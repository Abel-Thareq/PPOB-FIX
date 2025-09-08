import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'pinindosat_page.dart';

class VoucherPackage {
  final String name;
  final String price;
  final String benefit;

  VoucherPackage({
    required this.name,
    required this.price,
    required this.benefit,
  });
}

class VoucherIndosat1Page extends StatefulWidget {
  const VoucherIndosat1Page({super.key});

  @override
  State<VoucherIndosat1Page> createState() => _VoucherIndosat1PageState();
}

class _VoucherIndosat1PageState extends State<VoucherIndosat1Page> {
  bool isSearching = false;
  VoucherPackage? selectedPackage;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _inputDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.grey.withOpacity(0.8)),
  );

  final _inputPadding = const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );

  final List<VoucherPackage> paketVoucher = [
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom U 10 GB 30 Hari',
      price: '56.125',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom U 35 GB 30 Hari',
      price: '103.075',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom U 45 GB 30 Hari',
      price: '115.100',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom U Jumbo 30 Hari',
      price: '153.965',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom Internet Harian 1.5 GB 1 Hari (Jawa Barat)',
      price: '5.130',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom Internet Harian 3 GB 1 Hari (Jawa Barat)',
      price: '7.430',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom Internet Harian 5 GB 2 Hari (Jawa Barat)',
      price: '8.921',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom Internet Harian 3 GB 3 Hari (Jawa Barat)',
      price: '12.085',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom Internet Harian 2.5 GB 5 Hari (Jawa Barat)',
      price: '13.060',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom Internet Harian 5 GB 3 Hari (Jawa Barat)',
      price: '13.285',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom Internet Harian 3.5 GB 5 Hari (Jawa Barat)',
      price: '14.135',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom Internet Harian 5 GB 5 Hari (Jawa Barat)',
      price: '17.435',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom Internet Harian 3 GB 28 Hari (Jawa Barat)',
      price: '20.105',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom Internet Harian 4 GB 28 Hari (Jawa Barat)',
      price: '25.800',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom Internet Harian 15 GB 7 Hari (Jawa Barat)',
      price: '28.600',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom Internet Harian 5.5 GB 28 Hari (Jawa Barat)',
      price: '31.350',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom Internet Harian 7 GB 28 Hari (Jawa Barat)',
      price: '33.950',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom Internet Harian 9 GB 28 Hari (Jawa Barat)',
      price: '43.150',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom Internet Harian 13 GB 28 Hari (Jawa Barat)',
      price: '51.400',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom Internet Harian 20 GB 28 Hari (Jawa Barat)',
      price: '68.010',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom Internet Harian 30 GB 28 Hari (Jawa Barat)',
      price: '89.750',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Indosat Freedom Internet Harian 52 GB 28 Hari (Jawa Barat)',
      price: '112.625',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Cek Status Voucher Indosat',
      price: '125',
      benefit: '0',
    ),
  ];

  List<VoucherPackage> get paketTersaring {
    if (_searchController.text.isEmpty) {
      return paketVoucher;
    }
    return paketVoucher
        .where(
          (paket) => paket.name.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ),
        )
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // 🔹 Background wave SVG
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: SvgPicture.asset(
                    "assets/images/backgroundtop.svg",
                    fit: BoxFit.cover,
                  ),
                ),

                // 🔹 Tombol Back
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

                // 🔹 Title dan Subtitle
                Positioned(
                  top: 60,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: const [
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
              ],
            ),

            // 🔹 Card Voucher melayang
            Transform.translate(
              offset: const Offset(0, -30),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    "Voucher",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6C4DF4),
                    ),
                  ),
                ),
              ),
            ),

            // 🔹 Form Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Indosat",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: _inputDecoration,
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Masukan Nomor Anda',
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        contentPadding: _inputPadding,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Pilih Paket",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSearching = !isSearching;
                      });
                    },
                    child: Container(
                      padding: _inputPadding,
                      decoration: _inputDecoration,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (isSearching)
                            Expanded(
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: TextField(
                                      controller: _searchController,
                                      decoration: InputDecoration(
                                        hintText: 'Ketik untuk mencari...',
                                        hintStyle: TextStyle(
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            Expanded(
                              child: Text(
                                selectedPackage?.name ??
                                    'Pilih Nominal atau Produk',
                                style: TextStyle(
                                  color: selectedPackage != null
                                      ? Colors.black87
                                      : Colors.grey.withOpacity(0.5),
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          const SizedBox(width: 8),
                          Icon(
                            isSearching ? Icons.clear : Icons.chevron_right,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isSearching) ...[
                    const SizedBox(height: 16),
                    ...paketTersaring.map(
                      (paket) => InkWell(
                        onTap: () {
                          // Validate phone number first
                          if (_phoneController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Silahkan masukkan nomor telepon terlebih dahulu',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          // Set selected package and show confirmation
                          setState(() {
                            selectedPackage = paket;
                            isSearching = false;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.05),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  paket.name,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Rp${paket.price}',
                                          style: const TextStyle(
                                            color: Color(0xFF6C4DF4),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Keuntungan Rp${paket.benefit}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.withOpacity(0.8),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Icon(
                                      Icons.chevron_right,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],

                  // Tampilkan section konfirmasi jika paket sudah dipilih
                  if (selectedPackage != null) ...[
                    const SizedBox(height: 22),
                    const Text(
                      "Konfirmasi",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Card pertama - Informasi detail
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            spreadRadius: 0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Deskripsi Produk",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[400],
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  selectedPackage!.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Nominal",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[400],
                                ),
                              ),
                              Text(
                                "Rp${selectedPackage!.price}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Biaya Admin",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[400],
                                ),
                              ),
                              const Text(
                                "Rp0",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Card kedua - Total
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            spreadRadius: 0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Rp${selectedPackage!.price}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF6C4DF4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PinIndosatPage(
                                nomorTelepon: _phoneController.text,
                                namaPaket: selectedPackage!.name,
                                harga: selectedPackage!.price,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C4DF4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Lanjutkan",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
