import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/models/user_model.dart';
import 'package:swift/services/repositories.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial());

  Repositories _repo = Repositories();
  @override
  Stream<EditProfileState> mapEventToState(
    EditProfileEvent event,
  ) async* {
    if (event is EditUserProfile) {
      yield EditProfileLoading();
      try {
        var response = await _repo.updateUser(user: event.editedUser, photo: event.photo);
        if (response.statusCode == 200) {
          var decoded = jsonDecode(response.data);
          var userImage = decoded['results']['user_image'];
          SharedPreferences _prefs = await SharedPreferences.getInstance();
          _prefs.setString("firstName", decoded['results']['first_name']);
          _prefs.setString("lastName", decoded['results']['last_name']);
          if (userImage != null) {
            _prefs.setString("userImage", userImage);
          }
          yield EditProfileSuccess();
        } else {
          var decoded = jsonDecode(response.data);
          yield EditProfileFailed(decoded['message']);
        }
      } catch (_) {
        print(_);
        yield EditProfileFailed(AppLocalizations.of(event.context).failed);
      }
    }
  }
}
