part of 'create_order_bloc.dart';

@immutable
abstract class CreateOrderEvent {}

class OrderEvent extends CreateOrderEvent {
  OrderEvent({this.orderRequest, this.context, this.isAddress, this.token});
  final OrderRequest orderRequest;
  final bool isAddress;
  final String token;
  final BuildContext context;
}
