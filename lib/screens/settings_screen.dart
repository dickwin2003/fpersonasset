import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/user_provider.dart';
import '../database/database_helper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider()..loadUser(),
      child: Consumer<UserProvider>(
        builder: (context, provider, _) {
          final user = provider.user;
          return Scaffold(
            appBar: AppBar(title: const Text('设置')),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // 用户信息
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('用户信息', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: user?.username ?? '默认用户',
                          decoration: const InputDecoration(
                            labelText: '用户名',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          initialValue: user?.phone ?? '',
                          decoration: const InputDecoration(
                            labelText: '手机号',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          initialValue: user?.email ?? '',
                          decoration: const InputDecoration(
                            labelText: '邮箱',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: () async {
                              // Save user info
                              if (user != null) {
                                await provider.updateUser(user.copyWith());
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('保存成功'), backgroundColor: Colors.green),
                                  );
                                }
                              }
                            },
                            icon: const Icon(Icons.save),
                            label: const Text('保存'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // 数据管理
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.download, color: Colors.blue),
                        title: const Text('导出数据'),
                        subtitle: const Text('导出所有数据为 JSON 文件'),
                        onTap: () => _exportData(context),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.delete_forever, color: Colors.red),
                        title: const Text('清除数据'),
                        subtitle: const Text('清除所有数据（不可恢复）'),
                        onTap: () => _confirmClearData(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _exportData(BuildContext context) async {
    try {
      final db = DatabaseHelper();
      final data = await db.exportAllData();
      final jsonStr = const JsonEncoder.withIndent('  ').convert(data);

      final dir = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').split('.').first;
      final file = File('${dir.path}/jucai_backup_$timestamp.json');
      await file.writeAsString(jsonStr);

      if (context.mounted) {
        await Share.shareXFiles(
          [XFile(file.path)],
          text: '聚财数据备份 $timestamp',
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('导出失败: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _confirmClearData(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('⚠️ 危险操作'),
        content: const Text('确定要清除所有数据吗？此操作不可恢复！'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          TextButton(
            onPressed: () async {
              final db = DatabaseHelper();
              final database = await db.database;
              await database.delete('assets');
              await database.delete('liabilities');
              await database.delete('cash_flows');
              await database.delete('asset_value_history');
              await database.delete('investment_returns');
              if (ctx.mounted) {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('数据已清除'), backgroundColor: Colors.orange),
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('确认清除'),
          ),
        ],
      ),
    );
  }
}
