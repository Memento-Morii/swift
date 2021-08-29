part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileEvent {}

class EditUserProfile extends EditProfileEvent {
  EditUserProfile({this.editedUser, this.context, this.photo});
  final UserModel editedUser;
  final BuildContext context;
  final PlatformFile photo;
}
