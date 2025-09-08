import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Import halaman sukses dan gagal PBB
import 'package:ppob_app/features/pbb/presentation/pages/pbb_lima_berhasil.dart';
import 'package:ppob_app/features/pbb/presentation/pages/pbb_lima_gagal.dart';

class PbbEmpatPage extends StatefulWidget {
  final int nominalBayar;
  final int denda;
  final int biayaAdmin;
  final String keterangan;
  final String lokasi;
  final String namaPelanggan;
  final String nomorObjekPajak;
  final String kabupaten;
  final String tahun;

  const PbbEmpatPage({
    super.key,
    required this.nominalBayar,
    required this.denda,
    required this.biayaAdmin,
    required this.keterangan,
    required this.lokasi,
    required this.namaPelanggan,
    required this.nomorObjekPajak,
    required this.kabupaten,
    required this.tahun,
  });

  @override
  State<PbbEmpatPage> createState() => _PbbEmpatPageState();
}

class _PbbEmpatPageState extends State<PbbEmpatPage> {
  String enteredPin = '';
  final int pinLength = 6;

  String formatCurrency(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }

  void _onNumberPressed(String number) {
    if (enteredPin.length < pinLength) {
      setState(() {
        enteredPin += number;
      });
    }
  }

  void _onDeletePressed() {
    if (enteredPin.isNotEmpty) {
      setState(() {
        enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      });
    }
  }

  void _onSubmitPressed() {
    if (enteredPin.length == pinLength) {

      // Logika untuk navigasi berdasarkan PIN
      if (enteredPin == '555555') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PbbLimaBerhasilPage(
              // Data yang sudah diperbaiki untuk dikirim semua
              nominalBayar: widget.nominalBayar,
              denda: widget.denda,
              biayaAdmin: widget.biayaAdmin,
              keterangan: widget.keterangan,
              lokasi: widget.lokasi,
              namaPelanggan: widget.namaPelanggan,
              nomorObjekPajak: widget.nomorObjekPajak,
              kabupaten: widget.kabupaten,
              tahun: widget.tahun,
            ),
          ),
        );
      } else if (enteredPin == '111111') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PbbLimaGagalPage(
              // Data yang sudah diperbaiki untuk dikirim semua
              nominalBayar: widget.nominalBayar,
              denda: widget.denda,
              biayaAdmin: widget.biayaAdmin,
              keterangan: widget.keterangan,
              lokasi: widget.lokasi,
              namaPelanggan: widget.namaPelanggan,
              nomorObjekPajak: widget.nomorObjekPajak,
              kabupaten: widget.kabupaten,
              tahun: widget.tahun,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("PIN salah. Silakan coba lagi."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("PIN harus 6 digit"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF5938FB), // Mengubah warna ungu atas
              Color(0xFF8B6BFF), // Warna ungu bawah tetap
            ],
          ),
        ),
        child: Column(
          children: [
            // HEADER gambar
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 120, // Ketinggian header dikurangi
                  child: Image.asset(
                    'assets/images/header.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                      iconSize: 28,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            const Text(
              "PIN Transaksi",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Silahkan Masukan PIN Anda",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 30),

            // PIN kotak
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pinLength,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Container(
                    width: 40,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(
                        color: index < enteredPin.length
                            ? const Color(0xFF5938FB) // Warna border pin ungu
                            : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: index < enteredPin.length
                        ? const Icon(Icons.circle,
                        size: 12, color: Color(0xFF5938FB)) // Warna pin ungu
                        : null,
                  ),
                ),
              ),
            ),

            const Spacer(),

            // Keypad dengan background putih
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  _buildKeypadRow(['1', '2', '3']),
                  const SizedBox(height: 20),
                  _buildKeypadRow(['4', '5', '6']),
                  const SizedBox(height: 20),
                  _buildKeypadRow(['7', '8', '9']),
                  const SizedBox(height: 20),
                  // Baris bawah yang sudah diubah
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDeleteButton(), // Tombol hapus di kiri
                      _buildNumberButton('0'), // Tombol 0 di tengah
                      _buildSubmitButton(), // Tombol centang di kanan
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypadRow(List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((n) => _buildNumberButton(n)).toList(),
    );
  }

  Widget _buildNumberButton(String number) {
    return InkWell(
      onTap: () => _onNumberPressed(number),
      borderRadius: BorderRadius.circular(32),
      child: Container(
        width: 64,
        height: 64,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return InkWell(
      onTap: _onDeletePressed,
      borderRadius: BorderRadius.circular(32),
      child: Container(
        width: 64,
        height: 64,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: const Center(
          child: Icon(
            Icons.backspace_outlined,
            size: 28,
            color: Color(0xFF5938FB), // Warna ikon ungu
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return InkWell(
      onTap: _onSubmitPressed,
      borderRadius: BorderRadius.circular(32),
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: enteredPin.length == pinLength
              ? const Color(0xFF5938FB) // Warna tombol submit ungu
              : Colors.grey,
        ),
        child: const Center(
          child: Icon(
            Icons.check,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
