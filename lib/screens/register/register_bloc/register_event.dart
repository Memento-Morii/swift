part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class Login extends RegisterEvent {
  Login({this.phone, this.password, this.context});
  final String phone;
  final String password;
  BuildContext context;
}

class Signup extends RegisterEvent {
  Signup({
    this.firstName,
    this.lastName,
    this.email,
    this.houseNumber,
    this.siteName,
    this.blockNumber,
    this.password,
    this.phoneNumber,
    this.context,
  });
  final String firstName;
  final String lastName;
  final String email;
  final String siteName;
  final String houseNumber;
  final String blockNumber;
  final String phoneNumber;
  final String password;
  BuildContext context;
}
