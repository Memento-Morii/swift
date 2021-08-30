import 'package:flutter/material.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/helper/utils.dart';
import 'package:swift/screens/home/home_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.75,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).orderReceived,
                    style: CustomTextStyles.bigWhiteText,
                  ),
                ),
              ),
              Image.asset(
                "assets/swift_logo.png",
                height: 200,
              ),
              Text(
                AppLocalizations.of(context).swiftTech,
                style: CustomTextStyles.headlineText3,
              ),
              SizedBox(height: 60),
              InkWell(
                onTap: () {
                  Utils.showToast(context, null, "Loading...", 2);
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: BoxDecoration(
                    color: CustomColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).seeTechProfile,
                      style: CustomTextStyles.bigWhiteText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
