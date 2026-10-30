// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Orange/Content/Spot1/Spot_Page/reading_spot_page.dart';

import 'dart:math' as math;


// ── Reemplaza con tu import real ──────────────────────────────────
// import 'biography_abrahan.dart';
// ─────────────────────────────────────────────────────────────────

class AbrahanSplashScreen extends StatefulWidget {
  const AbrahanSplashScreen({super.key});

  @override
  State<AbrahanSplashScreen> createState() => _AbrahanSplashScreenState();
}

class _AbrahanSplashScreenState extends State<AbrahanSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _starsController;
  late Animation<double> _fadeIn;
  late Animation<double> _scaleUp;

  // 5 estrellas con distintos delays de parpadeo
  final List<_StarData> _stars = [
    _StarData(x: 0.10, y: 0.08, size: 10, duration: 1800, delay: 0),
    _StarData(x: 0.88, y: 0.12, size: 9,  duration: 2200, delay: 400),
    _StarData(x: 0.50, y: 0.05, size: 11, duration: 1600, delay: 900),
    _StarData(x: 0.22, y: 0.18, size: 8,  duration: 2400, delay: 200),
    _StarData(x: 0.78, y: 0.15, size: 9,  duration: 1900, delay: 700),
  ];

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _fadeIn  = CurvedAnimation(parent: _mainController, curve: Curves.easeIn);
    _scaleUp = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.elasticOut),
    );
    _mainController.forward();

    // Estrellas parpadeando en loop
    _starsController = AnimationController(
      duration: const Duration(milliseconds: 2400),
      vsync: this,
    )..repeat();

    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BiographyAbrahan()),
      );
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _starsController.dispose();
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

                  // ── Sombrero + estrellas ───────────────────────────
                  SizedBox(
                    width: 110,
                    height: 110,
                    child: AnimatedBuilder(
                      animation: _starsController,
                      builder: (_, __) => CustomPaint(
                        painter: _HatStarsPainter(
                          starsT: _starsController.value,
                          stars: _stars,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    "Lives of Poor Boys\nWho Became Famous:\nAbraham Lincoln",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E1200),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    "By Sarah K. Bolton, 1885",
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

// ─── Datos de cada estrella ───────────────────────────────────────────
class _StarData {
  final double x, y, size;
  final int duration, delay;
  const _StarData({
    required this.x, required this.y, required this.size,
    required this.duration, required this.delay,
  });
}

// ─── Sombrero de Lincoln + estrellas parpadeantes ─────────────────────
class _HatStarsPainter extends CustomPainter {
  final double starsT;
  final List<_StarData> stars;

  _HatStarsPainter({required this.starsT, required this.stars});

  @override
  void paint(Canvas canvas, Size size) {
    const brown = Color(0xFF8B5000);
    const dark  = Color(0xFF5C3000);

    final stroke = Paint()
      ..color = brown
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fill = Paint()..style = PaintingStyle.fill;

    final cx = size.width  / 2;

    // ── ESTRELLAS PARPADEANTES ─────────────────────────────────────
    for (final star in stars) {
      final totalMs = star.duration + star.delay;
      final elapsed = (starsT * 2400) % totalMs;
      if (elapsed < star.delay) continue;
      final p = ((elapsed - star.delay) / star.duration).clamp(0.0, 1.0);
      // Brillo: sube y baja suavemente (sin easing → usamos sin)
      final brightness = (math.sin(p * math.pi)).clamp(0.0, 1.0);
      final opacity = 0.20 + brightness * 0.75;
      final scale   = 1.0  + brightness * 0.45;

      _drawStar(
        canvas,
        Offset(star.x * size.width, star.y * size.height),
        star.size * scale / 2,
        brown.withOpacity(opacity),
      );
    }

    // ── ALA DEL SOMBRERO ──────────────────────────────────────────
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, size.height * 0.80),
        width: size.width  * 0.88,
        height: size.height * 0.18,
      ),
      fill..color = brown.withOpacity(0.40),
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, size.height * 0.80),
        width: size.width  * 0.88,
        height: size.height * 0.18,
      ),
      stroke,
    );

    // ── CUERPO DEL SOMBRERO (alto y recto) ────────────────────────
    final bodyRect = RRect.fromLTRBR(
      cx - size.width * 0.26, size.height * 0.18,
      cx + size.width * 0.26, size.height * 0.78,
      const Radius.circular(3),
    );
    canvas.drawRRect(bodyRect, fill..color = brown.withOpacity(0.50));
    canvas.drawRRect(bodyRect, stroke);

    // ── BANDA DEL SOMBRERO ────────────────────────────────────────
    final bandRect = RRect.fromLTRBR(
      cx - size.width * 0.26, size.height * 0.66,
      cx + size.width * 0.26, size.height * 0.76,
      const Radius.circular(2),
    );
    canvas.drawRRect(bandRect, fill..color = dark.withOpacity(0.60));
    canvas.drawRRect(bandRect, stroke..strokeWidth = 1.8);

    // ── TOPE PLANO ────────────────────────────────────────────────
    final topRect = RRect.fromLTRBR(
      cx - size.width * 0.26, size.height * 0.16,
      cx + size.width * 0.26, size.height * 0.22,
      const Radius.circular(2),
    );
    canvas.drawRRect(topRect, fill..color = dark.withOpacity(0.50));
    canvas.drawRRect(topRect, stroke..strokeWidth = 2.2);

    // ── LAZO DE LA BANDA ──────────────────────────────────────────
    final bowRect = RRect.fromLTRBR(
      cx - size.width * 0.05, size.height * 0.67,
      cx + size.width * 0.05, size.height * 0.75,
      const Radius.circular(1),
    );
    canvas.drawRRect(bowRect, fill..color = brown.withOpacity(0.70));
    canvas.drawRRect(bowRect, stroke..strokeWidth = 1.5);
  }

  // Dibuja una estrella de 5 puntas
  void _drawStar(Canvas canvas, Offset center, double r, Color color) {
    final path = Path();
    for (int i = 0; i < 5; i++) {
      final outerAngle = (i * 72 - 90) * math.pi / 180;
      final innerAngle = ((i * 72 + 36) - 90) * math.pi / 180;
      final outer = Offset(
        center.dx + math.cos(outerAngle) * r,
        center.dy + math.sin(outerAngle) * r,
      );
      final inner = Offset(
        center.dx + math.cos(innerAngle) * r * 0.4,
        center.dy + math.sin(innerAngle) * r * 0.4,
      );
      if (i == 0) path.moveTo(outer.dx, outer.dy);
      else path.lineTo(outer.dx, outer.dy);
      path.lineTo(inner.dx, inner.dy);
    }
    path.close();
    canvas.drawPath(path, Paint()..color = color..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant _HatStarsPainter old) => old.starsT != starsT;
}


