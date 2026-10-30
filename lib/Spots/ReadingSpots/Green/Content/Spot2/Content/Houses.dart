// ignore_for_file: duplicate_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Green/Content/Spot2/Spot_Page/Reading_Spot_Page.dart';
import 'dart:math';
import 'dart:math' as math;

class HousesAnimationOne extends StatefulWidget {
  const HousesAnimationOne({super.key});

  @override
  State<HousesAnimationOne> createState() => _HousesAnimationOneState();
}

class _HousesAnimationOneState extends State<HousesAnimationOne>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _floatController;
  late AnimationController _bgController;

  late Animation<double> _fadeIn;
  late Animation<double> _scaleUp;
  late Animation<double> _titleSlide;
  late Animation<double> _authorFade;
  late Animation<double> _dividerWidth;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _floatController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _bgController = AnimationController(
      duration: const Duration(seconds: 9),
      vsync: this,
    )..repeat(reverse: true);

    _fadeIn = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    _scaleUp = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _titleSlide = Tween<double>(begin: 28, end: 0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.3, 0.75, curve: Curves.easeOutCubic),
      ),
    );

    _authorFade = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
    );

    _dividerWidth = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 0.9, curve: Curves.easeOutCubic),
      ),
    );

    _mainController.forward();

    Future.delayed(const Duration(milliseconds: 4500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const News_Houses(),
            transitionsBuilder: (_, anim, __, child) => FadeTransition(
              opacity: anim,
              child: child,
            ),
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _floatController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // ── Fondo verde en capas ──
          _AnimatedBackground(
            floatController: _floatController,
            bgController: _bgController,
            size: size,
          ),

          // ── Contenido principal ──
          Center(
            child: FadeTransition(
              opacity: _fadeIn,
              child: ScaleTransition(
                scale: _scaleUp,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icono flotante
                      AnimatedBuilder(
                        animation: _floatController,
                        builder: (_, child) => Transform.translate(
                          offset: Offset(0, -9 * _floatController.value + 4.5),
                          child: child,
                        ),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.22),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: CustomPaint(
                              size: const Size(52, 52),
                              painter: _HouseIconPainter(),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 26),

                      // Título con slide-up
                      AnimatedBuilder(
                        animation: _titleSlide,
                        builder: (_, child) => Transform.translate(
                          offset: Offset(0, _titleSlide.value),
                          child: Opacity(
                            opacity:
                                (1 - _titleSlide.value / 28).clamp(0.0, 1.0),
                            child: child,
                          ),
                        ),
                        child: Text(
                          "Houses Made of Waste\nChanging Lives in\nSouth America",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.42,
                            letterSpacing: 0.2,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 12,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Divider animado
                      AnimatedBuilder(
                        animation: _dividerWidth,
                        builder: (_, __) => Align(
                          child: Container(
                            width: 140 * _dividerWidth.value,
                            height: 1,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.white.withOpacity(0.45),
                                  Colors.transparent,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Autor sin icono
                      FadeTransition(
                        opacity: _authorFade,
                        child: Text(
                          "By Aleida Rueda, 2024",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.7),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),

                      const SizedBox(height: 34),

                      FadeTransition(
                        opacity: _authorFade,
                        child: Text(
                          "From SciDev.Net",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.7),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Fondo animado ──────────────────────────────────────────────────────────

class _AnimatedBackground extends StatelessWidget {
  final AnimationController floatController;
  final AnimationController bgController;
  final Size size;

  const _AnimatedBackground({
    required this.floatController,
    required this.bgController,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([floatController, bgController]),
      builder: (_, __) => CustomPaint(
        size: size,
        painter: _BackgroundPainter(
          floatValue: floatController.value,
          bgValue: bgController.value,
        ),
      ),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final double floatValue;
  final double bgValue;

  _BackgroundPainter({required this.floatValue, required this.bgValue});

  // Colores base del tema verde
  static const Color _darkGreen = Color(0xFF123D23);
  static const Color _midGreen = Color(0xFF1A5C35);
  static const Color _lightGreen = Color(0xFF2D7A4F);

  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(42);

    // Gradiente de fondo
    final bgRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final bgPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_lightGreen, _midGreen, _darkGreen],
        stops: [0.0, 0.45 + 0.05 * sin(bgValue * 2 * pi), 1.0],
        transform: GradientRotation(pi * (0.44 + 0.04 * sin(bgValue * pi))),
      ).createShader(bgRect);
    canvas.drawRect(bgRect, bgPaint);

    // Blob superior izquierdo (claro)
    _drawBlob(
      canvas,
      Offset(size.width * 0.2 + 6 * sin(bgValue * 2 * pi),
          size.height * 0.15 - 8 * cos(bgValue * 2 * pi)),
      220,
      Colors.white.withOpacity(0.04 + 0.02 * sin(bgValue * 2 * pi)),
    );

    // Blob inferior derecho (oscuro)
    _drawBlob(
      canvas,
      Offset(size.width * 0.85, size.height * 0.85),
      180,
      Colors.black.withOpacity(0.12 + 0.04 * cos(bgValue * 2 * pi)),
    );

    // Blob inferior izquierdo
    _drawBlob(
      canvas,
      Offset(size.width * 0.1, size.height * 0.78),
      140,
      Colors.white.withOpacity(0.035),
    );

    // Cuadrícula sutil
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.055)
      ..strokeWidth = 0.7;
    const step = 55.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Partículas flotantes
    final particles = List.generate(12, (i) {
      final x = (rng.nextDouble() * 0.82 + 0.09) * size.width;
      final baseY = (rng.nextDouble() * 0.82 + 0.09) * size.height;
      final speed = 0.6 + rng.nextDouble() * 1.4;
      final phase = rng.nextDouble() * 2 * pi;
      final y = baseY - 16 * sin(floatValue * pi * speed + phase).abs();
      final rot = 0.14 * sin(floatValue * pi * speed + phase);
      final type = i % 5;
      return (x, y, rot, rng.nextDouble(), type);
    });

    for (final p in particles) {
      canvas.save();
      canvas.translate(p.$1, p.$2);
      canvas.rotate(p.$3);
      final opacity = 0.18 + 0.12 * p.$4;

      switch (p.$5) {
        case 0:
          _drawMiniHouse(canvas, opacity, p.$4 * 6 + 16);
          break;
        case 1:
          _drawLeaf(canvas, opacity, p.$4 * 5 + 14);
          break;
        case 2:
          _drawDiamond(canvas, opacity, p.$4 * 4 + 8);
          break;
        case 3:
          _drawStar(canvas, opacity, p.$4 * 3 + 7);
          break;
        case 4:
          _drawRecycleHint(canvas, opacity, p.$4 * 4 + 10);
          break;
      }
      canvas.restore();
    }
  }

  void _drawBlob(Canvas canvas, Offset center, double radius, Color color) {
    canvas.drawCircle(center, radius, Paint()..color = color);
  }

  void _drawMiniHouse(Canvas canvas, double opacity, double sz) {
    final bodyPaint = Paint()
      ..color = Colors.white.withOpacity(opacity * 0.85)
      ..style = PaintingStyle.fill;
    final roofPaint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = Colors.white.withOpacity(opacity * 1.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    final winPaint = Paint()
      ..color = Colors.white.withOpacity(opacity * 0.5)
      ..style = PaintingStyle.fill;

    // Body
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(0, sz * 0.15),
        width: sz,
        height: sz * 0.65,
      ),
      const Radius.circular(1),
    );
    canvas.drawRRect(bodyRect, bodyPaint);

    // Roof
    final roof = Path()
      ..moveTo(-sz * 0.6, -sz * 0.08)
      ..lineTo(0, -sz * 0.62)
      ..lineTo(sz * 0.6, -sz * 0.08)
      ..close();
    canvas.drawPath(roof, roofPaint);
    canvas.drawPath(roof, strokePaint);

    // Windows
    canvas.drawRect(
      Rect.fromCenter(
          center: Offset(-sz * 0.22, sz * 0.05),
          width: sz * 0.22,
          height: sz * 0.2),
      winPaint,
    );
    canvas.drawRect(
      Rect.fromCenter(
          center: Offset(sz * 0.22, sz * 0.05),
          width: sz * 0.22,
          height: sz * 0.2),
      winPaint,
    );
  }

  void _drawLeaf(Canvas canvas, double opacity, double sz) {
    final fillPaint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.fill;
    final stemPaint = Paint()
      ..color = Colors.white.withOpacity(opacity * 0.9)
      ..strokeWidth = 0.7
      ..style = PaintingStyle.stroke;

    final leaf = Path()
      ..moveTo(0, sz * 0.5)
      ..cubicTo(-sz * 0.55, sz * 0.1, -sz * 0.5, -sz * 0.5, 0, -sz * 0.5)
      ..cubicTo(sz * 0.5, -sz * 0.5, sz * 0.55, sz * 0.1, 0, sz * 0.5)
      ..close();
    canvas.drawPath(leaf, fillPaint);

    // Vein
    canvas.drawLine(Offset(0, sz * 0.5), Offset(0, -sz * 0.5), stemPaint);
  }

  void _drawDiamond(Canvas canvas, double opacity, double sz) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.fill;
    final stroke = Paint()
      ..color = Colors.white.withOpacity(opacity * 1.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.7;

    final path = Path()
      ..moveTo(0, -sz)
      ..lineTo(sz * 0.6, 0)
      ..lineTo(0, sz)
      ..lineTo(-sz * 0.6, 0)
      ..close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, stroke);
  }

  void _drawStar(Canvas canvas, double opacity, double sz) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.fill;

    final path = Path();
    const points = 4;
    for (int i = 0; i < points * 2; i++) {
      final r = i.isEven ? sz : sz * 0.4;
      final angle = i * pi / points - pi / 2;
      final x = r * cos(angle);
      final y = r * sin(angle);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawRecycleHint(Canvas canvas, double opacity, double sz) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    // Simple circular arrow hint
    canvas.drawArc(
      Rect.fromCenter(center: Offset.zero, width: sz, height: sz),
      -pi / 2,
      pi * 1.5,
      false,
      paint,
    );
    // Arrowhead
    final arrowPaint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.fill;
    final arrow = Path()
      ..moveTo(sz * 0.5, -sz * 0.18)
      ..lineTo(sz * 0.5 + sz * 0.25, sz * 0.0)
      ..lineTo(sz * 0.5 - sz * 0.0, sz * 0.22)
      ..close();
    canvas.drawPath(arrow, arrowPaint);
  }

  @override
  bool shouldRepaint(_BackgroundPainter old) =>
      old.floatValue != floatValue || old.bgValue != bgValue;
}

// ── Icono de casa central ─────────────────────────────────────────────────

class _HouseIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final bodyPaint = Paint()
      ..color = Colors.white.withOpacity(0.92)
      ..style = PaintingStyle.fill;
    final accentPaint = Paint()
      ..color = const Color(0xFF1E643C).withOpacity(0.5)
      ..style = PaintingStyle.fill;
    final chimPaint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..style = PaintingStyle.fill;
    final smokePaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    // House body
    final house = Path()
      ..moveTo(w * 0.5, h * 0.15)
      ..lineTo(w * 0.08, h * 0.42)
      ..lineTo(w * 0.08, h * 0.85)
      ..lineTo(w * 0.92, h * 0.85)
      ..lineTo(w * 0.92, h * 0.42)
      ..close();
    canvas.drawPath(house, bodyPaint);

    // Door
    final doorRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.4, h * 0.62, w * 0.2, h * 0.23),
      const Radius.circular(2),
    );
    canvas.drawRRect(doorRRect, accentPaint);

    // Windows
    final leftWin = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.12, h * 0.5, w * 0.14, h * 0.12),
      const Radius.circular(1.5),
    );
    final rightWin = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.74, h * 0.5, w * 0.14, h * 0.12),
      const Radius.circular(1.5),
    );
    canvas.drawRRect(leftWin, accentPaint);
    canvas.drawRRect(rightWin, accentPaint);

    // Chimney
    canvas.drawRect(
      Rect.fromLTWH(w * 0.62, h * 0.18, w * 0.09, h * 0.17),
      chimPaint,
    );

    // Smoke circles
    canvas.drawCircle(Offset(w * 0.655, h * 0.14), w * 0.028, smokePaint);
    canvas.drawCircle(Offset(w * 0.69, h * 0.08), w * 0.018,
        smokePaint..color = Colors.white.withOpacity(0.25));

    // Leaf accent bottom left
    final leafPaint = Paint()
      ..color = const Color(0xFF1E643C).withOpacity(0.4)
      ..style = PaintingStyle.fill;
    final leaf = Path()
      ..moveTo(w * 0.25, h * 0.73)
      ..cubicTo(w * 0.18, h * 0.68, w * 0.16, h * 0.58, w * 0.23, h * 0.64)
      ..cubicTo(w * 0.3, h * 0.58, w * 0.33, h * 0.68, w * 0.25, h * 0.73)
      ..close();
    canvas.drawPath(leaf, leafPaint);
  }

  @override
  bool shouldRepaint(_HouseIconPainter old) => false;
}

