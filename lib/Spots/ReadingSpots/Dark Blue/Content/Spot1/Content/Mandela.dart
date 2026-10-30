import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Dark Blue/Content/Spot1/Spot_Page/ReadingSpot.dart';
import 'dart:math' as math;

// ── Reemplaza con tu import real ──────────────────────────────────
// import 'mandela.dart';
// ─────────────────────────────────────────────────────────────────

class MandelaSplashScreen extends StatefulWidget {
  const MandelaSplashScreen({super.key});

  @override
  State<MandelaSplashScreen> createState() => _MandelaSplashScreenState();
}

class _MandelaSplashScreenState extends State<MandelaSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _rotateController;
  late Animation<double> _fadeIn;
  late Animation<double> _scaleUp;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _fadeIn = CurvedAnimation(parent: _mainController, curve: Curves.easeIn);
    _scaleUp = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.elasticOut),
    );
    _mainController.forward();

    // Mandala girando lentamente (18 s por vuelta)
    _rotateController = AnimationController(
      duration: const Duration(seconds: 18),
      vsync: this,
    )..repeat();

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Mandela()), // ← Mandela()
      );
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF8D6),
              Color(0xFFFDE87A),
              Color(0xFFF5C030),
              Color(0xFFE09010),
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
                  // ── Ícono puño + mandala girando ───────────────────
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Mandala de fondo girando
                        AnimatedBuilder(
                          animation: _rotateController,
                          builder: (_, __) => Transform.rotate(
                            angle: _rotateController.value * 2 * math.pi,
                            child: CustomPaint(
                              size: const Size(120, 120),
                              painter: _MandalaPainter(),
                            ),
                          ),
                        ),
                        // Ícono puño encima
                        const Icon(
                          FontAwesomeIcons.handFist,
                          color: Color(0xFF8B5000),
                          size: 56,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    "Life and Times of Mandela",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E1200),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    "By South African Government",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF5C3000),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    "From Government of South Africa",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF5C3000),
                    ),
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

