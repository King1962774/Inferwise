import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Dark Blue/Content/Spot4/Spot_Page/ReadingSpot.dart';

import 'dart:math' as math;

class BambooSustainableHousingSplash extends StatefulWidget {
  const BambooSustainableHousingSplash({super.key});

  @override
  State<BambooSustainableHousingSplash> createState() =>
      _BambooSustainableHousingSplashState();
}

class _BambooSustainableHousingSplashState
    extends State<BambooSustainableHousingSplash>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _pulseController;
  late AnimationController _particleController;

  late Animation<double> _fadeIn;
  late Animation<double> _scaleUp;
  late Animation<double> _dividerWidth;
  late Animation<double> _titleSlide;
  late Animation<double> _titleFade;
  late Animation<double> _authorsFade;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      duration: const Duration(milliseconds: 2200),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _particleController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();

    _fadeIn = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );

    _scaleUp = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    _dividerWidth = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.4, 0.65, curve: Curves.easeOut),
      ),
    );

    _titleSlide = Tween<double>(begin: 28.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 0.78, curve: Curves.easeOut),
      ),
    );

    _titleFade = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.5, 0.78, curve: Curves.easeOut),
    );

    _authorsFade = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.72, 1.0, curve: Curves.easeOut),
    );

    _pulse = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _mainController.forward();

    Future.delayed(const Duration(milliseconds: 5500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const Low_Cost(),
            transitionsBuilder: (_, animation, __, child) => FadeTransition(
              opacity: animation,
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
    _pulseController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07030F),
      body: Stack(
        children: [
          // Floating leaf particles
          AnimatedBuilder(
            animation: _particleController,
            builder: (context, _) => CustomPaint(
              painter: _LeafParticlePainter(_particleController.value),
              size: MediaQuery.of(context).size,
            ),
          ),

          // Radial purple glow
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 0.85,
                colors: [
                  Color(0x2E7C3AED),
                  Color(0x00000000),
                ],
              ),
            ),
          ),

          // Main content
          Center(
            child: AnimatedBuilder(
              animation: _mainController,
              builder: (context, _) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon with pulse + glow
                    FadeTransition(
                      opacity: _fadeIn,
                      child: ScaleTransition(
                        scale: _scaleUp,
                        child: AnimatedBuilder(
                          animation: _pulse,
                          builder: (context, _) => Transform.scale(
                            scale: _pulse.value,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF7C3AED).withOpacity(
                                      0.2 +
                                          0.35 *
                                              (_pulse.value - 1.0) /
                                              0.15,
                                    ),
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: CustomPaint(
                                size: const Size(72, 72),
                                painter: _BambooHouseIconPainter(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Expanding divider
                    FractionallySizedBox(
                      widthFactor: _dividerWidth.value * 0.52,
                      child: Container(
                        height: 1,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Color(0xFFA855F7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Title slide-up
                    Opacity(
                      opacity: _titleFade.value,
                      child: Transform.translate(
                        offset: Offset(0, _titleSlide.value),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            "Bamboo as a Sustainable\nBuilding Material",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.dmSerifDisplay(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFFF3ECFF),
                              height: 1.6,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Authors fade-in
                    FadeTransition(
                      opacity: _authorsFade,
                      child: Text(
                        "By Jan Bredenoord, 2025",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmMono(
                          fontSize: 11,
                          color: Colors.white30,
                          letterSpacing: 0.7,
                          height: 1.8,
                        ),
                      ),
                    ),
                                                                                const SizedBox(height: 18),

                    // Authors fade-in
                    FadeTransition(
                      opacity: _authorsFade,
                      child: Text(
                        "From MDPI",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmMono(
                          fontSize: 10,
                          color: Colors.white30,
                          letterSpacing: 0.7,
                          height: 1.8,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Bamboo House Icon painter ─────────────────────────────────────────────────

class _BambooHouseIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double s = size.width / 24;

    final mainPaint = Paint()
      ..color = const Color(0xFFD8B4FE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final accentPaint = Paint()
      ..color = const Color(0xFFA78BFA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final leafPaint = Paint()
      ..color = const Color(0xFFC4B5FD).withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    // Roof
    final roofPath = Path();
    roofPath.moveTo(3 * s, 11 * s);
    roofPath.lineTo(12 * s, 3 * s);
    roofPath.lineTo(21 * s, 11 * s);
    canvas.drawPath(roofPath, mainPaint);

    // House body
    final housePath = Path();
    housePath.moveTo(5 * s, 9.5 * s);
    housePath.lineTo(5 * s, 20 * s);
    housePath.arcToPoint(
      Offset(6 * s, 21 * s),
      radius: const Radius.circular(1),
    );
    housePath.lineTo(10 * s, 21 * s);
    housePath.lineTo(10 * s, 17 * s);
    housePath.lineTo(14 * s, 17 * s);
    housePath.lineTo(14 * s, 21 * s);
    housePath.lineTo(18 * s, 21 * s);
    housePath.arcToPoint(
      Offset(19 * s, 20 * s),
      radius: const Radius.circular(1),
    );
    housePath.lineTo(19 * s, 9.5 * s);
    canvas.drawPath(housePath, mainPaint);

    // Bamboo stalk left
    canvas.drawLine(Offset(2 * s, 22 * s), Offset(2 * s, 10 * s), accentPaint);
    canvas.drawLine(Offset(1 * s, 16 * s), Offset(3 * s, 16 * s), accentPaint);
    canvas.drawLine(Offset(1 * s, 13 * s), Offset(3 * s, 13 * s), accentPaint);

    // Bamboo stalk right
    canvas.drawLine(Offset(22 * s, 22 * s), Offset(22 * s, 10 * s), accentPaint);
    canvas.drawLine(Offset(21 * s, 16 * s), Offset(23 * s, 16 * s), accentPaint);
    canvas.drawLine(Offset(21 * s, 13 * s), Offset(23 * s, 13 * s), accentPaint);

    // Leaf accent left
    final leftLeaf = Path();
    leftLeaf.moveTo(2 * s, 10 * s);
    leftLeaf.quadraticBezierTo(4 * s, 8 * s, 3 * s, 6 * s);
    canvas.drawPath(leftLeaf, leafPaint);

    // Leaf accent right
    final rightLeaf = Path();
    rightLeaf.moveTo(22 * s, 10 * s);
    rightLeaf.quadraticBezierTo(20 * s, 8 * s, 21 * s, 6 * s);
    canvas.drawPath(rightLeaf, leafPaint);
  }

  @override
  bool shouldRepaint(_BambooHouseIconPainter old) => false;
}

// ── Leaf particle painter ─────────────────────────────────────────────────────

class _LeafParticlePainter extends CustomPainter {
  final double progress;

  static final List<_LeafParticle> _particles = List.generate(20, (i) {
    return _LeafParticle(
      x: (i * 137.508) % 1.0,
      y: (i * 97.3) % 1.0,
      size: 6.0 + (i % 4) * 2.5,
      speed: 0.035 + (i % 5) * 0.016,
      phase: (i * 0.43) % 1.0,
      driftX: ((i % 7) - 3) * 0.012,
      rotSpeed: ((i % 5) - 2) * 0.8,
      shapeType: i % 3,
    );
  });

  _LeafParticlePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in _particles) {
      final t = (p.y + progress * p.speed + p.phase) % 1.0;
      final x =
          (p.x + p.driftX * math.sin(progress * math.pi * 2 + p.phase * 5)) *
              size.width;
      final y = (1.0 - t) * size.height;
      final rotation =
          progress * math.pi * 2 * p.rotSpeed + p.phase * 6;
      final opacity =
          (t < 0.1 ? t / 0.1 : t > 0.85 ? (1.0 - t) / 0.15 : 1.0) * 0.38;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rotation);

      final colors = [
        const Color(0xFFA855F7),
        const Color(0xFF7C3AED),
        const Color(0xFFD8B4FE),
      ];

      final paint = Paint()
        ..color = colors[p.shapeType].withOpacity(opacity)
        ..style = PaintingStyle.fill;

      _drawLeaf(canvas, paint, p.size, p.shapeType);
      canvas.restore();
    }
  }

  void _drawLeaf(Canvas canvas, Paint paint, double size, int type) {
    final path = Path();
    switch (type) {
      case 0:
        path.addOval(Rect.fromCenter(
          center: Offset.zero,
          width: size,
          height: size * 1.6,
        ));
        break;
      case 1:
        path.moveTo(0, -size * 0.9);
        path.quadraticBezierTo(size * 0.6, 0, 0, size * 0.9);
        path.quadraticBezierTo(-size * 0.6, 0, 0, -size * 0.9);
        break;
      case 2:
        path.addOval(Rect.fromCenter(
          center: Offset.zero,
          width: size * 0.7,
          height: size * 0.7,
        ));
        break;
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_LeafParticlePainter old) => true;
}

class _LeafParticle {
  final double x, y, size, speed, phase, driftX, rotSpeed;
  final int shapeType;

  const _LeafParticle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.phase,
    required this.driftX,
    required this.rotSpeed,
    required this.shapeType,
  });
}

class Low_Cost extends StatefulWidget {
  const Low_Cost({super.key});
  @override
  State<Low_Cost> createState() => _Low_CostState();
}

class _Low_CostState extends State<Low_Cost> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is bamboo's classification?",
      "options": ["A) Moss", "B) Tree", "C) Fern", "D) Flowering plant"],
      "correct": 3,
      "feedback": [
        " Moss is a non-vascular plant, not related to bamboo.",
        " Bamboo is not a tree, although it can grow very tall.",
        " Bamboo is not a fern; it has different structural features.",
        " Correct! Bamboo is classified as a flowering plant and is part of the grass family. 🌷"
      ]
    },
    {
      "question": "How fast can bamboo grow?",
      "options": [
        "A) 1 inch per day",
        "B) 3 feet per day",
        "C) 1 foot per month",
        "D) 2 inches per year"
      ],
      "correct": 1,
      "feedback": [
        " Some species grow faster than 1 inch per day.",
        " Correct! Bamboo can grow up to 3 feet per day under optimal conditions. 🌿",
        " 1 foot per month is much slower than its real growth rate.",
        " 2 inches per year is inaccurate; bamboo grows much faster."
      ]
    },
    {
      "question": "Which of the following products can be made from bamboo?",
      "options": [
        "A) Furniture, paper, and clothing",
        "B) Only paper",
        "C) Only flooring",
        "D) Only food"
      ],
      "correct": 0,
      "feedback": [
        " Correct! Bamboo can be used to make furniture, paper, and clothing. 🪑📄👕",
        " Bamboo is not limited to paper production.",
        " Bamboo is used for more than just flooring.",
        " Bamboo is not only used for food; it's versatile."
      ]
    },
    {
      "question": "Bamboo is known to be environmentally friendly. Why?",
      "options": [
        "A) It requires very little water",
        "B) It absorbs large amounts of carbon dioxide and produces oxygen",
        "C) It grows in very hot climates",
        "D) It is resistant to pests"
      ],
      "correct": 1,
      "feedback": [
        " While bamboo doesn't require excessive water, this isn't its key environmental benefit.",
        " Correct! Bamboo is a great carbon sink that helps fight climate change by absorbing carbon dioxide and releasing oxygen. 🌱",
        " Its ability to grow in hot climates is not the primary reason it's eco-friendly.",
        " Pest resistance is useful, but not the main reason it's considered environmentally friendly."
      ]
    },
    {
      "question": "How strong is bamboo compared to steel?",
      "options": [
        "A) Bamboo is weaker than steel",
        "B) Bamboo is not strong at all",
        "C) Bamboo is stronger than steel",
        "D) Bamboo is as strong as steel in tension"
      ],
      "correct": 3,
      "feedback": [
        " Bamboo is surprisingly strong and can rival steel in specific conditions.",
        " This is incorrect; bamboo is very strong structurally.",
        " Bamboo can be as strong as steel in tension, not necessarily stronger.",
        " Correct! Bamboo is incredibly strong in tension, sometimes even stronger than steel of the same weight. 💪"
      ]
    }
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
          MaterialPageRoute(builder: (_) => const PurpleArticlesAnimation(title: "Low-Cost Solutions for Sustainable Development", nextPage: BiographyReadingPage(),)),
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
                  "assets/Wallpapers/WallPaperReadingSpots/FONDO GOAL INSTRUCTION 5 y articles.webp",
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
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFD1C4E9), // morado suave arriba
                        Color(0xFF6A1B9A), // morado fuerte abajo
                      ],
                    ),
                  ),
                ),

// 🔹 SUAVIZAR FONDO GENERAL
                Container(
                  color: Colors.white.withOpacity(0.08),
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
                                                255, 187, 36, 213)
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
                                    const Color.fromARGB(255, 187, 36, 213),
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

class PurpleArticlesAnimation extends StatefulWidget {
  const PurpleArticlesAnimation({
    super.key,
    this.title = 'Loading your articles',
    this.subtitle = 'just a moment',
    required this.nextPage,
  });

  final String title;
  final String subtitle;
  final Widget nextPage;

  @override
  State<PurpleArticlesAnimation> createState() =>
      _PurpleArticlesAnimationState();
}

class _PurpleArticlesAnimationState extends State<PurpleArticlesAnimation>
    with TickerProviderStateMixin {
  // ── Controladores ────────────────────────────────────────────────
  late final AnimationController _masterCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _floatCtrl;
  late final AnimationController _shimmerCtrl;
  late final AnimationController _cursorCtrl;

  // ── Master animations ────────────────────────────────────────────
  late final Animation<double> _bgFade;
  late final Animation<double> _bookScale;
  late final Animation<double> _bookDropY;
  late final Animation<double> _bookRotate;
  late final Animation<double> _tagFade;
  late final Animation<double> _line1;
  late final Animation<double> _line2;
  late final Animation<double> _divider;
  late final Animation<double> _bodyLine1;
  late final Animation<double> _bodyLine2;
  late final Animation<double> _bodyLine3;
  late final Animation<double> _bodyLine4;
  late final Animation<double> _bodyLine5;
  late final Animation<double> _bodyLine6;
  late final Animation<double> _bodyLine7;
  late final Animation<double> _cursorLineFade;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _exitFade;

  // ── Loop animations ──────────────────────────────────────────────
  late final Animation<double> _glow;
  late final Animation<double> _floatY;
  late final Animation<double> _shimmer;
  late final Animation<double> _cursor;

  // ── Paleta morada ────────────────────────────────────────────────
  static const _bg        = Color(0xFF08010F);
  static const _orb1      = Color(0xFF5B21B6);
  static const _orb2      = Color(0xFF7C3AED);
  static const _accent    = Color(0xFFA855F7);
  static const _accent2   = Color(0xFFC4B5FD);
  static const _accent3   = Color(0xFFDDD6FE);

  static const _bookBg    = Color(0xFF1A0845);
  static const _bookBg2   = Color(0xFF2D1060);
  static const _bookBdr   = Color(0xFF7C3AED);
  static const _spine1    = Color(0xFF8B5CF6);
  static const _spine2    = Color(0xFF6D28D9);
  static const _spine3    = Color(0xFF4C1D95);
  static const _tagBg     = Color(0xFF6D28D9);
  static const _tagText   = Color(0xFFEDE9FE);

  @override
  void initState() {
    super.initState();

    // ── Master: 3600ms total ─────────────────────────────────────
    _masterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    );

    _bgFade = CurvedAnimation(
      parent: _masterCtrl,
      curve: const Interval(0.0, 0.10, curve: Curves.easeIn),
    );

    // Book drop-in: caída desde arriba con rebote
    _bookDropY = Tween<double>(begin: -40.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.05, 0.35, curve: _BounceDrop()),
      ),
    );
    _bookScale = Tween<double>(begin: 0.80, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.05, 0.30, curve: Curves.easeOut),
      ),
    );
    _bookRotate = Tween<double>(begin: -0.14, end: 0.0).animate(
      CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.05, 0.35, curve: _BounceDrop()),
      ),
    );

    // Tag "Featured"
    _tagFade = CurvedAnimation(
      parent: _masterCtrl,
      curve: const Interval(0.22, 0.35, curve: Curves.easeOut),
    );

    // Líneas del título del artículo
    _line1 = CurvedAnimation(
      parent: _masterCtrl,
      curve: const Interval(0.28, 0.42, curve: Curves.easeOut),
    );
    _line2 = CurvedAnimation(
      parent: _masterCtrl,
      curve: const Interval(0.31, 0.44, curve: Curves.easeOut),
    );

    // Divisor
    _divider = CurvedAnimation(
      parent: _masterCtrl,
      curve: const Interval(0.34, 0.44, curve: Curves.easeOut),
    );

    // Líneas del cuerpo — aparecen escalonadas
    _bodyLine1 = CurvedAnimation(parent: _masterCtrl,
        curve: const Interval(0.37, 0.47, curve: Curves.easeOut));
    _bodyLine2 = CurvedAnimation(parent: _masterCtrl,
        curve: const Interval(0.40, 0.50, curve: Curves.easeOut));
    _bodyLine3 = CurvedAnimation(parent: _masterCtrl,
        curve: const Interval(0.43, 0.52, curve: Curves.easeOut));
    _bodyLine4 = CurvedAnimation(parent: _masterCtrl,
        curve: const Interval(0.46, 0.55, curve: Curves.easeOut));
    _bodyLine5 = CurvedAnimation(parent: _masterCtrl,
        curve: const Interval(0.48, 0.57, curve: Curves.easeOut));
    _bodyLine6 = CurvedAnimation(parent: _masterCtrl,
        curve: const Interval(0.51, 0.60, curve: Curves.easeOut));
    _bodyLine7 = CurvedAnimation(parent: _masterCtrl,
        curve: const Interval(0.54, 0.62, curve: Curves.easeOut));
    _cursorLineFade = CurvedAnimation(parent: _masterCtrl,
        curve: const Interval(0.56, 0.64, curve: Curves.easeOut));

    // Título exterior
    _titleFade = CurvedAnimation(
      parent: _masterCtrl,
      curve: const Interval(0.40, 0.58, curve: Curves.easeOut),
    );
    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.22),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _masterCtrl,
      curve: const Interval(0.40, 0.60, curve: Curves.easeOut),
    ));

    // Salida
    _exitFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.84, 1.0, curve: Curves.easeIn),
      ),
    );

    // ── Glow pulsante ────────────────────────────────────────────
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);
    _glow = Tween<double>(begin: 8.0, end: 28.0).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );

    // ── Float suave ──────────────────────────────────────────────
    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat(reverse: true);
    _floatY = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );

    // ── Shimmer ──────────────────────────────────────────────────
    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
    _shimmer = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _shimmerCtrl, curve: Curves.easeInOut),
    );

    // ── Cursor blink ─────────────────────────────────────────────
    _cursorCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    )..repeat(reverse: true);
    _cursor = CurvedAnimation(parent: _cursorCtrl, curve: Curves.easeInOut);

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
    _shimmerCtrl.dispose();
    _cursorCtrl.dispose();
    super.dispose();
  }

  // ── BUILD ────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: AnimatedBuilder(
        animation: Listenable.merge(
            [_masterCtrl, _glowCtrl, _floatCtrl, _shimmerCtrl, _cursorCtrl]),
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
                        _buildBook(),
                        const SizedBox(height: 28),
                        _buildTitle(),
                        const SizedBox(height: 6),
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
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: _bg),
          // Orbe superior izquierdo
          Positioned(
            left: -80, top: -80,
            child: _Orb(size: 320, color: _orb1.withOpacity(0.11),
                animation: _floatCtrl, phase: 0),
          ),
          // Orbe inferior derecho
          Positioned(
            right: -60, bottom: -50,
            child: _Orb(size: 260, color: _orb2.withOpacity(0.09),
                animation: _floatCtrl, phase: math.pi),
          ),
          // Orbe central sutil
          Positioned(
            left: MediaQuery.of(context).size.width * 0.28,
            top: MediaQuery.of(context).size.height * 0.38,
            child: _Orb(size: 180, color: _accent.withOpacity(0.06),
                animation: _floatCtrl, phase: math.pi * 0.5),
          ),
        ],
      ),
    );
  }

  // ── PARTÍCULAS ───────────────────────────────────────────────────
  Widget _buildParticles() {
    const pts = [
      (0.09, 0.14, 3.0, 0.0),
      (0.84, 0.19, 4.0, 0.5),
      (0.13, 0.74, 3.0, 1.0),
      (0.78, 0.67, 5.0, 0.7),
      (0.49, 0.07, 3.0, 0.3),
      (0.05, 0.50, 3.0, 1.3),
      (0.89, 0.56, 4.0, 0.6),
    ];

    // Chispas de estrella
    const sparks = [
      (0.17, 0.23, 2.0),
      (0.76, 0.28, 2.5),
      (0.28, 0.79, 3.0),
    ];

    return FadeTransition(
      opacity: _titleFade,
      child: LayoutBuilder(
        builder: (_, c) => Stack(
          children: [
            ...pts.map((p) {
              final dy = math.sin(
                      _floatCtrl.value * math.pi * 2 + p.$4 * math.pi) *
                  11;
              return Positioned(
                left: p.$1 * c.maxWidth,
                top: p.$2 * c.maxHeight + dy,
                child: Container(
                  width: p.$3,
                  height: p.$3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _accent2.withOpacity(0.55),
                  ),
                ),
              );
            }),
            ...sparks.map((s) {
              final progress =
                  (_floatCtrl.value + s.$3 * 0.1) % 1.0;
              final opacity = math.sin(progress * math.pi).clamp(0.0, 1.0);
              return Positioned(
                left: s.$1 * c.maxWidth,
                top: s.$2 * c.maxHeight,
                child: Opacity(
                  opacity: opacity,
                  child: CustomPaint(
                    size: const Size(8, 8),
                    painter: _SparkPainter(color: _accent2.withOpacity(0.7)),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // ── LIBRO ────────────────────────────────────────────────────────
  Widget _buildBook() {
    return Transform.translate(
      offset: Offset(0, _bookDropY.value + _floatY.value),
      child: Transform.rotate(
        angle: _bookRotate.value,
        child: Transform.scale(
          scale: _bookScale.value,
          child: Container(
            width: 160,
            height: 210,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_bookBg2, _bookBg, Color(0xFF110430)],
                stops: [0.0, 0.55, 1.0],
              ),
              border: Border.all(color: _bookBdr, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: _orb2.withOpacity(_glow.value / 55),
                  blurRadius: _glow.value * 2.5,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.55),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(3),
                bottomLeft: Radius.circular(3),
                topRight: Radius.circular(11),
                bottomRight: Radius.circular(11),
              ),
              child: Stack(
                children: [
                  _buildShimmer(),
                  _buildSpine(),
                  _buildBookContent(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Positioned.fill(
      child: ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            begin: Alignment(_shimmer.value - 0.5, -0.5),
            end: Alignment(_shimmer.value + 0.3, 0.5),
            colors: [
              Colors.transparent,
              _accent3.withOpacity(0.07),
              Colors.transparent,
            ],
          ).createShader(bounds);
        },
        blendMode: BlendMode.srcOver,
        child: Container(color: Colors.white),
      ),
    );
  }

  Widget _buildSpine() {
    return Positioned(
      left: 0, top: 0, bottom: 0,
      width: 14,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_spine1, _spine2, _spine3],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(3),
            bottomLeft: Radius.circular(3),
          ),
        ),
        child: Center(
          child: Container(
            width: 4,
            margin: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              color: _accent2.withOpacity(0.20),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookContent() {
    return Positioned(
      left: 22, right: 10, top: 16, bottom: 14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tag "Featured"
          FadeTransition(
            opacity: _tagFade,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: _tagBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'FEATURED',
                style: TextStyle(
                  color: _tagText,
                  fontSize: 7,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.8,
                ),
              ),
            ),
          ),
          const SizedBox(height: 7),

          // Líneas del título
          _AnimatedLine(
              progress: _line1.value, height: 9,
              color: _accent3, width: 1.0),
          const SizedBox(height: 4),
          _AnimatedLine(
              progress: _line2.value, height: 9,
              color: _accent2.withOpacity(0.75), width: 0.76),

          // Divisor
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SizeTransition(
              sizeFactor: _divider,
              axisAlignment: -1,
              axis: Axis.horizontal,
              child: Container(height: 1, color: _orb2.withOpacity(0.40)),
            ),
          ),

          // Líneas del cuerpo
          _AnimatedLine(progress: _bodyLine1.value, height: 4.5,
              color: _accent.withOpacity(0.38), width: 1.0),
          const SizedBox(height: 5),
          _AnimatedLine(progress: _bodyLine2.value, height: 4.5,
              color: _accent.withOpacity(0.35), width: 0.88),
          const SizedBox(height: 5),
          _AnimatedLine(progress: _bodyLine3.value, height: 4.5,
              color: _accent.withOpacity(0.38), width: 0.96),
          const SizedBox(height: 5),
          _AnimatedLine(progress: _bodyLine4.value, height: 4.5,
              color: _accent.withOpacity(0.33), width: 0.72),

          const SizedBox(height: 8),

          _AnimatedLine(progress: _bodyLine5.value, height: 4.5,
              color: _accent.withOpacity(0.38), width: 1.0),
          const SizedBox(height: 5),
          _AnimatedLine(progress: _bodyLine6.value, height: 4.5,
              color: _accent.withOpacity(0.35), width: 0.82),
          const SizedBox(height: 5),
          _AnimatedLine(progress: _bodyLine7.value, height: 4.5,
              color: _accent.withOpacity(0.33), width: 0.58),

          const SizedBox(height: 5),

          // Línea con cursor
          Row(
            children: [
              Expanded(
                child: _AnimatedLine(
                  progress: _cursorLineFade.value,
                  height: 4.5,
                  color: _accent.withOpacity(0.30),
                  width: 0.38,
                ),
              ),
              const SizedBox(width: 3),
              Opacity(
                opacity: _cursor.value,
                child: Container(
                  width: 2,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _accent,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
            ],
          ),
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
        child: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFF5F3FF),
            height: 1.35,
            shadows: [
              Shadow(
                color: _accent.withOpacity(0.75),
                blurRadius: _glow.value * 1.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
//  Línea animada con scaleX
// ══════════════════════════════════════════════════════════════════
class _AnimatedLine extends StatelessWidget {
  const _AnimatedLine({
    required this.progress,
    required this.height,
    required this.color,
    required this.width,
  });

  final double progress;
  final double height;
  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: width,
      alignment: Alignment.centerLeft,
      child: Transform.scale(
        scaleX: progress,
        alignment: Alignment.centerLeft,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
//  Orbe con blur animado
// ══════════════════════════════════════════════════════════════════
class _Orb extends StatelessWidget {
  const _Orb({
    required this.size,
    required this.color,
    required this.animation,
    required this.phase,
  });

  final double size;
  final Color color;
  final Animation<double> animation;
  final double phase;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) {
        final s = 1.0 +
            math.sin(animation.value * math.pi * 2 + phase) * 0.07;
        return Transform.scale(
          scale: s,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
        );
      },
    );
  }
}



// ══════════════════════════════════════════════════════════════════
//  CustomPainter: chispa de estrella (✦)
// ══════════════════════════════════════════════════════════════════
class _SparkPainter extends CustomPainter {
  final Color color;
  const _SparkPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;

    // Cruz horizontal + vertical
    canvas.drawLine(Offset(cx - r, cy), Offset(cx + r, cy), p);
    canvas.drawLine(Offset(cx, cy - r), Offset(cx, cy + r), p);

    // Cruz diagonal más pequeña
    final rd = r * 0.55;
    p.strokeWidth = 1.0;
    canvas.drawLine(Offset(cx - rd, cy - rd), Offset(cx + rd, cy + rd), p);
    canvas.drawLine(Offset(cx + rd, cy - rd), Offset(cx - rd, cy + rd), p);
  }

  @override
  bool shouldRepaint(covariant _SparkPainter old) => old.color != color;
}

// ══════════════════════════════════════════════════════════════════
//  Curve personalizada: caída con rebote tipo bookDrop
// ══════════════════════════════════════════════════════════════════
class _BounceDrop extends Curve {
  const _BounceDrop();

  @override
  double transformInternal(double t) {
    if (t < 0.65) {
      // Aceleración hacia abajo
      return Curves.easeIn.transform(t / 0.65);
    } else if (t < 0.80) {
      // Rebote hacia arriba
      final s = (t - 0.65) / 0.15;
      return 1.0 + 0.06 * math.sin(s * math.pi);
    } else if (t < 0.92) {
      // Pequeño rebote 2
      final s = (t - 0.80) / 0.12;
      return 1.0 - 0.02 * math.sin(s * math.pi);
    } else {
      return 1.0;
    }
  }
}

class BiographyReadingPage extends StatefulWidget {
  const BiographyReadingPage({super.key});

  @override
  State<BiographyReadingPage> createState() => _BiographyReadingPageState();
}

class _BiographyReadingPageState extends State<BiographyReadingPage> {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  /// ⭐ LÓGICA DE CONTINUIDAD
  int _lastQuestionIndex = 0;

  /// ===== ESTILOS APA =====
  TextStyle get bodyStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        color: Colors.black,
      );

  TextStyle get headingStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );

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

  /// ✅ CONTINUIDAD DE PREGUNTAS
  void _goToQuestions() async {
    setState(() => animating = true);

    await Future.delayed(const Duration(seconds: 1));

    final result = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (_) => QuestionPage(
          questions: sampleQuestions,
          startIndex: _lastQuestionIndex,
        ),
      ),
    );

    if (result != null) {
      _lastQuestionIndex = result;
    }

    setState(() => animating = false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          /// ===== CONTENIDO APA =====
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Introduction",
                  style: headingStyle,
                ),
                const SizedBox(height: 24),
                Text(
                  "The global construction industry is facing growing pressure "
                  "to reduce its environmental impact while addressing housing "
                  "shortages. Traditional building materials such as concrete, "
                  "steel, and timber contribute significantly to carbon "
                  "emissions, deforestation, and resource depletion. In "
                  "response to these challenges, researchers and architects "
                  "are increasingly exploring alternative, sustainable "
                  "materials that offer both ecological and economic benefits.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),
                Text(
                  "One material gaining renewed interest is bamboo, a fast-"
                  "growing, renewable resource with high strength, flexibility, "
                  "and cost-effectiveness. In many tropical and subtropical "
                  "regions, bamboo has historically been used in traditional "
                  "housing and infrastructure, but recent technological "
                  "advancements have enabled its application in modern "
                  "architectural designs and prefabricated housing solutions.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),
                Text(
                  "A study published in Sustainability examines the potential "
                  "of bamboo as a key material for innovative, low-cost, and "
                  "environmentally friendly housing. The study discusses its "
                  "benefits, traditional and modern applications, challenges "
                  "in large-scale implementation, and strategies for "
                  "promoting bamboo-based construction. This article explores "
                  "these findings, highlighting how bamboo could revolutionize "
                  "the building sector.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),

          /// ===== BOTÓN =====
          AnimatedPositioned(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            bottom: showButton ? 24 : -100,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 187, 36, 213),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: showButton ? _goToQuestions : null,
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                label: const Text(
                  "Go to Next Questions",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),

          /// ===== OVERLAY =====
          if (animating)
            Container(
              color: Colors.white.withOpacity(0.6),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                        color: Color.fromARGB(255, 187, 36, 213)),
                    SizedBox(height: 16),
                    Text(
                      "Going to Questions...",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 187, 36, 213),
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

// Preguntas de ejemplo
final List<QuestionData> sampleQuestions = [
  QuestionData(
    question:
        'Why are researchers exploring materials like bamboo for construction?',
    options: [
      "A) Because bamboo can replace all metal tools",
      "B) Because traditional materials are too cheap",
      "C) Because traditional materials harm the environment",
      "D) Because bamboo is harder to find"
    ],
    correctIndex: 2,
    explanation:
        ' The text mentions that materials like concrete and steel contribute to carbon emissions. We infer that researchers are looking at bamboo to reduce environmental harm.',
    incorrectExplanations: [
      ' Bamboo cannot replace *all* metal tools.',
      ' Cheapness of materials is not a reason mentioned.',
      ' Correct answer!',
      ' Bamboo is not described as being harder to find.'
    ],
  ),
  QuestionData(
    question: 'Why might bamboo be useful in solving housing shortages?',
    options: [
      "A) Because it can be used for furniture",
      "B) Because it replaces plastic entirely",
      "C) Because it requires high-tech tools to use",
      "D) Because it grows quickly and is affordable"
    ],
    correctIndex: 3,
    explanation:
        ' Bamboo is described as fast-growing and cost-effective. We infer that these traits make it suitable for creating more affordable housing quickly.',
    incorrectExplanations: [
      ' Furniture use is not the main reason for housing solutions.',
      ' Plastic replacement is not relevant here.',
      ' Bamboo does not require high-tech tools.',
      ' Correct answer!'
    ],
  ),
];

// Pantalla de preguntas con animación simple
class QuestionPage extends StatefulWidget {
  final List<QuestionData> questions;
  final int startIndex;

  const QuestionPage({
    super.key,
    required this.questions,
    required this.startIndex,
  });

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
   late int currentQuestionIndex;
  int? selected;
  bool showFeedback = false;
  bool _isCorrect = false;
  String _feedbackText = '';

  static const Color accentDark = Color(0xFF6A1B9A); // morado oscuro
  static const Color cardBg = Color(0xFFF3E5F5); // lavanda muy claro

  @override
  void initState() {
    super.initState();
    currentQuestionIndex = widget.startIndex;
  }

  void _submitAnswer() {
    if (selected == null) return;
    final current = widget.questions[currentQuestionIndex];
    final isCorrect = selected == current.correctIndex;

    String explanationText;
    if (isCorrect) {
      explanationText = current.explanation;
    } else if (current.incorrectExplanations != null &&
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFD1C4E9), // morado suave arriba
              Color(0xFF6A1B9A), // morado fuerte abajo
            ],
          ),
        ),
        child: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Column(
                  key: ValueKey<int>(currentQuestionIndex),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFAB47BC), // morado medio
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

                    const SizedBox(height: 24),

                    // Option buttons
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
                                  ? const Color(0xFFAB47BC) // morado medio
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

                    const SizedBox(height: 8),

                    // Submit button OR feedback card
                    if (!showFeedback)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // View Text
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context, currentQuestionIndex);
                            },
                            icon: const Icon(Icons.menu_book,
                                color: Colors.white),
                            label: const Text(
                              "View Text",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentDark,
                              elevation: 4,
                              shadowColor: accentDark.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                            ),
                          ),

                          // Submit
                          ElevatedButton(
                            onPressed: selected != null ? _submitAnswer : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF8E24AA), // morado botón
                              disabledBackgroundColor:
                                  accentDark.withOpacity(0.35),
                              elevation: 4,
                              shadowColor: accentDark.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 14),
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
                        ],
                      )
                    else
                      // Feedback card
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
                              onPressed: _goNext,
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
        ),
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

  /// ⭐ LÓGICA DE CONTINUIDAD
  int _lastQuestionIndex = 0;

  /// ===== ESTILOS APA =====
  TextStyle get bodyStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        color: Colors.black,
      );

  TextStyle get headingStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );

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

  /// ✅ CONTINUIDAD DE PREGUNTAS
  void _goToQuestions() async {
    setState(() => animating = true);

    await Future.delayed(const Duration(seconds: 1));

    final result = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (_) => QuestionPageSecond(
          questions: sampleQuestionsSecond,
          startIndex: _lastQuestionIndex,
        ),
      ),
    );

    if (result != null) {
      _lastQuestionIndex = result;
    }

    setState(() => animating = false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          /// ===== CONTENIDO =====
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "The Traditional Use of Bamboo in Construction",
                  style: headingStyle,
                ),
                const SizedBox(height: 24),
                Text(
                  "Bamboo has been used in construction for centuries across "
                  "Asia, Latin America, and Africa, where it is naturally "
                  "abundant. The study highlights various traditional building "
                  "techniques that demonstrate its versatility and durability.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),
                Text(
                  "1. Bamboo in Rural Housing",
                  style: headingStyle,
                ),
                const SizedBox(height: 24),
                Text(
                  "In countries such as China, India, Indonesia, and Colombia, "
                  "bamboo has historically been a primary construction material "
                  "for rural housing due to its availability, ease of use, and "
                  "cost-effectiveness.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),
                Text(
                  "Bamboo poles are used for structural framing, roofing, and "
                  "walls, often combined with local materials such as mud, "
                  "clay, and palm leaves.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),
                Text(
                  "Traditional woven bamboo panels (known as \"bahareque\" in "
                  "Latin America) provide natural ventilation and insulation, "
                  "making homes more energy-efficient.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),

          /// ===== BOTÓN =====
          AnimatedPositioned(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            bottom: showButton ? 24 : -100,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 187, 36, 213),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: showButton ? _goToQuestions : null,
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                label: const Text(
                  "Go to Next Questions",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),

          /// ===== OVERLAY =====
          if (animating)
            Container(
              color: Colors.white.withOpacity(0.6),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Color.fromARGB(255, 187, 36, 213),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Going to Questions...",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 187, 36, 213),
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
        'Why has bamboo traditionally been used for rural housing in countries like India and Colombia?',
    options: [
      "A) Because bamboo is affordable and easy to use",
      "B) Because bamboo is rare and expensive",
      "C) Because bamboo grows slowly and lasts longer",
      "D) Because bamboo can only be used in cities"
    ],
    correctIndex: 0,
    explanation:
        ' The text states bamboo is used due to its availability, ease of use, and cost-effectiveness. We infer that these qualities make it ideal for rural, low-cost housing.',
    incorrectExplanations: [
      ' Correct answer!',
      ' Bamboo is not described as rare or expensive.',
      ' Bamboo actually grows quickly, not slowly.',
      ' Bamboo is not limited to urban use.'
    ],
  ),
  QuestionData(
    question:
        'Why might woven bamboo panels help make homes more energy-efficient?',
    options: [
      "A) Because they block all air from getting inside",
      "B) Because they create a seal that traps heat",
      "C) Because they allow airflow and keep temperatures stable",
      "D) Because they are stronger than metal panels"
    ],
    correctIndex: 2,
    explanation:
        ' The panels provide natural ventilation and insulation. We infer that allowing air to circulate helps regulate temperature, improving energy efficiency.',
    incorrectExplanations: [
      ' Blocking all air would reduce ventilation, not improve it.',
      ' Trapping heat doesn’t necessarily make homes energy-efficient.',
      ' Correct answer!',
      ' Strength is not the reason for their energy efficiency.'
    ],
  ),
];

class QuestionPageSecond extends StatefulWidget {
  final List<QuestionData> questions;
  final int startIndex;

  const QuestionPageSecond({
    super.key,
    required this.questions,
    required this.startIndex,
  });

  @override
  State<QuestionPageSecond> createState() => _QuestionPageSecondState();
}

class _QuestionPageSecondState extends State<QuestionPageSecond> {
  late int currentQuestionIndex;
  int? selected;
  bool showFeedback = false;
  bool _isCorrect = false;
  String _feedbackText = '';

  static const Color accentDark = Color(0xFF6A1B9A); // morado oscuro
  static const Color cardBg = Color(0xFFF3E5F5); // lavanda muy claro

  @override
  void initState() {
    super.initState();
    currentQuestionIndex = widget.startIndex;
  }

  void _submitAnswer() {
    if (selected == null) return;
    final current = widget.questions[currentQuestionIndex];
    final isCorrect = selected == current.correctIndex;

    String explanationText;
    if (isCorrect) {
      explanationText = current.explanation;
    } else if (current.incorrectExplanations != null &&
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFD1C4E9), // morado suave arriba
              Color(0xFF6A1B9A), // morado fuerte abajo
            ],
          ),
        ),
        child: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Column(
                  key: ValueKey<int>(currentQuestionIndex),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFAB47BC), // morado medio
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

                    const SizedBox(height: 24),

                    // Option buttons
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
                                  ? const Color(0xFFAB47BC) // morado medio
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

                    const SizedBox(height: 8),

                    // Submit button OR feedback card
                    if (!showFeedback)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // View Text
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context, currentQuestionIndex);
                            },
                            icon: const Icon(Icons.menu_book,
                                color: Colors.white),
                            label: const Text(
                              "View Text",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentDark,
                              elevation: 4,
                              shadowColor: accentDark.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                            ),
                          ),

                          // Submit
                          ElevatedButton(
                            onPressed: selected != null ? _submitAnswer : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF8E24AA), // morado botón
                              disabledBackgroundColor:
                                  accentDark.withOpacity(0.35),
                              elevation: 4,
                              shadowColor: accentDark.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 14),
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
                        ],
                      )
                    else
                      // Feedback card
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
                              onPressed: _goNext,
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
        ),
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

  /// ⭐ LÓGICA DE CONTINUIDAD
  int _lastQuestionIndex = 0;

  /// ===== ESTILOS APA =====
  TextStyle get bodyStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        color: Colors.black,
      );

  TextStyle get headingStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );

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

  /// ✅ CONTINUIDAD DE PREGUNTAS
  void _goToQuestions() async {
    setState(() => animating = true);

    await Future.delayed(const Duration(seconds: 1));

    final result = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (_) => QuestionPageThird(
          questions: sampleQuestionsThird,
          startIndex: _lastQuestionIndex,
        ),
      ),
    );

    if (result != null) {
      _lastQuestionIndex = result;
    }

    setState(() => animating = false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          /// ===== CONTENIDO =====
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "2. Earthquake-Resistant Bamboo Construction",
                  style: headingStyle,
                ),
                const SizedBox(height: 24),
                Text(
                  "One of bamboo’s most valuable characteristics is its "
                  "flexibility, which allows it to withstand seismic activity "
                  "better than rigid materials like concrete or brick.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),
                Text(
                  "In earthquake-prone regions such as Ecuador, Costa Rica, "
                  "and Nepal, bamboo structures have demonstrated high "
                  "resilience, with many buildings surviving major earthquakes "
                  "with minimal damage.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),
                Text(
                  "The bahareque technique, which involves embedding bamboo "
                  "into mud or concrete walls, has been adapted into modern "
                  "earthquake-resistant housing solutions.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 32),
                Text(
                  "3. Traditional Bamboo Bridges and Infrastructure",
                  style: headingStyle,
                ),
                const SizedBox(height: 24),
                Text(
                  "Bamboo has also been used in bridge construction, "
                  "particularly in China and Vietnam, where entire pedestrian "
                  "and vehicle bridges have been built using bamboo poles "
                  "reinforced with natural resins.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),
                Text(
                  "These traditional structures highlight bamboo’s durability "
                  "and load-bearing capabilities, making it suitable for both "
                  "temporary and permanent infrastructure projects.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),

          /// ===== BOTÓN =====
          AnimatedPositioned(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            bottom: showButton ? 24 : -100,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 187, 36, 213),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: showButton ? _goToQuestions : null,
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                label: const Text(
                  "Go to Next Questions",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),

          /// ===== OVERLAY =====
          if (animating)
            Container(
              color: Colors.white.withOpacity(0.6),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Color.fromARGB(255, 187, 36, 213),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Going to Questions...",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 187, 36, 213),
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
        'Why might bamboo buildings survive earthquakes better than concrete ones?',
    options: [
      "A) Because bamboo is heavier than concrete",
      "B) Because bamboo is more flexible and absorbs shocks",
      "C) Because bamboo does not bend during earthquakes",
      "D) Because bamboo is waterproof"
    ],
    correctIndex: 1,
    explanation:
        ' The text says bamboo is flexible and survives earthquakes. From this, we infer its ability to absorb movement helps it resist damage better than rigid materials.',
    incorrectExplanations: [
      ' Weight is not a factor in bamboo’s earthquake resistance.',
      ' Correct answer!',
      ' Bamboo’s ability to bend is actually an advantage.',
      ' Being waterproof is unrelated to earthquake survival.'
    ],
  ),
  QuestionData(
    question:
        'What does the use of bamboo in traditional bridges suggest about the material?',
    options: [
      "A) It can only be used in temporary shelters",
      "B) It is too weak for large projects",
      "C) It can only support people, not vehicles",
      "D) It’s durable enough for infrastructure"
    ],
    correctIndex: 3,
    explanation:
        ' Since bamboo is used for pedestrian and vehicle bridges, we infer that it must be strong and durable enough for such demanding uses.',
    incorrectExplanations: [
      ' It is used in more than just temporary shelters.',
      ' Its use in bridges shows it is not too weak.',
      ' It supports both people and vehicles.',
      ' Correct answer!'
    ],
  ),
];

class QuestionPageThird extends StatefulWidget {
  final List<QuestionData> questions;
  final int startIndex;

  const QuestionPageThird({
    super.key,
    required this.questions,
    this.startIndex = 0,
  });

  @override
  State<QuestionPageThird> createState() => _QuestionPageThirdState();
}

class _QuestionPageThirdState extends State<QuestionPageThird> {
  late int currentQuestionIndex;
  int? selected;
  bool showFeedback = false;
  bool _isCorrect = false;
  String _feedbackText = '';

  static const Color accentDark = Color(0xFF6A1B9A); // morado oscuro
  static const Color cardBg = Color(0xFFF3E5F5); // lavanda muy claro

  @override
  void initState() {
    super.initState();
    currentQuestionIndex = widget.startIndex;
  }

  void _submitAnswer() {
    if (selected == null) return;
    final current = widget.questions[currentQuestionIndex];
    final isCorrect = selected == current.correctIndex;

    String explanationText;
    if (isCorrect) {
      explanationText = current.explanation;
    } else if (current.incorrectExplanations != null &&
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
        MaterialPageRoute(builder: (_) => BiographyReadingPageFour()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFD1C4E9), // morado suave arriba
              Color(0xFF6A1B9A), // morado fuerte abajo
            ],
          ),
        ),
        child: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Column(
                  key: ValueKey<int>(currentQuestionIndex),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFAB47BC), // morado medio
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

                    const SizedBox(height: 24),

                    // Option buttons
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
                                  ? const Color(0xFFAB47BC) // morado medio
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

                    const SizedBox(height: 8),

                    // Submit button OR feedback card
                    if (!showFeedback)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // View Text
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context, currentQuestionIndex);
                            },
                            icon: const Icon(Icons.menu_book,
                                color: Colors.white),
                            label: const Text(
                              "View Text",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentDark,
                              elevation: 4,
                              shadowColor: accentDark.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                            ),
                          ),

                          // Submit
                          ElevatedButton(
                            onPressed: selected != null ? _submitAnswer : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF8E24AA), // morado botón
                              disabledBackgroundColor:
                                  accentDark.withOpacity(0.35),
                              elevation: 4,
                              shadowColor: accentDark.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 14),
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
                        ],
                      )
                    else
                      // Feedback card
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
                              onPressed: _goNext,
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
        ),
      ),
    );
  }
}

