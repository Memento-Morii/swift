import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/screens/register/register_bloc/register_bloc.dart';
import 'package:swift/widgets/custom_button.dart';
import 'package:swift/widgets/custom_textfield.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  RegisterBloc _registerBloc;
  @override
  void initState() {
    _registerBloc = RegisterBloc();
    super.initState();
  }

  TextEditingController phoneController = TextEditingController();
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
                    return Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 20),
                          Text(
                            'Welcome',
                            style: CustomTextStyles.headlineText,
                          ),
                          Text(
                            'Back.',
                            style: CustomTextStyles.headlineText,
                          ),
                          Text(
                            'we\'re glad to have you!',
                            style: CustomTextStyles.headlineText2,
                          ),
                          SizedBox(height: 70),
                          CustomField(
                            hintText: "Phone",
                            iconUrl: 'assets/phone.png',
                            controller: phoneController,
                            textInputType: TextInputType.phone,
                          ),
                          SizedBox(height: 70),
                          CustomButton(
                            color: CustomColors.primaryColor,
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                _registerBloc.add(Login(
                                  context: context,
                                  phone: phoneController.text, //replaceFirst(RegExp(r'0'), '');
                                ));
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
                                } else {
                                  return Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white,
                                  );
                                }
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
                          // SizedBox(height: 20),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 10),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: <Widget>[
                          //       Text(
                          //         'Don\'t have an account?',
                          //         style: CustomTextStyles.mediumText,
                          //       ),
                          //       TextButton(
                          //         onPressed: () {
                          //           Navigator.pushReplacement(
                          //             context,
                          //             MaterialPageRoute(
                          //               builder: (context) => SignUpView(),
                          //             ),
                          //           );
                          //         },
                          //         child: Text(
                          //           'Signup',
                          //           style: CustomTextStyles.coloredBold,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    );
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
