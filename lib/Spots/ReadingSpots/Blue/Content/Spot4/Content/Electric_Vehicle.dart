import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Blue/Content/Spot4/Spot_Page/ReadingSpot.dart';

import 'dart:math' as math;

class EVTransitionSplashScreen extends StatefulWidget {
  const EVTransitionSplashScreen({super.key});

  @override
  State<EVTransitionSplashScreen> createState() =>
      _EVTransitionSplashScreenState();
}

class _EVTransitionSplashScreenState extends State<EVTransitionSplashScreen>
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
            pageBuilder: (_, __, ___) => const Vehicle(),
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
                    // EV icon with pulse + glow
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
                                painter: _EVIconPainter(),
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
                            "The Global Transition\nto Electric Vehicles",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.dmSerifDisplay(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFFF4EEFF),
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
                        "By Rami Zaino et al. 2024",
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

// ── EV Icon painter ───────────────────────────────────────────────────────────

class _EVIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD8B4FE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double s = size.width / 24;

    // Car body
    final bodyPath = Path();
    bodyPath.moveTo(5 * s, 17 * s);
    bodyPath.lineTo(3 * s, 17 * s);
    bodyPath.arcToPoint(Offset(2 * s, 16 * s),
        radius: const Radius.circular(1), clockwise: false);
    bodyPath.lineTo(2 * s, 12.5 * s);
    bodyPath.lineTo(4.5 * s, 7.5 * s);
    bodyPath.arcToPoint(Offset(5.4 * s, 7 * s),
        radius: const Radius.circular(1), clockwise: true);
    bodyPath.lineTo(18.6 * s, 7 * s);
    bodyPath.arcToPoint(Offset(19.5 * s, 7.5 * s),
        radius: const Radius.circular(1), clockwise: true);
    bodyPath.lineTo(22 * s, 12.5 * s);
    bodyPath.lineTo(22 * s, 16 * s);
    bodyPath.arcToPoint(Offset(21 * s, 17 * s),
        radius: const Radius.circular(1), clockwise: false);
    bodyPath.lineTo(19 * s, 17 * s);
    canvas.drawPath(bodyPath, paint);

    // Wheel arches + wheels
    canvas.drawCircle(Offset(7.5 * s, 17.5 * s), 2.5 * s, paint);
    canvas.drawCircle(Offset(16.5 * s, 17.5 * s), 2.5 * s, paint);

    // Axle line between wheels
    canvas.drawLine(
      Offset(10 * s, 17 * s),
      Offset(14 * s, 17 * s),
      paint,
    );

    // Window line
    canvas.drawLine(
      Offset(2 * s, 12 * s),
      Offset(22 * s, 12 * s),
      paint,
    );
  }

  @override
  bool shouldRepaint(_EVIconPainter old) => false;
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
    final paint = Paint()
      ..color = const Color(0xFFA855F7).withOpacity(0.28);

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

class Vehicle extends StatefulWidget {
  const Vehicle({super.key});
  @override
  State<Vehicle> createState() => _VehicleState();
}

