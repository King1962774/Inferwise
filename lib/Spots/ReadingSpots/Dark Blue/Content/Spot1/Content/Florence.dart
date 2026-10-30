import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Dark Blue/Content/Spot1/Spot_Page/ReadingSpot.dart';
import 'dart:math' as math;



// ── Reemplaza con tu import real ──────────────────────────────────
// import 'florence.dart';
// ─────────────────────────────────────────────────────────────────

class FlorenceSplashScreen extends StatefulWidget {
  const FlorenceSplashScreen({super.key});

  @override
  State<FlorenceSplashScreen> createState() => _FlorenceSplashScreenState();
}

class _FlorenceSplashScreenState extends State<FlorenceSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _flickerController;
  late AnimationController _glowController;
  late Animation<double> _fadeIn;
  late Animation<double> _scaleUp;

  // Llama: escala X y Y que parpadean
  late Animation<double> _flameScaleX;
  late Animation<double> _flameScaleY;
  late Animation<double> _flameOffsetY;

  // Halo: opacidad y escala que pulsan
  late Animation<double> _glowOpacity;
  late Animation<double> _glowScale;

  @override
  void initState() {
    super.initState();

    // ── Animación principal ────────────────────────────────────────
    _mainController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _fadeIn  = CurvedAnimation(parent: _mainController, curve: Curves.easeIn);
    _scaleUp = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.elasticOut),
    );
    _mainController.forward();

    // ── Parpadeo de la llama (0.9 s, loop) ────────────────────────
    _flickerController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..repeat(reverse: true);

    _flameScaleX = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0,  end: 0.85), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.85, end: 1.10), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.10, end: 0.92), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.92, end: 1.0),  weight: 25),
    ]).animate(CurvedAnimation(parent: _flickerController, curve: Curves.easeInOut));

    _flameScaleY = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0,  end: 1.10), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.10, end: 0.92), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.92, end: 1.08), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.08, end: 1.0),  weight: 25),
    ]).animate(CurvedAnimation(parent: _flickerController, curve: Curves.easeInOut));

    _flameOffsetY = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -3.0), weight: 30),
      TweenSequenceItem(tween: Tween(begin: -3.0, end: 1.5), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.5,  end: 0.0), weight: 30),
    ]).animate(CurvedAnimation(parent: _flickerController, curve: Curves.easeInOut));

    // ── Pulso del halo de luz (1.6 s, loop) ───────────────────────
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    )..repeat(reverse: true);

    _glowOpacity = Tween<double>(begin: 0.20, end: 0.48).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
    _glowScale = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Florence()),
      );
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _flickerController.dispose();
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

                  // ── Vela animada ───────────────────────────────────
                  SizedBox(
                    width: 100,
                    height: 120,
                    child: AnimatedBuilder(
                      animation: Listenable.merge([_flickerController, _glowController]),
                      builder: (_, __) => CustomPaint(
                        painter: _CandlePainter(
                          flameScaleX:  _flameScaleX.value,
                          flameScaleY:  _flameScaleY.value,
                          flameOffsetY: _flameOffsetY.value,
                          glowOpacity:  _glowOpacity.value,
                          glowScale:    _glowScale.value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    "Girls Who Became Famous:\nFlorence Nightingale",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E1200),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    "By Sarah K. Bolton, 1914",
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

// ─── Vela con llama y halo animados — CustomPainter ──────────────────
class _CandlePainter extends CustomPainter {
  final double flameScaleX;
  final double flameScaleY;
  final double flameOffsetY;
  final double glowOpacity;
  final double glowScale;

  _CandlePainter({
    required this.flameScaleX,
    required this.flameScaleY,
    required this.flameOffsetY,
    required this.glowOpacity,
    required this.glowScale,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;

    // ── Posiciones clave ───────────────────────────────────────────
    const baseH     = 8.0;   // altura base/plato
    const bodyH     = 58.0;  // altura cuerpo vela
    const bodyW     = 22.0;  // ancho cuerpo
    const wickH     = 10.0;  // altura mecha
    const flameH    = 28.0;  // altura llama exterior
    const flameW    = 18.0;  // ancho llama exterior

    final baseY  = size.height - baseH;
    final bodyY  = baseY - bodyH;
    final wickY  = bodyY - wickH;
    // ignore: unused_local_variable
    final flameY = wickY - flameH; // tope de llama

    // ── HALO de luz ambiental ──────────────────────────────────────
    final glowCenter = Offset(cx, wickY + 4);
    final glowR = 42.0 * glowScale;
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFC840).withOpacity(glowOpacity),
          const Color(0xFFFFC840).withOpacity(0.0),
        ],
      ).createShader(Rect.fromCircle(center: glowCenter, radius: glowR));
    canvas.drawCircle(glowCenter, glowR, glowPaint);

    // ── BASE / PLATO ───────────────────────────────────────────────
    final baseRect = RRect.fromLTRBR(
      cx - 16, baseY, cx + 16, baseY + baseH,
      const Radius.circular(2),
    );
    canvas.drawRRect(baseRect,
        Paint()..color = const Color(0xFFB06010)..style = PaintingStyle.fill);
    canvas.drawRRect(baseRect,
        Paint()..color = const Color(0xFF8B5000)..style = PaintingStyle.stroke..strokeWidth = 1.2);

    // ── CUERPO DE LA VELA ──────────────────────────────────────────
    // Gradiente lateral (iluminación)
    final bodyRect = Rect.fromLTWH(cx - bodyW / 2, bodyY, bodyW, bodyH);
    final bodyPaint = Paint()
      ..shader = LinearGradient(
        colors: const [
          Color(0xFFC87820),
          Color(0xFFF0C040),
          Color(0xFFE09010),
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(bodyRect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(bodyRect, const Radius.circular(3)),
      bodyPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bodyRect, const Radius.circular(3)),
      Paint()..color = const Color(0xFF8B5000)..style = PaintingStyle.stroke..strokeWidth = 1.3,
    );

    // Líneas horizontales de cera
    for (double wy = bodyY + 12; wy < baseY - 4; wy += 12) {
      canvas.drawLine(
        Offset(cx - bodyW / 2 + 2, wy),
        Offset(cx + bodyW / 2 - 2, wy),
        Paint()..color = const Color(0xFF8B5000).withOpacity(0.18)..strokeWidth = 1.0,
      );
    }

    // ── MECHA ──────────────────────────────────────────────────────
    canvas.drawLine(
      Offset(cx, bodyY),
      Offset(cx, wickY),
      Paint()..color = const Color(0xFF2E1000)..strokeWidth = 2.2..strokeCap = StrokeCap.round,
    );

    // ── LLAMA (parpadea) ───────────────────────────────────────────
    canvas.save();
    canvas.translate(cx, wickY + flameOffsetY);
    canvas.scale(flameScaleX, flameScaleY);

    // Llama exterior (naranja/amarillo)
    final flamePath = Path();
    flamePath.moveTo(0, 0);
    flamePath.cubicTo(
      -flameW / 2, -flameH * 0.3,
      -flameW / 2, -flameH * 0.7,
       0, -flameH,
    );
    flamePath.cubicTo(
       flameW / 2, -flameH * 0.7,
       flameW / 2, -flameH * 0.3,
       0, 0,
    );

    final flameRect = Rect.fromCenter(
      center: Offset(0, -flameH / 2),
      width: flameW, height: flameH,
    );
    canvas.drawPath(flamePath, Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: const [
          Color(0xFFCC5000),
          Color(0xFFFF8C00),
          Color(0xFFFFCC00),
          Color(0xFFFFEE88),
        ],
        stops: const [0.0, 0.35, 0.70, 1.0],
      ).createShader(flameRect)
      ..style = PaintingStyle.fill);

    // Llama interior (blanca/amarilla brillante)
    final innerPath = Path();
    const iw = flameW * 0.5;
    const ih = flameH * 0.6;
    innerPath.moveTo(0, -2);
    innerPath.cubicTo(-iw / 2, -ih * 0.3, -iw / 2, -ih * 0.7, 0, -ih);
    innerPath.cubicTo( iw / 2, -ih * 0.7,  iw / 2, -ih * 0.3, 0, -2);

    canvas.drawPath(innerPath, Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: const [
          Color(0xFFFFCC00),
          Color(0xFFFFFFCC),
        ],
      ).createShader(Rect.fromCenter(
        center: Offset(0, -ih / 2), width: iw, height: ih))
      ..style = PaintingStyle.fill);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CandlePainter old) =>
      old.flameScaleX  != flameScaleX  ||
      old.flameScaleY  != flameScaleY  ||
      old.flameOffsetY != flameOffsetY ||
      old.glowOpacity  != glowOpacity  ||
      old.glowScale    != glowScale;
}

