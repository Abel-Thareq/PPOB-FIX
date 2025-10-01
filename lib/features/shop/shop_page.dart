import 'package:flutter/material.dart';
import 'package:ppob_app/features/shop/keranjang_page.dart';
import 'detailshop_page.dart';

// Model Produk
class Produk {
  final String nama;
  final String harga;
  final String originalPrice;
  final String rating;
  final String sales;
  final String image;
  final String kota;

  Produk({
    required this.nama,
    required this.harga,
    required this.originalPrice,
    required this.rating,
    required this.sales,
    required this.image,
    required this.kota,
  });
}

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  // Daftar Produk Dummy
  final List<Produk> _produkList = [
    Produk(
      nama: 'Cooling Pad Laptop',
      harga: 'Rp. 25.000',
      originalPrice: 'Rp. 40.000',
      rating: '5.0',
      sales: '20+ terjual',
      image: 'assets/images/Cooling_Pad_Laptop.png',
      kota: 'Kota Tasikmalaya',
    ),
    Produk(
      nama: 'Mouse Wireless',
      harga: 'Rp. 75.000',
      originalPrice: 'Rp. 120.000',
      rating: '4.8',
      sales: '50+ terjual',
      image: 'assets/images/Mouse_Wireless.png',
      kota: 'Kota Bandung',
    ),
    Produk(
      nama: 'Keyboard Mechanical',
      harga: 'Rp. 350.000',
      originalPrice: 'Rp. 500.000',
      rating: '4.9',
      sales: '15+ terjual',
      image: 'assets/images/Keyboard_Mechanical.png',
      kota: 'Kota Jakarta',
    ),
    Produk(
      nama: 'Webcam HD',
      harga: 'Rp. 150.000',
      originalPrice: 'Rp. 200.000',
      rating: '4.7',
      sales: '30+ terjual',
      image: 'assets/images/Webcam_HD.png',
      kota: 'Kota Surabaya',
    ),
    Produk(
      nama: 'Headphone Gaming',
      harga: 'Rp. 200.000',
      originalPrice: 'Rp. 300.000',
      rating: '4.6',
      sales: '25+ terjual',
      image: 'assets/images/Headphone_Gaming.png',
      kota: 'Kota Yogyakarta',
    ),
    Produk(
      nama: 'Laptop Stand',
      harga: 'Rp. 80.000',
      originalPrice: 'Rp. 120.000',
      rating: '4.5',
      sales: '40+ terjual',
      image: 'assets/images/Laptop_Stand.png',
      kota: 'Kota Semarang',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(color: Color(0xFF5938FB)),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // Bar Pencarian
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Cari Produk',
                              prefixIcon: const Icon(Icons.search, color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF5938FB),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.shopping_cart,
                              color: Color(0xFFFFFFFF),
                              size: 34,
                            ),
                            onPressed: () {
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const KeranjangPage()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Bagian Promo/Iklan (Card putih horizontal)
                  Container(
                    height: 140,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: List.generate(
                          5, // Jumlah card promo
                          (index) => Container(
                            width: 280, // Lebar setiap card
                            margin: EdgeInsets.only(
                              left: index == 0 ? 16 : 8,
                              right: index == 4 ? 16 : 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF5938FB).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.local_offer,
                                      color: Color(0xFF5938FB),
                                      size: 40,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Promo Spesial ${index + 1}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Diskon hingga ${(index + 1) * 10}%',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF5938FB),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: const Text(
                                            'KLIK DISINI',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bar Tab
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Terkait'),
                      Tab(text: 'Terbaru'),
                      Tab(text: 'Terlaris'),
                    ],
                    labelColor: const Color(0xFF5938FB),
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: const Color(0xFF5938FB),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Tombol Filter
                TextButton.icon(
                  onPressed: () {
                    _showFilterDialog(context);
                  },
                  icon: const Icon(Icons.filter_list, color: Colors.grey),
                  label: const Text(
                    'Filter',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),

          // Konten Utama
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Tab Terkait
                _buildContent('Terkait'),
                // Tab Terbaru
                _buildContent('Terbaru'),
                // Tab Terlaris
                _buildContent('Terlaris'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(String tabName) {
    // Filter produk berdasarkan tab (dummy logic)
    List<Produk> filteredProducts = _produkList;
    
    switch (tabName) {
      case 'Terbaru':
        filteredProducts = _produkList.sublist(0, 3);
        break;
      case 'Terlaris':
        filteredProducts = _produkList.sublist(2);
        break;
      default:
        filteredProducts = _produkList;
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Elektronik
            _buildCategorySection('Elektronik', filteredProducts),
            const SizedBox(height: 16),
            
            // Section Office & Stationery
            _buildCategorySection('Office & Stationery', filteredProducts),
            const SizedBox(height: 16),
            
            // Section Produk Offline
            _buildCategorySection('Produk Offline', filteredProducts),
            const SizedBox(height: 16),
            
            // Section Produk Digital
            _buildCategorySection('Produk Digital', filteredProducts),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(String category, List<Produk> produkList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {
                // Aksi untuk lihat semua
              },
              child: const Text(
                'Lihat Semua',
                style: TextStyle(
                  color: Color(0xFF5938FB),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        _buildProductGrid(produkList),
      ],
    );
  }

  Widget _buildProductGrid(List<Produk> produkList) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: produkList.length,
      itemBuilder: (context, index) {
        return _buildProductCard(produkList[index]);
      },
    );
  }

  Widget _buildProductCard(Produk produk) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailShopPage(
              title: produk.nama,
              price: produk.harga,
              originalPrice: produk.originalPrice,
              rating: produk.rating,
              sales: produk.sales,
              weight: '0.5 kg',
              stock: '100',
              mainImage: produk.image, // Kirim mainImage ke DetailShopPage
            ),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk dari assets
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                ),
                child: Stack(
                  children: [
                    // Gambar Produk
                    Image.asset(
                      produk.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback jika gambar tidak ditemukan
                        return Container(
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                            size: 40,
                          ),
                        );
                      },
                    ),
                    // Badge Diskon
                    if (produk.originalPrice != produk.harga)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'DISKON',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produk.nama,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 12, color: Colors.grey),
                      const SizedBox(width: 2),
                      Text(
                        produk.kota,
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 12, color: Colors.amber),
                      const SizedBox(width: 2),
                      Text(produk.rating, style: const TextStyle(fontSize: 10)),
                      const SizedBox(width: 4),
                      Text(
                        ' • ${produk.sales}',
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    produk.harga,
                    style: const TextStyle(
                      color: Color(0xFF5938FB),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  if (produk.originalPrice != produk.harga)
                    Text(
                      produk.originalPrice,
                      style: const TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 10,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Filter Produk',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF5938FB),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kategori',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                _buildFilterChip('Elektronik'),
                _buildFilterChip('Office & Stationery'),
                _buildFilterChip('Produk Offline'),
                _buildFilterChip('Produk Digital'),
                
                const SizedBox(height: 16),
                const Text(
                  'Harga',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                _buildFilterChip('Rp 0 - 50.000'),
                _buildFilterChip('Rp 50.000 - 200.000'),
                _buildFilterChip('Rp 200.000 - 500.000'),
                _buildFilterChip('Rp 500.000+'),
                
                const SizedBox(height: 16),
                const Text(
                  'Rating',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                _buildFilterChip('4.5+'),
                _buildFilterChip('4.0+'),
                _buildFilterChip('3.0+'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Reset',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Aplikasikan filter di sini
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5938FB),
              ),
              child: const Text('Terapkan'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: FilterChip(
        label: Text(label),
        selected: false,
        onSelected: (bool selected) {
          // Handle filter selection
        },
        selectedColor: const Color(0xFF5938FB).withOpacity(0.2),
        checkmarkColor: const Color(0xFF5938FB),
        labelStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 14,
        ),
      ),
    );
  }
}