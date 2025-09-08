import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PersyaratanPage extends StatefulWidget {
  const PersyaratanPage({super.key});

  @override
  State<PersyaratanPage> createState() => _PersyaratanPageState();
}

class _PersyaratanPageState extends State<PersyaratanPage> {
  bool isIsiPulsaExpanded = false;
  bool isPrivasiExpanded = false;
  bool isDepositExpanded = false;
  bool isPergantianExpanded = false;
  bool isNotifikasiExpanded = false;
  bool isPengembalianExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Stack(
        children: [
          // 🔹 Header Section with Background
          Stack(
            children: [
              // Background wave SVG
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

          // Card Bantuan melayang
          Positioned(
            top: 120,
            left: 20,
            right: 20,
            child: Container(
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
                "Bantuan",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C4DF4),
                ),
              ),
            ),
          ),

          // Scrollable content
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
                    child: Text(
                      "Persyaratan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFFE5E5E5),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ExpansionTile untuk "Isi Pulsa"
                        _buildPersyaratanExpansionTile(
                          context,
                          title: 'Isi Pulsa',
                          isExpanded: isIsiPulsaExpanded,
                          onExpansionChanged: (expanding) {
                            setState(() => isIsiPulsaExpanded = expanding);
                          },
                          children: const [
                            Text(
                              "Pengisian pulsa maksimal 1 kali ke nomor yang sama dengan nominal yang sama. Hal ini untuk mengantisipasi terjadi pengisian 2 kali secara tidak disengaja. Modipay tidak bertanggung jawab atas kesalahan pengisian pulsa dikarenakan kesalahan input nomor tujuan. Deposit anda akan dikurangi setelah permintaan isi pulsa dilakukan. Deposit akan ditambahkan kembali apabila proses pengisian pulsa gagal dilakukan.",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Harga dapat berubah sewaktu-waktu tanpa pemberitahuan.",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "(PM) = Pulsa Murah dengan syarat ketentuan yang tertera diatas",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "(REG) = Pulsa Reguler",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        _buildDivider(),

                        // ExpansionTile untuk "Privasi dan Keamanan"
                        _buildPersyaratanExpansionTile(
                          context,
                          title: 'Privasi dan Keamanan',
                          isExpanded: isPrivasiExpanded,
                          onExpansionChanged: (expanding) {
                            setState(() => isPrivasiExpanded = expanding);
                          },
                          children: [
                            _buildBulletPointItem(
                              "Password terdiri dari minimal 6 karakter.",
                            ),
                            _buildBulletPointItem(
                              "Disarankan menggunakan huruf dan angka.",
                            ),
                            _buildBulletPointItem(
                              "Jangan memberitahukan Password Anda kepada siapapun.",
                            ),
                            _buildBulletPointItem(
                              "Pengguna yang kehilangan HP / akun Modipay bisa menghubungi kami di modipayid@gmail.com untuk menonaktifkan akun Modipay. Modipay tidak bertanggung jawab atas transaksi yang telah terjadi sebelum pelaporan dilakukan.",
                            ),
                            _buildBulletPointItem(
                              "Pengguna dihimbau untuk tidak memberikan informasi Password kepada orang lain.",
                            ),
                            _buildBulletPointItem(
                              "Pengguna yang kehilangan password bisa mengajukan lupa Password pada menu login.",
                            ),
                            _buildBulletPointItem(
                              "Password akan dikirimkan melalui email Modipay tidak akan menyebarkan informasi pengguna (email & nomor HP) kepada pihak siapapun.",
                            ),
                          ],
                        ),
                        _buildDivider(),

                        // ExpansionTile untuk "Deposit"
                        _buildPersyaratanExpansionTile(
                          context,
                          title: 'Deposit',
                          isExpanded: isDepositExpanded,
                          onExpansionChanged: (expanding) {
                            setState(() => isDepositExpanded = expanding);
                          },
                          children: [
                            _buildBulletPointItem(
                              "Deposit pada aplikasi Modipay berguna untuk melakukan transaksi pengisian pulsa.",
                            ),
                            _buildBulletPointItem(
                              "Pengguna dapat menambah deposit dengan melakukan pengajuan pada menu \"Isi Deposit\".",
                            ),
                            _buildBulletPointItem(
                              "Deposit akan ditambahkan jika pengguna sudah melakukan pembayaran.",
                            ),
                            _buildBulletPointItem(
                              "Deposit akan ditambahkan ke akun pengguna paling lambat 1x24 jam setelah pembayaran diterima.",
                            ),
                            _buildBulletPointItem(
                              "Deposit yang telah ditambahkan tidak dapat diuangkan.",
                              isLast: true,
                            ),
                          ],
                        ),
                        _buildDivider(),

                        // ExpansionTile untuk "Pergantian Nomor HP"
                        _buildPersyaratanExpansionTile(
                          context,
                          title: 'Pergantian Nomor HP',
                          isExpanded: isPergantianExpanded,
                          onExpansionChanged: (expanding) {
                            setState(() => isPergantianExpanded = expanding);
                          },
                          children: [
                            _buildBulletPointItem(
                              "Pengguna yang ingin mengganti no HP dan info akun pengguna bisa menghubungi modipayid@gmail.com.",
                            ),
                            _buildBulletPointItem(
                              "Modipay akan mengirimkan email berupa konfirmasi untuk pergantian no HP",
                              isLast: true,
                            ),
                          ],
                        ),
                        _buildDivider(),

                        // ExpansionTile untuk "Notifikasi"
                        _buildPersyaratanExpansionTile(
                          context,
                          title: 'Notifikasi',
                          isExpanded: isNotifikasiExpanded,
                          onExpansionChanged: (expanding) {
                            setState(() => isNotifikasiExpanded = expanding);
                          },
                          children: [
                            _buildBulletPointItem(
                              "Notifikasi yang dimunculkan pada aplikasi adalah notifikasi yang ada pada hari ini",
                            ),
                            _buildBulletPointItem(
                              "Notifikasi yang lama dapat di akses pada menu arsip di halaman notifikasi.",
                            ),
                            _buildBulletPointItem(
                              "Notifikasi yang sudah 30 hari lamanya akan dihapus secara otomatis.",
                              isLast: true,
                            ),
                          ],
                        ),
                        _buildDivider(),

                        // ExpansionTile untuk "Pengembalian Dana"
                        _buildPersyaratanExpansionTile(
                          context,
                          title: 'Pengembalian Dana',
                          isExpanded: isPengembalianExpanded,
                          onExpansionChanged: (expanding) {
                            setState(() => isPengembalianExpanded = expanding);
                          },
                          children: const [
                            Text(
                              "Segala bentuk proses pengembalian dana akan dikembalikan dalam bentuk deposit dan bukan tunai.",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget pembantu untuk ExpansionTile
  Widget _buildPersyaratanExpansionTile(
    BuildContext context, {
    required String title,
    required bool isExpanded,
    required ValueChanged<bool> onExpansionChanged,
    required List<Widget> children,
    bool isLast = false,
  }) {
    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 2,
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2D2D2D),
              ),
            ),
            trailing: isExpanded
                ? const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF757575),
                  )
                : const Icon(
                    Icons.keyboard_arrow_right,
                    color: Color(0xFF757575),
                  ),
            onExpansionChanged: onExpansionChanged,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ),
              ),
            ],
          ),
        ),
        if (!isLast) _buildDivider(),
      ],
    );
  }

  // Widget pembantu untuk bullet point
  Widget _buildBulletPointItem(String text, {bool isLast = false}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text("• ", style: TextStyle(color: Colors.black)),
            ),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(color: Colors.black, fontSize: 14),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
        if (!isLast) const SizedBox(height: 10),
      ],
    );
  }

  // Widget pembantu untuk Divider
  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, color: Color(0xFFE5E5E5));
  }
}
