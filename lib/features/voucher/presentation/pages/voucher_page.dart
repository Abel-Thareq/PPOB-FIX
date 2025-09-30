import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'voucher_telkomsel1_page.dart';
import 'voucher_axis1_page.dart';
import 'voucher_indosat1_page.dart';
import 'voucher_smartfren1_page.dart';
import 'voucher_byu1_page.dart';
import 'voucher_xl1_page.dart';
import 'voucher_tri1_page.dart';
import '../../../home/presentation/pages/home_page.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> vouchers = [
      {
        "name": "Telkomsel",
        "image": "assets/images/telkomsel.png",
        "isAssetImage": true,
      },
      {"name": "Axis", "image": "assets/images/axis.png", "isAssetImage": true},
      {
        "name": "Indosat",
        "image": "assets/images/indosat.png",
        "isAssetImage": true,
      },
      {
        "name": "Smartfren",
        "image": "assets/images/smartfren.png",
        "isAssetImage": true,
      },
      {"name": "by.U", "image": "assets/images/byu.png", "isAssetImage": true},
      {"name": "XL", "image": "assets/images/xl.png", "isAssetImage": true},
      {"name": "Tri", "image": "assets/images/tri.png", "isAssetImage": true},
      {
        "name": "Canva",
        "image": "assets/images/canva.png",
        "isAssetImage": true,
      },
      {
        "name": "Free Fire",
        "image": "assets/images/freefire.png",
        "isAssetImage": true,
      },
      {
        "name": "FC Mobile",
        "image": "assets/images/fifa.png",
        "isAssetImage": true,
      },
      {
        "name": "Monster Hunter Wilds",
        "image": "assets/images/monsterhunter.png",
        "isAssetImage": true,
      },
      {
        "name": "Steam Wallet",
        "image": "assets/images/steamwallet.png",
        "isAssetImage": true,
      },
      {
        "name": "Touch N Go",
        "image": "assets/images/touchngo.png",
        "isAssetImage": true,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Column(
        children: [
          // 🔹 Header Section with Background
          Stack(
            children: [
              // Background wave
              SizedBox(
                height: 140,
                width: double.infinity,
                child: SvgPicture.asset(
                  "assets/images/backgroundtop.svg",
                  fit: BoxFit.cover,
                ),
              ),

              // Header content
              SizedBox(
                height: 140,
                child: Column(
                  children: [
                    const SizedBox(height: 51),
                    // Back button and title row
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: const [
                              Text(
                                "modiPay",
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
                        const SizedBox(width: 40), // To balance the back button
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // 🔹 Content Section
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card Voucher Tab
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            spreadRadius: 0,
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Text(
                        "Voucher",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6C4DF4),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Pilih Voucher Kamu",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Cari Voucher",
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[400],
                            size: 22,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),

                    // Grid Voucher
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: vouchers.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 0.98,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                        itemBuilder: (context, index) {
                          final voucher = vouchers[index];
                          return InkWell(
                            onTap: () {
                              if (voucher["name"] == "Telkomsel") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const VoucherTelkomsel1Page(),
                                  ),
                                );
                              } else if (voucher["name"] == "Axis") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const VoucherAxis1Page(),
                                  ),
                                );
                              } else if (voucher["name"] == "Indosat") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const VoucherIndosat1Page(),
                                  ),
                                );
                              } else if (voucher["name"] == "Smartfren") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const VoucherSmartfren1Page(),
                                  ),
                                );
                              } else if (voucher["name"] == "by.U") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const VoucherByU1Page(),
                                  ),
                                );
                              } else if (voucher["name"] == "XL") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const VoucherXL1Page(),
                                  ),
                                );
                              } else if (voucher["name"] == "Tri") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const VoucherTri1Page(),
                                  ),
                                );
                              }
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 55,
                                  width: 55,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        offset: const Offset(0, 2),
                                        blurRadius: 4,
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    voucher["image"],
                                    width: 75,
                                    height: 75,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  voucher["name"],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF222222),
                                    height: 1.2,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
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
