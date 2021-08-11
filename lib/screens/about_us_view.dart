import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/screens/company_profile.dart';
import 'package:swift/screens/key_personnel.dart';
import 'package:swift/widgets/about_us_card.dart';
import 'package:swift/widgets/navigator_drawers.dart';

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
          'ABOUT US',
          style: CustomTextStyles.bigWhiteText,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ListView(
          children: [
            AboutUsCard(
              title: "Company Profile",
              buttonName: "See More",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompanyProfile(),
                  ),
                );
              },
              child: Text(
                'Swift Technologies PLC is an online service booking platform in Addis Ababa, Ethiopia',
                style: CustomTextStyles.boldText,
              ),
            ),
            SizedBox(height: 40),
            AboutUsCard(
                title: "Key Personnel",
                buttonName: "See Details",
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
