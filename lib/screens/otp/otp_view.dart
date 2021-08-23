import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/widgets/custom_button.dart';

import 'bloc/otp_bloc.dart';

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
                  'Verify your phone',
                  style: CustomTextStyles.headlineText3,
                ),
              ),
              SizedBox(height: 40),
              Text(
                'A text message has been sent to',
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
                      context: context,
                      response: widget.response,
                      smsCode: smsCode,
                      verificationId: widget.verificationId,
                      role: widget.role,
                    ),
                  );
                },
                color: CustomColors.primaryColor,
                child: BlocBuilder<OtpBloc, OtpState>(
                  bloc: _otpBloc,
                  builder: (context, state) {
                    if (state is OtpInitial) {
                      return Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
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
                      return Text(
                        'Failed',
                        style: CustomTextStyles.normalWhiteText,
                      );
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Didn\'t Recieve Code',
                    style: CustomTextStyles.mediumText,
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    onPressed: () async {},
                    child: Text(
                      'Resend',
                      style: CustomTextStyles.coloredBold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
