import 'package:flutter/material.dart';
import 'package:ppob_app/features/kai/presentation/pages/kai_enam_berhasil.dart';
import 'package:ppob_app/features/kai/presentation/pages/kai_enam_gagal.dart';

class KaiLimaPage extends StatefulWidget {
  final int nominalTagihan;
  final int biayaAdmin;
  final String namaPelanggan;
  final String kodeBayar;

  const KaiLimaPage({
    super.key,
    required this.nominalTagihan,
    required this.biayaAdmin,
    required this.namaPelanggan,
    required this.kodeBayar,
  });

  @override
  State<KaiLimaPage> createState() => _KaiLimaPageState();
}

class _KaiLimaPageState extends State<KaiLimaPage> {
  // State untuk menyimpan PIN yang dimasukkan.
  String enteredPin = '';
  // Panjang PIN yang dibutuhkan.
  final int pinLength = 6;

  // Fungsi saat tombol angka ditekan.
  void _onNumberPressed(String number) {
    if (enteredPin.length < pinLength) {
      setState(() {
        enteredPin += number;
      });
    }
  }

  // Fungsi saat tombol hapus ditekan.
  void _onDeletePressed() {
    if (enteredPin.isNotEmpty) {
      setState(() {
        enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      });
    }
  }

  // Fungsi saat tombol konfirmasi ditekan.
  void _onSubmitPressed() {
    if (enteredPin.length == pinLength) {
      // Simulasikan validasi PIN
      // PIN "555555" dianggap berhasil
      // PIN "111111" dianggap gagal karena jaringan
      // PIN lainnya dianggap salah
      if (enteredPin == '555555') {
        // Navigasi ke halaman berhasil
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KaiEnamBerhasil(
              nominalTagihan: widget.nominalTagihan,
              biayaAdmin: widget.biayaAdmin,
              namaPelanggan: widget.namaPelanggan,
              kodeBayar: widget.kodeBayar,
            ),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Transaksi Berhasil!"),
            backgroundColor: Colors.green,
          ),
        );
      } else if (enteredPin == '111111') {
        // Navigasi ke halaman gagal
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KaiEnamGagal(
              nominalTagihan: widget.nominalTagihan,
              biayaAdmin: widget.biayaAdmin,
              namaPelanggan: widget.namaPelanggan,
              kodeBayar: widget.kodeBayar,
            ),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Transaksi Gagal! Jaringan bermasalah."),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Pin yang Anda Masukkan Salah. Silahkan Coba lagi"),
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
              Color(0xFF5938FB),
              Color(0xFF8B6BFF),
            ],
          ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 120,
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
              "Masukan PIN Anda",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pinLength,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Container(
                    width: 40,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(
                        color: index < enteredPin.length
                            ? const Color(0xFF5938FB)
                            : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: index < enteredPin.length
                        ? const Icon(Icons.circle,
                            size: 12, color: Color(0xFF5938FB))
                        : null,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDeleteButton(),
                      _buildNumberButton('0'),
                      _buildSubmitButton(),
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
            color: Color(0xFF5938FB),
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
              ? const Color(0xFF5938FB)
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
