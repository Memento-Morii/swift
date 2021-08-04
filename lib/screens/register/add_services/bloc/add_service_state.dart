part of 'add_service_bloc.dart';

@immutable
abstract class AddServiceState {}

class AddServiceInitial extends AddServiceState {}

class AddServiceLoaded extends AddServiceState {
  AddServiceLoaded(this.service);
  final List<ServiceModel> service;
}

class AddServiceFailed extends AddServiceState {}
