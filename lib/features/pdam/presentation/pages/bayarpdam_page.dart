import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppob_app/features/pdam/presentation/pages/bayarpdam_pagedua.dart';
import 'package:ppob_app/features/pdam/presentation/pages/kabupaten_data.dart';

class BayarPdamPage extends StatefulWidget {
  const BayarPdamPage({super.key});

  @override
  State<BayarPdamPage> createState() => _BayarPdamPageState();
}

class _BayarPdamPageState extends State<BayarPdamPage> {
  String? selectedWilayah;
  final TextEditingController _nomorPelangganController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nomorPelangganController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _nomorPelangganController.removeListener(_updateButtonState);
    _nomorPelangganController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {});
  }

  void _showWilayahPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        String? selectedProvinsi;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateModal) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.8,
              minChildSize: 0.4,
              maxChildSize: 0.95,
              builder: (context, scrollController) {
                if (selectedProvinsi != null) {
                  final kabupatenList = provinsiKabupaten[selectedProvinsi]!;
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        height: 4,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 13.0),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              color: Colors.white,
                              onPressed: () {
                                setStateModal(() {
                                  selectedProvinsi = null;
                                });
                              },
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Pilih Kabupaten/Kota - $selectedProvinsi",
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: kabupatenList.length,
                          itemBuilder: (context, index) {
                            final kabupaten = kabupatenList[index];
                            return ListTile(
                              title: Text(kabupaten),
                              onTap: () {
                                setState(() {
                                  this.selectedWilayah = "$kabupaten, $selectedProvinsi";
                                });
                                _updateButtonState();
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        height: 4,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Pilih Provinsi",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(height: 1),
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          children: [
                            ...provinsiKabupaten.keys.map((provinsi) {
                              return ListTile(
                                title: Text(provinsi),
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () {
                                  setStateModal(() {
                                    selectedProvinsi = provinsi;
                                  });
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isButtonActive = selectedWilayah != null && _nomorPelangganController.text.length == 5;

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
                  padding: const EdgeInsets.only(top: 10.0, left: 13.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    iconSize: 28,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Bayar PDAM',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Pilih wilayah anda dan nomor anda',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  const Text(
                    'Wilayah',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  _buildSelectionCard(
                    icon: 'assets/images/district.png',
                    title: selectedWilayah ?? 'Pilih Wilayah',
                    onTap: _showWilayahPicker,
                  ),
                  const SizedBox(height: 12),

                  const Text(
                    'Nomor Pelanggan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // CONTAINER INPUT NOMOR PELANGGAN DENGAN BORDER
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!), // BORDER DITAMBAHKAN DI SINI
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/images/searchbold.png', width: 22, height: 22),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _nomorPelangganController,
                            keyboardType: TextInputType.number,
                            maxLength: 5,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(
                              hintText: 'Masukkan 5 digit nomor pelanggan',
                              border: InputBorder.none, // Tetap none karena border sudah di container
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 10),
                              counterText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Center(
                    child: Text(
                      'Belum Ada Daftar Tersimpan',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton(
              onPressed: isButtonActive
                  ? () {
                // Mengirimkan data ke halaman BayarPDAMPagedua
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BayarPDAMPagedua(
                      nomorPelanggan: _nomorPelangganController.text,
                      alamatWilayah: selectedWilayah!,
                    ),
                  ),
                );
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isButtonActive ? const Color(0xFF6C4EFF) : Colors.grey[400],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                'Lanjutkan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionCard({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Image.asset(icon, width: 24, height: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}