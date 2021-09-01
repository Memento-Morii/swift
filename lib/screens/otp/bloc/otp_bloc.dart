import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/services/repositories.dart';
part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitial());
  Repositories _repo = Repositories();
  // FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Stream<OtpState> mapEventToState(
    OtpEvent event,
  ) async* {
    if (event is CheckOtp) {
      yield OtpLoading();
      try {
        // PhoneAuthCredential credential = PhoneAuthProvider.credential(
        //   verificationId: event.verificationId,
        //   smsCode: event.smsCode,
        // );
        // // var authCredential = await _auth.signInWithCredential(credential);
        // if (authCredential.user != null) {
        //   print(authCredential.user);
        var response = await _repo.signIn(
          phone: event.phone,
        );
        print(response);
        if (response.statusCode == 200) {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          var token = jsonDecode(response.data)['token'];
          var serviceProvider = jsonDecode(response.data)['results']['is_service_provider'];
          sharedPreferences.setString("token", token);
          sharedPreferences.setInt("serviceProvider", serviceProvider);
          yield OtpLoaded(serviceProvider == 2 ? false : true);
        } else {
          print(response);
          yield GoToRegister(event.phone);
        }
        // } else {
        //   yield OtpFailed("User Not Found");
        // }
      } catch (_) {
        print(_);
        yield OtpFailed("Something Went Wrong");
        yield OtpInitial();
      }
    }
  }
}
