import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/dashboard_provider.dart';
import '../utils/formatters.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider()..loadDashboard(),
      child: Consumer<DashboardProvider>(
        builder: (context, provider, _) {
          if (provider.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: () => provider.loadDashboard(),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildMetricCards(context, provider),
                const SizedBox(height: 16),
                _buildMonthlySummary(context, provider),
                const SizedBox(height: 16),
                if (provider.monthlyTrend.isNotEmpty) ...[
                  _buildTrendChart(context, provider),
                  const SizedBox(height: 16),
                ],
                if (provider.assetDistribution.isNotEmpty) ...[
                  _buildDistributionChart(context, provider),
                  const SizedBox(height: 16),
                ],
                if (provider.assetReturns.isNotEmpty) ...[
                  _buildReturnChart(context, provider),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMetricCards(BuildContext context, DashboardProvider provider) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                title: '总资产',
                value: Formatters.formatCurrencyFull(provider.totalAssets),
                icon: Icons.account_balance_wallet,
                gradientColors: [const Color(0xFF42A5F5), const Color(0xFF1976D2)],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MetricCard(
                title: '总负债',
                value: Formatters.formatCurrencyFull(provider.totalLiabilities),
                icon: Icons.trending_down,
                gradientColors: [const Color(0xFFEF5350), const Color(0xFFC62828)],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _MetricCard(
          title: '净资产',
          value: Formatters.formatCurrencyFull(provider.netWorth),
          icon: Icons.savings,
          gradientColors: [const Color(0xFF66BB6A), const Color(0xFF2E7D32)],
        ),
      ],
    );
  }

  Widget _buildMonthlySummary(BuildContext context, DashboardProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('本月收支', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _SummaryItem(
                    label: '收入',
                    value: Formatters.formatCurrencyFull(provider.monthIncome),
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: _SummaryItem(
                    label: '支出',
                    value: Formatters.formatCurrencyFull(provider.monthExpense),
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  child: _SummaryItem(
                    label: '净额',
                    value: Formatters.formatCurrencyFull(provider.monthNetCashFlow),
                    color: provider.monthNetCashFlow >= 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendChart(BuildContext context, DashboardProvider provider) {
    final data = provider.monthlyTrend.reversed.toList();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('12个月收支趋势', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true, drawVerticalLine: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            Formatters.formatCurrency(value),
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final idx = value.toInt();
                          if (idx >= 0 && idx < data.length) {
                            final month = data[idx]['month'] as String;
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(month.substring(5), style: const TextStyle(fontSize: 10)),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(data.length, (i) {
                        return FlSpot(i.toDouble(), (data[i]['income'] as num).toDouble());
                      }),
                      color: Colors.green,
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                    ),
                    LineChartBarData(
                      spots: List.generate(data.length, (i) {
                        return FlSpot(i.toDouble(), (data[i]['expense'] as num).toDouble());
                      }),
                      color: Colors.red,
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Legend(color: Colors.green, label: '收入'),
                const SizedBox(width: 16),
                _Legend(color: Colors.red, label: '支出'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDistributionChart(BuildContext context, DashboardProvider provider) {
    final data = provider.assetDistribution;
    final total = data.fold(0.0, (sum, d) => sum + (d['total'] as num).toDouble());

    if (total == 0) return const SizedBox();

    final colors = [
      Colors.blue, Colors.green, Colors.orange, Colors.purple,
      Colors.red, Colors.teal, Colors.pink, Colors.indigo,
      Colors.amber, Colors.cyan,
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('资产分布', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        sections: List.generate(data.length, (i) {
                          final value = (data[i]['total'] as num).toDouble();
                          return PieChartSectionData(
                            value: value,
                            title: '${(value / total * 100).toStringAsFixed(1)}%',
                            color: colors[i % colors.length],
                            radius: 50,
                            titleStyle: const TextStyle(fontSize: 10, color: Colors.white),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(data.length, (i) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              Container(
                                width: 10, height: 10,
                                decoration: BoxDecoration(
                                  color: colors[i % colors.length],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  data[i]['type_name'] as String,
                                  style: const TextStyle(fontSize: 11),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReturnChart(BuildContext context, DashboardProvider provider) {
    final data = provider.assetReturns;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('资产收益率', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            SizedBox(
              height: (data.length * 40.0).clamp(80, 300),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 60,
                        getTitlesWidget: (value, meta) {
                          final idx = value.toInt();
                          if (idx >= 0 && idx < data.length) {
                            return Text(
                              data[idx]['name'] as String,
                              style: const TextStyle(fontSize: 10),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toStringAsFixed(0)}%',
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(data.length, (i) {
                    final rate = (data[i]['return_rate'] as num).toDouble();
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: rate,
                          color: rate >= 0 ? Colors.green : Colors.red,
                          width: 16,
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(4),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final List<Color> gradientColors;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white70, size: 20),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _SummaryItem({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;

  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 3, color: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
