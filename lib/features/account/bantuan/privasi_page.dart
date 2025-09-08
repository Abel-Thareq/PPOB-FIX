import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrivasiPage extends StatefulWidget {
  const PrivasiPage({super.key});

  @override
  State<PrivasiPage> createState() => _PrivasiPageState();
}

class _PrivasiPageState extends State<PrivasiPage> {
  bool isPengenalanExpanded = false;
  bool isPelacakanExpanded = false;
  bool isDistribusiExpanded = true; // Set to true to show the expanded content
  bool isKomitmenExpanded = false;
  bool isHapusAkunExpanded = false;

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
                      "Privasi",
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
                        // ExpansionTile untuk "Pengenalan"
                        _buildPrivasiExpansionTile(
                          context,
                          title: 'Pengenalan',
                          isExpanded: isPengenalanExpanded,
                          onExpansionChanged: (expanding) {
                            setState(() => isPengenalanExpanded = expanding);
                          },
                          children: const [
                            Text(
                              "Selamat Datang di Modipay (Situs). Kami menyarankan setiap pengunjung yang akan menggunakan situs diwajibkan membaca dan mematuhi Kebijakan Privasi yang tercantum disini. Terima kasih telah mengunjungi situs kami (Modipay). Kebijakan privasi ini memberitahukan Anda bagaimana kami menggunakan informasi pribadi yang dikumpulkan di situs ini. Silakan baca kebijakan privasi ini sebelum menggunakan situs atau mengirimkan informasi pribadi apapun. Mengakses dan menggunakan situs ini menandakan Anda menerima semua kegiatan yang dijelaskan dalam kebijakan privasi. Kebijakan ini dapat berubah, dan perubahan akan diumumkan serta perubahan hanya akan berlaku untuk kegiatan dan informasi yang akan datang, bukan yang sudah terjadi. Anda dianjurkan untuk membaca kebijakan privasi setiap kali Anda mengunjungi situs untuk memastikan bahwa Anda memahami bagaimana informasi pribadi yang Anda berikan akan digunakan",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        _buildDivider(),

                        // ExpansionTile untuk "Pelacakan (Cookie) Teknologi"
                        _buildPrivasiExpansionTile(
                          context,
                          title: 'Pelacakan (Cookie) Teknologi',
                          isExpanded: isPelacakanExpanded,
                          onExpansionChanged: (expanding) {
                            setState(() => isPelacakanExpanded = expanding);
                          },
                          children: const [
                            Text(
                              "Situs Modipay dapat menggunakan cookie dan teknologi pelacakan tergantung pada fitur yang ditawarkan. Teknologi pelacakan dan cookie bermanfaat untuk mengumpulkan informasi seperti jenis penjelajah (browser) dan sistem operasional, mendata jumlah pengunjung situs dan memahami cara pengunjung menggunakan situs. Cookie juga dapat membantu menyesuaikan situs untuk pengunjung. Informasi pribadi tidak dapat dikumpulkan melalui cookie dan teknologi pelacak lainnya. Namun, jika Anda sebelumnya memberikan informasi identitas pribadi, cookie dapat terhubung ke informasi tersebut.",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        _buildDivider(),

                        // ExpansionTile untuk "Distribusi Informasi"
                        _buildPrivasiExpansionTile(
                          context,
                          title: 'Distribusi Informasi',
                          isExpanded: isDistribusiExpanded,
                          onExpansionChanged: (expanding) {
                            setState(() => isDistribusiExpanded = expanding);
                          },
                          children: [
                            const Text(
                              "Modipay dapat berbagi informasi dengan lembaga pemerintah atau perusahaan lain yang membantu kami dalam pencegahan atau investigasi penipuan. Kita dapat melakukan ini ketika:",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "1. Diizinkan atau diwajibkan oleh hukum",
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "2. Berusaha untuk melindungi atau mencegah penipuan atau hal-hal yang berpotensi mengarah pada penipuan atau transaksi yang tidak sah",
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "3. Menyelidiki kecurangan yang terjadi.",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Informasi tidak diberikan kepada perusahaan lain untuk tujuan pemasaran.",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        _buildDivider(),

                        // ExpansionTile untuk "Komitmen untuk Keamanan Data"
                        _buildPrivasiExpansionTile(
                          context,
                          title: 'Komitmen untuk Keamanan Data',
                          isExpanded: isKomitmenExpanded,
                          onExpansionChanged: (expanding) {
                            setState(() => isKomitmenExpanded = expanding);
                          },
                          children: const [
                            Text(
                              "Informasi pribadi Anda disimpan secara aman. Hanya karyawan yang dapat memiliki akses ke informasi ini.",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        _buildDivider(),

                        // ExpansionTile untuk "Hapus Akun"
                        _buildPrivasiExpansionTile(
                          context,
                          title: 'Hapus Akun',
                          isExpanded: isHapusAkunExpanded,
                          onExpansionChanged: (expanding) {
                            setState(() => isHapusAkunExpanded = expanding);
                          },
                          children: [
                            _buildSubItem(
                              title:
                                  "Apa Yang Terjadi Jika Saya Menghapus Akun?",
                              description:
                                  "Anda tetap dapat masuk ke akun Anda (dalam waktu 7 hari setelah melakukan hapus akun).\n\nJika Anda tidak memulihkan akun dalam waktu 7 hari setelah melakukan hapus akun. Anda tidak dapat masuk ke akun Anda lagi.\n\nAnda tidak dapat melakukan isi deposit, pulsa maupun aktivitas transaksi lainnya.\n\nAnda tidak dapat menggunakan alamat email atau nomor handphone yang sama, jika ingin melakukan registrasi akun baru.",
                            ),
                            _buildSubItem(
                              title: "Cara Menghapus Akun",
                              description:
                                  "1. Kunjungi halaman Profile.\n\n2. Sebelum menghapus akun pastikan saldo deposit Anda sudah berjumlah 0. Lalu, tekan Hapus Akun.\n\n3. Setelah dialog konfirmasi hapus akun telah tampil. Silakan tekan Hapus Akun.",
                            ),
                            _buildSubItem(
                              title: "Cara Memulihkan Akun",
                              description:
                                  "1. Masuk ke akun Anda.\n\n2. Setelah berhasil, akun Anda akan secara otomatis, dipulihkan kembali dan sistem akan mengirimkan notifikasi bahwa akun berhasil dipulihkan.\n\nJika telah lebih dari 7 hari, Anda tidak dapat melakukan cara di atas dan perlu menghubungi pihak Customer Service agar dibantu untuk memulihkan Akun Anda.",
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
  Widget _buildPrivasiExpansionTile(
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

  // Widget pembantu untuk sub-item di dalam ExpansionTile
  Widget _buildSubItem({required String title, required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          description,
          style: const TextStyle(color: Colors.black, fontSize: 12),
          textAlign: TextAlign.justify,
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
