import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inferwise/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

class FinalTest extends StatefulWidget {
  final List<QuestionData> questions;

  const FinalTest({super.key, required this.questions});

  @override
  State<FinalTest> createState() => _FinalTestState();
}

class _FinalTestState extends State<FinalTest> {
  _FinalTestState();

  int currentQuestionIndex = 0;
  int? selected;
  int score = 0;
  bool isDialogOpen = false;
  bool showFeedback = false;
  String _feedbackText = '';
  bool _isCorrect = false;

  void _submitAnswer() {
    final current = widget.questions[currentQuestionIndex];
    final isCorrect = selected == current.correctIndex;

    String explanationText;
    if (isCorrect) {
      explanationText = current.explanation;
      score += 10;
    } else if (current.incorrectExplanations != null &&
        selected != null &&
        selected! < current.incorrectExplanations!.length) {
      explanationText = current.incorrectExplanations![selected!];
    } else {
      explanationText = 'Wrong answer.';
    }

    setState(() {
      _feedbackText = explanationText;
      _isCorrect = isCorrect;
      showFeedback = true;
      isDialogOpen = true; // bloquea las opciones
    });
  }

  Future<void> _finishQuiz() async {
    final userScore = score;
    final firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;

    await firestore.collection("quiz_results").add({
      'score': userScore,
      'timestamp': Timestamp.now(),
    });

    if (userScore >= 120) {
      if (user != null) {
        final medalRef = firestore
            .collection('users')
            .doc(user.uid)
            .collection('medals')
            .doc('Referential Ranger');

        final existing = await medalRef.get();

        if (!existing.exists) {
          await medalRef.set({
            'medalName': 'Referential Ranger',
            'score': userScore,
            'timestamp': FieldValue.serverTimestamp(),
          });
        }

        // ✅ NUEVO: marcar checkpoint localmente
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('completedCheckpoint1', true);
        int count = prefs.getInt('completedSpotsCount') ?? 0;
        await prefs.setInt('completedSpotsCount', count + 1);

        // Navegar a pantalla final
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => FinalPath(score: userScore),
          ),
        );

        // ✅ También guarda progreso del spot
        await _completeFinalLevel(context);
      } else {
        // ignore: avoid_print
        print("Usuario no autenticado. No se puede guardar medalla.");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => FinalPath(score: userScore),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Colors.red, width: 3),
          ),
          title: Row(
            children: const [
              Icon(Icons.warning, color: Colors.red),
              SizedBox(width: 10),
              Text("Not Passed ", style: TextStyle(fontSize: 22)),
            ],
          ),
          content: Text(
            "Your score was $userScore points. You need at least 120 points to pass. Please try again.",
            style: const TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  score = 0;
                  currentQuestionIndex = 0;
                  selected = null;
                });
              },
              child: const Text("Retry 🔄"),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _completeFinalLevel(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // 🔥 Guarda el progreso de este spot en Firestore
    await FirebaseFirestore.instance
        .collection('userProgress')
        .doc(user.uid)
        .set({'completedCheckpoint1': true}, SetOptions(merge: true));

    // 💾 Guarda localmente
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('completedCheckpoint1', true);

    // 🔥 Incrementa el conteo total en Firestore
    await _incrementSpotCount(user);
  }

  Future<void> _incrementSpotCount(User user) async {
    await FirebaseFirestore.instance
        .collection('userProgress')
        .doc(user.uid)
        .set({
      'completedSpotsCount': FieldValue.increment(1),
    }, SetOptions(merge: true));
  }

  Widget quizCard({
    required Widget child,
    EdgeInsets padding = const EdgeInsets.all(12),
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    final parts = question.question.split('\n\n');
    final String contextText = parts.length > 1
        ? parts.sublist(0, parts.length - 1).join('\n\n')
        : question.question;
    final String questionText = parts.length > 1 ? parts.last : '';

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Wallpapers/PATHWAY WALLPAPER.webp"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            MediaQuery.of(context).padding.top + 12,
            24,
            24,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    layoutBuilder: (currentChild, previousChildren) {
                      return Stack(
                        children: [
                          ...previousChildren,
                          if (currentChild != null) currentChild,
                        ],
                      );
                    },
                    child: Column(
                      key: ValueKey<int>(currentQuestionIndex),
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Score
                        quizCard(
                          child: Text(
                            "Score: $score",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),

                        // Contexto
                        if (contextText.isNotEmpty)
                          quizCard(
                            child: Text(
                              contextText,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.4,
                              ),
                            ),
                          ),
                        const SizedBox(height: 2),

                        // Pregunta
                        if (questionText.isNotEmpty)
                          quizCard(
                            child: Text(
                              questionText,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        const SizedBox(height: 12),

                        // Opciones como cards tappables (sin radio buttons)
                        ...List.generate(question.options.length, (i) {
                          final isSelected = selected == i;
                          final isCorrectOption = i == question.correctIndex;

                          Color cardColor = Colors.white;
                          Color borderColor = Colors.transparent;
                          double borderWidth = 0;

                          if (showFeedback) {
                            if (isSelected && !isCorrectOption) {
                              cardColor = const Color(0xFFFFEBEE);
                              borderColor = Colors.red;
                              borderWidth = 2;
                            }
                          } else if (isSelected) {
                            borderColor = Colors.green;
                            borderWidth = 2;
                          }

                          return GestureDetector(
                            onTap: isDialogOpen
                                ? null
                                : () => setState(() => selected = i),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: borderColor,
                                  width: borderWidth,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 2,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Text(
                                question.options[i],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                  color: showFeedback && isCorrectOption
                                      ? const Color.fromARGB(255, 0, 0, 0)
                                      : showFeedback && isSelected
                                          ? const Color(0xFFC62828)
                                          : Colors.black87,
                                ),
                              ),
                            ),
                          );
                        }),

                        const SizedBox(height: 4),

                        // Submit o Feedback Card (uno tapa al otro)
                        if (!showFeedback)
                          Center(
                            child: ElevatedButton(
                              onPressed: selected != null && !isDialogOpen
                                  ? _submitAnswer
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 36,
                                  vertical: 14,
                                ),
                              ),
                              child: const Text(
                                "Submit",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        else
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: _isCorrect
                                  ? const Color(0xFFE8F5E9)
                                  : const Color(0xFFFFEBEE),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _isCorrect
                                      ? "✩ $_feedbackText"
                                      : "❌ $_feedbackText",
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                    color: _isCorrect
                                        ? const Color(0xFF1B5E20)
                                        : Colors.red,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _isCorrect
                                          ? Colors.green.shade500
                                          : Colors.red.shade400,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 10,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        showFeedback = false;
                                        _feedbackText = '';
                                        isDialogOpen = false;
                                        if (currentQuestionIndex <
                                            widget.questions.length - 1) {
                                          currentQuestionIndex++;
                                          selected = null;
                                        } else {
                                          _finishQuiz();
                                        }
                                      });
                                    },
                                    child: const Text(
                                      "Next",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ─── Particle model ───────────────────────────────────────────────────────────
class _Star {
  late double x, y, size, opacity, speed;
  _Star(Random rng, Size screen) {
    _randomize(rng, screen, initial: true);
  }
  void _randomize(Random rng, Size screen, {bool initial = false}) {
    x = rng.nextDouble() * screen.width;
    y = initial ? rng.nextDouble() * screen.height : -10.0;
    size = rng.nextDouble() * 2.4 + 0.4;
    opacity = rng.nextDouble() * 0.7 + 0.3;
    speed = rng.nextDouble() * 0.3 + 0.05;
  }

  void tick(Random rng, Size screen) {
    y += speed;
    if (y > screen.height + 10) _randomize(rng, screen);
  }
}

// ─── Starfield painter ────────────────────────────────────────────────────────
class _StarfieldPainter extends CustomPainter {
  final List<_Star> stars;
  final double twinkle;
  _StarfieldPainter(this.stars, this.twinkle);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..isAntiAlias = true;
    for (final s in stars) {
      final pulse = (sin(twinkle * pi * 2 + s.x) * 0.3 + 0.7).clamp(0.0, 1.0);
      paint.color = Colors.white.withOpacity(s.opacity * pulse);
      canvas.drawCircle(Offset(s.x, s.y), s.size, paint);
    }
  }

  @override
  bool shouldRepaint(_StarfieldPainter old) => true;
}

// ─── Shooting star painter ────────────────────────────────────────────────────
class _ShootingStarPainter extends CustomPainter {
  final double progress;
  final Offset start, end;
  _ShootingStarPainter(this.progress, this.start, this.end);

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0 || progress >= 1) return;
    final head = Offset.lerp(start, end, progress)!;
    final tail = Offset.lerp(start, end, (progress - 0.18).clamp(0, 1))!;
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.white.withOpacity(0.9), Colors.transparent],
      ).createShader(Rect.fromPoints(tail, head))
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;
    canvas.drawLine(tail, head, paint);
  }

  @override
  bool shouldRepaint(_ShootingStarPainter old) => progress != old.progress;
}

