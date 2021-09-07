import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swift/models/order_history_model.dart';
import 'package:swift/services/repositories.dart';
part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial());
  Repositories _repo = Repositories();
  @override
  Stream<OrderState> mapEventToState(
    OrderEvent event,
  ) async* {
    if (event is FetchOrderHistory) {
      try {
        var historyResponse = await _repo.getOrderHistory();
        if (historyResponse.statusCode == 200) {
          var decodedHistory = jsonDecode(historyResponse.data);
          if (decodedHistory['results'] == null) {
            yield OrderEmpty();
          } else {
            List<OrderHistoryModel> orderHistories =
                orderHistoryModelFromJson(jsonEncode(decodedHistory['results']));
            yield OrderLoaded(
              orderHistories: orderHistories,
            );
          }
        }
      } catch (_) {
        print(_);
        yield OrderFailed();
      }
    }
  }
}
