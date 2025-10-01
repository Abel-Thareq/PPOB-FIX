import 'package:flutter/material.dart';
import 'checkout_page.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({Key? key}) : super(key: key);

  // Daftar produk di keranjang (sementara)
  static List<KeranjangItem> _keranjangItems = [];

  // Getter statis untuk mengakses daftar keranjang
  static List<KeranjangItem> get keranjangItems => _keranjangItems;

  // Method untuk menambahkan item ke keranjang
  static void tambahItem(KeranjangItem item) {
    _keranjangItems.add(item);
  }

  // Method untuk menghapus item dari keranjang
  static void hapusItem(int index) {
    _keranjangItems.removeAt(index);
  }

  // Method untuk update quantity
  static void updateQuantity(int index, int newQuantity) {
    _keranjangItems[index] = KeranjangItem(
      nama: _keranjangItems[index].nama,
      harga: _keranjangItems[index].harga,
      quantity: newQuantity,
      model: _keranjangItems[index].model,
      ukuran: _keranjangItems[index].ukuran,
    );
  }

  // Method untuk mendapatkan total harga semua item yang dipilih
  static double getTotalHarga(List<bool> selectedItems) {
    double totalHarga = 0;
    for (int i = 0; i < _keranjangItems.length; i++) {
      if (i < selectedItems.length && selectedItems[i]) {
        final item = _keranjangItems[i];
        final hargaNumerik = double.parse(item.harga.replaceAll('Rp', '').replaceAll('.', '').replaceAll(' ', ''));
        totalHarga += hargaNumerik * item.quantity;
      }
    }
    return totalHarga;
  }

  // Method untuk mendapatkan item yang dipilih
  static List<KeranjangItem> getSelectedItems(List<bool> selectedItems) {
    List<KeranjangItem> selected = [];
    for (int i = 0; i < _keranjangItems.length; i++) {
      if (i < selectedItems.length && selectedItems[i]) {
        selected.add(_keranjangItems[i]);
      }
    }
    return selected;
  }

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  List<bool> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    // Initialize semua item sebagai terpilih
    _selectedItems = List<bool>.generate(
      KeranjangPage.keranjangItems.length,
      (index) => true,
    );
  }

  void _navigateToCheckout() {
    final selectedItems = KeranjangPage.getSelectedItems(_selectedItems);
    
    if (selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih minimal 1 produk untuk checkout'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(
          keranjangItems: selectedItems,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalHarga = KeranjangPage.getTotalHarga(_selectedItems);
    double hemat = 8000; // Nilai hemat tetap

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5938FB),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Keranjang',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.grey[200], // Warna latar belakang abu-abu muda
        child: Column(
          children: [
            Expanded(
              child: KeranjangPage.keranjangItems.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Keranjang Anda kosong',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: KeranjangPage.keranjangItems.length,
                      itemBuilder: (context, index) {
                        return _buildKeranjangItem(KeranjangPage.keranjangItems[index], index);
                      },
                    ),
            ),
            if (KeranjangPage.keranjangItems.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Rp${totalHarga.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Hemat',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'Rp${hemat.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _navigateToCheckout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5938FB),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Center(
                          child: Text(
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
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeranjangItem(KeranjangItem item, int index) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Checkbox
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedItems[index] = !_selectedItems[index];
                });
              },
              child: Icon(
                _selectedItems[index] ? Icons.check_circle : Icons.radio_button_unchecked,
                color: _selectedItems[index] ? const Color(0xFF5938FB) : Colors.grey,
                size: 24,
              ),
            ),
            const SizedBox(width: 8),
            // Gambar Produk
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: _buildProductImage(item.nama),
            ),
            const SizedBox(width: 8),
            // Informasi Produk
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
                    item.harga,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5938FB),
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (item.model != null)
                    Text(
                      'Model: ${item.model}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  if (item.ukuran != null)
                    Text(
                      'Ukuran: ${item.ukuran}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 18),
                              onPressed: () {
                                if (item.quantity > 1) {
                                  setState(() {
                                    KeranjangPage.updateQuantity(index, item.quantity - 1);
                                  });
                                } else {
                                  // Hapus item jika quantity 0
                                  setState(() {
                                    KeranjangPage.hapusItem(index);
                                    _selectedItems.removeAt(index);
                                  });
                                }
                              },
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            Container(
                              width: 30,
                              child: Center(
                                child: Text(
                                  item.quantity.toString(),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, size: 18),
                              onPressed: () {
                                setState(() {
                                  KeranjangPage.updateQuantity(index, item.quantity + 1);
                                });
                              },
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            KeranjangPage.hapusItem(index);
                            _selectedItems.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(String productName) {
    // Format nama produk untuk dijadikan nama file
    String formattedName = productName
        .replaceAll(' ', '_')
        .replaceAll(RegExp(r'[^\w_]'), ''); // Hapus karakter khusus
    
    String imagePath = 'assets/images/$formattedName.png';
    
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        // Jika gambar tidak ditemukan, tampilkan placeholder
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.shopping_bag_outlined,
            color: Colors.grey,
            size: 40,
          ),
        );
      },
    );
  }
}

// Model untuk item keranjang
class KeranjangItem {
  final String nama;
  final String harga;
  final int quantity;
  final String? model;
  final String? ukuran;

  KeranjangItem({
    required this.nama,
    required this.harga,
    this.quantity = 1,
    this.model,
    this.ukuran,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is KeranjangItem &&
        other.nama == nama &&
        other.harga == harga &&
        other.model == model &&
        other.ukuran == ukuran;
  }

  @override
  int get hashCode {
    return Object.hash(nama, harga, model, ukuran);
  }
}