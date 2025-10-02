import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ppob_app/features/transaction/presentation/pages/pendidikan_page.dart';
import 'package:ppob_app/features/transaction/models/saved_transaction.dart';
import 'package:ppob_app/features/transaction/services/saved_transaction_service.dart';

class StrukTagihanPendidikanBerhasilPage extends StatefulWidget {
  final String noRef;
  final String nomorInduk;
  final int harga;
  final int denda;
  final int biayaAdmin;
  final int total;
  final DateTime tanggal;
  final int angsuranKe;
  final String noReferensiMLPO;

  const StrukTagihanPendidikanBerhasilPage({
    super.key,
    required this.noRef,
    required this.nomorInduk,
    required this.harga,
    required this.denda,
    required this.biayaAdmin,
    required this.total,
    required this.tanggal,
    this.angsuranKe = 18,
    this.noReferensiMLPO = "163703525586613000",
  });

  @override
  State<StrukTagihanPendidikanBerhasilPage> createState() =>
      _StrukTagihanPendidikanBerhasilPageState();
}

class _StrukTagihanPendidikanBerhasilPageState
    extends State<StrukTagihanPendidikanBerhasilPage> {
  bool _showDetails = false;
  final _transactionService = SavedTransactionService();

  @override
  void initState() {
    super.initState();
    _saveTransaction();
  }

  Future<void> _saveTransaction() async {
    final transaction = SavedTransaction(
      id: widget.noRef,
      name: "Pembayaran Pendidikan",
      customerNumber: widget.nomorInduk,
      date: widget.tanggal,
    );
    await _transactionService.saveTransaction(transaction);
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

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID');
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PendidikanPage(),
                          ),
                        );
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
                  _buildRow("Jenis Transaksi", "Pembayaran Cicilan FIF"),
                  const SizedBox(height: 12),
                  _buildRow("Nama Pelanggan", "ALFIN CHIPMUNK"),
                  const SizedBox(height: 12),
                  _buildRow("Nomor Pelanggan", widget.nomorInduk),
                  const SizedBox(height: 12),
                  if (_showDetails) ...[
                    _buildRow("Angsuran Ke", widget.angsuranKe.toString()),
                    const SizedBox(height: 12),
                    _buildRow("No. Referensi MLPO", widget.noReferensiMLPO),
                    const SizedBox(height: 12),
                  ],
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
                                ? "Lihat Lebih Sedikit"
                                : "Lihat Detail Transaksi",
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0066FF),
                            ),
                          ),
                          Icon(
                            _showDetails
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: const Color(0xFF0066FF),
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Divider(color: Colors.grey.withOpacity(0.3)),
                  ),
                  _buildRow("Harga", "Rp${formatter.format(widget.harga)}"),
                  const SizedBox(height: 12),
                  _buildRow("Denda", "Rp${formatter.format(widget.denda)}"),
                  const SizedBox(height: 12),
                  _buildRow(
                    "Biaya Admin",
                    "Rp${formatter.format(widget.biayaAdmin)}",
                  ),
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
                          "Rp${formatter.format(widget.total)}",
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

            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.all(20.w),
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PendidikanPage(),
                            ),
                          );
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
          ],
        ),
      ),
    );
  }
}
