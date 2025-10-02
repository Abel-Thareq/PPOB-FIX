import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'tagihan_pendidikan_page.dart';

class Pendidikan3Page extends StatefulWidget {
  final String universityName;
  final String universityImage;

  const Pendidikan3Page({
    super.key,
    required this.universityName,
    required this.universityImage,
  });

  @override
  State<Pendidikan3Page> createState() => _Pendidikan3PageState();
}

class _Pendidikan3PageState extends State<Pendidikan3Page> {
  String? selectedFaculty;
  final TextEditingController _paymentCodeController = TextEditingController();
  bool isPaymentCodeValid = false;

  @override
  void initState() {
    super.initState();
    _paymentCodeController.addListener(_validatePaymentCode);
  }

  @override
  void dispose() {
    _paymentCodeController.dispose();
    super.dispose();
  }

  void _validatePaymentCode() {
    setState(() {
      isPaymentCodeValid = _paymentCodeController.text.length >= 8;
    });
  }

  // Model data kampus
  Map<String, Map<String, dynamic>> get universities => {
    'Universitas Tidar': {
      'image': widget.universityImage,
      'faculties': [
        'Fakultas Teknik',
        'Fakultas Keguruan Ilmu dan Pendidikan',
        'Fakultas Ilmu Sosial dan Politik',
        'Fakultas Ekonomi',
        'Fakultas Pertanian',
      ],
    },
    'Universitas Lain': {
      'image':
          'assets/images/campus.png', // Ganti dengan gambar default atau logo kampus lain
      'faculties': ['Fakultas A', 'Fakultas B', 'Fakultas C'],
    },
  };

  String selectedUniversity = 'Universitas Tidar';

  void _showUniversityOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    "Pilih Universitas",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const Divider(height: 20),
            ...universities.keys
                .map(
                  (university) => ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        universities[university]!['image'],
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 40,
                          height: 40,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.school, color: Colors.grey),
                        ),
                      ),
                    ),
                    title: Text(university),
                    trailing: selectedUniversity == university
                        ? const Icon(Icons.check, color: Color(0xFF6C4DF4))
                        : null,
                    onTap: () {
                      setState(() {
                        selectedUniversity = university;
                        selectedFaculty =
                            null; // Reset fakultas ketika kampus berubah
                      });
                      Navigator.pop(context);
                    },
                  ),
                )
                ,
          ],
        ),
      ),
    );
  }

  Widget _buildFacultyOption(String faculty) {
    return InkWell(
      onTap: () {
        setState(() => selectedFaculty = faculty);
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Text(
              faculty,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const Spacer(),
            if (selectedFaculty == faculty)
              const Icon(Icons.check, color: Color(0xFF6C4DF4)),
          ],
        ),
      ),
    );
  }

  void _showFacultyOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.school, color: Colors.grey),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.universityName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        "Pilih Fakultas",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 20),
            ...universities[selectedUniversity]!['faculties']
                .map((faculty) => _buildFacultyOption(faculty.toString()))
                .toList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Stack(
        children: [
          // Header Section with Background
          Stack(
            children: [
              SizedBox(
                height: 150,
                width: double.infinity,
                child: SvgPicture.asset(
                  "assets/images/backgroundtop.svg",
                  fit: BoxFit.cover,
                ),
              ),
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

          // Content Area
          Padding(
            padding: const EdgeInsets.only(top: 170),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // University Selection
                      InkWell(
                        onTap: _showUniversityOptions,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE5E5E5)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  widget.universityImage,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        width: 40,
                                        height: 40,
                                        color: Colors.grey.shade200,
                                        child: const Icon(
                                          Icons.school,
                                          color: Colors.grey,
                                        ),
                                      ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                widget.universityName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF2D2D2D),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Fakultas
                      const Text(
                        "Fakultas",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE5E5E5)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          leading: const Icon(
                            Icons.account_balance,
                            color: Colors.grey,
                          ),
                          title: Text(
                            selectedFaculty ?? "Pilih Fakultas",
                            style: TextStyle(
                              color: selectedFaculty != null
                                  ? const Color(0xFF2D2D2D)
                                  : Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color.fromARGB(255, 158, 158, 158),
                          ),
                          onTap: _showFacultyOptions,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Kode Pembayaran
                      const Text(
                        "Kode Pembayaran",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE5E5E5)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _paymentCodeController,
                          decoration: InputDecoration(
                            hintText: "Masukkan Kode Pembayaran",
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              Icons.grid_3x3,
                              color: Colors.grey,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 250),

                      // Lanjutkan Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isPaymentCodeValid
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TagihanPendidikanPage(
                                            tanggal: DateTime.now().toString(),
                                            idModipay: '123456',
                                            namaPengirim: 'Nama Pengirim',
                                            nominal: '100000',
                                            idTransaksi: 'TRX001',
                                          ),
                                    ),
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isPaymentCodeValid
                                ? const Color(0xFF6C4DF6)
                                : const Color(0xFFEFEFEF),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            "Lanjutkan",
                            style: TextStyle(
                              color: isPaymentCodeValid
                                  ? Colors.white
                                  : const Color(0xFF757575),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
