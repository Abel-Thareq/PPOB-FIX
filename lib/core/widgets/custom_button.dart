import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final bool isLoading;
  final TextStyle? textStyle;
  final FontWeight? fontWeight; // Tambahkan parameter ini

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.isLoading = false,
    this.textStyle,
    this.fontWeight, // Hapus required, buat optional
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isOutlined ? Colors.transparent : const Color(0xFF5938FB),
          border: isOutlined
              ? Border.all(color: const Color(0xFF5938FB))
              : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );
    }

    // Gabungkan textStyle dengan fontWeight
    final buttonTextStyle =
        textStyle?.copyWith(
          fontWeight: fontWeight ?? textStyle?.fontWeight ?? FontWeight.w500,
        ) ??
        TextStyle(
          fontWeight: fontWeight ?? FontWeight.w500,
          fontFamily: 'Poppins',
        );

    if (isOutlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF5938FB),
          side: const BorderSide(color: Color(0xFF5938FB)),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          minimumSize: const Size(double.infinity, 48),
          textStyle: buttonTextStyle,
        ),
        child: Text(text),
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5938FB),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          minimumSize: const Size(double.infinity, 48),
          textStyle: buttonTextStyle,
        ),
        child: Text(text),
      );
    }
  }
}
