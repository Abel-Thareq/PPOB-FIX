import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'keranjang_page.dart';

// Fungsi helper untuk mengonversi nama produk ke nama file asset
String _convertProductNameToAsset(String productName) {
  // Contoh konversi: "Cooling Pad Laptop" -> "Cooling_Pad_Laptop.png"
  String formattedName = productName.replaceAll(' ', '_');
  return 'assets/images/$formattedName.png';
}

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

// Model untuk Alamat
class Alamat {
  final String nama;
  final String nomorTelepon;
  final String alamatLengkap;
  final String daerah;
  final bool isDefault;
  final String label;

  Alamat({
    required this.nama,
    required this.nomorTelepon,
    required this.alamatLengkap,
    required this.daerah,
    this.isDefault = false,
    required this.label,
  });
}

// Halaman Pilih Daerah (Provinsi, Kabupaten, Kecamatan, Kode Pos)
class PilihDaerahPage extends StatefulWidget {
  final String? provinsiTerpilih;
  final String? kabupatenTerpilih;
  final String? kecamatanTerpilih;
  final String? kodePosTerpilih;

  const PilihDaerahPage({
    Key? key,
    this.provinsiTerpilih,
    this.kabupatenTerpilih,
    this.kecamatanTerpilih,
    this.kodePosTerpilih,
  }) : super(key: key);

  @override
  State<PilihDaerahPage> createState() => _PilihDaerahPageState();
}

class _PilihDaerahPageState extends State<PilihDaerahPage> {
  String _selectedProvinsi = 'Pillin Provinsi';
  String _selectedKabupaten = 'Pillin Kabupaten/Kota';
  String _selectedKecamatan = 'Pillin Kecamatan';
  String _selectedKodePos = 'Pillin Kode Pos';

  @override
  void initState() {
    super.initState();
    _selectedProvinsi = widget.provinsiTerpilih ?? 'Pillin Provinsi';
    _selectedKabupaten = widget.kabupatenTerpilih ?? 'Pillin Kabupaten/Kota';
    _selectedKecamatan = widget.kecamatanTerpilih ?? 'Pillin Kecamatan';
    _selectedKodePos = widget.kodePosTerpilih ?? 'Pillin Kode Pos';
  }

