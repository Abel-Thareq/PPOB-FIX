import 'package:flutter/material.dart';
import 'package:ppob_app/features/home/presentation/pages/tagihan_page.dart';
import 'package:ppob_app/features/samsat/presentation/pages/samsat_dua.dart';
import 'package:ppob_app/features/samsat/presentation/pages/provinsi_data.dart';

class SamsatPage extends StatefulWidget {
  const SamsatPage({super.key});

  @override
  State<SamsatPage> createState() => _SamsatPageState();
}

class _SamsatPageState extends State<SamsatPage> {
  final TextEditingController _kodePembayaranController = TextEditingController();
  String? _selectedProvince;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _kodePembayaranController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _kodePembayaranController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _selectedProvince != null && _kodePembayaranController.text.isNotEmpty;
    });
  }

  void _showProvinceListPopup() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.2,
          maxChildSize: 0.8,
          builder: (_, controller) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const Text(
                    'Pilih Wilayah',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      controller: controller,
                      itemCount: kProvinces.length,
                      itemBuilder: (context, index) {
                        final province = kProvinces[index];
                        return ListTile(
                          title: Text(province),
                          onTap: () {
                            setState(() {
                              _selectedProvince = province;
                              _validateForm();
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const TagihanPage()),
          (route) => false,
        );
      },
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 120,
                  color: Colors.white,
                  child: Image.asset(
                    'assets/images/header.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.black,
                      iconSize: 28,
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const TagihanPage()),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'Pilih Wilayah',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _showProvinceListPopup,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.grey),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                _selectedProvince ?? 'Pilih Wilayah',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _selectedProvince == null ? Colors.grey[600] : Colors.black,
                                ),
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Kode Pembayaran',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextField(
                          controller: _kodePembayaranController,
                          onChanged: (_) => _validateForm(),
                          decoration: InputDecoration(
                            hintText: 'Masukkan Kode Pembayaran',
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.normal,
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 13),
                            isDense: true,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Image.asset(
                                'assets/images/payment_icon.png',
                                width: 0.1,
                                height: 0.1,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    if (_isFormValid) ...[
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3E8FF),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.info_outline_rounded, color: Color(0xFF55229E)),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Informasi',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF55229E),
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  RichText(
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: const <TextSpan>[
                                        TextSpan(
                                          text: 'Kode Pembayaran didapatkan dengan mengikuti langkah-langkah berikut:\n\n1. Pastikan telah memiliki akun SIGNAL.\n2. Daftarkan kendaraan jika belum terdaftar.\n3. Dapatkan kode pembayaran pada SIGNAL dan bayar melalui modipay.\n\nLihat langkah lebih lengkap dengan klik menu kiri atas pada halaman ini.',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF55229E),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFormValid ? const Color(0xFF55229E) : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _isFormValid ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SamsatDuaPage(
                          provinsi: _selectedProvince!,
                          kodePembayaran: _kodePembayaranController.text,
                        ),
                      ),
                    );
                  } : null,
                  child: const Text(
                    'Lanjutkan',
                    style: TextStyle(color: Colors.white, fontSize: 16),
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
