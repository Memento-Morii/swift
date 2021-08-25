import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/screens/home/all_services_bloc/get_all_services_bloc.dart';
import 'package:swift/screens/home/home_view.dart';
import 'package:swift/screens/register/add_services/add_services_view.dart';
import 'package:swift/services/repositories.dart';
part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitial());
  Repositories _repo = Repositories();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Stream<OtpState> mapEventToState(
    OtpEvent event,
  ) async* {
    if (event is CheckOtp) {
      yield OtpLoading();

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.smsCode,
      );
      var authCredential = await _auth.signInWithCredential(credential);
      if (authCredential.user != null) {
        print(authCredential.user);
        var response = await _repo.signIn(
          phone: event.phone,
        );
        if (response.statusCode == 200) {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          var token = jsonDecode(response.data)['token'];
          var serviceProvider = jsonDecode(response.data)['results']['is_service_provider'];
          sharedPreferences.setString("token", token);
          sharedPreferences.setInt("serviceProvider", serviceProvider);
          // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          // var token = jsonDecode(response.data)['token'];
          // sharedPreferences.setInt("serviceProvider", 1);
          // print(token);
          // sharedPreferences.setString("token", token);
          yield OtpLoaded();
        } else {
          yield GoToRegister(event.phone);
        }
        // if (event.role == "Provider") {

        // } else {
        //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        //   var token = jsonDecode(event.response)['token'];
        //   var serviceProvider = jsonDecode(event.response)['results']['is_service_provider'];
        //   sharedPreferences.setString("token", token);
        //   sharedPreferences.setInt("serviceProvider", serviceProvider);
        // }

        // Navigator.pushAndRemoveUntil(
        //   event.context,
        //   MaterialPageRoute(
        //     builder: (context) => event.role == "Provider" ? AddService(false) : Home(),
        //   ),
        //   (Route<dynamic> route) => false,
        // );
      } else {
        yield OtpFailed();
      }
    }
  }
}