// ---------------------- Abrahan QUESTIONS ----------------------
class BiographyAbrahan extends StatefulWidget {
  const BiographyAbrahan({super.key});
  @override
  State<BiographyAbrahan> createState() => _BiographyAbrahanState();
}

class _BiographyAbrahanState extends State<BiographyAbrahan> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What was the primary conflict of the U.S. Civil War?",
      "options": [
        "A) A war between the United States and Great Britain",
        "B) A conflict to gain independence from a foreign power",
        "C) A war fought between the Northern and Southern states of the U.S.",
        "D) A war to expand the United States' territory into Canada"
      ],
      "correct": 2,
      "feedback": [
        " Incorrect. The Civil War was not against Great Britain.",
        " Incorrect. The U.S. was already independent.",
        "🇺🇸 Correct! The U.S. Civil War (1861–1865) was fought between the Union (North) and the Confederacy (South) over slavery and states’ rights.",
        " Incorrect. The war was not about expanding into Canada."
      ]
    },
    {
      "question":
          "What was one of Abraham Lincoln's primary goals during the Civil War?",
      "options": [
        "A) Preserving the Union",
        "B) Freeing enslaved people",
        "C) Expanding the country's territory",
        "D) Punishing the Southern states"
      ],
      "correct": 0,
      "feedback": [
        " Correct! Lincoln’s main goal was to preserve the Union and prevent the Southern states from seceding.",
        " Incorrect. While emancipation became important, preserving the Union came first.",
        " Incorrect. Territorial expansion was not his focus.",
        " Incorrect. Lincoln aimed for reconciliation, not punishment."
      ]
    },
    {
      "question":
          "What is the significance of the Emancipation Proclamation, issued by Abraham Lincoln in 1863?",
      "options": [
        "A) It immediately freed all enslaved people in the United States.",
        "B) It declared the end of the Civil War.",
        "C) It granted citizenship to all formerly enslaved people.",
        "D) It freed enslaved people only in the Confederate-held states."
      ],
      "correct": 3,
      "feedback": [
        " Incorrect. It only applied to Confederate states, not all enslaved people.",
        " Incorrect. The Civil War continued after it was issued.",
        " Incorrect. Citizenship came later with the 14th Amendment.",
        " Correct! The Emancipation Proclamation freed enslaved people in the Confederate-held territories."
      ]
    },
    {
      "question":
          "From which speech does Abraham Lincoln's famous phrase, 'government of the people, by the people, for the people,' originate?",
      "options": [
        "A) His First Inaugural Address",
        "B) The Gettysburg Address",
        "C) His Second Inaugural Address",
        "D) The Emancipation Proclamation"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. That phrase wasn’t in his first inaugural address.",
        " Correct! The line comes from the closing of the Gettysburg Address, honoring democracy and equality.",
        " Incorrect. It wasn’t said in his second inaugural address.",
        " Incorrect. The Emancipation Proclamation was a legal document, not a speech."
      ]
    },
    {
      "question":
          "What tragic event cemented Abraham Lincoln’s legacy as a martyr for the Union?",
      "options": [
        "A) The Battle of Antietam",
        "B) His assassination",
        "C) His defeat in the 1864 election",
        "D) The surrender at Appomattox Court House"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. That was a key battle, not his death.",
        " Correct! Lincoln’s assassination just days after the Civil War’s end made him a martyr for the Union cause.",
        " Incorrect. He actually won the 1864 election.",
        " Incorrect. The surrender marked the end of the war, not Lincoln’s legacy as a martyr."
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
              builder: (_) =>
                  const AbrahanReadingAnimation()), //BiographyReadingPage
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

class AbrahanReadingAnimation extends StatefulWidget {
  const AbrahanReadingAnimation({super.key});

  @override
  State<AbrahanReadingAnimation> createState() =>
      _AbrahanReadingAnimationState();
}

class _AbrahanReadingAnimationState extends State<AbrahanReadingAnimation>
    with TickerProviderStateMixin {
  // ── Controllers ──────────────────────────────────────────────
  late final AnimationController _entryCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _bgCtrl;
  late final AnimationController _pulseCtrl;
  late final AnimationController _waveCtrl;
  late final AnimationController _particleCtrl;
  late final AnimationController _beamsCtrl;
  late final AnimationController _pageCtrl;

  // ── Animations ───────────────────────────────────────────────
  late final Animation<double> _textFade;
  late final Animation<double> _textSlide;
  // ignore: unused_field
  late final Animation<double> _subtitleFade;
  late final Animation<double> _dividerWidth;
  late final Animation<double> _iconFade;
  late final Animation<double> _iconScale;
  late final Animation<double> _glow;
  late final Animation<Color?> _bgColor1;
  late final Animation<Color?> _bgColor2;
  late final Animation<double> _bookPulse;
  late final Animation<double> _wavePhase;
  late final Animation<double> _beamsOpacity;
  late final Animation<double> _pageFlip;

  final List<_Particle> _particles = [];
  final math.Random _rng = math.Random();

  static const _goldenColors = [
    Color(0xFFFFF8E1), Color(0xFFEDD870),
    Color(0xFFD4AF37), Color(0xFF8D6E00), Color(0xFF5A3A00),
  ];

  @override
  void initState() {
    super.initState();
    _spawnParticles();

    _entryCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100));
    _textFade = CurvedAnimation(parent: _entryCtrl, curve: const Interval(0.0, 0.65, curve: Curves.easeOut));
    _textSlide = Tween<double>(begin: 12, end: 0).animate(CurvedAnimation(parent: _entryCtrl, curve: const Interval(0.0, 0.65, curve: Curves.easeOutCubic)));
    _subtitleFade = CurvedAnimation(parent: _entryCtrl, curve: const Interval(0.6, 1.0, curve: Curves.easeIn));
    _dividerWidth = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _entryCtrl, curve: const Interval(0.25, 0.75, curve: Curves.easeOut)));
    _iconFade = CurvedAnimation(parent: _entryCtrl, curve: const Interval(0.0, 0.5, curve: Curves.easeOut));
    _iconScale = Tween<double>(begin: 0.85, end: 1.0).animate(CurvedAnimation(parent: _entryCtrl, curve: const Interval(0.0, 0.55, curve: Curves.easeOutBack)));

    _glowCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2600))..repeat(reverse: true);
    _glow = Tween<double>(begin: 14, end: 38).animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));

    _bgCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 9))..repeat(reverse: true);
    _bgColor1 = ColorTween(begin: const Color(0xFF0E0700), end: const Color(0xFF2C1A00)).animate(_bgCtrl);
    _bgColor2 = ColorTween(begin: const Color(0xFFD4AF37), end: const Color(0xFFFFF3C2)).animate(_bgCtrl);

    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _bookPulse = Tween<double>(begin: 0.95, end: 1.08).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    _waveCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2800))..repeat();
    _wavePhase = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _waveCtrl, curve: Curves.linear));

    _particleCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();

    _beamsCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat(reverse: true);
    _beamsOpacity = Tween<double>(begin: 0.04, end: 0.16).animate(CurvedAnimation(parent: _beamsCtrl, curve: Curves.easeInOut));

    // Page flip animation
    _pageCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 3500))..repeat(reverse: true);
    _pageFlip = Tween<double>(begin: 0, end: -0.32).animate(CurvedAnimation(parent: _pageCtrl, curve: Curves.easeInOut));

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
    _entryCtrl.dispose(); _glowCtrl.dispose(); _bgCtrl.dispose();
    _pulseCtrl.dispose(); _waveCtrl.dispose(); _particleCtrl.dispose();
    _beamsCtrl.dispose(); _pageCtrl.dispose();
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
        child: FadeTransition(opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut), child: child),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _bgCtrl, _glowCtrl, _pulseCtrl, _waveCtrl,
          _particleCtrl, _beamsCtrl, _pageCtrl, _entryCtrl,
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
                      _bgColor1.value ?? const Color(0xFF0E0700),
                      const Color(0xFF5A3A00),
                      const Color(0xFF8D6E00),
                      _bgColor2.value ?? const Color(0xFFD4AF37),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
              ),

              // Vignette
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center, radius: 1.2,
                    colors: [
                      const Color(0xFFFFF8E1).withOpacity(0.07),
                      Colors.transparent,
                      const Color(0xFF0A0600).withOpacity(0.82),
                    ],
                  ),
                ),
              ),

              // Beams
              CustomPaint(painter: _BeamsPainter(opacity: _beamsOpacity.value)),

              // Particles
              CustomPaint(painter: _ParticlePainter(particles: _particles, progress: _particleCtrl.value)),

              // Content
              SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ── Book icon ───────────────────────────────
                        FadeTransition(
                          opacity: _iconFade,
                          child: ScaleTransition(
                            scale: _iconScale,
                            child: Transform.scale(
                              scale: _bookPulse.value,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ..._buildHaloRings(),
                                  // Glow
                                  Container(
                                    width: 114, height: 114,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(color: Colors.amberAccent.withOpacity(0.65), blurRadius: _glow.value, spreadRadius: _glow.value * 0.35, offset: const Offset(0, 14)),
                                        BoxShadow(color: const Color(0xFFFFF8E1).withOpacity(0.25), blurRadius: _glow.value * 1.8),
                                      ],
                                    ),
                                  ),
                                  // Gradient circle
                                  Container(
                                    width: 114, height: 114,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(
                                        center: Alignment(-0.3, -0.3),
                                        colors: [Color(0xFFFFF8E1), Color(0xFFD4AF37), Color(0xFF8D6E00)],
                                      ),
                                    ),
                                  ),
                                  // Book with page flip
                                  SizedBox(
                                    width: 114, height: 114,
                                    child: CustomPaint(
                                      painter: _BookPainter(pageFlip: _pageFlip.value, glowRadius: _glow.value),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),
                        _buildDivider(),
                        const SizedBox(height: 18),

                        // Message
                        FadeTransition(
                          opacity: _textFade,
                          child: Transform.translate(
                            offset: Offset(0, _textSlide.value),
                            child: Text(
                              'Leadership begins with integrity.\n'
                              'Knowledge lights the path of history.\n'
                              'A legacy is built through wisdom.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Georgia',
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                height: 1.65,
                                color: const Color(0xFFFFF8E1),
                                shadows: [
                                  Shadow(color: Colors.amberAccent.withOpacity(0.9), blurRadius: 18 * _bookPulse.value),
                                  Shadow(color: const Color(0xFFD4AF37).withOpacity(0.5), blurRadius: 36 * _bookPulse.value),
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
          width: 114, height: 114,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFD4AF37).withOpacity(opacity), width: 1.5),
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
              Colors.transparent, Color(0xFFD4AF37), Color(0xFFFFF8E1), Color(0xFFD4AF37), Colors.transparent,
            ]),
          ),
        ),
      ),
    );
  }
}

