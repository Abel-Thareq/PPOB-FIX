// Model data untuk notifikasi
class NotificationData {
  final String title;
  final String timestamp;
  final String description;

  NotificationData({
    required this.title,
    required this.timestamp,
    required this.description,
  });
}

// Daftar notifikasi untuk sub-tab "Hari Ini"
final List<NotificationData> notifications = [

];

// Daftar notifikasi untuk sub-tab "Berita" berdasarkan gambar yang diberikan
final List<NotificationData> newsNotifications = [
  NotificationData(
    title: "Top Up Shopeepay sudah stabil silahkan dilanjut kembali",
    timestamp: "4 menit yang lalu",
    description: "Deposit dapat dilakukan dengan menggunakan DANA dan QRIS, saldo masuk otomatis",
  ),
  NotificationData(
    title: "Transaksi tahan sejenak “Restock E Money”",
    timestamp: "4 jam yang lalu",
    description: "Informasi lebih lanjut akan diumumkan kemudian.",
  ),
  NotificationData(
    title: "Indosat Regular 10k Gangguan",
    timestamp: "6 jam yang lalu",
    description: "Dear pelanggan indosat pulsa reguler 10k sedang gangguan. terimakasih",
  ),
  NotificationData(
    title: "Indosat Pascabayar PLN sudah normal",
    timestamp: "8 jam yang lalu",
    description: "Layanan Indosat Pascabayar PLN telah kembali normal.",
  ),
  NotificationData(
    title: "Transaksi tahan sejenak “Restock Produk”",
    timestamp: "10 jam yang lalu",
    description: "Mohon maaf, transaksi restock produk sedang ditahan sementara karena perbaikan sistem.",
  ),
  NotificationData(
    title: "Pascabayar PLN dan PDAM Open",
    timestamp: "12 jam yang lalu",
    description: "Sekarang Anda dapat melakukan pembayaran tagihan Pascabayar PLN dan PDAM.",
  ),
  NotificationData(
    title: "PLN Pascabayar Open",
    timestamp: "14 jam yang lalu",
    description: "Layanan pembayaran tagihan Pascabayar PLN sudah tersedia.",
  ),
  NotificationData(
    title: "Informasi Layanan Pascabayar",
    timestamp: "16 jam yang lalu",
    description: "Informasi penting terkait layanan pascabayar kami. Klik untuk detail lebih lanjut.",
  ),
  NotificationData(
    title: "Top-Up Mobile Legends 100 dm berhasil masuk",
    timestamp: "13 jam yang lalu",
    description: "Informasi penting terkait layanan Top-Up kami. Klik untuk detail lebih lanjut.",
  ),
  NotificationData(
    title: "Top-Up Mobile Legends 500 dm berhasil masuk",
    timestamp: "1 hari yang lalu",
    description: "Informasi penting terkait layanan Top-Up kami. Klik untuk detail lebih lanjut.",
  ),
];

// Daftar notifikasi untuk sub-tab "Arsip" (data placeholder)
final List<NotificationData> archiveNotifications = [
  NotificationData(
    title: "Perbaikan sistem selesai",
    timestamp: "1 hari yang lalu",
    description: "Sistem kami telah kembali normal. Mohon maaf atas ketidaknyamanannya.",
  ),
  NotificationData(
    title: "Pemberitahuan: Pemeliharaan Server",
    timestamp: "3 hari yang lalu",
    description: "Telah dilakukan pemeliharaan server rutin untuk meningkatkan performa.",
  ),
  NotificationData(
    title: "Update Aplikasi Tersedia",
    timestamp: "5 hari yang lalu",
    description: "Silakan perbarui aplikasi Anda ke versi terbaru untuk fitur-fitur baru.",
  ),
];

// Menggabungkan semua notifikasi ke dalam satu daftar untuk memudahkan filter
final List<NotificationData> allNotifications = [
  ...notifications,
  ...newsNotifications,
  ...archiveNotifications,
];
