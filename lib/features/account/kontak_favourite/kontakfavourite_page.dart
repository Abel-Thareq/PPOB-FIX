import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KontakFavouritePage extends StatefulWidget {
  const KontakFavouritePage({super.key});

  @override
  State<KontakFavouritePage> createState() => _KontakFavouritePageState();
}

class _KontakFavouritePageState extends State<KontakFavouritePage>
    with TickerProviderStateMixin {
  String? selectedJenisKontak;
  bool isExpanded = false;

  final List<String> jenisKontakList = [
    "Handphone",
    "Telepon Rumah",
    "Telepon Kantor",
    "Listrik",
    "Air PDAM",
    "BPJS",
  ];

  List<Map<String, String>> kontakList = [];

  late AnimationController _expandController;
  late Animation<double> _expandAnimation;

  final FlutterNativeContactPicker _contactPicker =
      FlutterNativeContactPicker(); // instance picker

  @override
  void initState() {
    super.initState();
    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    );

    // 🔹 Load data tersimpan saat halaman pertama kali dibuka
    _loadKontak();
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  // 🔹 Simpan ke SharedPreferences (pastikan semua value String)
  Future<void> _saveKontak() async {
    final prefs = await SharedPreferences.getInstance();
    final sanitized = kontakList
        .map((m) => m.map((k, v) => MapEntry(k.toString(), v.toString())))
        .toList();
    await prefs.setString('kontakList', jsonEncode(sanitized));
  }

  // 🔹 Load dari SharedPreferences (konversi dynamic ke String)
  Future<void> _loadKontak() async {
    final prefs = await SharedPreferences.getInstance();
    final kontakJson = prefs.getString('kontakList');
    if (kontakJson != null) {
      try {
        final List decoded = jsonDecode(kontakJson);
        final loaded = decoded.map<Map<String, String>>((item) {
          final Map raw = item as Map;
          return raw.map((k, v) =>
              MapEntry(k.toString(), v == null ? '' : v.toString()));
        }).toList();

        setState(() {
          kontakList = loaded;
        });
      } catch (e) {
        debugPrint("Gagal parse kontak: $e");
      }
    }
  }

  void toggleExpand(StateSetter setStateDialog) {
    setStateDialog(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _expandController.forward();
      } else {
        _expandController.reverse();
      }
    });
  }

  void _tambahKontak(String nomor, String nama, String jenis) {
    setState(() {
      kontakList.add({
        "nomor": nomor,
        "nama": nama,
        "jenis": jenis,
      });
    });
    _saveKontak();
  }

  void _hapusKontak(int index) {
    setState(() {
      kontakList.removeAt(index);
    });
    _saveKontak();
  }

  /// Fungsi pilih kontak & isi otomatis ke TextField
  Future<void> _pickContact(TextEditingController nomorController,
      TextEditingController namaController) async {
    try {
      final Contact? contact = await _contactPicker.selectPhoneNumber();
      if (contact == null) return;

      final String nomor = contact.selectedPhoneNumber ??
          (contact.phoneNumbers != null && contact.phoneNumbers!.isNotEmpty
              ? contact.phoneNumbers!.first
              : "");
      final String nama = contact.fullName ?? "";

      if (nomor.isNotEmpty) nomorController.text = nomor;
      if (nama.isNotEmpty) namaController.text = nama;
    } catch (e) {
      debugPrint("Gagal memilih kontak: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 140.h,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 120.h,
                  child: Image.asset(
                    'assets/images/header.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back,
                          size: 28.r, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 24.w,
                  right: 24.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.grey[300]!),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Kontak Favorit",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF5938FB),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 🔹 Tambahan teks sesuai gambar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Pilih Kontak Favorit Anda",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          /// 🔹 TextField dengan shadow
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 0.h),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintText: "Cari",
                  hintStyle: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 0.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide:
                        const BorderSide(color: Color(0xFF5938FB), width: 1.2),
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: kontakList.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 160.w,
                        height: 160.h,
                        child: Image.asset(
                          "assets/images/emptydata.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Tidak Ada Nomor Favorit",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Kontak Anda masih kosong, silahkan Tambah Kontak",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: kontakList.length,
                    itemBuilder: (context, index) {
                      final kontak = kontakList[index];
                      return Column(
                        children: [
                          ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Icon(Icons.person, color: Colors.black54),
                            ),
                            title: Text(
                              kontak["nama"] ?? "",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  kontak["nomor"] ?? "",
                                  style: TextStyle(fontSize: 13.sp),
                                ),
                                Text(
                                  kontak["jenis"] ?? "",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            trailing: PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == "hapus") {
                                  _hapusKontak(index);
                                }
                              },
                              itemBuilder: (context) => const [
                                PopupMenuItem(
                                  value: "hapus",
                                  child: Text("Hapus"),
                                ),
                              ],
                              icon: const Icon(Icons.more_vert),
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 0.5,
                            color: Colors.grey[300],
                            indent: 16.w,
                            endIndent: 16.w,
                          ),
                        ],
                      );
                    },
                  ),
          ),

          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5938FB),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () {
                  final nomorController = TextEditingController();
                  final namaController = TextEditingController();

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (context, setStateDialog) {
                          return Dialog(
                            backgroundColor: Colors.white,
                            insetPadding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 24.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16.w),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            "Tambah / Edit Kontak Favorit",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 16.h),

                                        Text("Nomor",
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(height: 6.h),
                                        TextField(
                                          controller: nomorController,
                                          decoration: InputDecoration(
                                            hintText: "Masukkan Nomor",
                                            hintStyle: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.grey,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                            suffixIcon: IconButton(
                                              icon: const Icon(
                                                  Icons.contact_page_outlined),
                                              onPressed: () {
                                                _pickContact(
                                                    nomorController,
                                                    namaController); // pilih kontak & isi otomatis
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 12.h),

                                        Text("Nama",
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(height: 6.h),
                                        TextField(
                                          controller: namaController,
                                          decoration: InputDecoration(
                                            hintText: "Masukkan Nama",
                                            hintStyle: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.grey,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 12.h),

                                        Text("Jenis Kontak",
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(height: 6.h),
                                        GestureDetector(
                                          onTap: () {
                                            toggleExpand(setStateDialog);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.w,
                                                vertical: 14.h),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade300,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  selectedJenisKontak ??
                                                      "Jenis Kontak",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color:
                                                        selectedJenisKontak ==
                                                                null
                                                            ? Colors.grey
                                                            : Colors.black,
                                                  ),
                                                ),
                                                Icon(
                                                  isExpanded
                                                      ? Icons.keyboard_arrow_up
                                                      : Icons
                                                          .keyboard_arrow_down,
                                                  color: Colors.grey[700],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),

                                        SizeTransition(
                                          sizeFactor: _expandAnimation,
                                          axis: Axis.vertical,
                                          child: Container(
                                            margin: EdgeInsets.only(top: 6.h),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade300,
                                                  width: 0.5),
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                            child: Column(
                                              children:
                                                  jenisKontakList.map((item) {
                                                return InkWell(
                                                  onTap: () {
                                                    setStateDialog(() {
                                                      selectedJenisKontak =
                                                          item;
                                                      toggleExpand(
                                                          setStateDialog);
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(12.w),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(item),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),

                                        SizedBox(height: 20.h),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                            onPressed: () {
                                              if (nomorController
                                                      .text.isNotEmpty &&
                                                  namaController
                                                      .text.isNotEmpty &&
                                                  selectedJenisKontak != null) {
                                                _tambahKontak(
                                                  nomorController.text,
                                                  namaController.text,
                                                  selectedJenisKontak!,
                                                );
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Text(
                                              "Simpan",
                                              style: TextStyle(
                                                color: Color(0xFF5938FB),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 6,
                                  right: 6,
                                  child: IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: const Text("Tambah Kontak"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}