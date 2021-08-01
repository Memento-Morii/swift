import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/models/user_model.dart';
import 'package:swift/services/repositories.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());
  Repositories _repo = Repositories();
  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is FetchProfile) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var token = prefs.get("token");
        Response response = await _repo.getUser(token);
        if (response.statusCode == 200) {
          var decoded = jsonDecode(response.data);
          UserModel userModel = UserModel.fromJson(decoded['results']);
          yield ProfileLoaded(userModel);
        } else {
          print(response);
          yield ProfileFailed();
        }
      } catch (_) {
        print(_);
        yield ProfileFailed();
      }
    }
  }
}
