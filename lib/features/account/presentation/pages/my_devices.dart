import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeviceSession {
  final String id;
  final String deviceName;
  final String location;
  final DateTime lastActive;
  final bool isCurrentDevice;

  const DeviceSession({
    required this.id,
    required this.deviceName,
    required this.location,
    required this.lastActive,
    required this.isCurrentDevice,
  });
}

class MyDevicesPage extends StatefulWidget {
  final String name;
  final String? imageUrl;

  const MyDevicesPage({super.key, required this.name, this.imageUrl});

  @override
  State<MyDevicesPage> createState() => _MyDevicesPageState();
}

class _MyDevicesPageState extends State<MyDevicesPage> {
  List<DeviceSession> _sessions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDeviceSessions();
  }

  String _getInitials(String name) {
    List<String> nameParts = name.split(' ');
    if (nameParts.length > 1) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    }
    return nameParts[0][0].toUpperCase();
  }

  Future<void> _loadDeviceSessions() async {
    setState(() => _isLoading = true);
    try {
      // TODO: Replace with actual API call
      await Future.delayed(
        const Duration(seconds: 1),
      ); // Simulate network delay
      _sessions = [
        DeviceSession(
          id: '1',
          deviceName: 'AndroidOS-14',
          location: '',
          lastActive: DateTime.parse('2025-08-07 19:30:00'),
          isCurrentDevice: true,
        ),
      ];
    } catch (e) {
      // TODO: Handle error properly
      debugPrint('Error loading device sessions: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _terminateSession(String sessionId) async {
    try {
      // TODO: Replace with actual API call
      await Future.delayed(
        const Duration(seconds: 1),
      ); // Simulate network delay
      if (mounted) {
        setState(() {
          _sessions.removeWhere((session) => session.id == sessionId);
        });
        // Show success message
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Sesi berhasil diakhiri')));
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Gagal mengakhiri sesi')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Stack(
        children: [
          _buildHeader(context),
          _buildBody(),
          Positioned(
            top: 170,
            left: 0,
            right: 0,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color(0xFFE0E7FF),
                  backgroundImage: widget.imageUrl != null
                      ? NetworkImage(widget.imageUrl!)
                      : null,
                  child: widget.imageUrl == null
                      ? Text(
                          _getInitials(widget.name),
                          style: const TextStyle(
                            color: Color(0xFF5B5B5B),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                const SizedBox(height: 8),
                Text(
                  'Perangkat ${widget.name}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/images/backgroundtop.svg",
              fit: BoxFit.cover,
            ),
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
          const Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
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

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  Widget _buildDeviceCard({
    required String deviceName,
    required String location,
    required bool isCurrentDevice,
    required DateTime lastActive,
    VoidCallback? onTerminate,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.phone_android, size: 24, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  deviceName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF000000),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C4DF4).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'Sesi Sekarang',
                    style: TextStyle(
                      color: Color(0xFF6C4DF4),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Aktifitas Terakhir : ${_formatDateTime(lastActive)}',
              style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              'Login Pertama : 2025-08-04 19:50:00',
              style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14),
            ),
            const SizedBox(height: 4),
            const Text(
              'Via Chrome 138.0.777.111',
              style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
            ),
            const SizedBox(height: 4),
            const Text(
              'IP: 123.456.789.000',
              style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 320),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 16),
              child: Text(
                'Semua Perangkat',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_sessions.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Belum ada perangkat yang aktif',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: _sessions.map((session) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildDeviceCard(
                        deviceName: session.deviceName,
                        location: session.location,
                        lastActive: session.lastActive,
                        isCurrentDevice: session.isCurrentDevice,
                        onTerminate: session.isCurrentDevice
                            ? null
                            : () => _terminateSession(session.id),
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
