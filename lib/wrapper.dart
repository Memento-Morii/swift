import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:swift/helper/utils.dart';
import 'package:swift/screens/home/home_view.dart';
import 'package:swift/screens/orders/order_tab.dart';
import 'package:swift/screens/register/add_services/add_services_view.dart';
import 'package:swift/services/local_notification.dart';

class Wrapper extends StatefulWidget {
  Wrapper(this.serviceProvider);
  final int serviceProvider;

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int selected;
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((value) => print(value));
    //TERMINATED
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        // print(message.data.toString());
        Utils.logoutDialog(
          context: context,
          selectedIndex: selected,
        );
      }
    });

    //FOREGROUND
    FirebaseMessaging.onMessage.listen((message) {
      if (message != null) {
        // inspect(message);
        LocalNotificationService.display(message);
      }
    });

    //BACKGROUND
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message != null) {
        print(message);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.serviceProvider == 2) {
      return AddService(false);
    } else if (widget.serviceProvider == 1) {
      return OrderTab();
    } else {
      return Home();
    }
  }
}
