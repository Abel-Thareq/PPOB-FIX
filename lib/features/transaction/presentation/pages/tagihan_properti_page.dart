import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'konfirmasi_tagihan_properti_page.dart';

class TagihanPropertiPage extends StatefulWidget {
  final String propertyName;
  final String propertyImage;
  final String customerNumber;

  const TagihanPropertiPage({
    super.key,
    required this.propertyName,
    required this.propertyImage,
    required this.customerNumber,
  });

  @override
  State<TagihanPropertiPage> createState() => _TagihanPropertiPageState();
}

class _TagihanPropertiPageState extends State<TagihanPropertiPage> {
  bool _isLoading = true;
  bool _isSaved = false;
  late Map<String, dynamic> _invoiceData;

  @override
  void initState() {
    super.initState();
    _loadInvoiceData();
  }

  Future<void> _loadInvoiceData() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;

      setState(() {
        _invoiceData = {
          "nama": "ALFIN CHIMPUNK",
          "alamat":
              "CitraLand BSB Semarang,\nCluster Havana Blok A3 No. 15 Mijen, Semarang",
          "nomorPelanggan": "0012345",
          "sumberDana": {"nama": "ABEL THAREQ", "nomorHP": "08121563163"},
          "periode": "Bulanan",
          "tagihan": 50000,
          "biayaAdmin": 0,
          "totalTagihan": 50000,
        };
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _invoiceData = {"error": "Gagal memuat data"};
      });
    }
  }

  String _formatCurrency(int amount) {
    return "Rp${amount.toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]}.")}";
  }

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

  Widget _buildDetailItem(String label, String value, {bool isPurple = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isPurple ? FontWeight.bold : FontWeight.normal,
              color: const Color(0xFF2D2D2D),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isPurple
                    ? const Color(0xFF6C4DF6)
                    : const Color(0xFF2D2D2D),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C4DF6)),
        ),
      );
    }

    return Stack(
      children: [
        Column(
          children: [
            Container(
              transform: Matrix4.translationValues(0, -30, 0),
              margin: const EdgeInsets.symmetric(horizontal: 18),
              padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Text(
                "Tagihan",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C4DF6),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Total Pembayaran",
                    style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatCurrency(_invoiceData["totalTagihan"]),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6C4DF6),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFE0E0E0),
                        width: 1,
                      ),
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
                          value: _isSaved,
                          onChanged: (bool value) {
                            setState(() {
                              _isSaved = value;
                            });
                          },
                          activeTrackColor: const Color(0xFF6C4DF6),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildDetailItem(
                    "Sumber Dana",
                    "${_invoiceData["sumberDana"]["nama"]}\n${_invoiceData["sumberDana"]["nomorHP"]}",
                  ),
                  _buildDetailItem("Nama", _invoiceData["nama"]),
                  _buildDetailItem(
                    "Nomor Pelanggan",
                    _invoiceData["nomorPelanggan"],
                  ),
                  _buildDetailItem("Alamat", _invoiceData["alamat"]),
                  _buildDetailItem("Periode Tagihan", _invoiceData["periode"]),
                  const Divider(height: 24, thickness: 1),
                  _buildDetailItem(
                    "Tagihan",
                    _formatCurrency(_invoiceData["tagihan"]),
                  ),
                  _buildDetailItem(
                    "Biaya Admin",
                    _formatCurrency(_invoiceData["biayaAdmin"]),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _buildDetailItem(
                      "Total Tagihan",
                      _formatCurrency(_invoiceData["totalTagihan"]),
                      isPurple: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildContent()),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C4DF6),
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _isLoading
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KonfirmasiTagihanPropertiPage(
                            invoiceData: _invoiceData,
                          ),
                        ),
                      );
                    },
              child: const Text(
                "Bayar Sekarang",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
