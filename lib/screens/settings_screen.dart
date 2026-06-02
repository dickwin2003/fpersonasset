import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../l10n/app_localizations.dart';
import '../providers/user_provider.dart';
import '../providers/locale_provider.dart';
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
          final s = S.of(context);
          final localeProvider = Provider.of<LocaleProvider>(context);
          return Scaffold(
            appBar: AppBar(title: Text(s.settingsTitle)),
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
                        Text(s.settingsUserInfo, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: user?.username ?? s.settingsDefaultUser,
                          decoration: InputDecoration(
                            labelText: s.settingsUsername,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          initialValue: user?.phone ?? '',
                          decoration: InputDecoration(
                            labelText: s.settingsPhone,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.phone),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          initialValue: user?.email ?? '',
                          decoration: InputDecoration(
                            labelText: s.settingsEmail,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: () async {
                              if (user != null) {
                                await provider.updateUser(user.copyWith());
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(s.settingsSaveSuccess), backgroundColor: Colors.green),
                                  );
                                }
                              }
                            },
                            icon: const Icon(Icons.save),
                            label: Text(s.btnSave),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // 语言切换
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.language, color: Colors.blue),
                    title: Text(s.settingsLanguage),
                    subtitle: Text(LocaleProvider.getDisplayName(localeProvider.locale)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _showLanguagePicker(context, localeProvider),
                  ),
                ),
                const SizedBox(height: 16),
                // 数据管理
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.download, color: Colors.blue),
                        title: Text(s.settingsExportData),
                        subtitle: Text(s.settingsExportHint),
                        onTap: () => _exportData(context),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.delete_forever, color: Colors.red),
                        title: Text(s.settingsClearData),
                        subtitle: Text(s.settingsClearHint),
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

  void _showLanguagePicker(BuildContext context, LocaleProvider provider) {
    final s = S.of(context);
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(s.settingsSelectLanguage),
        children: LocaleProvider.supportedLocales.map((locale) {
          return SimpleDialogOption(
            onPressed: () {
              provider.setLocale(locale);
              Navigator.pop(ctx);
            },
            child: Row(
              children: [
                Radio<Locale>(
                  value: locale,
                  groupValue: provider.locale,
                  onChanged: (v) { provider.setLocale(v!); Navigator.pop(ctx); },
                ),
                Text(LocaleProvider.getDisplayName(locale)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Future<void> _exportData(BuildContext context) async {
    final s = S.of(context);
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
          text: '${s.appName} $timestamp',
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${s.settingsExportFailed}: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _confirmClearData(BuildContext context) {
    final s = S.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s.settingsDangerWarning),
        content: Text(s.settingsConfirmClear),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(s.btnCancel)),
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
                  SnackBar(content: Text(s.settingsDataCleared), backgroundColor: Colors.orange),
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(s.settingsConfirmClearBtn),
          ),
        ],
      ),
    );
  }
}
