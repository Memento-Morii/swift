import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
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
          yield EditProfileSuccess();
        } else {
          var decoded = jsonDecode(response.data);
          yield EditProfileFailed(decoded['message']);
        }
      } catch (_) {
        yield EditProfileFailed(AppLocalizations.of(event.context).failed);
      }
    }
  }
}
