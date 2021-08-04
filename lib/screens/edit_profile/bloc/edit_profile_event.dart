part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileEvent {}

class EditUserProfile extends EditProfileEvent {
  EditUserProfile({this.editedUser, this.context});
  final UserModel editedUser;
  final BuildContext context;
}
