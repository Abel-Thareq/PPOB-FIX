import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'emas3_page.dart';

class Emas2Page extends StatelessWidget {
  const Emas2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Stack(
        children: [
          _buildHeaderBackground(),
          _buildBackButton(context),
          _buildHeaderText(),
          _buildMainContent(context),
        ],
      ),
    );
  }

  Widget _buildHeaderBackground() {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: SvgPicture.asset(
        "assets/images/backgroundtop.svg",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      left: 16,
      top: 51,
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildHeaderText() {
    return const Positioned(
      top: 60,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Text(
            "modipay",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 1),
          Text(
            "SATU PINTU SEMUA PEMBAYARAN",
            style: TextStyle(
              color: Colors.white,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 150.0),
      child: Column(
        children: [
          _buildTitle(),
          const SizedBox(height: 32),
          _buildFeatureBox(),
          const Spacer(),
          _buildPriceSection(context),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Column(
      children: [
        SizedBox(height: 16),
        Text(
          "Nabung eMas gak perlu mahal\nMulai dari Rp199 aja!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6B48D1),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFeatureBox() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF6B48D1)),
        color: const Color(0xFFE8EAF6),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _buildFeatureRow('assets/images/icon_lock.png', 'Dilindungi modipay Protection'),
          const SizedBox(height: 16),
          _buildFeatureRow('assets/images/icon_coins.png', 'Jaminan eMas Fisik'),
          const SizedBox(height: 16),
          _buildFeatureRow('assets/images/icon_verified.png', 'Investasi Aman dan Terpercaya'),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(String imagePath, String text) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 30,
          height: 30,
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceSection(BuildContext context) {
    return Column(
      children: [
        Divider(color: Colors.grey[300], height: 40, thickness: 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: _buildPriceColumn(
                  "Harga Jual Terbaru",
                  "Rp19.220",
                  "Jual Sekarang",
                  const Color.fromARGB(255, 218, 216, 216),
                  const Color(0xFF9E9E9E),
                  () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildPriceColumn(
                  "Harga Beli Terbaru",
                  "Rp19.877",
                  "Beli Sekarang",
                  const Color(0xFF6B48D1),
                  Colors.white,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Emas3Page()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceColumn(
    String label,
    String price,
    String buttonText,
    Color buttonColor,
    Color textColor,
    VoidCallback onPressed,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF9E9E9E),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              price,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D2D2D),
              ),
            ),
            const SizedBox(width: 4),
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(
                "/ 0.01g",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
