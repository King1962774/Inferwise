import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Blue/Content/Spot1/Spot_Page/ReadingSpot.dart';
import 'dart:math' as math;

class YnesSplashScreen extends StatefulWidget {
  const YnesSplashScreen({super.key});

  @override
  State<YnesSplashScreen> createState() => _YnesSplashScreenState();
}

class _YnesSplashScreenState extends State<YnesSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _leavesController;
  late Animation<double> _fadeIn;
  late Animation<double> _scaleUp;

  final List<_LeafData> _leaves = [];

  @override
  void initState() {
    super.initState();

    final rng = math.Random();
    for (int i = 0; i < 10; i++) {
      _leaves.add(_LeafData(
        x: rng.nextDouble(),
        delay: rng.nextDouble() * 5.0,
        duration: 3.5 + rng.nextDouble() * 2.0,
        drift: (rng.nextDouble() - 0.5) * 0.12,
        rotation: (rng.nextDouble() - 0.5) * 2.5,
        size: 8.0 + rng.nextDouble() * 7.0,
      ));
    }

    _mainController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _fadeIn = CurvedAnimation(parent: _mainController, curve: Curves.easeIn);
    _scaleUp = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.elasticOut),
    );
    _mainController.forward();

    _leavesController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Ynes()), // ← Ynes()
      );
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _leavesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
        child: Stack(
          children: [
            // ── Hojas cayendo ──────────────────────────────────────
            AnimatedBuilder(
              animation: _leavesController,
              builder: (_, __) => CustomPaint(
                size: Size(size.width, size.height),
                painter: _LeavesPainter(_leaves, _leavesController.value),
              ),
            ),

            // ── Contenido principal ────────────────────────────────
            Center(
              child: FadeTransition(
                opacity: _fadeIn,
                child: ScaleTransition(
                  scale: _scaleUp,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ── Ícono flor ─────────────────────────────────
                      Icon(
                        Icons.filter_vintage,
                        color: const Color(0xFF8B5000),
                        size: 90,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Ynes E. J. Mexia\nWhere Love for Science Meets\nthe Spirit of Adventure",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2E1200),
                        ),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        "By Carolina Martínez Pulido, 2022",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: const Color(0xFF5C3000),
                        ),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        "From Mujeres con ciencia",
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
          ],
        ),
      ),
    );
  }
}

// ─── Datos de cada hoja ───────────────────────────────────────────────
class _LeafData {
  final double x, delay, duration, drift, rotation, size;
  const _LeafData({
    required this.x,
    required this.delay,
    required this.duration,
    required this.drift,
    required this.rotation,
    required this.size,
  });
}

// ─── Painter de hojas cayendo ─────────────────────────────────────────
class _LeavesPainter extends CustomPainter {
  final List<_LeafData> leaves;
  final double t;

  _LeavesPainter(this.leaves, this.t);

