part of 'create_service_provider_bloc.dart';

@immutable
abstract class CreateServiceProviderEvent {}

class CreateServiceProvider extends CreateServiceProviderEvent {
  CreateServiceProvider({this.request, this.token, this.context});
  final ServiceProviderRequest request;
  final String token;
  final BuildContext context;
}