// ── Book with page flip ───────────────────────────────────────────────────────
class _BookPainter extends CustomPainter {
  final double pageFlip;   // 0 .. -0.32 radians
  final double glowRadius;
  const _BookPainter({required this.pageFlip, required this.glowRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;

    const coverColor = Color(0xFF4A3000);
    const spineColor = Color(0xFF6B4E00);
    const lineColor = Color(0xFFD4AF37);

    final coverPaint = Paint()..color = coverColor;
    final spinePaint = Paint()..color = spineColor;
    final strokePaint = Paint()..color = lineColor..style = PaintingStyle.stroke..strokeWidth = 1.0;
    final linePaint = Paint()..color = lineColor..strokeWidth = 1.1..strokeCap = StrokeCap.round;

    // ── Left cover ──────────────────────────────────────────────
    final leftRect = RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.08, h * 0.14, w * 0.38, h * 0.70), const Radius.circular(4));
    canvas.drawRRect(leftRect, coverPaint);
    canvas.drawRRect(leftRect, strokePaint);
    // Left spine strip
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.08, h * 0.14, w * 0.07, h * 0.70), const Radius.circular(3)), spinePaint);
    // Lines left
    for (int i = 0; i < 4; i++) {
      final ly = h * (0.26 + i * 0.14);
      canvas.drawLine(Offset(w * 0.18, ly), Offset(w * (i == 3 ? 0.38 : 0.42), ly), linePaint..color = lineColor.withOpacity(0.7 - i * 0.08));
    }

    // ── Right cover (with page flip perspective) ─────────────────
    canvas.save();
    // Skew the right cover slightly to simulate page turn
    final skewMatrix = Matrix4.identity()
      ..setEntry(1, 0, pageFlip * 0.12)
      ..setEntry(0, 1, pageFlip * 0.04);
    canvas.transform(skewMatrix.storage);

    final rightRect = RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.50, h * 0.14, w * 0.38, h * 0.70), const Radius.circular(4));
    canvas.drawRRect(rightRect, coverPaint);
    canvas.drawRRect(rightRect, strokePaint);
    // Right spine strip
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.81, h * 0.14, w * 0.07, h * 0.70), const Radius.circular(3)), spinePaint);
    // Lines right
    for (int i = 0; i < 4; i++) {
      final ly = h * (0.26 + i * 0.14);
      canvas.drawLine(Offset(w * 0.54, ly), Offset(w * (i == 3 ? 0.74 : 0.78), ly), linePaint..color = lineColor.withOpacity(0.7 - i * 0.08));
    }
    canvas.restore();

    // ── Spine center glow ────────────────────────────────────────
    final spineGlowRect = RRect.fromRectAndRadius(Rect.fromLTWH(cx - 4, h * 0.12, 8, h * 0.74), const Radius.circular(3));
    canvas.drawRRect(spineGlowRect, Paint()..color = lineColor.withOpacity(0.7)..maskFilter = MaskFilter.blur(BlurStyle.normal, 2));
    canvas.drawRRect(spineGlowRect, Paint()..color = lineColor.withOpacity(0.6));

    // ── Star on left cover ───────────────────────────────────────
    _drawStar(canvas, Offset(w * 0.24, h * 0.72), 7, lineColor.withOpacity(0.85));
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Color color) {
    final path = Path();
    for (int i = 0; i < 10; i++) {
      final r = i.isEven ? radius : radius * 0.45;
      final angle = (i / 10) * math.pi * 2 - math.pi / 2;
      final pt = Offset(center.dx + r * math.cos(angle), center.dy + r * math.sin(angle));
      i == 0 ? path.moveTo(pt.dx, pt.dy) : path.lineTo(pt.dx, pt.dy);
    }
    path.close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_BookPainter old) => old.pageFlip != pageFlip || old.glowRadius != glowRadius;
}

