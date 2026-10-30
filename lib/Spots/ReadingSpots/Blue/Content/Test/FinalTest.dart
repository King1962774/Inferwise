import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inferwise/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Test.dart';
import 'dart:math';

class FinalTest extends StatefulWidget {
  final List<QuestionData> questions;
  const FinalTest({super.key, required this.questions});

  @override
  State<FinalTest> createState() => _FinalTestState();
}

class _FinalTestState extends State<FinalTest> {
  int currentQuestionIndex = 0;
  int? selected;
  int score = 0;
  bool isDialogOpen = false;
  bool showingNextPartAnimation = false;
  bool showFeedback = false;
  String _feedbackText = '';
  bool _isCorrect = false;  // ← quitado el "final"

  void _startNextPartTimer() {
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          showingNextPartAnimation = false;
          currentQuestionIndex++;
          selected = null;
        });
      }
    });
  }

  // ← _submitAnswer reemplazado: ya no usa showDialog
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

    if (userScore >= 120) {
      if (user != null) {
        final medalRef = firestore
            .collection('users')
            .doc(user.uid)
            .collection('medals')
            .doc('Lexical Linker');
        final existing = await medalRef.get();
        if (!existing.exists) {
          await medalRef.set({
            'medalName': 'Lexical Linker',
            'score': userScore,
            'timestamp': FieldValue.serverTimestamp(),
          });
        }
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('completedCheckpoint2', true);
        int count = prefs.getInt('completedSpotsCount') ?? 0;
        await prefs.setInt('completedSpotsCount', count + 1);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => FinalPath(score: userScore)),
        );
        await _completeFinalLevel(context);
      } else {
        // ignore: avoid_print
        print("Usuario no autenticado. No se puede guardar medalla.");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => FinalPath(score: userScore)),
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
                  showFeedback = false;
                  _feedbackText = '';
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
        .set({'completedCheckpoint2': true}, SetOptions(merge: true));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('completedCheckpoint2', true);
    await _incrementSpotCount(user);
  }

  Future<void> _incrementSpotCount(User user) async {
    await FirebaseFirestore.instance
        .collection('userProgress')
        .doc(user.uid)
        .set({'completedSpotsCount': FieldValue.increment(1)},
            SetOptions(merge: true));
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
    if (showingNextPartAnimation) {
      return const _GalacticTransitionScreen();
    }

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
            image: AssetImage("assets/Wallpapers/CHECKSPOT 2.webp"),
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
                  constraints:
                      BoxConstraints(minHeight: constraints.maxHeight),
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

                        // Opciones
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
                            borderColor = const Color(0xFF4C9EAF);
                            borderWidth = 2;
                          }

                          return GestureDetector(
                            onTap: showFeedback
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

                        // Submit o Feedback
                        if (!showFeedback)
                          Center(
                            child: ElevatedButton(
                              onPressed: selected != null
                                  ? _submitAnswer
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4C9EAF),
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
                                  ? const Color(0xFFE0F7FA)
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
                                        ? const Color(0xFF006064)
                                        : Colors.red,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _isCorrect
                                          ? const Color(0xFF4C9EAF)
                                          : Colors.red.shade400,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10),
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
                                        if (currentQuestionIndex == 9 &&
                                            widget.questions.length > 10) {
                                          showingNextPartAnimation = true;
                                          _startNextPartTimer();
                                        } else if (currentQuestionIndex <
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
                                        color: Colors.white,
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
// ═══════════════════════════════════════════════════════════════════════════════
//  GALACTIC TRANSITION SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class _GalacticTransitionScreen extends StatefulWidget {
  const _GalacticTransitionScreen();
  @override
  State<_GalacticTransitionScreen> createState() =>
      _GalacticTransitionScreenState();
}

class _GalacticTransitionScreenState extends State<_GalacticTransitionScreen>
    with TickerProviderStateMixin {

  late final AnimationController _bgCtrl;
  late final AnimationController _planetCtrl;
  late final AnimationController _floatCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _moonCtrl;
  late final AnimationController _starsCtrl;
  late final AnimationController _shootCtrl;
  late final AnimationController _textCtrl;
  late final AnimationController _dividerCtrl;
  late final AnimationController _countdownCtrl;
  late final AnimationController _rippleCtrl;
  late final AnimationController _progressCtrl;

  late final Animation<double> _bgFade;
  late final Animation<double> _planetScale;
  late final Animation<double> _planetOpacity;
  late final Animation<double> _floatY;
  late final Animation<double> _floatR;
  late final Animation<double> _glow;
  late final Animation<double> _moonAngle;
  late final Animation<double> _titleOpacity;
  late final Animation<double> _titleSlide;
  late final Animation<double> _subtitleOpacity;
  late final Animation<double> _dividerOpacity;
  late final Animation<double> _dividerScale;
  late final Animation<double> _rippleScale;
  late final Animation<double> _rippleOpacity;
  late final Animation<double> _progress;

  int _countdownValue = 3;
  bool _cdVisible = false;

  // [xFrac, yFrac, radius, twinkleSpeed, phase, isCross]
  static const List<List<double>> _starData = [
    [.06,.04,1.0,2.3,.0,0],[.22,.07,.8,2.8,.4,0],[.48,.03,1.1,2.1,.7,0],
    [.71,.06,.7,3.0,1.0,0],[.89,.04,1.0,2.5,.2,0],[.13,.14,.6,2.7,.5,0],
    [.37,.11,.8,2.2,.9,0],[.60,.08,1.0,3.1,.3,0],[.82,.13,.6,2.0,.6,0],
    [.94,.17,.7,2.6,1.1,0],[.05,.22,.8,2.4,.8,0],[.29,.25,1.0,3.2,.1,0],
    [.54,.19,.6,2.9,.4,0],[.76,.23,.8,2.1,.7,0],[.91,.28,.5,2.7,1.2,0],
    [.08,.70,.7,2.5,.3,0],[.24,.74,1.0,2.3,.6,0],[.49,.78,.6,3.0,.9,0],
    [.68,.72,.8,2.8,.2,0],[.85,.76,.5,2.2,.5,0],[.16,.82,.6,2.6,.8,0],
    [.42,.86,.8,2.4,1.1,0],[.63,.90,.5,3.1,.4,0],[.79,.88,.7,2.0,.7,0],
    [.33,.05,3.5,2.6,.4,1],[.88,.19,4.0,3.0,.9,1],[.11,.77,3.5,2.8,1.2,1],
    [.56,.92,4.0,2.5,.6,1],[.77,.44,3.0,3.2,.3,1],
  ];

  @override
  void initState() {
    super.initState();

    _bgCtrl = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _bgFade = CurvedAnimation(parent: _bgCtrl, curve: Curves.easeOut);
    _bgCtrl.forward();

    _planetCtrl = AnimationController(
        duration: const Duration(milliseconds: 900), vsync: this);
    _planetScale = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _planetCtrl, curve: Curves.elasticOut));
    _planetOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _planetCtrl,
            curve: const Interval(0, 0.4, curve: Curves.easeIn)));
    Future.delayed(const Duration(milliseconds: 150),
        () { if (mounted) _planetCtrl.forward(); });

    _floatCtrl = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this)
      ..repeat();
    _floatY = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: -6.0)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 33),
      TweenSequenceItem(
          tween: Tween(begin: -6.0, end: -9.0)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 33),
      TweenSequenceItem(
          tween: Tween(begin: -9.0, end: 0.0)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 34),
    ]).animate(_floatCtrl);
    _floatR = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: -2 * math.pi / 180)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 33),
      TweenSequenceItem(
          tween: Tween(begin: -2 * math.pi / 180, end: 2 * math.pi / 180)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 33),
      TweenSequenceItem(
          tween: Tween(begin: 2 * math.pi / 180, end: 0.0)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 34),
    ]).animate(_floatCtrl);

    _glowCtrl = AnimationController(
        duration: const Duration(milliseconds: 3200), vsync: this)
      ..repeat(reverse: true);
    _glow = Tween<double>(begin: 0.20, end: 0.45).animate(
        CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));

    _moonCtrl = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this)
      ..repeat();
    _moonAngle = Tween<double>(begin: 0, end: 2 * math.pi).animate(_moonCtrl);

    _starsCtrl = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this)
      ..repeat();

    _shootCtrl = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this)
      ..repeat();

    _dividerCtrl = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _dividerOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _dividerCtrl, curve: Curves.easeOut));
    _dividerScale = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _dividerCtrl, curve: Curves.easeOut));

    _textCtrl = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    _titleOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut));
    _titleSlide = Tween<double>(begin: 20, end: 0).animate(
        CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut));
    _subtitleOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _textCtrl,
            curve: const Interval(0.4, 1.0, curve: Curves.easeOut)));
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) { _dividerCtrl.forward(); _textCtrl.forward(); }
    });

    _rippleCtrl = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    _rippleScale = Tween<double>(begin: 0.8, end: 1.9).animate(
        CurvedAnimation(parent: _rippleCtrl, curve: Curves.easeOut));
    _rippleOpacity = Tween<double>(begin: 0.6, end: 0.0).animate(
        CurvedAnimation(parent: _rippleCtrl, curve: Curves.easeOut));

    _progressCtrl = AnimationController(
        duration: const Duration(milliseconds: 4800), vsync: this);
    _progress = CurvedAnimation(parent: _progressCtrl, curve: Curves.linear);
    Future.delayed(const Duration(milliseconds: 700),
        () { if (mounted) _progressCtrl.forward(); });

    _countdownCtrl = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    _startCountdown();
  }

  Future<void> _startCountdown() async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() { _cdVisible = true; _countdownValue = 3; });
    _countdownCtrl.forward(from: 0);
    _rippleCtrl.forward(from: 0);
    for (int i = 2; i >= 0; i--) {
      await Future.delayed(const Duration(milliseconds: 950));
      if (!mounted) return;
      setState(() => _countdownValue = i);
      _countdownCtrl.forward(from: 0);
      _rippleCtrl.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _bgCtrl.dispose();
    _planetCtrl.dispose();
    _floatCtrl.dispose();
    _glowCtrl.dispose();
    _moonCtrl.dispose();
    _starsCtrl.dispose();
    _shootCtrl.dispose();
    _textCtrl.dispose();
    _dividerCtrl.dispose();
    _countdownCtrl.dispose();
    _rippleCtrl.dispose();
    _progressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: FadeTransition(
        opacity: _bgFade,
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(-0.3, -0.4),
              radius: 1.5,
              colors: [
                Color(0xFF060D1F),
                Color(0xFF030810),
                Color(0xFF020610),
                Color(0xFF010308),
              ],
              stops: [0.0, 0.4, 0.75, 1.0],
            ),
          ),
          child: Stack(children: [

            // Milky Way band
            Positioned.fill(
              child: Transform.rotate(
                angle: -15 * math.pi / 180,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Color(0x04102060),
                        Color(0x061428A0),
                        Color(0x04102060),
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.25, 0.42, 0.62, 1.0],
                    ),
                  ),
                ),
              ),
            ),

            // Nebulae
            _GalacticNebula(
              color: const Color(0xFF0A1964),
              alignment: const Alignment(-1.0, -0.85),
              size: 380,
            ),
            _GalacticNebula(
              color: const Color(0xFF052882),
              alignment: const Alignment(1.0, 0.80),
              size: 280,
              delayMs: 2500,
            ),
            _GalacticNebula(
              color: const Color(0xFF140A78),
              alignment: const Alignment(0.75, 0.15),
              size: 200,
              delayMs: 4500,
            ),

            // Star field + shooting star
            AnimatedBuilder(
              animation: Listenable.merge([_starsCtrl, _shootCtrl]),
              builder: (_, __) => CustomPaint(
                painter: _GalacticStarPainter(
                  starData: _starData,
                  starsT: _starsCtrl.value,
                  shootT: _shootCtrl.value,
                ),
                size: size,
              ),
            ),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Planet
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _planetCtrl, _floatCtrl, _glowCtrl, _moonCtrl,
                    ]),
                    builder: (_, __) {
                      final floatY =
                          _planetCtrl.isCompleted ? _floatY.value : 0.0;
                      final floatR =
                          _planetCtrl.isCompleted ? _floatR.value : 0.0;
                      return Transform.translate(
                        offset: Offset(0, floatY),
                        child: Transform.rotate(
                          angle: floatR,
                          child: FadeTransition(
                            opacity: _planetOpacity,
                            child: ScaleTransition(
                              scale: _planetScale,
                              child: SizedBox(
                                width: 140,
                                height: 140,
                                child: CustomPaint(
                                  painter: _PlanetPainter(
                                    glowIntensity: _glow.value,
                                    moonAngle: _moonAngle.value,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Divider
                  AnimatedBuilder(
                    animation: _dividerCtrl,
                    builder: (_, __) => Opacity(
                      opacity: _dividerOpacity.value,
                      child: Transform.scale(
                        scaleX: _dividerScale.value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 44),
                          child: Row(children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: const Color(0xFF5090FF).withOpacity(0.35),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.star_rounded,
                                color: Color(0xFF6498FF), size: 13),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: const Color(0xFF5090FF).withOpacity(0.35),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Title
                  AnimatedBuilder(
                    animation: _textCtrl,
                    builder: (_, __) => Transform.translate(
                      offset: Offset(0, _titleSlide.value),
                      child: Opacity(
                        opacity: _titleOpacity.value,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            "Time to test your referential\ninferences! 🕵️‍♂️🔍💥",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFDDEEFF),
                              height: 1.35,
                              letterSpacing: 0.2,
                              shadows: [
                                Shadow(
                                  blurRadius: 24,
                                  color: Color(0x884878FF),
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Subtitle
                  AnimatedBuilder(
                    animation: _textCtrl,
                    builder: (_, __) => Opacity(
                      opacity: _subtitleOpacity.value,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "Let's see if you can track the clues like a pro detective!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF7A9FCC),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Countdown
                  if (_cdVisible)
                    AnimatedBuilder(
                      animation:
                          Listenable.merge([_countdownCtrl, _rippleCtrl]),
                      builder: (_, __) {
                        final scaleVal = Tween<double>(begin: 1.5, end: 1.0)
                            .animate(CurvedAnimation(
                                parent: _countdownCtrl,
                                curve: Curves.elasticOut))
                            .value;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(alignment: Alignment.center, children: [
                              // Ripple
                              Transform.scale(
                                scale: _rippleScale.value,
                                child: Container(
                                  width: 72,
                                  height: 72,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFF6498FF)
                                          .withOpacity(_rippleOpacity.value),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                              // Outer ring
                              Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF5090FF)
                                        .withOpacity(0.35),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              // Inner
                              Transform.scale(
                                scale: scaleVal,
                                child: Container(
                                  width: 54,
                                  height: 54,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const RadialGradient(colors: [
                                      Color(0x333C78E0),
                                      Color(0x660A1A50),
                                    ]),
                                    border: Border.all(
                                      color: const Color(0xFF6498FF)
                                          .withOpacity(0.55),
                                      width: 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF5090FF)
                                            .withOpacity(0.25),
                                        blurRadius: 18,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      _countdownValue > 0
                                          ? '$_countdownValue'
                                          : '✦',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF7ABAFF),
                                        shadows: [
                                          Shadow(
                                            blurRadius: 12,
                                            color: Color(0x996498FF),
                                            offset: Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                            const SizedBox(width: 14),
                            // Dots
                            Column(
                              children: List.generate(3, (i) {
                                final active = i < _countdownValue;
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  width: 7,
                                  height: 7,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: active
                                        ? const Color(0xFF7ABAFF)
                                        : const Color(0xFF1A2A50),
                                    border: Border.all(
                                      color: const Color(0xFF4070CC)
                                          .withOpacity(0.5),
                                      width: 1,
                                    ),
                                    boxShadow: active
                                        ? [
                                            const BoxShadow(
                                              color: Color(0x886498FF),
                                              blurRadius: 8,
                                              spreadRadius: 1,
                                            )
                                          ]
                                        : null,
                                  ),
                                );
                              }),
                            ),
                          ],
                        );
                      },
                    ),

                  const SizedBox(height: 26),

                  // Progress bar
                  AnimatedBuilder(
                    animation: _progressCtrl,
                    builder: (_, __) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Column(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: Stack(children: [
                            Container(
                              height: 3,
                              width: double.infinity,
                              color: const Color(0xFF0D1830),
                            ),
                            FractionallySizedBox(
                              widthFactor: _progress.value,
                              child: Container(
                                height: 3,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xFF5090FF),
                                    Color(0xFF8CBCFF),
                                  ]),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          "LOADING SECTION II",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0x558CB8FF),
                            letterSpacing: 1.8,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

// ── Planet painter ────────────────────────────────────────────────────────────
class _PlanetPainter extends CustomPainter {
  final double glowIntensity;
  final double moonAngle;

  const _PlanetPainter({required this.glowIntensity, required this.moonAngle});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final scl = size.width / 140;
    final pr = 42 * scl;

    // Outer ambient glow
    canvas.drawCircle(
      Offset(cx, cy), 70 * scl,
      Paint()
        ..shader = ui.Gradient.radial(
          Offset(cx, cy), 70 * scl,
          [
            Color.fromRGBO(48, 96, 208, glowIntensity * 0.35),
            const Color(0x003060D0),
          ],
        ),
    );

    // Inner glow
    canvas.drawCircle(
      Offset(cx, cy), 52 * scl,
      Paint()
        ..shader = ui.Gradient.radial(
          Offset(cx, cy), 52 * scl,
          [
            Color.fromRGBO(32, 80, 192, glowIntensity * 0.5),
            const Color(0x002050C0),
          ],
        ),
    );

    // Planet face
    canvas.drawCircle(
      Offset(cx, cy), pr,
      Paint()
        ..shader = ui.Gradient.radial(
          Offset(cx - pr * 0.35, cy - pr * 0.35),
          pr * 1.4,
          const [Color(0xFF4080E0), Color(0xFF1A4098), Color(0xFF0C1E52)],
          [0.0, 0.55, 1.0],
        ),
    );

    // Planet shadow overlay
    canvas.drawCircle(
      Offset(cx + pr * 0.3, cy + pr * 0.2),
      pr,
      Paint()..color = const Color(0x440A1040),
    );

    // Craters
    final craterPaint = Paint()..color = const Color(0x16FFFFFF);
    canvas.drawCircle(
        Offset(cx - pr * 0.28, cy - pr * 0.22), scl * 7, craterPaint);
    canvas.drawCircle(
        Offset(cx + pr * 0.15, cy - pr * 0.30), scl * 4.5, craterPaint);
    canvas.drawCircle(
        Offset(cx - pr * 0.10, cy + pr * 0.32), scl * 3.5, craterPaint);

    // Ring (back half)
    final ringW = pr * 3.2 * scl;
    final ringH = pr * 0.65 * scl;
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, cy), width: ringW, height: ringH),
      Paint()
        ..color = const Color(0xFF8CBCFF).withOpacity(0.28)
        ..style = PaintingStyle.stroke
        ..strokeWidth = scl * 2.5,
    );

    // Re-draw planet face to occlude front of ring
    canvas.drawCircle(
      Offset(cx, cy), pr,
      Paint()
        ..shader = ui.Gradient.radial(
          Offset(cx - pr * 0.35, cy - pr * 0.35),
          pr * 1.4,
          const [Color(0xFF4080E0), Color(0xFF1A4098), Color(0xFF0C1E52)],
          [0.0, 0.55, 1.0],
        ),
    );

    // Moon
    final moonOrbitR = pr * 1.65;
    final moonX = cx + math.cos(moonAngle) * moonOrbitR;
    final moonY = cy + math.sin(moonAngle) * moonOrbitR * 0.32;
    final moonR = scl * 7;
    canvas.drawCircle(
      Offset(moonX, moonY), moonR,
      Paint()
        ..shader = ui.Gradient.radial(
          Offset(moonX - moonR * 0.3, moonY - moonR * 0.3),
          moonR * 1.2,
          const [Color(0xFFCCCCCC), Color(0xFF666666)],
        ),
    );
  }

  @override
  bool shouldRepaint(covariant _PlanetPainter o) =>
      o.glowIntensity != glowIntensity || o.moonAngle != moonAngle;
}

// ── Nebula widget ─────────────────────────────────────────────────────────────
class _GalacticNebula extends StatefulWidget {
  final Color color;
  final Alignment alignment;
  final double size;
  final int delayMs;

  const _GalacticNebula({
    required this.color,
    required this.alignment,
    required this.size,
    this.delayMs = 0,
  });

  @override
  State<_GalacticNebula> createState() => _GalacticNebulaState();
}

class _GalacticNebulaState extends State<_GalacticNebula>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _opacity, _scale;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
        duration: const Duration(milliseconds: 9000), vsync: this)
      ..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.06, end: 0.16).animate(
        CurvedAnimation(parent: _c, curve: Curves.easeInOut));
    _scale = Tween<double>(begin: 1.0, end: 1.08).animate(
        CurvedAnimation(parent: _c, curve: Curves.easeInOut));
    if (widget.delayMs > 0) {
      _c.value = (widget.delayMs / 9000.0).clamp(0.0, 1.0);
    }
  }

  @override
  void dispose() { _c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: widget.alignment,
        child: AnimatedBuilder(
          animation: _c,
          builder: (_, __) => Opacity(
            opacity: _opacity.value,
            child: Transform.scale(
              scale: _scale.value,
              child: Container(
                width: widget.size,
                height: widget.size * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.size),
                  gradient: RadialGradient(colors: [
                    widget.color.withOpacity(1),
                    widget.color.withOpacity(0),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Star field + shooting star painter ───────────────────────────────────────
class _GalacticStarPainter extends CustomPainter {
  final List<List<double>> starData;
  final double starsT;
  final double shootT;

  const _GalacticStarPainter({
    required this.starData,
    required this.starsT,
    required this.shootT,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final t = starsT * 4.0;

    for (final s in starData) {
      final alpha =
          (0.25 + 0.65 * (0.5 + 0.5 * math.sin(t * s[3] + s[4]))).clamp(0.0, 1.0);
      final x = s[0] * w;
      final y = s[1] * h;
      final r = s[2];
      final isCross = s[5].toInt() == 1;

      if (isCross) {
        final p = Paint()
          ..color = Color.fromRGBO(100, 152, 255, alpha)
          ..strokeWidth = 1.0
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(Offset(x - r, y), Offset(x + r, y), p);
        canvas.drawLine(Offset(x, y - r), Offset(x, y + r), p);
      } else {
        canvas.drawCircle(
          Offset(x, y),
          r,
          Paint()..color = Color.fromRGBO(220, 230, 255, alpha),
        );
      }
    }

    // Shooting star
    const cycle = 5.0;
    final elapsed = (shootT * cycle) % cycle;
    const fireAt = 2.0;
    const fireDur = 1.4;
    if (elapsed >= fireAt && elapsed <= fireAt + fireDur) {
      final prog = ((elapsed - fireAt) / fireDur).clamp(0.0, 1.0);
      final sx = w * 0.15;
      final sy = h * 0.10;
      final dx = prog * 200.0;
      final dy = prog * 80.0;
      final op =
          prog < 0.1 ? prog / 0.1 : prog > 0.8 ? (1 - prog) / 0.2 : 1.0;
      final grad = ui.Gradient.linear(
        Offset(sx + dx, sy + dy),
        Offset(sx + dx - 110, sy + dy - 50),
        [
          Color.fromRGBO(150, 200, 255, op * 0.85),
          const Color(0x00A0C8FF),
        ],
      );
      canvas.drawLine(
        Offset(sx + dx, sy + dy),
        Offset(sx + dx - 110, sy + dy - 50),
        Paint()
          ..shader = grad
          ..strokeWidth = 1.5
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GalacticStarPainter o) =>
      o.starsT != starsT || o.shootT != shootT;
}

// ═══════════════════════════════════════════════════════════════════════════════
//  FINAL PATH
// ═══════════════════════════════════════════════════════════════════════════════


// ─── Particle model ───────────────────────────────────────────────────────────
class _Star {
  late double x, y, size, opacity, speed;
  _Star(Random rng, Size screen) {
    _randomize(rng, screen, initial: true);
  }
  void _randomize(Random rng, Size screen, {bool initial = false}) {
    x = rng.nextDouble() * screen.width;
    y = initial
        ? rng.nextDouble() * screen.height
        : -10.0;
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
  final double twinkle; // 0→1, drives pulsing opacity
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
  final double progress; // 0→1
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
  late AnimationController _starController;   // drives twinkle + star drift
  late AnimationController _shootController;  // drives shooting star
  late AnimationController _nebulaController; // slow nebula pulse

  final Random _rng = Random();
  List<_Star> _stars = [];
  Size _screenSize = Size.zero;

  // shooting star path (randomised each cycle)
  Offset _ssStart = Offset.zero;
  Offset _ssEnd = Offset.zero;

  // ── glow for score text ──
  late AnimationController _glowController;
  late Animation<double> _glowAnim;

Future<void> _completeFinalLevel(BuildContext context) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  // ── progreso existente (sin cambios) ──
  await FirebaseFirestore.instance
      .collection('userProgress')
      .doc(user.uid)
      .set({'completedCheckpoint2': true}, SetOptions(merge: true));

  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('completedCheckpoint2', true);

  // ── NUEVO: guardar medalla Lexical Linker con fecha ──
  await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('medals')
      .doc('Lexical Linker')
      .set({
    'unlockedAt': FieldValue.serverTimestamp(),
  }, SetOptions(merge: true));

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
        .set(
            {'completedSpotsCount': FieldValue.increment(1)},
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
    _medalOffset =
        Tween<Offset>(begin: const Offset(0, -2), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _dropController, curve: Curves.easeOutBack));
    _floatController = AnimationController(
        vsync: this, duration: const Duration(seconds: 2));
    _floatAnimation = Tween<double>(begin: 0, end: 10).animate(
        CurvedAnimation(parent: _floatController, curve: Curves.easeInOut));

    Future.delayed(const Duration(milliseconds: 300), () {
      _dropController.forward().whenComplete(() {
        setState(() => showMessage = true);
        _floatController.repeat(reverse: true);
      });
    });

    // ── starfield (twinkle) ──
    _starController = AnimationController(
        vsync: this, duration: const Duration(seconds: 3))
      ..repeat();

    // ── shooting star every ~5 s ──
    _shootController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed) {
          Future.delayed(
              Duration(milliseconds: 3500 + _rng.nextInt(3000)), () {
            if (!mounted) return;
            _randomizeShootingStar();
            _shootController.forward(from: 0);
          });
        }
      });

    // ── nebula pulse ──
    _nebulaController = AnimationController(
        vsync: this, duration: const Duration(seconds: 6))
      ..repeat(reverse: true);

    // ── score glow ──
    _glowController = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
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

  // called once we know the screen size
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
            // ── deep space gradient background ──
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF020818),
                    Color(0xFF050D2A),
                    Color(0xFF0A0F3D),
                    Color(0xFF060518),
                  ],
                  stops: [0.0, 0.3, 0.7, 1.0],
                ),
              ),
            ),

            // ── nebula blobs ──
            AnimatedBuilder(
              animation: _nebulaController,
              builder: (_, __) {
                final t = _nebulaController.value;
                return CustomPaint(
                  size: size,
                  painter: _NebulaPainter(t),
                );
              },
            ),

            // ── starfield ──
            AnimatedBuilder(
              animation: _starController,
              builder: (_, __) {
                // tick stars
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

                        // title text with glow
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
                                    color: const Color(0xFF56CCCE)
                                        .withOpacity(0.15),
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
                                  color: const Color(0xFF56CCCE)
                                      .withOpacity(0.25),
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                'You did it! You\'ve passed the final test\nand finished strong! 🌟🎓👏',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFB8F0F2),
                                  height: 1.45,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // score with glowing number
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
                                    color: Color(0xFF8ECFFF),
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
                                        color: const Color(0xFF56CCCE),
                                        blurRadius: _glowAnim.value,
                                      ),
                                    ],
                                  ),
                                ),
                                const TextSpan(
                                  text: '  points ✨',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF8ECFFF),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // cosmic button
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
                              // glow halo behind medal
                              AnimatedBuilder(
                                animation: _glowAnim,
                                builder: (_, __) => Container(
                                  width: 220,
                                  height: 220,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF56CCCE)
                                            .withOpacity(0.25),
                                        blurRadius: _glowAnim.value * 3,
                                        spreadRadius: _glowAnim.value,
                                      ),
                                      BoxShadow(
                                        color: const Color(0xFFAA88FF)
                                            .withOpacity(0.15),
                                        blurRadius: _glowAnim.value * 5,
                                        spreadRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(children: [
                                Image.asset(
                                  'assets/Medals/2. Lexical Linker.png',
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

// ─── Nebula painter ────────────────────────────────────────────────────────────
class _NebulaPainter extends CustomPainter {
  final double t;
  _NebulaPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..isAntiAlias = true;

    // blob 1 – teal/cyan top-left
    final r1 = 180.0 + sin(t * pi) * 20;
    paint.shader = RadialGradient(colors: [
      const Color(0xFF0D8A9E).withOpacity(0.18),
      Colors.transparent,
    ]).createShader(
      Rect.fromCircle(
          center: Offset(size.width * 0.15, size.height * 0.18), radius: r1),
    );
    canvas.drawCircle(
        Offset(size.width * 0.15, size.height * 0.18), r1, paint);

    // blob 2 – purple bottom-right
    final r2 = 220.0 + cos(t * pi) * 25;
    paint.shader = RadialGradient(colors: [
      const Color(0xFF6B3FA0).withOpacity(0.15),
      Colors.transparent,
    ]).createShader(
      Rect.fromCircle(
          center: Offset(size.width * 0.85, size.height * 0.75), radius: r2),
    );
    canvas.drawCircle(
        Offset(size.width * 0.85, size.height * 0.75), r2, paint);

    // blob 3 – deep blue center
    final r3 = 150.0 + sin(t * pi * 1.3) * 15;
    paint.shader = RadialGradient(colors: [
      const Color(0xFF1A3A8A).withOpacity(0.2),
      Colors.transparent,
    ]).createShader(
      Rect.fromCircle(
          center: Offset(size.width * 0.5, size.height * 0.5), radius: r3),
    );
    canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.5), r3, paint);
  }

  @override
  bool shouldRepaint(_NebulaPainter old) => t != old.t;
}

// ─── Cosmic animated button ───────────────────────────────────────────────────
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
    _pulse = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
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
          padding:
              const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1BBABD), Color(0xFF56CCCE), Color(0xFF0E8FA0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF56CCCE).withOpacity(0.45),
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
          child: Text(
            widget.label,
            style: const TextStyle(
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