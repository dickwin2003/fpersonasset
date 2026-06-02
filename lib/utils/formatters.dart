import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';

class Formatters {
  static String formatCurrency(double value, {BuildContext? context}) {
    final abs = value.abs();
    final S? s = context != null ? S.of(context) : null;
    if (abs >= 100000000) {
      return '${(value / 100000000).toStringAsFixed(2)}${s?.currencyHundredMillion ?? '亿'}';
    } else if (abs >= 10000000) {
      return '${(value / 10000000).toStringAsFixed(2)}${s?.currencyTenMillion ?? '千万'}';
    } else if (abs >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(2)}${s?.currencyOneMillion ?? '百万'}';
    } else if (abs >= 10000) {
      return '${(value / 10000).toStringAsFixed(2)}${s?.currencyTenThousand ?? '万'}';
    }
    return value.toStringAsFixed(2);
  }

  static String formatCurrencyFull(double value) {
    final prefix = value < 0 ? '-' : '';
    return '$prefix¥${value.abs().toStringAsFixed(2)}';
  }

  static String formatPercent(double value) {
    return '${value.toStringAsFixed(2)}%';
  }

  static String formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('yyyy-MM-dd').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  static String formatDateShort(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MM/dd').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  static String formatMonth(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('yyyy-MM').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  static String currentMonth() {
    return DateFormat('yyyy-MM').format(DateTime.now());
  }

  static String currentDateString() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }
}
