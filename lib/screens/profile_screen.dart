import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AppState>(context, listen: false).user;
    _nameCtrl = TextEditingController(text: user?.name ?? '');
    _emailCtrl = TextEditingController(text: user?.email ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppState>(context);
    final user = app.user;
    if (user == null) return Center(child: Text('No user'));

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(radius: 36, backgroundColor: Theme.of(context).primaryColor, child: Text(user.name.substring(0,1).toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 24))),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                        SizedBox(height: 6),
                        Text(user.email, style: TextStyle(color: Colors.grey[700])),
                        SizedBox(height: 8),
                        Chip(label: Text(user.role.toString().split('.').last.toUpperCase())),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Edit profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  SizedBox(height: 12),
                  TextField(controller: _nameCtrl, decoration: InputDecoration(labelText: 'Name')),
                  SizedBox(height: 8),
                  TextField(controller: _emailCtrl, decoration: InputDecoration(labelText: 'Email')),
                  SizedBox(height: 12),
                  ElevatedButton(onPressed: () {
                    user.name = _nameCtrl.text;
                    user.email = _emailCtrl.text;
                    app.setUser(user);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated')));
                  }, child: Text('Save')),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          if (user.studentAnswers.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Compatibility answers', style: TextStyle(fontWeight: FontWeight.w700)),
                    SizedBox(height: 8),
                    Wrap(spacing: 8, runSpacing: 8, children: user.studentAnswers.entries.map((e) => Chip(label: Text('${e.key}: ${e.value}'))).toList()),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
