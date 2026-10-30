import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_1/Animation1_1.dart';
import 'package:inferwise/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart';

class InstructionSpotPage1_1 extends StatefulWidget {
  final String title;
  final List<String> instructions;
  final String tipTitle;
  final List<String> tips;
  final String finalNote;

  const InstructionSpotPage1_1({
    super.key,
    required this.title,
    required this.instructions,
    required this.tipTitle,
    required this.tips,
    required this.finalNote,
  });

  @override
  State<InstructionSpotPage1_1> createState() => _InstructionSpotPage1_1State();
}

class _InstructionSpotPage1_1State extends State<InstructionSpotPage1_1> {
  int _currentStep = 0;

  void _nextStep() {
    if (_currentStep < widget.instructions.length - 1) {
      setState(() => _currentStep++);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MoreInfoPage()),
      );
    }
  }

  void _exit() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLast = _currentStep == widget.instructions.length - 1;

    return Scaffold(
      // Eliminamos el color de fondo para que se vea la imagen
      body: Stack(
        children: [
          // Imagen de fondo que ocupa todo el espacio
          Positioned.fill(
            child: Image.asset(
              'assets/Wallpapers/Wallpaper  Medals.png', // Reemplaza con tu ruta real
              fit: BoxFit.cover,
            ),
          ),
          // Contenido original envuelto en SafeArea
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título y botón de salir
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 19, 209, 48),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: _exit,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Contenedor de instrucciones con animación de fade
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(seconds: 1),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        // Agregamos un poco de opacidad al fondo para que el texto sea legible
                        color: const Color.fromARGB(255, 168, 255, 181)
                            .withOpacity(1.0),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        widget.instructions.isNotEmpty &&
                                _currentStep < widget.instructions.length
                            ? widget.instructions[_currentStep]
                            : 'No hay instrucciones disponibles.',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const Spacer(),

                  // Solo botón Next/Start
                  Center(
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF43B53F),
                        minimumSize: const Size(140, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        foregroundColor: Colors.black,
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      child: Text(
                        isLast ? "Start" : "Next",
                        style: const TextStyle(color: Colors.black),
                      ),
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

class MoreInfoPage extends StatefulWidget {
  const MoreInfoPage({super.key});

  @override
  State<MoreInfoPage> createState() => _MoreInfoPageState();
}

class _MoreInfoPageState extends State<MoreInfoPage> {
  int _visibleCount = 0;
  final PageController _pageController = PageController();
  // ignore: unused_field
  int _currentPage = 0;

  final List<Map<String, String>> examples = [
    {
      'title': ' Example 1',
      'image': 'assets/Imagenes de ejemplos/Level1/1.2 A Jake.webp',
      'sentence':
          'Jake bought a new laptop. *The device* has a powerful processor.',
      'explanation': '✔️ "The device" refers to "the laptop."',
    },
    {
      'title': ' Example 2',
      'image': 'assets/Imagenes de ejemplos/Level1/1.2 B Sarah.webp',
      'sentence': 'Sarah adopted a dog. *The little puppy* was very playful.',
      'explanation': '✔️ "The little puppy" refers to "the dog."',
    },
  ];

  void _revealNextExample() {
    if (_visibleCount < examples.length) {
      setState(() {
        _visibleCount++;
      });
      if (_visibleCount > 1) {
        _pageController.animateToPage(
          _visibleCount - 1,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _goToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondStagePartTwo()),
    );
  }

  void _exit() {
    Navigator.pop(context);
  }

  Widget _buildCard(
      String title, String image, String sentence, String explanation) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
          border: Border.all(color: Colors.green.withOpacity(0.2)),
        ),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF2E7D32),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                sentence,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1B5E20),
                  fontWeight: FontWeight.w600,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                explanation,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9),
              Color(0xFFC8E6C9),
              Color(0xFFA5D6A7),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Looking Back for \nReferences",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black54),
                      onPressed: _exit,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Info card
                Card(
                  elevation: 0,
                  color: Colors.white.withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Readers use this strategy when a word or phrase (not just a pronoun) refers back to something that was already mentioned in the text.',
                      style: TextStyle(fontSize: 17, height: 1.5),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Carrusel
                Expanded(
                  child: _visibleCount == 0
                      ? const SizedBox.shrink()
                      : PageView.builder(
                          controller: _pageController,
                          itemCount: _visibleCount,
                          onPageChanged: (index) {
                            setState(() => _currentPage = index);
                          },
                          itemBuilder: (context, index) {
                            final example = examples[index];
                            return _buildCard(
                              example['title']!,
                              example['image']!,
                              example['sentence']!,
                              example['explanation']!,
                            );
                          },
                        ),
                ),

                const SizedBox(height: 16),

                // Botón
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _visibleCount < examples.length
                        ? _revealNextExample
                        : _goToNextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _visibleCount < examples.length
                          ? const Color(0xFF43B53F)
                          : const Color(0xFF2E7D32),
                      foregroundColor: _visibleCount < examples.length
                          ? Colors.black
                          : Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        _visibleCount == 0
                            ? "Show example"
                            : _visibleCount < examples.length
                                ? "Next example"
                                : "Next",
                        key: ValueKey(_visibleCount),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecondStagePartTwo extends StatefulWidget {
  const SecondStagePartTwo({super.key});

  @override
  State<SecondStagePartTwo> createState() => _SecondStagePartTwoState();
}

class _SecondStagePartTwoState extends State<SecondStagePartTwo> {
  int _visibleCount = 0;
  final PageController _pageController = PageController();
  // ignore: unused_field
  int _currentPage = 0;

  final List<Map<String, String>> examples = [
    {
      'title': 'Example 1',
      'image': 'assets/Imagenes de ejemplos/Level1/1.2 C Researcher.webp',
      'sentence':
          '– The scientist entered the room. *The researcher* seemed nervous.',
      'explanation': '✔️ "The researcher" refers to "the scientist."',
    },
    {
      'title': 'Example 2',
      'image': 'assets/Imagenes de ejemplos/Level1/1.2 D Experiment.webp',
      'sentence':
          '– The experiment lasted three hours and required constant monitoring. *The test* revealed unexpected results.',
      'explanation': '✔️ "The test" refers to "the experiment."',
    },
  ];

  void _revealNextExample() {
    if (_visibleCount < examples.length) {
      setState(() {
        _visibleCount++;
      });
      if (_visibleCount > 1) {
        _pageController.animateToPage(
          _visibleCount - 1,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _goToStepByStep() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ThirdRoomPage()),
    );
  }

  void _exit() {
    Navigator.pop(context);
  }

  Widget _buildCard(
      String title, String image, String sentence, String explanation) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
          border: Border.all(color: Colors.green.withOpacity(0.2)),
        ),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF2E7D32),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
              // Oración en verde oscuro
              Text(
                sentence,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1B5E20),
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              // Explicación en negro
              Text(
                explanation,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9),
              Color(0xFFC8E6C9),
              Color(0xFFA5D6A7),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Looking Back for\nReferences",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black54),
                      onPressed: _exit,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Info card con "repetition" resaltado
                Card(
                  elevation: 0,
                  color: Colors.white.withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Synonyms or Near-Synonyms',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B5E20),
                          ),
                        ),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                                fontSize: 17,
                                height: 1.5,
                                color: Colors.black87),
                            children: [
                              TextSpan(text: 'Writers often avoid '),
                              TextSpan(
                                text: 'repetition',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2E7D32),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' by using different words to refer to the same thing. Readers must infer that the second term refers to the earlier one.',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                // Carrusel
                Expanded(
                  child: _visibleCount == 0
                      ? const SizedBox.shrink()
                      : PageView.builder(
                          controller: _pageController,
                          itemCount: _visibleCount,
                          onPageChanged: (index) {
                            setState(() => _currentPage = index);
                          },
                          itemBuilder: (context, index) {
                            final example = examples[index];
                            return _buildCard(
                              example['title']!,
                              example['image']!,
                              example['sentence']!,
                              example['explanation']!,
                            );
                          },
                        ),
                ),

                const SizedBox(height: 8),

                // Botón
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _visibleCount < examples.length
                        ? _revealNextExample
                        : _goToStepByStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _visibleCount < examples.length
                          ? const Color(0xFF43B53F)
                          : const Color(0xFF2E7D32),
                      foregroundColor: _visibleCount < examples.length
                          ? Colors.black
                          : Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        _visibleCount == 0
                            ? "Show example"
                            : _visibleCount < examples.length
                                ? "Next example"
                                : "Step-by-step explanation",
                        key: ValueKey(_visibleCount),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThirdRoomPage extends StatefulWidget {
  const ThirdRoomPage({super.key});

  @override
  State<ThirdRoomPage> createState() => _ThirdRoomPageState();
}

class _ThirdRoomPageState extends State<ThirdRoomPage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  final List<Map<String, String>> steps = [
    {
      'title': '🟢 1. Read the Sentences Carefully',
      'body':
          'First: "The musician stepped onto the stage."\nSecond: "The performer looked confident."',
    },
    {
      'title': '🟢 2. Identify the Word to Link',
      'body': 'We\'re analyzing: "The performer"',
    },
    {
      'title': '🟢 3. Look Back for a Possible Match',
      'body':
          'Does "performer" refer to the same person as "musician"?\n✔️ Yes — musicians are a type of performer',
    },
    {
      'title': '🟢 4. Use Logic and World Knowledge',
      'body':
          'No other people are introduced.\nA musician stepping onto a stage would also be called a performer.',
    },
    {
      'title': ' Final Answer',
      'body':
          '"The performer" refers to "the musician".\nThey describe the same person from different angles.',
    },
  ];

  Widget _buildStepContent(Map<String, String> step, int index) {
    const boldStyle = TextStyle(
      fontSize: 18,
      height: 1.6,
      color: Colors.black87,
      fontWeight: FontWeight.bold,
    );
    const normalStyle = TextStyle(
      fontSize: 17,
      height: 1.6,
      color: Colors.black87,
      fontWeight: FontWeight.normal,
    );
    const greenStyle = TextStyle(
      fontSize: 17,
      height: 1.6,
      color: Color.fromARGB(255, 42, 162, 50),
      fontWeight: FontWeight.normal,
    );

    // Last step (index 4): split body around the green sentence
    if (index == 4) {
      const greenSentence = '"The performer" refers to "the musician".';
      const afterGreen =
          '\nThey describe the same person from different angles.';

      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(text: step['title'], style: boldStyle),
            const TextSpan(text: '\n\n', style: normalStyle),
            TextSpan(text: greenSentence, style: greenStyle),
            TextSpan(text: afterGreen, style: normalStyle),
          ],
        ),
      );
    }

    // All other steps
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(text: step['title'], style: boldStyle),
          TextSpan(text: '\n\n${step['body']}', style: normalStyle),
        ],
      ),
    );
  }

  void _nextStep() {
    if (_currentStep < steps.length - 1) {
      _pageController.animateToPage(
        _currentStep + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const QuestionRoom()),
      );
    }
  }

  void _goBack() {
    if (_currentStep > 0) {
      _pageController.animateToPage(
        _currentStep - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLast = _currentStep == steps.length - 1;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9),
              Color(0xFFC8E6C9),
              Color(0xFFA5D6A7),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Step-by-Step",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black54),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Center(
                  child: Text(
                    "Let's look back for references in the next sentences",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1B5E20),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "✩ How to do it? ✩",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1B5E20),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),

                // PageView
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentStep = index;
                      });
                    },
                    itemCount: steps.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.white.withOpacity(0.85),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(32.0),
                            child: Center(
                              child: SingleChildScrollView(
                                child: _buildStepContent(steps[index], index),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 15),
                const SizedBox(height: 15),

                // Navigation buttons
                Row(
                  children: [
                    if (_currentStep > 0)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _goBack,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.7),
                            foregroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text("Back",
                              style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    if (_currentStep > 0) const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _nextStep,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isLast
                              ? const Color(0xFF2E7D32)
                              : const Color(0xFF43B53F),
                          foregroundColor: isLast ? Colors.white : Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 4,
                        ),
                        child: Text(
                          isLast ? "Finish" : "Next",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QuestionRoom extends StatelessWidget {
  const QuestionRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, size: 30, color: Colors.black54),
            onPressed: () {
              // Acción del botón cerrar
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const MoreInfoPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9), // Verde muy claro
              Color(0xFFC8E6C9), // Verde suave
              Color(0xFFA5D6A7), // Verde un poco más intenso pero suave
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green.withOpacity(0.1)),
                  ),
                  child: const Text(
                    "Is everything clear, or would you like a quick recap?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Start(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 2,
                        ),
                        child: const Text(
                          "Yes \n(continue\nwith practice)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const Reinfocert()),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.8),
                          foregroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 1,
                        ),
                        child: const Text(
                          "No \n(continue\nwith reinforcement)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Reinfocert extends StatelessWidget {
  const Reinfocert({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9), // Verde muy claro
              Color(0xFFC8E6C9), // Verde suave
              Color(0xFFA5D6A7), // Verde un poco más intenso
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header con botón de cerrar
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Remember",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close,
                          color: Colors.black54, size: 30),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const QuestionRoom()),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 10.0),
                  child: Column(
                    children: [
                      // Tarjeta Principal de Información
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.white.withOpacity(0.85),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                '🔍 Quick Review',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1B5E20),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                '🧠 Looking Back for References',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF2E7D32),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Readers use this strategy when a word or phrase refers back to something already mentioned — not just pronouns, but also synonyms or related descriptions.',
                                style: TextStyle(
                                  fontSize: 17,
                                  height: 1.5,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),

                              // Ejemplo estilizado
                              _buildExample(
                                sentence:
                                    'Emma prepared a delicious lasagna for dinner. The meal took her two hours to make.',
                                inference:
                                    '“The meal” refers to lasagna — a general word (“meal”) replaces a specific one (“lasagna”), so we infer they are the same.',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Botón inferior fijo
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReinforcentPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                    ),
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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

  Widget _buildExample({required String sentence, required String inference}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9).withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF81C784).withOpacity(0.5)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• $sentence',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('🌿 ', style: TextStyle(fontSize: 16)),
              Expanded(
                child: Text(
                  inference,
                  style: const TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF1B5E20),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ReinforcentPage extends StatelessWidget {
  const ReinforcentPage({super.key});

  final List<String> steps = const [
    '🟢 1. Find the word you need to interpret (often a noun or pronoun).',
    '🟢 2. Look back at earlier text for a matching idea or noun.',
    '🟢 3. Use logic and background knowledge to see if they refer to the same thing.',
    '🟢 4. Confirm that no other referents fit better.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9), // Verde muy claro
              Color(0xFFC8E6C9), // Verde suave
              Color(0xFFA5D6A7), // Verde un poco más intenso
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header con botón de cerrar
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Step-by-Step",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close,
                          color: Colors.black54, size: 30),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 10.0),
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          "✩ Summary of Steps ✩",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B5E20),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Lista de pasos como tarjetas estáticas
                      ...steps
                          .map((step) => Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  color: Colors.white.withOpacity(0.85),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            step,
                                            style: const TextStyle(
                                              fontSize: 17,
                                              height: 1.5,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ],
                  ),
                ),
              ),

              // Botón inferior fijo
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Start(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Finish',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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

/// Data model for a multiple choice question
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

final List<QuestionData> sampleQuestionsFinal = [
  QuestionData(
    question: 'Liam opened the gift. The *present* made him smile.',
    options: ["A) A speech", "B) A gift", "C) A birthday", "D) A moment"],
    correctIndex: 1,
    explanation:
        '✔️ Explanation: "The present" refers to "the gift" that Liam opened — both terms point to the same object, so we infer they are the same.',
    incorrectExplanations: [
      ' "A speech" doesn\'t fit the context of opening something.',
      '',
      ' "A birthday" is a time, not something you open.',
      ' "A moment" is abstract and doesn\'t match "the gift."',
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
  bool isAnswerSubmitted = false;
  bool? isCorrect;
  String? feedbackText;

  void _submitAnswer() {
    final current = widget.questions[currentQuestionIndex];
    final correct = selected == current.correctIndex;

    String explanationText;
    if (correct) {
      explanationText = current.explanation;
    } else if (current.incorrectExplanations != null &&
        selected != null &&
        selected! < current.incorrectExplanations!.length) {
      explanationText = current.incorrectExplanations![selected!];
    } else {
      explanationText = 'Incorrect answer.';
    }

    setState(() {
      isAnswerSubmitted = true;
      isCorrect = correct;
      feedbackText = explanationText;
    });
  }

  void _continue() {
    final correct = isCorrect ?? false;

    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selected = null;
        isAnswerSubmitted = false;
        isCorrect = null;
        feedbackText = null;
      });
    } else {
      if (correct) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Second()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ButWhy()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9),
              Color(0xFFC8E6C9),
              Color(0xFFA5D6A7),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close,
                          size: 24, color: Color(0xFF1B5E20)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Instrucción
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.touch_app_rounded,
                      size: 16,
                      color: Color(0xFF388E3C),
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Tap the option you think is correct",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF388E3C),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Card de pregunta
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF66BB6A),
                        Color(0xFF2E7D32),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1B5E20).withOpacity(0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),

                // Opciones — AbsorbPointer solo aquí
                Expanded(
                  child: AbsorbPointer(
                    absorbing: isAnswerSubmitted,
                    child: ListView.builder(
                      itemCount: question.options.length,
                      itemBuilder: (context, i) {
                        bool isSelected = selected == i;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF4CAF50).withOpacity(0.2)
                                : Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF2E7D32)
                                  : const Color(0xFFA5D6A7),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            dense: true,
                            title: Text(
                              question.options[i],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: Colors.black87,
                              ),
                            ),
                            onTap: () {
                              setState(() => selected = i);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Feedback inline
                if (isAnswerSubmitted && feedbackText != null) ...[
                  const SizedBox(height: 8),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isCorrect == true
                          ? const Color(0xFFE8F5E9)
                          : const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isCorrect == true
                            ? const Color(0xFF66BB6A)
                            : const Color(0xFFEF9A9A),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          isCorrect == true
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: isCorrect == true
                              ? const Color(0xFF2E7D32)
                              : Colors.red,
                          size: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isCorrect == true ? "Correct!" : "Incorrect",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: isCorrect == true
                                      ? const Color(0xFF1B5E20)
                                      : Colors.red.shade800,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                feedbackText!,
                                style: const TextStyle(
                                    fontSize: 14, height: 1.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 10),

                // Botón Submit / Continue — FUERA del AbsorbPointer
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isAnswerSubmitted
                        ? _continue
                        : selected != null
                            ? _submitAnswer
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 3,
                    ),
                    child: Text(
                      isAnswerSubmitted ? "Continue" : "Submit",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExplanationFirst extends StatefulWidget {
  const ExplanationFirst({super.key});

  @override
  State<ExplanationFirst> createState() => _ExplanationFirstState();
}

class _ExplanationFirstState extends State<ExplanationFirst> {
  int _currentStep = 0;
  String? _sentenceAboutAnswer;
  String? _presentRefersToAnswer;
  bool _isProcessing = false;
  double _progressValue = 0.2;
  String? _feedbackMessage;

  final Color _primaryGreen = const Color(0xFF2E7D32);
  final Color _darkGreen = const Color(0xFF1B5E20);

  void _nextStep() {
    if (_currentStep == 1 && _sentenceAboutAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an answer to continue')),
      );
      return;
    }

    if (_currentStep == 3 && _presentRefersToAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select what "present" refers to')),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
      _progressValue = (_currentStep + 1) * 0.2;
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        if (_currentStep < 4) {
          _currentStep++;
        } else {
          _completeAnalysis();
        }
      });
    });
  }

  void _completeAnalysis() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Second()),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: LinearProgressIndicator(
          value: _progressValue,
          backgroundColor: Colors.white.withOpacity(0.3),
          valueColor: AlwaysStoppedAnimation<Color>(_primaryGreen),
          minHeight: 8,
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "📖 Step 1: Read the first sentence",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B5E20),
          ),
        ),
        _buildProgressIndicator(),
        const SizedBox(height: 16),
        Card(
          elevation: 0,
          color: Colors.white.withOpacity(0.7),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                /// Sentence card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: _primaryGreen.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 22, color: Colors.black),
                          children: [
                            TextSpan(
                              text: "Liam ",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    _feedbackMessage =
                                        "👤 Liam is the subject of the sentence.";
                                  });
                                },
                            ),
                            TextSpan(
                              text: "opened ",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    _feedbackMessage =
                                        "✋ 'opened' describes the action.";
                                  });
                                },
                            ),
                            const TextSpan(text: "the "),
                            TextSpan(
                              text: "gift",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _primaryGreen,
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 255, 255)
                                        .withOpacity(0.3),
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    _feedbackMessage =
                                        "🎁 'gift' is the object of the action.";
                                  });
                                },
                            ),
                            const TextSpan(text: "."),
                          ],
                        ),
                      ),

                      /// Feedback below the sentence
                      if (_feedbackMessage != null) ...[
                        const SizedBox(height: 16),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: _primaryGreen.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: _primaryGreen.withOpacity(0.3)),
                          ),
                          child: Text(
                            _feedbackMessage!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                const Text(
                  "Read carefully and think about:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                _buildBulletPoint("Who is the sentence about?"),
                _buildBulletPoint("What action is happening?"),
                _buildBulletPoint("What objects are mentioned?"),
              ],
            ),
          ),
        ),
        const Spacer(),
        _buildContinueButton(),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("🤔 Step 2: What is the sentence about?",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20))),
        _buildProgressIndicator(),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildOptionCard(
                    "A) Liam's birthday party",
                    _sentenceAboutAnswer == "A",
                    false,
                    (val) => setState(() => _sentenceAboutAnswer = val)),
                _buildOptionCard(
                    "B) Liam and a present",
                    _sentenceAboutAnswer == "B",
                    true,
                    (val) => setState(() => _sentenceAboutAnswer = val)),
                _buildOptionCard(
                    "C) Liam and his smile",
                    _sentenceAboutAnswer == "C",
                    false,
                    (val) => setState(() => _sentenceAboutAnswer = val)),
                _buildOptionCard(
                    "D) Liam and a speech",
                    _sentenceAboutAnswer == "D",
                    false,
                    (val) => setState(() => _sentenceAboutAnswer = val)),
                if (_sentenceAboutAnswer != null)
                  _buildFeedback(_sentenceAboutAnswer == "B",
                      "The sentence is about: Liam received and opened a gift."),
              ],
            ),
          ),
        ),
        if (_sentenceAboutAnswer != null) _buildContinueButton(),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("📖 Step 3: Read the second sentence",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20))),
        _buildProgressIndicator(),
        const SizedBox(height: 16),
        Card(
          elevation: 0,
          color: Colors.white.withOpacity(0.7),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Text("Now look at the next part:",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: _primaryGreen.withOpacity(0.3)),
                  ),
                  child: const Text(
                    "\"He gave a big smile when he saw the present.\"",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        _buildContinueButton(),
      ],
    );
  }

  Widget _buildStep4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("🎯 Step 4: Make the connection",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20))),
        _buildProgressIndicator(),
        const SizedBox(height: 16),
        const Text(
          "Click on the noun that logically matches \"present\"",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildOptionCard(
                    "A) Liam",
                    _presentRefersToAnswer == "A",
                    false,
                    (val) => setState(() => _presentRefersToAnswer = val)),
                _buildOptionCard(
                    "B) A gift",
                    _presentRefersToAnswer == "B",
                    true,
                    (val) => setState(() => _presentRefersToAnswer = val)),
                _buildOptionCard(
                    "C) A birthday",
                    _presentRefersToAnswer == "C",
                    false,
                    (val) => setState(() => _presentRefersToAnswer = val)),
                _buildOptionCard(
                    "D) Smile",
                    _presentRefersToAnswer == "D",
                    false,
                    (val) => setState(() => _presentRefersToAnswer = val)),
                if (_presentRefersToAnswer != null)
                  _buildFeedback(_presentRefersToAnswer == "B",
                      "Present is a synonym for gift"),
              ],
            ),
          ),
        ),
        if (_presentRefersToAnswer != null) _buildContinueButton(),
      ],
    );
  }

  Widget _buildFinalStep() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("🎯 Final Answer",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20))),
          _buildProgressIndicator(),
          const SizedBox(height: 16),
          Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.white.withOpacity(0.9),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    " Correct Answer:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "B) A gift",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(height: 32),
                  const Text(
                    "Explanation:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              "\"Present\" means the same thing as \"gift,\" so it refers to the object Liam opened.\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              "The other options (Liam, birthday, smile) don't match the context logically.\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              "Using context clues, we confirm that a synonym is being used to refer back to the same object.",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow, color: Colors.black),
              label: const Text(
                "Start Practice Exercises",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFF4CAF50), width: 2),
                ),
                elevation: 4,
              ),
              onPressed: _completeAnalysis,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.check, size: 18, color: _primaryGreen),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _buildOptionCard(
      String text, bool isSelected, bool isCorrect, Function(String) onTap) {
    return GestureDetector(
      onTap: () => onTap(text.substring(0, 1)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect ? const Color(0xFFA5D6A7) : Colors.red[100])
              : Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected
                ? (isCorrect ? _primaryGreen : Colors.red)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
                child: Text(text,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500))),
            if (isSelected)
              Icon(isCorrect ? Icons.check_circle : Icons.cancel,
                  color: isCorrect ? _primaryGreen : Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedback(bool isCorrect, String message) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect
            ? _primaryGreen.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(isCorrect ? Icons.lightbulb : Icons.info_outline,
              color: isCorrect ? _primaryGreen : Colors.red),
          const SizedBox(width: 12),
          Expanded(
              child: Text(message,
                  style: TextStyle(
                      color: isCorrect ? _darkGreen : Colors.red[900],
                      fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget _buildContinueButton({String label = "Continue"}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isProcessing ? null : _nextStep,
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 4,
        ),
        child: _isProcessing
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2))
            : Text(label,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9), Color(0xFFA5D6A7)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Explanation",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32))),
                    IconButton(
                        icon: const Icon(Icons.close, color: Colors.black54),
                        onPressed: () => Navigator.pop(context)),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: KeyedSubtree(
                        key: ValueKey(_currentStep),
                        child: _buildCurrentStep()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildStep1();
      case 1:
        return _buildStep2();
      case 2:
        return _buildStep3();
      case 3:
        return _buildStep4();
      case 4:
        return _buildFinalStep();
      default:
        return const SizedBox();
    }
  }
}

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage>
    with SingleTickerProviderStateMixin {
  int currentQuestionIndex = 0;
  int? selectedOptionIndex;
  bool showFeedback = false;
  double progress = 0;

  int hintStep1 = 0;
  int hintStep2 = 0;
  int hintStep3 = 0;
  int hintStep4 = 0;

  // Variables para el efecto del bombillo de inactividad
  Timer? _inactivityTimer;
  bool _isInactive = false;
  late AnimationController _glowController;

  final List<String> hints1 = [
    '💡 General Hint: Think about what ‘dish’ means in cooking.',
    '📌 More Specific: Is it talking about food or an object?',
  ];

  final List<String> hints2 = [
    '💡 General Hint: Think about what ‘building’ is describing.',
    '📌 More Specific: Is “Building” talking about a place the students visited?',
  ];

  final List<String> hints3 = [
    '💡 General Hint: Think about what ‘film’ refers to in this context.',
    '📌 More Specific: Is ‘film’ talking about a type of media or an object?',
  ];

  final List<String> hints4 = [
    '💡 General Hint: Think about what ‘novel’ refers to.',
    '📌 More Specific: Is ‘novel’ talking about a type of reading material?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "The chef prepared a new recipe. The dish was spicy and flavorful.",
      "options": ["A) A plate", "B) A utensil", "C) A recipe", "D) A kitchen"],
      "correctIndex": 2,
      "feedback": [
        " “A plate” is where food is served, not the food itself.",
        " “A utensil” is a tool for eating or cooking.",
        " ✔️ Explanation: “Dish” is a near-synonym of a prepared recipe.",
        " “A kitchen” is a place, not the result of cooking."
      ]
    },
    {
      "question":
          "The students visited the museum. The building was full of history.",
      "options": [
        "A) The museum",
        "B) The city",
        "C) The school",
        "D) The classroom"
      ],
      "correctIndex": 0,
      "feedback": [
        " ✔️ Explanation: “Building” refers to “museum,” which is the place they visited.",
        " “The city” is too broad.",
        " “The school” was not mentioned.",
        " “The classroom” is unrelated."
      ]
    },
    {
      "question":
          "Samantha watched a documentary on whales. The film was fascinating.",
      "options": ["A) Whales", "B) A documentary", "C) A video", "D) Samantha"],
      "correctIndex": 1,
      "feedback": [
        " “A photograph” is not a synonym for documentary.",
        " ✔️ Explanation: “Film” is a synonym for “documentary.”",
        " “A poster” doesn’t fit the context.",
        " “A book” is unrelated to the visual medium mentioned."
      ]
    },
    {
      "question":
          "He bought a novel by his favorite author. The book was very inspiring.",
      "options": [
        "A) The author",
        "B) A bookstore",
        "C) A notebook",
        "D) The book"
      ],
      "correctIndex": 3,
      "feedback": [
        " “The author” is a person, not the object being described.",
        " “A bookstore” is where books are sold, not the book itself.",
        " “A notebook” is not the same as a novel.",
        " ✔️ Explanation: “Book” is another word for “novel.”"
      ]
    }
  ];

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _startInactivityTimer();
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel();
    _glowController.dispose();
    super.dispose();
  }

  void _startInactivityTimer() {
    _inactivityTimer?.cancel();
    if (_isInactive) {
      setState(() {
        _isInactive = false;
      });
    }
    _inactivityTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && !showFeedback) {
        setState(() {
          _isInactive = true;
        });
      }
    });
  }

  void handleOptionTap(int index) {
    _startInactivityTimer();
    final correctIndex = questions[currentQuestionIndex]['correctIndex'];
    setState(() {
      selectedOptionIndex = index;
      showFeedback = true;
      if (index == correctIndex) {
        progress += 1 / questions.length;
      }
    });
  }

  void goToNextQuestion() {
    _startInactivityTimer();
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        _showCompletionDialog();
        return;
      }
      selectedOptionIndex = null;
      showFeedback = false;
      hintStep1 = 0;
      hintStep2 = 0;
      hintStep3 = 0;
      hintStep4 = 0;
    });
  }

  void _showCompletionDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "LevelComplete",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedValue =
            Curves.easeInOutBack.transform(animation.value) - 1.0;

        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * -50, 0.0),
          child: Opacity(
            opacity: animation.value,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 16,
              backgroundColor: const Color.fromARGB(255, 232, 255, 232),
              titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              title: Row(
                children: const [
                  Icon(Icons.emoji_events,
                      color: Color.fromARGB(255, 76, 175, 80), size: 30),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Level Complete!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 27, 94, 32),
                      ),
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "You've completed all the questions.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 56, 56, 56),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Get ready for the next challenge!",
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 85, 139, 47),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              actions: [
                TextButton.icon(
                  icon: const Icon(Icons.close),
                  label: const Text("Close"),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.green.shade700,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  label: const Text("Advance"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Third()),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  TextSpan _buildColoredText(String text, TextStyle baseStyle) {
    final List<String> targetWords = ['dish', 'building', 'film', 'novel'];
    final List<TextSpan> spans = [];

    // Regex para encontrar las palabras (ignorando mayúsculas/minúsculas)
    final String pattern = '(${targetWords.join('|')})';
    final RegExp regExp = RegExp(pattern, caseSensitive: false);

    int lastIndex = 0;
    for (final Match match in regExp.allMatches(text)) {
      // Texto antes de la coincidencia
      if (match.start > lastIndex) {
        spans.add(TextSpan(
          text: text.substring(lastIndex, match.start),
          style: baseStyle,
        ));
      }

      // La palabra coincidente en verde
      spans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: baseStyle.copyWith(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ));

      lastIndex = match.end;
    }

    // Texto restante
    if (lastIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastIndex),
        style: baseStyle,
      ));
    }

    return TextSpan(children: spans);
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];
    final options = question['options'] as List<String>;
    final feedback = question['feedback'] as List<String>;
    final correctIndex = question['correctIndex'] as int;

    String? currentHint;
    int? currentHintIndex;

    if (currentQuestionIndex == 0 && hintStep1 < hints1.length) {
      currentHint = hints1[hintStep1];
      currentHintIndex = hintStep1;
    } else if (currentQuestionIndex == 1 && hintStep2 < hints2.length) {
      currentHint = hints2[hintStep2];
      currentHintIndex = hintStep2;
    } else if (currentQuestionIndex == 2 && hintStep3 < hints3.length) {
      currentHint = hints3[hintStep3];
      currentHintIndex = hintStep3;
    } else if (currentQuestionIndex == 3 && hintStep4 < hints4.length) {
      currentHint = hints4[hintStep4];
      currentHintIndex = hintStep4;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9),
              Color(0xFFC8E6C9),
            ],
          ),
        ),
        child: SafeArea(
          child: GestureDetector(
            onTapDown: (_) => _startInactivityTimer(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Choose what the highlighted word refers to.",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text.rich(
                      _buildColoredText(
                        question['question'],
                        const TextStyle(
                            fontSize: 18, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  for (int i = 0; i < options.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: ElevatedButton(
                        onPressed:
                            showFeedback ? null : () => handleOptionTap(i),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.9),
                          foregroundColor: Colors.black,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(options[i],
                              style: const TextStyle(fontSize: 16)),
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  if (showFeedback && selectedOptionIndex != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          _buildColoredText(
                            selectedOptionIndex == correctIndex
                                ? "✩ ${feedback[selectedOptionIndex!]}"
                                : " ${feedback[selectedOptionIndex!]}",
                            TextStyle(
                                fontSize: 18,
                                color: selectedOptionIndex == correctIndex
                                    ? const Color(0xFF1B5E20)
                                    : Colors.red),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  selectedOptionIndex == correctIndex
                                      ? Colors.green.shade400
                                      : Colors.green.shade300,
                            ),
                            onPressed: selectedOptionIndex == correctIndex
                                ? goToNextQuestion
                                : () {
                                    setState(() {
                                      selectedOptionIndex = null;
                                      showFeedback = false;
                                    });
                                    _startInactivityTimer();
                                  },
                            child: Text(
                              selectedOptionIndex == correctIndex
                                  ? "Next"
                                  : "Try Again",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 30),
                  if (!showFeedback)
                    Row(
                      children: [
                        Column(
                          children: [
                            IconButton(
                              icon: AnimatedBuilder(
                                animation: _glowController,
                                builder: (context, child) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: _isInactive
                                          ? [
                                              BoxShadow(
                                                color: Colors.yellow
                                                    .withOpacity(0.5 *
                                                        _glowController.value),
                                                blurRadius:
                                                    15 * _glowController.value,
                                                spreadRadius:
                                                    5 * _glowController.value,
                                              ),
                                            ]
                                          : [],
                                    ),
                                    child: Icon(
                                      Icons.lightbulb,
                                      color: _isInactive
                                          ? Colors.amber
                                          : const Color(0xFF3CB371),
                                      size: 40,
                                    ),
                                  );
                                },
                              ),
                              onPressed: () {
                                _startInactivityTimer();
                                setState(() {
                                  if (currentHintIndex != null) {
                                    if (currentQuestionIndex == 0) {
                                      hintStep1++;
                                    } else if (currentQuestionIndex == 1)
                                      // ignore: curly_braces_in_flow_control_structures
                                      hintStep2++;
                                    else if (currentQuestionIndex == 2)
                                      // ignore: curly_braces_in_flow_control_structures
                                      hintStep3++;
                                    else if (currentQuestionIndex == 3)
                                      // ignore: curly_braces_in_flow_control_structures
                                      hintStep4++;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        if (currentHint != null)
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.green),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text.rich(
                                      _buildColoredText(
                                        currentHint,
                                        const TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close, size: 20),
                                    onPressed: () {
                                      setState(() {
                                        if (currentQuestionIndex == 0) {
                                          hintStep1 = hints1.length;
                                        } else if (currentQuestionIndex == 1)
                                          // ignore: curly_braces_in_flow_control_structures
                                          hintStep2 = hints2.length;
                                        else if (currentQuestionIndex == 2)
                                          // ignore: curly_braces_in_flow_control_structures
                                          hintStep3 = hints3.length;
                                        else if (currentQuestionIndex == 3)
                                          // ignore: curly_braces_in_flow_control_structures
                                          hintStep4 = hints4.length;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
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

final List<QuestionData> sampleQuestionsSecond = [
  QuestionData(
    question:
        'Julia painted a portrait. The ___ took her three hours to finish.',
    options: ["A) artist", "B) canvas", "C) artwork", "D) wall"],
    correctIndex: 2,
    explanation:
        '✔️ Explanation: “Artwork” refers back to the portrait Julia painted — we infer they are the same.',
    incorrectExplanations: [
      ' “Artist” is the person, not the result of the painting.',
      ' “Canvas” is the material, not the finished work.',
      '',
      ' “Wall” is unrelated to what was painted.',
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
  bool isAnswerSubmitted = false;
  bool? isCorrect;
  String? feedbackText;

  void _submitAnswer() {
    final current = widget.questions[currentQuestionIndex];
    final correct = selected == current.correctIndex;

    String explanationText;
    if (correct) {
      explanationText = current.explanation;
    } else if (current.incorrectExplanations != null &&
        selected != null &&
        selected! < current.incorrectExplanations!.length) {
      explanationText = current.incorrectExplanations![selected!];
    } else {
      explanationText = 'Incorrect answer.';
    }

    setState(() {
      isAnswerSubmitted = true;
      isCorrect = correct;
      feedbackText = explanationText;
    });
  }

  void _continue() {
    final correct = isCorrect ?? false;

    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selected = null;
        isAnswerSubmitted = false;
        isCorrect = null;
        feedbackText = null;
      });
    } else {
      if (correct) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => const SecondActyvityAnimation()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ButWhy2()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9),
              Color(0xFFC8E6C9),
              Color(0xFFA5D6A7),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close,
                          size: 24, color: Color(0xFF1B5E20)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Instrucción
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.touch_app_rounded,
                      size: 16,
                      color: Color(0xFF388E3C),
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Select the option you think is correct",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF388E3C),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Card de pregunta
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF66BB6A),
                        Color(0xFF2E7D32),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1B5E20).withOpacity(0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),

                // Opciones — AbsorbPointer solo aquí
                Expanded(
                  child: AbsorbPointer(
                    absorbing: isAnswerSubmitted,
                    child: ListView.builder(
                      itemCount: question.options.length,
                      itemBuilder: (context, i) {
                        bool isSelected = selected == i;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF4CAF50).withOpacity(0.2)
                                : Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF2E7D32)
                                  : const Color(0xFFA5D6A7),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            dense: true,
                            title: Text(
                              question.options[i],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: Colors.black87,
                              ),
                            ),
                            onTap: () {
                              setState(() => selected = i);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Feedback inline
                if (isAnswerSubmitted && feedbackText != null) ...[
                  const SizedBox(height: 8),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isCorrect == true
                          ? const Color(0xFFE8F5E9)
                          : const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isCorrect == true
                            ? const Color(0xFF66BB6A)
                            : const Color(0xFFEF9A9A),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          isCorrect == true
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: isCorrect == true
                              ? const Color(0xFF2E7D32)
                              : Colors.red,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isCorrect == true ? "Correct!" : "Incorrect",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: isCorrect == true
                                      ? const Color(0xFF1B5E20)
                                      : Colors.red.shade800,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                feedbackText!,
                                style: const TextStyle(
                                    fontSize: 16, height: 1.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 10),

                // Botón Submit / Continue — FUERA del AbsorbPointer
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isAnswerSubmitted
                        ? _continue
                        : selected != null
                            ? _submitAnswer
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 3,
                    ),
                    child: Text(
                      isAnswerSubmitted ? "Continue" : "Submit",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExplanationSecond extends StatefulWidget {
  const ExplanationSecond({super.key});

  @override
  State<ExplanationSecond> createState() => _ExplanationSecondState();
}

class _ExplanationSecondState extends State<ExplanationSecond> {
  int _currentStep = 0;
  String? _sentenceAboutAnswer;
  String? _referenceAnswer;
  bool _isProcessing = false;
  double _progressValue = 0.2;

  final Color _primaryGreen = const Color(0xFF2E7D32);
  final Color _darkGreen = const Color(0xFF1B5E20);

  void _nextStep() {
    if (_currentStep == 1 && _sentenceAboutAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an answer to continue')),
      );
      return;
    }

    if (_currentStep == 3 && _referenceAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select what the blank refers to')),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
      _progressValue = (_currentStep + 1) * 0.2;
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        if (_currentStep < 4) {
          _currentStep++;
        } else {
          _completeAnalysis();
        }
      });
    });
  }

  void _completeAnalysis() {
    setState(() => _isProcessing = true);
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const SecondActyvityAnimation(),
        ),
      );
    });
  }

  Widget _buildProgressIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: LinearProgressIndicator(
          value: _progressValue,
          backgroundColor: Colors.white.withOpacity(0.3),
          valueColor: AlwaysStoppedAnimation<Color>(_primaryGreen),
          minHeight: 8,
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("📖 Step 1: Read the first sentence",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20))),
        _buildProgressIndicator(),
        const SizedBox(height: 16),
        Card(
          elevation: 0,
          color: Colors.white.withOpacity(0.7),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                //Aca se puede ponet un texto de introduccion o instrucciones
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: _primaryGreen.withOpacity(0.3)),
                  ),
                  child: const Text(
                    "\"Julia painted a portrait.\"",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Read carefully and think about:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                _buildBulletPoint("Who is performing the action?"),
                _buildBulletPoint("What action is happening?"),
                _buildBulletPoint("What objects are mentioned?"),
              ],
            ),
          ),
        ),
        const Spacer(),
        _buildContinueButton(),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("🤔 Step 2: What is the sentence about?",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20))),
        _buildProgressIndicator(),
        const SizedBox(height: 16),
        const Text(
          "Choose one option",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildOptionCard(
                    "A) Julia's house",
                    _sentenceAboutAnswer == "A",
                    false,
                    (val) => setState(() => _sentenceAboutAnswer = val)),
                _buildOptionCard("B) Julia's job", _sentenceAboutAnswer == "B",
                    false, (val) => setState(() => _sentenceAboutAnswer = val)),
                _buildOptionCard(
                    "C) Julia's portrait",
                    _sentenceAboutAnswer == "C",
                    true,
                    (val) => setState(() => _sentenceAboutAnswer = val)),
                _buildOptionCard("D) Julia's time", _sentenceAboutAnswer == "D",
                    false, (val) => setState(() => _sentenceAboutAnswer = val)),
                if (_sentenceAboutAnswer != null)
                  _buildFeedback(
                      _sentenceAboutAnswer == "C",
                      _sentenceAboutAnswer == "C"
                          ? "The sentence is about: Julia created a portrait, which is a type of artwork."
                          : "Look for what Julia did in the sentence."),
              ],
            ),
          ),
        ),
        if (_sentenceAboutAnswer != null) _buildContinueButton(),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("📖 Step 3: Read the second sentence",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20))),
        _buildProgressIndicator(),
        const SizedBox(height: 16),
        Card(
          elevation: 0,
          color: Colors.white.withOpacity(0.7),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Text("Now look at the next part:",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: _primaryGreen.withOpacity(0.3)),
                  ),
                  child: const Text(
                    "\"The ________ took her three hours to finish.\"",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        _buildContinueButton(),
      ],
    );
  }

  Widget _buildStep4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("🎯 Step 4: Make the connection",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20))),
        _buildProgressIndicator(),
        const SizedBox(height: 16),
        const Text(
          "Complete the sentence",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildOptionCard("A) Artist", _referenceAnswer == "A", false,
                    (val) => setState(() => _referenceAnswer = val)),
                _buildOptionCard("B) Canvas", _referenceAnswer == "B", false,
                    (val) => setState(() => _referenceAnswer = val)),
                _buildOptionCard("C) Artwork", _referenceAnswer == "C", true,
                    (val) => setState(() => _referenceAnswer = val)),
                _buildOptionCard("D) Wall", _referenceAnswer == "D", false,
                    (val) => setState(() => _referenceAnswer = val)),
                if (_referenceAnswer != null)
                  _buildFeedback(
                      _referenceAnswer == "C",
                      _referenceAnswer == "C"
                          ? "Artwork is the most general and accurate term for what she painted."
                          : "The other options don't match the context logically."),
              ],
            ),
          ),
        ),
        if (_referenceAnswer != null) _buildContinueButton(),
      ],
    );
  }

  Widget _buildFinalStep() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("🎯 Final Answer",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20))),
          _buildProgressIndicator(),
          const SizedBox(height: 16),
          Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.white.withOpacity(0.9),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    " Correct Answer:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "C) Artwork",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(height: 32),
                  const Text(
                    "Explanation:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              "\"Artwork\" is the most general and accurate term for what she painted (the portrait).\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              "The other options (artist, canvas, wall) don't match the context.\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              "The complete sentence becomes: \"Julia painted a portrait. The artwork took her three hours to finish.\"",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow, color: Colors.black),
              label: const Text(
                "Start Practice Exercises",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFF4CAF50), width: 2),
                ),
                elevation: 4,
              ),
              onPressed: _completeAnalysis,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.check, size: 18, color: _primaryGreen),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _buildOptionCard(
      String text, bool isSelected, bool isCorrect, Function(String) onTap) {
    return GestureDetector(
      onTap: () => onTap(text.substring(0, 1)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect ? const Color(0xFFA5D6A7) : Colors.red[100])
              : Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected
                ? (isCorrect ? _primaryGreen : Colors.red)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
                child: Text(text,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500))),
            if (isSelected)
              Icon(isCorrect ? Icons.check_circle : Icons.cancel,
                  color: isCorrect ? _primaryGreen : Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedback(bool isCorrect, String message) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect
            ? _primaryGreen.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(isCorrect ? Icons.lightbulb : Icons.info_outline,
              color: isCorrect ? _primaryGreen : Colors.red),
          const SizedBox(width: 12),
          Expanded(
              child: Text(message,
                  style: TextStyle(
                      color: isCorrect ? _darkGreen : Colors.red[900],
                      fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget _buildContinueButton({String label = "Continue"}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isProcessing ? null : _nextStep,
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 4,
        ),
        child: _isProcessing
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2))
            : Text(label,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9), Color(0xFFA5D6A7)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Explanation",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32))),
                    IconButton(
                        icon: const Icon(Icons.close, color: Colors.black54),
                        onPressed: () => Navigator.pop(context)),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: KeyedSubtree(
                        key: ValueKey(_currentStep),
                        child: _buildCurrentStep()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildStep1();
      case 1:
        return _buildStep2();
      case 2:
        return _buildStep3();
      case 3:
        return _buildStep4();
      case 4:
        return _buildFinalStep();
      default:
        return const SizedBox();
    }
  }
}

