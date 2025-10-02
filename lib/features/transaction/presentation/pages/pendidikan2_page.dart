import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'pendidikan3_page.dart';

class Pendidikan2Page extends StatefulWidget {
  const Pendidikan2Page({super.key});

  @override
  State<Pendidikan2Page> createState() => _Pendidikan2PageState();
}

class _Pendidikan2PageState extends State<Pendidikan2Page> {
  Widget _buildCollegeItem({required String title, required String imagePath}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Pendidikan3Page(
              universityName: title,
              universityImage: imagePath,
            ),
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
          Stack(
            children: [
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
            ],
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
                      "Pilih Lembaga Pendidikan",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Cari lembaga pendidikan disini",
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
                      "Daftar Perguruan Tinggi",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: [
                        _buildCollegeItem(
                          title: 'Universitas Tidar',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildCollegeItem(
                          title: 'Universitas Gadjah Mada',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildCollegeItem(
                          title: 'Universitas Indonesia',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildCollegeItem(
                          title: 'Universitas Airlangga',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildCollegeItem(
                          title: 'Universitas Negeri Yogyakarta',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildCollegeItem(
                          title: 'Institut Pertanian Bogor',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildCollegeItem(
                          title: 'Universitas Jendral Soedirman',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildCollegeItem(
                          title: 'Institut Teknologi Bandung',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildCollegeItem(
                          title: 'Universitas Padjadjaran',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildCollegeItem(
                          title: 'Universitas Diponegoro',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildCollegeItem(
                          title: 'Universitas Negeri Semarang',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildCollegeItem(
                          title: 'Universitas Riau',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildCollegeItem(
                          title: 'Universitas Sumatra Utara',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildCollegeItem(
                          title: 'Universitas Negeri Padang',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildCollegeItem(
                          title: 'Universitas Sriwijaya',
                          imagePath: 'assets/images/ut.png',
                        ),
                        _buildDivider(),
                        _buildCollegeItem(
                          title: 'Universitas Lampung',
                          imagePath: 'assets/images/ut.png',
                        ),
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
