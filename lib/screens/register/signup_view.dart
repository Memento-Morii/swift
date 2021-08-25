import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/helper/utils.dart';
import 'package:swift/models/signup_request_model.dart';
import 'package:swift/screens/otp/otp_view.dart';
import 'package:swift/screens/register/register_bloc/register_bloc.dart';
import 'package:swift/screens/register/signIn_view.dart';
import 'package:swift/widgets/custom_button.dart';
import 'package:swift/widgets/custom_textfield.dart';

import 'house_info.dart';

class SignUpView extends StatefulWidget {
  SignUpView(this.phone);
  final String phone;
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  RegisterBloc _registerBloc;
  void initState() {
    _registerBloc = RegisterBloc();
    super.initState();
  }

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();
  String role;
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (context) => RegisterBloc(),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: BlocBuilder<RegisterBloc, RegisterState>(
                  bloc: _registerBloc,
                  builder: (context, state) {
                    if (state is RegisterLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OTPView(),
                                  ),
                                );
                              },
                              child: Text(
                                'Create',
                                style: CustomTextStyles.headlineText,
                              ),
                            ),
                            Text(
                              'Account.',
                              style: CustomTextStyles.headlineText,
                            ),
                            Text(
                              'to get started!',
                              style: CustomTextStyles.headlineText2,
                            ),
                            SizedBox(height: 30),
                            CustomField(
                              hintText: "First Name",
                              iconUrl: 'assets/user.png',
                              controller: fnameController,
                            ),
                            CustomField(
                              hintText: "Last Name",
                              iconUrl: 'assets/user.png',
                              controller: lnameController,
                            ),
                            SizedBox(height: 20),
                            Container(
                              margin: EdgeInsets.only(left: 90),
                              child: CustomRadioButton(
                                buttonTextStyle: ButtonTextStyle(
                                  selectedColor: Colors.white,
                                  unSelectedColor: CustomColors.primaryColor,
                                  textStyle: CustomTextStyles.textField,
                                ),
                                unSelectedColor: Colors.white,
                                buttonLables: [
                                  "User",
                                  "Provider",
                                ],
                                buttonValues: [
                                  "User",
                                  "Provider",
                                ],
                                spacing: 0,
                                radioButtonValue: (value) {
                                  role = value;
                                  print(role);
                                },
                                horizontal: false,
                                enableButtonWrap: false,
                                width: 100,
                                absoluteZeroSpacing: false,
                                selectedColor: CustomColors.primaryColor,
                                padding: 10,

                                // enableShape: true,
                              ),
                            ),
                            // SizedBox(height: 20),
                            // Center(
                            //   child: Row(
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: <Widget>[
                            //       CircleAvatar(
                            //         radius: 25,
                            //         backgroundColor: Color(0xff3b5999),
                            //         backgroundImage: AssetImage('assets/facebook-logo.png'),
                            //       ),
                            //       SizedBox(width: 30),
                            //       CircleAvatar(
                            //         radius: 25,
                            //         backgroundColor: Colors.transparent,
                            //         backgroundImage: AssetImage('assets/gmail.png'),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(height: 30),
                            CustomButton(
                              color: CustomColors.primaryColor,
                              onPressed: () async {
                                if (_formkey.currentState.validate()) {
                                  if (role != null) {
                                    SignupRequest _signupRequest = SignupRequest(
                                      firstName: fnameController.text.trim(),
                                      lastName: lnameController.text.trim(),
                                      phone: widget.phone,
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HouseInfo(
                                          signupRequest: _signupRequest,
                                          role: role,
                                        ),
                                      ),
                                    );
                                  } else {
                                    Utils.showToast(context, true, "Choose your Role", 2);
                                  }
                                }
                              },
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 20),
                            BlocBuilder(
                              bloc: _registerBloc,
                              builder: (context, state) {
                                if (state is RegisterFailed) {
                                  return Center(
                                    child: Text(
                                      state.getMessage,
                                      style: CustomTextStyles.errorText,
                                    ),
                                  );
                                } else {
                                  return SizedBox();
                                }
                              },
                            ),
                            // SizedBox(height: 20),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 10),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: <Widget>[
                            //       Text(
                            //         'Already have an account?',
                            //         style: CustomTextStyles.mediumText,
                            //       ),
                            //       TextButton(
                            //         onPressed: () {
                            //           Navigator.pushReplacement(
                            //             context,
                            //             MaterialPageRoute(
                            //               builder: (context) => SignInView(),
                            //             ),
                            //           );
                            //         },
                            //         child: Text(
                            //           'Login',
                            //           style: CustomTextStyles.coloredBold,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
