import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final double centerIconSize;

  const CustomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    this.centerIconSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double sectionWidth = screenWidth / 5;
    double targetCenterX = sectionWidth * selectedIndex + sectionWidth / 2;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween<double>(
            begin: targetCenterX,
            end: targetCenterX,
          ),
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          builder: (context, animatedCenterX, child) {
            return CustomPaint(
              size: Size(screenWidth, 70),
              painter: NavBarPainter(centerX: animatedCenterX),
            );
          },
        ),
        SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem("assets/images/navbar_shop.png", 0),
              _navItem("assets/images/navbar_mutasi.png", 1),
              _navItem("assets/images/navbar_homepage.png", 2),
              _navItem("assets/images/navbar_komunitas.png", 3),
              _navItem("assets/images/navbar_akun.png", 4),
            ],
          ),
        ),
        _buildHighlightCircle(context),
      ],
    );
  }

  Widget _navItem(String imagePath, int index) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: isSelected
          ? const SizedBox(width: 26, height: 26)
          : Image.asset(
              imagePath,
              width: 26,
              height: 26,
              color: Colors.grey,
            ),
    );
  }

  Widget _buildHighlightCircle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double sectionWidth = screenWidth / 5;
    double leftPosition = sectionWidth * selectedIndex + sectionWidth / 2 - 30;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      top: -25,
      left: leftPosition,
      child: GestureDetector(
        onTap: () => onItemTapped(selectedIndex),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  _getImageForIndex(selectedIndex),
                  width: centerIconSize,
                  height: centerIconSize,
                  fit: BoxFit.contain,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _getImageForIndex(int index) {
    switch (index) {
      case 0:
        return "assets/images/navbar_shop.png";
      case 1:
        return "assets/images/navbar_mutasi.png";
      case 3:
        return "assets/images/navbar_komunitas.png";
      case 4:
        return "assets/images/navbar_akun.png";
      default:
        return "assets/images/navbar_homepage.png";
    }
  }
}

class NavBarPainter extends CustomPainter {
  final double centerX;
  NavBarPainter({required this.centerX});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 9);

    double circleDiameter = 60;
    double notchWidth = circleDiameter * 1.8;
    double notchDepth = 32;

    final path = Path();
    path.moveTo(0, 0);

    // garis kiri sebelum cekungan
    path.lineTo(centerX - notchWidth / 2, 0);

    // transisi ke bawah
    path.quadraticBezierTo(
      centerX - notchWidth / 2 + 15, 0,
      centerX - notchWidth / 2 + 20, notchDepth - 8,
    );

    // lengkungan dasar cekungan
    path.arcToPoint(
      Offset(centerX + notchWidth / 2 - 20, notchDepth - 8),
      radius: Radius.circular(40),
      clockwise: false,
    );

    // transisi kembali ke atas
    path.quadraticBezierTo(
      centerX + notchWidth / 2 - 15, 0,
      centerX + notchWidth / 2, 0,
    );

    // garis kanan
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // Bayangan di bawah navbar
    canvas.drawPath(path.shift(const Offset(0, 2)), shadowPaint);
    // Navbar utama
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant NavBarPainter oldDelegate) =>
      oldDelegate.centerX != centerX;
}