import 'package:hive_flutter/hive_flutter.dart';
import '../models/transaction_model.dart';

class HiveService {
  static const String transactionBoxName = 'transactions';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TransactionModelAdapter());
    await Hive.openBox<TransactionModel>(transactionBoxName);
  }

  static Box<TransactionModel> getTransactionBox() {
    return Hive.box<TransactionModel>(transactionBoxName);
  }
}