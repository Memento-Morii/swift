import 'package:flutter/material.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';

class AboutUsCard extends StatelessWidget {
  AboutUsCard({this.title, this.buttonName, this.child, this.onPressed});
  final String title;
  final String buttonName;
  final Widget child;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: CustomColors.primaryColor,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text(
              title.toUpperCase(),
              style: CustomTextStyles.bigWhiteText,
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: child,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                  backgroundColor: MaterialStateProperty.all(Color(0xff09DE04)),
                  side: MaterialStateProperty.all(BorderSide(width: 1.5, color: Colors.white)),
                ),
                onPressed: onPressed,
                child: Text(
                  buttonName.toUpperCase(),
                  style: CustomTextStyles.mediumWhiteText,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
