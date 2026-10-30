import 'package:flutter/material.dart';
import 'package:inferwise/Spots/ReadingSpots/Orange/Content/Spot1/Spot_Page/reading_spot_page.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: unused_import
import 'dart:math' as math;


// ── Reemplaza con tu import real ──────────────────────────────────
// import 'biography_aeroplane.dart';
// ─────────────────────────────────────────────────────────────────

class AeroplaneSplashScreen extends StatefulWidget {
  const AeroplaneSplashScreen({super.key});

  @override
  State<AeroplaneSplashScreen> createState() => _AeroplaneSplashScreenState();
}

class _AeroplaneSplashScreenState extends State<AeroplaneSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _flyController;
  late AnimationController _cloudController;
  late Animation<double> _fadeIn;
  late Animation<double> _scaleUp;

  // Avión: posición X, Y y estela
  late Animation<double> _planeX;
  late Animation<double> _planeY;
  late Animation<double> _trailWidth;
  late Animation<double> _trailOpacity;

  // Nubes
  late Animation<double> _cloud1X;
  late Animation<double> _cloud2X;
  late Animation<double> _cloud3X;

  @override
  void initState() {
    super.initState();

    // ── Animación principal ────────────────────────────────────────
    _mainController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _fadeIn  = CurvedAnimation(parent: _mainController, curve: Curves.easeIn);
    _scaleUp = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.elasticOut),
    );
    _mainController.forward();

    // ── Avión volando (3.8 s loop) ────────────────────────────────
    _flyController = AnimationController(
      duration: const Duration(milliseconds: 3800),
      vsync: this,
    )..repeat();

    _planeX = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: -30.0, end: 10.0),  weight: 30),
      TweenSequenceItem(tween: Tween(begin: 10.0,  end: 30.0),  weight: 30),
      TweenSequenceItem(tween: Tween(begin: 30.0,  end: -30.0), weight: 40),
    ]).animate(CurvedAnimation(parent: _flyController, curve: Curves.easeInOut));

    _planeY = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0,  end: -8.0), weight: 30),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: -4.0), weight: 30),
      TweenSequenceItem(tween: Tween(begin: -4.0, end: 0.0),  weight: 40),
    ]).animate(CurvedAnimation(parent: _flyController, curve: Curves.easeInOut));

    _trailWidth = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0,  end: 50.0), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 50.0, end: 35.0), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 35.0, end: 0.0),  weight: 30),
    ]).animate(CurvedAnimation(parent: _flyController, curve: Curves.easeInOut));

    _trailOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.5), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 0.3), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.3, end: 0.0), weight: 30),
    ]).animate(CurvedAnimation(parent: _flyController, curve: Curves.easeInOut));

    // ── Nubes flotando ────────────────────────────────────────────
    _cloudController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat(reverse: true);

    _cloud1X = Tween<double>(begin: 0.0, end: -6.0).animate(
      CurvedAnimation(parent: _cloudController,
          curve: const Interval(0.0, 0.5, curve: Curves.easeInOut)));
    _cloud2X = Tween<double>(begin: 0.0, end: 6.0).animate(
      CurvedAnimation(parent: _cloudController,
          curve: const Interval(0.2, 0.7, curve: Curves.easeInOut)));
    _cloud3X = Tween<double>(begin: 0.0, end: -5.0).animate(
      CurvedAnimation(parent: _cloudController,
          curve: const Interval(0.4, 1.0, curve: Curves.easeInOut)));

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BiographyAeroplane()),
      );
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _flyController.dispose();
    _cloudController.dispose();
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

                  // ── Escena: nubes + ícono de avión + estela ────────
                  AnimatedBuilder(
                    animation: Listenable.merge([_flyController, _cloudController]),
                    builder: (_, __) {
                      return SizedBox(
                        width: 160,
                        height: 100,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Nubes de fondo
                            CustomPaint(
                              size: const Size(160, 100),
                              painter: _CloudsPainter(
                                cloud1X: _cloud1X.value,
                                cloud2X: _cloud2X.value,
                                cloud3X: _cloud3X.value,
                              ),
                            ),

                            // Estela detrás del ícono
                            Positioned(
                              left: 80 + _planeX.value - _trailWidth.value - 20,
                              top:  50 + _planeY.value - 1,
                              child: Container(
                                width:  _trailWidth.value,
                                height: 2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1),
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFF8B5000).withOpacity(0.0),
                                      const Color(0xFF8B5000).withOpacity(_trailOpacity.value),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // Ícono del avión
                            Positioned(
                              left: 80 + _planeX.value - 28,
                              top:  50 + _planeY.value - 28,
                              child: const Icon(
                                Icons.flight,
                                color: Color(0xFF8B5000),
                                size: 56,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                  Text(
                    "The Wright Brothers' Aeroplane",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E1200),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    "By Orville and Wilbur Wright, 1922",
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

// ─── Nubes — CustomPainter ────────────────────────────────────────────
class _CloudsPainter extends CustomPainter {
  final double cloud1X, cloud2X, cloud3X;
  _CloudsPainter({required this.cloud1X, required this.cloud2X, required this.cloud3X});

  @override
  void paint(Canvas canvas, Size size) {
    const brown = Color(0xFF8B5000);
    _drawCloud(canvas, size.width * 0.14 + cloud1X, size.height * 0.22, 18, brown);
    _drawCloud(canvas, size.width * 0.72 + cloud2X, size.height * 0.18, 15, brown);
    _drawCloud(canvas, size.width * 0.38 + cloud3X, size.height * 0.75, 13, brown);
  }

  void _drawCloud(Canvas canvas, double x, double y, double r, Color color) {
    final fill = Paint()..color = color.withOpacity(0.18)..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(x,             y),          r,         fill);
    canvas.drawCircle(Offset(x + r,         y - r * 0.4), r * 0.75, fill);
    canvas.drawCircle(Offset(x + r * 1.6,   y),          r * 0.65,  fill);
  }

  @override
  bool shouldRepaint(covariant _CloudsPainter old) =>
      old.cloud1X != cloud1X || old.cloud2X != cloud2X || old.cloud3X != cloud3X;
}

// ---------------------- Aeroplane QUESTIONS ----------------------
class BiographyAeroplane extends StatefulWidget {
  const BiographyAeroplane({super.key});
  @override
  State<BiographyAeroplane> createState() => _BiographyAeroplaneState();
}

class _BiographyAeroplaneState extends State<BiographyAeroplane> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "What was the name of the first successful airplane built by the Wright brothers?",
      "options": [
        "A) The Spirit of St. Louis",
        "B) The Curtiss Pusher",
        "C) The Flyer",
        "D) The Kitty Hawk"
      ],
      "correct": 2,
      "feedback": [
        " Incorrect. The Spirit of St. Louis was flown by Charles Lindbergh, not the Wright brothers.",
        " No, the Curtiss Pusher was a later aircraft design by Glenn Curtiss.",
        "✈️ Correct! The Wright Flyer, also known as the Flyer I, was the first successful powered airplane built and flown by the Wright brothers.",
        " The Kitty Hawk was the location of their flight, not the name of the airplane."
      ]
    },
    {
      "question":
          "What year did the Wright brothers achieve their first successful powered flight?",
      "options": ["A) 1905", "B) 1903", "C) 1909", "D) 1899"],
      "correct": 1,
      "feedback": [
        " Not quite. By 1905 they were improving their designs, but the first flight was earlier.",
        "✈️ Correct! The historic first flight took place on December 17, 1903, marking a milestone in aviation history.",
        " Incorrect. 1909 was when they began public demonstrations, not their first success.",
        " Too early. They were still experimenting with gliders in 1899."
      ]
    },
    {
      "question":
          "Where did the Wright brothers conduct their first successful flight?",
      "options": [
        "A) Dayton, Ohio",
        "B) Washington, D.C.",
        "C) Kitty Hawk, North Carolina",
        "D) Kill Devil Hills, North Carolina"
      ],
      "correct": 2,
      "feedback": [
        " They built and tested models in Dayton, but the flight occurred elsewhere.",
        " Incorrect. Washington was not involved in their tests.",
        "✈️ Correct! The strong winds and soft sand dunes of Kitty Hawk, North Carolina, made it ideal for their flight experiments.",
        " Close, but Kitty Hawk is the correct general area commonly referenced."
      ]
    },
    {
      "question":
          "Which of the following was a key innovation of the Wright brothers' design that allowed for better control of the aircraft?",
      "options": [
        "A) Wing warping",
        "B) Fixed wings",
        "C) Jet propulsion",
        "D) Dual propellers"
      ],
      "correct": 0,
      "feedback": [
        "Correct: Wing warping was a method of twisting the wings to control roll and make turns",
        " Fixed wings would make control difficult.",
        " Jet propulsion did not exist at the time.",
        " Dual propellers were used, but the innovation for control was wing warping."
      ]
    },
    {
      "question":
          "What primary profession did the Wright brothers have before they began their work in aviation?",
      "options": [
        "A) Mechanics",
        "B) Printers",
        "C) Inventors",
        "D) Bicycle manufacturers"
      ],
      "correct": 3,
      "feedback": [
        " They had mechanical skills, but their main business was not general mechanics.",
        " They did some printing earlier, but their major work came later.",
        " While they were indeed inventors, their main trade was more specific.",
        "🚲 Correct! The Wright brothers owned and operated a bicycle shop in Dayton, Ohio, which funded and inspired their aviation work."
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
          MaterialPageRoute(builder: (_) => const AeroplaneReadingAnimation()),
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



class AeroplaneReadingAnimation extends StatefulWidget {
  const AeroplaneReadingAnimation({super.key});

  @override
  State<AeroplaneReadingAnimation> createState() =>
      _AeroplaneReadingAnimationState();
}

class _AeroplaneReadingAnimationState extends State<AeroplaneReadingAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _entryCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _bgCtrl;
  late final AnimationController _floatCtrl;
  late final AnimationController _particleCtrl;
  late final AnimationController _beamsCtrl;
  late final AnimationController _trailCtrl;
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
  late final Animation<double> _trail1;
  late final Animation<double> _trail2;
  late final Animation<double> _trail3;

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
      end: const Color(0xFF3A2400),
    ).animate(_bgCtrl);
    _bgColor2 = ColorTween(
      begin: const Color(0xFFD4AF37),
      end: const Color(0xFFFFF3C1),
    ).animate(_bgCtrl);

    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    )..repeat(reverse: true);
    _floatY = Tween<double>(begin: 0, end: -10).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );
    _floatRock = Tween<double>(begin: -0.035, end: 0.035).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );

    _trailCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _trail1 = CurvedAnimation(
      parent: _trailCtrl,
      curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    );
    _trail2 = CurvedAnimation(
      parent: _trailCtrl,
      curve: const Interval(0.17, 1.0, curve: Curves.easeOut),
    );
    _trail3 = CurvedAnimation(
      parent: _trailCtrl,
      curve: const Interval(0.33, 1.0, curve: Curves.easeOut),
    );

    _sparkCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
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
    _trailCtrl.dispose();
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
          _bgCtrl, _glowCtrl, _floatCtrl, _particleCtrl,
          _beamsCtrl, _trailCtrl, _sparkCtrl,
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
                      const Color(0xFF3A2400),
                      const Color(0xFF9E7C00),
                      _bgColor2.value ?? const Color(0xFFD4AF37),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
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
                              width: 130,
                              height: 130,
                              child: CustomPaint(
                                painter: _PlaneIconPainter(
                                  glow: _glow.value,
                                  trail1: _trail1.value,
                                  trail2: _trail2.value,
                                  trail3: _trail3.value,
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
                              'Innovation takes courage.\nKnowledge gives us wings.\nHistory rises with every idea.',
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
                                    color: const Color(0xFFEF9F27).withOpacity(0.9),
                                    blurRadius: _glow.value,
                                  ),
                                  Shadow(
                                    color: const Color(0xFFBA7517).withOpacity(0.55),
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

// ── Plane icon painter ────────────────────────────────────────────────────────
class _PlaneIconPainter extends CustomPainter {
  final double glow;
  final double trail1;
  final double trail2;
  final double trail3;
  final double sparkProgress;

  const _PlaneIconPainter({
    required this.glow,
    required this.trail1,
    required this.trail2,
    required this.trail3,
    required this.sparkProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final iconSize = size.width * 0.55;

    // ── Glow halo ──
    canvas.drawCircle(
      Offset(cx, cy),
      iconSize * 0.72,
      Paint()
        ..color = const Color(0xFFEF9F27).withOpacity(0.15)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glow * 0.9),
    );

    // ── Estelas animadas ──
    final trailData = [
      (width: size.width * 0.32, y: cy - 8.0, opacity: trail1, height: 2.0),
      (width: size.width * 0.25, y: cy - 0.5, opacity: trail2, height: 1.5),
      (width: size.width * 0.18, y: cy + 7.0, opacity: trail3, height: 1.0),
    ];

    final trailColors = [
      const Color(0xFFFAC775),
      const Color(0xFFEF9F27),
      const Color(0xFFBA7517),
    ];

    for (int i = 0; i < trailData.length; i++) {
      final t = trailData[i];
      final startX = cx - iconSize * 0.5 - t.width;
      final fadeOpacity = (1.0 - trailData[i].opacity).clamp(0.0, 1.0) * 0.85;
      final paint = Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.transparent,
            trailColors[i].withOpacity(fadeOpacity),
            const Color(0xFFFAEEDA).withOpacity(fadeOpacity * 0.6),
          ],
        ).createShader(Rect.fromLTWH(startX, t.y, t.width, t.height));
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(startX, t.y, t.width, t.height),
          const Radius.circular(2),
        ),
        paint,
      );
    }

    // ── Ícono flight_takeoff (Material Icons path) ──
    // Escalado y centrado
    final scale = iconSize / 24.0;
    canvas.save();
    canvas.translate(cx - 12 * scale, cy - 12 * scale);
    canvas.scale(scale, scale);

    final iconPath = Path()
      ..moveTo(2.5, 19)
      ..lineTo(21.5, 19)
      ..lineTo(21.5, 21)
      ..lineTo(2.5, 21)
      ..close()
      ..moveTo(9.68, 17.27)
      ..lineTo(14.03, 18.43)
      ..lineTo(19.34, 19.85)
      ..cubicTo(20.14, 20.06, 20.96, 19.59, 21.18, 18.79)
      ..cubicTo(21.39, 17.99, 20.92, 17.17, 20.12, 16.95)
      ..lineTo(14.81, 15.53)
      ..lineTo(12.05, 8.09)
      ..lineTo(11.12, 7.84)
      ..lineTo(11.12, 15.93)
      ..lineTo(9.68, 15.54)
      ..lineTo(7.84, 13.58)
      ..lineTo(6.43, 13.20)
      ..lineTo(6.05, 15.79)
      ..lineTo(8.68, 17.27)
      ..close();

    // Sombra del path
    canvas.drawPath(
      iconPath,
      Paint()
        ..color = const Color(0xFFEF9F27).withOpacity(0.5)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glow * 0.4 / scale),
    );

    // Fill con gradiente
    canvas.drawPath(
      iconPath,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFFFAEEDA), Color(0xFFFAC775), Color(0xFFEF9F27)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(const Rect.fromLTWH(0, 0, 24, 24)),
    );

    // Stroke fino
    canvas.drawPath(
      iconPath,
      Paint()
        ..color = const Color(0xFFFAEEDA).withOpacity(0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.3,
    );

    canvas.restore();

    // ── Chispas ──
    final sparks = [
      (cx + iconSize * 0.52, cy - iconSize * 0.38, 0.1),
      (cx + iconSize * 0.60, cy - iconSize * 0.10, 0.55),
      (cx + iconSize * 0.50, cy + iconSize * 0.28, 0.85),
      (cx - iconSize * 0.58, cy - iconSize * 0.28, 1.2),
    ];
    for (final sp in sparks) {
      final phase = (sparkProgress + sp.$3) % 1.0;
      final s = math.sin(phase * math.pi).clamp(0.0, 1.0);
      canvas.drawCircle(
        Offset(sp.$1, sp.$2),
        3.0 * s,
        Paint()
          ..color = const Color(0xFFFAEEDA).withOpacity(s)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3 * s),
      );
    }
  }

  @override
  bool shouldRepaint(_PlaneIconPainter old) =>
      old.glow != glow ||
      old.trail1 != trail1 ||
      old.trail2 != trail2 ||
      old.trail3 != trail3 ||
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
            const Color(0xFFFFF3C1).withOpacity(opacity * b.alpha),
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
    required this.x, required this.size,
    required this.speed, required this.color, required this.offset,
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

  int _lastQuestionIndex = 0;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final String biographyText = '''
Even though many people think that flying in the air is something new, humans have thought about it for a very long time. We became interested in flying when we were children. One evening in the autumn of 1878, our father came home with something in his hands. Before we could see what it was, he threw it into the air. We expected it to fall to the floor, but instead, it flew across the room, hit the ceiling, moved a little, and then came down. It was a small toy called a “helicoptere” by scientists, but we simply called it a “bat.” It was made of cork and bamboo and had paper wings. Rubber bands made the two propellers turn in opposite directions. The toy was very fragile and didn’t last long, but we always remembered it.

A few years later, we started to build similar toys, each time making them bigger. But we were surprised to find that the bigger they were, the less they could fly. We didn’t know at the time that when a machine is twice as big, it needs eight times more power. Eventually, we got discouraged and returned to flying kites. We had already spent a lot of time on kites and were seen as experts. But as we got older, we stopped flying kites because we thought it was not something older boys should do.

We didn’t think about flying again until the sad news came in 1896 that Otto Lilienthal had died in a flying accident. After that, we became very interested again. We read Chanute’s Progress in Flying Machines, Langley’s Experiments in Aerodynamics, the Aeronautical Annuals from 1905, 1906, and 1907, and some booklets from the Smithsonian Institution. These included writings by Lilienthal and parts of Mouillard’s Empire of the Air. These books helped us understand the problems of flying and why past attempts had failed. Lilienthal and Mouillard were so excited about flying that they made us excited too. Our interest turned into a strong desire to work on the problem ourselves.
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
    question: 'How did the toy helicopter move after being thrown in the air?',
    options: [
      "A) It fell straight down",
      "B) It flew across the room",
      "C) It stayed still in the air",
      "D) It flew out the window"
    ],
    correctIndex: 1,
    explanation:
        '✈️ The toy flew across the room, hit the ceiling, moved a little, then came down.',
    incorrectExplanations: [
      " It didn’t fall straight down; it actually moved through the air.",
      " Correct answer!",
      " It didn’t stay still — it moved actively after being thrown.",
      " It never flew out the window."
    ],
  ),
  QuestionData(
    question: 'Who introduced the toy helicopter to the children?',
    options: [
      "A) Their mother",
      "B) Their teacher",
      "C) Their father",
      "D) A scientist"
    ],
    correctIndex: 2,
    explanation:
        '👨‍👦 Their father came home with the toy helicopter and threw it into the air, inspiring the children’s interest in flight.',
    incorrectExplanations: [
      " Their mother was not involved in this event.",
      " It wasn’t introduced by a teacher.",
      " Correct answer!",
      " A scientist didn’t bring the toy — it was their father."
    ],
  ),
  QuestionData(
    question: 'When did the children first lose interest in flying kites?',
    options: [
      "A) When they were very young",
      "B) When they became older boys",
      "C) After 1896",
      "D) After building bigger toys"
    ],
    correctIndex: 1,
    explanation:
        '🪁 They stopped flying kites because they thought it wasn’t suitable for older boys.',
    incorrectExplanations: [
      " They still enjoyed kites when they were young.",
      " Correct answer!",
      " The year 1896 is unrelated to this specific change.",
      " They didn’t stop because of building bigger toys."
    ],
  ),
  QuestionData(
    question:
        'How did the writings of Lilienthal and Mouillard influence the children?',
    options: [
      "A) They discouraged them from flying",
      "B) They made them excited to work on flying",
      "C) They confused the children",
      "D) They made the children stop reading"
    ],
    correctIndex: 1,
    explanation:
        '📚 The children became excited and determined to solve flying problems after reading the writings of Lilienthal and Mouillard.',
    incorrectExplanations: [
      " The writings didn’t discourage them; they inspired them.",
      " Correct answer!",
      " The children weren’t confused — they became motivated.",
      " They continued reading and experimenting, not the opposite."
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

class _BiographyReadingPageSecondState
    extends State<BiographyReadingPageSecond> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;
  int _lastQuestionIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final String biographyTextSecond = '''
