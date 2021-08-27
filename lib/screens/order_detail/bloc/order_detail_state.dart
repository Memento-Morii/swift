part of 'order_detail_bloc.dart';

@immutable
abstract class OrderDetailState {}

class OrderDetailInitial extends OrderDetailState {}

class DetailFailed extends OrderDetailState {}

class DetailLoaded extends OrderDetailState {
  DetailLoaded(this.orderDetails);
  final OrderDetailsModel orderDetails;
}
