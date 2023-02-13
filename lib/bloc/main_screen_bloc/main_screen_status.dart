import 'package:cab_rider/repository/models/address.dart';
import 'package:cab_rider/repository/models/prediction.dart';

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
