// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'JuCai';

  @override
  String get currencyYuan => 'CNY';

  @override
  String get currencyHundredMillion => 'B';

  @override
  String get currencyTenMillion => 'M';

  @override
  String get currencyOneMillion => 'M';

  @override
  String get currencyTenThousand => 'K';

  @override
  String get btnSave => 'Save';

  @override
  String get btnCancel => 'Cancel';

  @override
  String get btnDelete => 'Delete';

  @override
  String get btnAdd => 'Add';

  @override
  String get btnEdit => 'Edit';

  @override
  String get dialogConfirmDelete => 'Confirm Delete';

  @override
  String get dialogConfirm => 'Confirm';

  @override
  String get navHome => 'Home';

  @override
  String get navAssets => 'Assets';

  @override
  String get navLiabilities => 'Liabilities';

  @override
  String get navCashFlow => 'Cash Flow';

  @override
  String get menuAssetTypes => 'Asset Types';

  @override
  String get menuSettings => 'Settings';

  @override
  String get menuAbout => 'About';

  @override
  String get dashboardTitle => 'Financial Overview';

  @override
  String get dashboardTotalAssets => 'Total Assets';

  @override
  String get dashboardTotalLiabilities => 'Total Liabilities';

  @override
  String get dashboardNetWorth => 'Net Worth';

  @override
  String get dashboardMonthlySummary => 'Monthly Summary';

  @override
  String get dashboardIncome => 'Income';

  @override
  String get dashboardExpense => 'Expense';

  @override
  String get dashboardNetAmount => 'Net';

  @override
  String get dashboardTrend12Months => '12-Month Trend';

  @override
  String get dashboardAssetDistribution => 'Asset Distribution';

  @override
  String get dashboardAssetReturnRate => 'Asset Return Rate';

  @override
  String get dashboardNoData => 'No Data';

  @override
  String get dashboardReturnRate => 'Return Rate';

  @override
  String get assetsTitle => 'My Assets';

  @override
  String get assetsEmpty => 'No Assets Yet';

  @override
  String get assetsEmptyHint => 'Tap the button below to add your first asset';

  @override
  String get assetsAddAsset => 'Add Asset';

  @override
  String get assetsEditAsset => 'Edit Asset';

  @override
  String get assetsDeleteConfirm =>
      'Are you sure you want to delete this asset?';

  @override
  String get assetsCurrentValue => 'Current Value';

  @override
  String get assetsPurchaseValue => 'Purchase Value';

  @override
  String get assetsReturnRate => 'Return Rate';

  @override
  String get assetFormName => 'Asset Name';

  @override
  String get assetFormEnterName => 'Enter asset name';

  @override
  String get assetFormType => 'Asset Type';

  @override
  String get assetFormSelectType => 'Select asset type';

  @override
  String get assetFormCurrentValue => 'Current Value';

  @override
  String get assetFormEnterValue => 'Enter current value';

  @override
  String get assetFormPurchaseValue => 'Purchase Value';

  @override
  String get assetFormPurchaseDate => 'Purchase Date';

  @override
  String get assetFormSelectDate => 'Select Date';

  @override
  String get assetFormDescription => 'Description';

  @override
  String get assetFormEnterDescription => 'Enter description (optional)';

  @override
  String get liabilitiesTitle => 'My Liabilities';

  @override
  String get liabilitiesEmpty => 'No Liabilities Yet';

  @override
  String get liabilitiesEmptyHint =>
      'Tap the button below to add your first liability';

  @override
  String get liabilitiesAddLiability => 'Add Liability';

  @override
  String get liabilitiesEditLiability => 'Edit Liability';

  @override
  String get liabilitiesDeleteConfirm =>
      'Are you sure you want to delete this liability?';

  @override
  String get liabilitiesName => 'Name';

  @override
  String get liabilitiesEnterName => 'Enter name';

  @override
  String get liabilitiesType => 'Type';

  @override
  String get liabilitiesTotalAmount => 'Total Amount';

  @override
  String get liabilitiesEnterAmount => 'Enter total amount';

  @override
  String get liabilitiesInterestRate => 'Interest Rate(%)';

  @override
  String get liabilitiesMonthlyPayment => 'Monthly Payment';

  @override
  String get liabilitiesRemainingAmount => 'Remaining Amount';

  @override
  String get liabilitiesRemainingMonths => 'Remaining Months';

  @override
  String get liabilitiesMonth => 'months';

  @override
  String get liabilitiesPaidPercent => 'Paid';

  @override
  String get cashFlowTitle => 'Cash Flow';

  @override
  String get cashFlowPlannedTab => 'Planned';

  @override
  String get cashFlowHistoricalTab => 'History';

  @override
  String get cashFlowEmptyPlanned => 'No Planned Items';

  @override
  String get cashFlowEmptyHistorical => 'No History Yet';

  @override
  String get cashFlowAddRecord => 'Add Record';

  @override
  String get cashFlowEditRecord => 'Edit Record';

  @override
  String get cashFlowSaveRecord => 'Save Changes';

  @override
  String get cashFlowIncome => 'Income';

  @override
  String get cashFlowExpense => 'Expense';

  @override
  String get cashFlowCategory => 'Category';

  @override
  String get cashFlowAmount => 'Amount';

  @override
  String get cashFlowEnterAmount => 'Enter amount';

  @override
  String get cashFlowDescription => 'Description';

  @override
  String get cashFlowEnterDescription => 'Enter description (optional)';

  @override
  String get cashFlowFrequency => 'Frequency';

  @override
  String get cashFlowSelectDate => 'Select Date';

  @override
  String get cashFlowStartDate => 'Start Date';

  @override
  String get cashFlowEndDate => 'End Date';

  @override
  String get cashFlowSummary => 'Summary';

  @override
  String get cashFlowTotalIncome => 'Total Income';

  @override
  String get cashFlowTotalExpense => 'Total Expense';

  @override
  String cashFlowDeleteConfirm(String type) {
    return 'Are you sure you want to delete this $type record?';
  }

  @override
  String get assetTypesTitle => 'Asset Types';

  @override
  String get assetTypesAddType => 'Add Type';

  @override
  String get assetTypesEditType => 'Edit Type';

  @override
  String get assetTypesTypeName => 'Type Name';

  @override
  String get assetTypesEnterName => 'Enter type name';

  @override
  String get assetTypesCategory => 'Category';

  @override
  String get assetTypesDescription => 'Description';

  @override
  String get assetTypesDepreciation => 'Depreciation';

  @override
  String get assetTypesDepreciationRate => 'Depreciation Rate(%)';

  @override
  String get assetTypesDeleteConfirm =>
      'Are you sure you want to delete this asset type?';

  @override
  String get assetTypesFixedAssets => 'Fixed Assets';

  @override
  String get assetTypesLiquidAssets => 'Liquid Assets';

  @override
  String get assetTypesConsumerGoods => 'Consumer Goods';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsUserInfo => 'User Info';

  @override
  String get settingsUsername => 'Username';

  @override
  String get settingsPhone => 'Phone';

  @override
  String get settingsEmail => 'Email';

  @override
  String get settingsSaveSuccess => 'Saved successfully';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsSelectLanguage => 'Select Language';

  @override
  String get settingsDataManagement => 'Data Management';

  @override
  String get settingsExportData => 'Export Data';

  @override
  String get settingsExportHint => 'Export all data as JSON file';

  @override
  String get settingsExportFailed => 'Export failed';

  @override
  String get settingsClearData => 'Clear Data';

  @override
  String get settingsClearHint => 'Clear all data (irreversible)';

  @override
  String get settingsDangerWarning => '⚠️ Danger';

  @override
  String get settingsConfirmClear =>
      'Are you sure you want to clear all data? This cannot be undone!';

  @override
  String get settingsConfirmClearBtn => 'Confirm Clear';

  @override
  String get settingsDataCleared => 'Data cleared';

  @override
  String get settingsDefaultUser => 'Default User';

  @override
  String get aboutTitle => 'About';

  @override
  String get aboutAppIntro => 'About App';

  @override
  String get aboutAppDescription =>
      'JuCai is a personal asset portfolio management app that helps you take full control of your finances. It supports multi-type asset management (fixed assets, liquid assets, consumer goods), liability tracking, income & expense recording, and displays your asset distribution, return rates, and monthly trends through intuitive charts. Making personal finance simple and transparent.';

  @override
  String get aboutVersion => 'Version';

  @override
  String get aboutPlatform => 'Platform';

  @override
  String get aboutPlatformDesc => 'Android / iOS';

  @override
  String get aboutStorage => 'Storage';

  @override
  String get aboutStorageDesc => 'Local SQLite Database';

  @override
  String get aboutFramework => 'Framework';

  @override
  String get aboutFrameworkDesc => 'Flutter';

  @override
  String get aboutCopyright => '© 2024 JuCai Team';

  @override
  String get categoryFixedAssets => 'Fixed Assets';

  @override
  String get categoryLiquidAssets => 'Liquid Assets';

  @override
  String get categoryConsumerGoods => 'Consumer Goods';

  @override
  String get categoryMortgage => 'Mortgage';

  @override
  String get categoryCarLoan => 'Car Loan';

  @override
  String get categoryCreditCard => 'Credit Card';

  @override
  String get categoryOther => 'Other';

  @override
  String get frequencyOnce => 'One-time';

  @override
  String get frequencyDaily => 'Daily';

  @override
  String get frequencyWeekly => 'Weekly';

  @override
  String get frequencyMonthly => 'Monthly';

  @override
  String get frequencyQuarterly => 'Quarterly';

  @override
  String get frequencyYearly => 'Yearly';

  @override
  String get incomeSalary => 'Salary';

  @override
  String get incomeBonus => 'Bonus';

  @override
  String get incomeRent => 'Rental Income';

  @override
  String get incomeInvestment => 'Investment Return';

  @override
  String get incomePartTime => 'Part-time';

  @override
  String get incomeBusiness => 'Business Income';

  @override
  String get incomeOther => 'Other Income';

  @override
  String get expenseHousing => 'Housing';

  @override
  String get expenseFood => 'Food & Dining';

  @override
  String get expenseTransport => 'Transportation';

  @override
  String get expenseUtilities => 'Utilities';

  @override
  String get expenseMedical => 'Healthcare';

  @override
  String get expenseEducation => 'Education';

  @override
  String get expenseEntertainment => 'Entertainment';

  @override
  String get expenseShopping => 'Shopping';

  @override
  String get expenseInsurance => 'Insurance';

  @override
  String get expenseLoanRepayment => 'Loan Payment';

  @override
  String get expenseInvestment => 'Investment';

  @override
  String get expenseOther => 'Other Expense';
}

