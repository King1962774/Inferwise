// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_2/Animation2_3.dart';
import 'package:inferwise/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InstructionSpotPage5 extends StatefulWidget {
  final String title;
  final List<String> instructions;
  final String tipTitle;
  final List<String> tips;
  final String finalNote;

  const InstructionSpotPage5({
    super.key,
    required this.title,
    required this.instructions,
    required this.tipTitle,
    required this.tips,
    required this.finalNote,
  });

  @override
  State<InstructionSpotPage5> createState() => _InstructionSpotPage5State();
}

class _InstructionSpotPage5State extends State<InstructionSpotPage5> {
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/Wallpapers/Wallpaper  Medals.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color:
                              Color.fromARGB(255, 39, 216, 193), // Azul claro
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Color(0xFF90CAF9)),
                        onPressed: _exit,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(seconds: 1),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6EE7D8)
                            .withOpacity(0.95), // Azul claro fondo
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        widget.instructions[_currentStep],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(
                              255, 0, 0, 0), // Azul oscuro para contraste
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 113, 221, 207), // Azul claro botón
                        minimumSize: const Size(140, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: Text(isLast ? "Start" : "Next"),
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
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> examples = [
    {
      'image': 'assets/Imagenes de ejemplos/Level2/2.4 A Lena.webp',
      'sentence': '💠 Lena winced after touching the boiling pot.',
      'explanation': '→ "Winced" means reacting in pain.',
    },
    {
      'image': 'assets/Imagenes de ejemplos/Level2/2.4 B Jake.webp',
      'sentence': '💠 Jake felt parched after running five miles.',
      'explanation': '→ "Parched" means very thirsty.',
    },
    {
      'image': 'assets/Imagenes de ejemplos/Level2/2.4 C Miguel.webp',
      'sentence': '💠 Miguel\'s legs ached after hiking the steep mountain.',
      'explanation':
          '→ "Steep" means difficult to climb.\n#️⃣ Context clues make it easy to understand new words by using the information around them!',
    },
    {
      'image': null,
      'sentence': 'Types of Context Clues:',
      'items': [
        {
          'title': 'Definition or Restatement:',
          'body':
              'The word is explained right after it.\nThe hike was treacherous, full of dangerous cliffs.',
        },
        {
          'title': 'Synonym Clues:',
          'body':
              'A similar word helps explain the unfamiliar word.\nThe hike was exhausting, making everyone feel drained.',
        },
      ],
    },
    {
      'image': null,
      'sentence': 'Types of Context Clues:',
      'items': [
        {
          'title': 'Antonym Clues:',
          'body':
              'A word with the opposite meaning helps clarify the unfamiliar word.\nUnlike the smooth path, the trail was rocky.',
        },
        {
          'title': 'Example Clues:',
          'body':
              'Specific examples help explain the word.\nHe was a pioneer, like the first astronauts to land on the moon.',
        },
      ],
    },
  ];

  void _goToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ThirdRoomPage()),
    );
  }

  void _exit() {
    Navigator.pop(context);
  }

  Widget _buildCard(Map<String, dynamic> example) {
    final String? image = example['image'];
    final String? sentence = example['sentence'];
    final String? explanation = example['explanation'];
    final List? items = example['items'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.88),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
              color: const Color(0xFF4DD0C4).withOpacity(0.45), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00897B).withOpacity(0.1),
              offset: const Offset(0, 6),
              blurRadius: 16,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen
              if (image != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    image,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
              ],

              // Sentence
              if (sentence != null) ...[
                Text(
                  sentence,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF00695C),
                    fontWeight: FontWeight.w600,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 6),
              ],

              // Explanation simple (slides con imagen)
              if (explanation != null)
                Text(
                  explanation,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    height: 1.6,
                  ),
                ),

              // Items con título destacado (slides de tipos)
              if (items != null) ...[
                const SizedBox(height: 8),
                ...items.map((item) => _buildTypeItem(
                      title: item['title'],
                      body: item['body'],
                    )),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeItem({required String title, required String body}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF00897B).withOpacity(0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF4DD0C4).withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título como badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFF00897B),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Cuerpo
          Text(
            body,
            style: const TextStyle(
              fontSize: 14.5,
              color: Colors.black87,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLast = _currentPage == examples.length - 1;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE0F7F4),
              Color(0xFFB2EBE5),
              Color(0xFF80CBC4),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Lexical inference",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00695C),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded,
                          color: Color(0xFF00897B)),
                      onPressed: _exit,
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Info card
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.65),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                        color: const Color(0xFF4DD0C4).withOpacity(0.4),
                        width: 1.5),
                  ),
                  child: const Text(
                    '🔎 What are Context Clues?\n\nContext clues are hints in the surrounding text that help us figure out what an unfamiliar word means.',
                    style: TextStyle(
                      fontSize: 14.5,
                      color: Color(0xFF00695C),
                      height: 1.45,
                    ),
                  ),
                ),

                // Carrusel
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: examples.length,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemBuilder: (context, index) {
                      return _buildCard(examples[index]);
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // Botón
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLast
                        ? _goToNextPage
                        : () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00897B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                      shadowColor: const Color(0xFF00695C).withOpacity(0.3),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        isLast ? "Continue →" : "Next example",
                        key: ValueKey(_currentPage),
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

  final List<String> steps = [
    '🔵 1. Read the Sentence Carefully\n\nSentence: "Jake felt parched after running five miles."',
    '🔵 2. Identify the Word to Analyze\n\nThe word to analyze: "parched" ',
    '🔵 3. Look for Context Clues\n\n-Jake ran a long distance (five miles).\n🏃‍♂️-Running makes you very thirsty. 💧',
    '🔵 4. Use Logic and World Knowledge\n\nFeeling "parched" after running suggests it means very thirsty.',
    '➡️ Lexical Inference:\n\n"Parched" means "very thirsty" based on the hint that Jake ran a long distance and would naturally need water.',
  ];

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

  /// Separa la primera línea (título) del resto y la renderiza en negrita
  Widget _buildStepText(String text) {
    final int newlineIndex = text.indexOf('\n');
    if (newlineIndex == -1) {
      return Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF00695C),
          height: 1.6,
        ),
      );
    }

    final String title = text.substring(0, newlineIndex);
    final String body = text.substring(newlineIndex + 1);

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00695C),
              height: 1.6,
            ),
          ),
          TextSpan(
            text: '\n$body',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE0F7F4),
              Color(0xFFB2EBE5),
              Color(0xFF80CBC4),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        " Step-by-Step",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00695C),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded,
                          color: Color(0xFF00897B), size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Context Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.65),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                        color: const Color(0xFF4DD0C4).withOpacity(0.4),
                        width: 1.5),
                  ),
                  child: const Text(
                    'Let\'s make a inference about this sentence using context clues:\n\n"Jake felt parched after running five miles."',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 15,
                      color: Color(0xFF00695C),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 14),

                Center(
                  child: const Text(
                    "✩ How to do it? ✩",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00695C),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 12),

                // Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(steps.length, (i) {
                    final isActive = i == _currentStep;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isActive ? 18 : 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFF00897B)
                            : const Color(0xFF80CBC4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 12),

                // Carousel
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) =>
                        setState(() => _currentStep = index),
                    itemCount: steps.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 8),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.88),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                              color: const Color(0xFF4DD0C4).withOpacity(0.45),
                              width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00897B).withOpacity(0.1),
                              offset: const Offset(0, 6),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Center(
                            child: _buildStepText(steps[index]),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Navigation Buttons
                Row(
                  children: [
                    if (_currentStep > 0)
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _goBack,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.5),
                            foregroundColor: const Color(0xFF00695C),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide(color: Color(0xFF00897B)),
                            ),
                            elevation: 0,
                          ),
                          child: const Text("Back",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    if (_currentStep > 0) const SizedBox(width: 16),
                    Expanded(
                      flex: 4,
                      child: ElevatedButton(
                        onPressed: _nextStep,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00897B),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 4,
                          shadowColor: const Color(0xFF00695C).withOpacity(0.3),
                        ),
                        child: Text(
                          isLast ? "Continue" : "Next",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F7F4), // turquesa muy claro
              Color(0xFFB2EBE5), // turquesa suave
              Color(0xFF80CBC4), // turquesa medio
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close_rounded,
                          color: Color(0xFF00897B), size: 28),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const MoreInfoPage()),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),

                const Spacer(),

                // Question Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.88),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                        color: const Color(0xFF4DD0C4).withOpacity(0.45),
                        width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00897B).withOpacity(0.1),
                        offset: const Offset(0, 4),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: const Column(
                    children: [
                      Text(
                        "Is everything clear, or would you like a quick recap?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00695C),
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Start()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00897B),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          shadowColor: const Color(0xFF00695C).withOpacity(0.3),
                        ),
                        child: const Text(
                          "Yes\n(continue with practice)",
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
                          backgroundColor: Colors.white.withOpacity(0.6),
                          foregroundColor: const Color(0xFF00695C),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: const BorderSide(
                                color: Color(0xFF00897B), width: 1.5),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "No\n(continue with reinforcement)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(flex: 2),
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE0F7F4),
              Color(0xFFB2EBE5),
              Color(0xFF80CBC4),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close_rounded,
                          size: 30, color: Color(0xFF00695C)),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Column(
                    children: [
                      // Main Info Card
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.88),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                              color: const Color(0xFF4DD0C4).withOpacity(0.45),
                              width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00897B).withOpacity(0.12),
                              offset: const Offset(0, 6),
                              blurRadius: 18,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.search,
                                    color: Color(0xFF00897B), size: 28),
                                SizedBox(width: 12),
                                Text(
                                  'Remember',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00695C),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Context clues are hints in the surrounding text that help us figure out the meaning of unfamiliar words.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              '📚 Examples:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00695C),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildContextExample(
                              sentence:
                                  'Sarah shuddered when the cold wind hit her face.',
                              explanation:
                                  '"Shuddered" means to react with a quick, involuntary movement due to discomfort or fear.',
                            ),
                            _buildContextExample(
                              sentence:
                                  'After hours of dancing, Carlos felt fatigued.',
                              explanation: '"Fatigued" means extremely tired.',
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE0F7F4).withOpacity(0.6),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: const Color(0xFF4DD0C4)
                                        .withOpacity(0.4)),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.info_outline,
                                      color: Color(0xFF00897B), size: 20),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Context clues help you understand new words by analyzing nearby details.',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF00695C),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Next Button
                      SizedBox(
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
                            backgroundColor: const Color(0xFF00897B),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 4,
                            shadowColor:
                                const Color(0xFF00695C).withOpacity(0.3),
                          ),
                          icon: const Icon(Icons.arrow_forward,
                              color: Colors.white),
                          label: const Text(
                            'Next',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContextExample({
    required String sentence,
    required String explanation,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: const Color(0xFF4DD0C4).withOpacity(0.45), width: 1),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.circle, size: 8, color: Color(0xFF00897B)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    sentence,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Text(
                '✩ $explanation',
                style: const TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF00695C),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReinforcentPage extends StatefulWidget {
  const ReinforcentPage({super.key});

  @override
  State<ReinforcentPage> createState() => _ReinforcentPageState();
}

class _ReinforcentPageState extends State<ReinforcentPage> {
  final List<String> steps = [
    '🔷 1. Read the sentence carefully.',
    '🔷 2. Find the tricky word.',
    '🔷 3. Look for clues around it (definition, synonym, antonym, examples).',
    '🔷 4. Use logic and context to guess the meaning.',
    '➡️ Inference: Context clues help you unlock new word meanings!',
  ];

  void _finish() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Start(),
      ),
    );
  }

  void _exit() {
    Navigator.pop(context);
  }

  /// Separa la primera línea (título) del resto y la renderiza en negrita
  Widget _buildStepText(String text) {
    final int newlineIndex = text.indexOf('\n');
    if (newlineIndex == -1) {
      return Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF00695C),
          height: 1.4,
        ),
      );
    }
    final String title = text.substring(0, newlineIndex);
    final String body = text.substring(newlineIndex + 1);
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00695C),
              height: 1.4,
            ),
          ),
          TextSpan(
            text: '\n$body',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(""),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close_rounded,
                size: 30, color: Color(0xFF00695C)),
            onPressed: _exit,
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE0F7F4),
              Color(0xFFB2EBE5),
              Color(0xFF80CBC4),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "✩ Step-by-Step ✩",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00695C),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  itemCount: steps.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(18),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.88),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: const Color(0xFF4DD0C4).withOpacity(0.45),
                            width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00897B).withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: _buildStepText(steps[index]),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _finish,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00897B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                      shadowColor: const Color(0xFF00695C).withOpacity(0.3),
                    ),
                    child: const Text(
                      "Continue to Practice",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
    question:
        'After the long hike, I was feeling completely _______ from the heat, so I quickly drank some water.',
    options: ["A) Tired", "B) Parched ", "C) Hungry", "D) Relaxed"],
    correctIndex: 1,
    explanation:
        '✔️ Explanation: “Parched” means very thirsty, so the word fits well with the context of heat and thirst.',
    incorrectExplanations: [
      'Don\'t worry\'s is a common error',
      '',
      'Don\'t worry\'s is a common error',
      'Don\'t worry\'s is a common error',
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
              Color(0xFFE0F7F4),
              Color(0xFFB2EBE5),
              Color(0xFF80CBC4),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close_rounded,
                          size: 28, color: Color(0xFF00897B)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Question card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 28),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF4DB6AC),
                        Color(0xFF00695C),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF00695C),
                        blurRadius: 16,
                        offset: Offset(0, 6),
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

                // Opciones
                Expanded(
                  child: AbsorbPointer(
                    absorbing: isAnswerSubmitted,
                    child: ListView.builder(
                      itemCount: question.options.length,
                      itemBuilder: (context, i) {
                        bool isSelected = selected == i;

                        Color bgColor;
                        Color borderColor;
                        Color textColor;

                        if (isAnswerSubmitted && isSelected) {
                          bgColor = isCorrect == true
                              ? const Color(0xFFE0F7F4)
                              : const Color(0xFFFFEBEE);
                          borderColor = isCorrect == true
                              ? const Color(0xFF00897B)
                              : const Color(0xFFEF9A9A);
                          textColor = isCorrect == true
                              ? const Color(0xFF00695C)
                              : Colors.red.shade800;
                        } else if (isSelected) {
                          bgColor = const Color(0xFF00897B);
                          borderColor = const Color(0xFF00695C);
                          textColor = Colors.white;
                        } else {
                          bgColor = Colors.white;
                          borderColor = const Color(0xFF4DD0C4);
                          textColor = Colors.black87;
                        }

                        return GestureDetector(
                          onTap: () => setState(() => selected = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: borderColor, width: 2),
                            ),
                            child: Text(
                              question.options[i],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: textColor,
                              ),
                            ),
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
                          ? const Color(0xFFE0F7F4)
                          : const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isCorrect == true
                            ? const Color(0xFF00897B)
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
                              ? const Color(0xFF00897B)
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
                                      ? const Color(0xFF00695C)
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

                // Botón Submit / Continue
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isAnswerSubmitted
                        ? _continue
                        : selected != null
                            ? _submitAnswer
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00897B),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 4,
                      shadowColor: const Color(0xFF00695C),
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

class ExplanationFirst extends StatefulWidget {
  const ExplanationFirst({super.key});

  @override
  State<ExplanationFirst> createState() => _ExplanationFirstState();
}

class _ExplanationFirstState extends State<ExplanationFirst>
    with SingleTickerProviderStateMixin {
  int _currentStep = 0;
  String? _selectedAnswer;
  double _progressValue = 0.2;
  late AnimationController _animationController;
  bool _correctAnswer = false;
  // ignore: unused_field
  bool? _confirmationAnswer;

  // Blue color scheme matching your preference
  final Color _primaryColor = const Color(0xFF00897B); // turquesa profundo
  final Color _darkBlue = const Color(0xFF00695C); // turquesa oscuro
  final Color _accentColor = const Color(0xFF4DB6AC); // turquesa medio
  final Color _lightBlue = const Color(0xFFB2EBE5); // turquesa suave
  final Color _lightBlueBg = const Color(0xFFE0F7F4); // turquesa muy claro
  final Color _softBlue = const Color(0xFF80CBC4); // turquesa medio-claro
  final Color _successColor = const Color(0xFF4CAF50);
  final Color _warningColor = const Color(0xFFFF9800);
  final Color _purpleColor = const Color(0xFF9C27B0);
  final Color _yellowColor = const Color(0xFFFFC107);

  // Interactive states
  bool _cluesAnalyzed = false;
  final List<String> _cluesList = [];
  final Map<String, bool> _clueMeanings = {
    'Indicates rest after physical activity': false,
    'Shows enjoyment of the activity': false,
    'Points to physical reaction to heat/exhaustion': false,
    'Suggests relaxation at home': false,
  };

  // Context clues pieces
  final List<String> _selectedClues = [];

  // Word examples
  // ignore: unused_field
  final List<Map<String, dynamic>> _clueExamples = [
    {
      'clue': 'Long hike',
      'meaning': 'Indicates tiredness',
      'color': Colors.blue
    },
    {
      'clue': 'From the heat',
      'meaning': 'Shows cause of discomfort',
      'color': Colors.orange
    },
    {
      'clue': 'Quickly drank water',
      'meaning': 'Shows urgent need to hydrate',
      'color': Colors.green
    },
    {
      'clue': 'After',
      'meaning': 'Indicates time relationship',
      'color': Colors.purple
    },
  ];

  // Sentence options
  late List<Map<String, dynamic>> _sentenceOptions = [
    {
      'word': 'Tired',
      'explanation':
          'Makes sense after a hike, but doesn\'t connect to drinking water',
      'color': Colors.grey
    },
    {
      'word': 'Parched',
      'explanation': 'Means very thirsty, perfect fit with clues',
      'color': _successColor
    },
    {
      'word': 'Hungry',
      'explanation': 'If hungry, you\'d eat, not drink',
      'color': Colors.red
    },
    {
      'word': 'Relaxed',
      'explanation':
          'Opposite of what\'s happening - you don\'t rush to drink when relaxed',
      'color': Colors.blue
    },
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _sentenceOptions = [
      {
        'word': 'Tired',
        'explanation':
            'Makes sense after a hike, but doesn\'t connect to drinking water',
        'color': Colors.grey,
      },
      {
        'word': 'Parched',
        'explanation': 'Means very thirsty, perfect fit with clues',
        'color': _successColor, //  AHORA SÍ
      },
      {
        'word': 'Hungry',
        'explanation': 'If hungry, you\'d eat, not drink',
        'color': Colors.red,
      },
      {
        'word': 'Relaxed',
        'explanation':
            'Opposite of what\'s happening - you don\'t rush to drink when relaxed',
        'color': Colors.blue,
      },
    ];
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _nextStep() {
    setState(() {
      _progressValue = (_currentStep + 1) * 0.2;
    });

    _animationController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 400), () {
        setState(() {
          if (_currentStep < 4) {
            _currentStep++;
            _animationController.reset();
            _resetInteractiveStates();
          } else {
            _completeActivity();
          }
        });
      });
    });
  }

  void _resetInteractiveStates() {
    _cluesAnalyzed = false;
    _cluesList.clear();
    _clueMeanings.forEach((key, value) {
      _clueMeanings[key] = false;
    });
    _selectedClues.clear();
    _selectedAnswer = null;
    _correctAnswer = false;
    _confirmationAnswer = null;
  }

  Widget _buildProgressIndicator() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return LinearProgressIndicator(
          value: Tween<double>(
            begin: _progressValue - 0.2,
            end: _progressValue,
          ).animate(_animationController).value,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        );
      },
    );
  }

  Widget _buildStep1() {
    String getFeedbackMessage(String meaning) {
      if (meaning == "Points to physical reaction to heat/exhaustion") {
        return "Correct! The sentence mentions 'from the heat' and drinking water quickly, indicating a physical reaction.";
      } else if (meaning == "Indicates rest after physical activity") {
        return "Not quite. While a hike is an activity, the focus is on the reaction to heat, not just resting.";
      } else if (meaning == "Shows enjoyment of the activity") {
        return "The sentence doesn't mention if they enjoyed it, but it does show they were affected by the heat.";
      } else {
        return "Try again. Look for clues about how the person is feeling and what they did to feel better.";
      }
    }

    String? selectedMeaning;
    _clueMeanings.forEach((key, value) {
      if (value == true) selectedMeaning = key;
    });

    // Colores agua marina
    const Color tealDark = Color(0xFF00695C);
    const Color tealMid = Color(0xFF00897B);
    const Color tealLight = Color(0xFF4DD0C4);
    const Color tealPale = Color(0xFFE0F7F4);

    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 30.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              // Título
              Text(
                "📖 Step 1: Read the Whole Sentence",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: tealDark,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 16),

              // ── Sentence + opciones en una sola Card ──────────────────────
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.88),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                      color: tealLight.withOpacity(0.45), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: tealMid.withOpacity(0.1),
                      offset: const Offset(0, 6),
                      blurRadius: 16,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sentence banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00897B), Color(0xFF4DD0C4)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: tealMid.withOpacity(0.25),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.5,
                          ),
                          children: [
                            const TextSpan(
                                text:
                                    "After the long hike, I was feeling completely "),
                            WidgetSpan(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                child: const Text(
                                  "_____",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const TextSpan(
                                text:
                                    " from the heat, so I quickly drank some water."),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Pregunta
                    Text(
                      "What is the sentence about?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: tealDark,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Opciones — columna completa, sin Wrap
                    Column(
                      children: _clueMeanings.keys.map((meaning) {
                        bool isSelected = _clueMeanings[meaning]!;
                        bool isCorrect = meaning ==
                            "Points to physical reaction to heat/exhaustion";

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _clueMeanings.forEach((key, _) {
                                _clueMeanings[key] = false;
                              });
                              _clueMeanings[meaning] = true;
                              _cluesAnalyzed = isCorrect;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? (isCorrect
                                      ? const Color(0xFF00897B).withOpacity(0.1)
                                      : Colors.red.withOpacity(0.08))
                                  : tealPale.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected
                                    ? (isCorrect ? tealMid : Colors.red)
                                    : tealLight.withOpacity(0.5),
                                width: 2,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: isCorrect
                                            ? tealMid.withOpacity(0.18)
                                            : Colors.red.withOpacity(0.15),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    meaning,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: tealDark,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Icon(
                                    isCorrect
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: isCorrect ? tealMid : Colors.red,
                                    size: 22,
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    // Feedback
                    if (selectedMeaning != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: (selectedMeaning ==
                                      "Points to physical reaction to heat/exhaustion"
                                  ? tealMid
                                  : Colors.orange)
                              .withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: selectedMeaning ==
                                    "Points to physical reaction to heat/exhaustion"
                                ? tealMid
                                : Colors.orange,
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  selectedMeaning ==
                                          "Points to physical reaction to heat/exhaustion"
                                      ? Icons.emoji_events
                                      : Icons.info_outline,
                                  color: selectedMeaning ==
                                          "Points to physical reaction to heat/exhaustion"
                                      ? tealMid
                                      : Colors.orange,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  selectedMeaning ==
                                          "Points to physical reaction to heat/exhaustion"
                                      ? "Correct Analysis!"
                                      : "Feedback:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: tealDark,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              getFeedbackMessage(selectedMeaning!),
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Key Observations Card ─────────────────────────────────────
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.88),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                      color: tealLight.withOpacity(0.45), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: tealMid.withOpacity(0.1),
                      offset: const Offset(0, 6),
                      blurRadius: 16,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Key Observations:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: tealDark,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _buildObservationItem(
                        "📍", "Location/Activity:", "Outdoors, hiking in heat"),
                    _buildObservationItem(
                        "⚡", "Action Taken:", "Drinking water quickly"),
                    _buildObservationItem("🎯", "Likely Feeling:",
                        "Physical discomfort from heat"),
                    _buildObservationItem("💧", "Clue Connection:",
                        "Quick water drinking → thirst"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── Botón ─────────────────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor:
                        _cluesAnalyzed ? tealMid : Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: _cluesAnalyzed ? 4 : 0,
                    shadowColor: tealDark.withOpacity(0.3),
                  ),
                  onPressed: _cluesAnalyzed ? _nextStep : null,
                  child: const Text(
                    "Analyze Context Clues ➡️",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildObservationItem(String emoji, String title, String content) {
    const Color tealDark = Color(0xFF00695C);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$title ',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: tealDark,
                    ),
                  ),
                  TextSpan(
                    text: content,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
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

  Widget _buildStep2() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 30.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              Text(
                "🔍 Step 2: Identify Context Clues",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),

              // Visual ilustrativo
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [_lightBlue, Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(color: _primaryColor, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: _primaryColor.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Context Clues",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: _darkBlue,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Pay attention to the hints in the sentence",
                              style: TextStyle(
                                fontSize: 16,
                                color: _darkBlue,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Card informativa (no interactiva)
              Card(
                elevation: 6,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Key Context Clues in the Sentence",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildClueReadOnly(
                        icon: Icons.directions_walk,
                        color: Colors.blue,
                        title: "Long hike",
                        description: "Shows physical effort and tiredness.",
                      ),
                      _buildClueReadOnly(
                        icon: Icons.wb_sunny,
                        color: Colors.orange,
                        title: "From the heat",
                        description: "Explains the cause of discomfort.",
                      ),
                      _buildClueReadOnly(
                        icon: Icons.water_drop,
                        color: Colors.green,
                        title: "Quickly drank water",
                        description:
                            "Strong hint of extreme thirst or dehydration.",
                      ),
                    ],
                  ),
                ),
              ),

              // Clue Analysis (ya era lectura, se queda igual)
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Clue Analysis:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildClueAnalysis(
                          "Long hike", "The person is tired or affected."),
                      _buildClueAnalysis(
                          "From the heat", "The cause — it was hot."),
                      _buildClueAnalysis("Quickly drank water",
                          "Key clue! You drink water quickly when you are very thirsty."),
                    ],
                  ),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: _primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                  ),
                  onPressed: _nextStep,
                  child: const Text(
                    "Evaluate Answer Options ➡️",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  Widget _buildClueReadOnly({
    required IconData icon,
    required Color color,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _darkBlue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getClueColor(String clue) {
    if (clue.contains('hike')) return Colors.blue;
    if (clue.contains('heat')) return Colors.orange;
    if (clue.contains('water')) return Colors.green;
    return _primaryColor;
  }

  Widget _buildClueAnalysis(String clue, String analysis) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getClueColor(clue).withOpacity(0.1),
              border: Border.all(color: _getClueColor(clue), width: 2),
            ),
            child: Center(
              child: Text(
                "🔍",
                style: TextStyle(
                  fontSize: 18,
                  color: _getClueColor(clue),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clue,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _darkBlue,
                  ),
                ),
                Text(
                  analysis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? _selectedClue;
  bool _showHint = false;
  // Practice Challenge (Step 3)
  final bool _challengeAnswered = false;
// Clue correcta
  final String _correctClue = "could be damaged";
  bool get _canProceed {
    return _correctAnswer ||
        (_challengeAnswered && _selectedClue == _correctClue);
  }

  Widget _buildStep3() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmall = constraints.maxWidth < 360;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 500),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 30,
                  child: FadeInAnimation(child: widget),
                ),
                children: [
                  /// 🔹 TÍTULO
                  Text(
                    "🎯 Step 3: Evaluate Options",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildProgressIndicator(),
                  const SizedBox(height: 20),

                  /// 🔹 OPCIONES
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Choose the best word:",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: _darkBlue,
                            ),
                          ),
                          const SizedBox(height: 16),

                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: isSmall ? 1 : 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: isSmall ? 2.8 : 1.25,
                            ),
                            itemCount: _sentenceOptions.length,
                            itemBuilder: (context, index) {
                              final option = _sentenceOptions[index];
                              final isSelected =
                                  _selectedAnswer == option['word'];
                              final isCorrect = option['word'] == 'Parched';

                              return _buildOptionCard(
                                option,
                                isSelected,
                                isCorrect,
                              );
                            },
                          ),

                          /// 🔹 HINT PROGRESIVO
                          if (_selectedAnswer == null)
                            TextButton.icon(
                              onPressed: () {
                                setState(() => _showHint = !_showHint);
                              },
                              icon: const Icon(Icons.lightbulb_outline),
                              label: const Text("Need a hint?"),
                            ),

                          if (_showHint)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                "Hint: Think about what your body needs most after heat.",
                                style: TextStyle(
                                  color: Colors.orange[700],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 🔹 FEEDBACK
                  if (_selectedAnswer != null) _buildFeedbackSection(),

                  /// 🔹 REFLEXIÓN FINAL
                  if (_canProceed) _buildReflectionBox(),

                  const SizedBox(height: 20),

                  if (_canProceed)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _nextStep,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          backgroundColor: _primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          "Vocabulary Expansion ➡️",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget _buildClueChip(String text) {
    final selected = _selectedClue == text;

    return ChoiceChip(
      label: Text(text),
      selected: selected,
      onSelected: (_) {
        setState(() => _selectedClue = text);
      },
      selectedColor: _accentColor.withOpacity(0.2),
    );
  }

  Widget _buildReflectionBox() {
    return Card(
      color: _successColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "🧠 Think About It:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Next time you see actions like drinking, running, or searching — ask yourself: what need does this action reveal?",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    Map<String, dynamic> option,
    bool isSelected,
    bool isCorrect,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAnswer = option['word'] as String;
          _correctAnswer = isCorrect;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect
                  ? _successColor.withOpacity(0.12)
                  : Colors.red.withOpacity(0.12))
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? (isCorrect ? _successColor : Colors.red)
                : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: isCorrect
                        ? _successColor.withOpacity(0.25)
                        : Colors.red.withOpacity(0.25),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            /// ICONO
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: option['color'] as Color,
              ),
              child: Center(
                child: Text(
                  option['word'].toString().substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            /// TEXTO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    option['word'] as String,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    option['explanation'] as String,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            if (isSelected)
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? _successColor : Colors.red,
                size: 26,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackSection() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Card(
        key: ValueKey(_selectedAnswer),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: _correctAnswer
            ? _successColor.withOpacity(0.12)
            : _warningColor.withOpacity(0.12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _correctAnswer ? Icons.check_circle : Icons.help_outline,
                    color: _correctAnswer ? _successColor : _warningColor,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _correctAnswer ? "Correct Choice!" : "Let's Analyze",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                _getAnswerFeedback(_selectedAnswer!),
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
              if (!_correctAnswer) ...[
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectedAnswer = null;
                      });
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text("Try Again"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  String _getAnswerFeedback(String selected) {
    switch (selected) {
      case 'Thirsty':
        return "Not quite. While 'thirsty' relates to needing water, it doesn't fully capture the extreme dryness implied by the context clues.";
      case 'Dehydrated':
        return "Close! 'Dehydrated' indicates a lack of water, but it is more of a medical term and doesn't fit as naturally in this context.";
      case 'Arid':
        return "Good try! 'Arid' describes dry conditions, often of land, but it doesn't directly describe a person's state of thirst.";
      case 'Parched':
        return "Excellent! 'Parched' perfectly captures the extreme thirst suggested by the context clues in the sentence.";
      default:
        return "";
    }
  }

  Widget _buildStep4() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 30,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              /// 🔹 TITLE
              Text(
                "📚 Step 4: Vocabulary Expansion",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),

              /// 🔹 MAIN CARD
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 🔹 MAIN WORD
                      Center(child: _buildMainWord()),
                      const SizedBox(height: 25),

                      /// 🔹 MEANING
                      Text(
                        "Meaning & Usage",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 15),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightBlue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _primaryColor),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                _buildVocabCard(
                                  "Definition",
                                  "Extremely thirsty",
                                  "After the long hike, he was parched.",
                                ),
                                const SizedBox(width: 1),
                                _buildVocabCard(
                                  "Part of Speech",
                                  "Adjective",
                                  "Parched describes a condition or state.",
                                ),
                                const SizedBox(width: 1),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Origin: from 'parch' — to dry out with heat",
                              style: TextStyle(
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      /// 🔹 SYNONYMS
                      Text(
                        "Synonyms",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildSynonymChip("Thirsty"),
                          _buildSynonymChip("Dehydrated"),
                          _buildSynonymChip("Arid"),
                          _buildSynonymChip("Waterless"),
                          _buildSynonymChip("Dry"),
                        ],
                      ),

                      const SizedBox(height: 25),

                      /// 🔹 EXAMPLES
                      Text(
                        "Example Sentences",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 12),

                      _buildExampleSentence(
                        "After running the marathon, my throat was completely parched.",
                        "Sports context",
                      ),
                      _buildExampleSentence(
                        "The parched earth cracked under the intense summer sun.",
                        "Environmental context",
                      ),
                      _buildExampleSentence(
                        "She felt parched and reached for her water bottle.",
                        "Personal experience",
                      ),

                      const SizedBox(height: 20),

                      /// 🔹 EXPRESSION
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _yellowColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: _yellowColor),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.lightbulb, color: _yellowColor),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                "Expression: 'Parched as a desert' — extremely dry",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// 🔹 PRACTICE
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Practice Creating Sentences",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Choose the best word using context clues:",
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 20),
                      _buildPracticeSentence(
                        "The spicy food made my mouth feel _____, so I drank water.",
                        ["burning", "fiery", "parched"],
                      ),
                      _buildPracticeSentence(
                        "After hours under the sun, Maria felt _____ and tired.",
                        ["parched", "sweaty", "dehydrated"],
                      ),
                      _buildPracticeSentence(
                        "The _____ land hadn't seen rain in months.",
                        ["parched", "dry", "arid"],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// 🔹 NEXT
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: _primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Final Analysis ➡️",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  Widget _buildMainWord() {
    return GestureDetector(
      onTap: _showMainWordDetail,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_purpleColor, Colors.deepPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: _purpleColor.withOpacity(0.5),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Text(
          "PARCHED",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2.5,
          ),
        ),
      ),
    );
  }

  void _showMainWordDetail() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Main Word Detail",
      barrierColor: Colors.black.withOpacity(0.55),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.88,
              padding: const EdgeInsets.all(26),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 25,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _purpleColor.withOpacity(0.15),
                          ),
                          child: Icon(
                            Icons.water_drop_outlined,
                            size: 40,
                            color: _purpleColor,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          "PARCHED",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: _darkBlue,
                            letterSpacing: 1.8,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "/pɑːrtʃt/ • adjective",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// Meaning
                  _infoSection(
                    title: "Meaning",
                    icon: Icons.menu_book_outlined,
                    content:
                        "Parched means extremely thirsty or completely dry, often as a result of heat, lack of water, or prolonged physical activity.",
                  ),

                  const SizedBox(height: 16),

                  /// Usage
                  _infoSection(
                    title: "Usage",
                    icon: Icons.edit_outlined,
                    content:
                        "It can describe both people and environments. When used for people, it emphasizes an urgent need for water. When used for places, it highlights extreme dryness.",
                  ),

                  const SizedBox(height: 16),

                  /// Tip
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: _yellowColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: _yellowColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.lightbulb_outline, color: _yellowColor),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            "Tip: 'Parched' is stronger than 'thirsty' and often used for emphasis or vivid description.",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  /// Example
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.format_quote, color: _accentColor),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          "After hours in the sun, the hikers were completely parched.",
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 26),

                  /// Close
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Continue Learning",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, animation, __, child) {
        return Transform.scale(
          scale: Curves.easeOutBack.transform(animation.value),
          child: Opacity(
            opacity: animation.value,
            child: child,
          ),
        );
      },
    );
  }

  Widget _infoSection({
    required String title,
    required IconData icon,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _accentColor.withOpacity(0.15),
          ),
          child: Icon(icon, color: _accentColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _darkBlue,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVocabCard(String title, String content, String example) {
    return Expanded(
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(title),
              content: Text(example),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _lightBlue),
          ),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _darkBlue,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Tap for example",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSynonymChip(String word) {
    return ChoiceChip(
      label: Text(word),
      selected: false,
      backgroundColor: _lightBlue.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onSelected: (_) {
        _showSynonymDetail(word);
      },
    );
  }

  void _showSynonymDetail(String word) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Synonym Detail",
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.menu_book_rounded,
                          size: 40,
                          color: _primaryColor,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          word.toUpperCase(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: _darkBlue,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Synonym of “Parched”",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Explanation Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _lightBlue.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: _lightBlue),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Meaning",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: _darkBlue,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _getSynonymExplanation(word),
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Example
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline, color: _yellowColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _getSynonymExample(word),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// Close Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Got it!",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, animation, __, child) {
        return Transform.scale(
          scale: Curves.easeOutBack.transform(animation.value),
          child: Opacity(
            opacity: animation.value,
            child: child,
          ),
        );
      },
    );
  }

  String _getSynonymExplanation(String word) {
    switch (word.toLowerCase()) {
      case "thirsty":
        return "Thirsty refers to the physical need or desire to drink liquids, especially water. Unlike 'parched', it can describe both mild and extreme dryness.";
      case "dehydrated":
        return "Dehydrated describes a condition where the body lacks sufficient water, often due to heat, exercise, or illness. It is more clinical than 'parched'.";
      case "arid":
        return "Arid is commonly used to describe dry climates or land with little rainfall, rather than a person.";
      case "dry":
        return "Dry is a general term that can describe the absence of moisture in objects, environments, or the body.";
      default:
        return "This word shares a similar meaning with 'parched', emphasizing dryness or lack of moisture.";
    }
  }

  String _getSynonymExample(String word) {
    switch (word.toLowerCase()) {
      case "thirsty":
        return "Example: After the long hike, everyone felt thirsty and searched for water.";
      case "dehydrated":
        return "Example: The athlete became dehydrated after training in extreme heat.";
      case "arid":
        return "Example: Very few plants survive in the arid desert climate.";
      case "dry":
        return "Example: The soil was dry after weeks without rain.";
      default:
        return "This synonym can be used in similar contexts to 'parched'.";
    }
  }

  Widget _buildExampleSentence(String sentence, String context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      leading: const Icon(Icons.chat_bubble_outline),
      title: Text(
        sentence,
        style: const TextStyle(fontStyle: FontStyle.italic),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            "Context: $context",
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }

  Widget _buildPracticeSentence(String sentence, List<String> options) {
    String? selected;

    return StatefulBuilder(
      builder: (context, setLocal) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _lightBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(sentence),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: options.map((word) {
                  return ChoiceChip(
                    label: Text(word),
                    selected: selected == word,
                    onSelected: (_) {
                      setLocal(() => selected = word);
                    },
                  );
                }).toList(),
              ),
              if (selected != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    selected == "parched"
                        ? " Correct!"
                        : "🤔 Try again using context",
                    style: TextStyle(
                      color:
                          selected == "parched" ? _successColor : Colors.orange,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStep5() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "🏆 Final Analysis: Context Clues Mastery",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _darkBlue,
            ),
          ),

          _buildProgressIndicator(),
          const SizedBox(height: 16),

          // Final Answer Card
          Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Final Answer Title
                  Text(
                    " Final Answer:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Answer
                  Text(
                    "B) Parched",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue,
                    ),
                    textAlign: TextAlign.left,
                  ),

                  const Divider(height: 32),

                  // Complete Sentence
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _lightBlue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 18,
                            color: _darkBlue,
                            height: 1.4,
                          ),
                          children: [
                            const TextSpan(
                                text:
                                    "After the long hike, I was feeling completely "),
                            TextSpan(
                              text: "parched",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _successColor,
                                backgroundColor: _successColor.withOpacity(0.1),
                              ),
                            ),
                            const TextSpan(
                                text:
                                    " from the heat, so I quickly drank some water."),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const Divider(height: 32),

                  // Explanation Title
                  Text(
                    "Detailed Explanation:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue,
                    ),
                  ),
                  const SizedBox(height: 12),

                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        color: _darkBlue,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(
                          text: "1. ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "We used context clues to analyze the sentence.\n\n",
                        ),
                        TextSpan(
                          text: "2. ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "Clues found: \"from the heat\" and \"quickly drank water\"\n\n",
                        ),
                        TextSpan(
                          text: "3. ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "These clues indicate the speaker was experiencing heat exhaustion and dehydration.\n\n",
                        ),
                        TextSpan(
                          text: "4. ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "The logical conclusion: extreme thirst → need for \"parched\".",
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 32),

                  // Clue Analysis Summary
                  Text(
                    "Context Clues Used:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _lightBlue.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.search, color: _primaryColor),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                "\"After the long hike\" → Indicates tiredness/affectation",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.whatshot, color: _primaryColor),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                "\"From the heat\" → Identifies the cause of discomfort",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.water_drop, color: _primaryColor),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                "\"Quickly drank water\" → Shows urgent need for hydration",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Why Context Clues Matter
          Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "🔍 Why Context Clues Matter:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        label: const Text("Understand unfamiliar words"),
                        backgroundColor: Colors.blue.withOpacity(0.1),
                      ),
                      Chip(
                        label: const Text("Improve reading comprehension"),
                        backgroundColor: Colors.green.withOpacity(0.1),
                      ),
                      Chip(
                        label: const Text("Make logical inferences"),
                        backgroundColor: Colors.orange.withOpacity(0.1),
                      ),
                      Chip(
                        label: const Text("Succeed in tests and real life"),
                        backgroundColor: Colors.purple.withOpacity(0.1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Skills you practiced: Word analysis, logical reasoning, vocabulary building",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Final Button
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.celebration, color: Colors.white),
              label: const Text(
                "Complete Activity",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _successColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              onPressed: _completeActivity,
            ),
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
  Widget _buildStrategyStep(String number, String step) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _primaryColor,
            ),
            child: Center(
              child: Text(
                number.substring(0, 1),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              step,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  void _completeActivity() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Second(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_lightBlueBg, _softBlue, const Color(0xFF90CAF9)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: IndexedStack(
              index: _currentStep,
              children: [
                _buildStep1(),
                _buildStep2(),
                _buildStep3(),
                _buildStep4(),
                _buildStep5(),
              ],
            ),
          ),
        ),
      ),
    );
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
    '💡 General Hint: Look at the words “rocky” and “harder” — what do they suggest about the path?',
    '📌 More Specific: Think about which word describes something difficult to climb or walk on.',
    '🧐 Little Explanation: One of the other choices is the opposite of what the sentence says — use that to help eliminate it!'
  ];

  final List<String> hints2 = [
    '💡 General Hint:  Focus on the phrase “help us understand its meaning” — which option is about explaining something clearly?',
    '📌 More Specific: The teacher reworded the new word — which choice describes that action?',
    '🧐 Little Explanation: Think about which option clarifies or simplifies the meaning of the word without introducing a new concept.'
  ];

  final List<String> hints3 = [
    '💡 General Hint: The context suggests that his face showed a reaction to pain — which word fits with that feeling?',
    '📌 More Specific: The phrase "in pain" gives us a clue — what word describes a reaction to pain?',
    '🧐 Little Explanation: Look for a word that suggests a physical reaction when someone feels pain.'
  ];

  final List<String> hints4 = [
    '💡 General Hint: The forest is described as full of dangers — which word suggests something dangerous?',
    '📌 More Specific: The word "dangers" points to a place that is unsafe — look for a word that fits that idea.',
    '🧐 Little Explanation: If the forest has wild animals and steep hills, what word could describe such a risky environment?'
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "The rocky path was very ______, making the hike much harder than expected.",
      "options": ["A) Steep", "B) Easy", "C) Smooth", "D) Long"],
      "correctIndex": 0,
      "feedback": [
        " Correct! “Steep” describes a difficult incline, making the path harder to climb.",
        " “Easy” is the opposite of what’s meant here — the hike was hard, not easy.",
        " “Smooth” would mean the path was flat and even, which doesn’t match 'much harder than expected.'",
        " “Long” refers to distance, not difficulty. The sentence focuses on the difficulty, not the length."
      ]
    },
    {
      "question":
          "The teacher gave us a ______ of the new word to help us understand its meaning.",
      "options": [
        "A) Description",
        "B) Restatement",
        "C) Antonym",
        "D) Synonym"
      ],
      "correctIndex": 1,
      "feedback": [
        " “Description” may provide information but doesn't always explain the meaning clearly.",
        " Correct! A “restatement” is when a word is clarified using simpler words or phrases.",
        " “Antonym” means the opposite — that doesn’t help explain a word’s meaning.",
        " “Synonym” is a similar word, but not necessarily a clear explanation or definition."
      ]
    },
    {
      "question":
          "His facial expression showed that he was in ______ pain after touching the boiling pot.",
      "options": ["A) Happy", "B) Nice", "C) Winced", "D) Bottom"],
      "correctIndex": 2,
      "feedback": [
        " “Happy” is not appropriate here — he’s in pain, not joy.",
        " “Nice” doesn’t relate to pain or facial expressions.",
        " Correct! “Winced” means to react quickly in pain, often with the face. It fits perfectly here.",
        " “Bottom” refers to a physical position or place, not an emotional or physical reaction."
      ]
    },
    {
      "question":
          "The ______ forest was full of dangers, like wild animals and steep hills.",
      "options": ["A) Gentle", "B) Treacherous", "C) Boring", "D) Safe"],
      "correctIndex": 1,
      "feedback": [
        " “Gentle” suggests softness and safety — the opposite of a dangerous forest.",
        " Correct! “Treacherous” means dangerous or risky — perfect for wild animals and steep hills.",
        " “Boring” doesn’t fit — the forest is clearly dangerous, not dull.",
        " “Safe” contradicts the clues about dangers in the forest."
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
              backgroundColor: const Color(0xFFE0F7F4), // _lightBlueBg
              titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              title: Row(
                children: const [
                  Icon(Icons.emoji_events,
                      color: Color(0xFF4DB6AC), size: 30), // _accentBlue
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Level Complete!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF00695C), // _primaryBlue
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
                      color: Color(0xFF37474F),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Get ready for the next challenge!",
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF00897B), // _deepBlue
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
                    foregroundColor: const Color(0xFF00897B), // _deepBlue
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  label: const Text("Advance"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4DB6AC), // _accentBlue
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
      backgroundColor: const Color(0xFFE0F7F4), // _lightBlueBg
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F7F4), // _lightBlueBg
              Color(0xFFB2EBE5), // _softBlue
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
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF4DB6AC)), // _accentBlue
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Choose the right option",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00695C), // _primaryBlue
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
                        Text(
                          selectedOptionIndex == correctIndex
                              ? "✩ ${feedback[selectedOptionIndex!]}"
                              : " ${feedback[selectedOptionIndex!]}",
                          style: TextStyle(
                              fontSize: 18,
                              color: selectedOptionIndex == correctIndex
                                  ? const Color(0xFF00695C) // _primaryBlue
                                  : const Color(0xFFD32F2F)),
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  selectedOptionIndex == correctIndex
                                      ? const Color(0xFF4DB6AC) // _accentBlue
                                      : const Color(0xFFB2EBE5), // _softBlue
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
                            child: const Text(
                              "Next",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
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
                                                color: const Color(
                                                        0xFF4DB6AC) // _accentBlue
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
                                          ? const Color(
                                              0xFF4DB6AC) // _accentBlue
                                          : const Color(
                                              0xFF80CBC4), // turquesa suave
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
                                      hintStep2++;
                                    else if (currentQuestionIndex == 2)
                                      hintStep3++;
                                    else if (currentQuestionIndex == 3)
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
                                border: Border.all(
                                    color:
                                        const Color(0xFF4DB6AC)), // _accentBlue
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
                                          hintStep2 = hints2.length;
                                        else if (currentQuestionIndex == 2)
                                          hintStep3 = hints3.length;
                                        else if (currentQuestionIndex == 3)
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
  //Ponerse al dia
  QuestionData(
    question:
        'The arid desert had no water, and the plants were all dry and brittle.\n\nWhich part of the sentence helps you understand the word "arid"?',
    options: ["A) The desert", "B) No water", "C) Plants", "D) Brittle"],
    correctIndex: 1,
    explanation: '✔️ Explanation: “No water” tells us that “arid” means dry.',
    incorrectExplanations: [
      'Don\'t worry\'s is a common error',
      '',
      'Don\'t worry\'s is a common error',
      'Don\'t worry\'s is a common error',
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
              Color(0xFFE0F7F4),
              Color(0xFFB2EBE5),
              Color(0xFF80CBC4),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close_rounded,
                          size: 28, color: Color(0xFF00897B)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Question card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 28),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF4DB6AC),
                        Color(0xFF00695C),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF00695C),
                        blurRadius: 16,
                        offset: Offset(0, 6),
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

                // Opciones
                Expanded(
                  child: AbsorbPointer(
                    absorbing: isAnswerSubmitted,
                    child: ListView.builder(
                      itemCount: question.options.length,
                      itemBuilder: (context, i) {
                        bool isSelected = selected == i;

                        Color bgColor;
                        Color borderColor;
                        Color textColor;

                        if (isAnswerSubmitted && isSelected) {
                          bgColor = isCorrect == true
                              ? const Color(0xFFE0F7F4)
                              : const Color(0xFFFFEBEE);
                          borderColor = isCorrect == true
                              ? const Color(0xFF00897B)
                              : const Color(0xFFEF9A9A);
                          textColor = isCorrect == true
                              ? const Color(0xFF00695C)
                              : Colors.red.shade800;
                        } else if (isSelected) {
                          bgColor = const Color(0xFF00897B);
                          borderColor = const Color(0xFF00695C);
                          textColor = Colors.white;
                        } else {
                          bgColor = Colors.white;
                          borderColor = const Color(0xFF4DD0C4);
                          textColor = Colors.black87;
                        }

                        return GestureDetector(
                          onTap: () => setState(() => selected = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: borderColor, width: 2),
                            ),
                            child: Text(
                              question.options[i],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: textColor,
                              ),
                            ),
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
                          ? const Color(0xFFE0F7F4)
                          : const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isCorrect == true
                            ? const Color(0xFF00897B)
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
                              ? const Color(0xFF00897B)
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
                                      ? const Color(0xFF00695C)
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

                // Botón Submit / Continue
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isAnswerSubmitted
                        ? _continue
                        : selected != null
                            ? _submitAnswer
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00897B),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 4,
                      shadowColor: const Color(0xFF00695C),
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

class ExplanationSecond extends StatefulWidget {
  const ExplanationSecond({super.key});

  @override
  State<ExplanationSecond> createState() => _ExplanationSecondState();
}

class _ExplanationSecondState extends State<ExplanationSecond>
    with TickerProviderStateMixin {
  int _currentStep = 0;
  String? _selectedAnswer;
  double _progressValue = 0.2;
  late AnimationController _animationController;
  bool _correctAnswer = false;
  // ignore: unused_field
  bool? _confirmationAnswer;

  // Desert color scheme - adjusted from blue to desert tones
  final Color _primaryColor =
      const Color(0xFF00897B); // turquesa profundo // Desert orange
  final Color _darkBrown =
      const Color.fromARGB(255, 139, 90, 43); // Dark desert brown
  final Color _accentColor = const Color(0xFF4DB6AC); // turquesa medio
  final Color _lightSand =
      const Color.fromARGB(255, 249, 229, 195); // Light sand
  final Color _successColor =
      const Color.fromARGB(255, 76, 175, 80); // Green oasis
  final Color _warningColor =
      const Color.fromARGB(255, 255, 152, 0); // Warning orange
  final Color _infoColor = const Color(0xFF00897B); // Sky blue
  final Color _lightBlueBg = const Color(0xFFE0F7F4); // turquesa muy claro
  final Color _softBlue = const Color(0xFF80CBC4); // turquesa medio-claro

  // Interactive states
  final List<String> _cluesList = [];
  late final Map<String, bool> _sentenceTopics = {
    'A lush, tropical forest': false,
    'A desert full of wildlife': false,
    'A place with no water and dry plants': true,
    'A desert with lots of lakes': false,
  };

  // Context clues pieces
  final List<String> _cluePieces = [
    'No water',
    'Dry plants',
    'Brittle',
    'Desert'
  ];
  final List<String> _selectedClues = [];
  bool _cluesCompleted = false;

  // Word examples for "arid"
  // ignore: unused_field
  late List<Map<String, dynamic>> _aridExamples = [
    {
      'sentence': 'The arid climate made farming impossible.',
      'meaning': 'Dry climate prevents agriculture',
      'color': Colors.orange
    },
    {
      'sentence': 'Arid lands stretch for miles without vegetation.',
      'meaning': 'Dry lands lack plants',
      'color': Colors.brown
    },
    {
      'sentence': 'Water conservation is crucial in arid regions.',
      'meaning': 'Dry areas need water saving',
      'color': _infoColor
    },
    {
      'sentence': 'The arid soil cracked under the intense sun.',
      'meaning': 'Dry soil breaks apart',
      'color': Colors.amber
    },
  ];

  // Answer options for clue identification
  late List<Map<String, dynamic>> _clueOptions = [
    {
      'option': 'The desert',
      'explanation': 'Tells us where we are, but not what "arid" means',
      'color': Colors.grey
    },
    {
      'option': 'No water',
      'explanation': 'Best clue that explains "arid" = very dry',
      'color': _successColor
    },
    {
      'option': 'Plants',
      'explanation': 'Not specific enough. Plants can be in any environment',
      'color': Colors.blue
    },
    {
      'option': 'Brittle',
      'explanation':
          'Description caused by being arid — not a definition itself',
      'color': Colors.orange
    },
  ];

  // Vocabulary expansion
  // ignore: unused_field
  final List<Map<String, dynamic>> _synonyms = [
    {'word': 'Dry', 'strength': 'Moderate', 'example': 'Dry weather'},
    {'word': 'Parched', 'strength': 'Strong', 'example': 'Parched land'},
    {
      'word': 'Barren',
      'strength': 'Very Strong',
      'example': 'Barren landscape'
    },
    {
      'word': 'Desiccated',
      'strength': 'Extreme',
      'example': 'Desiccated remains'
    },
    {'word': 'Dehydrated', 'strength': 'Medical', 'example': 'Dehydrated soil'},
  ];

  // Desert facts
  final List<Map<String, dynamic>> _desertFacts = [
    {
      'fact': 'Deserts cover about 1/3 of Earth\'s land surface',
      'icon': Icons.public
    },
    {
      'fact': 'The Sahara is the largest hot desert in the world',
      'icon': Icons.thermostat
    },
    {
      'fact': 'Some deserts are actually cold (like Antarctica)',
      'icon': Icons.ac_unit
    },
    {
      'fact': 'Desert plants have special adaptations to conserve water',
      'icon': Icons.park
    },
  ];

  String? _selectedTopic;
  bool _showFeedback = false;

  final Map<String, Map<String, String>> _topicFeedback = {
    "A story about people feeling thirsty": {
      "opinion": "This option focuses on people rather than the environment.",
      "explanation":
          "The sentence never mentions people or emotions. It talks about a desert and plants, not human thirst.",
    },
    "A place with no water and dry plants": {
      "opinion": "This is the strongest interpretation of the sentence.",
      "explanation":
          "The sentence clearly states 'no water' and 'dry and brittle plants', which describes an extremely dry environment.",
    },
    "A cold environment with frozen land": {
      "opinion": "Cold environments behave very differently from deserts.",
      "explanation":
          "Nothing in the sentence suggests cold, ice, or freezing temperatures. The clues point to heat and dryness.",
    },
    "A healthy environment full of life": {
      "opinion": "This option contradicts the clues in the sentence.",
      "explanation":
          "Words like 'arid' and 'dry and brittle' show that life is struggling, not thriving.",
    },
  };
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    // ===== CONTROLLER GENERAL (ya lo usabas) =====
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // ===== CONTROLLER SOLO PARA EL GLOW =====
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(
      begin: 0.3,
      end: 0.8,
    ).animate(
      CurvedAnimation(
        parent: _glowController,
        curve: Curves.easeInOut,
      ),
    );

    // ===== EJEMPLOS DE "ARID" =====
    _aridExamples = [
      {
        'sentence': 'The arid climate made farming impossible.',
        'meaning': 'Dry climate prevents agriculture',
        'color': Colors.orange,
      },
      {
        'sentence': 'Arid lands stretch for miles without vegetation.',
        'meaning': 'Dry lands lack plants',
        'color': Colors.brown,
      },
      {
        'sentence': 'Water conservation is crucial in arid regions.',
        'meaning': 'Dry areas need water saving',
        'color': _infoColor,
      },
      {
        'sentence': 'The arid soil cracked under the intense sun.',
        'meaning': 'Dry soil breaks apart',
        'color': Colors.amber,
      },
    ];

    // ===== MINI EVALUACIÓN (CLUES) =====
    _clueOptions = [
      {
        'option': 'The desert',
        'explanation': 'Tells us where we are, but not what "arid" means',
        'color': Colors.grey,
      },
      {
        'option': 'No water',
        'explanation': 'Best clue that explains "arid" = very dry',
        'color': _successColor,
      },
      {
        'option': 'Plants',
        'explanation': 'Not specific enough. Plants can exist in many places',
        'color': Colors.blue,
      },
      {
        'option': 'Brittle',
        'explanation': 'A result of being arid, not the definition itself',
        'color': Colors.orange,
      },
    ];
  }

  @override
  void dispose() {
    _animationController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _nextStep() {
    // 🚨 SI YA ES EL ÚLTIMO STEP → COMPLETAR ACTIVIDAD
    if (_currentStep >= 4) {
      _completeActivity();
      return;
    }

    // 🔄 ACTUALIZAMOS STEP Y PROGRESO
    setState(() {
      _currentStep++;
      _progressValue = (_currentStep + 1) * 0.2;
      _resetInteractiveStates();
    });

    // 🎬 REPRODUCIMOS ANIMACIÓN SOLO ENTRE STEPS
    _animationController
      ..reset()
      ..forward();
  }

  void _resetInteractiveStates() {
    _cluesList.clear();
    _sentenceTopics.forEach((key, value) {
      _sentenceTopics[key] = false;
    });
    _selectedClues.clear();
    _cluesCompleted = false;
    _selectedAnswer = null;
    _correctAnswer = false;
    _confirmationAnswer = null;
  }

  Widget _buildProgressIndicator() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return LinearProgressIndicator(
          value: Tween<double>(
            begin: _progressValue - 0.2,
            end: _progressValue,
          ).animate(_animationController).value,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        );
      },
    );
  }

  bool _showAridInfo = false;

  Widget _buildStep1() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 30.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              Text(
                "🏜️ Step 1: Explore the Sentence",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBrown,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),

              /// SENTENCE CARD
              Card(
                elevation: 6,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      /// SCENE
                      Container(
                        height: 190,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [_lightSand, const Color(0xFFEBCCA2)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.96),
                              borderRadius: BorderRadius.circular(14),
                              border:
                                  Border.all(color: _primaryColor, width: 2),
                            ),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: _darkBrown,
                                  height: 1.5,
                                ),
                                children: [
                                  const TextSpan(text: "The "),
                                  TextSpan(
                                    text: "arid",
                                    style: TextStyle(
                                      color: _primaryColor,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        setState(() {
                                          _showAridInfo = !_showAridInfo;
                                        });
                                      },
                                  ),
                                  const TextSpan(text: " desert had "),
                                  TextSpan(
                                    text: "no water",
                                    style: TextStyle(
                                      color: _infoColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                      text: ", and the plants were "),
                                  TextSpan(
                                    text: "dry and brittle.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.brown,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      /// ARID INFO
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _showAridInfo
                            ? Container(
                                key: const ValueKey("aridInfo"),
                                margin: const EdgeInsets.only(top: 18),
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: _infoColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(14),
                                  border:
                                      Border.all(color: _infoColor, width: 1.5),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.menu_book,
                                            color: _infoColor),
                                        const SizedBox(width: 8),
                                        Text(
                                          "Word Focus: arid",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: _darkBrown,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      "Arid means extremely dry — an area with very little or no rainfall.",
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                      "💡 Context clues here:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text("• no water"),
                                    const Text("• dry and brittle plants"),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),

                      const SizedBox(height: 25),

                      /// QUESTION
                      Text(
                        "What is this sentence mainly describing?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBrown,
                        ),
                      ),
                      const SizedBox(height: 15),

                      /// OPTIONS
                      Column(
                        children: _topicFeedback.keys.map((topic) {
                          final bool isSelected = _selectedTopic == topic;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedTopic = topic;
                                _showFeedback = false;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? _lightSand.withOpacity(0.35)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected
                                      ? _primaryColor
                                      : Colors.grey[300]!,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        isSelected ? _primaryColor : _lightSand,
                                    child: Text(
                                      topic.substring(0, 1),
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : _darkBrown,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Text(
                                      topic,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: _darkBrown,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      if (_selectedTopic != null)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              backgroundColor: _selectedTopic != null
                                  ? _infoColor
                                  : Colors.grey[400],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: _selectedTopic != null ? 4 : 0,
                              shadowColor: _infoColor.withOpacity(0.3),
                            ),
                            onPressed: () {
                              setState(() {
                                _showFeedback = true;
                              });
                            },
                            child: const Text(
                              "Check My Thinking",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                      /// FEEDBACK
                      if (_showFeedback && _selectedTopic != null)
                        Container(
                          margin: const EdgeInsets.only(top: 18),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _selectedTopic ==
                                    "A place with no water and dry plants"
                                ? _successColor.withOpacity(0.15)
                                : Colors.red.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: _selectedTopic ==
                                      "A place with no water and dry plants"
                                  ? _successColor
                                  : Colors.red,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _topicFeedback[_selectedTopic]!["opinion"]!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _topicFeedback[_selectedTopic]!["explanation"]!,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              /// NEXT
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: _primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Hunt for Context Clues ➡️",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  Widget _buildStep2() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 30.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              Text(
                "🔍 Step 2: Detective Work - Find the Clues",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBrown,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),

              // Magnifying Glass Investigation
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [_lightSand, Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(color: _primaryColor, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: _primaryColor.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ARID",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: _darkBrown,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "What does it mean?",
                              style: TextStyle(
                                fontSize: 16,
                                color: _darkBrown,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Interactive Clue Collection
              Card(
                elevation: 6,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Collect Context Clues from the Sentence:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBrown,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Clue Cards Grid
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: _cluePieces.map((clue) {
                          bool isSelected = _selectedClues.contains(clue);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  _selectedClues.remove(clue);
                                  _cluesList.remove(clue);
                                } else {
                                  _selectedClues.add(clue);
                                  _cluesList.add(clue);
                                }
                                _cluesCompleted = _selectedClues.length == 4;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? _getClueColor(clue)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: isSelected
                                      ? _getClueColor(clue)
                                      : _lightSand,
                                  width: 2,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: _getClueColor(clue)
                                              .withOpacity(0.3),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _getClueIcon(clue),
                                    size: 32,
                                    color: isSelected
                                        ? Colors.white
                                        : _getClueColor(clue),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    clue,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Colors.white
                                          : _darkBrown,
                                    ),
                                  ),
                                  if (isSelected)
                                    const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Icon(Icons.check,
                                          size: 16, color: Colors.white),
                                    ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 20),

                      if (_cluesList.isNotEmpty)
                        Column(
                          children: [
                            Text(
                              "Clues Collected:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: _darkBrown,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: _cluesList.map((clue) {
                                return Chip(
                                  label: Text(
                                    clue,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor: _getClueColor(clue),
                                  avatar: Icon(_getClueIcon(clue), size: 16),
                                );
                              }).toList(),
                            ),
                          ],
                        ),

                      const SizedBox(height: 20),

                      if (_cluesCompleted)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _successColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: _successColor, width: 2),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.done_all, color: _successColor),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Excellent Detective Work! 🕵️‍♂️",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: _darkBrown,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "You found all 4 key context clues that help explain 'arid'.",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Clue Analysis Guide
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Clue Analysis Guide:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkBrown,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildClueAnalysis(
                          "No water",
                          "Direct evidence of dryness",
                          "This is the strongest clue!"),
                      _buildClueAnalysis("Dry plants", "Result of no water",
                          "Plants suffer without moisture"),
                      _buildClueAnalysis(
                          "Brittle",
                          "Physical state due to dryness",
                          "Things break easily when dry"),
                      _buildClueAnalysis("Desert",
                          "Environment known for dryness", "Sets the scene"),
                    ],
                  ),
                ),
              ),

              // Desert Facts Interlude
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "🏜️ Desert Facts:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkBrown,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _desertFacts.length,
                          itemBuilder: (context, index) {
                            final fact = _desertFacts[index];
                            return Container(
                              width: 200,
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: _lightSand,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: _primaryColor.withOpacity(0.3)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(fact['icon'] as IconData,
                                      color: _primaryColor),
                                  const SizedBox(height: 8),
                                  Text(
                                    fact['fact'] as String,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor:
                        _cluesCompleted ? _primaryColor : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                  ),
                  onPressed: _cluesCompleted ? _nextStep : null,
                  child: const Text(
                    "Analyze Clue Effectiveness ➡️",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  Color _getClueColor(String clue) {
    if (clue.contains('water')) return _infoColor;
    if (clue.contains('Dry')) return Colors.brown;
    if (clue.contains('Brittle')) return Colors.amber;
    if (clue.contains('Desert')) return _primaryColor;
    return _accentColor;
  }

  IconData _getClueIcon(String clue) {
    if (clue.contains('water')) return Icons.water_drop_outlined;
    if (clue.contains('Dry')) return Icons.park;
    if (clue.contains('Brittle')) return Icons.breakfast_dining;
    if (clue.contains('Desert')) return Icons.landscape;
    return Icons.lightbulb;
  }

  Widget _buildClueAnalysis(String clue, String effect, String explanation) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _getClueColor(clue).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _getClueColor(clue).withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getClueColor(clue).withOpacity(0.2),
              border: Border.all(color: _getClueColor(clue)),
            ),
            child: Center(
              child: Icon(_getClueIcon(clue),
                  size: 20, color: _getClueColor(clue)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clue,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _darkBrown,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  effect,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  explanation,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep3() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 30.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              Text(
                "🎯 Step 3: Evaluate the Clues",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBrown,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),
              Card(
                elevation: 6,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: _lightSand,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: _primaryColor, width: 2),
                          ),
                          child: Text(
                            "Which clue best explains 'arid'?",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: _darkBrown,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Options Grid with Analysis
                      Column(
                        children: _clueOptions.map((option) {
                          bool isSelected = _selectedAnswer == option['option'];
                          bool isCorrect = option['option'] == 'No water';

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedAnswer = option['option'] as String;
                                _correctAnswer = isCorrect;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? (isCorrect
                                        ? _successColor.withOpacity(0.1)
                                        : Colors.red.withOpacity(0.1))
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: isSelected
                                      ? (isCorrect ? _successColor : Colors.red)
                                      : Colors.grey[300]!,
                                  width: 2,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: isSelected
                                              ? (isCorrect
                                                  ? _successColor
                                                      .withOpacity(0.2)
                                                  : Colors.red.withOpacity(0.2))
                                              : Colors.transparent,
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: option['color'] as Color,
                                        ),
                                        child: Text(
                                          option['option']
                                              .toString()
                                              .substring(0, 1),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: Text(
                                          option['option'] as String,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: _darkBrown,
                                          ),
                                        ),
                                      ),
                                      if (isSelected)
                                        Icon(
                                          isCorrect
                                              ? Icons.check_circle
                                              : Icons.cancel,
                                          color: isCorrect
                                              ? _successColor
                                              : Colors.red,
                                          size: 24,
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 45),
                                    child: Text(
                                      option['explanation'] as String,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 25),

                      if (_selectedAnswer != null)
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: Column(
                            key: ValueKey(_selectedAnswer),
                            children: [
                              Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                color: _correctAnswer
                                    ? _successColor.withOpacity(0.1)
                                    : _warningColor.withOpacity(0.1),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            _correctAnswer
                                                ? Icons.emoji_events
                                                : Icons.psychology,
                                            color: _correctAnswer
                                                ? _successColor
                                                : _warningColor,
                                            size: 28,
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            _correctAnswer
                                                ? " Perfect Reason! "
                                                : " Try again! ",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: _darkBrown,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        _getClueAnalysis(_selectedAnswer!),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              if (!_correctAnswer)
                                ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      _selectedAnswer = null;
                                    });
                                  },
                                  icon: const Icon(Icons.autorenew,
                                      color: Colors.white),
                                  label: const Text("Try Another Clue"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _accentColor,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 24),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                      if (_correctAnswer) ...[
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _successColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: _successColor),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.lightbulb_outline,
                                  color: _successColor),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Text(
                                  "You've mastered context clue analysis! 'No water' is the direct definitional clue for 'arid'.",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (_correctAnswer)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      backgroundColor: _primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 5,
                    ),
                    onPressed: _nextStep,
                    child: const Text(
                      "Expand Vocabulary ➡️",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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

  String _getClueAnalysis(String option) {
    switch (option) {
      case 'The desert':
        return "'The desert' tells us the location, but deserts can have water (oases) or be cold. It doesn't specifically define 'arid'.";
      case 'No water':
        return "Perfect! 'No water' is the most direct clue. 'Arid' means having little or no rain, and 'no water' directly explains this meaning.";
      case 'Plants':
        return "'Plants' alone doesn't help - plants exist everywhere. The description 'dry and brittle' is what matters, not just 'plants'.";
      case 'Brittle':
        return "'Brittle' describes the result of being arid (things become brittle when dry), but it's not the definition itself.";
      default:
        return "Look for the clue that most directly explains what the word means, not just describes the situation.";
    }
  }

  // ignore: unused_element
  Widget _buildClueStrength(String rank, String clue, String explanation) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _lightSand,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Text(
            rank,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clue,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _darkBrown,
                  ),
                ),
                Text(
                  explanation,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _showAridDeepInfo = false;

// Mini evaluation
  final Map<int, int> _quizAnswers = {};
  bool _quizCompleted = false;
  int _quizScore = 0;

  Widget _buildStep4() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 30,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              Text(
                "📚 Step 4: Vocabulary Oasis",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBrown,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),

              _buildAridWordCard(),
              _buildUsageActivity(),
              _buildFillInActivity(),
              _buildComparisonActivity(),

              _buildMiniEvaluation(),

              const SizedBox(height: 20),

              ///  SOLO APARECE CUANDO TERMINA LA EVALUACIÓN
              if (_quizCompleted)
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        backgroundColor: _primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "Final Mastery ➡️",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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

  Widget _buildAridWordCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ===== CENTERED GLOW BUTTON =====
            Center(
              child: AnimatedBuilder(
                animation: _glowAnimation,
                builder: (context, child) {
                  return GestureDetector(
                    onTap: () {
                      setState(() => _showAridDeepInfo = !_showAridDeepInfo);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 34, vertical: 18),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            _primaryColor,
                            const Color(0xFFA56B2C),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: _primaryColor.withOpacity(
                              _glowAnimation.value,
                            ),
                            blurRadius: 30,
                            spreadRadius: 4,
                          ),
                          BoxShadow(
                            color: Colors.orange.withOpacity(
                              _glowAnimation.value * 0.6,
                            ),
                            blurRadius: 45,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: const Text(
                        "ARID",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // ===== EXPANDABLE INFO =====
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.1),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: _showAridDeepInfo
                  ? Container(
                      key: const ValueKey("info"),
                      margin: const EdgeInsets.only(top: 24),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _lightSand.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _primaryColor),
                      ),
                      child: const Text(
                        "🌵 Arid describes places with extreme and long-lasting dryness, "
                        "especially regions or climates.\n\n"
                        "🕒 It refers to conditions that exist over time — not something that "
                        "becomes dry for a moment.\n\n"
                        "✔ arid desert, arid region\n"
                        "✘ arid glass, arid clothes",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsageActivity() {
    return _activityCard(
      title: "🧠 Correct Usage",
      question: "Which sentence uses *arid* correctly?",
      options: const [
        "The arid towel scratched my skin.",
        "The region has an arid climate with little rain.",
        "She drank arid water after running."
      ],
      correctIndex: 1,
      quizIndex: 0,
      explanation: "Arid is used for climates or land, not objects or liquids.",
    );
  }

  Widget _buildFillInActivity() {
    return _activityCard(
      title: "🧩 Complete the Sentence",
      question: "The Atacama Desert is extremely ___ because it rarely rains.",
      options: const ["humid", "arid", "wet"],
      correctIndex: 1,
      quizIndex: 1,
      explanation:
          "Arid describes long-term lack of rain in regions or climates.",
    );
  }

  Widget _buildComparisonActivity() {
    return _activityCard(
      title: "🔍 Arid vs Dry",
      question: "After years without rain, the land became ___.",
      options: const ["dry", "arid"],
      correctIndex: 1,
      quizIndex: 2,
      explanation: "Arid implies long-term dryness, especially in geography.",
    );
  }

  Widget _buildMiniEvaluation() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "🏁 Mini Evaluation",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      backgroundColor: _selectedTopic != null
                          ? _infoColor
                          : Colors.grey[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: _selectedTopic != null ? 4 : 0,
                      shadowColor: _infoColor.withOpacity(0.3),
                    ),
                    onPressed: () {
                      setState(() {
                        _quizScore = 0;
                        if (_quizAnswers[0] == 1) _quizScore++;
                        if (_quizAnswers[1] == 1) _quizScore++;
                        if (_quizAnswers[2] == 1) _quizScore++;
                        _quizCompleted = true;
                      });
                    },
                    child: const Text(
                      "Check My Thinking",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                if (_quizCompleted) ...[
                  const SizedBox(height: 16),
                  Text(
                    "Score: $_quizScore / 3",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _quizScore >= 2 ? _successColor : Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _quizScore >= 2
                        ? "🎉 Great job! You mastered *arid*."
                        : "📚 Review the activities and try again.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _activityCard({
    required String title,
    required String question,
    required List<String> options,
    required int correctIndex,
    required int quizIndex,
    required String explanation,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(question),
            const SizedBox(height: 12),
            ...List.generate(options.length, (i) {
              final selected = _quizAnswers[quizIndex] == i;
              return GestureDetector(
                onTap: () {
                  setState(() => _quizAnswers[quizIndex] = i);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: selected
                        ? (i == correctIndex
                            ? _successColor.withOpacity(0.25)
                            : Colors.red.withOpacity(0.2))
                        : _lightSand.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(options[i]),
                ),
              );
            }),
            if (_quizAnswers.containsKey(quizIndex))
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _quizAnswers[quizIndex] == correctIndex
                      ? " Correct! $explanation"
                      : " Incorrect. $explanation",
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep5() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "🏆 Final Mastery: Context Clues Success",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _darkBrown,
            ),
          ),

          _buildProgressIndicator(),
          const SizedBox(height: 16),

          // Final Answer Card
          Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Final Answer Title
                  Text(
                    " Final Answer:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Answer
                  Text(
                    "B) No water",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkBrown,
                    ),
                    textAlign: TextAlign.left,
                  ),

                  const Divider(height: 32),

                  // Complete Analysis
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _lightSand.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 18,
                            color: _darkBrown,
                            height: 1.4,
                          ),
                          children: [
                            TextSpan(
                              text: "We used context clues to figure out that ",
                            ),
                            TextSpan(
                              text: '"arid"',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _primaryColor,
                                backgroundColor: _primaryColor.withOpacity(0.1),
                              ),
                            ),
                            const TextSpan(text: " means "),
                            TextSpan(
                              text: "very dry.",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _successColor,
                              ),
                            ),
                            const TextSpan(text: "\n\nThe phrase "),
                            TextSpan(
                              text: '"no water"',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _infoColor,
                              ),
                            ),
                            const TextSpan(
                                text:
                                    " is the clearest clue that tells us what 'arid' means — "),
                            TextSpan(
                              text: "dry, hot, and lacking moisture.",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: _darkBrown,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const Divider(height: 32),

                  // Skills Mastered
                  Text(
                    "🛠️ Skills You Mastered:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkBrown,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _lightSand.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.search, color: _primaryColor),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                "Context Clue Identification: Finding hints in sentences",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.analytics, color: _primaryColor),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                "Clue Evaluation: Determining which clues are strongest",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.psychology, color: _primaryColor),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                "Logical Inference: Making educated guesses from context",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.book, color: _primaryColor),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                "Vocabulary Building: Learning new words without dictionaries",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Real-World Application
          Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "🌍 Real-World Application:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkBrown,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        label: const Text("Reading comprehension"),
                        backgroundColor: Colors.blue.withOpacity(0.1),
                      ),
                      Chip(
                        label: const Text("Standardized tests"),
                        backgroundColor: Colors.green.withOpacity(0.1),
                      ),
                      Chip(
                        label: const Text("Academic research"),
                        backgroundColor: Colors.orange.withOpacity(0.1),
                      ),
                      Chip(
                        label: const Text("Everyday conversations"),
                        backgroundColor: Colors.purple.withOpacity(0.1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Now you can understand unfamiliar words in any context without a dictionary!",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Final Button
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.celebration, color: Colors.white),
              label: const Text(
                "Complete Activity",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _successColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              onPressed: _completeActivity,
            ),
          ),
        ],
      ),
    );
  }

  void _completeActivity() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SecondActyvityAnimation(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_lightBlueBg, _softBlue, const Color(0xFF90CAF9)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: IndexedStack(
              index: _currentStep,
              children: [
                _buildStep1(),
                _buildStep2(),
                _buildStep3(),
                _buildStep4(),
                _buildStep5(),
              ],
            ),
          ),
        ),
      ),
    );
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
    '💡 General Hint: Look for a phrase that describes how funny the movie was.',
    '📌 More Specific: The sentence says everyone laughed nonstop — which word tells you why that happened?',
    '🧐 Little Explanation: Focus on the part of the sentence that helps explain why the movie made people laugh.'
  ];

  final List<String> hints2 = [
    '💡 General Hint: Look for a phrase that shows the teacher\'s expression or mood.',
    '📌 More Specific: Pay attention to the part where it describes how the teacher interacts with others.',
    '🧐 Little Explanation: Focus on the detail that helps you understand how the teacher\'s behavior is serious or strict.'
  ];

  final List<String> hints3 = [
    '💡 General Hint: Look for an action that shows the children’s emotional response.',
    '📌 More Specific: Pay attention to the activity the children are doing that suggests they are feeling excited.',
    '🧐 Little Explanation: Focus on the phrase that demonstrates their happiness after receiving the news.'
  ];

  final List<String> hints4 = [
    '💡 General Hint: Look for a word that shows contrast between her feelings and those of her friends.',
    '📌 More Specific: Focus on the part that shows opposite emotions to her friends excitement.',
    '🧐 Little Explanation: Pay attention to the word that highlights her hesitation despite the enthusiasm of others.'
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "The movie was hilarious, so funny that everyone in the theater laughed nonstop.\n\nWhich part tells you what “hilarious” means?",
      "options": ["A) So funny", "B) Everyone", "C) Theater", "D) Movie"],
      "correctIndex": 0,
      "feedback": [
        " Correct! “So funny” is a synonym clue that tells us what “hilarious” means.",
        " “Everyone” doesn’t explain the word — it's who was involved, not a clue.",
        " “Theater” is the place, not a context clue for the meaning of the word.",
        " “Movie” is the subject, not an explanation for the word “hilarious”."
      ]
    },
    {
      "question":
          "The teacher was stern, never smiling and always speaking in a serious tone.\n\nWhich part gives a clue about the meaning of “stern”?",
      "options": [
        "A) The teacher",
        "B) Never smiling",
        "C) Always speaking",
        "D) In a tone"
      ],
      "correctIndex": 1,
      "feedback": [
        " “The teacher” tells us who is being described but not what 'stern' means.",
        " Correct! “Never smiling” suggests that the teacher is strict or serious.",
        " “Always speaking” is vague and not directly related to the definition of “stern”.",
        " “In a tone” is incomplete and doesn’t help define the word clearly."
      ]
    },
    {
      "question":
          "The children were elated, jumping and cheering after hearing the good news.\n\nWhich part explains the word “elated”?",
      "options": ["A) Children", "B) Cheering", "C) Good news", "D) Hearing"],
      "correctIndex": 1,
      "feedback": [
        " “Children” is the subject of the sentence, not a clue to the meaning.",
        " Correct! “Jumping and cheering” shows the kids were very happy — a clear example clue.",
        " “Good news” is the cause of the feeling, not a definition or synonym of “elated”.",
        " “Hearing” describes the action, not the emotional reaction."
      ]
    },
    {
      "question":
          "She felt reluctant to join the game, despite her excited and eager friends.\n\nWhich part of the sentence helps explain “reluctant”?",
      "options": [
        "A) Join the game",
        "B) Despite",
        "C) Her friends",
        "D) Excited"
      ],
      "correctIndex": 1,
      "feedback": [
        " “Join the game” is what she was hesitant about, but not the clue itself.",
        " Correct! “Despite” shows a contrast — her feelings are opposite to being eager, which helps define 'reluctant'.",
        " “Her friends” are part of the context but don’t directly explain the word.",
        " “Excited” describes her friends, not her own attitude, and doesn’t directly explain 'reluctant'."
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
              backgroundColor: const Color(0xFFE0F7F4), // _lightBlueBg
              titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              title: Row(
                children: const [
                  Icon(Icons.emoji_events,
                      color: Color(0xFF4DB6AC), size: 30), // _accentBlue
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Level Complete!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF00695C), // _primaryBlue
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
                      color: Color(0xFF37474F),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Get ready for the next challenge!",
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF00897B), // _deepBlue
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
                    foregroundColor: const Color(0xFF00897B), // _deepBlue
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  label: const Text("Advance"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4DB6AC), // _accentBlue
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
      backgroundColor: const Color(0xFFE0F7F4), // _lightBlueBg
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F7F4), // _lightBlueBg
              Color(0xFFB2EBE5), // _softBlue
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
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF4DB6AC)), // _accentBlue
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Choose the right option",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00695C), // _primaryBlue
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
                        Text(
                          selectedOptionIndex == correctIndex
                              ? "✩ ${feedback[selectedOptionIndex!]}"
                              : " ${feedback[selectedOptionIndex!]}",
                          style: TextStyle(
                              fontSize: 18,
                              color: selectedOptionIndex == correctIndex
                                  ? const Color(0xFF00695C) // _primaryBlue
                                  : const Color(0xFFD32F2F)),
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  selectedOptionIndex == correctIndex
                                      ? const Color(0xFF4DB6AC) // _accentBlue
                                      : const Color(0xFFB2EBE5), // _softBlue
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
                            child: const Text(
                              "Next",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
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
                                                color: const Color(
                                                        0xFF4DB6AC) // _accentBlue
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
                                          ? const Color(
                                              0xFF4DB6AC) // _accentBlue
                                          : const Color(
                                              0xFF80CBC4), // turquesa suave
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
                                      hintStep2++;
                                    else if (currentQuestionIndex == 2)
                                      hintStep3++;
                                    else if (currentQuestionIndex == 3)
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
                                border: Border.all(
                                    color:
                                        const Color(0xFF4DB6AC)), // _accentBlue
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
                                          hintStep2 = hints2.length;
                                        else if (currentQuestionIndex == 2)
                                          hintStep3 = hints3.length;
                                        else if (currentQuestionIndex == 3)
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
    question:
        'Choose the right definition of the word\n\n She dropped the glass vase, and it broke easily — it was very fragile.',
    options: [
      "A) Strong",
      "B) Easy to break",
      "C) Very colorful",
      "D) Dirty and cleaned"
    ],
    correctIndex: 1,
    explanation:
        '✔️ Explanation: The vase “broke easily,” which tells us that “fragile” means easy to break',
    incorrectExplanations: [
      'Don\'t worry\'s is a common error',
      '',
      'Don\'t worry\'s is a common error',
      'Don\'t worry\'s is a common error',
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
              Color(0xFFE0F7F4),
              Color(0xFFB2EBE5),
              Color(0xFF80CBC4),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close_rounded,
                          size: 28, color: Color(0xFF00897B)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Question card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 28),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF4DB6AC),
                        Color(0xFF00695C),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF00695C),
                        blurRadius: 16,
                        offset: Offset(0, 6),
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

                // Opciones
                Expanded(
                  child: AbsorbPointer(
                    absorbing: isAnswerSubmitted,
                    child: ListView.builder(
                      itemCount: question.options.length,
                      itemBuilder: (context, i) {
                        bool isSelected = selected == i;

                        Color bgColor;
                        Color borderColor;
                        Color textColor;

                        if (isAnswerSubmitted && isSelected) {
                          bgColor = isCorrect == true
                              ? const Color(0xFFE0F7F4)
                              : const Color(0xFFFFEBEE);
                          borderColor = isCorrect == true
                              ? const Color(0xFF00897B)
                              : const Color(0xFFEF9A9A);
                          textColor = isCorrect == true
                              ? const Color(0xFF00695C)
                              : Colors.red.shade800;
                        } else if (isSelected) {
                          bgColor = const Color(0xFF00897B);
                          borderColor = const Color(0xFF00695C);
                          textColor = Colors.white;
                        } else {
                          bgColor = Colors.white;
                          borderColor = const Color(0xFF4DD0C4);
                          textColor = Colors.black87;
                        }

                        return GestureDetector(
                          onTap: () => setState(() => selected = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: borderColor, width: 2),
                            ),
                            child: Text(
                              question.options[i],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: textColor,
                              ),
                            ),
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
                          ? const Color(0xFFE0F7F4)
                          : const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isCorrect == true
                            ? const Color(0xFF00897B)
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
                              ? const Color(0xFF00897B)
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
                                      ? const Color(0xFF00695C)
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

                // Botón Submit / Continue
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isAnswerSubmitted
                        ? _continue
                        : selected != null
                            ? _submitAnswer
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00897B),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 4,
                      shadowColor: const Color(0xFF00695C),
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

class _ExplanationThirdState extends State<ExplanationThird>
    with SingleTickerProviderStateMixin {
  int _currentStep = 0;
  String? _selectedAnswer;
  double _progressValue = 0.2;
  late AnimationController _animationController;
  bool _correctAnswer = false;
  // ignore: unused_field
  bool? _confirmationAnswer;

  // ── Colores agua marina ───────────────────────────────────────────────────
  final Color _primaryColor = const Color(0xFF00897B);
  final Color _darkBlue = const Color(0xFF00695C);
  final Color _accentColor = const Color(0xFF4DD0C4);
  final Color _lightBlue = const Color(0xFFB2EBE5);
  final Color _backgroundLight = const Color(0xFFE0F7F4);
  final Color _backgroundDark = const Color(0xFF80CBC4);
  final Color _successColor = const Color(0xFF43A047);
  final Color _warningColor = const Color(0xFFFF8F00);
  // ignore: unused_field
  final Color _infoColor = const Color(0xFF00ACC1);
  final Color _glassColor = const Color(0xFFB2EBE5);
  final Color _crystalColor = const Color(0xFFE0F7F4);

  // Interactive states
  bool _clueIdentified = false;
  final List<String> _sentenceParts = [];
  Map<String, bool> _sentenceTopics = {};

  // ignore: unused_field
  bool _glassBroken = false;
  Timer? _breakTimer;

  final List<Map<String, dynamic>> _clueTypes = [
    {
      'type': 'Definition Clue',
      'description': 'Directly explains the word',
      'example': '"broke easily" = fragile',
      'active': false
    },
    {
      'type': 'Synonym Clue',
      'description': 'Uses similar words',
      'example': '"delicate" = fragile',
      'active': false
    },
    {
      'type': 'Antonym Clue',
      'description': 'Uses opposite words',
      'example': '"not sturdy" = fragile',
      'active': false
    },
    {
      'type': 'Example Clue',
      'description': 'Gives specific examples',
      'example': '"glass, eggshells" = fragile',
      'active': false
    },
  ];

  late List<Map<String, dynamic>> _fragileItems;

  final List<Map<String, dynamic>> _synonyms = [
    {'word': 'Delicate', 'strength': 85, 'formal': true},
    {'word': 'Breakable', 'strength': 90, 'formal': false},
    {'word': 'Fraible', 'strength': 95, 'formal': true},
    {'word': 'Flimsy', 'strength': 70, 'formal': false},
    {'word': 'Brittle', 'strength': 80, 'formal': true},
    {'word': 'Dainty', 'strength': 60, 'formal': false},
  ];

  final List<Map<String, dynamic>> _antonyms = [
    {'word': 'Strong', 'icon': Icons.fitness_center},
    {'word': 'Sturdy', 'icon': Icons.architecture},
    {'word': 'Durable', 'icon': Icons.build},
    {'word': 'Robust', 'icon': Icons.health_and_safety},
    {'word': 'Tough', 'icon': Icons.shield},
    {'word': 'Resilient', 'icon': Icons.autorenew},
  ];

  String? _selectedClue;
  bool _challengeAnswered = false;
  final String _correctClue = "could be damaged";

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _sentenceTopics = {
      "A vase that broke easily": false,
      "Cleaning a vase": false,
      "A vase changing color": false,
    };

    _fragileItems = [
      {
        'name': 'Glass Vase',
        'icon': Icons.wine_bar,
        'risk': 'High',
        'color': _glassColor
      },
      {
        'name': 'Eggshell',
        'icon': Icons.egg,
        'risk': 'Very High',
        'color': Colors.amber[100]!
      },
      {
        'name': 'Bubble',
        'icon': Icons.bubble_chart,
        'risk': 'Extreme',
        'color': _lightBlue
      },
      {
        'name': 'Ice',
        'icon': Icons.ac_unit,
        'risk': 'High',
        'color': Colors.blue[50]!
      },
      {
        'name': 'Porcelain',
        'icon': Icons.dinner_dining,
        'risk': 'Medium',
        'color': Colors.white
      },
      {
        'name': 'Thin Glass',
        'icon': Icons.liquor,
        'risk': 'High',
        'color': _crystalColor
      },
    ];
  }

  @override
  void dispose() {
    _animationController.dispose();
    _breakTimer?.cancel();
    super.dispose();
  }

  void _resetGlass() {
    _breakTimer?.cancel();
    setState(() {
      _glassBroken = false;
    });
  }

  void _nextStep() {
    setState(() {
      _progressValue = (_currentStep + 1) * 0.2;
    });
    _animationController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 400), () {
        setState(() {
          if (_currentStep < 4) {
            _currentStep++;
            _animationController.reset();
            _resetInteractiveStates();
          } else {
            _completeActivity();
          }
        });
      });
    });
  }

  void _resetInteractiveStates() {
    _clueIdentified = false;
    _sentenceParts.clear();
    _sentenceTopics.forEach((key, _) {
      _sentenceTopics[key] = false;
    });
    _selectedAnswer = null;
    _correctAnswer = false;
    _confirmationAnswer = null;
    _resetGlass();
    for (var clue in _clueTypes) {
      clue['active'] = false;
    }
  }

  Widget _buildProgressIndicator() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Column(
          children: [
            LinearProgressIndicator(
              value: Tween<double>(
                begin: _progressValue - 0.2,
                end: _progressValue,
              ).animate(_animationController).value,
              backgroundColor: _lightBlue.withOpacity(0.4),
              valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        );
      },
    );
  }

  // ── STEP 1 — informativo, sin interactividad ──────────────────────────────
  Widget _buildStep1() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (w) => SlideAnimation(
              verticalOffset: 30.0,
              child: FadeInAnimation(child: w),
            ),
            children: [
              Text(
                "🔍 Step 1: Read the Whole Sentence",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: _darkBlue),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),

              // ── Sentence card ──
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xFF00897B), _accentColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: _primaryColor.withOpacity(0.25),
                        blurRadius: 14,
                        offset: const Offset(0, 6)),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                        fontSize: 18, color: Colors.white, height: 1.5),
                    children: [
                      const TextSpan(
                          text: '"She dropped the glass vase, and it '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _warningColor.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: _warningColor.withOpacity(0.7)),
                          ),
                          child: Text(
                            "broke easily",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFFE082),
                            ),
                          ),
                        ),
                      ),
                      const TextSpan(text: ' — it was very '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4)
                            ],
                          ),
                          child: Text(
                            "fragile",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _darkBlue,
                            ),
                          ),
                        ),
                      ),
                      const TextSpan(text: '."'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ── Context clue highlight ──
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _warningColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: _warningColor.withOpacity(0.5), width: 1.5),
                ),
                padding: const EdgeInsets.all(18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("💡", style: const TextStyle(fontSize: 22)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontSize: 15, color: _darkBlue, height: 1.5),
                          children: [
                            const TextSpan(text: "The phrase "),
                            TextSpan(
                              text: '"broke easily"',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _warningColor),
                            ),
                            const TextSpan(text: " is a "),
                            TextSpan(
                              text: "Definition Clue",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _primaryColor),
                            ),
                            const TextSpan(
                                text: " — it directly tells us what "),
                            TextSpan(
                              text: '"fragile"',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(text: " means."),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Key Observations ──
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.88),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: _accentColor.withOpacity(0.45), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                        color: _primaryColor.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4))
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("🔑 Key Observations:",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: _darkBlue)),
                    const SizedBox(height: 14),
                    _buildObservationItem(
                        "Action:", "Dropped the vase", Icons.arrow_downward),
                    _buildObservationItem(
                        "Result:", "Broke easily", Icons.warning_amber_rounded),
                    _buildObservationItem("Description:", "Very fragile",
                        Icons.description_outlined),
                    _buildObservationItem("Connection:",
                        '"Broke easily" explains "fragile"', Icons.link),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 4,
                    shadowColor: _darkBlue.withOpacity(0.3),
                  ),
                  child: const Text("Discover Context Clue Types ➡️",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget _buildInfoRow(String emoji, String label, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 15, color: _darkBlue, height: 1.4),
              children: [
                TextSpan(
                    text: '$label ',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: content),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildObservationItem(String label, String content, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _primaryColor.withOpacity(0.1),
              border: Border.all(color: _primaryColor, width: 1.5),
            ),
            child: Icon(icon, color: _primaryColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style:
                    TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
                children: [
                  TextSpan(
                      text: '$label ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _darkBlue,
                          fontSize: 15)),
                  TextSpan(text: content),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── STEP 2 — colores agua marina ──────────────────────────────────────────
  Widget _buildStep2() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (w) => SlideAnimation(
                verticalOffset: 30, child: FadeInAnimation(child: w)),
            children: [
              Text("💡 Step 2: Types of Context Clues",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue)),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),
              _buildTealCard(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Identify the Context Clue Type:",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue)),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _lightBlue.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _accentColor),
                    ),
                    child: Column(children: [
                      Text(
                          '"broke easily" is a direct restatement of "fragile"',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _darkBlue)),
                      const SizedBox(height: 8),
                      Text('What type of context clue is this?',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600])),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.85,
                    children: _clueTypes.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> clue = entry.value;
                      bool isActive = clue['active'] as bool;
                      bool isDefinition = clue['type'] == 'Definition Clue';
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            for (var c in _clueTypes) {
                              c['active'] = false;
                            }
                            _clueTypes[index]['active'] = true;
                            _clueIdentified = true;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: isActive
                                ? (isDefinition
                                    ? _successColor.withOpacity(0.1)
                                    : Colors.red.withOpacity(0.1))
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: isActive
                                  ? (isDefinition ? _successColor : Colors.red)
                                  : Colors.grey[300]!,
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(_getClueIcon(clue['type'] as String),
                                      size: 28,
                                      color: isActive
                                          ? (isDefinition
                                              ? _successColor
                                              : Colors.red)
                                          : _primaryColor),
                                  const SizedBox(height: 8),
                                  Text(clue['type'] as String,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: _darkBlue)),
                                  const SizedBox(height: 4),
                                  Text(clue['description'] as String,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey[600])),
                                  if (isActive) ...[
                                    const SizedBox(height: 4),
                                    Icon(
                                        isDefinition
                                            ? Icons.check_circle
                                            : Icons.cancel,
                                        size: 16,
                                        color: isDefinition
                                            ? _successColor
                                            : Colors.red),
                                  ],
                                ]),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  if (_clueIdentified)
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: (_clueTypes[0]['active'] as bool
                                ? _successColor
                                : Colors.red)
                            .withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: _clueTypes[0]['active'] as bool
                                ? _successColor
                                : Colors.red,
                            width: 1.5),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Icon(
                                  _clueTypes[0]['active'] as bool
                                      ? Icons.emoji_events
                                      : Icons.warning_amber_rounded,
                                  color: _clueTypes[0]['active'] as bool
                                      ? _successColor
                                      : Colors.red,
                                  size: 20),
                              const SizedBox(width: 8),
                              Text(
                                  _clueTypes[0]['active'] as bool
                                      ? "Excellent Identification!"
                                      : "Not Quite...",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: _darkBlue)),
                            ]),
                            const SizedBox(height: 6),
                            Text(
                                _clueTypes[0]['active'] as bool
                                    ? "Correct! This is a Definition Clue. The phrase 'broke easily' directly defines 'fragile'."
                                    : "'Broke easily' isn't a synonym, antonym, or example — it's a direct definition!",
                                style: const TextStyle(fontSize: 13)),
                          ]),
                    ),
                ],
              )),
              const SizedBox(height: 16),
              _buildTealCard(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("📚 Examples of Each Clue Type:",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: _darkBlue)),
                    const SizedBox(height: 14),
                    _buildClueExample("Definition:", '"broke easily" = fragile',
                        _successColor),
                    _buildClueExample(
                        "Synonym:", '"delicate" = fragile', Colors.blue),
                    _buildClueExample(
                        "Antonym:", '"not sturdy" = fragile', Colors.orange),
                    _buildClueExample("Example:",
                        '"glass, eggshells" = fragile', Colors.purple),
                  ])),
              const SizedBox(height: 16),
              _buildTealCard(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("🏺 Gallery of Fragile Items:",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: _darkBlue)),
                    const SizedBox(height: 6),
                    Text("These items would be examples in an 'Example Clue':",
                        style:
                            TextStyle(fontSize: 13, color: Colors.grey[600])),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 145,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _fragileItems.length,
                        itemBuilder: (context, index) {
                          final item = _fragileItems[index];
                          return Container(
                            width: 100,
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: item['color'] as Color,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: _primaryColor.withOpacity(0.3)),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(item['icon'] as IconData,
                                      size: 28, color: _darkBlue),
                                  const SizedBox(height: 8),
                                  Text(item['name'] as String,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: _darkBlue)),
                                  const SizedBox(height: 4),
                                  Chip(
                                    label: Text(item['risk'] as String,
                                        style: const TextStyle(fontSize: 10)),
                                    backgroundColor:
                                        _warningColor.withOpacity(0.2),
                                    padding: EdgeInsets.zero,
                                  ),
                                ]),
                          );
                        },
                      ),
                    ),
                  ])),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _clueIdentified ? _nextStep : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _clueIdentified ? _primaryColor : Colors.grey[400],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: _clueIdentified ? 4 : 0,
                  ),
                  child: const Text("Apply Your Knowledge ➡️",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getClueIcon(String clueType) {
    switch (clueType) {
      case 'Definition Clue':
        return Icons.description;
      case 'Synonym Clue':
        return Icons.swap_horiz;
      case 'Antonym Clue':
        return Icons.compare_arrows;
      case 'Example Clue':
        return Icons.list;
      default:
        return Icons.help;
    }
  }

  Widget _buildClueExample(String type, String example, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8)),
          child: Text(type.substring(0, 1),
              style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        ),
        const SizedBox(width: 12),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(type,
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.bold, color: _darkBlue)),
          Text(example,
              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
        ])),
      ]),
    );
  }

  // ── STEP 3 ────────────────────────────────────────────────────────────────
  Widget _buildStep3() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (w) => SlideAnimation(
                verticalOffset: 30, child: FadeInAnimation(child: w)),
            children: [
              Text("🎯 Step 3: Apply Your Understanding",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue)),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),
              _buildTealCard(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _lightBlue.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _accentColor),
                      ),
                      child: Text("What does 'fragile' mean in this sentence?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: _darkBlue)),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _lightBlue.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _accentColor),
                      ),
                      child: Row(children: [
                        Icon(Icons.format_quote, color: _primaryColor),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Text(
                                '"She dropped the glass vase, and it broke easily — it was very fragile."',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontStyle: FontStyle.italic,
                                    color: _darkBlue))),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    Column(children: [
                      _buildMeaningOption("A", "Strong",
                          "✗ No. Strong is the opposite of fragile.", false),
                      _buildMeaningOption("B", "Easy to break",
                          "✓ Yes! This matches the clue 'broke easily.'", true),
                      _buildMeaningOption(
                          "C",
                          "Very colorful",
                          "✗ Not mentioned. Focus on the action and result.",
                          false),
                      _buildMeaningOption(
                          "D",
                          "Dirty",
                          "✗ Unrelated. The sentence doesn't mention cleanliness.",
                          false),
                    ]),
                    if (_selectedAnswer != null) ...[
                      const SizedBox(height: 16),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: Container(
                          key: ValueKey(_selectedAnswer),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color:
                                (_correctAnswer ? _successColor : _warningColor)
                                    .withOpacity(0.08),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: _correctAnswer
                                    ? _successColor
                                    : _warningColor,
                                width: 1.5),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Icon(
                                      _correctAnswer
                                          ? Icons.emoji_events
                                          : Icons.psychology,
                                      color: _correctAnswer
                                          ? _successColor
                                          : _warningColor,
                                      size: 24),
                                  const SizedBox(width: 10),
                                  Text(
                                      _correctAnswer
                                          ? "Perfect Choice!"
                                          : "Let's Analyze Again",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: _darkBlue)),
                                ]),
                                const SizedBox(height: 8),
                                Text(_getMeaningAnalysis(_selectedAnswer!),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                        height: 1.4)),
                              ]),
                        ),
                      ),
                      if (!_correctAnswer) ...[
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () => setState(() {
                              _selectedAnswer = null;
                            }),
                            icon: Icon(Icons.autorenew, color: _primaryColor),
                            label: Text("Try Another Answer",
                                style: TextStyle(color: _primaryColor)),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: _primaryColor),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                      ],
                    ],
                    if (_correctAnswer) ...[
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _successColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _successColor),
                        ),
                        child: Row(children: [
                          Icon(Icons.lightbulb_outline, color: _successColor),
                          const SizedBox(width: 10),
                          const Expanded(
                              child: Text(
                                  "Excellent! You've used the definition clue 'broke easily' to understand 'fragile'.",
                                  style: TextStyle(fontSize: 13))),
                        ]),
                      ),
                    ],
                  ])),
              const SizedBox(height: 16),
              _buildTealCard(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("🧩 Strategy for Definition Clues:",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: _darkBlue)),
                    const SizedBox(height: 14),
                    _buildStrategyStep(
                        1, "Look for dashes (—), commas, or 'is/are'"),
                    _buildStrategyStep(
                        2, "Find phrases that restate the unknown word"),
                    _buildStrategyStep(
                        3, "Check if it directly explains the meaning"),
                    _buildStrategyStep(
                        4, "Verify it makes sense in the sentence"),
                  ])),
              const SizedBox(height: 16),
              _buildTealCard(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("💪 Practice Challenge:",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: _darkBlue)),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: _lightBlue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(children: [
                        const Text(
                            "Identify the definition clue in this sentence:",
                            style: TextStyle(fontSize: 14)),
                        const SizedBox(height: 8),
                        Text(
                            '"The antique was very delicate — it could be damaged with just a touch."',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                                color: _darkBlue)),
                        const SizedBox(height: 14),
                        Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              "antique",
                              "could be damaged",
                              "with just a touch",
                              "very",
                            ].map((option) {
                              return ChoiceChip(
                                label: Text(option),
                                selected: _selectedClue == option,
                                selectedColor: _getChipColor(option),
                                onSelected: (_) {
                                  if (_challengeAnswered) return;
                                  setState(() {
                                    _selectedClue = option;
                                    _challengeAnswered = true;
                                  });
                                },
                              );
                            }).toList()),
                        const SizedBox(height: 10),
                        if (_challengeAnswered)
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  _selectedClue == _correctClue
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  color: _selectedClue == _correctClue
                                      ? _successColor
                                      : Colors.red,
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                    child: Text(
                                        _selectedClue == _correctClue
                                            ? "Correct! This explains what 'delicate' means."
                                            : "Try again: look for the explanation.",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: _darkBlue,
                                            fontWeight: FontWeight.w500))),
                              ]),
                        if (!_challengeAnswered)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                                "Hint: Look for what explains 'delicate'",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[600])),
                          ),
                      ]),
                    ),
                  ])),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 4,
                    shadowColor: _darkBlue.withOpacity(0.3),
                  ),
                  child: const Text("Expand Vocabulary ➡️",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMeaningOption(
      String letter, String word, String analysis, bool isCorrect) {
    bool isSelected = _selectedAnswer == word;
    return GestureDetector(
      onTap: () => setState(() {
        _selectedAnswer = word;
        _correctAnswer = isCorrect;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect
                  ? _successColor.withOpacity(0.1)
                  : Colors.red.withOpacity(0.08))
              : _lightBlue.withOpacity(0.2),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: isSelected
                  ? (isCorrect ? _successColor : Colors.red)
                  : _accentColor.withOpacity(0.5),
              width: 2),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? (isCorrect ? _successColor : Colors.red)
                    : _primaryColor.withOpacity(0.15),
              ),
              child: Text(letter,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : _darkBlue)),
            ),
            const SizedBox(width: 12),
            Expanded(
                child: Text(word,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _darkBlue))),
            if (isSelected)
              Icon(isCorrect ? Icons.check_circle : Icons.cancel,
                  color: isCorrect ? _successColor : Colors.red, size: 22),
          ]),
          if (isSelected)
            Padding(
              padding: const EdgeInsets.only(left: 44, top: 6),
              child: Text(analysis,
                  style: TextStyle(fontSize: 13, color: Colors.grey[700])),
            ),
        ]),
      ),
    );
  }

  String _getMeaningAnalysis(String option) {
    switch (option) {
      case 'Strong':
        return "Strong is actually the opposite of fragile. Look for the clue 'broke easily' which suggests weakness.";
      case 'Easy to break':
        return "Perfect! 'Easy to break' directly matches the clue 'broke easily' — a classic definition context clue.";
      case 'Very colorful':
        return "The sentence doesn't mention color. Context clues focus on breakability, not appearance.";
      case 'Dirty':
        return "Cleanliness isn't discussed. Context clues relate only to how easily the vase broke.";
      default:
        return "Return to the specific clues in the sentence. What phrases directly explain the unknown word?";
    }
  }

  Widget _buildStrategyStep(int number, String step) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _lightBlue.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _accentColor.withOpacity(0.3)),
      ),
      child: Row(children: [
        Container(
          width: 28,
          height: 28,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: _primaryColor),
          child: Center(
              child: Text(number.toString(),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(step, style: const TextStyle(fontSize: 14))),
      ]),
    );
  }

  // ── STEP 4 ────────────────────────────────────────────────────────────────
  Widget _buildStep4() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (w) => SlideAnimation(
                verticalOffset: 30, child: FadeInAnimation(child: w)),
            children: [
              Text("📚 Step 4: Vocabulary Expansion",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue)),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),
              _buildTealCard(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 14),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [_primaryColor, _accentColor],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                                color: _primaryColor.withOpacity(0.3),
                                blurRadius: 14,
                                spreadRadius: 2)
                          ],
                        ),
                        child: const Text("FRAGILE",
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2)),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _lightBlue.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _primaryColor),
                      ),
                      child: Column(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildWordInfo(
                                  "📖 Definition", "Easily broken or damaged"),
                              _buildWordInfo(
                                  "🗣️ Pronunciation", "/ˈfrædʒ.aɪl/"),
                            ]),
                        const SizedBox(height: 12),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildWordInfo("🌐 Origin", "Latin 'fragilis'"),
                              _buildWordInfo(
                                  "📅 First Use", "Early 17th century"),
                            ]),
                        const SizedBox(height: 12),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildWordInfo(
                                  "🔤 Word Family", "Fragility, Fragileness"),
                            ]),
                      ]),
                    ),
                    const SizedBox(height: 22),
                    Text("📊 Synonyms by Strength:",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: _darkBlue)),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: _synonyms.length,
                        itemBuilder: (context, index) {
                          final synonym = _synonyms[index];
                          int strength = synonym['strength'] as int;
                          bool isFormal = synonym['formal'] as bool;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: _lightBlue.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: _accentColor.withOpacity(0.3)),
                            ),
                            child: Column(children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(synonym['word'] as String,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: _darkBlue)),
                                    Row(children: [
                                      if (isFormal)
                                        Chip(
                                            label: const Text("Formal",
                                                style: TextStyle(fontSize: 10)),
                                            backgroundColor:
                                                _primaryColor.withOpacity(0.1),
                                            padding: EdgeInsets.zero),
                                      const SizedBox(width: 6),
                                      Text("$strength% match",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  _getStrengthColor(strength))),
                                    ]),
                                  ]),
                              const SizedBox(height: 6),
                              LinearProgressIndicator(
                                value: strength / 100,
                                backgroundColor: Colors.grey[300],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    _getStrengthColor(strength)),
                                minHeight: 5,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ]),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text("⚖️ Antonyms (Opposites):",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: _darkBlue)),
                    const SizedBox(height: 8),
                    Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _antonyms.map((antonym) {
                          return Chip(
                            label: Text(antonym['word'] as String),
                            avatar: Icon(antonym['icon'] as IconData, size: 14),
                            backgroundColor: _successColor.withOpacity(0.1),
                          );
                        }).toList()),
                    const SizedBox(height: 20),
                    Text("💬 Usage in Different Contexts:",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: _darkBlue)),
                    const SizedBox(height: 12),
                    _buildUsageExample(
                        "Physical Objects:",
                        '"Handle with care - contents are fragile."',
                        Icons.inventory_2),
                    _buildUsageExample(
                        "Emotional State:",
                        '"After the news, she was in a fragile emotional state."',
                        Icons.emoji_emotions),
                    _buildUsageExample(
                        "Systems/Relationships:",
                        '"The fragile peace agreement could collapse at any moment."',
                        Icons.handshake),
                    _buildUsageExample(
                        "Health:",
                        '"The patient\'s condition remains fragile."',
                        Icons.medical_services),
                  ])),
              const SizedBox(height: 16),
              _buildTealCard(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("🏛️ Etymology & Word History:",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: _darkBlue)),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: _lightBlue.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Icon(Icons.history, color: _primaryColor),
                              const SizedBox(width: 8),
                              const Text("Word Journey:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ]),
                            const SizedBox(height: 8),
                            const Text(
                                "Fragile comes from Latin 'fragilis' meaning 'easily broken,' "
                                "which comes from 'frangere' meaning 'to break.' "
                                "This root also gives us 'fraction,' 'fracture,' and 'fragment.'",
                                style: TextStyle(fontSize: 13)),
                            const SizedBox(height: 8),
                            Wrap(spacing: 8, runSpacing: 4, children: [
                              Chip(label: const Text("Latin: fragilis")),
                              Chip(label: const Text("Root: frangere")),
                              Chip(label: const Text("Related: fracture")),
                              Chip(label: const Text("Related: fragment")),
                            ]),
                          ]),
                    ),
                  ])),
              const SizedBox(height: 16),
              _buildTealCard(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("📝 Common Phrases with 'Fragile':",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: _darkBlue)),
                    const SizedBox(height: 12),
                    _buildCommonPhrase(
                        "Handle with care", "Warning on packages"),
                    _buildCommonPhrase(
                        "Fragile ego", "Easily offended personality"),
                    _buildCommonPhrase(
                        "Fragile state of mind", "Unstable mental condition"),
                    _buildCommonPhrase(
                        "Fragile economy", "Vulnerable economic system"),
                    _buildCommonPhrase(
                        "Fragile beauty", "Delicate attractiveness"),
                  ])),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 4,
                  ),
                  child: const Text("Final Mastery Review ➡️",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStrengthColor(int strength) {
    if (strength >= 90) return _successColor;
    if (strength >= 80) return Colors.green;
    if (strength >= 70) return const Color(0xFF0288D1);
    return Colors.grey;
  }

  Widget _buildWordInfo(String title, String content) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _lightBlue)),
        child: Column(children: [
          Text(title,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(content,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w600, color: _darkBlue)),
        ]),
      ),
    );
  }

  Widget _buildUsageExample(String context, String example, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: _lightBlue.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _accentColor.withOpacity(0.2))),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: _primaryColor, size: 18),
        const SizedBox(width: 10),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(context,
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.bold, color: _darkBlue)),
          const SizedBox(height: 3),
          Text(example,
              style: const TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87)),
        ])),
      ]),
    );
  }

  Widget _buildCommonPhrase(String phrase, String meaning) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: _lightBlue.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6)),
          child: const Text("💬", style: TextStyle(fontSize: 12)),
        ),
        const SizedBox(width: 10),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(phrase,
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.bold, color: _darkBlue)),
          Text(meaning,
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ])),
      ]),
    );
  }

  // ── STEP 5 ────────────────────────────────────────────────────────────────
  Widget _buildStep5() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("🏆 Final Mastery: Context Clues Complete",
              style: TextStyle(
                  fontSize: 21, fontWeight: FontWeight.bold, color: _darkBlue)),
          const SizedBox(height: 10),
          _buildProgressIndicator(),
          const SizedBox(height: 16),
          _buildTealCard(
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(" Final Answer:",
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: _primaryColor)),
            const SizedBox(height: 10),
            Text("B) Easy to break",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: _darkBlue)),
            Divider(height: 28, color: _accentColor.withOpacity(0.4)),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: _lightBlue.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style:
                        TextStyle(fontSize: 16, color: _darkBlue, height: 1.5),
                    children: [
                      const TextSpan(text: "We used "),
                      TextSpan(
                          text: "context clues",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _primaryColor,
                              backgroundColor: _primaryColor.withOpacity(0.1))),
                      const TextSpan(text: " — especially "),
                      TextSpan(
                          text: '"broke easily"',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _warningColor)),
                      const TextSpan(text: " — to figure out that "),
                      TextSpan(
                          text: '"fragile"',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _primaryColor,
                              backgroundColor: _primaryColor.withOpacity(0.1))),
                      const TextSpan(text: " means "),
                      TextSpan(
                          text: "easy to break.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _successColor)),
                    ],
                  ),
                ),
              ),
            ),
            Divider(height: 28, color: _accentColor.withOpacity(0.4)),
            Text("🔬 Step-by-Step Analysis Mastered:",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: _darkBlue)),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                  style: TextStyle(fontSize: 15, color: _darkBlue, height: 1.6),
                  children: [
                    const TextSpan(
                        text: "1. ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: "Identified the unknown word: "),
                    TextSpan(
                        text: "fragile\n\n",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: _primaryColor)),
                    const TextSpan(
                        text: "2. ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: "Located the context clue: "),
                    TextSpan(
                        text: '"broke easily"\n\n',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: _warningColor)),
                    const TextSpan(
                        text: "3. ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: "Recognized clue type: "),
                    TextSpan(
                        text: "Definition Clue\n\n",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: _successColor)),
                    const TextSpan(
                        text: "4. ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: "Connected clue to meaning: "),
                    TextSpan(
                        text: "easy to break",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: _successColor)),
                  ]),
            ),
            Divider(height: 28, color: _accentColor.withOpacity(0.4)),
            Text("🛠️ Skills You Developed:",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: _darkBlue)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: _lightBlue.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(children: [
                _buildSkillRow(Icons.search,
                    "Context Clue Identification: Finding definition clues in sentences"),
                _buildSkillRow(Icons.analytics,
                    "Vocabulary Inference: Determining word meanings from context"),
                _buildSkillRow(Icons.psychology,
                    "Critical Reading: Analyzing sentence structure and relationships"),
                _buildSkillRow(Icons.language,
                    "Word Analysis: Understanding etymology and word families"),
              ]),
            ),
          ])),
          const SizedBox(height: 14),
          _buildTealCard(
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("🌍 Real-World Applications:",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: _darkBlue)),
            const SizedBox(height: 10),
            Wrap(spacing: 8, runSpacing: 8, children: [
              _buildAppChip("Academic Reading", Icons.school, Colors.blue),
              _buildAppChip(
                  "Standardized Tests", Icons.assignment, Colors.green),
              _buildAppChip(
                  "Professional Documents", Icons.work, Colors.orange),
              _buildAppChip(
                  "Everyday Conversations", Icons.chat, Colors.purple),
              _buildAppChip("Creative Writing", Icons.create, Colors.pink),
              _buildAppChip(
                  "Technical Manuals", Icons.engineering, Colors.brown),
            ]),
            const SizedBox(height: 8),
            Text(
                "Now you can decode unfamiliar words in any context without external help!",
                style: TextStyle(fontSize: 13, color: Colors.grey[600])),
          ])),
          const SizedBox(height: 14),
          _buildTealCard(
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("💭 Final Reflection:",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: _darkBlue)),
            const SizedBox(height: 10),
            const Text(
                "You've mastered the art of using context clues! Remember: "
                "Definition clues like 'broke easily' for 'fragile' are your best friends "
                "when encountering unfamiliar words. This skill transforms you from "
                "a passive reader into an active word detective.",
                style: TextStyle(fontSize: 14)),
            const SizedBox(height: 12),
            Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.auto_awesome, color: _accentColor, size: 18),
              const SizedBox(width: 8),
              Text("Context Clue Master Achieved!",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: _successColor)),
            ])),
          ])),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.celebration, color: Colors.white),
              label: const Text("Complete Activity",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: _successColor,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                elevation: 4,
              ),
              onPressed: _completeActivity,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildSkillRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(children: [
        Icon(icon, color: _primaryColor, size: 18),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
      ]),
    );
  }

  Widget _buildAppChip(String label, IconData icon, Color color) {
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      avatar: Icon(icon, size: 14),
      backgroundColor: color.withOpacity(0.1),
    );
  }

  // ignore: unused_element
  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(children: [
        Icon(Icons.arrow_right, color: _primaryColor, size: 16),
        const SizedBox(width: 6),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
      ]),
    );
  }

  void _completeActivity() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ThirdActyvityAnimation()),
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
        return _buildStep5();
      default:
        return _buildStep1();
    }
  }

  // ── helper: teal card container ───────────────────────────────────────────
  Widget _buildTealCard(Widget child) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.88),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _accentColor.withOpacity(0.45), width: 1.5),
        boxShadow: [
          BoxShadow(
              color: _primaryColor.withOpacity(0.08),
              blurRadius: 14,
              offset: const Offset(0, 5))
        ],
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 4),
      child: child,
    );
  }

  Color _getChipColor(String option) {
    if (!_challengeAnswered) return Colors.grey[300]!;
    if (option == _correctClue) return _successColor.withOpacity(0.3);
    if (option == _selectedClue && option != _correctClue)
      return Colors.red.withOpacity(0.3);
    return Colors.grey[300]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_backgroundLight, _backgroundDark],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              // Close button
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.close_rounded, color: _darkBlue, size: 28),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _buildCurrentStep(),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
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

  // Colores agua marina
  static const Color tealDark = Color(0xFF00695C);
  static const Color tealMid = Color(0xFF00897B);
  static const Color tealLight = Color(0xFF4DD0C4);
  static const Color tealPale = Color(0xFFE0F7F4);
  static const Color tealSoft = Color(0xFFB2EBE5);

  final List<String> hints1 = [
    '💡 General Hint: Look for a word that describes how he expressed his frustration.',
    '📌 More Specific: Focus on the part that shows he was complaining, but not speaking clearly.',
    '🧐 Little Explanation: Think about how the word "grumbled" fits with a person who is not speaking loudly or clearly.'
  ];

  final List<String> hints2 = [
    '💡 General Hint: Pay attention to the weather description — dark and rainy.',
    '📌 More Specific: Think about how the sky affects the mood in this situation.',
    '🧐 Little Explanation: Look for the word that best matches a sad or depressed feeling caused by the dark sky.'
  ];

  final List<String> hints3 = [
    '💡 General Hint: Focus on the reaction to good news — his face lit up.',
    '📌 More Specific: Think about the emotion that would cause someone to feel delighted.',
    '🧐 Little Explanation: Look for the word that matches a happy or positive emotion in response to good news.'
  ];

  final List<String> hints4 = [
    '💡 General Hint: Think about what it means to move around without a specific direction.',
    '📌 More Specific: Consider how they might be moving without a clear plan or destination.',
    '🧐 Little Explanation: The absence of a map suggests they were moving aimlessly.'
  ];

  // Palabra a resaltar por pregunta
  final List<String> highlightWords = [
    'grumbled',
    'gloomy',
    'delight',
    'wandered',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "He didn't speak clearly — he just grumbled about how tired he was.\n\nMatch the word",
      "options": [
        "A) Spoke loudly",
        "B) Complained quietly",
        "C) Asked for help",
        "D) Whispered a joke"
      ],
      "correctIndex": 1,
      "feedback": [
        " 'Spoke loudly' is the opposite of 'grumbled', which is quiet.",
        " Correct! 'Grumbled' means to complain quietly or unclearly.",
        " 'Asked for help' is not related to complaining.",
        " 'Whispered a joke' is unrelated and suggests humor, not tiredness or frustration."
      ]
    },
    {
      "question":
          "The sky turned dark and rainy, and the mood was very gloomy.\n\nMatch the word",
      "options": [
        "A) Bright and clear",
        "B) Happy and joyful",
        "C) Sad and dark",
        "D) Cold"
      ],
      "correctIndex": 2,
      "feedback": [
        " 'Bright and clear' is the opposite of the gloomy setting.",
        " 'Happy and joyful' contradicts the tone set by a dark, rainy sky.",
        " Correct! 'Gloomy' means sad and dark — matching the mood created.",
        " 'Cold' is not clearly indicated in the sentence."
      ]
    },
    {
      "question":
          "When he heard the good news, his face lit up with delight.\n\nMatch the word",
      "options": ["A) Fear", "B) Confusion", "C) Joy", "D) Sorrow"],
      "correctIndex": 2,
      "feedback": [
        " 'Fear' doesn't match the happy reaction described.",
        " 'Confusion' is not related to lighting up with emotion.",
        " Correct! 'Delight' means joy, as shown by his bright reaction.",
        " 'Sorrow' is sadness — the opposite of delight."
      ]
    },
    {
      "question":
          "They didn't have a map, so they just wandered through the forest.\n\nMatch the word",
      "options": [
        "A) Walked with no plan",
        "B) Ran quickly",
        "C) Slept under trees",
        "D) Climbed a mountain"
      ],
      "correctIndex": 0,
      "feedback": [
        " Correct! 'Wandered' means walking without a clear direction or plan.",
        " 'Ran quickly' implies speed, but nothing suggests that.",
        " 'Slept under trees' is not mentioned or implied.",
        " 'Climbed a mountain' is unrelated to wandering in a forest."
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
    if (_isInactive) setState(() => _isInactive = false);
    _inactivityTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && !showFeedback) setState(() => _isInactive = true);
    });
  }

  void handleOptionTap(int index) {
    _startInactivityTimer();
    final correctIndex = questions[currentQuestionIndex]['correctIndex'];
    setState(() {
      selectedOptionIndex = index;
      showFeedback = true;
      if (index == correctIndex) progress += 1 / questions.length;
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
      hintStep1 = hintStep2 = hintStep3 = hintStep4 = 0;
    });
  }

  void _showCompletionDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "LevelComplete",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => const SizedBox(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedValue =
            Curves.easeInOutBack.transform(animation.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * -50, 0.0),
          child: Opacity(
            opacity: animation.value,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              elevation: 16,
              backgroundColor: tealPale,
              titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              title: const Row(
                children: [
                  Icon(Icons.emoji_events, color: tealMid, size: 30),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Level Complete!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: tealDark,
                      ),
                    ),
                  ),
                ],
              ),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "You've completed all the questions.",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Get ready for the next challenge!",
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: tealMid,
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
                  style: TextButton.styleFrom(foregroundColor: tealMid),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  label: const Text("Advance"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tealMid,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
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
  }

  /// Resalta [word] en [text] con un pill blanco sobre fondo teal
  Widget _buildHighlightedQuestion(String text, String word) {
    final idx = text.indexOf(word);
    if (idx == -1) {
      return Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
          height: 1.6,
        ),
      );
    }
    final before = text.substring(0, idx);
    final after = text.substring(idx + word.length);

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
          height: 1.6,
        ),
        children: [
          TextSpan(text: before),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: tealMid,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: tealDark.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                word,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          TextSpan(text: after),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];
    final options = question['options'] as List<String>;
    final feedback = question['feedback'] as List<String>;
    final correctIndex = question['correctIndex'] as int;
    final highlightWord = highlightWords[currentQuestionIndex];

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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [tealPale, tealSoft, Color(0xFF80CBC4)],
          ),
        ),
        child: SafeArea(
          child: GestureDetector(
            onTapDown: (_) => _startInactivityTimer(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: Colors.white.withOpacity(0.4),
                      valueColor: const AlwaysStoppedAnimation<Color>(tealMid),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Título
                  const Text(
                    "Choose the right definition",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: tealDark,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Question card con palabra resaltada
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.88),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                          color: tealLight.withOpacity(0.5), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: tealMid.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: _buildHighlightedQuestion(
                        question['question'] as String, highlightWord),
                  ),
                  const SizedBox(height: 20),

                  // Opciones
                  for (int i = 0; i < options.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        onTap: showFeedback ? null : () => handleOptionTap(i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 14),
                          decoration: BoxDecoration(
                            color: showFeedback && selectedOptionIndex == i
                                ? (i == correctIndex
                                    ? tealMid.withOpacity(0.12)
                                    : Colors.red.withOpacity(0.08))
                                : Colors.white.withOpacity(0.88),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: showFeedback && selectedOptionIndex == i
                                  ? (i == correctIndex ? tealMid : Colors.red)
                                  : tealLight.withOpacity(0.5),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: tealMid.withOpacity(0.06),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  options[i],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight:
                                        showFeedback && selectedOptionIndex == i
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                    color:
                                        showFeedback && selectedOptionIndex == i
                                            ? (i == correctIndex
                                                ? tealDark
                                                : Colors.red.shade800)
                                            : Colors.black87,
                                  ),
                                ),
                              ),
                              if (showFeedback && selectedOptionIndex == i)
                                Icon(
                                  i == correctIndex
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  color:
                                      i == correctIndex ? tealMid : Colors.red,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 8),

                  // Feedback
                  if (showFeedback && selectedOptionIndex != null) ...[
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: selectedOptionIndex == correctIndex
                            ? tealMid.withOpacity(0.08)
                            : Colors.red.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selectedOptionIndex == correctIndex
                              ? tealMid
                              : Colors.red,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            selectedOptionIndex == correctIndex
                                ? Icons.check_circle_outline
                                : Icons.highlight_off,
                            color: selectedOptionIndex == correctIndex
                                ? tealMid
                                : Colors.red,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              selectedOptionIndex == correctIndex
                                  ? "✩ ${feedback[selectedOptionIndex!]}"
                                  : " ${feedback[selectedOptionIndex!]}",
                              style: TextStyle(
                                fontSize: 16,
                                color: selectedOptionIndex == correctIndex
                                    ? tealDark
                                    : Colors.red.shade800,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedOptionIndex == correctIndex
                              ? tealMid
                              : Colors.grey.shade400,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation:
                              selectedOptionIndex == correctIndex ? 4 : 0,
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
                              ? "Next →"
                              : "Try again",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),

                  // Hint
                  if (!showFeedback)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                            color: tealLight.withOpacity(
                                                0.5 * _glowController.value),
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
                                  color: _isInactive ? tealLight : tealMid,
                                  size: 38,
                                ),
                              );
                            },
                          ),
                          onPressed: () {
                            _startInactivityTimer();
                            setState(() {
                              if (currentHintIndex != null) {
                                if (currentQuestionIndex == 0)
                                  hintStep1++;
                                else if (currentQuestionIndex == 1)
                                  hintStep2++;
                                else if (currentQuestionIndex == 2)
                                  hintStep3++;
                                else if (currentQuestionIndex == 3) hintStep4++;
                              }
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        if (currentHint != null)
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.88),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: tealLight.withOpacity(0.6)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      currentHint,
                                      style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black87,
                                        fontSize: 13,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close,
                                        size: 18, color: tealDark),
                                    onPressed: () {
                                      setState(() {
                                        if (currentQuestionIndex == 0)
                                          hintStep1 = hints1.length;
                                        else if (currentQuestionIndex == 1)
                                          hintStep2 = hints2.length;
                                        else if (currentQuestionIndex == 2)
                                          hintStep3 = hints3.length;
                                        else if (currentQuestionIndex == 3)
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

                  const SizedBox(height: 16),
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
        .set({'completedInstructionSpot2_3': true}, SetOptions(merge: true));

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
      'completedInstructionSpot2_3': true, // Repetido por seguridad
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE0F7F4),
              Color(0xFFB2EBE5),
              Color(0xFF80CBC4),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.emoji_events,
                  size: 100,
                  color: Color(0xFF00897B),
                ),
                const SizedBox(height: 12),
                const Text(
                  "You did amazing! The more you practice using context clues, the better you'll become! Keep up the fantastic work! 🌟🩵",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00695C),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.88),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: const Color(0xFF4DD0C4).withOpacity(0.45),
                        width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00897B).withOpacity(0.1),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    "To sum up...\n\nContext clues work as powerful tools to help us understand new words by looking at the surrounding details, making it easier to expand our vocabulary!",
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
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
                      backgroundColor: const Color(0xFF00897B),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                      shadowColor: const Color(0xFF00695C).withOpacity(0.3),
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
