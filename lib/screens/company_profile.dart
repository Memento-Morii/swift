import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';

class CompanyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: <Widget>[
            Text(
              'Company Profile'.toUpperCase(),
              style: CustomTextStyles.bigBoldText,
            ),
            SizedBox(height: 20),
            Text(
              'SwiftOlio is an online service booking platform in Addis Ababa, Ethiopia',
              style: CustomTextStyles.boldText,
            ),
          ],
        ),
      ),
    );
  }
}
