import 'package:flutter/material.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_3/Instruction_Spot3_1.dart';

class InstructionSpotLoaderPage3_1 extends StatefulWidget {
  final String title;
  final List<String> instructions;
  final String tipTitle;
  final List<String> tips;
  final String finalNote;

  const InstructionSpotLoaderPage3_1({
    super.key,
    required this.title,
    required this.instructions,
    required this.tipTitle,
    required this.tips,
    required this.finalNote, required String description,
  });

  @override
  State<InstructionSpotLoaderPage3_1> createState() =>
      _InstructionSpotLoaderPage3_1State();
}

class _InstructionSpotLoaderPage3_1State extends State<InstructionSpotLoaderPage3_1> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => InstructionSpotPage3_1(
            title: widget.title,
            instructions: widget.instructions,
            tipTitle: widget.tipTitle,
            tips: widget.tips,
            finalNote: widget.finalNote,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 252),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animación del ícono
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: Icon(
                Icons.auto_stories,
                size: 80,
                color: Color.fromARGB(255, 53, 13, 198)
              ),
            ),
            const SizedBox(height: 20),

            // Animación de texto
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(seconds: 2),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Some words in English don't tell you everything directly—you have to guess what they mean! It's like solving a fun puzzle! ❇️📚✨",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Indicador de carga
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}


class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => QuestionPage(questions: sampleQuestionsFinal),
        ),
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
      backgroundColor:
          const Color(0xFFBBDEFB), // Azul claro agradable de fondo
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: SlideTransition(
            position: _slide,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
              child: const Text(
                "Excited to practice and boost your skills? Let's dive in and have some fun! 🌟🚀",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 149, 255), // Blanco azulado para contraste
                  height: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}





class ButWhy extends StatefulWidget {
  const ButWhy({super.key});

  @override
  State<ButWhy> createState() => _ButWhyState();
}

class _ButWhyState extends State<ButWhy>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<Offset> _slide;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slide =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _fadeIn = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    _fadeController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ExplanationFirst()),
      );
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 205, 227, 253),
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: SlideTransition(
            position: _slide,
            child: const Text(
              "How to solve it?",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 12, 137, 193),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}


class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PracticePage()), //Cambiar a la actividad
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
      backgroundColor: const Color(0xFFE2F0FF),
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: SlideTransition(
            position: _slide,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Let’s practice more!✨\n\nDon’t hesitate to ask for help if you need it. 📘😇",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B77C1),
                  height: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Third extends StatefulWidget {
  const Third({super.key});

  @override
  State<Third> createState() => _ThirdState();
}

class _ThirdState extends State<Third> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => QuestionPageSecond(questions: sampleQuestionsSecond)), // Sustituye PracticePage por la clase a la que deseas ir
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
      backgroundColor: const Color(0xFFE2F0FF),
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: SlideTransition(
            position: _slide,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Great start—now double down and go even harder! 🎲⚡📈",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B77C1),
                  height: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ButWhy2 extends StatefulWidget {
  const ButWhy2({super.key});

  @override
  State<ButWhy2> createState() => _ButWhy2State();
}

class _ButWhy2State extends State<ButWhy2>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<Offset> _slide;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slide =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _fadeIn = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    _fadeController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ExplanationSecond()),
      );
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 205, 227, 253),
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: SlideTransition(
            position: _slide,
            child: const Text(
              "How to solve it?",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 12, 137, 193),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class SecondActyvityAnimation extends StatefulWidget {
  const SecondActyvityAnimation({super.key});

  @override
  State<SecondActyvityAnimation> createState() => _SecondActyvityAnimationState();
}

class _SecondActyvityAnimationState extends State<SecondActyvityAnimation> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PracticePageSecond()), // Cambia a tu pantalla destino
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
      backgroundColor: const Color(0xFFE2F0FF), // Fondo azul muy claro
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: SlideTransition(
            position: _slide,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Let’s practice more! 💡✨ Don’t hesitate to ask for help if you need it. 🧑‍🏫📘😇                                ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B77C1), // Azul principal
                  height: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class FinalPart1 extends StatefulWidget {
  const FinalPart1({super.key});

  @override
  State<FinalPart1> createState() => _FinalPart1State();
}

class _FinalPart1State extends State<FinalPart1> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const FinalPartSummary()), // Cambia si lo necesitas
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
      backgroundColor: const Color(0xFFE0F3FF), // Fondo azul claro
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: SlideTransition(
            position: _slide,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "🌌 Great work! The more you connect actions with motives, the easier it gets to spot what characters are really trying to do! 💙🔍",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0D6EBA), // Azul fuerte
                  height: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


