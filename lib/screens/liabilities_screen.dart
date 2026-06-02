import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
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
          final s = S.of(context);
          return Scaffold(
            body: provider.loading
                ? const Center(child: CircularProgressIndicator())
                : provider.liabilities.isEmpty
                    ? _buildEmpty(context, s)
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
              label: Text(s.liabilitiesAddLiability),
              backgroundColor: const Color(AppConstants.liabilityColor),
              foregroundColor: Colors.white,
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmpty(BuildContext context, S s) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.trending_down, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(s.liabilitiesEmpty, style: TextStyle(fontSize: 16, color: Colors.grey[500])),
          const SizedBox(height: 8),
          Text(s.liabilitiesEmptyHint, style: TextStyle(fontSize: 14, color: Colors.grey[400])),
        ],
      ),
    );
  }

  void _showForm(BuildContext context, LiabilityProvider provider, Liability? liability) {
    final s = S.of(context);
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
                  Text(liability == null ? s.liabilitiesAddLiability : s.liabilitiesEditLiability,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: nameCtrl,
                    decoration: InputDecoration(
                      labelText: s.liabilitiesName, border: const OutlineInputBorder(), prefixIcon: const Icon(Icons.label)),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: type,
                    decoration: InputDecoration(
                      labelText: s.liabilitiesType, border: const OutlineInputBorder(), prefixIcon: const Icon(Icons.category)),
                    items: AppConstants.liabilityTypes.map((t) =>
                      DropdownMenuItem(value: t, child: Text(AppConstants.getLiabilityTypeLabel(context, t)))).toList(),
                    onChanged: (v) => setModalState(() => type = v ?? 'other'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: amountCtrl,
                    decoration: InputDecoration(
                      labelText: s.liabilitiesTotalAmount, border: const OutlineInputBorder(), prefixIcon: const Icon(Icons.monetization_on), suffixText: s.currencyYuan),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(child: TextFormField(
                      controller: rateCtrl,
                      decoration: InputDecoration(
                        labelText: s.liabilitiesInterestRate, border: const OutlineInputBorder(), suffixText: '%'),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    )),
                    const SizedBox(width: 12),
                    Expanded(child: TextFormField(
                      controller: paymentCtrl,
                      decoration: InputDecoration(
                        labelText: s.liabilitiesMonthlyPayment, border: const OutlineInputBorder(), suffixText: s.currencyYuan),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    )),
                  ]),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(child: TextFormField(
                      controller: remainingCtrl,
                      decoration: InputDecoration(
                        labelText: s.liabilitiesRemainingAmount, border: const OutlineInputBorder(), suffixText: s.currencyYuan),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    )),
                    const SizedBox(width: 12),
                    Expanded(child: TextFormField(
                      controller: monthsCtrl,
                      decoration: InputDecoration(
                        labelText: s.liabilitiesRemainingMonths, border: const OutlineInputBorder(), suffixText: s.liabilitiesMonth),
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
                    child: Text(liability == null ? s.liabilitiesAddLiability : s.btnSave),
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
    final s = S.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.dialogConfirmDelete),
        content: Text(s.liabilitiesDeleteConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(s.btnCancel)),
          TextButton(
            onPressed: () { provider.deleteLiability(liability.id!); Navigator.pop(context); },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(s.btnDelete),
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
    final s = S.of(context);
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
                child: Text(Liability.getLiabilityTypeLabel(context, liability.liabilityType),
                  style: const TextStyle(fontSize: 12, color: Colors.red)),
              ),
            ]),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.liabilitiesRemainingAmount, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                  Text(Formatters.formatCurrencyFull(liability.remainingAmount ?? liability.amount),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
                ],
              )),
              if (liability.monthlyPayment != null) Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(s.liabilitiesMonthlyPayment, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
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
            Text('${s.liabilitiesPaidPercent} ${Formatters.formatPercent(liability.progressPercent * 100)}',
              style: TextStyle(fontSize: 12, color: Colors.grey[500])),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(onPressed: onEdit,
                  icon: const Icon(Icons.edit, size: 18), label: Text(s.btnEdit)),
                TextButton.icon(onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline, size: 18), label: Text(s.btnDelete),
                  style: TextButton.styleFrom(foregroundColor: Colors.red)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
