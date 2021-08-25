part of 'provider_order_bloc.dart';

@immutable
abstract class ProviderOrderEvent {}

class FetchProviderOrders extends ProviderOrderEvent {}

class AcceptOrder extends ProviderOrderEvent {
  AcceptOrder(this.orderId);
  final String orderId;
}

class RefuseOrder extends ProviderOrderEvent {
  RefuseOrder(this.orderId);
  final String orderId;
}
