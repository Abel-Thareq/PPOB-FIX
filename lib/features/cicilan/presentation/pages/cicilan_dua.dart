import 'package:flutter/material.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/features/cicilan/presentation/pages/cicilan_tiga.dart';
import 'package:ppob_app/features/home/presentation/pages/tagihan_page.dart';

// Definisi model untuk data penyedia cicilan
class CicilanProvider {
  final String name;
  final String assetPath;

  const CicilanProvider({required this.name, required this.assetPath});
}

class CicilanDuaPage extends StatefulWidget {
  const CicilanDuaPage({super.key});

  @override
  State<CicilanDuaPage> createState() => _CicilanDuaPageState();
}

class _CicilanDuaPageState extends State<CicilanDuaPage> {
  final TextEditingController _nomorPelangganController = TextEditingController();
  final List<CicilanProvider> _cicilanOptions = const [
    CicilanProvider(name: 'FIF (Federal International Finance)', assetPath: 'assets/images/fif.png'),
    CicilanProvider(name: 'BRI Finance', assetPath: 'assets/images/bri_finance.png'),
    CicilanProvider(name: 'Artha Prima Finance', assetPath: 'assets/images/artha_prima_finance.png'),
    CicilanProvider(name: 'Al Ijarah Finance', assetPath: 'assets/images/al_ijarah_finance.png'),
    CicilanProvider(name: 'ACC (Astra Credit Finance)', assetPath: 'assets/images/acc.png'),
    CicilanProvider(name: 'BPR Kredit Mandiri', assetPath: 'assets/images/bpr_kredit_mandiri.png'),
    CicilanProvider(name: 'Ceria', assetPath: 'assets/images/ceria.png'),
    CicilanProvider(name: 'Buana Finance', assetPath: 'assets/images/buana_finance.png'),
    CicilanProvider(name: 'Indomobil Finance', assetPath: 'assets/images/indomobil_finance.png'),
    CicilanProvider(name: 'Kreditplus Mobil', assetPath: 'assets/images/kreditplus_mobil.png'),
    CicilanProvider(name: 'Mandala Finance', assetPath: 'assets/images/mandala_finance.png'),
    CicilanProvider(name: 'JACCS MPM Finance Indonesia', assetPath: 'assets/images/jaccs_mpm_finance.png'),
    CicilanProvider(name: 'BAF (Bussan Auto Finance)', assetPath: 'assets/images/baf.png'),
  ];

  CicilanProvider? _selectedCicilanProvider;

  void _showCicilanListPopup() {
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
                    'Pilih Jenis Cicilan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      controller: controller,
                      itemCount: _cicilanOptions.length,
                      itemBuilder: (context, index) {
                        final provider = _cicilanOptions[index];
                        return ListTile(
                          leading: Image.asset(
                            provider.assetPath,
                            width: 32,
                            height: 32,
                          ),
                          title: Text(provider.name),
                          onTap: () {
                            setState(() {
                              _selectedCicilanProvider = provider;
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
  void dispose() {
    _nomorPelangganController.dispose();
    super.dispose();
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
            // Header
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
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),

            // Konten utama
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'Jenis Cicilan',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _showCicilanListPopup,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            _selectedCicilanProvider != null
                                ? Image.asset(
                                    _selectedCicilanProvider!.assetPath,
                                    width: 24,
                                    height: 24,
                                  )
                                : const Icon(Icons.credit_card, color: Colors.grey),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                _selectedCicilanProvider?.name ?? 'Pilih Jenis Cicilan',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _selectedCicilanProvider == null ? Colors.grey[600] : Colors.black,
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
                      'Nomor Pelanggan',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: _nomorPelangganController,
                        decoration: InputDecoration(
                          hintText: 'Masukkan Nomor Pelanggan',
                          hintStyle: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.normal,
                          ),
                          // Menghilangkan semua jenis border
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          isDense: true,
                        ),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Tombol "Lanjutkan"
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: CustomButton(
                text: 'Lanjutkan',
                onPressed: () {
                  // Validasi input
                  if (_selectedCicilanProvider == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pilih jenis cicilan terlebih dahulu')),
                    );
                    return;
                  }
                  
                  if (_nomorPelangganController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Masukkan nomor pelanggan terlebih dahulu')),
                    );
                    return;
                  }

                  // Navigasi ke halaman CicilanTigaPage dengan data yang relevan
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CicilanTigaPage(
                        nomorPelanggan: _nomorPelangganController.text,
                        selectedProviderName: _selectedCicilanProvider!.name,
                        selectedProviderAssetPath: _selectedCicilanProvider!.assetPath,
                        // Data placeholder untuk demonstrasi UI
                        totalTagihan: 447400, 
                        biayaAdmin: 0,
                        namaPelanggan: 'ALFIN CHIPMUNK',
                        jatuhTempo: '02 Mei 2025',
                        angsuranKe: 18,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
