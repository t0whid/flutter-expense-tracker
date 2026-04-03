import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../services/hive_service.dart';

class TransactionProvider extends ChangeNotifier {
  final box = HiveService.getTransactionBox();

  List<TransactionModel> get transactions {
    final items = box.values.toList();
    items.sort((a, b) => b.date.compareTo(a.date));
    return items;
  }

  List<TransactionModel> get recentTransactions {
    return transactions.take(5).toList();
  }

  double get totalIncome {
    return transactions
        .where((t) => t.type == 'income')
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get totalExpense {
    return transactions
        .where((t) => t.type == 'expense')
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get balance => totalIncome - totalExpense;

  Future<void> addTransaction(TransactionModel transaction) async {
    await box.put(transaction.id, transaction);
    notifyListeners();
  }

  Future<void> deleteTransaction(String id) async {
    await box.delete(id);
    notifyListeners();
  }

  List<TransactionModel> get filteredExpenseTransactions {
    return transactions.where((t) => t.type == 'expense').toList();
  }

  Map<String, double> get expenseCategoryTotals {
    final Map<String, double> result = {};
    for (final tx in filteredExpenseTransactions) {
      result[tx.category] = (result[tx.category] ?? 0) + tx.amount;
    }
    return result;
  }

  List<TransactionModel> searchTransactions({
    required String filter,
    required String query,
  }) {
    return transactions.where((tx) {
      final matchesFilter = filter == 'all' ? true : tx.type == filter;
      final q = query.trim().toLowerCase();

      final matchesQuery = q.isEmpty ||
          tx.category.toLowerCase().contains(q) ||
          tx.note.toLowerCase().contains(q);

      return matchesFilter && matchesQuery;
    }).toList();
  }
}