part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent {}

class MakePayment extends PaymentEvent {
  MakePayment({
    this.orderId,
    this.payment,
    this.serviceProviderId,
    this.userId,
  });
  final int orderId;
  final int serviceProviderId;
  final int userId;
  final double payment;
}
