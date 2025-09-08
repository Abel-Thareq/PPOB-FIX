import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/features/kartukredit/presentation/pages/kredit_empat.dart';

// Custom formatter untuk mata uang
class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String value = newValue.text;
    String cleanValue = value.replaceAll('.', '');
    
    // Check if the value is empty or not a valid number
    if (cleanValue.isEmpty || int.tryParse(cleanValue) == null) {
      return newValue.copyWith(text: '');
    }

    int parsedValue = int.parse(cleanValue);
    final formatter = NumberFormat.decimalPattern('id');
    String formattedValue = formatter.format(parsedValue);

    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}

// Halaman untuk menampilkan detail tagihan Kartu Kredit
class KreditTigaPage extends StatefulWidget {
  final int nominalTagihan;
  final int biayaAdmin;
  final String namaPelanggan;
  final String nomorKartu;
  final String namaBank;
  final String jatuhTempo;

  const KreditTigaPage({
    super.key,
    required this.nominalTagihan,
    required this.biayaAdmin,
    required this.namaPelanggan,
    required this.nomorKartu,
    required this.namaBank,
    required this.jatuhTempo,
  });

  @override
  State<KreditTigaPage> createState() => _KreditTigaPageState();
}

class _KreditTigaPageState extends State<KreditTigaPage> {
  // State untuk melacak apakah "Tambah Ke Daftar Tersimpan" aktif
  bool _isSavedListActive = false;
  // State untuk melacak opsi pembayaran (menggunakan Map untuk checkbox)
  Map<String, bool> _paymentOptions = {
    'Bayar Penuh': true,
    'Bayar Minimal': false,
    'Input Nominal': false,
  };
  late final TextEditingController _inputNominalController;

  // Controller untuk mengetahui posisi scroll
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan total tagihan penuh
    _inputNominalController = TextEditingController(
        text: _formatCurrencyInput(widget.nominalTagihan + widget.biayaAdmin));

