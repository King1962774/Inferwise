// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';
import 'package:inferwise/Spots/ReadingSpots/Green/Content/Spot1/Spot_Page/reading_spot_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

// ── Reemplaza con tu import real ──────────────────────────────────
// import 'biography_nikola.dart';
// ─────────────────────────────────────────────────────────────────

class TeslaSplashScreen extends StatefulWidget {
  const TeslaSplashScreen({super.key});

  @override
  State<TeslaSplashScreen> createState() => _TeslaSplashScreenState();
}

class _TeslaSplashScreenState extends State<TeslaSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _scaleUp;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _fadeIn = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _scaleUp = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _controller.forward();

    // 🔥 Después de 4 segundos ir a BiographyNikola
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const BiographyNikola()), // ← BiographyNikola()
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // ── Fondo degradado amarillo cálido (misma rama que Cleopatra y Helen) ──
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF8D6), // crema muy claro
              Color(0xFFFDE87A), // amarillo suave
              Color(0xFFF5C030), // ámbar dorado
              Color(0xFFE09010), // naranja dorado oscuro
            ],
            stops: [0.0, 0.38, 0.65, 1.0],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeIn,
            child: ScaleTransition(
              scale: _scaleUp,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ── Bobina Tesla + rayos ───────────────────────────
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: CustomPaint(painter: _TeslaCoilPainter()),
                  ),
                  const SizedBox(height: 20),

                  // ── Título del libro ───────────────────────────────
                  Text(
                    "From Spark to Genius:\nNikola Tesla's Early Life",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E1200),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // ── Autor ──────────────────────────────────────────
                  Text(
                    "By Thomas Commerford Martin\n (1894)",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF5C3000),
                    ),
                    textAlign: TextAlign.center,

                  ),
                  const SizedBox(height: 28),

                  // ── Source ──────────────────────────────────────────
                  Text(
                    "From The Project Gutenberg",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF5C3000),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Bobina Tesla + rayos — CustomPainter (tonos marrones/dorados) ────