// ─── Mandala decorativo — CustomPainter ──────────────────────────────
class _MandalaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    const brown = Color(0xFF8B5000);

    final strokePaint = Paint()
      ..color = brown.withOpacity(0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final fillPaint = Paint()
      ..color = brown.withOpacity(0.16)
      ..style = PaintingStyle.fill;

    final dotPaint = Paint()
      ..color = brown.withOpacity(0.50)
      ..style = PaintingStyle.fill;

    // ── 8 pétalos elípticos ────────────────────────────────────────
    for (int i = 0; i < 8; i++) {
      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(i * math.pi / 4);
      final petal = Rect.fromCenter(
        center: Offset(0, -size.height * 0.30),
        width: size.width * 0.11,
        height: size.height * 0.28,
      );
      canvas.drawOval(petal, fillPaint);
      canvas.drawOval(petal, strokePaint);
      canvas.restore();
    }

    // ── Dos anillos concéntricos ───────────────────────────────────
    canvas.drawCircle(
        Offset(cx, cy),
        size.width * 0.38,
        Paint()
          ..color = brown.withOpacity(0.22)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4);
    canvas.drawCircle(
        Offset(cx, cy),
        size.width * 0.27,
        Paint()
          ..color = brown.withOpacity(0.18)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0);

    // ── 8 puntos en el anillo exterior ────────────────────────────
    for (int i = 0; i < 8; i++) {
      final angle = i * math.pi / 4;
      canvas.drawCircle(
        Offset(cx + math.cos(angle) * size.width * 0.38,
            cy + math.sin(angle) * size.height * 0.38),
        2.8,
        dotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Mandela extends StatefulWidget {
  const Mandela({super.key});
  @override
  State<Mandela> createState() => _MandelaState();
}

class _MandelaState extends State<Mandela> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "What was the system of racial segregation in South Africa called?",
      "options": [
        "A) Colonization",
        "B) Apartheid",
        "C) Imperialism",
        "D) Nationalism"
      ],
      "correct": 1,
      "feedback": [
        " Colonization refers to foreign control, not South Africa’s internal policy.",
        "📌 Correct! Apartheid was a system of institutionalized racial segregation in South Africa from 1948 to the early 1990s.",
        " Imperialism relates more to empire-building, not the specific segregation in South Africa.",
        " Nationalism is unrelated to this specific racial system."
      ]
    },
    {
      "question": "Which group was given the most rights under apartheid?",
      "options": [
        "A) Black South Africans",
        "B) Indian South Africans",
        "C) Coloured South Africans",
        "D) White South Africans"
      ],
      "correct": 3,
      "feedback": [
        " Black South Africans were heavily discriminated against and had very few rights.",
        " Indian South Africans were also marginalized under apartheid.",
        " Coloured South Africans had more rights than Blacks and Indians, but still fewer than Whites.",
        "Correct! White South Africans had full political and economic control under apartheid."
      ]
    },
    {
      "question":
          "Who was the famous anti-apartheid leader who became South Africa's first Black president?",
      "options": [
        "A) Desmond Tutu",
        "B) Steve Biko",
        "C) Nelson Mandela",
        "D) F.W. de Klerk"
      ],
      "correct": 2,
      "feedback": [
        " Desmond Tutu was an important activist, but he did not become president.",
        " Steve Biko was a key figure but died before apartheid ended.",
        "🇿🇦 Correct! Nelson Mandela led the fight against apartheid and became president in 1994.",
        " F.W. de Klerk helped end apartheid but was not a Black president."
      ]
    },
    {
      "question": "What was the African National Congress (ANC)?",
      "options": [
        "A) A political party supporting apartheid",
        "B) A student club",
        "C) A trade union",
        "D) A group fighting apartheid"
      ],
      "correct": 3,
      "feedback": [
        " The ANC opposed apartheid, not supported it.",
        " The ANC was a political movement, not a student club.",
        " Although labor unions helped, the ANC was broader in scope.",
        "✊ Correct! The ANC led the struggle against apartheid and promoted equality."
      ]
    },
    {
      "question":
          "What year did apartheid officially end with democratic elections?",
      "options": ["A) 1989", "B) 1990", "C) 1994", "D) 2000"],
      "correct": 2,
      "feedback": [
        " Apartheid did not end officially in 1989.",
        " 1990 was the year Mandela was released, not when elections occurred.",
        "🎉 Correct! Apartheid officially ended in 1994 when South Africa held its first democratic elections.",
        " The transition had completed before 2000."
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
          MaterialPageRoute(builder: (_) => const MandelaAnimation()),
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

class MandelaAnimation extends StatefulWidget {
  const MandelaAnimation({super.key});

  @override
  State<MandelaAnimation> createState() => _MandelaAnimationState();
}

class _MandelaAnimationState extends State<MandelaAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _entryCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _bgCtrl;
  late final AnimationController _pulseCtrl;
  late final AnimationController _waveCtrl;
  late final AnimationController _particleCtrl;
  late final AnimationController _beamsCtrl;
  late final AnimationController _rayCtrl;

  late final Animation<double> _textFade;
  late final Animation<double> _textSlide;
  late final Animation<double> _dividerWidth;
  late final Animation<double> _iconFade;
  late final Animation<double> _iconScale;
  late final Animation<double> _glow;
  late final Animation<Color?> _bgColor1;
  late final Animation<Color?> _bgColor2;
  late final Animation<double> _fistPulse;
  late final Animation<double> _wavePhase;
  late final Animation<double> _beamsOpacity;
  late final Animation<double> _rayOpacity;

  final List<_Particle> _particles = [];
  final math.Random _rng = math.Random();

  static const _goldenColors = [
    Color(0xFFFFF9C4),
    Color(0xFFFFE57F),
    Color(0xFFFFC107),
    Color(0xFFF57F17),
    Color(0xFFFF8F00),
  ];

  @override
  void initState() {
    super.initState();
    _spawnParticles();

    _entryCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _textFade = CurvedAnimation(
        parent: _entryCtrl,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOut));
    _textSlide = Tween<double>(begin: 12, end: 0).animate(CurvedAnimation(
        parent: _entryCtrl,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOutCubic)));
    _dividerWidth = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _entryCtrl,
        curve: const Interval(0.25, 0.75, curve: Curves.easeOut)));
    _iconFade = CurvedAnimation(
        parent: _entryCtrl,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut));
    _iconScale = Tween<double>(begin: 0.82, end: 1.0).animate(CurvedAnimation(
        parent: _entryCtrl,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOutBack)));

    _glowCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2600))
      ..repeat(reverse: true);
    _glow = Tween<double>(begin: 14, end: 40)
        .animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));

    _bgCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 9))
          ..repeat(reverse: true);
    _bgColor1 =
        ColorTween(begin: const Color(0xFF1A0E00), end: const Color(0xFF3D2800))
            .animate(_bgCtrl);
    _bgColor2 =
        ColorTween(begin: const Color(0xFFFFC107), end: const Color(0xFFFFF9C4))
            .animate(_bgCtrl);

    _pulseCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);
    _fistPulse = Tween<double>(begin: 1.0, end: 1.045)
        .animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    _waveCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2800))
      ..repeat();
    _wavePhase = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _waveCtrl, curve: Curves.linear));

    _particleCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();

    _beamsCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat(reverse: true);
    _beamsOpacity = Tween<double>(begin: 0.05, end: 0.18)
        .animate(CurvedAnimation(parent: _beamsCtrl, curve: Curves.easeInOut));

    _rayCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat(reverse: true);
    _rayOpacity = Tween<double>(begin: 0.10, end: 0.26)
        .animate(CurvedAnimation(parent: _rayCtrl, curve: Curves.easeInOut));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await _entryCtrl.forward();
      await Future.delayed(const Duration(seconds: 4));
      if (!mounted) return;
      _goToNextScreen();
    });
  }

  void _spawnParticles() {
    for (int i = 0; i < 26; i++) {
      _particles.add(_Particle(
        x: _rng.nextDouble(),
        size: 2.0 + _rng.nextDouble() * 4.5,
        speed: 0.4 + _rng.nextDouble() * 1.4,
        color: _goldenColors[_rng.nextInt(_goldenColors.length)],
        offset: _rng.nextDouble(),
        wobble: _rng.nextDouble() * math.pi * 2,
      ));
    }
  }

  @override
  void dispose() {
    _entryCtrl.dispose();
    _glowCtrl.dispose();
    _bgCtrl.dispose();
    _pulseCtrl.dispose();
    _waveCtrl.dispose();
    _particleCtrl.dispose();
    _beamsCtrl.dispose();
    _rayCtrl.dispose();
    super.dispose();
  }

  void _goToNextScreen() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) => const BiographyReadingPage(),
      transitionsBuilder: (_, anim, __, child) => SlideTransition(
        position: Tween<Offset>(begin: const Offset(0.08, 0), end: Offset.zero)
            .animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
        child: FadeTransition(
            opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
            child: child),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _bgCtrl,
          _glowCtrl,
          _pulseCtrl,
          _waveCtrl,
          _particleCtrl,
          _beamsCtrl,
          _rayCtrl,
          _entryCtrl,
        ]),
        builder: (context, _) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // Background
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _bgColor1.value ?? const Color(0xFF1A0E00),
                      const Color(0xFF5F4B00),
                      const Color(0xFFC8860A),
                      _bgColor2.value ?? const Color(0xFFFFC107),
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
                    radius: 1.2,
                    colors: [
                      const Color(0xFFFFF9C4).withOpacity(0.07),
                      Colors.transparent,
                      const Color(0xFF100800).withOpacity(0.80),
                    ],
                  ),
                ),
              ),

              // Sun rays
              CustomPaint(painter: _SunRaysPainter(opacity: _rayOpacity.value)),

              // Beams
              CustomPaint(painter: _BeamsPainter(opacity: _beamsOpacity.value)),

              // Particles
              CustomPaint(
                  painter: _ParticlePainter(
                      particles: _particles, progress: _particleCtrl.value)),

              // Content
              SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ── FIST ICON ──────────────────────────────
                        FadeTransition(
                          opacity: _iconFade,
                          child: ScaleTransition(
                            scale: _iconScale,
                            child: Transform.scale(
                              scale: _fistPulse.value,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Halo rings
                                  ..._buildHaloRings(),
                                  // Glow
                                  Container(
                                    width: 110,
                                    height: 110,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color(0xFFFFC107)
                                                .withOpacity(0.5),
                                            blurRadius: _glow.value,
                                            spreadRadius: _glow.value * 0.35),
                                        BoxShadow(
                                            color: const Color(0xFFF57F17)
                                                .withOpacity(0.3),
                                            blurRadius: _glow.value * 2,
                                            offset: const Offset(0, 14)),
                                      ],
                                    ),
                                  ),
                                  // Gradient circle
                                  Container(
                                    width: 110,
                                    height: 110,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(
                                        center: Alignment(-0.3, -0.3),
                                        colors: [
                                          Color(0xFFFFF9C4),
                                          Color(0xFFFFC107),
                                          Color(0xFFF57F17)
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Fist emoji
                                  const Text('✊',
                                      style: TextStyle(fontSize: 52)),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 26),
                        _buildDivider(),
                        const SizedBox(height: 18),

                        // Title
                        FadeTransition(
                          opacity: _textFade,
                          child: Transform.translate(
                            offset: Offset(0, _textSlide.value),
                            child: Text(
                              'Life and Times of Mandela',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Georgia',
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFFFF9C4),
                                letterSpacing: 0.7,
                                shadows: [
                                  Shadow(
                                      color: const Color(0xFFFFC107)
                                          .withOpacity(0.9),
                                      blurRadius: _glow.value * 0.6),
                                  Shadow(
                                      color: const Color(0xFFF57F17)
                                          .withOpacity(0.5),
                                      blurRadius: _glow.value * 1.8),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),
                        _buildDivider(),
                        const SizedBox(height: 14),
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

  List<Widget> _buildHaloRings() {
    return List.generate(3, (i) {
      final phase = (_wavePhase.value + i / 3) % 1.0;
      final scale = 1.0 + phase * 1.6;
      final opacity = (1.0 - phase).clamp(0.0, 0.55);
      return Transform.scale(
        scale: scale,
        child: Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: const Color(0xFFFFC107).withOpacity(opacity),
                width: 1.5),
          ),
        ),
      );
    });
  }

  Widget _buildDivider() {
    return AnimatedBuilder(
      animation: _entryCtrl,
      builder: (_, __) => FractionallySizedBox(
        widthFactor: _dividerWidth.value,
        child: Container(
          height: 1.5,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.transparent,
              Color(0xFFFFC107),
              Color(0xFFFFF9C4),
              Color(0xFFFFC107),
              Colors.transparent,
            ]),
          ),
        ),
      ),
    );
  }
}

