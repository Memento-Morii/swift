import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/screens/orders/order_history/order_history_view.dart';
import 'package:swift/screens/orders/service_provider_order/service_provider_order_view.dart';
import 'package:swift/widgets/navigator_drawers.dart';

// ignore: must_be_immutable
class Order extends StatefulWidget {
  Order(this.isServiceProvider);
  bool isServiceProvider;
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  bool isUserOrder = false;
  @override
  void initState() {
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: SingleChildScrollView(
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
              isUserOrder == false ? OrderHistoryView() : ServiceProviderOrderView()
            ],
          ),
        ),
      ),
    );
  }
}