class PracticePageSecond extends StatefulWidget {
  const PracticePageSecond({super.key});

  @override
  State<PracticePageSecond> createState() => _PracticePageSecondState();
}

class _PracticePageSecondState extends State<PracticePageSecond>
    with SingleTickerProviderStateMixin {
  int currentQuestionIndex = 0;
  int? selectedOptionIndex;
  bool showFeedback = false;
  double progress = 0;

  int hintStep1 = 0;
  int hintStep2 = 0;
  int hintStep3 = 0;
  int hintStep4 = 0;

  Timer? _inactivityTimer;
  bool _isInactive = false;
  late AnimationController _glowController;

  final List<String> hints1 = [
    '💡 General Hint: Think about what fits with ‘apartment’.',
    '📌 More Specific: Is it referring to a place or something else?',
  ];

  final List<String> hints2 = [
    '💡 General Hint: Think about what ‘findings’ mean in this context.',
    '📌 More Specific: Are ‘findings’ something that can be described as results?',
  ];

  final List<String> hints3 = [
    '💡 General Hint: Think about what ‘speech’ means in this context.',
    '📌 More Specific: Is ‘speech’ another way to say something else?',
  ];

  final List<String> hints4 = [
    '💡 General Hint: Think about what fits with ‘chocolate cake’.',
    '📌 More Specific: Is it talking about food or something else?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "My cousin showed me his new apartment. The ___ is near the park.",
      "options": ["A) building", "B) car", "C) job", "D) phone"],
      "correctIndex": 0,
      "feedback": [
        " Explanation: “Building” is a general word that refers back to where the apartment is located.",
        " A car is unrelated to the context of an apartment.",
        " A job is unrelated to the apartment’s location.",
        " A phone has no relation to the apartment or location."
      ]
    },
    {
      "question":
          "The scientist published her findings. The ___ were surprising.",
      "options": ["A) articles", "B) results", "C) lab", "D) journal"],
      "correctIndex": 1,
      "feedback": [
        " Articles are not the same as findings.",
        " Explanation: “Findings” are results — they are synonyms.",
        " A lab is a place, not the findings.",
        " A journal is where findings are published, not the findings themselves."
      ]
    },
    {
      "question":
          "He gave a speech at the ceremony. The ___ received a lot of applause.",
      "options": ["A) speaker", "B) crowd", "C) microphone", "D) talk"],
      "correctIndex": 3,
      "feedback": [
        " The speaker is the person, not the speech.",
        " The crowd listens to the speech, not receives applause for it.",
        " A microphone is a device, not the subject of the applause.",
        " Explanation: “Talk” is a synonym for “speech.”"
      ]
    },
    {
      "question":
          "We ordered a chocolate cake for the party. The ___ was decorated with strawberries.",
      "options": ["A) party", "B) bakery", "C) dessert", "D) guest"],
      "correctIndex": 2,
      "feedback": [
        " The party is the event, not the food.",
        " A bakery makes cakes, but isn’t being described here.",
        " Explanation: “Dessert” is a general term that refers back to “chocolate cake.”",
        " The guest is a person, not the dessert."
      ]
    }
  ];

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _startInactivityTimer();
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel();
    _glowController.dispose();
    super.dispose();
  }

  void _startInactivityTimer() {
    _inactivityTimer?.cancel();
    if (_isInactive) {
      setState(() {
        _isInactive = false;
      });
    }
    _inactivityTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && !showFeedback) {
        setState(() {
          _isInactive = true;
        });
      }
    });
  }

  void handleOptionTap(int index) {
    _startInactivityTimer();
    final correctIndex = questions[currentQuestionIndex]['correctIndex'];
    setState(() {
      selectedOptionIndex = index;
      showFeedback = true;
      if (index == correctIndex) {
        progress += 1 / questions.length;
      }
    });
  }

  void goToNextQuestion() {
    _startInactivityTimer();
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        // Lógica de fin de nivel (se mantiene igual)
        _showCompletionDialog();
        return;
      }
      selectedOptionIndex = null;
      showFeedback = false;
      hintStep1 = 0;
      hintStep2 = 0;
      hintStep3 = 0;
      hintStep4 = 0;
    });
  }

  void _showCompletionDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "LevelComplete",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox(); // Required for pageBuilder
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedValue =
            Curves.easeInOutBack.transform(animation.value) - 1.0;

        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * -50, 0.0),
          child: Opacity(
            opacity: animation.value,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 16,
              backgroundColor: const Color.fromARGB(255, 232, 255, 232),
              titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              title: Row(
                children: const [
                  Icon(Icons.emoji_events,
                      color: Color.fromARGB(255, 76, 175, 80), size: 30),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Level Complete!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 27, 94, 32),
                      ),
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "You've completed all the questions.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 56, 56, 56),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Get ready for the next challenge!",
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 85, 139, 47),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              actions: [
                TextButton.icon(
                  icon: const Icon(Icons.close),
                  label: const Text("Close"),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.green.shade700,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  label: const Text("Advance"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Four()),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    return;
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];
    final options = question['options'] as List<String>;
    final feedback = question['feedback'] as List<String>;
    final correctIndex = question['correctIndex'] as int;

    String? currentHint;
    int? currentHintIndex;

    if (currentQuestionIndex == 0 && hintStep1 < hints1.length) {
      currentHint = hints1[hintStep1];
      currentHintIndex = hintStep1;
    } else if (currentQuestionIndex == 1 && hintStep2 < hints2.length) {
      currentHint = hints2[hintStep2];
      currentHintIndex = hintStep2;
    } else if (currentQuestionIndex == 2 && hintStep3 < hints3.length) {
      currentHint = hints3[hintStep3];
      currentHintIndex = hintStep3;
    } else if (currentQuestionIndex == 3 && hintStep4 < hints4.length) {
      currentHint = hints4[hintStep4];
      currentHintIndex = hintStep4;
    }

    return Scaffold(
      // El fondo se define aquí para que sea estático y no se mueva con el scroll
      backgroundColor: const Color(0xFFE8F5E9),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9), // Verde muy suave
              Color(0xFFC8E6C9),
            ],
          ),
        ),
        child: SafeArea(
          child: GestureDetector(
            onTapDown: (_) => _startInactivityTimer(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Choose the right option",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      question['question'],
                      style: const TextStyle(
                          fontSize: 18, fontStyle: FontStyle.italic),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Opciones
                  for (int i = 0; i < options.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: ElevatedButton(
                        onPressed:
                            showFeedback ? null : () => handleOptionTap(i),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.9),
                          foregroundColor: Colors.black,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(options[i],
                              style: const TextStyle(fontSize: 16)),
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),

                  // FEEDBACK
                  if (showFeedback && selectedOptionIndex != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedOptionIndex == correctIndex
                              ? "✩ ${feedback[selectedOptionIndex!]}"
                              : " ${feedback[selectedOptionIndex!]}",
                          style: TextStyle(
                              fontSize: 18,
                              color: selectedOptionIndex == correctIndex
                                  ? const Color(0xFF1B5E20)
                                  : Colors.red),
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  selectedOptionIndex == correctIndex
                                      ? Colors.green.shade400
                                      : Colors.green.shade300,
                            ),
                            onPressed: selectedOptionIndex == correctIndex
                                ? goToNextQuestion
                                : () {
                                    setState(() {
                                      selectedOptionIndex = null;
                                      showFeedback = false;
                                    });
                                    _startInactivityTimer();
                                  },
                            child: Text(
                              selectedOptionIndex == correctIndex
                                  ? "Next"
                                  : "Try Again",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 30),

                  // BOTÓN DE PISTAS Y EFECTO BRILLANTE
// BOTÓN DE PISTAS Y EFECTO BRILLANTE
                  if (!showFeedback)
                    Row(
                      children: [
                        Column(
                          children: [
                            // El botón de la bombilla que siempre está ahí
                            IconButton(
                              icon: AnimatedBuilder(
                                animation: _glowController,
                                builder: (context, child) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: _isInactive
                                          ? [
                                              BoxShadow(
                                                color: Colors.yellow
                                                    .withOpacity(0.5 *
                                                        _glowController.value),
                                                blurRadius:
                                                    15 * _glowController.value,
                                                spreadRadius:
                                                    5 * _glowController.value,
                                              ),
                                            ]
                                          : [],
                                    ),
                                    child: Icon(
                                      Icons.lightbulb,
                                      color: _isInactive
                                          ? Colors.amber
                                          : const Color(0xFF3CB371),
                                      size: 40,
                                    ),
                                  );
                                },
                              ),
                              onPressed: () {
                                _startInactivityTimer();
                                setState(() {
                                  if (currentHintIndex != null) {
                                    if (currentQuestionIndex == 0) {
                                      hintStep1++;
                                    } else if (currentQuestionIndex == 1)
                                      // ignore: curly_braces_in_flow_control_structures
                                      hintStep2++;
                                    else if (currentQuestionIndex == 2)
                                      // ignore: curly_braces_in_flow_control_structures
                                      hintStep3++;
                                    else if (currentQuestionIndex == 3)
                                      // ignore: curly_braces_in_flow_control_structures
                                      hintStep4++;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),

                        // El texto de la pista si está activa
                        if (currentHint != null)
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.green),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      currentHint,
                                      style: const TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close, size: 20),
                                    onPressed: () {
                                      setState(() {
                                        if (currentQuestionIndex == 0) {
                                          hintStep1 = hints1.length;
                                        } else if (currentQuestionIndex == 1)
                                          // ignore: curly_braces_in_flow_control_structures
                                          hintStep2 = hints2.length;
                                        else if (currentQuestionIndex == 2)
                                          // ignore: curly_braces_in_flow_control_structures
                                          hintStep3 = hints3.length;
                                        else if (currentQuestionIndex == 3)
                                          // ignore: curly_braces_in_flow_control_structures
                                          hintStep4 = hints4.length;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
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

final List<QuestionData> sampleQuestionsThird = [
  QuestionData(
    question: 'Which sentence contains a problem with anaphoric reference?',
    options: [
      "A) Marcus cooked dinner. The meal smelled delicious.",
      "B) We visited the castle. The structure was beautiful.",
      "C) Lisa bought flowers. The painting was colorful.",
      "D) The movie ended. The story was emotional."
    ],
    correctIndex: 2,
    explanation:
        '✔️ Explanation: “Painting” doesn’t refer back to anything mentioned earlier. The error is in C.',
    incorrectExplanations: [
      ' “The meal” refers back to “dinner,” which is correct.',
      ' “The structure” refers to “the castle,” so the reference is clear.',
      '',
      ' “The story” logically refers back to “the movie.”',
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
  bool isAnswerSubmitted = false;
  bool? isCorrect;
  String? feedbackText;

  void _submitAnswer() {
    final current = widget.questions[currentQuestionIndex];
    final correct = selected == current.correctIndex;

    String explanationText;
    if (correct) {
      explanationText = current.explanation;
    } else if (current.incorrectExplanations != null &&
        selected != null &&
        selected! < current.incorrectExplanations!.length) {
      explanationText = current.incorrectExplanations![selected!];
    } else {
      explanationText = 'Incorrect answer.';
    }

    setState(() {
      isAnswerSubmitted = true;
      isCorrect = correct;
      feedbackText = explanationText;
    });
  }

  void _continue() {
    final correct = isCorrect ?? false;

    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selected = null;
        isAnswerSubmitted = false;
        isCorrect = null;
        feedbackText = null;
      });
    } else {
      if (correct) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => const ThirdActyvityAnimation()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ButWhy3()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9),
              Color(0xFFC8E6C9),
              Color(0xFFA5D6A7),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close,
                          size: 28, color: Color(0xFF1B5E20)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Card de pregunta
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 28),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF66BB6A),
                        Color(0xFF2E7D32),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1B5E20).withOpacity(0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 28),

                // Opciones — AbsorbPointer solo aquí
                Expanded(
                  child: AbsorbPointer(
                    absorbing: isAnswerSubmitted,
                    child: ListView.builder(
                      itemCount: question.options.length,
                      itemBuilder: (context, i) {
                        bool isSelected = selected == i;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF4CAF50).withOpacity(0.2)
                                : Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF2E7D32)
                                  : const Color(0xFFA5D6A7),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              question.options[i],
                              style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: Colors.black87,
                              ),
                            ),
                            onTap: () {
                              setState(() => selected = i);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Feedback inline
                if (isAnswerSubmitted && feedbackText != null) ...[
                  const SizedBox(height: 8),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isCorrect == true
                          ? const Color(0xFFE8F5E9)
                          : const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isCorrect == true
                            ? const Color(0xFF66BB6A)
                            : const Color(0xFFEF9A9A),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          isCorrect == true
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: isCorrect == true
                              ? const Color(0xFF2E7D32)
                              : Colors.red,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isCorrect == true ? "Correct!" : "Incorrect",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: isCorrect == true
                                      ? const Color(0xFF1B5E20)
                                      : Colors.red.shade800,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                feedbackText!,
                                style: const TextStyle(
                                    fontSize: 16, height: 1.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 8),

                // Botón Submit / Continue — FUERA del AbsorbPointer
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isAnswerSubmitted
                        ? _continue
                        : selected != null
                            ? _submitAnswer
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 3,
                    ),
                    child: Text(
                      isAnswerSubmitted ? "Continue" : "Submit",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExplanationThird extends StatefulWidget {
  const ExplanationThird({super.key});

  @override
  State<ExplanationThird> createState() => _ExplanationThirdState();
}

class _ExplanationThirdState extends State<ExplanationThird> {
  int _currentStep = 0;
  final Set<String> _selectedFocus = {};
  bool? _connectionAnswer;
  String? _step4Answer;
  bool _isProcessing = false;
  double _progressValue = 0.2;
  String? _feedback1;
  String? _feedback2;

  final Color _primaryGreen = const Color(0xFF2E7D32);
  final Color _lightGreen = const Color(0xFFE8F5E9);
  final Color _darkGreen = const Color(0xFF1B5E20);

  void _nextStep() {
    if (_currentStep == 1 &&
        (_selectedFocus.length < 2 ||
            !_selectedFocus.contains("flowers") ||
            !_selectedFocus.contains("painting"))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Please select the correct focus for both sentences to continue')),
      );
      return;
    }

    if (_currentStep == 2 && _connectionAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please answer the connection question')),
      );
      return;
    }

    if (_currentStep == 3 && _step4Answer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select why the sentence is wrong')),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
      _progressValue = (_currentStep + 1) * 0.2;
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        if (_currentStep < 4) {
          _currentStep++;
        } else {
          _completeAnalysis();
        }
      });
    });
  }

  void _completeAnalysis() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ThirdActyvityAnimation()),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: LinearProgressIndicator(
          value: _progressValue,
          backgroundColor: Colors.white.withOpacity(0.3),
          valueColor: AlwaysStoppedAnimation<Color>(_primaryGreen),
          minHeight: 8,
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("🔍 Step 1: Identify Referring Words",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20))),
        _buildProgressIndicator(),
        const SizedBox(height: 16),
        Card(
          elevation: 0,
          color: Colors.white.withOpacity(0.7),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Analyze each option:",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildReferenceItem("A) The meal → refers to dinner", true),
                _buildReferenceItem(
                    "B) The structure → refers to the castle", true),
                _buildReferenceItem(
                    "C) The painting → doesn't match flowers", false),
                _buildReferenceItem("D) The story → refers to the movie", true),
              ],
            ),
          ),
        ),
        const Spacer(),
        _buildContinueButton(label: "Continue to Option C"),
      ],
    );
  }

  Widget _buildReferenceItem(String text, bool isCorrect) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCorrect ? _lightGreen.withOpacity(0.5) : Colors.red[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isCorrect
                ? _primaryGreen.withOpacity(0.3)
                : Colors.red.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(isCorrect ? Icons.check_circle : Icons.error,
              color: isCorrect ? _primaryGreen : Colors.red, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _buildStep2() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "🎯 Step 2: Focus on Option C",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1B5E20),
        ),
      ),
      _buildProgressIndicator(),
      const SizedBox(height: 16),
      Expanded(
        child: SingleChildScrollView(
          child: Card(
            elevation: 0,
            color: Colors.white.withOpacity(0.7),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Text(
                    "Tap on what each sentence focuses on",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  _buildInteractiveSentence(
                    sentenceId: 1,
                    sentence: "Lisa bought flowers.",
                    words: ["Lisa", "bought", "flowers"],
                    target: "flowers",
                  ),
                  const SizedBox(height: 20),
                  _buildInteractiveSentence(
                    sentenceId: 2,
                    sentence: "The painting was colorful.",
                    words: ["The", "painting", "was", "colorful"],
                    target: "painting",
                  ),
                  const SizedBox(height: 20),
                  if (_selectedFocus.contains("flowers") &&
                      _selectedFocus.contains("painting"))
                    _buildFeedback(
                      true,
                      "Correct!\nFirst sentence: flowers\nSecond sentence: painting\n→ These are unrelated.",
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 16),
      if (_selectedFocus.contains("flowers") &&
          _selectedFocus.contains("painting"))
        _buildContinueButton(),
    ],
  );
}

  Widget _buildInteractiveSentence({
    required int sentenceId,
    required String sentence,
    required List<String> words,
    required String target,
  }) {
    final feedback = sentenceId == 1 ? _feedback1 : _feedback2;

    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 6,
          children: words.map((word) {
            final cleanWord =
                word.replaceAll(RegExp(r'[^\w]'), '').toLowerCase();
            final isTarget = cleanWord == target;
            final isSelected = _selectedFocus.contains(cleanWord);

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isTarget) {
                    _selectedFocus.add(cleanWord);
                    if (sentenceId == 1) {
                      _feedback1 = " Correct! '$word' is the main focus.";
                    } else {
                      _feedback2 = " Correct! '$word' is the main focus.";
                    }
                  } else {
                    if (sentenceId == 1) {
                      _feedback1 =
                          " '$word' is not the main focus. Try again!";
                    } else {
                      _feedback2 =
                          " '$word' is not the main focus. Try again!";
                    }
                  }
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected ? _primaryGreen : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: isSelected
                        ? _primaryGreen
                        : Colors.grey.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  word,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        /// Feedback under each sentence
        if (feedback != null) ...[
          const SizedBox(height: 10),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: _primaryGreen.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _primaryGreen.withOpacity(0.3)),
            ),
            child: Text(
              feedback,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("🔗 Step 3: Match Reference",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20))),
        _buildProgressIndicator(),
        const SizedBox(height: 16),
        Card(
          elevation: 0,
          color: Colors.white.withOpacity(0.7),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Text(
                  "Does the word \"Painting\" have an referential connection with \"Flower\" in the text?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                        child: _buildSimpleOption(
                            "Yes",
                            _connectionAnswer == true,
                            () => setState(() => _connectionAnswer = true))),
                    const SizedBox(width: 16),
                    Expanded(
                        child: _buildSimpleOption(
                            "No",
                            _connectionAnswer == false,
                            () => setState(() => _connectionAnswer = false))),
                  ],
                ),
                if (_connectionAnswer != null)
                  _buildFeedback(
                      _connectionAnswer == false,
                      _connectionAnswer == false
                          ? "“Painting” doesn’t have a clear connection to anything in the first sentence"
                          : "Think again. Did Lisa buy a painting?"),
                if (_connectionAnswer == false) ...[
                  const Divider(height: 32),
                  const Text(
                    "A proper reference should point back to something already mentioned",
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text("→ This one introduces new information ",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ],
              ],
            ),
          ),
        ),
        const Spacer(),
        if (_connectionAnswer == false) _buildContinueButton(),
      ],
    );
  }

  Widget _buildStep4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("🎯 Step 4: Confirm with Context",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20))),
        _buildProgressIndicator(),
        const SizedBox(height: 16),
        const Text(
            "Why is this sentence wrong?\n\"Lisa bought flowers. The painting was colorful.\"",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildOptionCard(
                    "A) A reference error: “the painting” has no prior reference.",
                    _step4Answer == "A",
                    true,
                    (val) => setState(() => _step4Answer = val)),
                _buildOptionCard(
                    "B) A verb tense error: the sentences use different past tenses.",
                    _step4Answer == "B",
                    false,
                    (val) => setState(() => _step4Answer = val)),
                _buildOptionCard(
                    "C) A agreement error: “flowers” is plural while “painting” is singular.",
                    _step4Answer == "C",
                    false,
                    (val) => setState(() => _step4Answer = val)),
                _buildOptionCard(
                    "D) No error: the sentences are perfectly fine.",
                    _step4Answer == "D",
                    false,
                    (val) => setState(() => _step4Answer = val)),
                if (_step4Answer != null)
                  _buildFeedback(
                      _step4Answer == "A",
                      _step4Answer == "A"
                          ? "There's no mention of any painting before. The sentence pair feels disconnected → anaphoric error"
                          : "Check the reference link between sentences."),
              ],
            ),
          ),
        ),
        if (_step4Answer == "A")
          _buildContinueButton(label: "See Final Analysis"),
      ],
    );
  }

  Widget _buildFinalStep() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("🏁 Final Analysis",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20))),
          _buildProgressIndicator(),
          const SizedBox(height: 16),
          Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.white.withOpacity(0.9),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(" Conclusion for Option C:",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green)),
                  const SizedBox(height: 12),
                  const Text("\"The painting was colorful.\"",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Divider(height: 32),
                  const Text("Key Problems:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                          fontSize: 16, color: Colors.black87, height: 1.4),
                      children: [
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                "\"Painting\" doesn't refer back to anything in the first sentence\n\n"),
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                "It breaks the expected reference link (anaphoric error)\n\n"),
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                "Proper references should point back to already mentioned elements"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow, color: Colors.black),
              label: const Text("Start Practice Exercises",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Color(0xFF4CAF50), width: 2)),
                elevation: 4,
              ),
              onPressed: _completeAnalysis,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSimpleOption(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? _primaryGreen : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _primaryGreen),
        ),
        child: Center(
          child: Text(label,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : _primaryGreen)),
        ),
      ),
    );
  }

  Widget _buildOptionCard(
      String text, bool isSelected, bool isCorrect, Function(String) onTap) {
    return GestureDetector(
      onTap: () => onTap(text.substring(0, 1)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect ? const Color(0xFFA5D6A7) : Colors.red[100])
              : Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: isSelected
                  ? (isCorrect ? _primaryGreen : Colors.red)
                  : Colors.transparent,
              width: 2),
        ),
        child: Row(
          children: [
            Expanded(
                child: Text(text,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500))),
            if (isSelected)
              Icon(isCorrect ? Icons.check_circle : Icons.cancel,
                  color: isCorrect ? _primaryGreen : Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedback(bool isCorrect, String message) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect
            ? _primaryGreen.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(isCorrect ? Icons.lightbulb : Icons.info_outline,
              color: isCorrect ? _primaryGreen : Colors.red),
          const SizedBox(width: 12),
          Expanded(
              child: Text(message,
                  style: TextStyle(
                      color: isCorrect ? _darkGreen : Colors.red[900],
                      fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget _buildContinueButton({String label = "Continue"}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isProcessing ? null : _nextStep,
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 4,
        ),
        child: _isProcessing
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2))
            : Text(label,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9), Color(0xFFA5D6A7)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.close, color: Colors.black54),
                        onPressed: () => Navigator.pop(context)),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: KeyedSubtree(
                        key: ValueKey(_currentStep),
                        child: _buildCurrentStep()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildStep1();
      case 1:
        return _buildStep2();
      case 2:
        return _buildStep3();
      case 3:
        return _buildStep4();
      case 4:
        return _buildFinalStep();
      default:
        return const SizedBox();
    }
  }
}

