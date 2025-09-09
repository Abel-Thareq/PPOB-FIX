import 'package:flutter/material.dart';
import 'package:ppob_app/features/einvoicing/presentation/pages/einvoicing_dua.dart';

// Placeholder untuk CustomButton dan EinvoicingDuaPage agar kode ini dapat dijalankan.
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(text),
    );
  }
}

class EinvoicingPage extends StatefulWidget {
  const EinvoicingPage({super.key});

  @override
  State<EinvoicingPage> createState() => _EinvoicingPageState();
}

class _EinvoicingPageState extends State<EinvoicingPage> {
  String? _selectedPublisher;
  final TextEditingController _paymentCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _paymentCodeController.addListener(_onFieldChanged);
  }

  @override
  void dispose() {
    _paymentCodeController.removeListener(_onFieldChanged);
    _paymentCodeController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    setState(() {
      // Perubahan state akan dipicu saat teks berubah,
      // sehingga tombol akan diperbarui.
    });
  }

  bool get _isFormValid {
    return _selectedPublisher != null && _paymentCodeController.text.isNotEmpty;
  }

  void _showPublisherDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              ListTile(
                title: const Text('SIPIL', style: TextStyle(fontSize: 16)),
                onTap: () {
                  setState(() {
                    _selectedPublisher = 'SIPIL';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Paper.id', style: TextStyle(fontSize: 16)),
                onTap: () {
                  setState(() {
                    _selectedPublisher = 'Paper.id';
                  });
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool formIsValid = _isFormValid;
    final Color buttonColor = formIsValid ? const Color(0xFF6C4EFF) : Colors.grey[400]!;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        Navigator.pop(context);
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan latar belakang dan tombol kembali
            Stack(
              children: [
                // Latar Belakang Gambar Header
                Image.asset(
                  'assets/images/header.png',
                  fit: BoxFit.cover,
                ),

                // Tombol Kembali
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 16.0),
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
              ],
            ),

            // Konten utama yang bisa di-scroll
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'E-Invoicing',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Bagian "Penerbit E-Invoice"
                    const Text(
                      'Penerbit E-Invoice',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _showPublisherDialog,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Image.asset('assets/images/list.png', width: 20, height: 20),
                            const SizedBox(width: 25),
                            Expanded(
                              child: Text(
                                _selectedPublisher ?? 'Pilih Penerbit E-Invoice',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _selectedPublisher != null ? Colors.black : Colors.grey[600],
                                ),
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Bagian "Kode Pembayaran"
                    const Text(
                      'Kode Pembayaran',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Image.asset('assets/images/keypad.png', width: 20, height: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _paymentCodeController,
                              decoration: InputDecoration(
                                hintText: 'Masukkan Kode Pembayaran',
                                hintStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.normal,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Kondisional box informasi ungu
                    if (_isFormValid) ...[
                      const SizedBox(height: 24),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1EEFF),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFF6C4EFF),
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: Color(0xFF6C4EFF),
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Informasi',
                                    style: TextStyle(
                                      color: Color(0xFF6C4EFF),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    '1. Kamu bisa mendapatkan no. pembayaran dengan melakukan pembayaran di Aplikasi Paper.id terlebih dahulu.\n'
                                    '2. Ikuti proses yang ada mulai dari pembayaran invoice di Paper.id, hingga proses pemilihan metode pembayaran menggunakan modipay.\n'
                                    '3. Setelah memilih metode pembayaran, kamu akan mendapatkan no. pembayaran yang dapat kamu salin dan masukkan di modipay.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Tombol "Lanjutkan" tetap di bawah
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: CustomButton(
                text: 'Lanjutkan',
                onPressed: formIsValid
                    ? () {
                        // Mengirimkan data ke EinvoicingDuaPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EinvoicingDuaPage(
                              publisher: _selectedPublisher!,
                              paymentCode: _paymentCodeController.text,
                            ),
                          ),
                        );
                      }
                    : null,
                backgroundColor: buttonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
