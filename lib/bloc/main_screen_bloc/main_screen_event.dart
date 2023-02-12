part of 'main_screen_bloc.dart';

@immutable
abstract class MainScreenEvent {}

class GetAddressWithPositionEvent extends MainScreenEvent {
  final double latitude;
  final double longitude;
  GetAddressWithPositionEvent(
      {required this.latitude, required this.longitude});
}

class GetPositionWithAddressEvent extends MainScreenEvent {
  final String address;
  GetPositionWithAddressEvent({required this.address});
}

class GetCurrentAddressEvent extends MainScreenEvent {
  final double latitude;
  final double longitude;
  GetCurrentAddressEvent({required this.latitude, required this.longitude});
}
