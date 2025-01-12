import 'package:flutter/material.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({Key? key}) : super(key: key);

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage(String text, {bool isBot = false}) {
    setState(() {
      _messages.insert(0, {
        'text': text,
        'isBot': isBot,
        'timestamp': DateTime.now(),
      });
    });
  }

  void _handleSendMessage() {
    final userMessage = _messageController.text.trim();
    if (userMessage.isNotEmpty) {
      _sendMessage(userMessage); // Tambahkan pesan pengguna
      _messageController.clear();

      // Simulasikan respons bot
      Future.delayed(const Duration(seconds: 1), () {
        final botResponse = _generateBotResponse(userMessage);
        _sendMessage(botResponse, isBot: true); // Tambahkan pesan bot
      });
    }
  }

  String _generateBotResponse(String userMessage) {
    // Logika sederhana untuk respons bot
    if (userMessage.toLowerCase().contains('hello')) {
      return 'Hello! I\'m Rakha. How can I assist you today?';
    } else if (userMessage.toLowerCase().contains('how are you')) {
      return 'I\'m Rakha, your bot. I\'m doing great! How about you?';
    } else if (userMessage.toLowerCase().contains('bye')) {
      return 'Goodbye! Have a wonderful day!';
    } else {
      return 'I\'m not sure how to respond to that. Could you clarify?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat with Rakha',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? const Center(
              child: Text(
                'No messages yet. Say hi to Rakha!',
                style: TextStyle(color: Colors.black),
              ),
            )
                : ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isBot = message['isBot'] as bool;

                return Align(
                  alignment:
                  isBot ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isBot
                          ? Colors.blue[50]
                          : Colors.green[50], // Warna untuk bot & user
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: isBot
                            ? const Radius.circular(0)
                            : const Radius.circular(16),
                        bottomRight: isBot
                            ? const Radius.circular(16)
                            : const Radius.circular(0),
                      ),
                    ),
                    child: Text(
                      message['text'],
                      style: TextStyle(
                        color:
                        isBot ? Colors.blue[800] : Colors.green[800],
                        fontWeight: isBot
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      filled: true,
                      fillColor: Colors.blue[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.black),
                    onPressed: _handleSendMessage,
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
