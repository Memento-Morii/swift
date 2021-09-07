import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/helper/utils.dart';
import 'package:swift/screens/orders/order_history/order_history_view.dart';
// import 'package:swift/screens/orders/order_tab.dart';
// import 'package:swift/screens/orders/service_provider_order/service_provider_order_view.dart';
import 'package:swift/widgets/navigator_drawers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class Order extends StatefulWidget {
  // Order(this.isServiceProvider);
  // bool isServiceProvider;
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
          AppLocalizations.of(context).orders.toUpperCase(),
          style: CustomTextStyles.bigWhiteText,
        ),
      ),
      body: Utils.exitDialog(
        context: context,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: OrderHistoryView(),
        ),
      ),
    );
  }
}
