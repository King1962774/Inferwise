import 'package:flutter/material.dart';
import 'package:inferwise/Spots/ReadingSpots/Purple/Content/Spot1/Spot_Page/reading_spot_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class JoanOfArcSplashScreen extends StatefulWidget {
  const JoanOfArcSplashScreen({super.key});

  @override
  State<JoanOfArcSplashScreen> createState() => _JoanOfArcSplashScreenState();
}

class _JoanOfArcSplashScreenState extends State<JoanOfArcSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _particlesController;
  late AnimationController _glowController;
  late Animation<double> _fadeIn;
  late Animation<double> _scaleUp;
  late Animation<double> _glowOpacity;

  static const List<_ParticleData> _particles = [
    _ParticleData(
        x: 0.08,
        y: 0.22,
        w: 10,
        h: 6,
        dur: 3200,
        delay: 0,
        dx: -6,
        dy: -11,
        shape: _ParticleShape.diamond),
    _ParticleData(
        x: 0.90,
        y: 0.17,
        w: 7,
        h: 7,
        dur: 2800,
        delay: 500,
        dx: 9,
        dy: -7,
        shape: _ParticleShape.diamond),
    _ParticleData(
        x: 0.06,
        y: 0.60,
        w: 9,
        h: 5,
        dur: 3600,
        delay: 900,
        dx: -5,
        dy: 10,
        shape: _ParticleShape.circle),
    _ParticleData(
        x: 0.92,
        y: 0.58,
        w: 6,
        h: 9,
        dur: 2500,
        delay: 300,
        dx: 8,
        dy: 7,
        shape: _ParticleShape.diamond),
    _ParticleData(
        x: 0.12,
        y: 0.40,
        w: 6,
        h: 6,
        dur: 3000,
        delay: 700,
        dx: -4,
        dy: 5,
        shape: _ParticleShape.circle),
    _ParticleData(
        x: 0.88,
        y: 0.34,
        w: 5,
        h: 5,
        dur: 3400,
        delay: 1100,
        dx: 5,
        dy: -6,
        shape: _ParticleShape.circle),
  ];

  @override
  void initState() {
    super.initState();
    _mainController =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    _fadeIn = CurvedAnimation(parent: _mainController, curve: Curves.easeIn);
    _scaleUp = Tween<double>(begin: 0.8, end: 1.2).animate(
        CurvedAnimation(parent: _mainController, curve: Curves.elasticOut));
    _mainController.forward();

    _particlesController = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this)
      ..repeat();

    _glowController = AnimationController(
        duration: const Duration(milliseconds: 2200), vsync: this)
      ..repeat(reverse: true);

    _glowOpacity = Tween<double>(begin: 0.18, end: 0.40).animate(
        CurvedAnimation(parent: _glowController, curve: Curves.easeInOut));

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const BiographyJane()));
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _particlesController.dispose();
    _glowController.dispose();
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
                  SizedBox(
                    width: 150,
                    height: 168,
                    child: AnimatedBuilder(
                      animation: Listenable.merge(
                          [_particlesController, _glowController]),
                      builder: (_, __) => CustomPaint(
                        painter: _ShieldPainter(
                          particlesT: _particlesController.value,
                          glowOpacity: _glowOpacity.value,
                          particles: _particles,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "The Story of Joan of Arc:\nChapters I – II",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E1200),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "By Andrew Lang, 1906",
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

// ─── Partículas ───────────────────────────────────────────────────────
enum _ParticleShape { circle, diamond }

class _ParticleData {
  final double x, y, w, h, dx, dy;
  final int dur, delay;
  final _ParticleShape shape;
  const _ParticleData({
    required this.x,
    required this.y,
    required this.w,
    required this.h,
    required this.dur,
    required this.delay,
    required this.dx,
    required this.dy,
    required this.shape,
  });
}

// ─── Shield CustomPainter ─────────────────────────────────────────────
class _ShieldPainter extends CustomPainter {
  final double particlesT;
  final double glowOpacity;
  final List<_ParticleData> particles;

  _ShieldPainter({
    required this.particlesT,
    required this.glowOpacity,
    required this.particles,
  });

  // Coordenadas base: viewBox 150×168
  Offset p(Size s, double x, double y) =>
      Offset(x / 150 * s.width, y / 168 * s.height);
  double sc(Size s, double v) => v / 150 * s.width;

  Paint _fill(Color c) => Paint()
    ..style = PaintingStyle.fill
    ..color = c;

  Paint _strokeP(Color c, double w) => Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..color = c
    ..strokeWidth = w;

  // Silueta del escudo heráldico
  Path _shieldPath(Size s, {double inset = 0}) {
    final tl = p(s, 20 + inset, 10 + inset);
    final tr = p(s, 130 - inset, 10 + inset);
    final bl = p(s, 20 + inset, 98);
    final br = p(s, 130 - inset, 98);
    final bot = p(s, 75, 170 - inset);
    return Path()
      ..moveTo(tl.dx, tl.dy)
      ..lineTo(tr.dx, tr.dy)
      ..lineTo(br.dx, br.dy)
      ..quadraticBezierTo(br.dx, bot.dy * 0.82, bot.dx, bot.dy)
      ..quadraticBezierTo(bl.dx, bot.dy * 0.82, bl.dx, bl.dy)
      ..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    const gold = Color(0xFFF5D060);
    // ignore: unused_local_variable
    const goldLight = Color(0xFFF5E080);
    const goldMid = Color(0xFFC8922A);
    const goldDark = Color(0xFF8B5000);
    const brown = Color(0xFF6A3E08);
    const darkBrown = Color(0xFF2E1200);
    const deepBrown = Color(0xFF3E2005);
    const rimDark = Color(0xFF4A2800);

    final shieldRect = Rect.fromLTWH(
        p(size, 20, 10).dx, p(size, 10, 10).dy, sc(size, 110), sc(size, 160));

    // ── HALO ─────────────────────────────────────────────────────
    final glowCenter = p(size, 75, 90);
    canvas.drawCircle(
      glowCenter,
      sc(size, 68),
      Paint()
        ..shader = RadialGradient(colors: [
          goldDark.withOpacity(glowOpacity),
          goldDark.withOpacity(0),
        ]).createShader(
            Rect.fromCircle(center: glowCenter, radius: sc(size, 68))),
    );

    // ── PARTÍCULAS ────────────────────────────────────────────────
    for (final pt in particles) {
      final totalMs = pt.dur + pt.delay;
      final elapsed = (particlesT * 4000) % totalMs;
      if (elapsed < pt.delay) continue;
      final prog = ((elapsed - pt.delay) / pt.dur).clamp(0.0, 1.0);
      final wave = math.sin(prog * math.pi * 2);
      final ox = pt.x * size.width + pt.dx * wave;
      final oy = pt.y * size.height + pt.dy * wave;
      final opacity = 0.26 + wave.abs() * 0.18;
      final sf = 1.0 + wave * 0.12;
      final pw = pt.w * sf / 150 * size.width;
      final ph = pt.h * sf / 168 * size.height;
      final paint = _fill(goldDark.withOpacity(opacity));
      if (pt.shape == _ParticleShape.circle) {
        canvas.drawOval(
            Rect.fromCenter(center: Offset(ox, oy), width: pw, height: ph),
            paint);
      } else {
        canvas.drawPath(
          Path()
            ..moveTo(ox, oy - ph / 2)
            ..lineTo(ox + pw / 2, oy)
            ..lineTo(ox, oy + ph / 2)
            ..lineTo(ox - pw / 2, oy)
            ..close(),
          paint,
        );
      }
    }

    // ── SOMBRA ────────────────────────────────────────────────────
    canvas.drawPath(
      _shieldPath(size),
      Paint()
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8)
        ..color = darkBrown.withOpacity(0.28),
    );

    // ── CUERPO ────────────────────────────────────────────────────
    canvas.drawPath(
      _shieldPath(size),
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [goldMid, const Color(0xFF9A6A18), brown, deepBrown],
          stops: const [0.0, 0.35, 0.72, 1.0],
        ).createShader(shieldRect),
    );

    // ── BORDE EXTERIOR ────────────────────────────────────────────
    canvas.drawPath(
      _shieldPath(size),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = sc(size, 4.0)
        ..shader = LinearGradient(
          colors: [rimDark, goldMid, gold, goldMid, rimDark],
          stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
        ).createShader(shieldRect),
    );

    // ── BORDES INTERIORES ─────────────────────────────────────────
    canvas.drawPath(_shieldPath(size, inset: 7),
        _strokeP(goldMid.withOpacity(0.50), sc(size, 1.1)));
    canvas.drawPath(_shieldPath(size, inset: 12),
        _strokeP(goldMid.withOpacity(0.22), sc(size, 0.6)));

    // ── BANDA HORIZONTAL ──────────────────────────────────────────
  }

  @override
  bool shouldRepaint(covariant _ShieldPainter old) =>
      old.particlesT != particlesT || old.glowOpacity != glowOpacity;
}

// ---------------------- Joan QUESTIONS ----------------------
class BiographyJane extends StatefulWidget {
  const BiographyJane({super.key});
  @override
  State<BiographyJane> createState() => _BiographyJaneState();
}

class _BiographyJaneState extends State<BiographyJane> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Title: The Story of Joan of Arc: Chapters I - II\n\nWhat is most likely to be described?",
      "options": [
        "The beginning of Joan’s life",
        "The details of Joan’s trial and execution",
        "Modern interpretations of Joan’s legacy",
        "A comparison with other medieval figures"
      ],
      "correct": 0,
      "feedback": [
        " Correct! Since the text focuses on Chapters I–II, it will likely introduce Joan’s early life rather than later events.",
        " Incorrect. The trial happens much later.",
        " Incorrect. Modern interpretations are not part of Chapters I–II.",
        " Incorrect. The chapters focus on Joan herself, not comparisons."
      ]
    },
    {
      "question":
          "Which two countries fought in the war that took place from 1337 to 1453 in Europe?",
      "options": [
        "England and India",
        "England and France",
        "Japan and Italy",
        "Spain and Portugal"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. India was not involved.",
        " Correct! The Hundred Years’ War was fought between England and France.",
        " Incorrect. These countries were not involved in this conflict.",
        " Incorrect. Spain and Portugal were not the main belligerents."
      ]
    },
    {
      "question": "What was a major cause of this war?",
      "options": [
        "Religious differences",
        "Competition for the Americas",
        "Control of trade with Asia",
        "Disputes over the French crown"
      ],
      "correct": 3,
      "feedback": [
        " Incorrect. Religion was not the central issue.",
        " Incorrect. This occurred much later in history.",
        " Incorrect. Asian trade was not the main cause.",
        " Correct! English kings claimed a right to the French throne, which caused conflict."
      ]
    },
    {
      "question": "Why did Joan of Arc join the French army?",
      "options": [
        "To gain wealth and land",
        "She believed God had chosen her to help France",
        "To learn military tactics and beat the English army",
        "To act as a spy and betray her country"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Joan had no interest in personal gain.",
        " Correct! She claimed to receive visions telling her to support the French king and drive out the English.",
        " Incorrect. Her goal was not training but fulfilling what she believed was a divine mission.",
        " Incorrect. Joan was fiercely loyal to France."
      ]
    },
    {
      "question": "How did Joan of Arc influence French troops?",
      "options": [
        "She provided weapons and God’s blessings",
        "She trained archers and troops",
        "She negotiated peace treaties",
        "She boosted morale and inspired soldiers"
      ],
      "correct": 3,
      "feedback": [
        " Incorrect. She did not supply weapons.",
        " Incorrect. Joan was not a military trainer.",
        " Incorrect. She did not negotiate treaties.",
        " Correct! Her leadership and faith inspired confidence and determination in French soldiers."
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
                  const JaneReadingAnimation()), //BiographyReadingPage
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

class JaneReadingAnimation extends StatefulWidget {
  const JaneReadingAnimation({super.key});

  @override
  State<JaneReadingAnimation> createState() => _JaneReadingAnimationState();
}

class _JaneReadingAnimationState extends State<JaneReadingAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _entryCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _bgCtrl;
  late final AnimationController _floatCtrl;
  late final AnimationController _particleCtrl;
  late final AnimationController _beamsCtrl;
  late final AnimationController _sunCtrl;
  late final AnimationController _linesCtrl;
  late final AnimationController _pageCtrl;
  late final AnimationController _sparkCtrl;

  late final Animation<double> _textFade;
  late final Animation<double> _textSlide;
  late final Animation<double> _dividerWidth;
  late final Animation<double> _glow;
  late final Animation<Color?> _bgColor1;
  late final Animation<Color?> _bgColor2;
  late final Animation<double> _floatY;
  late final Animation<double> _floatRock;
  late final Animation<double> _beamsOpacity;
  late final Animation<double> _sunScale;
  late final Animation<double> _rayOpacity;
  late final Animation<double> _linesOpacity;
  late final Animation<double> _linesOpacity2;
  late final Animation<double> _pageOpacity;

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

    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);
    _glow = Tween<double>(begin: 8, end: 32).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );

    _bgCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat(reverse: true);
    _bgColor1 = ColorTween(
      begin: const Color(0xFF1A0C00),
      end: const Color(0xFF2B2100),
    ).animate(_bgCtrl);
    _bgColor2 = ColorTween(
      begin: const Color(0xFFFFC107),
      end: const Color(0xFFFFF4C1),
    ).animate(_bgCtrl);

    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3800),
    )..repeat(reverse: true);
    _floatY = Tween<double>(begin: 0, end: -9).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );
    _floatRock = Tween<double>(begin: -0.021, end: 0.021).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );

    _sunCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);
    _sunScale = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _sunCtrl, curve: Curves.easeInOut),
    );
    _rayOpacity = Tween<double>(begin: 0.55, end: 1.0).animate(
      CurvedAnimation(parent: _sunCtrl, curve: Curves.easeInOut),
    );

    _linesCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _linesOpacity = Tween<double>(begin: 0.3, end: 0.85).animate(
      CurvedAnimation(parent: _linesCtrl, curve: Curves.easeInOut),
    );
    _linesOpacity2 = Tween<double>(begin: 0.85, end: 0.3).animate(
      CurvedAnimation(parent: _linesCtrl, curve: Curves.easeInOut),
    );

    _pageCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);
    _pageOpacity = Tween<double>(begin: 0.45, end: 0.72).animate(
      CurvedAnimation(parent: _pageCtrl, curve: Curves.easeInOut),
    );

    _sparkCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _particleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _beamsCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _beamsOpacity = Tween<double>(begin: 0.06, end: 0.22).animate(
      CurvedAnimation(parent: _beamsCtrl, curve: Curves.easeInOut),
    );

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
    _floatCtrl.dispose();
    _particleCtrl.dispose();
    _beamsCtrl.dispose();
    _sunCtrl.dispose();
    _linesCtrl.dispose();
    _pageCtrl.dispose();
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
          _floatCtrl,
          _particleCtrl,
          _beamsCtrl,
          _sunCtrl,
          _linesCtrl,
          _pageCtrl,
          _sparkCtrl,
        ]),
        builder: (context, _) {
          return Stack(
            fit: StackFit.expand,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _bgColor1.value ?? const Color(0xFF1A0C00),
                      const Color(0xFF2B2100),
                      const Color(0xFF8D6E00),
                      _bgColor2.value ?? const Color(0xFFFFC107),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 0.85,
                    colors: [
                      Colors.white.withOpacity(0.10),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.15,
                    colors: [
                      Colors.transparent,
                      const Color(0xFF0C0600).withOpacity(0.74),
                    ],
                  ),
                ),
              ),
              CustomPaint(painter: _BeamsPainter(opacity: _beamsOpacity.value)),
              CustomPaint(
                painter: _ParticlePainter(
                  particles: _particles,
                  progress: _particleCtrl.value,
                ),
              ),
              SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.translate(
                          offset: Offset(0, _floatY.value),
                          child: Transform.rotate(
                            angle: _floatRock.value,
                            child: SizedBox(
                              width: 150,
                              height: 130,
                              child: CustomPaint(
                                painter: _SunBookPainter(
                                  glow: _glow.value,
                                  sunScale: _sunScale.value,
                                  rayOpacity: _rayOpacity.value,
                                  linesOpacity: _linesOpacity.value,
                                  linesOpacity2: _linesOpacity2.value,
                                  pageOpacity: _pageOpacity.value,
                                  sparkProgress: _sparkCtrl.value,
                                ),
                              ),
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
                              'Time to read and reflect.\nEvery page lights up your mind.',
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

// ── Sun + Book painter ────────────────────────────────────────────────────────
class _SunBookPainter extends CustomPainter {
  final double glow;
  final double sunScale;
  final double rayOpacity;
  final double linesOpacity;
  final double linesOpacity2;
  final double pageOpacity;
  final double sparkProgress;

  const _SunBookPainter({
    required this.glow,
    required this.sunScale,
    required this.rayOpacity,
    required this.linesOpacity,
    required this.linesOpacity2,
    required this.pageOpacity,
    required this.sparkProgress,
  });

  double sx(Size s, double v) => v / 150 * s.width;
  double sy(Size s, double v) => v / 130 * s.height;
  Offset p(Size s, double px, double py) => Offset(sx(s, px), sy(s, py));

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final sunCx = sx(size, 75);
    final sunCy = sy(size, 28);

    // ── Glow halo exterior ──
    canvas.drawCircle(
      Offset(sunCx, sunCy),
      sx(size, 32),
      Paint()
        ..color = const Color(0xFFEF9F27).withOpacity(0.14)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glow * 0.9),
    );

    // ── Rayos del sol (8 rayos) ──
    final rayPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = sx(size, 2.5);

    final rays = [
      // (x1, y1, x2, y2, isMain)
      (75.0, 4.0, 75.0, 14.0, true),
      (75.0, 42.0, 75.0, 52.0, true),
      (51.0, 28.0, 41.0, 28.0, true),
      (99.0, 28.0, 109.0, 28.0, true),
      (58.0, 11.0, 51.0, 4.0, false),
      (92.0, 11.0, 99.0, 4.0, false),
      (58.0, 45.0, 51.0, 52.0, false),
      (92.0, 45.0, 99.0, 52.0, false),
    ];

    for (final ray in rays) {
      rayPaint
        ..color = (ray.$5 ? const Color(0xFFFAEEDA) : const Color(0xFFFAC775))
            .withOpacity(rayOpacity)
        ..strokeWidth = ray.$5 ? sx(size, 2.5) : sx(size, 2.0);
      canvas.drawLine(
        p(size, ray.$1, ray.$2),
        p(size, ray.$3, ray.$4),
        rayPaint,
      );
    }

    // ── Disco solar ──
    canvas.save();
    canvas.translate(sunCx, sunCy);
    canvas.scale(sunScale, sunScale);

    // Fill con gradiente
    canvas.drawCircle(
      Offset.zero,
      sx(size, 18),
      Paint()
        ..shader = const RadialGradient(
          colors: [Color(0xFFFAEEDA), Color(0xFFFAC775), Color(0xFFEF9F27)],
          stops: [0.0, 0.5, 1.0],
        ).createShader(
          Rect.fromCircle(center: Offset.zero, radius: sx(size, 18)),
        ),
    );
    // Brillo interior
    canvas.drawCircle(
        Offset.zero,
        sx(size, 18),
        Paint()
          ..shader = RadialGradient(
            colors: [
              Colors.white.withOpacity(0.8),
              Colors.white.withOpacity(0.0),
            ],
            stops: const [0.0, 1.0],
          ).createShader(
            Rect.fromCircle(center: Offset.zero, radius: sx(size, 18)),
          ));

    // Cara — ojos
    canvas.drawCircle(
      Offset(-sx(size, 5), -sy(size, 2)),
      sx(size, 2.5),
      Paint()..color = const Color(0xFF412402),
    );
    canvas.drawCircle(
      Offset(sx(size, 5), -sy(size, 2)),
      sx(size, 2.5),
      Paint()..color = const Color(0xFF412402),
    );

    // Cara — sonrisa
    final smilePath = Path()
      ..moveTo(-sx(size, 6), sy(size, 4))
      ..quadraticBezierTo(0, sy(size, 9), sx(size, 6), sy(size, 4));
    canvas.drawPath(
      smilePath,
      Paint()
        ..color = const Color(0xFF412402)
        ..style = PaintingStyle.stroke
        ..strokeWidth = sx(size, 1.5)
        ..strokeCap = StrokeCap.round,
    );

    canvas.restore();

    // ── Tapa izquierda libro ──
    final leftCover = Path()
      ..moveTo(sx(size, 10), sy(size, 68))
      ..quadraticBezierTo(
          sx(size, 10), sy(size, 64), sx(size, 13), sy(size, 64))
      ..lineTo(sx(size, 72), sy(size, 64))
      ..lineTo(sx(size, 72), sy(size, 122))
      ..lineTo(sx(size, 13), sy(size, 122))
      ..quadraticBezierTo(
          sx(size, 10), sy(size, 122), sx(size, 10), sy(size, 119))
      ..close();
    canvas.drawPath(
      leftCover,
      Paint()
        ..shader = LinearGradient(
          colors: const [Color(0xFFFAC775), Color(0xFF854F0B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(
          Rect.fromLTWH(sx(size, 10), sy(size, 64), sx(size, 62), sy(size, 58)),
        ),
    );
    canvas.drawPath(
      leftCover,
      Paint()
        ..color = const Color(0xFFBA7517)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.9,
    );

    // ── Lomo ──
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(sx(size, 70), sy(size, 64), sx(size, 10), sy(size, 58)),
        const Radius.circular(1),
      ),
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFFEF9F27), Color(0xFF412402)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(
          Rect.fromLTWH(sx(size, 70), sy(size, 64), sx(size, 10), sy(size, 58)),
        ),
    );

    // ── Tapa derecha libro ──
    final rightCover = Path()
      ..moveTo(sx(size, 80), sy(size, 64))
      ..lineTo(sx(size, 137), sy(size, 64))
      ..quadraticBezierTo(
          sx(size, 140), sy(size, 64), sx(size, 140), sy(size, 68))
      ..lineTo(sx(size, 140), sy(size, 119))
      ..quadraticBezierTo(
          sx(size, 140), sy(size, 122), sx(size, 137), sy(size, 122))
      ..lineTo(sx(size, 80), sy(size, 122))
      ..close();
    canvas.drawPath(
      rightCover,
      Paint()
        ..shader = LinearGradient(
          colors: const [Color(0xFFFAC775), Color(0xFFBA7517)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ).createShader(
          Rect.fromLTWH(sx(size, 80), sy(size, 64), sx(size, 60), sy(size, 58)),
        ),
    );
    canvas.drawPath(
      rightCover,
      Paint()
        ..color = const Color(0xFFBA7517)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.9,
    );

    // ── Páginas izquierda ──
    canvas.drawRect(
      Rect.fromLTWH(sx(size, 13), sy(size, 64), sx(size, 57), sy(size, 58)),
      Paint()
        ..shader = LinearGradient(
          colors: [
            const Color(0xFFFAEEDA),
            const Color(0xFFFAC775).withOpacity(0.55),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(Rect.fromLTWH(sx(size, 13), 0, sx(size, 57), h)),
    );

    // ── Páginas derecha ──
    canvas.drawRect(
      Rect.fromLTWH(sx(size, 80), sy(size, 64), sx(size, 57), sy(size, 58)),
      Paint()
        ..shader = LinearGradient(
          colors: [
            const Color(0xFFFAC775).withOpacity(0.55),
            const Color(0xFFFAEEDA),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(Rect.fromLTWH(sx(size, 80), 0, sx(size, 57), h)),
    );

    // ── Líneas texto izquierda ──
    final leftYs = [75.0, 83.0, 91.0, 99.0, 107.0, 115.0];
    final leftWs = [44.0, 44.0, 37.0, 44.0, 32.0, 44.0];
    for (int i = 0; i < leftYs.length; i++) {
      canvas.drawLine(
        p(size, 18, leftYs[i]),
        Offset(sx(size, 18) + sx(size, leftWs[i]), sy(size, leftYs[i])),
        Paint()
          ..color = const Color(0xFFBA7517)
              .withOpacity(linesOpacity * (0.65 - i * 0.04))
          ..strokeWidth = i < 2 ? 1.1 : 1.0
          ..strokeCap = StrokeCap.round,
      );
    }

    // ── Líneas texto derecha ──
    final rightYs = [75.0, 83.0, 91.0, 99.0, 107.0, 115.0];
    final rightWs = [48.0, 48.0, 39.0, 48.0, 33.0, 48.0];
    for (int i = 0; i < rightYs.length; i++) {
      canvas.drawLine(
        p(size, 85, rightYs[i]),
        Offset(sx(size, 85) + sx(size, rightWs[i]), sy(size, rightYs[i])),
        Paint()
          ..color = const Color(0xFFBA7517)
              .withOpacity(linesOpacity2 * (0.65 - i * 0.04))
          ..strokeWidth = i < 2 ? 1.1 : 1.0
          ..strokeCap = StrokeCap.round,
      );
    }

    // ── Página volando ──
    final flutterPath = Path()
      ..moveTo(sx(size, 72), sy(size, 80))
      ..quadraticBezierTo(
          sx(size, 84), sy(size, 74), sx(size, 96), sy(size, 80))
      ..lineTo(sx(size, 96), sy(size, 112))
      ..quadraticBezierTo(
          sx(size, 84), sy(size, 106), sx(size, 72), sy(size, 112))
      ..close();
    canvas.drawPath(
      flutterPath,
      Paint()..color = const Color(0xFFFAEEDA).withOpacity(pageOpacity),
    );

    // ── Sombra libro ──
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, sy(size, 126)),
        width: w * 0.70,
        height: h * 0.06,
      ),
      Paint()
        ..color = const Color(0xFF1A0C00).withOpacity(0.25)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );

    // ── Chispas ──
    final sparks = [
      (sx(size, 42), sy(size, 6), 0.1),
      (sx(size, 110), sy(size, 4), 0.6),
      (sx(size, 6), sy(size, 82), 0.9),
      (sx(size, 145), sy(size, 80), 0.4),
      (sx(size, 28), sy(size, 56), 1.3),
      (sx(size, 124), sy(size, 54), 0.7),
    ];
    for (final sp in sparks) {
      final phase = (sparkProgress + sp.$3) % 1.0;
      final s = math.sin(phase * math.pi).clamp(0.0, 1.0);
      canvas.drawCircle(
        Offset(sp.$1, sp.$2),
        2.5 * s,
        Paint()
          ..color = const Color(0xFFFAEEDA).withOpacity(s)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3 * s),
      );
    }
  }

  @override
  bool shouldRepaint(_SunBookPainter old) =>
      old.glow != glow ||
      old.sunScale != sunScale ||
      old.rayOpacity != rayOpacity ||
      old.linesOpacity != linesOpacity ||
      old.linesOpacity2 != linesOpacity2 ||
      old.pageOpacity != pageOpacity ||
      old.sparkProgress != sparkProgress;
}

// ── Beams ─────────────────────────────────────────────────────────────────────
class _BeamsPainter extends CustomPainter {
  final double opacity;
  const _BeamsPainter({required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    const beams = [
      (frac: 0.28, angle: -0.38, alpha: 1.0),
      (frac: 0.50, angle: -0.26, alpha: 0.70),
      (frac: 0.68, angle: -0.18, alpha: 0.40),
    ];
    for (final b in beams) {
      final cx = size.width * b.frac;
      final paint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFFFFF4C1).withOpacity(opacity * b.alpha),
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

// ── Particles ─────────────────────────────────────────────────────────────────
class _Particle {
  final double x, size, speed, offset;
  final Color color;
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
CHAPTER I. THE CHILDHOOD OF JOAN OF ARC

Joan of Arc was one of the most amazing people in history. Her story is so surprising that it’s hard to believe it really happened—except that it was written down by her enemies while she was still alive. Joan was burned at the stake when she was only nineteen years old. But before that, when she was not even seventeen, she led the French army to victory and helped save her country from the English.

Joan was the daughter of a poor farmer and lived in a small village. She didn’t know how to read, write, or even ride a horse at first. But she was very smart—so smart that even educated men couldn’t confuse her with difficult questions. She became one of the best horse riders and was very good at using cannons. She was a great leader and won many battles. Her army was never defeated until her king abandoned her.

Even when she was badly wounded, Joan stayed strong and continued to lead her soldiers. She was also kind. She helped wounded English soldiers and protected them from cruelty. Joan was so good that even her enemies couldn’t find anything truly bad to say about her. And even when she was famous and successful, she still dreamed of being at home, sewing with her mother.

Joan was born on January 6, 1412, in the village of Domremy, in eastern France. At that time, life in France was very difficult. For nearly a hundred years, the kings of England had been trying to take over France—just as they had tried to take over Scotland. Sometimes the Scots helped the French in battle, just as the French helped the Scots at other times.

Eight years before Joan was born, something sad happened. King Henry V of England married Princess Katherine of France. Some tired French leaders agreed that the child of Henry and Katherine should become the new King of France. This was instead of the son of the old French king. That son was called the "Dauphin," which was the title given to the king’s oldest son. His name was Charles.
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
        "Joan was the daughter of a poor farmer, but very smart and brave.\n\nWhat will most likely happen as she grows older?",
    options: [
      "A) She will remain unknown in her small village",
      "B) She will become a merchant",
      "C) She will stop caring about France",
      "D) She will become an important leader"
    ],
    correctIndex: 3,
    explanation:
        "Her intelligence and bravery hint that she will rise above her humble beginnings to lead others.",
    incorrectExplanations: [
      " Incorrect. Joan will not stay unknown given her abilities and destiny.",
      " Incorrect. The story does not suggest she will become a merchant.",
      " Incorrect. She becomes even more committed to France, not less.",
      " Correct! Her qualities foreshadow her becoming an important leader."
    ],
  ),
  QuestionData(
    question:
        "Some French leaders agreed that Henry V’s son should rule France instead of the Dauphin, Charles.\n\nWhat is most likely to happen later?",
    options: [
      "A) Everyone will agree peacefully",
      "B) There will be conflict over who is the true king",
      "C) Charles will give up without trying",
      "D) The English will leave France alone"
    ],
    correctIndex: 1,
    explanation:
        "Competing claims to the throne usually lead to disputes, which Joan’s story will later connect to.",
    incorrectExplanations: [
      " Incorrect. Peaceful agreement is unlikely given the controversy.",
      " Correct! Rival claims typically result in conflict.",
      " Incorrect. Charles historically did not give up easily.",
      " Incorrect. The English did not simply withdraw at this point in history."
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

class _BiographyReadingPageSecondState
    extends State<BiographyReadingPageSecond> {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  final String biographyTextSecond = '''
Charles's supporters continued to fight the English, but he was not officially made King. In France, kings were crowned in the Cathedral of Rheims using special holy oil. This oil was believed to have come from heaven, brought by an angel to a saint. Without this ceremony in Rheims, a new king wasn’t seen as truly crowned. But Rheims was under English control, so Charles couldn’t go there. Some people even said he wasn’t really the old king’s son. This made him very sad. But Joan would later change everything and help him become King for real—something no army had been able to do.

At the same time, France was split into two groups. Some supported the Dauphin Charles. Others, especially people in Burgundy and the powerful Duke of Burgundy, supported the English. These groups fought each other fiercely. Poor people suffered the most. Soldiers often weren’t paid, so they stole from farms and towns. Villages were destroyed, fields were empty, and roads were overgrown. People had to hide in the woods with their animals when soldiers came. Even noblemen and knights became leaders of robber bands. It didn’t matter who won battles—villagers were always in danger.

Joan grew up in this time of suffering. Her village supported the Dauphin, which was the right side. But the nearby village of Maxey supported the English. The boys from both places often fought each other with sticks and stones. Joan’s brothers, Peter and John, came home with bruises and bloody noses, but Joan did not join these fights.

Her village was near a strong town called Vaucouleurs, which also supported the Dauphin. When Joan was little, her village was not attacked very often. But she still heard stories about the suffering in other parts of France. She once said, “There was great pity in France.” And sometimes, she saw it with her own eyes.

One time, some soldiers working for a man named Henry d’Orly came to her village and stole all the cows. But a noble lady in a nearby castle sent help. Her friend gathered some soldiers who chased after the thieves. The robbers couldn’t move fast because the cows were slow. The helpers caught up with them in a small town, where the robbers were drinking in wine shops. The good soldiers surprised them, and after a short fight, they brought the cows back to the village.
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
        "The nearby village of Maxey supported the English, while Joan’s village supported the Dauphin.\n\nWhat is most likely to happen in Joan’s youth?",
    options: [
      "A) Joan will join in the stick fights",
      "B) There will be constant small conflicts",
      "C) The two villages will sign a peace treaty",
      "D) Maxey will surrender peacefully"
    ],
    correctIndex: 1,
    explanation:
        "The rivalry between villages suggests these local fights will keep happening.",
    incorrectExplanations: [
      " Incorrect. This option focuses on Joan personally, but the question is about general events.",
      " Correct! The tension between the English-supporting and Dauphin-supporting villages makes ongoing conflicts likely.",
      " Incorrect. A peace treaty is unlikely given the hostility described.",
      " Incorrect. Maxey is not shown as willing to surrender peacefully."
    ],
  ),
  QuestionData(
    question:
        "Joan grew up in a village that supported the Dauphin Charles, hearing about the struggles across France.\n\n What is most likely to happen when Joan grows older?",
    options: [
      "A) She will stay in her village forever",
      "B) She will move to Burgundy for peace",
      "C) She will switch sides and support the English",
      "D) She will join the Dauphin's army"
    ],
    correctIndex: 3,
    explanation:
        "The text foreshadows Joan’s later role in supporting the Dauphin and fighting for France.",
    incorrectExplanations: [
      " Incorrect. Joan’s life story moves far beyond her home village.",
      " Incorrect. Burgundy was allied with England at the time, so moving there for peace is unlikely.",
      " Incorrect. Nothing suggests Joan would ever switch sides to support the English.",
      " Correct! Her upbringing in a Dauphin-supporting village foreshadows her loyalty and later involvement."
    ],
  )
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

class _BiographyReadingPageThirdState extends State<BiographyReadingPageThird> {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  final String biographyTextSecond = '''
Another time, all the people of Domremy had to run away and stay in a town called Neufchâteau. There, they were safe behind the city walls. They only stayed for a short time. Later, the English claimed that Joan had worked in an inn there and had learned to ride horses—but that was not true.

There were beautiful woods near Joan’s village. In one of the oak woods, there was a special tree called the Fairy Tree. People believed that a beautiful fairy used to meet her lover under that tree, just like in other old legends. The village children liked to take cakes, make small feasts, and hang flower garlands on the tree. But Joan was not very interested in fairy tales. Instead, she preferred to place her flowers in front of the statues of saints in the village church, especially Saint Catherine and Saint Margaret.

All this happened many years before the Reformation, a time when Protestants broke the statues of saints in churches, smashed their pictures in the windows, and even destroyed a beautiful statue of Joan on a bridge in the city of Orléans. That was more than a hundred years after Joan had died.
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
        "Joan preferred placing flowers in front of saints’ statues rather than following fairy tales.\n\nWhat is most likely to happen as Joan grows older?",
    options: [
      "A) She will become fascinated with fairy tales and legends",
      "B) She will continue to focus on her faith and saints",
      "C) She will leave her village to live in the woods",
      "D) She will start a bakery in her village"
    ],
    correctIndex: 1,
    explanation:
        "Joan's early preference for honoring saints instead of fairy tales suggests she will continue to be guided by faith and religious devotion as she grows older.",
    incorrectExplanations: [
      "Incorrect. Joan has shown no interest in fairy tales and legends.",
      "Correct! Her devotion to saints indicates she will remain focused on faith.",
      "Incorrect. There is no evidence she plans to isolate herself geographically.",
      "Incorrect. Her interests are spiritual, not related to baking."
    ],
  ),
  QuestionData(
    question:
        "Villagers decorated the Fairy Tree with cakes and flowers, but Joan was not interested.\n\nWhat is most likely to happen as she grows older?",
    options: [
      "A) She will focus on practical and meaningful actions",
      "B) She will become a storyteller of fairy tales",
      "C) She will lead village festivals around the Fairy Tree",
      "D) She will ignore religion entirely"
    ],
    correctIndex: 0,
    explanation:
        "Joan's preference for meaningful devotion over fantasy indicates she will likely continue focusing on practical or purposeful actions in her life.",
    incorrectExplanations: [
      "Correct! Her actions show she values meaningful devotion over fantasy.",
      "Incorrect. She has shown disinterest in fairy tales.",
      "Incorrect. She is not motivated by festivals or fairy lore.",
      "Incorrect. Her behavior shows strong religious inclination, not rejection."
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

class _BiographyReadingPageFinalState extends State<BiographyReadingPageFinal> {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  final String biographyTextSecond = '''
Although Joan could run faster than the other children and win races, she liked being quiet. She was very good at sewing and spinning, and she loved praying alone in church. Sometimes she went to quiet places away from the other children to pray to God to help France. The church services, the singing, and the music made her feel happy. When she heard the church bells from far away, she would stop and say a prayer.

She was very kind. If a poor traveler came to their house, Joan gave up her bed and slept near the fireplace. She also helped the sick, and if she had any money, she gave it to the church so Masses could be said for the souls of others.

Joan lived like this until she was thirteen years old. She was strong, beautiful, and had black hair. We don’t know the exact color of her eyes, but they were probably brown or dark gray. A young knight who saw her for the first time wrote to his mother and said she was “a creature all divine,” meaning he thought she looked almost like an angel.
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
        "Joan gave up her bed for travelers and helped the sick.\n\nWhat is most likely to happen later in her life?",
    options: [
      "A) She will ignore the needs of others",
      "B) She will focus only on winning races",
      "C) She will develop a strong sense of compassion",
      "D) She will become interested only in fashion"
    ],
    correctIndex: 2,
    explanation:
        "Joan's generosity and care for others indicate she will grow into a compassionate and selfless person.",
    incorrectExplanations: [
      "Incorrect. Joan already shows concern for others, so she is unlikely to ignore them.",
      "Incorrect. Nothing suggests she is focused on competition or winning.",
      "Correct! Her willingness to give up her bed for others shows strong compassion.",
      "Incorrect. Joan shows no interest in fashion or superficial concerns."
    ],
  ),
  QuestionData(
    question:
        "A young knight called her “a creature all divine.”\n\nWhat is most likely to happen as Joan grows older?",
    options: [
      "A) People will notice her extraordinary character",
      "B) She will live entirely in obscurity",
      "C) People will only comment on her hair",
      "D) She will stop interacting with others"
    ],
    correctIndex: 0,
    explanation:
        "Joan’s remarkable appearance and character hint that she will continue to attract attention for her abilities and personality.",
    incorrectExplanations: [
      "Correct! Her character already draws admiration and will likely continue to do so.",
      "Incorrect. The text suggests increasing recognition, not obscurity.",
      "Incorrect. People admire more than her appearance—they notice her character.",
      "Incorrect. There is no indication she will isolate herself socially."
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
