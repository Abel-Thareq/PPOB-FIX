import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'emas2_page.dart'; // Import halaman tujuan

class EmasPage extends StatefulWidget {
  const EmasPage({super.key});

  @override
  State<EmasPage> createState() => _EmasPageState();
}

class _EmasPageState extends State<EmasPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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

          // Back Button
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

          // Header Text
          const Positioned(
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
          ),

          // Main Content
          SingleChildScrollView(
            child: Column(
              children: [
                // Floating Card for "Detail Tabungan"
                Container(
                  margin: const EdgeInsets.only(top: 120, left: 20, right: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "Detail Tabungan",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6B48D1),
                      ),
                    ),
                  ),
                ),

                // Teks Deskripsi di luar card
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, left: 20, right: 20),
                  child: Text(
                    "Tabungan Emas Pegadaian adalah layanan penitipan saldo emas yang memudahkan kamu untuk berinvestasi emas secara mudah, murah, aman dan terpercaya.",
                    style: TextStyle(fontSize: 14, color: Color(0xFF000000)),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 24), // Spasi antara deskripsi dan tab
                // Tabs and their content
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        controller: _tabController,
                        indicatorColor: const Color(0xFF6B48D1),
                        labelColor: const Color(0xFF6B48D1),
                        unselectedLabelColor: const Color(0xFF2D2D2D),
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        tabs: const [
                          Tab(text: "Rincian"),
                          Tab(text: "Keuntungan"),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // Rincian Tab Content
                            SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Ketentuan Pembukaan Tabungan Emas",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2D2D2D),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "Melakukan pembukaan rekening melalui aplikasi BRimo dengan mengisi dan melampirkan:",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF2D2D2D),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "1. Merupakan Warga Negara Indonesia (WNI)\n2. Memastikan informasi pribadi pembukaan Tabungan Emas yang BRimo sudah sesuai.",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF2D2D2D),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8EAF6),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: const Color(0xFF6B48D1),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.info_outline,
                                          color: Color(0xFF6B48D1),
                                          size: 24,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                "Informasi",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF6B48D1),
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                "Tabungan Emas Pegadaian di BRimo tidak terhubung dengan Tabungan Emas di aplikasi lain selain Pegadaian Digital.",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF2D2D2D),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Keuntungan Tab Content
                            SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Jaminan Emas 24 Karat",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2D2D2D),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Emas yang ditransaksikan merupakan emas yang dijamin 24 karat.",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF2D2D2D),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "Transaksi Mulai dari Rp10.000",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2D2D2D),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Pembelian emas dengan harga terjangkau mulai dari Rp10.000",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF2D2D2D),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "Real Time Online",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2D2D2D),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Harga emas, informasi saldo dan juga transaksi dilakukan secara realtime.",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF2D2D2D),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "Aman dan Terpercaya",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2D2D2D),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Fisik emas terjamin aman di Pegadaian dan diawasi oleh OJK.",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF2D2D2D),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "Harga Flexibel",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2D2D2D),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Keuntungan optimal dengan harga jual dan beli sesuai harga emas harian sesuai Pegadaian.",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF2D2D2D),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // "Buka Tabungan" Button at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Logika navigasi ditambahkan di sini
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Emas2Page(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B48D1),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Buka Tabungan",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