class Florence extends StatefulWidget {
  const Florence({super.key});
  @override
  State<Florence> createState() => _FlorenceState();
}

class _FlorenceState extends State<Florence> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is the main role of a nurse?",
      "options": [
        "A) Care for patients",
        "B) Perform surgeries",
        "C) Prescribe medications",
        "D) Manage hospital budgets"
      ],
      "correct": 0,
      "feedback": [
        "😊 Explanation: Nurses focus on patient care, monitoring health, providing treatment, and supporting recovery.",
        " Surgeries are typically performed by doctors, not nurses.",
        " Prescribing medications is not usually within a nurse’s role.",
        " Managing budgets is an administrative task, not the main role of a nurse."
      ]
    },
    {
      "question":
          "What is the professional uniform commonly worn by nurses called?",
      "options": ["A) Lab coat", "B) Scrubs", "C) Apron", "D) Suit"],
      "correct": 1,
      "feedback": [
        " Lab coats are more common for doctors or lab technicians.",
        "😊 Explanation: Nurses typically wear scrubs—comfortable, hygienic uniforms designed for healthcare settings.",
        " Aprons are not standard nurse uniforms.",
        " Suits are not appropriate for healthcare work environments."
      ]
    },
    {
      "question":
          "Which famous nurse is known as the founder of modern nursing?",
      "options": [
        "A) Clara Barton",
        "B) Mary Seacole",
        "C) Florence Nightingale",
        "D) Margaret Sanger"
      ],
      "correct": 2,
      "feedback": [
        " Clara Barton is known for founding the American Red Cross, not modern nursing.",
        " Mary Seacole was a pioneering nurse, but not credited as the founder of modern nursing.",
        "😊 Explanation: Florence Nightingale improved hygiene practices and established nursing as a respected profession.",
        " Margaret Sanger is known for her work in birth control, not nursing."
      ]
    },
    {
      "question": "What is triage in a hospital setting?",
      "options": [
        "A) A type of medication",
        "B) A patient’s food schedule",
        "C) A method of prioritizing care based on urgency",
        "D) A cleaning procedure"
      ],
      "correct": 2,
      "feedback": [
        " Triage is not a type of medication.",
        " It is not related to food scheduling.",
        "😊 Explanation: Triage helps nurses and doctors decide which patients need immediate care based on their condition.",
        " Triage has nothing to do with cleaning."
      ]
    },
    {
      "question":
          "Which of the following qualities is most important for a nurse?",
      "options": [
        "A) Physical strength",
        "B) Artistic talent",
        "C) Financial expertise",
        "D) Kindness"
      ],
      "correct": 3,
      "feedback": [
        " Physical strength can help, but it's not the most essential quality.",
        " Artistic talent is not crucial in nursing.",
        " Financial expertise is not a core nursing skill.",
        "😊 Explanation: Nurses must be compassionate and good communicators to effectively support and care for patients."
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
              builder: (_) => const FlorenceNightingaleAnimation()),
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


class FlorenceNightingaleAnimation extends StatefulWidget {
  const FlorenceNightingaleAnimation({super.key});

  @override
  State<FlorenceNightingaleAnimation> createState() =>
      _FlorenceNightingaleAnimationState();
}

class _FlorenceNightingaleAnimationState
    extends State<FlorenceNightingaleAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _entryCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _bgCtrl;
  late final AnimationController _lampCtrl;
  late final AnimationController _flameCtrl;
  late final AnimationController _waveCtrl;
  late final AnimationController _particleCtrl;
  late final AnimationController _beamsCtrl;

  late final Animation<double> _textFade;
  late final Animation<double> _textSlide;
  late final Animation<double> _subtitleFade;
  late final Animation<double> _dividerWidth;
  late final Animation<double> _iconFade;
  late final Animation<double> _iconScale;
  late final Animation<double> _glow;
  late final Animation<Color?> _bgColor1;
  late final Animation<Color?> _bgColor2;
  late final Animation<double> _lampFloat;
  late final Animation<double> _flameSwayX;
  late final Animation<double> _flameScaleY;
  late final Animation<double> _wavePhase;
  late final Animation<double> _beamsOpacity;

  final List<_Particle> _particles = [];
  final math.Random _rng = math.Random();

  static const _warmColors = [
    Color(0xFFFFFDE7), Color(0xFFFFE082),
    Color(0xFFFFD54F), Color(0xFFF9A825), Color(0xFFE65100),
  ];

  @override
  void initState() {
    super.initState();
    _spawnParticles();

    _entryCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _textFade = CurvedAnimation(parent: _entryCtrl, curve: const Interval(0.0, 0.65, curve: Curves.easeOut));
    _textSlide = Tween<double>(begin: 12, end: 0).animate(CurvedAnimation(parent: _entryCtrl, curve: const Interval(0.0, 0.65, curve: Curves.easeOutCubic)));
    _subtitleFade = CurvedAnimation(parent: _entryCtrl, curve: const Interval(0.6, 1.0, curve: Curves.easeIn));
    _dividerWidth = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _entryCtrl, curve: const Interval(0.25, 0.75, curve: Curves.easeOut)));
    _iconFade = CurvedAnimation(parent: _entryCtrl, curve: const Interval(0.0, 0.5, curve: Curves.easeOut));
    _iconScale = Tween<double>(begin: 0.85, end: 1.0).animate(CurvedAnimation(parent: _entryCtrl, curve: const Interval(0.0, 0.55, curve: Curves.easeOutBack)));

    _glowCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2600))..repeat(reverse: true);
    _glow = Tween<double>(begin: 14, end: 38).animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));

    _bgCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 9))..repeat(reverse: true);
    _bgColor1 = ColorTween(begin: const Color(0xFF1C0F00), end: const Color(0xFF3D2200)).animate(_bgCtrl);
    _bgColor2 = ColorTween(begin: const Color(0xFFFFD54F), end: const Color(0xFFFFFDE7)).animate(_bgCtrl);

    _lampCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 4000))..repeat(reverse: true);
    _lampFloat = Tween<double>(begin: 0, end: -6).animate(CurvedAnimation(parent: _lampCtrl, curve: Curves.easeInOut));

    _flameCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 950))..repeat(reverse: true);
    _flameSwayX = Tween<double>(begin: -0.12, end: 0.14).animate(CurvedAnimation(parent: _flameCtrl, curve: Curves.easeInOut));
    _flameScaleY = Tween<double>(begin: 0.88, end: 1.14).animate(CurvedAnimation(parent: _flameCtrl, curve: Curves.easeInOut));

    _waveCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2600))..repeat();
    _wavePhase = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _waveCtrl, curve: Curves.linear));

    _particleCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();

    _beamsCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat(reverse: true);
    _beamsOpacity = Tween<double>(begin: 0.04, end: 0.16).animate(CurvedAnimation(parent: _beamsCtrl, curve: Curves.easeInOut));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await _entryCtrl.forward();
      await Future.delayed(const Duration(seconds: 4));
      if (!mounted) return;
      _goToNextScreen();
    });
  }

  void _spawnParticles() {
    for (int i = 0; i < 24; i++) {
      _particles.add(_Particle(
        x: _rng.nextDouble(),
        size: 2.0 + _rng.nextDouble() * 4.0,
        speed: 0.4 + _rng.nextDouble() * 1.4,
        color: _warmColors[_rng.nextInt(_warmColors.length)],
        offset: _rng.nextDouble(),
        wobble: _rng.nextDouble() * math.pi * 2,
      ));
    }
  }

  @override
  void dispose() {
    _entryCtrl.dispose(); _glowCtrl.dispose(); _bgCtrl.dispose();
    _lampCtrl.dispose(); _flameCtrl.dispose(); _waveCtrl.dispose();
    _particleCtrl.dispose(); _beamsCtrl.dispose();
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
          _bgCtrl, _glowCtrl, _lampCtrl, _flameCtrl,
          _waveCtrl, _particleCtrl, _beamsCtrl, _entryCtrl,
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
                      _bgColor1.value ?? const Color(0xFF1C0F00),
                      const Color(0xFF6D4C00),
                      const Color(0xFFB8860B),
                      _bgColor2.value ?? const Color(0xFFFFD54F),
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
                    center: Alignment.center, radius: 1.2,
                    colors: [
                      const Color(0xFFFFFDE7).withOpacity(0.06),
                      Colors.transparent,
                      const Color(0xFF120900).withOpacity(0.78),
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
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ── CANDLE ICON ────────────────────────────
                        FadeTransition(
                          opacity: _iconFade,
                          child: ScaleTransition(
                            scale: _iconScale,
                            child: Transform.translate(
                              offset: Offset(0, _lampFloat.value),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  // Halo rings
                                  ..._buildHaloRings(),
                                  // Candle CustomPainter
                                  SizedBox(
                                    width: 80,
                                    height: 130,
                                    child: CustomPaint(
                                      painter: _CandlePainter2(
                                        glowRadius: _glow.value,
                                        flameSwayX: _flameSwayX.value,
                                        flameScaleY: _flameScaleY.value,
                                    ),
                                  ),
                              )],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 4),

                        // Series label
                        FadeTransition(
                          opacity: _textFade,
                          child: Text(
                            'Girls Who Became Famous',
                            style: TextStyle(
                              fontFamily: 'Georgia', fontSize: 12,
                              letterSpacing: 1.8,
                              color: const Color(0xFFFFD54F).withOpacity(0.9),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        _buildDivider(),
                        const SizedBox(height: 16),

                        // Name
                        FadeTransition(
                          opacity: _textFade,
                          child: Transform.translate(
                            offset: Offset(0, _textSlide.value),
                            child: Text(
                              'Florence Nightingale',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Georgia', fontSize: 26,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFFFFDE7),
                                letterSpacing: 0.8,
                                shadows: [
                                  Shadow(color: const Color(0xFFFFD54F).withOpacity(0.9), blurRadius: _glow.value * 0.6),
                                  Shadow(color: const Color(0xFFF9A825).withOpacity(0.5), blurRadius: _glow.value * 1.6),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Tagline
                        FadeTransition(
                          opacity: _subtitleFade,
                          child: Text(
                            'The lady with the lamp.\nA light in the history of care.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Georgia', fontSize: 14, height: 1.6,
                              color: const Color(0xFFFFD54F).withOpacity(0.85),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildDivider(),
                        const SizedBox(height: 12),
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
      final scale = 1.0 + phase * 1.8;
      final opacity = (1.0 - phase).clamp(0.0, 0.55);
      return Transform.scale(
        scale: scale,
        child: Container(
          width: 60, height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFFFD54F).withOpacity(opacity), width: 1.5),
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
              Colors.transparent, Color(0xFFFFD54F), Color(0xFFFFFDE7), Color(0xFFFFD54F), Colors.transparent,
            ]),
          ),
        ),
      ),
    );
  }
}

// ── Candle CustomPainter ──────────────────────────────────────────────────────
class _CandlePainter2 extends CustomPainter {
  final double glowRadius;
  final double flameSwayX;   // -0.15 .. 0.15
  final double flameScaleY;  // 0.88 .. 1.14

  const _CandlePainter2({
    required this.glowRadius,
    required this.flameSwayX,
    required this.flameScaleY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;

    // ── Dimensions ──────────────────────────────────────────────
    const bodyW = 26.0;
    const bodyH = 62.0;
    const baseW = 44.0;
    const baseH = 9.0;
    const flameH = 38.0;
    const flameW = 18.0;

    final bodyTop = size.height - baseH - bodyH;
    final bodyLeft = cx - bodyW / 2;
    final baseTop = size.height - baseH;

    // ── Ambient glow under candle ────────────────────────────────
    canvas.drawCircle(
      Offset(cx, bodyTop + bodyH * 0.6),
      glowRadius * 1.2,
      Paint()
        ..color = const Color(0xFFFFD54F).withOpacity(0.18)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glowRadius),
    );

    // ── Base plate ───────────────────────────────────────────────
    final basePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter, end: Alignment.bottomCenter,
        colors: [const Color(0xFFF9A825), const Color(0xFFE65100)],
      ).createShader(Rect.fromLTWH(cx - baseW / 2, baseTop, baseW, baseH));
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - baseW / 2, baseTop, baseW, baseH),
        const Radius.circular(4),
      ),
      basePaint,
    );
    // Sheen on base
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - baseW / 2 + 6, baseTop + 2, baseW - 12, 2),
        const Radius.circular(1),
      ),
      Paint()..color = Colors.white.withOpacity(0.2),
    );

    // ── Candle body ──────────────────────────────────────────────
    final bodyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft, end: Alignment.centerRight,
        colors: [
          const Color(0xFFFFE082),
          const Color(0xFFFFFDE7),
          const Color(0xFFFFD54F),
          const Color(0xFFFFB300),
        ],
        stops: const [0.0, 0.35, 0.65, 1.0],
      ).createShader(Rect.fromLTWH(bodyLeft, bodyTop, bodyW, bodyH));
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(bodyLeft, bodyTop, bodyW, bodyH),
        topLeft: const Radius.circular(3),
        topRight: const Radius.circular(3),
        bottomLeft: const Radius.circular(2),
        bottomRight: const Radius.circular(2),
      ),
      bodyPaint,
    );

    // Highlight stripe
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(bodyLeft + 5, bodyTop + 4, 5, bodyH - 8),
        const Radius.circular(3),
      ),
      Paint()..color = Colors.white.withOpacity(0.3),
    );

    // Wax drip 1 (left side)
    _drawDrip(canvas, bodyLeft - 1, bodyTop + 10, 6, 12);
    // Wax drip 2 (right side)
    _drawDrip(canvas, bodyLeft + bodyW - 5, bodyTop + 18, 5, 8);

    // ── Candle top rim (elliptical) ──────────────────────────────
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, bodyTop), width: bodyW + 2, height: 7),
      Paint()
        ..shader = LinearGradient(
          colors: [const Color(0xFFFFFDE7), const Color(0xFFFFE082)],
        ).createShader(Rect.fromCenter(center: Offset(cx, bodyTop), width: bodyW + 2, height: 7)),
    );

    // ── Wick ─────────────────────────────────────────────────────
    final wickTop = bodyTop - 9;
    canvas.drawLine(
      Offset(cx, bodyTop),
      Offset(cx + 1, wickTop),
      Paint()
        ..color = const Color(0xFF3E2723)
        ..strokeWidth = 1.8
        ..strokeCap = StrokeCap.round,
    );

    // ── Flame ────────────────────────────────────────────────────
    final flameCx = cx + flameSwayX * flameW;
    final flameTip = wickTop - flameH * flameScaleY;
    final flameBase = wickTop + 2.0;

    // Outer glow
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(flameCx, flameBase - flameH * 0.45 * flameScaleY),
        width: flameW * 1.8,
        height: flameH * flameScaleY * 1.4,
      ),
      Paint()
        ..color = const Color(0xFFFFB300).withOpacity(0.35)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glowRadius * 0.55),
    );

    // Main flame shape
    final flamePath = _buildFlamePath(flameCx, flameTip, flameBase, flameW, flameH * flameScaleY);
    canvas.drawPath(
      flamePath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.bottomCenter, end: Alignment.topCenter,
          colors: [
            const Color(0xFFFF6D00),
            const Color(0xFFFFD54F),
            const Color(0xFFFFFDE7),
          ],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(Rect.fromLTWH(flameCx - flameW / 2, flameTip, flameW, flameH * flameScaleY)),
    );

    // Inner bright core
    final innerPath = _buildFlamePath(
      flameCx, flameTip + flameH * flameScaleY * 0.18,
      flameBase, flameW * 0.55, flameH * flameScaleY * 0.65,
    );
    canvas.drawPath(
      innerPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.bottomCenter, end: Alignment.topCenter,
          colors: [const Color(0xFFFFE082), const Color(0xFFFFFFFF)],
        ).createShader(Rect.fromLTWH(
          flameCx - flameW * 0.3, flameTip + flameH * flameScaleY * 0.18,
          flameW * 0.55, flameH * flameScaleY * 0.65,
        ))
        ..blendMode = BlendMode.plus,
    );

    // Top glow
    canvas.drawCircle(
      Offset(flameCx, flameTip + 4),
      glowRadius * 0.45,
      Paint()
        ..color = const Color(0xFFFFFDE7).withOpacity(0.55)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glowRadius * 0.4),
    );
  }

  void _drawDrip(Canvas canvas, double x, double y, double w, double h) {
    final path = Path()
      ..moveTo(x, y)
      ..lineTo(x + w, y)
      ..lineTo(x + w, y + h - 3)
      ..quadraticBezierTo(x + w / 2, y + h + 3, x, y + h - 3)
      ..close();
    canvas.drawPath(
      path,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [const Color(0xFFFFFDE7), const Color(0xFFFFE082)],
        ).createShader(Rect.fromLTWH(x, y, w, h)),
    );
  }

  Path _buildFlamePath(double cx, double tip, double base, double w, double h) {
    return Path()
      ..moveTo(cx, tip)
      ..cubicTo(cx + w * 0.7, tip + h * 0.3, cx + w * 0.55, base - 2, cx, base)
      ..cubicTo(cx - w * 0.55, base - 2, cx - w * 0.7, tip + h * 0.3, cx, tip)
      ..close();
  }

  @override
  bool shouldRepaint(_CandlePainter2 old) =>
      old.glowRadius != glowRadius ||
      old.flameSwayX != flameSwayX ||
      old.flameScaleY != flameScaleY;
}

