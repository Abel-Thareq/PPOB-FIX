// verifikasi_shop.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/shop/keranjang_page.dart';
import 'package:ppob_app/features/shop/shopberhasil_page.dart';
import 'package:ppob_app/features/shop/shopgagal_page.dart';
import 'checkout_page.dart';
import 'package:intl/intl.dart';

class VerifikasiShop extends StatefulWidget {
  final List<KeranjangItem> produk;
  final Alamat alamat;
  final String pesanUntukPenjual;
  final OpsiPengiriman opsiPengiriman;
  final MetodePembayaran metodePembayaran;
  final OpsiBank? bank;
  final Voucher? voucher;
  final int subtotalPesanan;
  final int subtotalPengiriman;
  final int totalDiskonPengiriman;
  final int totalPembayaran;

  const VerifikasiShop({
    super.key,
    required this.produk,
    required this.alamat,
    required this.pesanUntukPenjual,
    required this.opsiPengiriman,
    required this.metodePembayaran,
    this.bank,
    this.voucher,
    required this.subtotalPesanan,
    required this.subtotalPengiriman,
    required this.totalDiskonPengiriman,
    required this.totalPembayaran,
  });

  @override
  State<VerifikasiShop> createState() => _VerifikasiShopState();
}

class _VerifikasiShopState extends State<VerifikasiShop> {
  String enteredPin = '';
  final int pinLength = 6;

  String formatCurrency(int amount) {
    return 'Rp${NumberFormat('#,###', 'id_ID').format(amount).replaceAll(',', '.')}';
  }

  void _onNumberPressed(String number) {
    if (enteredPin.length < pinLength) {
      setState(() {
        enteredPin += number;
      });
    }
  }

  void _onDeletePressed() {
    if (enteredPin.isNotEmpty) {
      setState(() {
        enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      });
    }
  }

