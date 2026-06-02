// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class SZh extends S {
  SZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => '聚财';

  @override
  String get currencyYuan => '元';

  @override
  String get currencyHundredMillion => '亿';

  @override
  String get currencyTenMillion => '千万';

  @override
  String get currencyOneMillion => '百万';

  @override
  String get currencyTenThousand => '万';

  @override
  String get btnSave => '保存';

  @override
  String get btnCancel => '取消';

  @override
  String get btnDelete => '删除';

  @override
  String get btnAdd => '添加';

  @override
  String get btnEdit => '编辑';

  @override
  String get dialogConfirmDelete => '确认删除';

  @override
  String get dialogConfirm => '确认';

  @override
  String get navHome => '首页';

  @override
  String get navAssets => '资产';

  @override
  String get navLiabilities => '负债';

  @override
  String get navCashFlow => '资金流';

  @override
  String get menuAssetTypes => '资产类型';

  @override
  String get menuSettings => '设置';

  @override
  String get menuAbout => '关于';

  @override
  String get dashboardTitle => '财务总览';

  @override
  String get dashboardTotalAssets => '总资产';

  @override
  String get dashboardTotalLiabilities => '总负债';

  @override
  String get dashboardNetWorth => '净资产';

  @override
  String get dashboardMonthlySummary => '月度收支';

  @override
  String get dashboardIncome => '收入';

  @override
  String get dashboardExpense => '支出';

  @override
  String get dashboardNetAmount => '净值';

  @override
  String get dashboardTrend12Months => '12个月趋势';

  @override
  String get dashboardAssetDistribution => '资产分布';

  @override
  String get dashboardAssetReturnRate => '资产收益率';

  @override
  String get dashboardNoData => '暂无数据';

  @override
  String get dashboardReturnRate => '收益率';

  @override
  String get assetsTitle => '我的资产';

  @override
  String get assetsEmpty => '暂无资产';

  @override
  String get assetsEmptyHint => '点击右下角按钮添加您的第一笔资产';

  @override
  String get assetsAddAsset => '添加资产';

  @override
  String get assetsEditAsset => '编辑资产';

  @override
  String get assetsDeleteConfirm => '确定要删除这笔资产吗？';

  @override
  String get assetsCurrentValue => '当前价值';

  @override
  String get assetsPurchaseValue => '购入价值';

  @override
  String get assetsReturnRate => '收益率';

  @override
  String get assetFormName => '资产名称';

  @override
  String get assetFormEnterName => '请输入资产名称';

  @override
  String get assetFormType => '资产类型';

  @override
  String get assetFormSelectType => '请选择资产类型';

  @override
  String get assetFormCurrentValue => '当前价值';

  @override
  String get assetFormEnterValue => '请输入当前价值';

  @override
  String get assetFormPurchaseValue => '购入价值';

  @override
  String get assetFormPurchaseDate => '购入日期';

  @override
  String get assetFormSelectDate => '选择日期';

  @override
  String get assetFormDescription => '描述';

  @override
  String get assetFormEnterDescription => '请输入描述（选填）';

  @override
  String get liabilitiesTitle => '我的负债';

  @override
  String get liabilitiesEmpty => '暂无负债';

  @override
  String get liabilitiesEmptyHint => '点击右下角按钮添加您的第一笔负债';

  @override
  String get liabilitiesAddLiability => '添加负债';

  @override
  String get liabilitiesEditLiability => '编辑负债';

  @override
  String get liabilitiesDeleteConfirm => '确定要删除这笔负债吗？';

  @override
  String get liabilitiesName => '名称';

  @override
  String get liabilitiesEnterName => '请输入名称';

  @override
  String get liabilitiesType => '类型';

  @override
  String get liabilitiesTotalAmount => '总额';

  @override
  String get liabilitiesEnterAmount => '请输入总额';

  @override
  String get liabilitiesInterestRate => '利率(%)';

  @override
  String get liabilitiesMonthlyPayment => '月供';

  @override
  String get liabilitiesRemainingAmount => '剩余金额';

  @override
  String get liabilitiesRemainingMonths => '剩余月数';

  @override
  String get liabilitiesMonth => '个月';

  @override
  String get liabilitiesPaidPercent => '已还';

  @override
  String get cashFlowTitle => '资金流';

  @override
  String get cashFlowPlannedTab => '预期收支';

  @override
  String get cashFlowHistoricalTab => '历史记录';

  @override
  String get cashFlowEmptyPlanned => '暂无预期收支';

  @override
  String get cashFlowEmptyHistorical => '暂无历史记录';

  @override
  String get cashFlowAddRecord => '添加记录';

  @override
  String get cashFlowEditRecord => '编辑记录';

  @override
  String get cashFlowSaveRecord => '保存修改';

  @override
  String get cashFlowIncome => '收入';

  @override
  String get cashFlowExpense => '支出';

  @override
  String get cashFlowCategory => '分类';

  @override
  String get cashFlowAmount => '金额';

  @override
  String get cashFlowEnterAmount => '请输入金额';

  @override
  String get cashFlowDescription => '描述';

  @override
  String get cashFlowEnterDescription => '请输入描述（选填）';

  @override
  String get cashFlowFrequency => '频率';

  @override
  String get cashFlowSelectDate => '选择日期';

  @override
  String get cashFlowStartDate => '开始日期';

  @override
  String get cashFlowEndDate => '结束日期';

  @override
  String get cashFlowSummary => '收支汇总';

  @override
  String get cashFlowTotalIncome => '总收入';

  @override
  String get cashFlowTotalExpense => '总支出';

  @override
  String cashFlowDeleteConfirm(String type) {
    return '确定要删除这条$type记录吗？';
  }

  @override
  String get assetTypesTitle => '资产类型管理';

  @override
  String get assetTypesAddType => '添加类型';

  @override
  String get assetTypesEditType => '编辑类型';

  @override
  String get assetTypesTypeName => '类型名称';

  @override
  String get assetTypesEnterName => '请输入类型名称';

  @override
  String get assetTypesCategory => '分类';

  @override
  String get assetTypesDescription => '描述';

  @override
  String get assetTypesDepreciation => '折旧';

  @override
  String get assetTypesDepreciationRate => '折旧率(%)';

  @override
  String get assetTypesDeleteConfirm => '确定要删除此资产类型吗？';

  @override
  String get assetTypesFixedAssets => '固定资产';

  @override
  String get assetTypesLiquidAssets => '流动资产';

  @override
  String get assetTypesConsumerGoods => '消费品';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsUserInfo => '用户信息';

  @override
  String get settingsUsername => '用户名';

  @override
  String get settingsPhone => '手机号';

  @override
  String get settingsEmail => '邮箱';

  @override
  String get settingsSaveSuccess => '保存成功';

  @override
  String get settingsLanguage => '语言 / Language';

  @override
  String get settingsSelectLanguage => '选择语言';

  @override
  String get settingsDataManagement => '数据管理';

  @override
  String get settingsExportData => '导出数据';

  @override
  String get settingsExportHint => '导出所有数据为 JSON 文件';

  @override
  String get settingsExportFailed => '导出失败';

  @override
  String get settingsClearData => '清除数据';

  @override
  String get settingsClearHint => '清除所有数据（不可恢复）';

  @override
  String get settingsDangerWarning => '⚠️ 危险操作';

  @override
  String get settingsConfirmClear => '确定要清除所有数据吗？此操作不可恢复！';

  @override
  String get settingsConfirmClearBtn => '确认清除';

  @override
  String get settingsDataCleared => '数据已清除';

  @override
  String get settingsDefaultUser => '默认用户';

  @override
  String get aboutTitle => '关于';

  @override
  String get aboutAppIntro => '应用简介';

  @override
  String get aboutAppDescription =>
      '聚财是一款个人资产组合管理应用，帮助您全面掌控财务状况。支持多类型资产管理（固定资产、流动资产、消费品）、负债追踪、收支流水记录，并通过直观的图表展示您的资产分布、收益率和月度趋势。让理财变得简单透明。';

  @override
  String get aboutVersion => '版本';

  @override
  String get aboutPlatform => '平台';

  @override
  String get aboutPlatformDesc => 'Android / iOS';

  @override
  String get aboutStorage => '存储';

  @override
  String get aboutStorageDesc => '本地 SQLite 数据库';

  @override
  String get aboutFramework => '框架';

  @override
  String get aboutFrameworkDesc => 'Flutter';

  @override
  String get aboutCopyright => '© 2024 聚财团队';

  @override
  String get categoryFixedAssets => '固定资产';

  @override
  String get categoryLiquidAssets => '流动资产';

  @override
  String get categoryConsumerGoods => '消费品';

  @override
  String get categoryMortgage => '房贷';

  @override
  String get categoryCarLoan => '车贷';

  @override
  String get categoryCreditCard => '信用卡';

  @override
  String get categoryOther => '其他';

  @override
  String get frequencyOnce => '一次性';

  @override
  String get frequencyDaily => '每天';

  @override
  String get frequencyWeekly => '每周';

  @override
  String get frequencyMonthly => '每月';

  @override
  String get frequencyQuarterly => '每季度';

  @override
  String get frequencyYearly => '每年';

  @override
  String get incomeSalary => '工资';

  @override
  String get incomeBonus => '奖金';

  @override
  String get incomeRent => '租金收入';

  @override
  String get incomeInvestment => '投资收益';

  @override
  String get incomePartTime => '兼职';

  @override
  String get incomeBusiness => '经营收入';

  @override
  String get incomeOther => '其他收入';

  @override
  String get expenseHousing => '住房';

  @override
  String get expenseFood => '餐饮';

  @override
  String get expenseTransport => '交通';

  @override
  String get expenseUtilities => '水电';

  @override
  String get expenseMedical => '医疗';

  @override
  String get expenseEducation => '教育';

  @override
  String get expenseEntertainment => '娱乐';

  @override
  String get expenseShopping => '购物';

  @override
  String get expenseInsurance => '保险';

  @override
  String get expenseLoanRepayment => '还贷';

  @override
  String get expenseInvestment => '投资';

  @override
  String get expenseOther => '其他支出';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class SZhCn extends SZh {
  SZhCn() : super('zh_CN');

  @override
  String get appName => '聚财';

  @override
  String get currencyYuan => '元';

  @override
  String get currencyHundredMillion => '亿';

  @override
  String get currencyTenMillion => '千万';

  @override
  String get currencyOneMillion => '百万';

  @override
  String get currencyTenThousand => '万';

  @override
  String get btnSave => '保存';

  @override
  String get btnCancel => '取消';

  @override
  String get btnDelete => '删除';

  @override
  String get btnAdd => '添加';

  @override
  String get btnEdit => '编辑';

  @override
  String get dialogConfirmDelete => '确认删除';

  @override
  String get dialogConfirm => '确认';

  @override
  String get navHome => '首页';

  @override
  String get navAssets => '资产';

  @override
  String get navLiabilities => '负债';

  @override
  String get navCashFlow => '资金流';

  @override
  String get menuAssetTypes => '资产类型';

  @override
  String get menuSettings => '设置';

  @override
  String get menuAbout => '关于';

  @override
  String get dashboardTitle => '财务总览';

  @override
  String get dashboardTotalAssets => '总资产';

  @override
  String get dashboardTotalLiabilities => '总负债';

  @override
  String get dashboardNetWorth => '净资产';

  @override
  String get dashboardMonthlySummary => '月度收支';

  @override
  String get dashboardIncome => '收入';

  @override
  String get dashboardExpense => '支出';

  @override
  String get dashboardNetAmount => '净值';

  @override
  String get dashboardTrend12Months => '12个月趋势';

  @override
  String get dashboardAssetDistribution => '资产分布';

  @override
  String get dashboardAssetReturnRate => '资产收益率';

  @override
  String get dashboardNoData => '暂无数据';

  @override
  String get dashboardReturnRate => '收益率';

  @override
  String get assetsTitle => '我的资产';

  @override
  String get assetsEmpty => '暂无资产';

  @override
  String get assetsEmptyHint => '点击右下角按钮添加您的第一笔资产';

  @override
  String get assetsAddAsset => '添加资产';

  @override
  String get assetsEditAsset => '编辑资产';

  @override
  String get assetsDeleteConfirm => '确定要删除这笔资产吗？';

  @override
  String get assetsCurrentValue => '当前价值';

  @override
  String get assetsPurchaseValue => '购入价值';

  @override
  String get assetsReturnRate => '收益率';

  @override
  String get assetFormName => '资产名称';

  @override
  String get assetFormEnterName => '请输入资产名称';

  @override
  String get assetFormType => '资产类型';

  @override
  String get assetFormSelectType => '请选择资产类型';

  @override
  String get assetFormCurrentValue => '当前价值';

  @override
  String get assetFormEnterValue => '请输入当前价值';

  @override
  String get assetFormPurchaseValue => '购入价值';

  @override
  String get assetFormPurchaseDate => '购入日期';

  @override
  String get assetFormSelectDate => '选择日期';

  @override
  String get assetFormDescription => '描述';

  @override
  String get assetFormEnterDescription => '请输入描述（选填）';

  @override
  String get liabilitiesTitle => '我的负债';

  @override
  String get liabilitiesEmpty => '暂无负债';

  @override
  String get liabilitiesEmptyHint => '点击右下角按钮添加您的第一笔负债';

  @override
  String get liabilitiesAddLiability => '添加负债';

  @override
  String get liabilitiesEditLiability => '编辑负债';

  @override
  String get liabilitiesDeleteConfirm => '确定要删除这笔负债吗？';

  @override
  String get liabilitiesName => '名称';

  @override
  String get liabilitiesEnterName => '请输入名称';

  @override
  String get liabilitiesType => '类型';

  @override
  String get liabilitiesTotalAmount => '总额';

  @override
  String get liabilitiesEnterAmount => '请输入总额';

  @override
  String get liabilitiesInterestRate => '利率(%)';

  @override
  String get liabilitiesMonthlyPayment => '月供';

  @override
  String get liabilitiesRemainingAmount => '剩余金额';

  @override
  String get liabilitiesRemainingMonths => '剩余月数';

  @override
  String get liabilitiesMonth => '个月';

  @override
  String get liabilitiesPaidPercent => '已还';

  @override
  String get cashFlowTitle => '资金流';

  @override
  String get cashFlowPlannedTab => '预期收支';

  @override
  String get cashFlowHistoricalTab => '历史记录';

  @override
  String get cashFlowEmptyPlanned => '暂无预期收支';

  @override
  String get cashFlowEmptyHistorical => '暂无历史记录';

  @override
  String get cashFlowAddRecord => '添加记录';

  @override
  String get cashFlowEditRecord => '编辑记录';

  @override
  String get cashFlowSaveRecord => '保存修改';

  @override
  String get cashFlowIncome => '收入';

  @override
  String get cashFlowExpense => '支出';

  @override
  String get cashFlowCategory => '分类';

  @override
  String get cashFlowAmount => '金额';

  @override
  String get cashFlowEnterAmount => '请输入金额';

  @override
  String get cashFlowDescription => '描述';

  @override
  String get cashFlowEnterDescription => '请输入描述（选填）';

  @override
  String get cashFlowFrequency => '频率';

  @override
  String get cashFlowSelectDate => '选择日期';

  @override
  String get cashFlowStartDate => '开始日期';

  @override
  String get cashFlowEndDate => '结束日期';

  @override
  String get cashFlowSummary => '收支汇总';

  @override
  String get cashFlowTotalIncome => '总收入';

  @override
  String get cashFlowTotalExpense => '总支出';

  @override
  String cashFlowDeleteConfirm(String type) {
    return '确定要删除这条$type记录吗？';
  }

  @override
  String get assetTypesTitle => '资产类型管理';

  @override
  String get assetTypesAddType => '添加类型';

  @override
  String get assetTypesEditType => '编辑类型';

  @override
  String get assetTypesTypeName => '类型名称';

  @override
  String get assetTypesEnterName => '请输入类型名称';

  @override
  String get assetTypesCategory => '分类';

  @override
  String get assetTypesDescription => '描述';

  @override
  String get assetTypesDepreciation => '折旧';

  @override
  String get assetTypesDepreciationRate => '折旧率(%)';

  @override
  String get assetTypesDeleteConfirm => '确定要删除此资产类型吗？';

  @override
  String get assetTypesFixedAssets => '固定资产';

  @override
  String get assetTypesLiquidAssets => '流动资产';

  @override
  String get assetTypesConsumerGoods => '消费品';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsUserInfo => '用户信息';

  @override
  String get settingsUsername => '用户名';

  @override
  String get settingsPhone => '手机号';

  @override
  String get settingsEmail => '邮箱';

  @override
  String get settingsSaveSuccess => '保存成功';

  @override
  String get settingsLanguage => '语言 / Language';

  @override
  String get settingsSelectLanguage => '选择语言';

  @override
  String get settingsDataManagement => '数据管理';

  @override
  String get settingsExportData => '导出数据';

  @override
  String get settingsExportHint => '导出所有数据为 JSON 文件';

  @override
  String get settingsExportFailed => '导出失败';

  @override
  String get settingsClearData => '清除数据';

  @override
  String get settingsClearHint => '清除所有数据（不可恢复）';

  @override
  String get settingsDangerWarning => '⚠️ 危险操作';

  @override
  String get settingsConfirmClear => '确定要清除所有数据吗？此操作不可恢复！';

  @override
  String get settingsConfirmClearBtn => '确认清除';

  @override
  String get settingsDataCleared => '数据已清除';

  @override
  String get settingsDefaultUser => '默认用户';

  @override
  String get aboutTitle => '关于';

  @override
  String get aboutAppIntro => '应用简介';

  @override
  String get aboutAppDescription =>
      '聚财是一款个人资产组合管理应用，帮助您全面掌控财务状况。支持多类型资产管理（固定资产、流动资产、消费品）、负债追踪、收支流水记录，并通过直观的图表展示您的资产分布、收益率和月度趋势。让理财变得简单透明。';

  @override
  String get aboutVersion => '版本';

  @override
  String get aboutPlatform => '平台';

  @override
  String get aboutPlatformDesc => 'Android / iOS';

  @override
  String get aboutStorage => '存储';

  @override
  String get aboutStorageDesc => '本地 SQLite 数据库';

  @override
  String get aboutFramework => '框架';

  @override
  String get aboutFrameworkDesc => 'Flutter';

  @override
  String get aboutCopyright => '© 2024 聚财团队';

  @override
  String get categoryFixedAssets => '固定资产';

  @override
  String get categoryLiquidAssets => '流动资产';

  @override
  String get categoryConsumerGoods => '消费品';

  @override
  String get categoryMortgage => '房贷';

  @override
  String get categoryCarLoan => '车贷';

  @override
  String get categoryCreditCard => '信用卡';

  @override
  String get categoryOther => '其他';

  @override
  String get frequencyOnce => '一次性';

  @override
  String get frequencyDaily => '每天';

  @override
  String get frequencyWeekly => '每周';

  @override
  String get frequencyMonthly => '每月';

  @override
  String get frequencyQuarterly => '每季度';

  @override
  String get frequencyYearly => '每年';

  @override
  String get incomeSalary => '工资';

  @override
  String get incomeBonus => '奖金';

  @override
  String get incomeRent => '租金收入';

  @override
  String get incomeInvestment => '投资收益';

  @override
  String get incomePartTime => '兼职';

  @override
  String get incomeBusiness => '经营收入';

  @override
  String get incomeOther => '其他收入';

  @override
  String get expenseHousing => '住房';

  @override
  String get expenseFood => '餐饮';

  @override
  String get expenseTransport => '交通';

  @override
  String get expenseUtilities => '水电';

  @override
  String get expenseMedical => '医疗';

  @override
  String get expenseEducation => '教育';

  @override
  String get expenseEntertainment => '娱乐';

  @override
  String get expenseShopping => '购物';

  @override
  String get expenseInsurance => '保险';

  @override
  String get expenseLoanRepayment => '还贷';

  @override
  String get expenseInvestment => '投资';

  @override
  String get expenseOther => '其他支出';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class SZhTw extends SZh {
  SZhTw() : super('zh_TW');

  @override
  String get appName => '聚財';

  @override
  String get currencyYuan => '元';

  @override
  String get currencyHundredMillion => '億';

  @override
  String get currencyTenMillion => '千萬';

  @override
  String get currencyOneMillion => '百萬';

  @override
  String get currencyTenThousand => '萬';

  @override
  String get btnSave => '儲存';

  @override
  String get btnCancel => '取消';

  @override
  String get btnDelete => '刪除';

  @override
  String get btnAdd => '新增';

  @override
  String get btnEdit => '編輯';

  @override
  String get dialogConfirmDelete => '確認刪除';

  @override
  String get dialogConfirm => '確認';

  @override
  String get navHome => '首頁';

  @override
  String get navAssets => '資產';

  @override
  String get navLiabilities => '負債';

  @override
  String get navCashFlow => '資金流';

  @override
  String get menuAssetTypes => '資產類型';

  @override
  String get menuSettings => '設定';

  @override
  String get menuAbout => '關於';

  @override
  String get dashboardTitle => '財務總覽';

  @override
  String get dashboardTotalAssets => '總資產';

  @override
  String get dashboardTotalLiabilities => '總負債';

  @override
  String get dashboardNetWorth => '淨資產';

  @override
  String get dashboardMonthlySummary => '月度收支';

  @override
  String get dashboardIncome => '收入';

  @override
  String get dashboardExpense => '支出';

  @override
  String get dashboardNetAmount => '淨值';

  @override
  String get dashboardTrend12Months => '12個月趨勢';

  @override
  String get dashboardAssetDistribution => '資產分佈';

  @override
  String get dashboardAssetReturnRate => '資產收益率';

  @override
  String get dashboardNoData => '暫無資料';

  @override
  String get dashboardReturnRate => '收益率';

  @override
  String get assetsTitle => '我的資產';

  @override
  String get assetsEmpty => '暫無資產';

  @override
  String get assetsEmptyHint => '點擊右下角按鈕新增您的第一筆資產';

  @override
  String get assetsAddAsset => '新增資產';

  @override
  String get assetsEditAsset => '編輯資產';

  @override
  String get assetsDeleteConfirm => '確定要刪除這筆資產嗎？';

  @override
  String get assetsCurrentValue => '當前價值';

  @override
  String get assetsPurchaseValue => '購入價值';

  @override
  String get assetsReturnRate => '收益率';

  @override
  String get assetFormName => '資產名稱';

  @override
  String get assetFormEnterName => '請輸入資產名稱';

  @override
  String get assetFormType => '資產類型';

  @override
  String get assetFormSelectType => '請選擇資產類型';

  @override
  String get assetFormCurrentValue => '當前價值';

  @override
  String get assetFormEnterValue => '請輸入當前價值';

  @override
  String get assetFormPurchaseValue => '購入價值';

  @override
  String get assetFormPurchaseDate => '購入日期';

  @override
  String get assetFormSelectDate => '選擇日期';

  @override
  String get assetFormDescription => '描述';

  @override
  String get assetFormEnterDescription => '請輸入描述（選填）';

  @override
  String get liabilitiesTitle => '我的負債';

  @override
  String get liabilitiesEmpty => '暫無負債';

  @override
  String get liabilitiesEmptyHint => '點擊右下角按鈕新增您的第一筆負債';

  @override
  String get liabilitiesAddLiability => '新增負債';

  @override
  String get liabilitiesEditLiability => '編輯負債';

  @override
  String get liabilitiesDeleteConfirm => '確定要刪除這筆負債嗎？';

  @override
  String get liabilitiesName => '名稱';

  @override
  String get liabilitiesEnterName => '請輸入名稱';

  @override
  String get liabilitiesType => '類型';

  @override
  String get liabilitiesTotalAmount => '總額';

  @override
  String get liabilitiesEnterAmount => '請輸入總額';

  @override
  String get liabilitiesInterestRate => '利率(%)';

  @override
  String get liabilitiesMonthlyPayment => '月供';

  @override
  String get liabilitiesRemainingAmount => '剩餘金額';

  @override
  String get liabilitiesRemainingMonths => '剩餘月數';

  @override
  String get liabilitiesMonth => '個月';

  @override
  String get liabilitiesPaidPercent => '已還';

  @override
  String get cashFlowTitle => '資金流';

  @override
  String get cashFlowPlannedTab => '預期收支';

  @override
  String get cashFlowHistoricalTab => '歷史記錄';

  @override
  String get cashFlowEmptyPlanned => '暫無預期收支';

  @override
  String get cashFlowEmptyHistorical => '暫無歷史記錄';

  @override
  String get cashFlowAddRecord => '新增記錄';

  @override
  String get cashFlowEditRecord => '編輯記錄';

  @override
  String get cashFlowSaveRecord => '儲存修改';

  @override
  String get cashFlowIncome => '收入';

  @override
  String get cashFlowExpense => '支出';

  @override
  String get cashFlowCategory => '分類';

  @override
  String get cashFlowAmount => '金額';

  @override
  String get cashFlowEnterAmount => '請輸入金額';

  @override
  String get cashFlowDescription => '描述';

  @override
  String get cashFlowEnterDescription => '請輸入描述（選填）';

  @override
  String get cashFlowFrequency => '頻率';

  @override
  String get cashFlowSelectDate => '選擇日期';

  @override
  String get cashFlowStartDate => '開始日期';

  @override
  String get cashFlowEndDate => '結束日期';

  @override
  String get cashFlowSummary => '收支彙總';

  @override
  String get cashFlowTotalIncome => '總收入';

  @override
  String get cashFlowTotalExpense => '總支出';

  @override
  String cashFlowDeleteConfirm(String type) {
    return '確定要刪除這條$type記錄嗎？';
  }

  @override
  String get assetTypesTitle => '資產類型管理';

  @override
  String get assetTypesAddType => '新增類型';

  @override
  String get assetTypesEditType => '編輯類型';

  @override
  String get assetTypesTypeName => '類型名稱';

  @override
  String get assetTypesEnterName => '請輸入類型名稱';

  @override
  String get assetTypesCategory => '分類';

  @override
  String get assetTypesDescription => '描述';

  @override
  String get assetTypesDepreciation => '折舊';

  @override
  String get assetTypesDepreciationRate => '折舊率(%)';

  @override
  String get assetTypesDeleteConfirm => '確定要刪除此資產類型嗎？';

  @override
  String get assetTypesFixedAssets => '固定資產';

  @override
  String get assetTypesLiquidAssets => '流動資產';

  @override
  String get assetTypesConsumerGoods => '消費品';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsUserInfo => '使用者資訊';

  @override
  String get settingsUsername => '使用者名稱';

  @override
  String get settingsPhone => '手機號碼';

  @override
  String get settingsEmail => '電子郵件';

  @override
  String get settingsSaveSuccess => '儲存成功';

  @override
  String get settingsLanguage => '語言 / Language';

  @override
  String get settingsSelectLanguage => '選擇語言';

  @override
  String get settingsDataManagement => '資料管理';

  @override
  String get settingsExportData => '匯出資料';

  @override
  String get settingsExportHint => '匯出所有資料為 JSON 檔案';

  @override
  String get settingsExportFailed => '匯出失敗';

  @override
  String get settingsClearData => '清除資料';

  @override
  String get settingsClearHint => '清除所有資料（不可恢復）';

  @override
  String get settingsDangerWarning => '⚠️ 危險操作';

  @override
  String get settingsConfirmClear => '確定要清除所有資料嗎？此操作不可恢復！';

  @override
  String get settingsConfirmClearBtn => '確認清除';

  @override
  String get settingsDataCleared => '資料已清除';

  @override
  String get settingsDefaultUser => '預設使用者';

  @override
  String get aboutTitle => '關於';

  @override
  String get aboutAppIntro => '應用簡介';

  @override
  String get aboutAppDescription =>
      '聚財是一款個人資產組合管理應用，幫助您全面掌控財務狀況。支援多類型資產管理（固定資產、流動資產、消費品）、負債追蹤、收支流水記錄，並透過直觀的圖表展示您的資產分佈、收益率和月度趨勢。讓理財變得簡單透明。';

  @override
  String get aboutVersion => '版本';

  @override
  String get aboutPlatform => '平台';

  @override
  String get aboutPlatformDesc => 'Android / iOS';

  @override
  String get aboutStorage => '儲存';

  @override
  String get aboutStorageDesc => '本地 SQLite 資料庫';

  @override
  String get aboutFramework => '框架';

  @override
  String get aboutFrameworkDesc => 'Flutter';

  @override
  String get aboutCopyright => '© 2024 聚財團隊';

  @override
  String get categoryFixedAssets => '固定資產';

  @override
  String get categoryLiquidAssets => '流動資產';

  @override
  String get categoryConsumerGoods => '消費品';

  @override
  String get categoryMortgage => '房貸';

  @override
  String get categoryCarLoan => '車貸';

  @override
  String get categoryCreditCard => '信用卡';

  @override
  String get categoryOther => '其他';

  @override
  String get frequencyOnce => '一次性';

  @override
  String get frequencyDaily => '每天';

  @override
  String get frequencyWeekly => '每週';

  @override
  String get frequencyMonthly => '每月';

  @override
  String get frequencyQuarterly => '每季度';

  @override
  String get frequencyYearly => '每年';

  @override
  String get incomeSalary => '工資';

  @override
  String get incomeBonus => '獎金';

  @override
  String get incomeRent => '租金收入';

  @override
  String get incomeInvestment => '投資收益';

  @override
  String get incomePartTime => '兼職';

  @override
  String get incomeBusiness => '經營收入';

  @override
  String get incomeOther => '其他收入';

  @override
  String get expenseHousing => '住房';

  @override
  String get expenseFood => '餐飲';

  @override
  String get expenseTransport => '交通';

  @override
  String get expenseUtilities => '水電';

  @override
  String get expenseMedical => '醫療';

  @override
  String get expenseEducation => '教育';

  @override
  String get expenseEntertainment => '娛樂';

  @override
  String get expenseShopping => '購物';

  @override
  String get expenseInsurance => '保險';

  @override
  String get expenseLoanRepayment => '還貸';

  @override
  String get expenseInvestment => '投資';

  @override
  String get expenseOther => '其他支出';
}
