import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ppob_app/features/transaction/presentation/pages/pin_zakat_page.dart';

class Zakat3Page extends StatefulWidget {
  final String zakatName;
  final String zakatImage;
  final String nominal;

  const Zakat3Page({
    super.key,
    required this.zakatName,
    required this.zakatImage,
    required this.nominal,
  });

  @override
  State<Zakat3Page> createState() => _Zakat3PageState();
}

class _Zakat3PageState extends State<Zakat3Page> {
  bool _isSwitchActive = false;
  final String _biayaAdmin = "Rp1.000";

  String _calculateTotal() {
    try {
      final nominalValue = int.parse(widget.nominal.replaceAll('.', ''));
      const adminFee = 1000;
      final total = nominalValue + adminFee;
      return "Rp${total.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
    } catch (e) {
      return "Rp0";
    }
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

          // Scrollable content
          Padding(
            padding: const EdgeInsets.only(top: 170, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Sumber Dana",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xFF6B48D1),
                      child: Text("AT", style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ABEL THAREQ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF2D2D2D),
                          ),
                        ),
                        Text(
                          "modipay - 081215633163",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  "Tujuan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Image.asset(widget.zakatImage, width: 40, height: 40),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.zakatName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF2D2D2D),
                          ),
                        ),
                        const Text(
                          "Zakat",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tambah Ke Daftar Tersimpan",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                      Switch(
                        value: _isSwitchActive,
                        onChanged: (value) {
                          setState(() {
                            _isSwitchActive = value;
                          });
                        },
                        activeTrackColor: const Color(0xFF6B48D1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Divider(color: Colors.grey.shade300, thickness: 1),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Nominal",
                          style: TextStyle(color: Color(0xFF9E9E9E)),
                        ),
                        Text(
                          "Rp${widget.nominal}",
                          style: const TextStyle(
                            color: Color(0xFF2D2D2D),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Biaya Admin",
                          style: TextStyle(color: Color(0xFF9E9E9E)),
                        ),
                        Text(
                          _biayaAdmin,
                          style: const TextStyle(
                            color: Color(0xFF2D2D2D),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 24,
                      thickness: 1,
                      color: Color(0xFFE5E5E5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            color: Color(0xFF2D2D2D),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _calculateTotal(),
                          style: const TextStyle(
                            color: Color(0xFF2D2D2D),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PinZakatPage(
                            transactionData: {
                              'zakatName': widget.zakatName,
                              'zakatImage': widget.zakatImage,
                              'nominal': widget.nominal,
                              'biayaAdmin': _biayaAdmin,
                              'total': _calculateTotal(),
                            },
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6B48D1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      "Konfirmasi",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
