part of 'main_screen_bloc.dart';

@immutable
class MainScreenState {
  final MainScreenStatus currentPosition;
  final PredictionsStatus predictionsList;
  final PlaceDetailsStatus selectedPlaceDetails;
  const MainScreenState(
      {required this.currentPosition,
      required this.predictionsList,
      required this.selectedPlaceDetails});

  MainScreenState copyWith(
      {MainScreenStatus? current_position,
      PredictionsStatus? predictions_list,
      PlaceDetailsStatus? selected_place_details}) {
    return MainScreenState(
        currentPosition: current_position ?? currentPosition,
        predictionsList: predictions_list ?? predictionsList,
        selectedPlaceDetails: selected_place_details ?? selectedPlaceDetails);
  }
}
