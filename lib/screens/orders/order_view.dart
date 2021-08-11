import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/order_model.dart';
import 'package:swift/widgets/navigator_drawers.dart';
import 'package:swift/widgets/order_history_widget.dart';

import 'bloc/order_bloc.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  OrderBloc _orderBloc;
  @override
  void initState() {
    _orderBloc = OrderBloc();
    _orderBloc.add(FetchOrderHistory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigatorDrawer(),
      appBar: AppBar(
        title: Text(
          'ORDER',
          style: CustomTextStyles.bigWhiteText,
        ),
      ),
      body: BlocProvider(
        create: (context) => OrderBloc(),
        child: BlocBuilder<OrderBloc, OrderState>(
          bloc: _orderBloc,
          builder: (context, state) {
            if (state is OrderFailed) {
              return Center(
                child: Text('Failed'),
              );
            } else if (state is OrderEmpty) {
              return Center(
                child: Text(
                  "Your Order List is Empty",
                  style: CustomTextStyles.errorText,
                ),
              );
            } else if (state is OrderLoaded) {
              List<OrderModel> orders = state.orderHistories.reversed.toList();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.separated(
                  itemCount: state.orderHistories.length,
                  itemBuilder: (context, index) {
                    OrderModel order = orders[index];
                    return OrderHistoryWidget(order: order);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 20);
                  },
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
