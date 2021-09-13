import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/helper/utils.dart';
import 'package:swift/models/location_model.dart';
import 'package:swift/models/signup_request_model.dart';
import 'package:swift/screens/home/home_view.dart';
import 'package:swift/services/repositories.dart';
import 'package:swift/widgets/custom_button.dart';
import 'package:swift/widgets/custom_textfield.dart';
import 'add_services/add_services_view.dart';
import 'register_bloc/register_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  LocationModel selectedLocation;
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
      body: SafeArea(
        child: BlocProvider(
          create: (context) => RegisterBloc(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(context).houseInfo,
                      style: CustomTextStyles.headlineText,
                    ),
                    SizedBox(height: 50),
                    TypeAheadField<LocationModel>(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: siteController,
                        style: CustomTextStyles.textField,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                          // border: InputBorder.none,
                          hintText: AppLocalizations.of(context).siteName,
                          hintStyle: CustomTextStyles.textField,
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/home-broken.png',
                              height: 8,
                            ),
                          ),
                        ),
                      ),
                      suggestionsCallback: (pattern) async {
                        return await Repositories().searchLocation(pattern);
                      },
                      itemBuilder: (context, itemData) {
                        return ListTile(
                            title: Text(
                          itemData.name,
                          style: CustomTextStyles.boldMediumText,
                        ));
                      },
                      onSuggestionSelected: (suggestion) {
                        setState(() {
                          siteController.text = suggestion.name;
                          selectedLocation = suggestion;
                        });
                      },
                    ),
                    CustomField(
                      hintText: AppLocalizations.of(context).email,
                      iconUrl: 'assets/mail.png',
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      isEmail: true,
                    ),
                    CustomField(
                      hintText: AppLocalizations.of(context).houseNo,
                      iconUrl: 'assets/home-filled.png',
                      controller: houseController,
                    ),
                    CustomField(
                      hintText: AppLocalizations.of(context).blockNumber,
                      iconUrl: 'assets/home-broken.png',
                      controller: blockController,
                    ),
                    SizedBox(height: 40),
                    CustomButton(
                      color: CustomColors.primaryColor,
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          if (selectedLocation != null) {
                            widget.signupRequest.lat = selectedLocation.lat;
                            widget.signupRequest.lng = selectedLocation.lng;
                            widget.signupRequest.blockNumber = blockController.text.trim();
                            widget.signupRequest.houseNumber = houseController.text.trim();
                            widget.signupRequest.siteNumber = siteController.text;
                            widget.signupRequest.email = emailController.text.trim();
                            _registerBloc.add(
                              Signup(
                                signupRequest: widget.signupRequest,
                                context: context,
                                role: widget.role,
                              ),
                            );
                          } else {
                            Utils.showToast(
                              context,
                              true,
                              AppLocalizations.of(context).selectLocation,
                              2,
                            );
                          }
                        }
                      },
                      child: BlocListener<RegisterBloc, RegisterState>(
                        bloc: _registerBloc,
                        listener: (context, state) {
                          if (state is RegisterSuccess) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    state.role == "User" ? Home() : AddService(false),
                              ),
                              (Route<dynamic> route) => false,
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
                          },
                        ),
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
    );
  }
}
