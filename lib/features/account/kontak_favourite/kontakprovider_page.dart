import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KontakProvider with ChangeNotifier {
  List<Map<String, String>> _kontakList = [];

  List<Map<String, String>> get kontakList => _kontakList;

  KontakProvider() {
    loadKontak();
  }

  Future<void> loadKontak() async {
    final prefs = await SharedPreferences.getInstance();
    final kontakJson = prefs.getString('kontakList');
    if (kontakJson != null) {
      _kontakList = List<Map<String, String>>.from(jsonDecode(kontakJson));
      notifyListeners();
    }
  }

  Future<void> tambahKontak(String nomor, String nama, String jenis) async {
    _kontakList.add({
      "nomor": nomor,
      "nama": nama,
      "jenis": jenis,
    });
    await _saveKontak();
    notifyListeners();
  }

  Future<void> hapusKontak(int index) async {
    _kontakList.removeAt(index);
    await _saveKontak();
    notifyListeners();
  }

  Future<void> _saveKontak() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('kontakList', jsonEncode(_kontakList));
  }
}