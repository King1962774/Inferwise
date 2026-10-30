import 'package:flutter/material.dart';
import 'package:inferwise/Spots/ReadingSpots/Orange/Content/Spot4/Spot_Page/Reading_Spot_Page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:math' as math;

class HeritageSplashScreen extends StatefulWidget {
  const HeritageSplashScreen({super.key});

  @override
  State<HeritageSplashScreen> createState() => _HeritageSplashScreenState();
}

class _HeritageSplashScreenState extends State<HeritageSplashScreen>
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
            pageBuilder: (_, __, ___) => const Heritage(),
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
                    // Heritage icon with pulse + glow
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
                                painter: _HeritageIconPainter(),
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
                            "Environmental Pollution &\nArchitectural Heritage:\nCartagena de Indias",
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
                        "By John Fredy Heidis Cano 2022",
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

// ── Heritage Icon painter ─────────────────────────────────────────────────────

class _HeritageIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double s = size.width / 24;

    final mainPaint = Paint()
      ..color = const Color(0xFFD8B4FE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final columnPaint = Paint()
      ..color = const Color(0xFFC4B5FD)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final dotPaint = Paint()
      ..style = PaintingStyle.fill;

    // Base platform
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(2 * s, 20 * s, 20 * s, 2 * s),
        const Radius.circular(0.5),
      ),
      mainPaint,
    );

    // Three columns
    for (final x in [4.0, 10.75, 17.5]) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x * s, 10 * s, 2.5 * s, 10 * s),
          const Radius.circular(0.3),
        ),
        columnPaint,
      );
    }

    // Entablature (horizontal bar)
    canvas.drawLine(
      Offset(2 * s, 10 * s),
      Offset(22 * s, 10 * s),
      mainPaint,
    );

    // Pediment (triangular roof)
    final pedimentPath = Path();
    pedimentPath.moveTo(1 * s, 8 * s);
    pedimentPath.lineTo(12 * s, 2 * s);
    pedimentPath.lineTo(23 * s, 8 * s);
    canvas.drawPath(pedimentPath, mainPaint);

    // Pollution haze dots above
    dotPaint.color = const Color(0xFFC4B5FD).withOpacity(0.45);
    canvas.drawCircle(Offset(5 * s, 4 * s), 0.6 * s, dotPaint);
    dotPaint.color = const Color(0xFFC4B5FD).withOpacity(0.35);
    canvas.drawCircle(Offset(12 * s, 2.5 * s), 0.5 * s, dotPaint);
    dotPaint.color = const Color(0xFFC4B5FD).withOpacity(0.4);
    canvas.drawCircle(Offset(19 * s, 4 * s), 0.6 * s, dotPaint);
  }

  @override
  bool shouldRepaint(_HeritageIconPainter old) => false;
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

class Heritage extends StatefulWidget {
  const Heritage({super.key});
  @override
  State<Heritage> createState() => _HeritageState();
}

