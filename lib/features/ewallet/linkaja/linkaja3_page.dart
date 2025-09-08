import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/features/ewallet/pinpage_ewallet.dart';

class LinkAja3Page extends StatefulWidget {
  final String phoneNumber;
  const LinkAja3Page({super.key, required this.phoneNumber});

  @override
  State<LinkAja3Page> createState() => _LinkAja3PageState();
}

class _LinkAja3PageState extends State<LinkAja3Page> {
  bool _isSaved = true;
  bool _isExpanded = false; // kontrol expand/collapse
  final TextEditingController _nominalController = TextEditingController();
  int _totalPembayaran = 0;

  final List<int> _quickNominals = [20000, 50000, 100000, 200000, 300000];
  final NumberFormat _formatter = NumberFormat("#,###", "id_ID");

  static const int _biayaAdmin = 3000;

  int get totalWithAdmin {
    if (_totalPembayaran > 0) {
      return _totalPembayaran + _biayaAdmin;
    }
    return 0;
  }

  void _updateTotal(String value) {
    String clean = value.replaceAll('.', '').replaceAll(',', '');
    int? input = int.tryParse(clean);

    if (input != null) {
      setState(() {
        _totalPembayaran = input;
        _nominalController.value = TextEditingValue(
          text: _formatter.format(input),
          selection: TextSelection.collapsed(
            offset: _formatter.format(input).length,
          ),
        );
      });
    } else {
      setState(() {
        _totalPembayaran = 0;
      });
    }
  }

  void _selectNominal(int value) {
    setState(() {
      _nominalController.text = _formatter.format(value);
      _totalPembayaran = value;
    });
  }

  @override
  void dispose() {
    _nominalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    // 🔹 Header
                    SizedBox(
                      height: 135.h,
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
                                    size: 28.r, color: Colors.black),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 🔹 Info User & Logo
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          Image.asset("assets/images/linkaja_lingkaran.png",
                              width: 40, height: 40),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("AKMAL HASAN MULYADI",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              const Text("LinkAja",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                              Text(widget.phoneNumber,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // 🔹 Switch Tambah ke daftar
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      padding: EdgeInsets.symmetric(
                          vertical: 4.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Tambah Ke Daftar Tersimpan",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500)),
                          Switch(
                            value: _isSaved,
                            activeColor: const Color(0xFF5938FB),
                            onChanged: (val) =>
                                setState(() => _isSaved = val),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // 🔹 Input Nominal
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Pilih Nominal Top Up",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF5938FB))),
                          SizedBox(height: 8.h),
                          TextField(
                            controller: _nominalController,
                            keyboardType: TextInputType.number,
                            onChanged: _updateTotal,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 14.h),
                                child: const Text(
                                  "Rp",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              prefixIconConstraints: const BoxConstraints(
                                  minWidth: 0, minHeight: 0),
                              hintText: "Masukkan Nominal",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300, width: 0.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300, width: 0.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: const BorderSide(
                                    color: Color(0xFF5938FB), width: 1.2),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 🔹 Quick Nominals Horizontal Scroll
                    SizedBox(height: 10.h),
                    SizedBox(
                      height: 40.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: _quickNominals.length,
                        separatorBuilder: (_, __) => SizedBox(width: 10.w),
                        itemBuilder: (context, index) {
                          final val = _quickNominals[index];
                          return GestureDetector(
                            onTap: () => _selectNominal(val),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 18.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: _totalPembayaran == val
                                      ? const Color(0xFF5938FB)
                                      : Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                "Rp${_formatter.format(val)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: _totalPembayaran == val
                                      ? const Color(0xFF5938FB)
                                      : Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // 🔹 Total Pembayaran (Expandable)
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 8.h),
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () =>
                                setState(() => _isExpanded = !_isExpanded),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text("Total Pembayaran",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(width: 6),
                                    Icon(
                                      _isExpanded
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: Colors.black54,
                                    ),
                                  ],
                                ),
                                Text(
                                  "Rp${_formatter.format(totalWithAdmin)}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF5938FB)),
                                ),
                              ],
                            ),
                          ),

                          // ✅ Expand Detail hanya kalau ada nominal
                          if (_isExpanded && _totalPembayaran > 0) ...[
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Nominal",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13)),
                                Text("Rp${_formatter.format(_totalPembayaran)}",
                                    style: const TextStyle(fontSize: 13)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Biaya Admin",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13)),
                                Text("Rp${_formatter.format(_biayaAdmin)}",
                                    style: const TextStyle(fontSize: 13)),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Total",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(
                                  "Rp${_formatter.format(totalWithAdmin)}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Color(0xFF5938FB)),
                                ),
                              ],
                            ),
                          ]
                        ],
                      ),
                    ),

                    const Spacer(),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                      width: double.infinity,
                      child: CustomButton(
                        text: "Beli Sekarang",
                        onPressed: () {
                          if (_totalPembayaran <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Masukkan nominal terlebih dahulu")),
                            );
                            return;
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PinEWalletPage(
                                ewalletName: "LinkAja",
                                phoneNumber: widget.phoneNumber,
                                nominal: _totalPembayaran,
                                biayaAdmin: _biayaAdmin,
                                total: totalWithAdmin,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}