import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CaraPenggunaanPage extends StatefulWidget {
  const CaraPenggunaanPage({super.key});

  @override
  State<CaraPenggunaanPage> createState() => _CaraPenggunaanPageState();
}

class _CaraPenggunaanPageState extends State<CaraPenggunaanPage> {
  bool isInstallExpanded = false;
  bool isMemberRegistrationExpanded = false;
  bool isDepositExpanded = false;
  bool isDepositConfirmationExpanded = false;
  bool isTransactionExpanded = false;

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
                      "Cara Penggunaan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
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
                        // ExpansionTile untuk "Install Aplikasi"
                        _buildCaraPenggunaanExpansionTile(
                          context,
                          title: 'Install Aplikasi',
                          isExpanded: isInstallExpanded,
                          onExpansionChanged: (expanding) {
                            setState(() => isInstallExpanded = expanding);
                          },
                          children: const [
                            Text(
                              "Untuk saat ini aplikasi modipay hanya tersedia untuk Android. Temukan aplikasi Android versi terbaru Modipay. \n\nApabila anda tidak menggunakan Android, Anda dapat menggunakan Modipay melalui browser baik Melalui Mobile maupun komputer di https://modipay.wlabel.id. Untuk kelancaran penggunaan, Selalu gunakan browser dengan versi yang terbaru",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        _buildDivider(),

                        // ExpansionTile untuk "Pendaftaran Member"
                        _buildCaraPenggunaanExpansionTile(
                          context,
                          title: 'Pendaftaran Member',
                          isExpanded: isMemberRegistrationExpanded,
                          onExpansionChanged: (expanding) {
                            setState(
                              () => isMemberRegistrationExpanded = expanding,
                            );
                          },
                          children: const [
                            Text(
                              "Untuk bisa melakukan transaksi seperti pembelian pulsa, token listrik, voucher game dan lain-lainya Anda sebelumnya harus terdaftar sebagai member diModipay. Anda dapat dengan mudah mendaftar Melalui Aplikasi atau Website di menu Registrasi/Daftar\n\nPendaftaran hanya memerlukan Email, Nomor Hp, Nama, dan Kata sandi. Masing-masing informasi dibutuhkan untuk login, reset password, transaksi dan deposit anda.",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        _buildDivider(),

                        // ExpansionTile untuk "Isi Deposit"
                        _buildCaraPenggunaanExpansionTile(
                          context,
                          title: 'Isi Deposit',
                          isExpanded: isDepositExpanded,
                          onExpansionChanged: (expanding) {
                            setState(() => isDepositExpanded = expanding);
                          },
                          children: const [
                            Text(
                              "Deposit merupakan dana yang anda setor ke Modipay untuk kemudian dapat digunakan sebagai sarana pembayaran transaksi lainnya seperti isi pulsa, token listrik, voucher game dll. Dengan adanya Deposit, proses pembayaran, refund, dan pembatalan dapat dengan mudah untuk diproses.\n\nProses Isi Deposit:\n1. Pilih nominal rupiah yang akan anda transfer sebagai deposit.\n2. Pilih metode deposit.\n3. Pilih layanan pembayaran Modipay.\n4. Saat anda menekan Ok, instruksi cara dan informasi transaksi akan di tampilkan pada Notifikasi.\n5. Untuk kelancaran proses isi deposit pastikan anda mengikuti intruksi dan informasi yang anda terima, terutama Rekening Tujuan, Jumlah Transfer (harus sesuai dengan notifikasi), dan Kode deposit.\n\nApabila anda melkukan transfer dengan informasi dan jumlah yang sesuai, deposit anda akan langsung masuk ke akun Modipay anda dalam 2 menit.\n\nProses Transfer Dana:\n1. Apabila anda memilih isi deposit melalui Transfer Bank, anda dapat melakukannya melalui mesin ATM maupun internet Banking.\n2. Masukan jumlah transfer sesuai dengan jumlah teransfer yang di intruksikan, pastikan sesuai dengan 3 digit dibelakang.\n3. Transfer melalui mesin ATM tidak memiliki kolom berita untuk mencantumkan kode deposit, sehingga anda perlu melakukan konfirmasi diruang konfirmasi deposit setelah anda melaukan transfer.\n4. Untuk transfer melalui Bank lain anda dapat menggunakan layanan Switching ATM Bersama (Virtual Accnout) dan ikuti intruksi yang diberikan saat melakukan isi deposit.",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        _buildDivider(),

                        // ExpansionTile untuk "Konfirmasi Deposit"
                        _buildCaraPenggunaanExpansionTile(
                          context,
                          title: 'Konfirmasi Deposit',
                          isExpanded: isDepositConfirmationExpanded,
                          onExpansionChanged: (expanding) {
                            setState(
                              () => isDepositConfirmationExpanded = expanding,
                            );
                          },
                          children: const [
                            Text(
                              "Saat anda melakukan isi deposit dan telah melakukan transfer dana, apabila anda mengikuti intruksi dan mencantumkan informasi secara benar, deposit anda otomatis akan terisi dalam 2 menit. Namun, apabila deposit belum masuk setelah beberapa menit sejak dilakukan transfer, anda dapat melaukan konfirmasi transfer melalui menu konfirmasi deposit atau menghubungi customer service Modipay melalui SMS/Whatsapp Proses Konfirmasi Deposit:\n\n1. Pastikan anda telah melakukan isi deposit dan melakukan transfer sebagaimana yang telah diinformasikan\n2. Pada aplikasi atau web, akses menu konfirmasi deposit\n3. Masukan kode deposit yang anda terima saat melakukan isi deposit sebelumnya (DEPxxxx)\n4. Melakukan Metode pembayaran sesuai dengan yang anda gunakan untuk transfer.\n5. Masukan nama rekening yang anda gunakan untuk transfer ke rekening Modipay.\n6. Masukan jumlah transfer sesuai dengan yang telah anda transfer.\n7. Saat anda menekan OK, informasi yang anda kirimkan akan langsung kami proses",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        _buildDivider(),

                        // ExpansionTile untuk "Transaksi"
                        _buildCaraPenggunaanExpansionTile(
                          context,
                          title: 'Transaksi',
                          isExpanded: isTransactionExpanded,
                          onExpansionChanged: (expanding) {
                            setState(() => isTransactionExpanded = expanding);
                          },
                          children: const [
                            Text(
                              "Setelah deposit Modipay anda terisi, anda dapat melakukan transaksi dimodipay dengan mudah.\n\nBerikut transaksi yang dapat anda lakukan dimodipay:\n1. Isi Pulsa&Datas Semua Operator\n2. Isi Pulsa Internasional\n3. Beli Voucher Game\n4. Bayar Tagihan\n5. Top Up Ewallet\n6. E-Money\n7. E-Voucher\n8. Top Up Game\n9. by.u promo\n10. Lainnya",
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
  Widget _buildCaraPenggunaanExpansionTile(
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
