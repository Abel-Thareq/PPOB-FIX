import 'package:flutter/material.dart';

class CsPage extends StatefulWidget {
  const CsPage({super.key});

  @override
  State<CsPage> createState() => _CsPageState();
}

class _CsPageState extends State<CsPage> {
  // Controller untuk mengelola teks di dalam TextField
  final TextEditingController _textController = TextEditingController();
  // Controller untuk mengontrol posisi scroll pada chat
  final ScrollController _scrollController = ScrollController();

  // Daftar pesan yang akan ditampilkan. Setiap pesan berupa Map
  // dengan 'sender' (user/ai) dan 'text'.
  List<Map<String, String>> _messages = [
    {
      'sender': 'ai',
      'text': "Halo, mohon maaf saat ini kami sedang tidak ada ditempat."
    }
  ];

  // Fungsi untuk mengirim pesan
  void _handleSubmitted(String text) async {
    // Kosongkan teks di TextField
    _textController.clear();

    // Tambahkan pesan pengguna ke dalam daftar
    setState(() {
      _messages.add({'sender': 'user', 'text': text});
    });

    // Geser chat ke bawah agar pesan terbaru terlihat
    _scrollToBottom();

    // Simulasikan balasan dari AI setelah penundaan
    await Future.delayed(const Duration(milliseconds: 1000));
    _getAiResponse(text);
  }

  // Fungsi untuk mendapatkan balasan dari AI (disimulasikan)
  void _getAiResponse(String userText) {
    String aiResponse;
    String lowerCaseText = userText.toLowerCase();

    // Logika sederhana untuk merespons pesan pengguna
    if (lowerCaseText.contains("halo") || lowerCaseText.contains("hai")) {
      aiResponse = "Halo juga! Ada yang bisa saya bantu?";
    } else if (lowerCaseText.contains("bantu")) {
      aiResponse = "Tentu, ceritakan masalah Anda. Saya akan coba bantu.";
    } else if (lowerCaseText.contains("terima kasih") || lowerCaseText.contains("makasih")) {
      aiResponse = "Sama-sama! Senang bisa membantu.";
    } else {
      aiResponse = "Mohon maaf, saya belum bisa memahami pertanyaan Anda. Silakan berikan pertanyaan yang lebih spesifik.";
    }

    // Tambahkan balasan AI ke dalam daftar
    setState(() {
      _messages.add({'sender': 'ai', 'text': aiResponse});
    });

    // Geser chat ke bawah lagi
    _scrollToBottom();
  }

  // Fungsi untuk menggeser chat ke pesan terbaru
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Column(
        children: [
          // Header
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
                  padding: const EdgeInsets.only(top: 35.0, left: 35.0),
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

          // Area pesan chat
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.topRight : Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      color: isUser
                          ? const Color(0xFF673AB7)
                          : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0),
                        bottomLeft: isUser ? const Radius.circular(10.0) : Radius.zero,
                        bottomRight: isUser ? Radius.zero : const Radius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      message['text']!,
                      style: TextStyle(
                        fontSize: 16,
                        color: isUser ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Input field dan tombol kirim
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: TextField(
                      controller: _textController,
                      // Panggil _handleSubmitted saat tombol kirim ditekan di keyboard
                      onSubmitted: _handleSubmitted,
                      decoration: const InputDecoration(
                        hintText: "Type Here",
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                GestureDetector(
                  onTap: () {
                    if (_textController.text.isNotEmpty) {
                      _handleSubmitted(_textController.text);
                    }
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xFF673AB7),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
