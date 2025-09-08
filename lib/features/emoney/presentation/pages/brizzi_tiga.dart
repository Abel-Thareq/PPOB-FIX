import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/emoney/presentation/pages/brizzi_empat.dart';

class BrizziTigaPage extends StatefulWidget {
  final int nominal; // Properti baru untuk menerima nominal

  const BrizziTigaPage({super.key, required this.nominal});

  @override
  State<BrizziTigaPage> createState() => _BrizziTigaPageState();
}

class _BrizziTigaPageState extends State<BrizziTigaPage> {
  String formatCurrency(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }

  String selectedPaymentMethod = "Saldo Modipay";
  String? selectedBank;

  // Menggunakan nominal dari widget sebagai totalPesanan
  late int totalPesanan;
  int biayaAdmin = 1000;

  @override
  void initState() {
    super.initState();
    totalPesanan = widget.nominal; // Menginisialisasi totalPesanan
  }

  int get totalPembayaran => totalPesanan + biayaAdmin;

  void updateBiayaAdmin() {
    setState(() {
      if (selectedPaymentMethod == "Transfer Bank" && selectedBank != null) {
        biayaAdmin = 4000;
      } else if (selectedPaymentMethod == "Saldo Modipay") {
        biayaAdmin = 1000;
      } else {
        biayaAdmin = 3000;
      }
    });
  }

