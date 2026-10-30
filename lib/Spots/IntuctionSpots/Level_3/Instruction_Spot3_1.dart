// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_3/Animation3_1.dart';
import 'package:inferwise/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: unused_import
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class InstructionSpotPage3_1 extends StatefulWidget {
  final String title;
  final List<String> instructions;
  final String tipTitle;
  final List<String> tips;
  final String finalNote;

  const InstructionSpotPage3_1({
    super.key,
    required this.title,
    required this.instructions,
    required this.tipTitle,
    required this.tips,
    required this.finalNote,
  });

  @override
  State<InstructionSpotPage3_1> createState() => _InstructionSpotPage3_1State();
}

class _InstructionSpotPage3_1State extends State<InstructionSpotPage3_1> {
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
              color: Colors.black.withOpacity(0.15), // oscurece el wallpaper
              colorBlendMode: BlendMode.darken,
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
                              Color.fromARGB(255, 0, 106, 212), // Texto claro
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
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1673D1).withOpacity(0.75),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 136, 255)
                              .withOpacity(0.95),
                        ),
                      ),
                      child: Text(
                        widget.instructions[_currentStep],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E88E5),
                        minimumSize: const Size(160, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        foregroundColor: Colors.white,
                        elevation: 6,
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
  int _visibleCount = 0;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _examples = [
    {
      'type': 'example',
      'image': 'assets/Imagenes de ejemplos/Level3/3.2 A Lena.webp',
      'title': '🔹 Inferring a Goal',
      'text':
          ' Lena rushed out with her backpack.\nInference: She was trying to catch the school bus.'
    },
    {
      'type': 'example',
      'image': 'assets/Imagenes de ejemplos/Level3/3.2 B James.webp',
      'title': '🔹 Inferring a Goal',
      'text':
          ' James kept checking his watch.\nInference: He was waiting for someone.'
    },
    {
      'type': 'example',
      'image': 'assets/Imagenes de ejemplos/Level3/3.2 C Sophie.webp',
      'title': '🔹 Inferring How a Goal was Achieved',
      'text':
          ' Sophie baked a cake for her friend.\nInference: She mixed ingredients and used the oven.'
    },
    {
      'type': 'example',
      'image': 'assets/Imagenes de ejemplos/Level3/3.2 D The detective.webp',
      'title': '🔹 Inferring How a Goal was Achieved',
      'text':
          ' The detective followed the clues on the map.\nInference: He used the map to find the suspect.'
    },
  ];

  void _revealNextExample() {
    if (_visibleCount < _examples.length) {
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
      MaterialPageRoute(builder: (context) => const ThirdRoomPage()),
    );
  }

  void _exit() {
    Navigator.pop(context);
  }

  /// Líneas sin "Inference:" → azul oscuro e itálica
  /// Líneas con "Inference:" → "Inference:" en negrita + resto en negro normal
  Widget _buildCardText(String text) {
    final List<InlineSpan> spans = [];
    final List<String> lines = text.split('\n');

    for (int i = 0; i < lines.length; i++) {
      final String line = lines[i];
      final bool isInference = line.trimLeft().startsWith('Inference:');

      if (isInference) {
        final int colonIndex = line.indexOf(':');
        final String label = line.substring(0, colonIndex + 1);
        final String rest = line.substring(colonIndex + 1);
        spans.add(TextSpan(
          text: label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            height: 1.6,
          ),
        ));
        spans.add(TextSpan(
          text: rest,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
            height: 1.6,
          ),
        ));
      } else {
        spans.add(TextSpan(
          text: line,
          style: const TextStyle(
            fontSize: 15,
            fontStyle: FontStyle.italic,
            color: Color(0xFF0D47A1),
            height: 1.6,
          ),
        ));
      }

      if (i < lines.length - 1) {
        spans.add(const TextSpan(text: '\n'));
      }
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  Widget _buildCard(String title, String image, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
          border: Border.all(color: const Color(0xFF42A5F5).withOpacity(0.4)),
        ),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Color(0xFF0D47A1),
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  height: 175,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),
              _buildCardText(text),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_visibleCount, (index) {
        final bool isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive
                ? const Color(0xFF0D47A1)
                : Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
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
              Color(0xFF90CAF9),
              Color(0xFF42A5F5),
              Color(0xFF1976D2),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Inferring Goals",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Color(0xFF014F86)),
                      onPressed: _exit,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Info card principal
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: const Color(0xFF42A5F5).withOpacity(0.3)),
                  ),
                  child: const Text(
                    'Readers figure out a character\'s motive or intended action based on clues in the text and our background knowledge.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),

                const SizedBox(height: 10),

                // Dots indicadores
                if (_visibleCount > 0) ...[
                  _buildDots(),
                ],

                // Carrusel horizontal
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
                            final example = _examples[index];
                            return _buildCard(
                              example['title']!,
                              example['image']!,
                              example['text']!,
                            );
                          },
                        ),
                ),

                const SizedBox(height: 16),

                // Botón
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _visibleCount < _examples.length
                        ? _revealNextExample
                        : _goToNextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 34, 100, 198),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
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
                            : _visibleCount < _examples.length
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

class ThirdRoomPage extends StatefulWidget {
  const ThirdRoomPage({super.key});

  @override
  State<ThirdRoomPage> createState() => _ThirdRoomPageState();
}

