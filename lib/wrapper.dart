import 'package:flutter/material.dart';
import 'package:swift/screens/home/home_view.dart';
import 'package:swift/screens/register/add_services/add_services_view.dart';

class Wrapper extends StatelessWidget {
  Wrapper(this.serviceProvider);
  final int serviceProvider;
  @override
  Widget build(BuildContext context) {
    if (serviceProvider == 2) {
      return AddService(false);
    } else {
      return Home();
    }
  }
}
