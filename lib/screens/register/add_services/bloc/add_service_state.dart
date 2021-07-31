part of 'add_service_bloc.dart';

@immutable
abstract class AddServiceState {}

class AddServiceInitial extends AddServiceState {}

class AddServiceLoaded extends AddServiceState {
  AddServiceLoaded(this.service);
  final ServiceModel service;
}

class AddServiceFailed extends AddServiceState {}