  void _showPaymentMethodSheet(BuildContext context) {
    String tempSelectedPaymentMethod = selectedPaymentMethod;
    String? tempSelectedBank = selectedBank;
    bool tempShowBankOptions = (tempSelectedPaymentMethod == "Transfer Bank");

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
            return Container(
              padding: EdgeInsets.all(16.r),
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Pilih Pembayaran",
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPaymentOption(
                            "Saldo Modipay",
                            isSelected: tempSelectedPaymentMethod == "Saldo Modipay",
                            showArrow: false,
                            onTap: () {
                              setStateModal(() {
                                tempSelectedPaymentMethod = "Saldo Modipay";
                                tempSelectedBank = null;
                                tempShowBankOptions = false;
                              });
                            },
                          ),
                          Divider(height: 16.h),

                          _buildPaymentOption(
                            "Transfer Bank",
                            isSelected: tempSelectedPaymentMethod == "Transfer Bank",
                            showArrow: true,
                            onTap: () {
                              setStateModal(() {
                                tempSelectedPaymentMethod = "Transfer Bank";
                                tempShowBankOptions = !tempShowBankOptions;
                              });
                            },
                          ),

                          if (tempSelectedPaymentMethod == "Transfer Bank") ...[
                            SizedBox(height: 8.h),
                            Column(
                              children: [
                                _buildBankOption("Bank BRI", isSelected: tempSelectedBank == "Bank BRI", onTap: () {
                                  setStateModal(() {
                                    tempSelectedBank = "Bank BRI";
                                  });
                                }),
                                _buildBankOption("Bank BCA", isSelected: tempSelectedBank == "Bank BCA", onTap: () {
                                  setStateModal(() {
                                    tempSelectedBank = "Bank BCA";
                                  });
                                }),
                                _buildBankOption("Bank Mandiri", isSelected: tempSelectedBank == "Bank Mandiri", onTap: () {
                                  setStateModal(() {
                                    tempSelectedBank = "Bank Mandiri";
                                  });
                                }),
                                _buildBankOption("Bank BNI", isSelected: tempSelectedBank == "Bank BNI", onTap: () {
                                  setStateModal(() {
                                    tempSelectedBank = "Bank BNI";
                                  });
                                }),
                              ],
                            ),
                          ],

                          Divider(height: 16.h),

                          _buildPaymentOption(
                            "Kartu Debit/Kredit",
                            isSelected: tempSelectedPaymentMethod == "Kartu Debit/Kredit",
                            showArrow: true,
                            onTap: () {
                              setStateModal(() {
                                tempSelectedPaymentMethod = "Kartu Debit/Kredit";
                                tempSelectedBank = null;
                                tempShowBankOptions = false;
                              });
                            },
                          ),

                          Divider(height: 16.h),

                          _buildPaymentOption(
                            "Cicilan Kartu Kredit",
                            isSelected: tempSelectedPaymentMethod == "Cicilan Kartu Kredit",
                            showArrow: true,
                            onTap: () {
                              setStateModal(() {
                                tempSelectedPaymentMethod = "Cicilan Kartu Kredit";
                                tempSelectedBank = null;
                                tempShowBankOptions = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C4EFF),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          selectedPaymentMethod = tempSelectedPaymentMethod;
                          selectedBank = tempSelectedBank;
                          updateBiayaAdmin();
                        });
                      },
                      child: Text(
                        "Konfirmasi",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPaymentOption(String title, {required bool isSelected, required bool showArrow, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0EDFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: isSelected ? Border.all(color: const Color(0xFF6C4EFF), width: 1.5) : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: isSelected ? const Color(0xFF6C4EFF) : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (showArrow) Icon(Icons.chevron_right, color: isSelected ? const Color(0xFF6C4EFF) : Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  Widget _buildBankOption(String bankName, {required bool isSelected, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0EDFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: isSelected ? Border.all(color: const Color(0xFF6C4EFF), width: 1.5) : null,
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/images/bank_${bankName.split(' ')[1].toLowerCase()}.png',
              width: 24.w,
              height: 24.h,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.account_balance),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                bankName,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isSelected ? const Color(0xFF6C4EFF) : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected) const Icon(Icons.check, color: Color(0xFF6C4EFF)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/header.png',
                width: double.infinity,
                height: 100.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 100.h,
                  color: const Color(0xFF5938FB),
                ),
              ),
              Positioned(
                top: 40.h,
                left: 10.w,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4.r,
                          offset: Offset(0, 2.h),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/brizzi.png', // Logo BRIZZI
                              width: 50.w,
                              height: 40.h,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "TOPUP BRIZZI",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "6013 5001 2664 2595",
                                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 24.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Pesanan", style: TextStyle(fontSize: 14.sp)),
                            SizedBox(
                              width: 100.w,
                              child: Text(
                                formatCurrency(totalPesanan),
                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Voucher", style: TextStyle(fontSize: 14.sp)),
                        Row(
                          children: [
                            Text(
                              "Gunakan/masukan kode",
                              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                            ),
                            SizedBox(width: 8.w),
                            Icon(Icons.chevron_right, size: 20.r),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => _showPaymentMethodSheet(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Metode Pembayaran", style: TextStyle(fontSize: 14.sp)),
                              Row(
                                children: [
                                  Text(
                                    selectedBank ?? selectedPaymentMethod,
                                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                                  ),
                                  SizedBox(width: 8.w),
                                  Icon(Icons.chevron_right, size: 20.r),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 24.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Pesanan", style: TextStyle(fontSize: 14.sp)),
                            SizedBox(
                              width: 100.w,
                              child: Text(
                                formatCurrency(totalPesanan),
                                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Biaya Admin", style: TextStyle(fontSize: 14.sp)),
                            SizedBox(
                              width: 100.w,
                              child: Text(
                                formatCurrency(biayaAdmin),
                                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 24.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Pembayaran", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: 100.w,
                              child: Text(
                                formatCurrency(totalPembayaran),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF6C4EFF),
                                ),
                                textAlign: TextAlign.end,
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
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey, width: 0.2)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Total Pembayaran",
                              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.end,
                            ),
                            Text(
                              formatCurrency(totalPembayaran),
                              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C4EFF),
                      padding: EdgeInsets.symmetric(vertical: 18.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BrizziEmpatPage(
                          totalPesanan: totalPesanan,
                          biayaAdmin: biayaAdmin,
                        )),
                      );
                    },
                    child: Text(
                      "Bayar Sekarang",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                      ),
                    ),
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
