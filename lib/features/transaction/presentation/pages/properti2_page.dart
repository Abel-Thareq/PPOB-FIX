import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ppob_app/features/transaction/presentation/pages/tagihan_properti_page.dart';

class Properti2Page extends StatefulWidget {
  final String propertyName;
  final String propertyImage;

  const Properti2Page({
    super.key,
    required this.propertyName,
    required this.propertyImage,
  });

  @override
  State<Properti2Page> createState() => _Properti2PageState();
}

class _Properti2PageState extends State<Properti2Page> {
  final TextEditingController _customerNumberController =
      TextEditingController();

  Widget _buildHeader() {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Stack(
        children: [
          SvgPicture.asset(
            "assets/images/backgroundtop.svg",
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Positioned(
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
          ),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              children: const [
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
          ),
        ],
      ),
    );
  }

  Widget _buildPropertySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(widget.propertyImage, width: 34, height: 34),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.propertyName,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D2D2D),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerNumberInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Nomor Pelanggan",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D2D2D),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _customerNumberController,
            decoration: InputDecoration(
              hintText: "Masukkan Nomor Pelanggan",
              hintStyle: const TextStyle(color: Color(0xFFE0E0E0)),
              prefixIcon: const Icon(
                Icons.person_outline,
                color: Color(0xFF6C4DF6),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
        decoration: const BoxDecoration(
          color: Color(0xFFF8F8FF),
          boxShadow: [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // Navigasi ke halaman berikutnya dengan membawa data
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TagihanPropertiPage(
                    propertyName: widget.propertyName,
                    propertyImage: widget.propertyImage,
                    customerNumber: _customerNumberController.text,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C4DF6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Lanjutkan",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(),
              _buildPropertySection(),
              _buildCustomerNumberInput(),
            ],
          ),
          _buildContinueButton(),
        ],
      ),
    );
  }
}
