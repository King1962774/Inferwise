import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Blue/Content/Spot1/Spot_Page/ReadingSpot.dart';

import 'dart:math' as math;

class AtahualpaSplashScreen extends StatefulWidget {
  const AtahualpaSplashScreen({super.key});

  @override
  State<AtahualpaSplashScreen> createState() => _AtahualpaSplashScreenState();
}

class _AtahualpaSplashScreenState extends State<AtahualpaSplashScreen>
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
        MaterialPageRoute(builder: (_) => const Atahualpa()), // ← Atahualpa()
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
                  SizedBox(
                    width: 180,
                    height: 160,
                    child: CustomPaint(painter: _IntiMaskPainter()),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "The Story of Atahualpa\nLast Inca Emperor",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E1200),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "By: Mark Cartwright, 2016",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF5C3000),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    "World History Encyclopedia",
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

// ─── Máscara Sol Inti fiel a la referencia ───────────────────────────
// ViewBox interno: 180 × 160
class _IntiMaskPainter extends CustomPainter {
  // Escala del viewBox (180×160) al canvas real
  double x(Size s, double v) => v / 180 * s.width;
  double y(Size s, double v) => v / 160 * s.height;
  Offset p(Size s, double px, double py) => Offset(x(s, px), y(s, py));
  double r(Size s, double v) => v / 180 * s.width;

  // Paleta fiel a la imagen de referencia
  static const goldLight = Color(0xFFE8A822); // dorado claro (borde exterior)
  static const goldMid = Color(0xFFD4941A); // dorado medio
  static const teal = Color(0xFF3AADA8); // turquesa
  static const faceBrown = Color(0xFFB06818); // marrón dorado (cara)
  static const faceLight = Color(0xFFC87820); // marrón claro (frente)
  static const darkBrown =
      Color(0xFF7A3E00); // marrón oscuro (cejas, contornos)
  static const veryDark = Color(0xFF2E1200); // muy oscuro (pupilas)
  static const noseDark = Color(0xFF8A4E0A); // nariz
  static const outline = Color(0xFF8A4E0A); // contorno general

