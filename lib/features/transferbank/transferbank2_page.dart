import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/features/transferbank/transferbank3_page.dart'; // ✅ import halaman konfirmasi

// 🔹 Helper getBankLogo()
String getBankLogo(String bankName) {
  switch (bankName) {
    case "Bank BRI":
      return "assets/images/bank_bri.png";
    case "Bank Mandiri":
      return "assets/images/bank_mandiri.png";
    case "Bank BNI":
      return "assets/images/bank_bni.png";
    case "Bank BCA":
      return "assets/images/bank_bca.png";
    case "Bank BSI":
      return "assets/images/bank_bsi.png";
    case "Bank BTN":
      return "assets/images/bank_btn.png";
    case "Bank CIMB NIAGA":
      return "assets/images/bank_cimb.png";
    case "Bank DANAMON":
      return "assets/images/bank_danamon.png";
    case "Bank PERMATA":
      return "assets/images/bank_permata.png";
    case "Bank PANIN":
      return "assets/images/bank_panin.png";
    default:
      return "assets/images/default_bank.png";
  }
}

class TransferBank2Page extends StatefulWidget {
  final String bankName;
  final String rekeningNumber;

  const TransferBank2Page({
    super.key,
    required this.bankName,
    required this.rekeningNumber,
  });

  @override
  State<TransferBank2Page> createState() => _TransferBank2PageState();
}

class _TransferBank2PageState extends State<TransferBank2Page> {
  final TextEditingController _nominalController = TextEditingController();
  final TextEditingController _catatanController = TextEditingController();

  final NumberFormat _formatter = NumberFormat("#,###", "id_ID");
  bool _isSaved = true;
  bool _isValid = false;
  bool _isFormatting = false;

  @override
  void initState() {
    super.initState();
    _nominalController.addListener(_onNominalChanged);
  }

  void _onNominalChanged() {
    if (_isFormatting) return;

    String raw = _nominalController.text.replaceAll(".", "").replaceAll(",", "");
    if (raw.isEmpty) {
      setState(() => _isValid = false);
      return;
    }

    final value = int.tryParse(raw);
    if (value == null) return;

    final formatted = _formatter.format(value).replaceAll(",", ".");

    if (_nominalController.text != formatted) {
      _isFormatting = true;
      _nominalController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
      _isFormatting = false;
    }

    setState(() {
      _isValid = value >= 10000;
    });
  }

  @override
  void dispose() {
    _nominalController.removeListener(_onNominalChanged);
    _nominalController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dividerColor = const Color(0xFFE6E7EF);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 140,
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
                    color: Colors.white,
                    iconSize: 28,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),

          // Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Info penerima dengan logo bank
                  Row(
                    children: [
                      Image.asset(
                        getBankLogo(widget.bankName),
                        width: 52,
                        height: 52,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "MOH MAKFI MUSTOFA", // sementara dummy
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.bankName,
                            style: TextStyle(
                              fontSize: 12,
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.5), // ✅ lebih halus
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.rekeningNumber,
                            style: TextStyle(
                              fontSize: 12,
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.5), // ✅ lebih halus
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Switch Tambah ke daftar tersimpan
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: dividerColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Tambah Ke Daftar Tersimpan",
                            style: TextStyle(fontSize: 14)),
                        Switch(
                          value: _isSaved,
                          activeColor: const Color(0xFF5938FB),
                          onChanged: (v) => setState(() => _isSaved = v),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Nominal Transfer
                  const Text("Nominal Transfer",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87)),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: dividerColor, width: 1),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 2, 12, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: _nominalController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration: const InputDecoration(
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(left: 4, right: 4),
                                    child: Text(
                                      "Rp",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  prefixIconConstraints: BoxConstraints(
                                    minWidth: 0,
                                    minHeight: 0,
                                  ),
                                  hintText: "0",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 12),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text("Minimal 10.000",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ),
                        Divider(color: dividerColor, height: 1),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.edit_note_outlined,
                                  color: Colors.grey.shade400),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: _catatanController,
                                  minLines: 1,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  style: const TextStyle(fontSize: 14),
                                  decoration: const InputDecoration(
                                    hintText: "Tulis Catatan (Opsional)",
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
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
          ),

          // ✅ Button Lanjutkan → direct ke TransferBank3Page
          Padding(
            padding: const EdgeInsets.all(20),
            child: AbsorbPointer(
              absorbing: !_isValid,
              child: Opacity(
                opacity: _isValid ? 1.0 : 0.4,
                child: CustomButton(
                  text: "Lanjutkan",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransferBank3Page(
                          bankName: widget.bankName,
                          rekeningNumber: widget.rekeningNumber,
                          nominal: _nominalController.text,
                          catatan: _catatanController.text,
                          namaPenerima: "MOH MAKFI MUSTOFA", // sementara dummy
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}