import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/transaction/presentation/pages/emas_konfirmasi_modal.dart';
// import file modal yang baru, pastikan path-nya benar
// import 'emas_konfirmasi_modal.dart';

class Emas3Page extends StatefulWidget {
  const Emas3Page({super.key});

  @override
  State<Emas3Page> createState() => _Emas3PageState();
}

class _Emas3PageState extends State<Emas3Page> {
  final TextEditingController _nominalController = TextEditingController();
  final String _hargaBeliGram = "1987713"; // Harga beli per gram
  final int _minimumPembelian = 199; // Jumlah minimum pembelian dalam Rupiah
  double _jumlahGram = 0.0;
  bool _isButtonEnabled = false;
  int _selectedNominal = 0;

  @override
  void initState() {
    super.initState();
    _nominalController.addListener(_updateGramAndButtonState);
  }

  @override
  void dispose() {
    _nominalController.removeListener(_updateGramAndButtonState);
    _nominalController.dispose();
    super.dispose();
  }

  void _updateGramAndButtonState() {
    final nominal =
        int.tryParse(_nominalController.text.replaceAll('.', '')) ?? 0;
    final hargaPerGram = int.tryParse(_hargaBeliGram) ?? 1;

    setState(() {
      if (nominal >= _minimumPembelian) {
        _jumlahGram = nominal / hargaPerGram;
        _isButtonEnabled = true;
      } else {
        _jumlahGram = 0.0;
        _isButtonEnabled = false;
      }
    });
  }

  void _setNominal(int amount) {
    setState(() {
      _nominalController.text = NumberFormat.decimalPattern(
        'id',
      ).format(amount);
      _selectedNominal = amount;
    });
  }

  Widget _buildNominalButton(int amount) {
    final isSelected = _selectedNominal == amount;
    return InkWell(
      onTap: () => _setNominal(amount),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6B48D1) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6B48D1)
                : const Color(0xFFE5E5E5),
          ),
        ),
        child: Text(
          "Rp${NumberFormat.decimalPattern('id').format(amount)}",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF2D2D2D),
          ),
        ),
      ),
    );
  }

  void _onBeliButtonPressed() {
    if (_isButtonEnabled) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent, // Untuk membuat card melayang
        builder: (context) {
          return EmasKonfirmasiModal(
            nominal:
                int.tryParse(_nominalController.text.replaceAll('.', '')) ?? 0,
            jumlahGram: _jumlahGram,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Stack(
        children: [
          // Header Section with Background
          SizedBox(
            height: 150,
            width: double.infinity,
            child: SvgPicture.asset(
              "assets/images/backgroundtop.svg",
              fit: BoxFit.cover,
            ),
          ),

          // Back Button
          Positioned(
            left: 16,
            top: 51,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Header Text
          const Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  "modipay",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  "SATU PINTU SEMUA PEMBAYARAN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Main Content
          Padding(
            padding: const EdgeInsets.only(top: 170),
            child: Column(
              children: [
                // Harga Beli Terkini Card
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8EAF6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Harga Beli Terkini",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF000000),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Rp${NumberFormat.decimalPattern('id').format(int.tryParse(_hargaBeliGram) ?? 0)}",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D2D2D),
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Text(
                              "/gram",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6B48D1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Jumlah minimum pembelian emas Rp199.",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Icon(Icons.close, color: Colors.white, size: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                // Input Pembelian
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Jumlah Pembelian",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Garis bawah untuk Rp dan input nominal
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFC1C1C1),
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            const Text(
                              "Rp",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _nominalController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF2D2D2D),
                                ),
                                decoration: const InputDecoration(
                                  hintText: "0",
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 2,
                                    vertical: 0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Jumlah minimum pembelian Rp1.000.",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9E9E9E),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6B48D1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.swap_vert,
                    color: Color(0xFFFFFFFF),
                    size: 36,
                  ),
                ),
                const SizedBox(height: 16),

                const Text(
                  "Jumlah dalam gram",
                  style: TextStyle(fontSize: 14, color: Color(0xFF000000)),
                ),
                Text(
                  "${_jumlahGram.toStringAsFixed(2)} gram",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D2D2D),
                  ),
                ),

                const Spacer(),

                // Tombol Pilihan Nominal
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildNominalButton(1000),
                      _buildNominalButton(10000),
                      _buildNominalButton(100000),
                      _buildNominalButton(1000000),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                // Tombol Beli
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isButtonEnabled ? _onBeliButtonPressed : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isButtonEnabled
                            ? const Color(0xFF6B48D1)
                            : const Color(0xFFE5E5E5),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Beli",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _isButtonEnabled
                              ? Colors.white
                              : const Color(0xFF9E9E9E),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