  void _konfirmasiPilihan() {
    if (_selectedProvinsi.startsWith('Pillin') || 
        _selectedKabupaten.startsWith('Pillin') ||
        _selectedKecamatan.startsWith('Pillin') ||
        _selectedKodePos.startsWith('Pillin')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap lengkapi semua data alamat'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Kembalikan data langsung melalui Navigator.pop
    Navigator.pop(context, {
      'provinsi': _selectedProvinsi,
      'kabupaten': _selectedKabupaten,
      'kecamatan': _selectedKecamatan,
      'kodePos': _selectedKodePos,
    });
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
          'Pilih Daerah',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Alamat
            const Text(
              'Alamat',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            // Provinsi
            _buildDaerahSection(
              'Provinsi',
              _selectedProvinsi,
              () => _pilihProvinsi(),
            ),
            const SizedBox(height: 16),
            
            // Kabupaten/Kota
            _buildDaerahSection(
              'Kabupaten/Kota',
              _selectedKabupaten,
              () => _pilihKabupaten(),
            ),
            const SizedBox(height: 16),
            
            // Kecamatan
            _buildDaerahSection(
              'Kecamatan',
              _selectedKecamatan,
              () => _pilihKecamatan(),
            ),
            const SizedBox(height: 16),
            
            // Kode Pos
            _buildDaerahSection(
              'Kode Pos',
              _selectedKodePos,
              () => _pilihKodePos(),
            ),
            const SizedBox(height: 32),

            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _konfirmasiPilihan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5938FB),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Simpan',
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
      ),
    );
  }

  Widget _buildDaerahSection(String title, String value, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: value.startsWith('Pillin') ? Colors.grey : Colors.black87,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Fungsi-fungsi untuk memilih alamat
  void _pilihProvinsi() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => PilihanListPage(
          title: 'Pilih Provinsi',
          items: [
            'Jawa Tengah',
            'DKI Jakarta',
            'Jawa Barat',
            'Jawa Timur',
            'Bali',
            'Sumatera Utara',
            'Yogyakarta',
            'Banten',
          ],
          selectedItem: _selectedProvinsi.startsWith('Pillin') ? null : _selectedProvinsi,
        ),
      ),
    );
    
    if (result != null) {
      setState(() {
        _selectedProvinsi = result;
        // Reset pilihan turunan ketika provinsi berubah
        _selectedKabupaten = 'Pillin Kabupaten/Kota';
        _selectedKecamatan = 'Pillin Kecamatan';
        _selectedKodePos = 'Pillin Kode Pos';
      });
    }
  }

  void _pilihKabupaten() async {
    if (_selectedProvinsi.startsWith('Pillin')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap pilih provinsi terlebih dahulu'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    List<String> items = [];
    if (_selectedProvinsi == 'Jawa Tengah') {
      items = [
        'Kota Magelang',
        'Kota Semarang',
        'Kota Solo',
        'Kabupaten Magelang',
        'Kabupaten Semarang',
        'Kabupaten Boyolali',
      ];
    } else if (_selectedProvinsi == 'DKI Jakarta') {
      items = [
        'Jakarta Pusat',
        'Jakarta Selatan',
        'Jakarta Barat',
        'Jakarta Timur',
        'Jakarta Utara',
      ];
    } else {
      items = [
        'Kota Contoh 1',
        'Kota Contoh 2',
        'Kabupaten Contoh 1',
        'Kabupaten Contoh 2',
      ];
    }

    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => PilihanListPage(
          title: 'Pilih Kabupaten/Kota',
          items: items,
          selectedItem: _selectedKabupaten.startsWith('Pillin') ? null : _selectedKabupaten,
        ),
      ),
    );
    
    if (result != null) {
      setState(() {
        _selectedKabupaten = result;
        // Reset pilihan turunan ketika kabupaten berubah
        _selectedKecamatan = 'Pillin Kecamatan';
        _selectedKodePos = 'Pillin Kode Pos';
      });
    }
  }

  void _pilihKecamatan() async {
    if (_selectedKabupaten.startsWith('Pillin')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap pilih kabupaten/kota terlebih dahulu'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    List<String> items = [];
    if (_selectedKabupaten == 'Kota Magelang') {
      items = [
        'Magelang Utara',
        'Magelang Selatan',
        'Magelang Tengah',
      ];
    } else if (_selectedKabupaten == 'Jakarta Pusat') {
      items = [
        'Gambir',
        'Sawah Besar',
        'Kemayoran',
        'Senen',
        'Cempaka Putih',
        'Johar Baru',
      ];
    } else {
      items = [
        'Kecamatan Contoh 1',
        'Kecamatan Contoh 2',
        'Kecamatan Contoh 3',
      ];
    }

    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => PilihanListPage(
          title: 'Pilih Kecamatan',
          items: items,
          selectedItem: _selectedKecamatan.startsWith('Pillin') ? null : _selectedKecamatan,
        ),
      ),
    );
    
    if (result != null) {
      setState(() {
        _selectedKecamatan = result;
        // Reset kode pos ketika kecamatan berubah
        _selectedKodePos = 'Pillin Kode Pos';
      });
    }
  }

  void _pilihKodePos() async {
    if (_selectedKecamatan.startsWith('Pillin')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap pilih kecamatan terlebih dahulu'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    List<String> items = [];
    if (_selectedKecamatan == 'Magelang Utara') {
      items = ['56116', '56117'];
    } else if (_selectedKecamatan == 'Gambir') {
      items = ['10110', '10120'];
    } else {
      items = ['12345', '67890', '11223', '44556'];
    }

    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => PilihanListPage(
          title: 'Pilih Kode Pos',
          items: items,
          selectedItem: _selectedKodePos.startsWith('Pillin') ? null : _selectedKodePos,
        ),
      ),
    );
    
    if (result != null) {
      setState(() {
        _selectedKodePos = result;
      });
    }
  }
}

// Halaman untuk menampilkan list pilihan
class PilihanListPage extends StatefulWidget {
  final String title;
  final List<String> items;
  final String? selectedItem;

  const PilihanListPage({
    Key? key,
    required this.title,
    required this.items,
    this.selectedItem,
  }) : super(key: key);

  @override
  State<PilihanListPage> createState() => _PilihanListPageState();
}