//---- Question and Answer Section ----//

class News_Houses extends StatefulWidget {
  const News_Houses({super.key});
  @override
  State<News_Houses> createState() => _News_HousesState();
}

class _News_HousesState extends State<News_Houses> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is a landfill?",
      "options": [
        "A) A type of recycling center",
        "B) A composting facility",
        "C) A natural reserve",
        "D) A site for the disposal of waste materials"
      ],
      "correct": 3,
      "feedback": [
        " Incorrect. A recycling center is for processing reusable materials.",
        " Incorrect. A composting facility breaks down organic waste.",
        " Incorrect. A natural reserve is a protected natural area.",
        "♻️ Correct! A landfill is a designated site where waste materials are disposed of by burying them."
      ]
    },
    {
      "question":
          "How long does it take for a plastic bottle to decompose in a landfill?",
      "options": ["A) 450 years", "B) 100 years", "C) 50 years", "D) 10 years"],
      "correct": 0,
      "feedback": [
        "♻️ Correct! Plastic bottles can take around 450 years to decompose due to their durable chemical structure.",
        " Incorrect. It takes much longer than 100 years.",
        " Incorrect. 50 years is too short for plastic bottles.",
        " Incorrect. Decomposition takes much longer than 10 years."
      ]
    },
    {
      "question":
          "How long does it take for a car tire to decompose in a landfill?",
      "options": [
        "A) 10 years",
        "B) 50-80 years",
        "C) 5 years",
        "D) 100 years"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Tires are much more durable than 10 years.",
        "♻️ Correct! Tires can take 50 to 80 years due to their complex materials.",
        " Incorrect. 5 years is far too short.",
        " Incorrect. While long, 100 years is above the typical range."
      ]
    },
    {
      "question":
          "What materials are commonly used in innovative house construction using waste?",
      "options": [
        "A) Wood and bricks",
        "B) Plastic and metal",
        "C) Bottles and tires",
        "D) Glass and concrete"
      ],
      "correct": 2,
      "feedback": [
        " Incorrect. These are traditional, not waste-based materials.",
        " Incorrect. Though recyclable, they are not typically reused in this way.",
        "♻️ Correct! Bottles and tires are reused in sustainable construction projects.",
        " Incorrect. Glass and concrete are not waste-derived building materials."
      ]
    },
    {
      "question":
          "What is one major benefit of using waste materials for building houses?",
      "options": [
        "A) Increased construction costs",
        "B) Reduced environmental impact",
        "C) Longer construction time",
        "D) Higher energy consumption"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Costs can actually be reduced using recycled materials.",
        "♻️ Correct! Using waste helps reduce environmental impact by recycling and repurposing.",
        " Incorrect. Construction time is not necessarily longer.",
        " Incorrect. Waste-based construction often reduces energy use."
      ]
    },
  ];

  void handleOptionTap(int index) {
    setState(() {
      selectedOption = index;
      showFeedback = true;
    });
  }

  void tryAgain() {
    setState(() {
      showFeedback = false;
      selectedOption = null;
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestion < questions.length - 1) {
        currentQuestion++;
        selectedOption = null;
        showFeedback = false;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const GreenNewsReadingAnimation(
                    title:
                        "Houses Made of Waste\nChanging Lives in\nSouth America",
                    nextPage: BiographyReadingPage(),
                  )),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[currentQuestion];
    final isCorrect = selectedOption == q["correct"];

    return Scaffold(
      body: Stack(
        children: [
          // 🔹 FONDO GENERAL
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/Wallpapers/WallPaperReadingSpots/FONDO GOAL INSTRUCTION 4 Y Bios.webp",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🔹 SUAVIZAR FONDO GENERAL
          Container(
            color: Colors.white.withOpacity(0.35),
          ),

          // 🔹 CARD FULL SCREEN
          SizedBox.expand(
            child: Stack(
              children: [
                // 🔸 MISMO FONDO DENTRO
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF81C784), // verde suave
                        Color(0xFF4DB6AC), // teal elegante
                      ],
                    ),
                  ),
                ),

// 🔹 SUAVIZAR FONDO GENERAL
                Container(
                  color: Colors.white.withOpacity(0.10),
                ),

                // 🔸 CONTENIDO
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question ${currentQuestion + 1} of ${questions.length}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          q["question"],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ...List.generate(q["options"].length, (i) {
                          final isSelected = selectedOption == i;
                          final isRight = i == q["correct"];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: ElevatedButton(
                              onPressed: showFeedback
                                  ? null
                                  : () => handleOptionTap(i),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isSelected
                                    ? (showFeedback
                                        ? (isRight
                                            ? const Color.fromARGB(
                                                255, 21, 147, 23)
                                            : Colors.red)
                                        : Colors.grey.shade300)
                                    : Colors.white,
                                foregroundColor: Colors.black,
                                minimumSize: const Size.fromHeight(52),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 2,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  q["options"][i],
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 24),
                        if (showFeedback && selectedOption != null)
                           Center(
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 8),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: isCorrect
                                    ? Colors.green.shade50
                                    : Colors.red.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isCorrect
                                      ? const Color.fromARGB(255, 77, 218, 82)
                                      : Colors.red.shade300,
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                q["feedback"][selectedOption!],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isCorrect
                                      ? const Color.fromARGB(255, 2, 135, 9)
                                      : Colors.red.shade700,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        const Spacer(),
                        if (showFeedback && isCorrect)
                          Center(
                            child: ElevatedButton(
                              onPressed: nextQuestion,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 21, 147, 23),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 36,
                                  vertical: 14,
                                ),
                              ),
                              child: Text(
                                currentQuestion == questions.length - 1
                                    ? "Continue"
                                    : "Next",
                              ),
                            ),
                          ),
                        if (showFeedback && !isCorrect)
                          Center(
                            child: ElevatedButton(
                              onPressed: tryAgain,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 36,
                                  vertical: 14,
                                ),
                              ),
                              child: const Text("Try Again"),
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
}

// ══════════════════════════════════════════════════════════════════
//  GreenNewsReadingAnimation
//  Pantalla de transición genérica con periódico animado.
//
//  USO:
//    GreenNewsReadingAnimation(
//      title: "Houses Made of Waste\nChanging Lives in\nSouth America",
//      nextPage: TuSiguientePagina(),
//    )
// ══════════════════════════════════════════════════════════════════
class GreenNewsReadingAnimation extends StatefulWidget {
  const GreenNewsReadingAnimation({
    super.key,
    required this.title,
    required this.nextPage,
  });

  final String title;
  final Widget nextPage;

  @override
  State<GreenNewsReadingAnimation> createState() =>
      _GreenNewsReadingAnimationState();
}

class _GreenNewsReadingAnimationState extends State<GreenNewsReadingAnimation>
    with TickerProviderStateMixin {
  // ── Controladores ────────────────────────────────────────────────
  late final AnimationController _masterCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _floatCtrl;

  // ── Animations ───────────────────────────────────────────────────
  late final Animation<double> _bgFade;
  late final Animation<double> _paperUnfold;
  late final Animation<double> _paperScale;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _exitFade;
  late final Animation<double> _glow;
  late final Animation<double> _floatY;
  late final Animation<double> _floatRot;

  // ── Paleta ───────────────────────────────────────────────────────
  static const _bg1 = Color(0xFF010F0A);
  static const _bg2 = Color(0xFF012010);
  static const _bg3 = Color(0xFF023A20);
  static const _accent = Color(0xFF34D399);
  static const _accent2 = Color(0xFF6EE7B7);

  static const _paper = Color(0xFFF4EFE4);
  // ignore: unused_field
  static const _paperBdr = Color(0xFFC5B899);
  static const _mastBg = Color(0xFF0A2E1A);
  static const _mastBg2 = Color(0xFF0D3620);
  static const _ink = Color(0xFF1A1208);

  @override
  void initState() {
    super.initState();

    _masterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3400),
    );

    _bgFade = CurvedAnimation(
      parent: _masterCtrl,
      curve: const Interval(0.0, 0.12, curve: Curves.easeIn),
    );

    _paperScale = Tween<double>(begin: 0.60, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.05, 0.30, curve: Curves.elasticOut),
      ),
    );

    _paperUnfold = Tween<double>(begin: -0.12, end: 0.0).animate(
      CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.05, 0.35, curve: Curves.easeOutCubic),
      ),
    );

    _titleFade = CurvedAnimation(
      parent: _masterCtrl,
      curve: const Interval(0.38, 0.60, curve: Curves.easeOut),
    );

    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _masterCtrl,
      curve: const Interval(0.38, 0.62, curve: Curves.easeOut),
    ));

    _exitFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.82, 1.0, curve: Curves.easeIn),
      ),
    );

    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
    _glow = Tween<double>(begin: 6, end: 22).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );

    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);
    _floatY = Tween<double>(begin: -5.0, end: 5.0).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );
    _floatRot = Tween<double>(begin: -0.018, end: 0.018).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await _masterCtrl.forward();
      if (!mounted) return;
      _goNext();
    });
  }

  void _goNext() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 750),
        pageBuilder: (_, __, ___) => widget.nextPage,
        transitionsBuilder: (_, anim, __, child) {
          final slide = Tween<Offset>(
            begin: const Offset(0.08, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic));
          return SlideTransition(
            position: slide,
            child: FadeTransition(
              opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _masterCtrl.dispose();
    _glowCtrl.dispose();
    _floatCtrl.dispose();
    super.dispose();
  }

  // ── BUILD ────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([_masterCtrl, _glowCtrl, _floatCtrl]),
        builder: (_, __) {
          return FadeTransition(
            opacity: _exitFade,
            child: Stack(
              fit: StackFit.expand,
              children: [
                _buildBackground(),
                _buildParticles(),
                SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildNewspaper(),
                        const SizedBox(height: 32),
                        _buildTitle(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ── FONDO ────────────────────────────────────────────────────────
  Widget _buildBackground() {
    return FadeTransition(
      opacity: _bgFade,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [_bg1, _bg2, _bg3],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0, -0.3),
              radius: 0.8,
              colors: [_accent.withOpacity(0.08), Colors.transparent],
            ),
          ),
        ),
      ),
    );
  }

  // ── PARTÍCULAS ───────────────────────────────────────────────────
  Widget _buildParticles() {
    const pts = [
      (0.09, 0.13, 3.0, 0.0),
      (0.83, 0.19, 4.0, 0.5),
      (0.19, 0.73, 3.0, 0.9),
      (0.78, 0.66, 5.0, 0.2),
      (0.52, 0.07, 3.0, 0.7),
      (0.05, 0.53, 3.0, 1.1),
      (0.91, 0.47, 3.0, 0.3),
    ];
    return FadeTransition(
      opacity: _titleFade,
      child: LayoutBuilder(
        builder: (_, c) => Stack(
          children: pts.map((p) {
            final dy =
                math.sin(_floatCtrl.value * math.pi * 2 + p.$4 * math.pi) * 9;
            return Positioned(
              left: p.$1 * c.maxWidth,
              top: p.$2 * c.maxHeight + dy,
              child: Container(
                width: p.$3,
                height: p.$3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _accent2.withOpacity(0.45),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ── PERIÓDICO ────────────────────────────────────────────────────
  Widget _buildNewspaper() {
    return Transform.translate(
      offset: Offset(0, _floatY.value),
      child: Transform.rotate(
        angle: _paperUnfold.value + _floatRot.value,
        child: ScaleTransition(
          scale: _paperScale,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: _accent.withOpacity(_glow.value / 50),
                  blurRadius: _glow.value * 2,
                ),
                const BoxShadow(
                  color: Color(0x66000000),
                  blurRadius: 8,
                  offset: Offset(5, 5),
                ),
                const BoxShadow(
                  color: Color(0x22000000),
                  blurRadius: 4,
                  offset: Offset(10, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: SizedBox(
                width: 230,
                child: _buildPaperContent(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaperContent() {
    return Stack(
      children: [
        Container(color: _paper),
        // Línea de doblez
        Positioned.fill(
          child: Row(
            children: [
              const Spacer(),
              Container(
                width: 1,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color(0x1A000000),
                      Color(0x22000000),
                      Color(0x1A000000),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildMasthead(),
            _buildMetaBar(),
            _buildBody(),
            _buildFooter(),
          ],
        ),
      ],
    );
  }

  Widget _buildMasthead() {
    return Container(
      color: _mastBg,
      padding: const EdgeInsets.fromLTRB(12, 9, 12, 8),
      child: Column(
        children: [
          Text(
            'THE GREEN POST',
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: _accent,
              letterSpacing: 3.5,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Sustainable news for a better world',
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 7.5,
              color: _accent2.withOpacity(0.55),
              letterSpacing: 1.5,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 7),
            height: 2,
            color: _accent,
          ),
        ],
      ),
    );
  }

  Widget _buildMetaBar() {
    return Container(
      color: _mastBg2,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _metaText('Vol. XLVII · No. 312'),
          _metaText('★ Est. 1977 ★'),
          _metaText('Free Edition'),
        ],
      ),
    );
  }

  Widget _metaText(String t) => Text(
        t,
        style: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 7,
          color: _accent2.withOpacity(0.45),
        ),
      );

  Widget _buildBody() {
    return Container(
      color: _paper,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPhoto(),
          const SizedBox(height: 8),
          Container(height: 1.5, color: _ink.withOpacity(0.18)),
          const SizedBox(height: 7),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _buildColumn()),
                Container(width: 1, color: _ink.withOpacity(0.10)),
                Expanded(child: _buildColumn(alt: true)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoto() {
    return SizedBox(
      height: 72,
      child: CustomPaint(painter: _NewspaperPhotoPainter()),
    );
  }

  Widget _buildColumn({bool alt = false}) {
    return Padding(
      padding: EdgeInsets.only(
        left: alt ? 7 : 0,
        right: alt ? 0 : 7,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _inkLine(h: 8, w: 1.0, opacity: 0.38),
          const SizedBox(height: 4),
          _inkLine(h: 8, w: 0.75, opacity: 0.32),
          const SizedBox(height: 6),
          Container(height: 1, color: _ink.withOpacity(0.12)),
          const SizedBox(height: 6),
          _inkLine(h: 4.5, w: 1.0),
          const SizedBox(height: 4),
          _inkLine(h: 4.5, w: 0.88),
          const SizedBox(height: 4),
          _inkLine(h: 4.5, w: 1.0),
          const SizedBox(height: 4),
          _inkLine(h: 4.5, w: alt ? 0.70 : 0.80),
          const SizedBox(height: 4),
          _inkLine(h: 4.5, w: 1.0),
          const SizedBox(height: 4),
          _inkLine(h: 4.5, w: alt ? 0.92 : 0.65),
        ],
      ),
    );
  }

  Widget _inkLine({
    required double h,
    required double w,
    double opacity = 0.18,
  }) {
    return FractionallySizedBox(
      widthFactor: w,
      child: Container(
        height: h,
        decoration: BoxDecoration(
          color: _ink.withOpacity(opacity),
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: _mastBg,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _metaText('greenpost.eco'),
          Row(
            children: [
              Icon(Icons.eco, color: _accent.withOpacity(0.6), size: 9),
              const SizedBox(width: 3),
              _metaText('Recycled paper'),
            ],
          ),
          _metaText('Page 1 of 8'),
        ],
      ),
    );
  }

  // ── TÍTULO ───────────────────────────────────────────────────────
  Widget _buildTitle() {
    return FadeTransition(
      opacity: _titleFade,
      child: SlideTransition(
        position: _titleSlide,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Cinzel',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFF0FDF4),
              height: 1.35,
              shadows: [
                Shadow(
                  color: _accent.withOpacity(0.65),
                  blurRadius: _glow.value * 0.9,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
//  CustomPainter: escena genérica para la foto del periódico
// ══════════════════════════════════════════════════════════════════
class _NewspaperPhotoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final p = Paint()..isAntiAlias = true;

    // Cielo
    p.color = const Color(0xFF0F3D22);
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h * 0.58), p);

    // Suelo
    p.color = const Color(0xFF1A5C35);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.58, w, h * 0.42), p);

    // Hierba
    p.color = const Color(0xFF22803A).withOpacity(0.5);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.58, w, h * 0.07), p);

    // Sol
    p.color = const Color(0xFF34D399).withOpacity(0.4);
    canvas.drawCircle(Offset(w * 0.82, h * 0.20), 10, p);
    p.color = const Color(0xFF6EE7B7).withOpacity(0.55);
    canvas.drawCircle(Offset(w * 0.82, h * 0.20), 5.5, p);

    // Nubes
    p.color = const Color(0xFF34D399).withOpacity(0.10);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.22, h * 0.15), width: 36, height: 11),
        p);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.50, h * 0.10), width: 26, height: 9),
        p);

    // Montañas
    void mountain(double x1, double px, double x2, Color c) {
      final path = Path()
        ..moveTo(x1, h * 0.58)
        ..lineTo(px, h * 0.12)
        ..lineTo(x2, h * 0.58)
        ..close();
      p.color = c;
      canvas.drawPath(path, p);
    }

    mountain(0, w * 0.13, w * 0.26, const Color(0xFF155534));
    mountain(w * 0.18, w * 0.35, w * 0.52, const Color(0xFF1A6640));
    mountain(w * 0.44, w * 0.60, w * 0.76, const Color(0xFF155534));
    mountain(w * 0.66, w * 0.80, w * 0.95, const Color(0xFF1A6640));

    // Casas
    void house(
        double bx, double by, double hw, double hh, Color wall, Color roof) {
      p.color = wall;
      canvas.drawRect(Rect.fromLTWH(bx, by - hh, hw, hh), p);
      p.color = const Color(0xFF0A2E1A).withOpacity(0.35);
      canvas.drawRect(
          Rect.fromLTWH(bx + hw * 0.3, by - hh * 0.55, hw * 0.25, hh * 0.55),
          p);
      final r = Path()
        ..moveTo(bx - 1, by - hh)
        ..lineTo(bx + hw / 2, by - hh - hh * 0.55)
        ..lineTo(bx + hw + 1, by - hh)
        ..close();
      p.color = roof;
      canvas.drawPath(r, p);
    }

    house(w * 0.06, h * 0.58, 15, 10, const Color(0xFFE8D9B0),
        const Color(0xFFC8A060));
    house(w * 0.28, h * 0.58, 17, 11, const Color(0xFFEADED8),
        const Color(0xFF34D399));
    house(w * 0.54, h * 0.58, 13, 9, const Color(0xFFE0D4B8),
        const Color(0xFFC8A060));

    // Árboles
    void tree(double tx, double radius) {
      p.color = const Color(0xFF3D2A10);
      canvas.drawRect(
          Rect.fromLTWH(tx - 1.5, h * 0.58 - radius * 1.6, 3, radius * 1.6), p);
      p.color = const Color(0xFF22803A).withOpacity(0.9);
      canvas.drawCircle(Offset(tx, h * 0.58 - radius * 1.6), radius, p);
    }

    tree(w * 0.46, 5.5);
    tree(w * 0.74, 4.5);

    // Borde
    p
      ..color = const Color(0xFF34D399).withOpacity(0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class BiographyReadingPage extends StatefulWidget {
  const BiographyReadingPage({super.key});

  @override
  State<BiographyReadingPage> createState() => _BiographyReadingPageState();
}

class _BiographyReadingPageState extends State<BiographyReadingPage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  final String biographyText = '''
[MEXICO CITY] Homes made of discarded plastic bottles, construction waste and old tires are being built across Latin America as new technologies help turn municipal waste into sustainable bricks and tiles.

Across the region, recycling firms are turning their hands to construction, tackling a pollution problem and a housing crisis in one fell swoop.

“I have learned a lot about how to handle household waste to reduce the impact it generates on the environment,” said Javier Sebastian Folmer, a resident of the municipality of Crespo, in the province of Entre Ríos, just north of the Argentinian capital Buenos Aires.
''';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkScrollEnd);

    // Inicialización segura del controller
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
  }

  void _checkScrollEnd() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    const threshold = 20.0;

    if (currentScroll >= maxScroll - threshold && !showButton) {
      setState(() => showButton = true);
    } else if (currentScroll < maxScroll - threshold && showButton) {
      setState(() => showButton = false);
    }
  }

  void _goToQuestions() {
    setState(() => animating = true);

    // Reiniciar y reproducir la animación
    _fadeController.reset();
    _fadeController.forward();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => QuestionPage(questions: sampleQuestions),
        ),
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  biographyText,
                  style: const TextStyle(fontSize: 18, height: 1.6),
                ),
                const SizedBox(height: 32),
                AnimatedOpacity(
                  opacity: showButton ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: Column(
                    children: [
                      Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 21, 147, 23),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: _goToQuestions,
                          icon: const Icon(Icons.arrow_forward,
                              color: Colors.black),
                          label: const Text(
                            "Go to Questions",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (animating)
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                color: Colors.white.withOpacity(0.5),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                          color: Color.fromARGB(255, 21, 147, 23)),
                      SizedBox(height: 16),
                      Text(
                        "Going to Questions...",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 21, 147, 23),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Preguntas de ejemplo
final List<QuestionData> sampleQuestions = [
  QuestionData(
    question:
        '"Across the region, recycling firms are turning their hands to construction, tackling a pollution problem and a housing crisis in one fell swoop."\n\nWhat does “their hands” refer to?',
    options: [
      "A) Local governments",
      "B) Construction workers",
      "C) Recycling firms",
      "D) Homeowners"
    ],
    correctIndex: 2,
    explanation:
        '“Their hands” refers to recycling firms, which are described as expanding their work into construction to address pollution and housing problems.',
    incorrectExplanations: [
      ' Local governments are not mentioned as changing activities in the sentence.',
      ' Construction workers are not the subject turning their hands to construction.',
      ' Correct answer!',
      ' Homeowners are not referenced in this context.',
    ],
  ),
  QuestionData(
    question:
        '"I have learned a lot about how to handle household waste to reduce the impact it generates on the environment."\n\nWhat does “it” refer to?',
    options: [
      "A) The housing crisis",
      "B) Household trash",
      "C) Construction technology",
      "D) The environment"
    ],
    correctIndex: 1,
    explanation:
        '“It” refers to household waste (trash), which is the subject the speaker discusses in relation to environmental impact.',
    incorrectExplanations: [
      ' The housing crisis is not mentioned in this sentence.',
      ' Correct answer!',
      ' Construction technology is not discussed here.',
      ' The environment is affected, but it is not what “it” refers to.',
    ],
  ),
];

// Pantalla de preguntas con animación simple
class QuestionPage extends StatefulWidget {
  final List<QuestionData> questions;

  const QuestionPage({super.key, required this.questions});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int currentQuestionIndex = 0;
  int? selected;
  bool showFeedback = false;
  bool _isCorrect = false;
  String _feedbackText = '';

  static const Color accentDark = Color(0xFF2E7D32); // verde oscuro
  static const Color cardBg = Color(0xFFF1F8E9);     // crema verdoso

  void _submitAnswer() {
    final current = widget.questions[currentQuestionIndex];
    final isCorrect = selected == current.correctIndex;

    String explanationText;
    if (isCorrect) {
      explanationText = current.explanation;
    } else if (current.incorrectExplanations != null &&
        selected != null &&
        selected! < current.incorrectExplanations!.length) {
      explanationText = current.incorrectExplanations![selected!];
    } else {
      explanationText = 'Incorrect answer.';
    }

    setState(() {
      showFeedback = true;
      _isCorrect = isCorrect;
      _feedbackText = explanationText;
    });
  }

  void _goNext() {
    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selected = null;
        showFeedback = false;
        _isCorrect = false;
        _feedbackText = '';
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => BiographyReadingPageSecond()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      body: Stack(
        children: [
          // Fondo degradado
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF81C784), // verde suave
                  Color(0xFF4DB6AC), // teal elegante
                ],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Column(
                  key: ValueKey<int>(currentQuestionIndex),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    // Tarjeta de pregunta
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF66BB6A), // verde medio
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: accentDark.withOpacity(0.18),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Text(
                        question.question,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Botones de opciones
                    ...List.generate(question.options.length, (i) {
                      final isSelected = selected == i;

                      return GestureDetector(
                        onTap: showFeedback
                            ? () {}
                            : () => setState(() => selected = i),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF66BB6A) // verde medio
                                  : const Color(0xFFE0E0E0),
                              width: 1.8,
                            ),
                          ),
                          child: Text(
                            question.options[i],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }),

                    // Botón enviar o feedback
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF43A047), // verde botón
                            disabledBackgroundColor:
                                accentDark.withOpacity(0.35),
                            elevation: 4,
                            shadowColor: accentDark.withOpacity(0.4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      )
                    else
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _isCorrect
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _isCorrect
                                ? const Color.fromARGB(255, 77, 218, 82)
                                : Colors.red.shade300,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              _feedbackText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _isCorrect
                                    ? const Color.fromARGB(255, 2, 135, 9)
                                    : Colors.red.shade700,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isCorrect
                                    ? const Color.fromARGB(255, 2, 135, 9)
                                    : Colors.red.shade600,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 11,
                                ),
                              ),
                              onPressed: _goNext,
                              child: Text(
                                currentQuestionIndex ==
                                        widget.questions.length - 1
                                    ? "Finish"
                                    : "Next",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BiographyReadingPageSecond extends StatefulWidget {
  const BiographyReadingPageSecond({super.key});

  @override
  State<BiographyReadingPageSecond> createState() =>
      _BiographyReadingPageSecondState();
}

class _BiographyReadingPageSecondState
    extends State<BiographyReadingPageSecond> {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  final String biographyTextSecond = '''
Folmer, who runs the municipality’s Environmental Park, is one of an army of citizens in the region whose perception of waste has been transformed because they became part of the process that recovers it and turns it into raw materials for housing.

Every month, the park receives between 3,000 and 5,000 kilos of plastic bottles discarded by the city’s 23,000 inhabitants.

These bottles undergo a process that includes crushing and compression in a recycling plant to transform them into nearly 10,000 bricks.

“I think that in some way I changed the way I consume,” Folmer told SciDev.Net. “Everywhere I go, I bring my own reusable bag.”

The science behind the plant came from the Experimental Center for Economic Housing (CEVE in Spanish), in Córdoba, Argentina, a department of the National Council for Scientific and Technical Research.
''';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkScrollEnd);
  }

  void _checkScrollEnd() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    const threshold = 20.0;

    if (currentScroll >= maxScroll - threshold && !showButton) {
      setState(() => showButton = true);
    } else if (currentScroll < maxScroll - threshold && showButton) {
      setState(() => showButton = false);
    }
  }

  void _goToQuestions() {
    setState(() => animating = true);

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => QuestionPageSecond(questions: sampleQuestionsSecond),
        ),
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  biographyTextSecond,
                  style: const TextStyle(fontSize: 18, height: 1.6),
                ),
                const SizedBox(height: 32),
                AnimatedOpacity(
                  opacity: showButton ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: Column(
                    children: [
                      Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 21, 147, 23),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: _goToQuestions,
                          icon: const Icon(Icons.arrow_forward,
                              color: Colors.black),
                          label: const Text("Go to Next Questions",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (animating)
            Container(
              color: Colors.white.withOpacity(0.5),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                        color: Color.fromARGB(255, 21, 147, 23)),
                    SizedBox(height: 16),
                    Text(
                      "Going to Questions...",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 21, 147, 23),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class QuestionData {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final List<String>? incorrectExplanations;

  QuestionData({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    this.incorrectExplanations,
  });
}

final List<QuestionData> sampleQuestionsSecond = [
  QuestionData(
    question:
        '"In the region whose perception of waste has been transformed because they became part of the process that recovers it and turns it into raw materials for housing."\n\nWhat does “it” refer to?',
    options: [
      "A) The municipality’s Environmental Park",
      "B) The waste",
      "C) The recycling process",
      "D) The plastic bottles"
    ],
    correctIndex: 1,
    explanation:
        '“It” refers to the waste that is being transformed into raw materials for housing.',
    incorrectExplanations: [
      ' The Environmental Park is not what is transformed into raw materials.',
      ' Correct answer!',
      ' The recycling process performs the action but is not what “it” refers to.',
      ' Plastic bottles are a type of waste, but they are not explicitly referenced here.',
    ],
  ),
  QuestionData(
    question:
        '"These bottles undergo a process that includes crushing and compression in a recycling plant to transform them into nearly 10,000 bricks."\n\nWhat does “them” refer to?',
    options: [
      "A) The bottles",
      "B) The bricks",
      "C) The raw materials",
      "D) The inhabitants"
    ],
    correctIndex: 0,
    explanation:
        '“Them” refers to the plastic bottles that undergo the recycling process.',
    incorrectExplanations: [
      ' Correct answer!',
      ' The bricks are the result of the process, not what “them” refers to.',
      ' Raw materials are the outcome, not the object being transformed.',
      ' The inhabitants are not mentioned in this sentence.',
    ],
  ),
];

class QuestionPageSecond extends StatefulWidget {
  final List<QuestionData> questions;

  const QuestionPageSecond({super.key, required this.questions});

  @override
  State<QuestionPageSecond> createState() => _QuestionPageSecondState();
}

class _QuestionPageSecondState extends State<QuestionPageSecond> {
   int currentQuestionIndex = 0;
  int? selected;
  bool showFeedback = false;
  bool _isCorrect = false;
  String _feedbackText = '';

  static const Color accentDark = Color(0xFF2E7D32); // verde oscuro
  static const Color cardBg = Color(0xFFF1F8E9);     // crema verdoso

  void _submitAnswer() {
    final current = widget.questions[currentQuestionIndex];
    final isCorrect = selected == current.correctIndex;

    String explanationText;
    if (isCorrect) {
      explanationText = current.explanation;
    } else if (current.incorrectExplanations != null &&
        selected != null &&
        selected! < current.incorrectExplanations!.length) {
      explanationText = current.incorrectExplanations![selected!];
    } else {
      explanationText = 'Incorrect answer.';
    }

    setState(() {
      showFeedback = true;
      _isCorrect = isCorrect;
      _feedbackText = explanationText;
    });
  }

  void _goNext() {
    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selected = null;
        showFeedback = false;
        _isCorrect = false;
        _feedbackText = '';
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => BiographyReadingPageThird()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      body: Stack(
        children: [
          // Fondo degradado
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF81C784), // verde suave
                  Color(0xFF4DB6AC), // teal elegante
                ],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Column(
                  key: ValueKey<int>(currentQuestionIndex),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    // Tarjeta de pregunta
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF66BB6A), // verde medio
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: accentDark.withOpacity(0.18),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Text(
                        question.question,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Botones de opciones
                    ...List.generate(question.options.length, (i) {
                      final isSelected = selected == i;

                      return GestureDetector(
                        onTap: showFeedback
                            ? () {}
                            : () => setState(() => selected = i),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF66BB6A) // verde medio
                                  : const Color(0xFFE0E0E0),
                              width: 1.8,
                            ),
                          ),
                          child: Text(
                            question.options[i],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }),

                    // Botón enviar o feedback
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF43A047), // verde botón
                            disabledBackgroundColor:
                                accentDark.withOpacity(0.35),
                            elevation: 4,
                            shadowColor: accentDark.withOpacity(0.4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      )
                    else
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _isCorrect
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _isCorrect
                                ? const Color.fromARGB(255, 77, 218, 82)
                                : Colors.red.shade300,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              _feedbackText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _isCorrect
                                    ? const Color.fromARGB(255, 2, 135, 9)
                                    : Colors.red.shade700,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isCorrect
                                    ? const Color.fromARGB(255, 2, 135, 9)
                                    : Colors.red.shade600,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 11,
                                ),
                              ),
                              onPressed: _goNext,
                              child: Text(
                                currentQuestionIndex ==
                                        widget.questions.length - 1
                                    ? "Finish"
                                    : "Next",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BiographyReadingPageThird extends StatefulWidget {
  const BiographyReadingPageThird({super.key});

  @override
  State<BiographyReadingPageThird> createState() =>
      _BiographyReadingPageThirdState();
}

class _BiographyReadingPageThirdState extends State<BiographyReadingPageThird> {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  final String biographyTextSecond = '''
Shredded rubber

At CEVE, researcher María Paz Sánchez Amono uses shredded rubber that comes from old tires, as well as plastics from discarded pipes, bags and barrels and turns them into tiles through a heated moulding process.

The process is then transferred to governments, companies and organizations so that they can establish their own recycling plants, like the one in Crespo.

“There are social, environmental and housing projects throughout the entire Argentinian territory, carried out with CEVE systems and components,” Sánchez Amono told SciDev.Net.

This transfer has allowed people from different parts of the country to take ownership of the technology and work with it to reduce waste, but also to become aware of the importance of transforming it into something useful.

“The plant changed our perspective,” Gabriel Fontana, who is in charge of the recycling plant in Crespo, told SciDev.Net. “Garbage is no longer garbage but a usable resource.”
''';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkScrollEnd);
  }

  void _checkScrollEnd() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    const threshold = 20.0;

    if (currentScroll >= maxScroll - threshold && !showButton) {
      setState(() => showButton = true);
    } else if (currentScroll < maxScroll - threshold && showButton) {
      setState(() => showButton = false);
    }
  }

  void _goToQuestions() {
    setState(() => animating = true);

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => QuestionPageThird(questions: sampleQuestionsThird),
        ),
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ TÍTULO EN NEGRILLA
                    const Text(
                      "Shredded rubber",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ✅ TEXTO NORMAL
                    Text(
                      biographyTextSecond.replaceFirst(
                          "Shredded rubber\n\n", ""),
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                AnimatedOpacity(
                  opacity: showButton ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: Column(
                    children: [
                      Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 21, 147, 23),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: _goToQuestions,
                          icon: const Icon(Icons.arrow_forward,
                              color: Colors.black),
                          label: const Text("Go to Next Questions",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (animating)
            Container(
              color: Colors.white.withOpacity(0.5),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                        color: Color.fromARGB(255, 21, 147, 23)),
                    SizedBox(height: 16),
                    Text(
                      "Going to Questions...",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 21, 147, 23),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

final List<QuestionData> sampleQuestionsThird = [
  QuestionData(
    question:
        '"Shredded rubber that comes from old tires, as well as plastics from discarded pipes, bags and barrels and turns them into tiles through a heated moulding process."\n\nWhat does “them” refer to?',
    options: [
      "A) Old tires and plastic bottles",
      "B) Recycling plants and landfills",
      "C) Tiles and bricks",
      "D) Shredded rubber and plastics"
    ],
    correctIndex: 3,
    explanation:
        '“Them” refers to the shredded rubber and plastics, which are the materials being transformed into tiles.',
    incorrectExplanations: [
      ' Old tires and bottles are sources, but not what “them” directly refers to.',
      ' Recycling plants and landfills are not materials being transformed.',
      ' Tiles and bricks are the final products, not the objects referred to.',
      ' Correct answer!',
    ],
  ),
  QuestionData(
    question:
        '"This transfer has allowed people from different parts of the country to take ownership of the technology and work with it to reduce waste."\n\nWhat does “it” refer to?',
    options: [
      "A) Waste",
      "B) The country",
      "C) The recycling plant in Crespo",
      "D) The technology"
    ],
    correctIndex: 3,
    explanation:
        '“It” refers to the technology that people are using to reduce waste after taking ownership of it.',
    incorrectExplanations: [
      ' Waste is what they want to reduce, but it is not what “it” refers to.',
      ' The country is not something people can “work with” in this context.',
      ' The recycling plant is not mentioned as being transferred.',
      ' Correct answer!',
    ],
  ),
];

class QuestionPageThird extends StatefulWidget {
  final List<QuestionData> questions;

  const QuestionPageThird({super.key, required this.questions});

  @override
  State<QuestionPageThird> createState() => _QuestionPageThirdState();
}

class _QuestionPageThirdState extends State<QuestionPageThird> {
   int currentQuestionIndex = 0;
  int? selected;
  bool showFeedback = false;
  bool _isCorrect = false;
  String _feedbackText = '';

  static const Color accentDark = Color(0xFF2E7D32); // verde oscuro
  static const Color cardBg = Color(0xFFF1F8E9);     // crema verdoso

  void _submitAnswer() {
    final current = widget.questions[currentQuestionIndex];
    final isCorrect = selected == current.correctIndex;

    String explanationText;
    if (isCorrect) {
      explanationText = current.explanation;
    } else if (current.incorrectExplanations != null &&
        selected != null &&
        selected! < current.incorrectExplanations!.length) {
      explanationText = current.incorrectExplanations![selected!];
    } else {
      explanationText = 'Incorrect answer.';
    }

    setState(() {
      showFeedback = true;
      _isCorrect = isCorrect;
      _feedbackText = explanationText;
    });
  }

  void _goNext() {
    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selected = null;
        showFeedback = false;
        _isCorrect = false;
        _feedbackText = '';
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => BiographyReadingPageFinal()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      body: Stack(
        children: [
          // Fondo degradado
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF81C784), // verde suave
                  Color(0xFF4DB6AC), // teal elegante
                ],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Column(
                  key: ValueKey<int>(currentQuestionIndex),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    // Tarjeta de pregunta
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF66BB6A), // verde medio
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: accentDark.withOpacity(0.18),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Text(
                        question.question,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Botones de opciones
                    ...List.generate(question.options.length, (i) {
                      final isSelected = selected == i;

                      return GestureDetector(
                        onTap: showFeedback
                            ? () {}
                            : () => setState(() => selected = i),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF66BB6A) // verde medio
                                  : const Color(0xFFE0E0E0),
                              width: 1.8,
                            ),
                          ),
                          child: Text(
                            question.options[i],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }),

                    // Botón enviar o feedback
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF43A047), // verde botón
                            disabledBackgroundColor:
                                accentDark.withOpacity(0.35),
                            elevation: 4,
                            shadowColor: accentDark.withOpacity(0.4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      )
                    else
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _isCorrect
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _isCorrect
                                ? const Color.fromARGB(255, 77, 218, 82)
                                : Colors.red.shade300,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              _feedbackText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _isCorrect
                                    ? const Color.fromARGB(255, 2, 135, 9)
                                    : Colors.red.shade700,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isCorrect
                                    ? const Color.fromARGB(255, 2, 135, 9)
                                    : Colors.red.shade600,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 11,
                                ),
                              ),
                              onPressed: _goNext,
                              child: Text(
                                currentQuestionIndex ==
                                        widget.questions.length - 1
                                    ? "Finish"
                                    : "Next",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BiographyReadingPageFinal extends StatefulWidget {
  const BiographyReadingPageFinal({super.key});

  @override
  State<BiographyReadingPageFinal> createState() =>
      _BiographyReadingPageFinalState();
}

class _BiographyReadingPageFinalState extends State<BiographyReadingPageFinal> {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  final String biographyTextSecond = '''
For Jerónimo Kreiker, who is in charge of making the CEVE technology available to other organizations, this type of project has a significant impact on society, because it generates jobs, helps revalue waste, and improves environmental management.

“They are simple technologies with a low investment cost, but with an enormous social and environmental impact for any society,” he said.

These processes answer a pressing need for housing in Argentina, and across the region.

“In Argentina, the lack of access to housing affects almost all sectors of the population,” said CEVE researcher Sánchez Amono.

According to 2023 data from CAF Development Bank of Latin America and the Caribbean, almost 70 million people across the region lack adequate housing.

“In Crespo, there is also a housing deficit – we are more and more, and more people are arriving,” explained Raquel Gorostiaga, project manager of the Environmental Park in Crespo.

Five houses made with the plastic tiles will be inaugurated in Crespo this year.Top of Form

“The idea is to provide these houses for low-income seniors,” explained Gorostiaga.
''';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkScrollEnd);
  }

  void _checkScrollEnd() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    const threshold = 20.0;

    if (currentScroll >= maxScroll - threshold && !showButton) {
      setState(() => showButton = true);
    } else if (currentScroll < maxScroll - threshold && showButton) {
      setState(() => showButton = false);
    }
  }

  void _goToQuestions() {
    setState(() => animating = true);

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => QuestionPageFinal(questions: sampleQuestionsFinal),
        ),
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  biographyTextSecond,
                  style: const TextStyle(fontSize: 18, height: 1.6),
                ),
                const SizedBox(height: 32),
                AnimatedOpacity(
                  opacity: showButton ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: Column(
                    children: [
                      Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 21, 147, 23),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: _goToQuestions,
                          icon: const Icon(Icons.arrow_forward,
                              color: Colors.black),
                          label: const Text("Go to Next Questions",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (animating)
            Container(
              color: Colors.white.withOpacity(0.5),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                        color: Color.fromARGB(255, 21, 147, 23)),
                    SizedBox(height: 16),
                    Text(
                      "Going to Questions...",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 21, 147, 23),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

final List<QuestionData> sampleQuestionsFinal = [
  QuestionData(
    question:
        '"These processes answer a pressing need for housing in Argentina, and across the region."\n\nWhat does “these processes” refer to?',
    options: [
      "A) Government housing policies",
      "B) Traditional construction methods",
      "C) CEVE’s technologies and methods",
      "D) Population growth in Crespo"
    ],
    correctIndex: 2,
    explanation:
        '“These processes” refers to the technologies and methods developed by CEVE that transform waste into housing materials.',
    incorrectExplanations: [
      ' Government policies are not mentioned as the processes being discussed.',
      ' Traditional construction methods are not the focus of the sentence.',
      ' Correct answer!',
      ' Population growth explains the need, but it is not what “these processes” refers to.',
    ],
  ),
  QuestionData(
    question:
        '"In Crespo, there is also a housing deficit — we are more and more people are arriving," explained Raquel Gorostiaga.\n\nWhat does “we” refer to?',
    options: [
      "A) CEVE researchers",
      "B) Low-income seniors",
      "C) Residents of Crespo",
      "D) Project managers of the Environmental Park"
    ],
    correctIndex: 2,
    explanation:
        '“We” refers to the people living in Crespo, whose growing population is contributing to the housing deficit.',
    incorrectExplanations: [
      ' CEVE researchers are not the speakers in this statement.',
      ' Low-income seniors are not mentioned in this context.',
      ' Correct answer!',
      ' Project managers are not identified as part of the quoted group.',
    ],
  ),
];

class QuestionPageFinal extends StatefulWidget {
  final List<QuestionData> questions;

  const QuestionPageFinal({super.key, required this.questions});

  @override
  State<QuestionPageFinal> createState() => _QuestionPageFinalState();
}

class _QuestionPageFinalState extends State<QuestionPageFinal> {
    int currentQuestionIndex = 0;
  int? selected;
  bool showFeedback = false;
  bool _isCorrect = false;
  String _feedbackText = '';

  static const Color accentDark = Color(0xFF2E7D32); // verde oscuro
  static const Color cardBg = Color(0xFFF1F8E9);     // crema verdoso

  void _submitAnswer() {
    final current = widget.questions[currentQuestionIndex];
    final isCorrect = selected == current.correctIndex;

    String explanationText;
    if (isCorrect) {
      explanationText = current.explanation;
    } else if (current.incorrectExplanations != null &&
        selected != null &&
        selected! < current.incorrectExplanations!.length) {
      explanationText = current.incorrectExplanations![selected!];
    } else {
      explanationText = 'Incorrect answer.';
    }

    setState(() {
      showFeedback = true;
      _isCorrect = isCorrect;
      _feedbackText = explanationText;
    });
  }

  void _goNext() {
    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selected = null;
        showFeedback = false;
        _isCorrect = false;
        _feedbackText = '';
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => Final_Path()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      body: Stack(
        children: [
          // Fondo degradado
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF81C784), // verde suave
                  Color(0xFF4DB6AC), // teal elegante
                ],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Column(
                  key: ValueKey<int>(currentQuestionIndex),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    // Tarjeta de pregunta
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF66BB6A), // verde medio
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: accentDark.withOpacity(0.18),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Text(
                        question.question,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Botones de opciones
                    ...List.generate(question.options.length, (i) {
                      final isSelected = selected == i;

                      return GestureDetector(
                        onTap: showFeedback
                            ? () {}
                            : () => setState(() => selected = i),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF66BB6A) // verde medio
                                  : const Color(0xFFE0E0E0),
                              width: 1.8,
                            ),
                          ),
                          child: Text(
                            question.options[i],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }),

                    // Botón enviar o feedback
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF43A047), // verde botón
                            disabledBackgroundColor:
                                accentDark.withOpacity(0.35),
                            elevation: 4,
                            shadowColor: accentDark.withOpacity(0.4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      )
                    else
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _isCorrect
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _isCorrect
                                ? const Color.fromARGB(255, 77, 218, 82)
                                : Colors.red.shade300,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              _feedbackText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _isCorrect
                                    ? const Color.fromARGB(255, 2, 135, 9)
                                    : Colors.red.shade700,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isCorrect
                                    ? const Color.fromARGB(255, 2, 135, 9)
                                    : Colors.red.shade600,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 11,
                                ),
                              ),
                              onPressed: _goNext,
                              child: Text(
                                currentQuestionIndex ==
                                        widget.questions.length - 1
                                    ? "Finish"
                                    : "Next",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}