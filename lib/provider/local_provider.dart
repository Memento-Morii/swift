import 'package:flutter/material.dart';
import 'package:swift/l10n/l10n.dart';

class LocalProvider extends ChangeNotifier {
  // Locale _locale = L10n.all[1];
  Locale _locale;
  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }
}
