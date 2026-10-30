import 'package:flutter/material.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_1/Instruction_Spot1.dart';

class InstructionSpotLoaderPage1 extends StatefulWidget {
  final String title;
  final List<String> instructions;
  final String tipTitle;
  final List<String> tips;
  final String finalNote;

  const InstructionSpotLoaderPage1({
    super.key,
    required this.title,
    required this.instructions,
    required this.tipTitle,
    required this.tips,
    required this.finalNote, required String description,
  });

  @override
  State<InstructionSpotLoaderPage1> createState() =>
      _InstructionSpotLoaderPage1State();
}

class _InstructionSpotLoaderPage1State extends State<InstructionSpotLoaderPage1> {
  @override
@override
void initState() {
  super.initState();

  Future.delayed(const Duration(seconds: 3), () {
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => InstructionSpotPage1(
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
      backgroundColor: const Color.fromARGB(255, 211, 255, 212),
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
                color: Color.fromARGB(255, 11, 205, 53),
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
                  "Some words in English don’t give all the information directly—you have to infer what they refer to! ❇️📚✨",
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
        MaterialPageRoute(builder: (_) => QuestionPage(questions: sampleQuestionsFinal)), // Cambia esta ruta si deseas
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
      backgroundColor: const Color.fromARGB(255, 196, 255, 198), // Verde suave
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: SlideTransition(
            position: _slide,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Let’s dive into some practice exercises! 📚⚡🏅",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 4, 173, 52), // Azul fuerte
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
      backgroundColor: const Color.fromARGB(255, 196, 255, 198),
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
                color: Color.fromARGB(255, 12, 193, 15),
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
      backgroundColor: const Color.fromARGB(255, 196, 255, 198),
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: SlideTransition(
            position: _slide,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Let’s practice more. \n\n Ask for help if you need it. 🧑‍🏫📗🤗",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 20, 193, 11),
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
      backgroundColor: const Color.fromARGB(255, 196, 255, 198),
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: SlideTransition(
            position: _slide,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Round 2 coming up—keep that momentum going! 🔄🔥📈",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 11, 193, 26),
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
      backgroundColor: const Color.fromARGB(255, 196, 255, 198),
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
                color: Color.fromARGB(255, 60, 193, 12),
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
      backgroundColor: const Color.fromARGB(255, 226, 255, 226), // Fondo azul muy claro
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
                  color: Color.fromARGB(255, 11, 193, 66), // Azul principal
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

class Four extends StatefulWidget {
  const Four({super.key});

  @override
  State<Four> createState() => _FourState();
}

class _FourState extends State<Four> with TickerProviderStateMixin {
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
      begin: const Offset(0, 0.35),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart));

    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => QuestionPageThird(questions: sampleQuestionsThird)), // Cambia según lo que necesites // cambiar
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
      backgroundColor: const Color.fromARGB(255, 220, 255, 218), // Azul pastel muy claro
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: SlideTransition(
            position: _slide,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Ready for Round 3? Let’s sharpen those skills! ✏️💡🏆",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 4, 173, 18), // Azul fuerte
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


class ButWhy3 extends StatefulWidget {
  const ButWhy3({super.key});

  @override
  State<ButWhy3> createState() => _ButWhy3State();
}

class _ButWhy3State extends State<ButWhy3>
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
        MaterialPageRoute(builder: (_) => const ExplanationThird()),
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
      backgroundColor: const Color.fromARGB(255, 215, 253, 205),
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
                color: Color.fromARGB(255, 12, 193, 18),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class ThirdActyvityAnimation extends StatefulWidget {
  const ThirdActyvityAnimation({super.key});

  @override
  State<ThirdActyvityAnimation> createState() => _ThirdActyvityAnimationState();
}

class _ThirdActyvityAnimationState extends State<ThirdActyvityAnimation> with TickerProviderStateMixin {
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
        MaterialPageRoute(builder: (_) => const PracticePageThird()), // Cambia a tu pantalla destino
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
      backgroundColor: const Color.fromARGB(255, 226, 255, 229), // Fondo azul muy claro
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
                  color: Color.fromARGB(255, 11, 193, 47), // Azul principal
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
      backgroundColor: const Color.fromARGB(255, 224, 255, 236), // Fondo azul claro
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: SlideTransition(
            position: _slide,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "You did amazing! \n\nThe more you practice pronominal inferences, the better you'll become! 🌟👏",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 13, 186, 22), // Azul fuerte
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


