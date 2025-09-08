import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'pintri_page.dart';

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

class VoucherTri1Page extends StatefulWidget {
  const VoucherTri1Page({super.key});

  @override
  State<VoucherTri1Page> createState() => _VoucherTri1PageState();
}

class _VoucherTri1PageState extends State<VoucherTri1Page> {
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
      name: 'Aktivasi Voucher Tri Happy 1.5 GB 1 Hari (Jawa Barat)',
      price: '4.354',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 2 GB 1 Hari (Jawa Barat)',
      price: '4.304',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 2.5 GB 1 Hari (Jawa Barat)',
      price: '6.279',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 1 GB 3 Hari (Jawa Barat)',
      price: '7.239',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 3 GB 1 Hari (Jawa Barat)',
      price: '7.239',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 5 GB 2 Hari (Jawa Barat)',
      price: '8.635',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 5 GB 1 Hari (Jawa Barat)',
      price: '9.783',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 3 GB 2 Hari (Jawa Barat)',
      price: '10.261',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 2 GB 5 Hari (Jawa Barat)',
      price: '10.519',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 6 GB 3 Hari (Jawa Barat)',
      price: '13.895',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 4.5 GB 5 Hari (Jawa Barat)',
      price: '15.333',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri AlwaysOn 2.5 GB(Jawa Barat)',
      price: '21.702',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 5 GB 3 Hari (Jawa Barat)',
      price: '14.850',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 3.5 GB 5 Hari (Jawa Barat)',
      price: '15.140',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 3 GB 7 Hari (Jawa Barat)',
      price: '15.333',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 4.5 GB 28 Hari (Jawa Barat)',
      price: '21.542',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri AlwaysOn 3.5 GB(Jawa Barat)',
      price: '22.493',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 5 GB 7 Hari (Jawa Barat)',
      price: '19.710',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 9 GB 7 Hari (Jawa Barat)',
      price: '21.685',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 10 GB 7 Hari (Jawa Barat)',
      price: '22.398',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 6 GB 5 Hari (Jawa Barat)',
      price: '19.655',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri AlwaysOn 6 GB(Jawa Barat)',
      price: '29.685',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 15 GB 7 Hari (Jawa Barat)',
      price: '27.295',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 7 GB 28 Hari (Jawa Barat)',
      price: '29.180',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 9 GB 10 Hari (Jawa Barat)',
      price: '29.400',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri AlwaysOn 9 GB (Jawa Barat)',
      price: '43.100',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 11 GB 28 Hari (Jawa Barat)',
      price: '44.319',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri AlwaysOn 12 GB (Jawa Barat)',
      price: '55.495',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 14 GB 28 Hari (Jawa Barat)',
      price: '58.300',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 18 GB 28 Hari (Jawa Barat)',
      price: '61.644',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 30 GB 28 Hari (Jawa Barat)',
      price: '72.930',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 42 GB 28 Hari (Jawa Barat)',
      price: '69.265',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 100 GB 28 Hari (Jawa Barat)',
      price: '116.075',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 130 GB 28 Hari (Jawa Barat)',
      price: '245.481',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri Happy 3 GB 3 Hari (Jawa Barat)',
      price: '10.800',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Cek Status Voucher Tri',
      price: '115',
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
                    "Tri",
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
                              builder: (context) => PinTriPage(
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
