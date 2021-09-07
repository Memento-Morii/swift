import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/helper/utils.dart';
import 'package:swift/screens/company_profile.dart';
import 'package:swift/screens/key_personnel.dart';
import 'package:swift/widgets/about_us_card.dart';
import 'package:swift/widgets/navigator_drawers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigatorDrawer(),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).aboutUs.toUpperCase(),
          style: CustomTextStyles.bigWhiteText,
        ),
      ),
      body: Utils.exitDialog(
        context: context,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: ListView(
            children: [
              AboutUsCard(
                title: AppLocalizations.of(context).companyProfile,
                buttonName: AppLocalizations.of(context).seeMore,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CompanyProfile(),
                    ),
                  );
                },
                child: Text(
                  AppLocalizations.of(context).aboutSwift,
                  style: CustomTextStyles.boldText,
                ),
              ),
              SizedBox(height: 40),
              AboutUsCard(
                  title: AppLocalizations.of(context).meetTheTeam,
                  buttonName: AppLocalizations.of(context).seeDetails,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KeyPersonnel(),
                      ),
                    );
                  },
                  child: Container(
                    height: 130,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context).daniel,
                              style: CustomTextStyles.bodyColoredText,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Text(
                                AppLocalizations.of(context).andualem,
                                style: CustomTextStyles.bodyColoredText,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context).birhane,
                              style: CustomTextStyles.bodyColoredText,
                            ),
                          ],
                        ),
                        // SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context).danielTitle,
                              style: CustomTextStyles.boldText,
                            ),
                            SizedBox(height: 8),
                            Text(
                              AppLocalizations.of(context).andualemTitle,
                              style: CustomTextStyles.boldText,
                            ),
                            SizedBox(height: 15),
                            Text(
                              AppLocalizations.of(context).birhaneTitle,
                              style: CustomTextStyles.boldText,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
