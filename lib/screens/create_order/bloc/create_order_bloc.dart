import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:swift/helper/utils.dart';
import 'package:swift/models/order_request_model.dart';
import 'package:swift/screens/success_page.dart';
import 'package:swift/services/repositories.dart';

part 'create_order_event.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  CreateOrderBloc() : super(CreateOrderInitial());
  Repositories _repo = Repositories();

  @override
  Stream<CreateOrderState> mapEventToState(
    CreateOrderEvent event,
  ) async* {
    if (event is OrderEvent) {
      try {
        var response = await _repo.createOrder(
          event.orderRequest,
          event.isAddress,
          event.token,
        );
        if (response.statusCode == 200) {
          // var decoded = jsonDecode(response.data);
          Navigator.push(
            event.context,
            MaterialPageRoute(
              builder: (context) => SuccessPage(),
            ),
          );
          // Utils.showToast(event.context, false, decoded['message'], 2);
        } else {
          var decoded = jsonDecode(response.data);
          Utils.showToast(event.context, true, decoded["message"], 2);
        }
      } catch (_) {
        print(_);
        Utils.showToast(event.context, true, "Something went wrong", 2);
      }
    }
  }
}
