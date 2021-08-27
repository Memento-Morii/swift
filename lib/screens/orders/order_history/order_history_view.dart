import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/order_history_model.dart';
import 'package:swift/widgets/order_history_widget.dart';

import 'bloc/order_bloc.dart';

class OrderHistoryView extends StatefulWidget {
  @override
  _OrderHistoryViewState createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  OrderBloc _orderBloc;
  @override
  void initState() {
    _orderBloc = OrderBloc();
    _orderBloc.add(FetchOrderHistory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc(),
      child: BlocBuilder<OrderBloc, OrderState>(
        bloc: _orderBloc,
        builder: (context, state) {
          if (state is OrderInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is OrderEmpty) {
            return Center(
                child: Text(
              'Your Order is Empty',
              style: CustomTextStyles.errorText,
            ));
          } else if (state is OrderLoaded) {
            List<OrderHistoryModel> orders = state.orderHistories.reversed.toList();
            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                OrderHistoryModel order = orders[index];
                return OrderHistoryWidget(order: order);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 20);
              },
              itemCount: orders.length,
            );
          } else {
            return Text('Failed', style: CustomTextStyles.errorText);
          }
        },
      ),
    );
  }
}
