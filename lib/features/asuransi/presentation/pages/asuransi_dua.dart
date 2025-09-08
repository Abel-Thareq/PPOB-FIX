import 'package:flutter/material.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/features/asuransi/presentation/pages/asuransi_page.dart';
import 'package:ppob_app/features/asuransi/presentation/pages/asuransi_tiga.dart';

class AsuransiDuaPage extends StatefulWidget {
  const AsuransiDuaPage({super.key});

  @override
  State<AsuransiDuaPage> createState() => _AsuransiDuaPageState();
}

class _AsuransiDuaPageState extends State<AsuransiDuaPage> {
  String? _selectedInsuranceType;
  String? _selectedPaymentType;
  final TextEditingController _policyNumberController = TextEditingController();

  // Daftar jenis asuransi dan path gambar
  final Map<String, String> _insuranceIconPaths = {
    'Asuransi IFG Life': 'assets/images/ifg_life.png',
    'Asuransi Allianz Life': 'assets/images/allianz_life.png',
    'Asuransi CAR': 'assets/images/car.png',
  };

  // Daftar tipe pembayaran
  final List<String> _paymentTypes = [
    'Premi Pertama',
    'Premi Lanjutan',
    'Pemulihan',
    'Top Up',
    'Perubahan',
    'Cetak Polis',
  ];

  void _showInsuranceTypeBottomSheet() {
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
                'Pilih Jenis Asuransi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Iterasi dari map untuk menampilkan nama dan gambar asuransi
              ..._insuranceIconPaths.entries.map((entry) {
                return ListTile(
                  leading: Image.asset(entry.value, width: 40, height: 40),
                  title: Text(entry.key),
                  onTap: () {
                    setState(() {
                      _selectedInsuranceType = entry.key;
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

  void _showPaymentTypeBottomSheet() {
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
                'Pilih Tipe Pembayaran',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ..._paymentTypes.map((type) {
                return ListTile(
                  title: Text(type),
                  onTap: () {
                    setState(() {
                      _selectedPaymentType = type;
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
    if (_selectedInsuranceType == null || _selectedInsuranceType!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih jenis asuransi terlebih dahulu')),
      );
      return;
    }

    if (_selectedPaymentType == null || _selectedPaymentType!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih tipe pembayaran terlebih dahulu')),
      );
      return;
    }

    if (_policyNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan nomor polis terlebih dahulu')),
      );
      return;
    }

    // Navigasi ke halaman berikutnya dengan membawa data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AsuransiTigaPage(
          insuranceType: _selectedInsuranceType!,
          paymentType: _selectedPaymentType!,
          policyNumber: _policyNumberController.text,
          insuranceIconPaths: _insuranceIconPaths[_selectedInsuranceType!] ?? 'assets/images/default_icon.png',
        ),
      ),
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
          MaterialPageRoute(builder: (_) => const AsuransiPage()),
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
                        MaterialPageRoute(builder: (_) => const AsuransiPage()),
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
                        // Judul halaman
                        const Text(
                          'Bayar Asuransi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Input Jenis Asuransi
                        const Text(
                          'Jenis Asuransi',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Widget untuk memilih jenis asuransi
                        GestureDetector(
                          onTap: _showInsuranceTypeBottomSheet,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.security, color: Colors.grey, size: 24),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    _selectedInsuranceType ?? 'Pilih Jenis Asuransi',
                                    style: TextStyle(
                                      color: _selectedInsuranceType != null ? Colors.black : Colors.grey,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Input Tipe Pembayaran
                        const Text(
                          'Tipe Pembayaran',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Widget untuk memilih tipe pembayaran
                        GestureDetector(
                          onTap: _showPaymentTypeBottomSheet,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.payment, color: Colors.grey, size: 24),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    _selectedPaymentType ?? 'Pilih Tipe Pembayaran',
                                    style: TextStyle(
                                      color: _selectedPaymentType != null ? Colors.black : Colors.grey,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Input Nomor Polis
                        const Text(
                          'Nomor Polis',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Widget untuk input nomor polis
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.description, color: Colors.grey, size: 24),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextField(
                                  controller: _policyNumberController,
                                  decoration: const InputDecoration(
                                    hintText: 'Masukkan Nomor Polis',
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 40),

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
}