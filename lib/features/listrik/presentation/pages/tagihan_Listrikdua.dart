import 'package:flutter/material.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/features/listrik/presentation/pages/tagihan_Listriktiga.dart';

class TagihanListrikDua extends StatefulWidget {
  final String meterNumber;

  const TagihanListrikDua({
    super.key,
    required this.meterNumber,
  });

  @override
  State<TagihanListrikDua> createState() => _TagihanListrikDuaState();
}

class _TagihanListrikDuaState extends State<TagihanListrikDua> {
  bool isSaved = false;

  String _maskName(String originalName) {
    if (originalName.length <= 3) return originalName;
    final visiblePart = originalName.substring(0, 3);
    final maskedPart = 'X' * (originalName.length - 3);
    return '$visiblePart$maskedPart';
  }

  // Format nomor meter untuk ditampilkan (misalnya: 5210XXXXX)
  String _formatMeterNumber(String meterNumber) {
    if (meterNumber.length <= 4) {
      return meterNumber;
    }
    return '${meterNumber.substring(0, 4)}${'X' * (meterNumber.length - 4)}';
  }

  @override
  Widget build(BuildContext context) {
    const originalName = "PURWANDI"; // Original name
    const maskedName = "Tagihan Listrik";

    return Scaffold(
      body: Column(
        children: [
          // HEADER
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
                  padding: const EdgeInsets.all(11.0),
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
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // USERNAME + ICON PLN
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/iconpln.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _maskName(originalName), // Apply masking algorithm
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            maskedName,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '${_formatMeterNumber(widget.meterNumber)} - RI / 2200 VA',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // SWITCH SAVE (reverted to original except switch size)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tambah ke Daftar Tersimpan',
                          style: TextStyle(fontSize: 14), // Original size
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSaved = !isSaved;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 50,
                            height: 28,
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: isSaved ? Colors.purple : Colors.transparent,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSaved
                                    ? Colors.purple
                                    : Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),
                            child: AnimatedAlign(
                              duration: const Duration(milliseconds: 200),
                              alignment: isSaved
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // DETAIL TRANSAKSI BOX
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow('IDPEL', _formatMeterNumber(widget.meterNumber)),
                        _buildDetailRow('Tarif/Daya', 'RI / 2200 VA'),
                        _buildDetailRow('Stand Meter', '00019339-00019392'),
                        _buildDetailRow('BL/TH', 'AGUS25'),
                        _buildDetailRow('Total Lembar Tagihan', '1 Bulan'),
                        const Divider(),
                        _buildDetailRow('RP TAG PIN', 'Rp137.305'),
                        _buildDetailRow('Biaya Admin', 'Rp3.000'),
                        const SizedBox(height: 16),

                        // TOTAL TAGIHAN
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Tagihan',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                'Rp140.305',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
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

          // BUTTON CONFIRMASI
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomButton(
              text: 'Konfirmasi',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TagihanListrikTiga(
                      meterNumber: widget.meterNumber,
                      totalAmount: 140305, // Total tagihan dalam integer
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}