class BiographyReadingPageFour extends StatefulWidget {
  const BiographyReadingPageFour({super.key});

  @override
  State<BiographyReadingPageFour> createState() =>
      _BiographyReadingPageFourState();
}

class _BiographyReadingPageFourState extends State<BiographyReadingPageFour> {
  final ScrollController _scrollController = ScrollController();

  bool showButton = false;
  bool animating = false;

  /// ⭐ LÓGICA DE CONTINUIDAD
  int _lastQuestionIndex = 0;

  /// ===== ESTILOS APA =====
  TextStyle get bodyStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        color: Colors.black,
      );

  TextStyle get headingStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );

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

  /// ✅ CONTINUIDAD DE PREGUNTAS
  void _goToQuestions() async {
    setState(() => animating = true);

    await Future.delayed(const Duration(seconds: 1));

    final result = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (_) => QuestionPageFour(
          questions: sampleQuestionsFour,
          startIndex: _lastQuestionIndex,
        ),
      ),
    );

    if (result != null) {
      _lastQuestionIndex = result;
    }

    setState(() => animating = false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          /// ===== CONTENIDO =====
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Advantages of Bamboo as a Building Material",
                  style: headingStyle,
                ),
                const SizedBox(height: 24),
                Text(
                  "The study identifies several advantages of bamboo that make it a superior alternative to conventional building "
                  "materials, particularly in low-cost and sustainable housing projects ",
                  style: bodyStyle,
                ),
                const SizedBox(height: 32),
                Text(
                  "1. Environmental Sustainability",
                  style: headingStyle,
                ),
                const SizedBox(height: 24),
                Text(
                  "Bamboo is one of the fastest-growing plants in the world, reaching maturity in 3 to 5 years,"
                  "compared to decades for hardwood trees.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),
                Text(
                  "It is a highly renewable resource, capable of being harvested without killing the plant, which continues to grow "
                  "through its root system.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),
                Text(
                  "Bamboo forests absorb large amounts of CO₂, making it an important material for carbon sequestration and climate"
                  "change mitigation. ",
                  style: bodyStyle,
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),

          /// ===== BOTÓN (siempre visible) =====
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 187, 36, 213),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: _goToQuestions,
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                label: const Text(
                  "Go to Next Questions",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),

          /// ===== OVERLAY =====
          if (animating)
            Container(
              color: Colors.white.withOpacity(0.6),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Color.fromARGB(255, 187, 36, 213),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Going to Questions...",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 187, 36, 213),
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

final List<QuestionData> sampleQuestionsFour = [
  QuestionData(
    question:
        'Why is bamboo considered environmentally friendly?',
    options: [
      "A) Because it grows quickly",
      "B) Because it doesn't grow back once harvested",
      "C) Because it grows slowly and lasts a long time",
      "D) Because it uses lots of water to grow"
    ],
    correctIndex: 0,
    explanation:
        ' The text says bamboo grows fast and keeps growing after harvesting. From this, we infer that it’s sustainable because it doesn’t require replanting.',
    incorrectExplanations: [
      '  The text says bamboo grows fast and keeps growing after harvesting.',
      ' Incorrect answer! Bamboo continues to grow after harvesting.',
      ' Incorrect answer! Bamboo grows quickly, not slowly.',
      ' Incorrect answer! Bamboo is known for its rapid growth.'
    ],
  ),
  QuestionData(
    question:
        'How might bamboo help fight climate change?',
    options: [
      "A) By producing oxygen at night",
      "B) By replacing all fossil fuels",
      "C) By absorbing large amounts of CO2",
      "D) By using chemicals to clean the air"
    ],
    correctIndex: 2,
    explanation:
        ' The text mentions bamboo absorbs CO₂. From that, we infer it helps reduce greenhouse gases and fight climate change.',
    incorrectExplanations: [
      ' Incorrect answer! Bamboo is known for its rapid growth.',
      ' Incorrect answer! Bamboo continues to grow after harvesting.',
      ' Incorrect answer! Bamboo is used in more than just temporary shelters.',
      ' Correct answer!'
    ],
  ),
];

class QuestionPageFour extends StatefulWidget {
  final List<QuestionData> questions;
  final int startIndex;

  const QuestionPageFour({
    super.key,
    required this.questions,
    this.startIndex = 0,
  });

  @override
  State<QuestionPageFour> createState() => _QuestionPageFourthState();
}

class _QuestionPageFourthState extends State<QuestionPageFour> {
   late int currentQuestionIndex;
  int? selected;
  bool showFeedback = false;
  bool _isCorrect = false;
  String _feedbackText = '';

  static const Color accentDark = Color(0xFF6A1B9A); // morado oscuro
  static const Color cardBg = Color(0xFFF3E5F5); // lavanda muy claro

  @override
  void initState() {
    super.initState();
    currentQuestionIndex = widget.startIndex;
  }

  void _submitAnswer() {
    if (selected == null) return;
    final current = widget.questions[currentQuestionIndex];
    final isCorrect = selected == current.correctIndex;

    String explanationText;
    if (isCorrect) {
      explanationText = current.explanation;
    } else if (current.incorrectExplanations != null &&
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFD1C4E9), // morado suave arriba
              Color(0xFF6A1B9A), // morado fuerte abajo
            ],
          ),
        ),
        child: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Column(
                  key: ValueKey<int>(currentQuestionIndex),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFAB47BC), // morado medio
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

                    const SizedBox(height: 24),

                    // Option buttons
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
                                  ? const Color(0xFFAB47BC) // morado medio
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

                    const SizedBox(height: 8),

                    // Submit button OR feedback card
                    if (!showFeedback)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // View Text
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context, currentQuestionIndex);
                            },
                            icon: const Icon(Icons.menu_book,
                                color: Colors.white),
                            label: const Text(
                              "View Text",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentDark,
                              elevation: 4,
                              shadowColor: accentDark.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                            ),
                          ),

                          // Submit
                          ElevatedButton(
                            onPressed: selected != null ? _submitAnswer : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF8E24AA), // morado botón
                              disabledBackgroundColor:
                                  accentDark.withOpacity(0.35),
                              elevation: 4,
                              shadowColor: accentDark.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 14),
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
                        ],
                      )
                    else
                      // Feedback card
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
                              onPressed: _goNext,
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
        ),
      ),
    );
  }
}

