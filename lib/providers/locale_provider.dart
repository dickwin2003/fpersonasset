import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  static const String _prefKey = 'app_locale';

  Locale _locale = const Locale('zh', 'CN');

  Locale get locale => _locale;

  static const List<Locale> supportedLocales = [
    Locale('zh', 'CN'),
    Locale('zh', 'TW'),
    Locale('ja', 'JP'),
    Locale('en', 'US'),
  ];

  static const Map<String, String> localeDisplayNames = {
    'zh_CN': '简体中文',
    'zh_TW': '繁體中文',
    'ja_JP': '日本語',
    'en_US': 'English',
  };

  static String getDisplayName(Locale locale) {
    final key = '${locale.languageCode}_${locale.countryCode}';
    return localeDisplayNames[key] ?? locale.toString();
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_prefKey);
    if (saved != null) {
      final parts = saved.split('_');
      if (parts.length == 2) {
        _locale = Locale(parts[0], parts[1]);
      } else {
        _locale = Locale(parts[0]);
      }
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, '${locale.languageCode}_${locale.countryCode}');
  }
}
