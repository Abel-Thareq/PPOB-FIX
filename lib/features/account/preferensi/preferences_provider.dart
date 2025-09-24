import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProvider with ChangeNotifier {
  String _fontFamily = 'Metropolis';
  double _fontSizeMultiplier = 1.0;

  bool _showLogo = true;
  bool _showAddress = true;
  bool _showPhone = true;

  Color _successColor = Colors.green;
  Color _failedColor = Colors.red;

  // Getter
  String get fontFamily => _fontFamily;
  double get fontSizeMultiplier => _fontSizeMultiplier;

  bool get showLogo => _showLogo;
  bool get showAddress => _showAddress;
  bool get showPhone => _showPhone;

  Color get successColor => _successColor;
  Color get failedColor => _failedColor;

  PreferencesProvider() {
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    _fontFamily = prefs.getString('fontFamily') ?? 'Metropolis';
    _fontSizeMultiplier = prefs.getDouble('fontSizeMultiplier') ?? 1.0;

    _showLogo = prefs.getBool('showLogo') ?? true;
    _showAddress = prefs.getBool('showAddress') ?? true;
    _showPhone = prefs.getBool('showPhone') ?? true;

    // Ambil warna (simpan sebagai int di prefs)
    _successColor =
        Color(prefs.getInt('successColor') ?? Colors.green.value);
    _failedColor = Color(prefs.getInt('failedColor') ?? Colors.red.value);

    notifyListeners();
  }

  Future<void> setPreferences(
    String newFontFamily,
    double newSizeMultiplier, {
    Color? successColor,
    Color? failedColor,
    bool? showLogo,
    bool? showAddress,
    bool? showPhone,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    _fontFamily = newFontFamily;
    _fontSizeMultiplier = newSizeMultiplier;
    await prefs.setString('fontFamily', newFontFamily);
    await prefs.setDouble('fontSizeMultiplier', newSizeMultiplier);

    if (successColor != null) {
      _successColor = successColor;
      await prefs.setInt('successColor', successColor.value);
    }

    if (failedColor != null) {
      _failedColor = failedColor;
      await prefs.setInt('failedColor', failedColor.value);
    }

    if (showLogo != null) {
      _showLogo = showLogo;
      await prefs.setBool('showLogo', showLogo);
    }
    if (showAddress != null) {
      _showAddress = showAddress;
      await prefs.setBool('showAddress', showAddress);
    }
    if (showPhone != null) {
      _showPhone = showPhone;
      await prefs.setBool('showPhone', showPhone);
    }

    notifyListeners();
  }

  /// 🔹 Method khusus untuk pengaturan struk
  Future<void> setStrukPreferences({
    required bool showLogo,
    required bool showPhone,
    required bool showAddress,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    _showLogo = showLogo;
    _showPhone = showPhone;
    _showAddress = showAddress;

    await prefs.setBool('showLogo', showLogo);
    await prefs.setBool('showPhone', showPhone);
    await prefs.setBool('showAddress', showAddress);

    notifyListeners();
  }
}