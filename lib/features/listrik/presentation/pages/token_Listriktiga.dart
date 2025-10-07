import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/listrik/presentation/pages/token_Listrikempat.dart';

class TokenListrik3Page extends StatefulWidget {
  final int selectedNominal;
  final String meterNumber; // Tambahkan parameter meterNumber
  
  const TokenListrik3Page({
    super.key,
    required this.selectedNominal,
    required this.meterNumber, // Terima meterNumber dari page 2
  });

  @override
  State<TokenListrik3Page> createState() => _TokenListrik3PageState();
}

class _TokenListrik3PageState extends State<TokenListrik3Page> {
  String formatCurrency(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }

  // Fungsi untuk memformat nomor meter (sama seperti di page 2)
  String formatMeterNumber(String meterNumber) {
    if (meterNumber.length <= 4) {
      return meterNumber;
    }
    return '${meterNumber.substring(0, 4)}${'X' * (meterNumber.length - 4)}';
  }

  // Fungsi untuk memformat nama (sama seperti di page 2)
  String formatName(String name) {
    if (name.length <= 3) {
      return name;
    }
    return '${name.substring(0, 3)}${'X' * (name.length - 3)}';
  }

  String selectedPaymentMethod = "Saldo Modipay";
  String? selectedBank;
  String? selectedVoucher;
  String? selectedVoucherCode;
  int voucherDiscount = 0;
  bool isVoucherApplied = false;
  TextEditingController voucherController = TextEditingController();
  bool showSpecialVoucher = false;

  // Menggunakan selectedNominal dari page 2 sebagai totalPesanan
  int get totalPesanan => widget.selectedNominal;
  
  int biayaAdmin = 2000;

  int get totalPembayaran => totalPesanan + biayaAdmin - voucherDiscount;

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

