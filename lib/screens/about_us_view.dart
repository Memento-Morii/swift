import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';
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
      body: Padding(
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
                title: AppLocalizations.of(context).keyPersonnel,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Daniel Abera',
                            style: CustomTextStyles.coloredBold,
                          ),
                          Text(
                            'Kebede Tenkir',
                            style: CustomTextStyles.coloredBold,
                          ),
                          Text(
                            'Andualem Yosef',
                            style: CustomTextStyles.coloredBold,
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Founder & CEO',
                            style: CustomTextStyles.boldText,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'CMO',
                            style: CustomTextStyles.boldText,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'COO,CTO',
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
    );
  }
}
