import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/transaction_tile.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String filter = 'all';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();

    final items = provider.transactions.where((tx) {
      if (filter == 'all') return true;
      return tx.type == filter;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('All Transactions')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: DropdownButtonFormField<String>(
              value: filter,
              items: const [
                DropdownMenuItem(value: 'all', child: Text('All')),
                DropdownMenuItem(value: 'income', child: Text('Income')),
                DropdownMenuItem(value: 'expense', child: Text('Expense')),
              ],
              onChanged: (value) {
                setState(() {
                  filter = value!;
                });
              },
              decoration: const InputDecoration(labelText: 'Filter'),
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text('No transactions found'))
                : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final tx = items[index];
                return TransactionTile(
                  transaction: tx,
                  onDelete: () async {
                    await provider.deleteTransaction(tx.id);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}