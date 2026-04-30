import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  SettingsProvider() {
    _loadLocale();
  }

  void setLocale(Locale newLocale) async {
    if (_locale != newLocale) {
      _locale = newLocale;
      notifyListeners();
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('languageCode', newLocale.languageCode);
    }
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString('languageCode');
    
    if (languageCode != null) {
      _locale = Locale(languageCode);
      notifyListeners();
    }
  }
}
