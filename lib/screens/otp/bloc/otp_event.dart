part of 'otp_bloc.dart';

@immutable
abstract class OtpEvent {}

// ignore: must_be_immutable
class CheckOtp extends OtpEvent {
  CheckOtp({this.verificationId, this.smsCode, this.phone});
  final String verificationId;
  final String smsCode;
  final String phone;
}
