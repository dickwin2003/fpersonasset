import 'package:flutter/material.dart';
import '../models/cash_flow.dart';
import '../database/database_helper.dart';
import '../utils/constants.dart';

class CashFlowProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper();
  List<CashFlow> _cashFlows = [];
  bool _loading = false;

  List<CashFlow> get cashFlows => _cashFlows;
  bool get loading => _loading;

  List<CashFlow> get planned => _cashFlows.where((c) => c.isPlanned).toList();
  List<CashFlow> get historical => _cashFlows.where((c) => !c.isPlanned).toList();

  double get totalIncome => _cashFlows
      .where((c) => c.isIncome)
      .fold(0, (sum, c) => sum + c.displayAmount);

  double get totalExpense => _cashFlows
      .where((c) => !c.isIncome)
      .fold(0, (sum, c) => sum + c.displayAmount);

  Future<void> loadCashFlows() async {
    _loading = true;
    notifyListeners();
    final results = await _db.query(
      'cash_flows',
      where: 'user_id = ?',
      whereArgs: [AppConstants.defaultUserId],
      orderBy: 'date DESC',
    );
    _cashFlows = results.map((m) => CashFlow.fromMap(m)).toList();
    _loading = false;
    notifyListeners();
  }

  Future<void> addCashFlow(CashFlow cashFlow) async {
    await _db.insert('cash_flows', cashFlow.toMap());
    await loadCashFlows();
  }

  Future<void> updateCashFlow(CashFlow cashFlow) async {
    await _db.update(
      'cash_flows',
      cashFlow.toMap(),
      'id = ? AND user_id = ?',
      [cashFlow.id, AppConstants.defaultUserId],
    );
    await loadCashFlows();
  }

  Future<void> deleteCashFlow(int id) async {
    await _db.delete('cash_flows', 'id = ? AND user_id = ?', [id, AppConstants.defaultUserId]);
    await loadCashFlows();
  }
}
