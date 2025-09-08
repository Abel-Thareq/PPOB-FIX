import 'package:flutter/material.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/features/kabelinternet/presentation/pages/internet_page.dart';
import 'package:ppob_app/features/kabelinternet/presentation/pages/internet_tiga.dart';

class InternetDuaPage extends StatefulWidget {
  const InternetDuaPage({super.key});

  @override
  State<InternetDuaPage> createState() => _InternetDuaPageState();
}

class _InternetDuaPageState extends State<InternetDuaPage> {
  String? _selectedService;
  final TextEditingController _customerNumberController = TextEditingController();

  // Daftar layanan dengan gambar
  final List<Map<String, String>> _services = [
    {'name': 'Kawan K-Vision', 'image': 'assets/images/kawan.png'},
    {'name': 'K-Vision dan GOL', 'image': 'assets/images/kvision.png'},
    {'name': 'WeTV', 'image': 'assets/images/wetv.png'},
    {'name': 'Transvision', 'image': 'assets/images/transvision.png'},
    {'name': 'Vidio Streaming', 'image': 'assets/images/vidio.png'},
    {'name': 'Bstation Streaming', 'image': 'assets/images/bstation.png'},
  ];

  void _showServiceSelectionBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: FractionallySizedBox(
                  widthFactor: 0.15,
                  child: Divider(
                    thickness: 4,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Pilih Jenis Layanan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ..._services.map((service) {
                return ListTile(
                  leading: Image.asset(
                    service['image']!,
                    width: 32,
                    height: 32,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  ),
                  title: Text(service['name']!),
                  onTap: () {
                    setState(() {
                      _selectedService = service['name'];
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  void _onContinuePressed() {
    // Validasi input
    if (_selectedService == null || _selectedService!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih jenis layanan terlebih dahulu')),
      );
      return;
    }

    if (_customerNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan nomor pelanggan terlebih dahulu')),
      );
      return;
    }

    // Navigasi ke halaman berikutnya dengan membawa data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InternetTigaPage(
          selectedService: _selectedService!,
          customerNumber: _customerNumberController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Menentukan jalur gambar untuk ikon layanan yang dipilih
    String serviceIconPath = 'assets/images/iconsinyal.png';
    if (_selectedService != null) {
      final selectedService = _services.firstWhere(
        (service) => service['name'] == _selectedService,
        orElse: () => {'image': 'assets/images/iconsinyal.png'},
      );
      serviceIconPath = selectedService['image']!;
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const InternetPage()),
          (route) => false,
        );
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Header dengan gambar latar belakang
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 120,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/header.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Tombol kembali (diposisikan tetap di atas)
            Positioned(
              top: 0,
              left: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    iconSize: 28,
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const InternetPage()),
                        (route) => false,
                      );
                    },
                  ),
                ),
              ),
            ),

            // Konten utama yang tumpang tindih dengan header
            Positioned(
              top: 130,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Judul halaman sekarang berada di dalam kontainer putih
                        const Text(
                          'Bayar TV Kabel & Internet',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Input Jenis Layanan
                        const Text(
                          'TV Kabel & Internet',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        
                        // Widget untuk memilih layanan (sekarang bisa diklik)
                        GestureDetector(
                          onTap: _showServiceSelectionBottomSheet,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: Row(
                              children: [
                                Image.asset(serviceIconPath, height: 24, width: 24),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    _selectedService ?? 'Pilih Jenis Layanan',
                                    style: TextStyle(
                                      color: _selectedService != null ? Colors.black : Colors.grey,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Input Nomor Pelanggan
                        const Text(
                          'Nomor Pelanggan',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildTextInput(
                          context,
                          hintText: 'Masukkan Nomor Pelanggan',
                          iconPath: 'assets/images/profile.png',
                          controller: _customerNumberController,
                        ),

                        const SizedBox(height: 300),
                        
                        // Tombol Lanjutkan
                        Center(
                          child: CustomButton(
                            text: 'Lanjutkan',
                            onPressed: _onContinuePressed,
                          ),
                        ),
                      ],
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

  Widget _buildTextInput(BuildContext context, {
    required String hintText, 
    required String iconPath,
    required TextEditingController controller,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Row(
        children: [
          Image.asset(iconPath, height: 24, width: 24, color: Colors.grey),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}
