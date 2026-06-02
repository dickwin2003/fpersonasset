import 'package:flutter/material.dart';
import '../../models/asset_type.dart';
import '../../utils/formatters.dart';

class AssetForm extends StatefulWidget {
  final dynamic asset;
  final List<AssetType> assetTypes;
  final Function(Map<String, dynamic>) onSave;

  const AssetForm({
    super.key,
    this.asset,
    required this.assetTypes,
    required this.onSave,
  });

  @override
  State<AssetForm> createState() => _AssetFormState();
}

class _AssetFormState extends State<AssetForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _valueController = TextEditingController();
  final _purchaseValueController = TextEditingController();
  final _descriptionController = TextEditingController();
  int? _selectedTypeId;
  DateTime? _purchaseDate;

  bool get isEditing => widget.asset != null;

  @override
  void initState() {
    super.initState();
    if (widget.asset != null) {
      final a = widget.asset;
      _nameController.text = a.name;
      _valueController.text = a.currentValue.toString();
      if (a.purchaseValue != null) _purchaseValueController.text = a.purchaseValue.toString();
      _descriptionController.text = a.description ?? '';
      _selectedTypeId = a.assetTypeId;
      if (a.purchaseDate != null) _purchaseDate = DateTime.tryParse(a.purchaseDate!);
    } else if (widget.assetTypes.isNotEmpty) {
      _selectedTypeId = widget.assetTypes.first.id;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    _purchaseValueController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16, right: 16, top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isEditing ? '编辑资产' : '添加资产',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '资产名称',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.label),
              ),
              validator: (v) => v == null || v.isEmpty ? '请输入名称' : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              initialValue: _selectedTypeId,
              decoration: const InputDecoration(
                labelText: '资产类型',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              items: widget.assetTypes.map((type) {
                return DropdownMenuItem(
                  value: type.id,
                  child: Text('${type.name} (${type.categoryLabel})'),
                );
              }).toList(),
              onChanged: (v) => setState(() => _selectedTypeId = v),
              validator: (v) => v == null ? '请选择类型' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _valueController,
              decoration: const InputDecoration(
                labelText: '当前价值',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.monetization_on),
                suffixText: '元',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (v) => v == null || v.isEmpty ? '请输入价值' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _purchaseValueController,
              decoration: const InputDecoration(
                labelText: '购入价值（选填）',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.shopping_cart),
                suffixText: '元',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today),
              title: Text(_purchaseDate == null
                  ? '购入日期（选填）'
                  : Formatters.formatDate(_purchaseDate.toString())),
              trailing: const Icon(Icons.chevron_right),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(8),
              ),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _purchaseDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (date != null) setState(() => _purchaseDate = date);
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: '描述（选填）',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _submit,
              child: Text(isEditing ? '保存修改' : '添加资产'),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    widget.onSave({
      'name': _nameController.text.trim(),
      'asset_type_id': _selectedTypeId!,
      'current_value': double.tryParse(_valueController.text) ?? 0,
      'purchase_value': _purchaseValueController.text.isNotEmpty
          ? double.tryParse(_purchaseValueController.text)
          : null,
      'purchase_date': _purchaseDate?.toIso8601String().split('T').first,
      'description': _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
    });
  }
}
