import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/screens/home/home_view.dart';
import 'package:swift/screens/otp/bloc/otp_bloc.dart';
import 'package:swift/screens/register/signup_view.dart';
// import 'package:swift/screens/register/register_bloc/register_bloc.dart';
import 'package:swift/widgets/custom_button.dart';
import 'package:swift/widgets/custom_textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  // RegisterBloc _registerBloc;
  OtpBloc _otpBloc;
  @override
  void initState() {
    // _registerBloc = RegisterBloc();
    _otpBloc = OtpBloc();
    super.initState();
  }

  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (context) => OtpBloc(),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Center(
                        child: Image.asset(
                          "assets/swift_logo.png",
                          height: 150,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context).motto,
                        style: CustomTextStyles.bigBoldColoredText,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 70),
                      CustomField(
                        hintText: AppLocalizations.of(context).phone,
                        iconUrl: 'assets/phone.png',
                        controller: phoneController,
                        textInputType: TextInputType.phone,
                      ),
                      SizedBox(height: 70),
                      CustomButton(
                        color: CustomColors.primaryColor,
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            _otpBloc.add(CheckOtp(
                              // context: context,
                              phone: phoneController.text,
                            ));
                          }
                        },
                        child: BlocListener<OtpBloc, OtpState>(
                          bloc: _otpBloc,
                          listener: (context, state) {
                            if (state is OtpLoaded) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ),
                              );
                            }
                            if (state is GoToRegister) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpView(state.phone),
                                ),
                              );
                            }
                          },
                          child: BlocBuilder<OtpBloc, OtpState>(
                            bloc: _otpBloc,
                            builder: (context, state) {
                              if (state is OtpLoading) {
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
                      SizedBox(height: 20),
                      BlocBuilder<OtpBloc, OtpState>(
                        bloc: _otpBloc,
                        builder: (context, state) {
                          if (state is OtpFailed) {
                            return Center(
                              child: Text(
                                AppLocalizations.of(context).failed,
                                style: CustomTextStyles.bigErrorText,
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