// ── Beams ─────────────────────────────────────────────────────────────────────
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
      canvas.drawRect(Rect.fromLTWH(-1, -size.height * 0.9, 2, size.height * 1.8),
        Paint()..shader = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [Colors.transparent, const Color(0xFFFFF8E1).withOpacity(opacity * b.alpha), const Color(0xFFD4AF37).withOpacity(opacity * 0.5 * b.alpha), Colors.transparent],
        ).createShader(Rect.fromLTWH(cx - 1, 0, 2, size.height)));
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
  const _Particle({required this.x, required this.size, required this.speed, required this.color, required this.offset, required this.wobble});
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
      final opacity = t < 0.1 ? t / 0.1 : t > 0.75 ? 1 - (t - 0.75) / 0.25 : 1.0;
      canvas.drawCircle(Offset(p.x * size.width + dx, y), p.size * 0.55,
        Paint()..color = p.color.withOpacity(opacity * 0.65)..maskFilter = MaskFilter.blur(BlurStyle.normal, p.size * 0.5));
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
In the wilds of Gentryville, Indiana, in the year 1816, a humble log cabin stood silent against the vast woods—without doors, without window glass, the floor packed earth, the furniture rough-hewn from logs. There was little inside: a bed made of dried leaves, a stool or two, and a crude table. But within its rough walls lived a family whose story would one day echo across a nation.

