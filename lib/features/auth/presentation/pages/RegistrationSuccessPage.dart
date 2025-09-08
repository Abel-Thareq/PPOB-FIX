import 'package:flutter/material.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';

class RegistrationSuccessPage extends StatelessWidget {
  const RegistrationSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ✅ Success Icon
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/SucReg.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ✅ Title
              Text(
                'Pendaftaran Berhasil',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black87,
                    ),
              ),
              const SizedBox(height: 8),

              // ✅ Subtitle
              Text(
                'Yeay, akun kamu sudah aktif!',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
              ),
              const SizedBox(height: 24),

              // ✅ Description
              Text(
                'Sekarang kamu sudah bisa menggunakan semua layanan dan promo menarik dari Modipay.id. Selamat berbelanja!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 40),

              // ✅ Button Mulai Belanja
              CustomButton(
                text: 'Mulai Belanja!',
                fontWeight: FontWeight.w600,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(),
                    ),
                    (route) => false, // hapus semua route sebelumnya
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}