/// The translations for English, as used in the United States (`en_US`).
class SEnUs extends SEn {
  SEnUs() : super('en_US');

  @override
  String get appName => 'JuCai';

  @override
  String get currencyYuan => 'CNY';

  @override
  String get currencyHundredMillion => 'B';

  @override
  String get currencyTenMillion => 'M';

  @override
  String get currencyOneMillion => 'M';

  @override
  String get currencyTenThousand => 'K';

  @override
  String get btnSave => 'Save';

  @override
  String get btnCancel => 'Cancel';

  @override
  String get btnDelete => 'Delete';

  @override
  String get btnAdd => 'Add';

  @override
  String get btnEdit => 'Edit';

  @override
  String get dialogConfirmDelete => 'Confirm Delete';

  @override
  String get dialogConfirm => 'Confirm';

  @override
  String get navHome => 'Home';

  @override
  String get navAssets => 'Assets';

  @override
  String get navLiabilities => 'Liabilities';

  @override
  String get navCashFlow => 'Cash Flow';

  @override
  String get menuAssetTypes => 'Asset Types';

  @override
  String get menuSettings => 'Settings';

  @override
  String get menuAbout => 'About';

  @override
  String get dashboardTitle => 'Financial Overview';

  @override
  String get dashboardTotalAssets => 'Total Assets';

