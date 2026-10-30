import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Dark Blue/Content/Spot4/Spot_Page/ReadingSpot.dart';

import 'dart:math' as math;

class BioprintingPurpleSplash extends StatefulWidget {
  const BioprintingPurpleSplash({super.key});

  @override
  State<BioprintingPurpleSplash> createState() =>
      _BioprintingPurpleSplashState();
}

class _BioprintingPurpleSplashState extends State<BioprintingPurpleSplash>
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
            pageBuilder: (_, __, ___) => const Dimension(),
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
          // Floating particles
          AnimatedBuilder(
            animation: _particleController,
            builder: (context, _) => CustomPaint(
              painter: _ParticlePainter(_particleController.value),
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
                    // Biotech icon with pulse + glow
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
                                      0.2 + 0.35 * (_pulse.value - 1.0) / 0.15,
                                    ),
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.biotech_rounded,
                                color: Color(0xFFF3ECFF),
                                size: 68,
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
                            "Advancements in\n3D Bioprinting",
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
                        "By Giovanna Ricci et al.  · 2023",
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

// ── Particle painter ──────────────────────────────────────────────────────────

class _ParticlePainter extends CustomPainter {
  final double progress;

  static final List<_Particle> _particles = List.generate(20, (i) {
    return _Particle(
      x: (i * 137.508) % 1.0,
      y: (i * 97.3) % 1.0,
      radius: 1.2 + (i % 4) * 0.8,
      speed: 0.04 + (i % 5) * 0.018,
      phase: (i * 0.43) % 1.0,
    );
  });

  _ParticlePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFA855F7).withOpacity(0.28);

    for (final p in _particles) {
      final dy = (p.y + progress * p.speed + p.phase) % 1.0;
      final dx = p.x + 0.03 * math.sin(progress * math.pi * 2 + p.phase * 6);
      canvas.drawCircle(
        Offset(dx * size.width, dy * size.height),
        p.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => true;
}

class _Particle {
  final double x, y, radius, speed, phase;
  const _Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.speed,
    required this.phase,
  });
}

class Dimension extends StatefulWidget {
  const Dimension({super.key});
  @override
  State<Dimension> createState() => _DimensionState();
}