// ─── Nebula painter (green palette) ──────────────────────────────────────────
class _NebulaPainter extends CustomPainter {
  final double t;
  _NebulaPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..isAntiAlias = true;

    // blob 1 – emerald top-left
    final r1 = 190.0 + sin(t * pi) * 22;
    paint.shader = RadialGradient(colors: [
      const Color(0xFF1B6B3A).withOpacity(0.22),
      Colors.transparent,
    ]).createShader(Rect.fromCircle(
        center: Offset(size.width * 0.12, size.height * 0.15), radius: r1));
    canvas.drawCircle(Offset(size.width * 0.12, size.height * 0.15), r1, paint);

    // blob 2 – lime/teal bottom-right
    final r2 = 230.0 + cos(t * pi) * 26;
    paint.shader = RadialGradient(colors: [
      const Color(0xFF2E8B57).withOpacity(0.18),
      Colors.transparent,
    ]).createShader(Rect.fromCircle(
        center: Offset(size.width * 0.88, size.height * 0.78), radius: r2));
    canvas.drawCircle(Offset(size.width * 0.88, size.height * 0.78), r2, paint);

    // blob 3 – dark forest center
    final r3 = 160.0 + sin(t * pi * 1.4) * 18;
    paint.shader = RadialGradient(colors: [
      const Color(0xFF0D4A2A).withOpacity(0.25),
      Colors.transparent,
    ]).createShader(Rect.fromCircle(
        center: Offset(size.width * 0.5, size.height * 0.48), radius: r3));
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.48), r3, paint);

    // blob 4 – subtle yellow-green spark top-right
    final r4 = 110.0 + sin(t * pi * 0.8) * 14;
    paint.shader = RadialGradient(colors: [
      const Color(0xFF66BB6A).withOpacity(0.10),
      Colors.transparent,
    ]).createShader(Rect.fromCircle(
        center: Offset(size.width * 0.82, size.height * 0.12), radius: r4));
    canvas.drawCircle(Offset(size.width * 0.82, size.height * 0.12), r4, paint);
  }

  @override
  bool shouldRepaint(_NebulaPainter old) => t != old.t;
}