class _ThirdRoomPageState extends State<ThirdRoomPage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  final List<String> steps = [
    "🔷 1. Read the Sentence Carefully\n\nLook at the details in the sentence:\n\n➡️ Sarah is grabbing her keys.\n\n➡️ She's running out the door.",
    "🔷 2. Ask: What's the Goal or Motive?\n\nWhy is Sarah doing this?\n The sentence doesn't directly say why she's grabbing her keys or running.",
    "🔷 3. Activate Background Knowledge\n\nThink about why someone might grab keys and run out the door.\n💭 People usually grab their keys when they are leaving the house, maybe in a hurry.",
    "🔷 4. Make the Inference\n\n✅ Sarah is probably leaving to go somewhere, and she's in a hurry.",
    "🔷 5. Check for Coherence\n\n✅ Grabbing keys and running out the door makes sense if she's rushing to leave.",
    "🔵 Final Answer:\nSarah is leaving the house quickly, likely because she's in a hurry.\n\n🔹 You used a goal-oriented inference to figure out Sarah's motive based on context and real-world knowledge."
  ];

  void _nextStep() {
    if (_currentStep < steps.length - 1) {
      _pageController.animateToPage(
        _currentStep + 1,
        duration: const Duration(milliseconds: 350),
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
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Separa la primera línea (título) del resto del contenido
  /// y renderiza el título en negrita.
  Widget _buildStepText(String content) {
    final int newlineIndex = content.indexOf('\n');
    if (newlineIndex == -1) {
      return Text(
        content,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF0D1B2A),
          height: 1.6,
        ),
      );
    }

    final String title = content.substring(0, newlineIndex);
    final String body = content.substring(newlineIndex + 1);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D47A1),
              height: 1.6,
            ),
          ),
          TextSpan(
            text: '\n$body',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0D1B2A),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(steps.length, (index) {
        final bool isActive = index == _currentStep;
        final bool isPast = index < _currentStep;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive || isPast
                ? const Color(0xFF0D47A1)
                : Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLast = _currentStep == steps.length - 1;
    final bool isFirst = _currentStep == 0;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF90CAF9),
              Color(0xFF42A5F5),
              Color(0xFF1976D2),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Step-by-Step",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Color(0xFF014F86)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Card de contexto fija
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: const Color.fromARGB(255, 2, 130, 235),
                        width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.15),
                        offset: const Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Row(
                        children: [
                          Icon(Icons.format_quote_rounded,
                              color: Color(0xFF0277BD), size: 22),
                          SizedBox(width: 8),
                          Text(
                            "Let's infer the goal in the \nnext sentence:",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D47A1),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        '"Sarah grabbed her keys and ran out the door."',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                          color: Color(0xFF0D1B2A),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Dots
                _buildDots(),

                const SizedBox(height: 12),

                // PageView de pasos
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentStep = index);
                    },
                    itemCount: steps.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(24),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: const Color(0xFF90CAF9), width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.15),
                              offset: const Offset(0, 4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: _buildStepText(steps[index]),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // Botones
                Row(
                  children: [
                    // Botón volver
                    AnimatedOpacity(
                      opacity: isFirst ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      child: GestureDetector(
                        onTap: isFirst ? null : _goBack,
                        child: Container(
                          width: 54,
                          height: 54,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.5),
                              width: 1.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),

                    // Botón principal
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _nextStep,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 34, 100, 198),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 4,
                        ),
                        child: Text(
                          isLast ? "Continue" : "Next step",
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
              Color(0xFF90CAF9),
              Color(0xFF42A5F5),
              Color(0xFF1976D2),
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
                      icon: const Icon(Icons.close,
                          color: Color(0xFF014F86), size: 28),
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
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                        color: const Color.fromARGB(255, 2, 130, 235),
                        width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.15),
                        offset: const Offset(0, 4),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: const Text(
                    "Is everything clear, or would you like a quick recap?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
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
                          backgroundColor:
                              const Color.fromARGB(255, 34, 100, 198),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 4,
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
                          backgroundColor: Colors.white.withOpacity(0.25),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(
                                color: Colors.white.withOpacity(0.6),
                                width: 1.5),
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE3F2FD),
              Color(0xFFBBDEFB),
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
                      icon: const Icon(Icons.close,
                          size: 30, color: Color(0xFF0D47A1)),
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
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                              color: const Color(0xFF42A5F5), width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.15),
                              offset: const Offset(0, 4),
                              blurRadius: 15,
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
                                    color: Color(0xFF42A5F5), size: 28),
                                SizedBox(width: 12),
                                Text(
                                  'Remember',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0D47A1),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Readers figure out a character\'s motive or intended action based on what\'s happening in the text and our world knowledge.',
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
                                color: Color(0xFF1E88E5),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildExample(
                              sentence:
                                  'Sarah grabbed her keys and ran out the door.',
                              inference:
                                  'We infer that Sarah is in a hurry to leave the house, likely to go somewhere important.',
                            ),
                            _buildExample(
                              sentence:
                                  'Tom kept checking his watch while pacing by the door.',
                              inference:
                                  'We infer that Tom is probably waiting for someone or something to arrive.',
                            ),
                           const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: const Color(0xFF057BDB)),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.info_outline,
                                      color: Color(0xFF42A5F5), size: 20),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Let word similarities guide you — just double-check their meanings!',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF0D47A1),
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
                            backgroundColor: const Color(0xFF42A5F5),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
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

  static Widget _buildExample(
      {required String sentence, required String inference}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF057BDB), width: 1),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.circle, size: 8, color: Color(0xFF42A5F5)),
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
                '✩ $inference',
                style: const TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF1E88E5),
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
    '🔹 1. Read the Sentence Carefully\nIdentify what the character is doing.',
    '🔹 2. Ask: What’s the Goal or Motive?\nWhat might the character be trying to achieve?',
    '🔹 3. Activate Background Knowledge\nThink about real-life situations that explain the action.',
    '🔹 4. Make the Inference\nUse your knowledge to figure out the character\'s goal or motive.',
    '🔹 5. Check for Coherence\nDoes your inference make the sentence more logical or understandable?',
  ];

  void _finish() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => Start()),
    );
  }

  void _exit() {
    Navigator.pop(context);
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
              Color(0xFF90CAF9),
              Color(0xFF42A5F5),
              Color(0xFF1976D2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 8, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Step-by-Step",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Color(0xFF014F86)),
                      onPressed: _exit,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Lista scrollable
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                  itemCount: steps.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // Card de contexto
                      return Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: const Color.fromARGB(255, 2, 130, 235),
                              width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.15),
                              offset: const Offset(0, 4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Row(
                              children: [
                                Icon(Icons.format_quote_rounded,
                                    color: Color(0xFF0277BD), size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'Sentence to analyze',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0D47A1),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              '"Sarah grabbed her keys and ran out the door."',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 15,
                                color: Color(0xFF0D1B2A),
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }

                    final stepIndex = index - 1;
                    return Container(
                      padding: const EdgeInsets.all(18),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color(0xFF90CAF9), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.15),
                            offset: const Offset(0, 4),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Text(
                        steps[stepIndex],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0D1B2A),
                          height: 1.5,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Botón
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _finish,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 34, 100, 198),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
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
        'Ben grabbed his keys and ran to the front door.\n\nWhat is Ben most likely trying to do?',
    options: [
      "A) Clean his room",
      "B) Take a nap on the couch",
      "C) Watch TV",
      "D) Leave the house"
    ],
    correctIndex: 3,
    explanation:
        ' Explanation: Grabbing keys and running to the door suggests he\'s leaving — possibly for work, school, or an errand.',
    incorrectExplanations: [
      ' Cleaning his room doesn’t require keys or running to the door.',
      ' Taking a nap wouldn’t involve grabbing keys or going to the door.',
      ' Watching TV doesn’t require leaving the house or carrying keys.',
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
              Color(0xFFE3F0FF),
              Color(0xFFB6D0F7),
              Color(0xFF7AAEE8),
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
                          size: 28, color: Color(0xFF1565C0)),
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
                        Color(0xFF1E88E5),
                        Color(0xFF0D47A1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF0D47A1),
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
                              ? const Color(0xFFE3F0FF)
                              : const Color(0xFFFFEBEE);
                          borderColor = isCorrect == true
                              ? const Color(0xFF1565C0)
                              : const Color(0xFFEF9A9A);
                          textColor = isCorrect == true
                              ? const Color(0xFF0D47A1)
                              : Colors.red.shade800;
                        } else if (isSelected) {
                          bgColor = const Color(0xFF1565C0);
                          borderColor = const Color(0xFF0D47A1);
                          textColor = Colors.white;
                        } else {
                          bgColor = Colors.white;
                          borderColor = const Color(0xFF90CAF9);
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
                          ? const Color(0xFFE3F0FF)
                          : const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isCorrect == true
                            ? const Color(0xFF1565C0)
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
                              ? const Color(0xFF1565C0)
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
                                      ? const Color(0xFF0D47A1)
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
                      backgroundColor: const Color(0xFF1565C0),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 4,
                      shadowColor: const Color(0xFF0D47A1),
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
  String? _motiveAnswer;
  String? _inferenceAnswer;
  // ignore: unused_field
  bool _isProcessing = false;

  double _progressValue = 0.2;

  void _nextStep() {
    if (_currentStep == 1 && _motiveAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select Ben\'s possible motive')),
      );
      return;
    }

    if (_currentStep == 3 && _inferenceAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your inference')),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
      _progressValue = (_currentStep + 1) * 0.2;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
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

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: LinearProgressIndicator(
          value: _progressValue,
          backgroundColor: Colors.white.withOpacity(0.4),
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0D47A1)),
          minHeight: 8,
        ),
      ),
    );
  }

  // ─── SHARED WIDGETS ───────────────────────────────────────────────────────

  Widget _buildInfoCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: const Color.fromARGB(255, 2, 130, 235), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.15),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildContinueButton(String label) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _nextStep,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 34, 100, 198),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 4,
        ),
        child: Text(label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildFeedbackCard(
      {required bool isCorrect, required String message}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect
            ? const Color.fromARGB(255, 255, 255, 255).withOpacity(0.08)
            : Colors.red.withOpacity(0.07),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCorrect ? const Color(0xFF0D47A1) : Colors.red,
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
            color: isCorrect ? const Color(0xFF0D47A1) : Colors.red,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 15,
                height: 1.4,
                color: isCorrect
                    ? const Color.fromARGB(255, 255, 255, 255)
                    : Colors.red[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── STEP 1 ───────────────────────────────────────────────────────────────

  Widget _buildStep1() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "📖 Step 1: Read the Sentence",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D47A1),
            ),
          ),
          _buildProgressIndicator(),
          _buildInfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.format_quote_rounded,
                        color: Color(0xFF0277BD), size: 20),
                    SizedBox(width: 8),
                    Text(
                      "Analyze the sentence carefully:",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D47A1)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D47A1).withOpacity(0.07),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF90CAF9)),
                  ),
                  child: const Text(
                    '"Ben grabbed his keys and ran to the front door."',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF0D1B2A),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFF90CAF9)),
                const SizedBox(height: 12),
                // ✅ CORRECCIÓN: "WHAT DO WE KNOW FROM THE SENTENCE?"
                const Text(
                  "What do we know from the sentence?",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0D47A1)),
                ),
                const SizedBox(height: 10),
                _buildKnowledgePoint("Ben grabbed his keys"),
                const SizedBox(height: 8),
                _buildKnowledgePoint("Ben ran to the front door"),
              ],
            ),
          ),
          _buildContinueButton("Continue"),
        ],
      ),
    );
  }

  Widget _buildKnowledgePoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.circle, color: Color(0xFF0277BD), size: 8),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 15, color: Color(0xFF0D1B2A), height: 1.4),
          ),
        ),
      ],
    );
  }

  // ─── STEP 2 ───────────────────────────────────────────────────────────────

  Widget _buildStep2() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "❓ Step 2: Goal or Motive",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D47A1),
            ),
          ),
          _buildProgressIndicator(),
          _buildInfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Row(
                  children: [
                    Icon(Icons.search_rounded,
                        color: Color(0xFF0277BD), size: 20),
                    SizedBox(width: 8),
                    Text(
                      "What is Ben's possible motive?",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D47A1)),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "Choose the most likely reason for Ben's actions:",
                  style: TextStyle(fontSize: 15, color: Color(0xFF0D1B2A)),
                ),
              ],
            ),
          ),
          _buildOptionCard(
            text: "A) Going outside",
            isSelected: _motiveAnswer == "A",
            isCorrect: true,
            onTap: () => setState(() => _motiveAnswer = "A"),
          ),
          _buildOptionCard(
            text: "B) Taking a nap",
            isSelected: _motiveAnswer == "B",
            isCorrect: false,
            onTap: () => setState(() => _motiveAnswer = "B"),
          ),
          _buildOptionCard(
            text: "C) Cleaning his room",
            isSelected: _motiveAnswer == "C",
            isCorrect: false,
            onTap: () => setState(() => _motiveAnswer = "C"),
          ),
          _buildOptionCard(
            text: "D) Watching TV",
            isSelected: _motiveAnswer == "D",
            isCorrect: false,
            onTap: () => setState(() => _motiveAnswer = "D"),
          ),
          if (_motiveAnswer != null) ...[
            const SizedBox(height: 16),
            _buildFeedbackCard(
              isCorrect: _motiveAnswer == "A",
              message: _motiveAnswer == "A"
                  ? "Grabbing keys and going to the door suggests leaving."
                  : "Think about typical reasons for taking keys.",
            ),
            const SizedBox(height: 16),
            _buildContinueButton("Continue"),
          ],
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required String text,
    required bool isSelected,
    required bool isCorrect,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect
                  ? const Color(0xFF0D47A1).withOpacity(0.12)
                  : Colors.red.withOpacity(0.08))
              : const Color(0xFFE3F2FD),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? (isCorrect ? const Color(0xFF0D47A1) : Colors.red)
                : const Color(0xFF90CAF9),
            width: isSelected ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              offset: const Offset(0, 3),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? (isCorrect ? const Color(0xFF0D47A1) : Colors.red[700])
                      : const Color(0xFF0D1B2A),
                ),
              ),
            ),
            if (isSelected)
              Icon(
                isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                color: isCorrect ? const Color(0xFF0D47A1) : Colors.red,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }

  // ─── STEP 3 ───────────────────────────────────────────────────────────────

  Widget _buildStep3() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "🧠 Step 3: Background Knowledge",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D47A1),
            ),
          ),
          _buildProgressIndicator(),
          _buildInfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.public_rounded,
                        color: Color(0xFF0277BD), size: 20),
                    SizedBox(width: 8),
                    Text(
                      "What do people normally do \nwith keys?",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D47A1)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "Think about typical key-related behaviors:",
                  style: TextStyle(fontSize: 15, color: Color(0xFF0D1B2A)),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildKeyActionChip("Leave the house"),
                    _buildKeyActionChip("Drive a car"),
                    _buildKeyActionChip("Lock/unlock doors"),
                    _buildKeyActionChip("Enter their home"),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D47A1).withOpacity(0.07),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF90CAF9)),
                  ),
                  child: const Text(
                    "Grabbing keys and running to the door strongly suggests someone is about to leave, possibly in a hurry.",
                    style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF0D1B2A),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildContinueButton("Continue"),
        ],
      ),
    );
  }

  Widget _buildKeyActionChip(String text) {
    return Chip(
      label: Text(text),
      backgroundColor: const Color(0xFFBBDEFB),
      side: const BorderSide(color: Color(0xFF0D47A1)),
      labelStyle: const TextStyle(color: Color(0xFF0D47A1)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    );
  }

  // ─── STEP 4 ───────────────────────────────────────────────────────────────

  Widget _buildStep4() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "🔍 Step 4: Make an Inference",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D47A1),
            ),
          ),
          _buildProgressIndicator(),
          _buildInfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline,
                        color: Color(0xFF0277BD), size: 20),
                    SizedBox(width: 8),
                    Text(
                      "Based on the sentence, \nwhat is Ben probably doing?",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D47A1)),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "Pick the best answer:",
                  style: TextStyle(fontSize: 15, color: Color(0xFF0D1B2A)),
                ),
              ],
            ),
          ),
          _buildOptionCard(
            text: "A) Looking for his phone",
            isSelected: _inferenceAnswer == "A",
            isCorrect: false,
            onTap: () => setState(() => _inferenceAnswer = "A"),
          ),
          // ✅ CORRECCIÓN: Opción B actualizada
          _buildOptionCard(
            text: "B) Leaving the house quickly",
            isSelected: _inferenceAnswer == "B",
            isCorrect: true,
            onTap: () => setState(() => _inferenceAnswer = "B"),
          ),
          _buildOptionCard(
            text: "C) Taking a nap on the couch",
            isSelected: _inferenceAnswer == "C",
            isCorrect: false,
            onTap: () => setState(() => _inferenceAnswer = "C"),
          ),
          _buildOptionCard(
            text: "D) Hiding his keys",
            isSelected: _inferenceAnswer == "D",
            isCorrect: false,
            onTap: () => setState(() => _inferenceAnswer = "D"),
          ),
          if (_inferenceAnswer != null) ...[
            const SizedBox(height: 16),
            _buildFeedbackCard(
              isCorrect: _inferenceAnswer == "B",
              message: _inferenceAnswer == "B"
                  ? "This best explains both actions (grabbing keys and running to the door)."
                  : "Consider which option best fits all the evidence.",
            ),
            const SizedBox(height: 16),
            _buildContinueButton("See Final Answer"),
          ],
        ],
      ),
    );
  }

  // ─── FINAL STEP ───────────────────────────────────────────────────────────

  Widget _buildFinalStep() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "🏁 Final Answer",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D47A1),
            ),
          ),
          _buildProgressIndicator(),
          _buildInfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.check_circle_rounded,
                        color: Color(0xFF0D47A1), size: 22),
                    SizedBox(width: 8),
                    Text(
                      "Correct Answer:",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D47A1)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D47A1).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: const Color(0xFF0D47A1), width: 1.5),
                  ),
                  // ✅ CORRECCIÓN: Respuesta correcta actualizada
                  child: const Text(
                    "B) Leave the house quickly",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFF90CAF9)),
                const SizedBox(height: 12),
                const Text(
                  "Explanation:",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1)),
                ),
                const SizedBox(height: 10),
                // ✅ CORRECCIÓN: Explicación actualizada
                _buildExplanationPoint(
                    "People typically grab keys when leaving."),
                const SizedBox(height: 8),
                _buildExplanationPoint("Running to the door suggests urgency."),
                const SizedBox(height: 8),
                _buildExplanationPoint(
                    "No other option explains both actions together."),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _completeAnalysis,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 34, 100, 198),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                elevation: 4,
              ),
              child: const Text(
                "Start Practice Exercises",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExplanationPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.circle, color: Color(0xFF0277BD), size: 8),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 15, color: Color(0xFF0D1B2A), height: 1.5),
          ),
        ),
      ],
    );
  }

  // ─── NAVIGATION ───────────────────────────────────────────────────────────

  void _completeAnalysis() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Second()),
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
              Color(0xFF90CAF9),
              Color(0xFF42A5F5),
              Color(0xFF1976D2),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Step ${_currentStep + 1} of 5",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Color(0xFF014F86)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Expanded(child: _buildCurrentStep()),
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
  int hintStep5 = 0;

  Timer? _inactivityTimer;
  bool _isInactive = false;
  late AnimationController _glowController;

  final List<String> hints1 = [
    '💡 General Hint: What do people do when looking for a job?',
    '📌 More Specific: They search for job openings and update their resume.',
    '📝 Little Explanation: Carlos is likely job hunting based on his actions.'
  ];

  final List<String> hints2 = [
    '💡 General Hint: What do people do when preparing for a meal?',
    '📌 More Specific: They set the table with plates and glasses.',
    '📝 Little Explanation: Maya is preparing for a meal based on her actions.'
  ];

  final List<String> hints3 = [
    '💡 General Hint: What do people do to prepare for rain?',
    '📌 More Specific: They check the weather and bring an umbrella.',
    '📝 Little Explanation: Ethan\'s actions show he\'s preparing for rain.'
  ];

  final List<String> hints4 = [
    '💡 General Hint: What do people do when they go to the kitchen and open the fridge?',
    '📌 More Specific: They usually look for food.',
    '📝 Little Explanation: Nina is likely getting something to eat.'
  ];

  final List<String> hints5 = [
    '💡 General Hint: What do people do when they put on a helmet and get on a bike?',
    '📌 More Specific: They usually ride it.',
    '📝 Little Explanation: Daniel is likely getting ready to ride his bike.'
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Carlos looked up job openings on his computer and updated his resume.\n\nWhat is Carlos trying to do?",
      "options": [
        "A) Study for a test",
        "B) Find a new job",
        "C) Order food",
        "D) Learn a language"
      ],
      "correctIndex": 1,
      "feedback": [
        "Studying for a test doesn't relate to job openings or resumes.",
        "Correct: Searching for job openings and working on a resume are steps toward job hunting.",
        "Ordering food is unrelated to the given scenario.",
        "Learning a language is not mentioned in the context."
      ]
    },
    {
      "question":
          "Maya set the table and brought out plates and glasses.\n\nWhat is Maya preparing for?",
      "options": [
        "A) A meeting",
        "B) A meal",
        "C) A cleaning day",
        "D) A movie night"
      ],
      "correctIndex": 1,
      "feedback": [
        "A meeting usually does not require setting the table with plates and glasses.",
        "Correct: Setting the table is typically done before a meal.",
        "A cleaning day would not require plates and glasses.",
        "A movie night usually doesn't involve setting the table this way."
      ]
    },
    {
      "question":
          "Ethan checked the weather app and packed his umbrella.\n\nWhat is his goal?",
      "options": [
        "A) To go swimming",
        "B) To enjoy the sunshine",
        "C) To be ready for rain",
        "D) To water the plants"
      ],
      "correctIndex": 2,
      "feedback": [
        "Swimming does not require checking the weather for rain and packing an umbrella.",
        "Enjoying the sunshine doesn't match bringing an umbrella for rain.",
        "Correct: Checking the weather and packing an umbrella means he's preparing for possible rain.",
        "Watering plants is unrelated to this scenario."
      ]
    },
    {
      "question":
          "Nina walked into the kitchen and opened the fridge.\n\nWhy is Nina likely doing this?",
      "options": [
        "A) To clean",
        "B) To get something to eat",
        "C) To take a photo",
        "D) To look for her phone"
      ],
      "correctIndex": 1,
      "feedback": [
        "Cleaning is possible, but simply opening the fridge usually means looking for food.",
        "Correct: Going to the kitchen and opening the fridge usually indicates someone is looking for food.",
        "Taking a photo is unrelated to the fridge context.",
        "Looking for a phone is unrelated to the given actions."
      ]
    },
    {
      "question":
          "Daniel put on his helmet and climbed on his bike.\n\nWhat is Daniel trying to do?",
      "options": [
        "A) Ride his bike",
        "B) Go to sleep",
        "C) Fix the chain",
        "D) Polish his helmet"
      ],
      "correctIndex": 0,
      "feedback": [
        "Correct: Putting on a helmet and getting on a bike clearly shows he plans to ride it.",
        "Going to sleep is unrelated to putting on a helmet and climbing a bike.",
        "Fixing the chain is not mentioned in the context.",
        "Polishing the helmet is unrelated to the scenario."
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
      hintStep5 = 0;
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
              backgroundColor: const Color(0xFFBBDEFB), // más oscuro que E3F2FD
              titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              title: Row(
                children: const [
                  Icon(Icons.emoji_events, color: Color(0xFF1565C0), size: 30),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Level Complete!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0D47A1),
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
                      color: Color(0xFF1A237E),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Get ready for the next challenge!",
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF1565C0),
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
                    foregroundColor: const Color(0xFF1565C0),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  label: const Text("Advance"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
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
    } else if (currentQuestionIndex == 4 && hintStep5 < hints5.length) {
      currentHint = hints5[hintStep5];
      currentHintIndex = hintStep5;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFBBDEFB),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF90CAF9), // más oscuro que E3F2FD
              Color(0xFF42A5F5), // más oscuro que BBDEFB
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
                        const AlwaysStoppedAnimation<Color>(Color(0xFF1565C0)),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Choose the right option",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: const Color(0xFF1976D2).withOpacity(0.4)),
                    ),
                    child: Text(
                      question['question'],
                      style: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF0D47A1)),
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
                          backgroundColor: Colors.white.withOpacity(0.75),
                          foregroundColor: const Color(0xFF0D47A1),
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(
                                  color: Color(0xFF1976D2), width: 1)),
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
                                  ? const Color.fromARGB(255, 255, 255, 255)
                                  : const Color(0xFFD32F2F)),
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  selectedOptionIndex == correctIndex
                                      ? const Color(0xFF1976D2)
                                      : const Color(0xFF90CAF9),
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
                              "Next",
                              style: TextStyle(
                                  color: selectedOptionIndex == correctIndex
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16),
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
                                                color: const Color(0xFF1976D2)
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
                                          ? const Color(0xFF1565C0)
                                          : const Color(0xFF1976D2),
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
                                    else if (currentQuestionIndex == 4)
                                      hintStep5++;
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
                                color: Colors.white.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: const Color(0xFF1565C0)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      currentHint,
                                      style: const TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Color(0xFF0D47A1)),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close,
                                        size: 20, color: Color(0xFF1565C0)),
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
                                        else if (currentQuestionIndex == 4)
                                          hintStep5 = hints5.length;
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
        'Tyler built a birdhouse using wood, nails, and a hammer.\n\nHow did Tyler complete the birdhouse?',
    options: [
      "A) He glued paper together",
      "B) He used tools and materials",
      "C) He ordered it online",
      "D) He painted a box"
    ],
    correctIndex: 1,
    explanation:
        ' Explanation: The tools and materials mentioned are what helped him build the birdhouse.',
    incorrectExplanations: [
      ' Gluing paper together would not create a sturdy wooden birdhouse.',
      ' Ordering it online means he wouldn’t have built it himself.',
      ' Painting a box is not the same as constructing a birdhouse from wood and nails.',
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
              Color(0xFFE3F0FF),
              Color(0xFFB6D0F7),
              Color(0xFF7AAEE8),
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
                          size: 28, color: Color(0xFF1565C0)),
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
                        Color(0xFF1E88E5),
                        Color(0xFF0D47A1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF0D47A1),
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
                              ? const Color(0xFFE3F0FF)
                              : const Color(0xFFFFEBEE);
                          borderColor = isCorrect == true
                              ? const Color(0xFF1565C0)
                              : const Color(0xFFEF9A9A);
                          textColor = isCorrect == true
                              ? const Color(0xFF0D47A1)
                              : Colors.red.shade800;
                        } else if (isSelected) {
                          bgColor = const Color(0xFF1565C0);
                          borderColor = const Color(0xFF0D47A1);
                          textColor = Colors.white;
                        } else {
                          bgColor = Colors.white;
                          borderColor = const Color(0xFF90CAF9);
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
                          ? const Color(0xFFE3F0FF)
                          : const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isCorrect == true
                            ? const Color(0xFF1565C0)
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
                              ? const Color(0xFF1565C0)
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
                                      ? const Color(0xFF0D47A1)
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
                      backgroundColor: const Color(0xFF1565C0),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 4,
                      shadowColor: const Color(0xFF0D47A1),
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
    with SingleTickerProviderStateMixin {
  int _currentStep = 0;
  final Set<String> _selectedOptions = {};
  String? _inferenceAnswer;
  // ignore: unused_field
  bool _isProcessing = false;
  double _progressValue = 0.2;
  late AnimationController _animationController;
  bool _showFeedback = false;
  bool _correctInference = false;

  // Blue color scheme
  final Color _primaryColor = const Color(0xFF1976D2);
  final Color _lightBlue = const Color(0xFFBBDEFB);
  final Color _darkBlue = const Color(0xFF0D47A1);
  // ignore: unused_field
  final Color _accentColor = const Color(0xFF2196F3);
  final Color _lightBlueBg = const Color(0xFFE3F2FD);
  final Color _softBlue = const Color(0xFFBBDEFB);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep == 1 && _selectedOptions.isEmpty) {
      _showFeedbackMessage('Please select at least one option');
      return;
    }

    if (_currentStep == 3 && _inferenceAnswer == null) {
      _showFeedbackMessage('Please make your inference');
      return;
    }

    setState(() {
      _isProcessing = true;
      _progressValue = (_currentStep + 1) * 0.2;
      _showFeedback = false;
    });

    _animationController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _isProcessing = false;
          if (_currentStep < 4) {
            _currentStep++;
            _animationController.reset();
          } else {
            _completeAnalysis();
          }
        });
      });
    });
  }

  void _showFeedbackMessage(String message) {
    setState(() {
      _showFeedback = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: _darkBlue,
        duration: const Duration(seconds: 2),
      ),
    );
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
        );
      },
    );
  }

