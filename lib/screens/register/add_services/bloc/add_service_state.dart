part of 'add_service_bloc.dart';

@immutable
abstract class AddServiceState {}

class AddServiceInitial extends AddServiceState {}

class AddServiceLoaded extends AddServiceState {
  AddServiceLoaded({this.service, this.locations});
  final List<ServiceModel> service;
  final List<LocationModel> locations;
}

class AddServiceFailed extends AddServiceState {}
