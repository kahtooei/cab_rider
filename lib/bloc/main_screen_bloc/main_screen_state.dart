part of 'main_screen_bloc.dart';

@immutable
class MainScreenState {
  final MainScreenStatus currentPosition;
  final PredictionsStatus predictionsList;
  const MainScreenState(
      {required this.currentPosition, required this.predictionsList});

  MainScreenState copyWith(
      {MainScreenStatus? current_position,
      PredictionsStatus? predictions_list}) {
    return MainScreenState(
        currentPosition: current_position ?? currentPosition,
        predictionsList: predictions_list ?? predictionsList);
  }
}
