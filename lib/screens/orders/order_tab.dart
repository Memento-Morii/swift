import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/screens/orders/service_provider_order/service_provider_order_view.dart';
import 'package:swift/widgets/navigator_drawers.dart';
import 'order_history/order_history_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderTab extends StatefulWidget {
  @override
  _OrderTabState createState() => _OrderTabState();
}

class _OrderTabState extends State<OrderTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: NavigatorDrawer(),
        appBar: AppBar(
          title: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelStyle: CustomTextStyles.mediumWhiteText,
            tabs: <Widget>[
              Tab(
                text: AppLocalizations.of(context).myProviderOrders,
              ),
              Tab(
                text: AppLocalizations.of(context).myUserOrders,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ServiceProviderOrderView(),
            OrderHistoryView(),
          ],
        ),
      ),
    );
  }
}
