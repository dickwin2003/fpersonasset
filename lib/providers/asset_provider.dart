import 'package:flutter/material.dart';
import '../models/asset.dart';
import '../models/asset_type.dart';
import '../database/database_helper.dart';
import '../utils/constants.dart';

class AssetProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper();
  List<Asset> _assets = [];
  List<AssetType> _assetTypes = [];
  bool _loading = false;

  List<Asset> get assets => _assets;
  List<AssetType> get assetTypes => _assetTypes;
  bool get loading => _loading;
  double get totalValue => _assets.fold(0, (sum, a) => sum + a.currentValue);

  Future<void> loadAssets() async {
    _loading = true;
    notifyListeners();
    final results = await _db.query(
      'assets',
      where: 'user_id = ?',
      whereArgs: [AppConstants.defaultUserId],
      orderBy: 'id DESC',
    );
    _assets = results.map((m) => Asset.fromMap(m)).toList();
    _loading = false;
    notifyListeners();
  }

  Future<void> loadAssetTypes() async {
    final results = await _db.query(
      'asset_types',
      where: 'user_id = ?',
      whereArgs: [AppConstants.defaultUserId],
      orderBy: 'category, name',
    );
    _assetTypes = results.map((m) => AssetType.fromMap(m)).toList();
    notifyListeners();
  }

  Future<void> addAsset(Asset asset) async {
    await _db.insert('assets', asset.toMap());
    await loadAssets();
  }

  Future<void> updateAsset(Asset asset) async {
    await _db.update(
      'assets',
      asset.toMap(),
      'id = ? AND user_id = ?',
      [asset.id, AppConstants.defaultUserId],
    );
    await loadAssets();
  }

  Future<void> deleteAsset(int id) async {
    await _db.deleteAsset(id);
    await loadAssets();
  }

  AssetType? getAssetType(int? typeId) {
    try {
      return _assetTypes.firstWhere((t) => t.id == typeId);
    } catch (_) {
      return null;
    }
  }
}
