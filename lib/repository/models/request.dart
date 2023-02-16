import 'package:google_maps_flutter/google_maps_flutter.dart';

class RequestModel {
  String? requestKey;
  String? riderId;
  String? createAt;
  String? riderName;
  String? riderPhone;
  String? riderEmail;
  LatLng? pickupLocation;
  LatLng? destinationLocation;
  String? paymentMethod;
  String? driverId;

  RequestModel(
      {this.requestKey,
      this.riderId,
      this.createAt,
      this.riderName,
      this.riderPhone,
      this.riderEmail,
      this.pickupLocation,
      this.destinationLocation,
      this.paymentMethod,
      this.driverId});

  RequestModel.fromMap(Map<String, dynamic> requestData) {
    requestKey = requestData['requestKey'];
    riderId = requestData['riderId'];
    createAt = requestData['createAt'];
    riderName = requestData['riderName'];
    riderPhone = requestData['riderPhone'];
    riderEmail = requestData['riderEmail'];
    pickupLocation = LatLng(requestData['pickupLocation']['latitude'],
        requestData['pickupLocation']['longitude']);
    destinationLocation = LatLng(requestData['destinationLocation']['latitude'],
        requestData['destinationLocation']['longitude']);
    paymentMethod = requestData['paymentMethod'];
    driverId = requestData['driverId'];
  }
}
