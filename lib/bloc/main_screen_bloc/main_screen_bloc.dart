import 'package:bloc/bloc.dart';
import 'package:cab_rider/bloc/main_screen_bloc/main_screen_status.dart';
import 'package:cab_rider/repository/main_screen_repository.dart';
import 'package:cab_rider/repository/models/address.dart';
import 'package:cab_rider/repository/models/request.dart';
import 'package:cab_rider/shared/params/ride_request_params.dart';
import 'package:cab_rider/shared/resources/request_status.dart';
import 'package:cab_rider/shared/resources/user_data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenRepository mainScreenRepository;
  MainScreenBloc(this.mainScreenRepository)
      : super(MainScreenState(
            currentPosition: LoadingMainScreenStatus(),
            predictionsList: CompletePredictionsStatus([]),
            selectedPlaceDetails: LoadingPlaceDetailsStatus(),
            routeDirection: EmptyDirectionsStatus(),
            riderRequest: EmptyRiderRequestStatus())) {
    //get current address
    on<GetCurrentAddressEvent>((event, emit) async {
      emit(state.copyWith(current_position: LoadingMainScreenStatus()));
      RequestStatus request = await mainScreenRepository.getAddressWithPosition(
          event.longitude, event.latitude);
      if (request is SuccessRequest) {
        emit(state.copyWith(
            current_position: CompleteMainScreenStatus(request.response)));
      } else {
        emit(state.copyWith(
            current_position: FailedMainScreenStatus(request.error!)));
      }
    });

    //get address with positions
    on<GetAddressWithPositionEvent>((event, emit) async {
      emit(state.copyWith(current_position: LoadingMainScreenStatus()));
      RequestStatus request = await mainScreenRepository.getAddressWithPosition(
          event.longitude, event.latitude);
      if (request is SuccessRequest) {
        //set address
      } else {
        //set error
      }
    });

    //get positions with address
    on<GetPositionWithAddressEvent>((event, emit) async {
      emit(state.copyWith(current_position: LoadingMainScreenStatus()));
      RequestStatus request =
          await mainScreenRepository.getPositionWithAddress(event.address);
    });

    //get predictions
    on<GetPredictionsListEvent>((event, emit) async {
      emit(state.copyWith(predictions_list: LoadingPredictionsStatus()));
      RequestStatus request =
          await mainScreenRepository.getPredictionPlaces(event.name);
      if (request is SuccessRequest) {
        emit(state.copyWith(
            predictions_list: CompletePredictionsStatus(request.response)));
      } else {
        emit(state.copyWith(
            predictions_list: FailedPredictionsStatus(request.error!)));
      }
    });

    //get place details by placeId
    on<GetSelectedPlaceDetailsEvent>((event, emit) async {
      emit(state.copyWith(selected_place_details: LoadingPlaceDetailsStatus()));
      RequestStatus request =
          await mainScreenRepository.getPlaceDetails(event.placeId);
      if (request is SuccessRequest) {
        emit(state.copyWith(
            selected_place_details:
                CompletePlaceDetailsStatus(request.response)));
      } else {
        emit(state.copyWith(
            selected_place_details: FailedPlaceDetailsStatus(request.error!)));
      }
    });

    //get directions for start and end positions
    on<GetRouteDirectionEvent>((event, emit) async {
      emit(state.copyWith(route_direction: LoadingDirectionsStatus()));
      RequestStatus request = await mainScreenRepository.getDirections(
          event.startPosition, event.endPosition);
      if (request is SuccessRequest) {
        emit(state.copyWith(
            route_direction: CompleteDirectionsStatus(request.response)));
      } else {
        emit(state.copyWith(
            route_direction: FailedDirectionsStatus(request.error!)));
      }
    });

    //reset app after click arrow back button
    on<ResetAppEvent>((event, emit) async {
      emit(state.copyWith(
          current_position: LoadingMainScreenStatus(),
          predictions_list: CompletePredictionsStatus([]),
          selected_place_details: LoadingPlaceDetailsStatus(),
          route_direction: EmptyDirectionsStatus(),
          rider_request: EmptyRiderRequestStatus()));
    });

    //send rider request
    on<SendRiderRequestEvent>((event, emit) async {
      emit(state.copyWith(rider_request: LoadingRiderRequestStatus()));
      AddressModel start =
          (state.currentPosition as CompleteMainScreenStatus).address;
      AddressModel end =
          (state.selectedPlaceDetails as CompletePlaceDetailsStatus)
              .placeDetails;
      UserData user = UserData();
      RideRequestParams rideRequestParams = RideRequestParams();
      rideRequestParams.driverId = user.id;
      rideRequestParams.createAt = DateTime.now().toString();
      rideRequestParams.riderName = user.fullName;
      rideRequestParams.riderEmail = user.email;
      rideRequestParams.riderPhone = user.phone;
      rideRequestParams.pickupLocation = {
        'latitude': start.latitude!,
        'longitude': start.longitude!
      };
      rideRequestParams.destinationLocation = {
        'latitude': end.latitude!,
        'longitude': end.longitude!
      };
      rideRequestParams.paymentMethod = 'card';
      rideRequestParams.driverId = 'waiting';
      RequestStatus requestStatus =
          await mainScreenRepository.newReqeustRider(rideRequestParams);
      if (requestStatus is SuccessRequest) {
        emit(state.copyWith(
            rider_request: CompleteRiderRequestStatus(requestStatus.response)));
      } else {
        emit(state.copyWith(
            rider_request: FailedRiderRequestStatus(requestStatus.error!)));
      }
    });

    //remove ride request
    on<RemoveRiderRequestEvent>((event, emit) async {
      try {
        String requestKey = (state.riderRequest as CompleteRiderRequestStatus)
            .request
            .requestKey!;
        mainScreenRepository.removeRequestRider(requestKey);
      } catch (e) {}

      emit(state.copyWith(
          current_position: LoadingMainScreenStatus(),
          predictions_list: CompletePredictionsStatus([]),
          selected_place_details: LoadingPlaceDetailsStatus(),
          route_direction: EmptyDirectionsStatus(),
          rider_request: EmptyRiderRequestStatus()));
    });
  }
}