// Estado para opciones seleccionadas
  final Map<String, bool> _selectedOptionsStep1 = {
    "Tyler is making something": false,
    "He used wood, nails, and a hammer": false,
  };

  Widget _buildStep1() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              Text(
                "📖 Step 1: Read the Sentence",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              _buildProgressIndicator(),
              const SizedBox(height: 16),

              // Tarjeta principal
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: _lightBlue, // fondo con color del degradado
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Which option best paraphrases the sentence without changing its meaning?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _primaryColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _primaryColor.withOpacity(0.4),
                          ),
                        ),
                        child: Text(
                          "\"Tyler built a birdhouse using wood, nails, and a hammer.\"",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: _darkBlue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Select the best paraphrase: (Tap to select)",
                        style: TextStyle(
                          fontSize: 16,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Opciones A, B, C, D
                      ...[
                        "A) Tyler constructed a birdhouse using materials and tools.",
                        "B) Tyler built a birdhouse out of random objects.",
                        "C) Tyler used a hammer to destroy a wooden birdhouse with nails.",
                        "D) Tyler found a birdhouse made of wood, nails, and a hammer.",
                      ].map((option) {
                        return _buildNoticeOption(
                          option,
                          _selectedOptionsStep1[option] ?? false,
                          isCorrect: option ==
                              "A) Tyler constructed a birdhouse using materials and tools.",
                        );
                      }).toList(),

                      // Explicación — solo visible cuando se selecciona la opción correcta
                      if (_selectedOptionsStep1[
                              "A) Tyler constructed a birdhouse using materials and tools."] ==
                          true) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: _primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: _primaryColor.withOpacity(0.4),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "✅ Correct answer: A",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: _darkBlue,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                " Explanation:\nOption A replaces the specific items with the general term \"materials and tools\" while keeping the original meaning.",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _darkBlue,
                                  height: 1.5,
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

              const SizedBox(height: 16),

              // Botón continuar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  onPressed: _selectedOptionsStep1.containsValue(true)
                      ? _nextStep
                      : null,
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoticeOption(String text, bool isSelected,
    {required bool isCorrect}) {
  return GestureDetector(
    onTap: () {
      setState(() {
        _selectedOptionsStep1[text] = !isSelected;
      });

      // Mostrar SnackBar en lugar de diálogo
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
          content: Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.info,
                color: isCorrect ? _darkBlue : Colors.orange,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  isCorrect
                      ? "Correct! This is explicitly mentioned in the sentence."
                      : "Not Exactly. This might be true but isn't directly stated.",
                  style: TextStyle(
                    color: _darkBlue,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
    child: Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: isSelected
          ? (isCorrect ? _lightBlue.withOpacity(0.3) : Colors.orange[50])
          : Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? (isCorrect ? Icons.check_circle : Icons.info)
                  : Icons.circle_outlined,
              color: isSelected
                  ? (isCorrect ? _darkBlue : Colors.orange)
                  : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: _darkBlue,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              Text(
                "🛠️ Step 2: Materials Needed",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              _buildProgressIndicator(),
              const SizedBox(height: 16),
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
                        "What’s needed to build something out of wood?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Drag the correct items to the toolbox:",
                        style: TextStyle(
                          fontSize: 16,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildToolbox(),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _buildDraggableTool("Hammer", "A", Icons.handyman),
                          _buildDraggableTool("Nails", "C", Icons.construction),
                          _buildDraggableTool("Wood", "D", Icons.forest),
                          _buildDraggableTool("Paintbrush", "B", Icons.brush),
                          _buildDraggableTool("Remote", "E", Icons.tv),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (_showFeedback)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    "Selected: ${_selectedOptions.join(', ')}",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: _darkBlue,
                    ),
                  ),
                ),
              if (_selectedOptions.isNotEmpty)
                Column(
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: _lightBlue.withOpacity(0.3),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Good choices!",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _darkBlue,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "These are real construction tools and materials used for building wooden objects.",
                              style: TextStyle(
                                fontSize: 16,
                                color: _darkBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  onPressed: _nextStep,
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToolbox() {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          height: 120,
          decoration: BoxDecoration(
            color: _lightBlue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _primaryColor.withOpacity(0.5),
              width: 2,
            ),
          ),
          child: Center(
            child: _selectedOptions.isEmpty
                ? Text(
                    "Drag tools here",
                    style: TextStyle(
                      color: _darkBlue.withOpacity(0.5),
                      fontSize: 16,
                    ),
                  )
                : Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: _selectedOptions.map((option) {
                      IconData icon;
                      switch (option) {
                        case "A":
                          icon = Icons.handyman;
                          break;
                        case "B":
                          icon = Icons.brush;
                          break;
                        case "C":
                          icon = Icons.construction;
                          break;
                        case "D":
                          icon = Icons.forest;
                          break;
                        case "E":
                          icon = Icons.tv;
                          break;
                        default:
                          icon = Icons.build;
                      }
                      return Chip(
                        label: Text(
                          _getOptionText(option),
                          style: TextStyle(color: _darkBlue),
                        ),
                        avatar: Icon(icon, size: 20, color: _darkBlue),
                        backgroundColor: _lightBlue.withOpacity(0.5),
                        deleteIcon:
                            Icon(Icons.close, size: 18, color: _darkBlue),
                        onDeleted: () {
                          setState(() {
                            _selectedOptions.remove(option);
                          });
                        },
                      );
                    }).toList(),
                  ),
          ),
        );
      },
      onWillAccept: (data) => true,
      onAccept: (data) {
        setState(() {
          _selectedOptions.add(data);
        });

        // Show message if Paintbrush or Remote
        if (data == "B" || data == "E") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              backgroundColor: Colors.white,
              title: Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.orange),
                  const SizedBox(width: 8),
                  Text(
                    "Creative idea!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _darkBlue,
                    ),
                  ),
                ],
              ),
              content: Text(
                data == "B"
                    ? "The paintbrush is not necessary for this build, but it's a good idea. Try adding something else!"
                    : "The remote is not necessary here, though it could be fun. Try adding another item!",
                style: TextStyle(color: _darkBlue, fontSize: 16),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: _primaryColor),
                  onPressed: () {
                    setState(() {
                      _selectedOptions.remove(data);
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Got it"),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildDraggableTool(String text, String option, IconData icon) {
    return Draggable<String>(
      data: option,
      feedback: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _lightBlue,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: _darkBlue),
              const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  color: _darkBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: Chip(
          label: Text(text, style: TextStyle(color: _darkBlue)),
          avatar: Icon(icon, size: 20, color: _darkBlue),
          backgroundColor: _lightBlue.withOpacity(0.3),
        ),
      ),
      child: Chip(
        label: Text(text, style: TextStyle(color: _darkBlue)),
        avatar: Icon(icon, size: 20, color: _darkBlue),
        backgroundColor: _selectedOptions.contains(option)
            ? _lightBlue.withOpacity(0.5)
            : _lightBlue.withOpacity(0.3),
      ),
    );
  }

  String _getOptionText(String option) {
    switch (option) {
      case "A":
        return "Hammer";
      case "B":
        return "Paintbrush";
      case "C":
        return "Nails";
      case "D":
        return "Wood";
      case "E":
        return "Remote";
      default:
        return "";
    }
  }

  Widget _buildStep3() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              Text(
                "🧠 Step 3: Background Knowledge",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              _buildProgressIndicator(),
              const SizedBox(height: 16),
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
                        "Tap a tool to learn more about it:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildToolList(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  onPressed: _nextStep,
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToolList() {
    return Column(
      children: _matchingTools.map((item) {
        bool isExpanded = _expandedTool == item['tool'];
        return GestureDetector(
          onTap: () {
            setState(() {
              _expandedTool = isExpanded ? null : item['tool'];
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: isExpanded ? _primaryColor : Colors.grey.shade300,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                if (isExpanded)
                  BoxShadow(
                    color: _primaryColor.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(item['icon'], color: _primaryColor, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item['tool'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: _darkBlue,
                        ),
                      ),
                    ),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: _primaryColor,
                    ),
                  ],
                ),
                if (isExpanded) ...[
                  const SizedBox(height: 8),
                  Text(
                    item['purpose'],
                    style: TextStyle(
                      color: _darkBlue.withOpacity(0.8),
                      fontSize: 15,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

// Example data & state:
  final List<Map<String, dynamic>> _matchingTools = [
    {
      'tool': 'Hammer',
      'purpose':
          'A hammer is used to pound nails into wood or other materials.',
      'icon': Icons.handyman
    },
    {
      'tool': 'Nails',
      'purpose':
          'Nails are small metal pins that hold pieces of material together.',
      'icon': Icons.construction
    },
    {
      'tool': 'Wood',
      'purpose':
          'Wood is a versatile material used for building structures and furniture.',
      'icon': Icons.forest
    },
  ];

  String? _expandedTool;

  Widget _buildStep4() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              Text("🔍 Step 4: Make an Inference",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: _darkBlue,
                  )),
              _buildProgressIndicator(),
              const SizedBox(height: 16),
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
                        "How did Tyler build the birdhouse?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Based on what you read and what you know:",
                        style: TextStyle(
                          fontSize: 16,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildInferenceOption(
                          "He glued paper together", "A", false),
                      _buildInferenceOption(
                          "He used tools and materials", "B", true),
                      _buildInferenceOption("He ordered it online", "C", false),
                      _buildInferenceOption("He painted a box", "D", false),
                    ],
                  ),
                ),
              ),
              if (_inferenceAnswer != null)
                Column(
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: _correctInference
                          ? _lightBlue.withOpacity(0.3)
                          : Colors.red[100],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _correctInference ? "✅ Correct!" : " Try again",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _correctInference
                                    ? _darkBlue
                                    : Colors.red[800],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _correctInference
                                  ? "The sentence lists wood, nails, and a hammer — clear tools and materials used for building."
                                  : "Look for the option that matches the tools mentioned",
                              style: TextStyle(
                                fontSize: 16,
                                color: _correctInference
                                    ? _darkBlue
                                    : Colors.red[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  onPressed: _nextStep,
                  child: const Text(
                    "See Final Answer",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInferenceOption(String text, String option, bool isCorrect) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: _inferenceAnswer == option
          ? (isCorrect ? _lightBlue.withOpacity(0.3) : Colors.red[100])
          : Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          setState(() {
            _inferenceAnswer = option;
            _correctInference = isCorrect;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: _darkBlue,
                  ),
                ),
              ),
              if (_inferenceAnswer == option)
                Icon(
                  isCorrect ? Icons.check_circle : Icons.cancel,
                  color: isCorrect ? _primaryColor : Colors.red,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFinalStep() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("🏁 Final Answer",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: _darkBlue,
              )),
          _buildProgressIndicator(),
          const SizedBox(height: 16),
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
                    "✔ Correct Answer:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "He used tools and materials",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue,
                    ),
                  ),
                  const Divider(height: 32),
                  Text(
                    "Explanation:",
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
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "The sentence specifically mentions wood, nails, and a hammer\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "These are physical tools and materials for construction\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "No other option explains the specific tools mentioned",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton.icon(
              icon: Icon(Icons.play_arrow, color: Colors.white),
              label: const Text(
                "Start Practice Exercises",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              onPressed: _completeAnalysis,
            ),
          ),
        ],
      ),
    );
  }

  void _completeAnalysis() {
    Navigator.push(
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
                _buildFinalStep(),
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
  int hintStep5 = 0;

  Timer? _inactivityTimer;
  bool _isInactive = false;
  late AnimationController _glowController;

  final List<String> hints1 = [
    '💡 General Hint: What helps someone win a race?',
    '📌 More Specific: Smart strategy can lead to winning.',
    '📝 Little Explanation: Pacing + sprinting → winning the race.'
  ];

  final List<String> hints2 = [
    '💡 General Hint: What impresses judges during a presentation?',
    '📌 More Specific: Clear explanation and demonstration show mastery.',
    '📝 Little Explanation: Explaining + performing → impressing the judges.'
  ];

  final List<String> hints3 = [
    '💡 General Hint: How did Diego make his comeback?',
    '📌 More Specific: A disciplined recovery plan helps athletes regain strength.',
    '📝 Little Explanation: Recovery plan + consistency + effort → Diego returned to the field.'
  ];

  final List<String> hints4 = [
    '💡 General Hint: What helped David earn the scholarship?',
    '📌 More Specific: Strong applications combine grades with a compelling personal narrative.',
    '📝 Little Explanation: Outstanding grades + great personal statement → scholarship.'
  ];

  final List<String> hints5 = [
    '💡 General Hint: What does a cellphone need for charging its battery?',
    '📌 More Specific: Electricity flows through a cord to power the battery.',
    '📝 Little Explanation: Plugged in + power through the cord → battery charged.'
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Lila won the race by pacing herself and sprinting at the end.\n\nHow did she win the race?",
      "options": [
        "A) She gave up early",
        "B) She skipped the race",
        "C) She ran with smart strategy",
        "D) She walked the whole time"
      ],
      "correctIndex": 2,
      "feedback": [
        "Giving up early would prevent winning, so this is incorrect.",
        "Skipping the race means she couldn’t have won.",
        "Correct: Using pacing and sprinting helped her win — a strategy-based success.",
        "Walking the whole time would not lead to a win in most races."
      ]
    },
    {
      "question":
          "Samantha impressed the judges by clearly articulating her project and demonstrating how it functioned.\n\nHow did she leave a good impression?",
      "options": [
        "A) She sped through her presentation",
        "B) She left out key visuals in a PowerPoint Presentation",
        "C) She used only slides",
        "D) She explained and performed her experiment"
      ],
      "correctIndex": 3,
      "feedback": [
        "Speeding through a presentation usually reduces clarity and impact.",
        "Leaving out key visuals would weaken her presentation.",
        "Only using slides without demonstration is less effective.",
        "Correct: Demonstration and clear explanation show mastery of the material."
      ]
    },
    {
      "question":
          "After his injury, Diego returned to the soccer field by following a disciplined recovery plan and restoring his physical strength.\n\nHow did he make his comeback?",
      "options": [
        "A) He waited passively on bed for weeks",
        "B) He resumed too early",
        "C) He ignored the doctor’s advice and played the next day",
        "D) He got better with consistency and effort"
      ],
      "correctIndex": 3,
      "feedback": [
        "Waiting passively without rehab would slow recovery.",
        "Resuming too early could cause re-injury.",
        "Ignoring medical advice would risk his health.",
        "Correct: Rehabilitation and fitness rebuilding help athletes recover."
      ]
    },
    {
      "question":
          "David secured a scholarship by composing a compelling personal statement and maintaining outstanding academic performance.\n\nHow did he obtain the scholarship?",
      "options": [
        "A) He submitted a random application at his local newspaper office",
        "B) He earned one high score in school",
        "C) He combined academic excellence with a strong narrative",
        "D) He copied someone else’s essay"
      ],
      "correctIndex": 2,
      "feedback": [
        "Submitting a random application at a newspaper office is irrelevant.",
        "One high score alone isn’t usually enough to earn a scholarship.",
        "Correct: Successful applications pair achievements with personal insight.",
        "Copying someone else’s work is unethical and would disqualify him."
      ]
    },
    {
      "question":
          "The cellphone’s battery level increased after being plugged in.\n\nHow did it charge?",
      "options": [
        "A) Power flowed through a cord",
        "B) Wi-Fi signal",
        "C) Software update",
        "D) Low-power mode"
      ],
      "correctIndex": 0,
      "feedback": [
        "Correct: The phone charged by receiving electricity through the power source.",
        "Wi-Fi signal doesn’t charge a phone.",
        "Software updates may use battery but don’t provide charge.",
        "Low-power mode saves energy but doesn’t add battery power."
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
      hintStep5 = 0;
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
              backgroundColor: const Color(0xFFBBDEFB), // más oscuro que E3F2FD
              titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              title: Row(
                children: const [
                  Icon(Icons.emoji_events, color: Color(0xFF1565C0), size: 30),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Level Complete!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0D47A1),
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
                      color: Color(0xFF1A237E),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Get ready for the next challenge!",
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF1565C0),
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
                    foregroundColor: const Color(0xFF1565C0),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  label: const Text("Advance"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
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
    } else if (currentQuestionIndex == 4 && hintStep5 < hints5.length) {
      currentHint = hints5[hintStep5];
      currentHintIndex = hintStep5;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFBBDEFB),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF90CAF9), // más oscuro que E3F2FD
              Color(0xFF42A5F5), // más oscuro que BBDEFB
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
                        const AlwaysStoppedAnimation<Color>(Color(0xFF1565C0)),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Choose the right option",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: const Color(0xFF1976D2).withOpacity(0.4)),
                    ),
                    child: Text(
                      question['question'],
                      style: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF0D47A1)),
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
                          backgroundColor: Colors.white.withOpacity(0.75),
                          foregroundColor: const Color(0xFF0D47A1),
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(
                                  color: Color(0xFF1976D2), width: 1)),
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
                                  ? const Color.fromARGB(255, 255, 255, 255)
                                  : const Color(0xFFD32F2F)),
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  selectedOptionIndex == correctIndex
                                      ? const Color(0xFF1976D2)
                                      : const Color(0xFF90CAF9),
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
                              "Next",
                              style: TextStyle(
                                  color: selectedOptionIndex == correctIndex
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16),
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
                                                color: const Color(0xFF1976D2)
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
                                          ? const Color(0xFF1565C0)
                                          : const Color(0xFF1976D2),
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
                                    else if (currentQuestionIndex == 4)
                                      hintStep5++;
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
                                color: Colors.white.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: const Color(0xFF1565C0)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      currentHint,
                                      style: const TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Color(0xFF0D47A1)),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close,
                                        size: 20, color: Color(0xFF1565C0)),
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
                                        else if (currentQuestionIndex == 4)
                                          hintStep5 = hints5.length;
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
        .set({'completedInstructionSpot3_1': true}, SetOptions(merge: true));

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
      'completedInstructionSpot3_1': true, // Repetido por seguridad
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
            Color(0xFF90CAF9),
            Color(0xFF42A5F5),
            Color(0xFF1976D2),
          ],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32),

              // ── Trofeo con glow ──
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.3),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.emoji_events_rounded,
                  size: 90,
                  color: Color(0xFFFFE082),
                ),
              ),

              const SizedBox(height: 20),

              // ── Título ──
              const Text(
                "Great work! 🌌",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "You've completed this lesson",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.85),
                  letterSpacing: 0.3,
                ),
              ),

              const SizedBox(height: 28),

              // ── Card de resumen ──
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.92),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFF90CAF9).withOpacity(0.6),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.15),
                      offset: const Offset(0, 6),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Badge superior
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1976D2).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF1976D2).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.lightbulb_outline_rounded,
                              color: Color(0xFF1976D2), size: 16),
                          SizedBox(width: 6),
                          Text(
                            "To sum up...",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1976D2),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Inferring goals means reading between the lines to understand a character\'s purpose and how they achieved it.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.65,
                        color: Color(0xFF0D1B2A),
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    // Divider decorativo
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: const Color(0xFF90CAF9).withOpacity(0.5),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.auto_awesome,
                            color:
                                const Color(0xFF42A5F5).withOpacity(0.7),
                            size: 16,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: const Color(0xFF90CAF9).withOpacity(0.5),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Strong readers ask, "Why did they do that?" and "How did they make it happen?"',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: Color(0xFF1565C0),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // ── Botón ──
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.home_rounded, color: Colors.white),
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
                    backgroundColor:
                        const Color.fromARGB(255, 34, 100, 198),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 6,
                    shadowColor:
                        const Color(0xFF0D47A1).withOpacity(0.4),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}
}
