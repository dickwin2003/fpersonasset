class AppConstants {
  static const String appName = '聚财';
  static const String appVersion = '2.0.0';
  static const String defaultUserId = 'default_user';

  // 资产分类
  static const List<String> assetCategories = ['fixed', 'liquid', 'consumer'];
  static const Map<String, String> assetCategoryLabels = {
    'fixed': '固定资产',
    'liquid': '流动资产',
    'consumer': '消费品',
  };

  // 负债类型
  static const Map<String, String> liabilityTypeLabels = {
    'mortgage': '房贷',
    'car_loan': '车贷',
    'credit_card': '信用卡',
    'other': '其他',
  };

  // 收入类别
  static const List<String> incomeCategories = [
    '工资', '奖金', '租金收入', '投资收益', '兼职', '经营收入', '其他收入'
  ];

  // 支出类别
  static const List<String> expenseCategories = [
    '住房', '餐饮', '交通', '水电', '医疗', '教育', '娱乐', '购物', '保险', '还贷', '投资', '其他支出'
  ];

  // 频率选项
  static const Map<String, String> frequencyLabels = {
    'once': '一次性',
    'daily': '每天',
    'weekly': '每周',
    'monthly': '每月',
    'quarterly': '每季度',
    'yearly': '每年',
  };

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
}
