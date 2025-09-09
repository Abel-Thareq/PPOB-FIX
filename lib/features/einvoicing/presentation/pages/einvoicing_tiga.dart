import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Placeholder untuk halaman berhasil
class EinvoicingBerhasilPage extends StatelessWidget {
  const EinvoicingBerhasilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Transaksi Berhasil!"),
      ),
    );
  }
}

// Placeholder untuk halaman gagal
class EinvoicingGagalPage extends StatelessWidget {
  const EinvoicingGagalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Transaksi Gagal!"),
      ),
    );
  }
}

class EinvoicingTigaPage extends StatefulWidget {
  final String publisher;
  final String paymentCode;

  const EinvoicingTigaPage({
    super.key,
    required this.publisher,
    required this.paymentCode,
  });

  @override
  State<EinvoicingTigaPage> createState() => _EinvoicingTigaPageState();
}

class _EinvoicingTigaPageState extends State<EinvoicingTigaPage> {
  String enteredPin = '';
  final int pinLength = 6;

  // Fungsi saat tombol angka ditekan
  void _onNumberPressed(String number) {
    if (enteredPin.length < pinLength) {
      setState(() {
        enteredPin += number;
      });
    }
  }

  // Fungsi saat tombol hapus ditekan
  void _onDeletePressed() {
    if (enteredPin.isNotEmpty) {
      setState(() {
        enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      });
    }
  }

  // Fungsi saat tombol konfirmasi ditekan
  void _onSubmitPressed() {
    if (enteredPin.length == pinLength) {
      // Simulasikan validasi PIN
      // PIN "555555" dianggap berhasil
      if (enteredPin == '555555') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EinvoicingBerhasilPage(),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Transaksi Berhasil!"),
            backgroundColor: Colors.green,
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
            // Header
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 120.h,
                  child: Image.asset(
                    'assets/images/header.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
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
            Text(
              "Masukan PIN Anda",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30.h),
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
                        ? Icon(
                            Icons.circle,
                            size: 12.r,
                            color: const Color(0xFF5938FB),
                          )
                        : null,
                  ),
                ),
              ),
            ),
            const Spacer(),
            // Keypad
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
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
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
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
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
      onTap: enteredPin.length == pinLength ? _onSubmitPressed : null,
      borderRadius: BorderRadius.circular(32.r),
      child: Container(
        width: 64.w,
        height: 64.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: enteredPin.length == pinLength
              ? const Color(0xFF5938FB)
              : Colors.grey,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
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
