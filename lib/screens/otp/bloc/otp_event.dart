part of 'otp_bloc.dart';

@immutable
abstract class OtpEvent {}

class CheckOtp extends OtpEvent {
  CheckOtp({this.verificationId, this.smsCode, this.response, this.context});
  final String verificationId;
  final String smsCode;
  final BuildContext context;
  var response;
}
