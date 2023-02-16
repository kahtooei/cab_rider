import 'package:cab_rider/shared/params/ride_request_params.dart';
import 'package:firebase_database/firebase_database.dart';

class RideRequestFirebase {
  Future<Map<String, dynamic>> addNewRideRequest(
      RideRequestParams rideRequestParams) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("rideRequest").push();
    Map<String, dynamic> request = {
      'riderId': rideRequestParams.riderId,
      'createAt': rideRequestParams.createAt,
      'riderName': rideRequestParams.riderName,
      'riderPhone': rideRequestParams.riderPhone,
      'riderEmail': rideRequestParams.riderEmail,
      'pickupLocation': rideRequestParams.pickupLocation,
      'destinationLocation': rideRequestParams.destinationLocation,
      'paymentMethod': rideRequestParams.paymentMethod,
      'driverId': rideRequestParams.driverId
    };
    await ref.set(request);
    request['requestKey'] = ref.key!;
    return request;
  }

  Future<void> removeRideRequest(String requestKey) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("rideRequest/$requestKey");
    await ref.remove();
  }
}
