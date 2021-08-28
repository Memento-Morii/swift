class SignupRequest {
  SignupRequest({
    this.firstName,
    this.lastName,
    this.phone,
    this.houseNumber,
    this.siteNumber,
    this.blockNumber,
    this.email,
    this.isServiceProvider,
  });
  String firstName;
  String lastName;
  String phone;
  String houseNumber;
  String siteNumber;
  String blockNumber;
  String email;
  int isServiceProvider;
}
