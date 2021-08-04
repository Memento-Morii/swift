import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/service_model.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard(this.service);
  final ServiceModel service;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        children: <Widget>[
          Image.asset(
            "assets/lock.png",
            height: 50,
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width,
          ),
          Text(
            service.name,
            style: CustomTextStyles.textField,
          ),
        ],
      ),
    );
  }
}
