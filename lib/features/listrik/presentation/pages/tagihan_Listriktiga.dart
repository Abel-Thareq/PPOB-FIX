import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/listrik/presentation/pages/tagihan_Listrikempat.dart';

class TagihanListrikTiga extends StatefulWidget {
  const TagihanListrikTiga({super.key});

  @override
  State<TagihanListrikTiga> createState() => _TagihanListrikTigaState();
}

class _TagihanListrikTigaState extends State<TagihanListrikTiga> {
  String formatCurrency(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }

  String selectedPaymentMethod = "Saldo Modipay";
  String? selectedBank;

  final totalPesanan = 500000;
  int biayaAdmin = 3000;

  int get totalPembayaran => totalPesanan + biayaAdmin;

  String _maskName(String originalName) {
    if (originalName.length <= 3) return originalName;
    final visiblePart = originalName.substring(0, 3);
    final maskedPart = 'X' * (originalName.length - 3);
    return '$visiblePart$maskedPart';
  }

  void updateBiayaAdmin() {
    setState(() {
      if (selectedPaymentMethod == "Transfer Bank" && selectedBank != null) {
        biayaAdmin = 4000;
      } else if (selectedPaymentMethod == "Saldo Modipay") {
        biayaAdmin = 2000;
      } else {
        biayaAdmin = 3000;
      }
    });
  }

  void _showPaymentMethodSheet(BuildContext context) {
    String tempSelectedPaymentMethod = selectedPaymentMethod;
    String? tempSelectedBank = selectedBank;
    bool tempShowBankOptions =
    (tempSelectedPaymentMethod == "Transfer Bank" && tempSelectedBank != null);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
            return Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: AutoSizeText(
                      "Metode Pembayaran",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildPaymentOption(
                    "Saldo Modipay",
                    isSelected: tempSelectedPaymentMethod == "Saldo Modipay",
                    showArrow: false,
                    onTap: () {
                      setStateModal(() {
                        tempSelectedPaymentMethod = "Saldo Modipay";
                        tempSelectedBank = null;
                        tempShowBankOptions = false;
                      });
                    },
                  ),
                  const Divider(height: 16),

                  _buildPaymentOption(
                    "Transfer Bank",
                    isSelected: tempSelectedPaymentMethod == "Transfer Bank",
                    showArrow: true,
                    onTap: () {
                      setStateModal(() {
                        if (tempSelectedPaymentMethod != "Transfer Bank") {
                          tempSelectedPaymentMethod = "Transfer Bank";
                          tempShowBankOptions = true;
                          tempSelectedBank = null;
                        } else {
                          tempShowBankOptions = !tempShowBankOptions;
                        }
                      });
                    },
                  ),

                  if (tempShowBankOptions &&
                      tempSelectedPaymentMethod == "Transfer Bank") ...[
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        children: [
                          _buildBankOption("Bank BRI",
                              isSelected: tempSelectedBank == "Bank BRI",
                              onTap: () {
                                setStateModal(() {
                                  tempSelectedBank = "Bank BRI";
                                });
                              }),
                          _buildBankOption("Bank BCA",
                              isSelected: tempSelectedBank == "Bank BCA",
                              onTap: () {
                                setStateModal(() {
                                  tempSelectedBank = "Bank BCA";
                                });
                              }),
                          _buildBankOption("Bank Mandiri",
                              isSelected: tempSelectedBank == "Bank Mandiri",
                              onTap: () {
                                setStateModal(() {
                                  tempSelectedBank = "Bank Mandiri";
                                });
                              }),
                          _buildBankOption("Bank BNI",
                              isSelected: tempSelectedBank == "Bank BNI",
                              onTap: () {
                                setStateModal(() {
                                  tempSelectedBank = "Bank BNI";
                                });
                              }),
                        ],
                      ),
                    ),
                  ],

                  const Divider(height: 16),

                  _buildPaymentOption(
                    "Kartu Debit/Kredit",
                    isSelected: tempSelectedPaymentMethod == "Kartu Debit/Kredit",
                    showArrow: true,
                    onTap: () {
                      setStateModal(() {
                        tempSelectedPaymentMethod = "Kartu Debit/Kredit";
                        tempSelectedBank = null;
                        tempShowBankOptions = false;
                      });
                    },
                  ),

