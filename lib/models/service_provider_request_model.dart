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
  String document;
  double lat;
  double lng;
  String address;
  double priceRangeFrom;
  double priceRangeTo;
  DateTime timeRangeFrom;
  DateTime timeRangeTo;
  int serviceId;
  int serviceCategoryId;
  String description;
}
