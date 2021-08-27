part of 'create_service_provider_bloc.dart';

@immutable
abstract class CreateServiceProviderEvent {}

class CreateServiceProvider extends CreateServiceProviderEvent {
  CreateServiceProvider({this.request});
  final ServiceProviderRequest request;
}
