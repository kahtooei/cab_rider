import 'dart:convert';

import 'package:cab_rider/data/remote/geocoding.dart';
import 'package:cab_rider/repository/models/address.dart';
import 'package:cab_rider/shared/resources/request_status.dart';

class MainScreenRepository {
  GoogleGeoCoding geoCoding;
  MainScreenRepository(this.geoCoding);
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
}
