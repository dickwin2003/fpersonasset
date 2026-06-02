import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
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
          final s = S.of(context);
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text(s.cashFlowTitle),
                bottom: TabBar(
                  tabs: [
                    Tab(text: s.cashFlowPlannedTab),
                    Tab(text: s.cashFlowHistoricalTab),
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
                label: Text(s.cashFlowAddRecord),
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
    final s = S.of(context);
    final items = provider.planned;
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_note, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(s.cashFlowEmptyPlanned, style: TextStyle(color: Colors.grey[500])),
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
    final s = S.of(context);
    final items = provider.historical;
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(s.cashFlowEmptyHistorical, style: TextStyle(color: Colors.grey[500])),
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
                Text(s.cashFlowSummary, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: _SummaryChip(
                      label: s.cashFlowTotalIncome,
                      value: Formatters.formatCurrency(provider.totalIncome),
                      color: Colors.green)),
                    Expanded(child: _SummaryChip(
                      label: s.cashFlowTotalExpense,
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
    final s = S.of(context);
    final descCtrl = TextEditingController(text: cashFlow?.description ?? '');
    final amountCtrl = TextEditingController(text: cashFlow != null ? cashFlow.displayAmount.toString() : '');
    String type = cashFlow?.type ?? 'income';
    String category = cashFlow?.category ?? AppConstants.incomeCategoryKeys.first;
    String frequency = cashFlow?.frequency ?? 'once';
    DateTime? date = cashFlow?.date != null ? DateTime.tryParse(cashFlow!.date!) : DateTime.now();
    DateTime? startDate = cashFlow?.startDate != null ? DateTime.tryParse(cashFlow!.startDate!) : DateTime.now();
    DateTime? endDate = cashFlow?.endDate != null ? DateTime.tryParse(cashFlow!.endDate!) : null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return StatefulBuilder(builder: (ctx, setModalState) {
          final categories = type == 'income' ? AppConstants.incomeCategoryKeys : AppConstants.expenseCategoryKeys;
          if (!categories.contains(category)) {
            category = categories.first;
          }
          final isRecurring = frequency != 'once';

          return Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(cashFlow == null ? s.cashFlowAddRecord : s.cashFlowEditRecord,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  // 收入/支出切换
                  Row(
                    children: [
                      Expanded(child: ChoiceChip(
                        label: Text(s.cashFlowIncome),
                        selected: type == 'income',
                        selectedColor: Colors.green.withValues(alpha: 0.2),
                        onSelected: (_) => setModalState(() {
                          type = 'income';
                          category = AppConstants.incomeCategoryKeys.first;
                        }),
                      )),
                      const SizedBox(width: 12),
                      Expanded(child: ChoiceChip(
                        label: Text(s.cashFlowExpense),
                        selected: type == 'expense',
                        selectedColor: Colors.red.withValues(alpha: 0.2),
                        onSelected: (_) => setModalState(() {
                          type = 'expense';
                          category = AppConstants.expenseCategoryKeys.first;
                        }),
                      )),
                    ],
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: category,
                    decoration: InputDecoration(
                      labelText: s.cashFlowCategory, border: const OutlineInputBorder(), prefixIcon: const Icon(Icons.category)),
                    items: categories.map((c) {
                      final label = type == 'income'
                          ? AppConstants.getIncomeCategoryLabel(context, c)
                          : AppConstants.getExpenseCategoryLabel(context, c);
                      return DropdownMenuItem(value: c, child: Text(label));
                    }).toList(),
                    onChanged: (v) => setModalState(() => category = v ?? categories.first),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: amountCtrl,
                    decoration: InputDecoration(
                      labelText: s.cashFlowAmount, border: const OutlineInputBorder(), prefixIcon: const Icon(Icons.monetization_on), suffixText: s.currencyYuan),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: descCtrl,
                    decoration: InputDecoration(
                      labelText: s.cashFlowDescription, border: const OutlineInputBorder(), prefixIcon: const Icon(Icons.description)),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: frequency,
                    decoration: InputDecoration(
                      labelText: s.cashFlowFrequency, border: const OutlineInputBorder(), prefixIcon: const Icon(Icons.repeat)),
                    items: AppConstants.frequencyKeys.map((f) =>
                      DropdownMenuItem(value: f, child: Text(CashFlow.getFrequencyLabel(context, f)))).toList(),
                    onChanged: (v) => setModalState(() => frequency = v ?? 'once'),
                  ),
                  const SizedBox(height: 12),
                  // Date pickers: single date for once, start+end for recurring
                  if (!isRecurring) ...[
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.calendar_today),
                      title: Text(date == null ? s.cashFlowSelectDate : Formatters.formatDate(date.toString())),
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
                  ] else ...[
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.play_arrow),
                      title: Text(startDate == null ? s.cashFlowStartDate : Formatters.formatDate(startDate.toString())),
                      trailing: const Icon(Icons.chevron_right),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(8)),
                      onTap: () async {
                        final d = await showDatePicker(
                          context: ctx,
                          initialDate: startDate ?? DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (d != null) setModalState(() => startDate = d);
                      },
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.stop),
                      title: Text(endDate == null ? s.cashFlowEndDate : Formatters.formatDate(endDate.toString())),
                      trailing: const Icon(Icons.chevron_right),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(8)),
                      onTap: () async {
                        final d = await showDatePicker(
                          context: ctx,
                          initialDate: endDate ?? startDate ?? DateTime.now(),
                          firstDate: startDate ?? DateTime(2020),
                          lastDate: DateTime(2040),
                        );
                        if (d != null) setModalState(() => endDate = d);
                      },
                    ),
                  ],
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
                        date: !isRecurring ? date?.toIso8601String().split('T').first : null,
                        startDate: isRecurring ? startDate?.toIso8601String().split('T').first : null,
                        endDate: isRecurring ? endDate?.toIso8601String().split('T').first : null,
                      );
                      if (cashFlow == null) {
                        await provider.addCashFlow(data);
                      } else {
                        await provider.updateCashFlow(data);
                      }
                      if (ctx.mounted) Navigator.pop(ctx);
                    },
                    child: Text(cashFlow == null ? s.cashFlowAddRecord : s.cashFlowSaveRecord),
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
    final s = S.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.dialogConfirmDelete),
        content: Text(s.cashFlowDeleteConfirm(cashFlow.isIncome ? s.cashFlowIncome : s.cashFlowExpense)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(s.btnCancel)),
          TextButton(
            onPressed: () { provider.deleteCashFlow(cashFlow.id!); Navigator.pop(context); },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(s.btnDelete),
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
    final s = S.of(context);
    final isIncome = cashFlow.isIncome;
    final isRecurring = cashFlow.isRecurring;

    // Build date subtitle
    String dateText = '';
    if (isRecurring) {
      if (cashFlow.startDate != null && cashFlow.endDate != null) {
        dateText = ' · ${Formatters.formatDate(cashFlow.startDate!)} ~ ${Formatters.formatDate(cashFlow.endDate!)}';
      } else if (cashFlow.startDate != null) {
        dateText = ' · ${Formatters.formatDate(cashFlow.startDate!)} ~';
      }
    } else if (cashFlow.date != null) {
      dateText = ' · ${Formatters.formatDate(cashFlow.date!)}';
    }

    final categoryLabel = AppConstants.getCategoryLabelByType(context, cashFlow.category, cashFlow.type);
    final freqLabel = CashFlow.getFrequencyLabel(context, cashFlow.frequency);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isIncome ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
          child: Icon(isIncome ? Icons.arrow_upward : Icons.arrow_downward,
            color: isIncome ? Colors.green : Colors.red, size: 20),
        ),
        title: Text(cashFlow.description ?? categoryLabel),
        subtitle: Text('$categoryLabel · $freqLabel$dateText'),
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
                PopupMenuItem(value: 'edit', child: Text(s.btnEdit)),
                PopupMenuItem(value: 'delete', child: Text(s.btnDelete)),
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
