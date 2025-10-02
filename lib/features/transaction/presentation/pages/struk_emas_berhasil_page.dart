import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class StrukEmasBerhasilPage extends StatefulWidget {
  final String noRef;
  final int harga;
  final double beratEmas;
  final int hargaPerGram;
  final int biayaAdmin;
  final int pembulatanHarga;
  final int total;
  final DateTime tanggal;

  const StrukEmasBerhasilPage({
    super.key,
    required this.noRef,
    required this.harga,
    required this.beratEmas,
    required this.hargaPerGram,
    required this.biayaAdmin,
    required this.pembulatanHarga,
    required this.total,
    required this.tanggal,
  });

  @override
  State<StrukEmasBerhasilPage> createState() => _StrukEmasBerhasilPageState();
}

class _StrukEmasBerhasilPageState extends State<StrukEmasBerhasilPage> {
  // _showDetails diatur ke false secara default, sesuai dengan visual awal
  bool _showDetails = false;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID');
  }

  Widget _buildRow(String label, String value, {String? subValue}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF757575),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              if (subValue != null)
                Text(
                  subValue,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF757575),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatCurrency(int amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final NumberFormat formatter = NumberFormat("#,###", "id_ID");

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 135.h,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 120.h,
                    child: SvgPicture.asset(
                      'assets/images/backgroundtop.svg',
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
                            fontFamily: "Poppins",
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 1),
                        Text(
                          "SATU PINTU SEMUA PEMBAYARAN",
                          style: TextStyle(
                            fontFamily: "Poppins",
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
            ),
            SizedBox(height: 8.h),
            Container(
              width: 48.w,
              height: 48.w,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 71, 210, 33),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 32),
            ),
            SizedBox(height: 8.h),
            const Text(
              "Transaksi Berhasil",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRow(
                    "Tanggal",
                    "${DateFormat("dd MMM yyyy HH:mm:ss", "id_ID").format(widget.tanggal)} WIB",
                  ),
                  const SizedBox(height: 12),
                  _buildRow("No. Ref", widget.noRef),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Divider(color: Colors.grey.withOpacity(0.3)),
                  ),
                  _buildRow(
                    "Sumber Dana",
                    "ABEL THAREQ",
                    subValue: "081215633163",
                  ),
                  const SizedBox(height: 12),
                  _buildRow("Jenis Transaksi", "Pembelian eMas"),
                  const SizedBox(height: 12),
                  _buildRow(
                    "Berat Emas",
                    "${widget.beratEmas.toStringAsFixed(3)} gram",
                  ),
                  const SizedBox(height: 12),
                  _buildRow(
                    "Harga per gram",
                    _formatCurrency(widget.hargaPerGram),
                  ),

                  // Perbaikan di sini: Pindahkan tombol ke atas rincian harga
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _showDetails = !_showDetails;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _showDetails
                                ? "Tutup Detail Transaksi"
                                : "Lihat Detail Transaksi",
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF6C4DF4),
                            ),
                          ),
                          Icon(
                            _showDetails
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: const Color(0xFF6C4DF4),
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Detail harga yang akan disembunyikan/ditampilkan
                  if (_showDetails) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: Divider(color: Colors.grey.withOpacity(0.3)),
                    ),
                    _buildRow("Harga", _formatCurrency(widget.harga)),
                    const SizedBox(height: 12),
                    _buildRow(
                      "Biaya Admin",
                      _formatCurrency(widget.biayaAdmin),
                    ),
                    const SizedBox(height: 12),
                    _buildRow(
                      "Pembulatan Harga",
                      "-Rp${formatter.format(widget.pembulatanHarga)}",
                    ),
                  ],

                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFEEEEEE)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Pembelian",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          _formatCurrency(widget.total),
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6C4DF4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Color(0xFF6C4DF4)),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          // TODO: Implement share functionality
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.share,
                              color: Color(0xFF6C4DF4),
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Bagikan",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF6C4DF4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C4DF4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        child: const Text(
                          "Selesai",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
