part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  ProfileLoaded(this.userModel);
  final UserModel userModel;
}

class ProfileFailed extends ProfileState {}
