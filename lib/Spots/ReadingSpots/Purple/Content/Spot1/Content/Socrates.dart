import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Purple/Content/Spot1/Spot_Page/reading_spot_page.dart';
import 'dart:math' as math;

class SocratesSplashScreen extends StatefulWidget {
  const SocratesSplashScreen({super.key});

  @override
  State<SocratesSplashScreen> createState() => _SocratesSplashScreenState();
}

class _SocratesSplashScreenState extends State<SocratesSplashScreen>
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
        MaterialPageRoute(
            builder: (_) => const BiographyAbrahan()), // ← Nietzsche()
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
                      'assets/Items/S.webp',
                      width: 100,
                      height: 115,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Famous Men of Ancient Times:\n Socrates",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E1200),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "By Samuel G. Goodrich, 1843",
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

// ---------------------- Socrates QUESTIONS ----------------------
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
      "question":
          "Title: Famous Men of Ancient Times: Socrates\n\nWhat is most likely to be described?",
      "options": [
        "A) The military campaigns of Socrates",
        "B) The inventions of ancient engineers",
        "C) Socrates’ role as a teacher and philosopher",
        "D) Stories about Roman emperors"
      ],
      "correct": 2,
      "feedback": [
        " Incorrect. The passage is not about military events.",
        " Incorrect. Ancient engineering is unrelated to the title.",
        " Correct! The title indicates the focus will be on Socrates’ life and influence as a philosopher.",
        " Incorrect. Roman emperors are unrelated to Socrates."
      ]
    },
    {
      "question":
          "What form of government was Athens known for during Socrates’ lifetime?",
      "options": [
        "A) Monarchy",
        "B) Democracy",
        "C) Oligarchy",
        "D) Dictatorship"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Athens was not ruled by a monarch in this period.",
        " Correct! Athens developed a form of direct democracy where citizens could participate in decision-making.",
        " Incorrect. Although oligarchic periods existed, the passage points to democracy.",
        " Incorrect. Athens was not governed as a dictatorship."
      ]
    },
    {
      "question":
          "Which group of people were considered full citizens in Athens?",
      "options": [
        "A) Women and slaves",
        "B) Free men born in Athens",
        "C) All residents",
        "D) Foreign merchants and visitors"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Women and slaves did not have political rights.",
        " Correct! Only free adult men born to Athenian parents could vote and participate in politics.",
        " Incorrect. Not all residents had political rights.",
        " Incorrect. Foreigners were excluded from citizenship."
      ]
    },
    {
      "question":
          "What role did public debate and discussion play in Athenian society?",
      "options": [
        "A) It was discouraged",
        "B) It was central to education and politics",
        "C) It only happened in religious ceremonies",
        "D) It was limited to the military"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Debate was not discouraged in Athens.",
        " Correct! Athenians valued rhetoric and debate as essential to political life and education.",
        " Incorrect. Debate extended far beyond religious settings.",
        " Incorrect. Discussion was not restricted to the military."
      ]
    },
    {
      "question":
          "How were philosophy and education viewed in Socrates’ Athens?",
      "options": [
        "A) As irrelevant to daily life",
        "B) As central to understanding society",
        "C) Only for priests",
        "D) Only for military training"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Philosophy played an important role in Athenian life.",
        " Correct! Philosophers like Socrates emphasized ethics, questioning, and reasoning as essential to a good and just life.",
        " Incorrect. Philosophy was not restricted to priests.",
        " Incorrect. Education and philosophy extended far beyond military purposes."
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
                  const SocratesReadingAnimation()), //BiographyReadingPage
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

class SocratesReadingAnimation extends StatefulWidget {
  const SocratesReadingAnimation({super.key});

  @override
  State<SocratesReadingAnimation> createState() =>
      _SocratesReadingAnimationState();
}

class _SocratesReadingAnimationState extends State<SocratesReadingAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _entryCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _bgCtrl;
  late final AnimationController _floatCtrl;
  late final AnimationController _particleCtrl;
  late final AnimationController _beamsCtrl;
  late final AnimationController _flameCtrl;
  late final AnimationController _haloCtrl;
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
  late final Animation<double> _flameScaleX;
  late final Animation<double> _flameScaleY;
  late final Animation<double> _flameOpacity;
  late final Animation<double> _haloRadius;
  late final Animation<double> _haloOpacity;
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
      end: const Color(0xFF3B2F00),
    ).animate(_bgCtrl);
    _bgColor2 = ColorTween(
      begin: const Color(0xFFB8860B),
      end: const Color(0xFFFFE082),
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

    // Llama — ciclo rápido irregular simulado con dos controllers
    _flameCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);
    _flameScaleX = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.85), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.85, end: 1.10), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.10, end: 0.90), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.90, end: 1.0), weight: 25),
    ]).animate(_flameCtrl);
    _flameScaleY = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.12), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.12, end: 0.92), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.92, end: 1.08), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.08, end: 1.0), weight: 25),
    ]).animate(_flameCtrl);
    _flameOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.85), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.85, end: 0.95), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.95, end: 0.9), weight: 25),
    ]).animate(_flameCtrl);

    // Halo vela
    _haloCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _haloRadius = Tween<double>(begin: 28, end: 38).animate(
      CurvedAnimation(parent: _haloCtrl, curve: Curves.easeInOut),
    );
    _haloOpacity = Tween<double>(begin: 0.18, end: 0.38).animate(
      CurvedAnimation(parent: _haloCtrl, curve: Curves.easeInOut),
    );

    // Líneas texto
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

    // Página volando
    _pageCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);
    _pageOpacity = Tween<double>(begin: 0.45, end: 0.70).animate(
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
    _flameCtrl.dispose();
    _haloCtrl.dispose();
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
          _flameCtrl,
          _haloCtrl,
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
                      const Color(0xFF3B2F00),
                      const Color(0xFFB8860B),
                      _bgColor2.value ?? const Color(0xFFFFE082),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
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
                      const Color(0xFF0C0600).withOpacity(0.76),
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
                              height: 140,
                              child: CustomPaint(
                                painter: _BookCandlePainter(
                                  glow: _glow.value,
                                  flameScaleX: _flameScaleX.value,
                                  flameScaleY: _flameScaleY.value,
                                  flameOpacity: _flameOpacity.value,
                                  haloRadius: _haloRadius.value,
                                  haloOpacity: _haloOpacity.value,
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
                              'Step into history.\nThe more you read,\nthe brighter your wisdom shines.',
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

// ── Book + Candle painter ─────────────────────────────────────────────────────
class _BookCandlePainter extends CustomPainter {
  final double glow;
  final double flameScaleX;
  final double flameScaleY;
  final double flameOpacity;
  final double haloRadius;
  final double haloOpacity;
  final double linesOpacity;
  final double linesOpacity2;
  final double pageOpacity;
  final double sparkProgress;

  const _BookCandlePainter({
    required this.glow,
    required this.flameScaleX,
    required this.flameScaleY,
    required this.flameOpacity,
    required this.haloRadius,
    required this.haloOpacity,
    required this.linesOpacity,
    required this.linesOpacity2,
    required this.pageOpacity,
    required this.sparkProgress,
  });

  double sx(Size s, double v) => v / 150 * s.width;
  double sy(Size s, double v) => v / 140 * s.height;
  Offset p(Size s, double px, double py) => Offset(sx(s, px), sy(s, py));

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.5;

    // ── Halo vela ──
    canvas.drawCircle(
      Offset(cx, sy(size, 22)),
      haloRadius,
      Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFFFAC775).withOpacity(haloOpacity),
            Colors.transparent,
          ],
          stops: const [0.0, 1.0],
        ).createShader(
          Rect.fromCircle(center: Offset(cx, sy(size, 22)), radius: haloRadius),
        ),
    );

    // ── Llama ──
    canvas.save();
    canvas.translate(cx, sy(size, 22));
    canvas.scale(flameScaleX, flameScaleY);

    // Llama exterior
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(0, -sy(size, 6)),
          width: sx(size, 10),
          height: sy(size, 20)),
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFFEF9F27), Color(0xFFFAC775), Color(0xFFFAEEDA)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ).createShader(Rect.fromLTWH(-5, -16, 10, 20))
        ..color = const Color(0xFFEF9F27).withOpacity(flameOpacity),
    );
    // Núcleo interior
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(0, -sy(size, 5)),
          width: sx(size, 6),
          height: sy(size, 12)),
      Paint()..color = const Color(0xFFFAEEDA).withOpacity(flameOpacity * 0.7),
    );
    canvas.restore();

    // ── Cuerpo vela ──
    final candleRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(cx - sx(size, 4), sy(size, 28), sx(size, 8), sy(size, 22)),
      const Radius.circular(2),
    );
    canvas.drawRRect(
        candleRect, Paint()..color = const Color(0xFFFAEEDA).withOpacity(0.92));
    // Highlight lateral
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
            cx - sx(size, 4), sy(size, 28), sx(size, 3), sy(size, 22)),
        const Radius.circular(2),
      ),
      Paint()..color = Colors.white.withOpacity(0.35),
    );
    // Cera derramada
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(cx, sy(size, 50)),
          width: sx(size, 12),
          height: sy(size, 5)),
      Paint()..color = const Color(0xFFFAEEDA).withOpacity(0.6),
    );

    // ── Tapa izquierda ──
    final leftCover = Path()
      ..moveTo(sx(size, 8), sy(size, 55))
      ..quadraticBezierTo(sx(size, 8), sy(size, 51), sx(size, 11), sy(size, 51))
      ..lineTo(sx(size, 72), sy(size, 51))
      ..lineTo(sx(size, 72), sy(size, 118))
      ..lineTo(sx(size, 11), sy(size, 118))
      ..quadraticBezierTo(
          sx(size, 8), sy(size, 118), sx(size, 8), sy(size, 115))
      ..close();
    canvas.drawPath(
      leftCover,
      Paint()
        ..shader = LinearGradient(
          colors: const [Color(0xFFFAC775), Color(0xFF854F0B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromLTWH(
            sx(size, 8), sy(size, 51), sx(size, 64), sy(size, 67))),
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
        Rect.fromLTWH(sx(size, 70), sy(size, 51), sx(size, 10), sy(size, 67)),
        const Radius.circular(1),
      ),
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFFEF9F27), Color(0xFF412402)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(
          Rect.fromLTWH(sx(size, 70), sy(size, 51), sx(size, 10), sy(size, 67)),
        ),
    );

    // ── Tapa derecha ──
    final rightCover = Path()
      ..moveTo(sx(size, 80), sy(size, 51))
      ..lineTo(sx(size, 139), sy(size, 51))
      ..quadraticBezierTo(
          sx(size, 142), sy(size, 51), sx(size, 142), sy(size, 55))
      ..lineTo(sx(size, 142), sy(size, 115))
      ..quadraticBezierTo(
          sx(size, 142), sy(size, 118), sx(size, 139), sy(size, 118))
      ..lineTo(sx(size, 80), sy(size, 118))
      ..close();
    canvas.drawPath(
      rightCover,
      Paint()
        ..shader = LinearGradient(
          colors: const [Color(0xFFFAC775), Color(0xFFBA7517)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ).createShader(Rect.fromLTWH(
            sx(size, 80), sy(size, 51), sx(size, 62), sy(size, 67))),
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
      Rect.fromLTWH(sx(size, 11), sy(size, 51), sx(size, 59), sy(size, 67)),
      Paint()
        ..shader = LinearGradient(
          colors: [
            const Color(0xFFFAEEDA),
            const Color(0xFFFAC775).withOpacity(0.55)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(Rect.fromLTWH(sx(size, 11), 0, sx(size, 59), h)),
    );

    // ── Páginas derecha ──
    canvas.drawRect(
      Rect.fromLTWH(sx(size, 80), sy(size, 51), sx(size, 59), sy(size, 67)),
      Paint()
        ..shader = LinearGradient(
          colors: [
            const Color(0xFFFAC775).withOpacity(0.55),
            const Color(0xFFFAEEDA)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(Rect.fromLTWH(sx(size, 80), 0, sx(size, 59), h)),
    );

    // ── Líneas izquierda ──
    final leftYs = [0.62, 0.70, 0.78, 0.86, 0.94, 1.02, 1.10];
    final leftWs = [0.53, 0.53, 0.45, 0.53, 0.41, 0.53, 0.47];
    for (int i = 0; i < leftYs.length; i++) {
      canvas.drawLine(
        Offset(sx(size, 16), h * leftYs[i] / 1.40),
        Offset(sx(size, 16) + w * leftWs[i] * 0.45, h * leftYs[i] / 1.40),
        Paint()
          ..color = const Color(0xFFBA7517)
              .withOpacity(linesOpacity * (0.65 - i * 0.03))
          ..strokeWidth = 1.1
          ..strokeCap = StrokeCap.round,
      );
    }

    // ── Líneas derecha ──
    final rightYs = [0.62, 0.70, 0.78, 0.86, 0.94, 1.02, 1.10];
    final rightWs = [0.53, 0.53, 0.43, 0.53, 0.38, 0.53, 0.47];
    for (int i = 0; i < rightYs.length; i++) {
      canvas.drawLine(
        Offset(sx(size, 86), h * rightYs[i] / 1.40),
        Offset(sx(size, 86) + w * rightWs[i] * 0.45, h * rightYs[i] / 1.40),
        Paint()
          ..color = const Color(0xFFBA7517)
              .withOpacity(linesOpacity2 * (0.65 - i * 0.03))
          ..strokeWidth = 1.1
          ..strokeCap = StrokeCap.round,
      );
    }

    // ── Página volando ──
    final flutterPath = Path()
      ..moveTo(sx(size, 72), sy(size, 68))
      ..quadraticBezierTo(
          sx(size, 85), sy(size, 62), sx(size, 97), sy(size, 68))
      ..lineTo(sx(size, 97), sy(size, 105))
      ..quadraticBezierTo(
          sx(size, 85), sy(size, 99), sx(size, 72), sy(size, 105))
      ..close();
    canvas.drawPath(
      flutterPath,
      Paint()..color = const Color(0xFFFAEEDA).withOpacity(pageOpacity),
    );

    // ── Glow libro ──
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, sy(size, 130)),
        width: w * 0.72,
        height: h * 0.14,
      ),
      Paint()
        ..color = const Color(0xFFEF9F27).withOpacity(0.12)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glow * 0.5),
    );

    // ── Chispas ──
    final sparks = [
      (sx(size, 60), sy(size, 16), 0.1),
      (sx(size, 92), sy(size, 12), 0.5),
      (sx(size, 48), sy(size, 22), 0.9),
      (sx(size, 104), sy(size, 20), 0.3),
      (sx(size, 6), sy(size, 75), 1.1),
      (sx(size, 145), sy(size, 78), 0.7),
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
  bool shouldRepaint(_BookCandlePainter old) =>
      old.glow != glow ||
      old.flameScaleX != flameScaleX ||
      old.flameScaleY != flameScaleY ||
      old.flameOpacity != flameOpacity ||
      old.haloRadius != haloRadius ||
      old.haloOpacity != haloOpacity ||
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
            const Color(0xFFFFE082).withOpacity(opacity * b.alpha),
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
Socrates was born in Athens in 468 B.C. His father, Sophroniscus, was a modest sculptor who taught him the craft. Socrates became skilled, but he also loved learning. With help from his friend Crito, who gave him money, Socrates studied with several famous philosophers who visited Athens.

In his early years, Socrates worked just enough to earn a basic living. When his father died, he inherited a small amount of money and decided to focus completely on philosophy. He lived simply—his clothes were plain, and he often walked barefoot. Because he needed little, he didn’t have to work or depend on others.

As a citizen, he served as a soldier in three military campaigns. He was known for his bravery and endurance. In one battle, he saved his student Alcibiades and gave him the prize for bravery. In another, he rescued his student Xenophon while fighting off enemies.

At 65, Socrates was chosen to join the Athenian Council of Five Hundred and became its president for one day. That day, ten naval officers were blamed for not burying their soldiers after a sea battle. Though a storm had made burials impossible, the public wanted to punish them without trial. Socrates refused, risking his own safety. Later, he proudly said he had helped save ten innocent men.

At the time, some philosophers called sophists were teaching young people in Greece, but Socrates disagreed with their ideas. He believed philosophy should help people become better and wiser. He spent his days talking to people in the streets, markets, and public places about ethics, politics, religion, and everyday life. His goal was to help others think clearly and live honestly.
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
        'Socrates refused to punish innocent men even though the public demanded it. \n\nWhat is most likely to happen in the future?',
    options: [
      "A) He will always conform to popular opinion",
      "B) He will follow his principles, even if unpopular",
      "C) He will avoid politics entirely",
      "D) He will let others make all moral decisions for him"
    ],
    correctIndex: 1,
    explanation:
        '✔️ Socrates’ refusal to punish innocent men despite public pressure indicates he will continue acting according to his ethical beliefs.',
    incorrectExplanations: [
      " Incorrect. Socrates does not conform to public opinion.",
      " Correct answer!",
      " Incorrect. There is no evidence he will abandon politics altogether.",
      " Incorrect. Socrates is known for making his own moral judgments."
    ],
  ),
  QuestionData(
    question:
        'Socrates spent his days talking to people about ethics, politics, religion, and everyday life.\n\n What is most likely to happen as a result of this behavior?',
    options: [
      "A) People will stop listening to him",
      "B) He will focus only on writing books",
      "C) He will influence others to live wisely",
      "D) He will abandon philosophy"
    ],
    correctIndex: 2,
    explanation:
        '✔️ Socrates’ dedication to discussing important topics suggests he will have a lasting impact on how people think and act.',
    incorrectExplanations: [
      " Incorrect. There is no indication people will stop listening.",
      " Incorrect. Socrates was known for dialogues, not isolating himself to write.",
      " Correct answer!",
      " Incorrect. His behavior shows strong commitment to philosophy."
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

His way of life wasn’t easy, but Socrates stayed calm and cheerful. He trained both his body and mind to accept discomfort. He was strong, even in old age. His wife Xanthippe had a difficult temper, but Socrates said she helped him practice patience.

While most Greeks believed in many gods, Socrates believed in one supreme God. He still followed traditional ceremonies to avoid upsetting others. He was surrounded by students who shared his love for truth and virtue. Some of his best-known students were Alcibiades, Crito, Xenophon, Antisthenes, Aristippus, Phaedo, Aeschines, Cebes, Euclid, and Plato. According to Plato and Xenophon, Socrates taught politics, ethics, logic, and even poetry and math.

Instead of giving lectures, Socrates asked questions that helped people think. This method—asking and answering questions—is now called the Socratic method. Xenophon recorded some of these talks, but Plato captured Socrates’s ideas more fully and clearly. That’s why Plato is the main source we have for understanding Socrates’s philosophy.

Socrates was later sentenced to death for religious and political reasons. A copy of the official charge survived until the second century A.D. It said: “Melitus, son of Melitus, accuses Socrates of denying the gods, inventing new beliefs, and corrupting the youth of Athens. Penalty: death.”

Melitus was not a strong writer, but powerful enemies supported him. Among them were Anytus, a rich political leader, and Lycon, a judge. Socrates was seventy years old when he appeared before the court of the Areopagus. Many people expected this to happen—he had already been mocked in a comedy play by Aristophanes, which had hurt his reputation.
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
        'Socrates trained his body and mind to accept discomfort and stayed calm and cheerful.\n\n What is most likely to happen next?',
    options: [
      "A) He will give up philosophy because life is too hard",
      "B) He will stop interacting with his students",
      "C) He will face challenges with patience and composure",
      "D) He will leave Athens for an easier life"
    ],
    correctIndex: 2,
    explanation:
        '✔️ Socrates’ calm and disciplined approach to life suggests he will continue facing challenges with patience and mental strength.',
    incorrectExplanations: [
      " Incorrect. There is no indication he will abandon philosophy.",
      " Incorrect. He consistently engaged with students despite difficulties.",
      " Correct answer!",
      " Incorrect. Socrates was not known for seeking an easier life elsewhere."
    ],
  ),
  QuestionData(
    question:
        'Socrates’ students included Alcibiades, Plato, Xenophon, and others, and he taught using questions rather than lectures.\n\n What is most likely to happen next as a result of this teaching style?',
    options: [
      "A) His ideas will be forgotten after his death",
      "B) His students will stop learning from him",
      "C) He will write books himself instead of teaching",
      "D) His students will carry on his philosophy"
    ],
    correctIndex: 3,
    explanation:
        '✔️ The passage emphasizes that Plato and Xenophon recorded Socrates’ teachings, indicating his ideas will influence future generations.',
    incorrectExplanations: [
      " Incorrect. His students preserved his ideas, ensuring they would not be forgotten.",
      " Incorrect. His questioning style inspired continued learning.",
      " Incorrect. Socrates did not focus on writing books.",
      " Correct answer!"
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

class _BiographyReadingPageThirdState extends State<BiographyReadingPageThird> {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  final String biographyTextSecond = '''

His enemies came in two groups. One group respected him but feared his ideas could harm society. They believed that religion helped maintain order, and that if people stopped fearing the gods, society would suffer. They thought Socrates’s ideas were dangerous, even if true.

The second group was jealous and narrow-minded. They hated being questioned or corrected by him. Like when the great leader Aristides was exiled just for being too good, they wanted Socrates gone.

His friends begged him to escape or defend himself more strongly. A speaker named Lysias even wrote a powerful speech for Socrates to use. Socrates praised it but refused to read it. He believed that trying too hard to avoid punishment would betray his principles. He chose to stay true to his ideas—even if it cost him his life.

Socrates was a great speaker in conversation, but he wasn’t good at speaking to large crowds. So, on the day of his trial, he asked the judges if he could defend himself in the way he usually did: by talking simply and asking questions to those who were against him.

At the beginning of his speech, he said:
“Athenians, I hope my defense will succeed if it is for a good reason. But I do not expect to win, and I am not trying to fool myself. Whatever happens, let the will of the gods be done.”

There were two main accusations against Socrates. First, that he did not believe in the gods of the city. Second, that he had corrupted the minds of young people and caused them to stop believing in the official religion.
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
        'Socrates’ enemies were either afraid of his ideas or jealous of him.\n\n What is most likely to happen next?',
    options: [
      "A) Socrates’ enemies will drop the accusations",
      "B) The trial will be difficult for Socrates",
      "C) Socrates will win over all his enemies easily",
      "D) He will leave Athens before the trial"
    ],
    correctIndex: 1,
    explanation:
        '✔️ The text shows strong opposition from multiple groups, suggesting the trial will be challenging.',
    incorrectExplanations: [
      " Incorrect. There is no indication his enemies will give up.",
      " Correct answer!",
      " Incorrect. His enemies are shown as strongly opposed to him.",
      " Incorrect. Socrates did not flee Athens before the trial."
    ],
  ),
  QuestionData(
    question:
        'Socrates refused to use a prepared speech and chose to stay true to his principles.\n\n What is most likely to happen as a result of this choice?',
    options: [
      "A) He will be praised by everyone for cleverness",
      "B) He may face punishment for staying principled",
      "C) He will be ignored entirely by the judges",
      "D) He will be offered freedom immediately"
    ],
    correctIndex: 1,
    explanation:
        '✔️ By refusing to compromise or use a strategic speech, Socrates risks angering the court.',
    incorrectExplanations: [
      " Incorrect. The choice is risky, not praise-worthy to everyone.",
      " Correct answer!",
      " Incorrect. The judges will certainly pay attention to his case.",
      " Incorrect. His refusal does not make freedom more likely."
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

Socrates did not answer the accusations directly. Instead of saying he believed in the gods of Athens, he explained that he was not an atheist. Instead of denying that he taught young people to question religion, he said he taught them morality. He also did not try to make the judges feel sorry for him. Many people at trials brought their children and family to cry and beg for mercy, but Socrates refused to do this.

He said:
“I also have friends and family. I have three children—one is older, and two are still small—but I will not bring them here to make you feel pity. I do this not out of pride, but out of respect for myself, for you, and for Athens. It would be shameful if people who are supposed to be wise or brave acted in such a low way—as if dying were the worst thing that could happen. As if staying alive would make them live forever!”

When Socrates finished speaking, the judges found him guilty. Only three votes more were needed to convict him. According to Athenian law, Socrates now had to say what punishment he thought he deserved. Since he believed he had done nothing wrong, he said:

“I believe I have done great service to my country. So, instead of punishment, I should be rewarded. I should be given free meals at the Prytaneum, like the winners of the Olympic Games. They give you joy for a short time, but I have helped you in a much deeper way.”
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
        'Socrates did not answer the accusations directly but explained his beliefs and taught morality.\n\n What is most likely to happen next?',
    options: [
      "A) The judges will immediately forgive him",
      "B) He will change his explanation to avoid punishment",
      "C) He will be allowed to leave Athens safely",
      "D) His honesty may impress some, but anger others"
    ],
    correctIndex: 3,
    explanation:
        '✔️ Socrates’ refusal to conform or flatter the judges will likely polarize them—some may respect him, but most will remain hostile.',
    incorrectExplanations: [
      " Incorrect. There is no indication the judges will simply forgive him.",
      " Incorrect. Socrates is committed to his beliefs and will not change his explanation.",
      " Incorrect. The text does not suggest he will be allowed to leave freely.",
      " Correct answer!"
    ],
  ),
  QuestionData(
    question:
        'Socrates suggested he deserved a reward instead of punishment.\n\n What is most likely to happen next?',
    options: [
      "A) The judges will agree and honor him for a year",
      "B) The judges will be angered and impose a severe penalty",
      "C) The trial will be declared a mistrial",
      "D) Socrates will change his mind and apologize in a public ceremony"
    ],
    correctIndex: 1,
    explanation:
        '✔️ By claiming a reward, Socrates challenges the court’s authority and provokes their anger, leading to a harsh sentence.',
    incorrectExplanations: [
      " Incorrect. The judges are unlikely to honor him after such a challenge.",
      " Correct answer!",
      " Incorrect. Nothing suggests the trial will be voided.",
      " Incorrect. Socrates is not portrayed as someone who would retract his beliefs publicly."
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