    // Listener untuk perubahan scroll position
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
        // Hitung opacity berdasarkan scroll offset
        _opacity = 1.0 - (_scrollOffset / 100).clamp(0.0, 1.0);
      });
    });
  }

  @override
  void dispose() {
    _inputNominalController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Fungsi untuk memformat mata uang ke format Rupiah
  String formatCurrency(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }

  // Fungsi untuk memformat mata uang ke format input tanpa 'Rp'
  String _formatCurrencyInput(int amount) {
    final formatter = NumberFormat.decimalPattern('id');
    return formatter.format(amount);
  }

  // Fungsi untuk menangani perubahan pada checkbox
  void _handlePaymentOptionChange(String option, bool? value) {
    if (value == null) return;

    setState(() {
      // Reset semua opsi ke false
      _paymentOptions.forEach((key, val) {
        _paymentOptions[key] = false;
      });

      // Set opsi yang dipilih ke true
      _paymentOptions[option] = value;

      // Update nilai input berdasarkan opsi yang dipilih
      if (option == 'Bayar Penuh') {
        _inputNominalController.text =
            _formatCurrencyInput(widget.nominalTagihan + widget.biayaAdmin);
      } else if (option == 'Bayar Minimal') {
        int minimalPembayaran = (widget.nominalTagihan * 0.1).round();
        _inputNominalController.text =
            _formatCurrencyInput(minimalPembayaran + widget.biayaAdmin);
      } else if (option == 'Input Nominal') {
        _inputNominalController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Menghitung total tagihan dan nominal pembayaran minimal
    int totalTagihan = widget.nominalTagihan + widget.biayaAdmin;
    int minimalPembayaran = (widget.nominalTagihan * 0.1).round();
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Stack(
        children: [
          // Header Background Image
          SizedBox(
            height: 140,
            width: double.infinity,
            child: Image.asset(
              'assets/images/header.png',
              fit: BoxFit.cover,
            ),
          ),

          // Tombol kembali di atas header
          Positioned(
            top: 16,
            left: 16,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                iconSize: 28,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          // Box "Tagihan" yang tumpang tindih
          Positioned(
            top: 110,
            left: (screenWidth - 150) / 2, // Posisi horizontal di tengah
            right: (screenWidth - 150) / 2,
            child: Container(
              width: 150,
              height: 50,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                "Tagihan",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C4EFF),
                ),
              ),
            ),
          ),

          // Konten utama yang dapat digulir, diletakkan di bawah header dan box "Tagihan"
          NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollUpdateNotification) {
                setState(() {
                  _scrollOffset = _scrollController.offset;
                  _opacity = 1.0 - (_scrollOffset / 100).clamp(0.0, 1.0);
                });
              }
              return false;
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 170),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Bagian Total Tagihan di luar box dengan efek fade
                  AnimatedOpacity(
                    opacity: _opacity,
                    duration: const Duration(milliseconds: 100),
                    child: Column(
                      children: [
                        const Text(
                          "Total Tagihan",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          formatCurrency(totalTagihan),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6C4EFF),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Tulisan untuk minimal pembayaran
                        Text(
                          "Minimal Pembayaran ${formatCurrency(minimalPembayaran)}",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Box "Tambah Ke Daftar Tersimpan" dengan efek fade
                  AnimatedOpacity(
                    opacity: _opacity,
                    duration: const Duration(milliseconds: 100),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: SwitchListTile(
                        title: const Text(
                          "Tambah Ke Daftar Tersimpan",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        value: _isSavedListActive,
                        onChanged: (bool value) {
                          setState(() {
                            _isSavedListActive = value;
                          });
                        },
                        activeColor: const Color(0xFF6C4EFF),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Box detail tagihan
                  Container(
                    margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _DetailRow("Sumber Dana", "ABEL THAREQ", value2: "081390147404"),
                        _DetailRow("Nama Kartu", widget.namaPelanggan),
                        _DetailRow("Nomor Kartu", widget.nomorKartu),
                        _DetailRow("Nama Bank", widget.namaBank),
                        _DetailRow("Jatuh Tempo", widget.jatuhTempo),
                        const Divider(height: 24, thickness: 1),
                        _DetailRow("Tagihan", formatCurrency(widget.nominalTagihan)),
                        _DetailRow("Biaya Admin", formatCurrency(widget.biayaAdmin)),
                        const Divider(height: 24, thickness: 1),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total Tagihan",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                formatCurrency(totalTagihan),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6C4EFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Box "Nominal Pembayaran" dengan checkbox horizontal
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Nominal Pembayaran",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Opsi pembayaran dengan checkbox horizontal
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Checkbox Bayar Penuh
                            Expanded(
                              child: _PaymentOptionCheckbox(
                                value: _paymentOptions['Bayar Penuh']!,
                                onChanged: (value) => _handlePaymentOptionChange('Bayar Penuh', value),
                                label: "Bayar Penuh",
                              ),
                            ),
                            // Checkbox Bayar Minimal
                            Expanded(
                              child: _PaymentOptionCheckbox(
                                value: _paymentOptions['Bayar Minimal']!,
                                onChanged: (value) => _handlePaymentOptionChange('Bayar Minimal', value),
                                label: "Bayar Minimal",
                              ),
                            ),
                            // Checkbox Input Nominal
                            Expanded(
                              child: _PaymentOptionCheckbox(
                                value: _paymentOptions['Input Nominal']!,
                                onChanged: (value) => _handlePaymentOptionChange('Input Nominal', value),
                                label: "Input Nominal",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: TextField(
                                    controller: _inputNominalController,
                                    decoration: InputDecoration(
                                      prefixText: 'Rp',
                                      hintText: 'Masukkan Nominal',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                                      isDense: true,
                                      filled: true,
                                      fillColor: Colors.transparent,
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      CurrencyInputFormatter(),
                                    ],
                                    style: const TextStyle(fontSize: 14),
                                    enabled: _paymentOptions['Input Nominal']!,
                                  ),
                                ),
                              ),
                            ),
                            if (_paymentOptions['Input Nominal'] == true)
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "+ ${formatCurrency(widget.biayaAdmin).replaceAll('Rp', '')}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF6C4EFF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100), // Memberikan ruang untuk tombol bayar
                ],
              ),
            ),
          ),

          // Tombol "Bayar Sekarang" di bagian bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: CustomButton(
                text: 'Bayar Sekarang',
                onPressed: () {
                  final nominalBayarFormatted = _inputNominalController.text.replaceAll('.', '');
                  final nominalBayar = int.tryParse(nominalBayarFormatted) ?? 0;

                  if (nominalBayar <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Masukkan nominal pembayaran yang valid')),
                    );
                    return;
                  }

                  // Lanjutkan dengan navigasi ke halaman berikutnya
                  // (kode navigasi tetap dikomentari sesuai aslinya)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KreditEmpatPage(
                        nominalTagihan: widget.nominalTagihan,
                        biayaAdmin: widget.biayaAdmin,
                        nominalPembayaran: nominalBayar,
                        namaPelanggan: widget.namaPelanggan,
                        nomorKartu: widget.nomorKartu,
                        namaBank: widget.namaBank,
                        jatuhTempo: widget.jatuhTempo,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget khusus untuk checkbox opsi pembayaran
class _PaymentOptionCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String label;

  const _PaymentOptionCheckbox({
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF6C4EFF),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 10, // Ukuran font diperkecil
              fontWeight: FontWeight.normal,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// Widget pembantu untuk baris detail
class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final String? value2;

  const _DetailRow(this.label, this.value, {this.value2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              if (value2 != null)
                Text(
                  value2!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}