class _HeritageState extends State<Heritage> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "What is the primary source of air pollution in most major cities?",
      "options": [
        "A) Industrial waste from factories.",
        "B) Vehicle emissions.",
        "C) Residential heating and cooling systems.",
        "D) Natural events like dust storms."
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Industrial waste contributes, but vehicle emissions are the main cause in urban areas.",
        " Correct! Emissions from cars, trucks, and other vehicles are the biggest cause of air pollution in urban areas.",
        " Incorrect. Heating and cooling systems are minor contributors compared to vehicles.",
        " Incorrect. Natural dust storms are less frequent causes of urban air pollution."
      ]
    },
    {
      "question":
          "What is one of the main causes of light pollution in a city?",
      "options": [
        "A) Too many streetlights and advertising billboards.",
        "B) Using too many flashlights.",
        "C) Not having enough natural light.",
        "D) Using too much electricity."
      ],
      "correct": 0,
      "feedback": [
        " Correct! Light pollution results from excessive and misdirected artificial light, such as from streetlights and billboards.",
        " Incorrect. Flashlights are not significant contributors to city light pollution.",
        " Incorrect. The issue is excess artificial light, not lack of natural light.",
        " Incorrect. Electricity use is related but not the direct cause of light pollution."
      ]
    },
    {
      "question":
          "What is a common cause of contamination that directly damages historical stone buildings?",
      "options": [
        "A) Too much sunlight and heat.",
        "B) Acid rain caused by air pollution.",
        "C) Excessive water use inside the buildings.",
        "D) Loud noises and vibrations from traffic."
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Sunlight and heat do not chemically damage stone in this context.",
        " Correct! Acid rain forms when pollutants like sulfur dioxide and nitrogen oxides mix with water, corroding stone and metal.",
        " Incorrect. Water use inside buildings doesn’t cause external stone corrosion.",
        " Incorrect. Noise and vibration cause physical wear, not chemical damage."
      ]
    },
    {
      "question":
          "How do green spaces like parks and urban forests help reduce pollution in a city?",
      "options": [
        "A) They create more noise pollution.",
        "B) They absorb carbon dioxide and other pollutants from the air.",
        "C) They increase the urban heat island effect.",
        "D) They have no effect on pollution."
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Green spaces reduce noise rather than increase it.",
        " Correct! Trees and other plants use photosynthesis to absorb carbon dioxide and filter airborne pollutants.",
        " Incorrect. Vegetation helps reduce heat, not increase it.",
        " Incorrect. Parks play a key role in reducing multiple types of pollution."
      ]
    },
    {
      "question":
          "Which type of pollution is often associated with high-density urban areas and can cause hearing loss?",
      "options": [
        "A) Light pollution.",
        "B) Water pollution.",
        "C) Soil pollution.",
        "D) Noise pollution."
      ],
      "correct": 3,
      "feedback": [
        " Incorrect. Light pollution affects vision and ecosystems, not hearing.",
        " Incorrect. Water pollution impacts health, but not through hearing loss.",
        " Incorrect. Soil pollution concerns contamination of land and food sources.",
        " Correct! Noise pollution from excessive sounds in urban environments can lead to hearing damage over time."
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
              builder: (_) => const PurpleArticlesAnimation(title: "Heritage and Pollution", nextPage: BiographyReadingPage(),)),
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

  /// ⭐ CONTINUIDAD
  int _lastQuestionIndex = 0;

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

    if (currentScroll >= maxScroll - threshold && !animating) {
      if (!showButton) setState(() => showButton = true);
    } else {
      if (showButton) setState(() => showButton = false);
    }
  }

  void _goToQuestions() async {
    setState(() {
      animating = true;
      showButton = false;
    });

    _fadeController.forward();

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

    _fadeController.reset();

    setState(() => animating = false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

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
          /// 📜 TEXTO
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Introduction", style: titleStyle),
                const SizedBox(height: 16),

                Text(
                  "Architectural heritage is a critical component of cultural identity and historical continuity. However, environmental pollution poses a severe threat to the preservation of heritage structures worldwide. Cities with significant historical architecture, such as Cartagena de Indias, Colombia, face the dual challenge of protecting their built heritage while maintaining their economic reliance on tourism.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "Cartagena de Indias, a UNESCO World Heritage Site, is renowned for its colonial-era architecture, fortified walls, and historic buildings. These structures, made from limestone, coral stone, and other traditional materials, are highly susceptible to degradation caused by environmental pollutants such as air pollution, humidity, salinity, and biological growth.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "The deterioration of these buildings not only impacts their aesthetic and historical value but also affects the socioeconomic stability of the city, which depends on tourism, hospitality, and cultural industries.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "A study published in Sustainability examines how environmental pollution contributes to the degradation of architectural heritage materials in Cartagena de Indias. It also explores the socioeconomic consequences of heritage deterioration, particularly for communities whose livelihoods depend on the tourism sector.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "This article provides an in-depth analysis of the study’s key findings, the factors contributing to heritage degradation, and the necessary conservation strategies to ensure the sustainability of Cartagena’s historical sites.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 32),

                Text(
                  "Environmental Pollution and Heritage Degradation",
                  style: titleStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "Architectural heritage structures are constantly exposed to natural and human-induced environmental stressors. Over time, these factors weaken building materials, leading to structural damage, aesthetic decline, and, in severe cases, irreversible loss.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "The study identifies three primary environmental factors that accelerate the deterioration of heritage buildings in Cartagena.",
                  style: bodyStyle,
                ),

                const SizedBox(height: 120),
              ],
            ),
          ),

          /// 🔘 BOTÓN (SOLO AL FINAL)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            bottom: showButton ? 30 : -120,
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
                  "Go to Questions",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),

          /// ⏳ OVERLAY
          if (animating)
            Positioned.fill(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
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
    question: 'Where are the discussed heritage structures primarily located?',
    options: [
      "A) In Cartagena de Indias, a historic city",
      "B) In rural villages of Colombia",
      "C) Throughout South America randomly",
      "D) In modern urban centers only"
    ],
    correctIndex: 0,
    explanation:
        'The passage repeatedly references Cartagena de Indias and its historical architecture.',
    incorrectExplanations: [
      'Correct answer!',
      'Incorrect. The study focuses specifically on Cartagena, not rural areas.',
      'Incorrect. The discussion is limited to a specific city, not the entire continent.',
      'Incorrect. Heritage structures are historical, not modern urban constructions.',
    ],
  ),
  QuestionData(
    question:
        'When have the buildings in Cartagena been exposed to environmental threats?',
    options: [
      "A) Only in the last five years",
      "B) Constantly over time",
      "C) Only during the colonial era",
      "D) Only during tourism seasons"
    ],
    correctIndex: 1,
    explanation:
        'The text notes that heritage structures “are constantly exposed to natural and human-induced environmental stressors.”',
    incorrectExplanations: [
      'Incorrect. The exposure is ongoing, not recent.',
      'Correct answer!',
      'Incorrect. The threats extend far beyond the colonial period.',
      'Incorrect. Environmental threats are continuous, not seasonal.',
    ],
  ),
  QuestionData(
    question:
        'Who is responsible for analyzing the effects of environmental pollution on heritage buildings?',
    options: [
      "A) Local tourists",
      "B) City government exclusively",
      "C) Construction workers maintaining modern buildings",
      "D) Sustainability researchers"
    ],
    correctIndex: 3,
    explanation:
        'The passage refers to “a study published in Sustainability” that examines these effects.',
    incorrectExplanations: [
      'Incorrect. Tourists are not responsible for research or analysis.',
      'Incorrect. Local government is not the primary research agent here.',
      'Incorrect. The study involves researchers, not construction workers.',
      'Correct answer!',
    ],
  ),
  QuestionData(
    question:
        'Which group is most affected by the deterioration of heritage buildings in Cartagena?',
    options: [
      "A) Tourists visiting the city",
      "B) Communities relying on tourism",
      "C) Architects designing new buildings",
      "D) Environmental scientists"
    ],
    correctIndex: 1,
    explanation:
        'The text highlights “socioeconomic consequences… particularly for communities whose livelihoods depend on the tourism sector.”',
    incorrectExplanations: [
      'Incorrect. Tourists are visitors, not the most affected economically.',
      'Correct answer!',
      'Incorrect. Architects are not directly impacted by heritage deterioration.',
      'Incorrect. Environmental scientists study the issue but are not socioeconomically affected.',
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

class _BiographyReadingPageSecondState extends State<BiographyReadingPageSecond>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  bool showButton = false;
  bool animating = false;

  int _lastQuestionIndex = 0; // ✅ LÓGICA DE CONTINUIDAD

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.position.maxScrollExtent <= 20) {
        setState(() => showButton = true);
      }
    });
  }

  void _checkScrollEnd() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    const threshold = 20.0;

    if (currentScroll >= maxScroll - threshold && !animating) {
      if (!showButton) setState(() => showButton = true);
    } else {
      if (showButton) setState(() => showButton = false);
    }
  }

  // ✅ MISMA LÓGICA QUE LAS OTRAS PÁGINAS
  void _goToQuestions() async {
    setState(() {
      animating = true;
      showButton = false;
    });

    _fadeController.forward();

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
    _fadeController.dispose();
    super.dispose();
  }

  // 📄 Estilos APA
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
        body: Stack(children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 SECCIÓN 1
                Text("1. Air Pollution and Chemical Erosion",
                    style: titleStyle),
                const SizedBox(height: 16),

                Text(
                  "Urbanization and industrialization contribute significantly to airborne pollutants, which accelerate the decay of historical materials. The presence of sulfur dioxide (SO₂), nitrogen oxides (NOₓ), and particulate matter leads to several forms of material degradation.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "The formation of acid rain reacts with limestone and coral stone, causing progressive surface erosion and loss of material cohesion.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "Additionally, the accumulation of black crusts on façades reduces the aesthetic appeal of heritage buildings and alters their historical appearance.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "Increased mechanical stress caused by pollutant deposition makes surfaces more susceptible to cracking and disintegration over time.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "The study found that buildings located in high-traffic areas exhibited greater material erosion, indicating that vehicular emissions play a significant role in heritage deterioration.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 32),

                // 🔹 SECCIÓN 2
                Text(
                  "2. High Humidity and Salinity from the Coastal Environment",
                  style: titleStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "Cartagena’s coastal location exposes its architectural heritage to high humidity levels and salt deposits, which intensify material degradation processes.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "Salt crystallization within porous materials causes internal expansion and cracking, weakening the structural integrity of heritage buildings.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "Moisture absorption accelerates the growth of fungi, algae, and moss, which further deteriorate building surfaces.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "Thermal fluctuations contribute to the expansion and contraction of materials, resulting in long-term structural damage.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "The combination of humidity, salinity, and biological activity creates a highly corrosive environment that requires continuous monitoring and conservation efforts.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 32),

                // 🔹 SECCIÓN 3
                Text(
                  "3. Biological Growth and Biodeterioration",
                  style: titleStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "Biological organisms such as lichens, mosses, and bacteria contribute to heritage degradation through multiple mechanisms.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "These organisms produce organic acids that dissolve calcium carbonate in limestone, accelerating chemical deterioration.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "Root penetration into existing cracks worsens structural weaknesses and facilitates further damage.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "The formation of discoloration and biofilms alters the visual integrity of historic buildings.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "Cartagena’s warm and humid climate creates ideal conditions for rapid biological growth, making biodeterioration one of the leading causes of material degradation in the region.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),

          // 🔘 BOTÓN
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
                onPressed: _goToQuestions,
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                label: const Text(
                  "Go to Questions",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),
          if (animating)
            Positioned.fill(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
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
        'Why are Cartagena’s heritage buildings particularly affected by salinity?',
    options: [
      "A) They are near industrial factories",
      "B) They are mostly underground",
      "C) They are located in a coastal environment",
      "D) They are far from urban areas"
    ],
    correctIndex: 2,
    explanation:
        'Cartagena’s coastal location exposes its architectural heritage to high humidity and salt deposits.',
    incorrectExplanations: [
      'Incorrect. Being near industrial factories is not the reason.',
      'Incorrect. Most heritage buildings are not underground.',
      'Correct answer!',
      'Incorrect. The issue is not about distance from urban areas.',
    ],
  ),
  QuestionData(
    question:
        'When does material degradation due to thermal fluctuations occur?',
    options: [
      "A) Only during storms",
      "B) Only at night",
      "C) Continuously over time",
      "D) Only during construction"
    ],
    correctIndex: 2,
    explanation:
        'Thermal expansion and contraction cause long-term damage, implying continuous effects.',
    incorrectExplanations: [
      'Incorrect. Storms are not the sole factor.',
      'Incorrect. Nighttime is not exclusive.',
      'Correct answer!',
      'Incorrect. Construction is not the main period affected.',
    ],
  ),
  QuestionData(
    question: 'What causes black crusts to form on the façades of buildings?',
    options: [
      "A) Tourists touching surfaces",
      "B) Airborne pollutants like SO₂ and NOₓ",
      "C) Heavy rainfall",
      "D) Improper cleaning methods"
    ],
    correctIndex: 1,
    explanation:
        'The accumulation of black crusts on façades results from air pollutants.',
    incorrectExplanations: [
      'Incorrect. Physical contact is not the cause.',
      'Correct answer!',
      'Incorrect. Rainfall is unrelated.',
      'Incorrect. Cleaning methods are not the cause here.',
    ],
  ),
  QuestionData(
    question: 'How does biological growth damage heritage buildings?',
    options: [
      "A) By changing local weather patterns",
      "B) Through production of organic acids",
      "C) By blocking tourist access",
      "D) By causing acid rain"
    ],
    correctIndex: 1,
    explanation:
        'Production of organic acids through biological activity is a mechanism of biodeterioration.',
    incorrectExplanations: [
      'Incorrect. Local weather patterns are not altered by biological growth.',
      'Correct answer!',
      'Incorrect. Blocking access does not cause material damage.',
      'Incorrect. Acid rain is a different phenomenon.',
    ],
  )
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

  /// ⭐ CONTINUIDAD
  int _lastQuestionIndex = 0;

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.position.maxScrollExtent <= 20) {
        setState(() => showButton = true);
      }
    });
  }

  void _checkScrollEnd() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    const threshold = 20.0;

    if (currentScroll >= maxScroll - threshold && !animating) {
      if (!showButton) setState(() => showButton = true);
    } else {
      if (showButton) setState(() => showButton = false);
    }
  }

  /// ✅ SOLO CAMBIÓ ESTA FUNCIÓN
  void _goToQuestions() async {
    setState(() {
      animating = true;
      showButton = false;
    });

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

  // 📚 Estilos APA
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
                // 🔹 TÍTULO PRINCIPAL
                Text(
                  "Socioeconomic Consequences of Heritage Deterioration",
                  style: titleStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "Beyond the material degradation of historic buildings, the study emphasizes the economic and social consequences of heritage loss. Cartagena’s economy relies heavily on tourism, cultural heritage, and hospitality services, meaning that architectural decline directly affects multiple sectors.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 32),

                // 🔹 SECCIÓN 1
                Text(
                  "1. Decrease in Tourism Revenue",
                  style: subtitleStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "The city’s historical sites attract thousands of visitors annually, generating income for local businesses such as restaurants, hotels, and artisan markets.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "Tourism agencies that offer guided tours and historical experiences also depend on the preservation of architectural heritage.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "Cultural events and festivals, which draw international attention, further contribute to Cartagena’s tourism-based economy.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "However, a decline in the visual and structural quality of heritage buildings reduces Cartagena’s appeal as a cultural tourism destination, leading to decreased visitor numbers and economic losses.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 32),

                // 🔹 SECCIÓN 2
                Text(
                  "2. Rising Maintenance and Restoration Costs",
                  style: subtitleStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "As heritage buildings deteriorate, restoration costs increase significantly. Without regular intervention, minor material damage escalates into major structural failures that require extensive and costly repairs.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "The study highlights the high cost of traditional restoration materials, which are often difficult to source.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "Additionally, historical conservation requires specialized labor, increasing the financial burden on preservation initiatives.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "Limited government funding further complicates long-term preservation efforts.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "If pollution and environmental stressors continue unchecked, Cartagena’s historical sites may suffer irreversible damage, resulting in permanent cultural and economic losses.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 32),

                // 🔹 SECCIÓN 3
                Text(
                  "3. Negative Impact on Local Communities",
                  style: subtitleStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "Cartagena’s historic center is home to local artisans, vendors, and small businesses that depend directly on cultural tourism.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "The deterioration of heritage sites leads to job losses in the tourism and hospitality sectors.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "Economic displacement may occur as reduced tourism revenue forces businesses to close.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 16),

                Text(
                  "Cultural erosion follows, as local traditions and heritage-linked professions become less viable.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),

                Text(
                  "Preserving Cartagena’s built heritage is therefore not only a matter of historical conservation, but also a critical economic and social priority for local communities.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),

          // 🔘 BOTÓN
          AnimatedPositioned(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            bottom: showButton ? 40 : -140,
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
                  "Go to Questions",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),

          /// ===== OVERLAY =====
          if (animating)
            Positioned.fill(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
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
              ),
            ),
        ],
      ),
    );
  }
}

