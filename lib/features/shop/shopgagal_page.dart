
// ShopGagalPage.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';
import 'package:ppob_app/features/shop/checkout_page.dart'; // Import KeranjangItem
import 'dart:math';

class ShopGagalPage extends StatefulWidget {
  final CheckoutData checkoutData;

  const ShopGagalPage({
    Key? key,
    required this.checkoutData,
  }) : super(key: key);

  @override
  State<ShopGagalPage> createState() => _ShopGagalPageState();
}

class _ShopGagalPageState extends State<ShopGagalPage> {
  String formatCurrency(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }

  String _generateRandomString(int length) {
    final random = Random();
    const chars = "0123456789";
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  void _onBackPressed() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (Route<dynamic> route) => false,
    );
  }

  String _getProductNames() {
    if (widget.checkoutData.produk.isEmpty) return '-';
    if (widget.checkoutData.produk.length == 1) {
      final item = widget.checkoutData.produk.first;
      return '${item.nama} (x${item.quantity})';
    }
    return '${widget.checkoutData.produk.first.nama} dan ${widget.checkoutData.produk.length - 1} produk lainnya';
  }

  String _getFormattedAddress() {
    final alamat = widget.checkoutData.alamat;
    return '${alamat.alamatLengkap}, ${alamat.daerah}';
  }

  int _getTotalDiskon() {
    return (widget.checkoutData.voucher?.discountAmount ?? 0) +
        (widget.checkoutData.totalDiskonPengiriman);
  }

  String _getSumberDana() {
    if (widget.checkoutData.bank != null) {
      return '${widget.checkoutData.bank!.nama}';
    }
    return widget.checkoutData.metodePembayaran.nama;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final horizontalPadding = 24.w;

    final now = DateTime.now();
    final formattedDate = DateFormat('dd MMM yyyy HH:mm:ss').format(now) + ' WIB';
    final noRef = _generateRandomString(20);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _onBackPressed();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8FF),
        body: Stack(
          children: [
            SizedBox(
              height: 100.h,
              width: double.infinity,
              child: Image.asset(
                'assets/images/header.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 16.h,
              left: 16.w,
              child: SafeArea(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  iconSize: 28.r,
                  onPressed: _onBackPressed,
                ),
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 120.h, bottom: 20.h, left: horizontalPadding, right: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/error.png',
                    width: 60.w,
                    height: 60.w,
                  ),
                  SizedBox(height: 13.h),
                  Text(
                    "Transaksi Gagal",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6.r,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment:
                       CrossAxisAlignment.start,
                      children: [
                        _DetailRow("Tanggal", formattedDate),
                        _DetailRow("No. Ref", noRef),
                        SizedBox(height: 16.h),
                        const Divider(height: 1, color: Colors.grey),
                        SizedBox(height: 16.h),
                        _DetailRow("Sumber Dana", _getSumberDana()),
                        _DetailRow("Jenis Transaksi", "Shopping"),
                        _DetailRow("Nama Pemesan", widget.checkoutData.alamat.nama),
                        _DetailRow("Nama Produk", _getProductNames()),
                        _DetailRow("Alamat", _getFormattedAddress()),
                        _DetailRow("Opsi Pengiriman", widget.checkoutData.opsiPengiriman.nama),
                        SizedBox(height: 16.h),
                        const Divider(height: 1, color: Colors.grey),
                        SizedBox(height: 16.h),
                        _DetailRow("Subtotal Pesanan", formatCurrency(widget.checkoutData.subtotalPesanan)),
                        _DetailRow("Total Diskon", "-${formatCurrency(_getTotalDiskon())}"),
                        SizedBox(height: 16.h),
                        const Divider(height: 1, color: Colors.grey),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Pembelian",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              formatCurrency(widget.checkoutData.totalPembayaran),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF6C4EFF),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _onBackPressed,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            'Kembali',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            'Coba Lagi',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
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

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}