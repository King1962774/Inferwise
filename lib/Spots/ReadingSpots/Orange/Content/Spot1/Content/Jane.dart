import 'package:flutter/material.dart';
import 'package:inferwise/Spots/ReadingSpots/Orange/Content/Spot1/Spot_Page/reading_spot_page.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: unused_import
import 'dart:math' as math;

class JaneSplashScreen extends StatefulWidget {
  const JaneSplashScreen({super.key});

  @override
  State<JaneSplashScreen> createState() => _JaneSplashScreenState();
}

class _JaneSplashScreenState extends State<JaneSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _quillController;
  late Animation<double> _fadeIn;
  late Animation<double> _scaleUp;

  // Pluma: posición X, Y y rotación
  late Animation<double> _quillX;
  late Animation<double> _quillY;
  late Animation<double> _quillRot;

  // Tinta: ancho y opacidad
  late Animation<double> _inkWidth;
  late Animation<double> _inkOpacity;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _fadeIn  = CurvedAnimation(parent: _mainController, curve: Curves.easeIn);
    _scaleUp = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.elasticOut),
    );
    _mainController.forward();

    // Pluma escribiendo (1.8 s loop)
    _quillController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..repeat();

    _quillX = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end:  4.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 4.0, end:  8.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 8.0, end:  5.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 5.0, end:  0.0), weight: 25),
    ]).animate(CurvedAnimation(parent: _quillController, curve: Curves.easeInOut));

    _quillY = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0,  end: -3.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: -3.0, end:  1.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.0,  end: -1.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: -1.0, end:  0.0), weight: 25),
    ]).animate(CurvedAnimation(parent: _quillController, curve: Curves.easeInOut));

    _quillRot = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: -0.52, end: -0.49), weight: 25),
      TweenSequenceItem(tween: Tween(begin: -0.49, end: -0.56), weight: 25),
      TweenSequenceItem(tween: Tween(begin: -0.56, end: -0.50), weight: 25),
      TweenSequenceItem(tween: Tween(begin: -0.50, end: -0.52), weight: 25),
    ]).animate(CurvedAnimation(parent: _quillController, curve: Curves.easeInOut));

    _inkWidth = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0,  end: 38.0), weight: 80),
      TweenSequenceItem(tween: Tween(begin: 38.0, end: 0.0),  weight: 20),
    ]).animate(CurvedAnimation(parent: _quillController, curve: Curves.easeInOut));

    _inkOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.60), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.60, end: 0.50), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.50, end: 0.0),  weight: 20),
    ]).animate(CurvedAnimation(parent: _quillController, curve: Curves.easeInOut));

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BiographyJane()),
      );
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _quillController.dispose();
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

                  // ── Libro + pluma animada ──────────────────────────
                  SizedBox(
                    width: 120,
                    height: 110,
                    child: AnimatedBuilder(
                      animation: _quillController,
                      builder: (_, __) => CustomPaint(
                        painter: _BookQuillPainter(
                          quillX:     _quillX.value,
                          quillY:     _quillY.value,
                          quillRot:   _quillRot.value,
                          inkWidth:   _inkWidth.value,
                          inkOpacity: _inkOpacity.value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Divider(
                    color: const Color(0xFF8B5000).withOpacity(0.55),
                    thickness: 1,
                    indent: 40,
                    endIndent: 40,
                  ),
                  const SizedBox(height: 10),

                  Text(
                    "Memoir of Jane Austen: Fragment",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E1200),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    "By James Edward Austen-Leigh, 1871",
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

// ─── Libro abierto + pluma animada — CustomPainter ───────────────────
// ViewBox: 120 × 110
class _BookQuillPainter extends CustomPainter {
  final double quillX, quillY, quillRot;
  final double inkWidth, inkOpacity;

  _BookQuillPainter({
    required this.quillX, required this.quillY, required this.quillRot,
    required this.inkWidth, required this.inkOpacity,
  });

  Offset p(Size s, double x, double y) =>
      Offset(x / 120 * s.width, y / 110 * s.height);
  double sc(Size s, double v) => v / 120 * s.width;

  @override
  void paint(Canvas canvas, Size size) {
    const brown = Color(0xFF8B5000);
    const dark  = Color(0xFF5C3000);

    final stroke = Paint()
      ..color = brown
      ..style = PaintingStyle.stroke
      ..strokeWidth = sc(size, 1.5)
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fill = Paint()..style = PaintingStyle.fill;

    // ── PÁGINA IZQUIERDA ──────────────────────────────────────────
    final leftPage = Path()
      ..moveTo(p(size, 8,  10).dx,  p(size, 8,  10).dy)
      ..cubicTo(p(size, 8,  6).dx,  p(size, 8,  6).dy,
                p(size, 14, 4).dx,  p(size, 14, 4).dy,
                p(size, 20, 5).dx,  p(size, 20, 5).dy)
      ..cubicTo(p(size, 34, 7).dx,  p(size, 34, 7).dy,
                p(size, 50, 8).dx,  p(size, 50, 8).dy,
                p(size, 58, 10).dx, p(size, 58, 10).dy)
      ..lineTo(p(size, 58, 82).dx,  p(size, 58, 82).dy)
      ..cubicTo(p(size, 50, 80).dx, p(size, 50, 80).dy,
                p(size, 34, 79).dx, p(size, 34, 79).dy,
                p(size, 20, 81).dx, p(size, 20, 81).dy)
      ..cubicTo(p(size, 14, 82).dx, p(size, 14, 82).dy,
                p(size, 8,  80).dx, p(size, 8,  80).dy,
                p(size, 8,  76).dx, p(size, 8,  76).dy)
      ..close();
    canvas.drawPath(leftPage, fill..color = brown.withOpacity(0.20));
    canvas.drawPath(leftPage, stroke);

    // ── PÁGINA DERECHA ────────────────────────────────────────────
    final rightPage = Path()
      ..moveTo(p(size, 62,  10).dx, p(size, 62,  10).dy)
      ..cubicTo(p(size, 70,  8).dx, p(size, 70,  8).dy,
                p(size, 88,  7).dx, p(size, 88,  7).dy,
                p(size, 100, 5).dx, p(size, 100, 5).dy)
      ..cubicTo(p(size, 106, 4).dx, p(size, 106, 4).dy,
                p(size, 112, 6).dx, p(size, 112, 6).dy,
                p(size, 112, 10).dx,p(size, 112, 10).dy)
      ..lineTo(p(size, 112, 76).dx, p(size, 112, 76).dy)
      ..cubicTo(p(size, 112, 80).dx,p(size, 112, 80).dy,
                p(size, 106, 82).dx,p(size, 106, 82).dy,
                p(size, 100, 81).dx,p(size, 100, 81).dy)
      ..cubicTo(p(size, 88,  79).dx,p(size, 88,  79).dy,
                p(size, 70,  80).dx,p(size, 70,  80).dy,
                p(size, 62,  82).dx,p(size, 62,  82).dy)
      ..close();
    canvas.drawPath(rightPage, fill..color = brown.withOpacity(0.20));
    canvas.drawPath(rightPage, stroke);

    // ── LOMO ──────────────────────────────────────────────────────
    final spine = Path()
      ..moveTo(p(size, 58, 10).dx, p(size, 58, 10).dy)
      ..cubicTo(p(size, 59, 8).dx, p(size, 59, 8).dy,
                p(size, 61, 8).dx, p(size, 61, 8).dy,
                p(size, 62, 10).dx,p(size, 62, 10).dy)
      ..lineTo(p(size, 62, 82).dx, p(size, 62, 82).dy)
      ..cubicTo(p(size, 61, 84).dx,p(size, 61, 84).dy,
                p(size, 59, 84).dx,p(size, 59, 84).dy,
                p(size, 58, 82).dx,p(size, 58, 82).dy)
      ..close();
    canvas.drawPath(spine, fill..color = dark.withOpacity(0.40));
    canvas.drawPath(spine, stroke..strokeWidth = sc(size, 1.0));

    // ── LÍNEAS DE TEXTO ───────────────────────────────────────────
    final linePaint = Paint()
      ..color = brown.withOpacity(0.32)
      ..strokeWidth = sc(size, 1.0)
      ..strokeCap = StrokeCap.round;

    for (final y in [26.0, 35.0, 44.0, 53.0]) {
      canvas.drawLine(p(size, 14, y), p(size, 52, y - 0.8), linePaint);
    }
    for (final y in [26.0, 35.0, 44.0]) {
      canvas.drawLine(p(size, 68, y), p(size, 106, y + 0.8), linePaint);
    }

    // ── LÍNEA DE TINTA ANIMADA ────────────────────────────────────
    if (inkWidth > 0 && inkOpacity > 0) {
      final inkRect = Rect.fromLTWH(
        p(size, 68, 55).dx, p(size, 68, 55).dy - sc(size, 1),
        sc(size, inkWidth * 0.88), sc(size, 2),
      );
      canvas.drawRect(
        inkRect,
        Paint()
          ..shader = LinearGradient(
            colors: [
              brown.withOpacity(0.0),
              brown.withOpacity(inkOpacity),
            ],
          ).createShader(inkRect),
      );
    }

    // ── PLUMA (rotada y desplazada) ───────────────────────────────
    final quillBase = p(size, 88 + quillX, 30 + quillY);
    canvas.save();
    canvas.translate(quillBase.dx, quillBase.dy);
    canvas.rotate(quillRot);

    // Código de la pluma anterior (comentado)
    /*
    // Cañón de la pluma
    final quillPath = Path()
      ..moveTo(0, sc(size, 28))        // punta
      ..cubicTo(-sc(size, 4), sc(size, 18), -sc(size, 6), sc(size, 8),
                -sc(size, 4), -sc(size, 10))
      ..cubicTo( sc(size, 2), -sc(size, 16), sc(size, 8), -sc(size, 20),
                 sc(size, 10), -sc(size, 26))
      ..cubicTo( sc(size, 8), -sc(size, 14), sc(size, 6), -sc(size, 2),
                 sc(size, 4),  sc(size, 8))
      ..cubicTo( sc(size, 4), sc(size, 18), sc(size, 2), sc(size, 24), 0, sc(size, 28))
      ..close();
    canvas.drawPath(quillPath, fill..color = brown.withOpacity(0.78));
    canvas.drawPath(quillPath, Paint()
      ..color = dark
      ..style = PaintingStyle.stroke
      ..strokeWidth = sc(size, 0.8));

    // Barbas derecha
    for (final by in [-18.0, -10.0, -2.0]) {
      canvas.drawLine(
        Offset(sc(size, 4), sc(size, by)),
        Offset(sc(size, 14), sc(size, by - 8)),
        Paint()..color = brown.withOpacity(0.55)..strokeWidth = sc(size, 0.9)..strokeCap = StrokeCap.round,
      );
    }
    // Barbas izquierda
    for (final by in [-18.0, -10.0, -2.0]) {
      canvas.drawLine(
        Offset(-sc(size, 4), sc(size, by)),
        Offset(-sc(size, 14), sc(size, by - 8)),
        Paint()..color = brown.withOpacity(0.55)..strokeWidth = sc(size, 0.9)..strokeCap = StrokeCap.round,
      );
    }
    */
    // Nuevo diseño de la pluma
    // Cuerpo de la pluma (cañón)
    final newQuillPath = Path()
      ..moveTo(0, sc(size, 28)) // Punta
      ..cubicTo(-sc(size, 3), sc(size, 18), -sc(size, 5), sc(size, 8),
                -sc(size, 3), -sc(size, 10))
      ..cubicTo(sc(size, 1), -sc(size, 16), sc(size, 6), -sc(size, 20),
                sc(size, 8), -sc(size, 26)) // Parte superior de la pluma
      ..cubicTo(sc(size, 6), -sc(size, 14), sc(size, 4), -sc(size, 2),
                sc(size, 3), sc(size, 8))
      ..cubicTo(sc(size, 3), sc(size, 18), sc(size, 1), sc(size, 24), 0, sc(size, 28))
      ..close();
    canvas.drawPath(newQuillPath, fill..color = brown.withOpacity(0.78));
    canvas.drawPath(newQuillPath, Paint()
      ..color = dark
      ..style = PaintingStyle.stroke
      ..strokeWidth = sc(size, 0.8));

    // Barbas de la pluma (más detalladas)
    for (int i = 0; i < 4; i++) {
      final yOffset = sc(size, -18.0 + i * 8.0);
      // Derecha
      canvas.drawLine(
        Offset(sc(size, 3), yOffset),
        Offset(sc(size, 12), yOffset - sc(size, 6)),
        Paint()..color = brown.withOpacity(0.55)..strokeWidth = sc(size, 0.9)..strokeCap = StrokeCap.round,
      );
      // Izquierda
      canvas.drawLine(
        Offset(-sc(size, 3), yOffset),
        Offset(-sc(size, 12), yOffset - sc(size, 6)),
        Paint()..color = brown.withOpacity(0.55)..strokeWidth = sc(size, 0.9)..strokeCap = StrokeCap.round,
      );
    }

    // Punta de la pluma (más definida)
    final newTipPath = Path()
      ..moveTo(0, sc(size, 28))
      ..lineTo(-sc(size, 2), sc(size, 24))
      ..lineTo(sc(size, 2), sc(size, 24))
      ..close();
    canvas.drawPath(newTipPath, fill..color = dark.withOpacity(0.85));

    // Línea central de la punta
    canvas.drawLine(
      Offset(0, sc(size, 24)),
      Offset(0, sc(size, 20)),
      Paint()..color = brown.withOpacity(0.7)..strokeWidth = sc(size, 0.6)..strokeCap = StrokeCap.round,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _BookQuillPainter old) =>
      old.quillX != quillX || old.quillY != quillY ||
      old.inkWidth != inkWidth || old.inkOpacity != inkOpacity;
}


// ---------------------- Jane QUESTIONS ----------------------
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
          "What is one of the most famous aspects of Jane Austen’s novels?",
      "options": [
        "A) Their focus on historical battles and political intrigue.",
        "B) Their romantic themes and keen observations of social class.",
        "C) Their use of mythological and fantasy elements.",
        "D) Their exploration of scientific discoveries."
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Austen’s novels don’t center on political or military themes.",
        " Correct! Austen’s enduring fame comes from her detailed portrayal of courtship and marriage in the social classes of the English Regency period, explored with wit and social commentary.",
        " Incorrect. Austen didn’t use mythological or fantasy themes.",
        " Incorrect. Her novels focus on society, not science."
      ]
    },
    {
      "question":
          "Which of the following is true about Jane Austen’s life and writing?",
      "options": [
        "A) She was a wealthy aristocrat who wrote for a hobby.",
        "B) She was a well-known public figure during her lifetime.",
        "C) She published her novels anonymously during her lifetime.",
        "D) She traveled extensively and lived in multiple countries."
      ],
      "correct": 2,
      "feedback": [
        " Incorrect. Austen was not wealthy; she belonged to the middle class.",
        " Incorrect. She wasn’t publicly famous while alive.",
        " Correct! Austen published her novels anonymously, with the title page simply stating 'By a Lady,' as it wasn’t common for women to be professional writers at the time.",
        " Incorrect. Austen lived mainly in England and did not travel abroad."
      ]
    },
    {
      "question": "What literary style is Jane Austen most known for?",
      "options": [
        "A) Gothic horror",
        "B) Romantic poetry",
        "C) Comedy of manners",
        "D) Science fiction"
      ],
      "correct": 2,
      "feedback": [
        " Incorrect. Gothic horror was more associated with writers like Mary Shelley.",
        " Incorrect. Austen didn’t write poetry.",
        " Correct! The comedy of manners is a satirical style focusing on the behavior and conventions of a specific social class, which perfectly describes Austen’s novels.",
        " Incorrect. Science fiction came much later and isn’t related to Austen’s work."
      ]
    },
    {
      "question":
          "The novels of Jane Austen are often described as being set in what historical period?",
      "options": [
        "A) The Regency era",
        "B) The Elizabethan era",
        "C) The Victorian era",
        "D) The Edwardian era"
      ],
      "correct": 0,
      "feedback": [
        " Correct! The Regency era in England (1811–1820) was when most of Austen’s novels were published, known for its distinct social customs and fashion.",
        " Incorrect. The Elizabethan era occurred much earlier (1500s).",
        " Incorrect. The Victorian era came after Austen’s time.",
        " Incorrect. The Edwardian era followed the Victorian period."
      ]
    },
    {
      "question":
          "Which of the following lists includes most of Jane Austen’s most famous novels?",
      "options": [
        "A) Wuthering Heights, Jane Eyre, Little Women, Frankenstein",
        "B) Pride and Prejudice, Mansfield Park, Emma, Persuasion",
        "C) Moby-Dick, The Great Gatsby, To Kill a Mockingbird, 1984",
        "D) Mansfield Park, Northanger Abbey, Lady Susan, Sanditon"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Those novels were written by other authors.",
        " Correct! Pride and Prejudice, Sense and Sensibility, Emma, and Persuasion are among Jane Austen’s most popular works.",
        " Incorrect. Those belong to American authors from later centuries.",
        " Incorrect. Some of these are by Austen, but not her most famous ones."
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
  late final AnimationController _pageCtrl;
  late final AnimationController _linesCtrl;
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
  late final Animation<double> _pageFlutter;
  late final Animation<double> _linesOpacity;
  late final Animation<double> _linesOpacity2;

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
      end: const Color(0xFF3A2000),
    ).animate(_bgCtrl);
    _bgColor2 = ColorTween(
      begin: const Color(0xFFFFC107),
      end: const Color(0xFFFFF1B3),
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

    _pageCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);
    _pageFlutter = Tween<double>(begin: 0.0, end: -0.31).animate(
      CurvedAnimation(parent: _pageCtrl, curve: Curves.easeInOut),
    );

    _linesCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _linesOpacity = Tween<double>(begin: 0.3, end: 0.9).animate(
      CurvedAnimation(parent: _linesCtrl, curve: Curves.easeInOut),
    );
    _linesOpacity2 = Tween<double>(begin: 0.9, end: 0.3).animate(
      CurvedAnimation(parent: _linesCtrl, curve: Curves.easeInOut),
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
    _pageCtrl.dispose();
    _linesCtrl.dispose();
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
          _beamsCtrl, _pageCtrl, _linesCtrl, _sparkCtrl,
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
                      const Color(0xFF3A2000),
                      const Color(0xFF9C6F00),
                      _bgColor2.value ?? const Color(0xFFFFC107),
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
                              height: 110,
                              child: CustomPaint(
                                painter: _BookPainter(
                                  glow: _glow.value,
                                  pageFlutter: _pageFlutter.value,
                                  linesOpacity: _linesOpacity.value,
                                  linesOpacity2: _linesOpacity2.value,
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
                              'Time slows when words take hold.\nReading sharpens thought and feeling.\nUnderstanding grows in quiet moments.',
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

// ── Book painter ──────────────────────────────────────────────────────────────
class _BookPainter extends CustomPainter {
  final double glow;
  final double pageFlutter;
  final double linesOpacity;
  final double linesOpacity2;
  final double sparkProgress;

  const _BookPainter({
    required this.glow,
    required this.pageFlutter,
    required this.linesOpacity,
    required this.linesOpacity2,
    required this.sparkProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // ── Halo glow ──
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.5, h * 0.82), width: w * 0.9, height: h * 0.28),
      Paint()
        ..color = const Color(0xFFEF9F27).withOpacity(0.12)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glow * 0.7),
    );

    // ── Tapa izquierda ──
    final leftCover = Path()
      ..moveTo(w * 0.06, h * 0.16)
      ..quadraticBezierTo(w * 0.06, h * 0.13, w * 0.09, h * 0.13)
      ..lineTo(w * 0.477, h * 0.13)
      ..lineTo(w * 0.477, h * 0.90)
      ..lineTo(w * 0.09, h * 0.90)
      ..quadraticBezierTo(w * 0.06, h * 0.90, w * 0.06, h * 0.87)
      ..close();
    canvas.drawPath(
      leftCover,
      Paint()
        ..shader = LinearGradient(
          colors: const [Color(0xFFFAC775), Color(0xFF854F0B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromLTWH(0, 0, w * 0.48, h)),
    );
    canvas.drawPath(
      leftCover,
      Paint()
        ..color = const Color(0xFFBA7517)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // ── Tapa derecha ──
    final rightCover = Path()
      ..moveTo(w * 0.523, h * 0.13)
      ..lineTo(w * 0.91, h * 0.13)
      ..quadraticBezierTo(w * 0.94, h * 0.13, w * 0.94, h * 0.16)
      ..lineTo(w * 0.94, h * 0.87)
      ..quadraticBezierTo(w * 0.94, h * 0.90, w * 0.91, h * 0.90)
      ..lineTo(w * 0.523, h * 0.90)
      ..close();
    canvas.drawPath(
      rightCover,
      Paint()
        ..shader = LinearGradient(
          colors: const [Color(0xFFFAC775), Color(0xFFBA7517)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ).createShader(Rect.fromLTWH(w * 0.52, 0, w * 0.48, h)),
    );
    canvas.drawPath(
      rightCover,
      Paint()
        ..color = const Color(0xFFBA7517)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // ── Lomo ──
    final spineRect = Rect.fromLTWH(w * 0.46, h * 0.13, w * 0.08, h * 0.77);
    canvas.drawRRect(
      RRect.fromRectAndRadius(spineRect, const Radius.circular(2)),
      Paint()
        ..shader = LinearGradient(
          colors: const [Color(0xFFEF9F27), Color(0xFF412402)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(spineRect),
    );

    // ── Páginas izquierda ──
    canvas.drawRect(
      Rect.fromLTWH(w * 0.09, h * 0.13, w * 0.38, h * 0.77),
      Paint()
        ..shader = LinearGradient(
          colors: [const Color(0xFFFAEEDA), const Color(0xFFFAC775).withOpacity(0.6)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(Rect.fromLTWH(w * 0.09, 0, w * 0.38, h)),
    );

    // ── Páginas derecha ──
    canvas.drawRect(
      Rect.fromLTWH(w * 0.523, h * 0.13, w * 0.387, h * 0.77),
      Paint()
        ..shader = LinearGradient(
          colors: [const Color(0xFFFAC775).withOpacity(0.6), const Color(0xFFFAEEDA)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(Rect.fromLTWH(w * 0.52, 0, w * 0.39, h)),
    );

    // ── Líneas de texto izquierda ──
    final leftLines = [0.22, 0.30, 0.38, 0.46, 0.54, 0.62, 0.70, 0.78];
    final leftWidths = [0.36, 0.36, 0.30, 0.36, 0.28, 0.36, 0.32, 0.36];
    for (int i = 0; i < leftLines.length; i++) {
      canvas.drawLine(
        Offset(w * 0.12, h * leftLines[i]),
        Offset(w * (0.12 + leftWidths[i]), h * leftLines[i]),
        Paint()
          ..color = const Color(0xFFBA7517).withOpacity(linesOpacity * (0.7 - i * 0.03))
          ..strokeWidth = 1.2
          ..strokeCap = StrokeCap.round,
      );
    }

    // ── Líneas de texto derecha ──
    final rightLines = [0.22, 0.30, 0.38, 0.46, 0.54, 0.62, 0.70, 0.78];
    final rightWidths = [0.36, 0.36, 0.30, 0.36, 0.24, 0.36, 0.32, 0.36];
    for (int i = 0; i < rightLines.length; i++) {
      canvas.drawLine(
        Offset(w * 0.555, h * rightLines[i]),
        Offset(w * (0.555 + rightWidths[i]), h * rightLines[i]),
        Paint()
          ..color = const Color(0xFFBA7517).withOpacity(linesOpacity2 * (0.7 - i * 0.03))
          ..strokeWidth = 1.2
          ..strokeCap = StrokeCap.round,
      );
    }

    // ── Página volando ──
    canvas.save();
    canvas.translate(w * 0.477, h * 0.50);
    final matrix = Matrix4.identity()
      ..setEntry(3, 2, 0.002)
      ..rotateY(pageFlutter);
    canvas.transform(matrix.storage);
    final flutterPath = Path()
      ..moveTo(0, -h * 0.31)
      ..quadraticBezierTo(w * 0.10, -h * 0.35, w * 0.14, -h * 0.31)
      ..lineTo(w * 0.14, h * 0.31)
      ..quadraticBezierTo(w * 0.10, h * 0.27, 0, h * 0.31)
      ..close();
    canvas.drawPath(
      flutterPath,
      Paint()..color = const Color(0xFFFAEEDA).withOpacity(0.55),
    );
    canvas.restore();

    // ── Marcapáginas ──
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.755, h * 0.13, w * 0.046, h * 0.22),
        const Radius.circular(1),
      ),
      Paint()..color = const Color(0xFFEF9F27).withOpacity(0.92),
    );
    final bookmark = Path()
      ..moveTo(w * 0.755, h * 0.35)
      ..lineTo(w * 0.778, h * 0.40)
      ..lineTo(w * 0.801, h * 0.35);
    canvas.drawPath(bookmark, Paint()..color = const Color(0xFFBA7517));

    // ── Chispas ──
    final sparks = [
      (w * 0.108, h * 0.09, 0.1),
      (w * 0.908, h * 0.07, 0.6),
      (w * 0.046, h * 0.50, 0.9),
      (w * 0.969, h * 0.47, 0.4),
      (w * 0.23,  h * 0.04, 1.3),
      (w * 0.754, h * 0.04, 0.7),
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
  bool shouldRepaint(_BookPainter old) =>
      old.glow != glow ||
      old.pageFlutter != pageFlutter ||
      old.linesOpacity != linesOpacity ||
      old.linesOpacity2 != linesOpacity2 ||
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
            const Color(0xFFFFF1B3).withOpacity(opacity * b.alpha),
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
More than fifty years have passed since I, the youngest person at the time, went to the funeral of my dear aunt Jane at Winchester Cathedral. Now that I am old, people ask me if I can remember anything about her life or character to share with new readers—people who were born after she died.

There were not many events in her life: it was peaceful, with few big changes. Even her fame came after her death. While she was alive, she was not known by other writers or part of the literary world. She lived a quiet life at home.

Because of this, I don’t have enough information to write a detailed biography. But I do remember what she looked like and what she was like as a person. Many people might be interested in knowing more about the person who created such memorable characters as the Dashwoods, the Bennets, the Bertrams, and the Woodhouses—people who feel like close friends to many readers today. Some may wonder if the kindness, good morals, and warm feelings shown by her characters also existed in Jane herself. I can say that many of the lovely qualities in her characters were true of her. I was young when she died, but memories from childhood can be very strong. Even though many years have passed, I still remember how much we all loved “Aunt Jane.” We didn’t think of her as famous or even especially clever—but we knew she was kind, caring, and fun to be around. I saw this myself, but I don’t know if I can describe it well enough for others to see. Still, I will try, with the help of a few people who also knew her. I believe that, even if I don’t have much to tell, no one else alive now could tell as much
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
        'Why might the narrator feel a responsibility to share memories of Jane Austen?',
    options: [
      "A) Because Jane was famous while alive",
      "B) Because readers today can’t experience her personally",
      "C) Because she lived in a city full of writers",
      "D) Because biographies of her were already abundant"
    ],
    correctIndex: 1,
    explanation:
        'The text says “people who were born after she died... might be interested in knowing more about the person who created such memorable characters,” implying the narrator feels responsible to connect modern readers with someone they never met.',
    incorrectExplanations: [
      " Incorrect. Austen wasn’t famous while alive.",
      " Correct! The narrator wants to connect modern readers with someone they never knew personally.",
      " Incorrect. The narrator’s motive isn’t about other writers.",
      " Incorrect. Biographies of her were not yet abundant at the time."
    ],
  ),
  QuestionData(
    question:
        'How does the narrator plan to overcome the lack of written records about Jane Austen?',
    options: [
      "A) By inventing stories about her",
      "B) By visiting her home",
      "C) By summarizing her novels",
      "D) By relying on accounts from others"
    ],
    correctIndex: 3,
    explanation:
        'The text says “I will try, with the help of a few people who also knew her,” showing that the narrator uses memory and firsthand accounts to overcome the lack of written records.',
    incorrectExplanations: [
      " Incorrect. The narrator does not make up stories.",
      " Incorrect. Visiting her home is not mentioned.",
      " Incorrect. Summarizing her novels is not the narrator’s plan.",
      " Correct! The narrator depends on firsthand recollections from others."
    ],
  ),
  QuestionData(
    question:
        'What can we infer about the environment in which Jane Austen lived?',
    options: [
      "A) She lived removed from fame and recognition",
      "B) She lived amidst a lively literary community",
      "C) She moved frequently across England",
      "D) She spent most of her time traveling"
    ],
    correctIndex: 0,
    explanation:
        'The text says “she lived a quiet life at home... not known by other writers,” implying her surroundings were peaceful and private, far from fame.',
    incorrectExplanations: [
      " Correct! Austen’s life was quiet and private.",
      " Incorrect. The text describes her as isolated from the literary world.",
      " Incorrect. There is no evidence of frequent travel.",
      " Incorrect. She spent most of her time at home, not traveling."
    ],
  ),
  QuestionData(
    question:
        'Who provides most of the information about Jane Austen in this text?',
    options: [
      "A) Jane Austen herself",
      "B) The narrator",
      "C) Modern readers",
      "D) Literary critics"
    ],
    correctIndex: 1,
    explanation:
        'The narrator says “I still remember how much we all loved ‘Aunt Jane,’” showing that their own recollections serve as the main source of information about Austen.',
    incorrectExplanations: [
      " Incorrect. Austen did not write her own biography.",
      " Correct! The narrator’s personal memories provide the main information.",
      " Incorrect. Modern readers are not the source here.",
      " Incorrect. Critics are not mentioned in this text."
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
Jane Austen was born on December 16, 1775, at Steventon Parsonage in Hampshire. Her father, the Reverend George Austen, came from a family in Kent that had been there for many years. A long time ago, in the 1600s, the Austens worked in the cloth trade. A local historian, Hasted, wrote that the cloth business helped many families become wealthy and respected, including the Austens. These cloth workers were called the “Gray Coats of Kent,” and they were so many and so united that they had a lot of power in local elections. Even today, the family still uses “Kentish gray”—a mix of light blue and white—in their clothing to remember that past.

George Austen lost both parents before he was nine. He didn’t inherit any money, but he had a kind uncle, Mr. Francis Austen, who was a successful lawyer. He helped support George, even though he had his own children. George Austen went to Tunbridge School and then to Oxford, where he received a scholarship and later a fellowship. In 1764, he became the rector (a kind of priest) of two nearby churches in Deane and Steventon. These villages were only a mile apart and had less than 300 people in total.

That same year, he married Cassandra Leigh, the daughter of another clergyman. She came from the Leigh family in Warwickshire. Her uncle, Dr. Theophilus Leigh, was a well-known figure at Oxford. He lived to be ninety and was head of Balliol College for over fifty years. He was famous for his jokes and puns. One story tells how someone said the Lord Chancellor had hit the table so hard he broke it. Dr. Leigh joked, “I don’t think he split the table, but I believe he divided the Board.” He was still making puns just a few days before he died.
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
        'What might the description of the “Gray Coats of Kent” suggest about the Austen family’s social position?',
    options: [
      "A) They were part of influential local network",
      "B) They were isolated and unknown",
      "C) They worked mostly in agriculture",
      "D) They disliked participating in local events"
    ],
    correctIndex: 0,
    explanation:
        'The text says “they were so many and so united that they had a lot of power in local elections,” implying the Austen family had social influence and respect in their community.',
    incorrectExplanations: [
      " Correct! The Austen family was socially connected and influential locally.",
      " Incorrect. The family was well-known, not isolated.",
      " Incorrect. The focus is on social power, not agriculture.",
      " Incorrect. They actively participated in local matters."
    ],
  ),
  QuestionData(
    question:
        'How did George Austen’s uncle, Mr. Francis Austen, affect George’s early life?',
    options: [
      "A) He taught George to work in the cloth trade",
      "B) He provided support to George",
      "C) He discouraged George from going to school",
      "D) He arranged George’s marriage"
    ],
    correctIndex: 1,
    explanation:
        'The text says “He had a kind uncle... who was a successful lawyer. He helped support George,” indicating that Mr. Francis Austen provided financial and emotional assistance.',
    incorrectExplanations: [
      " Incorrect. There is no mention of teaching the cloth trade.",
      " Correct! The uncle helped George by offering support.",
      " Incorrect. The uncle encouraged, not discouraged, George’s education.",
      " Incorrect. His role was supportive, not marital arrangement."
    ],
  ),
  QuestionData(
    question:
        'What can be inferred about the size and setting of Steventon and Deane, where George Austen served as rector?',
    options: [
      "A) They were bustling cities",
      "B) They were small, close-knit villages",
      "C) They were distant from each other",
      "D) They were industrial centers"
    ],
    correctIndex: 1,
    explanation:
        'The text says “These villages were only a mile apart and had less than 300 people in total,” indicating that Steventon and Deane were small, rural, and closely connected communities.',
    incorrectExplanations: [
      " Incorrect. They were villages, not cities.",
      " Correct! The villages were small and close-knit.",
      " Incorrect. The text says they were close, not distant.",
      " Incorrect. There’s no mention of industry in the area."
    ],
  ),
  QuestionData(
    question:
        'What does the text suggest about how long the Austen family maintained prominence?',
    options: [
      "A) Their influence was brief and short-lived, just one generation",
      "B) They lost status quickly after moving to Hampshire",
      "C) They only became notable in the 1800s",
      "D) Their prominence lasted generations, from the 1600s onward"
    ],
    correctIndex: 3,
    explanation:
        'The text mentions the Austens worked in the cloth trade in the 1600s and “even today... still uses ‘Kentish gray,’” showing that the family maintained a long-standing prominence across generations.',
    incorrectExplanations: [
      " Incorrect. Their influence lasted much longer than one generation.",
      " Incorrect. They continued to be known after moving to Hampshire.",
      " Incorrect. Their prominence began earlier than the 1800s.",
      " Correct! The family’s status endured for many generations starting in the 1600s."
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
George and Cassandra Austen first lived in Deane, but in 1771 they moved to Steventon, where they stayed for about thirty years. When they got married, they were caring for a small boy, the son of Warren Hastings, a famous British official in India. This child died young from a throat infection, and Mrs. Austen was very sad, saying it felt like losing one of her own children.

Around the same time, the nearby parish of Ashe had a rector named Dr. Russell—the grandfather of writer Mary Russell Mitford—so the families of two well-known women writers must have known each other.

Because I’m writing about events from a hundred years ago, I’ll also mention some of the changes in everyday life since then. Even small things are interesting with time, just like old wine gains flavour. People today might not know how many modern comforts were unknown to their grandparents.

For example, the road between Deane and Steventon is now smooth, but in 1771, it was full of deep ruts. It was so rough that Mrs. Austen, who was not in good health, had to ride on a feather bed in the moving wagon with the furniture. In those days, people would sometimes fix bad roads only for special events like a wedding or a funeral.
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
        'What can be inferred about the social circles of George and Cassandra Austen?',
    options: [
      "A) They lived far from other families and had little contact",
      "B) They only associated with wealthy merchants",
      "C) They were familiar with other families connected to writers",
      "D) They avoided contact with neighboring parishes"
    ],
    correctIndex: 2,
    explanation:
        'The text says “the families of two well-known women writers must have known each other,” suggesting that George and Cassandra Austen were part of a social circle of educated and notable families.',
    incorrectExplanations: [
      " Incorrect. The Austens were socially connected, not isolated.",
      " Incorrect. Their connections extended beyond merchants to literary families.",
      " Correct! They interacted with other educated families connected to writers.",
      " Incorrect. They did not avoid neighboring communities."
    ],
  ),
  QuestionData(
    question:
        'Who was responsible for the temporary improvement of roads during special events?',
    options: [
      "A) Mrs. Austen herself",
      "B) Local communities",
      "C) The British government",
      "D) The clergy only"
    ],
    correctIndex: 1,
    explanation:
        'The text notes “people would sometimes fix bad roads only for special events,” implying that these improvements were done by local communities rather than officials.',
    incorrectExplanations: [
      " Incorrect. There’s no mention of Mrs. Austen repairing roads.",
      " Correct! The temporary repairs were done by local residents for special occasions.",
      " Incorrect. The British government is not mentioned as responsible.",
      " Incorrect. The clergy were not involved in this maintenance."
    ],
  ),
  QuestionData(
    question: 'What does the text suggest about changes over time?',
    options: [
      "A) Even small aspects have improved over a hundred years",
      "B) Life remained exactly the same for generations",
      "C) Only the wealthiest experienced changes",
      "D) Roads worsened over time"
    ],
    correctIndex: 0,
    explanation:
        'The text contrasts “the road between Deane and Steventon is now smooth, but in 1771, it was full of deep ruts,” showing that everyday aspects like roads improved significantly over time.',
    incorrectExplanations: [
      " Correct! The condition of roads improved as time passed.",
      " Incorrect. The text explicitly describes improvement, not stagnation.",
      " Incorrect. The changes affected general life, not only the wealthy.",
      " Incorrect. Roads got better, not worse."
    ],
  ),
  QuestionData(
    question:
        'What can be inferred about the distance and travel between Deane and Steventon?',
    options: [
      "A) They were very far apart, requiring weeks of travel",
      "B) They were close but challenging to traverse",
      "C) They were next door with paved streets",
      "D) Travel was impossible between the villages"
    ],
    correctIndex: 1,
    explanation:
        'The text mentions “the road... was full of deep ruts... Mrs. Austen had to ride on a feather bed,” implying that while the distance was short, travel was physically difficult due to poor road conditions.',
    incorrectExplanations: [
      " Incorrect. The villages were close, not distant.",
      " Correct! The journey was short but rough and uncomfortable.",
      " Incorrect. Roads were not paved at that time.",
      " Incorrect. Travel was difficult but not impossible."
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
At that time, many people, even those with land and money, were still quite ignorant and spoke in a coarse way. One landowner once asked Mr. Austen, “Is Paris in France, or France in Paris?” because he and his wife were arguing about it. This same man once told a story where he claimed Mrs. Austen had sworn angrily at her husband. When his daughter reminded him that Mrs. Austen never swore, he said, “That’s just how I tell the story!”

Some people today say that the clergy (priests) of the past were worse than the laypeople (non-religious people), but that may not be fair. Clergy often lived and worked with smaller landowners and farmers. A rector who was educated and polite was often the most refined person in the village. Over time, society has improved mostly in the lower classes—what we might call “levelling up.” Even Shakespeare joked about this in Hamlet when he said the peasant’s toe almost touches the courtier’s heel. A hundred years ago, country parishes improved mostly because of the clergy.

Mr. Austen was a very handsome man, both when he was young and when he was old. During his time at Oxford University, he was called the “handsome Proctor.” Even when he was over seventy years old and living in Bath, people noticed his good looks and his thick, white hair. He was a good student and helped two of his sons prepare for university. He also taught his other children at home and earned extra money by taking in students.

Mrs. Austen also had some of the intelligence and creativity that Jane inherited. She was practical and imaginative, and often spoke and wrote with a sharp and clever style. She lived to be eighty-eight. During her last years, she was often in pain, but she stayed cheerful. She once said, “Ah, my dear, you find me just where you left me—on the sofa. Sometimes I think God has forgotten me; but I’m sure He’ll come for me when the time is right.” She died in January 1827 and was buried at Chawton.
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
        'What does the text suggest about the relationship between clergy and villagers in the past?',
    options: [
      "A) Clergy often had closer contact with lower-class people",
      "B) Clergy were usually poorer than regular villagers",
      "C) Clergy avoided ordinary people entirely",
      "D) Wealthy villagers were more educated than the clergy"
    ],
    correctIndex: 0,
    explanation:
        'The text says “a rector who was educated and polite was often the most refined person in the village” and that “country parishes improved mostly because of the clergy,” indicating that clergy had significant interaction with villagers and helped raise their social level.',
    incorrectExplanations: [
      " Correct! Clergy were socially close to villagers and often guided them.",
      " Incorrect. The clergy were not necessarily poorer than the villagers.",
      " Incorrect. The clergy interacted actively with ordinary people.",
      " Incorrect. It was the clergy who were more educated, not the villagers."
    ],
  ),
  QuestionData(
    question:
        'How did Mr. Austen contribute to his family’s education and income?',
    options: [
      "A) By hiring tutors from outside",
      "B) By teaching his children and taking in students",
      "C) By sending his children to Oxford exclusively",
      "D) By working in a shop"
    ],
    correctIndex: 1,
    explanation:
        'The text says “he helped two of his sons prepare for university... taught his children at home and earned extra money by taking in students,” showing his dual role as educator and provider.',
    incorrectExplanations: [
      " Incorrect. He did not rely on outside tutors.",
      " Correct! He educated his children himself and took in paying students.",
      " Incorrect. While his sons went to Oxford, he taught them beforehand.",
      " Incorrect. He was a clergyman and teacher, not a shopkeeper."
    ],
  ),
  QuestionData(
    question: 'Who most influenced Jane Austen’s intelligence and creativity?',
    options: [
      "A) Only her father",
      "B) Only her mother",
      "C) Both her parents",
      "D) Her peers at school"
    ],
    correctIndex: 2,
    explanation:
        'The text notes “Mrs. Austen also had some of the intelligence and creativity that Jane inherited… practical and imaginative,” suggesting both parents shaped Jane’s development.',
    incorrectExplanations: [
      " Incorrect. Her father was influential but not the only one.",
      " Incorrect. Her mother influenced her but not alone.",
      " Correct! Both parents contributed to her intelligence and imagination.",
      " Incorrect. There’s no mention of school peers influencing her creativity."
    ],
  ),
  QuestionData(
    question:
        'What does the text imply about where Mrs. Austen spent her final days?',
    options: [
      "A) At home, mostly in one familiar place",
      "B) Traveling constantly between villages",
      "C) In a hospital in a large city",
      "D) Visiting friends across Hampshire"
    ],
    correctIndex: 0,
    explanation:
        'The text notes “you find me just where you left me—on the sofa,” implying she remained mostly in her home in Chawton until she died.',
    incorrectExplanations: [
      " Correct! She stayed at home in Chawton during her final years.",
      " Incorrect. There’s no indication of constant travel.",
      " Incorrect. The text does not mention a hospital or large city.",
      " Incorrect. She was not traveling to visit friends frequently."
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

