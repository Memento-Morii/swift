import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:swift/helper/utils.dart';
import 'package:swift/models/user_model.dart';
import 'package:swift/services/repositories.dart';

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
      try {
        var response = await _repo.updateUser(user: event.editedUser, photo: event.photo);
        if (response.statusCode == 200) {
          Utils.showToast(event.context, false, "Success", 2);
        } else {
          var decoded = jsonDecode(response.data);
          Utils.showToast(event.context, true, decoded["message"], 2);
        }
      } catch (_) {
        print(_);
        Utils.showToast(event.context, true, "Something went wrong", 2);
      }
    }
  }
}