// ─── Main widget ──────────────────────────────────────────────────────────────
class FinalPath extends StatefulWidget {
  final int score;
  const FinalPath({super.key, required this.score});

  @override
  State<FinalPath> createState() => _FinalPathState();
}

class _FinalPathState extends State<FinalPath> with TickerProviderStateMixin {
  bool showMessage = false;

  // ── original medal animations (untouched logic) ──
  late AnimationController _dropController;
  late Animation<Offset> _medalOffset;
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  // ── space background ──
  late AnimationController _starController;
  late AnimationController _shootController;
  late AnimationController _nebulaController;

  final Random _rng = Random();
  List<_Star> _stars = [];
  Size _screenSize = Size.zero;

  Offset _ssStart = Offset.zero;
  Offset _ssEnd = Offset.zero;

  // ── glow ──
  late AnimationController _glowController;
  late Animation<double> _glowAnim;

  Future<void> _completeFinalLevel(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // ── progreso existente (sin cambios) ──
    await FirebaseFirestore.instance
        .collection('userProgress')
        .doc(user.uid)
        .set({'completedCheckpoint1': true}, SetOptions(merge: true));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('completedCheckpoint1', true);

    // ── NUEVO: guardar medalla con fecha ──
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('medals')
        .doc('Referential Ranger') // nombre exacto como en kMedals
        .set(
            {
          'unlockedAt': FieldValue.serverTimestamp(),
        },
            SetOptions(
                merge: true)); // merge: true para no sobreescribir si ya existe

    await _incrementSpotCount(user);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  Future<void> _incrementSpotCount(User user) async {
    await FirebaseFirestore.instance
        .collection('userProgress')
        .doc(user.uid)
        .set({'completedSpotsCount': FieldValue.increment(1)},
            SetOptions(merge: true));
  }

  void _randomizeShootingStar() {
    final w = _screenSize.width;
    final h = _screenSize.height;
    _ssStart = Offset(_rng.nextDouble() * w * 0.6, _rng.nextDouble() * h * 0.4);
    _ssEnd = Offset(
      _ssStart.dx + 120 + _rng.nextDouble() * 80,
      _ssStart.dy + 80 + _rng.nextDouble() * 60,
    );
  }

  @override
  void initState() {
    super.initState();

    // ── original medal logic (unchanged) ──
    _dropController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _medalOffset = Tween<Offset>(begin: const Offset(0, -2), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _dropController, curve: Curves.easeOutBack));
    _floatController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _floatAnimation = Tween<double>(begin: 0, end: 10).animate(
        CurvedAnimation(parent: _floatController, curve: Curves.easeInOut));

    Future.delayed(const Duration(milliseconds: 300), () {
      _dropController.forward().whenComplete(() {
        setState(() => showMessage = true);
        _floatController.repeat(reverse: true);
      });
    });

    // ── starfield ──
    _starController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat();

    // ── shooting star ──
    _shootController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed) {
          Future.delayed(Duration(milliseconds: 3500 + _rng.nextInt(3000)), () {
            if (!mounted) return;
            _randomizeShootingStar();
            _shootController.forward(from: 0);
          });
        }
      });

    // ── nebula ──
    _nebulaController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat(reverse: true);

    // ── glow ──
    _glowController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);
    _glowAnim = Tween<double>(begin: 4, end: 18).animate(
        CurvedAnimation(parent: _glowController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _dropController.dispose();
    _floatController.dispose();
    _starController.dispose();
    _shootController.dispose();
    _nebulaController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _initStars(Size size) {
    if (_stars.isNotEmpty) return;
    _screenSize = size;
    _stars = List.generate(160, (_) => _Star(_rng, size));
    _randomizeShootingStar();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) _shootController.forward(from: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        _initStars(size);

        return Stack(
          children: [
            // ── deep forest-space gradient ──
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF010F05),
                    Color(0xFF041A0B),
                    Color(0xFF072215),
                    Color(0xFF030E07),
                  ],
                  stops: [0.0, 0.3, 0.7, 1.0],
                ),
              ),
            ),

            // ── nebula blobs ──
            AnimatedBuilder(
              animation: _nebulaController,
              builder: (_, __) => CustomPaint(
                size: size,
                painter: _NebulaPainter(_nebulaController.value),
              ),
            ),

            // ── starfield ──
            AnimatedBuilder(
              animation: _starController,
              builder: (_, __) {
                for (final s in _stars) {
                  s.tick(_rng, size);
                }
                return CustomPaint(
                  size: size,
                  painter: _StarfieldPainter(_stars, _starController.value),
                );
              },
            ),

            // ── shooting star ──
            AnimatedBuilder(
              animation: _shootController,
              builder: (_, __) => CustomPaint(
                size: size,
                painter: _ShootingStarPainter(
                    _shootController.value, _ssStart, _ssEnd),
              ),
            ),

            // ── main content ──
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 180),

                        // title card
                        AnimatedOpacity(
                          opacity: showMessage ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 700),
                          child: AnimatedBuilder(
                            animation: _glowAnim,
                            builder: (_, child) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF2E8B57)
                                        .withOpacity(0.18),
                                    blurRadius: _glowAnim.value * 2,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: child,
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.04),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color:
                                      const Color(0xFF4CAF50).withOpacity(0.28),
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                'You did it! You\'ve passed the final test\nand finished strong! 🌟🎓👏',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFA8E6B0),
                                  height: 1.45,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // score
                        AnimatedOpacity(
                          opacity: showMessage ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 900),
                          child: AnimatedBuilder(
                            animation: _glowAnim,
                            builder: (_, __) => Text.rich(
                              TextSpan(children: [
                                const TextSpan(
                                  text: 'You scored  ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF81C784),
                                  ),
                                ),
                                TextSpan(
                                  text: '${widget.score}',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: const Color(0xFF66BB6A),
                                        blurRadius: _glowAnim.value,
                                      ),
                                    ],
                                  ),
                                ),
                                const TextSpan(
                                  text: '  points ✨',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF81C784),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // button
                        AnimatedOpacity(
                          opacity: showMessage ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 1100),
                          child: _CosmicButton(
                            label: '🚀  Back to Home',
                            onPressed: () async {
                              _floatController.stop();
                              await _completeFinalLevel(context);
                            },
                          ),
                        ),
                      ],
                    ),

                    // ── medal (original animation untouched) ──
                    SlideTransition(
                      position: _medalOffset,
                      child: AnimatedBuilder(
                        animation: _floatController,
                        builder: (context, child) => Transform.translate(
                          offset: Offset(0, -_floatAnimation.value),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // halo glow behind medal
                              AnimatedBuilder(
                                animation: _glowAnim,
                                builder: (_, __) => Container(
                                  width: 220,
                                  height: 220,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF4CAF50)
                                            .withOpacity(0.28),
                                        blurRadius: _glowAnim.value * 3,
                                        spreadRadius: _glowAnim.value,
                                      ),
                                      BoxShadow(
                                        color: const Color(0xFF1B5E20)
                                            .withOpacity(0.20),
                                        blurRadius: _glowAnim.value * 5,
                                        spreadRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(children: [
                                Image.asset(
                                  'assets/Medals/1. Referential Ranger.png',
                                  width: 200,
                                  height: 200,
                                ),
                                const SizedBox(height: 12),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

// ─── Cosmic animated button (green) ──────────────────────────────────────────
class _CosmicButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  const _CosmicButton({required this.label, required this.onPressed});

  @override
  State<_CosmicButton> createState() => _CosmicButtonState();
}

class _CosmicButtonState extends State<_CosmicButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _pulse =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);
    _scale = Tween<double>(begin: 1.0, end: 1.04)
        .animate(CurvedAnimation(parent: _pulse, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scale,
      builder: (_, child) => Transform.scale(scale: _scale.value, child: child),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF2E7D32),
                Color(0xFF4CAF50),
                Color(0xFF1B5E20),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4CAF50).withOpacity(0.45),
                blurRadius: 24,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Text(
            '🚀  Back to Home',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