// ── Beams ─────────────────────────────────────────────────────────────────────
class _BeamsPainter extends CustomPainter {
  final double opacity;
  const _BeamsPainter({required this.opacity});
  static const _beams = [
    (frac: 0.25, angle: -0.32, alpha: 1.0),
    (frac: 0.50, angle: -0.15, alpha: 0.65),
    (frac: 0.75, angle: -0.08, alpha: 0.38),
  ];
  @override
  void paint(Canvas canvas, Size size) {
    for (final b in _beams) {
      final cx = size.width * b.frac;
      final paint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFFFFFDE7).withOpacity(opacity * b.alpha),
            const Color(0xFFFFD54F).withOpacity(opacity * 0.5 * b.alpha),
            Colors.transparent,
          ],
        ).createShader(Rect.fromLTWH(cx - 1, 0, 2, size.height));
      canvas.save();
      canvas.translate(cx, size.height * 0.5);
      canvas.rotate(b.angle);
      canvas.drawRect(Rect.fromLTWH(-1, -size.height * 0.9, 2, size.height * 1.8), paint);
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
      canvas.drawCircle(
        Offset(p.x * size.width + dx, y), p.size * 0.55,
        Paint()..color = p.color.withOpacity(opacity * 0.65)..maskFilter = MaskFilter.blur(BlurStyle.normal, p.size * 0.5),
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
In the heart of London stands one of its most remarkable landmarks—St. Thomas’ Hospital. This vast, four-story brick building, trimmed with stone, hums quietly with purpose. Within its walls lies the Nightingale Training School for Nurses, a living tribute to Florence Nightingale, whose service during the Crimean War so moved the British government that they gifted her a sum of \$250,000. True to her character, Florence refused to keep a penny for herself. Instead, she used the entire fund to create a school that would empower young women to bring comfort and healing, just as she had done.

This school—called the "Nightingale Home"—is no cold institution. The dining room alone, painted in warm reds and gentle shades, invites comfort and community. A Swiss clock gifted by the Grand Duchess of Baden ticks quietly against the wall. A harpsichord, another present, sits by the window. But the centerpiece is a marble likeness of Florence herself—her face serene, intelligent, and kind, her expression resolute, as though she had long ago discovered that life, in all its complexity, was still worth every effort.
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
        "What was Florence Nightingale’s goal after receiving the government’s gift?",
    options: [
      "A) To travel through Europe",
      "B) To retire comfortably",
      "C) To help more wounded soldiers",
      "D) To establish a nurse training school"
    ],
    correctIndex: 3,
    explanation:
        ' She used the entire fund to found the Nightingale Training School to train nurses. 🏫💉 Her focus remained on improving healthcare and professional nursing.',
    incorrectExplanations: [
      ' She didn’t use the funds for personal travel.',
      ' Retirement was not her priority.',
      ' While she cared for soldiers, this wasn’t her main use of the gift.',
      ' Correct answer! 🎯'
    ],
  ),
  QuestionData(
    question:
        "How did Florence Nightingale honor the spirit of service after the war?",
    options: [
      "A) By creating a welcoming school for nurses",
      "B) By building a war memorial",
      "C) By writing books about the war",
      "D) By donating to hospitals overseas"
    ],
    correctIndex: 0,
    explanation:
        ' She created a warm, inviting school for nurses—decorated and thoughtfully designed to reflect care and community. 🏥🌸',
    incorrectExplanations: [
      ' Correct answer! 🎯',
      ' She didn’t build a memorial, she built a school.',
      ' Though she wrote, her honoring act was creating the school.',
      ' Donations weren’t the focus of this gesture.'
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
Florence's influence runs through every corridor. Girls from high society sit beside working-class women, all bound by the same purpose: to serve. They are known as “probationers” and must undergo three years of rigorous training before they can become Protestant sisters. Each hospital ward is named after a royal figure—Leopold or Victoria—and placed in the hands of one of these sisters. Their days are long, their work demanding, but their spirits remain bright. They are allowed time off and are encouraged to take fresh air; their laughter can sometimes be heard mingling with the breeze in the courtyard.

The patients—four hundred of them, suffering from a hundred different ailments—find solace not only in medicine but in the gentle presence of these women. Flowerpots brighten the wards, as do the kind hands and quiet strength of the nurses. Many patients speak not of pain but of peace—how much easier it is to endure when a woman’s hands offer care.

But who was Florence Nightingale, the woman to whom Britain owed so much?

Born in 1820 in the romantic city of Florence, Italy, she was the younger daughter of William Shore Nightingale, a wealthy English landowner who had inherited both his fortune and his surname from his great-uncle, Peter Nightingale. Her mother, Frances, was the daughter of William Smith, a well-known philanthropist and Member of Parliament. The family estate, Lea Hurst in Derbyshire, nestled in picturesque countryside, was where Florence spent much of her youth. Her father, a man of learning, tutored her in Latin, Greek, and higher mathematics. Extensive travel gave her fluency in French, German, and Italian.
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
    question:
        "What was Florence Nightingale’s goal for the young women training at her school?",
    options: [
      "A) To become doctors",
      "B) To provide patient care and healing",
      "C) To be politically active",
      "D) To become wealthy"
    ],
    correctIndex: 1,
    explanation:
        ' Florence\'s goal was to train women to provide care and healing to patients in need, regardless of their social status. 💊❤️',
    incorrectExplanations: [
      ' Becoming doctors was not the focus of her program.',
      ' Correct answer! 🎯',
      ' Political activism wasn’t the objective of the training.',
      ' Wealth was not a goal of the nursing program.'
    ],
  ),
  QuestionData(
    question:
        "How did Florence Nightingale achieve her goal of training nurses?",
    options: [
      "A) By teaching them at home",
      "B) By allowing them to focus on academics only",
      "C) By creating a rigorous three-year training program",
      "D) By providing free accommodations"
    ],
    correctIndex: 2,
    explanation:
        ' She established a demanding three-year program where nurses, called probationers, trained intensely before becoming Protestant sisters. 🏥📘',
    incorrectExplanations: [
      ' Training was not conducted at home.',
      ' Her program emphasized hands-on training, not just academics.',
      ' Correct answer! 🎯',
      ' While accommodations may have been provided, the key was the rigorous training.'
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


  final String biographyTextSecond = '''
She had every advantage—wealth, beauty, and education. Yet her dreams did not follow the gilded path laid before her. While others in her circle chased fashion and social prestige, Florence gravitated toward the sick, the poor, and the forgotten. As a girl she often visited the needy near both Lea Hurst and the family’s other estate in Hampshire. From an early age, she seemed to possess an instinctive desire to help—an inheritance, perhaps, from her grandfather, William Smith.

Her compassion extended to animals as well. Even the shyest squirrels in the family’s wooded garden grew tame around her, venturing close to gather the nuts she scattered for them. An old gray pony, Peggy, would trot up whenever she appeared, gently nudging Florence’s dress for the apple or crust she always carried. She seemed to be surrounded by life drawn to her gentleness.
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
        "What was Florence Nightingale's goal despite her wealth and social standing?",
    options: [
      "A) To pursue fame, richness and luxury",
      "B) To become a teacher for poor children",
      "C) To help the sick, poor, and forgotten",
      "D) To create a family business"
    ],
    correctIndex: 2,
    explanation:
        ' Florence was driven by a deep desire to care for the needy and those often overlooked by society, despite her privileged background. 🕊️🤝',
    incorrectExplanations: [
      ' She rejected fame and luxury for a life of service.',
      ' While she valued education, her goal was broader than teaching.',
      ' Correct answer! 🎯',
      ' She did not pursue a business career.'
    ],
  ),
  QuestionData(
    question: "How did Florence show her compassion from an early age?",
    options: [
      "A) By becoming a famous doctor",
      "B) By becoming a teacher for young children",
      "C) By organizing charity events",
      "D) By visiting the poor near her estates"
    ],
    correctIndex: 3,
    explanation:
        ' Florence’s compassion was evident in her visits to the sick and poor near her family estates, showing an early commitment to helping others. 🌿💖',
    incorrectExplanations: [
      ' She was not a doctor in her youth.',
      ' Teaching wasn’t how she primarily showed compassion early on.',
      ' Her efforts were direct and personal, not through charity events.',
      ' Correct answer! 🎯'
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

class _BiographyReadingPageFiveState extends State<BiographyReadingPageFive> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;
  int _lastQuestionIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final String biographyTextSecond = '''
One story, recalled from her childhood, captures her spirit perfectly. Not far from their estate lived Roger, an elderly shepherd, and his beloved sheepdog, Cap. Cap was more than a pet—he was Roger’s partner and companion. One day, a mischievous boy threw a stone that injured Cap’s leg. With his loyal dog unable to work, Roger believed he had no choice but to end his life. When Florence and a family friend learned of this, they visited Cap themselves. Florence’s touch calmed the frightened dog, and the vicar examined the leg. It turned out to be badly bruised, not broken.

Determined to ease the animal’s pain, Florence lit the fire, prepared warm water, and tore strips from an old flannel petticoat to soothe the swelling. The next morning, she returned to care for Cap again, and even replaced the skirt she had used with two new ones for the woman she had borrowed from. Days later, Cap was back in the field, watching over the sheep. Roger, with tears in his eyes, declared it the greatest favor anyone had done him.

A girl who found such happiness in saving a dog would naturally find even greater joy in saving people. During trips to London, Florence spent her time not in ballrooms but in hospitals and charitable institutions. In Egypt, she nursed sick Arabs back to health; many believed she was a saint sent down from heaven.

Her calling became undeniable. She realized that to truly help, she needed deeper knowledge. In her travels across Europe, she studied hospitals and infirmaries, noting their procedures and conditions. Catholic Sisters of Charity were tending the sick—why, she wondered, couldn’t Protestant women do the same?
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

final List<QuestionData> sampleQuestionsFive = [
  QuestionData(
    question: "What was Florence’s reaction when Cap, the dog, was injured?",
    options: [
      "A) She immediately sent for a doctor",
      "B) She cared for the dog and treated his injury herself",
      "C) She offered to buy a new dog for Roger but he hesitated",
      "D) She ignored the situation"
    ],
    correctIndex: 1,
    explanation:
        ' Florence showed her compassion by personally caring for Cap’s injury, even using parts of her own clothing to help the dog heal. 🐶🩹',
    incorrectExplanations: [
      ' She didn’t call a doctor; she took action herself.',
      ' Correct answer! 🎯',
      ' Buying a new dog wasn’t her chosen response.',
      ' She responded with empathy, not neglect.'
    ],
  ),
  QuestionData(
    question: "What did Florence learn from her travels in Europe?",
    options: [
      "A) To become a professional dancer and travel around the world",
      "B) How to build hospitals from scratch",
      "C) Protestant women could care for the sick like Catholic Sisters",
      "D) How to run a large hospital in London"
    ],
    correctIndex: 2,
    explanation:
        ' Florence realized Protestant women could serve the sick in hospitals, inspiring her mission. ✨🩺',
    incorrectExplanations: [
      ' She wasn’t interested in becoming a dancer.',
      ' The focus was on care, not hospital construction.',
      ' Correct answer! 🎯',
      ' Managing a London hospital was not the key takeaway.'
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

class _BiographyReadingPageFinalState extends State<BiographyReadingPageFinal> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;
  int _lastQuestionIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final String biographyTextSecond = '''
To pursue this vision, she enrolled for a time at the Lutheran hospital at Kaiserwerth, near Düsseldorf. This institution had been founded by Pastor Fliedner, a man of extraordinary heart. Beginning with an impoverished church and a handful of faithful parishioners, he had raised money through travels, preaching even in prisons. Inspired by his encounter with Elizabeth Fry in England—a woman whose own work with the incarcerated left deep marks—he returned to Germany with a vision for social care. One by one, he built homes for discharged prisoners, schools for working children, and hospitals for the mentally ill.

Out of these efforts emerged the Deaconess movement—a community of trained Protestant women serving in hospitals across Europe. Florence walked their halls, learned from their example, and absorbed the discipline and purpose that would shape her future.

Later, in the midst of war, she would become "The Lady with the Lamp," ministering through the night in Crimean hospitals, transforming not only nursing but the way nations care for the vulnerable.

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
        "Why did Florence enroll at the Lutheran hospital in Kaiserwerth?",
    options: [
      "A) To become a Catholic nun",
      "B) To learn about running a hospital business",
      "C) To work with prisoners and mentally ill patients",
      "D) To study under Pastor Fliedner and learn social care"
    ],
    correctIndex: 3,
    explanation:
        " Florence enrolled to study under Pastor Fliedner and learn social care, shaping her future work in nursing. 🏥📚",
    incorrectExplanations: [
      " Becoming a Catholic nun was not her goal.",
      " Running a hospital business wasn't her reason for enrolling.",
      " Although she cared for the ill, this wasn't the main reason she enrolled.",
      " Correct answer! 🎯"
    ],
  ),
  QuestionData(
    question: "What did Florence learn from the Deaconess movement?",
    options: [
      "A) How to become a religious leader",
      "B) The importance of discipline and purpose in nursing",
      "C) How to manage a hospital",
      "D) The skills to build homes and schools"
    ],
    correctIndex: 1,
    explanation:
        " Florence learned discipline and purpose, which greatly influenced her future nursing work. 🎓💡",
    incorrectExplanations: [
      " Religious leadership wasn’t her primary lesson from the movement.",
      " Correct answer! 🎯",
      " Hospital management wasn’t the key takeaway here.",
      " Construction skills were not part of this movement's focus."
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
