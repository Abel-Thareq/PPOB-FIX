import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ppob_app/features/Tarik%20Tunai/presentation/pages/tarik_tunaisatu.dart';
import 'package:ppob_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ====== IMPORT FITUR-FITUR ======
import 'package:ppob_app/features/transferbank/transferbank_page.dart';
import 'package:ppob_app/features/pulsa_data/pulsa_page.dart';
import 'package:ppob_app/features/ewallet/ewallet_page.dart';
import 'package:ppob_app/features/listrik/presentation/pages/listrik_page.dart';
import 'package:ppob_app/features/pdam/presentation/pages/pdam_page.dart';
import 'package:ppob_app/features/home/presentation/pages/tagihan_page.dart';
import 'package:ppob_app/features/home/presentation/pages/lainnyahome_page.dart';
import 'package:ppob_app/features/isi_deposit/presentation/pages/isideposit_page.dart';
import 'package:ppob_app/features/byu/presentation/pages/byu_satu.dart';
import 'package:ppob_app/features/home/presentation/pages/topupgame_page.dart';
import 'package:ppob_app/features/home/presentation/pages/emoney_page.dart';
import 'package:ppob_app/features/home/presentation/pages/notif_page.dart';
import 'package:ppob_app/features/voucher/presentation/pages/voucher_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class ActionButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final MainAxisAlignment alignment;
  final VoidCallback? onTap;
  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.alignment = MainAxisAlignment.center,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisAlignment: alignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 8, color: Colors.white)),
        ],
      ),
    );
  }
}

class _HomePageState extends State<HomePage> {
  // ignore: unused_field
  final int _selectedIndex = 2;
  final PageController _bannerController = PageController(viewportFraction: 0.82);

