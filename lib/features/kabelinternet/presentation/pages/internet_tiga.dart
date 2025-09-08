import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/kabelinternet/presentation/pages/internet_tiga3.dart';
import 'package:ppob_app/features/kabelinternet/presentation/pages/internet_empat.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';
import 'dart:async';

class InternetTigaPage extends StatefulWidget {
  final String selectedService;
  final String customerNumber;

  const InternetTigaPage({
    super.key,
    required this.selectedService,
    required this.customerNumber,
  });

  @override
  State<InternetTigaPage> createState() => _InternetTigaPageState();
}

class _InternetTigaPageState extends State<InternetTigaPage> {
  bool _isLoading = false;
  List<Map<String, dynamic>> _packages = [];
  String _errorMessage = '';
  int _selectedPackageIndex = -1;
  Timer? _debounce;

  // Data paket untuk semua layanan
  final Map<String, List<Map<String, dynamic>>> _allPackagesByService = {
    'Kawan K-Vision': [
    {
      'title': 'Kawan K-Vision Basic',
      'price': 'Rp75.000',
      'keuntungan': 'Rp5.000',
      'details': {
        'description': 'Paket basic dengan 50 channel',
        'nominal': 'Rp75.000',
        'biayaAdmin': 'Rp2.500',
      },
    },
    {
      'title': 'Kawan K-Vision Standard',
      'price': 'Rp95.000',
      'keuntungan': 'Rp7.000',
      'details': {
        'description': 'Paket standard dengan 75 channel',
        'nominal': 'Rp95.000',
        'biayaAdmin': 'Rp2.800',
      },
    },
    {
      'title': 'Kawan K-Vision Premium',
      'price': 'Rp120.000',
      'keuntungan': 'Rp8.000',
      'details': {
        'description': 'Paket premium dengan 100 channel',
        'nominal': 'Rp120.000',
        'biayaAdmin': 'Rp3.000',
      },
    },
    {
      'title': 'Kawan K-Vision Ultimate',
      'price': 'Rp150.000',
      'keuntungan': 'Rp12.000',
      'details': {
        'description': 'Paket ultimate dengan 150 channel termasuk sports',
        'nominal': 'Rp150.000',
        'biayaAdmin': 'Rp3.500',
      },
    },
  ],
  'K-Vision dan GOL': [
    {
      'title': 'K-Vision + GOL Starter',
      'price': 'Rp120.000',
      'keuntungan': 'Rp8.000',
      'details': {
        'description': 'Paket combo TV + Internet 5 Mbps',
        'nominal': 'Rp120.000',
        'biayaAdmin': 'Rp4.000',
      },
    },
    {
      'title': 'K-Vision + GOL Combo 1',
      'price': 'Rp150.000',
      'keuntungan': 'Rp10.000',
      'details': {
        'description': 'Paket combo TV + Internet 10 Mbps',
        'nominal': 'Rp150.000',
        'biayaAdmin': 'Rp5.000',
      },
    },
    {
      'title': 'K-Vision + GOL Combo 2',
      'price': 'Rp200.000',
      'keuntungan': 'Rp15.000',
      'details': {
        'description': 'Paket combo TV + Internet 20 Mbps',
        'nominal': 'Rp200.000',
        'biayaAdmin': 'Rp5.000',
      },
    },
    {
      'title': 'K-Vision + GOL Pro',
      'price': 'Rp250.000',
      'keuntungan': 'Rp20.000',
      'details': {
        'description': 'Paket combo TV + Internet 30 Mbps',
        'nominal': 'Rp250.000',
        'biayaAdmin': 'Rp6.000',
      },
    },
  ],
  'WeTV': [
    {
      'title': 'WeTV Weekly',
      'price': 'Rp15.000',
      'keuntungan': 'Rp1.000',
      'details': {
        'description': 'Langganan WeTV 1 minggu',
        'nominal': 'Rp15.000',
        'biayaAdmin': 'Rp500',
      },
    },
    {
      'title': 'WeTV Monthly',
      'price': 'Rp39.000',
      'keuntungan': 'Rp2.000',
      'details': {
        'description': 'Langganan WeTV 1 bulan',
        'nominal': 'Rp39.000',
        'biayaAdmin': 'Rp1.000',
      },
    },
    {
      'title': 'WeTV Quarterly',
      'price': 'Rp99.000',
      'keuntungan': 'Rp6.000',
      'details': {
        'description': 'Langganan WeTV 3 bulan',
        'nominal': 'Rp99.000',
        'biayaAdmin': 'Rp2.000',
      },
    },
    {
      'title': 'WeTV Annual',
      'price': 'Rp349.000',
      'keuntungan': 'Rp25.000',
      'details': {
        'description': 'Langganan WeTV 1 tahun',
        'nominal': 'Rp349.000',
        'biayaAdmin': 'Rp5.000',
      },
    },
  ],
  'Transvision': [
    {
      'title': 'Transvision Basic',
      'price': 'Rp85.000',
      'keuntungan': 'Rp5.000',
      'details': {
        'description': 'Paket basic Transvision - 60 channel',
        'nominal': 'Rp85.000',
        'biayaAdmin': 'Rp3.000',
      },
    },
    {
      'title': 'Transvision Value',
      'price': 'Rp110.000',
      'keuntungan': 'Rp7.000',
      'details': {
        'description': 'Paket value Transvision - 80 channel',
        'nominal': 'Rp110.000',
        'biayaAdmin': 'Rp3.500',
      },
    },
    {
      'title': 'Transvision Family',
      'price': 'Rp135.000',
      'keuntungan': 'Rp8.000',
      'details': {
        'description': 'Paket keluarga Transvision - 100 channel',
        'nominal': 'Rp135.000',
        'biayaAdmin': 'Rp4.000',
      },
    },
    {
      'title': 'Transvision Premium',
      'price': 'Rp175.000',
      'keuntungan': 'Rp12.000',
      'details': {
        'description': 'Paket premium Transvision - 120 channel + sports',
        'nominal': 'Rp175.000',
        'biayaAdmin': 'Rp4.500',
      },
    },
  ],
  'Vidio Streaming': [
    {
      'title': 'Vidio Weekly Pass',
      'price': 'Rp19.000',
      'keuntungan': 'Rp1.500',
      'details': {
        'description': 'Akses Vidio Premium 1 minggu',
        'nominal': 'Rp19.000',
        'biayaAdmin': 'Rp800',
      },
    },
    {
      'title': 'Vidio Premium Monthly',
      'price': 'Rp49.000',
      'keuntungan': 'Rp3.000',
      'details': {
        'description': 'Langganan Vidio Premium 1 bulan',
        'nominal': 'Rp49.000',
        'biayaAdmin': 'Rp1.500',
      },
    },
    {
      'title': 'Vidio Premium Half Year',
      'price': 'Rp249.000',
      'keuntungan': 'Rp18.000',
      'details': {
        'description': 'Langganan Vidio Premium 6 bulan',
        'nominal': 'Rp249.000',
        'biayaAdmin': 'Rp4.000',
      },
    },
    {
      'title': 'Vidio Premium Annual',
      'price': 'Rp399.000',
      'keuntungan': 'Rp30.000',
      'details': {
        'description': 'Langganan Vidio Premium 1 tahun',
        'nominal': 'Rp399.000',
        'biayaAdmin': 'Rp6.000',
      },
    },
  ],
  'Bstation Streaming': [
    {
      'title': 'Bstation Weekly',
      'price': 'Rp25.000',
      'keuntungan': 'Rp2.000',
      'details': {
        'description': 'Akses Bstation 1 minggu',
        'nominal': 'Rp25.000',
        'biayaAdmin': 'Rp1.000',
      },
    },
    {
      'title': 'Bstation Monthly',
      'price': 'Rp45.000',
      'keuntungan': 'Rp3.000',
      'details': {
        'description': 'Langganan Bstation 1 bulan',
        'nominal': 'Rp45.000',
        'biayaAdmin': 'Rp1.500',
      },
    },
    {
      'title': 'Bstation Quarterly',
      'price': 'Rp120.000',
      'keuntungan': 'Rp10.000',
      'details': {
        'description': 'Langganan Bstation 3 bulan',
        'nominal': 'Rp120.000',
        'biayaAdmin': 'Rp2.500',
      },
    },
    {
      'title': 'Bstation Annual',
      'price': 'Rp450.000',
      'keuntungan': 'Rp35.000',
      'details': {
        'description': 'Langganan Bstation 1 tahun',
        'nominal': 'Rp450.000',
        'biayaAdmin': 'Rp7.000',
      },
    },
  ],
};

