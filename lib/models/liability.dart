class Liability {
  final int? id;
  final String userId;
  final String name;
  final double amount;
  final double? interestRate;
  final double? monthlyPayment;
  final int? remainingMonths;
  final double? remainingAmount;
  final String? startDate;
  final String? endDate;
  final String liabilityType; // 'mortgage' | 'car_loan' | 'credit_card' | 'other'

  Liability({
    this.id,
    required this.userId,
    required this.name,
    required this.amount,
    this.interestRate,
    this.monthlyPayment,
    this.remainingMonths,
    this.remainingAmount,
    this.startDate,
    this.endDate,
    this.liabilityType = 'other',
  });

  factory Liability.fromMap(Map<String, dynamic> map) {
    return Liability(
      id: map['id'] as int?,
      userId: map['user_id'] as String,
      name: map['name'] as String,
      amount: (map['amount'] as num).toDouble(),
      interestRate: (map['interest_rate'] as num?)?.toDouble(),
      monthlyPayment: (map['monthly_payment'] as num?)?.toDouble(),
      remainingMonths: map['remaining_months'] as int?,
      remainingAmount: (map['remaining_amount'] as num?)?.toDouble(),
      startDate: map['start_date'] as String?,
      endDate: map['end_date'] as String?,
      liabilityType: map['liability_type'] as String? ?? 'other',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'name': name,
      'amount': amount,
      'interest_rate': interestRate,
      'monthly_payment': monthlyPayment,
      'remaining_months': remainingMonths,
      'remaining_amount': remainingAmount,
      'start_date': startDate,
      'end_date': endDate,
      'liability_type': liabilityType,
    };
  }

  double get progressPercent {
    if (amount > 0 && remainingAmount != null) {
      final paid = amount - remainingAmount!;
      return (paid / amount).clamp(0.0, 1.0);
    }
    return 0;
  }

  String get liabilityTypeLabel {
    switch (liabilityType) {
      case 'mortgage':
        return '房贷';
      case 'car_loan':
        return '车贷';
      case 'credit_card':
        return '信用卡';
      case 'other':
        return '其他';
      default:
        return liabilityType;
    }
  }
}
