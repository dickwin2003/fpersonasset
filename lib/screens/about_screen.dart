import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('关于')),
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
            child: const Center(
              child: Text('聚财', style: TextStyle(
                fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
          const SizedBox(height: 24),
          const Text(AppConstants.appName,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('版本 ${AppConstants.appVersion}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          const SizedBox(height: 40),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('应用介绍'),
                  subtitle: const Text('个人资产组合管理系统'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.phone_android),
                  title: const Text('平台'),
                  subtitle: const Text('Android / iOS'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.storage),
                  title: const Text('数据存储'),
                  subtitle: const Text('本地 SQLite 数据库'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.flutter_dash),
                  title: const Text('技术框架'),
                  subtitle: const Text('Flutter ${AppConstants.appVersion}'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('© 2024-2026 聚财团队', textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey[400])),
        ],
      ),
    );
  }
}