  @override
  void paint(Canvas canvas, Size size) {
    // Centro del tocado (base de la cara)
    final cx = x(size, 90);
    final cy = y(size, 92);

    // ── TOCADO: anillos concéntricos con clipPath semicircular ────
    // Solo pintamos la mitad superior recortando con save/restore + clipRect
    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, cy));

    // Anillos de afuera hacia adentro
    _circle(canvas, size, 90, 92, 82, goldLight, null, 0);
    _circle(canvas, size, 90, 92, 70, goldMid, null, 0);
    _circle(canvas, size, 90, 92, 67, teal, null, 0);
    _circle(canvas, size, 90, 92, 60, goldLight, null, 0);
    _circle(canvas, size, 90, 92, 57, teal, null, 0);
    _circle(canvas, size, 90, 92, 50, goldMid, null, 0);

    // Dientes del tocado — rectángulos radiales en el borde exterior
    final toothPaint = Paint()
      ..color = goldLight
      ..style = PaintingStyle.fill;
    for (int i = -6; i <= 6; i++) {
      final double angle = i * 15 * math.pi / 180 - math.pi / 2;
      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(angle + math.pi / 2);
      // Cada diente: rectángulo apuntando hacia afuera
      final toothRect = Rect.fromCenter(
        center: Offset(0, -r(size, 84)),
        width: r(size, 5.5),
        height: r(size, 13),
      );
      final rrect =
          RRect.fromRectAndRadius(toothRect, Radius.circular(r(size, 1)));
      canvas.drawRRect(rrect, toothPaint);
      canvas.restore();
    }

    canvas.restore(); // fin clip semicircular

    // Puntos turquesa — fila exterior (sobre el clip, en arco)
    _arcDots(canvas, size, 90, 92, 64, 13, 15, r(size, 4.0), teal);

    // Puntos turquesa — fila interior
    _arcDots(canvas, size, 90, 92, 53, 11, 18, r(size, 3.0), teal);

    // ── CARA ──────────────────────────────────────────────────────
    // Cuerpo principal de la cara
    final faceRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(x(size, 52), y(size, 80), x(size, 76), y(size, 72)),
      Radius.circular(r(size, 10)),
    );
    canvas.drawRRect(
        faceRect,
        Paint()
          ..color = faceBrown
          ..style = PaintingStyle.fill);
    canvas.drawRRect(
        faceRect,
        Paint()
          ..color = outline
          ..style = PaintingStyle.stroke
          ..strokeWidth = r(size, 2));

    // Frente más clara (parte superior de la cara)
    canvas.save();
    canvas.clipRRect(faceRect);
    canvas.drawRect(
      Rect.fromLTWH(x(size, 52), y(size, 80), x(size, 76), y(size, 22)),
      Paint()
        ..color = faceLight
        ..style = PaintingStyle.fill,
    );
    canvas.restore();

    // ── CEJAS (bloques rectangulares) ─────────────────────────────
    _roundRect(canvas, size, 58, 100, 24, 7, 3, darkBrown);
    _roundRect(canvas, size, 98, 100, 24, 7, 3, darkBrown);

    // ── OJOS ──────────────────────────────────────────────────────
    _drawEye(canvas, size, 70, 116);
    _drawEye(canvas, size, 110, 116);

    // ── NARIZ (bloque geométrico) ─────────────────────────────────
    _roundRect(canvas, size, 81, 122, 18, 18, 3, noseDark);
    _roundRect(canvas, size, 84, 122, 12, 14, 2, darkBrown);
    // Fosas nasales
    canvas.drawCircle(
        p(size, 86, 136),
        r(size, 2.5),
        Paint()
          ..color = const Color(0xFF5C2800)
          ..style = PaintingStyle.fill);
    canvas.drawCircle(
        p(size, 94, 136),
        r(size, 2.5),
        Paint()
          ..color = const Color(0xFF5C2800)
          ..style = PaintingStyle.fill);

    // ── BOCA ──────────────────────────────────────────────────────
    _roundRect(canvas, size, 63, 143, 54, 6, 3, darkBrown);
    _roundRect(canvas, size, 68, 140, 44, 4, 2,
        const Color(0xFF9A5010).withOpacity(0.6));

    // ── OREJERAS (Orejones) ───────────────────────────────────────
    _drawEarring(canvas, size, 46, 114);
    _drawEarring(canvas, size, 134, 114);
  }

  // Círculo relleno
  void _circle(Canvas c, Size s, double cx, double cy, double rad, Color fill,
      Color? stroke, double sw) {
    c.drawCircle(
        p(s, cx, cy),
        r(s, rad),
        Paint()
          ..color = fill
          ..style = PaintingStyle.fill);
    if (stroke != null && sw > 0) {
      c.drawCircle(
          p(s, cx, cy),
          r(s, rad),
          Paint()
            ..color = stroke
            ..style = PaintingStyle.stroke
            ..strokeWidth = r(s, sw));
    }
  }

  // Puntos en arco
  void _arcDots(Canvas c, Size s, double cx, double cy, double rad, int count,
      double stepDeg, double dotR, Color col) {
    final paint = Paint()
      ..color = col
      ..style = PaintingStyle.fill;
    for (int i = 0; i < count; i++) {
      final double half = (count - 1) / 2.0;
      final double deg = (i - half) * stepDeg - 90;
      final double angle = deg * math.pi / 180;
      c.drawCircle(
        Offset(x(s, cx) + math.cos(angle) * r(s, rad),
            y(s, cy) + math.sin(angle) * r(s, rad)),
        dotR,
        paint,
      );
    }
  }

  // Rectángulo redondeado relleno
  void _roundRect(Canvas c, Size s, double lx, double ly, double w, double h,
      double radius, Color col) {
    c.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x(s, lx), y(s, ly), x(s, w), y(s, h)),
        Radius.circular(r(s, radius)),
      ),
      Paint()
        ..color = col
        ..style = PaintingStyle.fill,
    );
  }

  // Ojo almendrado
  void _drawEye(Canvas c, Size s, double ex, double ey) {
    final eyeRect = Rect.fromCenter(
        center: p(s, ex, ey), width: r(s, 22), height: r(s, 16));
    c.drawOval(
        eyeRect,
        Paint()
          ..color = const Color(0xFF5C3000)
          ..style = PaintingStyle.fill);
    c.drawOval(
        eyeRect,
        Paint()
          ..color = darkBrown
          ..style = PaintingStyle.stroke
          ..strokeWidth = r(s, 1.5));
    c.drawCircle(
        p(s, ex, ey),
        r(s, 5),
        Paint()
          ..color = veryDark
          ..style = PaintingStyle.fill);
    c.drawCircle(
      Offset(p(s, ex, ey).dx - r(s, 2), p(s, ex, ey).dy - r(s, 2)),
      r(s, 1.5),
      Paint()
        ..color = const Color(0xFFFFDC50).withOpacity(0.45)
        ..style = PaintingStyle.fill,
    );
  }

  // Orejera Orejón (3 círculos concéntricos + punto turquesa)
  void _drawEarring(Canvas c, Size s, double ex, double ey) {
    _circle(c, s, ex, ey, 12, goldMid, outline, 1.8);
    _circle(c, s, ex, ey, 7, faceBrown, outline, 1.2);
    c.drawCircle(
        p(s, ex, ey),
        r(s, 3),
        Paint()
          ..color = teal
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Atahualpa extends StatefulWidget {
  const Atahualpa({super.key});
  @override
  State<Atahualpa> createState() => _AtahualpaState();
}

class _AtahualpaState extends State<Atahualpa> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What was the capital city of the Inca Empire?",
      "options": ["A) Cuzco", "B) Machu Picchu", "C) Lima", "D) Quito"],
      "correct": 0,
      "feedback": [
        "🏛️ Correct! Cuzco was the political and cultural heart of the Inca Empire.",
        " Machu Picchu was an important site, but not the capital.",
        " Lima was founded later by the Spanish.",
        " Quito was part of the Inca Empire, but not its capital."
      ]
    },
    {
      "question":
          "What was the name of the Inca emperor when the Spanish arrived?",
      "options": ["A) Tupac", "B) Atahualpa", "C) Huayna", "D) Pachacuti"],
      "correct": 1,
      "feedback": [
        " Tupac was an Inca ruler, but not at the time of the Spanish arrival.",
        "👑 Correct! Atahualpa was captured by the Spanish during their conquest.",
        " Huayna Capac was Atahualpa's father and died before the conquest.",
        " Pachacuti was an earlier emperor known for expanding the empire."
      ]
    },
    {
      "question": "Which mountains did the Inca Empire mostly occupy?",
      "options": ["A) Himalayas", "B) Alps", "C) Andes", "D) Rockies"],
      "correct": 2,
      "feedback": [
        " The Himalayas are in Asia, not South America.",
        " The Alps are located in Europe.",
        "⛰️ Correct! The Inca Empire stretched along the Andes Mountains in South America.",
        " The Rockies are in North America."
      ]
    },
    {
      "question":
          "What crop was especially important to the Inca diet and culture?",
      "options": ["A) Corn", "B) Potatoes", "C) Wheat", "D) Bananas"],
      "correct": 1,
      "feedback": [
        " Corn was important, but potatoes were more essential to the Inca diet.",
        "🥔 Correct! Potatoes were a staple food, and the Incas grew many varieties.",
        " Wheat was not native to the Andes and was introduced by Europeans.",
        " Bananas were not as central to the Inca diet as potatoes."
      ]
    },
    {
      "question": "What animal did the Incas use for transport and wool?",
      "options": ["A) Llama", "B) Horse", "C) Goat", "D) Elephant"],
      "correct": 0,
      "feedback": [
        "🦙 Correct! Llamas helped carry goods in the Andes and provided wool.",
        " Horses were brought by the Spanish, not used by the Incas.",
        " Goats were not a primary animal in Inca society.",
        " Elephants are not native to the Americas and were not used by the Incas."
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
          MaterialPageRoute(builder: (_) => const AtahualpaReadingAnimation()),
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
                                style: const TextStyle(color: Colors.black),
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

// ── Entry point de la animación ───────────────────────────────────────────────

// Asegúrate de que esta importación sea correcta según tu proyecto
// import 'package:tu_proyecto/ruta/a/biography_reading_page.dart';

class AtahualpaReadingAnimation extends StatefulWidget {
  const AtahualpaReadingAnimation({super.key});

  @override
  State<AtahualpaReadingAnimation> createState() =>
      _AtahualpaReadingAnimationState();
}

class _AtahualpaReadingAnimationState extends State<AtahualpaReadingAnimation>
    with TickerProviderStateMixin {
  // ── Controllers (Usamos ? para evitar LateInitializationError en el dispose) ──
  AnimationController? _entryCtrl;
  AnimationController? _glowCtrl;
  AnimationController? _bgCtrl;
  AnimationController? _sunCtrl;
  AnimationController? _sunPulseCtrl;
  AnimationController? _particleCtrl;
  AnimationController? _beamsCtrl;

  // ── Animations ───────────────────────────────────────────────────────────────
  late Animation<double> _textFade;
  late Animation<double> _textSlide;
  late Animation<double> _dividerWidth;
  late Animation<double> _sunFade;
  late Animation<double> _glow;
  late Animation<Color?> _bgColor1;
  late Animation<Color?> _bgColor2;
  late Animation<double> _sunRotation;
  late Animation<double> _sunPulse;
  late Animation<double> _beamsOpacity;

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

    // ── Entry ────────────────────────────────────────────────────────────────
    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _textFade = CurvedAnimation(
      parent: _entryCtrl!,
      curve: const Interval(0.0, 0.65, curve: Curves.easeOut),
    );
    _textSlide = Tween<double>(begin: 16, end: 0).animate(
      CurvedAnimation(
        parent: _entryCtrl!,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOutCubic),
      ),
    );
    _dividerWidth = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryCtrl!,
        curve: const Interval(0.25, 0.75, curve: Curves.easeOut),
      ),
    );
    _sunFade = CurvedAnimation(
      parent: _entryCtrl!,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    // ── Glow ─────────────────────────────────────────────────────────────────
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat(reverse: true);
    _glow = Tween<double>(begin: 6, end: 28).animate(
      CurvedAnimation(parent: _glowCtrl!, curve: Curves.easeInOut),
    );

    // ── Background ───────────────────────────────────────────────────────────
    _bgCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat(reverse: true);
    _bgColor1 = ColorTween(
      begin: const Color(0xFF1A0800),
      end: const Color(0xFF2E1600),
    ).animate(_bgCtrl!);
    _bgColor2 = ColorTween(
      begin: const Color(0xFFD4AF37),
      end: const Color(0xFFFAEEDA),
    ).animate(_bgCtrl!);

    // ── Sun rotation ──────────────────────────────────────────────────────────
    _sunCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
    _sunRotation = Tween<double>(begin: 0, end: math.pi * 2).animate(
      CurvedAnimation(parent: _sunCtrl!, curve: Curves.linear),
    );

    // ── Sun pulse ─────────────────────────────────────────────────────────────
    _sunPulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _sunPulse = Tween<double>(begin: 0.92, end: 1.08).animate(
      CurvedAnimation(parent: _sunPulseCtrl!, curve: Curves.easeInOut),
    );

    // ── Particles ─────────────────────────────────────────────────────────────
    _particleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    // ── Beams ────────────────────────────────────────────────────────────────
    _beamsCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _beamsOpacity = Tween<double>(begin: 0.06, end: 0.20).animate(
      CurvedAnimation(parent: _beamsCtrl!, curve: Curves.easeInOut),
    );

    // ── Sequence & Navigation ────────────────────────────────────────────────
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await _entryCtrl?.forward();
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      _goToNextScreen();
    });
  }

  void _spawnParticles() {
    for (int i = 0; i < 26; i++) {
      _particles.add(_Particle(
        x: _rng.nextDouble(),
        size: 2.5 + _rng.nextDouble() * 5.0,
        speed: 0.4 + _rng.nextDouble() * 1.4,
        color: _golden[_rng.nextInt(_golden.length)],
        offset: _rng.nextDouble(),
      ));
    }
  }

  @override
  void dispose() {
    _entryCtrl?.dispose();
    _glowCtrl?.dispose();
    _bgCtrl?.dispose();
    _sunCtrl?.dispose();
    _sunPulseCtrl?.dispose();
    _particleCtrl?.dispose();
    _beamsCtrl?.dispose();
    super.dispose();
  }

  void _goToNextScreen() {
    if (!mounted) return;
    // IMPORTANTE: Asegúrate de que BiographyReadingPage esté importado arriba
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (_, __, ___) =>
            const BiographyReadingPage(), // Cambia esto si el nombre es distinto
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
          _bgCtrl!,
          _glowCtrl!,
          _sunCtrl!,
          _particleCtrl!,
          _beamsCtrl!,
          _entryCtrl!,
        ]),
        builder: (context, _) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // Fondo
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _bgColor1.value ?? const Color(0xFF1A0800),
                      const Color(0xFF5C2A00),
                      const Color(0xFFA0620A),
                      _bgColor2.value ?? const Color(0xFFD4AF37),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              // Halo solar
              Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(-0.2, -0.32),
                    radius: 1.05,
                    colors: [
                      Colors.white.withOpacity(0.13),
                      Colors.transparent
                    ],
                  ),
                ),
              ),
              // Vignette
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.18,
                    colors: [
                      Colors.transparent,
                      const Color(0xFF0F0600).withOpacity(0.68)
                    ],
                  ),
                ),
              ),
              // Rayos de luz
              CustomPaint(painter: _BeamsPainter(opacity: _beamsOpacity.value)),
              // Partículas
              CustomPaint(
                painter: _ParticlePainter(
                  particles: _particles,
                  progress: _particleCtrl!.value,
                ),
              ),
              // Contenido
              SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FadeTransition(
                          opacity: _sunFade,
                          child: CustomPaint(
                            size: const Size(88, 88),
                            painter: _SunPainter(
                              rotation: _sunRotation.value,
                              pulse: _sunPulse.value,
                              glow: _glow.value,
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),
                        _buildDivider(thick: true),
                        const SizedBox(height: 22),
                        FadeTransition(
                          opacity: _textFade,
                          child: Transform.translate(
                            offset: Offset(0, _textSlide.value),
                            child: const Text(
                              'Atahualpa',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFAEEDA),
                                height: 1.5,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
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
      animation: _entryCtrl!,
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

// ── Sun Painter (CALIDAD ORIGINAL) ───────────────────────────────────────────
class _SunPainter extends CustomPainter {
  final double rotation, pulse, glow;
  const _SunPainter(
      {required this.rotation, required this.pulse, required this.glow});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    canvas.save();
    canvas.translate(cx, cy);
    canvas.rotate(rotation);

    canvas.drawCircle(
        Offset.zero,
        30 * pulse,
        Paint()
          ..color = const Color(0xFFEF9F27).withOpacity(0.30)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, glow * 0.8));

    const rayCount = 12;
    for (int i = 0; i < rayCount; i++) {
      final angle = (i / rayCount) * math.pi * 2;
      final isLong = i % 2 == 0;
      final innerR = 15.0 * pulse;
      final outerR = (isLong ? 34.0 : 24.0) * pulse;
      canvas.drawLine(
        Offset(math.cos(angle) * innerR, math.sin(angle) * innerR),
        Offset(math.cos(angle) * outerR, math.sin(angle) * outerR),
        Paint()
          ..color = isLong
              ? const Color(0xFFEF9F27).withOpacity(0.85)
              : const Color(0xFFBA7517).withOpacity(0.65)
          ..strokeWidth = isLong ? 2.5 : 1.5
          ..strokeCap = StrokeCap.round,
      );
    }

    final coreGrad = RadialGradient(
      colors: [
        const Color(0xFFFFE6A7),
        const Color(0xFFEF9F27),
        const Color(0xFFBA7517)
      ],
      stops: const [0.0, 0.55, 1.0],
    ).createShader(Rect.fromCircle(center: Offset.zero, radius: 14 * pulse));

    canvas.drawCircle(Offset.zero, 14 * pulse, Paint()..shader = coreGrad);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_SunPainter old) => true;
}

// ── Beams Painter (CALIDAD ORIGINAL) ──────────────────────────────────────────
class _BeamsPainter extends CustomPainter {
  final double opacity;
  const _BeamsPainter({required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    const beams = [
      (frac: 0.28, angle: -0.35, alpha: 1.0),
      (frac: 0.48, angle: -0.24, alpha: 0.65),
      (frac: 0.65, angle: -0.15, alpha: 0.38)
    ];
    for (final b in beams) {
      final cx = size.width * b.frac;
      final paint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFFFAEEDA).withOpacity(opacity * b.alpha),
            Colors.transparent
          ],
        ).createShader(Rect.fromLTWH(cx - 1.5, 0, 3, size.height));
      canvas.save();
      canvas.translate(cx, size.height * 0.5);
      canvas.rotate(b.angle);
      canvas.drawRect(
          Rect.fromLTWH(-1.5, -size.height, 3, size.height * 2), paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_BeamsPainter old) => true;
}

// ── Particle Painter (CALIDAD ORIGINAL) ──────────────────────────────────────
class _Particle {
  final double x, size, speed, offset;
  final Color color;
  const _Particle(
      {required this.x,
      required this.size,
      required this.speed,
      required this.color,
      required this.offset});
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  const _ParticlePainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final t = (progress * p.speed + p.offset) % 1.0;
      final y = size.height * (1.0 - t * 0.88);
      final dx = math.sin(t * math.pi * 3 + p.offset * 5) * 18;
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
            ..maskFilter = MaskFilter.blur(BlurStyle.normal, p.size * 0.55));
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => true;
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
When Atahualpa finally ascended to the throne, the vast Inca Empire was already wounded. Years of bloody civil war had torn its people apart, and a silent killer—smallpox—had swept through the land, killing millions, including his father, Emperor Huayna Cápac. The disease moved faster than the Spanish themselves, devastating the population long before a single armored boot touched the Andes.

Huayna Cápac’s death left a dangerous vacuum. His chosen heir, Ninan Cuyuchi, had also fallen to disease, and with no clear successor, the empire fractured. Two sons, Atahualpa and Huáscar, plunged the Inca world into a six-year civil war. Atahualpa ruled from the northern city of Quito, while Huáscar held power in the capital, Cuzco. The nobles chose sides, alliances crumbled, and the once-unified empire bled. But in the end, it was Atahualpa who emerged victorious.

With Huáscar captured and his supporters executed—including the historians and the guardians of the ancient quipu records—Atahualpa began a violent purge. It was a symbolic act of renewal, a pachakuti: a radical shift in time and space, a rebirth of the empire. But unknown to him, a far greater pachakuti was coming—one that would turn his world upside down.


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
        'What does the word "victorious" most likely mean in the sentence below?\n\n*"But in the end, it was Atahualpa who emerged victorious."*',
    options: ["A) Emocionado", "B) Derrotado", "C) Victorioso", "D) Triste"],
    correctIndex: 2,
    explanation:
        '✔️ Explanation: "Victorious" and "Victorioso" are cognates—they have the same meaning and are similar in both English and Spanish.',
    incorrectExplanations: [
      ' "Emocionado" means excited, which does not match the context of someone winning.',
      ' "Derrotado" means defeated, which is the opposite of victorious.',
      ' Correct answer!',
      ' "Triste" means sad, which does not fit someone who emerged victorious.',
    ],
  ),
  QuestionData(
    question:
        'What does the word "desperately" most likely mean in the sentence below?\n\n*"The nobles chose sides, alliances crumbled, and the once-unified empire bled."*',
    options: [
      "A) With great effort",
      "B) With urgency",
      "C) Slowly",
      "D) Quietly"
    ],
    correctIndex: 1,
    explanation:
        '✔️ Explanation: The suffix "-ly" shows that "desperately" means with urgency or in a way that requires quick action.',
    incorrectExplanations: [
      ' "With great effort" implies effort but not necessarily urgency.',
      ' Correct answer!',
      ' "Slowly" is the opposite of urgency.',
      ' "Quietly" does not match the chaotic and urgent tone of the sentence.',
    ],
  ),
  QuestionData(
    question:
        'What does the word "pachakuti" most likely mean in the sentence below?\n\n*"It was a symbolic act of renewal, a pachakuti: a radical shift in time and space, a rebirth of the empire."*',
    options: [
      "A) An emperor's decree",
      "B) A change or revolution",
      "C) A traditional dance",
      "D) A religious ceremony"
    ],
    correctIndex: 1,
    explanation:
        '✔️ Explanation: Based on the context clue, "pachakuti" refers to a radical shift or change, suggesting a time of transformation or revolution.',
    incorrectExplanations: [
      ' "An emperor\'s decree" does not match the idea of symbolic renewal and transformation.',
      ' Correct answer!',
      ' "A traditional dance" is not supported by the context of change or rebirth.',
      ' "A religious ceremony" does not capture the idea of a radical societal shift.',
    ],
  ),
];

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
As the new Sapa Inca, or “Unique Inca,” Atahualpa ruled with divine authority. He drank from golden goblets, walked in sandals with silver soles, and wore brilliant feathers and jewels that marked him as a living son of the Sun god, Inti. He rode on a litter adorned with gold, silver, and parrot feathers, and his touch was so sacred that anything he used had to be burned afterward in ritual to ward off evil.