class _VehicleState extends State<Vehicle> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is the primary power source for an electric car?",
      "options": ["A) Gasoline", "B) Diesel", "C) Electricity", "D) Solar"],
      "correct": 2,
      "feedback": [
        " Gasoline is used in traditional cars, not electric ones.",
        " Diesel is not used in electric cars.",
        " Correct! 🚘 Electric cars run on electricity, stored in batteries, rather than on gasoline or diesel.",
        " Solar energy is not the direct power source, though it can be used to charge batteries."
      ]
    },
    {
      "question":
          "What is the main component used to store energy in an electric car?",
      "options": [
        "A) Solar panel",
        "B) Battery",
        "C) Fuel tank",
        "D) Wind turbine"
      ],
      "correct": 1,
      "feedback": [
        " Solar panels are used to collect energy, not store it.",
        " Correct! 🚘 Electric cars use batteries to store the energy that powers the electric motor.",
        " Fuel tanks are used in gasoline vehicles, not electric ones.",
        " Wind turbines generate energy but are not part of electric cars."
      ]
    },
    {
      "question":
          "How long does it typically take to fully charge an electric car at home?",
      "options": ["A) 30 minutes", "B) 1 hour", "C) 8-12 hours", "D) 24 hours"],
      "correct": 2,
      "feedback": [
        " 30 minutes is too short for home charging.",
        " 1 hour is usually too quick for a full home charge.",
        " Correct! Charging times vary, but at home, a full charge typically takes 8-12 hours depending on the battery and charging station.",
        " 24 hours is longer than necessary with standard home equipment."
      ]
    },
    {
      "question":
          "What is one major benefit of driving an electric car over a gasoline-powered car?",
      "options": [
        "A) Higher fuel costs",
        "B) Lower emissions",
        "C) No need for maintenance",
        "D) Higher maintenance costs"
      ],
      "correct": 1,
      "feedback": [
        " Electric cars usually have lower fuel costs.",
        " Correct! Electric cars produce no tailpipe emissions, helping reduce air pollution and greenhouse gases.",
        " Electric cars still require some maintenance.",
        " Electric cars tend to have lower maintenance costs than gasoline cars."
      ]
    },
    {
      "question":
          "What is the most common type of battery used in electric cars?",
      "options": [
        "A) Lead-acid battery",
        "B) Lithium-ion battery",
        "C) Nickel-cadmium battery",
        "D) Alkaline battery"
      ],
      "correct": 1,
      "feedback": [
        " Lead-acid batteries are outdated and heavy.",
        " Correct!  Lithium-ion batteries are commonly used in electric vehicles because they are lightweight, have a high energy density, and last longer.",
        " Nickel-cadmium batteries are not commonly used in EVs.",
        " Alkaline batteries are not suitable for electric vehicles."
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
              builder: (_) => const PurpleArticlesAnimation(title: "The Global Transition\nto Electric Vehicles", nextPage: BiographyReadingPage(),)),
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
          builder: (_) => QuestionPage(questions: sampleQuestions),
        ),
      );
    });
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
        height: 2.0,
        fontWeight: FontWeight.bold,
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
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TÍTULO
                const Center(
                  child: Text(
                    "Introduction",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      height: 2.0,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  "The global transportation sector is undergoing a fundamental "
                  "transformation as electric vehicles (EVs) replace traditional "
                  "internal combustion engine (ICE) vehicles. The adoption of EVs "
                  "is driven by multiple factors, including the urgent need to mitigate "
                  "climate change, advancements in battery technology, and shifts in "
                  "government policies worldwide. While EVs have been in development "
                  "for decades, their mainstream adoption has accelerated due to "
                  "increasing concerns about greenhouse gas emissions and air pollution. "
                  "Governments, industries, and consumers alike recognize EVs as a key "
                  "solution to reducing the carbon footprint of transportation. "
                  "However, the widespread adoption of EVs is not without challenges. "
                  "The transition requires advancements in technology, particularly "
                  "in battery storage and charging infrastructure, as well as policy "
                  "changes that support EV uptake and ensure an equitable shift to "
                  "sustainable transportation. Additionally, organizations—from automotive "
                  "manufacturers to energy providers—must adapt to new market demands "
                  "and technological paradigms. Finally, the environmental impact of EVs "
                  "must be critically assessed, including the life cycle emissions of "
                  "battery production and the sourcing of raw materials. "
                  "This article provides a comprehensive review of the multidimensional "
                  "aspects of EV adoption, examining technological innovations, "
                  "environmental implications, organizational transformations, and "
                  "policy measures. It draws from recent research, particularly a "
                  "systematic review of 88 peer-reviewed articles, to present a "
                  "well-rounded perspective on the current state of EVs and their role "
                  "in the future of transportation.",
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
        'What does the word “shifts” most likely mean in the sentence below?\n\n*"The adoption of EVs is driven by multiple factors, including the urgent need to mitigate climate change, advancements in battery technology, and shifts in government policies worldwide."*',
    options: [
      "A) Minor changes",
      "B) Complete changes",
      "C) Increases in quantity",
      "D) Slower progress"
    ],
    correctIndex: 1,
    explanation:
        ' “Shifts” in this context refers to significant changes in government policies, as indicated by the words “advancements” and “urgent need,” suggesting more substantial or sweeping changes.',
    incorrectExplanations: [
      ' Minor changes do not reflect the significant nature of the context.',
      ' Correct answer!',
      ' Increases in quantity is not implied here.',
      ' Slower progress does not relate to the meaning of "shifts" in this sentence.',
    ],
  ),
  QuestionData(
    question:
        'What does the prefix “re-” in the word “review” most likely mean in the sentence below?\n\n*"This article provides a comprehensive review of the multidimensional aspects of EV adoption.*"',
    options: ["A) Again", "B) Before", "C) Without", "D) Over"],
    correctIndex: 0,
    explanation:
        ' The prefix “re-” means “again,” indicating the action of looking at or considering something again, as in reviewing a topic or subject.',
    incorrectExplanations: [
      ' Correct answer!',
      ' “Before” is not the correct meaning of “re-.”',
      ' “Without” does not apply to the prefix “re-.”',
      ' “Over” is not the correct interpretation of “re-” in this context.',
    ],
  ),
  QuestionData(
    question:
        'What does the word “policies” most likely mean in the sentence below?\n\n*"...advancements in battery technology, and shifts in government policies worldwide.*"',
    options: [
      "A) Políticas",
      "B) Procedimientos",
      "C) Problemas",
      "D) Proyectos"
    ],
    correctIndex: 0,
    explanation:
        ' “Policies” is a cognate of the Spanish word “políticas,” meaning the principles or guidelines followed by governments, organizations, or institutions.',
    incorrectExplanations: [
      ' Correct answer!',
      ' “Procedimientos” are steps or methods, not broad governing rules.',
      ' “Problemas” means problems, which is not the intended meaning.',
      ' “Proyectos” refers to projects, not policies or guidelines.',
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

  static const Color accentDark = Color(0xFF6A1B9A);  // morado oscuro
  static const Color cardBg = Color(0xFFF3E5F5);      // lavanda muy claro

  List<TextSpan> _parseItalicText(String text, TextStyle baseStyle) {
    final regex = RegExp(r'\*(.*?)\*', dotAll: true);
    final matches = regex.allMatches(text);

    if (matches.isEmpty) {
      return [TextSpan(text: text, style: baseStyle)];
    }

    List<TextSpan> spans = [];
    int lastEnd = 0;

    for (final match in matches) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: baseStyle,
        ));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: baseStyle.copyWith(fontStyle: FontStyle.italic),
      ));
      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: baseStyle,
      ));
    }

    return spans;
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
          // Fondo degradado morado
          Container(
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
                      child: RichText(
                        text: TextSpan(
                          children: _parseItalicText(
                            question.question,
                            const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Opciones
                    ...List.generate(question.options.length, (i) {
                      final isSelected = selected == i;

                      return GestureDetector(
                        onTap: showFeedback
                            ? null
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

                    // Submit o feedback
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8E24AA), // morado botón
                            disabledBackgroundColor:
                                accentDark.withOpacity(0.35),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
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
Technological Advancements in Electric Vehicles

The technological evolution of EVs has been one of the most significant factors enabling their widespread adoption. Early electric cars suffered from limited range, long charging times, and high costs, making them an impractical alternative to gasoline-powered vehicles. However, significant innovations over the past two decades have addressed many of these limitations.

Battery Technology and Energy Storage

One of the most critical areas of technological progress has been battery development. Lithium-ion batteries, the dominant technology in modern EVs, have undergone major improvements in energy density, cost reduction, and longevity. Early lithium-ion batteries had limited storage capacity, requiring frequent recharges and making long-distance travel inconvenient. Today, next-generation batteries offer significantly higher energy density, allowing vehicles to travel over 400 miles on a single charge.

Moreover, advancements in solid-state batteries promise even greater improvements, with faster charging times, longer lifespans, and reduced fire hazards. Unlike conventional lithium-ion batteries, which use liquid electrolytes, solid-state batteries use solid electrolytes, making them more stable and efficient. Research indicates that these batteries could double the range of current EVs while reducing their overall weight.
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
                /// TÍTULO
                const Center(
                  child: Text(
                    "Technological Advancements in Electric Vehicles",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      height: 2.0,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  "The technological evolution of EVs has been one of the most "
                  "significant factors enabling their widespread adoption. Early "
                  "electric cars suffered from limited range, long charging times, "
                  "and high costs, making them an impractical alternative to "
                  "gasoline-powered vehicles. However, significant innovations "
                  "over the past two decades have addressed many of these limitations.",
                  style: bodyStyle,
                ),

                const SizedBox(height: 24),

                /// SUBTÍTULO
                Text(
                  "Battery Technology and Energy Storage",
                  style: headingStyle,
                ),

                const SizedBox(height: 24),

                Text(
                  "One of the most critical areas of technological progress has been "
                  "battery development. Lithium-ion batteries, the dominant technology "
                  "in modern EVs, have undergone major improvements in energy density, "
                  "cost reduction, and longevity. Early lithium-ion batteries had limited "
                  "storage capacity, requiring frequent recharges and making long-distance "
                  "travel inconvenient. Today, next-generation batteries offer significantly "
                  "higher energy density, allowing vehicles to travel over 400 miles on a single charge.",
                  style: bodyStyle,
                ),

                const SizedBox(height: 24),

                Text(
                  "Moreover, advancements in solid-state batteries promise even greater "
                  "improvements, with faster charging times, longer lifespans, and reduced "
                  "fire hazards. Unlike conventional lithium-ion batteries, which use liquid "
                  "electrolytes, solid-state batteries use solid electrolytes, making them more "
                  "stable and efficient. Research indicates that these batteries could double the "
                  "range of current EVs while reducing their overall weight.",
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
        'What does the word “development” most likely mean in the sentence below?\n\n*"One of the most critical areas of technological progress has been battery development."*',
    options: [
      "A) Destruction and chaos",
      "B) Out of time",
      "C) Growth or improvement",
      "D) Confusion and unclearness"
    ],
    correctIndex: 2,
    explanation:
        ' The context clue is “technological progress,” which suggests that development refers to positive growth or advancement.',
    incorrectExplanations: [
      ' Destruction is the opposite of development.',
      ' “Out of time” does not relate to growth or progress.',
      ' Correct answer!',
      ' Confusion is unrelated to the idea of technological development.',
    ],
  ),
  QuestionData(
    question:
        'What does the word “impractical” most likely mean in the sentence below?\n\n*"... making them an impractical alternative to gasoline-powered vehicles.*"',
    options: [
      "A) In a practical manner",
      "B) Very practical",
      "C) Against practicalism",
      "D) Not practical"
    ],
    correctIndex: 3,
    explanation:
        ' The prefix “im-” means “not.” So impractical means not practical or not useful or realistic.',
    incorrectExplanations: [
      ' This is the opposite meaning.',
      ' “Very practical” contradicts the prefix “im-.”',
      ' “Against practicalism” is not standard usage.',
      ' Correct answer!',
    ],
  ),
  QuestionData(
    question:
        'What does the word “density” most likely mean in the sentence below?\n\n*"Today, next-generation batteries offer significantly higher energy density, allowing vehicles to travel over 400 miles on a single charge.* "',
    options: ["A) Espesor", "B) Densidad", "C) Claridad", "D) Energía"],
    correctIndex: 1,
    explanation:
        ' “Density” is a cognate of the Spanish word “densidad,” referring to how much energy can be stored in a given space or mass, which makes it especially important for batteries.',
    incorrectExplanations: [
      ' “Espesor” means thickness, not energy concentration.',
      ' Correct answer!',
      ' “Claridad” means clarity, unrelated to energy storage.',
      ' “Energía” is related but not precise; density is more specific.',
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

  static const Color accentDark = Color(0xFF6A1B9A);  // morado oscuro
  static const Color cardBg = Color(0xFFF3E5F5);      // lavanda muy claro

  List<TextSpan> _parseItalicText(String text, TextStyle baseStyle) {
    final regex = RegExp(r'\*(.*?)\*', dotAll: true);
    final matches = regex.allMatches(text);

    if (matches.isEmpty) {
      return [TextSpan(text: text, style: baseStyle)];
    }

    List<TextSpan> spans = [];
    int lastEnd = 0;

    for (final match in matches) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: baseStyle,
        ));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: baseStyle.copyWith(fontStyle: FontStyle.italic),
      ));
      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: baseStyle,
      ));
    }

    return spans;
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
          // Fondo degradado morado
          Container(
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
                      child: RichText(
                        text: TextSpan(
                          children: _parseItalicText(
                            question.question,
                            const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Opciones
                    ...List.generate(question.options.length, (i) {
                      final isSelected = selected == i;

                      return GestureDetector(
                        onTap: showFeedback
                            ? null
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

                    // Submit o feedback
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8E24AA), // morado botón
                            disabledBackgroundColor:
                                accentDark.withOpacity(0.35),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
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
Charging Infrastructure and Vehicle-to-Grid (V2G) Integration

For EV adoption to be practical, widespread charging infrastructure is necessary. While early adopters of EVs primarily relied on home charging stations, urban environments and long-distance travel require an extensive network of public fast-charging stations. Governments and private companies have invested heavily in expanding high-speed charging networks, reducing the time it takes to charge an EV from several hours to less than 30 minutes in some cases.

Additionally, emerging vehicle-to-grid (V2G) technology allows EVs to act as mobile energy storage units. With V2G integration, EVs can return electricity to the grid during peak demand, enhancing the stability of renewable energy sources such as solar and wind. This innovation transforms EVs from mere transportation devices into key components of smart energy systems, helping to balance electricity supply and demand.

Autonomous Driving and Smart Connectivity

EVs are often equipped with advanced autonomous driving capabilities and smart connectivity features, further distinguishing them from traditional vehicles. Many modern EVs include semi-autonomous driving systems, AI-powered navigation, and over-the-air software updates, making them more efficient, safer, and adaptable to changing driving conditions.

These technological developments ensure that EVs are not just an alternative to gasoline-powered cars but a superior transportation solution in terms of efficiency, safety, and sustainability.
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
                /// TÍTULO
                const Center(
                  child: Text(
                    "Charging Infrastructure and Vehicle-to-Grid (V2G) Integration",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      height: 2.0,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  "For EV adoption to be practical, widespread charging infrastructure is necessary. "
                  "While early adopters of EVs primarily relied on home charging stations, urban environments "
                  "and long-distance travel require an extensive network of public fast-charging stations. "
                  "Governments and private companies have invested heavily in expanding high-speed charging networks, "
                  "reducing the time it takes to charge an EV from several hours to less than 30 minutes in some cases.",
                  style: bodyStyle,
                ),

                const SizedBox(height: 24),

                Text(
                  "Additionally, emerging vehicle-to-grid (V2G) technology allows EVs to act as mobile energy storage units. "
                  "With V2G integration, EVs can return electricity to the grid during peak demand, enhancing the stability of "
                  "renewable energy sources such as solar and wind. This innovation transforms EVs from mere transportation devices "
                  "into key components of smart energy systems, helping to balance electricity supply and demand.",
                  style: bodyStyle,
                ),

                const SizedBox(height: 24),

                /// SUBTÍTULO
                Text(
                  "Autonomous Driving and Smart Connectivity",
                  style: headingStyle,
                ),

                const SizedBox(height: 24),

                Text(
                  "EVs are often equipped with advanced autonomous driving capabilities and smart connectivity features, "
                  "further distinguishing them from traditional vehicles. Many modern EVs include semi-autonomous driving systems, "
                  "AI-powered navigation, and over-the-air software updates, making them more efficient, safer, and adaptable "
                  "to changing driving conditions.",
                  style: bodyStyle,
                ),

                const SizedBox(height: 24),

                Text(
                  "These technological developments ensure that EVs are not just an alternative to gasoline-powered cars "
                  "but a superior transportation solution in terms of efficiency, safety, and sustainability.",
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

final List<QuestionData> sampleQuestionsThird = [
  QuestionData(
    question:
        'What does the word “grid” most likely mean in the sentence below?\n\n*"With V2G integration, EVs can return electricity to the grid during peak demand, enhancing the stability of renewable energy resources..."*',
    options: [
      "A) A parking spot",
      "B) A power network",
      "C) A map",
      "D) A car engine"
    ],
    correctIndex: 1,
    explanation:
        ' The context clue is about “returning electricity” and “energy sources,” which indicates that grid refers to the power grid—a network for delivering electricity.',
    incorrectExplanations: [
      ' A parking spot doesn’t relate to energy systems.',
      ' Correct answer!',
      ' A map is unrelated to electricity networks.',
      ' A car engine is not a network for delivering electricity.',
    ],
  ),
  QuestionData(
    question:
        'What does the word “renewable” most likely mean in the sentence below?\n\n*"Enhancing the stability of renewable energy sources such as solar and wind."*',
    options: [
      "A) Full of energy",
      "B) Without stability",
      "C) Capable of being renewed",
      "D) Opposite of waste"
    ],
    correctIndex: 2,
    explanation:
        ' The suffix -able means “capable of being.” So renewable means “capable of being renewed,” which refers to energy sources that can be naturally replenished.',
    incorrectExplanations: [
      ' “Full of energy” doesn’t capture the idea of being able to renew.',
      ' Stability is not the key trait here.',
      ' Correct answer!',
      ' “Opposite of waste” is too vague and imprecise.',
    ],
  ),
  QuestionData(
    question:
        'What does the word “efficiency” most likely mean in the sentence below?\n\n*"EVs are not just an alternative to gasoline-powered cars but a superior transportation solution in terms of efficiency, safety, and sustainability.*"',
    options: ["A) Eficacia", "B) Emergencia", "C) Influencia", "D) Eficiencia"],
    correctIndex: 3,
    explanation:
        ' “Efficiency” is a cognate of the Spanish word eficiencia, meaning the ability to achieve maximum productivity with minimum wasted effort or energy.',
    incorrectExplanations: [
      ' “Eficacia” is close but not the correct cognate here.',
      ' “Emergencia” is unrelated.',
      ' “Influencia” means influence, not efficiency.',
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

  static const Color accentDark = Color(0xFF6A1B9A);  // morado oscuro
  static const Color cardBg = Color(0xFFF3E5F5);      // lavanda muy claro

  List<TextSpan> _parseItalicText(String text, TextStyle baseStyle) {
    final regex = RegExp(r'\*(.*?)\*', dotAll: true);
    final matches = regex.allMatches(text);

    if (matches.isEmpty) {
      return [TextSpan(text: text, style: baseStyle)];
    }

    List<TextSpan> spans = [];
    int lastEnd = 0;

    for (final match in matches) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: baseStyle,
        ));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: baseStyle.copyWith(fontStyle: FontStyle.italic),
      ));
      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: baseStyle,
      ));
    }

    return spans;
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
          // Fondo degradado morado
          Container(
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
                      child: RichText(
                        text: TextSpan(
                          children: _parseItalicText(
                            question.question,
                            const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Opciones
                    ...List.generate(question.options.length, (i) {
                      final isSelected = selected == i;

                      return GestureDetector(
                        onTap: showFeedback
                            ? null
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

                    // Submit o feedback
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8E24AA), // morado botón
                            disabledBackgroundColor:
                                accentDark.withOpacity(0.35),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
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
Environmental Impacts of EV Adoption

A primary motivation for transitioning to EVs is their potential to reduce environmental harm. However, while EVs eliminate tailpipe emissions, their overall environmental impact depends on several factors, including battery production, electricity generation, and end-of-life disposal.

Reduction in Greenhouse Gas Emissions

EVs produce zero direct emissions, leading to improved air quality in urban areas and a significant reduction in greenhouse gas (GHG) emissions over their lifetime. Studies indicate that even when accounting for electricity generation, EVs have a smaller carbon footprint compared to gasoline vehicles.

Countries with clean energy grids, such as those relying on hydropower, wind, or solar energy, benefit the most from EV adoption. However, in regions where electricity is still generated from fossil fuels, the environmental benefits of EVs are partially offset by emissions from coal or natural gas power plants.

Sustainability Concerns: Raw Materials and Battery Recycling

The extraction of raw materials for EV batteries, particularly lithium, cobalt, and nickel, poses significant environmental and ethical challenges. Mining operations often lead to habitat destruction, water pollution, and human rights violations.

To mitigate these issues, researchers and companies are developing alternative battery chemistries that reduce reliance on scarce materials. Lithium iron phosphate (LFP) batteries, for instance, offer a more sustainable alternative by eliminating the need for cobalt.

Furthermore, battery recycling programs and second-life applications (such as repurposing used EV batteries for energy storage in homes) are essential for minimizing waste and reducing environmental harm.
''';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkScrollEnd);
  }

  void _checkScrollEnd() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    const threshold = 30.0; // Ajusta el umbral según sea necesario del scroll

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
                /// TÍTULO
                const Center(
                  child: Text(
                    "Environmental Impacts of EV Adoption",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      height: 2.0,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  "A primary motivation for transitioning to EVs is their potential to reduce environmental harm. "
                  "However, while EVs eliminate tailpipe emissions, their overall environmental impact depends on several "
                  "factors, including battery production, electricity generation, and end-of-life disposal.",
                  style: bodyStyle,
                ),

                const SizedBox(height: 24),
                const Center(
                  child: Text(
                    "Reduction in Greenhouse Gas Emissions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      height: 2.0,
                    ),
                  ),
                ),

                Text(
                  "EVs produce zero direct emissions, leading to improved air quality in urban areas and a significant "
                  "reduction in greenhouse gas (GHG) emissions over their lifetime. Studies indicate that even when accounting "
                  "for electricity generation, EVs have a smaller carbon footprint compared to gasoline vehicles.",
                  style: bodyStyle,
                ),

                const SizedBox(height: 24),

                Text(
                  "Countries with clean energy grids, such as those relying on hydropower, wind, or solar energy, benefit the most "
                  "from EV adoption. However, in regions where electricity is still generated from fossil fuels, the environmental "
                  "benefits of EVs are partially offset by emissions from coal or natural gas power plants.",
                  style: bodyStyle,
                ),

                const SizedBox(height: 24),

                /// SUBTÍTULO
                Text(
                  "Sustainability Concerns: Raw Materials and Battery Recycling",
                  style: headingStyle,
                ),

                const SizedBox(height: 24),

                Text(
                  "The extraction of raw materials for EV batteries, particularly lithium, cobalt, and nickel, poses significant "
                  "environmental and ethical challenges. Mining operations often lead to habitat destruction, water pollution, "
                  "and human rights violations.",
                  style: bodyStyle,
                ),

                const SizedBox(height: 24),

                Text(
                  "To mitigate these issues, researchers and companies are developing alternative battery chemistries that reduce "
                  "reliance on scarce materials. Lithium iron phosphate (LFP) batteries, for instance, offer a more sustainable "
                  "alternative by eliminating the need for cobalt.",
                  style: bodyStyle,
                ),

                const SizedBox(height: 24),

                Text(
                  "Furthermore, battery recycling programs and second-life applications (such as repurposing used EV batteries for "
                  "energy storage in homes) are essential for minimizing waste and reducing environmental harm.",
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

final List<QuestionData> sampleQuestionsFinal = [
  QuestionData(
    question:
        'What does the word “greenhouse” most likely refer to in the sentence below?\n\n*"EVs produce zero direct emissions, leading to improved air quality in urban areas and a significant reduction in greenhouse gas (GHG) emissions over their lifetime."*',
    options: [
      "A) A building for plants",
      "B) A fossil fuel",
      "C) A type of harmful gas",
      "D) A fuel made from plants"
    ],
    correctIndex: 2,
    explanation:
        ' The context clue is “emissions over their lifetime” and “air quality,” suggesting that “greenhouse gases” are harmful gases that trap heat and contribute to climate change.',
    incorrectExplanations: [
      ' A building for plants is a literal meaning, not the intended one here.',
      ' A fossil fuel is not what “greenhouse” refers to in this context.',
      ' Correct answer!',
      ' “Fuel made from plants” is unrelated to greenhouse gases.',
    ],
  ),
  QuestionData(
    question:
        'What does the word “pollution” most likely mean in the sentence below?\n\n*"Mining operations often lead to habitat destruction, water pollution, and human rights violations.*"',
    options: ["A) Polución", "B) Población", "C) Posición", "D) Publicación"],
    correctIndex: 0,
    explanation:
        ' “Pollution” is a cognate of the Spanish word polución, meaning the presence of harmful substances in the environment (in this case, in water).',
    incorrectExplanations: [
      ' Correct answer!',
      ' “Población” means population, not pollution.',
      ' “Posición” means position, which is unrelated.',
      ' “Publicación” means publication, not pollution.',
    ],
  ),
  QuestionData(
    question:
        'What does the word “challenges” most likely mean in the sentence below?\n\n*"The extraction of raw materials for EV batteries, particularly lithium, cobalt, and nickel, poses significant environmental and ethical challenges.*"',
    options: ["A) Gifts", "B) Opportunities", "C) Difficulties", "D) Friends"],
    correctIndex: 2,
    explanation:
        ' The context mentions “environmental and ethical” concerns from mining, suggesting challenges are serious problems or obstacles.',
    incorrectExplanations: [
      ' “Gifts” are not related to problems or concerns.',
      ' “Opportunities” has a positive tone, not matching the sentence.',
      ' Correct answer!',
      ' “Friends” is unrelated to the topic.',
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

  static const Color accentDark = Color(0xFF6A1B9A);  // morado oscuro
  static const Color cardBg = Color(0xFFF3E5F5);      // lavanda muy claro

  List<TextSpan> _parseItalicText(String text, TextStyle baseStyle) {
    final regex = RegExp(r'\*(.*?)\*', dotAll: true);
    final matches = regex.allMatches(text);

    if (matches.isEmpty) {
      return [TextSpan(text: text, style: baseStyle)];
    }

    List<TextSpan> spans = [];
    int lastEnd = 0;

    for (final match in matches) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: baseStyle,
        ));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: baseStyle.copyWith(fontStyle: FontStyle.italic),
      ));
      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: baseStyle,
      ));
    }

    return spans;
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
          // Fondo degradado morado
          Container(
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
                      child: RichText(
                        text: TextSpan(
                          children: _parseItalicText(
                            question.question,
                            const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Opciones
                    ...List.generate(question.options.length, (i) {
                      final isSelected = selected == i;

                      return GestureDetector(
                        onTap: showFeedback
                            ? null
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

                    // Submit o feedback
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8E24AA), // morado botón
                            disabledBackgroundColor:
                                accentDark.withOpacity(0.35),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
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