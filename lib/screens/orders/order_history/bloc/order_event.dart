part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class FetchOrderHistory extends OrderEvent {}
