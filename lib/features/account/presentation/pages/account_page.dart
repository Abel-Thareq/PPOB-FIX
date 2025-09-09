import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ppob_app/features/account/preferensi/preferensi_page.dart';
import 'package:ppob_app/features/account/presentation/pages/profile_page.dart';
import 'package:ppob_app/features/account/presentation/pages/change_password.dart';
import 'package:ppob_app/features/account/presentation/pages/change_pin.dart';
import 'package:ppob_app/features/account/presentation/pages/my_devices.dart';
import 'package:ppob_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ppob_app/features/auth/presentation/pages/welcome_page.dart';
import 'package:ppob_app/features/account/kontak_favourite/kontakfavourite_page.dart';
import 'package:http/http.dart' as http;

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isBiometricEnabled = true;

  String? _name;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("auth_token");

      if (token == null) return;

      final response = await http.get(
        Uri.parse("${ApiService.baseUrl}/auth/profile"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final user = data["data"]?["user"];

        if (user != null && mounted) {
          setState(() {
            _name = user["name"] ?? user["full_name"] ?? "User";
            _imageUrl = null; // backend belum ada field avatar
          });
        }
      }
    } catch (e) {
      debugPrint("❌ Error fetch profile: $e");
    }
  }

  Future<void> _logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("auth_token");

      if (token != null) {
        final response = await http.post(
          Uri.parse("${ApiService.baseUrl}/auth/logout"),
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        );

        if (response.statusCode == 200) {
          debugPrint("✅ Logout sukses di backend");
        } else {
          debugPrint("⚠️ Gagal logout di backend: ${response.body}");
        }
      }

      await prefs.remove("auth_token");

      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const WelcomePage()),
          (route) => false,
        );
      }
    } catch (e) {
      debugPrint("❌ Error logout: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(top: 200),
              child: SingleChildScrollView(
                child: _buildContent(),
              ),
            ),
          ),
          Positioned(top: 0, left: 0, right: 0, child: _buildHeader()),
          Positioned(top: 115, left: 0, right: 0, child: _buildProfileCard()),
        ],
      ),
    );
  }

  /// 🔹 Header tanpa icon notifikasi & headset
  Widget _buildHeader() {
    return SizedBox(
      height: 140,
      width: double.infinity,
      child: Stack(
        children: [
          SvgPicture.asset(
            "assets/images/backgroundtop.svg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: 140,
          ),
          Column(
            children: [
              const SizedBox(height: 46),
              SizedBox(
                height: 80,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'modipay',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                      Text(
                        'SATU PINTU SEMUA PEMBAYARAN',
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 9,
                        ),
                      ),
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

  Widget _buildProfileCard() {
    final name = _name ?? "Loading...";
    final imageUrl = _imageUrl;

    const double offsetX = 30;
    const double offsetY = 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 6,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 19,
                backgroundColor: const Color(0xFFE0E7FF),
                backgroundImage:
                    imageUrl != null ? NetworkImage(imageUrl) : null,
                child: imageUrl == null
                    ? Text(
                        _getInitials(name),
                        style: const TextStyle(
                          color: Color(0xFF5B5B5B),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Transform.translate(
                  offset: const Offset(offsetX, offsetY),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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

  Widget _buildContent() {
    return Container(
      color: const Color(0xFFF8F8FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
            child: Text(
              'Pengaturan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildMenuItem(
                  icon: Icons.account_circle_outlined,
                  label: 'Profil',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()),
                    ).then((_) {
                      _fetchUserProfile();
                    });
                  },
                ),
                _buildDivider(),
                _buildMenuItem(
                  icon: Icons.lock_outline,
                  label: 'Ubah Password',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChangePasswordPage()),
                    );
                  },
                ),
                _buildDivider(),
                _buildMenuItem(
                  icon: Icons.pin_outlined,
                  label: 'Ubah PIN',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChangePINPage()),
                    );
                  },
                ),
                _buildDivider(),
                ListTile(
                  leading: const Icon(Icons.fingerprint, color: Colors.grey),
                  title: const Text('Login Fingerprint/FaceID'),
                  trailing: Switch(
                    value: isBiometricEnabled,
                    onChanged: (val) {
                      setState(() {
                        isBiometricEnabled = val;
                      });
                    },
                    activeColor: const Color(0xFF6C4DF4),
                  ),
                ),
                _buildDivider(),
                _buildMenuItem(
                  icon: Icons.devices_other,
                  label: 'Perangkat Saya',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyDevicesPage(
                          name: _name ?? "User",
                          imageUrl: _imageUrl,
                        ),
                      ),
                    );
                  },
                ),
                _buildDivider(),
                // 🔹 Modifikasi bagian Preferensi
                _buildMenuItem(
                  icon: Icons.tune,
                  label: 'Preferensi',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PreferensiPage()),
                    );
                  },
                ),
                _buildDivider(),
                _buildMenuItem(
                    icon: Icons.receipt_long, label: 'Pengaturan Struk'),
                _buildDivider(),
                _buildMenuItem(
                    icon: Icons.favorite_border,
                    label: 'Kontak Favorit',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const KontakFavouritePage()),
                      );
                    }),
                _buildDivider(),
                _buildMenuItem(
                    icon: Icons.file_upload_outlined, label: 'Ekspor Laporan'),
                _buildDivider(),
                _buildMenuItem(
                    icon: Icons.email_outlined, label: 'Notifikasi Email'),
              ],
            ),
          ),

          // Section Harga Inject Voucher
          const Padding(
            padding:
                EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
            child: Text(
              'Harga Inject Voucher',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildMenuItemWithImage(
                    imagePath: 'assets/images/injectvoucher.png',
                    label: 'Voucher Indosat'),
              ],
            ),
          ),

          // Section Tentang Kami
          const Padding(
            padding:
                EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
            child: Text(
              'Tentang Kami',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildMenuItemWithImage(
                    imagePath: 'assets/images/groupmodipay.png',
                    label: 'Group Modipay'),
                _buildDivider(),
                _buildMenuItemWithImage(
                    imagePath: 'assets/images/whatsapp.png',
                    label: 'Whatsapp Admin'),
                _buildDivider(),
                _buildMenuItemWithImage(
                    imagePath: 'assets/images/instagramlogo.png',
                    label: 'Instagram'),
              ],
            ),
          ),

          // Section Informasi
          const Padding(
            padding:
                EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
            child: Text(
              'Informasi',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildMenuItemWithImage(
                    imagePath: 'assets/images/daftarharga.png',
                    label: 'Daftar Harga'),
                _buildDivider(),
                _buildMenuItemWithImage(
                    imagePath: 'assets/images/gambardaftarharga.png',
                    label: 'Gambar Daftar Harga'),
                _buildDivider(),
                _buildMenuItemWithImage(
                    imagePath: 'assets/images/developerapi.png',
                    label: 'Developer API'),
                _buildDivider(),
                _buildMenuItemWithImage(
                    imagePath: 'assets/images/bantuan.png',
                    label: 'Bantuan'),
              ],
            ),
          ),

          Card(
            color: Colors.white,
            margin:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: _logout,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                'Versi Aplikasi 2.86.0',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 16,
      endIndent: 16,
      color: Color(0xFFE0E0E0),
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty || name == "Loading...") return "?";
    List<String> nameParts = name.trim().split(' ');
    if (nameParts.length > 1 && nameParts[1].isNotEmpty) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    }
    return nameParts[0][0].toUpperCase();
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(label),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildMenuItemWithImage({
    required String imagePath,
    required String label,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Image.asset(imagePath, width: 24, height: 24),
      title: Text(label),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
