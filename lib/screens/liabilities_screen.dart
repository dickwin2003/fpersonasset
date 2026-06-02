import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/liability_provider.dart';
import '../models/liability.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';

class LiabilitiesScreen extends StatelessWidget {
  const LiabilitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LiabilityProvider()..loadLiabilities(),
      child: Consumer<LiabilityProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            body: provider.loading
                ? const Center(child: CircularProgressIndicator())
                : provider.liabilities.isEmpty
                    ? _buildEmpty(context)
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                        itemCount: provider.liabilities.length,
                        itemBuilder: (context, index) {
                          final liability = provider.liabilities[index];
                          return _LiabilityCard(
                            liability: liability,
                            onEdit: () => _showForm(context, provider, liability),
                            onDelete: () => _confirmDelete(context, provider, liability),
                          );
                        },
                      ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _showForm(context, provider, null),
              icon: const Icon(Icons.add),
              label: const Text('添加负债'),
              backgroundColor: const Color(AppConstants.liabilityColor),
              foregroundColor: Colors.white,
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.trending_down, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text('还没有负债记录', style: TextStyle(fontSize: 16, color: Colors.grey[500])),
          const SizedBox(height: 8),
          Text('点击下方按钮添加负债信息', style: TextStyle(fontSize: 14, color: Colors.grey[400])),
        ],
      ),
    );
  }

  void _showForm(BuildContext context, LiabilityProvider provider, Liability? liability) {
    final nameCtrl = TextEditingController(text: liability?.name ?? '');
    final amountCtrl = TextEditingController(text: liability?.amount.toString() ?? '');
    final rateCtrl = TextEditingController(text: liability?.interestRate?.toString() ?? '');
    final paymentCtrl = TextEditingController(text: liability?.monthlyPayment?.toString() ?? '');
    final remainingCtrl = TextEditingController(text: liability?.remainingAmount?.toString() ?? '');
    final monthsCtrl = TextEditingController(text: liability?.remainingMonths?.toString() ?? '');
    String type = liability?.liabilityType ?? 'other';
    DateTime? startDate = liability?.startDate != null ? DateTime.tryParse(liability!.startDate!) : null;
    DateTime? endDate = liability?.endDate != null ? DateTime.tryParse(liability!.endDate!) : null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return StatefulBuilder(builder: (ctx, setModalState) {
          return Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(liability == null ? '添加负债' : '编辑负债',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(
                      labelText: '负债名称', border: OutlineInputBorder(), prefixIcon: Icon(Icons.label)),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: type,
                    decoration: const InputDecoration(
                      labelText: '负债类型', border: OutlineInputBorder(), prefixIcon: Icon(Icons.category)),
                    items: AppConstants.liabilityTypeLabels.entries.map((e) =>
                      DropdownMenuItem(value: e.key, child: Text(e.value))).toList(),
                    onChanged: (v) => setModalState(() => type = v ?? 'other'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: amountCtrl,
                    decoration: const InputDecoration(
                      labelText: '总金额', border: OutlineInputBorder(), prefixIcon: Icon(Icons.monetization_on), suffixText: '元'),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(child: TextFormField(
                      controller: rateCtrl,
                      decoration: const InputDecoration(
                        labelText: '利率', border: OutlineInputBorder(), suffixText: '%'),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    )),
                    const SizedBox(width: 12),
                    Expanded(child: TextFormField(
                      controller: paymentCtrl,
                      decoration: const InputDecoration(
                        labelText: '月供', border: OutlineInputBorder(), suffixText: '元'),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    )),
                  ]),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(child: TextFormField(
                      controller: remainingCtrl,
                      decoration: const InputDecoration(
                        labelText: '剩余金额', border: OutlineInputBorder(), suffixText: '元'),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    )),
                    const SizedBox(width: 12),
                    Expanded(child: TextFormField(
                      controller: monthsCtrl,
                      decoration: const InputDecoration(
                        labelText: '剩余期数', border: OutlineInputBorder(), suffixText: '月'),
                      keyboardType: TextInputType.number,
                    )),
                  ]),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () async {
                      final data = Liability(
                        id: liability?.id,
                        userId: AppConstants.defaultUserId,
                        name: nameCtrl.text.trim(),
                        liabilityType: type,
                        amount: double.tryParse(amountCtrl.text) ?? 0,
                        interestRate: double.tryParse(rateCtrl.text),
                        monthlyPayment: double.tryParse(paymentCtrl.text),
                        remainingAmount: double.tryParse(remainingCtrl.text),
                        remainingMonths: int.tryParse(monthsCtrl.text),
                        startDate: startDate?.toIso8601String().split('T').first,
                        endDate: endDate?.toIso8601String().split('T').first,
                      );
                      if (liability == null) {
                        await provider.addLiability(data);
                      } else {
                        await provider.updateLiability(data);
                      }
                      if (ctx.mounted) Navigator.pop(ctx);
                    },
                    child: Text(liability == null ? '添加负债' : '保存修改'),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void _confirmDelete(BuildContext context, LiabilityProvider provider, Liability liability) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除负债「${liability.name}」吗？'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('取消')),
          TextButton(
            onPressed: () { provider.deleteLiability(liability.id!); Navigator.pop(context); },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
}

class _LiabilityCard extends StatelessWidget {
  final Liability liability;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _LiabilityCard({required this.liability, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Expanded(child: Text(liability.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                child: Text(liability.liabilityTypeLabel,
                  style: const TextStyle(fontSize: 12, color: Colors.red)),
              ),
            ]),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('剩余金额', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                  Text(Formatters.formatCurrencyFull(liability.remainingAmount ?? liability.amount),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
                ],
              )),
              if (liability.monthlyPayment != null) Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('月供', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                  Text(Formatters.formatCurrencyFull(liability.monthlyPayment!),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              )),
            ]),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: liability.progressPercent,
                backgroundColor: Colors.red.withValues(alpha: 0.1),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 4),
            Text('已还 ${Formatters.formatPercent(liability.progressPercent * 100)}',
              style: TextStyle(fontSize: 12, color: Colors.grey[500])),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(onPressed: onEdit,
                  icon: const Icon(Icons.edit, size: 18), label: const Text('编辑')),
                TextButton.icon(onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline, size: 18), label: const Text('删除'),
                  style: TextButton.styleFrom(foregroundColor: Colors.red)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
