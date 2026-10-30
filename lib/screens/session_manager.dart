import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _userKey = 'loggedInUser';

  // Guardar el email del usuario en sesión
  Future<void> saveUserSession(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, email);
  }

  // Obtener el usuario en sesión
  Future<String?> getUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userKey);
  }

  // Cerrar sesión
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