Thomas Lincoln, the father, was a kind and hardworking man, though he had never learned to read or write. His wife, Nancy Hanks Lincoln, was his opposite in many ways—a pale, delicate woman with a gentle soul and a quiet strength that made her seem almost otherworldly in such a rugged setting. She seemed out of place in this life of hardship, like a flower blooming where it shouldn’t. Their children were Sarah, a girl of ten with her mother’s gentleness, and Abraham, a tall, awkward boy of eight who already showed signs of deep thought and quiet determination.

The Lincolns had only recently left their home in Hardin County, Kentucky, cutting their way through dense forest with axes, living off what game they could hunt with a rifle. It had been a journey of endurance and grit, and what they had found in Indiana was scarcely easier than what they had left behind.

In that little cabin, Nancy Lincoln owned only one book—the Bible. But she used it faithfully, reading it aloud, teaching her children each day. Abraham, curious and quick to learn, had already attended school for just a few months—the best the frontier could offer. He had learned to read, and his mind absorbed words like the parched earth takes in rain. With a sharp memory and a tender heart, he came to know the stories of the Bible almost by heart, and he began to see his mother as the living example of all its virtues.

Years later, when he would lead a fractured nation of thirty million through its greatest trial, he would remember her quiet strength. “All that I am, or hope to be,” he once said, “I owe to my angel mother. Blessings on her memory.”

