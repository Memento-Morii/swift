part of 'order_bloc.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoaded extends OrderState {
  OrderLoaded({this.orderHistories, this.orders});
  final List<OrderHistoryModel> orderHistories;
  final List<ProviderOrderModel> orders;
}

class OrderFailed extends OrderState {}

class OrderEmpty extends OrderState {}