  // ====== STATE SALDO ======
  bool isBalanceVisible = true;
  double saldo = 0.0;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchSaldo();
  }

  Future<void> fetchSaldo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) return;

      final resp = await http.get(
        Uri.parse("${ApiService.baseUrl}/user"),
        headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
      );

      if (resp.statusCode == 200) {
        final jsonBody = json.decode(resp.body);
        final rawSaldo = (jsonBody['data']?['saldo']) ?? 0;

        if (!mounted) return; // ✅ pastikan widget masih ada

        setState(() {
          saldo = (rawSaldo is int)
              ? rawSaldo.toDouble()
              : (rawSaldo is double)
                  ? rawSaldo
                  : double.tryParse(rawSaldo.toString()) ?? 0.0;
        });
      } else {
        debugPrint('Gagal ambil saldo: ${resp.statusCode} ${resp.body}');
      }
    } catch (e) {
      debugPrint('Error fetchSaldo: $e');
    }
  }

  String formatRupiah(double value) {
    final fixed = value.toStringAsFixed(2);
    final parts = fixed.split('.');
    String intPart = parts[0];
    final decPart = parts.length > 1 ? parts[1] : '00';

    final buffer = StringBuffer();
    for (int i = 0; i < intPart.length; i++) {
      final reverseIndex = intPart.length - i;
      buffer.write(intPart[i]);
      if (reverseIndex > 1 && reverseIndex % 3 == 1) {
        buffer.write('.');
      }
    }
    var formattedInt = buffer.toString();
    if (formattedInt.endsWith('.')) {
      formattedInt = formattedInt.substring(0, formattedInt.length - 1);
    }
    return 'Rp$formattedInt,$decPart';
  }

  void toggleBalanceVisibility() {
    setState(() => isBalanceVisible = !isBalanceVisible);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      extendBody: true,
      body: Stack(
        children: [
          SizedBox(
            height: 140,
            width: double.infinity,
            child: SvgPicture.asset('assets/images/backgroundtop.svg', fit: BoxFit.cover),
          ),

          Column(
            children: [
              const SizedBox(height: 40),
              // Header
              SizedBox(
                height: 80,
                child: Stack(
                  children: [
                    Positioned(
                      top: 25,
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'modipay',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 21),
                          ),
                          Text(
                            'SATU PINTU SEMUA PEMBAYARAN',
                            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 9),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 30,
                      child: Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              // Navigasi ke halaman NotifApp()
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const NotifApp()));
                            },
                            icon: const Icon(Icons.notifications_none, size: 25, color: Colors.white),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {},
                            icon: const Icon(Icons.headset_mic_outlined, size: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // Card saldo + quick menu
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6C4DF4),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                                    child: Image.asset('assets/images/qr.png', width: 20, height: 20),
                                  ),
                                  const SizedBox(width: 9),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Saldo Deposito', style: TextStyle(color: Colors.white, fontSize: 10)),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: AutoSizeText(
                                                isBalanceVisible ? formatRupiah(saldo) : 'Rp•••••••',
                                                style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                                                maxLines: 1,
                                                minFontSize: 13,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            GestureDetector(
                                              onTap: toggleBalanceVisibility,
                                              child: Icon(
                                                isBalanceVisible ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 6, top: 4),
                                        child: ActionButton(
                                          icon: Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                                            child: Image.asset('assets/images/add.png', width: 12, height: 12),
                                          ),
                                          label: 'Isi Deposit',
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (_) => const IsiDepositPage()),
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10, top: 4),
                                        child: ActionButton(
                                          icon: Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                                            child: const Icon(Icons.refresh, size: 14, color: Colors.black87),
                                          ),
                                          label: 'Refresh',
                                          onTap: () {
                                            fetchSaldo();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                _MenuButtonCustom(label: 'Transfer', iconPath: 'assets/images/transfer.png', navigateToTransfer: true),
                                _MenuButtonCustom(label: 'Pulsa/Data', iconPath: 'assets/images/pulsa.png', navigateToPulsa: true),
                                _MenuButtonCustom(label: 'E Wallet', iconPath: 'assets/images/ewallet.png', navigateToEWallet: true),
                                _MenuButtonCustom(label: 'Lainnya', iconPath: 'assets/images/lainnya.png', navigateToLainnya: true),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Search + fitur grid
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade300, width: 1),
                              ),
                              height: 48,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: TextField(
                                      controller: _searchController,
                                      textAlignVertical: TextAlignVertical.center,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 43, bottom: 14),
                                        hintText: 'Cari fitur',
                                        hintStyle: TextStyle(color: Color(0xFF6C4DF4), fontSize: 14, fontWeight: FontWeight.bold),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    left: 14,
                                    top: 12,
                                    child: Icon(Icons.search_rounded, color: Color(0xFF6C4DF4), size: 24),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                _MenuButtonCustom(label: 'Tagihan', iconPath: 'assets/images/tagihan.png', withBorder: true, navigateToTagihan: true),
                                _MenuButtonCustom(label: 'Cash Service', iconPath: 'assets/images/atm.png', withBorder: true, navigateToTariktunai: true),
                                _MenuButtonCustom(label: 'E Money', iconPath: 'assets/images/emoney.png', withBorder: true, navigateToEmoney: true),
                                _MenuButtonCustom(label: 'PDAM', iconPath: 'assets/images/pdam.png', withBorder: true, navigateToPdam: true),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                _MenuButtonCustom(label: 'E Voucher', iconPath: 'assets/images/evoucher.png', withBorder: true, navigateToEVoucher: true),
                                _MenuButtonCustom(label: 'Top Up Game', iconPath: 'assets/images/topup.png', withBorder: true, navigateToTopup: true),
                                _MenuButtonCustom(label: 'Listrik', iconPath: 'assets/images/listrik.png', withBorder: true, navigateToListrik: true),
                                _MenuButtonCustom(label: 'by.U Promo', iconPath: 'assets/images/byu.png', withBorder: true, navigateToByu: true),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Banner
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width * 9 / 26,
                        child: PageView.builder(
                          controller: _bannerController,
                          itemBuilder: (context, index) {
                            final bannerIndex = index % 4;
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Text(
                                  'Banner ${bannerIndex + 1}',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MenuButtonCustom extends StatelessWidget {
  final String label;
  final String iconPath;
  final Color backgroundColor;
  final bool navigateToListrik;
  final bool navigateToLainnya;
  final bool navigateToPdam;
  final bool withBorder;
  final bool navigateToTagihan;
  final bool navigateToEWallet;
  final bool navigateToPulsa;
  final bool navigateToTransfer;
  final bool navigateToTopup;
  final bool navigateToByu;
  final bool navigateToEmoney;
  final bool navigateToTariktunai;
  final bool navigateToEVoucher;

  const _MenuButtonCustom({
    required this.label,
    required this.iconPath,
    // ignore: unused_element_parameter
    this.backgroundColor = Colors.white,
    this.navigateToListrik = false,
    this.navigateToLainnya = false,
    this.navigateToTagihan = false,
    this.navigateToPdam = false,
    this.navigateToEWallet = false,
    this.navigateToPulsa = false,
    this.navigateToTransfer = false,
    this.navigateToByu = false,
    this.navigateToTopup = false,
    this.navigateToEmoney = false,
    this.navigateToTariktunai = false,
    this.navigateToEVoucher = false,
    this.withBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          if (navigateToTransfer) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const TransferBankPage()));
          } else if (navigateToListrik) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ListrikPage()));
          } else if (navigateToLainnya) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const LainnyaPage()));
          } else if (navigateToPdam) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const PdamPage()));
          } else if (navigateToTagihan) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const TagihanPage()));
          } else if (navigateToPulsa) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const PulsaPage()));
          } else if (navigateToEWallet) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const EwalletPage()));
          } else if (navigateToByu) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ByuSatuPage()));
          } else if (navigateToTopup) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const TopUpGamePage()));
          } else if (navigateToEmoney) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const EMoneyPage()));
          } else if (navigateToTariktunai) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const TarikTunaiSatuPage()));
          } else if (navigateToEVoucher) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const VoucherPage()));
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(13),
                  border: withBorder ? Border.all(color: Colors.grey.shade300, width: 1) : null,
                ),
                child: Center(child: Image.asset(iconPath, width: 56, height: 56)),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 72,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
