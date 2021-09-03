import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/l10n/l10n.dart';

class LocalProvider extends ChangeNotifier {
  // Locale _locale =
  Locale _locale = L10n.all[1];
  Locale get locale => _locale;
  int _localeIndex;
  get localeIndex => _localeIndex;
  set localeIndex(index) => _localeIndex = index;

  SharedPreferences _preferences;

  void setLocale(Locale locale, int index) async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.setInt("locale", index);
    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }

  Locale getLocale(SharedPreferences preferences) {
    int localeIndex = preferences.getInt('locale');
    if (localeIndex != null) {
      _localeIndex = localeIndex;
      _locale = L10n.all[localeIndex];
    } else {
      _localeIndex = 1;
      _locale = L10n.all[1];
    }
    return _locale;
  }

  Future<int> getLocaleIndex() async {
    _preferences = await SharedPreferences.getInstance();
    int localeIndex = _preferences.getInt('locale');
    if (localeIndex != null) {
      localeIndex = 1;
    }
    return localeIndex;
  }
}
