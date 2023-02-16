part of 'main_screen_bloc.dart';

@immutable
class MainScreenState {
  final MainScreenStatus currentPosition;
  final PredictionsStatus predictionsList;
  final PlaceDetailsStatus selectedPlaceDetails;
  final DirectionsStatus routeDirection;
  final RiderRequestStatus riderRequest;
  const MainScreenState(
      {required this.currentPosition,
      required this.predictionsList,
      required this.selectedPlaceDetails,
      required this.routeDirection,
      required this.riderRequest});

  MainScreenState copyWith(
      {MainScreenStatus? current_position,
      PredictionsStatus? predictions_list,
      PlaceDetailsStatus? selected_place_details,
      DirectionsStatus? route_direction,
      RiderRequestStatus? rider_request}) {
    return MainScreenState(
        currentPosition: current_position ?? currentPosition,
        predictionsList: predictions_list ?? predictionsList,
        selectedPlaceDetails: selected_place_details ?? selectedPlaceDetails,
        routeDirection: route_direction ?? routeDirection,
        riderRequest: rider_request ?? riderRequest);
  }
}
