import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/byu/presentation/pages/byu_dua.dart';
import 'package:ppob_app/features/byu/presentation/pages/byu_satu1.dart'; // Impor halaman ByuSatu1Page
import 'package:ppob_app/features/main_screen/main_screen.dart'; // Impor halaman MainScreen
import 'dart:async';

// Main widget untuk halaman byu_satu.
class ByuSatuPage extends StatefulWidget {
  const ByuSatuPage({super.key});

  @override
  State<ByuSatuPage> createState() => _ByuSatuPageState();
}

class _ByuSatuPageState extends State<ByuSatuPage> {
  // Controller untuk mengelola teks di TextField.
  final TextEditingController _numberController = TextEditingController();
  // State untuk melacak apakah proses loading sedang aktif.
  bool _isLoading = false;
  // State untuk menyimpan daftar promo yang akan ditampilkan.
  List<Map<String, dynamic>> _promos = [];
  // State untuk menyimpan pesan kesalahan.
  String _errorMessage = '';
  // Menyimpan nomor telepon valid yang terakhir kali dimasukkan.
  String _currentValidNumber = '';
  // Timer untuk debouncing input.
  Timer? _debounce;
  // Indeks untuk melacak promo mana yang dipilih, -1 jika tidak ada.
  int _selectedPromoIndex = -1;

  // Dummy data untuk daftar promo yang tersedia.
  final List<Map<String, dynamic>> _allPromos = const [
    {
      'title': 'Roaming Turki 1 GB, 1 Hari',
      'price': 'Rp200',
      'keuntungan': 'Rp0',
      'originalPrice': '',
      'discount': '',
      'details': {
        'description': 'Non-Hostpot, 1 Perangkat, 1 GB Transit',
        'website': 'www.byu.id',
        'nominal': 'Rp200',
        'biayaAdmin': 'Rp0',
      }
    },
    {
      'title': 'Paket Roaming Korea Selatan 20 GB, 7 Hari',
      'price': 'Rp3.615',
      'keuntungan': 'Rp0',
      'originalPrice': '',
      'discount': '',
      'details': {
        'description': 'Nikmati internetan cepat di Korea Selatan dengan kuota besar.',
        'website': 'www.byu.id',
        'nominal': 'Rp3.615',
        'biayaAdmin': 'Rp0',
      }
    },
    {
      'title': 'Roaming Taiwan 7,5 GB, 1 Hari',
      'price': 'Rp6.125',
      'keuntungan': 'Rp0',
      'originalPrice': '',
      'discount': '',
      'details': {
        'description': 'Kuota roaming besar untuk perjalanan singkat di Taiwan.',
        'website': 'www.byu.id',
        'nominal': 'Rp6.125',
        'biayaAdmin': 'Rp0',
      }
    },
    {
      'title': 'Roaming China 2 GB 3 Hari',
      'price': 'Rp8.880',
      'keuntungan': 'Rp0',
      'originalPrice': '',
      'discount': '',
      'details': {
        'description': 'Paket roaming terjangkau untuk kebutuhan internet dasar di China.',
        'website': 'www.byu.id',
        'nominal': 'Rp8.880',
        'biayaAdmin': 'Rp0',
      }
    },
    {
      'title': 'Promo Kaget 14 GB, 30 Hari',
      'price': 'Rp35.000',
      'keuntungan': 'Rp0',
      'originalPrice': '',
      'discount': '',
      'details': {
        'description': 'Kuota besar untuk penggunaan sebulan penuh, cocok untuk streaming dan gaming.',
        'website': 'www.byu.id',
        'nominal': 'Rp35.000',
        'biayaAdmin': 'Rp0',
      }
    },
    {
      'title': 'Super Kaget 7 GB, 20 Hari',
      'price': 'Rp15.000',
      'keuntungan': 'Rp0',
      'originalPrice': '',
      'discount': '',
      'details': {
        'description': 'Paket irit untuk internetan dan sosial media selama 20 hari.',
        'website': 'www.byu.id',
        'nominal': 'Rp15.000',
        'biayaAdmin': 'Rp0',
      }
    },
  ];

