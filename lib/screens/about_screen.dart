import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../utils/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(s.aboutTitle)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 40),
          // App Icon
          Container(
            width: 100, height: 100,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF42A5F5), Color(0xFF1976D2)],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(color: Colors.blue.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 10)),
              ],
            ),
            child: Center(
              child: Text(s.appName, style: const TextStyle(
                fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
          const SizedBox(height: 24),
          Text(s.appName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('${s.aboutVersion} ${AppConstants.appVersion}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          const SizedBox(height: 40),
          // App description card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(s.aboutAppIntro, style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(s.aboutAppDescription,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.6)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.phone_android),
                  title: Text(s.aboutPlatform),
                  subtitle: Text(s.aboutPlatformDesc),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.storage),
                  title: Text(s.aboutStorage),
                  subtitle: Text(s.aboutStorageDesc),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.flutter_dash),
                  title: Text(s.aboutFramework),
                  subtitle: Text('${s.aboutFrameworkDesc} ${AppConstants.appVersion}'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(s.aboutCopyright, textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey[400])),
        ],
      ),
    );
  }
}
