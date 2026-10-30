import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ImageLibraryPage extends StatefulWidget {
  const ImageLibraryPage({super.key});

  @override
  State<ImageLibraryPage> createState() => _ImageLibraryPageState();
}

class _ImageLibraryPageState extends State<ImageLibraryPage>
    with TickerProviderStateMixin {
  final PageController _pageController =
      PageController(viewportFraction: 0.6, initialPage: 1000);

  double _currentPage = 1000;

  /// 🔹 MAPEO IMAGEN → CHALLENGE
  static const List<Map<String, dynamic>> imageProgressMap = [
    {"section": "Referential", "index": 1},
    {"section": "Referential", "index": 2},
    {"section": "Referential", "index": 3},
    {"section": "Referential", "index": 4},
    {"section": "Lexical", "index": 1},
    {"section": "Lexical", "index": 2},
    {"section": "Lexical", "index": 3},
    {"section": "Lexical", "index": 4},
    {"section": "Explanatory", "index": 1},
    {"section": "Explanatory", "index": 2},
    {"section": "Explanatory", "index": 3},
    {"section": "Explanatory", "index": 4},
    {"section": "Elaborative", "index": 1},
    {"section": "Elaborative", "index": 2},
    {"section": "Elaborative", "index": 3},
    {"section": "Elaborative", "index": 4},
    {"section": "Predictive", "index": 1},
    {"section": "Predictive", "index": 2},
    {"section": "Predictive", "index": 3},
    {"section": "Predictive", "index": 4},
  ];

  /// 🔹 IMÁGENES
  static const List<String> images = [
    "assets/PUZZLES/L1-1.png",
    "assets/PUZZLES/L1-2.png",
    "assets/PUZZLES/L1-3.png",
    "assets/PUZZLES/L1-4.png",
    "assets/PUZZLES/L2-1.webp",
    "assets/PUZZLES/L2-2.webp",
    "assets/PUZZLES/L2-3.webp",
    "assets/PUZZLES/L2-4.webp",
    "assets/PUZZLES/L3-1.webp",
    "assets/PUZZLES/L3-2.webp",
    "assets/PUZZLES/L3-3.webp",
    "assets/PUZZLES/L3-4.webp",
    "assets/PUZZLES/L4-1.webp",
    "assets/PUZZLES/L4-2.webp",
    "assets/PUZZLES/L4-3.webp",
    "assets/PUZZLES/L4-4.webp",
    "assets/PUZZLES/L5-1.webp",
    "assets/PUZZLES/L5-2.webp",
    "assets/PUZZLES/L5-3.webp",
    "assets/PUZZLES/L5-4.webp",
  ];

  late AnimationController _bgAnimation;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      final p = _pageController.page;
      if (p != null) {
        setState(() => _currentPage = p);
      }
    });

    _bgAnimation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _bgAnimation.dispose();
    super.dispose();
  }

  int _realIndex(int index) => index % images.length;

  // ================== BUILD ==================
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return FutureBuilder<DocumentSnapshot>(
      future:
          FirebaseFirestore.instance.collection("userProgress").doc(uid).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }

        final progress = snapshot.data!.data() as Map<String, dynamic>? ?? {};

        return _buildScaffold(context, progress);
      },
    );
  }

  // ================== UI ==================
  Widget _buildScaffold(BuildContext context, Map<String, dynamic> progress) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Neon animated background
          AnimatedBuilder(
            animation: _bgAnimation,
            builder: (_, __) {
              final t = _bgAnimation.value;
              return CustomPaint(
                size: Size.infinite,
                painter: _NeonBackgroundPainter(t),
              );
            },
          ),

          // Carousel
          Center(
            child: SizedBox(
              height: 380,
              child: PageView.builder(
                controller: _pageController,
                itemBuilder: (context, index) {
                  final real = _realIndex(index);
                  final diff = _currentPage - index;
                  final isCenter = diff.abs() < 0.25;

                  final map = imageProgressMap[real];
                  final completed = progress[
                          "completed${map["section"]}Challenge${map["index"]}"] ==
                      true;

                  final scale = (1 - diff.abs() * 0.25).clamp(0.75, 1.0);
                  final opacity = (1 - diff.abs() * 0.45).clamp(0.25, 1.0);

                  return Center(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..scale(scale)
                        ..rotateY(diff * 0.3)
                        ..rotateX(diff * 0.1),
                      child: Opacity(
                        opacity: opacity,
                        child: _buildImageCard(
                          images[real],
                          isCenter,
                          real,
                          completed,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 16,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.black.withOpacity(0.65),
              onPressed: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ================== CARD ==================
  Widget _buildImageCard(
    String image,
    bool isCenter,
    int index,
    bool completed,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF111111), Color(0xFF1C1C1C)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white
                .withOpacity(completed ? (isCenter ? 0.35 : 0.2) : 0.08),
            blurRadius: isCenter ? 40 : 18,
            spreadRadius: isCenter ? 3 : 1,
          ),
        ],
        border: Border.all(
          color: completed
              ? Colors.white.withOpacity(0.8)
              : Colors.white.withOpacity(0.25),
          width: isCenter ? 3 : 1.2,
        ),
      ),
      child: GestureDetector(
        onTap: (isCenter && completed) ? () => _openZoomImage(index) : null,
        child: ColorFiltered(
          colorFilter: completed
              ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
              : const ColorFilter.matrix([
                  0.2126,0.7152,0.0722,0,0,
                  0.2126,0.7152,0.0722,0,0,
                  0.2126,0.7152,0.0722,0,0,
                  0,0,0,1,0,
                ]),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Image.asset(image, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }

  // ================== ZOOM ==================
  void _openZoomImage(int startIndex) {
    final PageController zoomController =
        PageController(initialPage: startIndex);

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.85),
      builder: (_) {
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.8, end: 1.0),
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutBack,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Dialog(
                  backgroundColor: Colors.transparent,
                  insetPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: zoomController,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: Image.asset(
                                images[index],
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// ================== BACKGROUND ==================
class _NeonBackgroundPainter extends CustomPainter {
  final double t;
  _NeonBackgroundPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (int i = 0; i < 3; i++) {
      final radius = 420 + i * 160;
      final dx = size.width * (0.5 + sin(t * 2 + i) * 0.25);
      final dy = size.height * (0.5 + cos(t * 2 + i) * 0.25);

      paint.shader = RadialGradient(
        colors: [
          Colors.primaries[(i * 3) % Colors.primaries.length].withOpacity(0.22),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(center: Offset(dx, dy), radius: radius.toDouble()),
      );

      canvas.drawCircle(Offset(dx, dy), radius.toDouble(), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
