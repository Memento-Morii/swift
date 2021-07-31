import 'package:flutter/material.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';

class NavigatorDrawer extends StatelessWidget {
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
              iconUrl: "assets/home.png",
              name: "Home",
            ),
            drawerListWidget(
              iconUrl: "assets/services.png",
              name: "My Services",
            ),
            drawerListWidget(
              iconUrl: "assets/orders.png",
              name: "Orders",
            ),
            Divider(
              color: Colors.grey,
              height: 30,
              thickness: 1,
            ),
            SizedBox(height: 20),
            drawerListWidget(
              iconUrl: "assets/setting.png",
              name: "Settings",
            ),
            drawerListWidget(
              iconUrl: "assets/logout.png",
              name: "Logout",
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerListWidget({String iconUrl, String name}) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
