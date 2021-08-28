import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/l10n/l10n.dart';
import 'package:swift/provider/local_provider.dart';
import 'package:swift/screens/register/signIn_view.dart';
import 'package:swift/wrapper.dart';
import 'helper/colors.dart';
// import 'screens/home/home_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.get("token");
  int serviceProvider = prefs.get('serviceProvider');
  // prefs.clear();
  print(token);
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocalProvider(),
      builder: (context, child) {
        final provider = Provider.of<LocalProvider>(context);
        return MaterialApp(
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
          locale: provider.locale,
          supportedLocales: L10n.all,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: token == null ? SignInView() : Wrapper(serviceProvider),
        );
      },
    ),
  );
}
