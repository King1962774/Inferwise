import 'package:flutter/material.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_2/Instruction_Spot2_3.dart';

// ─────────────────────────────────────────────
// Aquamarine shared palette
// ─────────────────────────────────────────────

const Color _aqua1 = Color(0xFF00BCD4);
const Color _aqua2 = Color(0xFF00897B);
const Color _aqua3 = Color(0xFF26C6DA);
const Color _aqua5 = Color(0xFF1DE9B6);
const Color _bgLight = Color(0xFFE0F7FA);

// ─────────────────────────────────────────────
// Shared mixin for aquamarine background + pulsing icon
// ─────────────────────────────────────────────

mixin _AquaAnimMixin<T extends StatefulWidget>
    on State<T>, TickerProviderStateMixin<T> {
  late AnimationController bgController;
  late AnimationController iconController;
  late Animation<Color?> color1;
  late Animation<Color?> color2;
  late Animation<double> iconScale;
  late Animation<double> iconOpacity;

  void initAquaAnims() {
    bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    color1 = ColorTween(begin: _aqua1, end: _aqua5).animate(
      CurvedAnimation(parent: bgController, curve: Curves.easeInOut),
    );
    color2 = ColorTween(begin: _aqua2, end: _aqua3).animate(
      CurvedAnimation(parent: bgController, curve: Curves.easeInOut),
    );

    iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    iconScale = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: iconController, curve: Curves.easeInOut),
    );
    iconOpacity = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: iconController, curve: Curves.easeInOut),
    );
  }

  void disposeAquaAnims() {
    bgController.dispose();
    iconController.dispose();
  }

  Widget buildAquaBg({required Widget child}) {
    return AnimatedBuilder(
      animation: bgController,
      builder: (context, inner) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _bgLight,
                color1.value ?? _aqua1,
                color2.value ?? _aqua2,
              ],
            ),
          ),
          child: inner,
        );
      },
      child: child,
    );
  }

  Widget buildPulsingIcon(IconData icon) {
    return AnimatedBuilder(
      animation: iconController,
      builder: (context, _) {
        return Transform.scale(
          scale: iconScale.value,
          child: Opacity(
            opacity: iconOpacity.value,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.25),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00E5FF)
                        .withOpacity(0.4 * iconOpacity.value),
                    blurRadius: 30 * iconScale.value,
                    spreadRadius: 8 * iconScale.value,
                  ),
                ],
              ),
              child: Icon(icon, size: 72, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// InstructionSpotLoaderPage2_3
// ─────────────────────────────────────────────

class InstructionSpotLoaderPage2_3 extends StatefulWidget {
  final String title;
  final List<String> instructions;
  final String tipTitle;
  final List<String> tips;
  final String finalNote;

  const InstructionSpotLoaderPage2_3({
    super.key,
    required this.title,
    required this.instructions,
    required this.tipTitle,
    required this.tips,
    required this.finalNote,
    required String description,
  });

  @override
  State<InstructionSpotLoaderPage2_3> createState() =>
      _InstructionSpotLoaderPage2_3State();
}

class _InstructionSpotLoaderPage2_3State
    extends State<InstructionSpotLoaderPage2_3>
    with TickerProviderStateMixin, _AquaAnimMixin {
  late AnimationController _textController;
  late Animation<double> _textOpacity;

  @override
  void initState() {
    super.initState();
    initAquaAnims();

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => InstructionSpotPage5(
              title: widget.title,
              instructions: widget.instructions,
              tipTitle: widget.tipTitle,
              tips: widget.tips,
              finalNote: widget.finalNote,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    disposeAquaAnims();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildAquaBg(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildPulsingIcon(Icons.auto_stories),
              const SizedBox(height: 32),
              FadeTransition(
                opacity: _textOpacity,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "Some words in English are like secret agents—you've got to use context clues to crack their code! 🕵️‍♂️🔍✨",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      height: 1.6,
                      shadows: [Shadow(color: Colors.black26, blurRadius: 4)],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withOpacity(0.9)),
                  strokeWidth: 3,
                  backgroundColor: Colors.white.withOpacity(0.2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Start
// ─────────────────────────────────────────────

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start>
    with TickerProviderStateMixin, _AquaAnimMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    initAquaAnims();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slide = Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => QuestionPage(questions: sampleQuestionsFinal),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    disposeAquaAnims();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildAquaBg(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildPulsingIcon(Icons.menu_book_rounded),
              const SizedBox(height: 36),
              FadeTransition(
                opacity: _fadeIn,
                child: SlideTransition(
                  position: _slide,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Let's dive into some practice exercises and give your brain a fun rollercoaster ride! 🎢🧠😱",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.5,
                        shadows: [Shadow(color: Colors.black26, blurRadius: 4)],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withOpacity(0.9)),
                  strokeWidth: 3,
                  backgroundColor: Colors.white.withOpacity(0.2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ButWhy
// ─────────────────────────────────────────────

class ButWhy extends StatefulWidget {
  const ButWhy({super.key});

  @override
  State<ButWhy> createState() => _ButWhyState();
}

class _ButWhyState extends State<ButWhy>
    with TickerProviderStateMixin, _AquaAnimMixin {
  late AnimationController _fadeController;
  late Animation<Offset> _slide;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    initAquaAnims();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _slide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));
    _fadeIn = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
    _fadeController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ExplanationFirst()),
        );
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    disposeAquaAnims();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildAquaBg(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildPulsingIcon(Icons.help_outline_rounded),
              const SizedBox(height: 32),
              FadeTransition(
                opacity: _fadeIn,
                child: SlideTransition(
                  position: _slide,
                  child: const Text(
                    "How to solve it?",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [Shadow(color: Colors.black26, blurRadius: 4)],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Second
// ─────────────────────────────────────────────

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second>
    with TickerProviderStateMixin, _AquaAnimMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    initAquaAnims();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _slide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const PracticePage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    disposeAquaAnims();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildAquaBg(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildPulsingIcon(Icons.auto_stories_rounded),
              const SizedBox(height: 32),
              FadeTransition(
                opacity: _fadeIn,
                child: SlideTransition(
                  position: _slide,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Let's practice more!✨\n\nDon't hesitate to ask for help if you need it. 📘😇",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.5,
                        shadows: [Shadow(color: Colors.black26, blurRadius: 4)],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Third
// ─────────────────────────────────────────────

class Third extends StatefulWidget {
  const Third({super.key});

  @override
  State<Third> createState() => _ThirdState();
}

class _ThirdState extends State<Third>
    with TickerProviderStateMixin, _AquaAnimMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    initAquaAnims();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _slide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                QuestionPageSecond(questions: sampleQuestionsSecond),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    disposeAquaAnims();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildAquaBg(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildPulsingIcon(Icons.trending_up_rounded),
              const SizedBox(height: 32),
              FadeTransition(
                opacity: _fadeIn,
                child: SlideTransition(
                  position: _slide,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Round 2 is here—let's build on that momentum! 🚴‍♂️📈💡",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.5,
                        shadows: [Shadow(color: Colors.black26, blurRadius: 4)],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ButWhy2
// ─────────────────────────────────────────────

class ButWhy2 extends StatefulWidget {
  const ButWhy2({super.key});

  @override
  State<ButWhy2> createState() => _ButWhy2State();
}

class _ButWhy2State extends State<ButWhy2>
    with TickerProviderStateMixin, _AquaAnimMixin {
  late AnimationController _fadeController;
  late Animation<Offset> _slide;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    initAquaAnims();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _slide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));
    _fadeIn = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
    _fadeController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ExplanationSecond()),
        );
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    disposeAquaAnims();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildAquaBg(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildPulsingIcon(Icons.help_outline_rounded),
              const SizedBox(height: 32),
              FadeTransition(
                opacity: _fadeIn,
                child: SlideTransition(
                  position: _slide,
                  child: const Text(
                    "How to solve it?",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [Shadow(color: Colors.black26, blurRadius: 4)],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SecondActyvityAnimation
// ─────────────────────────────────────────────

class SecondActyvityAnimation extends StatefulWidget {
  const SecondActyvityAnimation({super.key});

  @override
  State<SecondActyvityAnimation> createState() =>
      _SecondActyvityAnimationState();
}

class _SecondActyvityAnimationState extends State<SecondActyvityAnimation>
    with TickerProviderStateMixin, _AquaAnimMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    initAquaAnims();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _slide = Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const PracticePageSecond()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    disposeAquaAnims();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildAquaBg(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildPulsingIcon(Icons.lightbulb_rounded),
              const SizedBox(height: 32),
              FadeTransition(
                opacity: _fadeIn,
                child: SlideTransition(
                  position: _slide,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Let's practice more! 💡✨ Don't hesitate to ask for help if you need it. 🧑‍🏫📘😇",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.5,
                        shadows: [Shadow(color: Colors.black26, blurRadius: 4)],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Four
// ─────────────────────────────────────────────

class Four extends StatefulWidget {
  const Four({super.key});

  @override
  State<Four> createState() => _FourState();
}

class _FourState extends State<Four>
    with TickerProviderStateMixin, _AquaAnimMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    initAquaAnims();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slide = Tween<Offset>(begin: const Offset(0, 0.35), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart));
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                QuestionPageThird(questions: sampleQuestionsThird),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    disposeAquaAnims();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildAquaBg(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildPulsingIcon(Icons.crisis_alert_rounded),
              const SizedBox(height: 32),
              FadeTransition(
                opacity: _fadeIn,
                child: SlideTransition(
                  position: _slide,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Third time's the charm—let's crush this! 💥🔢🎯",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.5,
                        shadows: [Shadow(color: Colors.black26, blurRadius: 4)],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ButWhy3
// ─────────────────────────────────────────────

class ButWhy3 extends StatefulWidget {
  const ButWhy3({super.key});

  @override
  State<ButWhy3> createState() => _ButWhy3State();
}

class _ButWhy3State extends State<ButWhy3>
    with TickerProviderStateMixin, _AquaAnimMixin {
  late AnimationController _fadeController;
  late Animation<Offset> _slide;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    initAquaAnims();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _slide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));
    _fadeIn = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
    _fadeController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ExplanationThird()),
        );
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    disposeAquaAnims();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildAquaBg(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildPulsingIcon(Icons.help_outline_rounded),
              const SizedBox(height: 32),
              FadeTransition(
                opacity: _fadeIn,
                child: SlideTransition(
                  position: _slide,
                  child: const Text(
                    "How to solve it?",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [Shadow(color: Colors.black26, blurRadius: 4)],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ThirdActyvityAnimation
// ─────────────────────────────────────────────

class ThirdActyvityAnimation extends StatefulWidget {
  const ThirdActyvityAnimation({super.key});

  @override
  State<ThirdActyvityAnimation> createState() =>
      _ThirdActyvityAnimationState();
}

class _ThirdActyvityAnimationState extends State<ThirdActyvityAnimation>
    with TickerProviderStateMixin, _AquaAnimMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    initAquaAnims();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _slide = Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const PracticePageThird()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    disposeAquaAnims();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildAquaBg(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildPulsingIcon(Icons.lightbulb_rounded),
              const SizedBox(height: 32),
              FadeTransition(
                opacity: _fadeIn,
                child: SlideTransition(
                  position: _slide,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Let's practice more! 💡✨ Don't hesitate to ask for help if you need it. 🧑‍🏫📘😇",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.5,
                        shadows: [Shadow(color: Colors.black26, blurRadius: 4)],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// FinalPart1
// ─────────────────────────────────────────────

class FinalPart1 extends StatefulWidget {
  const FinalPart1({super.key});

  @override
  State<FinalPart1> createState() => _FinalPart1State();
}

class _FinalPart1State extends State<FinalPart1>
    with TickerProviderStateMixin, _AquaAnimMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    initAquaAnims();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const FinalPartSummary()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    disposeAquaAnims();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildAquaBg(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildPulsingIcon(Icons.emoji_events_rounded),
              const SizedBox(height: 32),
              FadeTransition(
                opacity: _fadeIn,
                child: SlideTransition(
                  position: _slide,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "You did amazing! The more you practice using context clues, the better you'll become! Keep up the fantastic work! 🌟🩵",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        height: 1.5,
                        shadows: [Shadow(color: Colors.black26, blurRadius: 4)],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}