class BiographyReadingPageFive extends StatefulWidget {
  const BiographyReadingPageFive({super.key});

  @override
  State<BiographyReadingPageFive> createState() =>
      _BiographyReadingPageFiveState();
}

class _BiographyReadingPageFiveState extends State<BiographyReadingPageFive> {
  final ScrollController _scrollController = ScrollController();
  bool showButton = true; // aparece desde el inicio
  bool animating = false;

  /// ⭐ LÓGICA DE CONTINUIDAD
  int _lastQuestionIndex = 0;

  /// ===== ESTILOS APA =====
  TextStyle get bodyStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        color: Colors.black,
      );

  TextStyle get headingStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );

  /// ✅ CONTINUIDAD DE PREGUNTAS
  void _goToQuestions() async {
    setState(() => animating = true);

    await Future.delayed(const Duration(seconds: 1));

    final result = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (_) => QuestionPageFive(
          questions: sampleQuestionsFive,
          startIndex: _lastQuestionIndex,
        ),
      ),
    );

    if (result != null) {
      _lastQuestionIndex = result;
    }

    setState(() => animating = false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          /// ===== CONTENIDO =====
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Advantages of Bamboo as a Building Material",
                  style: headingStyle,
                ),
                const SizedBox(height: 24),
                Text(
                  "The study identifies several advantages of bamboo that "
                  "make it a superior alternative to conventional building "
                  "materials, particularly in low-cost and sustainable "
                  "housing projects.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 32),
                Text(
                  "1. Environmental Sustainability",
                  style: headingStyle,
                ),
                const SizedBox(height: 24),
                Text(
                  "Bamboo is one of the fastest-growing plants in the world, "
                  "reaching maturity in three to five years, compared to "
                  "decades required for hardwood trees.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),
                Text(
                  "It is a highly renewable resource, capable of being "
                  "harvested without killing the plant, as it continues "
                  "to grow through its root system.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),
                Text(
                  "Furthermore, bamboo forests absorb large amounts of "
                  "carbon dioxide, making bamboo an important material "
                  "for carbon sequestration and climate change mitigation.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),

          /// ===== BOTÓN =====
          AnimatedPositioned(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 187, 36, 213),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: _goToQuestions,
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                label: const Text(
                  "Go to Next Questions",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),

          /// ===== OVERLAY =====
          if (animating)
            Container(
              color: Colors.white.withOpacity(0.6),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Color.fromARGB(255, 187, 36, 213),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Going to Questions...",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 187, 36, 213),
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

final List<QuestionData> sampleQuestionsFive = [
  QuestionData(
    question: 'Why is bamboo considered environmentally friendly?',
    options: [
      "A) Because it grows quickly",
      "B) Because it doesn’t grow back once harvested",
      "C) Because it grows slowly and lasts a long time",
      "D) Because it uses lots of water to grow"
    ],
    correctIndex: 0,
    explanation:
        ' The text says bamboo grows fast and keeps growing after harvesting. From this, we infer that it’s sustainable because it doesn’t require replanting.',
    incorrectExplanations: [
      ' Correct answer!',
      ' Bamboo *does* grow back once harvested.',
      ' Slow growth is not mentioned and would be a disadvantage.',
      ' Bamboo is not noted for using a lot of water.'
    ],
  ),
  QuestionData(
    question: 'How might bamboo help fight climate change?',
    options: [
      "A) By producing oxygen at night",
      "B) By replacing all fossil fuels",
      "C) By absorbing large amounts of CO₂",
      "D) By using chemicals to clean the air"
    ],
    correctIndex: 2,
    explanation:
        ' The text mentions bamboo absorbs CO₂. From that, we infer it helps reduce greenhouse gases and fight climate change.',
    incorrectExplanations: [
      ' Oxygen production at night is not mentioned.',
      ' Bamboo doesn’t replace *all* fossil fuels.',
      ' Correct answer!',
      ' No chemicals are mentioned in the process.'
    ],
  ),
];

class QuestionPageFive extends StatefulWidget {
  final List<QuestionData> questions;
  final int startIndex;

  const QuestionPageFive(
      {super.key, required this.questions, this.startIndex = 0});

  @override
  State<QuestionPageFive> createState() => _QuestionPageFiveState();
}

class _QuestionPageFiveState extends State<QuestionPageFive> {
  late int currentQuestionIndex;
  int? selected;

  @override
  void initState() {
    super.initState();
    currentQuestionIndex = widget.startIndex;
  }

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

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isCorrect
                ? const Color.fromARGB(255, 187, 36, 213)
                : Colors.red,
            width: 3,
          ),
        ),

        /// 🟡 TÍTULO CON ICONO
        title: Row(
          children: [
            Icon(
              isCorrect ? Icons.check_circle : Icons.cancel,
              color: isCorrect
                  ? const Color.fromARGB(255, 187, 36, 213)
                  : Colors.red,
            ),
            const SizedBox(width: 10),
            Text(
              isCorrect ? "Correct! 🎉" : "Incorrect",
              style: TextStyle(
                color: isCorrect
                    ? const Color.fromARGB(255, 187, 36, 213)
                    : Colors.red.shade800,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        /// 📘 EXPLICACIÓN
        content: Text(
          explanationText,
          style: const TextStyle(fontSize: 18),
        ),

        /// ▶ NEXT
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // 🔹 cierra el AlertDialog

              if (currentQuestionIndex < widget.questions.length - 1) {
                setState(() {
                  currentQuestionIndex++;
                  selected = null;
                });
              } else {
                // 🔥 AQUÍ YA PUEDES IR A OTRA PÁGINA
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BiographyReadingPageFinal(),
                  ),
                );
              }
            },
            child: const Text(
              "Next",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: Column(
            key: ValueKey<int>(currentQuestionIndex),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),

              /// ❓ PREGUNTA
              Text(
                question.question,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              /// ✅ OPCIONES
              ...List.generate(question.options.length, (i) {
                return RadioListTile(
                  title: Text(
                    question.options[i],
                    style: const TextStyle(fontSize: 18),
                  ),
                  value: i,
                  groupValue: selected,
                  onChanged: (value) {
                    setState(() => selected = value);
                  },
                );
              }),

              const Spacer(),

              /// 🔽 BOTONES
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// 📖 VIEW TEXT
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context, currentQuestionIndex);
                    },
                    icon: const Icon(Icons.menu_book,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    label: const Text(
                      "View Text",
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 187, 36, 213),
                    ),
                  ),

                  /// ✅ SUBMIT
                  ElevatedButton(
                    onPressed: selected != null ? _submitAnswer : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 187, 36, 213),
                    ),
                    child: const Text(
                      "Submit",
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
  bool showButton = true;
  bool animating = false;

  /// ⭐ LÓGICA DE CONTINUIDAD
  int _lastQuestionIndex = 0;

  /// ===== ESTILOS APA =====
  TextStyle get bodyStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        color: Colors.black,
      );

  TextStyle get headingStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );

  /// ✅ MISMA LÓGICA DE PAGE FIVE
  void _goToQuestions() async {
    setState(() => animating = true);

    await Future.delayed(const Duration(seconds: 1));

    final result = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (_) => QuestionPageFinal(
          questions: sampleQuestionsFinal,
          startIndex: _lastQuestionIndex,
        ),
      ),
    );

    if (result != null) {
      _lastQuestionIndex = result;
    }

    setState(() => animating = false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          /// ===== CONTENIDO =====
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ===== SECCIÓN 2 =====
                Text(
                  "2. High Strength and Structural Integrity",
                  style: headingStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "Bamboo has a high strength-to-weight ratio, making it "
                  "stronger than steel in tension and more resilient than "
                  "concrete in compression.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "Its natural flexibility allows it to absorb shocks and "
                  "vibrations, making it ideal for earthquake-resistant "
                  "structures.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "Engineered bamboo products, such as laminated bamboo panels "
                  "and bamboo-reinforced composites, further enhance its "
                  "structural capabilities.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 32),

                /// ===== SECCIÓN 3 =====
                Text(
                  "3. Cost-Effectiveness and Local Availability",
                  style: headingStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "Bamboo is cheaper than concrete, steel, and timber, "
                  "particularly in regions where it grows abundantly.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "Its lightweight nature reduces transportation and labor "
                  "costs, making it ideal for affordable housing initiatives.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "Communities can harvest and process bamboo locally, "
                  "reducing reliance on expensive imported materials.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 32),

                /// ===== SECCIÓN 4 =====
                Text(
                  "4. Thermal and Acoustic Performance",
                  style: headingStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "Bamboo naturally provides insulation, keeping homes cooler "
                  "in hot climates and warmer in colder temperatures.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "Its hollow structure absorbs sound, reducing noise "
                  "pollution in urban environments.",
                  style: bodyStyle,
                ),

                const SizedBox(height: 120),
              ],
            ),
          ),

          /// ===== BOTÓN =====
          AnimatedPositioned(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 187, 36, 213),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: _goToQuestions,
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                label: const Text(
                  "Go to Next Questions",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),

          /// ===== OVERLAY =====
          if (animating)
            Container(
              color: Colors.white.withOpacity(0.6),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Color.fromARGB(255, 187, 36, 213),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Going to Questions...",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 187, 36, 213),
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
        'Why might bamboo be a good material for buildings in earthquake-prone areas?',
    options: [
      "A) Because it conducts electricity well",
      "B) Because it's heavy and solid",
      "C) Because it is flexibility",
      "D) Because it's made of metal"
    ],
    correctIndex: 2,
    explanation:
        ' The text says bamboo is flexible and absorbs shocks. From that, we infer it helps buildings resist earthquake damage.',
    incorrectExplanations: [
      ' Conductivity isn’t relevant to earthquake resistance.',
      ' Heavy materials aren’t always safer in earthquakes.',
      ' Correct answer!',
      ' Bamboo is not made of metal.'
    ],
  ),
  QuestionData(
    question:
        'Why could bamboo help reduce building costs in some communities?',
    options: [
      "A) Because it lasts longer than concrete",
      "B) Because it’s grown and processed locally",
      "C) Because it requires advanced machinery",
      "D) Because it needs special handling"
    ],
    correctIndex: 1,
    explanation:
        ' The text mentions that bamboo is locally available and reduces transportation and labor costs, so we infer that this helps lower construction expenses.',
    incorrectExplanations: [
      ' Longevity is not the main cost-saving factor mentioned.',
      ' Correct answer!',
      ' Bamboo doesn’t require advanced tools.',
      ' It is not described as needing special handling.'
    ],
  ),
];

