import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/signup_request_model.dart';
import 'package:swift/widgets/custom_button.dart';
import 'package:swift/widgets/custom_textfield.dart';
import 'register_bloc/register_bloc.dart';

class HouseInfo extends StatefulWidget {
  HouseInfo({this.signupRequest, this.role});
  final String role;
  final SignupRequest signupRequest;

  @override
  _HouseInfoState createState() => _HouseInfoState();
}

class _HouseInfoState extends State<HouseInfo> {
  RegisterBloc _registerBloc;
  @override
  void initState() {
    _registerBloc = RegisterBloc();
    super.initState();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController siteController = TextEditingController();
  TextEditingController blockController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: BlocProvider(
            create: (context) => RegisterBloc(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      'House Information',
                      style: CustomTextStyles.headlineText,
                    ),
                    SizedBox(height: 50),
                    CustomField(
                      hintText: "Email",
                      iconUrl: 'assets/mail.png',
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                    ),
                    CustomField(
                      hintText: "House Number",
                      iconUrl: 'assets/home-filled.png',
                      controller: houseController,
                    ),
                    CustomField(
                      hintText: "Site Name",
                      iconUrl: 'assets/home-broken.png',
                      controller: siteController,
                    ),
                    CustomField(
                      hintText: "Block Number",
                      iconUrl: 'assets/home-broken.png',
                      controller: blockController,
                    ),
                    SizedBox(height: 40),
                    CustomButton(
                      color: CustomColors.primaryColor,
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          widget.signupRequest.blockNumber = blockController.text.trim();
                          widget.signupRequest.houseNumber = houseController.text.trim();
                          widget.signupRequest.siteNumber = siteController.text.trim();
                          widget.signupRequest.email = emailController.text.trim();
                          inspect(widget.signupRequest);
                          print(widget.role);
                          _registerBloc.add(
                            Signup(
                              signupRequest: widget.signupRequest,
                              context: context,
                              role: widget.role,
                            ),
                          );
                        }
                      },
                      child: BlocBuilder<RegisterBloc, RegisterState>(
                        bloc: _registerBloc,
                        builder: (context, state) {
                          if (state is RegisterLoading) {
                            return SizedBox(
                              height: 20,
                              width: 20,
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              ),
                            );
                          }
                          return Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                          );
                        },
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
