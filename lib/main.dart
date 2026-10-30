import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inferwise/Spots/Achievements/Achievements.dart';
import 'package:inferwise/Spots/Challenges/Challenges.dart';
import 'package:inferwise/Spots/Library/Books.dart';
import 'package:inferwise/Spots/Pathway/Pathway.dart';
import 'package:inferwise/Spots/Settings/Settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Cargamos darkMode al inicio para inyectarlo en ThemeNotifier
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('darkMode') ?? false;

  runApp(
    ProviderScope(
      overrides: [
        themeNotifierProvider.overrideWith((ref) => ThemeNotifier(isDarkMode)),
      ],
      child: const InferwiseApp(),
    ),
  );
}

class InferwiseApp extends StatefulWidget {
  const InferwiseApp({super.key});

  @override
  State<InferwiseApp> createState() => _InferwiseAppState();
}

class _InferwiseAppState extends State<InferwiseApp> {
  late Future<bool> _isLoggedInFuture;

  @override
  void initState() {
    super.initState();
    _isLoggedInFuture = _loadLoginState();
  }

  Future<bool> _loadLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        ref.watch(themeNotifierProvider);

        return FutureBuilder<bool>(
          future: _isLoggedInFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const MaterialApp(
                home: Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                ),
              );
            } else if (snapshot.hasError) {
              return const MaterialApp(
                home: Scaffold(
                  body: Center(child: Text('Error loading data')),
                ),
              );
            } else {
              final isLoggedIn = snapshot.data ?? false;

              return MaterialApp(
                title: 'Inferwise',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  scaffoldBackgroundColor: Colors.white,
                  textTheme: const TextTheme(
                    bodyMedium: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                debugShowCheckedModeBanner: false,
                home: isLoggedIn ? SplashScreen() : LoginScreen(),
              );
            }
          },
        );
      },
    );
  }
}

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;
  int _previousIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const HomePage(),
    const LessonsPage(),
    AchievementsPage(),
    const ChallengesPage(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _previousIndex = _selectedIndex;
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeNotifierProvider).isDarkMode;
    final bool slideFromRight = _selectedIndex > _previousIndex;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,

      // 🔥 ANIMACIÓN DE PANTALLAS CON DIRECCIÓN
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 380),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,

        transitionBuilder: (child, animation) {
          final offsetAnimation = Tween<Offset>(
            begin: Offset(slideFromRight ? 0.08 : -0.08, 0),
            end: Offset.zero,
          ).animate(animation);

          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: offsetAnimation,
              child: child,
            ),
          );
        },

        child: KeyedSubtree(
          key: ValueKey<int>(_selectedIndex),
          child: _pages[_selectedIndex],
        ),
      ),

      // 🔥 BOTTOM BAR ANIMADA
      bottomNavigationBar: Container(
        color: isDark ? const Color(0xFF121212) : Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(5, (index) {
            return _AnimatedNavItem(
              icon: _navIcons[index],
              label: _navLabels[index],
              isSelected: _selectedIndex == index,
              isDark: isDark,
              onTap: () => _onItemTapped(index),
            );
          }),
        ),
      ),
    );
  }
}

/// 🔹 ICONOS 
final List<IconData> _navIcons = [
  Icons.home,
  Icons.book, 
  Icons.workspace_premium_rounded,
  Icons.star_rounded,
  Icons.settings,
];

/// 🔹 LABELS
final List<String> _navLabels = [
  'Pathway',
  'Library',
  'Achievements',
  'Challenge',
  'Settings',
];

/// 🔥 ITEM ANIMADO
class _AnimatedNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _AnimatedNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? (isDark ? Colors.white : const Color.fromARGB(255, 30, 74, 89))
        : (isDark ? Colors.grey.shade400 : const Color.fromARGB(255, 30, 74, 89));

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 26),

            // 🔥 TEXTO ANIMADO
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isSelected ? 1 : 0,
                child: isSelected
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: color,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


