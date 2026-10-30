import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Green/Content/Spot2/Spot_Page/Reading_Spot_Page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
import 'dart:math' as math;

class UgandasAnimationOne extends StatefulWidget {
  const UgandasAnimationOne({super.key});

  @override
  State<UgandasAnimationOne> createState() => _UgandasAnimationOneState();
}

class _UgandasAnimationOneState extends State<UgandasAnimationOne>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _floatController;
  late AnimationController _bgController;
  late AnimationController _pulseController;

  late Animation<double> _fadeIn;
  late Animation<double> _scaleUp;
  late Animation<double> _titleSlide;
  late Animation<double> _authorFade;
  late Animation<double> _dividerWidth;
  late Animation<double> _iconPulse;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _floatController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _bgController = AnimationController(
      duration: const Duration(seconds: 9),
      vsync: this,
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2400),
      vsync: this,
    )..repeat(reverse: true);

    _fadeIn = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    _scaleUp = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _titleSlide = Tween<double>(begin: 28, end: 0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.3, 0.75, curve: Curves.easeOutCubic),
      ),
    );

    _authorFade = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
    );

    _dividerWidth = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 0.9, curve: Curves.easeOutCubic),
      ),
    );

    _iconPulse = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    _mainController.forward();

    Future.delayed(const Duration(milliseconds: 4500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const News_Ugandas(),
            transitionsBuilder: (_, anim, __, child) => FadeTransition(
              opacity: anim,
              child: child,
            ),
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _floatController.dispose();
    _bgController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // ── Fondo verde animado ──
          _AnimatedBackground(
            floatController: _floatController,
            bgController: _bgController,
            size: size,
          ),

          // ── Contenido principal ──
          Center(
            child: FadeTransition(
              opacity: _fadeIn,
              child: ScaleTransition(
                scale: _scaleUp,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icono flotante con pulso
                      AnimatedBuilder(
                        animation: Listenable.merge(
                            [_floatController, _pulseController]),
                        builder: (_, child) => Transform.translate(
                          offset: Offset(0, -9 * _floatController.value + 4.5),
                          child: Transform.scale(
                            scale: _iconPulse.value,
                            child: child,
                          ),
                        ),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.22),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.handFist,
                              color: Colors.white.withOpacity(0.92),
                              size: 46,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 26),

                      // Título con slide-up
                      AnimatedBuilder(
                        animation: _titleSlide,
                        builder: (_, child) => Transform.translate(
                          offset: Offset(0, _titleSlide.value),
                          child: Opacity(
                            opacity:
                                (1 - _titleSlide.value / 28).clamp(0.0, 1.0),
                            child: child,
                          ),
                        ),
                        child: Text(
                          "Uganda's anti-gay law sparks\nglobal concerns",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.42,
                            letterSpacing: 0.2,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 12,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Divider animado
                      AnimatedBuilder(
                        animation: _dividerWidth,
                        builder: (_, __) => Container(
                          width: 140 * _dividerWidth.value,
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.white.withOpacity(0.45),
                                Colors.transparent,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Autor
                      FadeTransition(
                        opacity: _authorFade,
                        child: Text(
                          "By Dann Okoth, 2023",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.7),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      FadeTransition(
                        opacity: _authorFade,
                        child: Text(
                          "From SciDev.Net",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.7),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),

                      const SizedBox(height: 34),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Fondo animado ─────────────────────────────────────────────────────────

class _AnimatedBackground extends StatelessWidget {
  final AnimationController floatController;
  final AnimationController bgController;
  final Size size;

  const _AnimatedBackground({
    required this.floatController,
    required this.bgController,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([floatController, bgController]),
      builder: (_, __) => CustomPaint(
        size: size,
        painter: _BackgroundPainter(
          floatValue: floatController.value,
          bgValue: bgController.value,
        ),
      ),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final double floatValue;
  final double bgValue;

  _BackgroundPainter({required this.floatValue, required this.bgValue});

  static const Color _darkGreen = Color(0xFF123D23);
  static const Color _midGreen = Color(0xFF1A5C35);
  static const Color _lightGreen = Color(0xFF2D7A4F);

  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(77);

    // Gradiente de fondo
    final bgRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final bgPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_lightGreen, _midGreen, _darkGreen],
        stops: [0.0, 0.45 + 0.05 * sin(bgValue * 2 * pi), 1.0],
        transform: GradientRotation(pi * (0.44 + 0.04 * sin(bgValue * pi))),
      ).createShader(bgRect);
    canvas.drawRect(bgRect, bgPaint);

    // Blobs
    _drawBlob(
        canvas,
        Offset(size.width * 0.2 + 6 * sin(bgValue * 2 * pi),
            size.height * 0.15 - 8 * cos(bgValue * 2 * pi)),
        220,
        Colors.white.withOpacity(0.04 + 0.02 * sin(bgValue * 2 * pi)));
    _drawBlob(canvas, Offset(size.width * 0.85, size.height * 0.85), 180,
        Colors.black.withOpacity(0.12 + 0.04 * cos(bgValue * 2 * pi)));
    _drawBlob(canvas, Offset(size.width * 0.1, size.height * 0.78), 140,
        Colors.white.withOpacity(0.035));

    // Cuadrícula sutil
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.055)
      ..strokeWidth = 0.7;
    const step = 55.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Partículas flotantes
    final particles = List.generate(12, (i) {
      final x = (rng.nextDouble() * 0.82 + 0.09) * size.width;
      final baseY = (rng.nextDouble() * 0.82 + 0.09) * size.height;
      final speed = 0.6 + rng.nextDouble() * 1.4;
      final phase = rng.nextDouble() * 2 * pi;
      final y = baseY - 16 * sin(floatValue * pi * speed + phase).abs();
      final rot = 0.14 * sin(floatValue * pi * speed + phase);
      return (x, y, rot, rng.nextDouble(), i % 5);
    });

    for (final p in particles) {
      canvas.save();
      canvas.translate(p.$1, p.$2);
      canvas.rotate(p.$3);
      final opacity = 0.18 + 0.12 * p.$4;
      switch (p.$5) {
        case 0:
          _drawPeaceSign(canvas, opacity, p.$4 * 6 + 14);
          break;
        case 1:
          _drawGlobe(canvas, opacity, p.$4 * 5 + 13);
          break;
        case 2:
          _drawDiamond(canvas, opacity, p.$4 * 4 + 8);
          break;
        case 3:
          _drawStar(canvas, opacity, p.$4 * 3 + 7);
          break;
        case 4:
          _drawHeart(canvas, opacity, p.$4 * 4 + 10);
          break;
      }
      canvas.restore();
    }
  }

  void _drawBlob(Canvas canvas, Offset center, double radius, Color color) {
    canvas.drawCircle(center, radius, Paint()..color = color);
  }

  void _drawPeaceSign(Canvas canvas, double opacity, double sz) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(Offset.zero, sz, paint);
    canvas.drawLine(Offset(0, -sz), Offset(0, sz), paint);
    canvas.drawLine(Offset.zero, Offset(-sz * 0.7, sz * 0.7), paint);
    canvas.drawLine(Offset.zero, Offset(sz * 0.7, sz * 0.7), paint);
  }

  void _drawGlobe(Canvas canvas, double opacity, double sz) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9;

    canvas.drawCircle(Offset.zero, sz, paint);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: sz, height: sz * 2),
      paint,
    );
    canvas.drawLine(Offset(-sz, -sz * 0.4), Offset(sz, -sz * 0.4), paint);
    canvas.drawLine(Offset(-sz, sz * 0.4), Offset(sz, sz * 0.4), paint);
  }

  void _drawDiamond(Canvas canvas, double opacity, double sz) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.fill;
    final stroke = Paint()
      ..color = Colors.white.withOpacity(opacity * 1.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.7;

    final path = Path()
      ..moveTo(0, -sz)
      ..lineTo(sz * 0.6, 0)
      ..lineTo(0, sz)
      ..lineTo(-sz * 0.6, 0)
      ..close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, stroke);
  }

  void _drawStar(Canvas canvas, double opacity, double sz) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.fill;

    final path = Path();
    const points = 4;
    for (int i = 0; i < points * 2; i++) {
      final r = i.isEven ? sz : sz * 0.4;
      final angle = i * pi / points - pi / 2;
      i == 0
          ? path.moveTo(r * cos(angle), r * sin(angle))
          : path.lineTo(r * cos(angle), r * sin(angle));
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawHeart(Canvas canvas, double opacity, double sz) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, sz * 0.3)
      ..cubicTo(-sz * 0.1, sz * 0.1, -sz * 0.5, -sz * 0.2, -sz * 0.5, -sz * 0.1)
      ..cubicTo(-sz * 0.5, -sz * 0.5, 0, -sz * 0.4, 0, -sz * 0.05)
      ..cubicTo(0, -sz * 0.4, sz * 0.5, -sz * 0.5, sz * 0.5, -sz * 0.1)
      ..cubicTo(sz * 0.5, -sz * 0.2, sz * 0.1, sz * 0.1, 0, sz * 0.3)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_BackgroundPainter old) =>
      old.floatValue != floatValue || old.bgValue != bgValue;
}

// ── Dots de carga ─────────────────────────────────────────────────────────

class _LoadingDots extends StatefulWidget {
  const _LoadingDots();

  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with TickerProviderStateMixin {
  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _anims = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 3; i++) {
      final c = AnimationController(
        duration: const Duration(milliseconds: 650),
        vsync: this,
      );
      _controllers.add(c);
      _anims.add(Tween<double>(begin: 0, end: -5).animate(
        CurvedAnimation(parent: c, curve: Curves.easeInOut),
      ));
      Future.delayed(Duration(milliseconds: i * 180), () {
        if (mounted) c.repeat(reverse: true);
      });
    }
  }

  @override
  void dispose() {
    // ignore: curly_braces_in_flow_control_structures
    for (final c in _controllers) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        return AnimatedBuilder(
          animation: _anims[i],
          builder: (_, __) => Transform.translate(
            offset: Offset(0, _anims[i].value),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.45),
              ),
            ),
          ),
        );
      }),
    );
  }
}

