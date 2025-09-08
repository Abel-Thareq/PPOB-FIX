import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'pinxl_page.dart';

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

class VoucherXL1Page extends StatefulWidget {
  const VoucherXL1Page({super.key});

  @override
  State<VoucherXL1Page> createState() => _VoucherXL1PageState();
}

class _VoucherXL1PageState extends State<VoucherXL1Page> {
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
    VoucherPackage(name: 'Cek Status Voucher Tri', price: '110', benefit: '0'),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri XTRA Hotroad Special 1 GB 3 Hari',
      price: '9.700',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri XTRA Hotroad Special 2 GB 3 Hari',
      price: '10.700',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri XTRA Hotroad Special S 7 Hari',
      price: '16.800',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri XTRA Hotroad Special M 7 Hari',
      price: '19.716',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri XTRA Hotroad Special L 7 Hari',
      price: '26.405',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri XTRA Hotroad Special XL 7 Hari',
      price: '31.595',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher Tri XTRA Combo Flex M+ 28 Hari',
      price: '56.525',
      benefit: '0',
    ),
    VoucherPackage(
    name: 'Aktivasi Voucher XL Xtra Combo Flex L+ 28 Hari',
    price: '79.125',
    benefit: '0',
  ),
  VoucherPackage(
    name: 'Aktivasi Voucher XL Bebas Puas 2rb 1 Hari',
    price: '2.755',
    benefit: '0',
  ),
  VoucherPackage(
    name: 'Aktivasi Voucher XL Bebas Puas 2rb 3 Hari',
    price: '6.643',
    benefit: '0',
  ),
  VoucherPackage(
    name: 'Aktivasi Voucher XL Bebas Puas 2rb 5 Hari',
    price: '10.669',
    benefit: '0',
  ),
  VoucherPackage(
    name: 'Aktivasi Voucher XL Bebas Puas 2rb 7 Hari',
    price: '13.851',
    benefit: '0',
  ),
  VoucherPackage(
    name: 'Aktivasi Voucher XL Bebas Puas 2rb 10 Hari',
    price: '19.525',
    benefit: '0',
  ),
  VoucherPackage(
    name: 'Aktivasi Voucher XL Bebas Puas 2rb 15 Hari',
    price: '28.998',
    benefit: '0',
  ),
  VoucherPackage(
    name: 'Aktivasi Voucher XL Bebas Puas 2rb 30 Hari',
    price: '57.370',
    benefit: '0',
  ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Xtra Combo Flex L+ 28 Hari',
      price: '79.125',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Bebas Puas 2rb 1 Hari',
      price: '2.755',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Bebas Puas 2rb 3 Hari',
      price: '6.643',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Bebas Puas 2rb 5 Hari',
      price: '10.669',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Bebas Puas 2rb 7 Hari',
      price: '13.851',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Bebas Puas 2rb 10 Hari',
      price: '19.525',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Bebas Puas 2rb 15 Hari',
      price: '28.998',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Bebas Puas 2rb 30 Hari',
      price: '57.370',
      benefit: '0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Bebas Puas 3rb 1 Hari',
      price: 'Rp3.491',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Bebas Puas 3rb 3 Hari',
      price: 'Rp9.272',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Bebas Puas 3rb 5 Hari',
      price: 'Rp15.039',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Bebas Puas 3rb 7 Hari',
      price: 'Rp19.910',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Bebas Puas 3rb 10 Hari',
      price: 'Rp28.270',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Bebas Puas 3rb 15 Hari',
      price: 'Rp39.451',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Bebas Puas 3rb 30 Hari',
      price: 'Rp83.560',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Bebas Puas 5rb 1 Hari',
      price: 'Rp5.366',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Bebas Puas 5rb 3 Hari',
      price: 'Rp14.203',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Bebas Puas 5rb 5 Hari',
      price: 'Rp23.605',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Bebas Puas 5rb 7 Hari',
      price: 'Rp35.425',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Bebas Puas 5rb 10 Hari',
      price: 'Rp46.530',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Bebas Puas 5rb 15 Hari',
      price: 'Rp74.800',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Bebas Puas 5rb 30 Hari',
      price: 'Rp136.080',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Paket Harian M 3 Hari',
      price: 'Rp10.960',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Paket Harian S 3 Hari',
      price: 'Rp9.530',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Paket Harian S 5 Hari',
      price: 'Rp13.003',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Paket Harian XS 10 Hari',
      price: 'Rp15.110',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Paket Harian S 10 Hari',
      price: 'Rp17.475',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Paket Harian L 3 Hari',
      price: 'Rp13.430',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Paket Harian XS 7 Hari',
      price: 'Rp13.968',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Paket Harian M 5 Hari',
      price: 'Rp14.870',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Paket Harian S 7 Hari',
      price: 'Rp16.908',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Paket Harian M 7 Hari',
      price: 'Rp19.860',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Paket Harian M 10 Hari',
      price: 'Rp20.010',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Paket Harian L 7 Hari',
      price: 'Rp25.195',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Paket Harian XL 7 Hari',
      price: 'Rp30.695',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL XTRA Hotrod Special 2 GB 7 Hari',
      price: 'Rp16.634',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL XTRA Hotrod Special 4 GB 10 Hari',
      price: 'Rp16.525',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL XTRA Hotrod Special 3 GB 7 Hari',
      price: 'Rp19.742',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL XTRA Hotrod Special 6 GB 10 Hari',
      price: 'Rp20.928',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL XTRA Hotrod Special 4.5 GB 7 Hari',
      price: 'Rp25.975',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL XTRA Hotrod Special 6.5 GB 7 Hari',
      price: 'Rp32.125',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Xtra Combo Flex L 28 Hari',
      price: 'Rp65.398',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Xtra Combo Flex XXL 28 Hari',
      price: 'Rp125.825',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Xtra Combo Flex M 28 Hari',
      price: 'Rp46.350',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Xtra Combo Flex XL 28 Hari',
      price: 'Rp94.075',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Xtra Combo Flex XXXL 28 Hari',
      price: 'Rp149.025',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Xtra Combo Flex S 28 Hari',
      price: 'Rp20.510',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Xtra ComboSpecial 8 GB 30 Hari',
      price: 'Rp31.775',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Xtra ComboSpecial 14 GB 30 Hari',
      price: 'Rp42.515',
      benefit: 'Keuntungan Rp0',
    ),
    VoucherPackage(
      name: 'Aktivasi Voucher XL Xtra Combo Flex S+ 28 Hari',
      price: 'Rp32.675',
      benefit: 'Keuntungan Rp0',
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
                    "XL",
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
                              builder: (context) => PinXLPage(
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
