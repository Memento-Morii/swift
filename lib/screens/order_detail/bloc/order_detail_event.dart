part of 'order_detail_bloc.dart';

@immutable
abstract class OrderDetailEvent {}

class FetchDetails extends OrderDetailEvent {
  FetchDetails(this.orderId);
  final String orderId;
}
