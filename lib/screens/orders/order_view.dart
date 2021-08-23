import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/order_history_model.dart';
import 'package:swift/screens/orders/service_provider_order/service_provider_order_view.dart';
import 'package:swift/widgets/navigator_drawers.dart';
import 'package:swift/widgets/order_history_widget.dart';

import 'bloc/order_bloc.dart';

// ignore: must_be_immutable
class Order extends StatefulWidget {
  Order(this.isServiceProvider);
  bool isServiceProvider;
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  OrderBloc _orderBloc;
  bool isUserOrder = false;
  @override
  void initState() {
    _orderBloc = OrderBloc();
    _orderBloc.add(FetchOrderHistory(widget.isServiceProvider));
    // _orderBloc.add(ServiceProviderOrders());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigatorDrawer(),
      appBar: AppBar(
        title: Text(
          'ORDERS',
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
                child: Text(
                  'Failed',
                  style: CustomTextStyles.errorText,
                ),
              );
            } else if (state is OrderEmpty) {
              return Center(
                child: Text(
                  "Your Order List is Empty",
                  style: CustomTextStyles.errorText,
                ),
              );
            } else if (state is OrderLoaded) {
              List<OrderHistoryModel> orders = state.orderHistories.reversed.toList();
              return Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Column(
                  children: [
                    widget.isServiceProvider
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'MY USER ORDERS',
                                style: CustomTextStyles.boldMediumText,
                              ),
                              Switch(
                                value: isUserOrder,
                                inactiveThumbColor: Colors.green,
                                inactiveTrackColor: Colors.green[300],
                                onChanged: (value) {
                                  setState(() {
                                    isUserOrder = !isUserOrder;
                                  });
                                },
                              ),
                              Text(
                                'ORDERS RECEIVED',
                                style: CustomTextStyles.boldMediumText,
                              ),
                            ],
                          )
                        : SizedBox(),
                    isUserOrder == false
                        ? ListView.separated(
                            shrinkWrap: true,
                            itemCount: state.orderHistories.length,
                            itemBuilder: (context, index) {
                              OrderHistoryModel order = orders[index];
                              return OrderHistoryWidget(order: order);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 20);
                            },
                          )
                        : ServiceProviderOrderView(state.orders)
                  ],
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
