part of 'main_screen_bloc.dart';

@immutable
class MainScreenState {
  final MainScreenStatus currentPosition;
  const MainScreenState({required this.currentPosition});

  MainScreenState copyWith({MainScreenStatus? current_position}) {
    return MainScreenState(
        currentPosition: current_position ?? currentPosition);
  }
}
