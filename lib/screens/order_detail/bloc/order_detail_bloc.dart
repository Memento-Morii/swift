import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_detail_event.dart';
part 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  OrderDetailBloc() : super(OrderDetailInitial());

  @override
  Stream<OrderDetailState> mapEventToState(
    OrderDetailEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
