import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/asset_provider.dart';
import '../models/asset.dart';
import '../models/asset_type.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';
import '../widgets/forms/asset_form.dart';

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final provider = AssetProvider();
        provider.loadAssetTypes();
        provider.loadAssets();
        return provider;
      },
      child: Consumer<AssetProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            body: provider.loading
                ? const Center(child: CircularProgressIndicator())
                : provider.assets.isEmpty
                    ? _buildEmpty(context)
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: provider.assets.length,
                        itemBuilder: (context, index) {
                          final asset = provider.assets[index];
                          final assetType = provider.getAssetType(asset.assetTypeId);
                          return _AssetCard(
                            asset: asset,
                            assetType: assetType,
                            onEdit: () => _showForm(context, provider, asset),
                            onDelete: () => _confirmDelete(context, provider, asset),
                          );
                        },
                      ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _showForm(context, provider, null),
              icon: const Icon(Icons.add),
              label: const Text('添加资产'),
              backgroundColor: const Color(AppConstants.assetColor),
              foregroundColor: Colors.white,
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_balance_wallet, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text('还没有资产记录', style: TextStyle(fontSize: 16, color: Colors.grey[500])),
          const SizedBox(height: 8),
          Text('点击下方按钮添加第一笔资产', style: TextStyle(fontSize: 14, color: Colors.grey[400])),
        ],
      ),
    );
  }

  void _showForm(BuildContext context, AssetProvider provider, Asset? asset) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AssetForm(
        asset: asset,
        assetTypes: provider.assetTypes,
        onSave: (data) async {
          if (asset == null) {
            await provider.addAsset(Asset(
              userId: AppConstants.defaultUserId,
              assetTypeId: data['asset_type_id'] as int,
              name: data['name'] as String,
              currentValue: data['current_value'] as double,
              purchaseValue: data['purchase_value'] as double?,
              purchaseDate: data['purchase_date'] as String?,
              description: data['description'] as String?,
            ));
          } else {
            await provider.updateAsset(Asset(
              id: asset.id,
              userId: asset.userId,
              assetTypeId: data['asset_type_id'] as int,
              name: data['name'] as String,
              currentValue: data['current_value'] as double,
              purchaseValue: data['purchase_value'] as double?,
              purchaseDate: data['purchase_date'] as String?,
              description: data['description'] as String?,
            ));
          }
          if (context.mounted) Navigator.pop(context);
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, AssetProvider provider, Asset asset) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除资产「${asset.name}」吗？相关历史数据也会被删除。'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('取消')),
          TextButton(
            onPressed: () {
              provider.deleteAsset(asset.id!);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
}

class _AssetCard extends StatelessWidget {
  final Asset asset;
  final AssetType? assetType;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _AssetCard({
    required this.asset,
    this.assetType,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    asset.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                if (assetType != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(assetType!.category).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      assetType!.name,
                      style: TextStyle(
                        fontSize: 12,
                        color: _getCategoryColor(assetType!.category),
                      ),
                    ),
                  ),
              ],
            ),
            if (asset.description != null && asset.description!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(asset.description!, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('当前价值', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      Text(
                        Formatters.formatCurrencyFull(asset.currentValue),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                ),
                if (asset.purchaseValue != null && asset.purchaseValue! > 0) ...[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('收益率', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                        Text(
                          Formatters.formatPercent(asset.returnRate),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: asset.returnRate >= 0 ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('编辑'),
                ),
                TextButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline, size: 18),
                  label: const Text('删除'),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'fixed':
        return Colors.blue;
      case 'liquid':
        return Colors.green;
      case 'consumer':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
