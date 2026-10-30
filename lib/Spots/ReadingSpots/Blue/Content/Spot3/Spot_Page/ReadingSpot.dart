import 'package:inferwise/Spots/ReadingSpots/Blue/Content/Spot3/Content/Dill.dart';
import 'package:inferwise/Spots/ReadingSpots/Blue/Content/Spot3/Content/Equation.dart';
import 'package:inferwise/Spots/ReadingSpots/Blue/Content/Spot3/Content/Heart.dart';
import 'package:inferwise/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReadingSpot_2_3_Page extends StatelessWidget {
  const ReadingSpot_2_3_Page({super.key});

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
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F2027), // azul oscuro profundo
              Color(0xFF203A43), // azul grisáceo
              Color(0xFF2C5364), // azul acero
              Color(0xFF324B54), // tono intermedio suave
              Color(0xFF3E5A64), // azul frío
              Color(0xFF4A6A74), // tono más claro hacia abajo
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
                "📖 Please select one of these stories",
                style: TextStyle(
                  fontFamily: 'Cinzel',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 6,
                      color: Colors.black54,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // ✅ Scroll que evita overflow
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildStoryCard(
                        context,
                        title: "The Nothing Equation",
                        imageAsset: 'assets/Banners/Story/Story 2.1.png',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EquationSplashScreen(),
                          ),
                        ),
                      ),
                      _buildStoryCard(
                        context,
                        title: "A Dill Pickle",
                        imageAsset: 'assets/Banners/Story/Story 2.2.png',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DillSplashScreen(),
                          ),
                        ),
                      ),
                      _buildStoryCard(
                        context,
                        title: "The Tell-Tale Heart",
                        imageAsset: 'assets/Banners/Story/Story 2.3.png',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HeartSplashScreen(),
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 0, 68, 255).withOpacity(0.25), // brillo cálido
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
                  fit: BoxFit.cover, width: double.infinity, height: 140),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.3),
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
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    _checkCompletion();
  }

  Future<void> _checkCompletion() async {
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getBool('completedReadingSpot7') ?? false;

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
                Color(0xFF1E2A38),
                Color(0xFF2F3D4C),
                Color(0xFF5C7893),
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
      'completedReadingSpot7': true,
      'completedSpotsCount': FieldValue.increment(1),
    }, SetOptions(merge: true));

    // Guardar localmente
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('completedReadingSpot7', true);

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
            Color(0xFFE3F2FD), // azul muy suave
            Color(0xFF64B5F6), // azul medio
            Color(0xFF1E88E5), // azul fuerte
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
              color: Color(0xFF0D47A1), // azul oscuro
            ),

            const SizedBox(height: 16),

            const Text(
              "Great job completing Reading Spot 3.2! 📖🌟",
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
                backgroundColor: const Color(0xFF1565C0), // azul botón
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