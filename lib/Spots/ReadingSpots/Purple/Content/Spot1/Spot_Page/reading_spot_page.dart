import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inferwise/Spots/ReadingSpots/Purple/Content/Spot1/Content/Giuseppina.dart';
import 'package:inferwise/Spots/ReadingSpots/Purple/Content/Spot1/Content/Joan_of_Arc.dart';
import 'package:inferwise/Spots/ReadingSpots/Purple/Content/Spot1/Content/Socrates.dart';
import 'package:inferwise/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingSpot5_1Page extends StatelessWidget {
  const ReadingSpot5_1Page({super.key});

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
      body: Stack(
        children: [
          // Fondo con degradado amarillo
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFFDE7),
                  Color(0xFFFFF8E1),
                  Color(0xFFFFF3B0),
                  Color(0xFFFFE082),
                  Color(0xFFFFD54F),
                  Color(0xFFFFCA28),
                  Color(0xFFFFB300),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Contenido principal
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 100),
                const Text(
                  "📖 Please select one of these biographies",
                  style: TextStyle(
                    fontFamily: 'Cinzel',
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    shadows: [
                      Shadow(
                        blurRadius: 6,
                        color: Colors.white70,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildStoryCard(
                          context,
                          title: "Giuseppina Cattani, the Unknown \nCo-Discoverer of the Antitetanus Serum",
                          imageAsset:
                              'assets/Banners/Biography/Biography 5.1.png',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const GiuseppinaSplashScreen(),
                            ),
                          ),
                        ),
                        _buildStoryCard(
                          context,
                          title: "The Story of Joan of Arc: Chapters I - II",
                          imageAsset:
                              'assets/Banners/Biography/Biography 5.2.png',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const JoanOfArcSplashScreen(),
                            ),
                          ),
                        ),
                        _buildStoryCard(
                          context,
                          title: "Famous Men of Ancient Times: Socrates",
                          imageAsset:
                              'assets/Banners/Biography/Biography 5.3.png',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SocratesSplashScreen(),
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
        ],
      ),
    );
  }

  // Widget que combina imagen + título
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
              color: Colors.black87,
              shadows: [
                Shadow(
                  blurRadius: 4,
                  color: Colors.white70,
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.orangeAccent.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.asset(imageAsset,
                  fit: BoxFit.cover, width: double.infinity, height: 130),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.25),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
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


class FinalPath extends StatefulWidget {
  const FinalPath({super.key});

  @override
  State<FinalPath> createState() => _FinalPathState();
}

class _FinalPathState extends State<FinalPath> {
  bool? alreadyCompleted;

  @override
  void initState() {
    super.initState();
    _checkCompletion();
  }

  Future<void> _checkCompletion() async {
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getBool('completedReadingSpot17') ?? false;

    setState(() {
      alreadyCompleted = completed;
    });
  }

  Future<void> _completeFinalLevel() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    if (alreadyCompleted == true) {
      if (!mounted) return;

      // Mostrar diálogo bonito sin botones
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
                  Color(0xFFFAF3D3),
                  Color(0xFFF6D365),
                  Color(0xFFFDAE6B),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.menu_book_rounded,
                  size: 50,
                  color: Color(0xFF8B6B2F),
                ),
                SizedBox(height: 20),
                Text(
                  "Spot Already Completed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Cinzel',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "You've already completed this spot.\nRedirecting to Main Menu...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // Cerrar diálogo y redirigir tras 3 segundos
      Future.delayed(const Duration(seconds: 3), () {
        if (!mounted) return;
        Navigator.of(context).pop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      });

      return; // Early return si ya estaba completado
    }

    // 🆕 Primera vez completando: guardar progreso
    await FirebaseFirestore.instance
        .collection('userProgress')
        .doc(user.uid)
        .set({'completedReadingSpot17': true}, SetOptions(merge: true));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('completedReadingSpot17', true);

    await FirebaseFirestore.instance
        .collection('userProgress')
        .doc(user.uid)
        .set({
      'completedSpotsCount': FieldValue.increment(1),
    }, SetOptions(merge: true));

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    }
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
            Color(0xFFFFF3B0), // amarillo suave
            Color(0xFFFFD54F), // amarillo vibrante
            Color(0xFF80CBC4), // aquamarina elegante
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
              color: Color.fromARGB(255, 243, 196, 42),
            ),

            const SizedBox(height: 16),

            const Text(
              "Great job completing Reading Spot 5.1! 📖🌟",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            const Text(
              "Explore the full text in the library. Dive in and unlock its secrets! \n📚🔍✨",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 36),

            ElevatedButton.icon(
              icon: const Icon(Icons.home, color: Colors.black),
              label: const Text(
                "Go to Home",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: _completeFinalLevel,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 243, 196, 42),
                elevation: 4,
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

