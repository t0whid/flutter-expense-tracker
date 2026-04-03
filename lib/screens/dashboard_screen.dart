import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/expense_pie_chart.dart';
import '../widgets/summary_card.dart';
import '../widgets/transaction_tile.dart';
import 'add_transaction_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Track your money beautifully',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            SummaryCard(
              title: 'Total Income',
              amount: '৳${provider.totalIncome.toStringAsFixed(0)}',
              icon: Icons.arrow_downward_rounded,
              iconBg: const Color(0xFFDCFCE7),
              iconColor: const Color(0xFF16A34A),
            ),
            const SizedBox(height: 14),
            SummaryCard(
              title: 'Total Expense',
              amount: '৳${provider.totalExpense.toStringAsFixed(0)}',
              icon: Icons.arrow_upward_rounded,
              iconBg: const Color(0xFFFEE2E2),
              iconColor: const Color(0xFFDC2626),
            ),
            const SizedBox(height: 14),
            SummaryCard(
              title: 'Current Balance',
              amount: '৳${provider.balance.toStringAsFixed(0)}',
              icon: Icons.account_balance_wallet_rounded,
              iconBg: const Color(0xFFE0E7FF),
              iconColor: const Color(0xFF4F46E5),
            ),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Expense Analytics',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Category insights and spending distribution',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7280),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ExpensePieChart(
                    data: provider.expenseCategoryTotals,
                    expenseCount: provider.filteredExpenseTransactions.length,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 10),
            if (provider.recentTransactions.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.receipt_long_rounded,
                      size: 42,
                      color: Color(0xFF9CA3AF),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'No transactions yet',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Add your first income or expense',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              )
            else
              ...provider.recentTransactions.map(
                    (tx) => TransactionTile(
                  transaction: tx,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddTransactionScreen(transaction: tx),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}