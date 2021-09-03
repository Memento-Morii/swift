import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/widgets/drawer_lists.dart';

int selectedIndex = 0;

class NavigatorDrawer extends StatefulWidget {
  @override
  _NavigatorDrawerState createState() => _NavigatorDrawerState();
}

class _NavigatorDrawerState extends State<NavigatorDrawer> {
  int userRole;
  String firstName;
  String lastName;
  // String email;
  String phone;
  // String userImage;
  Future getRole() async {
    userRole = null;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    userRole = _prefs.getInt("serviceProvider");
    firstName = _prefs.getString("firstName");
    lastName = _prefs.getString("lastName");
    // email = _prefs.getString("email");
    phone = _prefs.getString("phone");
    // userImage = _prefs.getString("userImage");
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: CustomColors.primaryColor,
        child: FutureBuilder(
          future: getRole(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return DrawerLists(
                userRole: userRole,
                firstName: firstName,
                lastName: lastName,
                // email: email,
                phone: phone,
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
