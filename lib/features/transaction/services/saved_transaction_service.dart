import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/saved_transaction.dart';

class SavedTransactionService {
  static const String _key = 'saved_transactions';

  Future<List<SavedTransaction>> getSavedTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedData = prefs.getString(_key);

    if (savedData == null) return [];

    final List<dynamic> jsonData = json.decode(savedData);
    return jsonData.map((item) => SavedTransaction.fromJson(item)).toList();
  }

  Future<void> saveTransaction(SavedTransaction transaction) async {
    final prefs = await SharedPreferences.getInstance();
    List<SavedTransaction> currentTransactions = await getSavedTransactions();

    // Menambahkan transaksi baru ke awal list
    currentTransactions.insert(0, transaction);

    // Menyimpan kembali ke SharedPreferences
    final String jsonData = json.encode(
      currentTransactions.map((t) => t.toJson()).toList(),
    );

      await prefs.setString(_key, jsonData);
    }
  
    Future<void> deleteTransaction(String id) async {
      final prefs = await SharedPreferences.getInstance();
      List<SavedTransaction> currentTransactions = await getSavedTransactions();
  
      currentTransactions.removeWhere((transaction) => transaction.id == id);
  
      final String jsonData = json.encode(
        currentTransactions.map((t) => t.toJson()).toList(),
      );
  
      await prefs.setString(_key, jsonData);
    }
  }