// ── Sun rays painter ──────────────────────────────────────────────────────────
class _SunRaysPainter extends CustomPainter {
  final double opacity;
  const _SunRaysPainter({required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height * 0.38;
    final rayPaint = Paint()
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 12; i++) {
      final angle = (i / 12) * math.pi * 2;
      final phaseOffset = (i / 12);
      final alpha = opacity * (0.6 + 0.4 * math.sin(phaseOffset * math.pi * 2));
      rayPaint.shader = LinearGradient(
        colors: [
          const Color(0xFFFFE57F).withOpacity(alpha),
          Colors.transparent,
        ],
      ).createShader(
          Rect.fromCenter(center: Offset(cx, cy), width: 200, height: 200));

      canvas.drawLine(
        Offset(cx + math.cos(angle) * 60, cy + math.sin(angle) * 60),
        Offset(cx + math.cos(angle) * 130, cy + math.sin(angle) * 130),
        rayPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_SunRaysPainter old) => old.opacity != opacity;
}

// ── Beams painter ─────────────────────────────────────────────────────────────
class _BeamsPainter extends CustomPainter {
  final double opacity;
  const _BeamsPainter({required this.opacity});
  static const _beams = [
    (frac: 0.25, angle: -0.30, alpha: 1.0),
    (frac: 0.50, angle: -0.15, alpha: 0.65),
    (frac: 0.75, angle: -0.08, alpha: 0.38),
  ];
  @override
  void paint(Canvas canvas, Size size) {
    for (final b in _beams) {
      final cx = size.width * b.frac;
      canvas.save();
      canvas.translate(cx, size.height * 0.5);
      canvas.rotate(b.angle);
      canvas.drawRect(
        Rect.fromLTWH(-1, -size.height * 0.9, 2, size.height * 1.8),
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              const Color(0xFFFFF9C4).withOpacity(opacity * b.alpha),
              const Color(0xFFFFC107).withOpacity(opacity * 0.5 * b.alpha),
              Colors.transparent,
            ],
          ).createShader(Rect.fromLTWH(cx - 1, 0, 2, size.height)),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_BeamsPainter old) => old.opacity != opacity;
}

// ── Particles ─────────────────────────────────────────────────────────────────
class _Particle {
  final double x, size, speed, offset, wobble;
  final Color color;
  const _Particle(
      {required this.x,
      required this.size,
      required this.speed,
      required this.color,
      required this.offset,
      required this.wobble});
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  const _ParticlePainter({required this.particles, required this.progress});
  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final t = (progress * p.speed + p.offset) % 1.0;
      final y = size.height * (1.0 - t);
      final dx = math.sin(t * math.pi * 4 + p.wobble) * 14;
      final opacity = t < 0.1
          ? t / 0.1
          : t > 0.75
              ? 1 - (t - 0.75) / 0.25
              : 1.0;
      canvas.drawCircle(
        Offset(p.x * size.width + dx, y),
        p.size * 0.55,
        Paint()
          ..color = p.color.withOpacity(opacity * 0.65)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, p.size * 0.5),
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

  int _lastQuestionIndex = 0;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final String biographyText = '''
Nelson Rolihlahla Mandela became known and respected all over the world as a symbol of the struggle against apartheid and all forms of racism; the icon and the hero of African liberation.

Mandela or Madiba, as he was affectionately known, has been called a freedom fighter, a great man, South Africa's Favourite Son, a global icon and a living legend, among countless other names. He has been an activist, a political prisoner, South Africa's first democratically elected president, an international peacemaker and statesman, and a Nobel Peace Prize winner.

As a husband and a father, Mandela sacrificed the joys of family life and of seeing his children grow up. As a young man, he missed out on a normal life spent with family and friends and pursuing a career of his choice, to fight for the cause he unshakably stood for.

Most ordinary South Africans knew little about Mandela during his prison years, as the apartheid government suppressed information, and what was released was biased. Limited information about Mandela was available from the international press, anti-apartheid activist groups and the Free Nelson Mandela campaign.

But prison bars could not prevent him from continuing to inspire his people to struggle and sacrifice for their liberation. Public opinion polls repeatedly showed that he was the most popular leader the country has ever had. As the Commonwealth Eminent Persons Group observed in 1986, he had become "a living legend", galvanising the resistance in his country.

He is the most honoured political prisoner in history. He has received prestigious international awards, the freedom of many cities and honorary degrees from several universities.

Musicians have been inspired to compose songs and music in his honour. Major international art exhibits have been dedicated to him and some of the most prominent writers have contributed to books for him and about him. Even an atomic particle has been named after him.

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

  void _goToQuestions() async {
    setState(() => animating = true);
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
                  child: Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 243, 196, 23),
                      ),
                      onPressed: _goToQuestions,
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.black),
                      label: const Text(
                        "Go to Questions",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
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
    question: 'Why did Mandela give up a normal life with his family?',
    options: [
      "A) He wanted to travel the world",
      "B) He was forced into exile",
      "C) He chose to fight against injustice",
      "D) He had no family ties"
    ],
    correctIndex: 2,
    explanation:
        ' Mandela sacrificed personal comfort and time with his family because his goal was to fight for freedom and equality in South Africa.',
    incorrectExplanations: [
      ' Traveling was not the main reason for his sacrifice.',
      ' Mandela was not forced into exile; he chose resistance.',
      'Correct answer! ✊',
      ' Mandela had a strong bond with his family but chose activism.',
    ],
  ),
  QuestionData(
    question: 'How did Mandela become a global symbol despite being in prison?',
    options: [
      "A) He wrote novels from prison",
      "B) He led protests while jailed",
      "C) His struggle inspired international support",
      "D) He escaped and traveled"
    ],
    correctIndex: 2,
    explanation:
        ' Although imprisoned, Mandela\'s story and message spread worldwide 🌍, making him a symbol of resistance and justice through campaigns, music, books, and international recognition.',
    incorrectExplanations: [
      ' Mandela was not famous for writing novels.',
      ' He could not physically lead protests from prison.',
      'Correct answer! 🌟',
      ' Mandela did not escape; he remained in prison for 27 years.',
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

  static const Color accentDark = Color(0xFFFF8F00);
  static const Color cardBg = Color(0xFFFFFDE7);

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
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFE082),
            Color(0xFF80CBC4),
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
                        color: const Color(0xFFF3C417),
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
                          icon:
                              const Icon(Icons.menu_book, color: Colors.white),
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
                            backgroundColor: accentDark,
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
                            ),
                            child: Text(
                              currentQuestionIndex ==
                                      widget.questions.length - 1
                                  ? "Finish"
                                  : "Next",
                              style: const TextStyle(color: Colors.black),
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
    ));
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
  int _lastQuestionIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final String biographyTextFirst = '''
Mandela is a universal symbol of freedom and reconciliation, an icon representing the triumph of the human spirit. During his lifetime he not only dedicated himself to the struggle of the African people, but with his humility, and his spirit of forgiveness, he captured hearts and inspired people all over the world. As South Africans, we owe it to this great champion of our nation to continue to live by his example.
''';

  final String biographyTextSecond = '''
Rolihlahla Nelson Mandela was born in Mvezo, a village near Mthatha in the Transkei, on 18 July 1918, to Nongaphi Nosekeni and Gadla Henry Mandela. His father was the key counsellor/adviser to the Thembu royal house. His Xhosa name Rolihlahla literally means "pulling the branch of a tree". After his father's death in 1927, the young Rolihlahla became the ward of Chief Jongintaba Dalindyebo, the acting regent of the Thembu nation. It was at the Thembu royal homestead that his personality, values and political views were shaped. Hearing the elders' stories of his ancestors' valour during the wars of resistance to colonialism, he dreamed also of making his own contribution to the freedom struggle of his people.

After receiving his primary education at a local mission school, where he was given the name Nelson, he was sent to the Clarkebury Boarding Institute for his Junior Certificate and then to Healdtown, a reputable Wesleyan secondary school, where he matriculated. He then enrolled at the University College of Fort Hare for a Bachelor of Arts (BA) Degree where he was elected onto the Students' Representative Council. He was suspended from college for joining a protest boycott, along with Oliver Tambo.
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

  void _goToQuestions() async {
    setState(() => animating = true);
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
                  biographyTextFirst,
                  style: const TextStyle(fontSize: 18, height: 1.6),
                ),
                const SizedBox(height: 8),
                const Text(
                  "The Early Years",
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  biographyTextSecond,
                  style: const TextStyle(fontSize: 18, height: 1.6),
                ),
                const SizedBox(height: 32),
                AnimatedOpacity(
                  opacity: showButton ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  child: Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 243, 196, 23),
                      ),
                      onPressed: _goToQuestions,
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.black),
                      label: const Text(
                        "Go to Questions",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
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
    question: 'What inspired Mandela to join the freedom struggle?',
    options: [
      "A) His studies at university",
      "B) Stories from Thembu elders",
      "C) His father's political job",
      "D) A book he read at school"
    ],
    correctIndex: 1,
    explanation:
        ' Hearing stories of resistance from elders at the royal homestead sparked Mandela’s desire to fight for his people’s freedom.',
    incorrectExplanations: [
      ' His university studies did not inspire his activism.',
      'Correct answer! 🗣️',
      ' His father’s job was not the key motivator mentioned.',
      ' There’s no evidence a specific book inspired his struggle.',
    ],
  ),
  QuestionData(
    question: 'How did Mandela show commitment to his beliefs in college?',
    options: [
      "A) He tutored other students and leaders",
      "B) He joined a debate club and won",
      "C) He took part in a protest and accepted suspension",
      "D) He ran for student president and knew lots of people"
    ],
    correctIndex: 2,
    explanation:
        ' Mandela’s suspension for joining a protest at Fort Hare shows he was already taking risks to stand up for his beliefs.',
    incorrectExplanations: [
      ' Tutoring others was valuable, but not the main act of resistance.',
      ' Debate club participation wasn’t the key demonstration.',
      'Correct answer! ✊',
      ' Running for student president is not what showed his commitment.',
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

  static const Color accentDark = Color(0xFFFF8F00);
  static const Color cardBg = Color(0xFFFFFDE7);

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
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFE082),
            Color(0xFF80CBC4),
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
                        color: const Color(0xFFF3C417),
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
                          icon:
                              const Icon(Icons.menu_book, color: Colors.white),
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
                            backgroundColor: accentDark,
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
                            ),
                            child: Text(
                              currentQuestionIndex ==
                                      widget.questions.length - 1
                                  ? "Finish"
                                  : "Next",
                              style: const TextStyle(color: Colors.black),
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
    ));
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

  final String biographyTextSecond = '''
Shortly after his return to the royal homestead, he and his cousin, Justice, ran away to Johannesburg to avoid arranged marriages and for a short period he worked as a mine policeman. Mandela was introduced to Walter Sisulu in 1941 and it was Sisulu who arranged for him to serve his articles at Lazar Sidelsky's law firm. Completing his BA through the University of South Africa (Unisa) in 1942, he commenced study for his Bachelor of Laws Degree shortly afterwards (though he left the University of the Witwatersrand without graduating in 1948). He entered politics in earnest while studying, and joined the African National Congress (ANC) in 1943.

At the height of the Second World War in 1944, a small group of young Africans who were members of the ANC, banded together under the leadership of Anton Lembede. Among them were William Nkomo, Sisulu, Oliver R Tambo, Ashby P Mda and Mandela. Starting out with 60 members, all of whom were residing around the Witwatersrand, these young people set themselves the formidable task of transforming the ANC into a more radical mass movement.

In September 1944, they came together to found the African National Congress Youth League (ANCYL).

Mandela soon impressed his peers by his disciplined work and consistent effort and was elected as the league's national secretary in 1948. Through painstaking work, campaigning at the grass-roots and through its mouthpiece Inyaniso ("Truth"), the ANCYL was able to canvass support for its policies among the ANC membership.
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

  void _goToQuestions() async {
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
                  child: Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 243, 196, 23),
                      ),
                      onPressed: _goToQuestions,
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.black),
                      label: const Text(
                        "Go to Questions",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
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

final List<QuestionData> sampleQuestionsThird = [
  QuestionData(
    question: 'Why did Mandela and Justice run away to Johannesburg?',
    options: [
      "A) To find better jobs",
      "B) To explore the city",
      "C) To visit relatives",
      "D) To avoid arranged marriages"
    ],
    correctIndex: 3,
    explanation:
        ' The passage clearly states they left to avoid arranged marriages, showing their desire to choose their own paths.',
    incorrectExplanations: [
      ' Finding better jobs was not their main reason for leaving.',
      ' They weren’t just looking to explore the city.',
      ' Visiting relatives wasn’t mentioned as a motive.',
      'Correct! They wanted to avoid arranged marriages. 💍',
    ],
  ),
  QuestionData(
    question:
        'How did Mandela rise in the African National Congress Youth League?',
    options: [
      "A) By making speeches in parliament",
      "B) By publishing his own newspaper",
      "C) Through steady work and grassroots campaigning",
      "D) By organizing concerts and public events"
    ],
    correctIndex: 2,
    explanation:
        ' Mandela earned respect through disciplined effort and campaigning, leading to his election as national secretary.',
    incorrectExplanations: [
      ' Mandela wasn’t in parliament at that point.',
      ' He did not publish his own newspaper.',
      'Correct! His rise was due to grassroots campaigning. 🗳️',
      ' Public events like concerts weren’t the key to his leadership.',
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

  static const Color accentDark = Color(0xFFFF8F00);
  static const Color cardBg = Color(0xFFFFFDE7);

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
        MaterialPageRoute(builder: (_) => BiographyReadingPageFive()),
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
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFE082),
            Color(0xFF80CBC4),
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
                        color: const Color(0xFFF3C417),
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
                          icon:
                              const Icon(Icons.menu_book, color: Colors.white),
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
                            backgroundColor: accentDark,
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
                            ),
                            child: Text(
                              currentQuestionIndex ==
                                      widget.questions.length - 1
                                  ? "Finish"
                                  : "Next",
                              style: const TextStyle(color: Colors.black),
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
    ));
  }
}

class BiographyReadingPageFive extends StatefulWidget {
  const BiographyReadingPageFive({super.key});

  @override
  State<BiographyReadingPageFive> createState() =>
      _BiographyReadingPageFiveState();
}

class _BiographyReadingPageFiveState extends State<BiographyReadingPageFive>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;
  int _lastQuestionIndex = 0;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final String biographyTextSecond = '''

