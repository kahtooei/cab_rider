import 'package:cab_rider/repository/models/address.dart';

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
