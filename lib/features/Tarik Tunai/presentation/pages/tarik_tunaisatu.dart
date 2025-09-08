import 'package:ppob_app/features/Tarik%20Tunai/presentation/pages/tarik_tunaidua.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// Class untuk memformat input nominal secara real-time
class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String cleanedText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanedText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    String formattedText = NumberFormat.currency(
        locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
        .format(int.parse(cleanedText));

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class TarikTunaiSatuPage extends StatefulWidget {
  const TarikTunaiSatuPage({super.key});

  @override
  State<TarikTunaiSatuPage> createState() => _TarikTunaiSatuPageState();
}

class _TarikTunaiSatuPageState extends State<TarikTunaiSatuPage> {
  String? selectedJalur;
  String? selectedAsset; // <- simpan logo yang dipilih
  TextEditingController nominalController = TextEditingController();

  // Jalur tarik tunai dengan aset gambar yang sesuai
  final List<Map<String, String>> jalurList = [
    {"nama": "Indomaret - Ceriamart", "asset": "assets/images/Indomaret.png"},
    {"nama": "Alfamart - Indomidi", "asset": "assets/images/Alfamart.png"},
  ];

  final List<int> opsiNominal = [50000, 100000, 200000, 500000];

  @override
  void initState() {
    super.initState();
    nominalController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    nominalController.dispose();
    super.dispose();
  }

  void _showJalurBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return ListView(
          shrinkWrap: true,
          children: jalurList.map((jalur) {
            return ListTile(
              leading: Image.asset(
                jalur["asset"]!,
                width: 40,
                height: 40,
              ),
              title: Text(jalur["nama"]!),
              onTap: () {
                setState(() {
                  selectedJalur = jalur["nama"];
                  selectedAsset = jalur["asset"]; // simpan logo
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  // Helper untuk mengecek apakah nominal yang diinput valid
  bool get _isNominalValid {
    String cleanedText =
    nominalController.text.replaceAll(RegExp(r'[^0-9]'), '');
    return cleanedText.isNotEmpty &&
        int.tryParse(cleanedText) != null &&
        int.parse(cleanedText) > 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          // Header (elemen tetap di atas)
          Image.asset(
            "assets/images/header.png",
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          // Konten utama yang dapat digulir (mengambil sisa ruang)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Sumber Dana ---
                  const Text(
                    "Sumber Dana",
                    style: TextStyle(
                      color: Color(0xFF6245FC),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color(0xFF6245FC),
                        child: Text(
                          "AT",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "ABEL THAREQ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "modipay - 081215633163",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  // --- Jalur Tarik Tunai ---
                  const Text(
                    "Jalur Tarik Tunai",
                    style: TextStyle(
                      color: Color(0xFF6245FC),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Tombol pilih jalur tarik tunai
                  GestureDetector(
                    onTap: _showJalurBottomSheet,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          // Kalau belum pilih, tampilkan default icon TarikTunai
                          if (selectedAsset == null)
                            Image.asset(
                              "assets/images/TarikTunai.png",
                              width: 20,
                              height: 20,
                            )
                          else
                            Image.asset(
                              selectedAsset!,
                              width: 40,
                              height: 40,
                            ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              selectedJalur ?? "Pilih Jalur Tarik Tunai",
                              style: TextStyle(
                                color: selectedJalur == null
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_down,
                              color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  // --- Pilih Nominal muncul hanya jika jalur dipilih ---
                  if (selectedJalur != null) ...[
                    const SizedBox(height: 20),
                    const Text(
                      "Pilih Nominal",
                      style: TextStyle(
                        color: Color(0xFF6245FC),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Input manual nominal
                    TextField(
                      controller: nominalController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [CurrencyInputFormatter()],
                      decoration: InputDecoration(
                        hintText: "Masukkan nominal",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Opsi pilihan cepat -> horizontal scroll
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: opsiNominal.map((nominal) {
                          final isSelected = nominalController.text.isNotEmpty &&
                              int.tryParse(nominalController.text
                                  .replaceAll(RegExp(r'[^0-9]'), '')) ==
                                  nominal;

                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ChoiceChip(
                              label: Text(
                                  "Rp ${NumberFormat('#,##0', 'id').format(nominal)}"),
                              selected: isSelected,
                              onSelected: (_) {
                                setState(() {
                                  nominalController.text =
                                      NumberFormat.currency(
                                        locale: 'id_ID',
                                        symbol: 'Rp',
                                        decimalDigits: 0,
                                      ).format(nominal);
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Tombol Lanjutkan (elemen tetap di bawah)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (selectedJalur != null && _isNominalValid)
                    ? () {
                  // Menyembunyikan keyboard sebelum navigasi
                  FocusScope.of(context).unfocus();
                  final parsedNominal = int.tryParse(
                      nominalController.text
                          .replaceAll(RegExp(r'[^0-9]'), '')) ??
                      0;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TarikTunaiDuaPage(
                        jalur: selectedJalur!,
                        nominal: parsedNominal,
                        assetPath: selectedAsset!, // <-- BARIS BARU INI
                      ),
                    ),
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6245FC),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Lanjutkan",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}