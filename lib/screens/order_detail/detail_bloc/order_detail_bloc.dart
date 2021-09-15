import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swift/models/order_details_model.dart';
import 'package:swift/services/repositories.dart';

part 'order_detail_event.dart';
part 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  OrderDetailBloc() : super(OrderDetailInitial());
  Repositories _repo = Repositories();
  @override
  Stream<OrderDetailState> mapEventToState(
    OrderDetailEvent event,
  ) async* {
    if (event is FetchDetails) {
      try {
        var response = await _repo.getOrderDetails(event.orderId);
        if (response.statusCode == 200) {
          var decoded = jsonDecode(response.data);
          OrderDetailsModel orderDetails =
              orderDetailsModelFromJson(jsonEncode(decoded['results']));
          yield DetailLoaded(orderDetails);
        } else {
          yield DetailFailed();
        }
      } catch (_) {
        print(_);
        yield DetailFailed();
      }
    }
  }
}