  @override
  void paint(Canvas canvas, Size size) {
    for (final leaf in leaves) {
      final totalCycle = leaf.duration + leaf.delay;
      final elapsed = (t * 6.0) % totalCycle;
      if (elapsed < leaf.delay) continue;

      final progress = ((elapsed - leaf.delay) / leaf.duration).clamp(0.0, 1.0);
      final opacity = progress < 0.1
          ? progress / 0.1
          : progress > 0.8
              ? (1.0 - progress) / 0.2
              : 1.0;

      final dx = leaf.x * size.width + leaf.drift * size.width * progress;
      final dy = -leaf.size + progress * (size.height + leaf.size * 2);

      canvas.save();
      canvas.translate(dx, dy);
      canvas.rotate(leaf.rotation * progress);

      final hw = leaf.size * 0.52;
      final hh = leaf.size * 0.34;
      final path = Path()
        ..moveTo(0, -hh)
        ..cubicTo(hw, -hh, hw, hh, 0, hh)
        ..cubicTo(-hw, hh, -hw, -hh, 0, -hh)
        ..close();

      canvas.drawPath(
          path,
          Paint()
            ..color = const Color(0xFF8B5000).withOpacity(opacity * 0.52)
            ..style = PaintingStyle.fill);

      canvas.drawLine(
        Offset(0, -hh * 0.75),
        Offset(0, hh * 0.75),
        Paint()
          ..color = const Color(0xFF5C3000).withOpacity(opacity * 0.45)
          ..strokeWidth = 0.9
          ..strokeCap = StrokeCap.round,
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _LeavesPainter old) => old.t != t;
}

class Ynes extends StatefulWidget {
  const Ynes({super.key});
  @override
  State<Ynes> createState() => _YnesState();
}

class _YnesState extends State<Ynes> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What does a botanist study?",
      "options": ["A) Insects", "B) Rocks", "C) Plants", "D) Stars"],
      "correct": 2,
      "feedback": [
        " Insects are studied by entomologists, not botanists.",
        " Rocks are studied in geology, not botany.",
        "🌿 Correct! A botanist is a scientist who specializes in studying plants.",
        " Stars are studied in astronomy, not botany."
      ]
    },
    {
      "question":
          "What kind of plants might a botanist study in the rainforest?",
      "options": [
        "A) Desert plants",
        "B) Polar mosses",
        "C) Algae",
        "D) Tropical plants"
      ],
      "correct": 3,
      "feedback": [
        " Desert plants don’t grow in rainforests.",
        " Polar mosses grow in cold regions, not in rainforests.",
        " Algae are mostly aquatic and not specific to rainforests.",
        "🌿 Correct! Tropical plants grow in warm, moist rainforests."
      ]
    },
    {
      "question":
          "What degree is usually required to become a professional botanist?",
      "options": [
        "A) Law degree",
        "B) Medical degree",
        "C) Biology or Botany degree",
        "D) Art degree"
      ],
      "correct": 2,
      "feedback": [
        " A law degree is unrelated to botany.",
        " A medical degree is for practicing medicine, not botany.",
        "🌿 Correct! Botanists usually study biology, plant science, or botany in college.",
        " Art degrees do not qualify someone to be a botanist."
      ]
    },
    {
      "question": "What is a herbarium used for?",
      "options": [
        "A) Growing vegetables",
        "B) Pressing and storing plant samples",
        "C) Cooking herbs",
        "D) Making medicine"
      ],
      "correct": 1,
      "feedback": [
        " A herbarium is not used for growing plants.",
        "🌿 Correct! A herbarium is a collection of preserved plants for study.",
        " Cooking herbs is unrelated to the scientific function of a herbarium.",
        " Making medicine is not the main purpose of a herbarium."
      ]
    },
    {
      "question": "What is one reason botanists might travel to remote areas?",
      "options": [
        "A) To find lost treasure",
        "B) To discover new plant species",
        "C) To observe stars",
        "D) To test food"
      ],
      "correct": 1,
      "feedback": [
        " Treasure hunting is not related to botany.",
        "🌿 Correct! Botanists explore wild areas to find unknown or rare plants.",
        " Observing stars is part of astronomy, not botany.",
        " Testing food is not a primary reason for fieldwork in botany."
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
          MaterialPageRoute(builder: (_) => const YnesEJReadingAnimation()),
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

// ── Entry point ───────────────────────────────────────────────────────────────
class YnesEJReadingAnimation extends StatefulWidget {
  const YnesEJReadingAnimation({super.key});

  @override
  State<YnesEJReadingAnimation> createState() => _YnesEJReadingAnimationState();
}

class _YnesEJReadingAnimationState extends State<YnesEJReadingAnimation>
    with TickerProviderStateMixin {
  // ── Controllers — todos declarados como campos late final ─────────────────
  late final AnimationController _entryCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _bgCtrl;
  late final AnimationController _leafSwayCtrl;
  late final AnimationController _leafPulseCtrl; // nunca anónimo
  late final AnimationController _particleCtrl;
  late final AnimationController _beamsCtrl;

  // ── Animations ────────────────────────────────────────────────────────────
  late final Animation<double> _textFade;
  late final Animation<double> _textSlide;
  late final Animation<double> _dividerWidth;
  late final Animation<double> _iconFade;
  late final Animation<double> _iconScale;
  late final Animation<double> _glow;
  late final Animation<Color?> _bgColor1;
  late final Animation<Color?> _bgColor2;
  late final Animation<double> _leafSway;
  late final Animation<double> _leafPulse;
  late final Animation<double> _beamsOpacity;

  // ── Partículas ────────────────────────────────────────────────────────────
  final List<_EarthParticle> _particles = [];
  final math.Random _rng = math.Random();

  static const _earthColors = [
    Color(0xFFFFE8B6),
    Color(0xFFF0C060),
    Color(0xFFC89B3C),
    Color(0xFF8B6020),
    Color(0xFF4A3010),
  ];

  @override
  void initState() {
    super.initState();
    _spawnParticles();

    // ── Entry ────────────────────────────────────────────────────────────────
    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _textFade = CurvedAnimation(
      parent: _entryCtrl,
      curve: const Interval(0.0, 0.65, curve: Curves.easeOut),
    );
    _textSlide = Tween<double>(begin: 16, end: 0).animate(
      CurvedAnimation(
        parent: _entryCtrl,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOutCubic),
      ),
    );
    _dividerWidth = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryCtrl,
        curve: const Interval(0.25, 0.75, curve: Curves.easeOut),
      ),
    );
    _iconFade = CurvedAnimation(
      parent: _entryCtrl,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );
    _iconScale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryCtrl,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOutBack),
      ),
    );

    // ── Glow suave ───────────────────────────────────────────────────────────
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat(reverse: true);
    _glow = Tween<double>(begin: 6, end: 22).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );

    // ── Background shimmer ───────────────────────────────────────────────────
    _bgCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
    _bgColor1 = ColorTween(
      begin: const Color(0xFF2A1B12),
      end: const Color(0xFF3A2418),
    ).animate(_bgCtrl);
    _bgColor2 = ColorTween(
      begin: const Color(0xFFFFE8B6),
      end: const Color(0xFFFFF4D6),
    ).animate(_bgCtrl);

    // ── Hoja: balanceo lento ─────────────────────────────────────────────────
    _leafSwayCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);
    _leafSway = Tween<double>(begin: -0.06, end: 0.06).animate(
      CurvedAnimation(parent: _leafSwayCtrl, curve: Curves.easeInOut),
    );

    // ── Hoja: pulso de escala (controller propio, NO anónimo) ─────────────────
    _leafPulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _leafPulse = Tween<double>(begin: 0.94, end: 1.06).animate(
      CurvedAnimation(parent: _leafPulseCtrl, curve: Curves.easeInOut),
    );

    // ── Partículas ───────────────────────────────────────────────────────────
    _particleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    // ── Rayos de luz ─────────────────────────────────────────────────────────
    _beamsCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
    _beamsOpacity = Tween<double>(begin: 0.04, end: 0.16).animate(
      CurvedAnimation(parent: _beamsCtrl, curve: Curves.easeInOut),
    );

    // ── Secuencia automática ─────────────────────────────────────────────────
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await _entryCtrl.forward();
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      _goToNextScreen();
    });
  }

  void _spawnParticles() {
    for (int i = 0; i < 26; i++) {
      _particles.add(_EarthParticle(
        x: _rng.nextDouble(),
        size: 2.0 + _rng.nextDouble() * 4.0,
        speed: 0.35 + _rng.nextDouble() * 1.2,
        color: _earthColors[_rng.nextInt(_earthColors.length)],
        offset: _rng.nextDouble(),
        wobble: _rng.nextDouble() * math.pi * 2,
      ));
    }
  }

  @override
  void dispose() {
    // Todos los controllers dispuestos — sin leaks
    _entryCtrl.dispose();
    _glowCtrl.dispose();
    _bgCtrl.dispose();
    _leafSwayCtrl.dispose();
    _leafPulseCtrl.dispose();
    _particleCtrl.dispose();
    _beamsCtrl.dispose();
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
          ).animate(
            CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
          );
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
          _leafSwayCtrl,
          _leafPulseCtrl,
          _particleCtrl,
          _beamsCtrl,
          _entryCtrl,
        ]),
        builder: (context, _) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // ── Fondo cálido animado ──────────────────────────────────────
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _bgColor1.value ?? const Color(0xFF2A1B12),
                      const Color(0xFF5C3A21),
                      const Color(0xFFC89B3C),
                      _bgColor2.value ?? const Color(0xFFFFE8B6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              // ── Halo suave ────────────────────────────────────────────────
              Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(-0.2, -0.35),
                    radius: 1.05,
                    colors: [
                      Colors.white.withOpacity(0.13),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // ── Vignette ──────────────────────────────────────────────────
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.18,
                    colors: [
                      Colors.transparent,
                      const Color(0xFF120A04).withOpacity(0.65),
                    ],
                  ),
                ),
              ),

              // ── Rayos de luz ──────────────────────────────────────────────
              CustomPaint(
                painter: _BeamsPainter(opacity: _beamsOpacity.value),
              ),

              // ── Partículas de tierra ──────────────────────────────────────
              CustomPaint(
                painter: _EarthParticlePainter(
                  particles: _particles,
                  progress: _particleCtrl.value,
                ),
              ),

              // ── Contenido ─────────────────────────────────────────────────
              SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 🌿 Hoja animada
                        FadeTransition(
                          opacity: _iconFade,
                          child: ScaleTransition(
                            scale: _iconScale,
                            child: CustomPaint(
                              size: const Size(72, 84),
                              painter: _LeafPainter(
                                sway: _leafSway.value,
                                pulse: _leafPulse.value,
                                glow: _glow.value,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        // ── Divider superior ─────────────────────────────────
                        _buildDivider(thick: true),

                        const SizedBox(height: 22),

                        // ── Mensaje ───────────────────────────────────────────
                        FadeTransition(
                          opacity: _textFade,
                          child: Transform.translate(
                            offset: Offset(0, _textSlide.value),
                            child: Text(
                              'Words shape thought.\nUnderstanding begins within.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Cinzel',
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFFFF8EC),
                                height: 1.55,
                                letterSpacing: 0.4,
                                shadows: [
                                  Shadow(
                                    color: Colors.amberAccent.withOpacity(0.85),
                                    blurRadius: _glow.value,
                                  ),
                                  Shadow(
                                    color: const Color(0xFFC89B3C)
                                        .withOpacity(0.50),
                                    blurRadius: _glow.value * 2.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ── Divider inferior ──────────────────────────────────
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
                Color(0xFFC89B3C),
                Color(0xFFFFE8B6),
                Color(0xFFC89B3C),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Hoja ──────────────────────────────────────────────────────────────────────
class _LeafPainter extends CustomPainter {
  final double sway;
  final double pulse;
  final double glow;

  const _LeafPainter({
    required this.sway,
    required this.pulse,
    required this.glow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final baseY = size.height * 0.88;
    final topY = size.height * 0.06;
    final wobX = sway * 16;

    // Halo difuso exterior
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, (topY + baseY) / 2),
        width: 38 * pulse,
        height: 52 * pulse,
      ),
      Paint()
        ..color = const Color(0xFF8AB840).withOpacity(0.22)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glow * 0.6),
    );

    // Hoja principal (cuerpo)
    final leafPath = Path()
      ..moveTo(cx + wobX * 0.4, topY)
      ..cubicTo(
        cx + 22 * pulse + wobX,
        topY + (baseY - topY) * 0.35,
        cx + 24 * pulse,
        baseY * 0.82,
        cx,
        baseY * 0.90,
      )
      ..cubicTo(
        cx - 24 * pulse,
        baseY * 0.82,
        cx - 22 * pulse + wobX,
        topY + (baseY - topY) * 0.35,
        cx + wobX * 0.4,
        topY,
      )
      ..close();

    // Sombra difusa de la hoja
    canvas.drawPath(
      leafPath,
      Paint()
        ..color = const Color(0xFF4A7A18).withOpacity(0.35)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8),
    );

    // Cuerpo con gradiente simulado por capas
    final layers = [
      _LeafLayer(color: const Color(0xFF4A7A18), opacity: 1.0),
      _LeafLayer(color: const Color(0xFF7AB030), opacity: 0.85),
      _LeafLayer(color: const Color(0xFFAAD060), opacity: 0.55),
      _LeafLayer(color: const Color(0xFFD4E8A0), opacity: 0.25),
    ];

    for (final layer in layers) {
      canvas.drawPath(
        leafPath,
        Paint()..color = layer.color.withOpacity(layer.opacity),
      );
    }

    // Nervio central
    final nervePaint = Paint()
      ..color = const Color(0xFFFFE8B6).withOpacity(0.55)
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(cx + wobX * 0.4, topY + 2),
      Offset(cx, baseY * 0.88),
      nervePaint,
    );

    // Nervios secundarios
    final veinPaint = Paint()
      ..color = const Color(0xFFFFE8B6).withOpacity(0.30)
      ..strokeWidth = 0.8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final midY = (topY + baseY) / 2;
    final veins = [
      [cx, midY - 14, cx - 18 * pulse, midY - 4],
      [cx, midY - 14, cx + 18 * pulse, midY - 4],
      [cx, midY + 2, cx - 16 * pulse, midY + 12],
      [cx, midY + 2, cx + 16 * pulse, midY + 12],
    ];
    for (final v in veins) {
      canvas.drawLine(Offset(v[0], v[1]), Offset(v[2], v[3]), veinPaint);
    }

    // Base circular (tallo)
    canvas.drawCircle(
      Offset(cx, baseY),
      6 * pulse,
      Paint()
        ..color = const Color(0xFFC89B3C).withOpacity(0.65)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    canvas.drawCircle(
      Offset(cx, baseY),
      3.5 * pulse,
      Paint()..color = const Color(0xFFFFE8B6).withOpacity(0.90),
    );
  }

  @override
  bool shouldRepaint(_LeafPainter old) =>
      old.sway != sway || old.pulse != pulse || old.glow != glow;
}

class _LeafLayer {
  final Color color;
  final double opacity;
  const _LeafLayer({required this.color, required this.opacity});
}

// ── Rayos de luz ──────────────────────────────────────────────────────────────
class _BeamsPainter extends CustomPainter {
  final double opacity;
  const _BeamsPainter({required this.opacity});

  static const _beams = [
    (frac: 0.30, angle: -0.28, alpha: 1.0),
    (frac: 0.52, angle: -0.16, alpha: 0.55),
    (frac: 0.70, angle: -0.08, alpha: 0.28),
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
            const Color(0xFFFFE8B6).withOpacity(opacity * b.alpha),
            const Color(0xFFC89B3C).withOpacity(opacity * 0.5 * b.alpha),
            Colors.transparent,
          ],
        ).createShader(Rect.fromLTWH(cx - 1.5, 0, 3, size.height));

      canvas.save();
      canvas.translate(cx, size.height * 0.5);
      canvas.rotate(b.angle);
      canvas.drawRect(
        Rect.fromLTWH(-1.5, -size.height * 0.9, 3, size.height * 1.8),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_BeamsPainter old) => old.opacity != opacity;
}

// ── Partículas de tierra ──────────────────────────────────────────────────────
class _EarthParticle {
  final double x;
  final double size;
  final double speed;
  final Color color;
  final double offset;
  final double wobble;

  const _EarthParticle({
    required this.x,
    required this.size,
    required this.speed,
    required this.color,
    required this.offset,
    required this.wobble,
  });
}

class _EarthParticlePainter extends CustomPainter {
  final List<_EarthParticle> particles;
  final double progress;

  const _EarthParticlePainter({
    required this.particles,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final t = (progress * p.speed + p.offset) % 1.0;
      final y = size.height * (1.0 - t * 0.85);
      final dx = math.sin(t * math.pi * 2.5 + p.wobble) * 12;
      final opacity = t < 0.14
          ? t / 0.14
          : t > 0.70
              ? 1 - (t - 0.70) / 0.30
              : 1.0;

      canvas.drawCircle(
        Offset(p.x * size.width + dx, y),
        p.size * 0.5,
        Paint()
          ..color = p.color.withOpacity(opacity * 0.65)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, p.size * 0.55),
      );
    }
  }

  @override
  bool shouldRepaint(_EarthParticlePainter old) => old.progress != progress;
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
Ynes Mexia was a scientist who loved nature deeply. She was very curious about plants and had a brave heart. Because of her love for the natural world and her adventurous spirit, she became one of the most successful botanists of her time.

She was born on May 24, 1870, in Washington, D.C. Her father was a Mexican diplomat, and her mother was American, so Ynes had both nationalities. She didn’t start her career until she was older—only in the last 13 years of her life—but she did amazing work in that short time. She traveled across the Americas, often by herself, and collected thousands of plants. With them, she created a big and important herbarium. People admired her not only for the number of plants she found but also for the long and difficult trips she made. The Encyclopedia Britannica says that her discoveries helped complete many plant records. Ynes Mexia died at the age of 68, on July 12, 1938.

Ynes’s life was not easy. When she was just three years old, her parents separated. She stayed with her mother, and her father went back to Mexico. Over the next ten years, she moved a lot and studied in different private schools. These changes helped her get a good education. She was a quiet girl who liked reading, writing, and exploring nature around her home. This was mentioned in Madroño, a magazine from the California Botanical Society.

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
        'What does the word "important" most likely mean in this sentence from the text?\n\n*“With them, she created a big and important herbarium.”*',
    options: ["A) Pequeño", "B) Irrelevante", "C) Importante", "D) Ligero"],
    correctIndex: 2,
    explanation:
        '“Important” and “importante” are cognates in English and Spanish—they look and mean the same.',
    incorrectExplanations: [
      '"Pequeño" means small, which is the opposite of "important."',
      '"Irrelevante" means irrelevant, which doesn’t match the meaning.',
      'Correct answer!',
      '"Ligero" means light, which doesn’t fit the context.',
    ],
  ),
  QuestionData(
    question:
        'What does the word "hopeless" most likely mean in the sentence below?\n\n*“Ynes’s life was not easy… but she never felt hopeless.”*',
    options: [
      "A) Full of hope",
      "B) Without hope",
      "C) Feeling lucky",
      "D) Full of success"
    ],
    correctIndex: 1,
    explanation:
        'The suffix “-less” means “without,” so “hopeless” means without hope.',
    incorrectExplanations: [
      '"Full of hope" is the opposite.',
      'Correct answer!',
      '"Feeling lucky" doesn’t relate.',
      '"Full of success" is unrelated.',
    ],
  ),
  QuestionData(
    question:
        'What does the word "brave" most likely mean in the sentence below?\n\n*“She was very curious about plants and had a brave heart.”*',
    options: [
      "A) Afraid",
      "B) Tired",
      "C) Strong and not afraid",
      "D) Quiet and shy"
    ],
    correctIndex: 2,
    explanation:
        'Context clues show she traveled alone and faced danger, meaning brave = not afraid.',
    incorrectExplanations: [
      '"Afraid" is the opposite.',
      '"Tired" doesn’t mean brave.',
      'Correct answer!',
      '"Quiet and shy" contrasts bravery.',
    ],
  ),
];

// ================================
// 📘 QUESTION PAGE
// ================================
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

  static const Color accentDark = Color(0xFFFF8F00);
  static const Color cardBg = Color(0xFFFFFDE7);

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
        spans.add(
          TextSpan(
            text: text.substring(lastEnd, match.start),
            style: baseStyle,
          ),
        );
      }

      spans.add(
        TextSpan(
          text: match.group(1),
          style: baseStyle.copyWith(fontStyle: FontStyle.italic),
        ),
      );

      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastEnd),
          style: baseStyle,
        ),
      );
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
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFE082),
                  Color(0xFF80CBC4),
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
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF3C417),
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
                              color: Colors.black,
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
In 1887, at age 17, she went to Mexico City to help her sick father. He had a small business selling pets and birds. Ten years later, in 1897, she married a local man named Herman de Laue. She continued taking care of her father until he died. In 1904, her husband also passed away, as mentioned in The Glinda Factor, a blog about American women in history.