//-------/// Ugandas.dart ///-------//
class News_Ugandas extends StatefulWidget {
  const News_Ugandas({super.key});
  @override
  State<News_Ugandas> createState() => _News_UgandasState();
}

class _News_UgandasState extends State<News_Ugandas> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "On which continent is Uganda located?",
      "options": ["A) Asia", "B) Europe", "C) Africa", "D) South America"],
      "correct": 2,
      "feedback": [
        " Incorrect. Uganda is not in Asia.",
        " Incorrect. Uganda is not located in Europe.",
        "🌍 Correct! Uganda is in East Africa, bordering Kenya, South Sudan, DR Congo, Rwanda, and Tanzania.",
        " Incorrect. Uganda is not in South America."
      ]
    },
    {
      "question":
          "When did Uganda gain independence from British colonial rule?",
      "options": ["A) 1962", "B) 1950", "C) 1971", "D) 1986"],
      "correct": 0,
      "feedback": [
        "🎉 Correct! Uganda became independent on October 9, 1962.",
        " Incorrect. This was too early.",
        " Incorrect. This date refers to other events in Ugandan history, not independence.",
        " Incorrect. This was not the year Uganda gained independence."
      ]
    },
    {
      "question": "What is a notable feature of Uganda's agricultural sector?",
      "options": [
        "A) Heavy reliance on imports",
        "B) Advanced irrigation systems",
        "C) Production of high-quality coffee",
        "D) Limited agricultural output"
      ],
      "correct": 2,
      "feedback": [
        " Incorrect. Uganda is more known for exports than reliance on imports.",
        " Incorrect. Advanced irrigation is not a highlighted feature.",
        "☕ Correct! Uganda is famous for its high-quality coffee, including robusta and arabica.",
        " Incorrect. Uganda’s agricultural sector is productive, especially in coffee."
      ]
    },
    {
      "question": "What is a key cultural contribution of Uganda to the world?",
      "options": [
        "A) Its technological innovations",
        "B) Its traditional music and dance",
        "C) Its urban architecture",
        "D) Its financial services"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Uganda is more known for its cultural heritage than tech innovations.",
        "💃 Correct! Uganda’s music and dance include Baganda drums and Bwola dance.",
        " Incorrect. Urban architecture is not a widely recognized contribution.",
        " Incorrect. Financial services are not a standout cultural contribution."
      ]
    },
    {
      "question": "What is a significant challenge facing Uganda's economy?",
      "options": [
        "A) High technological advancement",
        "B) Political stability",
        "C) Excessive foreign investment",
        "D) Poverty and unemployment"
      ],
      "correct": 3,
      "feedback": [
        " Incorrect. Uganda is still developing technologically.",
        " Incorrect. While political stability is improving, it's not the main challenge mentioned.",
        " Incorrect. The issue is lack of investment, not excess.",
        "⚠️ Correct! Uganda faces poverty and unemployment, especially among rural populations."
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
              builder: (_) => const GreenNewsReadingAnimation(
                    title: 'Uganda\'s anti-gay law sparks\nglobal concerns',
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
                  "assets/Wallpapers/WallPaperReadingSpots/FONDO GOAL INSTRUCTION 1B Y news.webp",
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
[NAIROBI] Uganda’s anti-homosexuality legislation, which includes the death penalty for offenders, was signed into law on Monday by President Yoweri Museveni, sparking international condemnation. 

The new rule, which had been mooted by the country’s legislators, was passed into law last week (29 May) by President Yoweri Museveni. The law criminalizes same-sex relationships and imposes harsh penalties, including capital punishment for homosexuals.  

U.S. President Joe Biden, in a statement, described the law as a tragic violation of universal human rights that jeopardizes Uganda’s prospects for critical economic growth.

''';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkScrollEnd);

    // Inicialización segura del controller
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

    // Reiniciar y reproducir la animación
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
        '"The new rule, which had been mooted by the country’s legislators, was passed into law last week (29 May) by President Yoweri Museveni."\n\nWhat does “the new rule” refer to?',
    options: [
      "A) A new economic policy",
      "B) International human rights standards",
      "C) Uganda’s anti-homosexuality legislation",
      "D) A statement by U.S. President Joe Biden"
    ],
    correctIndex: 2,
    explanation:
        '“The new rule” refers to Uganda’s anti-homosexuality legislation, mentioned in the previous paragraph.',
    incorrectExplanations: [
      ' A new economic policy is not discussed in this context.',
      ' International human rights standards are mentioned only as a point of criticism, not as the rule.',
      ' Correct answer!',
      ' A statement by the U.S. President is not the law being referred to.',
    ],
  ),
  QuestionData(
    question:
        '"Uganda’s anti-homosexuality legislation, which includes the death penalty for offenders, was signed into law on Monday."\n\nWho does “offenders” refer to?',
    options: [
      "A) Homosexuals",
      "B) Human rights activists",
      "C) Government officials",
      "D) Foreign nationals"
    ],
    correctIndex: 0,
    explanation:
        '“Offenders” refers to individuals who violate the anti-homosexuality legislation, as described in the sentence.',
    incorrectExplanations: [
      ' Correct answer!',
      ' Human rights activists are not identified as offenders in the sentence.',
      ' Government officials are not mentioned in this context.',
      ' Foreign nationals are not specified as the group referred to.',
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
He said: “The enactment of Uganda’s anti-homosexuality act is a tragic violation of universal human rights, one that is not worthy of the Ugandan people — and one that jeopardizes the prospects of critical economic growth for the entire country.”

The European Union (EU) high representative of the European Union for Foreign Affairs and Security Policy, Josep Borrell, also condemned the law, stating that it introduces severe punishments, including the death penalty, which the EU opposes in all circumstances. Borrell emphasized that the law contradicts international human rights standards and Uganda’s obligations under the African Charter on Human and People’s Rights.

“Uganda now runs the risk of losing support from programs such as Global Fund, UNAIDS, and PEPFAR. If this happens it’s not the politicians who suffer, but vulnerable children and communities who would no longer access health care for Aids, malaria, and tuberculosis.”

Joakim Osur, professor of Gynecology and vice-chancellor at Amref International University
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
        '"He said: "The enactment of Uganda’s anti-homosexuality act is a tragic violation of universal human rights, one that is not worthy of the Ugandan people""\n\nWhat does “he” refer to?',
    options: [
      "A) President Museveni",
      "B) President Biden",
      "C) The Ugandan government",
      "D) The European Union"
    ],
    correctIndex: 1,
    explanation:
        '“He” refers to President Joe Biden, the United States president at the time, who publicly condemned Uganda’s anti-homosexuality law.',
    incorrectExplanations: [
      ' President Museveni signed the law; he did not condemn it in this way.',
      ' Correct answer!',
      ' The Ugandan government is an institution, not the individual speaker referred to as “he.”',
      ' The European Union is not a single person and is not referred to by “he.”',
    ],
  ),
  QuestionData(
    question:
        '"Uganda now runs the risk of losing support from programs such as Global Fund, UNAIDS, and PEPFAR. If this happens it’s not the politicians who suffer, but vulnerable children and communities."\n\nWhat does “it” refer to?',
    options: [
      "A) The passing of the anti-homosexuality law",
      "B) Uganda losing international support",
      "C) The criticism from foreign governments",
      "D) The actions of Ugandan politicians"
    ],
    correctIndex: 1,
    explanation:
        '“It” refers to Uganda losing international support from health and aid programs, which is the risk mentioned in the previous sentence.',
    incorrectExplanations: [
      ' The passing of the law is the cause, not what “it” refers to.',
      ' Correct answer!',
      ' Criticism from foreign governments is mentioned elsewhere, not as the risk described by “it.”',
      ' The actions of politicians are not the event being referred to by “it.”',
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
Aside from the human rights backlash, the new legislation puts Uganda at odds with humanitarian organizations supporting health programs in the country. 

The Global Fund to Fight AIDS, Tuberculosis, and Malaria, the joint United Nations Program on HIV/AIDS (UNAIDS), and the US President’s Emergency Plan for AIDS Relief (PEPFAR) all condemned the law in a joint statement. 

These organizations warned that the law would jeopardize Uganda’s progress in HIV response, and hinder health education and outreach efforts to combat AIDS as a public health threat. 

“The stigma and discrimination associated with the law have already resulted in reduced access to prevention and treatment services,” the organizations say.

They added that there is a crucial need for trust, confidentiality, and stigma-free engagement for individuals seeking healthcare and held that the principles of access to healthcare without stigma or discrimination is vital to sustain progress in ending AIDS and saving lives.
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
        '"These organizations warned that the law would jeopardize Uganda’s progress in HIV response."\n\nWhat do “these organizations” refer to?',
    options: [
      "A) The US government and international NGOs",
      "B) The Global Fund, UNAIDS, and PEPFAR",
      "C) Uganda’s health authorities",
      "D) Humanitarian workers in Uganda"
    ],
    correctIndex: 1,
    explanation:
        '“These organizations” refers to the Global Fund, UNAIDS, and PEPFAR, which issued warnings about the negative impact of the law on Uganda’s HIV response.',
    incorrectExplanations: [
      ' The US government and NGOs are not the specific organizations named in the context.',
      ' Correct answer!',
      ' Uganda’s health authorities are not the ones issuing this warning.',
      ' Humanitarian workers are not identified as the organizations mentioned.',
    ],
  ),
  QuestionData(
    question:
        '"The stigma and discrimination associated with the law have already resulted in reduced access to prevention and treatment services,” the organizations say."\n\nWhat does “the law” refer to?',
    options: [
      "A) International health regulations",
      "B) Uganda’s healthcare policies",
      "C) Uganda’s anti-homosexuality legislation",
      "D) Global HIV prevention strategies"
    ],
    correctIndex: 2,
    explanation:
        '“The law” refers to Uganda’s anti-homosexuality legislation, which is discussed throughout the passage as affecting health programs and access to care.',
    incorrectExplanations: [
      ' International health regulations are not the focus of the passage.',
      ' Uganda’s healthcare policies are broader and not the specific law mentioned.',
      ' Correct answer!',
      ' Global HIV prevention strategies are impacted, but they are not the law being referred to.',
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
