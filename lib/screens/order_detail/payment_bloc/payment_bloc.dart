import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swift/services/repositories.dart';
part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial());
  Repositories _repo = Repositories();
  @override
  Stream<PaymentState> mapEventToState(
    PaymentEvent event,
  ) async* {
    if (event is MakePayment) {
      try {
        var response = await _repo.submitPayment(
          orderId: event.orderId,
          payment: event.payment,
          serviceProviderId: event.serviceProviderId,
          userId: event.userId,
        );
        if (response.statusCode == 200) {
          yield PaymentSuccess();
        } else {
          yield PaymentFailed();
        }
      } catch (_) {
        print(_);
        yield PaymentFailed();
      }
    }
  }
}
