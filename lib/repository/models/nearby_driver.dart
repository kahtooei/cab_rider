import 'package:equatable/equatable.dart';

class NearbyDriver extends Equatable {
  String? key;
  double? latitude;
  double? longitude;
  NearbyDriver({this.key, this.latitude, this.longitude});

  @override
  // TODO: implement props
  List<Object?> get props => [key, latitude, longitude];
}
