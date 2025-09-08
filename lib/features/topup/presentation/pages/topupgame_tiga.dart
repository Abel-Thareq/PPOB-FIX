import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/topup/presentation/pages/topupgame_empatberhasil.dart';
import 'package:ppob_app/features/topup/presentation/pages/topupgame_empatgagal.dart';

// Definisi halaman baru untuk konfirmasi PIN
class TopUpGameTiga extends StatefulWidget {
  final String gameTitle;
  final String gameId;
  final String serverId;
  final String selectedDiamond;
  final String price;

  const TopUpGameTiga({
    super.key,
    required this.gameTitle,
    required this.gameId,
    required this.serverId,
    required this.selectedDiamond,
    required this.price,
  });

  @override
  State<TopUpGameTiga> createState() => _TopUpGameTigaState();
}

class _TopUpGameTigaState extends State<TopUpGameTiga> {
  String enteredPin = '';
  final int pinLength = 6;

  // Fungsi untuk format mata uang
  String formatCurrency(String amount) {
    try {
      final int parsedAmount = int.parse(amount);
      return NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp',
        decimalDigits: 0,
      ).format(parsedAmount);
    } catch (e) {
      return 'Rp0';
    }
  }

  // Fungsi untuk menangani input angka
  void _onNumberPressed(String number) {
    if (enteredPin.length < pinLength) {
      setState(() {
        enteredPin += number;
      });
    }
  }

  // Fungsi untuk menghapus satu digit PIN
  void _onDeletePressed() {
    if (enteredPin.isNotEmpty) {
      setState(() {
        enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      });
    }
  }

  // Fungsi untuk validasi dan navigasi setelah PIN dimasukkan
  void _onSubmitPressed() {
    if (enteredPin.length == pinLength) {
      // Contoh sederhana navigasi, Anda bisa menambahkan logika yang lebih kompleks di sini
      if (enteredPin == '555555') {
        // Navigasi ke halaman berhasil
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TopUpGameEmpatBerhasil(
              gameTitle: widget.gameTitle,
              gameId: widget.gameId,
              serverId: widget.serverId,
              selectedDiamond: widget.selectedDiamond,
              price: widget.price,
            ),
          ),
        );
      } else {
        // Navigasi ke halaman gagal
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TopUpGameEmpatGagal(
              gameTitle: widget.gameTitle,
              gameId: widget.gameId,
              serverId: widget.serverId,
              selectedDiamond: widget.selectedDiamond,
              price: widget.price,
            ),
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
    ScreenUtil.init(context, designSize: const Size(360, 690));

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
            // HEADER gambar
            SizedBox(
              height: 100.h,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 100.h,
                    color: Colors.white,
                    child: Image.asset(
                      'assets/images/header.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, size: 28.r),
                        color: Colors.white,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),
            Text(
              "PIN Transaksi",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Silahkan Masukan PIN Anda",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 30.h),

            // PIN kotak
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pinLength,
                    (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Container(
                    width: 40.w,
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.white,
                      border: Border.all(
                        color: index < enteredPin.length
                            ? const Color(0xFF5938FB)
                            : Colors.grey.shade300,
                        width: 2.w,
                      ),
                    ),
                    child: index < enteredPin.length
                        ? Icon(Icons.circle,
                        size: 12.r, color: const Color(0xFF5938FB))
                        : null,
                  ),
                ),
              ),
            ),

            const Spacer(),

            // Keypad dengan background putih
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
              ),
              child: Column(
                children: [
                  _buildKeypadRow(['7', '8', '9']),
                  SizedBox(height: 20.h),
                  _buildKeypadRow(['4', '5', '6']),
                  SizedBox(height: 20.h),
                  _buildKeypadRow(['1', '2', '3']),
                  SizedBox(height: 20.h),
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
      borderRadius: BorderRadius.circular(32.r),
      child: Container(
        width: 64.w,
        height: 64.h,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(
              fontSize: 24.sp,
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
      borderRadius: BorderRadius.circular(32.r),
      child: Container(
        width: 64.w,
        height: 64.h,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
          child: Icon(
            Icons.backspace_outlined,
            size: 28.r,
            color: const Color(0xFF5938FB),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return InkWell(
      onTap: _onSubmitPressed,
      borderRadius: BorderRadius.circular(32.r),
      child: Container(
        width: 64.w,
        height: 64.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: enteredPin.length == pinLength
              ? const Color(0xFF5938FB)
              : Colors.grey,
        ),
        child: Center(
          child: Icon(
            Icons.check,
            size: 28.r,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
