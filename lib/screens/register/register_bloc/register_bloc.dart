import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/models/signup_request_model.dart';
import 'package:swift/screens/home/home_view.dart';
import 'package:swift/screens/register/add_services/add_services_view.dart';
import 'package:swift/services/repositories.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial());
  Repositories _repo = Repositories();
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
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          var token = jsonDecode(response.data)['token'];
          // print(token);
          sharedPreferences.setString("token", token);
          // print("Id:" + sharedPreferences.get("token"));
          Navigator.push(
            event.context,
            MaterialPageRoute(
              builder: (context) => event.role == "User"
                  ? Home(response: "Homepage")
                  : AddService(),
            ),
          );
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
        var response = await _repo.signIn(
          password: event.password,
          phone: event.phone,
        );
        if (response.statusCode == 200) {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          // print("response.data");
          var token = jsonDecode(response.data)['token'];
          sharedPreferences.setString("token", token);
          // print("Id:" + sharedPreferences.get("token"));
          Navigator.push(
            event.context,
            MaterialPageRoute(
              builder: (context) => Home(response: "response.data.toString()"),
            ),
          );
          yield RegisterInitial();
        } else {
          var some = jsonDecode(response.data);
          yield RegisterInitial();
          yield RegisterFailed(message: some['message']);
        }
      } catch (e) {
        print(e);
        yield RegisterFailed(message: "Some error");
      }
    }
  }
}