  @override
  void initState() {
    super.initState();
    _fetchPackages();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onBackPressed() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (Route<dynamic> route) => false,
    );
  }

  void _fetchPackages() {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _packages = _allPackagesByService[widget.selectedService] ?? [];
          if (_packages.isEmpty) {
            _errorMessage = 'Tidak ada paket tersedia untuk ${widget.selectedService}';
          }
        });
      }
    });
  }

  void _navigateToPaymentWithCode() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InternetTiga3Page(
          selectedService: widget.selectedService,
          customerNumber: widget.customerNumber,
          selectedPackage: null,
        ),
      ),
    );
  }

  // Fungsi untuk menghitung total pembayaran
  String _calculateTotal(Map<String, dynamic> package) {
    final nominal = int.parse(package['details']['nominal'].replaceAll('Rp', '').replaceAll('.', '').replaceAll(',', ''));
    final biayaAdmin = int.parse(package['details']['biayaAdmin'].replaceAll('Rp', '').replaceAll('.', '').replaceAll(',', ''));
    final total = nominal + biayaAdmin;
    
    return 'Rp${total.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  void _showPackageDetails(Map<String, dynamic> package, int index) {
    final totalPembayaran = _calculateTotal(package);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(24.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rincian Paket',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    package['title'],
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    package['details']['description'],
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nominal',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        package['details']['nominal'],
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Biaya Admin',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        package['details']['biayaAdmin'],
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Divider(),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Pembayaran',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        totalPembayaran,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF5938FB),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedPackageIndex = index;
                        });
                        Navigator.of(context).pop();
                        _showPaymentDetails(package);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5938FB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                      ),
                      child: Text(
                        'Pilih Paket',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showPaymentDetails(Map<String, dynamic> package) {
    final totalPembayaran = _calculateTotal(package);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(24.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Detail Pembayaran',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nominal',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        package['details']['nominal'],
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Biaya Admin',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        package['details']['biayaAdmin'],
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Divider(),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Pembayaran',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        totalPembayaran,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF5938FB),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPackageItem(Map<String, dynamic> package, int index) {
    final isSelected = index == _selectedPackageIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPackageIndex = index;
        });
        _showPaymentDetails(package);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF5938FB) : Colors.grey.shade300,
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  package['title'],
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      package['price'],
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF5938FB),
                      ),
                    ),
                    Text(
                      'Keuntungan ${package['keuntungan']}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _showPackageDetails(package, index);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        side: const BorderSide(
                          color: Color(0xFF5938FB),
                          width: 1.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Lihat Detail',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFF5938FB),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (isSelected)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFF5938FB),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16.r,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final selectedPackage = _selectedPackageIndex != -1 ? _packages[_selectedPackageIndex] : null;

    return WillPopScope(
      onWillPop: () async {
        _onBackPressed();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 100.h,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 100.h,
                          color: Colors.white,
                          child: Image.asset(
                            'assets/images/header.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SafeArea(
                          child: Padding(
                            padding: EdgeInsets.all(16.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_back, size: 28.r),
                                  color: Colors.white,
                                  onPressed: _onBackPressed,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nomor Tujuan',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.customerNumber,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Icon(Icons.check_circle, color: Colors.green),
                            ],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Layanan: ${widget.selectedService}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        // Teks untuk pembayaran dengan kode
                        GestureDetector(
                          onTap: _navigateToPaymentWithCode,
                          child: RichText(
                            text: TextSpan(
                              text: 'Ingin pembayaran dengan kode pembayaran? ',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey.shade600,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Klik disini',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xFF5938FB),
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: <Widget>[
                        if (_isLoading)
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 24.h),
                              child: CircularProgressIndicator(
                                color: const Color(0xFF5938FB),
                              ),
                            ),
                          )
                        else if (_errorMessage.isNotEmpty)
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: Text(
                                _errorMessage,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        else if (_packages.isNotEmpty)
                          ..._packages.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, dynamic> package = entry.value;
                            return _buildPackageItem(package, index);
                          }).toList()
                        else if (!_isLoading && _packages.isEmpty)
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 24.h),
                              child: Text(
                                'Tidak ada paket tersedia',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: selectedPackage != null ? 80.h : 0),
                ],
              ),
            ),
            if (selectedPackage != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(16.r),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showPaymentDetails(selectedPackage);
                        },
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Pembayaran',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  _calculateTotal(selectedPackage),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_drop_up,
                              color: Colors.grey.shade600,
                              size: 24.r,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 150.w,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InternetEmpatPage(
                                  selectedService: widget.selectedService,
                                  customerNumber: widget.customerNumber,
                                  selectedPackage: selectedPackage,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5938FB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                          ),
                          child: Text(
                            'Beli Sekarang',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
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