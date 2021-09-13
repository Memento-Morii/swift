import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/helper/utils.dart';
import 'package:swift/screens/about_us_view.dart';
import 'package:swift/screens/help/help_view.dart';
import 'package:swift/screens/home/home_view.dart';
import 'package:swift/screens/my_services/my_services_view.dart';
import 'package:swift/screens/orders/order_tab.dart';
import 'package:swift/screens/orders/order_view.dart';
import 'package:swift/screens/profile/profile_view.dart';
import 'package:swift/screens/settings/settings_view.dart';
import 'package:swift/widgets/navigator_drawers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerLists extends StatefulWidget {
  DrawerLists({
    this.userRole,
    this.firstName,
    this.lastName,
    this.phone,
    this.userImage,
  });
  final int userRole;
  final String firstName;
  final String lastName;
  final String phone;
  final String userImage;
  @override
  _DrawerListsState createState() => _DrawerListsState();
}

class _DrawerListsState extends State<DrawerLists> {
  bool isUser;
  @override
  void initState() {
    widget.userRole == 0 ? isUser = true : isUser = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 20),
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: widget.userImage == null
                  ? AssetImage("assets/profile-user.png")
                  : MemoryImage(
                      Base64Decoder().convert(widget.userImage),
                    ),
              radius: 30,
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${widget.firstName} ${widget.lastName}",
                  style: CustomTextStyles.bigWhiteText,
                ),
                Text(
                  widget.phone,
                  style: CustomTextStyles.mediumWhiteText,
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 30),
        isUser
            ? drawerListWidget(
                index: 0,
                iconUrl: "assets/home.png",
                name: AppLocalizations.of(context).home,
                page: Home(),
              )
            : drawerListWidget(
                index: 0,
                iconUrl: "assets/orders.png",
                name: AppLocalizations.of(context).orders,
                page: isUser ? Order() : OrderTab(),
              ),
        widget.userRole == 0
            ? SizedBox()
            : drawerListWidget(
                index: 1,
                iconUrl: "assets/services.png",
                name: AppLocalizations.of(context).myServices,
                page: MyServices(),
              ),
        drawerListWidget(
          index: 2,
          iconUrl: "assets/profile.png",
          name: AppLocalizations.of(context).profile,
          page: Profile(),
        ),
        isUser
            ? drawerListWidget(
                index: 3,
                iconUrl: "assets/orders.png",
                name: AppLocalizations.of(context).orders,
                page: isUser ? Order() : OrderTab(),
              )
            : drawerListWidget(
                index: 3,
                iconUrl: "assets/home.png",
                name: AppLocalizations.of(context).home,
                page: Home(),
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
          name: AppLocalizations.of(context).settings,
          page: Settings(),
        ),
        drawerListWidget(
          index: 5,
          iconUrl: "assets/about.png",
          name: AppLocalizations.of(context).aboutUs,
          page: AboutUs(),
        ),
        drawerListWidget(
          index: 6,
          iconUrl: "assets/question.png",
          name: AppLocalizations.of(context).help,
          page: Help(),
        ),
        drawerListWidget(
          iconUrl: "assets/logout.png",
          name: AppLocalizations.of(context).logout,
          onTap: () {},
        ),
      ],
    );
  }

  Widget drawerListWidget({String iconUrl, String name, Function onTap, int index, Widget page}) {
    return InkWell(
      onTap: onTap != null
          ? () async {
              Utils.logoutDialog(
                context: context,
                selectedIndex: selectedIndex,
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