After some time alone, Ynes married again. Her second husband was one of her workers, Agustín Reygados. But this marriage was very difficult. He made bad decisions with money and lost her land. After so many personal problems, Ynes became sick—both mentally and physically. She got divorced and returned to the United States. She was 38 years old, with no job or family. But she didn’t give up. She moved to San Francisco to start over. Early Women in Science says she found a job as a social worker and got the medical help she needed.

In California, Ynes joined a hiking group called the Sierra Club. She loved their long walks and spent more and more time outdoors. She was amazed by the forests and the plants. When she saw the tall redwood trees, she felt the need to protect nature. She joined the movement to create and take care of national parks.

The more she walked in nature, the more she wanted to learn about plants. So, in 1921, when she was 51 years old, she started studying Natural Sciences at the University of California in Berkeley. Most students were much younger, and it was unusual at that time for a woman—especially one with mixed heritage—to study science. But Ynes didn’t let that stop her. She entered the classroom with confidence and stayed focused on her goal.
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
        'What does the word "physically" most likely mean in the sentence below?\n\n*“Ynes became sick—both mentally and physically.”*',
    options: [
      "A) Físicamente",
      "B) Rápidamente",
      "C) Mentalmente",
      "D) Perfectamente"
    ],
    correctIndex: 0,
    explanation:
        ' “Physically” and “físicamente” are cognates—they look alike and mean the same in English and Spanish.',
    incorrectExplanations: [
      ' Correct answer!',
      ' "Rápidamente" means quickly, not related to physical health.',
      ' "Mentalmente" refers to the mind, not the body.',
      ' "Perfectamente" means perfectly, which doesn’t match the context of being sick.',
    ],
  ),
  QuestionData(
    question:
        'What does the word "unusual" most likely mean in the sentence below?\n\n*“It was unusual at that time for a woman—especially one with mixed heritage—to study science.”*',
    options: ["A) Normal", "B) Expected", "C) Not common", "D) Scientific"],
    correctIndex: 2,
    explanation:
        ' The prefix “un-” means “not.” So “unusual” means “not usual” or “not common.”',
    incorrectExplanations: [
      ' "Normal" is the opposite of "unusual."',
      ' "Expected" is incorrect since "unusual" suggests the opposite.',
      ' Correct answer!',
      ' "Scientific" is unrelated to the idea of how common something is.',
    ],
  ),
  QuestionData(
    question:
        'What does the word "confident" most likely mean in the sentence below?\n\n*“She entered the classroom with confidence and stayed focused on her goal.”*',
    options: [
      "A) Fear about her teacher",
      "B) Doubt about the class",
      "C) Confusion",
      "D) Belief in herself"
    ],
    correctIndex: 3,
    explanation:
        ' The phrase “stayed focused on her goal” suggests she was sure of herself. The context tells us “confidence” means believing in herself.',
    incorrectExplanations: [
      ' "Fear about her teacher" is the opposite of confidence.',
      ' "Doubt about the class" doesn’t match the confident tone.',
      ' "Confusion" is not supported by the context.',
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

  static const Color accentDark = Color(0xFFFF8F00);
  static const Color cardBg = Color(0xFFFFFDE7);

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
        spans.add(
          TextSpan(
            text: text.substring(lastEnd, match.start),
            style: baseStyle,
          ),
        );
      }

      spans.add(
        TextSpan(
          text: match.group(1),
          style: baseStyle.copyWith(fontStyle: FontStyle.italic),
        ),
      );

      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastEnd),
          style: baseStyle,
        ),
      );
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
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFE082),
                  Color(0xFF80CBC4),
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
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF3C417),
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
                              color: Colors.black,
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
She studied for 16 years, although she never finished her degree. For Ynes, the important thing was not the diploma—it was learning more about botany. The blog Latino Natural History says it clearly: “Ynes Mexia’s life is a great example of how it is never too late to discover your passion.”

