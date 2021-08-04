part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class Login extends RegisterEvent {
  Login({this.phone, this.password, this.context});
  final String phone;
  final String password;
  final BuildContext context;
}

class Signup extends RegisterEvent {
  Signup({
    this.signupRequest,
    this.context,
    this.role,
  });
  final SignupRequest signupRequest;
  final String role;
  final BuildContext context;
}
