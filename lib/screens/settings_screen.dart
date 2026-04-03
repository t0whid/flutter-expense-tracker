import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../services/export_service.dart';
import '../widgets/app_snackbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _exportCsv(BuildContext context) async {
    final provider = context.read<TransactionProvider>();

    if (provider.transactions.isEmpty) {
      AppSnackbar.showError(context, 'No transactions available to export');
      return;
    }

    try {
      await ExportService.exportTransactionsAsCsv(provider.transactions);

      if (!context.mounted) return;
      AppSnackbar.showSuccess(context, 'CSV export ready');
    } catch (_) {
      if (!context.mounted) return;
      AppSnackbar.showError(context, 'Failed to export CSV');
    }
  }

  Future<void> _backupJson(BuildContext context) async {
    final provider = context.read<TransactionProvider>();

    if (provider.transactions.isEmpty) {
      AppSnackbar.showError(context, 'No transactions available to back up');
      return;
    }

    try {
      await ExportService.exportTransactionsAsJson(provider.transactions);

      if (!context.mounted) return;
      AppSnackbar.showSuccess(context, 'JSON backup ready');
    } catch (_) {
      if (!context.mounted) return;
      AppSnackbar.showError(context, 'Failed to create JSON backup');
    }
  }

  Future<void> _confirmReset(BuildContext context) async {
    final provider = context.read<TransactionProvider>();

    final shouldReset = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reset all data?'),
          content: const Text(
            'This will permanently delete all transactions from the app. This action cannot be undone.',
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );

    if (shouldReset == true) {
      try {
        await provider.clearAllTransactions();

        if (!context.mounted) return;
        AppSnackbar.showSuccess(context, 'All transaction data has been reset');
      } catch (_) {
        if (!context.mounted) return;
        AppSnackbar.showError(context, 'Failed to reset app data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 22,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Data Management',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${provider.transactions.length} saved transactions',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _SettingsTile(
                  icon: Icons.table_chart_rounded,
                  iconBg: const Color(0xFFE0F2FE),
                  iconColor: const Color(0xFF0284C7),
                  title: 'Export as CSV',
                  subtitle: 'Download/share your transaction data in CSV format',
                  onTap: () => _exportCsv(context),
                ),
                const Divider(height: 24),
                _SettingsTile(
                  icon: Icons.backup_rounded,
                  iconBg: const Color(0xFFEDE9FE),
                  iconColor: const Color(0xFF7C3AED),
                  title: 'Backup as JSON',
                  subtitle: 'Create a structured JSON backup of all transactions',
                  onTap: () => _backupJson(context),
                ),
                const Divider(height: 24),
                _SettingsTile(
                  icon: Icons.delete_sweep_rounded,
                  iconBg: const Color(0xFFFEE2E2),
                  iconColor: const Color(0xFFDC2626),
                  title: 'Reset all data',
                  subtitle: 'Delete all saved transactions from the app',
                  onTap: () => _confirmReset(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 22,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E7FF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.info_outline_rounded,
                      color: Color(0xFF4F46E5),
                    ),
                  ),
                  title: const Text(
                    'App version',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111827),
                    ),
                  ),
                  subtitle: const Text('Expense Tracker'),
                  trailing: Text(
                    'v1.0.0',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF6B7280),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF9CA3AF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}