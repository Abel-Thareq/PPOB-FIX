import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/wakaf/presentation/pages/wakaf_tujuh_berhasil.dart';
import 'package:ppob_app/features/wakaf/presentation/pages/wakaf_tujuh_gagal.dart';
import 'wakaf_model.dart';

class WakafEnamPage extends StatefulWidget {
  final WakafModel wakaf;
  final int selectedAmount;
  final String selectedLabel;

  const WakafEnamPage({
    super.key,
    required this.wakaf,
    required this.selectedAmount,
    required this.selectedLabel,
  });

  @override
  State<WakafEnamPage> createState() => _WakafEnamPageState();
}

class _WakafEnamPageState extends State<WakafEnamPage> {
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
      if (enteredPin == '555555') {
        // Navigasi ke halaman berhasil
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WakafTujuhBerhasil(
              wakaf: widget.wakaf,
              selectedAmount: widget.selectedAmount,
              selectedLabel: widget.selectedLabel,
            ),
          ),
        );
      } else if (enteredPin == '111111') {
        // Navigasi ke halaman gagal
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WakafTujuhGagal(
              wakaf: widget.wakaf,
              selectedAmount: widget.selectedAmount,
              selectedLabel: widget.selectedLabel,
            ),
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

  // Format Rupiah dengan titik
  String _formatRupiah(int amount) {
    final format = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return format.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    final int adminFee = 0; // Biaya admin untuk wakaf biasanya 0
    final int totalAmount = widget.selectedAmount + adminFee;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6A1B9A), // Ungu tua
              Color(0xFF8E24AA), // Ungu muda
            ],
          ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 100.h,
                  child: Image.asset(
                    'assets/images/header.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                      iconSize: 28.r,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            
            // Judul "Masukan PIN Anda"
            Text(
              "Masukan PIN Anda",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30.h),
            
            // Tampilan titik-titik PIN
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
                            ? const Color(0xFF6A1B9A)
                            : Colors.grey.shade300,
                        width: 2.w,
                      ),
                    ),
                    child: index < enteredPin.length
                        ? Icon(Icons.circle,
                            size: 12.r, color: const Color(0xFF6A1B9A))
                        : null,
                  ),
                ),
              ),
            ),
            
            const Spacer(),
            
            // Keypad input PIN
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
              ),
              child: Column(
                children: [
                  _buildKeypadRow(['1', '2', '3']),
                  SizedBox(height: 20.h),
                  _buildKeypadRow(['4', '5', '6']),
                  SizedBox(height: 20.h),
                  _buildKeypadRow(['7', '8', '9']),
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
            color: const Color(0xFF6A1B9A),
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
              ? const Color(0xFF6A1B9A)
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