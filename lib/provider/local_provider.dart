import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/l10n/l10n.dart';

class LocalProvider extends ChangeNotifier {
  // Locale _locale =
  Locale _locale = L10n.all[1];
  Locale get locale => _locale;

  void setLocale(Locale locale) async {
    // SharedPreferences _prefs = await SharedPreferences.getInstance();
    // _prefs.setInt("locale", 0);
    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }
}
