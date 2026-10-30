import 'package:flutter/material.dart';
import 'package:inferwise/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_screen.dart';
import 'database_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseService dbService = DatabaseService();

  bool _isLoading = false;
  bool _obscurePassword = true;

  final Color primaryColor = const Color.fromARGB(255, 30, 74, 89);     // Azul petróleo
  final Color accentBlue = const Color.fromARGB(255, 48, 144, 212);                     // Azul educativo
  final Color accentYellow = const Color(0xFFFFC857);                   // Amarillo cálido
  final Color softBackground = const Color(0xFFF4F9FF);                 // Fondo suave

  void _loginUser() async {
    if (_isLoading) return;

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Correo y contraseña requeridos.");
      return;
    }

    setState(() => _isLoading = true);

    bool isAuthenticated = await dbService.authenticateUser(email, password);

    setState(() => _isLoading = false);

    if (isAuthenticated) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      _showMessage("Inicio de sesión exitoso.");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SplashScreen()),
      );
    } else {
      _showMessage("Correo o contraseña incorrectos.");
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: primaryColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: softBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.12),

              /// LOGO + TITULO
              Container(
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
child: Column(
  children: [
    // LOGO CIRCULAR
    CircleAvatar(
      radius: 48,
      backgroundColor: primaryColor.withOpacity(0.20), // borde suave
      child: CircleAvatar(
        radius: 44,
        backgroundImage: AssetImage("assets/Miniatura.png"), // tu miniatura
      ),
    ),

    SizedBox(height: 16),

    Text(
      "InferWise",
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
    ),

    SizedBox(height: 6),

    Text(
      "Inicia sesión en tu cuenta",
      style: TextStyle(
        color: Colors.grey.shade600,
        fontSize: 15,
      ),
    ),
  ],
),
              ),

              SizedBox(height: 40),

              /// FORMULARIO
              Container(
                padding: EdgeInsets.all(26),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 20,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildInputField(
                      controller: _emailController,
                      label: "Correo Electrónico",
                      icon: Icons.email,
                    ),

                    SizedBox(height: 18),

                    _buildInputField(
                      controller: _passwordController,
                      label: "Contraseña",
                      icon: Icons.lock,
                      isPassword: true,
                    ),

                    SizedBox(height: 26),

                    /// BOTÓN LOGIN
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _loginUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentBlue,
                          foregroundColor: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              )
                            : Text(
                                "Iniciar Sesión",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),

                    SizedBox(height: 22),

                    /// ENLACE REGISTRO
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "¿No tienes cuenta?",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        SizedBox(width: 6),
                        GestureDetector(
                          onTap: _isLoading
                              ? null
                              : () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) => RegisterScreen()));
                                },
                          child: Text(
                            "Regístrate",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              Text(
                "© 2025 InferWise App",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// INPUT FIELD MODERNO
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFFEAF4FF), // azul súper suave
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? _obscurePassword : false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Color(0xFF1E4A59)),
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: Color(0xFF3FA9F5)),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: Color(0xFF3FA9F5),
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                )
              : null,
        ),
      ),
    );
  }
}
