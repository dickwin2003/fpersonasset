class Asset {
  final int? id;
  final String userId;
  final int assetTypeId;
  final String name;
  final double currentValue;
  final double? purchaseValue;
  final String? purchaseDate;
  final String? description;

  Asset({
    this.id,
    required this.userId,
    required this.assetTypeId,
    required this.name,
    required this.currentValue,
    this.purchaseValue,
    this.purchaseDate,
    this.description,
  });

  factory Asset.fromMap(Map<String, dynamic> map) {
    return Asset(
      id: map['id'] as int?,
      userId: map['user_id'] as String,
      assetTypeId: map['asset_type_id'] as int,
      name: map['name'] as String,
      currentValue: (map['current_value'] as num).toDouble(),
      purchaseValue: (map['purchase_value'] as num?)?.toDouble(),
      purchaseDate: map['purchase_date'] as String?,
      description: map['description'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'asset_type_id': assetTypeId,
      'name': name,
      'current_value': currentValue,
      'purchase_value': purchaseValue,
      'purchase_date': purchaseDate,
      'description': description,
    };
  }

  double get returnRate {
    if (purchaseValue != null && purchaseValue! > 0) {
      return (currentValue - purchaseValue!) / purchaseValue! * 100;
    }
    return 0;
  }
}
