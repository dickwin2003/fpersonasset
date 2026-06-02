class InvestmentReturn {
  final int? id;
  final String userId;
  final int assetId;
  final double returnAmount;
  final String returnDate;
  final String? notes;

  InvestmentReturn({
    this.id,
    required this.userId,
    required this.assetId,
    required this.returnAmount,
    required this.returnDate,
    this.notes,
  });

  factory InvestmentReturn.fromMap(Map<String, dynamic> map) {
    return InvestmentReturn(
      id: map['id'] as int?,
      userId: map['user_id'] as String,
      assetId: map['asset_id'] as int,
      returnAmount: (map['return_amount'] as num).toDouble(),
      returnDate: map['return_date'] as String,
      notes: map['notes'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'asset_id': assetId,
      'return_amount': returnAmount,
      'return_date': returnDate,
      'notes': notes,
    };
  }
}
