import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/service_model.dart';

class ServiceCard extends StatelessWidget {
  ServiceCard(this.result);
  final Result result;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        height: 100,
        child: Column(
          children: <Widget>[
            Image.asset(
              "assets/home-filled.png",
              height: 50,
            ),
            SizedBox(height: 10),
            Text(
              result.name,
              style: CustomTextStyles.textField,
            )
          ],
        ),
      ),
    );
  }
}
