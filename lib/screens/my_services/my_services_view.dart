import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/widgets/navigator_drawers.dart';

class MyServices extends StatefulWidget {
  @override
  _MyServicesState createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigatorDrawer(),
      appBar: AppBar(
        title: Text(
          'MY SERVICES',
          style: CustomTextStyles.bigWhiteText,
        ),
      ),
      body: Center(
        child: Text('My Services'),
      ),
    );
  }
}
