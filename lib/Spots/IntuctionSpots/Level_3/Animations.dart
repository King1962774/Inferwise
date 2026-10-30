import 'dart:math';

import 'package:flutter/material.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_3/Instruction_Spot3.dart';

class InstructionSpotLoaderPage3 extends StatefulWidget {
  final String title;
  final List<String> instructions;
  final String tipTitle;
  final List<String> tips;
  final String finalNote;

  const InstructionSpotLoaderPage3({
    super.key,
    required this.title,
    required this.instructions,
    required this.tipTitle,
    required this.tips,
    required this.finalNote, required String description,
  });

  @override
  State<InstructionSpotLoaderPage3> createState() =>
      _InstructionSpotLoaderPage3State();
}

class _InstructionSpotLoaderPage3State extends State<InstructionSpotLoaderPage3> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => InstructionSpotPage3(
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
      backgroundColor: const Color.fromARGB(255, 211, 237, 255),
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
                color: Color.fromARGB(255, 11, 63, 205),
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 173, 216, 255), // Azul suave
              Color.fromARGB(255, 168, 196, 255), // Azul lavanda
              Color.fromARGB(255, 255, 168, 196), // Rosado suave
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeIn,
            child: SlideTransition(
              position: _slide,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  "Let's jump into some practice exercises and sharpen those skills! 📚💪✨",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 20, 60, 180), // Azul fuerte elegante
                    height: 1.5,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black26,
                        offset: Offset(1, 2),
                      ),
                    ],
                  ),
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

class _ButWhyState extends State<ButWhy> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fadeIn;
  late Animation<double> _scale;

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
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _fadeIn = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _scale = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ExplanationFirst()),
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
      backgroundColor: const Color.fromARGB(255, 225, 240, 255), // Azul muy suave
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: SlideTransition(
            position: _slide,
            child: ScaleTransition(
              scale: _scale,
              child: const Text(
                "How to solve it?",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 102, 204), // Azul intenso
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
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
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _scale = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PracticePage()),
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
            colors: [
              Color(0xFFB3E5FC), // Azul claro
              Color(0xFF81D4FA), // Azul intermedio
              Color(0xFF4FC3F7), // Azul más intenso
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeIn,
            child: SlideTransition(
              position: _slide,
              child: ScaleTransition(
                scale: _scale,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: const Text(
                    "Let’s practice more.\n\nAsk for help if you need it. 🧑‍🏫📗🤗",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF01579B), // Azul oscuro elegante
                      height: 1.5,
                      letterSpacing: 1.1,
                    ),
                  ),
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
  late Animation<double> _scale;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000), // más lenta
      vsync: this,
    );

    _scale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );

    _rotation = Tween<double>(begin: -0.05, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => QuestionPageSecond(
            questions: sampleQuestionsSecond,
          ),
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 173, 216, 230), // azul claro
              Color.fromARGB(255, 70, 130, 180),  // azul acero
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scale.value,
                child: Transform.rotate(
                  angle: _rotation.value * pi,
                  child: child,
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "New round, same unstoppable you! 💫🚴‍♂️🔥",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 51, 102), // azul oscuro
                  height: 1.4,
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
      backgroundColor: const Color.fromARGB(255, 196, 197, 255),
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
                color: Color.fromARGB(255, 54, 12, 193),
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
      backgroundColor: const Color.fromARGB(255, 226, 235, 255), // Fondo azul muy claro
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
                  color: Color.fromARGB(255, 14, 11, 193), // Azul principal
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
      backgroundColor: const Color.fromARGB(255, 224, 232, 255), // Fondo azul claro
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: SlideTransition(
            position: _slide,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "🌌 Awesome thinking! Spotting causes and effects helps you understand not just what happened, but why — and that’s powerful reading! 💙📘",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 13, 16, 186), // Azul fuerte
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


