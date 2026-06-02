import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('en', 'US'),
    Locale('ja'),
    Locale('ja', 'JP'),
    Locale('zh'),
    Locale('zh', 'CN'),
    Locale('zh', 'TW'),
  ];

  /// No description provided for @appName.
  ///
  /// In zh_CN, this message translates to:
  /// **'聚财'**
  String get appName;

  /// No description provided for @currencyYuan.
  ///
  /// In zh_CN, this message translates to:
  /// **'元'**
  String get currencyYuan;

  /// No description provided for @currencyHundredMillion.
  ///
  /// In zh_CN, this message translates to:
  /// **'亿'**
  String get currencyHundredMillion;

  /// No description provided for @currencyTenMillion.
  ///
  /// In zh_CN, this message translates to:
  /// **'千万'**
  String get currencyTenMillion;

  /// No description provided for @currencyOneMillion.
  ///
  /// In zh_CN, this message translates to:
  /// **'百万'**
  String get currencyOneMillion;

  /// No description provided for @currencyTenThousand.
  ///
  /// In zh_CN, this message translates to:
  /// **'万'**
  String get currencyTenThousand;

  /// No description provided for @btnSave.
  ///
  /// In zh_CN, this message translates to:
  /// **'保存'**
  String get btnSave;

  /// No description provided for @btnCancel.
  ///
  /// In zh_CN, this message translates to:
  /// **'取消'**
  String get btnCancel;

  /// No description provided for @btnDelete.
  ///
  /// In zh_CN, this message translates to:
  /// **'删除'**
  String get btnDelete;

  /// No description provided for @btnAdd.
  ///
  /// In zh_CN, this message translates to:
  /// **'添加'**
  String get btnAdd;

  /// No description provided for @btnEdit.
  ///
  /// In zh_CN, this message translates to:
  /// **'编辑'**
  String get btnEdit;

  /// No description provided for @dialogConfirmDelete.
  ///
  /// In zh_CN, this message translates to:
  /// **'确认删除'**
  String get dialogConfirmDelete;

  /// No description provided for @dialogConfirm.
  ///
  /// In zh_CN, this message translates to:
  /// **'确认'**
  String get dialogConfirm;

  /// No description provided for @navHome.
  ///
  /// In zh_CN, this message translates to:
  /// **'首页'**
  String get navHome;

  /// No description provided for @navAssets.
  ///
  /// In zh_CN, this message translates to:
  /// **'资产'**
  String get navAssets;

  /// No description provided for @navLiabilities.
  ///
  /// In zh_CN, this message translates to:
  /// **'负债'**
  String get navLiabilities;

  /// No description provided for @navCashFlow.
  ///
  /// In zh_CN, this message translates to:
  /// **'资金流'**
  String get navCashFlow;

  /// No description provided for @menuAssetTypes.
  ///
  /// In zh_CN, this message translates to:
  /// **'资产类型'**
  String get menuAssetTypes;

  /// No description provided for @menuSettings.
  ///
  /// In zh_CN, this message translates to:
  /// **'设置'**
  String get menuSettings;

  /// No description provided for @menuAbout.
  ///
  /// In zh_CN, this message translates to:
  /// **'关于'**
  String get menuAbout;

  /// No description provided for @dashboardTitle.
  ///
  /// In zh_CN, this message translates to:
  /// **'财务总览'**
  String get dashboardTitle;

  /// No description provided for @dashboardTotalAssets.
  ///
  /// In zh_CN, this message translates to:
  /// **'总资产'**
  String get dashboardTotalAssets;

  /// No description provided for @dashboardTotalLiabilities.
  ///
  /// In zh_CN, this message translates to:
  /// **'总负债'**
  String get dashboardTotalLiabilities;

  /// No description provided for @dashboardNetWorth.
  ///
  /// In zh_CN, this message translates to:
  /// **'净资产'**
  String get dashboardNetWorth;

  /// No description provided for @dashboardMonthlySummary.
  ///
  /// In zh_CN, this message translates to:
  /// **'月度收支'**
  String get dashboardMonthlySummary;

  /// No description provided for @dashboardIncome.
  ///
  /// In zh_CN, this message translates to:
  /// **'收入'**
  String get dashboardIncome;

  /// No description provided for @dashboardExpense.
  ///
  /// In zh_CN, this message translates to:
  /// **'支出'**
  String get dashboardExpense;

  /// No description provided for @dashboardNetAmount.
  ///
  /// In zh_CN, this message translates to:
  /// **'净值'**
  String get dashboardNetAmount;

  /// No description provided for @dashboardTrend12Months.
  ///
  /// In zh_CN, this message translates to:
  /// **'12个月趋势'**
  String get dashboardTrend12Months;

  /// No description provided for @dashboardAssetDistribution.
  ///
  /// In zh_CN, this message translates to:
  /// **'资产分布'**
  String get dashboardAssetDistribution;

  /// No description provided for @dashboardAssetReturnRate.
  ///
  /// In zh_CN, this message translates to:
  /// **'资产收益率'**
  String get dashboardAssetReturnRate;

  /// No description provided for @dashboardNoData.
  ///
  /// In zh_CN, this message translates to:
  /// **'暂无数据'**
  String get dashboardNoData;

  /// No description provided for @dashboardReturnRate.
  ///
  /// In zh_CN, this message translates to:
  /// **'收益率'**
  String get dashboardReturnRate;

  /// No description provided for @assetsTitle.
  ///
  /// In zh_CN, this message translates to:
  /// **'我的资产'**
  String get assetsTitle;

  /// No description provided for @assetsEmpty.
  ///
  /// In zh_CN, this message translates to:
  /// **'暂无资产'**
  String get assetsEmpty;

  /// No description provided for @assetsEmptyHint.
  ///
  /// In zh_CN, this message translates to:
  /// **'点击右下角按钮添加您的第一笔资产'**
  String get assetsEmptyHint;

  /// No description provided for @assetsAddAsset.
  ///
  /// In zh_CN, this message translates to:
  /// **'添加资产'**
  String get assetsAddAsset;

  /// No description provided for @assetsEditAsset.
  ///
  /// In zh_CN, this message translates to:
  /// **'编辑资产'**
  String get assetsEditAsset;

  /// No description provided for @assetsDeleteConfirm.
  ///
  /// In zh_CN, this message translates to:
  /// **'确定要删除这笔资产吗？'**
  String get assetsDeleteConfirm;

  /// No description provided for @assetsCurrentValue.
  ///
  /// In zh_CN, this message translates to:
  /// **'当前价值'**
  String get assetsCurrentValue;

  /// No description provided for @assetsPurchaseValue.
  ///
  /// In zh_CN, this message translates to:
  /// **'购入价值'**
  String get assetsPurchaseValue;

  /// No description provided for @assetsReturnRate.
  ///
  /// In zh_CN, this message translates to:
  /// **'收益率'**
  String get assetsReturnRate;

  /// No description provided for @assetFormName.
  ///
  /// In zh_CN, this message translates to:
  /// **'资产名称'**
  String get assetFormName;

  /// No description provided for @assetFormEnterName.
  ///
  /// In zh_CN, this message translates to:
  /// **'请输入资产名称'**
  String get assetFormEnterName;

  /// No description provided for @assetFormType.
  ///
  /// In zh_CN, this message translates to:
  /// **'资产类型'**
  String get assetFormType;

  /// No description provided for @assetFormSelectType.
  ///
  /// In zh_CN, this message translates to:
  /// **'请选择资产类型'**
  String get assetFormSelectType;

  /// No description provided for @assetFormCurrentValue.
  ///
  /// In zh_CN, this message translates to:
  /// **'当前价值'**
  String get assetFormCurrentValue;

  /// No description provided for @assetFormEnterValue.
  ///
  /// In zh_CN, this message translates to:
  /// **'请输入当前价值'**
  String get assetFormEnterValue;

  /// No description provided for @assetFormPurchaseValue.
  ///
  /// In zh_CN, this message translates to:
  /// **'购入价值'**
  String get assetFormPurchaseValue;

  /// No description provided for @assetFormPurchaseDate.
  ///
  /// In zh_CN, this message translates to:
  /// **'购入日期'**
  String get assetFormPurchaseDate;

  /// No description provided for @assetFormSelectDate.
  ///
  /// In zh_CN, this message translates to:
  /// **'选择日期'**
  String get assetFormSelectDate;

  /// No description provided for @assetFormDescription.
  ///
  /// In zh_CN, this message translates to:
  /// **'描述'**
  String get assetFormDescription;

  /// No description provided for @assetFormEnterDescription.
  ///
  /// In zh_CN, this message translates to:
  /// **'请输入描述（选填）'**
  String get assetFormEnterDescription;

  /// No description provided for @liabilitiesTitle.
  ///
  /// In zh_CN, this message translates to:
  /// **'我的负债'**
  String get liabilitiesTitle;

  /// No description provided for @liabilitiesEmpty.
  ///
  /// In zh_CN, this message translates to:
  /// **'暂无负债'**
  String get liabilitiesEmpty;

  /// No description provided for @liabilitiesEmptyHint.
  ///
  /// In zh_CN, this message translates to:
  /// **'点击右下角按钮添加您的第一笔负债'**
  String get liabilitiesEmptyHint;

  /// No description provided for @liabilitiesAddLiability.
  ///
  /// In zh_CN, this message translates to:
  /// **'添加负债'**
  String get liabilitiesAddLiability;

  /// No description provided for @liabilitiesEditLiability.
  ///
  /// In zh_CN, this message translates to:
  /// **'编辑负债'**
  String get liabilitiesEditLiability;

  /// No description provided for @liabilitiesDeleteConfirm.
  ///
  /// In zh_CN, this message translates to:
  /// **'确定要删除这笔负债吗？'**
  String get liabilitiesDeleteConfirm;

  /// No description provided for @liabilitiesName.
  ///
  /// In zh_CN, this message translates to:
  /// **'名称'**
  String get liabilitiesName;

  /// No description provided for @liabilitiesEnterName.
  ///
  /// In zh_CN, this message translates to:
  /// **'请输入名称'**
  String get liabilitiesEnterName;

  /// No description provided for @liabilitiesType.
  ///
  /// In zh_CN, this message translates to:
  /// **'类型'**
  String get liabilitiesType;

  /// No description provided for @liabilitiesTotalAmount.
  ///
  /// In zh_CN, this message translates to:
  /// **'总额'**
  String get liabilitiesTotalAmount;

  /// No description provided for @liabilitiesEnterAmount.
  ///
  /// In zh_CN, this message translates to:
  /// **'请输入总额'**
  String get liabilitiesEnterAmount;

  /// No description provided for @liabilitiesInterestRate.
  ///
  /// In zh_CN, this message translates to:
  /// **'利率(%)'**
  String get liabilitiesInterestRate;

  /// No description provided for @liabilitiesMonthlyPayment.
  ///
  /// In zh_CN, this message translates to:
  /// **'月供'**
  String get liabilitiesMonthlyPayment;

  /// No description provided for @liabilitiesRemainingAmount.
  ///
  /// In zh_CN, this message translates to:
  /// **'剩余金额'**
  String get liabilitiesRemainingAmount;

  /// No description provided for @liabilitiesRemainingMonths.
  ///
  /// In zh_CN, this message translates to:
  /// **'剩余月数'**
  String get liabilitiesRemainingMonths;

  /// No description provided for @liabilitiesMonth.
  ///
  /// In zh_CN, this message translates to:
  /// **'个月'**
  String get liabilitiesMonth;

  /// No description provided for @liabilitiesPaidPercent.
  ///
  /// In zh_CN, this message translates to:
  /// **'已还'**
  String get liabilitiesPaidPercent;

  /// No description provided for @cashFlowTitle.
  ///
  /// In zh_CN, this message translates to:
  /// **'资金流'**
  String get cashFlowTitle;

  /// No description provided for @cashFlowPlannedTab.
  ///
  /// In zh_CN, this message translates to:
  /// **'预期收支'**
  String get cashFlowPlannedTab;

  /// No description provided for @cashFlowHistoricalTab.
  ///
  /// In zh_CN, this message translates to:
  /// **'历史记录'**
  String get cashFlowHistoricalTab;

  /// No description provided for @cashFlowEmptyPlanned.
  ///
  /// In zh_CN, this message translates to:
  /// **'暂无预期收支'**
  String get cashFlowEmptyPlanned;

  /// No description provided for @cashFlowEmptyHistorical.
  ///
  /// In zh_CN, this message translates to:
  /// **'暂无历史记录'**
  String get cashFlowEmptyHistorical;

  /// No description provided for @cashFlowAddRecord.
  ///
  /// In zh_CN, this message translates to:
  /// **'添加记录'**
  String get cashFlowAddRecord;

  /// No description provided for @cashFlowEditRecord.
  ///
  /// In zh_CN, this message translates to:
  /// **'编辑记录'**
  String get cashFlowEditRecord;

  /// No description provided for @cashFlowSaveRecord.
  ///
  /// In zh_CN, this message translates to:
  /// **'保存修改'**
  String get cashFlowSaveRecord;

  /// No description provided for @cashFlowIncome.
  ///
  /// In zh_CN, this message translates to:
  /// **'收入'**
  String get cashFlowIncome;

  /// No description provided for @cashFlowExpense.
  ///
  /// In zh_CN, this message translates to:
  /// **'支出'**
  String get cashFlowExpense;

  /// No description provided for @cashFlowCategory.
  ///
  /// In zh_CN, this message translates to:
  /// **'分类'**
  String get cashFlowCategory;

  /// No description provided for @cashFlowAmount.
  ///
  /// In zh_CN, this message translates to:
  /// **'金额'**
  String get cashFlowAmount;

  /// No description provided for @cashFlowEnterAmount.
  ///
  /// In zh_CN, this message translates to:
  /// **'请输入金额'**
  String get cashFlowEnterAmount;

  /// No description provided for @cashFlowDescription.
  ///
  /// In zh_CN, this message translates to:
  /// **'描述'**
  String get cashFlowDescription;

  /// No description provided for @cashFlowEnterDescription.
  ///
  /// In zh_CN, this message translates to:
  /// **'请输入描述（选填）'**
  String get cashFlowEnterDescription;

  /// No description provided for @cashFlowFrequency.
  ///
  /// In zh_CN, this message translates to:
  /// **'频率'**
  String get cashFlowFrequency;

  /// No description provided for @cashFlowSelectDate.
  ///
  /// In zh_CN, this message translates to:
  /// **'选择日期'**
  String get cashFlowSelectDate;

  /// No description provided for @cashFlowStartDate.
  ///
  /// In zh_CN, this message translates to:
  /// **'开始日期'**
  String get cashFlowStartDate;

  /// No description provided for @cashFlowEndDate.
  ///
  /// In zh_CN, this message translates to:
  /// **'结束日期'**
  String get cashFlowEndDate;

  /// No description provided for @cashFlowSummary.
  ///
  /// In zh_CN, this message translates to:
  /// **'收支汇总'**
  String get cashFlowSummary;

  /// No description provided for @cashFlowTotalIncome.
  ///
  /// In zh_CN, this message translates to:
  /// **'总收入'**
  String get cashFlowTotalIncome;

  /// No description provided for @cashFlowTotalExpense.
  ///
  /// In zh_CN, this message translates to:
  /// **'总支出'**
  String get cashFlowTotalExpense;

  /// No description provided for @cashFlowDeleteConfirm.
  ///
  /// In zh_CN, this message translates to:
  /// **'确定要删除这条{type}记录吗？'**
  String cashFlowDeleteConfirm(String type);

  /// No description provided for @assetTypesTitle.
  ///
  /// In zh_CN, this message translates to:
  /// **'资产类型管理'**
  String get assetTypesTitle;

  /// No description provided for @assetTypesAddType.
  ///
  /// In zh_CN, this message translates to:
  /// **'添加类型'**
  String get assetTypesAddType;

  /// No description provided for @assetTypesEditType.
  ///
  /// In zh_CN, this message translates to:
  /// **'编辑类型'**
  String get assetTypesEditType;

  /// No description provided for @assetTypesTypeName.
  ///
  /// In zh_CN, this message translates to:
  /// **'类型名称'**
  String get assetTypesTypeName;

  /// No description provided for @assetTypesEnterName.
  ///
  /// In zh_CN, this message translates to:
  /// **'请输入类型名称'**
  String get assetTypesEnterName;

  /// No description provided for @assetTypesCategory.
  ///
  /// In zh_CN, this message translates to:
  /// **'分类'**
  String get assetTypesCategory;

  /// No description provided for @assetTypesDescription.
  ///
  /// In zh_CN, this message translates to:
  /// **'描述'**
  String get assetTypesDescription;

  /// No description provided for @assetTypesDepreciation.
  ///
  /// In zh_CN, this message translates to:
  /// **'折旧'**
  String get assetTypesDepreciation;

  /// No description provided for @assetTypesDepreciationRate.
  ///
  /// In zh_CN, this message translates to:
  /// **'折旧率(%)'**
  String get assetTypesDepreciationRate;

  /// No description provided for @assetTypesDeleteConfirm.
  ///
  /// In zh_CN, this message translates to:
  /// **'确定要删除此资产类型吗？'**
  String get assetTypesDeleteConfirm;

  /// No description provided for @assetTypesFixedAssets.
  ///
  /// In zh_CN, this message translates to:
  /// **'固定资产'**
  String get assetTypesFixedAssets;

  /// No description provided for @assetTypesLiquidAssets.
  ///
  /// In zh_CN, this message translates to:
  /// **'流动资产'**
  String get assetTypesLiquidAssets;

  /// No description provided for @assetTypesConsumerGoods.
  ///
  /// In zh_CN, this message translates to:
  /// **'消费品'**
  String get assetTypesConsumerGoods;

  /// No description provided for @settingsTitle.
  ///
  /// In zh_CN, this message translates to:
  /// **'设置'**
  String get settingsTitle;

  /// No description provided for @settingsUserInfo.
  ///
  /// In zh_CN, this message translates to:
  /// **'用户信息'**
  String get settingsUserInfo;

  /// No description provided for @settingsUsername.
  ///
  /// In zh_CN, this message translates to:
  /// **'用户名'**
  String get settingsUsername;

  /// No description provided for @settingsPhone.
  ///
  /// In zh_CN, this message translates to:
  /// **'手机号'**
  String get settingsPhone;

  /// No description provided for @settingsEmail.
  ///
  /// In zh_CN, this message translates to:
  /// **'邮箱'**
  String get settingsEmail;

  /// No description provided for @settingsSaveSuccess.
  ///
  /// In zh_CN, this message translates to:
  /// **'保存成功'**
  String get settingsSaveSuccess;

  /// No description provided for @settingsLanguage.
  ///
  /// In zh_CN, this message translates to:
  /// **'语言 / Language'**
  String get settingsLanguage;

  /// No description provided for @settingsSelectLanguage.
  ///
  /// In zh_CN, this message translates to:
  /// **'选择语言'**
  String get settingsSelectLanguage;

  /// No description provided for @settingsDataManagement.
  ///
  /// In zh_CN, this message translates to:
  /// **'数据管理'**
  String get settingsDataManagement;

  /// No description provided for @settingsExportData.
  ///
  /// In zh_CN, this message translates to:
  /// **'导出数据'**
  String get settingsExportData;

  /// No description provided for @settingsExportHint.
  ///
  /// In zh_CN, this message translates to:
  /// **'导出所有数据为 JSON 文件'**
  String get settingsExportHint;

  /// No description provided for @settingsExportFailed.
  ///
  /// In zh_CN, this message translates to:
  /// **'导出失败'**
  String get settingsExportFailed;

  /// No description provided for @settingsClearData.
  ///
  /// In zh_CN, this message translates to:
  /// **'清除数据'**
  String get settingsClearData;

  /// No description provided for @settingsClearHint.
  ///
  /// In zh_CN, this message translates to:
  /// **'清除所有数据（不可恢复）'**
  String get settingsClearHint;

  /// No description provided for @settingsDangerWarning.
  ///
  /// In zh_CN, this message translates to:
  /// **'⚠️ 危险操作'**
  String get settingsDangerWarning;

  /// No description provided for @settingsConfirmClear.
  ///
  /// In zh_CN, this message translates to:
  /// **'确定要清除所有数据吗？此操作不可恢复！'**
  String get settingsConfirmClear;

  /// No description provided for @settingsConfirmClearBtn.
  ///
  /// In zh_CN, this message translates to:
  /// **'确认清除'**
  String get settingsConfirmClearBtn;

  /// No description provided for @settingsDataCleared.
  ///
  /// In zh_CN, this message translates to:
  /// **'数据已清除'**
  String get settingsDataCleared;

  /// No description provided for @settingsDefaultUser.
  ///
  /// In zh_CN, this message translates to:
  /// **'默认用户'**
  String get settingsDefaultUser;

  /// No description provided for @aboutTitle.
  ///
  /// In zh_CN, this message translates to:
  /// **'关于'**
  String get aboutTitle;

  /// No description provided for @aboutAppIntro.
  ///
  /// In zh_CN, this message translates to:
  /// **'应用简介'**
  String get aboutAppIntro;

  /// No description provided for @aboutAppDescription.
  ///
  /// In zh_CN, this message translates to:
  /// **'聚财是一款个人资产组合管理应用，帮助您全面掌控财务状况。支持多类型资产管理（固定资产、流动资产、消费品）、负债追踪、收支流水记录，并通过直观的图表展示您的资产分布、收益率和月度趋势。让理财变得简单透明。'**
  String get aboutAppDescription;

  /// No description provided for @aboutVersion.
  ///
  /// In zh_CN, this message translates to:
  /// **'版本'**
  String get aboutVersion;

  /// No description provided for @aboutPlatform.
  ///
  /// In zh_CN, this message translates to:
  /// **'平台'**
  String get aboutPlatform;

  /// No description provided for @aboutPlatformDesc.
  ///
  /// In zh_CN, this message translates to:
  /// **'Android / iOS'**
  String get aboutPlatformDesc;

  /// No description provided for @aboutStorage.
  ///
  /// In zh_CN, this message translates to:
  /// **'存储'**
  String get aboutStorage;

  /// No description provided for @aboutStorageDesc.
  ///
  /// In zh_CN, this message translates to:
  /// **'本地 SQLite 数据库'**
  String get aboutStorageDesc;

  /// No description provided for @aboutFramework.
  ///
  /// In zh_CN, this message translates to:
  /// **'框架'**
  String get aboutFramework;

  /// No description provided for @aboutFrameworkDesc.
  ///
  /// In zh_CN, this message translates to:
  /// **'Flutter'**
  String get aboutFrameworkDesc;

  /// No description provided for @aboutCopyright.
  ///
  /// In zh_CN, this message translates to:
  /// **'© 2024 聚财团队'**
  String get aboutCopyright;

  /// No description provided for @categoryFixedAssets.
  ///
  /// In zh_CN, this message translates to:
  /// **'固定资产'**
  String get categoryFixedAssets;

  /// No description provided for @categoryLiquidAssets.
  ///
  /// In zh_CN, this message translates to:
  /// **'流动资产'**
  String get categoryLiquidAssets;

  /// No description provided for @categoryConsumerGoods.
  ///
  /// In zh_CN, this message translates to:
  /// **'消费品'**
  String get categoryConsumerGoods;

  /// No description provided for @categoryMortgage.
  ///
  /// In zh_CN, this message translates to:
  /// **'房贷'**
  String get categoryMortgage;

  /// No description provided for @categoryCarLoan.
  ///
  /// In zh_CN, this message translates to:
  /// **'车贷'**
  String get categoryCarLoan;

  /// No description provided for @categoryCreditCard.
  ///
  /// In zh_CN, this message translates to:
  /// **'信用卡'**
  String get categoryCreditCard;

  /// No description provided for @categoryOther.
  ///
  /// In zh_CN, this message translates to:
  /// **'其他'**
  String get categoryOther;

  /// No description provided for @frequencyOnce.
  ///
  /// In zh_CN, this message translates to:
  /// **'一次性'**
  String get frequencyOnce;

  /// No description provided for @frequencyDaily.
  ///
  /// In zh_CN, this message translates to:
  /// **'每天'**
  String get frequencyDaily;

  /// No description provided for @frequencyWeekly.
  ///
  /// In zh_CN, this message translates to:
  /// **'每周'**
  String get frequencyWeekly;

  /// No description provided for @frequencyMonthly.
  ///
  /// In zh_CN, this message translates to:
  /// **'每月'**
  String get frequencyMonthly;

  /// No description provided for @frequencyQuarterly.
  ///
  /// In zh_CN, this message translates to:
  /// **'每季度'**
  String get frequencyQuarterly;

  /// No description provided for @frequencyYearly.
  ///
  /// In zh_CN, this message translates to:
  /// **'每年'**
  String get frequencyYearly;

  /// No description provided for @incomeSalary.
  ///
  /// In zh_CN, this message translates to:
  /// **'工资'**
  String get incomeSalary;

  /// No description provided for @incomeBonus.
  ///
  /// In zh_CN, this message translates to:
  /// **'奖金'**
  String get incomeBonus;

  /// No description provided for @incomeRent.
  ///
  /// In zh_CN, this message translates to:
  /// **'租金收入'**
  String get incomeRent;

  /// No description provided for @incomeInvestment.
  ///
  /// In zh_CN, this message translates to:
  /// **'投资收益'**
  String get incomeInvestment;

  /// No description provided for @incomePartTime.
  ///
  /// In zh_CN, this message translates to:
  /// **'兼职'**
  String get incomePartTime;

  /// No description provided for @incomeBusiness.
  ///
  /// In zh_CN, this message translates to:
  /// **'经营收入'**
  String get incomeBusiness;

  /// No description provided for @incomeOther.
  ///
  /// In zh_CN, this message translates to:
  /// **'其他收入'**
  String get incomeOther;

  /// No description provided for @expenseHousing.
  ///
  /// In zh_CN, this message translates to:
  /// **'住房'**
  String get expenseHousing;

  /// No description provided for @expenseFood.
  ///
  /// In zh_CN, this message translates to:
  /// **'餐饮'**
  String get expenseFood;

  /// No description provided for @expenseTransport.
  ///
  /// In zh_CN, this message translates to:
  /// **'交通'**
  String get expenseTransport;

  /// No description provided for @expenseUtilities.
  ///
  /// In zh_CN, this message translates to:
  /// **'水电'**
  String get expenseUtilities;

  /// No description provided for @expenseMedical.
  ///
  /// In zh_CN, this message translates to:
  /// **'医疗'**
  String get expenseMedical;

  /// No description provided for @expenseEducation.
  ///
  /// In zh_CN, this message translates to:
  /// **'教育'**
  String get expenseEducation;

  /// No description provided for @expenseEntertainment.
  ///
  /// In zh_CN, this message translates to:
  /// **'娱乐'**
  String get expenseEntertainment;

  /// No description provided for @expenseShopping.
  ///
  /// In zh_CN, this message translates to:
  /// **'购物'**
  String get expenseShopping;

  /// No description provided for @expenseInsurance.
  ///
  /// In zh_CN, this message translates to:
  /// **'保险'**
  String get expenseInsurance;

  /// No description provided for @expenseLoanRepayment.
  ///
  /// In zh_CN, this message translates to:
  /// **'还贷'**
  String get expenseLoanRepayment;

  /// No description provided for @expenseInvestment.
  ///
  /// In zh_CN, this message translates to:
  /// **'投资'**
  String get expenseInvestment;

  /// No description provided for @expenseOther.
  ///
  /// In zh_CN, this message translates to:
  /// **'其他支出'**
  String get expenseOther;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'en':
      {
        switch (locale.countryCode) {
          case 'US':
            return SEnUs();
        }
        break;
      }
    case 'ja':
      {
        switch (locale.countryCode) {
          case 'JP':
            return SJaJp();
        }
        break;
      }
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return SZhCn();
          case 'TW':
            return SZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return SEn();
    case 'ja':
      return SJa();
    case 'zh':
      return SZh();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
