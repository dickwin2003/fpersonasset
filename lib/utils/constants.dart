import 'package:flutter/widgets.dart';
import '../l10n/app_localizations.dart';

class AppConstants {
  static const String appName = '聚财';
  static const String appVersion = '2.0.0';
  static const String defaultUserId = 'default_user';

  // 资产分类
  static const List<String> assetCategories = ['fixed', 'liquid', 'consumer'];

  // 负债类型
  static const List<String> liabilityTypes = ['mortgage', 'car_loan', 'credit_card', 'other'];

  // 收入类别 (key)
  static const List<String> incomeCategoryKeys = [
    'salary', 'bonus', 'rent', 'investment', 'partTime', 'business', 'otherIncome'
  ];

  // 支出类别 (key)
  static const List<String> expenseCategoryKeys = [
    'housing', 'food', 'transport', 'utilities', 'medical', 'education',
    'entertainment', 'shopping', 'insurance', 'loanRepayment', 'investment', 'otherExpense'
  ];

  // 频率选项 (key list)
  static const List<String> frequencyKeys = ['once', 'daily', 'weekly', 'monthly', 'quarterly', 'yearly'];

  // 默认资产类型
  static const List<Map<String, dynamic>> defaultAssetTypes = [
    {'name': '现金', 'category': 'liquid', 'description': '现金及活期存款', 'has_depreciation': false, 'depreciation_rate': 0},
    {'name': '股票', 'category': 'liquid', 'description': '股票投资', 'has_depreciation': false, 'depreciation_rate': 0},
    {'name': '房产', 'category': 'fixed', 'description': '房产投资', 'has_depreciation': false, 'depreciation_rate': 0},
    {'name': '基金', 'category': 'liquid', 'description': '基金投资', 'has_depreciation': false, 'depreciation_rate': 0},
    {'name': '债券', 'category': 'liquid', 'description': '债券投资', 'has_depreciation': false, 'depreciation_rate': 0},
    {'name': '汽车', 'category': 'consumer', 'description': '私家车', 'has_depreciation': true, 'depreciation_rate': 15},
    {'name': '电子产品', 'category': 'consumer', 'description': '手机、电脑等', 'has_depreciation': true, 'depreciation_rate': 30},
    {'name': '家具', 'category': 'consumer', 'description': '家具家电', 'has_depreciation': true, 'depreciation_rate': 10},
    {'name': '贵金属', 'category': 'liquid', 'description': '黄金白银等', 'has_depreciation': false, 'depreciation_rate': 0},
    {'name': '其他', 'category': 'liquid', 'description': '其他资产', 'has_depreciation': false, 'depreciation_rate': 0},
  ];

  // 颜色
  static const int primaryColor = 0xFF1976D2;
  static const int incomeColor = 0xFF4CAF50;
  static const int expenseColor = 0xFFF44336;
  static const int assetColor = 0xFF2196F3;
  static const int liabilityColor = 0xFFE53935;
  static const int netWorthColor = 0xFF43A047;

  // ============ i18n helper methods ============

  static String getCategoryLabel(BuildContext context, String category) {
    final s = S.of(context);
    switch (category) {
      case 'fixed': return s.categoryFixedAssets;
      case 'liquid': return s.categoryLiquidAssets;
      case 'consumer': return s.categoryConsumerGoods;
      default: return category;
    }
  }

  static String getLiabilityTypeLabel(BuildContext context, String type) {
    final s = S.of(context);
    switch (type) {
      case 'mortgage': return s.categoryMortgage;
      case 'car_loan': return s.categoryCarLoan;
      case 'credit_card': return s.categoryCreditCard;
      case 'other': return s.categoryOther;
      default: return type;
    }
  }

  static String getFrequencyLabel(BuildContext context, String frequency) {
    final s = S.of(context);
    switch (frequency) {
      case 'once': return s.frequencyOnce;
      case 'daily': return s.frequencyDaily;
      case 'weekly': return s.frequencyWeekly;
      case 'monthly': return s.frequencyMonthly;
      case 'quarterly': return s.frequencyQuarterly;
      case 'yearly': return s.frequencyYearly;
      default: return frequency;
    }
  }

  static String getIncomeCategoryLabel(BuildContext context, String key) {
    final s = S.of(context);
    switch (key) {
      case 'salary': return s.incomeSalary;
      case 'bonus': return s.incomeBonus;
      case 'rent': return s.incomeRent;
      case 'investment': return s.incomeInvestment;
      case 'partTime': return s.incomePartTime;
      case 'business': return s.incomeBusiness;
      case 'otherIncome': return s.incomeOther;
      default: return key; // fallback for legacy Chinese data
    }
  }

  static String getExpenseCategoryLabel(BuildContext context, String key) {
    final s = S.of(context);
    switch (key) {
      case 'housing': return s.expenseHousing;
      case 'food': return s.expenseFood;
      case 'transport': return s.expenseTransport;
      case 'utilities': return s.expenseUtilities;
      case 'medical': return s.expenseMedical;
      case 'education': return s.expenseEducation;
      case 'entertainment': return s.expenseEntertainment;
      case 'shopping': return s.expenseShopping;
      case 'insurance': return s.expenseInsurance;
      case 'loanRepayment': return s.expenseLoanRepayment;
      case 'investment': return s.expenseInvestment;
      case 'otherExpense': return s.expenseOther;
      default: return key; // fallback for legacy Chinese data
    }
  }

  // Get localized category label (auto-detect income or expense)
  static String getCategoryLabelByType(BuildContext context, String key, String type) {
    if (type == 'income') return getIncomeCategoryLabel(context, key);
    return getExpenseCategoryLabel(context, key);
  }
}
