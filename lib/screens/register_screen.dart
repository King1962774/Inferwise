import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inferwise/screens/splash_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;

  final Color primaryColor = const Color.fromARGB(255, 30, 74, 89);
  final Color secondaryColor = const Color.fromARGB(255, 16, 40, 50);

  final List<String> _avatars = [
    "assets/User Profile Illustrations/Designer (1).png",
    "assets/User Profile Illustrations/Designer (2).png",
    "assets/User Profile Illustrations/Designer (3).png",
    "assets/User Profile Illustrations/Designer (4).png",
    "assets/User Profile Illustrations/Designer (5).png",
    "assets/User Profile Illustrations/Designer (6).png",
    "assets/User Profile Illustrations/Designer (7).png",
    "assets/User Profile Illustrations/Designer (8).png",
    "assets/User Profile Illustrations/Designer (9).png",
    "assets/User Profile Illustrations/Designer (10).png",
    "assets/User Profile Illustrations/Designer (11).png",
    "assets/User Profile Illustrations/Designer (12).png",
  ];

  String? _selectedAvatar;

  void _registerUser() async {
    String email = _emailController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || username.isEmpty || password.isEmpty) {
      _showMessage("Todos los campos son obligatorios.");
      return;
    }

    if (password.length < 6) {
      _showMessage("La contraseña debe tener al menos 6 caracteres.");
      return;
    }

    if (_selectedAvatar == null) {
      _showMessage("Selecciona un avatar.");
      return;
    }

    setState(() => _isLoading = true);

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.toLowerCase(),
        password: password,
      );

      final String uid = userCredential.user!.uid;

      await _firestore.collection("users").doc(uid).set({
        "email": email,
        "username": username,
        "profileImage": _selectedAvatar,
        "createdAt": FieldValue.serverTimestamp(),
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userId', uid);
      await prefs.setString('username', username);
      await prefs.setString('email', email);
      await prefs.setString('profileImage', _selectedAvatar!);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => SplashScreen()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      setState(() => _isLoading = false);

      if (e.code == 'email-already-in-use') {
        _showMessage("Este correo ya está registrado.");
      } else if (e.code == 'weak-password') {
        _showMessage("La contraseña es muy débil.");
      } else {
        _showMessage("Error: ${e.message}");
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showMessage("Error inesperado: $e");
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: secondaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            itemCount: _avatars.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final avatar = _avatars[index];
              final isSelected = avatar == _selectedAvatar;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedAvatar = avatar;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? Colors.white : Colors.transparent,
                      width: 3,
                    ),
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(avatar, fit: BoxFit.cover),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _showAvatarPicker,
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        backgroundImage: _selectedAvatar != null
                            ? AssetImage(_selectedAvatar!)
                            : null,
                        child: _selectedAvatar == null
                            ? const Icon(Icons.person,
                                color: Colors.white, size: 36)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Toca para elegir tu avatar",
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Crear Cuenta",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _emailController,
                      label: "Correo Electrónico",
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _usernameController,
                      label: "Nombre de Usuario",
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _passwordController,
                      label: "Contraseña",
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor.withOpacity(0.9),
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: _isLoading ? null : _registerUser,
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Registrarse",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.08),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: Colors.white.withOpacity(0.2), width: 1.4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: Colors.white.withOpacity(0.9), width: 1.6),
        ),
      ),
    );
  }
}