// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inferwise/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Question.dart';
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
      _isCorrect = isCorrect;
      _feedbackText = explanationText;
      showFeedback = true;
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

    if (userScore >= 200) {
      if (user != null) {
        final medalRef = firestore
            .collection('users')
            .doc(user.uid)
            .collection('medals')
            .doc('Infera Champion');

        final existing = await medalRef.get();

        if (!existing.exists) {
          await medalRef.set({
            'medalName': 'Infera Champion',
            'score': userScore,
            'timestamp': FieldValue.serverTimestamp(),
          });
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('completedFinalTest', true);
        int count = prefs.getInt('completedSpotsCount') ?? 0;
        await prefs.setInt('completedSpotsCount', count + 1);

        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => FinalPath(score: userScore)),
        );

        if (result == true && mounted) {
          await _completeFinalLevel(context);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainScreen()),
          );
        }
      } else {
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
            side: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 3),
          ),
          title: Row(
            children: const [
              Icon(Icons.warning, color: Color.fromARGB(255, 0, 0, 0)),
              SizedBox(width: 10),
              Text("Not Passed ", style: TextStyle(fontSize: 22)),
            ],
          ),
          content: Text(
            "Your score was $userScore points. Don't worry! 🌟 You can try again—retake the test, keep learning, and show your Infera Champion spirit! 💪📖👏",
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

    await FirebaseFirestore.instance
        .collection('userProgress')
        .doc(user.uid)
        .set({'completedFinalTest': true}, SetOptions(merge: true));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('completedFinalTest', true);

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

  Widget _buildTextWithHighlights(String text, int index, TextStyle baseStyle) {
    if (index != 3 && index != 4) {
      return Text(text, style: baseStyle);
    }

    final List<String> wordsToHighlight = ["dish", "present", "prensent"];
    final List<TextSpan> spans = [];

    final pattern = RegExp(
      "(${wordsToHighlight.join('|')})",
      caseSensitive: false,
    );

    text.splitMapJoin(
      pattern,
      onMatch: (match) {
        spans.add(TextSpan(
          text: match.group(0),
          style: baseStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF222222), // ← antes verde, ahora negro intenso
          ),
        ));
        return '';
      },
      onNonMatch: (nonMatch) {
        spans.add(TextSpan(text: nonMatch, style: baseStyle));
        return '';
      },
    );

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  Widget quizCard({
    required Widget child,
    EdgeInsets padding = const EdgeInsets.all(16),
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
            blurRadius: 6,
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
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Wallpapers/FINAL TEST.webp"),
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
                        if (contextText.isNotEmpty)
                          quizCard(
                            child: _buildTextWithHighlights(
                              contextText,
                              currentQuestionIndex,
                              const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                height: 1.4,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        const SizedBox(height: 2),
                        if (questionText.isNotEmpty)
                          quizCard(
                            child: _buildTextWithHighlights(
                              questionText,
                              currentQuestionIndex,
                              const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        const SizedBox(height: 2),
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
                            borderColor = Colors.black; // ← antes verde
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

                        if (!showFeedback)
                          Center(
                            child: ElevatedButton(
                              onPressed: selected != null && !isDialogOpen
                                  ? _submitAnswer
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 61, 61, 61), // ← antes verde
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
                                  ? const Color(0xFFF5F5F5) // ← antes verde claro
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
                                        ? const Color(0xFF212121) // ← antes verde oscuro
                                        : Colors.red,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _isCorrect
                                          ? const Color.fromARGB(255, 61, 61, 61) // ← antes verde
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
                                        color: Colors.white, // ← antes negro sobre verde
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




// ─── Star particle ────────────────────────────────────────────────────────────
class _Star {
  late double x, y, size, opacity, speed;
  _Star(Random rng, Size screen) {
    _randomize(rng, screen, initial: true);
  }
  void _randomize(Random rng, Size screen, {bool initial = false}) {
    x = rng.nextDouble() * screen.width;
    y = initial ? rng.nextDouble() * screen.height : -10.0;
    size = rng.nextDouble() * 2.2 + 0.4;
    opacity = rng.nextDouble() * 0.6 + 0.4;
    speed = rng.nextDouble() * 0.25 + 0.05;
  }

  void tick(Random rng, Size screen) {
    y += speed;
    if (y > screen.height + 10) _randomize(rng, screen);
  }
}

// ─── Orbit particle (Mario Galaxy style) ─────────────────────────────────────
class _OrbitParticle {
  final double angle;       // starting angle
  final double radius;      // orbit radius
  final double speed;       // radians per frame
  final double size;
  final double opacity;
  double currentAngle;

  _OrbitParticle(Random rng)
      : angle = rng.nextDouble() * pi * 2,
        radius = 120 + rng.nextDouble() * 80,
        speed = (rng.nextDouble() * 0.012 + 0.006) *
            (rng.nextBool() ? 1 : -1),
        size = rng.nextDouble() * 3.5 + 1.0,
        opacity = rng.nextDouble() * 0.7 + 0.3,
        currentAngle = rng.nextDouble() * pi * 2;

  void tick() {
    currentAngle += speed;
  }

  Offset position(Offset center) {
    return Offset(
      center.dx + cos(currentAngle) * radius,
      center.dy + sin(currentAngle) * radius * 0.45, // flatten into ellipse
    );
  }
}

// ─── Stardust ring painter ────────────────────────────────────────────────────
class _OrbitPainter extends CustomPainter {
  final List<_OrbitParticle> particles;
  final Offset center;
  final double glow;

  _OrbitPainter(this.particles, this.center, this.glow);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..isAntiAlias = true;
    for (final p in particles) {
      final pos = p.position(center);
      // draw glow halo
      paint.color = Colors.white.withOpacity(p.opacity * 0.25 * glow);
      canvas.drawCircle(pos, p.size * 2.2, paint);
      // draw core
      paint.color = Colors.white.withOpacity(p.opacity);
      canvas.drawCircle(pos, p.size, paint);
    }
  }

  @override
  bool shouldRepaint(_OrbitPainter old) => true;
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
      final pulse =
          (sin(twinkle * pi * 2 + s.x) * 0.35 + 0.65).clamp(0.0, 1.0);
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
    final tail = Offset.lerp(start, end, (progress - 0.22).clamp(0, 1))!;
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.white, Colors.transparent],
      ).createShader(Rect.fromPoints(tail, head))
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;
    canvas.drawLine(tail, head, paint);
  }

  @override
  bool shouldRepaint(_ShootingStarPainter old) => progress != old.progress;
}

// ─── Nebula painter (monochrome — silver/grey mist) ───────────────────────────
class _NebulaPainter extends CustomPainter {
  final double t;
  _NebulaPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..isAntiAlias = true;

    final blobs = [
      (Offset(size.width * 0.10, size.height * 0.12), 200.0, const Color(0xFFFFFFFF), 0.07),
      (Offset(size.width * 0.88, size.height * 0.20), 160.0, const Color(0xFFCCCCCC), 0.06),
      (Offset(size.width * 0.50, size.height * 0.45), 220.0, const Color(0xFF888888), 0.09),
      (Offset(size.width * 0.85, size.height * 0.80), 180.0, const Color(0xFFAAAAAA), 0.07),
      (Offset(size.width * 0.15, size.height * 0.85), 150.0, const Color(0xFFFFFFFF), 0.05),
    ];

    for (int i = 0; i < blobs.length; i++) {
      final b = blobs[i];
      final r = b.$2 + sin(t * pi + i * 1.3) * 18;
      paint.shader = RadialGradient(colors: [
        b.$3.withOpacity(b.$4),
        Colors.transparent,
      ]).createShader(Rect.fromCircle(center: b.$1, radius: r));
      canvas.drawCircle(b.$1, r, paint);
    }
  }

  @override
  bool shouldRepaint(_NebulaPainter old) => t != old.t;
}

// ─── Burst painter (explosion on drop landing) ────────────────────────────────
class _BurstPainter extends CustomPainter {
  final double progress; // 0→1
  final Offset center;
  _BurstPainter(this.progress, this.center);

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0 || progress >= 1) return;
    final eased = Curves.easeOut.transform(progress);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    for (int i = 0; i < 16; i++) {
      final angle = (i / 16) * pi * 2;
      final len = 30 + (i % 3) * 20.0;
      final start = Offset(
        center.dx + cos(angle) * 110 * eased,
        center.dy + sin(angle) * 50 * eased,
      );
      final end = Offset(
        center.dx + cos(angle) * (110 + len) * eased,
        center.dy + sin(angle) * (50 + len * 0.45) * eased,
      );
      final opacity = (1.0 - eased).clamp(0.0, 1.0);
      paint.color = Colors.white.withOpacity(opacity * 0.85);
      paint.strokeWidth = 1.5 + (i % 2) * 0.8;
      canvas.drawLine(start, end, paint);
    }

    // expanding ring
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.white.withOpacity((1 - eased).clamp(0, 1) * 0.6)
      ..isAntiAlias = true;
    canvas.drawOval(
      Rect.fromCenter(
        center: center,
        width: 240 * eased,
        height: 110 * eased,
      ),
      ringPaint,
    );
  }

  @override
  bool shouldRepaint(_BurstPainter old) => progress != old.progress;
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

  // ── original medal animations (untouched) ──
  late AnimationController _dropController;
  late Animation<Offset> _medalOffset;
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  // ── space background ──
  late AnimationController _starController;
  late AnimationController _shootController;
  late AnimationController _nebulaController;

  // ── galaxy orbit ring ──
  late AnimationController _orbitController;
  final List<_OrbitParticle> _orbitParticles = [];

  // ── burst on landing ──
  late AnimationController _burstController;

  // ── glow pulse ──
  late AnimationController _glowController;
  late Animation<double> _glowAnim;

  // ── title shimmer ──
  late AnimationController _shimmerController;

  final Random _rng = Random();
  List<_Star> _stars = [];
  Size _screenSize = Size.zero;
  Offset _medalCenter = Offset.zero;

  Offset _ssStart = Offset.zero;
  Offset _ssEnd = Offset.zero;

Future<void> _completeFinalLevel(BuildContext context) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  await FirebaseFirestore.instance
      .collection('userProgress')
      .doc(user.uid)
      .set({'completedFinalTest': true}, SetOptions(merge: true));

  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('completedFinalTest', true);

  // ── NUEVO: guardar medalla Infera Champion con fecha ──
  await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('medals')
      .doc('Infera Champion')
      .set({
    'unlockedAt': FieldValue.serverTimestamp(),
  }, SetOptions(merge: true));

  await _incrementSpotCount(user);

  Navigator.pop(context, true);
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
    _ssStart =
        Offset(_rng.nextDouble() * w * 0.5, _rng.nextDouble() * h * 0.35);
    _ssEnd = Offset(
      _ssStart.dx + 140 + _rng.nextDouble() * 100,
      _ssStart.dy + 90 + _rng.nextDouble() * 70,
    );
  }

  @override
  void initState() {
    super.initState();

    // ── original medal logic (unchanged) ──
    _dropController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _medalOffset =
        Tween<Offset>(begin: const Offset(0, -4), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _dropController, curve: Curves.easeOutBack));
    _floatController = AnimationController(
        vsync: this, duration: const Duration(seconds: 4));
    _floatAnimation = Tween<double>(begin: 0, end: 10).animate(
        CurvedAnimation(parent: _floatController, curve: Curves.easeInOut));

    Future.delayed(const Duration(milliseconds: 300), () {
      _dropController.forward().whenComplete(() {
        setState(() => showMessage = true);
        _floatController.repeat(reverse: true);
        // fire burst on landing
        _burstController.forward(from: 0);
        // start orbit ring
        _orbitController.repeat();
        // start shimmer
        _shimmerController.repeat();
      });
    });

    // ── starfield ──
    _starController = AnimationController(
        vsync: this, duration: const Duration(seconds: 3))
      ..repeat();

    // ── shooting star ──
    _shootController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800))
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed) {
          Future.delayed(
              Duration(milliseconds: 2500 + _rng.nextInt(2500)), () {
            if (!mounted) return;
            _randomizeShootingStar();
            _shootController.forward(from: 0);
          });
        }
      });

    // ── nebula ──
    _nebulaController = AnimationController(
        vsync: this, duration: const Duration(seconds: 7))
      ..repeat(reverse: true);

    // ── orbit ring ──
    _orbitController = AnimationController(
        vsync: this, duration: const Duration(seconds: 8));
    _orbitParticles
        .addAll(List.generate(40, (_) => _OrbitParticle(_rng)));

    // ── burst ──
    _burstController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    // ── glow ──
    _glowController = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _glowAnim = Tween<double>(begin: 6, end: 24).animate(
        CurvedAnimation(parent: _glowController, curve: Curves.easeInOut));

    // ── shimmer ──
    _shimmerController = AnimationController(
        vsync: this, duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _dropController.dispose();
    _floatController.dispose();
    _starController.dispose();
    _shootController.dispose();
    _nebulaController.dispose();
    _orbitController.dispose();
    _burstController.dispose();
    _glowController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  void _initStars(Size size) {
    if (_stars.isNotEmpty) return;
    _screenSize = size;
    _stars = List.generate(200, (_) => _Star(_rng, size));
    _randomizeShootingStar();
    // medal sits roughly at top-center after padding
    _medalCenter = Offset(size.width / 2, 132);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) _shootController.forward(from: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        _initStars(size);

        return Stack(
          children: [
            // ── deep black gradient ──
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF000000),
                    Color(0xFF0A0A0A),
                    Color(0xFF141414),
                    Color(0xFF050505),
                  ],
                  stops: [0.0, 0.3, 0.7, 1.0],
                ),
              ),
            ),

            // ── silver nebula mist ──
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

            // ── shooting stars ──
            AnimatedBuilder(
              animation: _shootController,
              builder: (_, __) => CustomPaint(
                size: size,
                painter: _ShootingStarPainter(
                    _shootController.value, _ssStart, _ssEnd),
              ),
            ),

            // ── galaxy orbit ring (around medal) ──
            AnimatedBuilder(
              animation: _orbitController,
              builder: (_, __) {
                for (final p in _orbitParticles) {
                  p.tick();
                }
                return AnimatedBuilder(
                  animation: _glowAnim,
                  builder: (_, __) => CustomPaint(
                    size: size,
                    painter: _OrbitPainter(
                      _orbitParticles,
                      _medalCenter,
                      (_glowAnim.value / 24).clamp(0, 1),
                    ),
                  ),
                );
              },
            ),

            // ── burst on medal landing ──
            AnimatedBuilder(
              animation: _burstController,
              builder: (_, __) => CustomPaint(
                size: size,
                painter:
                    _BurstPainter(_burstController.value, _medalCenter),
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
                        const SizedBox(height: 188),

                        // title with shimmer
                        AnimatedOpacity(
                          opacity: showMessage ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 800),
                          child: AnimatedBuilder(
                            animation: _shimmerController,
                            builder: (_, child) {
                              return ShaderMask(
                                shaderCallback: (bounds) {
                                  final t = _shimmerController.value;
                                  return LinearGradient(
                                    colors: const [
                                      Color(0xFF888888),
                                      Colors.white,
                                      Color(0xFFCCCCCC),
                                      Colors.white,
                                      Color(0xFF888888),
                                    ],
                                    stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
                                    begin: Alignment(-2 + t * 4, 0),
                                    end: Alignment(-1 + t * 4, 0),
                                  ).createShader(bounds);
                                },
                                child: child,
                              );
                            },
                            child: AnimatedBuilder(
                              animation: _glowAnim,
                              builder: (_, child) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white
                                          .withOpacity(0.08),
                                      blurRadius: _glowAnim.value * 1.5,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: child,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22, vertical: 18),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.04),
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.18),
                                    width: 1,
                                  ),
                                ),
                                child: const Text(
                                  'Congratulations! 🌟\n\nYou\'ve completed the entire pathway and mastered the art of making inferences — now you\'re officially an Infera Champion! 🏆🎓👏',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    height: 1.5,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // score
                        AnimatedOpacity(
                          opacity: showMessage ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 1000),
                          child: AnimatedBuilder(
                            animation: _glowAnim,
                            builder: (_, __) => Text.rich(
                              TextSpan(children: [
                                const TextSpan(
                                  text: 'You scored  ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFFAAAAAA),
                                  ),
                                ),
                                TextSpan(
                                  text: '${widget.score}',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.white,
                                        blurRadius: _glowAnim.value,
                                      ),
                                    ],
                                  ),
                                ),
                                const TextSpan(
                                  text: '  points ✨',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFFAAAAAA),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),

                        const SizedBox(height: 44),

                        // final button
                        AnimatedOpacity(
                          opacity: showMessage ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 1200),
                          child: _ChampionButton(
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
                              // multi-ring white glow halo
                              AnimatedBuilder(
                                animation: _glowAnim,
                                builder: (_, __) => Container(
                                  width: 230,
                                  height: 230,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.35),
                                        blurRadius: _glowAnim.value * 2,
                                        spreadRadius: _glowAnim.value * 0.5,
                                      ),
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.12),
                                        blurRadius: _glowAnim.value * 5,
                                        spreadRadius: _glowAnim.value,
                                      ),
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.05),
                                        blurRadius: _glowAnim.value * 10,
                                        spreadRadius: _glowAnim.value * 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Image.asset(
                                'assets/Medals/6. Infera Champion.png',
                                width: 200,
                                height: 200,
                              ),
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

// ─── Champion button (black/white with pulse) ─────────────────────────────────
class _ChampionButton extends StatefulWidget {
  final VoidCallback onPressed;
  const _ChampionButton({required this.onPressed});

  @override
  State<_ChampionButton> createState() => _ChampionButtonState();
}

class _ChampionButtonState extends State<_ChampionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;
  late Animation<double> _scale;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _scale = Tween<double>(begin: 1.0, end: 1.05)
        .animate(CurvedAnimation(parent: _pulse, curve: Curves.easeInOut));
    _glow = Tween<double>(begin: 8, end: 28)
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
      animation: _pulse,
      builder: (_, __) => Transform.scale(
        scale: _scale.value,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 17),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF1A1A1A),
                  Color(0xFF3A3A3A),
                  Color(0xFF111111),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.30),
                  blurRadius: _glow.value,
                  spreadRadius: 1,
                  offset: const Offset(0, 0),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Text(
              '🏆  Back to Home',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
