import 'package:flutter/material.dart';
import '../models/liability.dart';
import '../database/database_helper.dart';
import '../utils/constants.dart';

class LiabilityProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper();
  List<Liability> _liabilities = [];
  bool _loading = false;

  List<Liability> get liabilities => _liabilities;
  bool get loading => _loading;
  double get totalAmount => _liabilities.fold(0.0, (sum, l) => sum + (l.remainingAmount ?? l.amount));
  double get totalMonthlyPayment => _liabilities.fold(0, (sum, l) => sum + (l.monthlyPayment ?? 0));

  Future<void> loadLiabilities() async {
    _loading = true;
    notifyListeners();
    final results = await _db.query(
      'liabilities',
      where: 'user_id = ?',
      whereArgs: [AppConstants.defaultUserId],
      orderBy: 'id DESC',
    );
    _liabilities = results.map((m) => Liability.fromMap(m)).toList();
    _loading = false;
    notifyListeners();
  }

  Future<void> addLiability(Liability liability) async {
    await _db.insert('liabilities', liability.toMap());
    await loadLiabilities();
  }

  Future<void> updateLiability(Liability liability) async {
    await _db.update(
      'liabilities',
      liability.toMap(),
      'id = ? AND user_id = ?',
      [liability.id, AppConstants.defaultUserId],
    );
    await loadLiabilities();
  }

  Future<void> deleteLiability(int id) async {
    await _db.delete('liabilities', 'id = ? AND user_id = ?', [id, AppConstants.defaultUserId]);
    await loadLiabilities();
  }
}
