part of 'otp_bloc.dart';

@immutable
abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpLoaded extends OtpState {
  OtpLoaded(this.isFinished);
  final bool isFinished;
}

class GoToRegister extends OtpState {
  GoToRegister(this.phone);
  final String phone;
}

class OtpFailed extends OtpState {
  OtpFailed(this.message);
  final String message;
}
