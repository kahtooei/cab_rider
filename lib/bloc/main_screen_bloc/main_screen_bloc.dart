import 'package:bloc/bloc.dart';
import 'package:cab_rider/bloc/main_screen_bloc/main_screen_status.dart';
import 'package:cab_rider/repository/main_screen_repository.dart';
import 'package:cab_rider/shared/resources/request_status.dart';
import 'package:meta/meta.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenRepository mainScreenRepository;
  MainScreenBloc(this.mainScreenRepository)
      : super(MainScreenState(
            currentPosition: LoadingMainScreenStatus(),
            predictionsList: CompletePredictionsStatus([]))) {
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
  }
}