class QuestionPageFinal extends StatefulWidget {
  final List<QuestionData> questions;
  final int startIndex;

  const QuestionPageFinal(
      {super.key, required this.questions, this.startIndex = 0});

  @override
  State<QuestionPageFinal> createState() => _QuestionPageFinalState();
}

class _QuestionPageFinalState extends State<QuestionPageFinal> {
 late int currentQuestionIndex;
  int? selected;
  bool showFeedback = false;
  bool _isCorrect = false;
  String _feedbackText = '';

  static const Color accentDark = Color(0xFF6A1B9A); // morado oscuro
  static const Color cardBg = Color(0xFFF3E5F5); // lavanda muy claro

  @override
  void initState() {
    super.initState();
    currentQuestionIndex = widget.startIndex;
  }

  void _submitAnswer() {
    if (selected == null) return;
    final current = widget.questions[currentQuestionIndex];
    final isCorrect = selected == current.correctIndex;

    String explanationText;
    if (isCorrect) {
      explanationText = current.explanation;
    } else if (current.incorrectExplanations != null &&
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFD1C4E9), // morado suave arriba
              Color(0xFF6A1B9A), // morado fuerte abajo
            ],
          ),
        ),
        child: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Column(
                  key: ValueKey<int>(currentQuestionIndex),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFAB47BC), // morado medio
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

                    const SizedBox(height: 24),

                    // Option buttons
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
                                  ? const Color(0xFFAB47BC) // morado medio
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

                    const SizedBox(height: 8),

                    // Submit button OR feedback card
                    if (!showFeedback)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // View Text
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context, currentQuestionIndex);
                            },
                            icon: const Icon(Icons.menu_book,
                                color: Colors.white),
                            label: const Text(
                              "View Text",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentDark,
                              elevation: 4,
                              shadowColor: accentDark.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                            ),
                          ),

                          // Submit
                          ElevatedButton(
                            onPressed: selected != null ? _submitAnswer : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF8E24AA), // morado botón
                              disabledBackgroundColor:
                                  accentDark.withOpacity(0.35),
                              elevation: 4,
                              shadowColor: accentDark.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 14),
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
                        ],
                      )
                    else
                      // Feedback card
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
                              onPressed: _goNext,
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
        ),
      ),
    );
  }
}
