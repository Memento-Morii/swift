import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/widgets/custom_button.dart';
import 'package:swift/screens/register/signup_view.dart';
import 'package:swift/wrapper.dart';
import 'bloc/otp_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class OTPView extends StatefulWidget {
  OTPView({this.verificationId, this.phone, this.response, this.role});
  final String verificationId;
  final String phone;
  final String role;
  var response;

  @override
  _OTPViewState createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  String smsCode;
  OtpBloc _otpBloc;
  @override
  void initState() {
    _otpBloc = OtpBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: CustomColors.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => OtpBloc(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  AppLocalizations.of(context).verifyPhone,
                  style: CustomTextStyles.headlineText3,
                ),
              ),
              SizedBox(height: 40),
              Text(
                AppLocalizations.of(context).messageSent,
                style: CustomTextStyles.mediumText,
              ),
              Text(
                widget.phone,
                style: CustomTextStyles.coloredBold,
              ),
              SizedBox(height: 20),
              Center(
                child: OTPTextField(
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 50,
                  otpFieldStyle: OtpFieldStyle(
                    disabledBorderColor: CustomColors.secondaryColor,
                    enabledBorderColor: CustomColors.primaryColor,
                  ),
                  fieldStyle: FieldStyle.underline,
                  style: CustomTextStyles.boldTitleText,
                  onChanged: (pin) {
                    print(pin);
                  },
                  onCompleted: (pin) {
                    smsCode = pin;
                  },
                ),
              ),
              SizedBox(height: 50),
              CustomButton(
                onPressed: () async {
                  _otpBloc.add(
                    CheckOtp(
                      smsCode: smsCode,
                      verificationId: widget.verificationId,
                      phone: widget.phone,
                    ),
                  );
                },
                color: CustomColors.primaryColor,
                child: BlocListener<OtpBloc, OtpState>(
                  bloc: _otpBloc,
                  listener: (context, state) async {
                    if (state is OtpLoaded) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Wrapper(state.serivceProvider),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    }
                    if (state is GoToRegister) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpView(state.phone),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    }
                  },
                  child: BlocBuilder<OtpBloc, OtpState>(
                    bloc: _otpBloc,
                    builder: (context, state) {
                      if (state is OtpFailed) {
                        return Text(
                          AppLocalizations.of(context).failed,
                          style: CustomTextStyles.mediumWhiteText,
                        );
                      } else if (state is OtpLoading) {
                        return SizedBox(
                          height: 20,
                          width: 20,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        );
                      } else {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppLocalizations.of(context).go,
                              style: CustomTextStyles.mediumWhiteText,
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Text(
              //       'Didn\'t Recieve Code',
              //       style: CustomTextStyles.mediumText,
              //     ),
              //     SizedBox(width: 10),
              //     TextButton(
              //       onPressed: () async {},
              //       child: Text(
              //         'Resend',
              //         style: CustomTextStyles.coloredBold,
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(height: 20),
              BlocBuilder<OtpBloc, OtpState>(
                bloc: _otpBloc,
                builder: (context, state) {
                  if (state is OtpFailed) {
                    return Text(
                      state.message,
                      style: CustomTextStyles.bigErrorText,
                    );
                  } else
                    return SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
