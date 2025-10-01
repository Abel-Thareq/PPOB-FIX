import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'checkout_page.dart';
import 'keranjang_page.dart'; // Import KeranjangPage

// Model untuk data produk
class ProductModel {
  final String name;
  final String price;
  final int stock;
  final List<String> models;
  final List<String> sizes;
  int quantity;

  ProductModel({
    required this.name,
    required this.price,
    required this.stock,
    required this.models,
    required this.sizes,
    this.quantity = 1,
  });
}

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

  // Fungsi untuk menampilkan bottom sheet
  void _showProductOptionsBottomSheet(BuildContext context, bool isBuyNow) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ProductOptionsBottomSheet(
          product: ProductModel(
            name: widget.title,
            price: widget.price,
            stock: int.parse(widget.stock),
            models: ['Gede banget', 'Sedikit Kecil', 'Sedang', 'Sedikit Gede', 'Kurang Gede'],
            sizes: ['M', 'L', 'XL', 'XXL', 'XXXL'],
          ),
          isBuyNow: isBuyNow,
        );
      },
    );
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
          // Icon Keranjang dengan badge
          Stack(
            children: [
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const KeranjangPage()),
                    );
                  },
                ),
              ),
              if (KeranjangPage.keranjangItems.isNotEmpty)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      KeranjangPage.keranjangItems.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
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
                child: GestureDetector(
                  onTap: () {
                    _showProductOptionsBottomSheet(context, false);
                  },
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
              ),
              const SizedBox(width: 16),
              // Beli Sekarang Button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _showProductOptionsBottomSheet(context, true);
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

// Widget untuk bottom sheet pilihan produk
class ProductOptionsBottomSheet extends StatefulWidget {
  final ProductModel product;
  final bool isBuyNow;

  const ProductOptionsBottomSheet({
    super.key,
    required this.product,
    required this.isBuyNow,
  });

  @override
  State<ProductOptionsBottomSheet> createState() => _ProductOptionsBottomSheetState();
}

class _ProductOptionsBottomSheetState extends State<ProductOptionsBottomSheet> {
  String? _selectedModel;
  String? _selectedSize;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _selectedModel = widget.product.models.first;
    _selectedSize = widget.product.sizes.first;
    _quantity = widget.product.quantity;
  }

  void _tambahKeKeranjang(BuildContext context) {
    // Format nama produk untuk dijadikan nama file gambar
    String formattedName = widget.product.name
        .toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll(RegExp(r'[^\w_]'), '');
    
    String imagePath = 'assets/images/$formattedName.png';

    // Cek apakah item sudah ada di keranjang
    bool itemExists = KeranjangPage.keranjangItems.any((item) => 
        item.nama == widget.product.name &&
        item.model == _selectedModel &&
        item.ukuran == _selectedSize);

    if (itemExists) {
      // Jika item sudah ada, update quantity
      int existingIndex = KeranjangPage.keranjangItems.indexWhere((item) => 
          item.nama == widget.product.name &&
          item.model == _selectedModel &&
          item.ukuran == _selectedSize);
      
      if (existingIndex != -1) {
        KeranjangPage.updateQuantity(
          existingIndex, 
          KeranjangPage.keranjangItems[existingIndex].quantity + _quantity
        );
      }
    } else {
      // Jika item belum ada, tambahkan baru
      KeranjangPage.tambahItem(
        KeranjangItem(
          nama: widget.product.name,
          harga: widget.product.price,
          quantity: _quantity,
          model: _selectedModel,
          ukuran: _selectedSize,
        ),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.product.name} ditambahkan ke keranjang'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header dengan garis atas
          Container(
            width: 60,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[100],
                      ),
                      child: _buildProductImage(),
                    ),
                    const SizedBox(width: 12),
                    // Product Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.price,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5938FB),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.product.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Stok : ${widget.product.stock}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Model Section
                const Text(
                  'Model',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),

                // Model Options - Bullet Points
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < 2; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text(
                              widget.product.models[i],
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 12),

                // Model Options - Table
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                    },
                    children: [
                      TableRow(
                        children: [
                          for (int i = 2; i < 5; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedModel = widget.product.models[i];
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: _selectedModel == widget.product.models[i]
                                      ? const Color(0xFF5938FB).withOpacity(0.1)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  widget.product.models[i],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: _selectedModel == widget.product.models[i]
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: _selectedModel == widget.product.models[i]
                                        ? const Color(0xFF5938FB)
                                        : Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Ukuran Section
                const Text(
                  'Ukuran',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),

                // Size Options
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.product.sizes.map((size) {
                    final isSelected = _selectedSize == size;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedSize = size;
                        });
                    },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF5938FB)
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF5938FB)
                                : Colors.grey[300]!,
                          ),
                        ),
                        child: Text(
                          size,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 24),

                // Jumlah Section
                const Text(
                  'Jumlah',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),

                // Quantity Selector
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.remove, size: 18),
                        onPressed: () {
                          if (_quantity > 1) {
                            setState(() {
                              _quantity--;
                            });
                          }
                        },
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Center(
                        child: Text(
                          _quantity.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add, size: 18),
                        onPressed: () {
                          if (_quantity < widget.product.stock) {
                            setState(() {
                              _quantity++;
                            });
                          }
                        },
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Divider
                Container(
                  height: 1,
                  color: Colors.grey[300],
                ),

                const SizedBox(height: 16),

                // Confirm Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (widget.isBuyNow) {
                        // Navigate to checkout page dengan single item
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutPage(
                              keranjangItems: [
                                KeranjangItem(
                                  nama: widget.product.name,
                                  harga: widget.product.price,
                                  quantity: _quantity,
                                  model: _selectedModel,
                                  ukuran: _selectedSize,
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        // Add to cart logic
                        _tambahKeKeranjang(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5938FB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      widget.isBuyNow ? 'Beli Sekarang' : 'Konfirmasi',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    // Format nama produk untuk dijadikan nama file
    String formattedName = widget.product.name
        .toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll(RegExp(r'[^\w_]'), '');
    
    String imagePath = 'assets/images/$formattedName.png';
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
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
      ),
    );
  }
}