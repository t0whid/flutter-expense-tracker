import 'dart:convert';
import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../models/transaction_model.dart';

class ExportService {
  static Future<void> exportTransactionsAsCsv(
      List<TransactionModel> transactions,
      ) async {
    final directory = await getTemporaryDirectory();
    final fileName =
        'expense_tracker_backup_${DateTime.now().millisecondsSinceEpoch}.csv';
    final file = File('${directory.path}/$fileName');

    final buffer = StringBuffer();
    buffer.writeln('id,type,category,amount,note,date');

    for (final tx in transactions) {
      buffer.writeln(
        [
          _escapeCsv(tx.id),
          _escapeCsv(tx.type),
          _escapeCsv(tx.category),
          tx.amount.toString(),
          _escapeCsv(tx.note),
          tx.date.toIso8601String(),
        ].join(','),
      );
    }

    await file.writeAsString(buffer.toString(), flush: true);

    await SharePlus.instance.share(
      ShareParams(
        title: 'Export CSV',
        subject: 'Expense Tracker CSV Backup',
        text: 'Expense Tracker data export (CSV)',
        files: [XFile(file.path)],
      ),
    );
  }

  static Future<void> exportTransactionsAsJson(
      List<TransactionModel> transactions,
      ) async {
    final directory = await getTemporaryDirectory();
    final fileName =
        'expense_tracker_backup_${DateTime.now().millisecondsSinceEpoch}.json';
    final file = File('${directory.path}/$fileName');

    final data = transactions
        .map(
          (tx) => {
        'id': tx.id,
        'type': tx.type,
        'category': tx.category,
        'amount': tx.amount,
        'note': tx.note,
        'date': tx.date.toIso8601String(),
      },
    )
        .toList();

    const encoder = JsonEncoder.withIndent('  ');
    await file.writeAsString(encoder.convert(data), flush: true);

    await SharePlus.instance.share(
      ShareParams(
        title: 'Backup JSON',
        subject: 'Expense Tracker JSON Backup',
        text: 'Expense Tracker data backup (JSON)',
        files: [XFile(file.path)],
      ),
    );
  }

  static String _escapeCsv(String value) {
    final safe = value.replaceAll('"', '""');
    return '"$safe"';
  }
}