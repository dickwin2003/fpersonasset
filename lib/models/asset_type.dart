import 'package:flutter/widgets.dart';
import '../l10n/app_localizations.dart';

class AssetType {
  final int? id;
  final String userId;
  final String name;
  final String category; // 'fixed' | 'liquid' | 'consumer'
  final String? description;
  final bool hasDepreciation;
  final double depreciationRate;

  AssetType({
    this.id,
    required this.userId,
    required this.name,
    required this.category,
    this.description,
    this.hasDepreciation = false,
    this.depreciationRate = 0.0,
  });

  factory AssetType.fromMap(Map<String, dynamic> map) {
    return AssetType(
      id: map['id'] as int?,
      userId: map['user_id'] as String,
      name: map['name'] as String,
      category: map['category'] as String,
      description: map['description'] as String?,
      hasDepreciation: (map['has_depreciation'] as int?) == 1,
      depreciationRate: (map['depreciation_rate'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'name': name,
      'category': category,
      'description': description,
      'has_depreciation': hasDepreciation ? 1 : 0,
      'depreciation_rate': depreciationRate,
    };
  }

  String get categoryLabel {
    // Legacy fallback for non-context usage
    switch (category) {
      case 'fixed':
        return '固定资产';
      case 'liquid':
        return '流动资产';
      case 'consumer':
        return '消费品';
      default:
        return category;
    }
  }

  static String getCategoryLabel(BuildContext context, String category) {
    final s = S.of(context);
    switch (category) {
      case 'fixed': return s.categoryFixedAssets;
      case 'liquid': return s.categoryLiquidAssets;
      case 'consumer': return s.categoryConsumerGoods;
      default: return category;
    }
  }
}
