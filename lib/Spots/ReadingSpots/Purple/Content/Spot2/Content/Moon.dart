import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Purple/Content/Spot2/Spot_Page/Reading_Spot_Page.dart';
import 'dart:math' as math;

class MoonAnimationOne extends StatefulWidget {
  const MoonAnimationOne({super.key});

  @override
  State<MoonAnimationOne> createState() => _MoonAnimationOneState();
}

class _MoonAnimationOneState extends State<MoonAnimationOne>
    with TickerProviderStateMixin {
  late AnimationController _entryController;
  late Animation<double> _fadeIn;
  late Animation<double> _scaleUp;
  late Animation<Offset> _slideUp;

  late AnimationController _floatController;
  late Animation<double> _floating;

  late AnimationController _pulseController;
  late Animation<double> _pulse;

  late AnimationController _starController;

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..forward();

    _fadeIn = CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );

    _scaleUp = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack),
      ),
    );

    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.2, 0.9, curve: Curves.easeOut),
    ));

    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floating = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    )..repeat(reverse: true);

    _pulse = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _starController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 800),
            pageBuilder: (_, __, ___) => const News_Moon(),
            transitionsBuilder: (_, anim, __, child) =>
                FadeTransition(opacity: anim, child: child),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _entryController.dispose();
    _floatController.dispose();
    _pulseController.dispose();
    _starController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ── Fondo verde profundo (único cambio) ──
      backgroundColor: const Color(0xFF061A0E),
      body: Stack(
        children: [
          // ── Fondo: gradiente verde espacial ──
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, -0.3),
                  radius: 1.2,
                  colors: [
                    Color(0xFF0D3320), // verde profundo centro
                    Color(0xFF061A0E), // verde muy oscuro exterior
                  ],
                ),
              ),
            ),
          ),

          // ── Estrellas parpadeantes ──
          Positioned.fill(child: _buildStars()),

          // ── Contenido principal (sin tocar) ──
          Center(
            child: FadeTransition(
              opacity: _fadeIn,
              child: SlideTransition(
                position: _slideUp,
                child: AnimatedBuilder(
                  animation: _floating,
                  builder: (_, child) => Transform.translate(
                    offset: Offset(0, _floating.value),
                    child: child,
                  ),
                  child: ScaleTransition(
                    scale: _scaleUp,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ── Halo + luna ──
                        AnimatedBuilder(
                          animation: _pulse,
                          builder: (_, child) => Stack(
                            alignment: Alignment.center,
                            children: [
                              // Halo exterior difuso — tono verde/blanco
                              Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFA8D8C0)
                                          .withOpacity(_pulse.value * 0.25),
                                      blurRadius: 60,
                                      spreadRadius: 20,
                                    ),
                                  ],
                                ),
                              ),
                              // Halo interior
                              Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFD4EEE0)
                                          .withOpacity(_pulse.value * 0.4),
                                      blurRadius: 30,
                                      spreadRadius: 8,
                                    ),
                                  ],
                                ),
                              ),
                              child!,
                            ],
                          ),
                          child: const Icon(
                            Icons.nightlight_round,
                            color: Color(0xFFF0FFF4),
                            size: 100,
                            shadows: [
                              Shadow(
                                color: Color(0xFF90EEC0),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 36),

                        // ── Línea decorativa ──
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                width: 40, height: 1, color: Colors.white24),
                            const SizedBox(width: 10),
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF90EEC0),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                                width: 40, height: 1, color: Colors.white24),
                          ],
                        ),

                        const SizedBox(height: 28),

                        // ── Título ──
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            "Will the US Get to Mars Quicker\nif it Drops or Delays\nPlans to Visit the Moon?",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFF0FFF4),
                              height: 1.5,
                              letterSpacing: 0.3,
                              shadows: const [
                                Shadow(
                                  color: Color(0x6690EEC0),
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ── Autor ──
                        Text(
                          "By Ian Whittaker, 2025",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: const Color(0xFF7EB898),
                            letterSpacing: 1.2,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ── Autor ──
                        Text(
                          "From The Conversation",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: const Color(0xFF7EB898),
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStars() {
    final starData = List.generate(50, (i) {
      final x = ((i * 173 + 37) % 100) / 100.0;
      final y = ((i * 251 + 61) % 100) / 100.0;
      final size = ((i * 97) % 3 + 1).toDouble();
      final delay = (i * 0.04) % 1.0;
      return (x: x, y: y, size: size, delay: delay);
    });

    return AnimatedBuilder(
      animation: _starController,
      builder: (_, __) {
        return CustomPaint(
          painter: _StarsPainter(
            stars: starData,
            progress: _starController.value,
          ),
        );
      },
    );
  }
}

// ── Painter para estrellas ────────────────────────────────────────────────

class _StarsPainter extends CustomPainter {
  final List<({double x, double y, double size, double delay})> stars;
  final double progress;

  _StarsPainter({required this.stars, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final star in stars) {
      final t = ((progress + star.delay) % 1.0);
      final opacity = 0.2 + 0.8 * (t < 0.5 ? t * 2 : (1 - t) * 2);

      final paint = Paint()
        ..color = Color.fromRGBO(200, 240, 220, opacity)
        ..maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          star.size > 2 ? 1.5 : 0.5,
        );

      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_StarsPainter old) => old.progress != progress;
}

//---- Question and Answer Section ----//

class News_Moon extends StatefulWidget {
  const News_Moon({super.key});
  @override
  State<News_Moon> createState() => _News_MoonState();
}

class _News_MoonState extends State<News_Moon> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Title: Will the US Get to Mars Quicker if it Drops or Delays Plans to Visit the Moon?\n\nWhat is most likely to be discussed?",
      "options": [
        "A) A fictional story about astronauts and space rockets",
        "B) The history of the Apollo program from the beginning until today",
        "C) A guide for building rockets at home: DIY",
        "D) The connection between moon missions and reaching Mars"
      ],
      "correct": 3,
      "feedback": [
        " Incorrect. This title does not suggest a fictional story.",
        " Incorrect. The title does not indicate a historical overview.",
        " Incorrect. The text will not be a DIY guide.",
        " Correct! Explanation: The title signals the focus will be on whether delaying or canceling moon missions could speed up progress toward Mars."
      ]
    },
    {
      "question": "Which was the first human-made object to reach the Moon?",
      "options": ["A) Apollo 11", "B) Luna 2", "C) Sputnik 1", "D) Voyager 1"],
      "correct": 1,
      "feedback": [
        " Incorrect. Apollo 11 was the first crewed landing, not the first object.",
        " Correct! Explanation: The Soviet spacecraft Luna 2 reached the Moon in 1959, becoming the first human-made object to make contact with the lunar surface.",
        " Incorrect. Sputnik 1 was the first artificial satellite but never reached the Moon.",
        " Incorrect. Voyager 1 is a deep space probe and never traveled to the Moon."
      ]
    },
    {
      "question": "Which mission first landed humans on the Moon?",
      "options": [
        "A) Apollo 8",
        "B) Apollo 11",
        "C) Apollo 13",
        "D) Gemini 12"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Apollo 8 orbited the Moon but did not land.",
        " Correct! Explanation: Apollo 11, in 1969, carried Neil Armstrong and Buzz Aldrin, who became the first humans to walk on the Moon.",
        " Incorrect. Apollo 13 had an in-flight emergency and never landed.",
        " Incorrect. Gemini missions were Earth-orbit missions."
      ]
    },
    {
      "question":
          "How long did astronauts typically stay on the Moon during Apollo missions?",
      "options": [
        "A) A few hours",
        "B) Over a month",
        "C) 1–2 weeks",
        "D) 1–3 days"
      ],
      "correct": 3,
      "feedback": [
        " Incorrect. Only the earliest missions stayed a few hours, not typical.",
        " Incorrect. No Apollo mission stayed anywhere close to a month.",
        " Incorrect. Missions never lasted 1–2 weeks on the lunar surface.",
        " Correct! Explanation: Apollo astronauts spent between about 21 and 75 hours on the lunar surface, depending on the mission, conducting experiments and exploration."
      ]
    },
    {
      "question":
          "How many Apollo missions successfully landed humans on the Moon?",
      "options": ["A) 3", "B) 6", "C) 9", "D) 12"],
      "correct": 1,
      "feedback": [
        " Incorrect. More than three missions landed.",
        " Correct! Explanation: Six Apollo missions (11, 12, 14, 15, 16, 17) successfully landed humans on the Moon between 1969 and 1972.",
        " Incorrect. Nine missions did not land on the Moon.",
        " Incorrect. Twelve is too high; only six landed."
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
              builder: (_) => const GreenNewsReadingAnimation(
                    title:
                        "Will the US Get to Mars Quicker\nif it Drops or Delays\nPlans to Visit the Moon?",
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
                        Color(0xFF81C784), // verde suave
                        Color(0xFF4DB6AC), // teal elegante
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
                            fontSize: 18,
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
                                                255, 21, 147, 23)
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
                                  style: const TextStyle(fontSize: 15),
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
                                  fontSize: 14,
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
                                    const Color.fromARGB(255, 21, 147, 23),
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

class GreenNewsReadingAnimation extends StatefulWidget {
  const GreenNewsReadingAnimation({
    super.key,
    required this.title,
    required this.nextPage,
  });

  final String title;
  final Widget nextPage;

  @override
  State<GreenNewsReadingAnimation> createState() =>
      _GreenNewsReadingAnimationState();
}

class _GreenNewsReadingAnimationState extends State<GreenNewsReadingAnimation>
    with TickerProviderStateMixin {
  // ── Controladores ────────────────────────────────────────────────
  late final AnimationController _masterCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _floatCtrl;

  // ── Animations ───────────────────────────────────────────────────
  late final Animation<double> _bgFade;
  late final Animation<double> _paperUnfold;
  late final Animation<double> _paperScale;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _exitFade;
  late final Animation<double> _glow;
  late final Animation<double> _floatY;
  late final Animation<double> _floatRot;

  // ── Paleta ───────────────────────────────────────────────────────
  static const _bg1 = Color(0xFF010F0A);
  static const _bg2 = Color(0xFF012010);
  static const _bg3 = Color(0xFF023A20);
  static const _accent = Color(0xFF34D399);
  static const _accent2 = Color(0xFF6EE7B7);

  static const _paper = Color(0xFFF4EFE4);
  // ignore: unused_field
  static const _paperBdr = Color(0xFFC5B899);
  static const _mastBg = Color(0xFF0A2E1A);
  static const _mastBg2 = Color(0xFF0D3620);
  static const _ink = Color(0xFF1A1208);

  @override
  void initState() {
    super.initState();

    _masterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3400),
    );

    _bgFade = CurvedAnimation(
      parent: _masterCtrl,
      curve: const Interval(0.0, 0.12, curve: Curves.easeIn),
    );

    _paperScale = Tween<double>(begin: 0.60, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.05, 0.30, curve: Curves.elasticOut),
      ),
    );

    _paperUnfold = Tween<double>(begin: -0.12, end: 0.0).animate(
      CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.05, 0.35, curve: Curves.easeOutCubic),
      ),
    );

    _titleFade = CurvedAnimation(
      parent: _masterCtrl,
      curve: const Interval(0.38, 0.60, curve: Curves.easeOut),
    );

    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _masterCtrl,
      curve: const Interval(0.38, 0.62, curve: Curves.easeOut),
    ));

    _exitFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.82, 1.0, curve: Curves.easeIn),
      ),
    );

    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
    _glow = Tween<double>(begin: 6, end: 22).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );

    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);
    _floatY = Tween<double>(begin: -5.0, end: 5.0).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );
    _floatRot = Tween<double>(begin: -0.018, end: 0.018).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );

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
    super.dispose();
  }

  // ── BUILD ────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([_masterCtrl, _glowCtrl, _floatCtrl]),
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
                        _buildNewspaper(),
                        const SizedBox(height: 32),
                        _buildTitle(),
                        const SizedBox(height: 20),
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
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [_bg1, _bg2, _bg3],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0, -0.3),
              radius: 0.8,
              colors: [_accent.withOpacity(0.08), Colors.transparent],
            ),
          ),
        ),
      ),
    );
  }

  // ── PARTÍCULAS ───────────────────────────────────────────────────
  Widget _buildParticles() {
    const pts = [
      (0.09, 0.13, 3.0, 0.0),
      (0.83, 0.19, 4.0, 0.5),
      (0.19, 0.73, 3.0, 0.9),
      (0.78, 0.66, 5.0, 0.2),
      (0.52, 0.07, 3.0, 0.7),
      (0.05, 0.53, 3.0, 1.1),
      (0.91, 0.47, 3.0, 0.3),
    ];
    return FadeTransition(
      opacity: _titleFade,
      child: LayoutBuilder(
        builder: (_, c) => Stack(
          children: pts.map((p) {
            final dy =
                math.sin(_floatCtrl.value * math.pi * 2 + p.$4 * math.pi) * 9;
            return Positioned(
              left: p.$1 * c.maxWidth,
              top: p.$2 * c.maxHeight + dy,
              child: Container(
                width: p.$3,
                height: p.$3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _accent2.withOpacity(0.45),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ── PERIÓDICO ────────────────────────────────────────────────────
  Widget _buildNewspaper() {
    return Transform.translate(
      offset: Offset(0, _floatY.value),
      child: Transform.rotate(
        angle: _paperUnfold.value + _floatRot.value,
        child: ScaleTransition(
          scale: _paperScale,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: _accent.withOpacity(_glow.value / 50),
                  blurRadius: _glow.value * 2,
                ),
                const BoxShadow(
                  color: Color(0x66000000),
                  blurRadius: 8,
                  offset: Offset(5, 5),
                ),
                const BoxShadow(
                  color: Color(0x22000000),
                  blurRadius: 4,
                  offset: Offset(10, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: SizedBox(
                width: 230,
                child: _buildPaperContent(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaperContent() {
    return Stack(
      children: [
        Container(color: _paper),
        // Línea de doblez
        Positioned.fill(
          child: Row(
            children: [
              const Spacer(),
              Container(
                width: 1,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color(0x1A000000),
                      Color(0x22000000),
                      Color(0x1A000000),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildMasthead(),
            _buildMetaBar(),
            _buildBody(),
            _buildFooter(),
          ],
        ),
      ],
    );
  }

  Widget _buildMasthead() {
    return Container(
      color: _mastBg,
      padding: const EdgeInsets.fromLTRB(12, 9, 12, 8),
      child: Column(
        children: [
          Text(
            'THE GREEN POST',
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: _accent,
              letterSpacing: 3.5,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Sustainable news for a better world',
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 7.5,
              color: _accent2.withOpacity(0.55),
              letterSpacing: 1.5,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 7),
            height: 2,
            color: _accent,
          ),
        ],
      ),
    );
  }

  Widget _buildMetaBar() {
    return Container(
      color: _mastBg2,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _metaText('Vol. XLVII · No. 312'),
          _metaText('★ Est. 1977 ★'),
          _metaText('Free Edition'),
        ],
      ),
    );
  }

  Widget _metaText(String t) => Text(
        t,
        style: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 7,
          color: _accent2.withOpacity(0.45),
        ),
      );

  Widget _buildBody() {
    return Container(
      color: _paper,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPhoto(),
          const SizedBox(height: 8),
          Container(height: 1.5, color: _ink.withOpacity(0.18)),
          const SizedBox(height: 7),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _buildColumn()),
                Container(width: 1, color: _ink.withOpacity(0.10)),
                Expanded(child: _buildColumn(alt: true)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoto() {
    return SizedBox(
      height: 72,
      child: CustomPaint(painter: _NewspaperPhotoPainter()),
    );
  }

  Widget _buildColumn({bool alt = false}) {
    return Padding(
      padding: EdgeInsets.only(
        left: alt ? 7 : 0,
        right: alt ? 0 : 7,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _inkLine(h: 8, w: 1.0, opacity: 0.38),
          const SizedBox(height: 4),
          _inkLine(h: 8, w: 0.75, opacity: 0.32),
          const SizedBox(height: 6),
          Container(height: 1, color: _ink.withOpacity(0.12)),
          const SizedBox(height: 6),
          _inkLine(h: 4.5, w: 1.0),
          const SizedBox(height: 4),
          _inkLine(h: 4.5, w: 0.88),
          const SizedBox(height: 4),
          _inkLine(h: 4.5, w: 1.0),
          const SizedBox(height: 4),
          _inkLine(h: 4.5, w: alt ? 0.70 : 0.80),
          const SizedBox(height: 4),
          _inkLine(h: 4.5, w: 1.0),
          const SizedBox(height: 4),
          _inkLine(h: 4.5, w: alt ? 0.92 : 0.65),
        ],
      ),
    );
  }

  Widget _inkLine({
    required double h,
    required double w,
    double opacity = 0.18,
  }) {
    return FractionallySizedBox(
      widthFactor: w,
      child: Container(
        height: h,
        decoration: BoxDecoration(
          color: _ink.withOpacity(opacity),
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: _mastBg,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _metaText('greenpost.eco'),
          Row(
            children: [
              Icon(Icons.eco, color: _accent.withOpacity(0.6), size: 9),
              const SizedBox(width: 3),
              _metaText('Recycled paper'),
            ],
          ),
          _metaText('Page 1 of 8'),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Cinzel',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFF0FDF4),
              height: 1.35,
              shadows: [
                Shadow(
                  color: _accent.withOpacity(0.65),
                  blurRadius: _glow.value * 0.9,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
//  CustomPainter: escena genérica para la foto del periódico
// ══════════════════════════════════════════════════════════════════
class _NewspaperPhotoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final p = Paint()..isAntiAlias = true;

    // Cielo
    p.color = const Color(0xFF0F3D22);
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h * 0.58), p);

    // Suelo
    p.color = const Color(0xFF1A5C35);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.58, w, h * 0.42), p);

    // Hierba
    p.color = const Color(0xFF22803A).withOpacity(0.5);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.58, w, h * 0.07), p);

    // Sol
    p.color = const Color(0xFF34D399).withOpacity(0.4);
    canvas.drawCircle(Offset(w * 0.82, h * 0.20), 10, p);
    p.color = const Color(0xFF6EE7B7).withOpacity(0.55);
    canvas.drawCircle(Offset(w * 0.82, h * 0.20), 5.5, p);

    // Nubes
    p.color = const Color(0xFF34D399).withOpacity(0.10);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.22, h * 0.15), width: 36, height: 11),
        p);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.50, h * 0.10), width: 26, height: 9),
        p);

    // Montañas
    void mountain(double x1, double px, double x2, Color c) {
      final path = Path()
        ..moveTo(x1, h * 0.58)
        ..lineTo(px, h * 0.12)
        ..lineTo(x2, h * 0.58)
        ..close();
      p.color = c;
      canvas.drawPath(path, p);
    }

    mountain(0, w * 0.13, w * 0.26, const Color(0xFF155534));
    mountain(w * 0.18, w * 0.35, w * 0.52, const Color(0xFF1A6640));
    mountain(w * 0.44, w * 0.60, w * 0.76, const Color(0xFF155534));
    mountain(w * 0.66, w * 0.80, w * 0.95, const Color(0xFF1A6640));

    // Casas
    void house(
        double bx, double by, double hw, double hh, Color wall, Color roof) {
      p.color = wall;
      canvas.drawRect(Rect.fromLTWH(bx, by - hh, hw, hh), p);
      p.color = const Color(0xFF0A2E1A).withOpacity(0.35);
      canvas.drawRect(
          Rect.fromLTWH(bx + hw * 0.3, by - hh * 0.55, hw * 0.25, hh * 0.55),
          p);
      final r = Path()
        ..moveTo(bx - 1, by - hh)
        ..lineTo(bx + hw / 2, by - hh - hh * 0.55)
        ..lineTo(bx + hw + 1, by - hh)
        ..close();
      p.color = roof;
      canvas.drawPath(r, p);
    }

    house(w * 0.06, h * 0.58, 15, 10, const Color(0xFFE8D9B0),
        const Color(0xFFC8A060));
    house(w * 0.28, h * 0.58, 17, 11, const Color(0xFFEADED8),
        const Color(0xFF34D399));
    house(w * 0.54, h * 0.58, 13, 9, const Color(0xFFE0D4B8),
        const Color(0xFFC8A060));

    // Árboles
    void tree(double tx, double radius) {
      p.color = const Color(0xFF3D2A10);
      canvas.drawRect(
          Rect.fromLTWH(tx - 1.5, h * 0.58 - radius * 1.6, 3, radius * 1.6), p);
      p.color = const Color(0xFF22803A).withOpacity(0.9);
      canvas.drawCircle(Offset(tx, h * 0.58 - radius * 1.6), radius, p);
    }

    tree(w * 0.46, 5.5);
    tree(w * 0.74, 4.5);

    // Borde
    p
      ..color = const Color(0xFF34D399).withOpacity(0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
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

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  final String biographyText = '''
The Artemis program has been Nasa's best chance to get "boots on the Moon" again. But with the new US administration taking guidance from tech entrepreneur Elon Musk, who is focused on Mars colonization, will they end up abandoning or pushing back lunar missions?

For example, there's been speculation that returning US president Donald Trump may cancel the Space Launch System rocket, which Nasa intended to use to get from the Moon to Mars. But is this approach likely to help them get to Mars quicker?

The last human presence on the lunar surface was Apollo 17 in 1972. So you may imagine that it should be easy for the US to return. However there have been plans to once again send people there since 2004, which have changed name with each incoming president, until its current incarnation as the Artemis program.

The 2022 Artemis-1 test flight was successful in its mission to send an unmanned satellite around the lunar orbit and return using the new SLS rocket system. But Artemis-2, which will carry crew, is not scheduled for launch until 2026. When we consider private companies and other nations, this is comparatively slow progress.

The first successful landing of a spacecraft on the Moon by the Indian Space Agency, Isro, took place in 2023 with Chaandrayan-3, which was an amazing achievement with a low budget. China landed in 2013 with Chang'e 3, and Chang'e 4 in 2019 on the dark side. 

Russia have previously had landers on the Moon. Their more recent attempt at a lunar landing with Luna-25 was unsuccessful though. There are also future lander missions planned by the European Space Agency with Argonaut, a private Israeli company and other private industries. Clearly, there is no shortage of potential competitors which could eventually develop to send humans too.
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

    _fadeController.reset();
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
                const Text(
                  "Implications for Mars",
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.6,
                    fontWeight: FontWeight.bold,
                  ),
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
                                const Color.fromARGB(255, 21, 147, 23),
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
                          color: Color.fromARGB(255, 21, 147, 23)),
                      SizedBox(height: 16),
                      Text(
                        "Going to Questions...",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 21, 147, 23),
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
        'The Artemis program is NASA’s main plan to return humans to the Moon, but private companies and other countries are making rapid progress.\n\nWhat is most likely to happen next?',
    options: [
      "A) NASA will accelerate its lunar missions to stay competitive",
      "B) Private companies will stop their lunar missions",
      "C) The US will abandon space exploration entirely",
      "D) Other countries will cancel their plans"
    ],
    correctIndex: 0,
    explanation:
        'With competitors advancing, NASA is likely to feel pressure to speed up its Artemis missions to maintain leadership in lunar exploration.',
    incorrectExplanations: [
      '♻️ Correct answer!',
      ' Private companies are not expected to halt their missions.',
      ' The US abandoning all space exploration is highly unlikely.',
      ' Other countries canceling their plans is not supported by the passage.'
    ],
  ),
  QuestionData(
    question:
        'Elon Musk and Mars colonization may influence US space priorities.\n\nWhat is most likely to happen to lunar missions under this influence?',
    options: [
      "A) Lunar missions may be delayed or deprioritized",
      "B) Lunar missions will continue on the same schedule",
      "C) NASA will cancel all Mars plans",
      "D) Private companies will leave Mars exploration"
    ],
    correctIndex: 0,
    explanation:
        'If leadership shifts focus toward Mars, lunar missions could be postponed or receive less funding.',
    incorrectExplanations: [
      '♻️ Correct answer!',
      ' The schedule is likely to change if priorities shift.',
      ' NASA canceling all Mars plans contradicts the scenario.',
      ' Private companies are not expected to abandon Mars exploration.'
    ],
  ),
  QuestionData(
    question:
        'Subtitle: “Implications for Mars” \n\nWhat will most likely happen?',
    options: [
      "A) NASA abandons all space exploration",
      "B) Mars missions may be delayed",
      "C) Private companies stop working on space projects",
      "D) The Moon becomes unimportant"
    ],
    correctIndex: 1,
    explanation:
        'The subtitle suggests that changes to the Artemis program could affect Mars exploration. Delays and competing efforts make it likely that Mars missions could be postponed.',
    incorrectExplanations: [
      ' NASA abandoning all space exploration is not supported.',
      '♻️ Correct answer!',
      ' Private companies stopping their work is not indicated.',
      ' The Moon does not become unimportant according to the text.'
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

  static const Color accentDark = Color(0xFF2E7D32); // verde oscuro
  static const Color cardBg = Color(0xFFF1F8E9);     // crema verdoso

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
                  Color(0xFF81C784), // verde suave
                  Color(0xFF4DB6AC), // teal elegante
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
                          color: const Color(0xFF66BB6A), // verde medio
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
                                  ? const Color(0xFF66BB6A) // verde medio
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
                            backgroundColor: const Color(0xFF43A047), // verde botón
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

class _BiographyReadingPageSecondState
    extends State<BiographyReadingPageSecond> {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  final String biographyTextSecond = '''

So would turning to Martian exploration be a sensible move instead of heading for the Moon? It would likely mean abandoning the Lunar Gateway project, a space station in orbit around the Moon where astronauts could live. But as this is not planned until 2027 at the earliest, this would seem acceptable.

However the difference between going to the Moon and going to Mars is like the difference between walking to the end of your road compared to walking to another country.

Besides the incredible difference in distance (the distance to travel to Mars is 833 times greater than that of the distance to the Moon), the time taken to get there is far longer as well. The optimal lunar launch conditions repeat once a month. And you could still launch at times that are not ideal. 

The optimal fuel route for Mars involves arriving when the two planets are roughly on opposite sides of the Sun. This launch window repeats every 18 months, and the journey time of nine months means any problems onboard will need to be fixed by the crew, with no rescue option. Faster routes can be achieved (roughly six months) but this then becomes very energy intensive.
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
                                const Color.fromARGB(255, 21, 147, 23),
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
                        color: Color.fromARGB(255, 21, 147, 23)),
                    SizedBox(height: 16),
                    Text(
                      "Going to Questions...",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 21, 147, 23),
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
        'The distance to Mars is 833 times greater than the distance to the Moon, with a travel time of about nine months.\n\n What is most likely to happen in the future?',
    options: [
      "A) Mars missions will require much longer journeys than lunar missions",
      "B) Astronauts will arrive at Mars in just a few days",
      "C) Traveling to Mars will be as easy as going to the Moon",
      "D) Rescue crews will quickly reach Mars if problems occur"
    ],
    correctIndex: 0,
    explanation:
        'The text emphasizes the extreme distance and longer travel time to Mars compared to the Moon.',
    incorrectExplanations: [
      '♻️ Correct answer!',
      ' A few days is not realistic given current technology.',
      ' The trip to Mars is far more difficult and time-consuming than going to the Moon.',
      ' Rescue crews cannot reach Mars quickly due to the long travel time.'
    ],
  ),
  QuestionData(
    question:
        'The optimal Mars launch window happens only once every 18 months. \n\nWhat is most likely to happen in the future?',
    options: [
      "A) Launches to Mars will happen more often than to the Moon",
      "B) Crews will launch to Mars every month",
      "C) Mars missions will be unaffected by timing",
      "D) Launch opportunities for Mars missions will be limited"
    ],
    correctIndex: 3,
    explanation:
        'The text states that Mars missions depend on an 18-month cycle, so opportunities will be restricted.',
    incorrectExplanations: [
      ' Mars launches cannot exceed Moon launches because timing constraints are stricter.',
      ' Monthly Mars launches are impossible due to orbital mechanics.',
      ' Timing is a major factor for Mars missions, so they are affected.',
      '♻️ Correct answer!'
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

  static const Color accentDark = Color(0xFF2E7D32); // verde oscuro
  static const Color cardBg = Color(0xFFF1F8E9);     // crema verdoso

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
                  Color(0xFF81C784), // verde suave
                  Color(0xFF4DB6AC), // teal elegante
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
                          color: const Color(0xFF66BB6A), // verde medio
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
                                  ? const Color(0xFF66BB6A) // verde medio
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
                            backgroundColor: const Color(0xFF43A047), // verde botón
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

class _BiographyReadingPageThirdState extends State<BiographyReadingPageThird> {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  final String biographyTextSecond = '''


This is why the lunar gateway would come in handy, allowing astronauts to take off from the Moon, away from the Earth's immense gravity, and head to Mars from there. Of course the material for the gateway would need to be sent to the lunar gateway first. But by splitting the energy requirements up it means slower but more efficient propulsion methods can be used for part of the Mars journey.

There is no doubt that, with some work, SpaceX will be able to make a landing on Mars. But will they be able to safely take people there and get them back? As a company the idea of profit will be a strong factor, along with astronaut safety. We only have to look at some of the more recent Boeing problems (astronauts have been stuck on the International Space Station for seven months at time of writing) to see that private companies may want to slow down a bit when it comes to transporting people.

This is unlikely to happen though, with the considerable influence of Musk on the White House administration, and the suggestion of fellow billionaire Jared Isaacman (a private astronaut) as the new head of Nasa. 
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
                const Text(
                  "Critical Decisions",
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.6,
                    fontWeight: FontWeight.bold,
                  ),
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
                                const Color.fromARGB(255, 21, 147, 23),
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
                        color: Color.fromARGB(255, 21, 147, 23)),
                    SizedBox(height: 16),
                    Text(
                      "Going to Questions...",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 21, 147, 23),
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
        'SpaceX may be able to land on Mars, but bringing people back safely is uncertain. \n\nWhat is most likely to happen in the future?',
    options: [
      "A) Safety concerns will slow down human missions to Mars",
      "B) SpaceX will send people immediately without testing",
      "C) Astronauts will be guaranteed risk-free travel",
      "D) Boeing will handle all Mars missions alone"
    ],
    correctIndex: 0,
    explanation:
        'Since astronaut safety is questioned, progress will likely be cautious and delayed.',
    incorrectExplanations: [
      '♻️ Correct answer!',
      ' Sending people without testing would be extremely unlikely and unsafe.',
      ' Risk-free travel is impossible with current technology.',
      ' Boeing taking over all Mars missions is not suggested by the passage.'
    ],
  ),
  QuestionData(
    question:
        'Musk has strong influence on the White House, and Jared Isaacman could become NASA’s new head. \n\nWhat is most likely to happen in the future?',
    options: [
      "A) Private interests will shape NASA’s space decisions",
      "B) NASA will ignore billionaire influence entirely",
      "C) The government will stop funding space exploration",
      "D) Mars missions will be canceled forever"
    ],
    correctIndex: 0,
    explanation:
        'With political and financial influence from Musk and Isaacman, NASA’s direction will likely be guided by private priorities.',
    incorrectExplanations: [
      '♻️ Correct answer!',
      ' Ignoring billionaire influence contradicts the scenario.',
      ' There is no indication that the government will stop all funding.',
      ' Mars missions being canceled forever is not supported.'
    ],
  ),
  QuestionData(
    question:
        'Subtitle: “Critical Decisions”  \n\nWhat will most likely the text show?',
    options: [
      "A) That Mars missions have already been canceled",
      "B) That astronauts have decided to stop training",
      "C) That the Moon is no longer scientifically interesting",
      "D) That leaders must weigh safety, costs, and goals"
    ],
    correctIndex: 3,
    explanation:
        'A subtitle like “Critical Decisions” signals that the text will describe the tough choices policymakers and space agencies must make about space exploration.',
    incorrectExplanations: [
      ' The text does not indicate Mars missions are already canceled.',
      ' Astronauts stopping training is not related.',
      ' The Moon still has scientific importance and this is not stated.',
      '♻️ Correct answer!'
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

  static const Color accentDark = Color(0xFF2E7D32); // verde oscuro
  static const Color cardBg = Color(0xFFF1F8E9);     // crema verdoso

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
                  Color(0xFF81C784), // verde suave
                  Color(0xFF4DB6AC), // teal elegante
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
                          color: const Color(0xFF66BB6A), // verde medio
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
                                  ? const Color(0xFF66BB6A) // verde medio
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
                            backgroundColor: const Color(0xFF43A047), // verde botón
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

class _BiographyReadingPageFinalState extends State<BiographyReadingPageFinal> {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  final String biographyTextSecond = '''


So two options for Nasa to choose from: either keep going with their Artemis program and abandon the Lunar Gateway, or aim for Mars and be primarily dependent on Musk.

Funding both options will likely mean that neither ever happens. Of course, the Mars mission would be easier if the gateway was already present at the Moon.

The timelines involved here are important. SpaceX states that it will send five uncrewed Starships to Mars next year with an aim to send humans to Mars in 2028. This seems ambitious, particularly as it involves refuelling in orbit, but if additional funds and material are put towards the project it could potentially be sooner than this.

As the lunar gateway would be built at the earliest in 2027, then it’d be unlikely to be operational in 2028 anyway. So prioritising Mars exploration over the lunar gateway may indeed get us to Mars quicker – but it will be risky.
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
                                const Color.fromARGB(255, 21, 147, 23),
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
                        color: Color.fromARGB(255, 21, 147, 23)),
                    SizedBox(height: 16),
                    Text(
                      "Going to Questions...",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 21, 147, 23),
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
        'SpaceX plans to send five uncrewed Starships to Mars next year, aiming for humans in 2028.\n\n What is most likely to happen in the future?',
    options: [
      "A) SpaceX will easily send humans to Mars without difficulty",
      "B) The 2028 human mission may face challenges",
      "C) Starships will not require orbital refueling",
      "D) Mars missions will be canceled before they launch"
    ],
    correctIndex: 1,
    explanation:
        'The text describes the 2028 timeline as ambitious and risky, suggesting delays or difficulties are likely.',
    incorrectExplanations: [
      ' The text does not suggest that sending humans to Mars will be easy.',
      '♻️ Correct answer!',
      ' Orbital refueling is still required for long-distance missions.',
      ' There is no indication that Mars missions will be canceled before launch.'
    ],
  ),
  QuestionData(
    question:
        'Prioritizing Mars exploration over the Lunar Gateway could speed up Mars missions. \n\nWhat is most likely to happen in the future?',
    options: [
      "A) Focusing on Mars may allow faster progress but increase risks",
      "B) Mars missions will be completely risk-free",
      "C) Lunar Gateway construction will automatically accelerate",
      "D) Artemis will finish before any Mars mission begins"
    ],
    correctIndex: 0,
    explanation:
        'The text highlights that prioritizing Mars may help reach it quicker, but with significant risks.',
    incorrectExplanations: [
      '♻️ Correct answer!',
      ' No major space mission is risk-free, especially Mars missions.',
      ' Prioritizing Mars does not automatically accelerate Gateway construction.',
      ' There is no indication Artemis will fully finish before Mars missions begin.'
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

  static const Color accentDark = Color(0xFF2E7D32); // verde oscuro
  static const Color cardBg = Color(0xFFF1F8E9);     // crema verdoso

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
          // Fondo degradado
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF81C784), // verde suave
                  Color(0xFF4DB6AC), // teal elegante
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
                          color: const Color(0xFF66BB6A), // verde medio
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
                                  ? const Color(0xFF66BB6A) // verde medio
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
                            backgroundColor: const Color(0xFF43A047), // verde botón
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