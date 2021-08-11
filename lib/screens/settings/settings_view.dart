import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';
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
      body: Center(
        child: Text('Settings'),
      ),
    );
  }
}