  void _onSubmitPressed() {
    if (enteredPin.length == pinLength) {
      if (enteredPin == '555555') {
        // Create CheckoutData untuk diteruskan
        final checkoutData = CheckoutData(
          produk: widget.produk,
          alamat: widget.alamat,
          pesanUntukPenjual: widget.pesanUntukPenjual,
          opsiPengiriman: widget.opsiPengiriman,
          metodePembayaran: widget.metodePembayaran,
          bank: widget.bank,
          voucher: widget.voucher,
          subtotalPesanan: widget.subtotalPesanan,
          subtotalPengiriman: widget.subtotalPengiriman,
          totalDiskonPengiriman: widget.totalDiskonPengiriman,
          totalPembayaran: widget.totalPembayaran,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ShopBerhasilPage(checkoutData: checkoutData),
          ),
        );
      } else if (enteredPin == '111111') {
        // Create CheckoutData untuk diteruskan
        final checkoutData = CheckoutData(
          produk: widget.produk,
          alamat: widget.alamat,
          pesanUntukPenjual: widget.pesanUntukPenjual,
          opsiPengiriman: widget.opsiPengiriman,
          metodePembayaran: widget.metodePembayaran,
          bank: widget.bank,
          voucher: widget.voucher,
          subtotalPesanan: widget.subtotalPesanan,
          subtotalPengiriman: widget.subtotalPengiriman,
          totalDiskonPengiriman: widget.totalDiskonPengiriman,
          totalPembayaran: widget.totalPembayaran,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ShopGagalPage(checkoutData: checkoutData),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("PIN yang Anda Masukkan Salah. Silahkan Coba lagi"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("PIN harus 6 digit"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showPaymentDetails() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        padding: EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Detail Pembayaran',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              
              Text(
                'Produk:',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              ...widget.produk.map((item) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${item.nama} (x${item.quantity})',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                    Text(
                      formatCurrency(int.parse(item.harga.replaceAll(RegExp(r'[Rp\s\.]'), '')) * item.quantity),
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
              )).toList(),
              
              SizedBox(height: 16.h),
              const Divider(),
              SizedBox(height: 8.h),
              
              _buildDetailRow('Subtotal Pesanan', formatCurrency(widget.subtotalPesanan)),
              _buildDetailRow('Subtotal Pengiriman', formatCurrency(widget.subtotalPengiriman)),
              _buildDetailRow('Biaya Layanan', 'Rp1.900'),
              if (widget.totalDiskonPengiriman > 0)
                _buildDetailRow('Total Diskon Pengiriman', '-${formatCurrency(widget.totalDiskonPengiriman)}'),
              if (widget.voucher != null)
                _buildDetailRow('Voucher Diskon', '-${formatCurrency(widget.voucher!.discountAmount)}'),
              
              SizedBox(height: 8.h),
              const Divider(thickness: 2),
              SizedBox(height: 8.h),
              
              _buildDetailRow(
                'Total Pembayaran',
                formatCurrency(widget.totalPembayaran),
                isTotal: true,
              ),
              
              SizedBox(height: 24.h),
              
              Text(
                'Pengiriman:',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                widget.opsiPengiriman.nama,
                style: TextStyle(fontSize: 14.sp),
              ),
              Text(
                widget.opsiPengiriman.estimasi,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
              
              SizedBox(height: 16.h),
              
              Text(
                'Metode Pembayaran:',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                widget.metodePembayaran.nama,
                style: TextStyle(fontSize: 14.sp),
              ),
              if (widget.bank != null)
                Text(
                  widget.bank!.nama,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: isTotal ? Colors.black : Colors.grey[700],
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              color: isTotal ? const Color(0xFF5938FB) : Colors.grey[700],
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF5938FB),
              Color(0xFF8B6BFF),
            ],
          ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 100.h,
                  child: Image.asset(
                    'assets/images/header.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.white,
                          iconSize: 28.r,
                          onPressed: () => Navigator.pop(context),
                        ),
                        IconButton(
                          icon: const Icon(Icons.info_outline),
                          color: Colors.white,
                          iconSize: 28.r,
                          onPressed: _showPaymentDetails,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 40.h),
            
            Text(
              "Masukan PIN Anda",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            
            SizedBox(height: 30.h),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pinLength,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Container(
                    width: 40.w,
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.white,
                      border: Border.all(
                        color: index < enteredPin.length
                            ? const Color(0xFF5938FB)
                            : Colors.grey.shade300,
                        width: 2.w,
                      ),
                    ),
                    child: index < enteredPin.length
                        ? Icon(Icons.circle,
                            size: 12.r, color: const Color(0xFF5938FB))
                        : null,
                  ),
                ),
              ),
            ),
            
            const Spacer(),
            
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
              ),
              child: Column(
                children: [
                  _buildKeypadRow(['1', '2', '3']),
                  SizedBox(height: 20.h),
                  _buildKeypadRow(['4', '5', '6']),
                  SizedBox(height: 20.h),
                  _buildKeypadRow(['7', '8', '9']),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDeleteButton(),
                      _buildNumberButton('0'),
                      _buildSubmitButton(),
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

  Widget _buildKeypadRow(List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((n) => _buildNumberButton(n)).toList(),
    );
  }

  Widget _buildNumberButton(String number) {
    return InkWell(
      onTap: () => _onNumberPressed(number),
      borderRadius: BorderRadius.circular(32.r),
      child: Container(
        width: 64.w,
        height: 64.h,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return InkWell(
      onTap: _onDeletePressed,
      borderRadius: BorderRadius.circular(32.r),
      child: Container(
        width: 64.w,
        height: 64.h,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
          child: Icon(
            Icons.backspace_outlined,
            size: 28.r,
            color: const Color(0xFF5938FB),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return InkWell(
      onTap: _onSubmitPressed,
      borderRadius: BorderRadius.circular(32.r),
      child: Container(
        width: 64.w,
        height: 64.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: enteredPin.length == pinLength
              ? const Color(0xFF5938FB)
              : Colors.grey,
        ),
        child: Center(
          child: Icon(
            Icons.check,
            size: 28.r,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}