At that time, there were two main groups in aviation. One group, which included Professor Langley and Sir Hiram Maxim, focused on machines with engines. The other group, with people like Lilienthal, Mouillard, and Chanute, worked on gliders. We liked the second group better. We didn’t like that the first group put expensive machines on wings that nobody could really control. We also loved how the glider group talked about the beauty of flying quietly through the air, using only the wind.

Balancing a flying machine sounds easy, but almost everyone had problems with it. Many different methods were tried. Some people put the center of gravity (the heaviest part) far below the wings. They thought this would help balance the machine like a pendulum. But, like a swinging pendulum, it actually caused the machine to move too much and lose balance. Another idea was to shape the wings like a wide V, which would help with sideways balance. This helped a little, but only when the air was calm. In real conditions, it didn’t work well.

A similar idea was used to help balance from front to back. They gave the main wings a positive angle and the back tail a negative one, and moved the center of gravity forward. But this design also caused the machine to move up and down constantly. In wind, the forces that were supposed to help with balance actually made it worse. Even though people knew this didn’t work perfectly, many flying machines still used this design.

After studying these ideas, we decided that this system could be interesting for science but not useful for real flying. We wanted to try something new. Our idea was to build a machine that did not try to balance itself automatically. Instead, it would resist changes in speed or direction as much as possible. This would help the machine stay more stable when the wind changed. To do this, we gave the wings a special shape. For balance from side to side, we bent the wings in the opposite way that others had done before. Then, we added controls that the pilot could move to keep the machine balanced.
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
    question: 'Which group did the narrators feel more connected to?',
    options: [
      "A) The engine-powered machine group",
      "B) The glider group",
      "C) The pendulum design group",
      "D) The wing-V shape group"
    ],
    correctIndex: 1,
    explanation:
        '🪁 They said they liked the glider group better, appreciating their focus on quiet, wind-powered flying and the beauty of flight.',
    incorrectExplanations: [
      " The narrator preferred non-engine-powered flight.",
      " Correct answer!",
      " The pendulum group’s ideas didn’t align with their interests.",
      " The wing-V shape group wasn’t mentioned as their preference."
    ],
  ),
  QuestionData(
    question:
        'Where was the center of gravity placed in some early balancing designs?',
    options: [
      "A) Above the wings",
      "B) Far below the wings",
      "C) Behind the tail",
      "D) Inside the engine compartment"
    ],
    correctIndex: 1,
    explanation:
        '⚖️ Some inventors placed the center of gravity far below the wings, hoping it would help balance the machine like a pendulum.',
    incorrectExplanations: [
      " It wasn’t placed above the wings.",
      " Correct answer!",
      " The tail position didn’t define the center of gravity in these designs.",
      " The engine compartment was not relevant to balance placement."
    ],
  ),
  QuestionData(
    question:
        'What feature did the narrator’s design use to help the pilot control side-to-side balance?',
    options: [
      "A) A heavier tail",
      "B) A special propeller",
      "C) Wings bent differently",
      "D) A larger engine"
    ],
    correctIndex: 2,
    explanation:
        '✈️ The narrator describes bending the wings in the opposite way others had done before, allowing the pilot to maintain balance during flight.',
    incorrectExplanations: [
      " The tail weight was not the method of control.",
      " Propellers affected thrust, not lateral balance.",
      " Correct answer!",
      " The engine size didn’t influence side-to-side balance."
    ],
  ),
  QuestionData(
    question:
        'Who was responsible for moving the controls to keep the machine balanced?',
    options: [
      "A) The wind",
      "B) The pilot",
      "C) An automatic system",
      "D) The passengers"
    ],
    correctIndex: 1,
    explanation:
        '🎛️ The design relied on the pilot manually moving the controls to maintain balance, rather than using an automatic system.',
    incorrectExplanations: [
      " The wind didn’t move the controls.",
      " Correct answer!",
      " There was no automatic balancing mechanism at that time.",
      " There were no passengers operating the controls."
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

class _BiographyReadingPageThirdState extends State<BiographyReadingPageThird> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;
  int _lastQuestionIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final String biographyTextThird = '''
Lilienthal and Chanute had controlled their gliders by moving their bodies. But we thought this would not work for bigger machines. The pilot’s weight was not enough, and they couldn’t move far enough to control large flying machines. So, we wanted a system where the pilot could change the angles of different parts of the wings to help balance the machine. This could be done by twisting the wings and using extra parts like rudders. The good thing was that the forces we needed for control would grow as the disturbing forces (like wind) grew too. So, this method could work for very large machines. We found a clever way to twist the wings in a new way, even though they looked solid. This allowed us to tilt the left and right wings at different angles. We also added a small adjustable front rudder. These were the main features of our first glider.

Between 1885 and 1900, there was a lot of activity in flying, and many people believed that flying machines would soon become real. But things went wrong. Maxim spent \$100,000 and then gave up. The Ader machine, paid for by the French government, didn’t work. Lilienthal and Pilcher died in accidents. Chanute and others also stopped working on flying. Still, Professor Langley secretly continued to build a machine for the U.S. government. After these failures, the public no longer believed flying was possible. They thought inventors of flying machines were just like people who tried to build machines that worked forever without energy.

We started our own tests in October 1900 at Kitty Hawk, North Carolina. Our first glider was made to be flown like a kite with a person on it, in winds of 15 to 20 miles per hour. But when we tried it, the wind was not strong enough. So, we flew the glider without a person and controlled it with ropes from the ground. This wasn’t the kind of test we hoped for, but it gave us confidence that our balance system worked.

In the summer of 1901, we met Mr. Chanute. When he learned we were working on flying as a hobby and not for money, he supported us a lot. He stayed at our camp at Kill Devil Hill (four miles from Kitty Hawk) for several weeks in 1901 and the next two years. He also saw one flight of our powered machine in October 1904 near Dayton, Ohio.

The 1901 machine used the same curved wing shape as Lilienthal, curved from front to back like part of a circle. The curve was 1/12 of the width of the wing. To make sure it would lift enough when flown as a kite in 15–20 mile winds, we made it much bigger—308 square feet instead of 165. That was much larger than the machines of Lilienthal, Pilcher, or Chanute. But again, the machine did not lift as much as we had calculated. So we gave up on the idea of practicing while flying it like a kite. Mr. Chanute saw our tests and said the machine was well built. So we believed the problem was not the design, but that the air pressure data used by everyone at the time was probably wrong.
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
                  biographyTextThird,
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
        'Why did Mr. Chanute likely support the inventors after meeting them?',
    options: [
      "A) They promised him payment",
      "B) They were working for the U.S. government",
      "C) They were pursuing flying for a hobby, not profit",
      "D) They had already flown successfully"
    ],
    correctIndex: 2,
    explanation:
        '🤝 The text says Chanute supported them after learning they were working on flying as a hobby, not for money.',
    incorrectExplanations: [
      " He wasn’t paid for his support.",
      " They weren’t government employees.",
      " Correct answer!",
      " They hadn’t flown successfully yet at that time."
    ],
  ),
  QuestionData(
    question:
        'Where did the inventors set up their camp for flight experiments in 1901?',
    options: [
      "A) Dayton, Ohio",
      "B) Kill Devil Hill",
      "C) Paris, France",
      "D) Washington, D.C."
    ],
    correctIndex: 1,
    explanation:
        '🏕️ The inventors camped at Kill Devil Hill, four miles from Kitty Hawk, during their 1901 experiments.',
    incorrectExplanations: [
      " They built their machines in Dayton but didn’t camp there.",
      " Correct answer!",
      " Paris wasn’t the location of their tests.",
      " Washington, D.C. wasn’t involved in their field experiments."
    ],
  ),
  QuestionData(
    question:
        'What method did they use to control the glider when the wind wasn’t strong enough?',
    options: [
      "A) By twisting the wings mid-air",
      "B) By adding a larger engine",
      "C) By using ropes from the ground",
      "D) By moving the pilot’s body weight"
    ],
    correctIndex: 2,
    explanation:
        '🌬️ The glider was controlled from the ground using ropes when the wind was too weak for manned flight.',
    incorrectExplanations: [
      " They didn’t twist the wings mid-air for control.",
      " There was no engine used in these gliders.",
      " Correct answer!",
      " The glider was unmanned, so body movement wasn’t a factor."
    ],
  ),
  QuestionData(
    question:
        'Who secretly carried on building a flying machine after others stopped?',
    options: ["A) Pilcher", "B) Maxim", "C) Ader", "D) Professor Langley"],
    correctIndex: 3,
    explanation:
        '🔧 Professor Langley continued working in secret even after other inventors had given up.',
    incorrectExplanations: [
      " Pilcher did not continue secretly after stopping.",
      " Maxim abandoned his attempts earlier.",
      " Ader was not the one who kept working in secret.",
      " Correct answer!"
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

class _BiographyReadingPageFinalState extends State<BiographyReadingPageFinal> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;
  int _lastQuestionIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  final String biographyTextSecond = '''
Then we started to glide—sliding downhill through the air—because it was the only way to practice balancing the flying machine. After just a few minutes, we were able to glide more than 300 feet. In a few days, we could fly safely even in winds of 27 miles per hour. During these tests, we saw some surprising things. We learned that, unlike what the books said, the center of pressure (the point where the wind pushes on the surface) moved backward when the wing was turned more and more sideways to the wind.

We also saw that when flying freely, if one wing was turned at a bigger angle to the wind than the other, that wing went down, and the machine turned in the opposite direction from what we had expected based on our kite tests. The wing with the bigger angle slowed down the machine on that side. The slower speed was more important than the bigger angle, so the wing with more angle actually went lower.

Adding a fixed vertical fin at the back made the problem worse, and the machine became very dangerous. It took us a while to find the answer. The solution was to use movable rudders that worked together with the twisted wings. We had already explained this system in detail in documents published some years earlier.

The experiments in 1901 were not very encouraging. Mr. Chanute told us that our results in controlling the machine and in the weight it could carry with its power were better than anyone else’s before us. Still, we realized that the calculations used by others for building flying machines were not correct. Everyone, including us, was just guessing. We had started our work with full trust in the scientific information that already existed. But after two years, we began to doubt more and more of it, and finally we decided to stop using it and to depend only on our own research. Truth and mistakes were mixed so closely together in the books that it was hard to know what to believe.

Still, reading those books was not a waste of time. They gave us a basic understanding of the subject, and they helped us avoid going in directions that would not have worked.

The usual way to measure wind pressure is to use a flat surface of one square foot and let air at one mile per hour hit it directly. But even this simple test was difficult to do exactly. Different experts gave results that were 50% different from each other. If it was so hard to get correct results for a basic measurement, it must have been much harder to measure how pressure changed when the surface was turned at different angles to the wind.
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
        "What does Mr. Chanute’s comment about their results suggest about his attitude?",
    options: [
      "A) He thought they were wasting time",
      "B) He thought they should stop flying",
      "C) He didn’t care about their experiments",
      "D) He believed their results were the best so far"
    ],
    correctIndex: 3,
    explanation:
        "💬 Chanute told them their control and carrying capacity were better than anyone else’s before them, showing he valued their progress.",
    incorrectExplanations: [
      " He didn’t think they were wasting time.",
      " He didn’t want them to stop flying.",
      " He did care about their experiments.",
      " Correct answer!"
    ],
  ),
  QuestionData(
    question:
        "Where was the fixed vertical fin placed that made the machine more dangerous?",
    options: [
      "A) At the front of the wings",
      "B) At the back",
      "C) Under the pilot’s seat",
      "D) On the top of the machine"
    ],
    correctIndex: 1,
    explanation:
        "⚙️ The text says “Adding a fixed vertical fin at the back made the problem worse.”",
    incorrectExplanations: [
      " It wasn’t placed at the front of the wings.",
      " Correct answer!",
      " It wasn’t under the pilot’s seat.",
      " It wasn’t on the top of the machine."
    ],
  ),
  QuestionData(
    question:
        "What design change solved the problem caused by the vertical fin?",
    options: [
      "A) Removing the wings entirely",
      "B) Using larger engines and without a pilot",
      "C) Using movable rudders with twisted wings",
      "D) Flying only in calm weather"
    ],
    correctIndex: 2,
    explanation:
        "🛠️ The text explains they solved the problem by adding movable rudders that worked together with twisted wings.",
    incorrectExplanations: [
      " Removing the wings was not a solution.",
      " Larger engines were not used at this stage.",
      " Correct answer!",
      " Weather conditions weren’t the main fix."
    ],
  ),
  QuestionData(
    question:
        "When did they decide to stop relying on existing scientific information?",
    options: [
      "A) After two years of work",
      "B) At the very start of their experiments",
      "C) Right after meeting Mr. Chanute",
      "D) During their first glider flight"
    ],
    correctIndex: 0,
    explanation:
        "📚 The text says they began to doubt existing information “after two years” and then chose to depend only on their own research.",
    incorrectExplanations: [
      " Correct answer!",
      " They didn’t doubt science from the beginning.",
      " Meeting Chanute wasn’t the reason for that change.",
      " It didn’t happen during the first glider flight."
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
