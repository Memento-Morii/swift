import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/screens/about_us_view.dart';
import 'package:swift/screens/help/help_view.dart';
import 'package:swift/screens/home/home_view.dart';
import 'package:swift/screens/my_services/my_services_view.dart';
import 'package:swift/screens/orders/order_view.dart';
import 'package:swift/screens/profile/profile_view.dart';
import 'package:swift/screens/register/register_view.dart';
import 'package:swift/screens/settings/settings_view.dart';

class NavigatorDrawer extends StatefulWidget {
  @override
  _NavigatorDrawerState createState() => _NavigatorDrawerState();
}

int selectedIndex = 0;

class _NavigatorDrawerState extends State<NavigatorDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: CustomColors.primaryColor,
        child: ListView(
          children: [
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/user.png"),
                  radius: 30,
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Name",
                      style: CustomTextStyles.bigWhiteText,
                    ),
                    Text(
                      "lorem@ipsum.com",
                      style: CustomTextStyles.mediumWhiteText,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 30),
            drawerListWidget(
              index: 0,
              iconUrl: "assets/home.png",
              name: "Home",
              page: Home(),
            ),
            drawerListWidget(
              index: 1,
              iconUrl: "assets/services.png",
              name: "My Services",
              page: MyServices(),
            ),
            drawerListWidget(
              index: 2,
              iconUrl: "assets/profile.png",
              name: "Profile",
              page: Profile(),
            ),
            drawerListWidget(
              index: 3,
              iconUrl: "assets/orders.png",
              name: "Orders",
              page: Order(),
            ),
            Divider(
              color: Colors.grey[700],
              height: 30,
              thickness: 1,
            ),
            // SizedBox(height: 20),
            drawerListWidget(
              index: 4,
              iconUrl: "assets/setting.png",
              name: "Settings",
              page: Settings(),
            ),
            drawerListWidget(
              index: 5,
              iconUrl: "assets/about.png",
              name: "About Us",
              page: AboutUs(),
            ),
            drawerListWidget(
              index: 6,
              iconUrl: "assets/question.png",
              name: "Help",
              page: Help(),
            ),
            drawerListWidget(
              iconUrl: "assets/logout.png",
              name: "Logout",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerListWidget({String iconUrl, String name, Function onTap, int index, Widget page}) {
    return InkWell(
      onTap: onTap != null
          ? () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove("token");
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Register(),
                ),
                (Route<dynamic> route) => false,
              );
            }
          : selectedIndex == index
              ? () => Navigator.pop(context)
              : () {
                  setState(() {
                    selectedIndex = index;
                  });
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => page,
                    ),
                  );
                },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: selectedIndex == index ? Color(0xff174ca5) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: <Widget>[
            Image.asset(iconUrl, height: 20),
            SizedBox(width: 30),
            Text(
              name,
              style: CustomTextStyles.mediumWhiteText,
            ),
          ],
        ),
      ),
    );
  }
}
