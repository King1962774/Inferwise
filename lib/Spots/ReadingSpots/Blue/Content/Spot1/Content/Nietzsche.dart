import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Blue/Content/Spot1/Spot_Page/ReadingSpot.dart';
import 'dart:math' as math;

class NietzcheSplashScreen extends StatefulWidget {
  const NietzcheSplashScreen({super.key});

  @override
  State<NietzcheSplashScreen> createState() => _NietzcheSplashScreenState();
}

class _NietzcheSplashScreenState extends State<NietzcheSplashScreen>
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
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scaleUp = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Nietzsche()), // ← Nietzsche()
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
                  ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF4A2000),
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      'assets/Items/f.png',
                      width: 100,
                      height: 115,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Nietzsche\nHis Life and Works",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E1200),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "By Anthony M. Ludovici, 1914",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF5C3000),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "From The Project Gutenberg",
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

class Nietzsche extends StatefulWidget {
  const Nietzsche({super.key});
  @override
  State<Nietzsche> createState() => _NietzscheState();
}

class _NietzscheState extends State<Nietzsche> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What does a philosopher often question?",
      "options": [
        "A) Everyday routines",
        "B) Beliefs and assumptions",
        "C) Sports results",
        "D) Fashion choices"
      ],
      "correct": 1,
      "feedback": [
        " Philosophers go beyond just observing routines.",
        " Correct! Philosophers challenge what we often take for granted.",
        " Sports results are not usually philosophical topics.",
        " Fashion is not a primary concern in philosophy."
      ]
    },
    {
      "question": "What kind of writing is common in philosophy?",
      "options": [
        "A) Poetry",
        "B) Novels",
        "C) Essays and arguments",
        "D) Comics"
      ],
      "correct": 2,
      "feedback": [
        " Poetry is more common in literature.",
        " Novels are more related to fiction writing.",
        " Correct! Philosophers usually express ideas through logical essays and arguments.",
        " Comics are a visual medium, not typical in philosophical discourse."
      ]
    },
    {
      "question": "Which of the following might a philosopher ask?",
      "options": [
        "A) How do plants grow?",
        "B) What is the meaning of life?",
        "C) How do I fix a bike?",
        "D) What’s for dinner?"
      ],
      "correct": 1,
      "feedback": [
        " That's a biological question, not philosophical.",
        " Correct! Philosophers ask big, fundamental questions about existence.",
        " That's a practical question, not a philosophical one.",
        " That’s a daily life question, not a philosophical inquiry."
      ]
    },
    {
      "question": "What might inspire someone to become a philosopher today?",
      "options": [
        "A) A desire to win arguments",
        "B) Curiosity about the world and human experience",
        "C) A love of money",
        "D) Strong political views"
      ],
      "correct": 1,
      "feedback": [
        " Philosophy isn't just about arguing to win.",
        " Correct! Many philosophers start with a deep curiosity about life’s questions.",
        " Philosophy is not typically motivated by financial gain.",
        " While political views can inspire thought, philosophy is broader than politics."
      ]
    },
    {
      "question": "How does philosophy differ from science?",
      "options": [
        "A) Philosophy focuses on meaning, values, and reasoning",
        "B) Philosophy avoids asking questions and lectures",
        "C) Philosophy uses experiments and writes articles",
        "D) Philosophy is only about religion"
      ],
      "correct": 0,
      "feedback": [
        " Correct! Unlike science, philosophy explores abstract questions like morality, identity, and purpose.",
        " Philosophy encourages questions—it’s central to the discipline.",
        " Experiments are more characteristic of science.",
        " Philosophy includes religion but is not limited to it."
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
          MaterialPageRoute(builder: (_) => const NietzscheReadingAnimation()),
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
class NietzscheReadingAnimation extends StatefulWidget {
  const NietzscheReadingAnimation({super.key});

  @override
  State<NietzscheReadingAnimation> createState() =>
      _NietzscheReadingAnimationState();
}

class _NietzscheReadingAnimationState extends State<NietzscheReadingAnimation>
    with TickerProviderStateMixin {
  // ── Controllers — todos declarados como campos late final ─────────────────
  late final AnimationController _entryCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _bgCtrl;
  late final AnimationController _flameCtrl;
  late final AnimationController _flamePulseCtrl; // separado, no anónimo
  late final AnimationController _particleCtrl;
  late final AnimationController _beamsCtrl;

  // ── Animations ───────────────────────────────────────────────────────────
  late final Animation<double> _textFade;
  late final Animation<double> _textSlide;
  late final Animation<double> _dividerWidth;
  late final Animation<double> _iconFade;
  late final Animation<double> _glow;
  late final Animation<Color?> _bgColor1;
  late final Animation<Color?> _bgColor2;
  late final Animation<double> _flameFlicker;
  late final Animation<double> _flamePulse;
  late final Animation<double> _beamsOpacity;

  // ── Partículas de fuego ───────────────────────────────────────────────────
  final List<_FireParticle> _particles = [];
  final math.Random _rng = math.Random();

  static const _fireColors = [
    Color(0xFFFFF0C0),
    Color(0xFFFFB347),
    Color(0xFFFF6600),
    Color(0xFFCC3300),
    Color(0xFF8B1A00),
  ];

  @override
  void initState() {
    super.initState();
    _spawnParticles();

    // ── Entry ───────────────────────────────────────────────────────────────
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

    // ── Glow pulsante ────────────────────────────────────────────────────────
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);
    _glow = Tween<double>(begin: 8, end: 28).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );

    // ── Background shimmer ───────────────────────────────────────────────────
    _bgCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat(reverse: true);
    _bgColor1 = ColorTween(
      begin: const Color(0xFF1C0F0A),
      end: const Color(0xFF2A1505),
    ).animate(_bgCtrl);
    _bgColor2 = ColorTween(
      begin: const Color(0xFFD4AF37),
      end: const Color(0xFFFF8C42),
    ).animate(_bgCtrl);

    // ── Llama: flicker rápido ────────────────────────────────────────────────
    _flameCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..repeat(reverse: true);
    _flameFlicker = Tween<double>(begin: -0.06, end: 0.06).animate(
      CurvedAnimation(parent: _flameCtrl, curve: Curves.easeInOut),
    );

    // ── Llama: pulso lento (controller propio, NO anónimo) ───────────────────
    _flamePulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _flamePulse = Tween<double>(begin: 0.88, end: 1.12).animate(
      CurvedAnimation(parent: _flamePulseCtrl, curve: Curves.easeInOut),
    );

    // ── Partículas ───────────────────────────────────────────────────────────
    _particleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    // ── Rayos de luz ─────────────────────────────────────────────────────────
    _beamsCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _beamsOpacity = Tween<double>(begin: 0.05, end: 0.18).animate(
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
    for (int i = 0; i < 28; i++) {
      _particles.add(_FireParticle(
        x: _rng.nextDouble(),
        size: 2.0 + _rng.nextDouble() * 4.5,
        speed: 0.5 + _rng.nextDouble() * 1.6,
        color: _fireColors[_rng.nextInt(_fireColors.length)],
        offset: _rng.nextDouble(),
      ));
    }
  }

  @override
  void dispose() {
    // Todos los controllers dispuestos — sin leaks
    _entryCtrl.dispose();
    _glowCtrl.dispose();
    _bgCtrl.dispose();
    _flameCtrl.dispose();
    _flamePulseCtrl.dispose();
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
          _flameCtrl,
          _flamePulseCtrl,
          _particleCtrl,
          _beamsCtrl,
          _entryCtrl,
        ]),
        builder: (context, _) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // ── Fondo filosófico animado ──────────────────────────────────
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _bgColor1.value ?? const Color(0xFF1C0F0A),
                      const Color(0xFF3A1F0B),
                      const Color(0xFF8B5A2B),
                      _bgColor2.value ?? const Color(0xFFD4AF37),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              // ── Halo naranja-fuego ────────────────────────────────────────
              Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(-0.15, -0.35),
                    radius: 1.05,
                    colors: [
                      Colors.deepOrangeAccent.withOpacity(0.18),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // ── Vignette oscura ───────────────────────────────────────────
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.18,
                    colors: [
                      Colors.transparent,
                      const Color(0xFF0D0700).withOpacity(0.70),
                    ],
                  ),
                ),
              ),

              // ── Rayos de luz ──────────────────────────────────────────────
              CustomPaint(
                painter: _BeamsPainter(opacity: _beamsOpacity.value),
              ),

              // ── Partículas de fuego ───────────────────────────────────────
              CustomPaint(
                painter: _FireParticlePainter(
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
                        // 🔥 Llama animada
                        FadeTransition(
                          opacity: _iconFade,
                          child: CustomPaint(
                            size: const Size(72, 84),
                            painter: _FlamePainter(
                              flicker: _flameFlicker.value,
                              pulse: _flamePulse.value,
                              glow: _glow.value,
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
                              'Dare to think beyond limits.\nStrength is born from self-overcoming.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Cinzel',
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFFFF0E0),
                                height: 1.5,
                                letterSpacing: 0.4,
                                shadows: [
                                  Shadow(
                                    color: Colors.deepOrangeAccent
                                        .withOpacity(0.9),
                                    blurRadius: _glow.value,
                                  ),
                                  Shadow(
                                    color: const Color(0xFFCC3300)
                                        .withOpacity(0.55),
                                    blurRadius: _glow.value * 2.2,
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
                Color(0xFFE05A00),
                Color(0xFFFF8C42),
                Color(0xFFE05A00),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Llama ─────────────────────────────────────────────────────────────────────
class _FlamePainter extends CustomPainter {
  final double flicker;
  final double pulse;
  final double glow;

  const _FlamePainter({
    required this.flicker,
    required this.pulse,
    required this.glow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final baseY = size.height * 0.88;

    // Halo difuso exterior
    canvas.drawCircle(
      Offset(cx, baseY * 0.72),
      28 * pulse,
      Paint()
        ..color = const Color(0xFFFF4400).withOpacity(0.28)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glow * 0.7),
    );

    // Capas de la llama (de afuera hacia adentro)
    final layers = [
      _FlameLayer(
        radiusX: 20 * pulse,
        topY: size.height * 0.10,
        baseY: baseY,
        color: const Color(0xFF8B1A00).withOpacity(0.8),
        glowBlur: glow * 0.5,
      ),
      _FlameLayer(
        radiusX: 15 * pulse,
        topY: size.height * 0.16,
        baseY: baseY,
        color: const Color(0xFFCC3300).withOpacity(0.9),
        glowBlur: glow * 0.4,
      ),
      _FlameLayer(
        radiusX: 11 * pulse,
        topY: size.height * 0.24,
        baseY: baseY,
        color: const Color(0xFFFF6600),
        glowBlur: glow * 0.3,
      ),
      _FlameLayer(
        radiusX: 7 * pulse,
        topY: size.height * 0.34,
        baseY: baseY,
        color: const Color(0xFFFFB347),
        glowBlur: glow * 0.2,
      ),
      _FlameLayer(
        radiusX: 4 * pulse,
        topY: size.height * 0.44,
        baseY: baseY,
        color: const Color(0xFFFFF0C0),
        glowBlur: glow * 0.1,
      ),
    ];

    for (final layer in layers) {
      final wob = flicker * layer.radiusX * 1.5;
      final path = Path()
        ..moveTo(cx + wob, layer.topY)
        ..cubicTo(
          cx + layer.radiusX + wob,
          layer.topY + (layer.baseY - layer.topY) * 0.4,
          cx + layer.radiusX * 1.1,
          layer.baseY * 0.9,
          cx,
          layer.baseY,
        )
        ..cubicTo(
          cx - layer.radiusX * 1.1,
          layer.baseY * 0.9,
          cx - layer.radiusX + wob,
          layer.topY + (layer.baseY - layer.topY) * 0.4,
          cx + wob,
          layer.topY,
        )
        ..close();

      canvas.drawPath(
        path,
        Paint()
          ..color = layer.color
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, layer.glowBlur),
      );
      canvas.drawPath(path, Paint()..color = layer.color);
    }

    // Base circular (mecha)
    canvas.drawCircle(
      Offset(cx, baseY),
      8 * pulse,
      Paint()
        ..color = const Color(0xFFFF6600).withOpacity(0.7)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4),
    );
    canvas.drawCircle(
      Offset(cx, baseY),
      5 * pulse,
      Paint()..color = const Color(0xFFFFF0C0).withOpacity(0.9),
    );
  }

  @override
  bool shouldRepaint(_FlamePainter old) =>
      old.flicker != flicker || old.pulse != pulse || old.glow != glow;
}

class _FlameLayer {
  final double radiusX;
  final double topY;
  final double baseY;
  final Color color;
  final double glowBlur;

  const _FlameLayer({
    required this.radiusX,
    required this.topY,
    required this.baseY,
    required this.color,
    required this.glowBlur,
  });
}

// ── Rayos de luz ──────────────────────────────────────────────────────────────
class _BeamsPainter extends CustomPainter {
  final double opacity;
  const _BeamsPainter({required this.opacity});

  static const _beams = [
    (frac: 0.25, angle: -0.30, alpha: 1.0),
    (frac: 0.50, angle: -0.18, alpha: 0.60),
    (frac: 0.72, angle: -0.10, alpha: 0.30),
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
            const Color(0xFFFF8C42).withOpacity(opacity * b.alpha),
            const Color(0xFFE05A00).withOpacity(opacity * 0.5 * b.alpha),
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

// ── Partículas de fuego ───────────────────────────────────────────────────────
class _FireParticle {
  final double x;
  final double size;
  final double speed;
  final Color color;
  final double offset;

  const _FireParticle({
    required this.x,
    required this.size,
    required this.speed,
    required this.color,
    required this.offset,
  });
}

class _FireParticlePainter extends CustomPainter {
  final List<_FireParticle> particles;
  final double progress;

  const _FireParticlePainter({
    required this.particles,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final t = (progress * p.speed + p.offset) % 1.0;
      final y = size.height * (1.0 - t * 0.88);
      final dx = math.sin(t * math.pi * 3 + p.offset * 5) * 14;
      final opacity = t < 0.12
          ? t / 0.12
          : t > 0.72
              ? 1 - (t - 0.72) / 0.28
              : 1.0;

      canvas.drawCircle(
        Offset(p.x * size.width + dx, y),
        p.size * 0.5,
        Paint()
          ..color = p.color.withOpacity(opacity * 0.70)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, p.size * 0.55),
      );
    }
  }

  @override
  bool shouldRepaint(_FireParticlePainter old) => old.progress != progress;
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
“May your name be honored by all future generations! In the name of all your friends, I, your student, give you our warmest thanks for your great life.

“You were one of the noblest and purest men who ever lived on this earth.

“Although both your friends and enemies know this, I still think it is important to say it clearly at your grave. We know how the world treats great thinkers. We know what happened to Spinoza. And the same could happen to your memory. So I say these final words: Peace to your ashes!”

These words were spoken by Peter Gast, Nietzsche’s closest friend and follower, at Nietzsche’s grave in August 1900. His message shows the deep love and respect that Nietzsche’s followers had for him. But at the same time, there were also many people who strongly disagreed with Nietzsche’s ideas. His critics believed that his work was harmful, dangerous, and even ridiculous.

Today, Nietzsche is still a powerful influence. His ideas are becoming more important every year. No matter what your profession is, it is important to understand what he believed in and decide whether you agree with his ideas or not. If you study Nietzsche’s life and work, you will see that people have called him many different names. One of the challenges when talking about Nietzsche is deciding what to call him and how to describe his ideas.

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
        'What does the word “followers” most likely mean in the sentence below?\n\n*“Nietzsche’s followers had deep love and respect for him.”*',
    options: [
      "A) People who lead him",
      "B) People who walk behind him",
      "C) People who support him",
      "D) People who ignore him"
    ],
    correctIndex: 2,
    explanation:
        '✔️ Explanation: The word “followers” has the suffix “-er”, which means “a person who does something.” So a follower is someone who follows, or supports, a leader or belief.',
    incorrectExplanations: [
      ' People who lead him is the opposite of a follower.',
      ' Walking behind someone doesn’t imply support or following beliefs.',
      ' Correct answer!',
      ' Ignoring someone shows no support, which contradicts the sentence.',
    ],
  ),
  QuestionData(
    question:
        'What does the word “clearly” most likely mean in the sentence below?\n\n*“…I still think it is important to say it clearly at your grave.”*',
    options: [
      "A) In a loud way",
      "B) In a confusing way",
      "C) In a kind way",
      "D) In an easy-to-understand way"
    ],
    correctIndex: 3,
    explanation:
        '✔️ Explanation: The suffix “-ly” turns the adjective “clear” into the adverb “clearly,” which means in an easy-to-understand way.',
    incorrectExplanations: [
      ' Loudness doesn’t imply clarity or understanding.',
      ' Confusion is the opposite of being clear.',
      ' Kindness is not the same as being clear.',
      ' Correct answer!',
    ],
  ),
  QuestionData(
    question:
        'What does the word “critic” most likely mean in the sentence below?\n\n*“His critics believed that his work was harmful, dangerous, and even ridiculous.”*',
    options: [
      "A) People who praised his work",
      "B) People who misunderstood him",
      "C) People who judged his ideas",
      "D) People who copied his work"
    ],
    correctIndex: 2,
    explanation:
        '✔️ Explanation: The context says “his critics believed that his work was harmful…” This shows us they disagreed with Nietzsche’s ideas, so “critics” means people who judge or oppose something.',
    incorrectExplanations: [
      ' Praising someone’s work is not criticism.',
      ' Misunderstanding is not the same as judging or opposing.',
      ' Correct answer!',
      ' Copying doesn’t imply judging or disapproval.',
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
Some people say he wasn’t a real philosopher. Others think he was just an anarchist. Many believe that his later books were simply shocking and strange, written to oppose everything that people usually accept.

To make so many people think differently about him, Nietzsche had to be both intelligent and powerful. He was both. There are few topics in philosophy that he didn’t write about. His ideas were strong and often destroyed traditional beliefs. He expressed them clearly and with great force, which is why many defenders of old ideas now see him as someone who disturbed their peace. However, even through the noise and chaos of his writing, you can see that he had a clear method and purpose. He was not just writing randomly—his goal was clear and serious.

Throughout his life, even though his opinions often changed, Nietzsche always stayed true to one goal: to improve the human being. Even when his writing style seems difficult or confusing, you can still see this main idea in all of his work. He wanted to make people stronger and more worthy of the great past of humanity.

Even when he criticized English thinkers in The Genealogy of Morals, he was trying to protect the greatness of human beings. He said these thinkers lowered the value of humanity. They believed that historical events and ideas were only caused by accidents or by people simply adjusting to their environment, not by deep thought or strength.

Nietzsche also attacked the theory of evolution, especially the idea of the “struggle for existence.” He didn’t believe that just surviving was a good goal. He thought that people should aim for something greater. Again, he did this because he wanted to help people grow and have better values.
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
        'What does the word “philosophy” most likely mean in the sentence below?\n\n*“There are few topics in philosophy that he didn’t write about.”*',
    options: ["A) Science", "B) Love", "C) Study of ideas", "D) Government"],
    correctIndex: 2,
    explanation:
        '✔️ Explanation: “Philosophy” is a cognate, which means it looks and sounds similar in both English and Spanish (filosofía). It refers to the study of ideas, existence, and knowledge.',
    incorrectExplanations: [
      ' Science is a different field focused more on experiments and observation.',
      ' Love is a feeling, not the definition of philosophy.',
      ' Correct answer!',
      ' Government refers to political systems, not the study of ideas.',
    ],
  ),
  QuestionData(
    question:
        'What does the word “thinkers” most likely mean in the sentence below?\n\n*“Even when he criticized English thinkers in The Genealogy of Morals…”* ',
    options: [
      "A) People who refuse to think",
      "B) People who create art",
      "C) People who think deeply",
      "D) People who ignore ideas"
    ],
    correctIndex: 2,
    explanation:
        '✔️ Explanation: The word “thinkers” has the suffix “-er,” which means “a person who does something.” So a thinker is someone who thinks, especially in a deep or serious way.',
    incorrectExplanations: [
      ' Refusing to think is the opposite of a thinker.',
      ' Creating art is not necessarily related to deep thinking.',
      ' Correct answer!',
      ' Ignoring ideas contradicts the meaning of a thinker.',
    ],
  ),
  QuestionData(
    question:
        'What does the word “confusing” most likely mean in the sentence below?\n\n*“Even when his writing style seems difficult or confusing, you can still see this main idea in all of his work.”*',
    options: [
      "A) Easy to understand",
      "B) Hard to understand",
      "C) Very interesting",
      "D) Boring"
    ],
    correctIndex: 1,
    explanation:
        '✔️ Explanation: The word “confusing” is used together with “difficult,” which helps the reader understand it means hard to understand.',
    incorrectExplanations: [
      ' Easy to understand is the opposite of what “confusing” means.',
      ' Correct answer!',
      ' Interesting is not the same as confusing.',
      ' Boring refers to lack of interest, not difficulty in understanding.',
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
Whether or not you agree with Nietzsche’s way of writing or thinking, his goal was always noble. He never avoided the work he believed he had to do to reach it.

So, what exactly was Nietzsche? If we follow his own idea of what a philosopher should do, then he truly was one. He said that a philosopher should create new values, new rules, and new goals. And Nietzsche did exactly that. But if we follow the old-fashioned idea of a philosopher—someone who builds a clear system of ideas—then Nietzsche does not fit. He didn’t create a full system like traditional philosophers did.

Still, it’s fair to say that he was a true poet—not just someone who wrote poems, but a “poet” in the old Greek sense: a creator or maker. Today, people like that are very rare. Many small or bad poets have made us lose trust in true ones. Goethe may have been the last great example of this kind of person in modern Europe. Even when we think about famous men like Michelangelo, Leonardo da Vinci, or Galileo, we don’t always see how their creative thinking in science was also poetic. But it was.

Because of this, we should take Nietzsche’s ideas seriously—not in spite of his poetic style, but because of it. Sadly, today many people don’t do that. We have separated science from emotion and feeling. So when we see a thinker show strong emotions or passion, we often become suspicious.

It may seem strange that Nietzsche, who later attacked Christianity so strongly, came from a very religious family. His father, Karl Ludwig Nietzsche, was a Protestant clergyman. His grandfather was also a minister, and his grandmother came from a long line of religious people. On his mother’s side, things were similar. Her father was also a clergyman and a well-respected theologian.
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
        'What does the word “religious” most likely mean in the sentence below?\n\n*“It may seem strange that Nietzsche, who later attacked Christianity so strongly, came from a very religious family.”*',
    options: [
      "A) Connected to the arts",
      "B) Connected to science",
      "C) Connected to religion",
      "D) Full of energy"
    ],
    correctIndex: 2,
    explanation:
        '✔️ Explanation: The word “religious” is a cognate—it looks and sounds similar in Spanish (religioso) and means the same thing.',
    incorrectExplanations: [
      ' The arts are not related to religion in this context.',
      ' Science is different from religion and doesn’t fit the sentence.',
      ' Correct answer!',
      ' Full of energy doesn’t relate to religious beliefs or practices.',
    ],
  ),
  QuestionData(
    question:
        'What does the word “unclear” most likely mean in the sentence below?\n\n*“He didn’t create a full system like traditional philosophers did, so his ideas were often unclear.”*',
    options: ["A) Very clear", "B) Not clear", "C) New", "D) Popular"],
    correctIndex: 1,
    explanation:
        '✔️ Explanation: The prefix “un-” means “not.” So “unclear” means “not clear.”',
    incorrectExplanations: [
      ' Very clear is the opposite of unclear.',
      ' Correct answer!',
      ' New doesn’t relate to how understandable the ideas are.',
      ' Popular refers to how many people like something, not how clear it is.',
    ],
  ),
  QuestionData(
    question:
        'What does the word “clergyman” most likely mean in the sentence below?\n\n*“His father, Karl Ludwig Nietzsche, was a Protestant clergyman. His grandfather was also a minister, and his grandmother came from a long line of religious people.”*',
    options: [
      "A) A political leader",
      "B) A military leader",
      "C) A scientist leader",
      "D) A religious leader"
    ],
    correctIndex: 3,
    explanation:
        '✔️ Explanation: The sentence gives helpful context clues. It says his grandfather was a minister, and his family was religious. These clues tell us that a clergyman is someone connected to religion—specifically, a religious leader.',
    incorrectExplanations: [
      ' Political leaders are not related to religious roles.',
      ' A military leader doesn’t fit with the religious family context.',
      ' A scientist leader is unrelated to the idea of a minister or religion.',
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
But maybe it’s not so strange after all. Many great thinkers come from traditional, disciplined families. Generations of strict upbringing can help build the strength and willpower needed to make great changes in the world.

Friedrich Nietzsche was born on October 15, 1844, in Röcken near Lützen, in Saxony, Prussia. As a child, he was strong and active. According to his sister, Elisabeth Nietzsche, both he and his family were generally healthy. This is important to her because Nietzsche later died insane, and some people have claimed that his mental illness was inherited.

Nietzsche’s father died in 1849. The next year, the family moved to Naumburg. There, Nietzsche went to a preparatory school and then to the town’s Grammar School. As a boy, he liked playing military games and being alone. He would sit for hours listening to his grandmother talk about Napoleon. In 1858, Nietzsche received a six-year scholarship to study at Pforta, a very strict and famous school.

At Pforta, he followed the normal school program and worked very hard. His sister says that he stood out in his private studies and artistic projects. Even in regular school work, he did better than most students. While at Pforta, he also discovered the music of Richard Wagner, who would later have a huge influence on him.
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
        'What does the word “disciplined” most likely mean in the sentence below?\n\n*“Many great thinkers come from traditional, disciplined families.”*',
    options: [
      "A) Relaxed and fun",
      "B) Disorganized and chaotic",
      "C) Strict and organized",
      "D) Friendly and open"
    ],
    correctIndex: 2,
    explanation:
        '✔️ Explanation: The word “disciplined” looks and sounds like the Spanish word “disciplinado,” which means organized and controlled. It’s a cognate.',
    incorrectExplanations: [
      ' "Relaxed and fun" doesn’t match the meaning of “disciplined.”',
      ' "Disorganized and chaotic" is the opposite of being disciplined.',
      ' Correct answer!',
      ' "Friendly and open" doesn’t relate to structure or discipline.',
    ],
  ),
  QuestionData(
    question:
        'What does the word “insane” most likely mean in the sentence below?\n\n*“Nietzsche later died insane, and some people have claimed that his mental illness was inherited.”*',
    options: [
      "A) Very sane",
      "B) Before sane",
      "C) No sane",
      "D) State of being sane"
    ],
    correctIndex: 2,
    explanation:
        '✔️ Explanation: The prefix “in-” means “not.” So “insane” means “not sane” or mentally ill.',
    incorrectExplanations: [
      ' "Very sane" is the opposite of insane.',
      ' "Before sane" doesn’t make sense grammatically.',
      ' Correct answer!',
      ' "State of being sane" does not match the definition of “insane.”',
    ],
  ),
  QuestionData(
    question:
        'What does the word “huge” most likely mean in the sentence below?\n\n*“He also discovered the music of Richard Wagner, who would later have a huge influence on him.”*',
    options: [
      "A) A small effect",
      "B) A musical friend",
      "C) A happy memory",
      "D) A big impact"
    ],
    correctIndex: 3,
    explanation:
        '✔️ Explanation: The sentence says Wagner had an “influence” on Nietzsche. The word “huge” here means that the influence was very big, which we understand from the context.',
    incorrectExplanations: [
      ' "A small effect" is the opposite of “huge impact.”',
      ' "A musical friend" is not mentioned or implied.',
      ' "A happy memory" doesn’t relate to the idea of influence.',
      ' Correct answer!',
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