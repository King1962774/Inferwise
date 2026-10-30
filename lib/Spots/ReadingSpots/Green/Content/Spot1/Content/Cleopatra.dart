import 'package:flutter/material.dart';
import 'package:inferwise/Spots/ReadingSpots/Green/Content/Spot1/Spot_Page/reading_spot_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

// ── Reemplaza con tu import real ──────────────────────────────────
// import 'biography_cleopatra.dart';
// ─────────────────────────────────────────────────────────────────

class CleopatraSplashScreen extends StatefulWidget {
  const CleopatraSplashScreen({super.key});

  @override
  State<CleopatraSplashScreen> createState() => _CleopatraSplashScreenState();
}

class _CleopatraSplashScreenState extends State<CleopatraSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _scaleUp;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 4),
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

    // Navegación automática a BiographyCleopatra
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const BiographyCleopatra()), // ← BiographyCleopatra()
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
        // ── Fondo degradado cálido egipcio ──────────────────────────
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF5E6C0), // arena clara
              Color(0xFFE8C97A), // dorado suave
              Color(0xFFD4A832), // ámbar
              Color(0xFFB8832A), // bronce oscuro
            ],
            stops: [0.0, 0.35, 0.65, 1.0],
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
                  // ── Ojo de Ra ─────────────────────────────────────
                  SizedBox(
                    width: 90,
                    height: 64,
                    child: CustomPaint(painter: _EyeOfRaPainter()),
                  ),
                  const SizedBox(height: 20),

                  // ── Título del libro ──────────────────────────────
                  Text(
                    "Cleopatra VII",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2A1000),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // ── Autor ─────────────────────────────────────────
                  Text(
                    "By Joshua J. Mark, 2018",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF5C3000),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // ── Source ─────────────────────────────────────────
                  Text(
                    "From World History Encyclopedia",
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

// ─── Ojo de Ra — CustomPainter ligero ───────────────────────────────
class _EyeOfRaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    final double cy = size.height * 0.48;

    final strokePaint = Paint()
      ..color = const Color(0xFF8B5000)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = const Color(0xFFB87010).withOpacity(0.12)
      ..style = PaintingStyle.fill;

    // Forma almendrada del ojo
    final eyePath = Path()
      ..moveTo(size.width * 0.06, cy)
      ..cubicTo(
        size.width * 0.25,
        cy - size.height * 0.40,
        size.width * 0.75,
        cy - size.height * 0.40,
        size.width * 0.94,
        cy,
      )
      ..cubicTo(
        size.width * 0.75,
        cy + size.height * 0.40,
        size.width * 0.25,
        cy + size.height * 0.40,
        size.width * 0.06,
        cy,
      )
      ..close();
    canvas.drawPath(eyePath, fillPaint);
    canvas.drawPath(eyePath, strokePaint);

    // Iris
    canvas.drawCircle(
      Offset(cx, cy),
      size.width * 0.135,
      Paint()
        ..color = const Color(0xFF7A4500).withOpacity(0.18)
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      Offset(cx, cy),
      size.width * 0.135,
      strokePaint..strokeWidth = 1.2,
    );

    // Pupila
    canvas.drawCircle(
      Offset(cx, cy),
      size.width * 0.068,
      Paint()
        ..color = const Color(0xFF3D1800).withOpacity(0.88)
        ..style = PaintingStyle.fill,
    );

    // Reflejo
    canvas.drawCircle(
      Offset(cx - size.width * 0.025, cy - size.height * 0.08),
      size.width * 0.022,
      Paint()
        ..color = const Color(0xFFFFE090).withOpacity(0.55)
        ..style = PaintingStyle.fill,
    );

    // Cola wedjat (gota decorativa)
    final tailPath = Path()
      ..moveTo(cx, cy + size.height * 0.40)
      ..lineTo(cx - size.width * 0.055, size.height * 0.92)
      ..lineTo(cx + size.width * 0.055, size.height * 0.82)
      ..close();
    canvas.drawPath(
      tailPath,
      Paint()
        ..color = const Color(0xFF8B5000).withOpacity(0.18)
        ..style = PaintingStyle.fill,
    );
    canvas.drawPath(tailPath, strokePaint..strokeWidth = 1.1);

    // Líneas de kohl en los extremos
    canvas.drawLine(
      Offset(size.width * 0.06, cy),
      Offset(size.width * 0.01, cy - size.height * 0.12),
      strokePaint..strokeWidth = 1.1,
    );
    canvas.drawLine(
      Offset(size.width * 0.94, cy),
      Offset(size.width * 0.99, cy - size.height * 0.12),
      strokePaint..strokeWidth = 1.1,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------- CLEOPATRA QUESTIONS ----------------------
class BiographyCleopatra extends StatefulWidget {
  const BiographyCleopatra({super.key});
  @override
  State<BiographyCleopatra> createState() => _BiographyCleopatraState();
}

class _BiographyCleopatraState extends State<BiographyCleopatra> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What was the main role of a pharaoh in ancient Egypt?",
      "options": [
        "A) A skilled artist who painted tombs and temples",
        "B) A military general who only led armies",
        "C) A political and religious leader considered a god-king",
        "D) A farmer who controlled the Nile’s floods"
      ],
      "correct": 2,
      "feedback": [
        " No, artists were important, but pharaohs had higher roles.",
        " Incorrect, pharaohs led armies but were more than generals.",
        "𓅓 Correct! Pharaohs were seen as god-kings and divine rulers.",
        " While they influenced agriculture, that wasn’t their main role."
      ]
    },
    {
      "question": "How did pharaohs claim their right to rule?",
      "options": [
        "A) By winning elections",
        "B) Through inheritance",
        "C) By conquering neighboring kingdoms",
        "D) By marrying high priestesses"
      ],
      "correct": 1,
      "feedback": [
        " Egypt did not have elections like democracies today.",
        "𓅓 Correct! Power passed through family bloodlines.",
        " Conquest wasn't the basis for legitimacy.",
        " Priestesses did not grant ruling rights."
      ]
    },
    {
      "question": "What was the primary duty of a pharaoh to the gods?",
      "options": [
        "A) Building giant statues of themselves",
        "B) Maintaining ma’at (cosmic balance and order)",
        "C) Collecting taxes from the poor",
        "D) Writing sacred scrolls"
      ],
      "correct": 1,
      "feedback": [
        " While they built monuments, their duty was deeper.",
        "𓅓 Correct! Pharaohs had to maintain ma’at (order and harmony).",
        " Tax collection was administrative, not divine duty.",
        " Writing was the task of scribes, not pharaohs."
      ]
    },
    {
      "question": "How did ordinary Egyptians view their pharaoh?",
      "options": [
        "A) As a cruel dictator they feared",
        "B) As a distant bureaucrat who taxed them",
        "C) As a living god and protector",
        "D) As a figurehead with no real power"
      ],
      "correct": 2,
      "feedback": [
        " Pharaohs were respected, not just feared.",
        " They were seen as divine, not mere officials.",
        "𓅓 Correct! Egyptians believed pharaohs were gods in human form.",
        " Pharaohs held great power and responsibility."
      ]
    },
    {
      "question": "Why did pharaohs build pyramids?",
      "options": [
        "A) As tombs to protect their bodies and souls for the afterlife",
        "B) As monuments to celebrate military victories",
        "C) As prisons for enemies of Egypt",
        "D) As astronomical tools to predict the Nile’s floods"
      ],
      "correct": 0,
      "feedback": [
        "𓅓 Correct! Pyramids were sacred tombs to aid the pharaoh’s journey to the afterlife.",
        " Pyramids were not meant to glorify victories.",
        " They were not used as prisons.",
        " Although aligned astronomically, that wasn’t the main reason."
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
          MaterialPageRoute(builder: (_) => const CleopatraReadingAnimation()),
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

class CleopatraReadingAnimation extends StatefulWidget {
  const CleopatraReadingAnimation({super.key});

  @override
  State<CleopatraReadingAnimation> createState() =>
      _CleopatraReadingAnimationState();
}

class _CleopatraReadingAnimationState extends State<CleopatraReadingAnimation>
    with TickerProviderStateMixin {
  // ── Controllers ──────────────────────────────────────────────
  late final AnimationController _entryCtrl; // text + divider
  late final AnimationController _glowCtrl; // pulsing glow
  late final AnimationController _bgCtrl; // shimmer background
  late final AnimationController _crownCtrl; // crown rocking
  late final AnimationController _particleCtrl; // floating particles

  // ── Animations ───────────────────────────────────────────────
  late final Animation<double> _textFade;
  late final Animation<double> _textSlide;
  late final Animation<double> _dividerWidth;
  // ignore: unused_field
  late final Animation<double> _subtitleFade;
  late final Animation<double> _glow;
  late final Animation<Color?> _bgColor1;
  late final Animation<Color?> _bgColor2;
  late final Animation<double> _crownRock;

  // ── Particle data ─────────────────────────────────────────────
  final List<_Particle> _particles = [];
  final math.Random _rng = math.Random();

  static const _golden = [
    Color(0xFFE8D5A3),
    Color(0xFFEF9F27),
    Color(0xFFFAC775),
    Color(0xFFBA7517),
    Color(0xFFFAEEDA),
  ];

  @override
  void initState() {
    super.initState();
    _spawnParticles();

    // Entry (text, divider, subtitle)
    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _textFade = CurvedAnimation(
      parent: _entryCtrl,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );

    _textSlide = Tween<double>(begin: 18, end: 0).animate(
      CurvedAnimation(
        parent: _entryCtrl,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
      ),
    );

    _dividerWidth = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryCtrl,
        curve: const Interval(0.2, 0.65, curve: Curves.easeOut),
      ),
    );

    _subtitleFade = CurvedAnimation(
      parent: _entryCtrl,
      curve: const Interval(0.55, 1.0, curve: Curves.easeIn),
    );

    // Glow pulse
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat(reverse: true);

    _glow = Tween<double>(begin: 6, end: 28).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );

    // Background shimmer
    _bgCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _bgColor1 = ColorTween(
      begin: const Color(0xFF412402),
      end: const Color(0xFF633806),
    ).animate(_bgCtrl);

    _bgColor2 = ColorTween(
      begin: const Color(0xFFEF9F27),
      end: const Color(0xFFFAEEDA),
    ).animate(_bgCtrl);

    // Crown rock
    _crownCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    )..repeat(reverse: true);

    _crownRock = Tween<double>(begin: -0.07, end: 0.07).animate(
      CurvedAnimation(parent: _crownCtrl, curve: Curves.easeInOut),
    );

    // Particles
    _particleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

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
    for (int i = 0; i < 24; i++) {
      _particles.add(_Particle(
        x: _rng.nextDouble(),
        size: 3 + _rng.nextDouble() * 5,
        speed: 0.6 + _rng.nextDouble() * 1.4,
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
    _crownCtrl.dispose();
    _particleCtrl.dispose();
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
          _crownCtrl,
          _particleCtrl,
        ]),
        builder: (context, _) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // ── Shimmer background ───────────────────────────
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _bgColor1.value ?? const Color(0xFF412402),
                      const Color(0xFF854F0B),
                      const Color(0xFFBA7517),
                      _bgColor2.value ?? const Color(0xFFEF9F27),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              // ── Radial vignette ──────────────────────────────
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.1,
                    colors: [
                      Colors.transparent,
                      const Color(0xFF1E0C00).withOpacity(0.65),
                    ],
                  ),
                ),
              ),

              // ── Floating particles ───────────────────────────
              CustomPaint(
                painter: _ParticlePainter(
                  particles: _particles,
                  progress: _particleCtrl.value,
                ),
              ),

              // ── Main content ─────────────────────────────────
              SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Crown
                        AnimatedBuilder(
                          animation: _crownCtrl,
                          builder: (_, __) => Transform.rotate(
                            angle: _crownRock.value,
                            child: _CrownIcon(glow: _glow.value),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Divider line
                        AnimatedBuilder(
                          animation: _entryCtrl,
                          builder: (_, __) => FractionallySizedBox(
                            widthFactor: _dividerWidth.value,
                            child: Container(
                              height: 1.5,
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
                        ),

                        const SizedBox(height: 24),

                        // Main message
                        AnimatedBuilder(
                          animation: _entryCtrl,
                          builder: (_, __) => FadeTransition(
                            opacity: _textFade,
                            child: Transform.translate(
                              offset: Offset(0, _textSlide.value),
                              child: AnimatedBuilder(
                                animation: _glowCtrl,
                                builder: (_, __) => Text(
                                  'Step into history!\nThe more you read,\nthe deeper your wisdom shines.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Georgia',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFFFAEEDA),
                                    height: 1.55,
                                    letterSpacing: 0.5,
                                    shadows: [
                                      Shadow(
                                        color: const Color(0xFFEF9F27)
                                            .withOpacity(0.9),
                                        blurRadius: _glow.value,
                                      ),
                                      Shadow(
                                        color: const Color(0xFFBA7517)
                                            .withOpacity(0.6),
                                        blurRadius: _glow.value * 2.2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Divider line (bottom)
                        AnimatedBuilder(
                          animation: _entryCtrl,
                          builder: (_, __) => FractionallySizedBox(
                            widthFactor: _dividerWidth.value,
                            child: Container(
                              height: 1,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Color(0xFFBA7517),
                                    Color(0xFFEF9F27),
                                    Color(0xFFBA7517),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),
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
}

// ── Crown icon ────────────────────────────────────────────────────────────────
class _CrownIcon extends StatelessWidget {
  final double glow;
  const _CrownIcon({required this.glow});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      height: 56,
      child: CustomPaint(painter: _CrownPainter(glow: glow)),
    );
  }
}

class _CrownPainter extends CustomPainter {
  final double glow;
  const _CrownPainter({required this.glow});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final glowPaint = Paint()
      ..color = const Color(0xFFEF9F27).withOpacity(0.55)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, glow * 0.7);

    final crownPaint = Paint()
      ..color = const Color(0xFFEF9F27)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = const Color(0xFFFAEEDA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(w * 0.06, h * 0.92)
      ..lineTo(w * 0.06, h * 0.38)
      ..lineTo(w * 0.25, h * 0.62)
      ..lineTo(w * 0.5, h * 0.10)
      ..lineTo(w * 0.75, h * 0.62)
      ..lineTo(w * 0.94, h * 0.38)
      ..lineTo(w * 0.94, h * 0.92)
      ..close();

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, crownPaint);
    canvas.drawPath(path, strokePaint);

    // Base bar
    final basePaint = Paint()..color = const Color(0xFFBA7517);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.06, h * 0.85, w * 0.88, h * 0.12),
        const Radius.circular(4),
      ),
      basePaint,
    );

    // Gems
    final gemPaint = Paint()
      ..color = const Color(0xFFFAEEDA)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, glow * 0.3);

    for (final pt in [
      Offset(w * 0.50, h * 0.13),
      Offset(w * 0.06, h * 0.38),
      Offset(w * 0.94, h * 0.38),
    ]) {
      canvas.drawCircle(pt, 4, gemPaint);
      canvas.drawCircle(
          pt, 3.5, Paint()..color = const Color(0xFFFAEEDA).withOpacity(0.9));
    }
  }

  @override
  bool shouldRepaint(_CrownPainter old) => old.glow != glow;
}

// ── Particle system ───────────────────────────────────────────────────────────
class _Particle {
  final double x;
  final double size;
  final double speed;
  final Color color;
  final double offset; // phase offset 0‥1

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

  const _ParticlePainter({
    required this.particles,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final t = ((progress * p.speed + p.offset) % 1.0);
      final y = size.height * (1.0 - t);
      final dx = math.sin(t * math.pi * 3 + p.offset * 6) * 18;
      final opacity = t < 0.15
          ? t / 0.15
          : t > 0.75
              ? 1 - (t - 0.75) / 0.25
              : 1.0;
      final paint = Paint()
        ..color = p.color.withOpacity(opacity * 0.75)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, p.size * 0.6);
      canvas.drawCircle(
        Offset(p.x * size.width + dx, y),
        p.size * 0.55,
        paint,
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
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  final String biographyText = '''
The golden sands of Egypt had witnessed countless pharaohs come and go, but none would leave as indelible a mark as the young queen who ascended to power in 51 BCE. Cleopatra VII Philopator entered a world where the glories of ancient Egypt were fading memories, where her Greek ancestors - the Ptolemies - had ruled for nearly three centuries without ever truly understanding the land they governed. She would change everything.

Born in the royal palace of Alexandria in 69 BCE, Cleopatra grew up in the shadow of Rome's growing power. Her childhood was spent studying in the great Library, where she absorbed knowledge like the Nile absorbed sunlight. Unlike her predecessors who clung stubbornly to their Greek heritage, the young princess immersed herself in Egyptian culture. She became the first and only Ptolemaic ruler to master the ancient Egyptian language, along with seven others - a linguistic prowess that would later astonish foreign diplomats.
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
                            backgroundColor: const Color(0xFFF3C417),
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
        '"She absorbed knowledge like the Nile absorbed sunlight."\n\nWho does "she" refer to?',
    options: [
      "A) The Library of Alexandria",
      "B) A Greek ancestor",
      "C) Cleopatra ",
      "D) The Egyptian language"
    ],
    correctIndex: 2,
    explanation:
        ' The pronoun "she" refers to Cleopatra, who was mentioned in the previous sentence as growing up in Alexandria.',
    incorrectExplanations: [
      ' The Library is a place, not a person who can absorb knowledge.',
      ' No specific Greek ancestor is named in this context.',
      ' Correct answer!',
      'The Egyptian language is not described with the pronoun "she" or in terms of learning.',
    ],
  ),
  QuestionData(
    question:
        '"Unlike her predecessors who clung stubbornly to their Greek heritage, the young princess immersed herself in Egyptian culture." \n\nWho does "the young princess" refer to?',
    options: [
      "A) Cleopatra",
      "B) A Roman noblewoman",
      "C) One of the Ptolemaic rulers",
      "D) A daughter of Julius Caesar"
    ],
    correctIndex: 0,
    explanation:
        '"The young princess" refers back to Cleopatra, who is introduced earlier as ascending to power and is described throughout the paragraph. We infer they are the same person.',
    incorrectExplanations: [
      ' Correct answer!',
      ' No Roman noblewoman is mentioned in this context.',
      ' Though Cleopatra was a Ptolemaic ruler, "the young princess" clearly refers to her individually.',
      ' Julius Caesar’s daughter is not referenced in this text.',
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

class _BiographyReadingPageSecondState extends State<BiographyReadingPageSecond>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  final String biographyTextSecond = '''
When her father, Ptolemy XII, died in 51 BCE, eighteen-year-old Cleopatra faced her first challenge. Egyptian tradition demanded a female ruler have a male consort, so she was forced to marry her ten-year-old brother, Ptolemy XIII. But this was no equal partnership. From the beginning, Cleopatra made it clear she would rule alone. Official documents soon bore only her name, her face appeared alone on coins, and she began issuing decrees in the ancient Egyptian style - a calculated move to win the people's loyalty.

The royal court seethed with resentment. Powerful advisors like Pothinus and Theodotus of Chios watched in horror as this young woman ignored their counsel and made her own decisions. When Roman mercenaries in Egypt's pay murdered the sons of Rome's governor in Syria, Cleopatra acted swiftly and decisively - arresting the killers and sending them to face Roman justice. It was a bold statement: Egypt would not be a lawless frontier.
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
        '"Powerful advisors like Pothinus and Theodotus of Chios watched in horror as this young woman ignored their counsel and made her own decisions." \n\nWho does “their” refer to?',
    options: [
      "A) The royal guards",
      "B) Cleopatra and her brother",
      "C) The advisors",
      "D) The Roman mercenaries"
    ],
    correctIndex: 2,
    explanation:
        ' “Their” refers to Pothinus and Theodotus of Chios, the advisors whose guidance Cleopatra refused to follow.',
    incorrectExplanations: [
      ' The royal guards are not mentioned as offering counsel in this part of the text.',
      ' Cleopatra and her brother were involved in a power struggle, not giving each other advice.',
      ' Correct answer!',
      ' Roman mercenaries are only referenced in military or violent actions, not in advisory roles.',
    ],
  ),
  QuestionData(
    question:
        '"When Roman mercenaries in Egypt\'s pay murdered the sons of Rome\'s governor in Syria, Cleopatra acted swiftly and decisively - arresting the killers and sending them to face Roman justice."\n\nWhat does “the killers” refer to? ',
    options: [
      "A) The advisors who opposed her",
      "B) The sons of Rome’s governor",
      "C) The Roman soldiers stationed in Egypt ",
      "D) The mercenaries who committed murder"
    ],
    correctIndex: 3,
    explanation:
        ' “The killers” refers to the Roman mercenaries who murdered the sons of the Roman governor in Syria, as mentioned in the previous sentence.',
    incorrectExplanations: [
      ' The advisors were politically opposed to Cleopatra, but they were not the murderers.',
      ' The sons of the governor were the victims, not the perpetrators.',
      ' Roman soldiers stationed in Egypt were not responsible for that specific crime.',
      ' Correct answer!',
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
                        border: Border.all(
                            color: const Color(0xFFF3C417), width: 1.5),
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

class _BiographyReadingPageThirdState extends State<BiographyReadingPageThird>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  final String biographyTextThird = '''
By 48 BCE, the conspirators struck. Forced into exile, Cleopatra gathered mercenary armies in Syria, determined to fight her way back to power. But fate intervened in the form of Rome's civil war. When Pompey the Great arrived seeking sanctuary after his defeat at Pharsalus, her brother's advisors made a fatal miscalculation - they murdered him, hoping to curry favor with the victorious Julius Caesar.

Instead, when Caesar arrived in Alexandria, he was furious. The stage was set for Cleopatra's most famous moment. Knowing she couldn't enter the palace openly, legend says she had herself smuggled to Caesar rolled in a carpet (or perhaps a bed sack). When unfurled before the Roman general, the 21-year-old exile didn't beg for help - she negotiated as an equal. Plutarch would later write of Caesar being instantly "captivated by her intelligence and charm."

What followed was a desperate six-month siege of Alexandria, during which parts of the great Library may have burned. Cleopatra fought side-by-side with Caesar, proving herself far more than just a pretty face. When the dust settled, her brother was dead, and Cleopatra sat once more on Egypt's throne - now with a Roman guarantee of support.
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
                  biographyTextThird,
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
        '"When Pompey the Great arrived seeking sanctuary after his defeat at Pharsalus, her brother\'s advisors made a fatal miscalculation - they murdered him."\n\nWho does “they” refer to?',
    options: [
      "A) Roman generals",
      "B) Caesar’s soldiers",
      "C) Cleopatra’s mercenaries",
      "D) Her brother’s advisors"
    ],
    correctIndex: 3,
    explanation:
        '“They” refers to her brother’s advisors, who made the decision to murder Pompey in hopes of gaining Caesar’s approval.',
    incorrectExplanations: [
      ' Roman generals did not carry out the assassination; it was a political move by Egyptians.',
      ' Caesar’s soldiers were not involved in Pompey’s death.',
      ' Cleopatra’s mercenaries played no role in the assassination.',
      ' Correct answer!',
    ],
  ),
  QuestionData(
    question:
        '"Legend says she had herself smuggled to Caesar rolled in a carpet (or perhaps a bed sack). When unfurled before the Roman general, the 21-year-old exile didn\'t beg for help"\n\nWho does “the Roman general” refer to?',
    options: [
      "A) Pompey the Great",
      "B) Julius Caesar",
      "C) Marc Antony",
      "D) A Roman mercenary"
    ],
    correctIndex: 1,
    explanation:
        ' “The Roman general” refers back to Julius Caesar, who had just arrived in Alexandria and was furious about Pompey’s murder.',
    incorrectExplanations: [
      ' Pompey had already been killed and could not be present at that moment.',
      ' Correct answer!',
      ' Marc Antony was not involved in this particular scene.',
      'The general referred to is a high-ranking figure, not a nameless mercenary.',
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
                        border: Border.all(
                            color: const Color(0xFFF3C417), width: 1.5),
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

class _BiographyReadingPageFinalState extends State<BiographyReadingPageFinal>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  final String biographyTextSecond = '''
The next years would see Cleopatra at the height of her power. She bore Caesar a son, Caesarion, and ruled Egypt with remarkable skill, reviving its economy and restoring its temples. When Caesar was assassinated in 44 BCE, she quietly returned to Alexandria, watching as Rome tore itself apart in civil war.

Her next act would be even more dramatic. When Mark Antony summoned Egyptian rulers to Tarsus in 41 BCE, Cleopatra made sure her entrance would be unforgettable. She arrived on a golden barge with purple sails, dressed as Venus, surrounded by attendants costumed as cupids. Plutarch describes how perfumes wafted from the ship to shore, drawing crowds who abandoned the marketplace to witness the spectacle. Antony, known for his love of spectacle and pleasure, never stood a chance.

Their partnership would last a decade - a grand alliance that nearly reshaped the ancient world. Together they dreamed of an empire that blended East and West, with Alexandria as its glittering capital. Cleopatra bore Antony three children, and for a brief, glorious moment, it seemed their vision might become reality.
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
        '"Their partnership would last a decade (...)Together they dreamed of an empire that blended East and West..." \n\nWho does “their partnership” refer to?',
    options: [
      "A) Caesarion and Cleopatra",
      "B) Plutarch and Cleopatra",
      "C) Mark Antony and Cleopatra", // Correct answer
      "D) Julius Caesar and Plutarch"
    ],
    correctIndex: 2,
    explanation:
        ' “He” refers to Mark Antony, who was famously captivated by Cleopatra’s theatrical arrival and luxurious display.',
    incorrectExplanations: [
      ' Caesarion was Cleopatra’s son and not involved in this specific event.',
      ' Plutarch was a historian writing about the event, not a participant.',
      ' Correct answer!',
      ' "A Roman general" is too vague and doesn’t specify Mark Antony, who is clearly meant.',
    ],
  ),
  QuestionData(
    question:
        '"She arrived on a golden barge with purple sails (...) drawing crowds who abandoned the marketplace to witness the spectacle.\n\nWhat does “the spectacle” refer to?',
    options: [
      "A) The elaborate arrival",
      "B) The Roman civil war",
      "C) Her role as a mother and ruler",
      "D) A festival in Alexandria"
    ],
    correctIndex: 0,
    explanation:
        ' “The spectacle” refers to Cleopatra’s elaborate entrance, which included her costume as Venus, the golden barge, the perfumes, and the entire dramatic performance that drew public attention.',
    incorrectExplanations: [
      ' Correct answer!',
      ' The Roman civil war is unrelated to Cleopatra’s specific entrance in Tarsus.',
      ' Her maternal and political roles are not the focus of this phrase.',
      ' The phrase refers to a real event in Tarsus, not a festival in Alexandria.',
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
                        border: Border.all(
                            color: const Color(0xFFF3C417), width: 1.5),
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
