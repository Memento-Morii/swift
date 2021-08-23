part of 'otp_bloc.dart';

@immutable
abstract class OtpEvent {}

// ignore: must_be_immutable
class CheckOtp extends OtpEvent {
  CheckOtp({this.verificationId, this.smsCode, this.response, this.context, this.role});
  final String verificationId;
  final String smsCode;
  final String role;
  final BuildContext context;
  var response;
}
