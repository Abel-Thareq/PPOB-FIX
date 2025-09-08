import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/topup/presentation/pages/topupgame_dua.dart';

/// Widget utama untuk halaman Top Up Game.
/// Ini adalah halaman pertama di mana pengguna memilih game dan memasukkan ID.
class TopUpGameSatu extends StatefulWidget {
  // Properti untuk menerima data dari halaman sebelumnya.
  final String gameTitle;
  final dynamic gameIcon;
  final List<Map<String, dynamic>> gameItems;

  const TopUpGameSatu({
    super.key,
    required this.gameTitle,
    required this.gameIcon,
    required this.gameItems,
  });

  @override
  State<TopUpGameSatu> createState() => _TopUpGameSatuState();
}

class _TopUpGameSatuState extends State<TopUpGameSatu> {
  // State untuk mengelola data yang dipilih dan input pengguna.
  late String _selectedGameTitle;
  late dynamic _selectedGameIcon;
  String _productSelectionText = 'Pilih jumlah diamond';
  String? _selectedPrice;
  String? _selectedImagePath;
  final TextEditingController _gameIdController = TextEditingController();
  final TextEditingController _serverIdController = TextEditingController();
  bool _isButtonEnabled = false;

  late String _productLabel;
  late Widget _productIconWidget;
  late String _idHintText;

  @override
  void initState() {
    super.initState();
    // Inisialisasi state awal dengan data yang diterima melalui widget.
    _selectedGameTitle = widget.gameTitle;
    _selectedGameIcon = widget.gameIcon;

    // Panggil fungsi untuk memperbarui UI berdasarkan game yang dipilih.
    _updateUIForGameSelection();
    // Tambahkan listener untuk mendengarkan perubahan pada field input.
    _gameIdController.addListener(_checkFields);
    _serverIdController.addListener(_checkFields);
  }

  @override
  void dispose() {
    // Hapus listener dan dispose controller untuk menghindari memory leaks.
    _gameIdController.removeListener(_checkFields);
    _serverIdController.removeListener(_checkFields);
    _gameIdController.dispose();
    _serverIdController.dispose();
    super.dispose();
  }

  /// Memperbarui teks dan ikon UI berdasarkan game yang dipilih.
  void _updateUIForGameSelection() {
    setState(() {
      // Logika untuk menentukan label produk dan ikon berdasarkan game.
      if (_selectedGameTitle == 'Point Blank') {
        _productLabel = 'Pilih Jumlah PB Cash';
        _productIconWidget = Image.asset('assets/images/iconpbcash.png', width: 32.w, height: 32.w);
        _productSelectionText = _productLabel;
      } else if (_selectedGameTitle == 'Ragnarok M.E.L') {
        _productLabel = 'Pilih Jumlah Big Cat Coins';
        _productIconWidget = Image.asset('assets/images/iconbigcatcoins.png', width: 32.w, height: 32.w);
        _productSelectionText = _productLabel;
      } else if (_selectedGameTitle == 'Garena') {
        _productLabel = 'Pilih Jumlah Shell';
        _productIconWidget = Image.asset('assets/images/iconshell.png', width: 32.w, height: 32.w);
        _productSelectionText = _productLabel;
      } else if (_selectedGameTitle == 'PUBG Mobile') {
        _productLabel = 'Pilih Jumlah UC';
        _productIconWidget = Image.asset('assets/images/iconpubgm.png', width: 32.w, height: 32.w);
        _productSelectionText = _productLabel;
      } else if (_selectedGameTitle == 'Valorant') {
        _productLabel = 'Pilih Jumlah VP';
        _productIconWidget = Image.asset('assets/images/iconvalorant.png', width: 32.w, height: 32.w);
        _productSelectionText = _productLabel;
      } else if (_selectedGameTitle == 'Call of Duty Mobile') {
        _productLabel = 'Pilih Jumlah CP';
        _productIconWidget = Image.asset('assets/images/iconcodm.png', width: 32.w, height: 32.w);
        _productSelectionText = _productLabel;
      } else if (_selectedGameTitle == 'Honor of Kings') { // Perubahan baru untuk Honor of Kings
        _productLabel = 'Pilih Jumlah Token';
        _productIconWidget = Image.asset('assets/images/iconhok.png', width: 32.w, height: 32.w);
        _productSelectionText = _productLabel;
      } else if (_selectedGameTitle == 'Genshin Impact') { // Perubahan baru untuk Genshin Impact
        _productLabel = 'Pilih Produk';
        _productIconWidget = Image.asset('assets/images/icongenshin.png', width: 32.w, height: 32.w);
        _productSelectionText = _productLabel;
      } else {
        _productLabel = 'Pilih jumlah diamond';
        _productIconWidget = Image.asset('assets/images/icondiamonds.png', width: 32.w, height: 32.w);
        _productSelectionText = _productLabel;
      }

      // Logika untuk menentukan teks petunjuk ID berdasarkan game.
      if (_selectedGameTitle == 'Mobile Legend') {
        _idHintText = 'Masukkan User ID dan Server sesuai game anda';
      } else {
        _idHintText = 'Masukkan User ID sesuai game anda';
      }

      // Reset input fields dan data produk yang dipilih saat game berubah.
      _gameIdController.clear();
      _serverIdController.clear();
      _selectedPrice = null;
      _selectedImagePath = null;
      _checkFields();
    });
  }