  @override
  void dispose() {
    // Memastikan timer dibatalkan dan controller dibuang saat widget dihapus.
    _numberController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // Fungsi untuk menangani navigasi kembali ke MainScreen.
  void _onBackPressed() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
          (Route<dynamic> route) => false,
    );
  }

  // Fungsi yang dipanggil saat teks di TextField berubah.
  void _onNumberChanged(String value) {
    // Menerapkan debounce untuk mencegah panggilan yang terlalu sering.
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final number = value.replaceAll(' ', '');
      final regex = RegExp(r'^0851\d{8}$');

      if (regex.hasMatch(number)) {
        if (number != _currentValidNumber) {
          _fetchAndSetPromos(number);
        }
      } else {
        _clearState(showError: number.isNotEmpty);
      }
    });
  }

  // Fungsi untuk mensimulasikan pengambilan data promo dan menampilkannya.
  void _fetchAndSetPromos(String number) {
    _clearState();

    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _currentValidNumber = number;
    });

    // Mensimulasikan delay 800ms untuk meniru panggilan API.
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          // Menampilkan daftar promo di halaman.
          _promos = List.from(_allPromos);
        });
      }
    });
  }

  // Fungsi untuk membersihkan state.
  void _clearState({bool showError = false}) {
    setState(() {
      _promos = [];
      _isLoading = false;
      _currentValidNumber = '';
      _errorMessage = showError ? 'Itu bukan nomor By.U' : '';
      _selectedPromoIndex = -1; // Juga reset indeks yang dipilih.
    });
  }

  // Fungsi untuk menampilkan detail promo di pop-up dari bawah.
  void _showPromoDetails(Map<String, dynamic> promo, int index) {
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
                        'Rincian Paket Data',
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
                    promo['title'],
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    promo['details']['description'],
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    promo['details']['website'],
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
                        promo['details']['nominal'],
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
                        promo['details']['biayaAdmin'],
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Mengatur indeks promo yang dipilih dan menampilkan bottom sheet pembayaran.
                        setState(() {
                          _selectedPromoIndex = index;
                        });
                        Navigator.of(context).pop();
                        // Menampilkan pop-up pembayaran setelah memilih promo.
                        _showPaymentDetails(promo);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5938FB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                      ),
                      child: Text(
                        'Pilih Paket Data',
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

  // Fungsi untuk menampilkan detail pembayaran di pop-up dari bawah.
  void _showPaymentDetails(Map<String, dynamic> promo) {
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
                        promo['details']['nominal'],
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
                        promo['details']['biayaAdmin'],
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
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

  // Fungsi untuk membangun setiap item promo.
  Widget _buildPromoItem(Map<String, dynamic> promo, int index) {
    // Memeriksa apakah item promo saat ini dipilih.
    final isSelected = index == _selectedPromoIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPromoIndex = index;
        });
        _showPaymentDetails(promo);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          // Mengubah warna dan lebar border jika dipilih.
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
                  promo['title'],
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
                      promo['price'],
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF5938FB),
                      ),
                    ),
                    Text(
                      'Keuntungan ${promo['keuntungan']}',
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
                    // Menggunakan TextButton untuk menambahkan border dengan mudah.
                    TextButton(
                      onPressed: () {
                        _showPromoDetails(promo, index);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        minimumSize: Size.zero, // Menghapus batasan ukuran minimum.
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        side: const BorderSide(
                          color: Color(0xFF5938FB), // Border tipis berwarna ungu.
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
            // Menampilkan ikon centang jika promo dipilih.
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
    final selectedPromo = _selectedPromoIndex != -1 ? _promos[_selectedPromoIndex] : null;

    return PopScope(
      // Ini memastikan tombol kembali hardware di Android memicu navigasi kustom kita.
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _onBackPressed();
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // Bagian Header
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
                                // Tombol kembali di UI, sekarang memanggil fungsi _onBackPressed
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
                  // Bagian Input Nomor
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
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _numberController,
                                  onChanged: _onNumberChanged,
                                  decoration: InputDecoration(
                                    hintText: 'Masukkan Nomor Anda',
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 14.sp,
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.phone,
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ),
                              Icon(Icons.person_outline, color: Colors.grey.shade400),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        // Menggunakan Text.rich dengan GestureDetector untuk navigasi
                        Text.rich(
                          TextSpan(
                            text: 'Sudah punya kode bayar? ',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                            children: <InlineSpan>[
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const ByuSatu1Page()),
                                    );
                                  },
                                  child: Text(
                                    'Bayar disini',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF5938FB),
                                      decoration: TextDecoration.underline,
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
                  SizedBox(height: 16.h),
                  // Konten dinamis (loading, error, atau daftar promo)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
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
                        else if (_promos.isNotEmpty)
                            ..._promos.asMap().entries.map((entry) {
                              int index = entry.key;
                              Map<String, dynamic> promo = entry.value;
                              return _buildPromoItem(promo, index);
                            }).toList(),
                      ],
                    ),
                  ),
                  // Menambahkan padding di bagian bawah agar tidak tertutup oleh bilah pembayaran.
                  SizedBox(height: selectedPromo != null ? 80.h : 0),
                ],
              ),
            ),
            // Bilah bawah tetap untuk total pembayaran dan tombol beli.
            if (selectedPromo != null)
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
                          // Menampilkan kembali pop-up detail pembayaran saat bagian total pembayaran diklik.
                          _showPaymentDetails(selectedPromo);
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
                                  selectedPromo['price'],
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
                            // Navigasi ke ByuDuaPage dengan data promo yang dipilih.
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ByuDuaPage(selectedPromo: selectedPromo),
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
