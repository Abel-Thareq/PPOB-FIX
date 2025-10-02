import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'properti2_page.dart';

class Properti1Page extends StatefulWidget {
  const Properti1Page({super.key});

  @override
  State<Properti1Page> createState() => _Properti1PageState();
}

class _Properti1PageState extends State<Properti1Page> {
  Widget _buildPropertyItem({
    required String title,
    required String imagePath,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Properti2Page(propertyName: title, propertyImage: imagePath),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Image.asset(imagePath, width: 30, height: 30),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2D2D2D),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, color: Color(0xFFE5E5E5));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Stack(
        children: [
          // Header Section with Background
          SizedBox(
            height: 150,
            width: double.infinity,
            child: SvgPicture.asset(
              "assets/images/backgroundtop.svg",
              fit: BoxFit.cover,
            ),
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

          // Scrollable content
          Padding(
            padding: const EdgeInsets.only(top: 170),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Pilih Nama Properti",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Cari nama properti",
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Daftar Properti",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: [
                        _buildPropertyItem(
                          title: 'CitraLand Puri Serang',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildPropertyItem(
                          title: 'CitraLand NGK',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildPropertyItem(
                          title: 'CitraLand Cirebon',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildPropertyItem(
                          title: 'CitraLand Botanical City',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildPropertyItem(
                          title: 'CitraLand Celebes Makassar',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildPropertyItem(
                          title: 'CitraLand BSB Semarang',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildPropertyItem(
                          title: 'Citra Garden Gelason City',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildPropertyItem(
                          title: 'CitraLand Garden Bnajarmasin',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildPropertyItem(
                          title: 'Citra Mitra City Banjarbaru',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