Spurred on by the victory of the National Party, which won the 1948 all-white elections on the platform of apartheid, at the 1949 Annual Conference, the Programme of Action, inspired by the Youth League, which advocated the weapons of boycott, strike, civil disobedience and non-cooperation, was accepted as official ANC policy.

In December, Mandela was elected to the National Executive Committee at the National Conference.

When the ANC launched its Campaign for the Defiance of Unjust Laws in 1952, Mandela, by then president of the Youth League, was elected national volunteer-in-chief. The Defiance Campaign was conceived as a mass civil disobedience campaign that would snowball from a core of selected volunteers to involve more and more ordinary people, culminating in mass defiance. Fulfilling his responsibility as volunteer-in-chief, Mandela travelled the country, organising resistance to discriminatory legislation. Charged, with Moroka, Sisulu and 17 others, and brought to trial for his role in the campaign, the court found that Mandela and his co-accused had consistently advised their followers to adopt a peaceful course of action and to avoid all violence.

For his part in the Defiance Campaign, Mandela was convicted of contravening the Suppression of Communism Act and given a suspended prison sentence. Shortly after the campaign ended, he was also prohibited from attending gatherings and confined to Johannesburg for six months.
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

  void _goToQuestions() async {
    setState(() => animating = true);
    _fadeController.forward();

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
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🟡 TÍTULO
                const Text(
                  "The Political Journey",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 16),

                /// 📖 TEXTO
                Text(
                  biographyTextSecond,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 32),

                AnimatedOpacity(
                  opacity: showButton ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  child: Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 243, 196, 23),
                      ),
                      onPressed: _goToQuestions,
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.black),
                      label: const Text(
                        "Go to Questions",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 🔄 LOADING
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
                        color: Color.fromARGB(255, 243, 196, 23),
                      ),
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

