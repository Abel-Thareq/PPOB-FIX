import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'pendidikan2_page.dart';
import '../../models/saved_transaction.dart';
import '../../services/saved_transaction_service.dart';

class PendidikanPage extends StatefulWidget {
  const PendidikanPage({super.key});

  @override
  State<PendidikanPage> createState() => _PendidikanPageState();
}

class _PendidikanPageState extends State<PendidikanPage> {
  final _transactionService = SavedTransactionService();
  List<SavedTransaction> _transactions = [];
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID');
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final transactions = await _transactionService.getSavedTransactions();
    setState(() {
      _transactions = transactions;
    });
  }

  List<SavedTransaction> get _filteredTransactions {
    if (_searchQuery.isEmpty) return _transactions;
    return _transactions
        .where(
          (transaction) =>
              transaction.name.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              transaction.customerNumber.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ),
        )
        .toList();
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Stack(
        children: [
          SvgPicture.asset(
            "assets/images/backgroundtop.svg",
            fit: BoxFit.cover,
            width: double.infinity,
          ),
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
    );
  }

  Widget _buildRecentTransactionItem(SavedTransaction transaction) {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        // Mengubah Column menjadi Row
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/ut.png',
              width: 34,
              height: 34,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8), // Memberikan jarak antara logo dan teks
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.name.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D2D2D),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  transaction.customerNumber,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 8,
                    color: Color(0xFF6C4DF6),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedTransactionItem(SavedTransaction transaction) {
    return Dismissible(
      key: Key(transaction.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Konfirmasi Hapus'),
                content: Text(
                  'Apakah Anda yakin ingin menghapus transaksi "${transaction.name}"?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text(
                      'Hapus',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ) ??
            false;
      },
      onDismissed: (direction) async {
        await _transactionService.deleteTransaction(transaction.id);
        _loadTransactions();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${transaction.name} telah dihapus'),
              action: SnackBarAction(label: 'Tutup', onPressed: () {}),
            ),
          );
        }
      },
      background: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete, color: Colors.white),
            SizedBox(height: 4),
            Text(
              'Hapus',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/ut.png',
                  width: 34,
                  height: 34,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.name.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      transaction.customerNumber,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                        color: Color(0xFF6C4DF6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Pembayaran Terakhir Section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: const Text(
              "Pembayaran Terakhir",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D2D2D),
              ),
            ),
          ),
          if (_transactions.isNotEmpty)
            SizedBox(
              height: 60,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: _transactions
                      .map(
                        (transaction) =>
                            _buildRecentTransactionItem(transaction),
                      )
                      .toList(),
                ),
              ),
            )
          else
            const Center(
              child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: 24),
              child: Column(
              children: [
                Text(
                "Kamu belum pernah melakukan transaksi.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
                ),
                Text(
                "Yuk mulai transaksimu sekarang.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
                ),
              ],
              ),
              ),
            ),

          // Daftar Tersimpan Section
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Daftar Tersimpan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Pendidikan2Page(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 18,
                    color: Color(0xFF6C4DF6),
                  ),
                  label: const Text(
                    "Tambah",
                    style: TextStyle(
                      color: Color(0xFF6C4DF6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search Bar
          Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                hintText: "Cari nama disini",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),

          // Daftar Tersimpan List
          ..._filteredTransactions
              .map((transaction) => _buildSavedTransactionItem(transaction)),
          // Tambahkan padding di bawah list
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 60), // Tambahkan margin bottom
      padding: const EdgeInsets.fromLTRB(
        16,
        8,
        16,
        8,
      ), // Kurangi padding atas dan bawah
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Pendidikan2Page()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C4DF6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "Tambah Transaksi Baru",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Column(
        children: [_buildHeader(), _buildContent(), _buildAddButton()],
      ),
    );
  }
}
