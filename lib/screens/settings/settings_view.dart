import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/screens/language/language_view.dart';
import 'package:swift/widgets/navigator_drawers.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigatorDrawer(),
        appBar: AppBar(
          title: Text(
            'SETTINGS',
            style: CustomTextStyles.bigWhiteText,
          ),
        ),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Language',
                  style: CustomTextStyles.boldText,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LanguageView(),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ));
  }
}
