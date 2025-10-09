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

// Import halaman tagihan
import 'package:ppob_app/features/bpjs/presentation/pages/bpjs_page.dart';
import 'package:ppob_app/features/kartukredit/presentation/pages/kredit_page.dart';
import 'package:ppob_app/features/cicilan/presentation/pages/cicilan_page.dart';
import 'package:ppob_app/features/kai/presentation/pages/kai_page.dart';
import 'package:ppob_app/features/asuransi/presentation/pages/asuransi_page.dart';
import 'package:ppob_app/features/pbb/presentation/pages/pbb_page.dart';
import 'package:ppob_app/features/pascabayar/presentation/pages/pascabayar_page.dart';
import 'package:ppob_app/features/snpmb/presentation/pages/snpmb_page.dart';
import 'package:ppob_app/features/samsat/presentation/pages/samsat_page.dart';
import 'package:ppob_app/features/telkom/presentation/pages/telkom_page.dart';
import 'package:ppob_app/features/kua/presentation/pages/kua_page.dart';
import 'package:ppob_app/features/einvoicing/presentation/pages/einvoicing_page.dart';
import 'package:ppob_app/features/pgn/presentation/pages/pgn_page.dart';
import 'package:ppob_app/features/etilang/presentation/pages/etilang_page.dart';
import 'package:ppob_app/features/paspor/presentation/pages/paspor_page.dart';
import 'package:ppob_app/features/kabelinternet/presentation/pages/internet_page.dart';
import 'package:ppob_app/features/pajak%20daerah/presentation/pages/pajakdaerah_page.dart';
import 'package:ppob_app/features/transaction/presentation/pages/properti1_page.dart';
import 'package:ppob_app/features/mpn/presentation/pages/mpn_page.dart';
import 'package:ppob_app/features/transaction/presentation/pages/pendidikan_page.dart';

