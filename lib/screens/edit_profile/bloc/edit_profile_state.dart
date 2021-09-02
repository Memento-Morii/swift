part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileFailed extends EditProfileState {
  EditProfileFailed(this.message);
  final String message;
}

class EditProfileSuccess extends EditProfileState {}
