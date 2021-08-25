part of 'order_bloc.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoaded extends OrderState {
  OrderLoaded({this.orderHistories});
  final List<OrderHistoryModel> orderHistories;
}

class OrderFailed extends OrderState {}

class OrderEmpty extends OrderState {}