When he was ten years old, Abraham Lincoln’s mother died. Life was hard for the family, and she became sick with a disease called consumption. She was buried in a simple wooden box near the cabin where they lived. It was a very sad time for Abraham. He missed her so much that he sat by her grave every day and cried. People later remembered the sad look in his eyes during difficult times in his life.
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
    question:
        'Abraham sat by his mother’s grave every day and cried.\n\n What does this suggest about their relationship?',
    options: [
      "A) He was angry at her for leaving",
      "B) He didn’t know her very well",
      "C) He loved and missed her greatly",
      "D) He quickly forgot about her"
    ],
    correctIndex: 2,
    explanation:
        '💔 Abraham’s daily visits to his mother’s grave and his grief show a deep emotional bond and affection.',
    incorrectExplanations: [
      " Incorrect. There’s no sign of anger toward his mother.",
      " Incorrect. His actions show he knew her and cared deeply.",
      " Correct answer!",
      " Incorrect. Visiting her grave daily shows he didn’t forget her."
    ],
  ),
  QuestionData(
    question:
        'The Lincolns’ cabin stood in the wilds of Indiana, surrounded by dense forest.\n\n Where did the family likely have to go if they needed supplies?',
    options: [
      "A) A small settlement miles away",
      "B) A nearby grocery store",
      "C) Their neighbours’ house next door",
      "D) A store inside the cabin"
    ],
    correctIndex: 0,
    explanation:
        '🌲 Dense forest and isolation suggest they lived far from towns, so supplies would come from a settlement some distance away.',
    incorrectExplanations: [
      " Correct answer!",
      " Incorrect. There were no grocery stores nearby in the frontier days.",
      " Incorrect. Their neighbors were likely far away.",
      " Incorrect. They didn’t have a store inside the cabin."
    ],
  ),
  QuestionData(
    question:
        'The Lincolns cut their way through dense forest with axes. \n\nWhat was the axe most likely used for?',
    options: [
      "A) Playing games",
      "B) Hunting animals",
      "C) Building their cabin",
      "D) Reading books"
    ],
    correctIndex: 2,
    explanation:
        '🪓 Axes were essential tools for chopping wood to clear land and build shelter on the frontier.',
    incorrectExplanations: [
      " Incorrect. Axes weren’t used for games.",
      " Incorrect. Guns, not axes, were used for hunting.",
      " Correct answer!",
      " Incorrect. Reading books doesn’t involve an axe."
    ],
  ),
  QuestionData(
    question:
        'Nancy Hanks Lincoln read the Bible to her children each day. \n\nWhen did Abraham most likely develop his early reading skills?',
    options: [
      "A) After becoming president",
      "B) Before his family left Kentucky",
      "C) When he lived in the Indiana cabin",
      "D) Only after his mother died"
    ],
    correctIndex: 2,
    explanation:
        '📖 The text explains Abraham learned to read during the frontier years in Indiana, influenced by his mother’s daily Bible readings.',
    incorrectExplanations: [
      " Incorrect. He learned long before becoming president.",
      " Incorrect. His reading habits developed later in Indiana.",
      " Correct answer!",
      " Incorrect. He began learning while his mother was still alive."
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
  final String biographyTextSecond = '''

Nine months later, Abraham wrote a letter to a pastor named Parson Elkins, who had known the family in Kentucky. He asked him to come and give a funeral speech for his mother. The pastor rode over 100 miles on horseback to come. On a Sunday morning, many people came from nearby areas to hear the speech. He spoke about the kind and Christian life of Abraham’s mother. Even though she died young, she had helped shape the strong character of her son.

Abraham wanted to learn more about the world. He borrowed books like Pilgrim’s Progress, Aesop’s Fables, and Robinson Crusoe. He read them many times and memorized parts of them. He began to imagine a big world beyond Kentucky and Indiana and dreamed about seeing it one day.

Later, his father married a widow who was a friend of Abraham’s mother. She brought her three children and furniture like chairs, a table, and a bed. Before that, Abraham had climbed to the attic and slept on a sack of corn husks. Now he had a real bed. Abraham and his sister were happy to have a new mother, and she became a kind and loving stepmother. She supported Abraham and encouraged him to study and become someone important. She also gave him love and care.

He found an old book called Life of Washington by Weems and loved reading about a great man who did amazing things. Abraham, who wore old buckskin pants that didn’t even reach his ankles, started to wonder if he could also do something great in the world. One day, when a woman asked what he thought he would become, he answered, “I think I’m going to be President of the United States someday.”

Sadly, the Life of Washington book got wet during a storm and was damaged. Abraham returned it to the owner and worked for three days to pay for it. Then the book was his.

Abraham’s time at school had ended, so he worked for local farmers doing hard jobs like chopping wood and planting. He gave all the money he earned to his family. At night, he read more books like Plutarch’s Lives and The Life of Benjamin Franklin. People liked him because he was good with children, told funny stories, recited poetry, and could wrestle and jump well.

Although many people around him drank alcohol, Abraham never did, because his mother had told him not to. He also helped others. Once, he and his friends found a drunk man lying in the cold. They put the man on his horse and took him to a house where Abraham stayed all night to take care of him, saving his life.
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
    question: "Why did Abraham’s stepmother encourage him to study?",
    options: [
      "A) She wanted him to become famous someday",
      "B) She thought reading was a waste of time",
      "C) She didn’t like the way he spent his evenings",
      "D) She wanted him to stop working for farmers"
    ],
    correctIndex: 0,
    explanation:
        "💖 The text says she was kind, loving, and encouraged him to study to 'become someone important,' showing her belief in his potential.",
    incorrectExplanations: [
      " Correct answer!",
      " Incorrect. The text shows she valued study, not that she thought it was a waste of time.",
      " Incorrect. Her encouragement wasn’t about how he spent his evenings.",
      " Incorrect. There’s no evidence she wanted him to stop working for farmers."
    ],
  ),
  QuestionData(
    question:
        "Before Abraham’s stepmother arrived, \n\nwhere did Abraham sleep?",
    options: [
      "A) In a neighbor’s house",
      "B) On the ground outside",
      "C) In the attic",
      "D) In a proper bed in his own room"
    ],
    correctIndex: 2,
    explanation:
        "🛏️ The text mentions he 'climbed to the attic and slept on a sack of corn husks' before getting a real bed from his stepmother.",
    incorrectExplanations: [
      " Incorrect. The text doesn’t mention neighbors.",
      " Incorrect. He slept indoors, not outside.",
      " Correct answer!",
      " Incorrect. He didn’t have a proper bed until later."
    ],
  ),
  QuestionData(
    question:
        "Why did Abraham work for three days after the Life of Washington book got wet?",
    options: [
      "A) To buy food for his family",
      "B) To repair the book",
      "C) To pay the book’s owner for the damage",
      "D) To earn money for school"
    ],
    correctIndex: 2,
    explanation:
        "📚 The text says he returned the book and 'worked for three days to pay for it,' showing the work was to make up for the damage.",
    incorrectExplanations: [
      " Incorrect. The work was specifically to pay for the damaged book.",
      " Incorrect. He didn’t repair the book himself.",
      " Correct answer!",
      " Incorrect. The work wasn’t related to school expenses."
    ],
  ),
  QuestionData(
    question:
        "When did Abraham start to dream about doing something great in the world?",
    options: [
      "A) Before reading Life of Washington",
      "B) After he read Life of Washington",
      "C) After becoming president",
      "D) After leaving Kentucky"
    ],
    correctIndex: 1,
    explanation:
        "🌟 The text says reading about Washington inspired him to wonder if he could 'also do something great in the world.'",
    incorrectExplanations: [
      " Incorrect. The inspiration came *after* reading the book.",
      " Correct answer!",
      " Incorrect. His dream started long before becoming president.",
      " Incorrect. The event was not related to leaving Kentucky."
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

At age eighteen, Abraham worked at a small store. But he wanted more. He had read about Washington and Franklin, and he wanted to do something bigger. He sometimes walked fifteen miles to watch court trials. He even borrowed a book called The Revised Statutes of Indiana, which was not common reading for a poor boy.

One day, he listened to a famous lawyer named John A. Breckenridge defend a man accused of murder. Abraham was amazed by the speech and tried to shake the lawyer’s hand, but the man ignored him. Thirty years later, when Lincoln became President, he met Breckenridge again and thanked him for that speech.

In 1828, Abraham had a chance to travel. A man asked him to take a flatboat down the Mississippi River to New Orleans. He was paid two dollars a week and food. On the trip, he saw terrible things—Black men and women being sold as slaves. This experience made him hate slavery deeply. Years later, he would help end it.

When he turned 21, Abraham moved with his family to Illinois. He helped build a log house, plowed land, and made fences. Now that he was an adult, he could keep his own wages. Once, he split 400 fence rails just to get enough cloth to make trousers.

Abraham had no job training or money, so he worked wherever he could. Later, he helped build another flatboat and went back to New Orleans. After that, he got a job managing a store and a mill. People called him “Honest Abe” because he always told the truth and treated others fairly. Once, he realized he had charged a woman too much by six cents. That night, he walked several miles to return the money. Another time, he gave extra tea to a woman because he had used the wrong weight on the scale. People trusted him.
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
    question:
        "What does Abraham walking fifteen miles to watch court trials suggest?",
    options: [
      "A) He enjoys long walks",
      "B) He is willing to work hard to learn",
      "C) He likes seeing new towns",
      "D) He wants to meet lawyers"
    ],
    correctIndex: 1,
    explanation:
        "🚶‍♂️ The text says he 'sometimes walked fifteen miles to watch court trials,' showing his determination to learn even from far away.",
    incorrectExplanations: [
      " Incorrect. The focus isn’t on enjoying walking.",
      " Correct answer!",
      " Incorrect. He wasn’t sightseeing; he wanted to learn.",
      " Incorrect. The purpose wasn’t to meet lawyers."
    ],
  ),
  QuestionData(
    question:
        "Why did Abraham split 400 fence rails to get cloth for trousers?",
    options: [
      "A) He was determined to make money",
      "B) He liked sewing",
      "C) He enjoyed working outdoors",
      "D) He wanted to achieve his goal"
    ],
    correctIndex: 3,
    explanation:
        "🪓 The text explains he split 400 rails 'just to get enough cloth to make trousers,' showing persistence in reaching his goal.",
    incorrectExplanations: [
      " Incorrect. His focus wasn’t on earning general money, but achieving a specific goal.",
      " Incorrect. He didn’t sew the trousers himself.",
      " Incorrect. The motivation wasn’t enjoyment of work.",
      " Correct answer!"
    ],
  ),
  QuestionData(
    question: "How did Abraham’s trip to New Orleans shape his later life?",
    options: [
      "A) He avoided boats in the future",
      "B) He chose to live in New Orleans",
      "C) He started writing travel journals",
      "D) He developed a dislike for injustice"
    ],
    correctIndex: 3,
    explanation:
        "⚖️ The text says he 'saw terrible things—Black men and women being sold as slaves,' which influenced his strong dislike of injustice and slavery later in life.",
    incorrectExplanations: [
      " Incorrect. There’s no mention of avoiding boats.",
      " Incorrect. He didn’t settle in New Orleans.",
      " Incorrect. He didn’t begin writing journals.",
      " Correct answer!"
    ],
  ),
  QuestionData(
    question:
        "Why did Abraham never drink alcohol like many people around him?",
    options: [
      "A) He did not like the taste",
      "B) He remembered his mother’s advice",
      "C) He wanted to be different from others",
      "D) He was too busy working"
    ],
    correctIndex: 1,
    explanation:
        "🍷 The text says he 'never did, because his mother had told him not to,' showing that her guidance influenced him even in social situations.",
    incorrectExplanations: [
      " Incorrect. The text doesn’t mention taste as a reason.",
      " Correct answer!",
      " Incorrect. His decision was based on moral advice, not rebellion.",
      " Incorrect. Being busy wasn’t the reason given."
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

He also believed in treating women with respect. One day, when a man used bad language in front of some women, Lincoln asked him to stop. The man became angry and wanted to fight. Lincoln said, “If you need to be beaten, I guess I can do it,” and he did. The man changed and became Lincoln’s friend.

Even as President, Lincoln hated bad language. When someone cursed in front of him, he said, “I thought you were a gentleman. I was wrong. Please leave.”

To learn more, he walked six miles to buy a grammar book. Since candles were expensive, he used small pieces of wood to light his reading. He also read newspapers and took notes on politics and history.

When Mr. Offutt, the store owner, lost his business, Lincoln had to look for work again. A war with the Native American chief Black Hawk had started, and volunteers were needed. A group in New Salem chose Lincoln as their captain. He was a good leader and cared for his men. Later, he was even asked to run for the state legislature. At first, he thought it was a joke, but his friend encouraged him. Though he didn’t win, he got almost every vote in New Salem—277 out of 280. That showed how much people liked him.

Later, a surveyor asked Lincoln to be his assistant. Lincoln studied hard and learned the job in six weeks. He still dreamed of being a lawyer and continued reading law books in his free time.

Abraham Lincoln was a modest man, but within him lived a quiet fire—a deep ambition to learn, to grow, and to serve others. In the small town of New Salem, during a formative time in his life, he experienced a love that would shape his soul. Ann Rutledge, the daughter of one of his close friends, was known for her intelligence and quiet beauty. When Lincoln came to live at her father’s home, she was already engaged to a young man who had traveled to New York. At first, the man wrote regularly—letters filled with news of illness and family misfortunes—but then the letters stopped coming.

As the months passed, Lincoln and Ann grew close. Though her heart still held onto the memory of her absent fiancé, Lincoln’s quiet strength, his loyalty, and his honest affection began to reach her. Slowly, she let go of the past. A year later, she agreed to marry him. 
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
    question:
        "Why did the townspeople trust Lincoln to run for the state legislature even though he hadn’t won before?",
    options: [
      "A) He promised money",
      "B) People respected him",
      "C) He was the only candidate",
      "D) He was famous"
    ],
    correctIndex: 1,
    explanation:
        "🤝 The text says he 'got almost every vote in New Salem—277 out of 280,' showing people trusted him because of his character and how he treated others.",
    incorrectExplanations: [
      " Incorrect. He didn’t win their trust through money.",
      " Correct answer!",
      " Incorrect. There were other candidates; he earned trust through respect.",
      " Incorrect. He wasn’t yet famous at that time."
    ],
  ),
  QuestionData(
    question: "Why did Lincoln use small pieces of wood to light his reading?",
    options: [
      "A) He liked the smell of burning wood",
      "B) Candles were expensive",
      "C) He wanted to start a fire",
      "D) He didn’t have a lamp"
    ],
    correctIndex: 1,
    explanation:
        "🕯️ The text explains 'candles were expensive, so he used small pieces of wood,' showing his creativity and determination to keep learning despite hardships.",
    incorrectExplanations: [
      " Incorrect. It wasn’t about enjoying the smell.",
      " Correct answer!",
      " Incorrect. He wasn’t trying to start a fire; he needed light for reading.",
      " Incorrect. The issue was cost, not the absence of a lamp."
    ],
  ),
  QuestionData(
    question: "Who helped Lincoln grow closer to Ann Rutledge over time?",
    options: [
      "A) Her absent fiancé",
      "B) Lincoln himself",
      "C) Her father",
      "D) His friends"
    ],
    correctIndex: 1,
    explanation:
        "❤️ The text says Lincoln’s 'quiet strength, his loyalty, and his honest affection' began to reach Ann, showing his own qualities drew them closer.",
    incorrectExplanations: [
      " Incorrect. Her fiancé was absent, not involved in this relationship.",
      " Correct answer!",
      " Incorrect. Her father wasn’t mentioned as influencing their closeness.",
      " Incorrect. Lincoln’s friends had no part in this matter."
    ],
  ),
  QuestionData(
    question:
        "What does Lincoln walking six miles to buy a grammar book suggest about his environment?",
    options: [
      "A) Resources were far away",
      "B) Everything he needed was nearby",
      "C) Stores were in every town",
      "D) Books were free"
    ],
    correctIndex: 0,
    explanation:
        "📚 The text says he 'walked six miles to buy a grammar book,' indicating that educational resources were scarce and distant in his rural community.",
    incorrectExplanations: [
      " Correct answer!",
      " Incorrect. The long walk shows things weren’t close by.",
      " Incorrect. There weren’t stores in every town.",
      " Incorrect. Books had to be bought, not given freely."
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
        MaterialPageRoute(builder: (_) => FinalPath()),
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