class PracticePageThird extends StatefulWidget {
  const PracticePageThird({super.key});

  @override
  State<PracticePageThird> createState() => _PracticePageThirdState();
}

class _PracticePageThirdState extends State<PracticePageThird>
    with SingleTickerProviderStateMixin {
  int currentQuestionIndex = 0;
  int? selectedOptionIndex;
  bool showFeedback = false;
  double progress = 0;

  int hintStep1 = 0;
  int hintStep2 = 0;
  int hintStep3 = 0;
  int hintStep4 = 0;

  Timer? _inactivityTimer;
  bool _isInactive = false;
  late AnimationController _glowController;

  final List<String> hints1 = [
    '💡 General Hint: Look for a reference that doesn’t match the subject.',
    '📌 More Specific: Is there a reference that doesn’t logically connect?',
  ];

  final List<String> hints2 = [
    '💡 General Hint: Look for a reference that doesn’t fit the subject.',
    '📌 More Specific: Is there something mentioned that doesn’t relate to the previous idea?',
  ];

  final List<String> hints3 = [
    '💡 General Hint: Check for a reference that doesn’t match the previous subject.',
    '📌 More Specific: Does the second sentence refer to something not mentioned earlier?',
  ];

  final List<String> hints4 = [
    '💡 General Hint: Look for a reference that doesn’t match the subject.',
    '📌 More Specific: Is the second sentence referring to something not connected to the first?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question": "which snetence contains a referential error?",
      "options": [
        "A) The wind blew strongly. The weather changed quickly.",
        "B) The team won the championship. The victory was celebrated.",
        "C) I wrote an email. The printer was very helpful.",
        "D) Her phone rang suddenly. The sound startled her."
      ],
      "correctIndex": 2,
      "feedback": [
        " The weather changing after the wind is logical.",
        " 'The victory' logically refers to the championship.",
        " Explanation: 'Printer' is unrelated to email writing.",
        " 'The sound' clearly refers to the phone ringing."
      ]
    },
    {
      "question": "Which sentence contains a problem with referential error?",
      "options": [
        "A) Sarah read an article. The text was informative.",
        "B) We saw the sunrise. The view was breathtaking.",
        "C) He fixed the sink. The solution was clear.",
        "D) The baby cried loudly. The report was confusing."
      ],
      "correctIndex": 3,
      "feedback": [
        " 'The text' clearly refers to the article.",
        " 'The view' refers to the sunrise.",
        " 'The solution' could reasonably relate to fixing the sink.",
        " Explanation: 'Report' doesn’t refer to anything mentioned."
      ]
    },
    {
      "question": "Which sentence contains a problem with referential error?",
      "options": [
        "A) I watched the concert. The music was amazing.",
        "B) He built a shelf. The project took all afternoon.",
        "C) Emily lost her umbrella. The jacket was soaked.",
        "D) The mountain was steep. The hike was exhausting."
      ],
      "correctIndex": 2,
      "feedback": [
        " 'The music' logically relates to the concert.",
        " A shelf-building task can be considered a project.",
        " Explanation: 'Jacket' isn’t connected to the umbrella unless clarified.",
        " 'The hike' logically relates to climbing a steep mountain."
      ]
    },
    {
      "question": "Which sentence contains a problem with referential error?",
      "options": [
        "A) She entered the contest. The event was well organized.",
        "B) The cake was delicious. The dessert was a success.",
        "C) My brother repaired the car. The airplane was expensive.",
        "D) They visited a museum. The experience was memorable."
      ],
      "correctIndex": 2,
      "feedback": [
        " 'The event' refers to the contest.",
        " 'The dessert' refers to the cake.",
        " Explanation: 'Airplane' is unrelated to the car in sentence C.",
        " 'The experience' refers to visiting the museum."
      ]
    }
  ];

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _startInactivityTimer();
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel();
    _glowController.dispose();
    super.dispose();
  }

  void _startInactivityTimer() {
    _inactivityTimer?.cancel();
    if (_isInactive) {
      setState(() {
        _isInactive = false;
      });
    }
    _inactivityTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && !showFeedback) {
        setState(() {
          _isInactive = true;
        });
      }
    });
  }

  void handleOptionTap(int index) {
    _startInactivityTimer();
    final correctIndex = questions[currentQuestionIndex]['correctIndex'];
    setState(() {
      selectedOptionIndex = index;
      showFeedback = true;
      if (index == correctIndex) {
        progress += 1 / questions.length;
      }
    });
  }

  void goToNextQuestion() {
    _startInactivityTimer();
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        // Lógica de fin de nivel (se mantiene igual)
        _showCompletionDialog();
        return;
      }
      selectedOptionIndex = null;
      showFeedback = false;
      hintStep1 = 0;
      hintStep2 = 0;
      hintStep3 = 0;
      hintStep4 = 0;
    });
  }

  void _showCompletionDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "LevelComplete",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox(); // Required for pageBuilder
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedValue =
            Curves.easeInOutBack.transform(animation.value) - 1.0;

        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * -50, 0.0),
          child: Opacity(
            opacity: animation.value,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 16,
              backgroundColor: const Color.fromARGB(255, 232, 255, 232),
              titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              title: Row(
                children: const [
                  Icon(Icons.emoji_events,
                      color: Color.fromARGB(255, 76, 175, 80), size: 30),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Level Complete!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 27, 94, 32),
                      ),
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "You've completed all the questions.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 56, 56, 56),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Get ready for the next challenge!",
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 85, 139, 47),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              actions: [
                TextButton.icon(
                  icon: const Icon(Icons.close),
                  label: const Text("Close"),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.green.shade700,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  label: const Text("Advance"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FinalPart1()),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    return;
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];
    final options = question['options'] as List<String>;
    final feedback = question['feedback'] as List<String>;
    final correctIndex = question['correctIndex'] as int;

    String? currentHint;
    int? currentHintIndex;

    if (currentQuestionIndex == 0 && hintStep1 < hints1.length) {
      currentHint = hints1[hintStep1];
      currentHintIndex = hintStep1;
    } else if (currentQuestionIndex == 1 && hintStep2 < hints2.length) {
      currentHint = hints2[hintStep2];
      currentHintIndex = hintStep2;
    } else if (currentQuestionIndex == 2 && hintStep3 < hints3.length) {
      currentHint = hints3[hintStep3];
      currentHintIndex = hintStep3;
    } else if (currentQuestionIndex == 3 && hintStep4 < hints4.length) {
      currentHint = hints4[hintStep4];
      currentHintIndex = hintStep4;
    }

    return Scaffold(
      // El fondo se define aquí para que sea estático y no se mueva con el scroll
      backgroundColor: const Color(0xFFE8F5E9),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9), // Verde muy suave
              Color(0xFFC8E6C9),
            ],
          ),
        ),
        child: SafeArea(
          child: GestureDetector(
            onTapDown: (_) => _startInactivityTimer(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Choose the right option",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      question['question'],
                      style: const TextStyle(
                          fontSize: 18, fontStyle: FontStyle.italic),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Opciones
                  for (int i = 0; i < options.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: ElevatedButton(
                        onPressed:
                            showFeedback ? null : () => handleOptionTap(i),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.9),
                          foregroundColor: Colors.black,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(options[i],
                              style: const TextStyle(fontSize: 16)),
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),

                  // FEEDBACK
                  if (showFeedback && selectedOptionIndex != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedOptionIndex == correctIndex
                              ? "✩ ${feedback[selectedOptionIndex!]}"
                              : " ${feedback[selectedOptionIndex!]}",
                          style: TextStyle(
                              fontSize: 18,
                              color: selectedOptionIndex == correctIndex
                                  ? const Color(0xFF1B5E20)
                                  : Colors.red),
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  selectedOptionIndex == correctIndex
                                      ? Colors.green.shade400
                                      : Colors.green.shade300,
                            ),
                            onPressed: selectedOptionIndex == correctIndex
                                ? goToNextQuestion
                                : () {
                                    setState(() {
                                      selectedOptionIndex = null;
                                      showFeedback = false;
                                    });
                                    _startInactivityTimer();
                                  },
                            child: Text(
                              selectedOptionIndex == correctIndex
                                  ? "Next"
                                  : "Try Again",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 30),

                  // BOTÓN DE PISTAS Y EFECTO BRILLANTE
// BOTÓN DE PISTAS Y EFECTO BRILLANTE
                  if (!showFeedback)
                    Row(
                      children: [
                        Column(
                          children: [
                            // El botón de la bombilla que siempre está ahí
                            IconButton(
                              icon: AnimatedBuilder(
                                animation: _glowController,
                                builder: (context, child) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: _isInactive
                                          ? [
                                              BoxShadow(
                                                color: Colors.yellow
                                                    .withOpacity(0.5 *
                                                        _glowController.value),
                                                blurRadius:
                                                    15 * _glowController.value,
                                                spreadRadius:
                                                    5 * _glowController.value,
                                              ),
                                            ]
                                          : [],
                                    ),
                                    child: Icon(
                                      Icons.lightbulb,
                                      color: _isInactive
                                          ? Colors.amber
                                          : const Color(0xFF3CB371),
                                      size: 40,
                                    ),
                                  );
                                },
                              ),
                              onPressed: () {
                                _startInactivityTimer();
                                setState(() {
                                  if (currentHintIndex != null) {
                                    if (currentQuestionIndex == 0) {
                                      hintStep1++;
                                    } else if (currentQuestionIndex == 1)
                                      // ignore: curly_braces_in_flow_control_structures
                                      hintStep2++;
                                    else if (currentQuestionIndex == 2)
                                      // ignore: curly_braces_in_flow_control_structures
                                      hintStep3++;
                                    else if (currentQuestionIndex == 3)
                                      // ignore: curly_braces_in_flow_control_structures
                                      hintStep4++;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),

                        // El texto de la pista si está activa
                        if (currentHint != null)
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.green),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      currentHint,
                                      style: const TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close, size: 20),
                                    onPressed: () {
                                      setState(() {
                                        if (currentQuestionIndex == 0) {
                                          hintStep1 = hints1.length;
                                        } else if (currentQuestionIndex == 1)
                                          // ignore: curly_braces_in_flow_control_structures
                                          hintStep2 = hints2.length;
                                        else if (currentQuestionIndex == 2)
                                          // ignore: curly_braces_in_flow_control_structures
                                          hintStep3 = hints3.length;
                                        else if (currentQuestionIndex == 3)
                                          // ignore: curly_braces_in_flow_control_structures
                                          hintStep4 = hints4.length;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
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

class FinalPartSummary extends StatelessWidget {
  const FinalPartSummary({super.key});

  Future<void> _completeFinalLevel(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // 🔥 Guarda en Firestore el paso básico
    await FirebaseFirestore.instance
        .collection('userProgress')
        .doc(user.uid)
        .set({'completedInstructionSpot1_1': true}, SetOptions(merge: true));

    // 💾 Guarda en local
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('spotCompletado', true);

    // 🔥 Guarda más progreso en Firestore (ej. conteo total)
    await _saveProgressToCloud(user);

    // 🧭 Navega a la pantalla principal y limpia el historial
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (route) => false,
    );
  }

  // 🔥 Guarda progreso extra en Firestore
  Future<void> _saveProgressToCloud(User user) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('userProgress').doc(user.uid).set({
      'completedInstructionSpot1_1': true, // Repetido por seguridad
      'completedSpotsCount': FieldValue.increment(1),
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9), // Verde muy claro
              Color(0xFFC8E6C9), // Verde suave
              Color(0xFFA5D6A7), // Verde un poco más intenso
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.emoji_events, size: 100, color: Colors.amber),
                const SizedBox(height: 12),
                const Text(
                  "Awesome job! Keep up the great work and you'll be a pro in no time! 🎉💪",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B5E20),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Card(
                  elevation: 0,
                  color: Colors.white.withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "To sum up...\n\nWriters often use variety in vocabulary.\n\n It's up to the reader to make the connection and understand when different words refer to the same thing. ",
                      style: TextStyle(
                          fontSize: 18, height: 1.5, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.home, color: Colors.white),
                    label: const Text(
                      "Back to Home",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () => _completeFinalLevel(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
