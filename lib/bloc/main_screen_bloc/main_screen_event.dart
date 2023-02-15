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

class GetPredictionsListEvent extends MainScreenEvent {
  final String name;
  GetPredictionsListEvent({required this.name});
}

class GetSelectedPlaceDetailsEvent extends MainScreenEvent {
  final String placeId;
  GetSelectedPlaceDetailsEvent({required this.placeId});
}

class GetRouteDirectionEvent extends MainScreenEvent {
  final LatLng startPosition;
  final LatLng endPosition;
  GetRouteDirectionEvent(
      {required this.startPosition, required this.endPosition});
}

class ResetAppEvent extends MainScreenEvent {
  ResetAppEvent();
}
