import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/pulsa_data/pulsa4_page.dart';

class Pulsa3Page extends StatefulWidget {
  final String phoneNumber;
  const Pulsa3Page({super.key, required this.phoneNumber});

  @override
  State<Pulsa3Page> createState() => _Pulsa3PageState();
}

class _Pulsa3PageState extends State<Pulsa3Page>
    with SingleTickerProviderStateMixin {
  late TextEditingController _phoneController;
  late TabController _tabController;

  String? _selectedPulsa;
  String? _selectedPaket;

  final List<String> pulsaList = [
    "Rp 2.000",
    "Rp 5.000",
    "Rp 10.000",
    "Rp 15.000",
    "Rp 20.000",
    "Rp 25.000",
    "Rp 30.000",
    "Rp 40.000",
    "Rp 50.000",
    "Rp 75.000",
    "Rp 100.000",
    "Rp 150.000",
    "Rp 200.000",
    "Rp 300.000",
    "Rp 350.000",
    "Rp 400.000",
    "Rp 500.000",
    "Rp 1.000.000",
  ];

  final List<Map<String, String>> paketDataList = [
    {
      "title": "Paket Internet Bulanan OMG! 55K",
      "desc": "Internet OMG hingga 3GB, 30 Hari\nwww.telkomsel.com",
      "harga": "Rp55.000",
    },
    {
      "title": "Paket Internet Bulanan OMG! 75K",
      "desc": "Internet OMG hingga 15GB, 30 Hari\nwww.telkomsel.com",
      "harga": "Rp75.000",
    },
    {
      "title": "Telkomsel Data 1GB",
      "desc": "Telkomsel data flash 1GB/30Hari",
      "harga": "Rp55.000",
    },
    {
      "title": "Telkomsel Data 2GB",
      "desc": "Telkomsel data flash 2GB/30Hari",
      "harga": "Rp55.000",
    },
    {
      "title": "Telkomsel Data 3GB",
      "desc": "Telkomsel data flash 3GB/30Hari",
      "harga": "Rp55.000",
    },
  ];

  static const int biayaAdmin = 3000;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _phoneController = TextEditingController(text: widget.phoneNumber);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  int _parseRupiahToInt(String nominal) {
    final normalized = nominal
        .replaceAll('Rp', '')
        .replaceAll(' ', '')
        .replaceAll('.', '')
        .replaceAll(',', '')
        .trim();
    return int.tryParse(normalized) ?? 0;
  }

  String _formatRupiah(int value) {
    final s = value.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = s.length - 1; i >= 0; i--) {
      buffer.write(s[i]);
      count++;
      if (count == 3 && i != 0) {
        buffer.write('.');
        count = 0;
      }
    }
    return "Rp${buffer.toString().split('').reversed.join()}";
  }

  void _showDetailPopup(String nominalStr) {
    final harga = _parseRupiahToInt(nominalStr);
    final total = harga + biayaAdmin;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    "Detail Pembayaran",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Nominal",
                        style: TextStyle(color: Colors.grey, fontSize: 13)),
                    Text(nominalStr, style: const TextStyle(fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Biaya Admin",
                        style: TextStyle(color: Colors.grey, fontSize: 13)),
                    Text(_formatRupiah(biayaAdmin),
                        style: const TextStyle(fontSize: 13)),
                  ],
                ),
                const Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Pembayaran",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(_formatRupiah(total),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5938FB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Pulsa4Page(
                            phoneNumber: _phoneController.text,
                            sumberDanaNama: "Akmal Hasan", // contoh dummy
                            sumberDanaRekening: "1234567890", // contoh dummy
                            provider: "Telkomsel Prabayar",
                            nominal: nominalStr,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Beli Sekarang",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPulsaButton(String label) {
    final bool isSelected = _selectedPulsa == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPulsa = label;
        });
        _showDetailPopup(label);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF5938FB) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaketDataCard(Map<String, String> paket) {
    final bool isSelected = _selectedPaket == paket["title"];
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaket = paket["title"];
        });
        _showDetailPopup(paket["harga"]!);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF5938FB) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(paket["title"]!,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.black)),
            SizedBox(height: 4.h),
            Text(paket["desc"]!,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  paket["harga"]!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
                const Icon(Icons.shopping_cart_outlined,
                    size: 20, color: Color(0xFF5938FB)),
              ],
            ),
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
          // Header
          SizedBox(
            height: 130.h,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 120.h,
                  child: Image.asset('assets/images/header.png',
                      fit: BoxFit.cover),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back,
                          size: 28.r, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Provider
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Image.asset("assets/images/telkomsel.png",
                      width: 30.w, height: 30.h),
                  SizedBox(width: 10.w),
                  const Text("Telkomsel Prabayar",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),

          // Input Nomor HP
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nomor Handphone",
                    style: TextStyle(
                        fontSize: 13.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 8.h),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(10.r),
                      child: Image.asset("assets/images/phone.png",
                          width: 20.w, height: 20.h),
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(10.r),
                      child: Image.asset("assets/images/contact.png",
                          width: 20.w, height: 20.h),
                    ),
                    hintText: "Masukan Nomor Handphone",
                    hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                          color: Color(0xFF5938FB), width: 1.2),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tabs
          TabBar(
            controller: _tabController,
            indicatorColor: const Color(0xFF5938FB),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [Tab(text: "Pulsa"), Tab(text: "Paket Data")],
          ),

          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Pulsa
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: pulsaList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12.h,
                      crossAxisSpacing: 12.w,
                      childAspectRatio: 2.7,
                    ),
                    itemBuilder: (context, index) {
                      return _buildPulsaButton(pulsaList[index]);
                    },
                  ),
                ),

                // Paket Data
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: paketDataList.length,
                    itemBuilder: (context, index) {
                      return _buildPaketDataCard(paketDataList[index]);
                    },
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