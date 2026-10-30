// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Green/Content/Spot1/Spot_Page/reading_spot_page.dart';
import 'dart:math' as math;

class HellenKellerSplashScreen extends StatefulWidget {
  const HellenKellerSplashScreen({super.key});

  @override
  State<HellenKellerSplashScreen> createState() =>
      _HellenKellerSplashScreenState();
}

class _HellenKellerSplashScreenState extends State<HellenKellerSplashScreen>
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

    // ⏩ Navegación automática a la biografía de Helen Keller
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const BiographyHellen()), // ← BiographyHellen()
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
        // ── Fondo degradado amarillo cálido ────────────────────────
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
                  // ── Ícono: puntos Braille + libro abierto ─────────
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: CustomPaint(painter: _BrailleBookPainter()),
                  ),
                  const SizedBox(height: 20),

                  // ── Título del libro ───────────────────────────────
                  Text(
                    "Helen Keller, The Story of My Life:\nChapters IV to VI",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E1200),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // ── Autor ──────────────────────────────────────────
                  Text(
                    "By Helen Keller, 1903",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF5C3000),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // ── Source ──────────────────────────────────────────
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

// ─── Puntos Braille + libro abierto — CustomPainter ──────────────────
class _BrailleBookPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final brown = const Color(0xFF8B5000);

    final strokePaint = Paint()
      ..color = brown
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = brown.withOpacity(0.13)
      ..style = PaintingStyle.fill;

    final dotPaint = Paint()
      ..color = brown.withOpacity(0.75)
      ..style = PaintingStyle.fill;

    final dotFaintPaint = Paint()
      ..color = brown.withOpacity(0.40)
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = brown.withOpacity(0.45)
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    final double cx = size.width / 2;

    // ── Libro abierto ──────────────────────────────────────────────
    // Rango vertical: y=28 (tope) a y=78 (base)
    final bookPath = Path()
      ..moveTo(size.width * 0.13, size.height * 0.69)
      ..cubicTo(
        size.width * 0.13,
        size.height * 0.33,
        cx - size.width * 0.04,
        size.height * 0.29,
        cx,
        size.height * 0.31,
      )
      ..cubicTo(
        cx + size.width * 0.04,
        size.height * 0.29,
        size.width * 0.87,
        size.height * 0.33,
        size.width * 0.87,
        size.height * 0.69,
      )
      ..lineTo(size.width * 0.87, size.height * 0.78)
      ..cubicTo(
        size.width * 0.87,
        size.height * 0.78,
        cx + size.width * 0.11,
        size.height * 0.71,
        cx,
        size.height * 0.745,
      )
      ..cubicTo(
        cx - size.width * 0.11,
        size.height * 0.71,
        size.width * 0.13,
        size.height * 0.78,
        size.width * 0.13,
        size.height * 0.78,
      )
      ..close();
    canvas.drawPath(bookPath, fillPaint);
    canvas.drawPath(bookPath, strokePaint);

    // Lomo central
    canvas.drawLine(
      Offset(cx, size.height * 0.31),
      Offset(cx, size.height * 0.745),
      strokePaint..strokeWidth = 1.5,
    );

    // Líneas de texto — página izquierda
    final List<double> lineYs = [0.44, 0.51, 0.58];
    for (final y in lineYs) {
      canvas.drawLine(
        Offset(size.width * 0.22, size.height * y),
        Offset(cx - size.width * 0.04, size.height * (y - 0.022)),
        linePaint,
      );
    }
    // Líneas de texto — página derecha
    for (final y in lineYs) {
      canvas.drawLine(
        Offset(cx + size.width * 0.04, size.height * (y - 0.022)),
        Offset(size.width * 0.78, size.height * y),
        linePaint,
      );
    }

    // ── Puntos Braille sobre el libro ─────────────────────────────
    // Fila superior (más oscura) — 4 puntos
    final double brailleY1 = size.height * 0.175;
    final List<double> brailleXs = [
      size.width * 0.33,
      size.width * 0.44,
      size.width * 0.56,
      size.width * 0.67,
    ];
    for (final x in brailleXs) {
      canvas.drawCircle(Offset(x, brailleY1), 3.2, dotPaint);
    }

    // Fila inferior (más suave) — 4 puntos
    final double brailleY2 = size.height * 0.265;
    for (final x in brailleXs) {
      canvas.drawCircle(Offset(x, brailleY2), 3.2, dotFaintPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------- HELLEN QUESTIONS ----------------------
class BiographyHellen extends StatefulWidget {
  const BiographyHellen({super.key});
  @override
  State<BiographyHellen> createState() => _BiographyHellenState();
}

class _BiographyHellenState extends State<BiographyHellen> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What does it mean to be a blind person?",
      "options": [
        "A) Someone who has difficulty seeing or cannot see at all",
        "B) Someone who uses a wheelchair",
        "C) Someone who communicates only with sign language",
        "D) Someone who has super-sensitive hearing"
      ],
      "correct": 0,
      "feedback": [
        "👁️ Correct! Blindness means having little to no vision. Blind people may use tools like canes, guide dogs, or Braille to navigate the world.",
        " Incorrect. A wheelchair is for mobility, not sight.",
        " Incorrect. Sign language is typically used by deaf people.",
        " Incorrect. Not all blind people have enhanced hearing."
      ]
    },
    {
      "question": "What does it mean to be a deaf person?",
      "options": [
        "A) Someone who loves loud music",
        "B) Someone who has difficulty hearing or cannot hear at all",
        "C) Someone who cannot speak",
        "D) Someone who wears glasses"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Deafness is not related to music preferences.",
        "👂 Correct! Deafness means having little to no hearing. Deaf people may use sign language, lip-reading, or hearing aids to communicate.",
        " Incorrect. Some deaf people can speak.",
        " Incorrect. Glasses are for vision, not hearing."
      ]
    },
    {
      "question": "How might a deaf-blind person recognize you?",
      "options": [
        "A) By your handwriting",
        "B) By hearing your voice pitch",
        "C) By smelling your perfume",
        "D) By touching your face, hair, or unique features"
      ],
      "correct": 3,
      "feedback": [
        " Incorrect. Handwriting is visual.",
        " Incorrect. Deaf-blind people cannot rely on voice.",
        " Not quite. Smell might help, but tactile cues are more precise.",
        "✋ Correct! Tactile cues like facial structure, jewelry, or even a wristwatch become 'visual' identifiers through touch."
      ]
    },
    {
      "question": "How do most deaf-blind people communicate with others?",
      "options": [
        "A) By using text messages on smartphones",
        "B) Through tactile sign language (hand-over-hand signing)",
        "C) By reading lips with special glasses",
        "D) Through loud, clear speech"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Many deaf-blind people cannot see text.",
        "✋ Correct! Most deaf-blind people communicate through tactile signing, where they feel signs by placing their hands over the signer’s hands.",
        " Incorrect. Lip-reading requires vision.",
        " Incorrect. Speech doesn't help if the person can't hear."
      ]
    },
    {
      "question": "What is one major challenge deaf-blind people face daily?",
      "options": [
        "A) Choosing what clothes to wear",
        "B) Navigating and moving around safely",
        "C) Deciding what to eat",
        "D) Remembering to breathe"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Clothing choice is not the primary issue.",
        "✋ Correct! Independent mobility is extremely challenging without sight or hearing. Deaf-blind people often use canes, guide dogs, or human guides to navigate.",
        " Incorrect. They can make eating decisions independently.",
        " Incorrect. Breathing is automatic."
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
          MaterialPageRoute(
              builder: (_) =>
                  const HellenKellerReadingAnimation()), //BiographyReadingPage
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

class HellenKellerReadingAnimation extends StatefulWidget {
  const HellenKellerReadingAnimation({super.key});

  @override
  State<HellenKellerReadingAnimation> createState() =>
      _HellenKellerReadingAnimationState();
}

class _HellenKellerReadingAnimationState
    extends State<HellenKellerReadingAnimation> with TickerProviderStateMixin {
  // ── Controllers ──────────────────────────────────────────────
  late final AnimationController _entryCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _bgCtrl;
  late final AnimationController _bookCtrl;
  late final AnimationController _particleCtrl;
  late final AnimationController _brailleCtrl;
  late final AnimationController _beamsCtrl;

  // ── Animations ───────────────────────────────────────────────
  late final Animation<double> _textFade;
  late final Animation<double> _textSlide;
  late final Animation<double> _dividerWidth;
  // ignore: unused_field
  late final Animation<double> _subtitleFade;
  late final Animation<double> _glow;
  late final Animation<Color?> _bgColor1;
  late final Animation<Color?> _bgColor2;
  late final Animation<double> _bookFloat;
  late final Animation<double> _bookRock;
  late final Animation<double> _beamsOpacity;

  // ── Particles ─────────────────────────────────────────────────
  final List<_Particle> _particles = [];
  final math.Random _rng = math.Random();

  static const _golden = [
    Color(0xFFFAEEDA),
    Color(0xFFFAC775),
    Color(0xFFEF9F27),
    Color(0xFFBA7517),
  ];

  // ── Braille "HELEN" (6-dot grade 1) ──────────────────────────
  static const _brailleHelen = [
    [true, false, true, true, false, false], // H
    [true, true, false, false, false, false], // E
    [true, true, true, true, false, false], // L
    [true, true, false, false, false, false], // E
    [true, false, true, true, true, false], // N
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
      duration: const Duration(milliseconds: 2800),
    )..repeat(reverse: true);
    _glow = Tween<double>(begin: 6, end: 28).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );

    // Background shimmer
    _bgCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat(reverse: true);
    _bgColor1 = ColorTween(
      begin: const Color(0xFF1A0C00),
      end: const Color(0xFF2C1A00),
    ).animate(_bgCtrl);
    _bgColor2 = ColorTween(
      begin: const Color(0xFFD4AF37),
      end: const Color(0xFFFAEEDA),
    ).animate(_bgCtrl);

    // Book float + rock
    _bookCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3800),
    )..repeat(reverse: true);
    _bookFloat = Tween<double>(begin: 0, end: -8).animate(
      CurvedAnimation(parent: _bookCtrl, curve: Curves.easeInOut),
    );
    _bookRock = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(parent: _bookCtrl, curve: Curves.easeInOut),
    );

    // Particles
    _particleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    // Braille dot pulse
    _brailleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    // Light beams
    _beamsCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _beamsOpacity = Tween<double>(begin: 0.06, end: 0.20).animate(
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
        size: 2.5 + _rng.nextDouble() * 4.5,
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
    _bookCtrl.dispose();
    _particleCtrl.dispose();
    _brailleCtrl.dispose();
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
          _bookCtrl,
          _particleCtrl,
          _brailleCtrl,
          _beamsCtrl,
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
                      const Color(0xFF5C3A00),
                      const Color(0xFFB8860B),
                      _bgColor2.value ?? const Color(0xFFD4AF37),
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
                      const Color(0xFF0F0800).withOpacity(0.72),
                    ],
                  ),
                ),
              ),

              // Light beams — CustomPainter, NO Positioned widget
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
                        _buildBrailleDots(),
                        const SizedBox(height: 16),
                        Transform.translate(
                          offset: Offset(0, _bookFloat.value),
                          child: Transform.rotate(
                            angle: _bookRock.value,
                            child: _BookIcon(glow: _glow.value),
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
                              'Knowledge gives us light\neven in darkness.',
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

  Widget _buildBrailleDots() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_brailleHelen.length, (letterIdx) {
        final dots = _brailleHelen[letterIdx];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SizedBox(
            width: 14,
            child: Wrap(
              spacing: 3,
              runSpacing: 3,
              children: List.generate(6, (i) {
                final raised = dots[i];
                final phase = (_brailleCtrl.value * math.pi * 2) +
                    (letterIdx * 0.18 + i * 0.07) * math.pi * 2;
                final scale = raised ? 1.0 + math.sin(phase) * 0.3 : 1.0;
                return Transform.scale(
                  scale: scale,
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: raised
                          ? const Color(0xFFEF9F27)
                          : const Color(0xFF412402),
                      boxShadow: raised
                          ? [
                              BoxShadow(
                                color: const Color(0xFFEF9F27).withOpacity(0.7),
                                blurRadius: 5,
                              ),
                            ]
                          : null,
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      }),
    );
  }
}

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

// ── Book icon ─────────────────────────────────────────────────────────────────
class _BookIcon extends StatelessWidget {
  final double glow;
  // ignore: unused_element
  const _BookIcon({super.key, required this.glow});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 54,
      child: CustomPaint(painter: _BookPainter(glow: glow)),
    );
  }
}

class _BookPainter extends CustomPainter {
  final double glow;
  const _BookPainter({required this.glow});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, h * 0.08, w, h * 0.88),
        const Radius.circular(4),
      ),
      Paint()
        ..color = const Color(0xFFEF9F27).withOpacity(0.45)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glow * 0.65),
    );

    final coverPaint = Paint()..color = const Color(0xFF854F0B);
    final spinePaint = Paint()..color = const Color(0xFFBA7517);
    final strokePaint = Paint()
      ..color = const Color(0xFFEF9F27)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final leftCover = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.04, h * 0.08, w * 0.44, h * 0.84),
      const Radius.circular(3),
    );
    canvas.drawRRect(leftCover, coverPaint);
    canvas.drawRRect(leftCover, strokePaint);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.04, h * 0.08, w * 0.07, h * 0.84),
        const Radius.circular(2),
      ),
      spinePaint,
    );

    final rightCover = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.52, h * 0.08, w * 0.44, h * 0.84),
      const Radius.circular(3),
    );
    canvas.drawRRect(rightCover, coverPaint);
    canvas.drawRRect(rightCover, strokePaint);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.89, h * 0.08, w * 0.07, h * 0.84),
        const Radius.circular(2),
      ),
      spinePaint,
    );

    final spineRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.455, h * 0.06, w * 0.09, h * 0.88),
      const Radius.circular(2),
    );
    canvas.drawRRect(
      spineRect,
      Paint()
        ..color = const Color(0xFFEF9F27).withOpacity(0.7)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
    );
    canvas.drawRRect(
      spineRect,
      Paint()..color = const Color(0xFFEF9F27).withOpacity(0.55),
    );

    for (int i = 0; i < 4; i++) {
      final y = h * (0.28 + i * 0.14);
      final lp = Paint()
        ..color = const Color(0xFFEF9F27).withOpacity(0.65 - i * 0.08)
        ..strokeWidth = 1.2
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(
          Offset(w * 0.13, y), Offset(w * (i == 3 ? 0.40 : 0.44), y), lp);
      canvas.drawLine(
          Offset(w * 0.56, y), Offset(w * (i == 3 ? 0.83 : 0.87), y), lp);
    }
  }

  @override
  bool shouldRepaint(_BookPainter old) => old.glow != glow;
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
CHAPTER IV


