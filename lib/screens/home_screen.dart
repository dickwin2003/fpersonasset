import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../utils/constants.dart';
import 'dashboard_screen.dart';
import 'assets_screen.dart';
import 'liabilities_screen.dart';
import 'cash_flow_screen.dart';
import 'asset_types_screen.dart';
import 'settings_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DashboardScreen(),
    AssetsScreen(),
    LiabilitiesScreen(),
    CashFlowScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(s.appName),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'asset_types':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AssetTypesScreen()),
                  );
                  break;
                case 'settings':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                  break;
                case 'about':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AboutScreen()),
                  );
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'asset_types',
                child: Row(
                  children: [
                    const Icon(Icons.category, size: 20),
                    const SizedBox(width: 12),
                    Text(s.menuAssetTypes),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    const Icon(Icons.settings, size: 20),
                    const SizedBox(width: 12),
                    Text(s.menuSettings),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'about',
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, size: 20),
                    const SizedBox(width: 12),
                    Text(s.menuAbout),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.dashboard_outlined),
            selectedIcon: const Icon(Icons.dashboard),
            label: s.navHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: const Icon(Icons.account_balance_wallet),
            label: s.navAssets,
          ),
          NavigationDestination(
            icon: const Icon(Icons.trending_down_outlined),
            selectedIcon: const Icon(Icons.trending_down),
            label: s.navLiabilities,
          ),
          NavigationDestination(
            icon: const Icon(Icons.swap_horiz_outlined),
            selectedIcon: const Icon(Icons.swap_horiz),
            label: s.navCashFlow,
          ),
        ],
      ),
    );
  }
}
