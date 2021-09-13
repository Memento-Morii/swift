import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/helper/utils.dart';
import 'package:swift/screens/home/home_view.dart';
import 'package:swift/screens/orders/order_tab.dart';
import 'package:swift/screens/register/add_services/add_services_view.dart';
import 'package:swift/services/local_notification.dart';
import 'package:swift/services/repositories.dart';

class Wrapper extends StatefulWidget {
  Wrapper(this.serviceProvider);
  final int serviceProvider;

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((token) async {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      int id = _prefs.getInt('id');
      Repositories().sumbitToken(
        token: token,
        userId: id,
      );
    });
    //TERMINATED
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        // print(message.data.toString());
        // Utils.newOrder(
        //   context: context,
        // );
      }
    });

    //FOREGROUND
    FirebaseMessaging.onMessage.listen((message) {
      if (message != null) {
        print(message.notification.body);
        // inspect(message);
        LocalNotificationService.display(message);
      }
    });

    //BACKGROUND
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message != null) {
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
