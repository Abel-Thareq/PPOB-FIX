import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'checkout_page.dart';

class DetailShopPage extends StatefulWidget {
  final String title;
  final String price;
  final String originalPrice;
  final String rating;
  final String sales;
  final String weight;
  final String stock;
  final String mainImage;

  const DetailShopPage({
    super.key,
    this.title = 'Cooling Pad Laptop',
    this.price = 'Rp. 25.000',
    this.originalPrice = 'Rp. 40.000',
    this.rating = '5.0',
    this.sales = '2rb+ terjual',
    this.weight = '0.5 kg',
    this.stock = '100',
    required this.mainImage,
  });

  @override
  State<DetailShopPage> createState() => _DetailShopPageState();
}

class _DetailShopPageState extends State<DetailShopPage> {
  int selectedImageIndex = 0;
  List<String> productImages = [];

  @override
  void initState() {
    super.initState();
    _loadProductImages();
  }

  // Fungsi untuk memuat gambar produk yang tersedia
  Future<void> _loadProductImages() async {
    final List<String> availableImages = [];
    
    // Selalu tambahkan gambar utama
    availableImages.add(widget.mainImage);
    
    // Cek gambar tambahan (1-5)
    for (int i = 1; i <= 5; i++) {
      final imagePath = _getImageVariantPath(widget.mainImage, i);
      final exists = await _checkImageExists(imagePath);
      if (exists) {
        availableImages.add(imagePath);
      }
    }
    
    setState(() {
      productImages = availableImages;
    });
  }

  // Fungsi untuk mendapatkan path variasi gambar
  String _getImageVariantPath(String mainImage, int variant) {
    final fileName = mainImage.split('/').last;
    final nameWithoutExtension = fileName.split('.').first;
    final extension = fileName.split('.').last;
    
    // Cek jika nama file sudah mengandung angka di akhir
    final regex = RegExp(r'(\d+)$');
    final match = regex.firstMatch(nameWithoutExtension);
    
    if (match != null) {
      // Jika sudah ada angka, ganti angka tersebut
      final baseName = nameWithoutExtension.substring(0, match.start);
      return 'assets/images/${baseName}$variant.$extension';
    } else {
      // Jika belum ada angka, tambahkan angka
      return 'assets/images/${nameWithoutExtension}$variant.$extension';
    }
  }

  // Fungsi untuk mengecek apakah gambar tersedia di assets
  Future<bool> _checkImageExists(String imagePath) async {
    try {
      await rootBundle.load(imagePath);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.share_outlined,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () {},
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Section
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  // Main Image
                  Container(
                    height: 220,
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: productImages.isEmpty
                          ? const CircularProgressIndicator()
                          : Hero(
                              tag: 'product-image-$selectedImageIndex',
                              child: Image.asset(
                                productImages[selectedImageIndex],
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  print('Error loading image: $error');
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                    ),
                  ),
                  
                  // Thumbnail Images (hanya ditampilkan jika ada lebih dari 1 gambar)
                  if (productImages.length > 1)
                    Container(
                      height: 80,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productImages.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedImageIndex = index;
                              });
                            },
                            child: Container(
                              width: 70,
                              height: 70,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: index == selectedImageIndex
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey[300]!,
                                  width: index == selectedImageIndex ? 2 : 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: Image.asset(
                                  productImages[index],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    print('Error loading thumbnail: $error');
                                    return const Icon(Icons.error);
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            
            // Product Info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        widget.price,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.originalPrice,
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber[800],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.rating,
                              style: TextStyle(
                                color: Colors.amber[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.sales,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Berat : ${widget.weight}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Stok : ${widget.stock}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            
            // Description
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Deskripsi',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Detail Produk:\n'
                    '• Cooling Pad Kipas Pendingin Laptop\n'
                    '• Koneksi: USB - Mendukung semua laptop\n'
                    '• Kipas: Ultra quiet fan dengan LED biru\n'
                    '• Desain: Ringkas, ringan, dan ergonomis\n'
                    '• Kemiringan dapat diatur untuk kenyamanan\n'
                    '• Cocok untuk: Gaming, kerja, dan aktivitas laptop lainnya',
                    style: TextStyle(color: Colors.grey[800], height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Keranjang Button
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      '+ Keranjang',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Beli Sekarang Button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutPage(
                          productTitle: widget.title,
                          productPrice: widget.price.replaceAll('Rp. ', 'Rp'),
                          productSize: 'S',
                          productColor: 'Hitam',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5938FB),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Beli Sekarang',
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