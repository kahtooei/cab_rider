import 'dart:convert';

import 'package:cab_rider/data/remote/geocoding.dart';
import 'package:cab_rider/data/remote/places_api.dart';
import 'package:cab_rider/repository/models/address.dart';
import 'package:cab_rider/repository/models/prediction.dart';
import 'package:cab_rider/shared/resources/request_status.dart';

class MainScreenRepository {
  GoogleGeoCoding geoCoding;
  GooglePlaceAPI placeAPI;
  MainScreenRepository(this.geoCoding, this.placeAPI);
  Future<RequestStatus<AddressModel>> getAddressWithPosition(
      double longitude, double latitude) async {
    try {
      var res = await geoCoding.getAddressWithPosition(latitude, longitude);
      if (res == '') {
        return FailedRequest<AddressModel>('request error');
      } else {
        Map data = jsonDecode(res);
        AddressModel address = AddressModel();
        address.latitude = latitude;
        address.longitude = longitude;
        address.placeFormattedAddress = data['results'][0]['formatted_address'];
        address.placeId = data['results'][0]['place_id'];
        return SuccessRequest<AddressModel>(address);
      }
    } catch (e) {
      return FailedRequest<AddressModel>(e.toString());
    }
  }

  Future<RequestStatus<AddressModel>> getPositionWithAddress(
      String address) async {
    try {
      var res = await geoCoding.getPositionWithAddress(address);
      if (res == '') {
        return FailedRequest<AddressModel>('request error');
      } else {
        Map data = jsonDecode(res);
        AddressModel address = AddressModel();
        address.latitude = data['results'][0]['geometry']['location']['lat'];
        address.longitude = data['results'][0]['geometry']['location']['lng'];
        address.placeFormattedAddress = data['results'][0]['formatted_address'];
        address.placeId = data['results'][0]['place_id'];
        return SuccessRequest<AddressModel>(address);
      }
    } catch (e) {
      return FailedRequest<AddressModel>(e.toString());
    }
  }

  Future<RequestStatus<List<PredictionModel>>> getPredictionPlaces(
      String name) async {
    try {
      var res = await placeAPI.getPrediction(name);
      if (res == '') {
        return FailedRequest<List<PredictionModel>>('request error');
      } else {
        Map data = jsonDecode(res);
        List<PredictionModel> predictionList = [];
        for (Map<String, dynamic> item in data['predictions']) {
          predictionList.add(PredictionModel.fromJson(item));
        }
        return SuccessRequest<List<PredictionModel>>(predictionList);
      }
    } catch (e) {
      return FailedRequest<List<PredictionModel>>(e.toString());
    }
  }

  Future<RequestStatus<AddressModel>> getPlaceDetails(String placeId) async {
    try {
      var res = await placeAPI.getPlaceDetails(placeId);
      if (res == '') {
        return FailedRequest<AddressModel>('request error');
      } else {
        Map data = jsonDecode(res);
        AddressModel placeDetails = AddressModel();
        placeDetails.placeId = placeId;
        placeDetails.placeFormattedAddress =
            data['result']['formatted_address'];
        placeDetails.placeName = data['result']['name'];
        placeDetails.latitude = data['result']['geometry']['location']['lat'];
        placeDetails.longitude = data['result']['geometry']['location']['lng'];
        return SuccessRequest<AddressModel>(placeDetails);
      }
    } catch (e) {
      return FailedRequest<AddressModel>(e.toString());
    }
  }
}
