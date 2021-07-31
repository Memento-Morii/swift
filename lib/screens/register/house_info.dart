import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/widgets/custom_button.dart';
import 'package:swift/widgets/custom_textfield.dart';

import 'register_bloc/register_bloc.dart';

class HouseInfo extends StatefulWidget {
  HouseInfo({this.firstName, this.lastName, this.password, this.phone});
  final String firstName;
  final String lastName;
  final String phone;
  final String password;

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
              child: BlocBuilder<RegisterBloc, RegisterState>(
                bloc: _registerBloc,
                builder: (context, state) {
                  if (state is RegisterLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // else if (state is RegisterLoaded) {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => Home(),
                  //     ),
                  //   );
                  // }
                  else {
                    return Column(
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
                        ),
                        CustomField(
                          hintText: "House Number",
                          iconUrl: 'assets/home-filled.png',
                          controller: houseController,
                        ),
                        CustomField(
                          hintText: "Site Number",
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
                            _registerBloc.add(Signup(
                              firstName: widget.firstName,
                              lastName: widget.lastName,
                              email: emailController.text.trim(),
                              blockNumber: blockController.text.trim(),
                              houseNumber: houseController.text.trim(),
                              password: widget.password,
                              phoneNumber: widget.phone,
                              siteName: siteController.text.trim(),
                              context: context,
                            ));
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
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
