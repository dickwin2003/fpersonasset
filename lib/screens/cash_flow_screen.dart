import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cash_flow_provider.dart';
import '../models/cash_flow.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';

class CashFlowScreen extends StatelessWidget {
  const CashFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CashFlowProvider()..loadCashFlows(),
      child: Consumer<CashFlowProvider>(
        builder: (context, provider, _) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('资金流'),
                bottom: const TabBar(
                  tabs: [
                    Tab(text: '预期收支'),
                    Tab(text: '历史记录'),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  _buildPlannedList(context, provider),
                  _buildHistoricalList(context, provider),
                ],
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () => _showForm(context, provider, null),
                icon: const Icon(Icons.add),
                label: const Text('添加记录'),
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlannedList(BuildContext context, CashFlowProvider provider) {
    final items = provider.planned;
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_note, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text('暂无预期收支', style: TextStyle(color: Colors.grey[500])),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      itemCount: items.length,
      itemBuilder: (context, index) => _CashFlowCard(
        cashFlow: items[index],
        onEdit: () => _showForm(context, provider, items[index]),
        onDelete: () => _confirmDelete(context, provider, items[index]),
      ),
    );
  }

  Widget _buildHistoricalList(BuildContext context, CashFlowProvider provider) {
    final items = provider.historical;
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text('暂无历史记录', style: TextStyle(color: Colors.grey[500])),
          ],
        ),
      );
    }

    // 月度汇总
    final monthlyData = <String, Map<String, double>>{};
    for (final cf in items) {
      if (cf.date != null) {
        final month = cf.date!.substring(0, 7);
        monthlyData.putIfAbsent(month, () => {'income': 0, 'expense': 0});
        if (cf.isIncome) {
          monthlyData[month]!['income'] = monthlyData[month]!['income']! + cf.displayAmount;
        } else {
          monthlyData[month]!['expense'] = monthlyData[month]!['expense']! + cf.displayAmount;
        }
      }
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      children: [
        // 月度汇总卡片
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('收支汇总', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: _SummaryChip(
                      label: '总收入',
                      value: Formatters.formatCurrency(provider.totalIncome),
                      color: Colors.green)),
                    Expanded(child: _SummaryChip(
                      label: '总支出',
                      value: Formatters.formatCurrency(provider.totalExpense),
                      color: Colors.red)),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...items.map((cf) => _CashFlowCard(
          cashFlow: cf,
          onEdit: () => _showForm(context, provider, cf),
          onDelete: () => _confirmDelete(context, provider, cf),
        )),
      ],
    );
  }

  void _showForm(BuildContext context, CashFlowProvider provider, CashFlow? cashFlow) {
    final descCtrl = TextEditingController(text: cashFlow?.description ?? '');
    final amountCtrl = TextEditingController(text: cashFlow != null ? cashFlow.displayAmount.toString() : '');
    String type = cashFlow?.type ?? 'income';
    String category = cashFlow?.category ?? AppConstants.incomeCategories.first;
    String frequency = cashFlow?.frequency ?? 'once';
    DateTime? date = cashFlow?.date != null ? DateTime.tryParse(cashFlow!.date!) : DateTime.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return StatefulBuilder(builder: (ctx, setModalState) {
          final categories = type == 'income' ? AppConstants.incomeCategories : AppConstants.expenseCategories;
          if (!categories.contains(category)) {
            category = categories.first;
          }

          return Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(cashFlow == null ? '添加记录' : '编辑记录',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  // 收入/支出切换
                  Row(
                    children: [
                      Expanded(child: ChoiceChip(
                        label: const Text('收入'),
                        selected: type == 'income',
                        selectedColor: Colors.green.withValues(alpha: 0.2),
                        onSelected: (_) => setModalState(() {
                          type = 'income';
                          category = AppConstants.incomeCategories.first;
                        }),
                      )),
                      const SizedBox(width: 12),
                      Expanded(child: ChoiceChip(
                        label: const Text('支出'),
                        selected: type == 'expense',
                        selectedColor: Colors.red.withValues(alpha: 0.2),
                        onSelected: (_) => setModalState(() {
                          type = 'expense';
                          category = AppConstants.expenseCategories.first;
                        }),
                      )),
                    ],
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: category,
                    decoration: const InputDecoration(
                      labelText: '分类', border: OutlineInputBorder(), prefixIcon: Icon(Icons.category)),
                    items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (v) => setModalState(() => category = v ?? categories.first),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: amountCtrl,
                    decoration: const InputDecoration(
                      labelText: '金额', border: OutlineInputBorder(), prefixIcon: Icon(Icons.monetization_on), suffixText: '元'),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: descCtrl,
                    decoration: const InputDecoration(
                      labelText: '描述', border: OutlineInputBorder(), prefixIcon: Icon(Icons.description)),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: frequency,
                    decoration: const InputDecoration(
                      labelText: '频率', border: OutlineInputBorder(), prefixIcon: Icon(Icons.repeat)),
                    items: AppConstants.frequencyLabels.entries.map((e) =>
                      DropdownMenuItem(value: e.key, child: Text(e.value))).toList(),
                    onChanged: (v) => setModalState(() => frequency = v ?? 'once'),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.calendar_today),
                    title: Text(date == null ? '选择日期' : Formatters.formatDate(date.toString())),
                    trailing: const Icon(Icons.chevron_right),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey[400]!),
                      borderRadius: BorderRadius.circular(8)),
                    onTap: () async {
                      final d = await showDatePicker(
                        context: ctx,
                        initialDate: date ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (d != null) setModalState(() => date = d);
                    },
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () async {
                      final data = CashFlow(
                        id: cashFlow?.id,
                        userId: AppConstants.defaultUserId,
                        type: type,
                        category: category,
                        amount: double.tryParse(amountCtrl.text) ?? 0,
                        description: descCtrl.text.trim().isEmpty ? null : descCtrl.text.trim(),
                        frequency: frequency,
                        date: date?.toIso8601String().split('T').first,
                      );
                      if (cashFlow == null) {
                        await provider.addCashFlow(data);
                      } else {
                        await provider.updateCashFlow(data);
                      }
                      if (ctx.mounted) Navigator.pop(ctx);
                    },
                    child: Text(cashFlow == null ? '添加记录' : '保存修改'),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void _confirmDelete(BuildContext context, CashFlowProvider provider, CashFlow cashFlow) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除这条${cashFlow.isIncome ? '收入' : '支出'}记录吗？'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('取消')),
          TextButton(
            onPressed: () { provider.deleteCashFlow(cashFlow.id!); Navigator.pop(context); },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
}

class _CashFlowCard extends StatelessWidget {
  final CashFlow cashFlow;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _CashFlowCard({required this.cashFlow, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final isIncome = cashFlow.isIncome;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isIncome ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
          child: Icon(isIncome ? Icons.arrow_upward : Icons.arrow_downward,
            color: isIncome ? Colors.green : Colors.red, size: 20),
        ),
        title: Text(cashFlow.description ?? cashFlow.category),
        subtitle: Text('${cashFlow.category} · ${cashFlow.frequencyLabel}'
          '${cashFlow.date != null ? ' · ${Formatters.formatDate(cashFlow.date!)}' : ''}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${isIncome ? '+' : '-'}${Formatters.formatCurrencyFull(cashFlow.displayAmount)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isIncome ? Colors.green : Colors.red,
              ),
            ),
            PopupMenuButton(
              itemBuilder: (_) => [
                const PopupMenuItem(value: 'edit', child: Text('编辑')),
                const PopupMenuItem(value: 'delete', child: Text('删除')),
              ],
              onSelected: (v) {
                if (v == 'edit') onEdit();
                if (v == 'delete') onDelete();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _SummaryChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: color)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
