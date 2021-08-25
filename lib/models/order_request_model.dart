class OrderRequest {
  OrderRequest({
    this.lat,
    this.lng,
    this.houseNumber,
    this.siteName,
    this.blockNumber,
    this.serviceId,
    this.serviceCategoryId,
  });
  double lat;
  double lng;
  String houseNumber;
  String siteName;
  String blockNumber;
  int serviceId;
  int serviceCategoryId;
}
