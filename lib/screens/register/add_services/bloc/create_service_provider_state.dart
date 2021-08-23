part of 'create_service_provider_bloc.dart';

@immutable
abstract class CreateServiceProviderState {}

class CreateServiceProviderInitial extends CreateServiceProviderState {}

class CreateServiceProviderLoading extends CreateServiceProviderState {}

class CreateServiceProviderFailed extends CreateServiceProviderState {
  CreateServiceProviderFailed({this.message});
  final String message;
}

class CreateServiceProviderSuccess extends CreateServiceProviderState {}
