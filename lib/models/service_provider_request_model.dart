import 'package:file_picker/file_picker.dart';

class ServiceProviderRequest {
  ServiceProviderRequest({
    this.document,
    this.lat,
    this.lng,
    this.address,
    this.priceRangeFrom,
    this.priceRangeTo,
    this.serviceId,
    this.serviceCategoryId,
    this.timeRangeFrom,
    this.timeRangeTo,
    this.description,
  });
  PlatformFile document;
  double lat;
  double lng;
  String address;
  double priceRangeFrom;
  double priceRangeTo;
  String timeRangeFrom;
  String timeRangeTo;
  int serviceId;
  int serviceCategoryId;
  String description;
}
