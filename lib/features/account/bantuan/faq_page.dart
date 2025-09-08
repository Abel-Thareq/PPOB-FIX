import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  bool isTentangModipayExpanded = false;
  bool isCaraMulaiTransaksiExpanded = false;
  bool isMasalahTransaksiExpanded = false;
  bool isCaraDepositExpanded = false;
  bool isAplikasiMobileExpanded = false;

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
                      "FAQ",
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
                        // ExpansionTile untuk "Tentang Modipay"
                        _buildFaqExpansionTile(
                          context,
                          title: 'Tentang Modipay',
                          isExpanded: isTentangModipayExpanded,
                          onExpansionChanged: (expanding) {
                            setState(
                              () => isTentangModipayExpanded = expanding,
                            );
                          },
                          children: const [
                            Text(
                              "Q: Apa itu Modipay?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "A: Modipay adalah Aplikasi dan web yang membantu Anda dalam melakukan pembayaran dan pembelian rutin Anda hanya dengan beberapa sentuhan.",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Q: Apa saja fitur yang dimiliki Modipay?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "A: Kami memiliki fitur pengisian pulsa untuk semua operator, pulsa internasional, pulsa listrik (token listrik), pembayaran tagihan internet, TV kabel, PDAM dan kupon main (voucher game).",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Q: Pulsa internasional apa saja yang tersedia di Modipay?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "A: Untuk saat ini Modipay telah menyediakan Pulsa Internasional Bangladesh, China, Malaysia, Singapore, Thailand, Vietnam dan Philippines",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        _buildDivider(),

                        // ExpansionTile untuk "Cara Mulai Transaksi"
                        _buildFaqExpansionTile(
                          context,
                          title: 'Cara Mulai Transaksi',
                          isExpanded: isCaraMulaiTransaksiExpanded,
                          onExpansionChanged: (expanding) {
                            setState(
                              () => isCaraMulaiTransaksiExpanded = expanding,
                            );
                          },
                          children: const [
                            Text(
                              "Q: Bagaimana cara memulai transaksi ?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "A: Silahkan registrasi terlebih dahulu, setelah itu Anda perlu mengisi deposit di menu Isi deposit. Silahkan melakukan pembayaran sesuai rekening yang tertera. Setelah melakukan pembayaran, silahkan tunggu dan cek notifikasi secara berkala sampai pembayaran anda dikonfirmasi. Setelah pembayaran deposit anda terkonfirmasi, silahkan lakukan transaksi di halaman utama.",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        _buildDivider(),

                        // ExpansionTile untuk "Masalah Transaksi, Pembatalan dan Pengembalian"
                        _buildFaqExpansionTile(
                          context,
                          title:
                              'Masalah Transaksi, Pembatalan dan Pengembalian',
                          isExpanded: isMasalahTransaksiExpanded,
                          onExpansionChanged: (expanding) {
                            setState(
                              () => isMasalahTransaksiExpanded = expanding,
                            );
                          },
                          children: const [
                            Text(
                              "Q: Apakah nomor yang saya daftarkan dapat melakukan pembelian pulsa untuk nomor lain?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "A: Ya. Bisa.",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Q: Kenapa saya hanya bisa mengisi pulsa 1x untuk nominal yang sama ke nomor yang sama dalam 1 hari?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "A: Kami memberikan yang terbaik ke pelanggan, oleh karena itu kami membatasi agar Anda transaksi Anda tidak terisi 2x.",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Q: Saya sudah melakukan pengisian pulsa listrik tetapi saya belum mendapatkan kode nya, apa yang harus saya lakukan?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "A: Kode pulsa listrik Anda dapat di lihat di menu notifikasi.",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Q: Berapa lama pulsa yang saya beli akan masuk?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "A: Pulsa Anda akan masuk dalam 5 detik setelah Anda melakukan pembelian.",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Q: Saya sudah melakukan transaksi, namun pulsa yang saya isi tidak kunjung masuk, apa yang harus saya lakukan?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "A: Anda dapat menginformasikan order Anda ke kami dengan menghubungi 0857-7716-0669 (CS). Kami selalu siap untuk membantu Anda",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        _buildDivider(),

                        // ExpansionTile untuk "Cara Deposit"
                        _buildFaqExpansionTile(
                          context,
                          title: 'Cara Deposit',
                          isExpanded: isCaraDepositExpanded,
                          onExpansionChanged: (expanding) {
                            setState(() => isCaraDepositExpanded = expanding);
                          },
                          children: const [
                            Text(
                              "Q: Saya pengguna baru di Modipay, apa yang harus saya lakukan untuk dapat bertransaksi?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "A: Silahkan lakukan registrasi terlebih dahulu, setelah itu Anda perlu mengisi deposit di menu isi deposit. Silahkan melakukan pembayaran sesuai rekening yang tertera, dan kemudian lakukan konfirmasi deposit. Hingga Anda dapat melakukan transaksi.",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Q: Kenapa saya perlu melakukan deposit di Modipay?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "A: Deposit membantu kami dan pelanggan untuk memudahkan proses transaksi dan refund dana secara real time, sehingga pelanggan tidak selalu ke ATM setiap transaksi.",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Q: Apakah deposit di Modipay saya bisa hangus?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "A: Tidak. Deposit anda akan berlaku selama-lamanya.",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Q: Bagaimana cara untuk mengisi deposit?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "A: Untuk mengisi deposit, silahkan masuk ke menu isi deposit dan pilih nominal deposit, dan kemudian metode pembayaran yang akan digunakan.",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Q: Apakah Modipay menerima pengisian deposit pada hari sabtu, minggu dan hari libur?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "A: Ya, kami menerima pengisian deposit di hari tersebut.",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Q: Berapa lama deposit saya akan terisi setelah saya melakukan pembayaran untuk isi deposit?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "A: Jika Anda melakukan transfer diikuti dengan kode unik, cth: 100.124, dan mencantumkan kode deposit ketika melakukan transfer, maka dalam 2 menit deposit Anda akan otomatis ditambahkan (tidak perlu melakukan konfirmasi).",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Q: Apa itu kode deposit?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "A: Kode deposit adalah kode yang digunakan agar kami mengindentifikasi sumber dana yang masuk. Ini adalah contoh kode deposit DEPxxxxx.",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Q: Saya sudah melakukan isi deposit dan melakukan pembayaran, namun deposit saya belum terisi, apa yang harus saya lakukan?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "A: Silahkan kirim SMS/Whatsapp kepada customer service kami di 0857-7716-0669 (CS) dengan format [kode deposit] atas nama [nama pengirim][nama bank].",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Q: Apakah pengisian deposit di Modipay 24 jam?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "A: Kami menerima pengisian deposit hingga pukul 21.30 malam, pengisian deposit di atas jam tersebut akan kami proses pada hari berikutnya",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        _buildDivider(),

                        // ExpansionTile untuk "Aplikasi Mobile"
                        _buildFaqExpansionTile(
                          context,
                          title: 'Aplikasi Mobile',
                          isExpanded: isAplikasiMobileExpanded,
                          onExpansionChanged: (expanding) {
                            setState(
                              () => isAplikasiMobileExpanded = expanding,
                            );
                          },
                          children: const [
                            Text(
                              "Q: Mobile app Modipay tersedia untuk operating system apa saja?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "A: Untuk saat ini, aplikasi Modipay hanya dapat diakses melalui web browser smartphone ataupun komputer.",
                              style: TextStyle(color: Colors.black),
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

  // Widget pembantu untuk ExpansionTile
  Widget _buildFaqExpansionTile(
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

  // Widget pembantu untuk Divider
  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, color: Color(0xFFE5E5E5));
  }

}
