import 'package:flutter/material.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/widgets/custom_button.dart';
import 'package:swift/widgets/myTextField.dart';
import 'package:swift/widgets/navigator_drawers.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigatorDrawer(),
      appBar: AppBar(
        title: Text(
          'HELP',
          style: CustomTextStyles.bigWhiteText,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  width: 250,
                  child: Text(
                    'Contact Our Customer Service For any help'.toUpperCase(),
                    style: CustomTextStyles.bigBoldText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: <Widget>[
                  Image.asset(
                    "assets/customer-service.png",
                    height: 100,
                  ),
                  SizedBox(width: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Call Us',
                            style: CustomTextStyles.boldTitleText,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Telegram Us',
                            style: CustomTextStyles.boldTitleText,
                          ),
                        ],
                      ),
                      SizedBox(width: 15),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(
                            "assets/phone_green.png",
                            height: 30,
                          ),
                          SizedBox(height: 12),
                          Image.asset(
                            "assets/telegram.png",
                            height: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Leave us your feedback here',
                style: CustomTextStyles.mediumText,
              ),
              MyTextField(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 100,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: CustomButton(
                  width: 160,
                  color: CustomColors.primaryColor,
                  child: Text(
                    'Send Feedback',
                    style: CustomTextStyles.mediumWhiteText,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