                  const Divider(height: 16),

                  _buildPaymentOption(
                    "Cicilan Kartu Kredit",
                    isSelected: tempSelectedPaymentMethod == "Cicilan Kartu Kredit",
                    showArrow: true,
                    onTap: () {
                      setStateModal(() {
                        tempSelectedPaymentMethod = "Cicilan Kartu Kredit";
                        tempSelectedBank = null;
                        tempShowBankOptions = false;
                      });
                    },
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C4EFF),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          selectedPaymentMethod = tempSelectedPaymentMethod;
                          selectedBank = tempSelectedBank;
                          updateBiayaAdmin();
                        });
                      },
                      child: const AutoSizeText(
                        "Konfirmasi",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                      ),
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

  Widget _buildPaymentOption(String title,
      {required bool isSelected,
        required bool showArrow,
        required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0EDFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: const Color(0xFF6C4EFF), width: 1.5)
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: AutoSizeText(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected ? const Color(0xFF6C4EFF) : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                maxLines: 1,
              ),
            ),
            if (showArrow)
              Icon(Icons.chevron_right,
                  color: isSelected ? const Color(0xFF6C4EFF) : Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  Widget _buildBankOption(String bankName,
      {required bool isSelected, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0EDFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: const Color(0xFF6C4EFF), width: 1.5)
              : null,
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/images/bank_${bankName.split(' ')[1].toLowerCase()}.png',
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.account_balance),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AutoSizeText(
                bankName,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? const Color(0xFF6C4EFF) : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                maxLines: 1,
              ),
            ),
            if (isSelected)
              const Icon(Icons.check, color: Color(0xFF6C4EFF)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding:
            const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
            color: const Color(0xFF6C4EFF),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Expanded(
                  child: Column(
                    children: [
                      AutoSizeText(
                        "modipay",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(height: 2),
                      AutoSizeText(
                        "SATU PINTU SEMUA PEMBAYARAN",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 40),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/iconpln.png',
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    _maskName("PURWANDI"), // Apply masking algorithm
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 1,
                                  ),
                                  const SizedBox(height: 4),
                                  const AutoSizeText(
                                    "Token Listrik",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                    maxLines: 1,
                                  ),
                                  const AutoSizeText(
                                    "521041373414 - SI / 5500 VA",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const AutoSizeText("Total Pesanan",
                                style: TextStyle(fontSize: 14),
                                maxLines: 1),
                            AutoSizeText(
                              formatCurrency(totalPesanan),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        AutoSizeText("Voucher",
                            style: TextStyle(fontSize: 14),
                            maxLines: 1),
                        Row(
                          children: [
                            AutoSizeText(
                              "Gunakan/masukan kode",
                              style:
                              TextStyle(fontSize: 14, color: Colors.grey),
                              maxLines: 1,
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.chevron_right, size: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => _showPaymentMethodSheet(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AutoSizeText("Metode Pembayaran",
                                  style: TextStyle(fontSize: 13),
                                  maxLines: 1),
                              Row(
                                children: [
                                  AutoSizeText(
                                    selectedBank ?? selectedPaymentMethod,
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                    maxLines: 1,
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.chevron_right, size: 20),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const AutoSizeText("Total Pesanan",
                                style: TextStyle(fontSize: 14),
                                maxLines: 1),
                            AutoSizeText(formatCurrency(totalPesanan),
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                                maxLines: 1),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const AutoSizeText("Biaya Admin",
                                style: TextStyle(fontSize: 14),
                                maxLines: 1),
                            AutoSizeText(formatCurrency(biayaAdmin),
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                                maxLines: 1),
                          ],
                        ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const AutoSizeText("Total Pembayaran",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1),
                            AutoSizeText(
                              formatCurrency(totalPembayaran),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6C4EFF),
                              ),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey, width: 0.2)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: AutoSizeText(
                        "Total Pembayaran\n${formatCurrency(totalPembayaran)}",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.right,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C4EFF),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (selectedPaymentMethod == "Transfer Bank" &&
                          selectedBank == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Silakan pilih bank terlebih dahulu"),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TagihanListrikEmpat(),
                          ),
                        );
                      }
                    },
                    child: const AutoSizeText(
                      "Bayar Sekarang",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}