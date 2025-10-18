import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import 'chat_detail_screen.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppState>(context);

    // Placeholder: list of available chat users
    final chats = [
      {'id': 'u2', 'name': 'Bob Landlord', 'image': 'assets/profile_placeholder.png'},
      {'id': 'u3', 'name': 'Clara Realtor', 'image': 'assets/profile_placeholder.png'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        elevation: 0.5,
      ),
      backgroundColor: Colors.grey.shade100,
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, i) {
          final c = chats[i];
          final chat = app.getChat(c['id']!);
          final lastMessage = chat.isNotEmpty ? chat.last['text'] : 'No messages yet';

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              radius: 26,
              backgroundImage: AssetImage(c['image']!),
            ),
            title: Text(c['name']!, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(
              lastMessage!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '12:30 PM', // placeholder timestamp
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatDetailScreen(
                    userId: c['id']!,
                    userName: c['name']!,
                    userImage: c['image']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