  /// Memeriksa validitas field input untuk mengaktifkan tombol 'Lanjutkan'.
  void _checkFields() {
    setState(() {
      if (_selectedGameTitle == 'Mobile Legend') {
        _isButtonEnabled = _gameIdController.text.isNotEmpty &&
            _serverIdController.text.isNotEmpty &&
            _productSelectionText != _productLabel &&
            _selectedPrice != null;
      } else {
        _isButtonEnabled = _gameIdController.text.isNotEmpty &&
            _productSelectionText != _productLabel &&
            _selectedPrice != null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    // Menentukan widget ikon yang akan ditampilkan di UI.
    Widget displayIconWidget;
    if (_selectedGameIcon is String) {
      displayIconWidget = Image.asset(_selectedGameIcon, width: 32.w, height: 32.w);
    } else {
      displayIconWidget = Icon(_selectedGameIcon, size: 32.w, color: Colors.grey[600]);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Bagian header dengan gambar dan tombol kembali.
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
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, size: 28.r),
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kotak input untuk memilih game.
                  _buildInputBox(
                    context,
                    label: 'Pilih Game',
                    child: GestureDetector(
                      onTap: () async {
                        final selectedGame = await _showGameListModal(context);
                        if (selectedGame != null) {
                          setState(() {
                            _selectedGameTitle = selectedGame['title'];
                            _selectedGameIcon = selectedGame['icon'];
                            _updateUIForGameSelection();
                          });
                        }
                      },
                      child: Row(
                        children: [
                          displayIconWidget,
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              _selectedGameTitle,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Kotak input untuk Game ID dan Server ID.
                  _buildInputBox(
                    context,
                    label: 'Game ID',
                    child: Column(
                      children: [
                        TextField(
                          controller: _gameIdController,
                          decoration: InputDecoration(
                            hintText: 'Masukkan User ID',
                            prefixIcon: const Icon(Icons.person_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        if (_selectedGameTitle == 'Mobile Legend') ...[
                          SizedBox(height: 8.h),
                          TextField(
                            controller: _serverIdController,
                            decoration: InputDecoration(
                              hintText: 'Masukkan Server ID',
                              prefixIcon: const Icon(Icons.apps),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ],
                        SizedBox(height: 8.h),
                        Text(
                          _idHintText,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Kotak input untuk memilih produk, sekarang tanpa warna abu-abu.
                  _buildInputBox(
                    context,
                    label: 'Pilih Produk',
                    child: GestureDetector(
                      onTap: () {
                        _showProductModal(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h), // Padding horizontal diubah di sini
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 24.w,
                              height: 24.h,
                              child: _productIconWidget,
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Text(
                                _productSelectionText,
                                style: TextStyle(
                                  fontSize: 12.sp, // Ukuran font dikembalikan ke semula
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Tombol 'Lanjutkan'.
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isButtonEnabled
                    ? () {
                  String serverIdToSend = (_selectedGameTitle == 'Mobile Legend') ? _serverIdController.text : " ";
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopUpGameDua(
                        gameTitle: _selectedGameTitle,
                        gameIcon: _selectedGameIcon,
                        gameId: _gameIdController.text,
                        serverId: serverIdToSend,
                        selectedDiamond: _productSelectionText,
                        diamondImagePath: _selectedImagePath!,
                        price: _selectedPrice!,
                      ),
                    ),
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isButtonEnabled ? const Color(0xFF5938FB) : const Color(0xFFEFEFF3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  elevation: 0,
                ),
                child: Text(
                  'Lanjutkan',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: _isButtonEnabled ? Colors.white : Colors.grey[600],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Menampilkan modal untuk memilih game.
  Future<Map<String, dynamic>?> _showGameListModal(BuildContext context) async {
    return await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            children: [
              // Header modal.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pilih Game',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              // Field pencarian.
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cari Game Kamu',
                  prefixIcon: const Icon(Icons.search, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              // Tampilan grid untuk daftar game.
              Expanded(
                child: GridView.builder(
                  // Ubah physics dari NeverScrollableScrollPhysics menjadi AlwaysScrollableScrollPhysics
                  // agar GridView bisa di-scroll tanpa SingleChildScrollView di atasnya.
                  physics: const AlwaysScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.w,
                    mainAxisSpacing: 8.h,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: widget.gameItems.length,
                  itemBuilder: (context, index) {
                    final item = widget.gameItems[index];
                    final dynamic iconData = item['icon'];
                    Widget iconWidget;
                    const double iconContainerSize = 56;
                    const double iconPadding = 6;

                    if (iconData is String) {
                      iconWidget = ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.asset(
                          iconData,
                          fit: BoxFit.cover,
                          width: iconContainerSize.w,
                          height: iconContainerSize.w,
                        ),
                      );
                    } else {
                      iconWidget = Icon(iconData, size: (iconContainerSize - (iconPadding * 2)).w, color: Colors.grey[600]);
                    }

                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context, item);
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 56.w,
                            height: 56.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: Colors.grey[300]!),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4.r,
                                  offset: Offset(0, 2.h),
                                ),
                              ],
                            ),
                            child: Center(
                              child: iconWidget,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            item['title']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Menampilkan modal untuk memilih produk (diamond, PB Cash, dll).
  void _showProductModal(BuildContext context) {
    // List produk yang dibuat secara dinamis.
    final List<Map<String, dynamic>> productItems = [];
    final isPointBlank = _selectedGameTitle == 'Point Blank';
    final isRagnarok = _selectedGameTitle == 'Ragnarok M.E.L';
    final isGarena = _selectedGameTitle == 'Garena';
    final isPUBGM = _selectedGameTitle == 'PUBG Mobile';
    final isValorant = _selectedGameTitle == 'Valorant';
    final isCodm = _selectedGameTitle == 'Call of Duty Mobile';
    final isHok = _selectedGameTitle == 'Honor of Kings'; // Perubahan baru untuk Honor of Kings
    final isGenshinImpact = _selectedGameTitle == 'Genshin Impact'; // Perubahan baru untuk Genshin Impact

    if (isGenshinImpact) {
      // Perubahan: Menggunakan list produk statis untuk Genshin Impact
      productItems.addAll([
        {
          'productText': 'Blessing of the Welkin Moon',
          'imagePath': 'assets/images/genshin1.png',
          'price': '70000',
          'subtitle': null,
        },
        {
          'productText': '60 Genesis Crystals',
          'imagePath': 'assets/images/genshin2.png',
          'price': '20000',
          'subtitle': null,
        },
        {
          'productText': '300 Genesis Crystals',
          'imagePath': 'assets/images/genshin2.png',
          'price': '60000',
          'subtitle': 'Bonus 30',
        },
        {
          'productText': '980 Genesis Crystals',
          'imagePath': 'assets/images/genshin2.png',
          'price': '160000',
          'subtitle': 'Bonus 110',
        },
        {
          'productText': '1980 Genesis Crystals',
          'imagePath': 'assets/images/genshin2.png',
          'price': '300000',
          'subtitle': 'Bonus 260',
        },
        {
          'productText': '3280 Genesis Crystals',
          'imagePath': 'assets/images/genshin2.png',
          'price': '500000',
          'subtitle': 'Bonus 300',
        },
        {
          'productText': '6480 Genesis Crystals',
          'imagePath': 'assets/images/genshin2.png',
          'price': '1000000',
          'subtitle': 'Bonus 600',
        },
      ]);
    } else {
      // Logika lama untuk game lain yang menggunakan loop dinamis
      for (int i = 1; i <= 100; i += 2) {
        String imagePath;
        String productText;
        int price = i * 1000; // Harga produk

        if (isPointBlank) {
          imagePath = 'assets/images/pbcash.png';
          productText = '${i}K PB Cash';
        } else if (isRagnarok) {
          if (i <= 20) {
            imagePath = 'assets/images/bigcatcoins.png';
          } else if (i <= 50) {
            imagePath = 'assets/images/manybigcatcoins.png';
          } else {
            imagePath = 'assets/images/muchbigcatcoins.png';
          }
          productText = '${i} Big Cat Coins';
        } else if (isGarena) {
          imagePath = 'assets/images/shell.png';
          productText = '${i} Shell';
        } else if (isPUBGM) {
          if (i <= 20) {
            imagePath = 'assets/images/uc.png';
          } else if (i <= 50) {
            imagePath = 'assets/images/manyuc.png';
          } else if (i <= 75) {
            imagePath = 'assets/images/muchuc.png';
          } else {
            imagePath = 'assets/images/verymuchuc.png';
          }
          productText = '${i} UC';
        } else if (isValorant) {
          imagePath = 'assets/images/iconvalorant.png';
          productText = '${i} VP';
        } else if (isCodm) {
          if (i <= 20) {
            imagePath = 'assets/images/cp.png';
          } else if (i <= 50) {
            imagePath = 'assets/images/manycp.png';
          } else {
            imagePath = 'assets/images/muchcp.png';
          }
          productText = '${i} CP';
        } else if (isHok) { // Perubahan baru untuk Honor of Kings
          if (i <= 20) {
            imagePath = 'assets/images/hoktoken.png';
          } else if (i <= 50) {
            imagePath = 'assets/images/manyhoktoken.png';
          } else {
            imagePath = 'assets/images/muchhoktoken.png';
          }
          productText = '${i} Token';
        } else {
          if (i <= 20) {
            imagePath = 'assets/images/diamonds.png';
          } else if (i <= 50) {
            imagePath = 'assets/images/manydiamonds.png';
          } else {
            imagePath = 'assets/images/muchdiamonds.png';
          }
          productText = '${i} Diamond';
        }
        productItems.add({
          'productText': productText,
          'imagePath': imagePath,
          'count': i,
          'price': price.toStringAsFixed(0),
        });
      }
    }


    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            children: [
              // Header modal produk.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isPointBlank
                        ? 'Pilih PB Cash'
                        : isRagnarok
                        ? 'Pilih Big Cat Coins'
                        : isGarena
                        ? 'Pilih Shell'
                        : isPUBGM
                        ? 'Pilih UC'
                        : isValorant
                        ? 'Pilih VP'
                        : isCodm
                        ? 'Pilih CP'
                        : isHok
                        ? 'Pilih Token'
                        : isGenshinImpact
                        ? 'Pilih Produk'
                        : 'Pilih Produk',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              // Field pencarian.
              TextField(
                decoration: InputDecoration(
                  hintText: isPointBlank
                      ? 'Cari PB Cash'
                      : isRagnarok
                      ? 'Cari Big Cat Coins'
                      : isGarena
                      ? 'Cari Shell'
                      : isPUBGM
                      ? 'Cari UC'
                      : isValorant
                      ? 'Cari VP'
                      : isCodm
                      ? 'Cari CP'
                      : isHok
                      ? 'Cari Token'
                      : isGenshinImpact
                      ? 'Cari Produk'
                      : 'Cari Produk',
                  prefixIcon: const Icon(Icons.search, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              // Tampilan grid untuk daftar produk.
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  // Ubah physics dari NeverScrollableScrollPhysics menjadi AlwaysScrollableScrollPhysics
                  // agar GridView bisa di-scroll.
                  physics: const AlwaysScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: productItems.length,
                  itemBuilder: (context, index) {
                    final item = productItems[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _productSelectionText = item['productText'];
                          _selectedPrice = item['price'];
                          _selectedImagePath = item['imagePath'];
                        });
                        Navigator.pop(context);
                        _checkFields();
                      },
                      child: Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.grey[300]!),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4.r,
                              offset: Offset(0, 2.h),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item['productText'],
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // Perubahan: Menambahkan subtitle (bonus) jika ada.
                            if (item['subtitle'] != null)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item['subtitle']!,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            Expanded(
                              child: Center(
                                child: Image.asset(
                                  item['imagePath'],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Rp${item['price']}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF5938FB),
                                  ),
                                ),
                                // Perubahan: Menggunakan teks 'Keuntungan Rp0' sebagai fallback
                                // jika subtitle tidak ada.
                                if (item['subtitle'] == null)
                                  Text(
                                    'Keuntungan Rp0',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Widget pembantu untuk membuat kotak input dengan label.
  Widget _buildInputBox(BuildContext context, {required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey[300]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4.r,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          child: child,
        ),
      ],
    );
  }
}
