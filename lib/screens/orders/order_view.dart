import 'package:flutter/material.dart';
import 'package:swift/widgets/navigator_drawers.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigatorDrawer(),
      appBar: AppBar(),
      body: Center(
        child: Text('Order'),
      ),
    );
  }
}
