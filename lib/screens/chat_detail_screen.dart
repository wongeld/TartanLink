import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import 'dart:async';

class ChatDetailScreen extends StatefulWidget {
  final String userId;
  final String userName;
  final String userImage;

  const ChatDetailScreen({
    required this.userId,
    required this.userName,
    required this.userImage,
  });

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final _controller = TextEditingController();
  final ScrollController _scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppState>(context);
    final chat = app.getChat(widget.userId);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) _scroll.jumpTo(_scroll.position.maxScrollExtent);
    });

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(widget.userImage),
            ),
            const SizedBox(width: 10),
            Text(widget.userName, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        elevation: 0.5,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: chat.length,
              itemBuilder: (_, i) {
                final m = chat[i];
                final isMe = m['from'] == (app.user?.id ?? 'me');

                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isMe
                          ? Colors.blueAccent.shade100.withOpacity(0.9)
                          : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(isMe ? 16 : 0),
                        bottomRight: Radius.circular(isMe ? 0 : 16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          m['text'] ?? '',
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black87,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '12:30 PM',
                          style: TextStyle(
                            color: isMe ? Colors.white70 : Colors.grey.shade500,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // message input
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      final text = _controller.text.trim();
                      if (text.isEmpty) return;

                      app.sendMessage(widget.userId, app.user?.id ?? 'me', text);
                      _controller.clear();

                      // Scroll after short delay
                      Future.delayed(const Duration(milliseconds: 50), () {
                        if (_scroll.hasClients)
                          _scroll.jumpTo(_scroll.position.maxScrollExtent);
                      });

                      // Auto-reply logic
                      _handleAutoReply(app, text);
                    },
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(Icons.send, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 🧠 Automated reply logic
  // --------------------------------------------------------------------------
  void _handleAutoReply(AppState app, String userMessage) {
    final lower = userMessage.toLowerCase();

    String reply;

    if (lower.contains('hi') || lower.contains('hello')) {
      reply = 'Hi there! Thanks for your interest in the property.';
    } else if (lower.contains('price')) {
      reply = 'The house is going for around RWF 250,000 per month';
    } else if (lower.contains('location')) {
      reply = 'It’s located about 10 minutes from CMU-Africa';
    } else if (lower.contains('furnished')) {
      reply = 'Yes! The apartment is fully furnished and ready to move in';
    } else if (lower.contains('available')) {
      reply = 'It’s currently available! Would you like to schedule a visit?';
    } else {
      reply = 'I’ll get back to you with more details soon.';
    }

    Timer(const Duration(seconds: 1), () {
      app.sendMessage(widget.userId, widget.userId, reply);
      if (_scroll.hasClients)
        _scroll.jumpTo(_scroll.position.maxScrollExtent);
    });
  }
}