class _PilihanListPageState extends State<PilihanListPage> {
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
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
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          final isSelected = _selectedItem == item;

          return ListTile(
            title: Text(
              item,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? const Color(0xFF5938FB) : Colors.black87,
              ),
            ),
            trailing: isSelected
                ? Icon(
                    Icons.check_circle,
                    color: const Color(0xFF5938FB),
                  )
                : null,
            onTap: () {
              Navigator.pop(context, item);
            },
          );
        },
      ),
    );
  }
}

// Halaman Tambah Alamat dengan navigasi ke halaman Pilih Daerah
class TambahAlamatPage extends StatefulWidget {
  final Function(Alamat) onAlamatAdded;

  const TambahAlamatPage({
    Key? key,
    required this.onAlamatAdded,
  }) : super(key: key);

  @override
  State<TambahAlamatPage> createState() => _TambahAlamatPageState();
}

class _TambahAlamatPageState extends State<TambahAlamatPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nomorTeleponController = TextEditingController();
  final _alamatLengkapController = TextEditingController();
  
  // Variabel untuk menyimpan data alamat yang dipilih
  String _selectedProvinsi = 'Pillin Provinsi';
  String _selectedKabupaten = 'Pillin Kabupaten/Kota';
  String _selectedKecamatan = 'Pillin Kecamatan';
  String _selectedKodePos = 'Pillin Kode Pos';
  
  String _selectedLabel = 'Rumah';
  bool _isAlamatUtama = false;

  final List<String> _labelOptions = ['Rumah', 'Kantor', 'Kos', 'Lainnya'];

  @override
  void dispose() {
    _namaController.dispose();
    _nomorTeleponController.dispose();
    _alamatLengkapController.dispose();
    super.dispose();
  }

  // Fungsi untuk membuka halaman pemilihan daerah
  void _bukaHalamanPilihDaerah() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PilihDaerahPage(
          provinsiTerpilih: _selectedProvinsi.startsWith('Pillin') ? null : _selectedProvinsi,
          kabupatenTerpilih: _selectedKabupaten.startsWith('Pillin') ? null : _selectedKabupaten,
          kecamatanTerpilih: _selectedKecamatan.startsWith('Pillin') ? null : _selectedKecamatan,
          kodePosTerpilih: _selectedKodePos.startsWith('Pillin') ? null : _selectedKodePos,
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _selectedProvinsi = result['provinsi'] ?? 'Pillin Provinsi';
        _selectedKabupaten = result['kabupaten'] ?? 'Pillin Kabupaten/Kota';
        _selectedKecamatan = result['kecamatan'] ?? 'Pillin Kecamatan';
        _selectedKodePos = result['kodePos'] ?? 'Pillin Kode Pos';
      });
    }
  }

  // Fungsi untuk mendapatkan teks alamat lengkap
  String get _daerahText {
    if (_selectedProvinsi.startsWith('Pillin') && 
        _selectedKabupaten.startsWith('Pillin') &&
        _selectedKecamatan.startsWith('Pillin') &&
        _selectedKodePos.startsWith('Pillin')) {
      return '';
    }
    
    List<String> parts = [];
    if (!_selectedProvinsi.startsWith('Pillin')) parts.add(_selectedProvinsi);
    if (!_selectedKabupaten.startsWith('Pillin')) parts.add(_selectedKabupaten);
    if (!_selectedKecamatan.startsWith('Pillin')) parts.add(_selectedKecamatan);
    if (!_selectedKodePos.startsWith('Pillin')) parts.add('Kode Pos: ${_selectedKodePos}');
    
    return parts.join(', ');
  }

  void _simpanAlamat() {
    if (_formKey.currentState!.validate()) {
      // Validasi apakah alamat lengkap sudah dipilih
      if (_selectedProvinsi.startsWith('Pillin') || 
          _selectedKabupaten.startsWith('Pillin') ||
          _selectedKecamatan.startsWith('Pillin') ||
          _selectedKodePos.startsWith('Pillin')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Harap lengkapi semua data alamat (Provinsi, Kabupaten, Kecamatan, Kode Pos)'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final alamatBaru = Alamat(
        nama: _namaController.text,
        nomorTelepon: _nomorTeleponController.text,
        alamatLengkap: _alamatLengkapController.text,
        daerah: _daerahText,
        isDefault: _isAlamatUtama,
        label: _selectedLabel,
      );
      
      widget.onAlamatAdded(alamatBaru);
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
          'Tambah Alamat',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Alamat
              const Text(
                'Alamat',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // Nama Penerima
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Penerima',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama penerima harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Nomor Telepon
              TextFormField(
                controller: _nomorTeleponController,
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor telepon harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Button untuk memilih daerah (menggantikan TextFormField)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Provinsi, Kota, Kecamatan, Kode Pos',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: _bukaHalamanPilihDaerah,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              _daerahText.isEmpty ? 'Pilih Provinsi, Kota, Kecamatan, Kode Pos' : _daerahText,
                              style: TextStyle(
                                fontSize: 14,
                                color: _daerahText.isEmpty ? Colors.grey : Colors.black87,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey[600],
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Alamat Lengkap
              TextFormField(
                controller: _alamatLengkapController,
                decoration: InputDecoration(
                  labelText: 'Alamat Lengkap (Jalan, Nomor, RT/RW)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat lengkap harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Detail Tambahan (Blok, Patokan)
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Detail Tambahan (Blok, Patokan, dll)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 24),

              // Section Atur sebagai Alamat Utama
              const Text(
                'Atur sebagai Alamat Utama',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              // Switch untuk Alamat Utama
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Jadikan sebagai alamat utama',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    Switch(
                      value: _isAlamatUtama,
                      onChanged: (value) {
                        setState(() {
                          _isAlamatUtama = value;
                        });
                      },
                      activeColor: const Color(0xFF5938FB),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Section Tanda Sebagai
              const Text(
                'Tanda Sebagai',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              // Pilihan Label Alamat
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _labelOptions.map((label) {
                  final isSelected = _selectedLabel == label;
                  return ChoiceChip(
                    label: Text(label),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedLabel = label;
                      });
                    },
                    selectedColor: const Color(0xFF5938FB),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),

              // Tombol Simpan
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _simpanAlamat,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5938FB),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Simpan Alamat',
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
        ),
      ),
    );
  }
}

// Halaman Pilih Alamat
class PilihAlamatPage extends StatefulWidget {
  final Function(Alamat) onAlamatSelected;
  final Alamat? alamatTerpilih;

  const PilihAlamatPage({
    Key? key,
    required this.onAlamatSelected,
    this.alamatTerpilih,
  }) : super(key: key);

  @override
  State<PilihAlamatPage> createState() => _PilihAlamatPageState();
}

class _PilihAlamatPageState extends State<PilihAlamatPage> {
  late List<Alamat> _alamatList;
  Alamat? _selectedAlamat;

  @override
  void initState() {
    super.initState();

    // Data dummy alamat
    _alamatList = [
      Alamat(
        nama: 'Abel Thareq',
        nomorTelepon: '+62 853 7764 2239',
        alamatLengkap: 'Kost Abubakar Dumpoh, Jalan Kapten Suparman, RT.4/RW.7, Potrobangsan, Magelang Utara (KosPutra Abu Bakar)',
        daerah: 'MAGELANG UTARA, KOTA MAGELANG, JAWA TENGAH, ID 56116',
        isDefault: true,
        label: 'Rumah',
      ),
      Alamat(
        nama: 'Abel Thareq',
        nomorTelepon: '+62 853 7764 2239',
        alamatLengkap: 'Jl. Merdeka No. 123, RT.1/RW.2, Central Park',
        daerah: 'JAKARTA PUSAT, DKI JAKARTA, ID 10110',
        isDefault: false,
        label: 'Kantor',
      ),
      Alamat(
        nama: 'Abel Thareq',
        nomorTelepon: '+62 853 7764 2239',
        alamatLengkap: 'Apartemen Green Garden, Tower A Lantai 15, Jl. Sudirman Kav. 1',
        daerah: 'JAKARTA SELATAN, DKI JAKARTA, ID 12190',
        isDefault: false,
        label: 'Kos',
      ),
    ];

    _selectedAlamat = widget.alamatTerpilih ?? _alamatList.firstWhere((alamat) => alamat.isDefault);
  }

  void _selectAlamat(Alamat alamat) {
    setState(() {
      _selectedAlamat = alamat;
    });
  }

  void _konfirmasiPilihan() {
    if (_selectedAlamat != null) {
      widget.onAlamatSelected(_selectedAlamat!);
      Navigator.pop(context);
    }
  }

  void _tambahAlamat() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TambahAlamatPage(
          onAlamatAdded: (alamatBaru) {
            setState(() {
              _alamatList.add(alamatBaru);
              _selectedAlamat = alamatBaru;
            });
          },
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan dialog pilihan alamat
  void _showAlamatOptionsDialog(Alamat alamat) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          contentPadding: const EdgeInsets.all(0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      alamat.nama,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      alamat.nomorTelepon,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      alamat.alamatLengkap,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      alamat.daerah,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              // Divider
              Container(height: 1, color: Colors.grey[300]),
              
              // Opsi Jadikan Alamat Utama
              ListTile(
                leading: const Icon(
                  Icons.star,
                  color: Color(0xFF5938FB),
                ),
                title: const Text(
                  'Jadikan Alamat Utama',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _setAsDefaultAddress(alamat);
                },
              ),
              
              // Divider
              Container(height: 1, color: Colors.grey[300]),
              
              // Opsi Hapus Alamat
              ListTile(
                leading: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                title: const Text(
                  'Hapus Alamat',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmationDialog(alamat);
                },
              ),
              
              // Divider
              Container(height: 1, color: Colors.grey[300]),
              
              // Tombol Batalkan
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16.0),
                        bottomRight: Radius.circular(16.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Batalkan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5938FB),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Fungsi untuk mengatur alamat sebagai default
  void _setAsDefaultAddress(Alamat alamat) {
    setState(() {
      // Reset semua alamat menjadi non-default
      for (var item in _alamatList) {
        if (item == alamat) {
          // Update alamat yang dipilih menjadi default
          _alamatList[_alamatList.indexOf(item)] = Alamat(
            nama: item.nama,
            nomorTelepon: item.nomorTelepon,
            alamatLengkap: item.alamatLengkap,
            daerah: item.daerah,
            isDefault: true,
            label: item.label,
          );
        } else {
          // Set lainnya menjadi non-default
          _alamatList[_alamatList.indexOf(item)] = Alamat(
            nama: item.nama,
            nomorTelepon: item.nomorTelepon,
            alamatLengkap: item.alamatLengkap,
            daerah: item.daerah,
            isDefault: false,
            label: item.label,
          );
        }
      }
      _selectedAlamat = alamat;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${alamat.nama} diatur sebagai alamat utama'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Fungsi untuk menampilkan dialog konfirmasi hapus
  void _showDeleteConfirmationDialog(Alamat alamat) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: const Text(
            'Hapus Alamat',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Apakah Anda yakin ingin menghapus alamat ini?',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Batalkan',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteAddress(alamat);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'Hapus',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menghapus alamat
  void _deleteAddress(Alamat alamat) {
    setState(() {
      _alamatList.remove(alamat);
      // Jika alamat yang dihapus adalah yang terpilih, pilih alamat default lainnya
      if (_selectedAlamat == alamat) {
        _selectedAlamat = _alamatList.isNotEmpty ? _alamatList.first : null;
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Alamat berhasil dihapus'),
        backgroundColor: Colors.green,
      ),
    );
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
          'Pilih Alamat',
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
          // Tombol Tambah Alamat
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _tambahAlamat,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5938FB),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  'Tambah Alamat',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: _alamatList.length,
              itemBuilder: (context, index) {
                final alamat = _alamatList[index];
                final isSelected = _selectedAlamat == alamat;

                return _buildAlamatItem(alamat, isSelected);
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
                onPressed: _konfirmasiPilihan,
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

  Widget _buildAlamatItem(Alamat alamat, bool isSelected) {
    return GestureDetector(
      onLongPress: () {
        _showAlamatOptionsDialog(alamat);
      },
      child: Card(
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
          onTap: () => _selectAlamat(alamat),
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
                      alamat.nama,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            alamat.label,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (alamat.isDefault) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF5938FB).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Default',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF5938FB),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  alamat.nomorTelepon,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  alamat.alamatLengkap,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  alamat.daerah,
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
      ),
    );
  }
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
                    color: _transferBankExpanded ? Colors.white : Colors.grey[100],
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
                          padding: const EdgeInsets.only(left: 25.0, bottom: 10.0),
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
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF5938FB)),
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
        color: isSelected ? Colors.blue[50] : null,
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

// Model untuk Voucher
class Voucher {
  final String title;
  final String subtitle;
  final String voucherType;
  final String expiry;
  final String image;
  final int discountAmount;
  bool isSelected;

  Voucher({
    required this.title,
    required this.subtitle,
    required this.voucherType,
    required this.expiry,
    required this.image,
    required this.discountAmount,
    this.isSelected = false,
  });
}

// Checkout Page (Updated untuk menerima multiple items dari keranjang)
class CheckoutPage extends StatefulWidget {
  final List<KeranjangItem> keranjangItems;

  const CheckoutPage({
    Key? key,
    required this.keranjangItems,
  }) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _pesanUntukPenjual = '';
  OpsiPengiriman? _opsiPengirimanTerpilih;
  MetodePembayaran? _metodePembayaranTerpilih;
  OpsiBank? _selectedBank;
  int _subtotalPengiriman = 5000;
  int _totalDiskonPengiriman = 5000;

  List<Voucher> _vouchers = [
    Voucher(
      title: 'Diskon Rp5K',
      subtitle: 'Min. Blj Rp50K',
      voucherType: 'Voucher Pembelian Pertama',
      expiry: 'Terpakai 84% s/d 30.09.2025 S&K',
      image: 'assets/images/iconmodipay.png',
      discountAmount: 5000,
    ),
    Voucher(
      title: 'Diskon Rp6K',
      subtitle: 'Min. Blj Rp150K',
      voucherType: 'Produk Tertentu',
      expiry: 'Terpakai 90% s/d 30.09.2025 S&K',
      image: 'assets/images/iconmodipay.png',
      discountAmount: 6000,
    ),
  ];

  Voucher? _selectedVoucher;
  Alamat? _selectedAlamat;

  ValueNotifier<Voucher?> _selectedVoucherNotifier = ValueNotifier<Voucher?>(null);

  // Menghitung total harga semua produk
  int get _subtotalPesanan {
    int total = 0;
    for (var item in widget.keranjangItems) {
      final String cleanString = item.harga.replaceAll(RegExp(r'[Rp\s\.]'), '');
      final int itemPrice = int.parse(cleanString);
      total += itemPrice * item.quantity;
    }
    return total;
  }

  int get _totalPembayaran {
    final biayaLayanan = 1900;
    final voucherDiskon = _selectedVoucher?.discountAmount ?? 0;

    return _subtotalPesanan + _subtotalPengiriman + biayaLayanan - _totalDiskonPengiriman - voucherDiskon;
  }

  @override
  void initState() {
    super.initState();
    
    _selectedAlamat = Alamat(
      nama: 'Abel Thareq',
      nomorTelepon: '+62 853 7764 2239',
      alamatLengkap: 'Kost Abubakar Dumpoh, Jalan Kapten Suparman, RT.4/RW.7, Potrobangsan, Magelang Utara (KosPutra Abu Bakar)',
      daerah: 'MAGELANG UTARA, KOTA MAGELANG, JAWA TENGAH, ID 56116',
      isDefault: true,
      label: 'Rumah',
    );
  }

  void _handleAlamatSelected(Alamat alamat) {
    setState(() {
      _selectedAlamat = alamat;
    });
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

  Future<void> _showVoucherDialog(BuildContext context) async {
    Voucher? tempSelectedVoucher = _selectedVoucher;

    final result = await showDialog<Voucher?>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              contentPadding: const EdgeInsets.all(16.0),
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: AutoSizeText(
                                  'Voucher Acome Official Shop',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  Navigator.of(context).pop(tempSelectedVoucher);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Masukkan Kode Voucher Toko',
                              suffixText: 'Pakai',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Column(
                            children: _vouchers.map((voucher) {
                              final isSelected = tempSelectedVoucher?.title == voucher.title;
                              return _buildVoucherItem(
                                voucher, 
                                isSelected,
                                onTap: () {
                                  setState(() {
                                    tempSelectedVoucher = voucher;
                                  });
                                }
                              );
                            }).toList(),
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
                              Navigator.of(context).pop(tempSelectedVoucher);
                            },
                            child: const Text(
                              'Konfirmasi',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );

    if (result != null && mounted) {
      setState(() {
        _selectedVoucher = result;
      });
    }
  }

  Widget _buildVoucherItem(Voucher voucher, bool isSelected, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              voucher.image,
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    voucher.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AutoSizeText(
                    voucher.subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.purple[100],
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: AutoSizeText(
                      voucher.voucherType,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.purple,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AutoSizeText(
                    voucher.expiry,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: isSelected
                ? Icon(
                    Icons.check_circle, 
                    color: const Color(0xFF5938FB),
                    size: 24,
                  )
                : null,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showPesanDialog(BuildContext context) async {
    String tempPesan = _pesanUntukPenjual;

    final result = await showDialog<String>(
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
                          Navigator.of(context).pop(tempPesan);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: tempPesan,
                    decoration: InputDecoration(
                      hintText: 'Tinggalkan Pesan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    maxLines: 3,
                    onChanged: (value) {
                      tempPesan = value;
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
                      Navigator.of(context).pop(tempPesan);
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

    if (result != null && mounted) {
      setState(() {
        _pesanUntukPenjual = result;
      });
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Alamat Pengiriman',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PilihAlamatPage(
                                    onAlamatSelected: _handleAlamatSelected,
                                    alamatTerpilih: _selectedAlamat,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF5938FB),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Ubah',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.purple,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _selectedAlamat?.nama ?? 'Abel Thareq',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      _selectedAlamat?.nomorTelepon ?? '+62 853 7764 2239',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _selectedAlamat?.alamatLengkap ?? 'Kost Abubakar Dumpoh, Jalan Kapten Suparman, RT.4/RW.7, Potrobangsan, Magelang Utara (KosPutra Abu Bakar)',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _selectedAlamat?.daerah ?? 'MAGELANG UTARA, KOTA MAGELANG, JAWA TENGAH, ID 56116',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                if (_selectedAlamat?.label != null) ...[
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      _selectedAlamat!.label,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.blue[700],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Product Information Box - Menampilkan semua produk dari keranjang
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
                        'Produk Dipesan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...widget.keranjangItems.map((item) {
                        return _buildProductItem(item);
                      }).toList(),
                    ],
                  ),
                ),
              ),

              // Container utama yang menggabungkan section
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
                        _showVoucherDialog(context);
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
                            Row(
                              children: [
                                if (_selectedVoucher != null)
                                  Text(
                                    _selectedVoucher!.title,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: const Color(0xFF5938FB),
                                      fontWeight: FontWeight.w500,
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
                            'Total ${widget.keranjangItems.length} Produk',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            'Rp$_subtotalPesanan',
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

              // Box Metode Pembayaran
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        if (_selectedBank != null && _metodePembayaranTerpilih?.nama == 'Transfer Bank')
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 9.0),
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

                      _buildPaymentRow('Subtotal Pesanan', 'Rp$_subtotalPesanan'),
                      _buildPaymentRow('Subtotal Pengiriman', 'Rp$_subtotalPengiriman'),
                      _buildPaymentRow('Biaya Layanan', 'Rp1.900'),
                      _buildPaymentRow('Total Diskon Pengiriman', '-Rp$_totalDiskonPengiriman',
                          isDiscount: true),
                      _buildPaymentRow('Voucher Diskon', '-Rp${_selectedVoucher?.discountAmount ?? 0}',
                          isDiscount: true),

                      const SizedBox(height: 8),
                      Container(height: 1, color: Colors.grey[300]),
                      const SizedBox(height: 8),

                      _buildPaymentRow(
                        'Total Pembayaran',
                        'Rp$_totalPembayaran',
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
                        'Rp$_totalPembayaran',
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
                        'Hemat Rp${8000 + _totalDiskonPengiriman + (_selectedVoucher?.discountAmount ?? 0)}',
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

  Widget _buildProductItem(KeranjangItem item) {
    String productImage = _convertProductNameToAsset(item.nama);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              productImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.nama,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.ukuran ?? ''}${item.ukuran != null && item.model != null ? ', ' : ''}${item.model ?? ''}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.harga,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5938FB),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'x${item.quantity}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
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
}