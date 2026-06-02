import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../l10n/app_localizations.dart';
import '../providers/user_provider.dart';
import '../providers/locale_provider.dart';
import '../providers/password_provider.dart';
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
          final passwordProvider = Provider.of<PasswordProvider>(context);
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
                // 安全设置 - 应用锁
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                        child: Text(s.settingsSecurity, style: Theme.of(context).textTheme.titleMedium),
                      ),
                      if (!passwordProvider.hasPassword)
                        ListTile(
                          leading: const Icon(Icons.lock_outline, color: Colors.orange),
                          title: Text(s.settingsSetPassword),
                          subtitle: Text(s.settingsAppLockHint),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _showSetPasswordDialog(context, passwordProvider),
                        )
                      else ...[
                        SwitchListTile(
                          secondary: const Icon(Icons.lock, color: Colors.green),
                          title: Text(s.settingsAppLock),
                          subtitle: Text(s.settingsAppLockHint),
                          value: true,
                          onChanged: (v) {
                            if (!v) _showRemovePasswordDialog(context, passwordProvider);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.key, color: Colors.blue),
                          title: Text(s.settingsChangePassword),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _showChangePasswordDialog(context, passwordProvider),
                        ),
                      ],
                    ],
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

  // ============ 语言选择 ============

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

  // ============ 密码设置 ============

  void _showSetPasswordDialog(BuildContext context, PasswordProvider provider) {
    final s = S.of(context);
    final ctrl1 = TextEditingController();
    final ctrl2 = TextEditingController();
    String? error;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(builder: (ctx, setDialogState) {
        return AlertDialog(
          title: Text(s.lockSetPassword),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: ctrl1,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 4,
                decoration: InputDecoration(
                  labelText: s.lockEnterPassword,
                  border: const OutlineInputBorder(),
                  counterText: '',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: ctrl2,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 4,
                decoration: InputDecoration(
                  labelText: s.lockConfirmPassword,
                  border: const OutlineInputBorder(),
                  counterText: '',
                ),
              ),
              if (error != null) ...[
                const SizedBox(height: 8),
                Text(error!, style: const TextStyle(color: Colors.red, fontSize: 13)),
              ],
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: Text(s.btnCancel)),
            FilledButton(
              onPressed: () async {
                if (ctrl1.text.length < 4) {
                  setDialogState(() => error = s.lockEnterPassword);
                  return;
                }
                if (ctrl1.text != ctrl2.text) {
                  setDialogState(() => error = s.lockPasswordMismatch);
                  return;
                }
                await provider.setPassword(ctrl1.text);
                if (ctx.mounted) {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(s.lockPasswordSet), backgroundColor: Colors.green),
                  );
                }
              },
              child: Text(s.lockSetPassword),
            ),
          ],
        );
      }),
    );
  }

  void _showChangePasswordDialog(BuildContext context, PasswordProvider provider) {
    final s = S.of(context);
    final oldCtrl = TextEditingController();
    final newCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();
    String? error;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(builder: (ctx, setDialogState) {
        return AlertDialog(
          title: Text(s.lockChangePassword),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: oldCtrl,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 4,
                decoration: InputDecoration(
                  labelText: s.lockOldPassword,
                  border: const OutlineInputBorder(),
                  counterText: '',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: newCtrl,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 4,
                decoration: InputDecoration(
                  labelText: s.lockNewPassword,
                  border: const OutlineInputBorder(),
                  counterText: '',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: confirmCtrl,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 4,
                decoration: InputDecoration(
                  labelText: s.lockConfirmNewPassword,
                  border: const OutlineInputBorder(),
                  counterText: '',
                ),
              ),
              if (error != null) ...[
                const SizedBox(height: 8),
                Text(error!, style: const TextStyle(color: Colors.red, fontSize: 13)),
              ],
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: Text(s.btnCancel)),
            FilledButton(
              onPressed: () async {
                final oldOk = await provider.verifyPassword(oldCtrl.text);
                if (!oldOk) {
                  setDialogState(() => error = s.lockOldPasswordWrong);
                  return;
                }
                if (newCtrl.text.length < 4) {
                  setDialogState(() => error = s.lockNewPassword);
                  return;
                }
                if (newCtrl.text != confirmCtrl.text) {
                  setDialogState(() => error = s.lockPasswordMismatch);
                  return;
                }
                await provider.setPassword(newCtrl.text);
                if (ctx.mounted) {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(s.lockPasswordChanged), backgroundColor: Colors.green),
                  );
                }
              },
              child: Text(s.dialogConfirm),
            ),
          ],
        );
      }),
    );
  }

  void _showRemovePasswordDialog(BuildContext context, PasswordProvider provider) {
    final s = S.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s.lockRemovePassword),
        content: Text(s.settingsRemovePasswordConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(s.btnCancel)),
          TextButton(
            onPressed: () async {
              await provider.removePassword();
              if (ctx.mounted) {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(s.lockPasswordRemoved), backgroundColor: Colors.orange),
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(s.dialogConfirm),
          ),
        ],
      ),
    );
  }

  // ============ 数据管理 ============

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
