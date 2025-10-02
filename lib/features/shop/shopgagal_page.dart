// ShopGagalPage.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';
import 'package:ppob_app/features/shop/checkout_page.dart';
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
  bool _showDetails = false;

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
    
    // Jika hanya satu produk
    if (widget.checkoutData.produk.length == 1) {
      final item = widget.checkoutData.produk.first;
      final productName = '${item.nama} (x${item.quantity})';
      
      // Jika nama produk terlalu panjang, potong dan tambahkan "..."
      if (productName.length > 40) {
        return '${productName.substring(0, 37)}...';
      }
      return productName;
    }
    
    // Jika multiple products, tampilkan produk pertama + jumlah produk lainnya
    final firstProduct = widget.checkoutData.produk.first;
    final remainingCount = widget.checkoutData.produk.length - 1;
    final productName = '${firstProduct.nama} (x${firstProduct.quantity}) + $remainingCount produk lainnya';
    
    // Jika masih terlalu panjang, potong
    if (productName.length > 40) {
      return '${productName.substring(0, 37)}...';
    }
    return productName;
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

  void _toggleDetails() {
    setState(() {
      _showDetails = !_showDetails;
    });
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
        body: Column(
          children: [
            // Header tetap di atas
            Container(
              height: 100.h,
              width: double.infinity,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/header.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
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
                ],
              ),
            ),
            // Konten yang bisa di-scroll di bawah header
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 20.h, bottom: 20.h, left: horizontalPadding, right: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 35.r,
                      ),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Informasi dasar transaksi (SAMA PERSIS dengan ShopBerhasilPage)
                          _DetailRow("Tanggal", formattedDate),
                          _DetailRow("No. Ref", noRef),
                          SizedBox(height: 16.h),
                          const Divider(height: 1, color: Colors.grey),
                          SizedBox(height: 16.h),
                          _DetailRow("Sumber Dana", _getSumberDana()),
                          _DetailRow("Jenis Transaksi", "Shopping"),
                          _DetailRow("Nama Pemesan", widget.checkoutData.alamat.nama),
                          _DetailRow("Nama Produk", _getProductNames()),
                          
                          // Tombol Lihat Detail Transaksi (SAMA PERSIS dengan ShopBerhasilPage)
                          SizedBox(height: 16.h),
                          Center(
                            child: GestureDetector(
                              onTap: _toggleDetails,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F0F0),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Lihat Detail Transaksi",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: const Color(0xFF6C4EFF),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Icon(
                                      _showDetails ? Icons.expand_less : Icons.expand_more,
                                      size: 16.r,
                                      color: const Color(0xFF6C4EFF),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          
                          // Detail tambahan yang bisa di-expand (SAMA PERSIS dengan ShopBerhasilPage)
                          if (_showDetails) ...[
                            const Divider(height: 1, color: Colors.grey),
                            SizedBox(height: 16.h),
                            
                            // Tampilkan detail semua produk
                            Text(
                              'Detail Produk:',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            ...widget.checkoutData.produk.map((item) => Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '• ${item.nama} (x${item.quantity})',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )).toList(),
                            
                            SizedBox(height: 16.h),
                            _DetailRow("Alamat", _getFormattedAddress()),
                            _DetailRow("Opsi Pengiriman", widget.checkoutData.opsiPengiriman.nama),
                            SizedBox(height: 16.h),
                            const Divider(height: 1, color: Colors.grey),
                            SizedBox(height: 16.h),
                            
                            // RINCIAN PEMBAYARAN - SAMA PERSIS dengan ShopBerhasilPage
                            _DetailRow("Subtotal Pesanan", formatCurrency(widget.checkoutData.subtotalPesanan)),
                            _DetailRow("Subtotal Pengiriman", formatCurrency(widget.checkoutData.subtotalPengiriman)),
                            _DetailRow("Biaya Layanan", "Rp1.900"),
                            _DetailRow("Total Diskon", "-${formatCurrency(_getTotalDiskon())}"),
                            
                            SizedBox(height: 16.h),
                            const Divider(height: 1, color: Colors.grey),
                            SizedBox(height: 16.h),
                            
                            // TOTAL PEMBAYARAN - SAMA PERSIS dengan ShopBerhasilPage
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
                            
                            SizedBox(height: 16.h),
                            const Divider(height: 1, color: Colors.grey),
                            SizedBox(height: 16.h),
                            
                            // STATUS PESANAN - DIUBAH MENJADI "GAGAL"
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Daftar Pesanan",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Gagal",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
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