The most important day I remember in my life is the day my teacher, Anne Mansfield Sullivan, came to me. When I think about it, I feel amazed by the huge difference between my life before and after that day. It was March 3rd, 1887, just three months before my seventh birthday.
That afternoon, I stood silently on the porch, waiting. I had a feeling something special was going to happen. I could tell from my mother’s signals and the busy movements inside the house. So I waited by the door. The afternoon sun passed through the honeysuckle vines that covered the porch and touched my face. My fingers moved slowly over the leaves and flowers that were just starting to bloom. I didn’t know what surprises the future had for me. For weeks, I had felt angry and upset, and after that, very tired and sad.
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
        '"I could tell from my mother’s signals and the busy movements inside the house. So I waited by the door." \n\nWho does “I” refer to?',
    options: [
      "A) The narrator’s sister",
      "B) Her mother",
      "C) Anne Mansfield Sullivan",
      "D) The narrator"
    ],
    correctIndex: 3,
    explanation:
        'The pronoun “I” refers to the narrator, who is describing her own thoughts and actions.',
    incorrectExplanations: [
      'The sister is not the person telling the story.',
      'The mother is mentioned, but she is not the speaker.',
      'Anne Mansfield Sullivan is not speaking in this sentence.',
      'Correct answer!',
    ],
  ),
  QuestionData(
    question:
        '"The most important day I remember in my life is the day my teacher (...) came to me. When I think about it, I feel amazed by the huge difference between my life before and after that day."\n\nWhat does “that day” refer to?',
    options: [
      "A) The day Anne Sullivan arrived",
      "B) The first time she read a book",
      "C) Her seventh birthday",
      "D) The day she first felt angry and upset"
    ],
    correctIndex: 0,
    explanation:
        ' “That day” refers to March 3rd, 1887, when Anne Sullivan came into the narrator’s life and everything began to change.',
    incorrectExplanations: [
      ' Correct answer!',
      ' Incorrect. Reading came later.',
      ' Incorrect. Her seventh birthday is not emphasized in this way.',
      ' Incorrect. The emotional moment mentioned is different from the described “day”.'
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
Have you ever been on a ship in thick fog, where everything feels white and quiet, and the ship carefully searches for the shore with no clear direction? That was how I felt before I started to learn. But I didn’t even have tools like a compass or a rope to help me know where I was. My soul silently cried out, "Light! Give me light!" And in that very hour, the light of love came to me.
I heard someone walking toward me. I reached out my hand, thinking it was my mother. Someone took my hand and lifted me up in a warm hug. It was the woman who would show me the world and, more importantly, love me.                                        
The next morning, my teacher brought me to her room and gave me a doll. The blind children at the Perkins Institute had sent it, and it had been dressed by Laura Bridgman, though I didn’t know that until later. After I played with it for a while, Miss Sullivan spelled the word "d-o-l-l" into my hand. I was curious and tried to copy her. When I finally did it right, I felt very happy and proud. I ran to my mother and showed her the signs for “doll.” I didn’t know I was spelling a word or that words existed at all. I was just moving my fingers like a little monkey. Over the next few days, I learned to spell many more words like pin, hat, cup, and some verbs like sit, stand, and walk—but I didn’t understand their meaning yet.
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
        '"Someone took my hand and lifted me up in a warm hug. It was the woman who would show me the world and, more importantly, love me." \n\nWho does “someone” refer to?',
    options: [
      "A) Miss Sullivan",
      "B) The narrator",
      "C) The narrator's mother",
      "D) The teacher"
    ],
    correctIndex: 0,
    explanation:
        '“Someone” refers to Miss Sullivan, the woman who later became the narrator’s teacher and guide.',
    incorrectExplanations: [
      'Correct answer!',
      'The narrator is the one being hugged, not the person doing the action.',
      'The mother is not identified as the person who would teach and guide her.',
      '“The teacher” is too general; the text refers to a specific woman.',
    ],
  ),
  QuestionData(
    question:
        '"I learned to spell many more words like pin, hat, cup, and some verbs like sit, stand, and walk—but I didn’t understand their meaning yet." \n\nWhat does “their” refer to?',
    options: [
      "A) The objects in the room",
      "B) Miss Sullivan",
      "C) The words and verbs she learned",
      "D) The narrator’s emotions"
    ],
    correctIndex: 2,
    explanation:
        '“Their” refers to the words and verbs the narrator learned to spell, whose meanings she did not yet understand.',
    incorrectExplanations: [
      'Incorrect. The sentence focuses on language, not physical objects.',
      'Incorrect. “Their” does not refer to a person.',
      'Correct answer!',
      'Incorrect. Emotions are not mentioned in the sentence.',
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

One day, while I was playing with my doll, Miss Sullivan put a larger rag doll in my lap and spelled "d-o-l-l" again. She wanted me to understand that the word "doll" could describe both. That morning, she had tried to teach me the words mug and water, but I kept confusing them. She stopped for a while because I was frustrated, but she tried again later. I became angry and threw the new doll on the floor. When I felt the broken pieces, I was happy. I didn’t feel sad or sorry. I didn’t love the doll. In my dark, silent world, I didn’t yet understand emotions like love or sadness. My teacher swept the broken pieces away, and I felt relieved that it was gone. Then she gave me my hat, and I knew we were going outside into the sunshine. That thought made me feel joyful.                                                                                                                                                                                                                                                                                                                                         
We walked to the well-house, which smelled of honeysuckle. Someone was drawing water, and my teacher placed my hand under the spout. As the cold water ran over one hand, she spelled w-a-t-e-r into the other, first slowly, then faster. I stood still, focusing completely on her fingers. Suddenly, I felt like something hidden was coming back to me—a strange but exciting feeling. Then I understood: w-a-t-e-r was the name of that cool, flowing thing. That living word woke up my soul. It gave me light, hope, and joy. I still had many challenges, but I knew now that I could overcome them.
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
        '"Then she gave me my hat, and I knew we were going outside into the sunshine. That thought made me feel joyful. " \n\nWhat does “that thought” refer to?       ',
    options: [
      "A) The idea of being outside",
      "B) The excitement about the new doll",
      "C) The hope of learning new words",
      "D) The feeling of frustration"
    ],
    correctIndex: 0,
    explanation:
        ' "That thought" refers to the idea of going outside into the sunshine, which brings joy to the narrator.',
    incorrectExplanations: [
      ' Correct answer!',
      ' Incorrect. The doll is not the source of the joy in this sentence.',
      ' Incorrect. Hope is not explicitly linked to the joyful thought here.',
      ' Incorrect. The narrator is not experiencing frustration in that moment.'
    ],
  ),
  QuestionData(
    question:
        '"I became angry and threw the new doll on the floor (...) My teacher swept the broken pieces away, and I felt relieved that it was gone." \n\nWhat does “it” refer to?',
    options: [
      "A) The broken doll",
      "B) The teacher",
      "C) The broken pieces",
      "D) The feeling of relief"
    ],
    correctIndex: 0,
    explanation:
        '“It” refers to the broken doll. The narrator feels relieved because the doll itself was gone, not because of the teacher, the pieces, or the emotion.',
    incorrectExplanations: [
      'Correct answer!',
      'Incorrect. “It” does not refer to a person.',
      'Incorrect. The pieces are mentioned, but “it” refers to the object as a whole.',
      'Incorrect. Relief is a feeling, not something that can be “gone.”',
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

After that moment, I was excited to learn. Everything had a name, and every name gave me a new idea. On the way back to the house, everything I touched felt alive. I was seeing things with a new kind of vision. When we went inside, I remembered the broken doll. I felt around the fireplace and picked up the pieces. I tried to put them back together, but couldn’t. For the first time, my eyes filled with tears—I understood what I had done. For the first time, I felt sorry.
That day I learned many new words. I don’t remember all of them, but I know mother, father, sister, and teacher were among them—words that would bring color and life to my world. That night, lying in bed, I was one of the happiest children alive. I thought about everything that had happened that day, and for the first time, I looked forward to tomorrow.
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
        '“That night, lying in bed, I was one of the happiest children alive”\n\nWhat does “that night” refer to in the sentence?',
    options: [
      "A) The night after the teacher arrived",
      "B) The night after the narrator learned many words",
      "C) The night the doll was fixed",
      "D) The night the narrator first felt sorry"
    ],
    correctIndex: 1,
    explanation:
        '“That night” refers to the moment after the narrator learned many new words, which made her feel extremely happy.',
    incorrectExplanations: [
      'Incorrect. The teacher arrived earlier and that moment is not being described here.',
      'Correct answer!',
      'Incorrect. The doll is not related to this sentence.',
      'Incorrect. Feeling sorry is not connected to this moment of happiness.',
    ],
  ),
  QuestionData(
    question:
        '"After that moment, I was excited to learn. Everything had a name, and every name gave me a new idea." \n\nWhat does "everything" refer to?',
    options: [
      "A) The people around her",
      "B) The objects and things she encountered",
      "C) The emotions she experienced",
      "D) The words she learned"
    ],
    correctIndex: 1,
    explanation:
        '“Everything” refers to the objects and things in the narrator’s surroundings, which she was now able to understand by learning their names.',
    incorrectExplanations: [
      'Incorrect. The sentence is not about people.',
      'Correct answer!',
      'Incorrect. Emotions are not the focus here.',
      'Incorrect. Words are important, but “everything” refers to the things being named.',
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