import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inferwise/Self%20Assessments/HistoryPage.dart';
import 'package:inferwise/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// ------------------
/// Provider global
/// ------------------
final themeNotifierProvider =
    ChangeNotifierProvider<ThemeNotifier>((ref) => ThemeNotifier(false));

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  // ignore: unused_field for the future use of notifications setting
  bool _notificationsEnabled = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final user = FirebaseAuth.instance.currentUser;
    final username = prefs.getString('username');

    setState(() {
      _notificationsEnabled = prefs.getBool('notifications') ?? true;
      _isLoggedIn = user != null || username != null;
    });
  }

  // ignore: unused_element for the future use of notifications setting
  Future<void> _toggleNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', value);
    setState(() => _notificationsEnabled = value);
  }

  Future<void> _confirmLogout(bool isDark) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.logout_rounded,
                    color: Colors.orange, size: 40),
              ),
              const SizedBox(height: 20),
              Text(
                'Log out?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Are you sure you want to end your session and log out of your account?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isDark ? Colors.grey[400] : Colors.grey,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Log out'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (confirmed == true) {
      await _showLoadingDialog(isDark);
      await _logout();
    }
  }

  Future<void> _showLoadingDialog(bool isDark) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 16),
              Text(
                'Logging out...',
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pop();
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = ref.watch(themeNotifierProvider);
    final isDark = themeNotifier.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F0F0F) : Colors.white,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
        foregroundColor: isDark ? Colors.white : Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Dark Mode',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              trailing: Switch(
                value: themeNotifier.isDarkMode,
                onChanged: (value) {
                  ref.read(themeNotifierProvider).toggleTheme(value);
                },
                activeColor: Colors.white, // bolita ON
                activeTrackColor: const Color(0xFF3A3A3A), // riel ON (dark)

                inactiveThumbColor:
                    const Color.fromARGB(255, 30, 74, 89), // bolita OFF
                inactiveTrackColor:
                    const Color.fromARGB(255, 30, 74, 89).withOpacity(0.4),
              ),
            ),
            ListTile(
              onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, anim, __) =>
                      const SelfEvaluationsHistoryPage(),
                  transitionsBuilder: (_, anim, __, child) =>
                      FadeTransition(opacity: anim, child: child),
                  transitionDuration: const Duration(milliseconds: 400),
                ),
              ),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: const Color(0xFF4CAF50).withOpacity(0.3),
                      width: 1),
                ),
                child: const Icon(Icons.auto_graph_rounded,
                    color: Color(0xFF81C784), size: 20),
              ),
              title: Text(
                'My Self-Assessments',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                'View your progress and improvement tips',
                style: TextStyle(
                  color: isDark ? Colors.white38 : Colors.black38,
                  fontSize: 12,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: isDark ? Colors.white24 : Colors.black26,
                size: 14,
              ),
            ),
            const Spacer(),
            if (_isLoggedIn)
              ElevatedButton.icon(
                onPressed: () => _confirmLogout(isDark),
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  'Log out',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// ------------------
/// ThemeNotifier
/// ------------------
class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode;

  ThemeNotifier(this._isDarkMode);

  bool get isDarkMode => _isDarkMode;

  Future<void> toggleTheme(bool value) async {
    _isDarkMode = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
  }
}
