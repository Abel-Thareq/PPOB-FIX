import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AgentCenterPage extends StatefulWidget {
  const AgentCenterPage({super.key});

  @override
  State<AgentCenterPage> createState() => _AgentCenterPageState();
}

class _AgentCenterPageState extends State<AgentCenterPage> {
  Map<String, bool> expandedState = {
    'Apa itu Agen Center?': false,
    'Apa Kelebihan menjadi Master?': false,
    'Bagaimana Cara menjadi Master?': false,
  };

  void toggleExpansion(String title) {
    setState(() {
      expandedState[title] = !(expandedState[title] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Stack(
        children: [
          // 🔹 Background wave SVG
          SizedBox(
            height: 150,
            width: double.infinity,
            child: SvgPicture.asset(
              "assets/images/backgroundtop.svg",
              fit: BoxFit.cover,
            ),
          ),

          // 🔹 Tombol Back
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

          // 🔹 Title dan Subtitle
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

          // 🔹 Card Agen Center melayang
          Positioned(
            top: 120,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                "Agen Center",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C4DF4),
                ),
              ),
            ),
          ),

          // 🔹 Scrollable content
          Padding(
            padding: const EdgeInsets.only(top: 180),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Agent Image and Message
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/agent.png',
                          height: 180,
                          width: 180,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            print('Error loading image: $error');
                            return Container(
                              height: 180,
                              width: 180,
                              decoration: BoxDecoration(
                                color: const Color(0xFF6C4DF4).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.people,
                                size: 100,
                                color: Color(0xFF6C4DF4),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Mohon Maaf, Halaman Agen Center hanya dapat diakses oleh Master',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF2D2D2D),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  // Expandable Information Cards
                  const SizedBox(height: 8),
                  _buildExpandableCard(
                    title: 'Apa itu Agen Center?',
                    content:
                        'Agen Center adalah halaman yang berfungsi sebagai pusat informasi yang memungkinkan master untuk mengelola bisnis secara lebih efisien dengan adanya informasi seperti, Total transaksi, Cashback, Profit tertulis, dan lainnya',
                    isExpanded: expandedState['Apa itu Agen Center?'] ?? false,
                    onTap: () => toggleExpansion('Apa itu Agen Center?'),
                  ),
                  _buildExpandableCard(
                    title: 'Apa Kelebihan menjadi Master?',
                    content:
                        'Fitur-fitur yang diperbolehkan oleh Master Yaitu:', // Content handled in _buildExpandableCard
                    isExpanded:
                        expandedState['Apa Kelebihan menjadi Master?'] ?? false,
                    onTap: () =>
                        toggleExpansion('Apa Kelebihan menjadi Master?'),
                  ),
                  _buildExpandableCard(
                    title: 'Bagaimana Cara menjadi Master?',
                    content:
                        'Admin berhak untuk mengubah status agen ke Master apabila total transaksi agen selama 30 hari terakhir telah mencapai Rp1.000.000',
                    isExpanded:
                        expandedState['Bagaimana Cara menjadi Master?'] ??
                        false,
                    onTap: () =>
                        toggleExpansion('Bagaimana Cara menjadi Master?'),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableCard({
    required String title,
    required String content,
    required bool isExpanded,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2D2D2D),
            ),
          ),
          trailing: Icon(
            isExpanded ? Icons.expand_less : Icons.chevron_right,
            size: 20,
            color: const Color(0xFF757575),
          ),
          onExpansionChanged: (_) => onTap(),
          initiallyExpanded: isExpanded,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            if (title == 'Apa Kelebihan menjadi Master?') ...[
              const Text(
                'Fitur-fitur yang diperbolehkan oleh Master Yaitu:',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF757575),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              _buildFeatureItem(
                'Fitur Cashback: Dapat memperoleh cashback dari setiap transaksi sukses',
              ),
              _buildFeatureItem(
                'Fitur Referal: Dapat merekrut Agen secara langsung untuk menjadi downline',
              ),
              _buildFeatureItem(
                'Fitur Utang: Dapat mencatat transaksi yang diutangkan',
              ),
              const SizedBox(height: 8),
              const Text(
                'Cashback diberikan per admin dan setiap harga produk hanya memiliki 1 jenis cashback',
                style: TextStyle(fontSize: 12, color: Colors.red, height: 1.5),
              ),
            ] else ...[
              Text(
                content,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF757575),
                  height: 1.5,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF757575),
              height: 1.5,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF757575),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
