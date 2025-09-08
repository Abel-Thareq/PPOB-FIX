import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/pulsa_data/pinpage_pulsa.dart';

class Pulsa4Page extends StatefulWidget {
  final String phoneNumber;
  final String sumberDanaNama;
  final String sumberDanaRekening;
  final String provider;
  final String nominal;

  const Pulsa4Page({
    super.key,
    required this.phoneNumber,
    required this.sumberDanaNama,
    required this.sumberDanaRekening,
    required this.provider,
    required this.nominal,
  });

  @override
  State<Pulsa4Page> createState() => _Pulsa4PageState();
}

class _Pulsa4PageState extends State<Pulsa4Page> {
  bool _isSaved = true;

  static const int biayaAdmin = 3000;

  /// 🔹 Format angka jadi ribuan (contoh: 10000 -> 10.000)
  String formatRupiah(int number) {
    return NumberFormat.decimalPattern("id").format(number);
  }

  int get _harga {
    return int.tryParse(
            widget.nominal.replaceAll("Rp", "").replaceAll(".", "").trim()) ??
        0;
  }

  int get _total => _harga + biayaAdmin;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Header
          SizedBox(
            height: 130.h,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 120.h,
                  child: Image.asset(
                    'assets/images/header.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back,
                          size: 28.r, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Sumber Dana
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Sumber Dana",
                    style: TextStyle(
                        color: Color(0xFF5938FB),
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundColor: const Color(0xFF5938FB),
                      child: const Text("AT",
                          style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.sumberDanaNama,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                        Text(widget.sumberDanaRekening,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12)),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),

          // 🔹 Tujuan
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Tujuan",
                    style: TextStyle(
                        color: Color(0xFF5938FB),
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Image.asset("assets/images/telkomsel.png",
                        width: 36.w, height: 36.h),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.provider,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                        Text("Pulsa - ${widget.phoneNumber}",
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12)),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),

          // 🔹 Switch Tambah ke Daftar
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Tambah Ke Daftar Tersimpan",
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                Switch(
                  value: _isSaved,
                  activeColor: const Color(0xFF5938FB),
                  onChanged: (val) => setState(() => _isSaved = val),
                ),
              ],
            ),
          ),

          const Divider(thickness: 1, indent: 19, endIndent: 19),

          // 🔹 Rincian Biaya
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Nominal",
                        style: TextStyle(color: Colors.grey, fontSize: 13)),
                    Text("Rp ${formatRupiah(_harga)}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Biaya Admin",
                        style: TextStyle(color: Colors.grey, fontSize: 13)),
                    Text("Rp ${formatRupiah(biayaAdmin)}"),
                  ],
                ),
                const Divider(indent: 0, endIndent: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    Text("Rp ${formatRupiah(_total)}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),

          const Spacer(),

          // 🔹 Tombol Konfirmasi
          Container(
            margin: EdgeInsets.all(16.w),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5938FB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PinPulsaPage(
                      sumberDana:
                          "${widget.sumberDanaNama}\n${widget.sumberDanaRekening}",
                      tujuan:
                          "${widget.provider}\n${widget.phoneNumber}", // digabung provider + nomor
                      nomorSerial: "0373850000055559", // contoh dummy, bisa diganti dari API
                      harga: _harga,
                      biayaAdmin: biayaAdmin,
                      total: _total,
                    ),
                  ),
                );
              },
              child: const Text(
                "Konfirmasi",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}