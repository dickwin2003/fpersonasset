import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/asset_provider.dart';
import '../models/asset_type.dart';
import '../database/database_helper.dart';
import '../utils/constants.dart';

class AssetTypesScreen extends StatelessWidget {
  const AssetTypesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AssetProvider()..loadAssetTypes(),
      child: Consumer<AssetProvider>(
        builder: (context, provider, _) {
          final types = provider.assetTypes;
          return Scaffold(
            appBar: AppBar(title: const Text('资产类型管理')),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: AppConstants.assetCategories.map((category) {
                final categoryTypes = types.where((t) => t.category == category).toList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        AppConstants.assetCategoryLabels[category] ?? category,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...categoryTypes.map((type) => Card(
                      child: ListTile(
                        leading: Icon(_getCategoryIcon(category), color: _getCategoryColor(category)),
                        title: Text(type.name),
                        subtitle: type.description != null ? Text(type.description!) : null,
                        trailing: type.hasDepreciation
                            ? Text('折旧率: ${type.depreciationRate}%', style: const TextStyle(fontSize: 12, color: Colors.orange))
                            : null,
                        onTap: () => _showForm(context, provider, type),
                      ),
                    )),
                    const SizedBox(height: 8),
                  ],
                );
              }).toList(),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showForm(context, provider, null),
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'fixed': return Icons.home;
      case 'liquid': return Icons.water_drop;
      case 'consumer': return Icons.shopping_bag;
      default: return Icons.category;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'fixed': return Colors.blue;
      case 'liquid': return Colors.green;
      case 'consumer': return Colors.orange;
      default: return Colors.grey;
    }
  }

  void _showForm(BuildContext context, AssetProvider provider, AssetType? type) {
    final nameCtrl = TextEditingController(text: type?.name ?? '');
    final descCtrl = TextEditingController(text: type?.description ?? '');
    final rateCtrl = TextEditingController(text: type?.depreciationRate.toString() ?? '0');
    String category = type?.category ?? 'liquid';
    bool hasDepreciation = type?.hasDepreciation ?? false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return StatefulBuilder(builder: (ctx, setModalState) {
          return Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(type == null ? '添加资产类型' : '编辑资产类型',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: '类型名称', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: category,
                  decoration: const InputDecoration(
                    labelText: '分类', border: OutlineInputBorder()),
                  items: AppConstants.assetCategoryLabels.entries.map((e) =>
                    DropdownMenuItem(value: e.key, child: Text(e.value))).toList(),
                  onChanged: (v) => setModalState(() => category = v ?? 'liquid'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: descCtrl,
                  decoration: const InputDecoration(
                    labelText: '描述', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  title: const Text('支持折旧'),
                  value: hasDepreciation,
                  onChanged: (v) => setModalState(() => hasDepreciation = v),
                ),
                if (hasDepreciation)
                  TextFormField(
                    controller: rateCtrl,
                    decoration: const InputDecoration(
                      labelText: '折旧率', border: OutlineInputBorder(), suffixText: '%'),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () async {
                    final db = DatabaseHelper();
                    if (type == null) {
                      await db.insert('asset_types', {
                        'user_id': AppConstants.defaultUserId,
                        'name': nameCtrl.text.trim(),
                        'category': category,
                        'description': descCtrl.text.trim().isEmpty ? null : descCtrl.text.trim(),
                        'has_depreciation': hasDepreciation ? 1 : 0,
                        'depreciation_rate': double.tryParse(rateCtrl.text) ?? 0,
                      });
                    } else {
                      await db.update('asset_types', {
                        'name': nameCtrl.text.trim(),
                        'category': category,
                        'description': descCtrl.text.trim().isEmpty ? null : descCtrl.text.trim(),
                        'has_depreciation': hasDepreciation ? 1 : 0,
                        'depreciation_rate': double.tryParse(rateCtrl.text) ?? 0,
                      }, 'id = ?', [type.id!]);
                    }
                    provider.loadAssetTypes();
                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                  child: Text(type == null ? '添加' : '保存'),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
