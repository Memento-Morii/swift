import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/screens/register/register_view.dart';
import 'helper/colors.dart';
import 'screens/home/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.get("token");
  // prefs.clear();
  print(token);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: CustomColors.primaryColor),
        ),
        primarySwatch: Colors.blue,
      ),
      home: token == null ? Register() : Home(response: "Homepage"),
    ),
  );
}
