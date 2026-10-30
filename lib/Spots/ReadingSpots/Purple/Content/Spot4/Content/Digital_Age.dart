import 'package:flutter/material.dart';
import 'package:inferwise/Spots/ReadingSpots/Purple/Content/Spot4/Spot_Page/Reading_Spot_Page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:math' as math;

class DigitalAgeSplashScreen extends StatefulWidget {
  const DigitalAgeSplashScreen({super.key});

  @override
  State<DigitalAgeSplashScreen> createState() => _DigitalAgeSplashScreenState();
}

class _DigitalAgeSplashScreenState extends State<DigitalAgeSplashScreen>
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
            pageBuilder: (_, __, ___) => const Digital_Age(),
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
                    // Globe icon with pulse + glow
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
                                painter: _DigitalGlobeIconPainter(),
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
                            "Media and Policy Making\nin the Digital Age:\nChallenges & Transformations",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.dmSerifDisplay(
                              fontSize: 20,
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
                        "By Emiliano Grossman, 2022",
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
                        "From Annual Review of Political Science",
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

// ── Digital Globe Icon painter ────────────────────────────────────────────────

class _DigitalGlobeIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double s = size.width / 24;

    final mainPaint = Paint()
      ..color = const Color(0xFFD8B4FE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final linePaint = Paint()
      ..color = const Color(0xFFC4B5FD).withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    final thinPaint = Paint()
      ..color = const Color(0xFFC4B5FD).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9
      ..strokeCap = StrokeCap.round;

    final signalPaint = Paint()
      ..color = const Color(0xFFA78BFA).withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1
      ..strokeCap = StrokeCap.round;

    // Globe outline
    canvas.drawCircle(Offset(12 * s, 12 * s), 9 * s, mainPaint);

    // Equator
    canvas.drawLine(
      Offset(3 * s, 12 * s),
      Offset(21 * s, 12 * s),
      linePaint,
    );

    // Upper latitude
    final upperLat = Path();
    upperLat.moveTo(3.5 * s, 8.5 * s);
    upperLat.quadraticBezierTo(12 * s, 6 * s, 20.5 * s, 8.5 * s);
    canvas.drawPath(upperLat, thinPaint);

    // Lower latitude
    final lowerLat = Path();
    lowerLat.moveTo(3.5 * s, 15.5 * s);
    lowerLat.quadraticBezierTo(12 * s, 18 * s, 20.5 * s, 15.5 * s);
    canvas.drawPath(lowerLat, thinPaint);

    // Left longitude
    final leftLon = Path();
    leftLon.moveTo(12 * s, 3 * s);
    leftLon.quadraticBezierTo(8 * s, 8 * s, 8 * s, 12 * s);
    leftLon.quadraticBezierTo(8 * s, 16 * s, 12 * s, 21 * s);
    canvas.drawPath(leftLon, thinPaint);

    // Right longitude
    final rightLon = Path();
    rightLon.moveTo(12 * s, 3 * s);
    rightLon.quadraticBezierTo(16 * s, 8 * s, 16 * s, 12 * s);
    rightLon.quadraticBezierTo(16 * s, 16 * s, 12 * s, 21 * s);
    canvas.drawPath(rightLon, thinPaint);

    // Inner signal wave 1
    final wave1 = Path();
    wave1.moveTo(10 * s, 9 * s);
    wave1.arcToPoint(
      Offset(14 * s, 9 * s),
      radius: Radius.circular(3 * s),
      clockwise: false,
    );
    canvas.drawPath(wave1, signalPaint);

    // Outer signal wave 2
    final wave2 = Path();
    wave2.moveTo(8 * s, 7 * s);
    wave2.arcToPoint(
      Offset(16 * s, 7 * s),
      radius: Radius.circular(5.5 * s),
      clockwise: false,
    );
    canvas.drawPath(
      wave2,
      signalPaint..color = const Color(0xFFA78BFA).withOpacity(0.5),
    );

    // Center dot
    canvas.drawCircle(
      Offset(12 * s, 12 * s),
      1 * s,
      Paint()
        ..color = const Color(0xFFD8B4FE)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(_DigitalGlobeIconPainter old) => false;
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
      final dx =
          p.x + 0.03 * math.sin(progress * math.pi * 2 + p.phase * 6);
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

class Digital_Age extends StatefulWidget {
  const Digital_Age({super.key});
  @override
  State<Digital_Age> createState() => _Digital_AgeState();
}

class _Digital_AgeState extends State<Digital_Age> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Title: Media and Policy Making in the Digital Age: Challenges, Opportunities, and Transformations\n\nWhat is most likely to be explored?",
      "options": [
        "A) Cooking recipes for robots",
        "B) Digital media’s impact on policy",
        "C) Ancient civilizations and the digital age",
        "D) Space exploration and holiday celebrations"
      ],
      "correct": 1,
      "feedback": [
        "Incorrect. Cooking recipes for robots are unrelated to the title.",
        "Correct. The title highlights how media and policymaking interact in the digital era.",
        "Incorrect. Ancient civilizations are not connected to modern policymaking.",
        "Incorrect. Space exploration and holidays are not part of the topic."
      ]
    },
    {
      "question": "How does media influence policy-making?",
      "options": [
        "A) By ignoring political events and agendas",
        "B) By providing entertainment only",
        "C) By controlling elections directly",
        "D) By informing the public and shaping opinions"
      ],
      "correct": 3,
      "feedback": [
        "Incorrect. Media does not influence policy by ignoring events.",
        "Incorrect. Entertainment alone does not shape policy.",
        "Incorrect. Media does not directly control elections.",
        "Correct. Media informs, raises awareness, and influences public opinion, which affects policy."
      ]
    },
    {
      "question":
          "Which type of media can directly reach policymakers and influence decisions?",
      "options": [
        "A) Newspapers, TV, and social media",
        "B) Only radio",
        "C) Only print magazines",
        "D) None; media never reaches policymakers"
      ],
      "correct": 0,
      "feedback": [
        "Correct. Traditional and digital media provide information and advocacy that policymakers monitor.",
        "Incorrect. Radio is only one medium and does not represent the full range.",
        "Incorrect. Print magazines alone cannot ensure broad influence.",
        "Incorrect. Policymakers do receive information from media sources."
      ]
    },
    {
      "question":
          "What is a potential negative effect of media on policy-making?",
      "options": [
        "A) Encouraging informed debate",
        "B) Spreading misinformation or bias",
        "C) Providing access to diverse viewpoints",
        "D) Increasing transparency"
      ],
      "correct": 1,
      "feedback": [
        "Incorrect. Informed debate is a positive effect.",
        "Correct. Biased reporting or misinformation can mislead the public and policymakers.",
        "Incorrect. Access to diverse viewpoints is beneficial.",
        "Incorrect. Transparency is also a positive effect."
      ]
    },
    {
      "question": "How can citizens use media to influence policy?",
      "options": [
        "A) By ignoring news",
        "B) By sharing information and opinions",
        "C) By avoiding social networks and trends",
        "D) By only watching entertainment shows"
      ],
      "correct": 1,
      "feedback": [
        "Incorrect. Ignoring news prevents civic participation.",
        "Correct. Citizens can raise awareness, share views, and engage in public discussion through media.",
        "Incorrect. Avoiding social networks limits participation.",
        "Incorrect. Entertainment shows do not directly influence policy."
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
          MaterialPageRoute(builder: (_) => const PurpleArticlesAnimation(title: "The Digital Age", nextPage: BiographyReadingPage(),)),
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

class _BiographyReadingPageState extends State<BiographyReadingPage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

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

  void _goToQuestions() {
    setState(() => animating = true);
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

  // 📚 ESTILOS APA
  TextStyle get bodyStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        color: Colors.black,
      );

  TextStyle get titleStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );

  TextStyle get subtitleStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        color: Colors.black,
      );

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
                /// 🔹 TÍTULO
                Text(
                  "Introduction",
                  style: titleStyle,
                ),
                const SizedBox(height: 24),

                /// 🔹 PÁRRAFO 1
                Text(
                  "    The relationship between media and policy making has undergone profound changes in the digital era. Traditional media, once the primary force in shaping public discourse and influencing policy decisions, now coexists with digital platforms, social media, and decentralized networks of information dissemination.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                /// 🔹 PÁRRAFO 2
                Text(
                  "    While these developments have democratized access to information, they have also introduced new challenges, including misinformation, information overload, and shifting patterns of political influence.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                /// 🔹 PÁRRAFO 3
                Text(
                  "    Emiliano Grossman’s article, *Media and Policy Making in the Digital Age*, published in the *Annual Review of Political Science*, examines how digital advancements have reshaped media dynamics and their impact on policy-making processes.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                /// 🔹 PÁRRAFO 4
                Text(
                  "    This article explores the evolution of media, its implications for governance, the challenges posed by misinformation, and the role of emerging media technologies in shaping political agendas.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 32),

                /// 🔹 SUBTÍTULO
                Text(
                  "The Transformation of Media in the Digital Era",
                  style: titleStyle,
                ),
                const SizedBox(height: 40),

                /// 🔘 BOTÓN SOLO AL FINAL
                AnimatedOpacity(
                  opacity: showButton ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 187, 36, 213),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: _goToQuestions,
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.white),
                      label: const Text(
                        "Go to Questions",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),

          /// ⏳ OVERLAY DE TRANSICIÓN
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
                          color: Color.fromARGB(255, 187, 36, 213)),
                      SizedBox(height: 16),
                      Text(
                        "Going to Questions...",
                        style: TextStyle(
                          fontSize: 20,
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

// Preguntas de ejemplo
final List<QuestionData> sampleQuestions = [
  QuestionData(
    question:
        'Digital platforms now coexist with traditional media and influence policy.\n\nWhat is most likely to happen?',
    options: [
      "A) Policymakers will ignore digital media entirely",
      "B) Social media will disappear in politics",
      "C) Information will remain fully controlled by print outlets",
      "D) Political influence will adapt to shifting media dynamics"
    ],
    correctIndex: 3,
    explanation:
        'Explanation: Since digital platforms shape public discourse, policymakers will need to adjust to their growing influence.',
    incorrectExplanations: [
      'Incorrect. Digital media is too influential for policymakers to ignore.',
      'Incorrect. Social media continues to grow in political relevance.',
      'Incorrect. Print outlets no longer fully control information.',
      'Correct answer!',
    ],
  ),
  QuestionData(
    question:
        'Subtitle: The Transformation of Media in the Digital Era\n\nWhat will most likely follow?',
    options: [
      "A) A conclusion about the end of politics",
      "B) Possible explanations of how media evolved",
      "C) A list of entertainment media trends",
      "D) A summary of traditional print newspapers only"
    ],
    correctIndex: 1,
    explanation:
        'Explanation: The subtitle signals a discussion about how media changed in the digital era and its effects on politics.',
    incorrectExplanations: [
      'Incorrect. The subtitle does not suggest politics is ending.',
      'Correct answer!',
      'Incorrect. Entertainment trends are unrelated to the subtitle.',
      'Incorrect. The subtitle suggests broader media transformation, not only print newspapers.',
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

  static const Color accentDark = Color(0xFF6A1B9A); // morado oscuro
  static const Color cardBg = Color(0xFFF3E5F5); // lavanda muy claro

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

                    // Botón enviar o feedback
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF8E24AA), // morado botón
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

class _BiographyReadingPageSecondState extends State<BiographyReadingPageSecond>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

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

  void _goToQuestions() {
    setState(() => animating = true);
    _fadeController.forward();

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
    _fadeController.dispose();
    super.dispose();
  }

  // 📚 ESTILOS APA
  TextStyle get bodyStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        color: Colors.black,
      );

  TextStyle get titleStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );

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
                /// 🔹 PÁRRAFO INTRODUCTORIO
                Text(
                  "    The digital revolution has altered how media functions, how information is distributed, and how the public engages with policy issues. Grossman identifies three significant shifts that have reshaped the role of media in policy making.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                /// 🔹 SECCIÓN 1
                Text("1. The Rise of Digital Platforms", style: titleStyle),
                const SizedBox(height: 24),

                Text(
                  "    In the past, newspapers, television, and radio controlled the flow of information, acting as gatekeepers that determined which issues gained public attention. Today, digital platforms such as Google, YouTube, and Twitter serve as alternative sources of news, decentralizing control over information.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                Text(
                  "    This shift has produced both positive and negative consequences. A broader range of voices are now represented, as independent journalists, activists, and organizations can publish news without relying on traditional media outlets.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                Text(
                  "    However, the decline of editorial oversight has contributed to an increase in misinformation and biased reporting, making it more difficult for policymakers to rely on credible sources.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 32),

                /// 🔹 SECCIÓN 2
                Text("2. The Influence of Social Media", style: titleStyle),
                const SizedBox(height: 24),

                Text(
                  "    Social media platforms have become central to political communication, allowing policymakers, advocacy groups, and the public to engage with policy issues in real time. Unlike traditional media, which follows structured reporting cycles, social media operates continuously.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                Text(
                  "    Political figures can bypass traditional media filters and address the public directly through platforms such as Twitter and Facebook. In addition, grassroots movements and digital activism have gained unprecedented influence.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                Text(
                  "    At the same time, algorithm-driven news feeds contribute to political polarization by reinforcing users’ preexisting beliefs rather than exposing them to diverse perspectives.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 32),

                /// 🔹 SECCIÓN 3
                Text("3. The Rise of Citizen Journalism", style: titleStyle),
                const SizedBox(height: 24),

                Text(
                  "    The widespread use of smartphones and digital recording devices has enabled individuals to act as journalists, documenting political events, exposing corruption, and challenging official narratives.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                Text(
                  "    This development has increased transparency by drawing attention to human rights abuses and governmental misconduct. However, the lack of journalistic standards has also led to the rapid spread of unverified or manipulated information.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 32),

                /// 🔹 CIERRE
                Text(
                  "    These changes have diminished traditional media’s role as the primary source of information for policymakers, requiring governments to adapt to a more fragmented and dynamic media environment.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                Text(" The Impact of Digital Media on Policy Making",
                    style: titleStyle),
                const SizedBox(height: 40),

                /// 🔘 BOTÓN FINAL
                AnimatedOpacity(
                  opacity: showButton ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 187, 36, 213),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: _goToQuestions,
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.white),
                      label: const Text(
                        "Go to Questions",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),

          /// ⏳ OVERLAY
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
                          color: Color.fromARGB(255, 187, 36, 213)),
                      SizedBox(height: 16),
                      Text(
                        "Going to Questions...",
                        style: TextStyle(
                          fontSize: 20,
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
        'Digital platforms, social media, and citizen journalism now shape political communication.\n\nWhat is most likely to happen?',
    options: [
      "A) Traditional media will remain the sole gatekeeper of information",
      "B) Political figures will only rely on newspapers for communication",
      "C) Citizens will stop engaging in political debates",
      "D) Policymakers will adapt to the fast-changing media landscape"
    ],
    correctIndex: 3,
    explanation:
        'Explanation: Since traditional media no longer dominates, policymakers must adjust to new digital dynamics.',
    incorrectExplanations: [
      "Incorrect. Digital platforms have ended traditional media’s exclusive control.",
      "Incorrect. Politicians increasingly rely on multiple digital outlets.",
      "Incorrect. Digital media actually increases opportunities for public engagement.",
      "Correct answer!",
    ],
  ),
  QuestionData(
    question:
        'Subtitle: The Impact of Digital Media on Policy Making\n\nWhat will most likely follow?',
    options: [
      "A) An unrelated discussion of film and entertainment",
      "B) An exploration of how these media shifts affect governance",
      "C) A history of newspapers in the 19th century",
      "D) A summary of global economic crises"
    ],
    correctIndex: 1,
    explanation:
        'Explanation: The subtitle signals that the next section will examine how media changes directly influence policy-making.',
    incorrectExplanations: [
      "Incorrect. Film and entertainment do not relate to digital media’s influence on policy.",
      "Correct answer!",
      "Incorrect. The topic is about modern digital media, not historical print newspapers.",
      "Incorrect. Global crises are unrelated to the subtitle’s focus.",
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

  static const Color accentDark = Color(0xFF6A1B9A); // morado oscuro
  static const Color cardBg = Color(0xFFF3E5F5); // lavanda muy claro

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

                    // Botón enviar o feedback
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF8E24AA), // morado botón
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

class _BiographyReadingPageThirdState extends State<BiographyReadingPageThird>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

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

  void _goToQuestions() {
    setState(() => animating = true);
    _fadeController.forward();

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
    _fadeController.dispose();
    super.dispose();
  }

  // 📚 ESTILOS APA
  TextStyle get bodyStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        color: Colors.black,
      );

  TextStyle get titleStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );

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
                /// 🔹 SECCIÓN 1
                Text("1. Agenda Setting and Issue Prioritization",
                    style: titleStyle),
                const SizedBox(height: 24),

                Text(
                  "    Historically, policymakers relied on traditional media to shape their legislative priorities. Investigative journalism and televised debates influenced which policy issues gained public and governmental attention.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                Text(
                  "    In the digital era, this process has accelerated. Social media allows policy issues to gain traction rapidly, often dictating the political agenda in ways that would have been unthinkable in the past.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                Text(
                  "    Additionally, the public’s ability to mobilize through online platforms places increased pressure on policymakers to respond quickly to emerging concerns. While this responsiveness can be beneficial, it also carries risks, including the prioritization of short-term political interests over long-term policy planning.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 32),

                /// 🔹 SECCIÓN 2
                Text(
                  "2. Policy Decision Making in an Age of Information Overload",
                  style: titleStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "    Governments today have access to more information than ever before; however, this abundance does not necessarily result in better decision-making. Grossman identifies the challenge of filtering relevant information from an overwhelming volume of digital content.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                Text(
                  "    Policymakers must distinguish credible sources from misleading or biased information. Moreover, the speed of digital media encourages reactionary decision-making, often at the expense of careful policy deliberation.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                Text(
                  "    To address these challenges, governments must develop more effective tools and strategies for analyzing and interpreting digital information.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 32),

                /// 🔹 SECCIÓN 3
                Text(
                  "3. The Power of Public Opinion and Digital Activism",
                  style: titleStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "    Public opinion has become increasingly visible and immediate due to the rise of digital media. Social movements, advocacy groups, and individual citizens can exert significant pressure on policymakers through online campaigns.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                Text(
                  "    Digital petitions and viral campaigns have influenced legislation, corporate policies, and governmental actions. For example, online activism such as the Black Lives Matter movement has shaped policy discussions on racial justice and law enforcement practices.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                Text(
                  "    While this increased engagement can strengthen democratic participation, it also raises concerns regarding the disproportionate influence of certain groups and the difficulty of distinguishing genuine activism from coordinated disinformation efforts.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                Text("Challenges and Risks in the Digital Media-Policy Nexus.",
                    style: titleStyle),
                const SizedBox(height: 40),

                /// 🔘 BOTÓN FINAL
                AnimatedOpacity(
                  opacity: showButton ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 187, 36, 213),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: _goToQuestions,
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.white),
                      label: const Text(
                        "Go to Questions",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),

          /// ⏳ OVERLAY
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
                          color: Color.fromARGB(255, 187, 36, 213)),
                      SizedBox(height: 16),
                      Text(
                        "Going to Questions...",
                        style: TextStyle(
                          fontSize: 20,
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
    question:
        'Social media rapidly shapes agendas and pressures policymakers to respond quickly.\n\nWhat is most likely to happen?',
    options: [
      "A) Policymakers will only rely on television debates",
      "B) Citizens will lose interest in politics",
      "C) Long-term planning may be overlooked for short-term concerns",
      "D) Policymakers will ignore online activism"
    ],
    correctIndex: 2,
    explanation:
        'Explanation: The text explains that while responsiveness is beneficial, digital pressure often leads to short-term prioritization over long-term policy.',
    incorrectExplanations: [
      "Incorrect. Television alone is not enough in the digital era.",
      "Incorrect. Social media tends to increase—not decrease—political engagement.",
      "Correct answer!",
      "Incorrect. Policymakers generally cannot ignore online activism due to its influence.",
    ],
  ),
  QuestionData(
    question:
        'Subtitle: Challenges and Risks in the Digital Media-Policy Nexus\n\nWhat will most likely follow?',
    options: [
      "A) A list of entertainment trends in social media",
      "B) A discussion of the difficulties created by digital media",
      "C) A history of traditional journalism in the XXI century",
      "D) A focus on economic growth statistics"
    ],
    correctIndex: 1,
    explanation:
        'Explanation: The subtitle indicates that the next section will outline the problems and risks of digital media’s influence on policy.',
    incorrectExplanations: [
      "Incorrect. Entertainment trends do not relate to the policy-media nexus.",
      "Correct answer!",
      "Incorrect. The subtitle points to modern digital challenges, not historical journalism.",
      "Incorrect. Economic growth is unrelated to the subtitle’s focus.",
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

  static const Color accentDark = Color(0xFF6A1B9A); // morado oscuro
  static const Color cardBg = Color(0xFFF3E5F5); // lavanda muy claro

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

                    // Botón enviar o feedback
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF8E24AA), // morado botón
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

class _BiographyReadingPageFinalState extends State<BiographyReadingPageFinal>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

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

  void _goToQuestions() {
    setState(() => animating = true);
    _fadeController.forward();

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
    _fadeController.dispose();
    super.dispose();
  }

  // 📚 ESTILOS APA
  TextStyle get bodyStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        color: Colors.black,
      );

  TextStyle get titleStyle => const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 12,
        height: 2.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );

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
                /// 🔹 SECCIÓN 1
                Text(
                  "1. The Proliferation of Misinformation and Fake News",
                  style: titleStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "    One of the greatest challenges in the digital media environment is the rapid spread of misinformation. Grossman highlights how false political narratives can manipulate public perception and influence electoral outcomes.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                Text(
                  "    Conspiracy theories and misleading information have contributed to declining public trust in democratic institutions. The speed and reach of digital platforms amplify these effects, making misinformation difficult to contain.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                Text(
                  "    Emerging technologies such as deepfake videos present additional challenges for policymakers attempting to preserve the integrity of public discourse. Addressing these issues requires sustained investment in fact-checking initiatives, media literacy programs, and regulatory frameworks for digital content.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 32),

                /// 🔹 SECCIÓN 2
                Text(
                  "2. The Role of Digital Surveillance and Privacy Concerns",
                  style: titleStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "    As governments and corporations collect increasing amounts of data from digital communications, concerns regarding surveillance and privacy have intensified. The balance between state security measures and the protection of individual privacy remains a central policy dilemma.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                Text(
                  "    Surveillance practices may be justified for national security purposes; however, they also raise ethical concerns when used to suppress political dissent. Furthermore, technology companies that control vast quantities of personal data often operate without sufficient regulatory oversight.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                Text(
                  "    Policymakers must therefore develop regulatory strategies that protect individual privacy while simultaneously ensuring national security and democratic accountability.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 32),

                /// 🔹 SECCIÓN 3
                Text(
                  "3. The Growing Influence of Technology Companies",
                  style: titleStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "    Technology companies play an increasingly influential role in shaping political communication and policy agendas. Platforms that control information flows possess significant power over public discourse and the visibility of political issues.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                Text(
                  "    This concentration of power raises important questions regarding accountability, transparency, and the appropriate role of private actors in democratic governance. Future policy frameworks must address these concerns to ensure that digital platforms contribute positively to democratic processes.",
                  style: bodyStyle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 40),

                /// 🔘 BOTÓN FINAL
                AnimatedOpacity(
                  opacity: showButton ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 187, 36, 213),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: _goToQuestions,
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.white),
                      label: const Text(
                        "Go to Questions",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),

          /// ⏳ OVERLAY
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
                          color: Color.fromARGB(255, 187, 36, 213)),
                      SizedBox(height: 16),
                      Text(
                        "Going to Questions...",
                        style: TextStyle(
                          fontSize: 20,
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
        'False narratives, conspiracy theories, and deepfakes spread widely online.\n\nWhat is most likely to happen?',
    options: [
      "A) Trust in democratic institutions will decline",
      "B) Elections will remain unaffected",
      "C) Fake news will disappear without regulation",
      "D) Citizens will stop using social media"
    ],
    correctIndex: 0,
    explanation:
        'Explanation: The text explains that misinformation and conspiracy theories contribute directly to weakening trust in democracy.',
    incorrectExplanations: [
      "Correct answer!",
      "Incorrect. Elections are often influenced by misinformation online.",
      "Incorrect. Fake news does not disappear on its own without intervention.",
      "Incorrect. Citizens continue to use social media despite misinformation concerns.",
    ],
  ),
  QuestionData(
    question:
        'Subtitle: The Growing Influence of Technology Companies\n\nWhat will most likely follow?',
    options: [
      "A) A discussion of how tech companies shape politics and society",
      "B) An explanation of agricultural policy and agrotechnology",
      "C) A history of traditional newspapers and digital ones",
      "D) A section on international law only"
    ],
    correctIndex: 0,
    explanation:
        'Explanation: The subtitle signals the next section will focus on the power and influence of major tech corporations.',
    incorrectExplanations: [
      "Correct answer!",
      "Incorrect. The subtitle is not related to agriculture or agrotechnology.",
      "Incorrect. The focus is on tech companies, not historical media evolution.",
      "Incorrect. International law alone does not match the subtitle’s topic.",
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

  static const Color accentDark = Color(0xFF6A1B9A); // morado oscuro
  static const Color cardBg = Color(0xFFF3E5F5); // lavanda muy claro

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

                    // Botón enviar o feedback
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF8E24AA), // morado botón
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