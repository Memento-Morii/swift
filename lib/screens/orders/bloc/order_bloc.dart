import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/models/order_model.dart';
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
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var token = prefs.get("token");
        var response = await _repo.getOrderHistory(token);
        if (response.statusCode == 200) {
          var decoded = jsonDecode(response.data);
          if (decoded['results'] == null) {
            yield OrderEmpty();
          } else {
            List<OrderModel> orderHistories = orderModelFromJson(jsonEncode(decoded['results']));
            yield OrderLoaded(orderHistories);
          }
        }
      } catch (_) {
        print(_);
        yield OrderFailed();
      }
    }
  }
}
