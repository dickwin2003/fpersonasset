class AssetValueHistory {
  final int? id;
  final String userId;
  final int assetId;
  final double value;
  final String date;

  AssetValueHistory({
    this.id,
    required this.userId,
    required this.assetId,
    required this.value,
    required this.date,
  });

  factory AssetValueHistory.fromMap(Map<String, dynamic> map) {
    return AssetValueHistory(
      id: map['id'] as int?,
      userId: map['user_id'] as String,
      assetId: map['asset_id'] as int,
      value: (map['value'] as num).toDouble(),
      date: map['date'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'asset_id': assetId,
      'value': value,
      'date': date,
    };
  }
}
