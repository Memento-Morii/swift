import 'package:flutter/material.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/service_model.dart';

class ServiceCategoryCard extends StatelessWidget {
  ServiceCategoryCard(this.service);
  final ServiceModel service;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 6,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: CustomColors.primaryColor,
                  radius: 30,
                ),
                SizedBox(width: 20),
                Text(
                  service.name,
                  style: CustomTextStyles.mediumText,
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Hey Dialog"),
                    // content: ,
                    actions: [
                      TextButton(
                        onPressed: () {},
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                "Order",
                style: CustomTextStyles.coloredBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
