part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterFailed extends RegisterState {
  RegisterFailed({this.message});
  final String message;
  String get getMessage => message;
}
