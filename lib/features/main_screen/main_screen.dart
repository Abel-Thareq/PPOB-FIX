import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter/services.dart';
import 'package:ppob_app/core/widgets/custom_navbar.dart';
import 'package:ppob_app/features/home/presentation/pages/home_page.dart';
import 'package:ppob_app/features/account/presentation/pages/account_page.dart';
import 'package:ppob_app/features/agent/presentation/pages/agent_center_page.dart';
import 'package:ppob_app/features/shop/shop_page.dart';
import 'package:ppob_app/features/transaction/presentation/pages/mutasitransaksi_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Default tab ke Home (index 2)
  int _selectedIndex = 2;

  // Urutan halaman harus sesuai dengan urutan ikon di CustomNavBar
  final List<Widget> _pages = const [
    ShopPage(),
    MutasiTransaksiPage(),
    HomePage(),
    AgentCenterPage(),
    AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    // ✅ Kalau bukan di HomePage, pindahkan ke HomePage
    if (_selectedIndex != 2) {
      setState(() {
        _selectedIndex = 2;
      });
      return false; // cegah keluar
    }

    // ✅ Kalau sudah di HomePage, blok tombol back (tidak keluar app)
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: CustomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}