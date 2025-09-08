import 'package:flutter/material.dart';
import 'package:ppob_app/features/listrik/presentation/pages/token_listriklima.dart';

class TokenListrikEmpatPage extends StatefulWidget {
  const TokenListrikEmpatPage({super.key});

  @override
  State<TokenListrikEmpatPage> createState() => _TokenListrikEmpatPageState();
}

class _TokenListrikEmpatPageState extends State<TokenListrikEmpatPage> {
  String enteredPin = '';
  final int pinLength = 6;

  void _onNumberPressed(String number) {
    if (enteredPin.length < pinLength) {
      setState(() {
        enteredPin += number;
      });
    }
  }

  void _onDeletePressed() {
    if (enteredPin.isNotEmpty) {
      setState(() {
        enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      });
    }
  }

  void _onSubmitPressed() {
    if (enteredPin.length == pinLength) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TokenListrikLimaPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("PIN harus 6 digit"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // HEADER gambar
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 160,
                child: Image.asset(
                  'assets/images/header.png',
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.black,
                    iconSize: 28,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),
          const Text(
            "PIN Transaksi",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Silahkan Masukan PIN Anda",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30),

          // PIN kotak
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pinLength,
                  (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Container(
                  width: 40,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    border: Border.all(
                      color: index < enteredPin.length
                          ? const Color(0xFF6C4EFF)
                          : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: index < enteredPin.length
                      ? const Icon(Icons.circle,
                      size: 12, color: Color(0xFF6C4EFF))
                      : null,
                ),
              ),
            ),
          ),

          const Spacer(),

          // Keypad
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
            child: Column(
              children: [
                _buildKeypadRow(['7', '8', '9']),
                const SizedBox(height: 20),
                _buildKeypadRow(['4', '5', '6']),
                const SizedBox(height: 20),
                _buildKeypadRow(['1', '2', '3']),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDeleteButton(),
                    _buildNumberButton('0'),
                    _buildSubmitButton(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeypadRow(List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((n) => _buildNumberButton(n)).toList(),
    );
  }

  Widget _buildNumberButton(String number) {
    return InkWell(
      onTap: () => _onNumberPressed(number),
      borderRadius: BorderRadius.circular(32),
      child: Container(
        width: 64,
        height: 64,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return InkWell(
      onTap: _onDeletePressed,
      borderRadius: BorderRadius.circular(32),
      child: Container(
        width: 64,
        height: 64,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
        child: const Center(
          child: Icon(
            Icons.clear,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return InkWell(
      onTap: _onSubmitPressed,
      borderRadius: BorderRadius.circular(32),
      child: Container(
        width: 64,
        height: 64,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
        ),
        child: const Center(
          child: Icon(
            Icons.check,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