class _DimensionState extends State<Dimension> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is the basic function of body tissue?",
      "options": [
        "A) To form and support organs and systems",
        "B) To help the body digest food",
        "C) To color the skin, teeth and nails",
        "D) To produce oxygen and improve blood pressure"
      ],
      "correct": 0,
      "feedback": [
        " Correct! Tissues are groups of similar cells that work together to perform specific functions and build the body's structures.",
        " That's incorrect. Digestion involves organs like the stomach and enzymes, not tissues alone.",
        " Coloring the body is related to pigments like melanin, not a core function of tissues.",
        " Producing oxygen is primarily a function of the lungs and red blood cells, not tissues generally."
      ]
    },
    {
      "question": "What is 3D printing of tissues used for?",
      "options": [
        "A) To create food",
        "B) To build living organs and tissues",
        "C) To print books",
        "D) To make plastic objects"
      ],
      "correct": 1,
      "feedback": [
        " While food printing exists, it's unrelated to tissue bioprinting.",
        " Correct! 3D bioprinting allows scientists to create layers of living cells to build tissues and organs for research, transplants, and drug testing.",
        " Book printing is unrelated to tissue engineering.",
        " Plastic objects are printed with standard 3D printers, not tissue bioprinters."
      ]
    },
    {
      "question": "Which type of material is used in 3D tissue printing?",
      "options": ["A) Plastic only", "B) Ink", "C) Bioink", "D) Paper"],
      "correct": 2,
      "feedback": [
        " Plastic is not used in living tissue bioprinting.",
        " Standard ink does not contain living cells.",
        " Correct! Bioinks are a blend of living cells and materials that help form the base for creating human tissues in 3D printing.",
        " Paper is unrelated to the materials used in 3D bioprinting."
      ]
    },
    {
      "question": "What is a major challenge in 3D printing human tissues?",
      "options": [
        "A) Making the tissues colorful",
        "B) Getting them to function like real organs",
        "C) Printing larger than usual objects",
        "D) Using metal-based materials"
      ],
      "correct": 1,
      "feedback": [
        " Color is not a critical challenge in tissue engineering.",
        " Correct! While 3D printing can create tissue structures, ensuring they function like real, living organs remains a significant challenge.",
        " Size isn't the main difficulty; complexity and functionality are.",
        " Metals are not typically used in bioprinting human tissues."
      ]
    },
    {
      "question":
          "What is the potential impact of 3D tissue printing on organ donation?",
      "options": [
        "A) It could make organ donation unnecessary",
        "B) It could increase the demand for organ transplants",
        "C) It could stop the need for any surgery",
        "D) It could make organs more difficult to transplant"
      ],
      "correct": 0,
      "feedback": [
        " Correct! 3D printing could allow for the creation of custom organs, reducing reliance on organ donations.",
        " It would likely decrease, not increase, the demand for donor organs.",
        " Surgery would still be needed to implant 3D printed organs.",
        " Printed organs aim to improve compatibility and ease transplantation, not hinder it."
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
          MaterialPageRoute(
              builder: (_) => const PurpleArticlesAnimation(
                    title: "Advancements in\n3D Bioprinting",
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
  static const _bg = Color(0xFF08010F);
  static const _orb1 = Color(0xFF5B21B6);
  static const _orb2 = Color(0xFF7C3AED);
  static const _accent = Color(0xFFA855F7);
  static const _accent2 = Color(0xFFC4B5FD);
  static const _accent3 = Color(0xFFDDD6FE);

  static const _bookBg = Color(0xFF1A0845);
  static const _bookBg2 = Color(0xFF2D1060);
  static const _bookBdr = Color(0xFF7C3AED);
  static const _spine1 = Color(0xFF8B5CF6);
  static const _spine2 = Color(0xFF6D28D9);
  static const _spine3 = Color(0xFF4C1D95);
  static const _tagBg = Color(0xFF6D28D9);
  static const _tagText = Color(0xFFEDE9FE);

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
    _bodyLine1 = CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.37, 0.47, curve: Curves.easeOut));
    _bodyLine2 = CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.40, 0.50, curve: Curves.easeOut));
    _bodyLine3 = CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.43, 0.52, curve: Curves.easeOut));
    _bodyLine4 = CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.46, 0.55, curve: Curves.easeOut));
    _bodyLine5 = CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.48, 0.57, curve: Curves.easeOut));
    _bodyLine6 = CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.51, 0.60, curve: Curves.easeOut));
    _bodyLine7 = CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.54, 0.62, curve: Curves.easeOut));
    _cursorLineFade = CurvedAnimation(
        parent: _masterCtrl,
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
            left: -80,
            top: -80,
            child: _Orb(
                size: 320,
                color: _orb1.withOpacity(0.11),
                animation: _floatCtrl,
                phase: 0),
          ),
          // Orbe inferior derecho
          Positioned(
            right: -60,
            bottom: -50,
            child: _Orb(
                size: 260,
                color: _orb2.withOpacity(0.09),
                animation: _floatCtrl,
                phase: math.pi),
          ),
          // Orbe central sutil
          Positioned(
            left: MediaQuery.of(context).size.width * 0.28,
            top: MediaQuery.of(context).size.height * 0.38,
            child: _Orb(
                size: 180,
                color: _accent.withOpacity(0.06),
                animation: _floatCtrl,
                phase: math.pi * 0.5),
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
              final dy =
                  math.sin(_floatCtrl.value * math.pi * 2 + p.$4 * math.pi) *
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
              final progress = (_floatCtrl.value + s.$3 * 0.1) % 1.0;
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
      left: 0,
      top: 0,
      bottom: 0,
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
      left: 22,
      right: 10,
      top: 16,
      bottom: 14,
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
              progress: _line1.value, height: 9, color: _accent3, width: 1.0),
          const SizedBox(height: 4),
          _AnimatedLine(
              progress: _line2.value,
              height: 9,
              color: _accent2.withOpacity(0.75),
              width: 0.76),

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
          _AnimatedLine(
              progress: _bodyLine1.value,
              height: 4.5,
              color: _accent.withOpacity(0.38),
              width: 1.0),
          const SizedBox(height: 5),
          _AnimatedLine(
              progress: _bodyLine2.value,
              height: 4.5,
              color: _accent.withOpacity(0.35),
              width: 0.88),
          const SizedBox(height: 5),
          _AnimatedLine(
              progress: _bodyLine3.value,
              height: 4.5,
              color: _accent.withOpacity(0.38),
              width: 0.96),
          const SizedBox(height: 5),
          _AnimatedLine(
              progress: _bodyLine4.value,
              height: 4.5,
              color: _accent.withOpacity(0.33),
              width: 0.72),

          const SizedBox(height: 8),

          _AnimatedLine(
              progress: _bodyLine5.value,
              height: 4.5,
              color: _accent.withOpacity(0.38),
              width: 1.0),
          const SizedBox(height: 5),
          _AnimatedLine(
              progress: _bodyLine6.value,
              height: 4.5,
              color: _accent.withOpacity(0.35),
              width: 0.82),
          const SizedBox(height: 5),
          _AnimatedLine(
              progress: _bodyLine7.value,
              height: 4.5,
              color: _accent.withOpacity(0.33),
              width: 0.58),

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
        final s = 1.0 + math.sin(animation.value * math.pi * 2 + phase) * 0.07;
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
  bool showButton = true; // visible desde el inicio
  bool animating = false;

  /// ⭐ LO IMPORTANTE
  int _lastQuestionIndex = 0;

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

  /// ===== ESTILOS APA =====
  TextStyle get bodyStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        color: Colors.black,
      );

  TextStyle get titleStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        fontWeight: FontWeight.bold,
        height: 2.0,
        color: Colors.black,
      );

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
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Introduction", style: titleStyle),
                const SizedBox(height: 40),
                Text(
                  "The field of biomedical engineering has witnessed rapid advancements over the past decades, "
                  "with 3D bioprinting emerging as a groundbreaking technology. This technique allows scientists "
                  "to create living tissues and even organs layer by layer, using bio-inks composed of living cells. "
                  "The ability to print biological structures has vast implications for regenerative medicine, "
                  "drug testing, and organ transplantation.\n\n"
                  "However, despite its potential, 3D bioprinting faces several challenges, including the complexity "
                  "of tissue structures, the need for biocompatible materials, and the difficulty in vascularization "
                  "(creating blood vessels in printed tissues). This essay explores the principles of 3D bioprinting, "
                  "recent technological advancements, current applications, and the challenges that need to be "
                  "overcome for widespread adoption.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),

          /// ===== BOTÓN (SIEMPRE VISIBLE) =====
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
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
        'What is the main benefit of 3D bioprinting mentioned in the introduction?',
    options: [
      "A) It reduces the cost of medical procedures",
      "B) It allows for the creation of living tissues and organs",
      "C) It eliminates the need for surgery",
      "D) It speeds up computer simulations"
    ],
    correctIndex: 1,
    explanation:
        ' The passage explains that 3D bioprinting enables the creation of living tissues and organs using bio-inks.',
    incorrectExplanations: [
      ' Cost reduction is not the main benefit highlighted.',
      ' Correct answer!',
      ' Surgery may still be needed, even with bioprinted organs.',
      ' Computer simulations are unrelated to the physical creation of tissues.',
    ],
  ),
  QuestionData(
    question: 'What is one major challenge in 3D bioprinting?',
    options: [
      "A) Printing with metal materials",
      "B) Lack of interest from researchers",
      "C) Creating blood vessels in printed tissues",
      "D) High demand for printed toys"
    ],
    correctIndex: 2,
    explanation:
        ' The passage highlights vascularization—creating blood vessels—as one of the key challenges in 3D bioprinting.',
    incorrectExplanations: [
      ' Metal materials are not commonly used in bioprinting living tissues.',
      ' Research interest in 3D bioprinting is actually high.',
      ' Correct answer!',
      ' Toys are unrelated to the medical and biological focus of 3D bioprinting.',
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

  /// ⭐ LO IMPORTANTE
  int _lastQuestionIndex = 0;

  final String biographyTextSecond = '''
Principles of 3D Bioprinting

3D bioprinting is similar to traditional 3D printing, but instead of using plastic or metal, it utilizes bio-inks containing living cells. The process generally follows three key steps:
Pre-processing – Scientists create a digital model of the tissue or organ using imaging techniques like MRI or CT scans.

Bioprinting – The bio-ink is deposited layer by layer using a specialized printer, forming a 3D structure.

Post-processing – The printed tissue is placed in a bioreactor, where it matures and develops its final biological properties.

The main types of bioprinting technologies include:
Inkjet Bioprinting – Uses droplets of bio-ink to create structures.

Extrusion-based Bioprinting – Uses a continuous flow of material for more complex designs.

Laser-assisted Bioprinting – Provides high precision using laser pulses.

Each technique has advantages and limitations, depending on the type of tissue being printed.
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

  /// ✅ AQUÍ VA LA LÓGICA CORRECTA
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
        fontWeight: FontWeight.bold,
        height: 2.0,
        color: Colors.black,
      );

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
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Principles of 3D Bioprinting", style: headingStyle),
                const SizedBox(height: 16),
                Text(
                  "3D bioprinting is similar to traditional 3D printing, but instead of using plastic or metal, it utilizes bio-inks containing living cells. "
                  "The process generally follows three key steps:\n"
                  "Pre-processing – Scientists create a digital model of the tissue or organ using imaging techniques like MRI or CT scans.\n\n"
                  "Bioprinting – The bio-ink is deposited layer by layer using a specialized printer, forming a 3D structure.\n\n"
                  "Post-processing – The printed tissue is placed in a bioreactor, where it matures and develops its final biological properties.\n\n",
                  style: bodyStyle,
                ),
                Text(
                  "The main types of bioprinting technologies include:",
                  style: headingStyle,
                ),
                const SizedBox(height: 16),
                Text(
                  "Inkjet Bioprinting – Uses droplets of bio-ink to create structures.\n\n"
                  "Extrusion-based Bioprinting – Uses a continuous flow of material for more complex designs.\n\n"
                  "Laser-assisted Bioprinting – Provides high precision using laser pulses.\n\n"
                  "Each technique has advantages and limitations, depending on the type of tissue being printed.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),

          /// ===== BOTÓN FLOTANTE =====
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
    question: 'What is the purpose of post-processing in 3D bioprinting?',
    options: [
      "A) To scan the printed object for errors",
      "B) To paint the surface of the structure",
      "C) To mature the printed tissue in a bioreactor",
      "D) To freeze the structure for preservation"
    ],
    correctIndex: 2,
    explanation:
        ' Post-processing involves placing the printed tissue in a bioreactor so it can mature and develop proper biological functions.',
    incorrectExplanations: [
      ' Scanning may happen, but the purpose of post-processing is biological maturation.',
      ' Painting is not part of the bioprinting process for tissues.',
      ' Correct answer!',
      ' Freezing is used for preservation, not for tissue development.',
    ],
  ),
  QuestionData(
    question: 'What happens during post-processing in bioprinting?',
    options: [
      "A) The tissue matures in a bioreactor",
      "B) The tissue is scanned",
      "C) The tissue is frozen",
      "D) The tissue is painted"
    ],
    correctIndex: 0,
    explanation:
        ' In post-processing, printed tissues are placed in bioreactors to grow and develop.',
    incorrectExplanations: [
      ' Correct answer!',
      ' Scanning is not the main activity during post-processing.',
      ' Freezing halts development rather than promoting it.',
      ' Painting is not part of tissue bioprinting processes.',
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

class _BiographyReadingPageThirdState extends State<BiographyReadingPageThird>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  bool showButton = false;
  bool animating = false;
  int _lastQuestionIndex = 0;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

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
        fontWeight: FontWeight.bold,
        height: 2.0,
        color: Colors.black,
      );

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_checkScrollEnd);

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

  Future<void> _goToQuestions() async {
    setState(() => animating = true);
    _fadeController.forward();

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

    _fadeController.reset();
    setState(() => animating = false);
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
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ===== TÍTULO PRINCIPAL =====
                Text(
                  "Recent Technological Advancements",
                  style: headingStyle,
                ),
                const SizedBox(height: 24),

                /// ===== SECCIÓN 1 =====
                Text("Better Bio-Inks and Materials", style: headingStyle),
                const SizedBox(height: 8),
                Text(
                  "One of the biggest advancements in 3D bioprinting is the development of more sophisticated bio-inks. "
                  "These materials must be biocompatible, strong enough to maintain structure, and support cell growth. "
                  "Recent studies have explored using hydrogels, collagen, and even decellularized extracellular matrices "
                  "to improve the quality of printed tissues.",
                  style: bodyStyle,
                ),

                const SizedBox(height: 24),

                /// ===== SECCIÓN 2 =====
                Text("Improved Vascularization", style: headingStyle),
                const SizedBox(height: 8),
                Text(
                  "A major challenge in bioprinting is vascularization—the formation of blood vessels within printed tissues. "
                  "Without blood flow, cells in the inner layers of printed tissues cannot receive oxygen and nutrients, "
                  "leading to cell death.\n\n"
                  "Recent research has focused on printing tiny channels within tissues that allow the formation of blood vessels. "
                  "Scientists have also experimented with co-printing blood vessel cells alongside other cell types, "
                  "allowing tissues to develop their own vascular networks over time.",
                  style: bodyStyle,
                ),

                const SizedBox(height: 24),

                /// ===== SECCIÓN 3 =====
                Text("Multi-Material Printing", style: headingStyle),
                const SizedBox(height: 8),
                Text(
                  "Many tissues in the human body are made of different types of cells and materials. "
                  "New bioprinting techniques allow scientists to print multiple materials at once, "
                  "better mimicking natural tissues. For example, researchers can now print bone and cartilage together, "
                  "making it possible to repair complex injuries like damaged joints.",
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

          /// ===== OVERLAY CON FADE =====
          if (animating)
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
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
            ),
        ],
      ),
    );
  }
}

final List<QuestionData> sampleQuestionsThird = [
  QuestionData(
    question: 'What is a key improvement in bio-inks for 3D bioprinting?',
    options: [
      "A) They can now conduct electricity",
      "B) They support cell growth",
      "C) They are made of metal",
      "D) They no longer need living cells"
    ],
    correctIndex: 1,
    explanation:
        ' Modern bio-inks are designed to be biocompatible, structurally stable, and supportive of cell growth.',
    incorrectExplanations: [
      ' Conducting electricity is not the goal of bio-inks in tissue engineering.',
      ' Correct answer!',
      ' Metals are not used in bio-inks for growing living tissues.',
      ' Living cells are essential for functional tissue development.',
    ],
  ),
  QuestionData(
    question: 'Why is vascularization important in 3D printed tissues?',
    options: [
      "A) It helps the tissue look more realistic",
      "B) It keeps the tissue cool",
      "C) It allows tissues to grow faster",
      "D) It delivers nutrients to cells"
    ],
    correctIndex: 2,
    explanation:
        ' Vascularization allows blood flow, which is critical for delivering nutrients and oxygen to inner tissue layers.',
    incorrectExplanations: [
      ' A realistic appearance is not the primary concern—functionality is.',
      ' Temperature regulation is not the main purpose of vascularization.',
      ' Correct answer!',
      ' While nutrients are delivered, the faster growth aspect is more emphasized in the context of tissue development.',
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

class BiographyReadingPageFinal extends StatefulWidget {
  const BiographyReadingPageFinal({super.key});

  @override
  State<BiographyReadingPageFinal> createState() =>
      _BiographyReadingPageFinalState();
}

class _BiographyReadingPageFinalState extends State<BiographyReadingPageFinal>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  bool showButton = false;
  bool animating = false;

  int _lastQuestionIndex = 0;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final String textRegenerativeMedicine = '''
One of the most promising uses of 3D bioprinting is in regenerative medicine—the field focused on replacing or repairing damaged tissues. Scientists are already able to print simple tissues like skin, cartilage, and bone, which can be used for medical treatments.
In the future, bioprinted organs could solve the organ transplant crisis, reducing the need for donors and eliminating organ rejection, since the printed organs would be made from a patient's own cells.
''';

  final String textDrugTesting = '''
Pharmaceutical companies are using 3D bioprinting to create artificial human tissues for drug testing. This allows researchers to study how new medicines affect real human cells, making drug development safer and faster.
Additionally, personalized medicine could benefit from bioprinting by creating tissues tailored to an individual's genetic profile, leading to more effective treatments.
''';

  final String textWoundHealing = '''
3D bioprinting is also being used to create customized skin grafts for burn victims. Scientists have successfully printed layers of human skin, which can be applied to patients to speed up healing and reduce scarring.
''';

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_checkScrollEnd);

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
    const threshold = 30.0;

    if (currentScroll >= maxScroll - threshold && !showButton) {
      setState(() => showButton = true);
    } else if (currentScroll < maxScroll - threshold && showButton) {
      setState(() => showButton = false);
    }
  }

  Future<void> _goToQuestions() async {
    setState(() => animating = true);
    _fadeController.forward();

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

    _fadeController.reset();
    setState(() => animating = false);
  }

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
        fontWeight: FontWeight.bold,
        height: 2.0,
        color: Colors.black,
      );

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
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
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Applications of 3D Bioprinting", style: headingStyle),
                const SizedBox(height: 16),

                // Subtítulo 1
                Text("Regenerative Medicine", style: headingStyle),
                Text(textRegenerativeMedicine, style: bodyStyle),

                // Subtítulo 2
                Text("Drug Testing and Personalized Medicine",
                    style: headingStyle),
                Text(textDrugTesting, style: bodyStyle),

                // Subtítulo 3
                Text("Wound Healing and Skin Grafts", style: headingStyle),
                Text(textWoundHealing, style: bodyStyle),

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

          /// ===== OVERLAY CON FADE =====
          if (animating)
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
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
            ),
        ],
      ),
    );
  }
}

final List<QuestionData> sampleQuestionsFinal = [
  QuestionData(
    question:
        'What is one main purpose of using 3D bioprinting in regenerative medicine?',
    options: [
      "A) To produce artificial limbs",
      "B) To create tissues for beauty treatments",
      "C) To make robotic parts more lifelike",
      "D) To repair damaged tissues and organs"
    ],
    correctIndex: 3,
    explanation:
        ' 3D bioprinting is used in regenerative medicine to help rebuild tissues like skin, cartilage, and possibly organs in the future.',
    incorrectExplanations: [
      ' Artificial limbs are not created using bioprinted tissues.',
      ' Beauty treatments are not the focus of regenerative medicine.',
      ' Robotic parts are not the target of tissue regeneration.',
      ' Correct answer!',
    ],
  ),
  QuestionData(
    question:
        'How does 3D bioprinting help make drug testing safer and more accurate?',
    options: [
      "A) By using animals in testing",
      "B) By speeding up computer simulations",
      "C) By printing artificial human tissues",
      "D) By reducing the cost of manufacturing drugs"
    ],
    correctIndex: 2,
    explanation:
        ' Scientists can test drugs on bioprinted human tissues, which improves accuracy and reduces the need for animal or human trials early in development.',
    incorrectExplanations: [
      ' Bioprinting helps reduce, not increase, animal testing.',
      ' While simulations help, bioprinting offers a physical, accurate model.',
      ' Correct answer!',
      ' Cost is not the main factor related to accuracy or safety in this context.',
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