  @override
  String get dashboardTotalLiabilities => 'Total Liabilities';

  @override
  String get dashboardNetWorth => 'Net Worth';

  @override
  String get dashboardMonthlySummary => 'Monthly Summary';

  @override
  String get dashboardIncome => 'Income';

  @override
  String get dashboardExpense => 'Expense';

  @override
  String get dashboardNetAmount => 'Net';

  @override
  String get dashboardTrend12Months => '12-Month Trend';

  @override
  String get dashboardAssetDistribution => 'Asset Distribution';

  @override
  String get dashboardAssetReturnRate => 'Asset Return Rate';

  @override
  String get dashboardNoData => 'No Data';

  @override
  String get dashboardReturnRate => 'Return Rate';

  @override
  String get assetsTitle => 'My Assets';

  @override
  String get assetsEmpty => 'No Assets Yet';

  @override
  String get assetsEmptyHint => 'Tap the button below to add your first asset';

  @override
  String get assetsAddAsset => 'Add Asset';

  @override
  String get assetsEditAsset => 'Edit Asset';

  @override
  String get assetsDeleteConfirm =>
      'Are you sure you want to delete this asset?';

  @override
  String get assetsCurrentValue => 'Current Value';

  @override
  String get assetsPurchaseValue => 'Purchase Value';

