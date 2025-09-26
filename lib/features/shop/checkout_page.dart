import 'package:flutter/material.dart';

// Model untuk metode pembayaran
class MetodePembayaran {
  final String nama;
  final String icon;
  final bool isSelected;

  MetodePembayaran({
    required this.nama,
    required this.icon,
    this.isSelected = false,
  });

  MetodePembayaran copyWith({
    String? nama,
    String? icon,
    bool? isSelected,
  }) {
    return MetodePembayaran(
      nama: nama ?? this.nama,
      icon: icon ?? this.icon,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

// Model untuk opsi bank
class OpsiBank {
  final String nama;
  final String icon;

  OpsiBank({
    required this.nama,
    required this.icon,
  });
}

// Halaman Metode Pembayaran
class MetodePembayaranPage extends StatefulWidget {
  final Function(MetodePembayaran, OpsiBank?) onMetodeSelected;
  final MetodePembayaran? metodeTerpilih;
  final OpsiBank? bankTerpilih;

  const MetodePembayaranPage({
    Key? key,
    required this.onMetodeSelected,
    this.metodeTerpilih,
    this.bankTerpilih,
  }) : super(key: key);

  @override
  State<MetodePembayaranPage> createState() => _MetodePembayaranPageState();
}

class _MetodePembayaranPageState extends State<MetodePembayaranPage> {
  late List<MetodePembayaran> _metodePembayaranList;
  MetodePembayaran? _selectedMetode;
  bool _transferBankExpanded = false;
  OpsiBank? _selectedBank;

  @override
  void initState() {
    super.initState();

    // Data dummy metode pembayaran
    _metodePembayaranList = [
      MetodePembayaran(
        nama: 'COD',
        icon: 'assets/images/cod.png',
        isSelected: widget.metodeTerpilih?.nama == 'COD',
      ),
      MetodePembayaran(
        nama: 'Transfer Bank',
        icon: 'assets/images/transferbank.png',
        isSelected: widget.metodeTerpilih?.nama == 'Transfer Bank',
      ),
      MetodePembayaran(
        nama: 'Saldo Modipay',
        icon: 'assets/images/iconmodipay.png',
        isSelected: widget.metodeTerpilih?.nama == 'Saldo Modipay',
      ),
    ];

    _selectedMetode = widget.metodeTerpilih;
    _selectedBank = widget.bankTerpilih;
    if (_selectedMetode?.nama == 'Transfer Bank') {
      _transferBankExpanded = true;
    }
  }

  void _selectMetode(MetodePembayaran metode) {
    setState(() {
      _selectedMetode = metode;
      _selectedBank = null;
      if (metode.nama != 'Transfer Bank') {
        _transferBankExpanded = false;
      }
    });
  }

  void _selectBank(OpsiBank bank) {
    setState(() {
      _selectedBank = bank;
      _selectedMetode = _metodePembayaranList.firstWhere((element) => element.nama == 'Transfer Bank');
      _transferBankExpanded = false;
    });
  }

  void _konfirmasiPilihan() {
    if (_selectedMetode != null) {
      widget.onMetodeSelected(_selectedMetode!, _selectedBank);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF5938FB),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Metode Pembayaran',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // COD
                _buildMetodeItem(
                  metode: _metodePembayaranList[0],
                  isSelected: _selectedMetode?.nama == 'COD',
                  onTap: () {
                    _selectMetode(_metodePembayaranList[0]);
                  },
                ),

                // Transfer Bank
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: _transferBankExpanded ? Colors.white : Colors.grey[100], // Warna beda
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Header Transfer Bank
                      InkWell(
                        onTap: () {
                          setState(() {
                            _transferBankExpanded = !_transferBankExpanded;
                            if (_selectedMetode?.nama != 'Transfer Bank' && _transferBankExpanded) {
                              _selectMetode(_metodePembayaranList[1]);
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/transferbank.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    'Transfer Bank',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: _selectedMetode?.nama == 'Transfer Bank'
                                          ? const Color(0xFF5938FB)
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                _transferBankExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.grey[600],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Tampilan Bank yang dipilih
                       if (_selectedBank != null && _selectedMetode?.nama == 'Transfer Bank')
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Image.asset(
                                _selectedBank!.icon,
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                _selectedBank!.nama,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),

                      // Daftar Bank (Expanded)
                      if (_transferBankExpanded && _selectedMetode?.nama == 'Transfer Bank')
                        Column(
                          children: [
                            _buildBankItem(
                              'Bank BRI',
                              'assets/images/bankbri.png',
                              () {
                                _selectBank(OpsiBank(
                                    nama: 'Bank BRI',
                                    icon: 'assets/images/bankbri.png'));
                              },
                              isSelected: _selectedBank?.nama == 'Bank BRI',
                            ),
                            _buildBankItem(
                              'Bank BCA',
                              'assets/images/bankbca.png',
                              () {
                                _selectBank(OpsiBank(
                                    nama: 'Bank BCA',
                                    icon: 'assets/images/bankbca.png'));
                              },
                              isSelected: _selectedBank?.nama == 'Bank BCA',
                            ),
                            _buildBankItem(
                              'Bank Mandiri',
                              'assets/images/bankmandiri.png',
                              () {
                                _selectBank(OpsiBank(
                                    nama: 'Bank Mandiri',
                                    icon: 'assets/images/bankmandiri.png'));
                              },
                              isSelected: _selectedBank?.nama == 'Bank Mandiri',
                            ),
                            _buildBankItem(
                              'Bank BNI',
                              'assets/images/bankbni.png',
                              () {
                                _selectBank(OpsiBank(
                                    nama: 'Bank BNI',
                                    icon: 'assets/images/bankbni.png'));
                              },
                              isSelected: _selectedBank?.nama == 'Bank BNI',
                            ),
                            _buildBankItem(
                              'Bank Syariah Indonesia',
                              'assets/images/bankbsi.png',
                              () {
                                _selectBank(OpsiBank(
                                    nama: 'Bank Syariah Indonesia',
                                    icon: 'assets/images/bankbsi.png'));
                              },
                              isSelected: _selectedBank?.nama ==
                                  'Bank Syariah Indonesia',
                            ),
                            _buildBankItem(
                              'Bank Lainnya',
                              'assets/images/transferbank.png',
                              () {
                                _selectBank(OpsiBank(
                                    nama: 'Bank Lainnya',
                                    icon: 'assets/images/transferbank.png'));
                              },
                              isSelected: _selectedBank?.nama == 'Bank Lainnya',
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                // Saldo Modipay
                _buildMetodeItem(
                  metode: _metodePembayaranList[2],
                  isSelected: _selectedMetode?.nama == 'Saldo Modipay',
                  onTap: () {
                    _selectMetode(_metodePembayaranList[2]);
                  },
                ),
              ],
            ),
          ),

          // Tombol Konfirmasi
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedMetode != null ? _konfirmasiPilihan : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5938FB),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Konfirmasi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetodeItem({
    required MetodePembayaran metode,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? const Color(0xFF5938FB) : Colors.grey[300]!,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon/Emoji
              Image.asset(
                metode.icon,
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 16),

              // Nama Metode
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      metode.nama,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? const Color(0xFF5938FB) : Colors.black,
                      ),
                    ),
                    // Informasi Gratis Ongkir
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF5938FB).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Gratis Ongkir',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF5938FB),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Checkmark jika dipilih
              if (isSelected && metode.nama != 'Transfer Bank')
                Icon(
                  Icons.check_circle,
                  color: const Color(0xFF5938FB),
                  size: 24,
                ),
               if (isSelected && metode.nama == 'Transfer Bank' && _selectedBank != null)
                Icon(
                  Icons.check_circle,
                  color: const Color(0xFF5938FB),
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBankItem(String namaBank, String assetImage, VoidCallback onTap, {bool isSelected = false}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: isSelected ? Colors.blue[50] : null, // Highlight warna ketika dipilih
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    assetImage,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    namaBank,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
               if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: const Color(0xFF5938FB),
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Model untuk opsi pengiriman
class OpsiPengiriman {
  final String nama;
  final int harga;
  final int diskon;
  final String estimasi;
  final bool isSelected;

  OpsiPengiriman({
    required this.nama,
    required this.harga,
    required this.diskon,
    required this.estimasi,
    this.isSelected = false,
  });

  OpsiPengiriman copyWith({
    String? nama,
    int? harga,
    int? diskon,
    String? estimasi,
    bool? isSelected,
  }) {
    return OpsiPengiriman(
      nama: nama ?? this.nama,
      harga: harga ?? this.harga,
      diskon: diskon ?? this.diskon,
      isSelected: isSelected ?? this.isSelected,
      estimasi: estimasi ?? this.estimasi,
    );
  }
}

// Halaman Opsi Pengiriman
class OpsiPengirimanPage extends StatefulWidget {
  final Function(OpsiPengiriman) onOpsiSelected;
  final OpsiPengiriman? opsiTerpilih;

  const OpsiPengirimanPage({
    Key? key,
    required this.onOpsiSelected,
    this.opsiTerpilih,
  }) : super(key: key);

  @override
  State<OpsiPengirimanPage> createState() => _OpsiPengirimanPageState();
}

class _OpsiPengirimanPageState extends State<OpsiPengirimanPage> {
  late List<OpsiPengiriman> _opsiPengirimanList;
  OpsiPengiriman? _selectedOpsi;

  @override
  void initState() {
    super.initState();

    // Data dummy opsi pengiriman
    _opsiPengirimanList = [
      OpsiPengiriman(
        nama: 'Reguler',
        harga: 9000,
        diskon: 0,
        estimasi: 'Garansi tiba 17-18 Oktober',
        isSelected: widget.opsiTerpilih?.nama == 'Reguler',
      ),
      OpsiPengiriman(
        nama: 'Hemat Kargo',
        harga: 5000,
        diskon: 0,
        estimasi: 'Garansi tiba 17-18 Oktober',
                isSelected: widget.opsiTerpilih?.nama == 'Hemat Kargo',
      ),
      OpsiPengiriman(
        nama: 'Instant',
        harga: 12000,
        diskon: 0,
        estimasi: 'Garansi tiba 17-18 Oktober',
        isSelected: widget.opsiTerpilih?.nama == 'Instant',
      ),
    ];

    _selectedOpsi = widget.opsiTerpilih;
  }

  void _selectOpsi(OpsiPengiriman opsi) {
    setState(() {
      _selectedOpsi = opsi;
    });
  }

  void _konfirmasiPilihan() {
    if (_selectedOpsi != null) {
      widget.onOpsiSelected(_selectedOpsi!);
      Navigator.pop(context);
          }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF5938FB),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Opsi Pengiriman',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Garansi Tepat Waktu
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PILIH JASA PENGIRIMAN',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                                Row(
                  children: [
                    Icon(Icons.timer, color: Colors.green[600], size: 16),
                    const SizedBox(width: 4),
                    const Text(
                      'Garansi Tepat Waktu',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Voucher s/d Rp10.000 jika pesanan terlambat.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // List Opsi Pengiriman
          Expanded(
            child: ListView.builder(
              itemCount: _opsiPengirimanList.length,
              itemBuilder: (context, index) {
                final opsi = _opsiPengirimanList[index];
                final isSelected = _selectedOpsi?.nama == opsi.nama;

                return _buildOpsiItem(opsi, isSelected);
              },
            ),
          ),

          // Tombol Konfirmasi
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedOpsi != null ? _konfirmasiPilihan : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5938FB),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Konfirmasi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildOpsiItem(OpsiPengiriman opsi, bool isSelected) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? const Color(0xFF5938FB) : Colors.grey[300]!,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: () => _selectOpsi(opsi),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    opsi.nama,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? const Color(0xFF5938FB) : Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Rp${opsi.harga.toString()}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? const Color(0xFF5938FB) : Colors.black,
                        ),
                      ),
                      if (opsi.diskon > 0) ...[
                        const SizedBox(width: 8),
                        Text(
                          'Rp${opsi.diskon.toString()}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                opsi.estimasi,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              if (isSelected) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green[600], size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'Dipilih',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Checkout Page yang sudah direvisi
class CheckoutPage extends StatefulWidget {
  final String productTitle;
  final String productPrice;
  final String productSize;
  final String productColor;
  final OpsiBank? bankTerpilih;

  const CheckoutPage({
    Key? key,
    required this.productTitle,
    required this.productPrice,
    this.productSize = 'S',
    this.productColor = 'Hitam',
    this.bankTerpilih,
  }) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _pesanUntukPenjual = '';
  OpsiPengiriman? _opsiPengirimanTerpilih;
  MetodePembayaran? _metodePembayaranTerpilih;
  OpsiBank? _selectedBank;
  int _subtotalPengiriman = 5000; // Default harga pengiriman
  int _totalDiskonPengiriman = 5000; // Default diskon pengiriman

  // Hitung total pembayaran
  int get _totalPembayaran {
    final subtotalPesanan = 15900;
    final biayaLayanan = 1900;
    final voucherDiskon = 3000;

    return subtotalPesanan + _subtotalPengiriman + biayaLayanan - _totalDiskonPengiriman - voucherDiskon;
  }

  @override
  void initState() {
    super.initState();
    _selectedBank = widget.bankTerpilih;
  }

  void _handleOpsiPengirimanSelected(OpsiPengiriman opsi) {
    setState(() {
      _opsiPengirimanTerpilih = opsi;
      _subtotalPengiriman = opsi.harga;
      _totalDiskonPengiriman = opsi.diskon;
    });
  }

  void _handleMetodePembayaranSelected(MetodePembayaran metode, OpsiBank? bank) {
    setState(() {
      _metodePembayaranTerpilih = metode;
      _selectedBank = bank;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF5938FB),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shipping Address Box
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.purple,
                        size: 30,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Abel Thareq',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '+62 853 7764 2239',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Kost Abubakar Dumpoh, Jalan Kapten Suparman, RT.4/RW.7, Potrobangsan, Magelang Utara (KosPutra Abu Bakar)',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'MAGELANG UTARA, KOTA MAGELANG, JAWA TENGAH, ID 56116',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Product Information Box
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TOKO MAJU JAYA',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.image, color: Colors.grey),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.productTitle,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${widget.productSize}, ${widget.productColor}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  widget.productPrice,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF5938FB),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'x1',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Container utama yang menggabungkan section dari Pesan untuk Penjual hingga Total Produk
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Section 1: Pesan untuk Penjual
                    InkWell(
                      onTap: () {
                        _showPesanDialog(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Pesan untuk Penjual',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Icon(Icons.chevron_right, color: Colors.grey[600], size: 20),
                              ],
                            ),
                            if (_pesanUntukPenjual.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  _pesanUntukPenjual,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    Container(height: 1, color: Colors.grey[200]),

                    // Section 2: Voucher Toko
                    InkWell(
                      onTap: () {
                        // Aksi untuk voucher toko
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Voucher Toko',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                              ),
                            ),
                            Icon(Icons.chevron_right, color: Colors.grey[600], size: 20),
                          ],
                        ),
                      ),
                    ),

                    Container(height: 1, color: Colors.grey[200]),

                    // Section 3: Opsi Pengiriman
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OpsiPengirimanPage(
                              onOpsiSelected: _handleOpsiPengirimanSelected,
                              opsiTerpilih: _opsiPengirimanTerpilih,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Opsi Pengiriman',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                              ),
                            ),
                            Row(
                              children: [
                                if (_opsiPengirimanTerpilih != null)
                                  Text(
                                    _opsiPengirimanTerpilih!.nama,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                const SizedBox(width: 8),
                                Icon(Icons.chevron_right, color: Colors.grey[600], size: 20),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Box Hemat Kargo dengan informasi opsi yang dipilih
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF5938FB).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: const Color(0xFF5938FB).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 4,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF5938FB),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _opsiPengirimanTerpilih?.nama ?? 'Hemat Kargo',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: const Color(0xFF5938FB),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _opsiPengirimanTerpilih?.estimasi ?? 'Garansi tiba 17-18 Sep',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                                                  Text(
                            'Voucher s/d Rp10.000 jika pesanan belum tiba 18 Sep 2025',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(height: 1, color: Colors.grey[200]),

                    // Section 4: Total Produk
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total 1 Produk',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            'Rp15.900',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Box Metode Pembayaran - REVISI dengan navigasi ke halaman baru
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MetodePembayaranPage(
                          onMetodeSelected: _handleMetodePembayaranSelected,
                          metodeTerpilih: _metodePembayaranTerpilih,
                          bankTerpilih: _selectedBank,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(  // Mengubah Padding menjadi Column
                      crossAxisAlignment: CrossAxisAlignment.start, // Align kiri
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Metode Pembayaran',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  _metodePembayaranTerpilih?.nama ?? 'Saldo Modipay',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(Icons.chevron_right, color: Colors.grey[600], size: 20),
                              ],
                            ),
                          ],
                        ),
                        // Tampilan Bank yang dipilih (Jika ada)
                        if (_selectedBank != null && _metodePembayaranTerpilih?.nama == 'Transfer Bank')
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  _selectedBank!.icon,
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _selectedBank!.nama,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              // Box Rincian Pembayaran
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rincian Pembayaran',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 12),

                      _buildPaymentRow('Subtotal Pesanan', 'Rp15.900'),
                      _buildPaymentRow('Subtotal Pengiriman', 'Rp${_subtotalPengiriman}'),
                      _buildPaymentRow('Biaya Layanan', 'Rp1.900'),
                      _buildPaymentRow('Total Diskon Pengiriman', '-Rp${_totalDiskonPengiriman}',
                          isDiscount: true),
                      _buildPaymentRow('Voucher Diskon', '-Rp3.000',
                          isDiscount: true),

                      const SizedBox(height: 8),
                      Container(height: 1, color: Colors.grey[300]),
                      const SizedBox(height: 8),

                      _buildPaymentRow(
                        'Total Pembayaran',
                        'Rp${_totalPembayaran}',
                        isTotal: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Payment Section
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Rp${_totalPembayaran}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5938FB),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Hemat Rp${8000 + _totalDiskonPengiriman}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle order placement
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5938FB),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Buat Pesanan',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentRow(String label, String value,
      {bool isDiscount = false, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isDiscount ? Colors.green : Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isDiscount ? Colors.green : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk menampilkan dialog pesan
  Future<void> _showPesanDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Pesan untuk Penjual',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Tinggalkan Pesan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    maxLines: 3,
                    onChanged: (value) {
                      setState(() {
                        _pesanUntukPenjual = value;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5938FB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Buat Pesan',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}