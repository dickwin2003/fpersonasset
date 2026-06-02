import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class DashboardProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper();
  bool _loading = false;

  double _totalAssets = 0;
  double _totalLiabilities = 0;
  double _monthIncome = 0;
  double _monthExpense = 0;
  List<Map<String, dynamic>> _assetDistribution = [];
  List<Map<String, dynamic>> _assetReturns = [];
  List<Map<String, dynamic>> _monthlyTrend = [];

  bool get loading => _loading;
  double get totalAssets => _totalAssets;
  double get totalLiabilities => _totalLiabilities;
  double get netWorth => _totalAssets - _totalLiabilities;
  double get monthIncome => _monthIncome;
  double get monthExpense => _monthExpense;
  double get monthNetCashFlow => _monthIncome - _monthExpense;
  List<Map<String, dynamic>> get assetDistribution => _assetDistribution;
  List<Map<String, dynamic>> get assetReturns => _assetReturns;
  List<Map<String, dynamic>> get monthlyTrend => _monthlyTrend;

  Future<void> loadDashboard() async {
    _loading = true;
    notifyListeners();

    final now = DateTime.now();

    final futures = await Future.wait([
      _db.getTotalAssets(),
      _db.getTotalLiabilities(),
      _db.getMonthlyCashFlow(now.year, now.month),
      _db.getAssetDistribution(),
      _db.getAssetReturns(),
      _db.getMonthlyTrend(12),
    ]);

    _totalAssets = futures[0] as double;
    _totalLiabilities = futures[1] as double;
    final cashFlow = futures[2] as Map<String, double>;
    _monthIncome = cashFlow['income'] ?? 0;
    _monthExpense = cashFlow['expense'] ?? 0;
    _assetDistribution = futures[3] as List<Map<String, dynamic>>;
    _assetReturns = futures[4] as List<Map<String, dynamic>>;
    _monthlyTrend = futures[5] as List<Map<String, dynamic>>;

    _loading = false;
    notifyListeners();
  }
}