  @override
  String get assetsReturnRate => 'Return Rate';

  @override
  String get assetFormName => 'Asset Name';

  @override
  String get assetFormEnterName => 'Enter asset name';

  @override
  String get assetFormType => 'Asset Type';

  @override
  String get assetFormSelectType => 'Select asset type';

  @override
  String get assetFormCurrentValue => 'Current Value';

  @override
  String get assetFormEnterValue => 'Enter current value';

  @override
  String get assetFormPurchaseValue => 'Purchase Value';

  @override
  String get assetFormPurchaseDate => 'Purchase Date';

  @override
  String get assetFormSelectDate => 'Select Date';

  @override
  String get assetFormDescription => 'Description';

  @override
  String get assetFormEnterDescription => 'Enter description (optional)';

  @override
  String get liabilitiesTitle => 'My Liabilities';

  @override
  String get liabilitiesEmpty => 'No Liabilities Yet';

  @override
  String get liabilitiesEmptyHint =>
      'Tap the button below to add your first liability';

  @override
  String get liabilitiesAddLiability => 'Add Liability';

  @override
  String get liabilitiesEditLiability => 'Edit Liability';

  @override
  String get liabilitiesDeleteConfirm =>
      'Are you sure you want to delete this liability?';

  @override
  String get liabilitiesName => 'Name';

  @override
  String get liabilitiesEnterName => 'Enter name';

  @override
  String get liabilitiesType => 'Type';

  @override
  String get liabilitiesTotalAmount => 'Total Amount';

  @override
  String get liabilitiesEnterAmount => 'Enter total amount';

  @override
  String get liabilitiesInterestRate => 'Interest Rate(%)';

  @override
  String get liabilitiesMonthlyPayment => 'Monthly Payment';

  @override
  String get liabilitiesRemainingAmount => 'Remaining Amount';

  @override
  String get liabilitiesRemainingMonths => 'Remaining Months';

  @override
  String get liabilitiesMonth => 'months';

  @override
  String get liabilitiesPaidPercent => 'Paid';

  @override
  String get cashFlowTitle => 'Cash Flow';

  @override
  String get cashFlowPlannedTab => 'Planned';

  @override
  String get cashFlowHistoricalTab => 'History';

  @override
  String get cashFlowEmptyPlanned => 'No Planned Items';

  @override
  String get cashFlowEmptyHistorical => 'No History Yet';

  @override
  String get cashFlowAddRecord => 'Add Record';

  @override
  String get cashFlowEditRecord => 'Edit Record';

  @override
  String get cashFlowSaveRecord => 'Save Changes';

  @override
  String get cashFlowIncome => 'Income';

  @override
  String get cashFlowExpense => 'Expense';

  @override
  String get cashFlowCategory => 'Category';

  @override
  String get cashFlowAmount => 'Amount';

  @override
  String get cashFlowEnterAmount => 'Enter amount';

  @override
  String get cashFlowDescription => 'Description';

  @override
  String get cashFlowEnterDescription => 'Enter description (optional)';

  @override
  String get cashFlowFrequency => 'Frequency';

  @override
  String get cashFlowSelectDate => 'Select Date';

  @override
  String get cashFlowStartDate => 'Start Date';

  @override
  String get cashFlowEndDate => 'End Date';

  @override
  String get cashFlowSummary => 'Summary';

  @override
  String get cashFlowTotalIncome => 'Total Income';

  @override
  String get cashFlowTotalExpense => 'Total Expense';

  @override
  String cashFlowDeleteConfirm(String type) {
    return 'Are you sure you want to delete this $type record?';
  }

  @override
  String get assetTypesTitle => 'Asset Types';

  @override
  String get assetTypesAddType => 'Add Type';

  @override
  String get assetTypesEditType => 'Edit Type';

  @override
  String get assetTypesTypeName => 'Type Name';

  @override
  String get assetTypesEnterName => 'Enter type name';

  @override
  String get assetTypesCategory => 'Category';

  @override
  String get assetTypesDescription => 'Description';

