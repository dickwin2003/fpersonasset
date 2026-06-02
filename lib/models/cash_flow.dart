import 'package:flutter/widgets.dart';
import '../l10n/app_localizations.dart';

class CashFlow {
  final int? id;
  final String userId;
  final String type; // 'income' | 'expense'
  final String category;
  final double amount;
  final String? description;
  final String frequency; // 'once' | 'daily' | 'weekly' | 'monthly' | 'quarterly' | 'yearly'
  final String? startDate;
  final String? endDate;
  final String? date;

  CashFlow({
    this.id,
    required this.userId,
    required this.type,
    required this.category,
    required this.amount,
    this.description,
    this.frequency = 'once',
    this.startDate,
    this.endDate,
    this.date,
  });

  factory CashFlow.fromMap(Map<String, dynamic> map) {
    return CashFlow(
      id: map['id'] as int?,
      userId: map['user_id'] as String,
      type: map['type'] as String,
      category: map['category'] as String,
      amount: (map['amount'] as num).toDouble(),
      description: map['description'] as String?,
      frequency: map['frequency'] as String? ?? 'once',
      startDate: map['start_date'] as String?,
      endDate: map['end_date'] as String?,
      date: map['date'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'type': type,
      'category': category,
      'amount': type == 'expense' ? -amount.abs() : amount.abs(),
      'description': description,
      'frequency': frequency,
      'start_date': startDate,
      'end_date': endDate,
      'date': date,
    };
  }

  double get displayAmount => amount.abs();

  bool get isIncome => type == 'income';

  bool get isPlanned {
    if (date == null) return false;
    final flowDate = DateTime.tryParse(date!);
    if (flowDate == null) return false;
    final now = DateTime.now();
    return flowDate.year >= now.year && flowDate.month >= now.month;
  }

  String get frequencyLabel {
    // Legacy fallback for non-context usage
    switch (frequency) {
      case 'once':
        return '一次性';
      case 'daily':
        return '每天';
      case 'weekly':
        return '每周';
      case 'monthly':
        return '每月';
      case 'quarterly':
        return '每季度';
      case 'yearly':
        return '每年';
      default:
        return frequency;
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

  bool get isRecurring => frequency != 'once';
}
