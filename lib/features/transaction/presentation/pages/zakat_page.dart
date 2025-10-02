import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ppob_app/features/transaction/presentation/pages/zakat2_page.dart';
// Import halaman tujuan, ganti dengan halaman yang sesuai
// import 'detail_zakat_page.dart';

class ZakatPage extends StatefulWidget {
  const ZakatPage({super.key});

  @override
  State<ZakatPage> createState() => _ZakatPageState();
}

class _ZakatPageState extends State<ZakatPage> {
  final List<Map<String, String>> _zakatInstitutions = [
    {'title': 'Rumah Zakat', 'imagePath': 'assets/images/rumah_zakat_logo.png'},
    {'title': 'Rumah Yatim', 'imagePath': 'assets/images/rumah_yatim_logo.png'},
    {'title': 'BAZNAS', 'imagePath': 'assets/images/baznas_jabar_logo.png'},
    {'title': 'Dompet Dhuafa', 'imagePath': 'assets/images/dompet_duafa.png'},
    {'title': 'LAZ Al-Azhar', 'imagePath': 'assets/images/laz_alazhar_logo.png'},
    {'title': 'Lazis Darul Hikam', 'imagePath': 'assets/images/lazis_darul_hikam_logo.png'},
    {'title': 'BAZNAS Jawa Barat', 'imagePath': 'assets/images/baznas_jabar_logo.png'},
  ];

  List<Map<String, String>> _filteredInstitutions = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredInstitutions = _zakatInstitutions;
    _searchController.addListener(_filterInstitutions);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterInstitutions() {
    final String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredInstitutions = _zakatInstitutions.where((institution) {
        return institution['title']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  Widget _buildZakatItem({required String title, required String imagePath}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Zakat2Page(zakatName: title, zakatImage: imagePath),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 30,
              height: 30,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 30,
                  height: 30,
                  color: const Color(0xFFE5E5E5),
                  child: const Icon(Icons.error_outline, size: 20),
                );
              },
            ),
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
            padding: const EdgeInsets.only(top: 170),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Pilih Lembaga/Yayasan",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D2D2D),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Cari lembaga/yayasan disini",
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
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
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    itemCount: _filteredInstitutions.length,
                    itemBuilder: (context, index) {
                      final institution = _filteredInstitutions[index];
                      return Column(
                        children: [
                          _buildZakatItem(
                            title: institution['title']!,
                            imagePath: institution['imagePath']!,
                          ),
                          _buildDivider(),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