  @override
  String get assetTypesDepreciation => 'Depreciation';

  @override
  String get assetTypesDepreciationRate => 'Depreciation Rate(%)';

  @override
  String get assetTypesDeleteConfirm =>
      'Are you sure you want to delete this asset type?';

  @override
  String get assetTypesFixedAssets => 'Fixed Assets';

  @override
  String get assetTypesLiquidAssets => 'Liquid Assets';

  @override
  String get assetTypesConsumerGoods => 'Consumer Goods';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsUserInfo => 'User Info';

  @override
  String get settingsUsername => 'Username';

  @override
  String get settingsPhone => 'Phone';

  @override
  String get settingsEmail => 'Email';

  @override
  String get settingsSaveSuccess => 'Saved successfully';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsSelectLanguage => 'Select Language';

  @override
  String get settingsDataManagement => 'Data Management';

  @override
  String get settingsExportData => 'Export Data';

  @override
  String get settingsExportHint => 'Export all data as JSON file';

  @override
  String get settingsExportFailed => 'Export failed';

  @override
  String get settingsClearData => 'Clear Data';

  @override
  String get settingsClearHint => 'Clear all data (irreversible)';

  @override
  String get settingsDangerWarning => '⚠️ Danger';

  @override
  String get settingsConfirmClear =>
      'Are you sure you want to clear all data? This cannot be undone!';

  @override
  String get settingsConfirmClearBtn => 'Confirm Clear';

  @override
  String get settingsDataCleared => 'Data cleared';

  @override
  String get settingsDefaultUser => 'Default User';

  @override
  String get aboutTitle => 'About';

  @override
  String get aboutAppIntro => 'About App';

  @override
  String get aboutAppDescription =>
      'JuCai is a personal asset portfolio management app that helps you take full control of your finances. It supports multi-type asset management (fixed assets, liquid assets, consumer goods), liability tracking, income & expense recording, and displays your asset distribution, return rates, and monthly trends through intuitive charts. Making personal finance simple and transparent.';

  @override
  String get aboutVersion => 'Version';

  @override
  String get aboutPlatform => 'Platform';

  @override
  String get aboutPlatformDesc => 'Android / iOS';

  @override
  String get aboutStorage => 'Storage';

  @override
  String get aboutStorageDesc => 'Local SQLite Database';

  @override
  String get aboutFramework => 'Framework';

  @override
  String get aboutFrameworkDesc => 'Flutter';

  @override
  String get aboutCopyright => '© 2024 JuCai Team';

  @override
  String get categoryFixedAssets => 'Fixed Assets';

  @override
  String get categoryLiquidAssets => 'Liquid Assets';

  @override
  String get categoryConsumerGoods => 'Consumer Goods';

  @override
  String get categoryMortgage => 'Mortgage';

  @override
  String get categoryCarLoan => 'Car Loan';

  @override
  String get categoryCreditCard => 'Credit Card';

  @override
  String get categoryOther => 'Other';

  @override
  String get frequencyOnce => 'One-time';

  @override
  String get frequencyDaily => 'Daily';

  @override
  String get frequencyWeekly => 'Weekly';

  @override
  String get frequencyMonthly => 'Monthly';

  @override
  String get frequencyQuarterly => 'Quarterly';

  @override
  String get frequencyYearly => 'Yearly';

  @override
  String get incomeSalary => 'Salary';

  @override
  String get incomeBonus => 'Bonus';

  @override
  String get incomeRent => 'Rental Income';

  @override
  String get incomeInvestment => 'Investment Return';

  @override
  String get incomePartTime => 'Part-time';

  @override
  String get incomeBusiness => 'Business Income';

  @override
  String get incomeOther => 'Other Income';

  @override
  String get expenseHousing => 'Housing';

  @override
  String get expenseFood => 'Food & Dining';

  @override
  String get expenseTransport => 'Transportation';

  @override
  String get expenseUtilities => 'Utilities';

  @override
  String get expenseMedical => 'Healthcare';

  @override
  String get expenseEducation => 'Education';

  @override
  String get expenseEntertainment => 'Entertainment';

  @override
  String get expenseShopping => 'Shopping';

  @override
  String get expenseInsurance => 'Insurance';

  @override
  String get expenseLoanRepayment => 'Loan Payment';

  @override
  String get expenseInvestment => 'Investment';

  @override
  String get expenseOther => 'Other Expense';
}
