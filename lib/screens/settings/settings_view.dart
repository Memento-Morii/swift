import 'package:flutter/material.dart';
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
      appBar: AppBar(),
      body: Center(
        child: Text('Settings'),
      ),
    );
  }
}
