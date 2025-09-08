import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/features/transferbank/transferbank2_page.dart';

class TransferBankPage extends StatefulWidget {
  const TransferBankPage({super.key});

  @override
  State<TransferBankPage> createState() => _TransferBankPageState();
}

class _TransferBankPageState extends State<TransferBankPage> {
  final TextEditingController _rekeningController = TextEditingController();
  String? _selectedBank;
  bool _isValid = false;

  final List<String> _bankList = [
    "Bank BRI",
    "Bank Mandiri",
    "Bank BNI",
    "Bank BCA",
    "Bank BSI",
    "Bank BTN",
    "Bank CIMB NIAGA",
    "Bank DANAMON",
    "Bank PERMATA",
    "Bank PANIN",
  ];

  // ✅ mapping bank ke logo
  final Map<String, String> _bankLogos = {
    "Bank BRI": "assets/images/bank_bri.png",
    "Bank Mandiri": "assets/images/bank_mandiri.png",
    "Bank BNI": "assets/images/bank_bni.png",
    "Bank BCA": "assets/images/bank_bca.png",
    "Bank BSI": "assets/images/bank_bsi.png",
    "Bank BTN": "assets/images/bank_btn.png",
    "Bank CIMB NIAGA": "assets/images/bank_cimb.png",
    "Bank DANAMON": "assets/images/bank_danamon.png",
    "Bank PERMATA": "assets/images/bank_permata.png",
    "Bank PANIN": "assets/images/bank_panin.png",
  };

  List<String> _filteredBanks = [];

  @override
  void initState() {
    super.initState();
    _rekeningController.addListener(_validateInput);
    _filteredBanks = List.from(_bankList);
  }

  void _validateInput() {
    setState(() {
      final rekening = _rekeningController.text.replaceAll(" ", "");
      _isValid = rekening.length >= 10 && _selectedBank != null;
    });
  }

  @override
  void dispose() {
    _rekeningController.removeListener(_validateInput);
    _rekeningController.dispose();
    super.dispose();
  }

  static String _formatWithSpaces(String input) {
    final digitsOnly = input.replaceAll(" ", "");
    final buffer = StringBuffer();
    for (int i = 0; i < digitsOnly.length; i++) {
      buffer.write(digitsOnly[i]);
      if ((i + 1) % 4 == 0 && i + 1 != digitsOnly.length) {
        buffer.write(" ");
      }
    }
    return buffer.toString();
  }

  void _showBankDialog() {
    final TextEditingController searchController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            void filterBanks(String query) {
              setModalState(() {
                if (query.isEmpty) {
                  _filteredBanks = List.from(_bankList);
                } else {
                  _filteredBanks = _bankList
                      .where((bank) =>
                          bank.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                }
              });
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  TextField(
                    controller: searchController,
                    onChanged: filterBanks,
                    decoration: InputDecoration(
                      hintText: "Cari Bank disini",
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color(0xFF5938FB), width: 1.2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: _filteredBanks.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: Colors.grey.shade300,
                      ),
                      itemBuilder: (context, index) {
                        final bank = _filteredBanks[index];
                        final logoPath = _bankLogos[bank];
                        return ListTile(
                          leading: logoPath != null
                              ? Image.asset(
                                  logoPath,
                                  width: 32,
                                  height: 32,
                                )
                              : const Icon(Icons.account_balance_outlined,
                                  color: Colors.grey),
                          title: Text(bank, style: const TextStyle(fontSize: 14)),
                          onTap: () {
                            setState(() {
                              _selectedBank = bank;
                            });
                            _validateInput();
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
    return Scaffold(
      body: Column(
        children: [
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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Bank Tujuan",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87)),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _showBankDialog,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              _selectedBank == null
                                  ? const Icon(Icons.account_balance_outlined,
                                      color: Colors.black54)
                                  : Image.asset(
                                      _bankLogos[_selectedBank] ??
                                          'assets/images/default_bank.png',
                                      width: 28,
                                      height: 28,
                                    ),
                              const SizedBox(width: 8),
                              Text(
                                _selectedBank ?? "Pilih Bank",
                                style: TextStyle(
                                  color: _selectedBank == null
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_drop_down,
                              color: Colors.black54),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Nomor Rekening/Alias",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _rekeningController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        final formatted = _formatWithSpaces(newValue.text);
                        return newValue.copyWith(
                          text: formatted,
                          selection: TextSelection.collapsed(
                              offset: formatted.length),
                        );
                      }),
                    ],
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_outline),
                      hintText: "Masukan nomor rekening",
                      hintStyle:
                          const TextStyle(fontSize: 14, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color(0xFF5938FB), width: 1.2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text("Minimal 10 digit nomor rekening",
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: AbsorbPointer(
              absorbing: !_isValid,
              child: Opacity(
                opacity: _isValid ? 1.0 : 0.5,
                child: CustomButton(
                  text: "Lanjutkan",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransferBank2Page(
                          bankName: _selectedBank ?? "",
                          rekeningNumber: _rekeningController.text,
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