import 'package:cab_rider/repository/models/address.dart';
import 'package:cab_rider/repository/models/direction.dart';
import 'package:cab_rider/repository/models/prediction.dart';
import 'package:cab_rider/repository/models/request.dart';

class MainScreenStatus {}

//current position status
class LoadingMainScreenStatus extends MainScreenStatus {}

class FailedMainScreenStatus extends MainScreenStatus {
  final String error;
  FailedMainScreenStatus(this.error);
}

class CompleteMainScreenStatus extends MainScreenStatus {
  final AddressModel address;
  CompleteMainScreenStatus(this.address);
}

//prediction list for destination
class PredictionsStatus {}

class LoadingPredictionsStatus extends PredictionsStatus {}

class FailedPredictionsStatus extends PredictionsStatus {
  final String error;
  FailedPredictionsStatus(this.error);
}

class CompletePredictionsStatus extends PredictionsStatus {
  final List<PredictionModel> predictionsList;
  CompletePredictionsStatus(this.predictionsList);
}

//get place details for selected place from prediction
class PlaceDetailsStatus {}

class LoadingPlaceDetailsStatus extends PlaceDetailsStatus {}

class FailedPlaceDetailsStatus extends PlaceDetailsStatus {
  final String error;
  FailedPlaceDetailsStatus(this.error);
}

class CompletePlaceDetailsStatus extends PlaceDetailsStatus {
  final AddressModel placeDetails;
  CompletePlaceDetailsStatus(this.placeDetails);
}

//get directions for selected start and end positions
class DirectionsStatus {}

class EmptyDirectionsStatus extends DirectionsStatus {}

class LoadingDirectionsStatus extends DirectionsStatus {}

class FailedDirectionsStatus extends DirectionsStatus {
  final String error;
  FailedDirectionsStatus(this.error);
}

class CompleteDirectionsStatus extends DirectionsStatus {
  final DirectionModel direction;
  CompleteDirectionsStatus(this.direction);
}

//add new rider request
class RiderRequestStatus {}

class EmptyRiderRequestStatus extends RiderRequestStatus {}

class LoadingRiderRequestStatus extends RiderRequestStatus {}

class FailedRiderRequestStatus extends RiderRequestStatus {
  final String error;
  FailedRiderRequestStatus(this.error);
}

class CompleteRiderRequestStatus extends RiderRequestStatus {
  final RequestModel request;
  CompleteRiderRequestStatus(this.request);
}
