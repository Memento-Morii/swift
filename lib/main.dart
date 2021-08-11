import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/l10n/l10n.dart';
import 'package:swift/screens/register/register_view.dart';
import 'helper/colors.dart';
import 'screens/home/home_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          titleTextStyle: CustomTextStyles.normalWhiteText,
          backgroundColor: CustomColors.primaryColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        primarySwatch: Colors.blue,
      ),
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: token == null ? Register() : Home(response: "Homepage"),
    ),
  );
}
