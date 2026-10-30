import 'package:flutter/material.dart';
import 'session_manager.dart';
import 'login_screen.dart';

class MainScreen extends StatelessWidget {
  final SessionManager _sessionManager = SessionManager();

  void _logout(BuildContext context) async {
    await _sessionManager.clearSession();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla Principal'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Text('Bienvenido a la app!'),
      ),
    );
  }
}