class _TeslaCoilPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;

    final strokePaint = Paint()
      ..color = const Color(0xFF8B5000)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = const Color(0xFF8B5000).withOpacity(0.13)
      ..style = PaintingStyle.fill;

    final spirePaint = Paint()
      ..color = const Color(0xFF8B5000).withOpacity(0.50)
      ..strokeWidth = 0.9
      ..strokeCap = StrokeCap.round;

    final boltPaint = Paint()
      ..color = const Color(0xFF3D1800)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final boltFaintPaint = Paint()
      ..color = const Color(0xFF8B5000).withOpacity(0.70)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // ── Halos en la cima ───────────────────────────────────────────
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(cx, size.height * 0.31), width: 52, height: 16),
      Paint()
        ..color = const Color(0xFF8B5000).withOpacity(0.38)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(cx, size.height * 0.31), width: 36, height: 10),
      Paint()
        ..color = const Color(0xFF8B5000).withOpacity(0.52)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // ── Cuerpo de la bobina ────────────────────────────────────────
    final double coilTop = size.height * 0.31;
    final double coilBottom = size.height * 0.67;
    final double coilLeft = cx - size.width * 0.10;
    final double coilRight = cx + size.width * 0.10;

    final coilRect = RRect.fromLTRBR(
      coilLeft,
      coilTop,
      coilRight,
      coilBottom,
      const Radius.circular(3),
    );
    canvas.drawRRect(coilRect, fillPaint);
    canvas.drawRRect(coilRect, strokePaint);

    // Espiras
    for (double y = coilTop + 7; y < coilBottom - 4; y += 7) {
      canvas.drawLine(Offset(coilLeft, y), Offset(coilRight, y), spirePaint);
    }

    // ── Base (dos plataformas) ─────────────────────────────────────
    canvas.drawRRect(
      RRect.fromLTRBR(cx - 15, coilBottom, cx + 15, coilBottom + 7,
          const Radius.circular(2)),
      Paint()
        ..color = const Color(0xFF8B5000).withOpacity(0.15)
        ..style = PaintingStyle.fill,
    );
    canvas.drawRRect(
      RRect.fromLTRBR(cx - 15, coilBottom, cx + 15, coilBottom + 7,
          const Radius.circular(2)),
      strokePaint..strokeWidth = 1.3,
    );
    canvas.drawRRect(
      RRect.fromLTRBR(cx - 20, coilBottom + 7, cx + 20, coilBottom + 13,
          const Radius.circular(2)),
      Paint()
        ..color = const Color(0xFF8B5000).withOpacity(0.10)
        ..style = PaintingStyle.fill,
    );
    canvas.drawRRect(
      RRect.fromLTRBR(cx - 20, coilBottom + 7, cx + 20, coilBottom + 13,
          const Radius.circular(2)),
      strokePaint..strokeWidth = 1.2,
    );

    // ── Rayo principal (zigzag) ────────────────────────────────────
    final boltPath = Path()
      ..moveTo(cx, coilTop)
      ..lineTo(cx - 6, coilTop - 9)
      ..lineTo(cx + 4, coilTop - 14)
      ..lineTo(cx - 4, coilTop - 22);
    canvas.drawPath(boltPath, boltPaint);

    // ── Rayo secundario izquierdo ──────────────────────────────────
    final boltLeft = Path()
      ..moveTo(cx, coilTop)
      ..lineTo(cx - 10, coilTop - 6)
      ..lineTo(cx - 5, coilTop - 11)
      ..lineTo(cx - 14, coilTop - 16);
    canvas.drawPath(boltLeft, boltFaintPaint);

    // ── Rayo secundario derecho ────────────────────────────────────
    final boltRight = Path()
      ..moveTo(cx, coilTop)
      ..lineTo(cx + 10, coilTop - 6)
      ..lineTo(cx + 5, coilTop - 11)
      ..lineTo(cx + 14, coilTop - 16);
    canvas.drawPath(boltRight, boltFaintPaint);

    // ── Chispa en la punta ─────────────────────────────────────────
    final Offset sparkPos = Offset(cx - 4, coilTop - 22);
    canvas.drawCircle(
      sparkPos,
      5.0,
      Paint()
        ..color = const Color(0xFF8B5000).withOpacity(0.22)
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      sparkPos,
      2.5,
      Paint()
        ..color = const Color(0xFF3D1800).withOpacity(0.88)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------- NIKOLA QUESTIONS ----------------------
class BiographyNikola extends StatefulWidget {
  const BiographyNikola({super.key});
  @override
  State<BiographyNikola> createState() => _BiographyNikolaState();
}

class _BiographyNikolaState extends State<BiographyNikola> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "What natural phenomenon inspired early electrical experiments?",
      "options": [
        "A) Earthquakes",
        "B) Lightning",
        "C) Tornadoes",
        "D) Volcanoes"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Earthquakes are not related to early electrical experiments.",
        " Correct! Lightning showed electricity existed in nature before humans harnessed it.",
        " Incorrect. Tornadoes are powerful but not related to electrical studies.",
        " Incorrect. Volcanoes do not inspire electrical experiments."
      ]
    },
    {
      "question":
          "What was the main source of light in homes before electricity?",
      "options": [
        "A) Gas lamps or candles",
        "B) Solar panels",
        "C) Flashlights",
        "D) Wind turbines"
      ],
      "correct": 0,
      "feedback": [
        " Correct! Homes used open flames before Tesla's electrical innovations.",
        " Incorrect. Solar panels are modern and require electricity.",
        " Incorrect. Flashlights didn't exist before electricity.",
        " Incorrect. Wind turbines generate electricity, not light directly."
      ]
    },
    {
      "question":
          "What was Nikola Tesla's primary profession throughout his career?",
      "options": [
        "A) A medical doctor",
        "B) An electrical engineer and inventor",
        "C) A university mathematics professor",
        "D) A mechanical clockmaker"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Tesla was not a medical doctor.",
        " Correct! Tesla was primarily an electrical engineer who invented AC power systems and held over 300 patents.",
        " Incorrect. Tesla was not a university professor.",
        " Incorrect. He wasn’t a clockmaker."
      ]
    },
    {
      "question":
          "Which modern technology relies on principles Tesla discovered?",
      "options": [
        "A) Wireless phone chargers",
        "B) Solar panels",
        "C) Digital cameras",
        "D) Nuclear power plants"
      ],
      "correct": 0,
      "feedback": [
        " Correct! Wireless power transfer builds on Tesla's experiments with electromagnetic fields.",
        " Incorrect. Solar panels are based on photovoltaic principles, not Tesla's work.",
        " Incorrect. Digital cameras don't directly relate to Tesla’s discoveries.",
        " Incorrect. Nuclear power came after Tesla's era and relies on different principles."
      ]
    },
    {
      "question": "Why is Nikola Tesla less famous than Thomas Edison today?",
      "options": [
        "A) His inventions weren’t useful",
        "B) He didn’t patent his ideas",
        "C) He worked alone",
        "D) People feared electricity"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Tesla’s inventions were very useful.",
        " Correct! Tesla focused on discovery rather than business success.",
        " Incorrect. Tesla collaborated with others too.",
        " Incorrect. Public fear wasn't the main reason for his obscurity."
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
          MaterialPageRoute(builder: (_) => const TeslaReadingAnimation()),
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
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFFE082), // amarillo suave
                        Color(0xFF80CBC4), // aquamarina elegante
                      ],
                    ),
                  ),
                ),
// 🔹 SUAVIZAR FONDO GENERAL
                Container(
                  color: Colors.white.withOpacity(0.10),
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
                        Color(0xFFFFE082), // amarillo suave
                        Color(0xFF80CBC4), // aquamarina elegante
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
                                                255, 243, 196, 23)
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
                                    const Color.fromARGB(255, 243, 196, 23),
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

class TeslaReadingAnimation extends StatefulWidget {
  const TeslaReadingAnimation({super.key});

  @override
  State<TeslaReadingAnimation> createState() => _TeslaReadingAnimationState();
}

