import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class PasswordProvider extends ChangeNotifier {
  static const String _passwordKey = 'app_lock_password';
  static const String _enabledKey = 'app_lock_enabled';

  bool _isLocked = false;
  bool _hasPassword = false;
  bool _isLoading = true;

  bool get isLocked => _isLocked;
  bool get hasPassword => _hasPassword;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _hasPassword = prefs.getBool(_enabledKey) ?? false;
    _isLocked = _hasPassword;
    _isLoading = false;
    notifyListeners();
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  Future<bool> verifyPassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_passwordKey);
    if (stored == null) return false;
    return stored == _hashPassword(password);
  }

  Future<bool> setPassword(String password) async {
    if (password.length < 4) return false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_passwordKey, _hashPassword(password));
    await prefs.setBool(_enabledKey, true);
    _hasPassword = true;
    notifyListeners();
    return true;
  }

  Future<void> removePassword() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_passwordKey);
    await prefs.setBool(_enabledKey, false);
    _hasPassword = false;
    _isLocked = false;
    notifyListeners();
  }

  void unlock() {
    _isLocked = false;
    notifyListeners();
  }

  void lock() {
    if (_hasPassword) {
      _isLocked = true;
      notifyListeners();
    }
  }
}
