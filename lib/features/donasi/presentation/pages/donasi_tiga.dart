import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ppob_app/features/donasi/presentation/pages/donasi_empat.dart';

// Class untuk memformat input teks dengan titik pemisah ribuan
class _NominalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    String cleanText = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (cleanText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    int value = int.tryParse(cleanText) ?? 0;

    final format = NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    );

    String formattedText = format.format(value).trim();

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class DonasiTigaPage extends StatefulWidget {
  final String institutionName;
  final String institutionImage;

  const DonasiTigaPage({
    super.key,
    required this.institutionName,
    required this.institutionImage,
  });

  @override
  State<DonasiTigaPage> createState() => _DonasiTigaPageState();
}

class _DonasiTigaPageState extends State<DonasiTigaPage> {
  final TextEditingController _nominalController = TextEditingController();
  String? _selectedNominal;
  bool _isButtonEnabled = false;
  bool _isDetailsVisible = false;
  bool _isExpanded = false;

  // Biaya admin sebagai konstanta
  static const int _adminFee = 1000;

  final List<String> _nominalList = [
    '10000',
    '20000',
    '50000',
    '70000',
    '100000',
    '150000',
    '200000',
    '300000',
    '500000',
    '1000000',
  ];

  @override
  void initState() {
    super.initState();
    _nominalController.addListener(_updateState);
  }

  @override
  void dispose() {
    _nominalController.dispose();
    super.dispose();
  }

  void _updateState() {
    final cleanText = _nominalController.text.replaceAll('.', '');
    final newButtonEnabled = cleanText.isNotEmpty;
    final newDetailsVisible = cleanText.isNotEmpty;

    setState(() {
      _isButtonEnabled = newButtonEnabled;
      _isDetailsVisible = newDetailsVisible;
    });
  }

  void _selectNominal(String nominal) {
    setState(() {
      _selectedNominal = nominal;
      _nominalController.text = _formatNumberWithDots(int.parse(nominal));
      _updateState();
    });
  }

  String _formatRupiah(int amount) {
    final format = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return format.format(amount);
  }

  String _formatNumberWithDots(int amount) {
    final format = NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    );
    return format.format(amount).trim();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  int get _totalAmount {
    if (_nominalController.text.isEmpty) return 0;
    final cleanText = _nominalController.text.replaceAll('.', '');
    return int.tryParse(cleanText) ?? 0;
  }

  // Getter baru untuk menghitung total pembayaran final (nominal + biaya admin)
  int get _finalAmount {
    return _totalAmount + _adminFee;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final double headerHeight = 120.h;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          navigateBack(context);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8FF),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: headerHeight),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Image.asset(
                            widget.institutionImage,
                            width: 40.w,
                            height: 40.h,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.account_balance,
                                color: Colors.grey[400],
                                size: 20.r,
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: AutoSizeText(
                            widget.institutionName,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            maxLines: 2,
                            minFontSize: 14.sp,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      "Pilih Nominal",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6.r,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Rp",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: TextField(
                              controller: _nominalController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                _NominalInputFormatter(),
                              ],
                              decoration: InputDecoration(
                                hintText: "Masukkan Nominal",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12.sp,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedNominal = null;
                                  _isDetailsVisible = true;
                                });
                              },
                              onChanged: (value) {
                                _updateState();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      "Pilih nominal instant",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 0.01.h), // DIUBAH: dari 2.h menjadi 16.h
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: 3.5,
                      ),
                      itemCount: _nominalList.length,
                      itemBuilder: (context, index) {
                        final nominal = _nominalList[index];
                        final isSelected = _selectedNominal == nominal;
                        return _buildNominalButton(nominal, isSelected);
                      },
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: headerHeight,
              width: double.infinity,
              child: Image.asset(
                'assets/images/header.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 50.h,
              left: 10.w,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                iconSize: 28.r,
                onPressed: () {
                  navigateBack(context);
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10.r,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header dengan total pembayaran dan tombol expand
              if (_isDetailsVisible)
                GestureDetector(
                  onTap: _toggleExpansion,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Pembayaran",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          // Menggunakan _finalAmount yang sudah termasuk biaya admin
                          Text(
                            "Rp${_formatNumberWithDots(_finalAmount)}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF6A1B9A),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            _isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            size: 20.r,
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              // Tombol Bayar Sekarang (selalu terlihat)
              SizedBox(height: _isDetailsVisible ? 16.h : 0),
              ElevatedButton(
                onPressed: _isButtonEnabled
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DonasiEmpatPage(
                              institutionName: widget.institutionName,
                              institutionImage: widget.institutionImage,
                              nominal: _totalAmount,
                              adminFee: _adminFee,
                            ),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isButtonEnabled
                      ? const Color(0xFF6A1B9A)
                      : const Color(0xFFE0E0E0),
                  foregroundColor:
                      _isButtonEnabled ? Colors.white : Colors.grey[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  minimumSize: Size(double.infinity, 50.h),
                  elevation: 0,
                ),
                child: Text(
                  "Bayar Sekarang",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Detail pembayaran (hanya terlihat saat di-expand)
              AnimatedSize(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                child: Visibility(
                  visible: _isExpanded && _isDetailsVisible,
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),
                      Divider(height: 1.h, color: Colors.grey[300]),
                      SizedBox(height: 16.h),
                      _buildPaymentDetailRow(
                        "Lembaga/Yayasan",
                        widget.institutionName,
                        useAutoSize: true,
                      ),
                      SizedBox(height: 8.h),
                      _buildPaymentDetailRow(
                        "Nominal",
                        _totalAmount > 0 ? "Rp${_formatNumberWithDots(_totalAmount)}" : "Rp0",
                      ),
                      SizedBox(height: 8.h),
                      _buildPaymentDetailRow(
                        "Biaya Admin",
                        "Rp${_formatNumberWithDots(_adminFee)}",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNominalButton(String nominal, bool isSelected) {
    final amount = int.parse(nominal);
    return GestureDetector(
      onTap: () => _selectNominal(nominal),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF6A1B9A) : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4.r,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            _formatRupiah(amount),
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: isSelected ? const Color(0xFF6A1B9A) : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentDetailRow(String label, String value, {bool useAutoSize = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: useAutoSize
              ? AutoSizeText(
                  value,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  minFontSize: 10.sp,
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                )
              : Text(
                  value,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ],
    );
  }
}