final List<QuestionData> sampleQuestionsThird = [
  QuestionData(
    question: 'When do restoration costs become particularly high?',
    options: [
      "A) Immediately after construction and renewal",
      "B) After minor damage escalates",
      "C) During tourist festivals and holidays",
      "D) Only during the rainy season"
    ],
    correctIndex: 1,
    explanation:
        'Minor material damage escalates into major structural failures, requiring extensive and costly repairs.',
    incorrectExplanations: [
      'Incorrect. Immediate costs are not the highest.',
      'Correct answer!',
      'Incorrect. Tourist events do not inherently cause high costs.',
      'Incorrect. The rainy season is not the main period for high restoration costs.',
    ],
  ),
  QuestionData(
    question:
        'Who benefits from tourism generated by Cartagena’s historic sites?',
    options: [
      "A) Only foreign investors",
      "B) Industrial factories",
      "C) Local businesses, and tourism agencies",
      "D) Construction companies exclusively"
    ],
    correctIndex: 2,
    explanation:
        'Local businesses such as restaurants, hotels, artisan markets, tourism agencies, and cultural events benefit from tourism.',
    incorrectExplanations: [
      'Incorrect. The benefit is not exclusive to foreign investors.',
      'Incorrect. Industrial factories are not the main beneficiaries.',
      'Correct answer!',
      'Incorrect. Construction companies are not the primary beneficiaries.',
    ],
  ),
  QuestionData(
    question:
        'What happens to local traditions when heritage buildings deteriorate?',
    options: [
      "A) They become more popular",
      "B) They risk cultural erosion",
      "C) They expand to new cities",
      "D) They are unaffected"
    ],
    correctIndex: 1,
    explanation:
        'Deterioration causes cultural erosion as local traditions and heritage-linked professions become less viable.',
    incorrectExplanations: [
      'Incorrect. Popularity does not generally increase.',
      'Correct answer!',
      'Incorrect. Expansion to other cities does not follow deterioration.',
      'Incorrect. They are in fact affected and at risk.',
    ],
  ),
  QuestionData(
    question:
        'Where are the local artisans and small businesses that are affected by heritage deterioration located?',
    options: [
      "A) In the industrial zones",
      "B) In Cartagena’s historic center",
      "C) On the outskirts of the city",
      "D) In neighboring towns"
    ],
    correctIndex: 1,
    explanation:
        'Cartagena’s historic center is home to many local artisans, vendors, and small businesses affected by heritage loss.',
    incorrectExplanations: [
      'Incorrect. Industrial zones are not the main location.',
      'Correct answer!',
      'Incorrect. The outskirts are not the key area.',
      'Incorrect. Neighboring towns are not the primary context.',
    ],
  )
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