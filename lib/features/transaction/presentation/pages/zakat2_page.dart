import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ppob_app/features/transaction/presentation/pages/zakat3_page.dart';
// import halaman selanjutnya jika ada
// import 'zakat3_page.dart';

class Zakat2Page extends StatefulWidget {
  final String zakatName;
  final String zakatImage;

  const Zakat2Page({
    super.key,
    required this.zakatName,
    required this.zakatImage,
  });

  @override
  State<Zakat2Page> createState() => _Zakat2PageState();
}

class _Zakat2PageState extends State<Zakat2Page> {
  final TextEditingController _nominalController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _nominalController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _nominalController.removeListener(_updateButtonState);
    _nominalController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _nominalController.text.isNotEmpty;
    });
  }

  void _onContinueButtonPressed() {
    if (_isButtonEnabled) {
      // Parse and format the nominal value
      String nominal = _nominalController.text.replaceAll(RegExp(r'[^0-9]'), '');
      // Format as currency
      String formattedNominal = ' ${double.parse(nominal).toStringAsFixed(0).replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]}.',
          )}';

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Zakat3Page(
            zakatName: widget.zakatName,
            zakatImage: widget.zakatImage,
            nominal: formattedNominal,
          ),
        ),
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

          // Scrollable content
          Padding(
            padding: const EdgeInsets.only(top: 170, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(widget.zakatImage, width: 30, height: 30),
                    const SizedBox(width: 16),
                    Text(
                      widget.zakatName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                  ],
                ),
                Divider( color: Colors.grey.shade300, thickness: 1, height: 32),
                const SizedBox(height: 2),
                const Text(
                  "Pilih Nominal",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _nominalController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Masukkan Nominal",
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        "Rp",
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isButtonEnabled
                        ? _onContinueButtonPressed
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isButtonEnabled
                          ? const Color(0xFF6B48D1)
                          : const Color(0xFFE5E5E5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      "Lanjutkan",
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
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