During her studies, she also took summer classes at the California Academy of Sciences. There, she met Alice Eastwood, a famous botanist. Eastwood organized trips to the mountains and the coast, where she taught students how to collect and protect plants for research.

Alice Eastwood became Ynes’s friend and mentor. She taught her that working with plants takes patience and care. Ynes learned to take the plants from the ground without damaging the roots, leaves, flowers, or fruits. She practiced pressing the plants between special paper to dry them. She also took pictures and wrote careful notes about where and when she found each specimen.

With Eastwood’s help, Ynes saw that properly collected plants could last for many years—even forever. Later, Ynes became an expert in working in wet forests and keeping plants safe.
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
        'What does the word "example" most likely mean in this sentence?\n\n*“Ynes Mexia’s life is a great example of how it is never too late to discover your passion.”*',
    options: ["A) Lección", "B) Ejemplo", "C) Escuela", "D) Estilo"],
    correctIndex: 1,
    explanation:
        ' “Example” and “ejemplo” are cognates—they look and mean the same in English and Spanish.',
    incorrectExplanations: [
      ' "Lección" means lesson, not example.',
      ' Correct answer!',
      ' "Escuela" means school, which is not the correct meaning.',
      ' "Estilo" means style, which is unrelated here.',
    ],
  ),
  QuestionData(
    question:
        'What does the word "discover" most likely mean in the sentence below?\n\n*“Ynes Mexia’s life is a great example of how it is never too late to discover your passion.”*',
    options: [
      "A) To hide something",
      "B) To cover something again",
      "C) To forget something",
      "D) To find something for the first time"
    ],
    correctIndex: 3,
    explanation:
        ' The prefix “dis-” means “not” or “opposite of.” So “discover” means to uncover or to find something that was hidden.',
    incorrectExplanations: [
      ' "To hide something" is the opposite of discovering.',
      ' "To cover something again" is not relevant here.',
      ' "To forget something" has no connection to discovering.',
      ' Correct answer!',
    ],
  ),
  QuestionData(
    question:
        'What does the word "specimen" most likely mean in the sentence below?\n\n*“She found each specimen and wrote notes about where and when she found it.”*',
    options: [
      "A) A rare photo",
      "B) A plant she collected",
      "C) A broken tool",
      "D) A classroom"
    ],
    correctIndex: 1,
    explanation:
        ' The sentence gives context: she “found it,” took notes, and she worked with plants. So “specimen” means a plant sample she studied.',
    incorrectExplanations: [
      ' A photo doesn’t match the context of collecting and taking notes.',
      ' Correct answer!',
      ' A tool is not referenced or implied here.',
      ' A classroom is not something she collected.',
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

  static const Color accentDark = Color(0xFFFF8F00);
  static const Color cardBg = Color(0xFFFFFDE7);

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
        spans.add(
          TextSpan(
            text: text.substring(lastEnd, match.start),
            style: baseStyle,
          ),
        );
      }

      spans.add(
        TextSpan(
          text: match.group(1),
          style: baseStyle.copyWith(fontStyle: FontStyle.italic),
        ),
      );

      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastEnd),
          style: baseStyle,
        ),
      );
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
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFE082),
                  Color(0xFF80CBC4),
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
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF3C417),
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
                              color: Colors.black,
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
By 1925, Ynes was ready to plan her own trips. She no longer needed to go with university groups. Since she spoke Spanish well, she decided to travel through Latin America on her own. The Glinda Factor explains how she planned a big trip to Mexico. She made a map, created a travel plan, and decided to go by train and boat. She also planned to stay in small villages, set up base camps, and hire local guides to help her explore the mountains. Every day, she would collect plants, and every afternoon, she would dry and organize them. She even made a list of all the tools she needed.

