import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../state/app_state.dart';

class RoleSelectionScreen extends StatelessWidget {
  void _selectRole(BuildContext context, UserRole role) {
  final app = Provider.of<AppState>(context, listen: false);
  final user = UserProfile(id: 'me', name: 'Me', email: 'me@example.com', role: role);
  app.setUser(user);
  if (role == UserRole.student) Navigator.pushNamed(context, '/questionnaire');
  else Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(title: Text('Choose your role')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('I am a', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectRole(context, UserRole.student),
              child: Text('Student', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: primary, padding: EdgeInsets.symmetric(vertical: 16)),
            ),
            SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => _selectRole(context, UserRole.realtor),
              child: Text('Realtor'),
              style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
            ),
            SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => _selectRole(context, UserRole.landlord),
              child: Text('Landlord'),
              style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
