import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/models/signup_request_model.dart';
import 'package:swift/screens/otp/otp_view.dart';
import 'package:swift/services/repositories.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial());
  Repositories _repo = Repositories();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is Signup) {
      yield RegisterLoading();
      try {
        var response = await _repo.signUp(
          signupRequest: event.signupRequest,
        );
        if (response.statusCode == 200) {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          var token = jsonDecode(response.data)['token'];
          sharedPreferences.setInt(
            "serviceProvider",
            event.role == "User" ? jsonDecode(response.data)['results']['is_service_provider'] : 1,
          );
          print(token);
          sharedPreferences.setString("token", token);
          yield RegisterSuccess(event.role);
        } else {
          var some = jsonDecode(response.data);
          print(some);
          yield RegisterInitial();
          yield RegisterFailed(message: some['message']);
        }
      } catch (e) {
        print(e);
        yield RegisterFailed(message: "Some error");
      }
    } else if (event is Login) {
      yield RegisterLoading();
      try {
        // var response = await _repo.signIn(
        //   phone: event.phone,
        // );
        // if (response.statusCode == 200) {
        await _auth.verifyPhoneNumber(
          phoneNumber: "+251${event.phone}",
          verificationCompleted: (phoneCred) async {},
          verificationFailed: (verificationFailed) async {
            print(verificationFailed.message);
          },
          codeSent: (verifcationId, resendingToken) {
            Navigator.push(
              event.context,
              MaterialPageRoute(
                builder: (context) => OTPView(
                  phone: event.phone,
                  verificationId: verifcationId,
                  // response: response.data,
                ),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verifcationId) {},
        );
        // } else {
        //   var some = jsonDecode(response.data);
        //   print(some);
        //   yield RegisterInitial();
        //   yield RegisterFailed(message: some['message']);
        // }
      } catch (e) {
        print(e);
        yield RegisterFailed(message: "Some error");
      }
    }
  }
}

// SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
// var token = jsonDecode(response.data)['token'];
// var serviceProvider = jsonDecode(response.data)['results']['is_service_provider'];
// sharedPreferences.setString("token", token);
// sharedPreferences.setInt("serviceProvider", serviceProvider);

// yield RegisterInitial();