It was in the midst of this triumph and luxury that the Spaniards arrived.

On November 15, 1532, a small force of 168 men led by Francisco Pizarro approached the highland city of Cajamarca. Atahualpa, resting in the nearby hot springs, agreed to meet them. Confident—perhaps too confident—he kept them waiting. Surrounded by an army of 80,000 warriors, he saw no threat in the strangers. When they finally met, the Inca king, seated on a wooden throne and surrounded by wives and nobles, gazed curiously at the pale, bearded men who had dared to climb into his world.
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
        'What does the word "divine" most likely mean in the sentence below?\n\n*"Atahualpa ruled with divine authority."*',
    options: ["A) Humble", "B) Sacred", "C) Mortal", "D) Evil"],
    correctIndex: 1,
    explanation:
        '✔️ Explanation: "Divine" and "divino" are cognates—they are similar and mean the same in both languages, referring to something sacred or from the gods.',
    incorrectExplanations: [
      ' "Humble" does not relate to being from the gods or sacred.',
      ' Correct answer!',
      ' "Mortal" is the opposite of divine, which implies something godlike or eternal.',
      ' "Evil" is the opposite meaning of divine, which is associated with goodness and sacredness.',
    ],
  ),
  QuestionData(
    question:
        'What does the word "gazed" most likely mean in the sentence below?\n\n*"...surrounded by wives and nobles, gazed curiously at the pale, bearded men who had dared to climb into his world."*',
    options: [
      "A) Looked quickly",
      "B) Looked intensely",
      "C) Turned away",
      "D) Glanced nervously"
    ],
    correctIndex: 1,
    explanation:
        '✔️ Explanation: The context suggests that Atahualpa gazed at the strangers, which implies he looked at them intensely or with great focus and curiosity.',
    incorrectExplanations: [
      ' "Looked quickly" does not match the word "gazed", which implies a lingering or focused look.',
      ' Correct answer!',
      ' "Turned away" is the opposite of gazing.',
      ' "Glanced nervously" suggests a quick, anxious look—not the focused observation implied.',
    ],
  ),
  QuestionData(
    question:
        'What does the word "litter" most likely mean in the sentence below?\n\n*"He rode on a litter adorned with gold, silver, and parrot feathers."*',
    options: [
      "A) A bed for sleeping",
      "B) A type of clothing",
      "C) A type of vehicle or seat",
      "D) A group of animals and plants"
    ],
    correctIndex: 2,
    explanation:
        '✔️ Explanation: The context suggests that "litter" refers to a vehicle or seat used for carrying someone, as it\'s described as being "adorned with gold, silver, and parrot feathers."',
    incorrectExplanations: [
      ' "A bed for sleeping" doesn\'t fit the description of being carried or adorned for transport.',
      ' "A type of clothing" is unrelated to the context of being ridden.',
      ' Correct answer!',
      ' "A group of animals and plants" refers to a different meaning of "litter" not relevant here.',
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
The first meeting was uneventful. Formal greetings, shared drinks, a demonstration of Spanish horsemanship—then each side withdrew, already plotting the other’s downfall. The next day, Pizarro laid a trap. Using the city’s narrow, maze-like streets, he placed his men in ambush around the main square.

When Atahualpa entered the plaza with his entourage, the Spaniards attacked. Gunfire thundered, horses charged, and steel cut through cloth and flesh. Thousands of Inca warriors fell—over 7,000—while the Spaniards didn’t lose a single man. Amid the chaos, Atahualpa was struck on the head and taken alive.

Whether it was Pizarro who demanded a ransom or Atahualpa who offered it, what followed was one of the most extraordinary ransoms in history. The Spaniards promised the emperor’s freedom in exchange for a room filled with treasure. The room, measuring 6.2 by 4.8 meters and up to 2.5 meters high, was soon overflowing with golden idols, jewelry, and ornaments. Twice more it was filled with silver. It took eight months to collect it all, and its value today would surpass 50 million.
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
        'What does the word "trap" most likely mean in the sentence below?\n\n"The next day, Pizarro laid a trap."',
    options: ["A) Trampa", "B) Trapo", "C) Tropa", "D) Tragar"],
    correctIndex: 0,
    explanation:
        '✔️ Explanation: "Trap" and "trampa" in Spanish are cognates, meaning they both refer to a device or strategy used to catch someone or something.',
    incorrectExplanations: [
      ' Correct answer!',
      ' "Trapo" means rag or cloth, which doesn\'t relate to the meaning of "trap."',
      ' "Tropa" means troop, unrelated to the meaning in this context.',
      ' "Tragar" means to swallow, which is not relevant to a trap.',
    ],
  ),
  QuestionData(
    question:
        'What does the word "uneventful" most likely mean in the sentence below?\n\n"The first meeting was uneventful."',
    options: [
      "A) Very exciting and thrilling",
      "B) Without any notable events",
      "C) Dangerous and risky",
      "D) Uncertain"
    ],
    correctIndex: 1,
    explanation:
        '✔️ Explanation: The prefix "un-" means "not" or "opposite of." So, uneventful means not eventful or without any notable events.',
    incorrectExplanations: [
      ' "Very exciting and thrilling" is the opposite of "uneventful."',
      ' Correct answer!',
      ' "Dangerous and risky" implies something intense, not uneventful.',
      ' "Uncertain" refers to lack of clarity, not lack of events.',
    ],
  ),
  QuestionData(
    question:
        'What does the word "exchange" most likely mean in the sentence below?\n\n"The Spaniards promised the emperor\'s freedom in exchange for a room filled with treasure."',
    options: [
      "A) Giving something without receiving anything",
      "B) Trade or swap",
      "C) A gift and treasures",
      "D) A loan from a rich Inca family"
    ],
    correctIndex: 1,
    explanation:
        '✔️ Explanation: Based on the context, "exchange" refers to a trade or swap, where freedom is traded for treasure.',
    incorrectExplanations: [
      ' "Giving something without receiving anything" is not an exchange.',
      ' Correct answer!',
      ' "A gift and treasures" does not imply a trade or negotiation.',
      ' "A loan from a rich Inca family" is unrelated to the idea of a swap.',
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
During this time, Atahualpa continued to rule his empire from captivity, unaware that his fate was already sealed.

On July 26, 1533, after receiving the full ransom, Pizarro executed the Inca emperor anyway. Atahualpa had been sentenced to die by fire, but when he agreed to be baptized—a symbolic gesture to satisfy Christian ritual—his sentence was changed to death by strangulation.

Even some of Pizarro’s own men were shocked. Miguel de Estete later wrote how Atahualpa, even in chains, received visitors with the same reverence he had as a free man. They bowed, kissed his hands and feet, and never met his gaze directly. Pizarro understood what few others did: the Inca people would never truly submit while their god-king lived.

And so the Sapa Inca died, but his legend did not. The story of Inkarri—that his head would grow a new body and return one day to defeat the invaders—was born, and it spread through the Andes like wildfire.

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
        'What does the word "sentenced" most likely mean in the sentence below?\n\n"Atahualpa had been sentenced to die by fire."',
    options: ["A) Sentenciado", "B) Documentado", "C) Pensado", "D) Oración"],
    correctIndex: 0,
    explanation:
        '✔️ Explanation: "Sentenced" and "sentenciado" are cognates, meaning both words refer to a judgment or decision made by a court, often related to punishment.',
    incorrectExplanations: [
      '✅ Correct answer!',
      ' "Documentado" means documented, not related to legal punishment.',
      ' "Pensado" means thought, which doesn\'t relate to a legal decision.',
      ' "Oración" means sentence as in grammar, not a legal judgment.',
    ],
  ),
  QuestionData(
    question:
        'What does the word "truly" most likely mean in the sentence below?\n\n"Pizarro understood what few others did: the Inca people would never truly submit while their god-king lived."',
    options: [
      "A) In a fake way",
      "B) In an uncertain way",
      "C) In a loud way",
      "D) In a genuine way"
    ],
    correctIndex: 3,
    explanation:
        '✔️ Explanation: The suffix "-ly" is often added to adjectives to form adverbs that describe the manner in which something is done. In this case, "truly" means in a genuine or sincere way.',
    incorrectExplanations: [
      ' "In a fake way" is the opposite of truly.',
      ' "In an uncertain way" suggests doubt, which is not implied.',
      ' "In a loud way" is unrelated to sincerity or authenticity.',
      '✅ Correct answer!',
    ],
  ),
  QuestionData(
    question:
        'What does the word "reverence" most likely mean in the sentence below?\n\n"Atahualpa, even in chains, received visitors with the same reverence he had as a free man."',
    options: ["A) Disrespect", "B) Admiration", "C) Anger", "D) Fear"],
    correctIndex: 1,
    explanation:
        '✔️ Explanation: Based on the context, "reverence" refers to admiration and deep respect, as visitors treated Atahualpa with the same respect even when he was imprisoned.',
    incorrectExplanations: [
      ' "Disrespect" is the opposite of reverence.',
      '✅ Correct answer!',
      ' "Anger" does not match the tone of admiration or respect.',
      ' "Fear" is a different emotion, not shown in the sentence.',
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