  void _showVoucherDialog(BuildContext context) {
    String searchQuery = '';
    bool tempShowSpecialVoucher = false;

    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Voucher",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Input Kode Voucher dengan tombol Pakai
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                padding: const EdgeInsets.symmetric(horizontal: 1),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: TextField(
                                  controller: voucherController,
                                  onChanged: (value) {
                                    setStateDialog(() {
                                      searchQuery = value;
                                      tempShowSpecialVoucher = false;
                                    });
                                  },
                                  style: const TextStyle(fontSize: 12),
                                  decoration: const InputDecoration(
                                    hintText: "Masukkan Kode Voucher",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              width: 60,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF6C4EFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: () {
                                  if (searchQuery.toUpperCase() == 'A78SHUAK') {
                                    setStateDialog(() {
                                      tempShowSpecialVoucher = true;
                                    });
                                  }
                                },
                                child: const Text(
                                  "Pakai",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Voucher Khusus (hanya muncul setelah tekan tombol Pakai)
                        if (tempShowSpecialVoucher)
                          _buildSpecialVoucherItem(
                            'A78SHUAK',
                            'Diskon Tiktok',
                            10000,
                            0,
                            selectedVoucherCode == 'A78SHUAK',
                            () {
                              setStateDialog(() {
                                selectedVoucherCode = 'A78SHUAK';
                                selectedVoucher = 'Diskon Tiktok';
                                voucherDiscount = 10000;
                              });
                            },
                          ),

                        if (tempShowSpecialVoucher)
                          const SizedBox(height: 8),

                        // Daftar Voucher Biasa
                        const Text(
                          "Voucher Tersedia",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Voucher Biasa
                        Column(
                          children: [
                            _buildVoucherItem(
                              'DISKON5K',
                              'Diskon Rp5K',
                              5000,
                              50000,
                              selectedVoucherCode == 'DISKON5K',
                              () {
                                setStateDialog(() {
                                  selectedVoucherCode = 'DISKON5K';
                                  selectedVoucher = 'Diskon Rp5K';
                                  voucherDiscount = 5000;
                                });
                              },
                            ),
                            const SizedBox(height: 6),
                            _buildVoucherItem(
                              'DISKON6K',
                              'Diskon Rp6K',
                              6000,
                              150000,
                              selectedVoucherCode == 'DISKON6K',
                              () {
                                setStateDialog(() {
                                  selectedVoucherCode = 'DISKON6K';
                                  selectedVoucher = 'Diskon Rp6K';
                                  voucherDiscount = 6000;
                                });
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),
                        const Divider(height: 1, color: Colors.grey),
                        const SizedBox(height: 12),

                        // Konfirmasi Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6C4EFF),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                isVoucherApplied = selectedVoucherCode != null;
                                showSpecialVoucher = tempShowSpecialVoucher;
                              });
                            },
                            child: const Text(
                              "Konfirmasi",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSpecialVoucherItem(String code, String name, int discount, int minPurchase, bool isSelected, VoidCallback onTap) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF6C4EFF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Image.asset(
              'assets/images/tiktok.png',
              width: 18,
              height: 18,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.local_offer_outlined, color: Color(0xFF6C4EFF), size: 16),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  code,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "Diskon ${formatCurrency(discount)}",
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF6C4EFF) : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isSelected ? const Color(0xFF6C4EFF) : Colors.grey.shade400,
                ),
              ),
              child: Text(
                "Pakai",
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherItem(String code, String name, int discount, int minPurchase, bool isSelected, VoidCallback onTap) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF6C4EFF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Image.asset(
              'assets/images/iconmodipay.png',
              width: 18,
              height: 18,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.local_offer_outlined, color: Color(0xFF6C4EFF), size: 16),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Min. Beli ${formatCurrency(minPurchase)}",
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF6C4EFF) : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isSelected ? const Color(0xFF6C4EFF) : Colors.grey.shade400,
                ),
              ),
              child: Text(
                "Pakai",
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
                    child: Text(
                      "Pilih Pembayaran",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      child: const Text(
                        "Konfirmasi",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
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
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected ? const Color(0xFF6C4EFF) : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
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
              child: Text(
                bankName,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? const Color(0xFF6C4EFF) : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
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
          // HEADER - Diubah seperti di TokenListrik2Page
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 120,
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

          // CONTENT
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
                                  Text(
                                    formatName('PONPES ASSALAFIYYAH 2'), // Gunakan fungsi formatName
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    "Token Listrik",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                  Text(
                                    "${formatMeterNumber(widget.meterNumber)} - SI / 5500 VA", // Gunakan meterNumber dari widget
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
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
                            const Text("Total Pesanan",
                                style: TextStyle(fontSize: 14)),
                            Text(
                              formatCurrency(totalPesanan),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Voucher Section
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: () => _showVoucherDialog(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Voucher", style: TextStyle(fontSize: 14)),
                          Row(
                            children: [
                              if (isVoucherApplied && selectedVoucher != null)
                                Text(
                                  selectedVoucher!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF6C4EFF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              else
                                const Text(
                                  "Gunakan/masukan kode",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              const SizedBox(width: 8),
                              const Icon(Icons.chevron_right, size: 20),
                            ],
                          ),
                        ],
                      ),
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
                              const Text("Metode Pembayaran",
                                  style: TextStyle(fontSize: 14)),
                              Row(
                                children: [
                                  Text(
                                    selectedBank ?? selectedPaymentMethod,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
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
                            const Text("Total Pesanan",
                                style: TextStyle(fontSize: 14)),
                            Text(formatCurrency(totalPesanan),
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (isVoucherApplied && voucherDiscount > 0)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Diskon Voucher",
                                  style: TextStyle(fontSize: 14)),
                              Text(
                                "-${formatCurrency(voucherDiscount)}",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.green),
                              ),
                            ],
                          ),
                        if (isVoucherApplied && voucherDiscount > 0)
                          const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Biaya Admin",
                                style: TextStyle(fontSize: 14)),
                            Text(formatCurrency(biayaAdmin),
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                          ],
                        ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total Pembayaran",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              formatCurrency(totalPembayaran),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6C4EFF),
                              ),
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

          // FOOTER BUTTON
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
                      child: Text(
                        "Total Pembayaran\n${formatCurrency(totalPembayaran)}",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.right,
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
                            builder: (context) => TokenListrikEmpatPage(
                              customerName: formatName('PONPES ASSALAFIYYAH 2'),
                              meterNumber: "${formatMeterNumber(widget.meterNumber)} - SI / 5500 VA", // Kirim meterNumber yang sudah diformat
                              paymentMethod: selectedPaymentMethod,
                              selectedBank: selectedBank,
                              totalPesanan: totalPesanan,
                              voucherDiscount: voucherDiscount,
                              biayaAdmin: biayaAdmin,
                              totalPembayaran: totalPembayaran,
                              selectedVoucher: selectedVoucher ?? "Tidak ada voucher",
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Bayar Sekarang",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
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