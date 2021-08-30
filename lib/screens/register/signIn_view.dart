import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/screens/register/register_bloc/register_bloc.dart';
import 'package:swift/widgets/custom_button.dart';
import 'package:swift/widgets/custom_textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                            _registerBloc.add(Login(
                              context: context,
                              phone: phoneController.text,
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
      ),
    );
  }
}
