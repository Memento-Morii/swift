import 'package:flutter/material.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/widgets/custom_button.dart';
import 'package:swift/widgets/myTextField.dart';
import 'package:swift/widgets/navigator_drawers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:swift/widgets/social_network.dart';

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
          AppLocalizations.of(context).help.toUpperCase(),
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
                    AppLocalizations.of(context).contactForHelp.toUpperCase(),
                    style: CustomTextStyles.bigBoldText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 70),
              Row(
                mainAxisSize: MainAxisSize.min,
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
                          SizedBox(height: 10),
                          Text(
                            AppLocalizations.of(context).callUs,
                            style: CustomTextStyles.boldTitleText,
                          ),
                          SizedBox(height: 20),
                          Text(
                            AppLocalizations.of(context).telegramUs,
                            style: CustomTextStyles.boldTitleText,
                          ),
                        ],
                      ),
                      SizedBox(width: 15),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SocialNetwork(
                            icon: "assets/phone_green.png",
                            url: "+251113854444",
                            urlType: URL_TYPE.Telephone,
                          ),
                          SizedBox(height: 12),
                          SocialNetwork(
                            icon: "assets/telegram.png",
                            url: "https://t.me/SwiftOlio_CustomerServiceBot",
                            urlType: URL_TYPE.Link,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // SizedBox(height: 20),
              // Text(
              //   AppLocalizations.of(context).leaveFeedback,
              //   style: CustomTextStyles.mediumText,
              // ),
              // MyTextField(
              //   width: MediaQuery.of(context).size.width * 0.85,
              //   height: 100,
              // ),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: CustomButton(
              //     width: 160,
              //     color: CustomColors.primaryColor,
              //     child: Text(
              //       AppLocalizations.of(context).sendFeedback,
              //       style: CustomTextStyles.mediumWhiteText,
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
