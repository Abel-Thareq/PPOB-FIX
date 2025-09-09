import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PanduanKeamananPage extends StatefulWidget {
  const PanduanKeamananPage({super.key});

  @override
  State<PanduanKeamananPage> createState() => _PanduanKeamananPageState();
}

class _PanduanKeamananPageState extends State<PanduanKeamananPage> {
  bool isAncamanKeamananExpanded = false;
  bool isMemperkuatAkunExpanded = false;
  bool isPenangananInsidenExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Stack(
        children: [
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
                      "Panduan Keamanan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text(
                      "Artikel ini bertujuan untuk menjadi panduan keamanan dalam menggunakan Modipay, sehingga Anda dapat menjalankan bisnis dengan nyaman, aman, dan terhindar dari berbagai kejadian yang merugikan.",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text(
                      "Panduan keamanan dapat membantu Anda memahami dan mengidentifikasi ancaman keamanan, serta melakukan respon yang cepat dan tepat dalam menghadapi insiden keamanan.",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.justify,
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
                        // ExpansionTile untuk "Ancaman Keamanan"
                        _buildPanduanKeamananExpansionTile(
                          context,
                          title: 'Ancaman Keamanan',
                          isExpanded: isAncamanKeamananExpanded,
                          onExpansionChanged: (expanding) {
                            setState(
                              () => isAncamanKeamananExpanded = expanding,
                            );
                          },
                          children: [
                            _buildAncamanKeamananSubItem(
                              title: 'Akses Tidak Sah',
                              description:
                                  "Akses Tidak Sah merujuk pada tindakan mengakses, melakukan perubahan, ataupun melakukan transaksi pada data akun tanpa izin Anda. Ada berbagai cara pelaku dapat mendapatkan akses tidak sah ke akun Anda. Berikut adalah beberapa contohnya: \n\n1. Pelaku telah mendapatkan data email dan password akun Anda. \nJika pelaku mendapatkan data login Anda, tentunya pelaku dapat dengan mudah mengakses akun Anda.\n\n2. Pelaku telah mendapatkan akses ke akun email pribadi Anda. \nEmail pribadi Anda merupakan titik krusial keamanan. Jika pelaku berhasil mendapatkan akses ke email Anda, maka pelaku dapat dengan mudah mengakses website dengan melakukan permintaan reset password dan mengikuti instruksi reset password yang dikirimkan ke email Anda.\n\n3. Pelaku membajak perangkat Anda. \nModipay menyediakan akses yang sangat mudah untuk bertransaksi di mana saja dan kapan saja. Jika Anda tidak menjaga keamanan perangkat yang Anda gunakan dengan baik, maka ada kemungkinan perangkat mengalami insiden tidak sah secara langsung melalui perangkat Anda. \n\nAncaman-ancaman ini juga dapat terjadi jika perangkat yang Anda gunakan tidak terjaga dengan baik ataupun jika Anda menjadi korban serangan siber seperti Phishing dan Brute Force.",
                              textAlign: TextAlign.justify,
                            ),
                            _buildAncamanKeamananSubItem(
                              title: 'Rekayasa Sosial atau Penipuan',
                              description:
                                  "Rekayasa Sosial atau Penipuan juga dapat mengancam keamanan akun Anda dan merugikan bisnis Anda. Berikut adalah contoh penipuan yang mungkin terjadi:\n\n1. Penipu menirukan Modipay sebagai admin untuk mendapatkan akses akun ataupun untuk mencuri data pribadi Anda.\nPelaku mungkin saja mengatasnamakan kami (Modipay) sebagai admin atau petugas yang akan melayani, dengan alasan untuk membantu, melakukan pemeliharaan, dan sebagainya. Pelaku dapat menggunakan profil palsu yang sangat meyakinkan dan menggunakan bahasa yang sangat sopan dan manipulatif.",
                              textAlign: TextAlign.justify,
                            ),
                            _buildAncamanKeamananSubItem(
                              title: 'Daftar Istilah',
                              description:
                                  "Phishing adalah upaya untuk mencuri informasi pribadi Anda, seperti akun, email, kata sandi, dan pin, melalui website atau pesan yang terlihat sangat mirip dengan situs yang biasa Anda gunakan. Misalnya, pesan yang mengaku dari layanan perbankan, Modipay, dan lain-lain, yang meminta informasi pribadi Anda.\n\nBrute Force adalah upaya untuk mendapatkan akses ke akun Anda dengan menebak email/username dan password akun Anda. Jika password terlalu pendek atau menggunakan kombinasi karakter yang mudah ditebak, atau jika Anda pernah menjadi korban keylogger, maka akun Anda rentan terhadap ancaman ini.\n\nSocial Engineering adalah teknik psikologis yang dirancang untuk menipu Anda melakukan suatu perbuatan yang pada akhirnya merugikan Anda. Misalnya, orang yang Anda kenal dalam sebuah grup yang Anda kenal untuk meminta data-data pribadi. Ancaman phishing adalah salah satu jenis Social Engineering.",
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        _buildDivider(),

                        // ExpansionTile untuk "Memperkuat Keamanan Akun"
                        _buildPanduanKeamananExpansionTile(
                          context,
                          title: 'Memperkuat Keamanan Akun',
                          isExpanded: isMemperkuatAkunExpanded,
                          onExpansionChanged: (expanding) {
                            setState(
                              () => isMemperkuatAkunExpanded = expanding,
                            );
                          },
                          children: [
                            _buildMemperkuatAkunSubItem(
                              title: 'A. Amankan Data Login Anda',
                              description:
                                  "Berikut adalah tips untuk menjaga keamanan data login Anda\n\n- Gunakan password dengan panjang minimal 8 karakter.\n- Gunakan password dengan kombinasi huruf kapital, angka, dan karakter spesial.\n- Hindari password dengan kombinasi karakter yang mudah ditebak (pola, pengulangan, nama Anda, istilah umum, dsb).\n- Hindari password yang sama dengan akun-akun lain.\n- Perbaharui password Anda secara berkala.\n- Selalu ingat data login. Jika Anda tidak bisa mengingat dan perlu menyimpan data login, simpanlah di tempat yang terproteksi.\n\nJangan memberitahukan data login Anda kepada siapapun, termasuk tim Modipay.",
                              textAlign: TextAlign.justify,
                            ),
                            _buildMemperkuatAkunSubItem(
                              title: 'B. Sistem Trusted Device',
                              description:
                                  "Trusted Device adalah mekanisme pengecekan perangkat pada saat Anda login ke Modipay, sehingga setiap kali login, perangkat yang digunakan akan dibandingkan dengan perangkat sebelumnya atau yang biasa digunakan untuk login.\n\nPerangkat yang digunakan pada saat pertama login akan dianggap sebagai Trusted Device. Selanjutnya, bila ada perangkat lain melakukan login, maka dibutuhkan verifikasi tambahan melalui perangkat yang sudah dikenali sebelumnya (trusted).\n\nUntuk melakukan verifikasi, Anda dapat mengakses menu Perangkat Saya. Di menu tersebut terdapat 2 aksi yang dapat dilakukan, yaitu:\n- Mengizinkan permintaan login.\n- Menolak permintaan login.\n\nJika perangkat tidak dikenal melakukan percobaan login, maka Anda dapat menolak perangkat tersebut untuk login. Dengan demikian Anda dapat mengetahui dan lebih memiliki kendali terhadap perangkat mana saja yang memiliki akses login.\n\nBila perangkat Anda hilang atau ter-reset sehingga tidak dapat melakukan verifikasi login, hubungi kami untuk bantuan.",
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        _buildDivider(),

                        // ExpansionTile untuk "Penanganan Insiden"
                        _buildPanduanKeamananExpansionTile(
                          context,
                          title: 'Penanganan Insiden',
                          isExpanded: isPenangananInsidenExpanded,
                          onExpansionChanged: (expanding) {
                            setState(
                              () => isPenangananInsidenExpanded = expanding,
                            );
                          },
                          children: [
                            _buildPenangananInsidenSubItem(
                              title: 'A. Reset Password',
                              description:
                                  "Setiap kali Anda melakukan login ke Modipay, sistem akan mengirimkan email notifikasi ke email terdaftar Anda. Jika Anda tidak menerima email notifikasi login yang dikirim, maka kemungkinan besar telah terjadi akses tidak sah ke akun Anda. Jika hal ini terjadi, atau ada indikasi lain bahwa ada kemungkinan akun Anda diakses pihak tidak dikenal, segera lakukan reset password.\n\nAnda dapat melakukan reset password di halaman Ubah Password. Buatlah password baru yang kuat sesuai dengan panduan sebelumnya.",
                              textAlign: TextAlign.justify,
                            ),
                            _buildPenangananInsidenSubItem(
                              title: 'B. Reset PIN',
                              description:
                                  "Jika PIN transaksi Anda tersebar atau diketahui oleh pihak lain, segera lakukan reset PIN.\n\nAnda dapat melakukan reset PIN di halaman Ubah PIN. Buatlah PIN baru yang kuat, PIN yang kuat tidak mengandung pola yang mudah ditebak (pengulangan atau berurutan) ataupun data diri (tanggal lahir, dsb) milik Anda.",
                              textAlign: TextAlign.justify,
                            ),
                            _buildPenangananInsidenSubItem(
                              title: 'C. Hapus Perangkat Tidak Dikenal',
                              description:
                                  "Jika ada indikasi insiden keamanan pada akun Anda, Anda juga dapat memeriksa daftar perangkat yang pernah login ke akunnya. Daftar ini dapat dilihat di menu Perangkat Saya.\n\nJika ada aktivitas atau perangkat yang tidak dikenali, maka kemungkinan telah terjadi akses tidak sah ke akun Anda. Klik tombol Logout untuk menghapus akses perangkat tidak dikenal tersebut ke akun Anda.\n\nJangan lupa untuk melakukan reset password dan PIN juga untuk memastikan keamanan akun.\n\nSegera laporkan segala indikasi insiden keamanan apapun terkait akun Anda kepada tim Modipay.",
                              textAlign: TextAlign.justify,
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

  // Widget untuk ExpansionTile
  Widget _buildPanduanKeamananExpansionTile(
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
              vertical: 8,
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black, // Mengubah warna teks judul menjadi hitam
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
        if (!isLast)
          const Divider(height: 1, thickness: 1, color: Color(0xFFE5E5E5)),
      ],
    );
  }

  // Widget pembantu untuk sub-item "Ancaman Keamanan"
  Widget _buildAncamanKeamananSubItem({
    required String title,
    required String description,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black,
          ), // Mengubah warna teks deskripsi menjadi hitam
        ),
        const SizedBox(height: 5),
        Text(
          description,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
          ), // Mengubah warna teks deskripsi menjadi hitam
          textAlign: textAlign,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  // Widget pembantu untuk sub-item "Memperkuat Keamanan Akun"
  Widget _buildMemperkuatAkunSubItem({
    required String title,
    required String description,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black,
          ), // Mengubah warna teks deskripsi menjadi hitam
        ),
        const SizedBox(height: 5),
        Text(
          description,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
          ), // Mengubah warna teks deskripsi menjadi hitam
          textAlign: textAlign,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  // Widget pembantu untuk sub-item "Penanganan Insiden"
  Widget _buildPenangananInsidenSubItem({
    required String title,
    required String description,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black,
          ), // Mengubah warna teks deskripsi menjadi hitam
        ),
        const SizedBox(height: 5),
        Text(
          description,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
          ), // Mengubah warna teks deskripsi menjadi hitam
          textAlign: textAlign,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  // Widget pembantu untuk Divider
  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, color: Color(0xFFE5E5E5));
  }

}
