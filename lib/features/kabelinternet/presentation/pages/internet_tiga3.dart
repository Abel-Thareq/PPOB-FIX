import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/kabelinternet/presentation/pages/internet_empat.dart';

class InternetTiga3Page extends StatefulWidget {
  final String selectedService;
  final String customerNumber;
  final Map<String, dynamic>? selectedPackage;

  const InternetTiga3Page({
    super.key,
    required this.selectedService,
    required this.customerNumber,
    required this.selectedPackage,
  });

  @override
  State<InternetTiga3Page> createState() => _InternetTiga3PageState();
}

class _InternetTiga3PageState extends State<InternetTiga3Page> {
  final TextEditingController _paymentCodeController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isCodeValid = false;

  // Data kode pembayaran untuk semua layanan
  final Map<String, Map<String, Map<String, dynamic>>> _paymentCodesByService = {
    'Kawan K-Vision': {
      'KVISBASIC': {
        'title': 'Kawan K-Vision Basic',
        'price': 'Rp75.000',
        'details': {
          'nominal': 'Rp75.000',
          'biayaAdmin': 'Rp2.500',
        }
      },
      'KVISPREMIUM': {
        'title': 'Kawan K-Vision Premium',
        'price': 'Rp120.000',
        'details': {
          'nominal': 'Rp120.000',
          'biayaAdmin': 'Rp3.000',
        }
      },
    },
    'K-Vision dan GOL': {
      'KVGOLCOMBO1': {
        'title': 'K-Vision + GOL Combo 1',
        'price': 'Rp150.000',
        'details': {
          'nominal': 'Rp150.000',
          'biayaAdmin': 'Rp5.000',
        }
      },
      'KVGOLCOMBO2': {
        'title': 'K-Vision + GOL Combo 2',
        'price': 'Rp200.000',
        'details': {
          'nominal': 'Rp200.000',
          'biayaAdmin': 'Rp5.000',
        }
      },
    },
    'WeTV': {
      'WETVMONTHLY': {
        'title': 'WeTV Monthly',
        'price': 'Rp39.000',
        'details': {
          'nominal': 'Rp39.000',
          'biayaAdmin': 'Rp1.000',
        }
      },
      'WETVQUARTER': {
        'title': 'WeTV Quarterly',
        'price': 'Rp99.000',
        'details': {
          'nominal': 'Rp99.000',
          'biayaAdmin': 'Rp2.000',
        }
      },
      'WETVANNUAL': {
        'title': 'WeTV Annual',
        'price': 'Rp349.000',
        'details': {
          'nominal': 'Rp349.000',
          'biayaAdmin': 'Rp5.000',
        }
      },
    },
    'Transvision': {
      'TRANSBASIC': {
        'title': 'Transvision Basic',
        'price': 'Rp85.000',
        'details': {
          'nominal': 'Rp85.000',
          'biayaAdmin': 'Rp3.000',
        }
      },
      'TRANSFAMILY': {
        'title': 'Transvision Family',
        'price': 'Rp135.000',
        'details': {
          'nominal': 'Rp135.000',
          'biayaAdmin': 'Rp4.000',
        }
      },
    },
    'Vidio Streaming': {
      'VIDIOMONTHLY': {
        'title': 'Vidio Premium Monthly',
        'price': 'Rp49.000',
        'details': {
          'nominal': 'Rp49.000',
          'biayaAdmin': 'Rp1.500',
        }
      },
      'VIDIOANNUAL': {
        'title': 'Vidio Premium Annual',
        'price': 'Rp399.000',
        'details': {
          'nominal': 'Rp399.000',
          'biayaAdmin': 'Rp6.000',
        }
      },
    },
    'Bstation Streaming': {
      'BSTMONTHLY': {
        'title': 'Bstation Monthly',
        'price': 'Rp45.000',
        'details': {
          'nominal': 'Rp45.000',
          'biayaAdmin': 'Rp1.500',
        }
      },
      'BSTANNUAL': {
        'title': 'Bstation Annual',
        'price': 'Rp450.000',
        'details': {
          'nominal': 'Rp450.000',
          'biayaAdmin': 'Rp7.000',
        }
      },
    },
  };

  @override
  void initState() {
    super.initState();
    _paymentCodeController.addListener(_validatePaymentCode);

    if (widget.selectedPackage != null) {
      _autoFillPaymentCode();
    }
  }

  void _autoFillPaymentCode() {
    final serviceCodes = _paymentCodesByService[widget.selectedService];
    if (serviceCodes != null) {
      final entry = serviceCodes.entries.firstWhere(
        (entry) => entry.value['title'] == widget.selectedPackage!['title'],
        orElse: () => const MapEntry('', {}),
      );

      if (entry.key.isNotEmpty) {
        _paymentCodeController.text = entry.key;
        _isCodeValid = true;
      }
    }
  }

  @override
  void dispose() {
    _paymentCodeController.removeListener(_validatePaymentCode);
    _paymentCodeController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _validatePaymentCode() {
    final paymentCode = _paymentCodeController.text.toUpperCase().trim();
    final serviceCodes = _paymentCodesByService[widget.selectedService];

    if (serviceCodes != null && serviceCodes.containsKey(paymentCode)) {
      setState(() {
        _isCodeValid = true;
      });
    } else {
      setState(() {
        _isCodeValid = false;
      });
    }
  }

  void _onBackPressed() {
    Navigator.of(context).pop();
  }

  Map<String, dynamic>? _getSelectedPackageDetails() {
    final paymentCode = _paymentCodeController.text.toUpperCase().trim();
    final serviceCodes = _paymentCodesByService[widget.selectedService];
    return serviceCodes != null ? serviceCodes[paymentCode] : null;
  }

  void _onContinuePressed() {
    if (_isCodeValid) {
      final packageDetails = _getSelectedPackageDetails();
      if (packageDetails != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InternetEmpatPage(
              selectedService: widget.selectedService,
              customerNumber: widget.customerNumber,
              selectedPackage: packageDetails,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Detail paket tidak ditemukan')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    final Color buttonColor = _isCodeValid ? const Color(0xFF5938FB) : Colors.grey.shade300;
    final Color textColor = _isCodeValid ? Colors.white : Colors.grey.shade600;
    final packageDetails = _getSelectedPackageDetails();

    return WillPopScope(
      onWillPop: () async {
        _onBackPressed();
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8FF),
        body: Column(
          children: [
            Stack(
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
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pembayaran dengan Kode',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Nomor Pelanggan: ${widget.customerNumber}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Layanan: ${widget.selectedService}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Masukkan kode pembayaran yang Anda miliki:',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextField(
                      controller: _paymentCodeController,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        hintText: 'Masukkan Kode Pembayaran',
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey.shade400,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            color: Color(0xFF5938FB),
                            width: 2.0,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Contoh kode: ${_paymentCodesByService[widget.selectedService]?.keys.first ?? "KVISBASIC"}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    if (_isCodeValid && packageDetails != null)
                      Container(
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Detail Paket',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              packageDetails['title'] ?? '',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Harga',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  packageDetails['price'] ?? '',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
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
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isCodeValid ? _onContinuePressed : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: textColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    elevation: _isCodeValid ? 2 : 0,
                  ),
                  child: Text(
                    'Bayar Sekarang',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}