import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inferwise/Spots/ReadingSpots/Green/Content/Spot2/Content/Houses.dart';
import 'package:inferwise/Spots/ReadingSpots/Green/Content/Spot2/Content/Ugandas.dart';
import 'package:inferwise/Spots/ReadingSpots/Green/Content/Spot2/Content/Recovery.dart';
import 'package:inferwise/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingSpot2Page extends StatelessWidget {
  const ReadingSpot2Page({super.key});

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
              Color(0xFFF1F8F4), // verde blanco muy tenue
              Color(0xFFE8F5E9), // verde pastel muy claro
              Color(0xFFD0EDD4), // verde menta suave
              Color(0xFFC8E6C9), // verde suave
              Color(0xFFA5D6A7), // verde claro más definido
              Color(0xFF81C784), // verde medio
              Color(0xFF66BB6A), // verde fuerte
              Color(0xFF388E3C), // verde bosque
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Text(
                "🗞️ Please select one of these news",
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
                        title: "Houses Made of Waste Changing Lives in South America",
                        imageAsset: 'assets/Banners/News/News 1.1.png',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HousesAnimationOne(),
                          ),
                        ),
                      ),
                      _buildStoryCard(
                        context,
                        title: "Uganda’s anti-gay law sparks global concerns",
                        imageAsset: 'assets/Banners/News/News 1.2.png',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const UgandasAnimationOne(),
                          ),
                        ),
                      ),
                      _buildStoryCard(
                        context,
                        title: "A Recovery Center in Nigeria Takes a Musical Approach to Combating Drug Addiction",
                        imageAsset: 'assets/Banners/News/News 1.3.png',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RecoveryAnimationOne(),
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
              fontSize: 16,
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

class Final_Path extends StatefulWidget {
  const Final_Path({super.key});

  @override
  State<Final_Path> createState() => _Final_PathState();
}

class _Final_PathState extends State<Final_Path> {
  bool? alreadyCompleted;

  @override
  void initState() {
    super.initState();
    _checkCompletion();
  }

  Future<void> _checkCompletion() async {
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getBool('completedReadingSpot2') ?? false;

    setState(() {
      alreadyCompleted = completed;
    });
  }

  Future<void> _completeFinalLevel() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    if (alreadyCompleted == true) {
      if (!mounted) return;

      // 🎨 Mostrar diálogo bonito sin botones
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
                  Color(0xFF1C352D), // verde bosque oscuro
                  Color(0xFF2E5941), // verde oliva profundo
                  Color(0xFF5FA777), // verde medio vibrante
                  Color(0xFF9FD6B0), // verde claro suave
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.25), // sombra verdosa
                  blurRadius: 20,
                  offset: Offset(0, 10),
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
                  color: Color.fromARGB(255, 0, 0, 0),
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

      // ⏳ Cerrar diálogo y redirigir tras 3 segundos
      Future.delayed(const Duration(seconds: 3), () {
        if (!mounted) return;
        Navigator.of(context).pop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      });

      return; // 🚫 No seguir si ya estaba completado
    }

    // ✅ Primera vez completando: guardar progreso
    await FirebaseFirestore.instance
        .collection('userProgress')
        .doc(user.uid)
        .set({'completedReadingSpot2': true}, SetOptions(merge: true));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('completedReadingSpot2', true);

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
            Color(0xFFE8F5E9), // verde muy suave
            Color(0xFF81C784), // verde medio
            Color(0xFF4DB6AC), // teal elegante
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
              color: Color(0xFF2E7D32), // verde oscuro
            ),

            const SizedBox(height: 16),

            const Text(
              "Great job completing Reading Spot 2! 📖🌟",
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
                backgroundColor: const Color(0xFF43A047), // verde botón
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
