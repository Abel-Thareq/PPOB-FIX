import 'package:flutter/material.dart';
import 'notification_data.dart'; // Mengimpor file data notifikasi

class NotifApp extends StatelessWidget {
  const NotifApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F0F0),
        body: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 140,
                  child: Image.asset(
                    'assets/images/header.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 36.0, left: 30.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios,
                              color: Colors.white, size: 24),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 1),
            const Padding(
              padding: EdgeInsets.only(top: 6.0, left: 16.0, right: 16.0),
              child: TabBar(
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(text: 'Hari ini'),
                  Tab(text: 'Berita'),
                  Tab(text: 'Arsip'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _TodayNotifications(),
                  _NewsNotifications(),
                  _ArchiveNotifications(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper function untuk mengkonversi string timestamp menjadi nilai yang bisa dibandingkan (dalam menit)
// Nilai yang lebih kecil menunjukkan waktu yang lebih baru
int _getTimestampValue(String timestamp) {
  final parts = timestamp.split(' ');
  if (parts.length < 2) return 999999; // Nilai default jika format tidak valid

  final int value = int.tryParse(parts[0]) ?? 999999;
  final String unit = parts[1].toLowerCase();

  switch (unit) {
    case 'detik':
      return value ~/ 60; // Konversi detik ke menit
    case 'menit':
      return value;
    case 'jam':
      return value * 60;
    case 'hari':
      return value * 60 * 24;
    case 'bulan':
      return value * 60 * 24 * 30;
    case 'tahun':
      return value * 60 * 24 * 365;
    default:
      return 999999;
  }
}

// Widget untuk tab "Hari ini" dengan notifikasi yang sudah disortir
class _TodayNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Memfilter notifikasi dari semua daftar yang berumur "detik", "menit", atau "jam" yang lalu
    final List<NotificationData> todayNotifications = allNotifications.where((notif) {
      final String lowerTimestamp = notif.timestamp.toLowerCase();
      return lowerTimestamp.contains('detik') ||
          lowerTimestamp.contains('menit') ||
          lowerTimestamp.contains('jam');
    }).toList();

    // Mengurutkan notifikasi dari yang terbaru ke terlama
    todayNotifications.sort((a, b) => _getTimestampValue(a.timestamp).compareTo(_getTimestampValue(b.timestamp)));

    // Membangun daftar widget notifikasi dengan pemisah
    final List<Widget> notificationWidgets = [];
    for (int i = 0; i < todayNotifications.length; i++) {
      notificationWidgets.add(
        _NotificationItem(
          title: todayNotifications[i].title,
          timestamp: todayNotifications[i].timestamp,
          description: todayNotifications[i].description,
        ),
      );
      // Tambahkan Divider setelah setiap item, kecuali yang terakhir
      if (i < todayNotifications.length - 1) {
        notificationWidgets.add(
          const Divider(
            height: 1.0,
            thickness: 1.0,
            color: Color(0xFFE0E0E0),
          ),
        );
      }
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Widget Center untuk memusatkan teks dengan jumlah notifikasi yang dinamis
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Text(
                "${todayNotifications.length} Notifikasi Baru",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
          ...notificationWidgets,
        ],
      ),
    );
  }
}

// Widget untuk tab Berita dengan notifikasi yang sudah disortir
class _NewsNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mengurutkan notifikasi berita dari yang terbaru ke terlama
    newsNotifications.sort((a, b) => _getTimestampValue(a.timestamp).compareTo(_getTimestampValue(b.timestamp)));

    final List<Widget> newsWidgets = [];
    for (int i = 0; i < newsNotifications.length; i++) {
      newsWidgets.add(
        _NotificationItem(
          title: newsNotifications[i].title,
          timestamp: newsNotifications[i].timestamp,
          description: newsNotifications[i].description,
        ),
      );
      if (i < newsNotifications.length - 1) {
        newsWidgets.add(
          const Divider(
            height: 1.0,
            thickness: 1.0,
            color: Color(0xFFE0E0E0),
          ),
        );
      }
    }
    return SingleChildScrollView(
      child: Column(
        children: newsWidgets,
      ),
    );
  }
}

// Widget untuk tab Arsip dengan notifikasi yang sudah disortir
class _ArchiveNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mengurutkan notifikasi arsip dari yang terbaru ke terlama
    archiveNotifications.sort((a, b) => _getTimestampValue(a.timestamp).compareTo(_getTimestampValue(b.timestamp)));

    final List<Widget> archiveWidgets = [];
    for (int i = 0; i < archiveNotifications.length; i++) {
      archiveWidgets.add(
        _NotificationItem(
          title: archiveNotifications[i].title,
          timestamp: archiveNotifications[i].timestamp,
          description: archiveNotifications[i].description,
        ),
      );
      if (i < archiveNotifications.length - 1) {
        archiveWidgets.add(
          const Divider(
            height: 1.0,
            thickness: 1.0,
            color: Color(0xFFE0E0E0),
          ),
        );
      }
    }
    return SingleChildScrollView(
      child: Column(
        children: archiveWidgets,
      ),
    );
  }
}

// Widget untuk setiap item notifikasi yang bisa di-expand
class _NotificationItem extends StatefulWidget {
  final String title;
  final String timestamp;
  final String description;

  const _NotificationItem({
    required this.title,
    required this.timestamp,
    required this.description,
  });

  @override
  State<_NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<_NotificationItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.timestamp,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            if (_isExpanded) ...[
              const SizedBox(height: 8),
              Text(
                widget.description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
