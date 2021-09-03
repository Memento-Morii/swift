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
          var decoded = jsonDecode(response.data);
          var token = decoded['token'];
          sharedPreferences.setInt(
            "serviceProvider",
            event.role == "User" ? decoded['results']['is_service_provider'] : 2,
          );
          var firstName = decoded['results']['first_name'];
          var lastName = decoded['results']['last_name'];
          // var email = decoded['results']['email'];
          var phone = decoded['results']['phone_number'];
          // var userImage = decoded['results']['user_image'];
          sharedPreferences.setString("token", token);
          sharedPreferences.setString("firstName", firstName);
          sharedPreferences.setString("lastName", lastName);
          // sharedPreferences.setString("email", email);
          sharedPreferences.setString("phone", phone);
          sharedPreferences.setString("token", token);
          // sharedPreferences.setString("userImage", userImage);
          yield RegisterSuccess(event.role);
        } else {
          var some = jsonDecode(response.data);
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
                ),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verifcationId) {},
        );
      } catch (e) {
        print(e);
        yield RegisterFailed(message: "Some error");
      }
    }
  }
}
