import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inferwise/Spots/ReadingSpots/Orange/Content/Spot4/Content/Depression.dart';
import 'package:inferwise/Spots/ReadingSpots/Orange/Content/Spot4/Content/Heritage.dart';
import 'package:inferwise/Spots/ReadingSpots/Orange/Content/Spot4/Content/Mars.dart';

import 'package:inferwise/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingSpot4_4Page extends StatelessWidget {
  const ReadingSpot4_4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 6),
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.black87),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF8EAFB), // lavanda muy tenue (casi blanco)
              Color(0xFFF3E5F5), // lavanda claro
              Color(0xFFE1BEE7), // lavanda clásico
              Color(0xFFD1C4E9), // violeta grisáceo
              Color(0xFFCE93D8), // lila
              Color(0xFFBA68C8), // morado medio
              Color(0xFFAB47BC), // morado fuerte
              Color(0xFF9C27B0), // púrpura principal
              Color(0xFF6A1B9A), // púrpura profundo
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Text(
                "📚 Please select one of these articles",
                style: TextStyle(
                  fontFamily: 'Cinzel',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildStoryCard(
                        context,
                        title: "The Evolution of Mars Water-Ice Detection Research (1990–2024)",
                        imageAsset: 'assets/Banners/Article/Article 4.1.png',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MarsSplashScreen(),
                          ),
                        ),
                      ),
                      _buildStoryCard(
                        context,
                        title: "Burnout and Depression in College Students",
                        imageAsset: 'assets/Banners/Article/Article 4.2.png',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BurnoutSplashScreen(),
                          ),
                        ),
                      ),
                      _buildStoryCard(
                        context,
                        title: "The Impact of Environmental Pollution on the Sustainability of Architectural Heritage: The Case of Cartagena de Indias",
                        imageAsset: 'assets/Banners/Article/Article 4.3.png',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HeritageSplashScreen(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoryCard(BuildContext context,
      {required String title,
      required String imageAsset,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          _buildStoryImageButton(context, imageAsset, onTap),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Cinzel',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 4,
                  color: Colors.black54,
                  offset: Offset(1, 1),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStoryImageButton(
      BuildContext context, String imageAsset, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.shade200.withOpacity(0.35),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(imageAsset, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class Final_Path extends StatefulWidget {
  const Final_Path({super.key});

  @override
  State<Final_Path> createState() => _Final_PathState();
}

class _Final_PathState extends State<Final_Path> {
  bool? alreadyCompleted;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    _checkCompletion();
  }

  Future<void> _checkCompletion() async {
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getBool('completedReadingSpot16') ?? false;

    setState(() {
      alreadyCompleted = completed;
    });
  }

  Future<void> _showAlreadyCompletedDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: const LinearGradient(
                      colors: [
                        Color(0xFF2B1B3D), // morado oscuro
                        Color(0xFF4B326F), // violeta medio
                        Color(0xFF9F87C3), // lila claro
                      ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.80),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.auto_stories_outlined,
                size: 50,
                color: Colors.white70,
              ),
              SizedBox(height: 20),
              Text(
                "Spot Already Completed",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cinzel',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(221, 213, 213, 213),
                ),
              ),
              SizedBox(height: 12),
              Text(
                "You've already completed this spot.\nRedirecting to Main Menu...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: Color.fromARGB(137, 255, 255, 255),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.of(context).pop();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  Future<void> _completeFinalLevel() async {
    if (isProcessing) return;
    setState(() => isProcessing = true);

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    if (alreadyCompleted == true) {
      if (!mounted) return;
      _showAlreadyCompletedDialog();
      return;
    }

    // Guardar progreso y contador de spots en Firestore
    await FirebaseFirestore.instance
        .collection('userProgress')
        .doc(user.uid)
        .set({
      'completedReadingSpot16': true,
      'completedSpotsCount': FieldValue.increment(1),
    }, SetOptions(merge: true));

    // Guardar localmente
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('completedReadingSpot16', true);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  @override
Widget build(BuildContext context) {
  if (alreadyCompleted == null) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  return Scaffold(
    body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF3E5F5), // morado muy suave
            Color(0xFFBA68C8), // morado medio
            Color(0xFF7B1FA2), // morado fuerte
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.emoji_events,
              size: 100,
              color: Color(0xFF4A148C), // morado oscuro
            ),

            const SizedBox(height: 16),

            const Text(
              "Great job completing Reading Spot 4.4! 📖🌟",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            const Text(
              "Explore the full text in the library. Dive in and unlock its secrets! \n📚🔍✨",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 36),

            ElevatedButton.icon(
              icon: const Icon(Icons.home, color: Colors.white),
              label: const Text(
                "Go to Home",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: _completeFinalLevel,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A1B9A), // morado botón
                elevation: 6,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}