import 'package:flutter/material.dart';
import '../models/user.dart';
import '../database/database_helper.dart';
import '../utils/constants.dart';

class UserProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper();
  User? _user;

  User? get user => _user;

  Future<void> loadUser() async {
    final results = await _db.query(
      'users',
      where: 'user_id = ?',
      whereArgs: [AppConstants.defaultUserId],
    );
    if (results.isNotEmpty) {
      _user = User.fromMap(results.first);
      notifyListeners();
    }
  }

  Future<void> updateUser(User user) async {
    await _db.update(
      'users',
      user.toMap(),
      'user_id = ?',
      [user.userId],
    );
    _user = user;
    notifyListeners();
  }
}
