import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _to = 'u2';
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppState>(context);
    final chat = app.getChat(_to);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField<String>(
            value: _to,
            items: [
              DropdownMenuItem(value: 'u2', child: Text('Bob Landlord')),
              DropdownMenuItem(value: 'u3', child: Text('Clara Realtor')),
            ],
            onChanged: (v) => setState(() => _to = v ?? 'u2'),
            decoration: InputDecoration(labelText: 'Chat with'),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: chat.length,
            itemBuilder: (_, i) {
              final m = chat[i];
              final isMe = m['from'] == (app.user?.id ?? 'me');
              return ListTile(
                title: Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(color: isMe ? Colors.grey[300] : Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(8)),
                    child: Text(m['text'] ?? '', style: TextStyle(color: isMe ? Colors.black : Colors.white)),
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
              Expanded(child: TextField(controller: _controller, decoration: InputDecoration(hintText: 'Message'))),
              IconButton(
                icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
                onPressed: () {
                  if (_controller.text.trim().isEmpty) return;
                  app.sendMessage(_to, app.user?.id ?? 'me', _controller.text.trim());
                  _controller.clear();
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
