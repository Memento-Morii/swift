import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swift/models/provider_order_model.dart';
import 'package:swift/services/repositories.dart';

part 'provider_order_event.dart';
part 'provider_order_state.dart';

class ProviderOrderBloc extends Bloc<ProviderOrderEvent, ProviderOrderState> {
  ProviderOrderBloc() : super(ProviderOrderInitial());
  Repositories _repo = Repositories();
  @override
  Stream<ProviderOrderState> mapEventToState(
    ProviderOrderEvent event,
  ) async* {
    if (event is FetchProviderOrders) {
      try {
        var orderResponse = await _repo.getServiceProviderOrder();
        if (orderResponse.statusCode == 200) {
          var decodedOrders = jsonDecode(orderResponse.data);
          if (decodedOrders['results'] == null) {
            yield ProviderOrderEmpty();
          } else {
            List<ProviderOrderModel> orders =
                providerOrderModelFromJson(jsonEncode(decodedOrders['results']));
            yield ProviderOrderLoaded(orders);
          }
        }
      } catch (_) {
        print(_);
        yield ProviderOrderFailed();
      }
    } else if (event is AcceptOrder) {
      try {
        yield ProviderOrderLoading();
        var acceptResponse = await _repo.acceptOrder(event.orderId);
        if (acceptResponse.statusCode == 200) {
          print(acceptResponse);
          yield Accepted();
        } else {
          print(acceptResponse);
          yield ProviderOrderFailed();
        }
      } catch (_) {
        print(_);
        yield ProviderOrderFailed();
      }
    } else if (event is RefuseOrder) {
      try {
        yield ProviderOrderLoading();
        var acceptResponse = await _repo.acceptOrder(event.orderId);
        if (acceptResponse.statusCode == 200) {
          print(acceptResponse);
          yield Refused();
        } else {
          print(acceptResponse);
          yield ProviderOrderFailed();
        }
      } catch (_) {
        print(_);
        yield ProviderOrderFailed();
      }
    }
  }
}
