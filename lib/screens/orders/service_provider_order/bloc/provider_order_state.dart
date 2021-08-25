part of 'provider_order_bloc.dart';

@immutable
abstract class ProviderOrderState {}

class ProviderOrderInitial extends ProviderOrderState {}

class ProviderOrderLoading extends ProviderOrderState {}

class ProviderOrderLoaded extends ProviderOrderState {
  ProviderOrderLoaded(this.orders);
  final List<ProviderOrderModel> orders;
}

class Accepted extends ProviderOrderState {}

class Refused extends ProviderOrderState {}

class ProviderOrderEmpty extends ProviderOrderState {}

class ProviderOrderFailed extends ProviderOrderState {}
