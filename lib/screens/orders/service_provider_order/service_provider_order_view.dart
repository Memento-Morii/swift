import 'package:flutter/material.dart';
import 'package:swift/models/provider_order_model.dart';
import 'package:swift/widgets/provider_order_card.dart';

class ServiceProviderOrderView extends StatefulWidget {
  ServiceProviderOrderView(this.orders);
  final List<ProviderOrderModel> orders;
  @override
  _ServiceProviderOrderViewState createState() => _ServiceProviderOrderViewState();
}

class _ServiceProviderOrderViewState extends State<ServiceProviderOrderView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        ProviderOrderModel order = widget.orders[index];
        return ProviderOrderCard(order);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 20);
      },
      itemCount: widget.orders.length,
    );
  }
}
