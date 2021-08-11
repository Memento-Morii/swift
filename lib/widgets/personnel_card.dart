import 'package:flutter/material.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';

class PersonnelCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(20),
      color: CustomColors.primaryColor,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 10),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent[400],
                    border: Border.all(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    'Daniel Abera Haile',
                    style: CustomTextStyles.mediumWhiteText,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      'Founder & CEO',
                      style: CustomTextStyles.boldTitleText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
