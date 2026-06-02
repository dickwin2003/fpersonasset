import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../providers/password_provider.dart';
import '../utils/constants.dart';

class LockScreen extends StatefulWidget {
  final PasswordProvider passwordProvider;

  const LockScreen({super.key, required this.passwordProvider});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final List<String> _input = [];
  String? _error;
  static const int _pinLength = 4;

  void _onKeyTap(String value) {
    if (_input.length >= _pinLength) return;
    setState(() {
      _input.add(value);
      _error = null;
    });

    if (_input.length == _pinLength) {
      _verify();
    }
  }

  void _onDelete() {
    if (_input.isEmpty) return;
    setState(() {
      _input.removeLast();
      _error = null;
    });
  }

  Future<void> _verify() async {
    final password = _input.join('');
    final correct = await widget.passwordProvider.verifyPassword(password);
    if (correct) {
      widget.passwordProvider.unlock();
    } else {
      setState(() {
        _input.clear();
        _error = S.of(context).lockWrongPassword;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            // App icon
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF42A5F5), Color(0xFF1976D2)],
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(s.appName, style: const TextStyle(
                  fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 24),
            Text(s.lockTitle, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(s.lockSubtitle, style: TextStyle(color: Colors.grey[500], fontSize: 14)),
            const SizedBox(height: 32),
            // PIN dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pinLength, (i) {
                final filled = i < _input.length;
                return Container(
                  width: 20, height: 20,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: filled ? const Color(AppConstants.primaryColor) : Colors.transparent,
                    border: Border.all(
                      color: filled ? const Color(AppConstants.primaryColor) : Colors.grey[400]!,
                      width: 2,
                    ),
                  ),
                );
              }),
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: Colors.red, fontSize: 14)),
            ],
            const Spacer(flex: 1),
            // Numpad
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Column(
                children: [
                  _buildRow(['1', '2', '3']),
                  _buildRow(['4', '5', '6']),
                  _buildRow(['7', '8', '9']),
                  _buildRow(['', '0', 'del']),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((key) {
        if (key == 'del') {
          return _buildDeleteKey();
        } else if (key.isEmpty) {
          return const SizedBox(width: 72, height: 72);
        } else {
          return _buildNumberKey(key);
        }
      }).toList(),
    );
  }

  Widget _buildNumberKey(String number) {
    return InkWell(
      onTap: () => _onKeyTap(number),
      borderRadius: BorderRadius.circular(36),
      child: Container(
        width: 72, height: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[300]!, width: 1.5),
        ),
        child: Center(
          child: Text(number, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }

  Widget _buildDeleteKey() {
    return InkWell(
      onTap: _onDelete,
      borderRadius: BorderRadius.circular(36),
      child: const SizedBox(
        width: 72, height: 72,
        child: Center(
          child: Icon(Icons.backspace_outlined, size: 28, color: Colors.grey),
        ),
      ),
    );
  }
}
