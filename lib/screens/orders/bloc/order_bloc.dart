import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/models/order_history_model.dart';
import 'package:swift/models/provider_order_model.dart';
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    if (event is FetchOrderHistory) {
      try {
        if (event.isServiceProvider == true) {
          var historyResponse = await _repo.getOrderHistory(token);
          var orderResponse = await _repo.getServiceProviderOrder(token);
          if (historyResponse.statusCode == 200 && orderResponse.statusCode == 200) {
            var decodedHistory = jsonDecode(historyResponse.data);
            var decodedOrders = jsonDecode(orderResponse.data);
            if (decodedHistory['results'] == null && decodedOrders['results'] == null) {
              yield OrderEmpty();
            } else {
              List<ProviderOrderModel> orders =
                  providerOrderModelFromJson(jsonEncode(decodedOrders['results']));
              List<OrderHistoryModel> orderHistories =
                  orderHistoryModelFromJson(jsonEncode(decodedHistory['results']));
              yield OrderLoaded(
                orderHistories: orderHistories,
                orders: orders,
              );
            }
          }
        }
      } catch (_) {
        print(_);
        yield OrderFailed();
      }
    }
  }
}
