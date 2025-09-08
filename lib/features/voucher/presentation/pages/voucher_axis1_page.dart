import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'pinaxis_page.dart';

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

class VoucherAxis1Page extends StatefulWidget {
  const VoucherAxis1Page({super.key});

  @override
  State<VoucherAxis1Page> createState() => _VoucherAxis1PageState();
}

class _VoucherAxis1PageState extends State<VoucherAxis1Page> {
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
    VoucherPackage(name: 'Cek Status Voucher Axis', price: '110', benefit: '0'),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 1GB 1 Hari (Voucher Kosongan)',
      price: '5.460',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 1.5 GB 1 Hari',
      price: '5.360',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 2.5 GB 1 Hari ',
      price: '7.055',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 1 GB 3 Hari ',
      price: '9.235',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 2 GB 3 Hari(Voucher Kosongan)',
      price: '9.238',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis Aigo SS 2 GB 3 Hari ',
      price: '9.505',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 2.5 GB 2 Hari',
      price: '10.771',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis Aigo SS 2,5 GB 3 Hari',
      price: '10.765',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis Aigo SS 3 GB 3 Hari',
      price: '10.750',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 3 GB 3 Hari',
      price: '10.810',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis Aigo SS 2 GB 5 Hari',
      price: '12.013',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis Aigo SS 2,5 GB 2 Hari ',
      price: '11.905',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 1 GB 5 Hari ',
      price: '11.807',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 4.5 GB 3 Hari ',
      price: '12.310',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 2.5 GB 5 Hari ',
      price: '12.385',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis Aigo SS 4,5 GB 3 Hari ',
      price: '12.337',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 1.5 GB 7 Hari ',
      price: '13.075',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 1 GB 7 Hari ',
      price: '13.179',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 3 GB 5 Hari ',
      price: '14.585',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 9 GB 3 Hari ',
      price: '14.220',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis Aigo SS 9 GB 3 Hari ',
      price: '14.392',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis Aigo SS 4 GB 5 Hari ',
      price: '14.715',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 4 GB 5 Hari ',
      price: '14.660',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 2 GB 30 Hari ',
      price: '19.910',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 3 GB 30 Hari ',
      price: '22.460',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 7.5 GB 5 Hari ',
      price: '20.265',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis Aigo SS 7.5 GB 5 Hari ',
      price: '20.295',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 7 GB 7 Hari ',
      price: '22.810',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 15 GB 5 Hari (Voucher Kosongan)',
      price: '25.150',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis Aigo SS 15 GB 5 Hari  ',
      price: '25.215',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 8,5 GB 7 Hari ',
      price: '23.610',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 5 GB 15 Hari ',
      price: '27.225',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 11 GB 7 Hari ',
      price: '28.725',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 6 GB 30 Hari ',
      price: '30.305',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 8 GB 30 Hari ',
      price: '38.900',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 24 GB 7 Hari ',
      price: '39.515',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis Aigo SS 24 GB 7 Hari ',
      price: '40.625',
      benefit: '0',
    ),
    VoucherPackage(
      name:'Aktivasi Voucher Axis 4 GB + 8 GB Sosmed + 8 GB Music + 12 GB Malam /30 Hari',
      price: '41.687',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 11.5 GB 15 Hari ',
      price: '42.015',
      benefit: '0',
    ),
    VoucherPackage(
      name:'Aktivasi Voucher Axis 6 GB + 12 GB Sosmed + 12 GB Music + 18 GB Malam /30 Hari',
      price: '48.547',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 14 GB 30 Hari ',
      price: '56.960',
      benefit: '0',
    ),
    VoucherPackage(name: '', price: '60.916', benefit: '0'),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 30 GB 15 Hari(Voucher Kosongan)',
      price: '69.525',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 20 GB 30 Hari(Voucher Kosongan)',
      price: '74.625',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 30 GB 30 Hari ',
      price: '88.500',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 35 GB 60 Hari ',
      price: '102.610',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 75 GB 60 Hari ',
      price: '159.941',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 50 GB 60 Hari(Voucher Kosongan) ',
      price: '158.968',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Axis 65 GB 60 Hari(Voucher Kosongan) ',
      price: '158.968',
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
                    "Axis",
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
                              builder: (context) => PinAxisPage(
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