final List<QuestionData> sampleQuestionsFive = [
  QuestionData(
    question: 'Why did Mandela travel around the country in 1952?',
    options: [
      "A) To support local elections",
      "B) To organize peaceful resistance",
      "C) To meet ANC leaders",
      "D) To promote a new education policy"
    ],
    correctIndex: 1,
    explanation:
        ' As national volunteer-in-chief, Mandela’s goal was to organize mass civil disobedience against unjust laws.',
    incorrectExplanations: [
      ' Local elections were not his purpose.',
      'Correct! He traveled to organize peaceful resistance. ✊',
      ' Meeting ANC leaders was not the main reason for his travels.',
      ' Education reform was not the focus of his journey.',
    ],
  ),
  QuestionData(
    question: 'How did Mandela achieve his role in the Defiance Campaign?',
    options: [
      "A) By writing speeches",
      "B) By leading violent protests",
      "C) By organizing volunteers across the country",
      "D) By working as a lawyer for the ANC"
    ],
    correctIndex: 2,
    explanation:
        ' Mandela fulfilled his role by traveling and mobilizing peaceful resistance, as the campaign required.',
    incorrectExplanations: [
      ' Writing speeches was part of his activism but not the main way he led the campaign.',
      ' The campaign focused on peaceful protest, not violence.',
      'Correct! He organized volunteers nationwide. 🌍',
      ' While he was a lawyer, his leadership in this campaign involved organizing actions.',
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
  bool showFeedback = false;
  bool _isCorrect = false;
  String _feedbackText = '';

  static const Color accentDark = Color(0xFFFF8F00);
  static const Color cardBg = Color(0xFFFFFDE7);

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
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFE082),
            Color(0xFF80CBC4),
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
                        color: const Color(0xFFF3C417),
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
                          icon:
                              const Icon(Icons.menu_book, color: Colors.white),
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
                            backgroundColor: accentDark,
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
                            ),
                            child: Text(
                              currentQuestionIndex ==
                                      widget.questions.length - 1
                                  ? "Finish"
                                  : "Next",
                              style: const TextStyle(color: Colors.black),
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
    ));
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

  final String biographyTextSecond = '''
In December 1952, in partnership with Tambo, Mandela opened South Africa's first black law firm in central Johannesburg.

In 1953, Mandela was given the responsibility to prepare a plan that would enable the leadership of the movement to maintain dynamic contact with its membership without recourse to public meetings. The objective was to prepare for the possibility that the ANC would, like the Communist Party, be declared illegal and to ensure that the organisation would be able to operate from underground. This was the M-Plan, named after him.

During the early 1950s, Mandela played an important part in leading the resistance to the Western Areas removals, and to the introduction of Bantu Education. He also played a significant role in popularising the Freedom Charter, adopted by the Congress of the People in 1955.

During the whole of the 1950s, Mandela was the victim of various forms of repression. He was banned, arrested and imprisoned. A five-year banning order was enforced against him in March 1956.

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

  void _goToQuestions() async {
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
                  biographyTextSecond,
                  style: const TextStyle(fontSize: 18, height: 1.6),
                ),
                const SizedBox(height: 32),
                AnimatedOpacity(
                  opacity: showButton ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  child: Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 243, 196, 23),
                      ),
                      onPressed: _goToQuestions,
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.black),
                      label: const Text(
                        "Go to Questions",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
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

final List<QuestionData> sampleQuestionsFinal = [
  QuestionData(
    question: 'Why did Mandela create the M-Plan?',
    options: [
      "A) To improve public speeches",
      "B) To train new lawyers",
      "C) To teach Bantu Education",
      "D) To keep the ANC active if banned"
    ],
    correctIndex: 3,
    explanation:
        ' Mandela’s goal was to help the ANC operate underground if it became illegal. 🔒✊',
    incorrectExplanations: [
      ' The M-Plan was not about improving speeches.',
      ' It wasn’t designed to train lawyers.',
      ' It didn’t promote Bantu Education—it opposed it.',
      'Correct answer! 🎯'
    ],
  ),
  QuestionData(
    question: 'How did Mandela help resist government actions in the 1950s?',
    options: [
      "A) By leaving South Africa",
      "B) By supporting Western Areas removals",
      "C) By organizing legal reforms",
      "D) By leading opposition to forced removals and unfair education"
    ],
    correctIndex: 3,
    explanation:
        ' He actively resisted Bantu Education and removals, and promoted the Freedom Charter. 📝✊',
    incorrectExplanations: [
      ' He did not leave South Africa.',
      ' He opposed, not supported, the removals.',
      ' His actions went beyond just legal reforms.',
      'Correct answer! 🎯'
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

  static const Color accentDark = Color(0xFFFF8F00);
  static const Color cardBg = Color(0xFFFFFDE7);

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
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFE082),
            Color(0xFF80CBC4),
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
                        color: const Color(0xFFF3C417),
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
                          icon:
                              const Icon(Icons.menu_book, color: Colors.white),
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
                            backgroundColor: accentDark,
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
                            ),
                            child: Text(
                              currentQuestionIndex ==
                                      widget.questions.length - 1
                                  ? "Finish"
                                  : "Next",
                              style: const TextStyle(color: Colors.black),
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
    ));
  }
}
