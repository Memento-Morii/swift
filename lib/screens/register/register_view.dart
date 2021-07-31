import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/screens/register/add_services/add_services_view.dart';
import 'package:swift/screens/register/house_info.dart';
import 'package:swift/services/repositories.dart';
import 'package:swift/widgets/custom_button.dart';
import 'package:swift/widgets/custom_textfield.dart';

import 'register_bloc/register_bloc.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  RegisterBloc _registerBloc;
  bool isLogin;
  @override
  void initState() {
    _registerBloc = RegisterBloc();
    isLogin = true;
    super.initState();
  }

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
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
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddService(),
                                ),
                              );
                            },
                            child: Text(
                              isLogin ? 'Welcome' : 'Create',
                              style: CustomTextStyles.headlineText,
                            ),
                          ),
                          Text(
                            isLogin ? 'Back.' : 'Account.',
                            style: CustomTextStyles.headlineText,
                          ),
                          Text(
                            isLogin
                                ? 'we\'re glad to have you!'
                                : 'to get started!',
                            style: CustomTextStyles.headlineText2,
                          ),
                          SizedBox(height: isLogin ? 70 : 30),
                          isLogin
                              ? SizedBox()
                              : CustomField(
                                  hintText: "First Name",
                                  iconUrl: 'assets/user.png',
                                  controller: fnameController,
                                ),
                          isLogin
                              ? SizedBox()
                              : CustomField(
                                  hintText: "Last Name",
                                  iconUrl: 'assets/user.png',
                                  controller: lnameController,
                                ),
                          CustomField(
                            hintText: "Phone",
                            iconUrl: 'assets/phone.png',
                            controller: phoneController,
                          ),
                          CustomField(
                            hintText: "Password",
                            iconUrl: 'assets/lock.png',
                            controller: passwordController,
                          ),
                          SizedBox(height: 20),
                          isLogin
                              ? SizedBox()
                              : Container(
                                  margin: EdgeInsets.only(left: 90),
                                  child: CustomRadioButton(
                                    buttonTextStyle: ButtonTextStyle(
                                      selectedColor: Colors.white,
                                      unSelectedColor:
                                          CustomColors.primaryColor,
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
                                      print(value);
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
                          SizedBox(height: 20),
                          isLogin
                              ? SizedBox()
                              : Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Color(0xff3b5999),
                                        backgroundImage: AssetImage(
                                            'assets/facebook-logo.png'),
                                      ),
                                      SizedBox(width: 30),
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            AssetImage('assets/gmail.png'),
                                      ),
                                    ],
                                  ),
                                ),
                          SizedBox(height: isLogin ? 70 : 30),
                          CustomButton(
                            color: CustomColors.primaryColor,
                            onPressed: isLogin
                                ? () async {
                                    _registerBloc.add(Login(
                                      context: context,
                                      phone: phoneController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ));
                                    // var response = await _repo.signIn(
                                    //   email: emailController.text.trim(),
                                    //   password: passwordController.text.trim(),
                                    // );
                                    // if (response != null) {
                                    //   print(response);
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => Home(),
                                    //     ),
                                    //   );
                                    // }
                                    // else {
                                    //   print(response);
                                    // }
                                  }
                                : () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HouseInfo(
                                          firstName:
                                              fnameController.text.trim(),
                                          lastName: lnameController.text.trim(),
                                          phone: phoneController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                        ),
                                      ),
                                    );
                                  },
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                          ),
                          BlocBuilder(
                            bloc: _registerBloc,
                            builder: (context, state) {
                              if (state is RegisterFailed) {
                                return Text(state.getMessage);
                              } else {
                                return SizedBox();
                              }
                            },
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  isLogin
                                      ? 'Don\'t have an account?'
                                      : 'Already have an account?',
                                  style: CustomTextStyles.mediumText,
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isLogin = !isLogin;
                                    });
                                  },
                                  child: Text(
                                    isLogin ? 'Signup' : 'Login',
                                    style: CustomTextStyles.coloredBold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
