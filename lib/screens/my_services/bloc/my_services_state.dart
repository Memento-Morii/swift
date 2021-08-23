part of 'my_services_bloc.dart';

@immutable
abstract class MyServicesState {}

class MyServicesInitial extends MyServicesState {}

class MyServicesLoaded extends MyServicesState {
  MyServicesLoaded(this.myServices);
  final List<MyServicesModel> myServices;
}

class MyServicesFailed extends MyServicesState {}