// Import halaman lainnya
import 'package:ppob_app/features/donasi/presentation/pages/donasi_page.dart';
import 'package:ppob_app/features/reksa_dana/presentation/pages/reksa_page.dart';
import 'package:ppob_app/features/wakaf/presentation/pages/wakaf_page.dart';
import 'package:ppob_app/features/transaction/presentation/pages/emas_page.dart';
import 'package:ppob_app/features/transaction/presentation/pages/zakat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class ActionButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final MainAxisAlignment alignment;
  final VoidCallback? onTap;
  const ActionButton({
    Key? key,
    required this.icon,
    required this.label,
    this.alignment = MainAxisAlignment.center,
    this.onTap,
  }) : super(key: key);

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
  bool _isSearching = false;
  List<Map<String, dynamic>> _searchResults = [];
  final FocusNode _searchFocusNode = FocusNode();

  // ====== DATA SEMUA FITUR ======
  final List<Map<String, dynamic>> _allFeatures = [
    // ====== FITUR DARI HOME PAGE ======
    {'title': 'Transfer', 'iconPath': 'assets/images/transfer.png', 'category': 'home', 'routeType': 'transfer'},
    {'title': 'Pulsa/Data', 'iconPath': 'assets/images/pulsa.png', 'category': 'home', 'routeType': 'pulsa'},
    {'title': 'E Wallet', 'iconPath': 'assets/images/ewallet.png', 'category': 'home', 'routeType': 'ewallet'},
    {'title': 'Lainnya', 'iconPath': 'assets/images/lainnya.png', 'category': 'home', 'routeType': 'lainnya'},
    {'title': 'Tagihan', 'iconPath': 'assets/images/tagihan.png', 'category': 'home', 'routeType': 'tagihan'},
    {'title': 'Cash Service', 'iconPath': 'assets/images/atm.png', 'category': 'home', 'routeType': 'tariktunai'},
    {'title': 'E Money', 'iconPath': 'assets/images/emoney.png', 'category': 'home', 'routeType': 'emoney'},
    {'title': 'PDAM', 'iconPath': 'assets/images/pdam.png', 'category': 'home', 'routeType': 'pdam'},
    {'title': 'E Voucher', 'iconPath': 'assets/images/evoucher.png', 'category': 'home', 'routeType': 'evoucher'},
    {'title': 'Top Up Game', 'iconPath': 'assets/images/topup.png', 'category': 'home', 'routeType': 'topup'},
    {'title': 'Listrik', 'iconPath': 'assets/images/listrik.png', 'category': 'home', 'routeType': 'listrik'},
    {'title': 'by.U Promo', 'iconPath': 'assets/images/byu.png', 'category': 'home', 'routeType': 'byu'},

    // ====== FITUR DARI TAGIHAN PAGE ======
    {'title': 'Briva', 'iconPath': 'assets/images/briva.png', 'category': 'tagihan', 'routeType': 'briva'},
    {'title': 'BPJS', 'iconPath': 'assets/images/bpjs.png', 'category': 'tagihan', 'routeType': 'bpjs'},
    {'title': 'Kartu Kredit', 'iconPath': 'assets/images/kartukredit.png', 'category': 'tagihan', 'routeType': 'kartukredit'},
    {'title': 'Cicilan', 'iconPath': 'assets/images/cicilan.png', 'category': 'tagihan', 'routeType': 'cicilan'},
    {'title': 'KAI', 'iconPath': 'assets/images/kai.png', 'category': 'tagihan', 'routeType': 'kai'},
    {'title': 'Pendidikan', 'iconPath': 'assets/images/pendidikan.png', 'category': 'tagihan', 'routeType': 'pendidikan'},
    {'title': 'Asuransi', 'iconPath': 'assets/images/asuransi.png', 'category': 'tagihan', 'routeType': 'asuransi'},
    {'title': 'PBB', 'iconPath': 'assets/images/pbb.png', 'category': 'tagihan', 'routeType': 'pbb'},
    {'title': 'Pascabayar', 'iconPath': 'assets/images/pascabayar.png', 'category': 'tagihan', 'routeType': 'pascabayar'},
    {'title': 'SNPMB', 'iconPath': 'assets/images/snpmb.png', 'category': 'tagihan', 'routeType': 'snpmb'},
    {'title': 'SAMSAT', 'iconPath': 'assets/images/samsat.png', 'category': 'tagihan', 'routeType': 'samsat'},
    {'title': 'Telkom', 'iconPath': 'assets/images/telkom.png', 'category': 'tagihan', 'routeType': 'telkom'},
    {'title': 'Bayar SPT Bulanan', 'iconPath': 'assets/images/spt.png', 'category': 'tagihan', 'routeType': 'spt'},
    {'title': 'Bayar KUA', 'iconPath': 'assets/images/kua.png', 'category': 'tagihan', 'routeType': 'kua'},
    {'title': 'E-Invoicing', 'iconPath': 'assets/images/einvoicing.png', 'category': 'tagihan', 'routeType': 'einvoicing'},
    {'title': 'PGN', 'iconPath': 'assets/images/pgn.png', 'category': 'tagihan', 'routeType': 'pgn'},
    {'title': 'E-Tilang', 'iconPath': 'assets/images/etilang.png', 'category': 'tagihan', 'routeType': 'etilang'},
    {'title': 'Bayar Paspor', 'iconPath': 'assets/images/bayarpaspor.png', 'category': 'tagihan', 'routeType': 'paspor'},
    {'title': 'TV Kabel & Internet', 'iconPath': 'assets/images/tvkabelinternet.png', 'category': 'tagihan', 'routeType': 'internet'},
    {'title': 'Pajak Daerah', 'iconPath': 'assets/images/pajakdaerah.png', 'category': 'tagihan', 'routeType': 'pajakdaerah'},
    {'title': 'IPL & Properti', 'iconPath': 'assets/images/iplproperti.png', 'category': 'tagihan', 'routeType': 'properti'},
    {'title': 'Penerimaan Negara', 'iconPath': 'assets/images/penerimaannegara.png', 'category': 'tagihan', 'routeType': 'mpn'},

    // ====== FITUR DARI LAINNYA PAGE ======
    {'title': 'CGV Movies', 'iconPath': 'assets/images/movie.png', 'category': 'lainnya', 'routeType': 'movie'},
    {'title': 'Tiket Event & Hiburan', 'iconPath': 'assets/images/ticket.png', 'category': 'lainnya', 'routeType': 'ticket'},
    {'title': 'Emas', 'iconPath': 'assets/images/gold.png', 'category': 'lainnya', 'routeType': 'emas'},
    {'title': 'Donasi', 'iconPath': 'assets/images/donation.png', 'category': 'lainnya', 'routeType': 'donasi'},
    {'title': 'Zakat', 'iconPath': 'assets/images/zakat.png', 'category': 'lainnya', 'routeType': 'zakat'},
    {'title': 'Wakaf', 'iconPath': 'assets/images/wakaf.png', 'category': 'lainnya', 'routeType': 'wakaf'},
    {'title': 'Fidyah', 'iconPath': 'assets/images/fidyah.png', 'category': 'lainnya', 'routeType': 'fidyah'},
    {'title': 'Bayar Ecommerce', 'iconPath': 'assets/images/ecommerce.png', 'category': 'lainnya', 'routeType': 'ecommerce'},
    {'title': 'Reksa Dana', 'iconPath': 'assets/images/mutual_fund.png', 'category': 'lainnya', 'routeType': 'reksadana'},
    {'title': 'Sedekah Santuni Anak Yatim', 'iconPath': 'assets/images/charity.png', 'category': 'lainnya', 'routeType': 'sedekah'},
  ];

  @override
  void initState() {
    super.initState();
    fetchSaldo();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    setState(() {
      _isSearching = query.isNotEmpty;
      if (_isSearching) {
        // Filter dan hapus duplikat berdasarkan title
        final seenTitles = <String>{};
        _searchResults = _allFeatures.where((feature) {
          final containsQuery = feature['title'].toLowerCase().contains(query.toLowerCase());
          final isFirstOccurrence = seenTitles.add(feature['title']);
          return containsQuery && isFirstOccurrence;
        }).toList();
      } else {
        _searchResults.clear();
      }
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _isSearching = false;
      _searchResults.clear();
      _searchFocusNode.unfocus();
    });
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

        if (!mounted) return;

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

  void _navigateToFeature(String routeType) {
    switch (routeType) {
      // Navigation dari Home Page
      case 'transfer':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const TransferBankPage()));
        break;
      case 'pulsa':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const PulsaPage()));
        break;
      case 'ewallet':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const EwalletPage()));
        break;
      case 'lainnya':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const LainnyaPage()));
        break;
      case 'tagihan':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const TagihanPage()));
        break;
      case 'tariktunai':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const TarikTunaiSatuPage()));
        break;
      case 'emoney':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const EMoneyPage()));
        break;
      case 'pdam':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const PdamPage()));
        break;
      case 'evoucher':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const VoucherPage()));
        break;
      case 'topup':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const TopUpGamePage()));
        break;
      case 'listrik':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ListrikPage()));
        break;
      case 'byu':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ByuSatuPage()));
        break;

      // Navigation dari Tagihan Page
      case 'bpjs':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const BpjsPage()));
        break;
      case 'kartukredit':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const KreditPage()));
        break;
      case 'cicilan':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const CicilanPage()));
        break;
      case 'kai':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const KaiPage()));
        break;
      case 'asuransi':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const AsuransiPage()));
        break;
      case 'pbb':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const PbbPage()));
        break;
      case 'pascabayar':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const PascabayarPage()));
        break;
      case 'snpmb':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SnpmbPage()));
        break;
      case 'samsat':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SamsatPage()));
        break;
      case 'telkom':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const TelkomPage()));
        break;
      case 'kua':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const KuaPage()));
        break;
      case 'einvoicing':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const EinvoicingPage()));
        break;
      case 'pgn':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const PgnPage()));
        break;
      case 'etilang':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const EtilangPage()));
        break;
      case 'paspor':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const PasporPage()));
        break;
      case 'internet':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const InternetPage()));
        break;
      case 'pajakdaerah':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const PajakDaerahPage()));
        break;
      case 'properti':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const Properti1Page()));
        break;
      case 'mpn':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const MpnPage()));
        break;
      case 'pendidikan':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const PendidikanPage()));
        break;

      // Navigation dari Lainnya Page
      case 'donasi':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const DonasiPage()));
        break;
      case 'reksadana':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ReksaPage()));
        break;
      case 'wakaf':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const WakafPage()));
        break;
      case 'emas':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const EmasPage()));
        break;
      case 'zakat':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ZakatPage()));
        break;

      // Default case untuk fitur yang belum diimplementasi
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fitur $routeType akan segera hadir'),
            duration: const Duration(milliseconds: 1000),
          ),
        );
        break;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
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
                            'PPOB Merah Putih',
                            style: TextStyle(fontFamily: 'Poppins',color: Colors.white, fontWeight: FontWeight.bold, fontSize: 21),
                          ),
                          Text(
                            'SATU PINTU SEMUA PEMBAYARAN',
                            style: TextStyle(fontFamily: 'Poppins',color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 9),
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
                            // Search Bar - Updated for inline search
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
                                      focusNode: _searchFocusNode,
                                      textAlignVertical: TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(left: 43, bottom: 14),
                                        hintText: 'Cari fitur',
                                        hintStyle: const TextStyle(color: Color(0xFF6C4DF4), fontSize: 14, fontWeight: FontWeight.bold),
                                        border: InputBorder.none,
                                        suffixIcon: _searchController.text.isNotEmpty
                                            ? IconButton(
                                                icon: const Icon(Icons.close, size: 20),
                                                onPressed: _clearSearch,
                                              )
                                            : null,
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

                            // TAMPILKAN HASIL PENCARIAN ATAU FITUR NORMAL
                            if (_isSearching) ...[
                              if (_searchResults.isEmpty)
                                _buildNoResults()
                              else
                                _buildSearchResults(),
                            ] else ...[
                              // TAMPILAN NORMAL (FITUR GRID)
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
                          ],
                        ),
                      ),

                      // Banner (sembunyikan saat searching)
                      if (!_isSearching) ...[
                        const SizedBox(height: 16),
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

  Widget _buildSearchResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hasil Pencarian (${_searchResults.length})',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        GridView.builder(
          padding: const EdgeInsets.only(top:20.0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            final feature = _searchResults[index];
            return _buildSearchResultItem(feature);
          },
        ),
      ],
    );
  }

  Widget _buildSearchResultItem(Map<String, dynamic> feature) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _navigateToFeature(feature['routeType']),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  feature['iconPath'],
                  width: 32,
                  height: 32,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.credit_card,
                    size: 24,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 72,
              child: Text(
                feature['title'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoResults() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Fitur tidak ditemukan',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Coba dengan kata kunci lain',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
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
    Key? key,
    required this.label,
    required this.iconPath,
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
  }) : super(key: key);

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