class _TeslaReadingAnimationState extends State<TeslaReadingAnimation>
    with TickerProviderStateMixin {
  // ── Controllers ──────────────────────────────────────────────
  late final AnimationController _entryCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _bgCtrl;
  late final AnimationController _boltCtrl;
  late final AnimationController _particleCtrl;
  late final AnimationController _arc1Ctrl;
  late final AnimationController _arc2Ctrl;
  late final AnimationController _arc3Ctrl;
  late final AnimationController _beamsCtrl;
  late final AnimationController _sparkCtrl;

  // ── Animations ───────────────────────────────────────────────
  late final Animation<double> _textFade;
  late final Animation<double> _textSlide;
  late final Animation<double> _dividerWidth;
  // ignore: unused_field
  late final Animation<double> _subtitleFade;
  late final Animation<double> _glow;
  late final Animation<Color?> _bgColor1;
  late final Animation<Color?> _bgColor2;
  late final Animation<double> _boltFloat;
  late final Animation<double> _boltRock;
  late final Animation<double> _beamsOpacity;
  late final Animation<double> _arc1Opacity;
  late final Animation<double> _arc2Opacity;
  late final Animation<double> _arc3Opacity;
  late final Animation<double> _sparkScale;

  // ── Particles ─────────────────────────────────────────────────
  final List<_Particle> _particles = [];
  final math.Random _rng = math.Random();

  static const _golden = [
    Color(0xFFFAEEDA),
    Color(0xFFFAC775),
    Color(0xFFEF9F27),
    Color(0xFFBA7517),
  ];

  @override
  void initState() {
    super.initState();
    _spawnParticles();

    // Entry
    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _textFade = CurvedAnimation(
      parent: _entryCtrl,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );
    _textSlide = Tween<double>(begin: 16, end: 0).animate(
      CurvedAnimation(
        parent: _entryCtrl,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
      ),
    );
    _dividerWidth = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryCtrl,
        curve: const Interval(0.25, 0.7, curve: Curves.easeOut),
      ),
    );
    _subtitleFade = CurvedAnimation(
      parent: _entryCtrl,
      curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
    );

    // Glow pulse
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);
    _glow = Tween<double>(begin: 8, end: 32).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );

    // Background shimmer
    _bgCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat(reverse: true);
    _bgColor1 = ColorTween(
      begin: const Color(0xFF1A0C00),
      end: const Color(0xFF3A2000),
    ).animate(_bgCtrl);
    _bgColor2 = ColorTween(
      begin: const Color(0xFFB8860B),
      end: const Color(0xFFD4AF37),
    ).animate(_bgCtrl);

    // Bolt float + rock
    _boltCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3800),
    )..repeat(reverse: true);
    _boltFloat = Tween<double>(begin: 0, end: -10).animate(
      CurvedAnimation(parent: _boltCtrl, curve: Curves.easeInOut),
    );
    _boltRock = Tween<double>(begin: -0.026, end: 0.026).animate(
      CurvedAnimation(parent: _boltCtrl, curve: Curves.easeInOut),
    );

    // Arc 1 — left top
    _arc1Ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _arc1Opacity = Tween<double>(begin: 0.12, end: 1.0).animate(
      CurvedAnimation(parent: _arc1Ctrl, curve: Curves.easeInOut),
    );

    // Arc 2 — right mid
    _arc2Ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);
    _arc2Opacity = Tween<double>(begin: 0.05, end: 0.95).animate(
      CurvedAnimation(parent: _arc2Ctrl, curve: Curves.easeInOut),
    );

    // Arc 3 — left bottom
    _arc3Ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    )..repeat(reverse: true);
    _arc3Opacity = Tween<double>(begin: 0.08, end: 0.85).animate(
      CurvedAnimation(parent: _arc3Ctrl, curve: Curves.easeInOut),
    );

    // Sparks
    _sparkCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _sparkScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _sparkCtrl, curve: Curves.easeInOut),
    );

    // Particles
    _particleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    // Light beams
    _beamsCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _beamsOpacity = Tween<double>(begin: 0.06, end: 0.22).animate(
      CurvedAnimation(parent: _beamsCtrl, curve: Curves.easeInOut),
    );

    // Sequence
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await _entryCtrl.forward();
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      _goToNextScreen();
    });
  }

  void _spawnParticles() {
    for (int i = 0; i < 22; i++) {
      _particles.add(_Particle(
        x: _rng.nextDouble(),
        size: 2.5 + _rng.nextDouble() * 4.0,
        speed: 0.5 + _rng.nextDouble() * 1.5,
        color: _golden[_rng.nextInt(_golden.length)],
        offset: _rng.nextDouble(),
      ));
    }
  }

  @override
  void dispose() {
    _entryCtrl.dispose();
    _glowCtrl.dispose();
    _bgCtrl.dispose();
    _boltCtrl.dispose();
    _particleCtrl.dispose();
    _arc1Ctrl.dispose();
    _arc2Ctrl.dispose();
    _arc3Ctrl.dispose();
    _beamsCtrl.dispose();
    _sparkCtrl.dispose();
    super.dispose();
  }

  void _goToNextScreen() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (_, __, ___) => const BiographyReadingPage(),
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _bgCtrl,
          _glowCtrl,
          _boltCtrl,
          _particleCtrl,
          _arc1Ctrl,
          _arc2Ctrl,
          _arc3Ctrl,
          _beamsCtrl,
          _sparkCtrl,
        ]),
        builder: (context, _) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // Background shimmer
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _bgColor1.value ?? const Color(0xFF1A0C00),
                      const Color(0xFF3A2000),
                      const Color(0xFF5C3A00),
                      _bgColor2.value ?? const Color(0xFFB8860B),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              // Vignette
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.15,
                    colors: [
                      Colors.transparent,
                      const Color(0xFF0F0800).withOpacity(0.75),
                    ],
                  ),
                ),
              ),

              // Light beams
              CustomPaint(
                painter: _BeamsPainter(opacity: _beamsOpacity.value),
              ),

              // Particles
              CustomPaint(
                painter: _ParticlePainter(
                  particles: _particles,
                  progress: _particleCtrl.value,
                ),
              ),

              // Content
              SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.translate(
                          offset: Offset(0, _boltFloat.value),
                          child: Transform.rotate(
                            angle: _boltRock.value,
                            child: _BoltIcon(
                              glow: _glow.value,
                              arc1Opacity: _arc1Opacity.value,
                              arc2Opacity: _arc2Opacity.value,
                              arc3Opacity: _arc3Opacity.value,
                              sparkScale: _sparkScale.value,
                              sparkCtrlValue: _sparkCtrl.value,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildDivider(thick: true),
                        const SizedBox(height: 22),
                        FadeTransition(
                          opacity: _textFade,
                          child: Transform.translate(
                            offset: Offset(0, _textSlide.value),
                            child: Text(
                              'The more you read,\nthe more you will infer.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Georgia',
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFFAEEDA),
                                height: 1.6,
                                letterSpacing: 0.4,
                                shadows: [
                                  Shadow(
                                    color: const Color(0xFFEF9F27)
                                        .withOpacity(0.9),
                                    blurRadius: _glow.value,
                                  ),
                                  Shadow(
                                    color: const Color(0xFFBA7517)
                                        .withOpacity(0.55),
                                    blurRadius: _glow.value * 2.4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        _buildDivider(thick: false),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDivider({required bool thick}) {
    return AnimatedBuilder(
      animation: _entryCtrl,
      builder: (_, __) => FractionallySizedBox(
        widthFactor: _dividerWidth.value,
        child: Container(
          height: thick ? 1.5 : 1.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Color(0xFFEF9F27),
                Color(0xFFFAEEDA),
                Color(0xFFEF9F27),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Light beams ───────────────────────────────────────────────────────────────
class _BeamsPainter extends CustomPainter {
  final double opacity;
  const _BeamsPainter({required this.opacity});

  static const _beams = [
    (frac: 0.30, angle: -0.38, alpha: 1.0),
    (frac: 0.50, angle: -0.28, alpha: 0.70),
    (frac: 0.66, angle: -0.20, alpha: 0.40),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (final b in _beams) {
      final cx = size.width * b.frac;
      final paint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFFFAEEDA).withOpacity(opacity * b.alpha),
            const Color(0xFFEF9F27).withOpacity(opacity * 0.55 * b.alpha),
            Colors.transparent,
          ],
        ).createShader(Rect.fromLTWH(cx - 1, 0, 2, size.height));

      canvas.save();
      canvas.translate(cx, size.height * 0.5);
      canvas.rotate(b.angle);
      canvas.drawRect(
        Rect.fromLTWH(-1, -size.height * 0.9, 2, size.height * 1.8),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_BeamsPainter old) => old.opacity != opacity;
}

// ── Bolt icon ─────────────────────────────────────────────────────────────────
class _BoltIcon extends StatelessWidget {
  final double glow;
  final double arc1Opacity;
  final double arc2Opacity;
  final double arc3Opacity;
  final double sparkScale;
  final double sparkCtrlValue;

  const _BoltIcon({
    // ignore: unused_element
    super.key,
    required this.glow,
    required this.arc1Opacity,
    required this.arc2Opacity,
    required this.arc3Opacity,
    required this.sparkScale,
    required this.sparkCtrlValue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 130,
      child: CustomPaint(
        painter: _BoltPainter(
          glow: glow,
          arc1Opacity: arc1Opacity,
          arc2Opacity: arc2Opacity,
          arc3Opacity: arc3Opacity,
          sparkScale: sparkScale,
          sparkCtrlValue: sparkCtrlValue,
        ),
      ),
    );
  }
}

class _BoltPainter extends CustomPainter {
  final double glow;
  final double arc1Opacity;
  final double arc2Opacity;
  final double arc3Opacity;
  final double sparkScale;
  final double sparkCtrlValue;

  const _BoltPainter({
    required this.glow,
    required this.arc1Opacity,
    required this.arc2Opacity,
    required this.arc3Opacity,
    required this.sparkScale,
    required this.sparkCtrlValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // ── Halos exteriores ──────────────────────────────────────
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(w * 0.5, h * 0.5), width: w * 1.05, height: h * 0.9),
      Paint()
        ..color = const Color(0xFFEF9F27).withOpacity(0.06)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glow * 1.2),
    );
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(w * 0.5, h * 0.5), width: w * 0.75, height: h * 0.7),
      Paint()
        ..color = const Color(0xFFEF9F27).withOpacity(0.09)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glow * 0.8),
    );

    // ── Bobina Tesla ──────────────────────────────────────────
    void drawCoilRing(
        double cy, double rx, double ry, double strokeW, double op) {
      canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.5, cy), width: rx * 2, height: ry * 2),
        Paint()
          ..color = const Color(0xFFEF9F27).withOpacity(op)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeW,
      );
    }

    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(w * 0.5, h * 0.862),
          width: w * 0.582,
          height: h * 0.123),
      Paint()
        ..color = const Color(0xFFBA7517)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );
    drawCoilRing(h * 0.808, w * 0.455, h * 0.092, 1.4, 0.80);
    drawCoilRing(h * 0.762, w * 0.346, h * 0.069, 1.1, 0.65);
    drawCoilRing(h * 0.723, w * 0.255, h * 0.054, 0.9, 0.50);

    canvas.drawLine(
      Offset(w * 0.5, h * 0.692),
      Offset(w * 0.5, h * 0.554),
      Paint()
        ..color = const Color(0xFFBA7517).withOpacity(0.5)
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round,
    );

    // ── Rayo — glow ───────────────────────────────────────────
    final boltPoints = [
      Offset(w * 0.591, h * 0.046),
      Offset(w * 0.345, h * 0.446),
      Offset(w * 0.473, h * 0.446),
      Offset(w * 0.255, h * 0.754),
      Offset(w * 0.745, h * 0.308),
      Offset(w * 0.600, h * 0.308),
    ];

    final boltPath = Path()..moveTo(boltPoints[0].dx, boltPoints[0].dy);
    for (int i = 1; i < boltPoints.length; i++) {
      boltPath.lineTo(boltPoints[i].dx, boltPoints[i].dy);
    }
    boltPath.close();

    canvas.drawPath(
      boltPath,
      Paint()
        ..color = const Color(0xFFEF9F27).withOpacity(0.55)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glow * 0.55),
    );

    // ── Rayo — fill con gradiente simulado ────────────────────
    canvas.drawPath(
      boltPath,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFFFAEEDA), Color(0xFFFAC775), Color(0xFFEF9F27)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, 0, w, h)),
    );

    // ── Rayo — brillo interior ────────────────────────────────
    final innerPoints = [
      Offset(w * 0.564, h * 0.092),
      Offset(w * 0.382, h * 0.415),
      Offset(w * 0.482, h * 0.415),
      Offset(w * 0.300, h * 0.677),
      Offset(w * 0.664, h * 0.354),
      Offset(w * 0.564, h * 0.354),
    ];
    final innerPath = Path()..moveTo(innerPoints[0].dx, innerPoints[0].dy);
    for (int i = 1; i < innerPoints.length; i++) {
      innerPath.lineTo(innerPoints[i].dx, innerPoints[i].dy);
    }
    innerPath.close();
    canvas.drawPath(
      innerPath,
      Paint()
        ..color = Colors.white.withOpacity(0.38)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );

    // ── Rayo — stroke ─────────────────────────────────────────
    canvas.drawPath(
      boltPath,
      Paint()
        ..color = const Color(0xFFFAEEDA).withOpacity(0.9)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..strokeJoin = StrokeJoin.round,
    );

    // ── Núcleo brillante en punta ─────────────────────────────
    final coreOpacity = 0.5 + math.sin(sparkCtrlValue * math.pi) * 0.5;
    canvas.drawCircle(
      Offset(w * 0.591, h * 0.046),
      5.0,
      Paint()
        ..color = Colors.white.withOpacity(coreOpacity * 0.85)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );

    // ── Arcos eléctricos ─────────────────────────────────────
    void drawArc(Path arcPath, double opacity, Color color, double strokeW) {
      canvas.drawPath(
        arcPath,
        Paint()
          ..color = color.withOpacity(opacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeW
          ..strokeCap = StrokeCap.round,
      );
    }

    // Arco 1 — izquierda arriba
    final arc1 = Path()
      ..moveTo(w * 0.309, h * 0.169)
      ..quadraticBezierTo(w * 0.200, h * 0.123, w * 0.236, h * 0.062)
      ..quadraticBezierTo(w * 0.273, h * 0.015, w * 0.327, h * 0.046);
    drawArc(arc1, arc1Opacity, const Color(0xFFFAC775), 1.8);

    // Arco 2 — derecha medio
    final arc2 = Path()
      ..moveTo(w * 0.727, h * 0.269)
      ..quadraticBezierTo(w * 0.836, h * 0.215, w * 0.800, h * 0.138)
      ..quadraticBezierTo(w * 0.764, h * 0.077, w * 0.709, h * 0.115);
    drawArc(arc2, arc2Opacity, const Color(0xFFEF9F27), 1.6);

    // Arco 3 — izquierda bajo
    final arc3 = Path()
      ..moveTo(w * 0.236, h * 0.523)
      ..quadraticBezierTo(w * 0.127, h * 0.477, w * 0.145, h * 0.400)
      ..quadraticBezierTo(w * 0.164, h * 0.338, w * 0.236, h * 0.369);
    drawArc(arc3, arc3Opacity, const Color(0xFFFAC775), 1.3);

    // Arco 4 — derecha bajo, pequeño
    final arc4 = Path()
      ..moveTo(w * 0.745, h * 0.554)
      ..quadraticBezierTo(w * 0.836, h * 0.508, w * 0.818, h * 0.446);
    drawArc(arc4, arc1Opacity * 0.85, const Color(0xFFEF9F27), 1.1);

    // ── Chispas ───────────────────────────────────────────────
    final sparks = [
      (x: w * 0.182, y: h * 0.231, color: const Color(0xFFFAEEDA), phase: 0.0),
      (x: w * 0.836, y: h * 0.169, color: const Color(0xFFFAC775), phase: 0.5),
      (x: w * 0.127, y: h * 0.462, color: const Color(0xFFEF9F27), phase: 0.8),
      (x: w * 0.855, y: h * 0.446, color: const Color(0xFFFAEEDA), phase: 0.3),
      (x: w * 0.273, y: h * 0.077, color: const Color(0xFFFAC775), phase: 1.1),
      (x: w * 0.709, y: h * 0.046, color: const Color(0xFFFAEEDA), phase: 0.7),
    ];

    for (final sp in sparks) {
      final phase = (sparkCtrlValue + sp.phase) % 1.0;
      final scale = math.sin(phase * math.pi).clamp(0.0, 1.0);
      canvas.drawCircle(
        Offset(sp.x, sp.y),
        2.5 * scale,
        Paint()
          ..color = sp.color.withOpacity(scale)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3 * scale),
      );
    }
  }

  @override
  bool shouldRepaint(_BoltPainter old) =>
      old.glow != glow ||
      old.arc1Opacity != arc1Opacity ||
      old.arc2Opacity != arc2Opacity ||
      old.arc3Opacity != arc3Opacity ||
      old.sparkScale != sparkScale ||
      old.sparkCtrlValue != sparkCtrlValue;
}

