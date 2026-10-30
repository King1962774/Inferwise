import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bienvenido")),
      body: Center(child: Text("¡Has iniciado sesión con éxito!", style: TextStyle(fontSize: 20))),
    );
  }
}
