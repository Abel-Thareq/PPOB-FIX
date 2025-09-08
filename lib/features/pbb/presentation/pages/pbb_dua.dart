import 'package:flutter/material.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/features/pbb/presentation/pages/pbb_tiga.dart';
import 'package:ppob_app/features/pbb/presentation/pages/clusterdankabupaten.dart'; // Impor semua yang dibutuhkan dari sini

class PbbDuaPage extends StatefulWidget {
  const PbbDuaPage({super.key});

  @override
  State<PbbDuaPage> createState() => _PbbDuaPageState();
}

class _PbbDuaPageState extends State<PbbDuaPage> {
  String? selectedCluster;
  String? selectedKotaKabupaten;
  String? selectedTahun;
  final TextEditingController _nomorObjekPajakController = TextEditingController();

  // Fungsi untuk navigasi ke halaman baru dan mendapatkan hasil yang dipilih
  Future<void> _navigateToSelectionPage(
      BuildContext context,
      String title,
      List<String> items,
      Function(String) onItemSelected,
      ) async {
    final selectedItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClusterDanKabupatenPage(
          title: title,
          items: items,
        ),
      ),
    );

    if (selectedItem != null && selectedItem is String) {
      onItemSelected(selectedItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Navigator.pop(context);
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
                  Text(
                    'Bayar Pajak PBB',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                  ),
                  const SizedBox(height: 24),
                  _buildInputField(
                    title: 'Cluster',
                    hintText: 'Pilih Cluster',
                    hasDropdown: true,
                    icon: Icons.location_on,
                    onTap: () async {
                      await _navigateToSelectionPage(
                        context,
                        'Pilih Cluster',
                        PBBData.allProvinces,
                        (item) {
                          setState(() {
                            selectedCluster = item;
                            selectedKotaKabupaten = null;
                          });
                        },
                      );
                    },
                    selectedValue: selectedCluster,
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    title: 'Kota/Kabupaten/Kecamatan',
                    hintText: 'Pilih Kota/Kabupaten/Kecamatan',
                    hasDropdown: true,
                    icon: Icons.business,
                    onTap: () async {
                      if (selectedCluster == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Silakan pilih Cluster terlebih dahulu')),
                        );
                        return;
                      }
                      await _navigateToSelectionPage(
                        context,
                        'Pilih Kota/Kabupaten/Kecamatan',
                        PBBData.allCities[selectedCluster] ?? [],
                        (item) {
                          setState(() {
                            selectedKotaKabupaten = item;
                          });
                        },
                      );
                    },
                    selectedValue: selectedKotaKabupaten,
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    title: 'Tahun PBB',
                    hintText: 'Pilih Tahun Pembayaran',
                    hasDropdown: true,
                    icon: Icons.calendar_today,
                    onTap: () async {
                      await _navigateToSelectionPage(
                        context,
                        'Pilih Tahun Pembayaran',
                        PBBData.getYears(),
                        (item) {
                          setState(() {
                            selectedTahun = item;
                          });
                        },
                      );
                    },
                    selectedValue: selectedTahun,
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    title: 'Nomor Objek Pajak',
                    hintText: 'Masukkan Nomor Objek Pajak',
                    hasDropdown: false,
                    icon: Icons.description,
                    controller: _nomorObjekPajakController,
                  ),
                  const SizedBox(height: 30),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomButton(
              text: 'Lanjutkan',
              onPressed: () {
                // Pass selected values to the next page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PbbTigaPage(
                      nominalBayar: 150000,
                      denda: 10000,
                      biayaAdmin: 2500,
                      keterangan: "1103 ${selectedKotaKabupaten ?? 'Tidak Ada'}",
                      lokasi: selectedCluster ?? 'Tidak Ada',
                      namaPelanggan: "ABXX XXXXX",
                      nomorObjekPajak: _nomorObjekPajakController.text,
                      kabupaten: selectedKotaKabupaten ?? 'Tidak Ada',
                      tahun: selectedTahun ?? 'Tidak Ada',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String title,
    required String hintText,
    required bool hasDropdown,
    required IconData icon,
    VoidCallback? onTap,
    String? selectedValue,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xFF6A1B9A),
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.grey[600],
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: controller != null
                        ? TextField(
                            controller: controller,
                            readOnly: hasDropdown,
                            decoration: InputDecoration(
                              hintText: hintText,
                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              selectedValue ?? hintText,
                              style: TextStyle(
                                color: selectedValue != null ? Colors.black : Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ),
                  ),
                  if (hasDropdown)
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                      size: 24,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