But a trip like that needed money. So, Ynes wrote to other botanists and offered to send them plants in exchange for support. Her plan worked. On a sunny day in September 1926, she arrived in Sinaloa, on the west coast of Mexico, full of energy and excitement. She finally began the adventure she had dreamed of, as Early Women in Science tells us. From that day on, Ynes worked as an independent scientist. She explored wild places and shared her discoveries with the world.

At a time when women were strongly discouraged from traveling alone without the “protection” of a man, Ynes Mexia boldly explored from the far north of Alaska to the southern tip of South America. Just like in her university classes, she showed a strong personality and rejected the stereotypes of her time. Her level of independence was remarkable—especially since, in the early 20th century, married women couldn’t even get a passport without their husband's permission
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
        'What does the word "mountains" most likely mean in this sentence?\n\n*“She explored wild places and shared her discoveries with the world, including the mountains of Latin America.”*',
    options: ["A) Montañas", "B) Bosques", "C) Mar", "D) Ciudades"],
    correctIndex: 0,
    explanation:
        ' “Mountains” and “montañas” are cognates—they look and mean the same in both English and Spanish.',
    incorrectExplanations: [
      ' Correct answer!',
      ' "Bosques" means forests, not mountains.',
      ' "Mar" means sea, which is unrelated here.',
      ' "Ciudades" means cities, not mountains.',
    ],
  ),
  QuestionData(
    question:
        'What does the word "boldly" most likely mean in the sentence below?\n\n*“…Ynes Mexia boldly explored from the far north of Alaska to the southern tip of South America.”*',
    options: [
      "A) In a weak way",
      "B) In a quiet way",
      "C) In a silent way",
      "D) In a courageous way"
    ],
    correctIndex: 3,
    explanation:
        ' The suffix “-ly” turns the word "bold" into an adverb, meaning in a brave manner or in a courageous way. ',
    incorrectExplanations: [
      ' "In a weak way" is the opposite of boldly.',
      ' "In a quiet way" does not fit the tone of exploration.',
      ' "In a silent way" doesn’t match the bold nature of exploring.',
      ' Correct answer!',
    ],
  ),
  QuestionData(
    question:
        'What does the word "husband" most likely mean in the sentence below?\n\n*“In the early 20th century, married women couldn’t even get a passport without their husband’s permission.”*',
    options: [
      "A) A male friend",
      "B) Male partner in marriage",
      "C) A family member",
      "D) A cousin"
    ],
    correctIndex: 1,
    explanation:
        ' The context tells us that a “husband” is the male partner in marriage, someone who had legal authority over his wife actions during that time. ',
    incorrectExplanations: [
      ' A male friend is not someone who would have legal authority.',
      ' Correct answer!',
      ' "Family member" is too vague and not accurate here.',
      ' A cousin wouldn’t have this legal role.',
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

  static const Color accentDark = Color(0xFFFF8F00);
  static const Color cardBg = Color(0xFFFFFDE7);

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
        spans.add(
          TextSpan(
            text: text.substring(lastEnd, match.start),
            style: baseStyle,
          ),
        );
      }

      spans.add(
        TextSpan(
          text: match.group(1),
          style: baseStyle.copyWith(fontStyle: FontStyle.italic),
        ),
      );

      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastEnd),
          style: baseStyle,
        ),
      );
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
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFE082),
                  Color(0xFF80CBC4),
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
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF3C417),
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
                              color: Colors.black,
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