// ── Particle system ───────────────────────────────────────────────────────────
class _Particle {
  final double x;
  final double size;
  final double speed;
  final Color color;
  final double offset;
  const _Particle({
    required this.x,
    required this.size,
    required this.speed,
    required this.color,
    required this.offset,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  const _ParticlePainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final t = (progress * p.speed + p.offset) % 1.0;
      final y = size.height * (1.0 - t * 0.85);
      final dx = math.sin(t * math.pi * 3 + p.offset * 5) * 16;
      final opacity = t < 0.12
          ? t / 0.12
          : t > 0.72
              ? 1 - (t - 0.72) / 0.28
              : 1.0;
      canvas.drawCircle(
        Offset(p.x * size.width + dx, y),
        p.size * 0.5,
        Paint()
          ..color = p.color.withOpacity(opacity * 0.72)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, p.size * 0.55),
      );
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => old.progress != progress;
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

  final String biographyText = '''
Nikola Tesla was born in 1857 in Smiljan, a small village in the region of Lika. At that time, this area was part of the Austro-Hungarian Empire, near the border where Serbians had long fought for their freedom against foreign rulers, including the Turks. His family was well-known in their community, with a history of leadership and service. His father was a priest in the Greek Orthodox Church and was known for his powerful speaking skills. One of Tesla's uncles even became a high-ranking bishop in Bosnia.

Tesla's mother was a clever and creative woman. She not only managed household tasks skillfully but also enjoyed building useful machines like looms for weaving and churns for making butter—devices that were important in their farming village.

As a boy, Tesla first went to school in Gospich for four years. Then he spent three years at a more advanced school called the Real Schule. After this, he was sent to Carstatt in Croatia, where he studied for three more years at the Higher Real Schule. It was there that he saw a steam-powered train for the first time, which fascinated him. He finished his studies in 1873.
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
                                const Color.fromARGB(255, 243, 196, 23),
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
                          color: Color.fromARGB(255, 243, 196, 23)),
                      SizedBox(height: 16),
                      Text(
                        "Going to Questions...",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 228, 184, 22),
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
        '"Building useful machines like looms for weaving and churns for making butter—devices that were important in their farming village." \n\nWhat does "devices" refer to in the text?',
    options: [
      "A) Tesla’s inventions",
      "B) Looms and churns",
      "C) Household tools in general",
      "D) Farming equipment from the Austro-Hungarian Empire"
    ],
    correctIndex: 1,
    explanation:
        'The word "devices" refers to the looms for weaving and churns for making butter mentioned earlier in the sentence.',
    incorrectExplanations: [
      'The text refers to machines built by Tesla’s mother, not Tesla’s own inventions.',
      'Correct answer!',
      'The sentence specifies exactly which devices are meant, not tools in general.',
      'The Austro-Hungarian Empire is not mentioned in this context.',
    ],
  ),
  QuestionData(
    question:
        '"It was there that he saw a steam-powered train for the first time, which fascinated him."\n\nWho does "he" refer to throughout the text?',
    options: [
      "A) Tesla’s father",
      "B) One of Tesla’s uncles",
      "C) Nikola Tesla",
      "D) A teacher at the Real Schule"
    ],
    correctIndex: 2,
    explanation:
        'The passage focuses on Nikola Tesla’s life, so the pronoun "he" refers to Tesla.',
    incorrectExplanations: [
      'Tesla’s father is not the focus of this part of the text.',
      'His uncles are not mentioned in this section.',
      'Correct answer!',
      'A teacher is not mentioned in this sentence.',
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

  // Paleta: ámbar cálido + crema + terracota suave
  static const Color accentDark = Color(0xFFFF8F00); // ámbar oscuro
  static const Color cardBg = Color(0xFFFFFDE7); // crema casi blanco

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
                  Color(0xFFFFE082), // amarillo suave
                  Color(0xFF80CBC4), // aquamarina elegante
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
                        border: Border.all(color: const Color(0xFFF3C417), width: 1.5),
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
                                  ? const Color(0xFFF3C417)
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
                            backgroundColor: Color(0xFFF3C417),
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
                              color: Color.fromARGB(255, 0, 0, 0),
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
That same year, Tesla became very sick with cholera but recovered. After his illness, he spent much of his time experimenting, especially with electricity and magnets. His father wanted him to become a priest like many others in their family, but Tesla's talent for science was too strong. Instead, he was allowed to go to the Polytechnic School in Graz to study mathematics and physics, with the goal of becoming a professor.

At the school, Tesla worked with a machine called a Gramme dynamo, which was used as an electric motor. His teacher explained that such motors needed parts called brushes and a commutator to work properly. But Tesla was not convinced. He believed there had to be a better way—one that did not require these parts. This idea stayed with him, and from that time on, he began developing what would later become his famous rotating field motor.
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
                                const Color.fromARGB(255, 243, 196, 23),
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
                        color: Color.fromARGB(255, 243, 196, 23)),
                    SizedBox(height: 16),
                    Text(
                      "Going to Questions...",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 232, 186, 23),
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
        '"His teacher explained that such motors needed parts called brushes and a commutator to work properly. But Tesla was not convinced."\n\nWhat does "parts" refer to?',
    options: [
      "A) Electric motors in general",
      "B) Brushes and commutators",
      "C) The Gramme dynamo’s wires",
      "D) Tesla’s rotating field motor"
    ],
    correctIndex: 1,
    explanation:
        'The phrase "these parts" refers to the brushes and the commutator mentioned earlier in the sentence.',
    incorrectExplanations: [
      'The text talks about specific components, not electric motors in general.',
      'Correct answer!',
      'The Gramme dynamo’s wires are not mentioned in this sentence.',
      'The rotating field motor is an idea, not the parts being discussed here.',
    ],
  ),
  QuestionData(
    question:
        '"He believed there had to be a better way—one that did not require these parts. This idea stayed with him." \n\nWhat does "this idea" refer to?',
    options: [
      "A) The Gramme dynamo’s design",
      "B) Tesla’s belief that motors could work without brushes/commutators",
      "C) Becoming a professor",
      "D) His father’s wish for him to be a priest"
    ],
    correctIndex: 1,
    explanation:
        '"This idea" refers to Tesla’s belief that a motor could function without brushes or a commutator.',
    incorrectExplanations: [
      'The Gramme dynamo is not discussed in this sentence.',
      'Correct answer!',
      'There is no mention of becoming a professor in this context.',
      'His father’s wishes are not related to the idea described here.',
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

  // Paleta: ámbar cálido + crema + terracota suave
  static const Color accentDark = Color(0xFFFF8F00); // ámbar oscuro
  static const Color cardBg = Color(0xFFFFFDE7); // crema casi blanco

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
                  Color(0xFFFFE082), // amarillo suave
                  Color(0xFF80CBC4), // aquamarina elegante
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
                        border: Border.all(color: const Color(0xFFF3C417), width: 1.5),
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
                                  ? const Color(0xFFF3C417)
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
                            backgroundColor: Color(0xFFF3C417),
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
                              color: Color.fromARGB(255, 0, 0, 0),
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
By his second year in Graz, Tesla decided he did not want to be a teacher. Instead, he chose to study engineering. When his studies ended, he returned home just in time to see his father before he passed away. After this, Tesla went to Prague and Budapest to study languages, hoping to improve his chances of becoming a successful engineer.

For a short time, he worked as an assistant in the Government Telegraph Engineering Department. Then he joined a telephone company run by a family friend, M. Puskas, in Hungary. Tesla invented several improvements for telephones, but he felt limited in Hungary. Wanting more opportunities, he moved to Paris, where he found work as an electrical engineer for a company involved in the new electric lighting industry.

During this time, around 1882, Tesla began working seriously on his idea for the rotating field motor. He was completely focused on this project, believing it would change the world of electrical engineering. Some business-minded friends encouraged him to start a company to sell his invention, but Tesla, still young and inexperienced, was more interested in sharing his ideas openly. He thought his discovery was too important to keep secret.
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
                                const Color.fromARGB(255, 243, 196, 23),
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
                        color: Color.fromARGB(255, 243, 196, 23)),
                    SizedBox(height: 16),
                    Text(
                      "Going to Questions...",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 232, 186, 23),
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
        '"Tesla began working seriously on his idea for the rotating field motor. He was completely focused on this project."\n\nWhat does "this project" refer to?',
    options: [
      "A) Telephone field engineering",
      "B) Electrical rotative lighting",
      "C) Motor development",
      "D) Telegraph systems"
    ],
    correctIndex: 2,
    explanation:
        'The phrase “this project” refers to the development of the rotating field motor, which is the only project mentioned in the text.',
    incorrectExplanations: [
      'Telephone field engineering is not mentioned anywhere in this sentence.',
      'Lighting systems are not discussed in this part of the text.',
      'Correct answer!',
      'Telegraph systems are not related to the rotating field motor mentioned.',
    ],
  ),
  QuestionData(
    question:
        '"When his studies ended, he returned home just in time to see his father before he passed away." \n\nWho does the second "he" refer to?',
    options: [
      "A) Tesla's father",
      "B) Tesla",
      "C) Tesla’s professor",
      "D) It’s ambiguous"
    ],
    correctIndex: 0,
    explanation:
        'While the first "he" refers to Tesla, the second "he" clearly refers to Tesla\'s father, who passed away.',
    incorrectExplanations: [
      'Correct answer!',
      'Tesla is the one who returned home, not the one who passed away.',
      'The professor is not mentioned in the sentence.',
      'The meaning is clear from the context and is not ambiguous.',
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

  // Paleta: ámbar cálido + crema + terracota suave
  static const Color accentDark = Color(0xFFFF8F00); // ámbar oscuro
  static const Color cardBg = Color(0xFFFFFDE7); // crema casi blanco

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
                  Color(0xFFFFE082), // amarillo suave
                  Color(0xFF80CBC4), // aquamarina elegante
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
                        border: Border.all(color: const Color(0xFFF3C417), width: 1.5),
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
                                  ? const Color(0xFFF3C417)
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
                            backgroundColor: Color(0xFFF3C417),
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
                              color: Color.fromARGB(255, 0, 0, 0),
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
Finally, Tesla decided to try his luck in America. In France, he had met many Americans and learned that the U.S. was a place where inventors were encouraged and new ideas were welcomed. Without hesitation, he left Europe behind and set off for the United States.

When Tesla arrived in America, he immediately went to work at Edison's laboratory. Working with Thomas Edison, whom Tesla greatly admired, was a dream come true. However, Tesla had his own inventions to develop, and before long, he left Edison's company to work on his own. His new project was an arc lighting system based on his own designs. While he succeeded in perfecting this system, his main passion remained his rotating field motor for alternating current (AC) electricity.

At the time, few engineers understood or trusted AC power. Most were used to direct current (DC), and Tesla's ideas seemed strange to them. Even Tesla himself had to work for a long time before he could build an efficient AC motor. But his determination would soon lead to one of the most important breakthroughs in electrical engineering.
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
                                const Color.fromARGB(255, 243, 196, 23),
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
                        color: Color.fromARGB(255, 243, 196, 23)),
                    SizedBox(height: 16),
                    Text(
                      "Going to Questions...",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 232, 186, 23),
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
        '"Working with Thomas Edison, whom Tesla greatly admired, was a dream come true." \n\nWho does "whom" refer to in the text?',
    options: [
      "A) America",
      "B) Tesla",
      "C) Thomas Edison",
      "D) The laboratory"
    ],
    correctIndex: 2,
    explanation:
        'The relative pronoun "whom" refers to Thomas Edison, the person Tesla admired.',
    incorrectExplanations: [
      'America is a place, not a person, and cannot be referred to by "whom".',
      'Tesla is the one doing the admiring, not the person being admired.',
      'Correct answer!',
      'The laboratory is not a person, so "whom" cannot refer to it.',
    ],
  ),
  QuestionData(
    question:
        '"At the time, few engineers understood or trusted AC power. Most were used to direct current (DC), and Tesla\'s ideas seemed strange to them."\n\nWhat does "Tesla\'s ideas" refer to?',
    options: [
      "A) Direct Current Electricity",
      "B) Alternating Current Electricity",
      "C) Electrical Engineering",
      "D) Arc Lighting System"
    ],
    correctIndex: 1,
    explanation:
        '“Tesla’s ideas” refers to his promotion of alternating current (AC), which most engineers did not yet understand or trust.',
    incorrectExplanations: [
      'Direct current (DC) was already common and familiar, so it was not considered Tesla’s new idea.',
      'Correct answer!',
      'Electrical engineering is a general field, not a specific idea mentioned in the sentence.',
      'The arc lighting system is not discussed in this part of the text.',
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

  // Paleta: ámbar cálido + crema + terracota suave
  static const Color accentDark = Color(0xFFFF8F00); // ámbar oscuro
  static const Color cardBg = Color(0xFFFFFDE7); // crema casi blanco

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
        MaterialPageRoute(builder: (_) => FinalPath()),
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
                  Color(0xFFFFE082), // amarillo suave
                  Color(0xFF80CBC4), // aquamarina elegante
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
                        border: Border.all(color: const Color(0xFFF3C417), width: 1.5),
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
                                  ? const Color(0xFFF3C417)
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
                            backgroundColor: Color(0xFFF3C417),
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
                              color: Color.fromARGB(255, 0, 0, 0),
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
