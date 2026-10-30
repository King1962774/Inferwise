// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unnecessary_import
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_3/Animations.dart';
import 'package:inferwise/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: unused_import
import 'package:loading_animation_widget/loading_animation_widget.dart';

class InstructionSpotPage3 extends StatefulWidget {
  final String title;
  final List<String> instructions;
  final String tipTitle;
  final List<String> tips;
  final String finalNote;

  const InstructionSpotPage3({
    super.key,
    required this.title,
    required this.instructions,
    required this.tipTitle,
    required this.tips,
    required this.finalNote,
  });

  @override
  State<InstructionSpotPage3> createState() => _InstructionSpotPage3State();
}

class _InstructionSpotPage3State extends State<InstructionSpotPage3> {
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
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'type': 'definition',
      'title': '',
      'content': [
        {
          'subtitle': null,
          'text':
              'Readers figure out the causes, consequences, or motivations in a text using your background knowledge or real-world experience.',
        },
        {
          'subtitle': 'What you do as a reader:',
          'text': '• You connect what you read with what you already know.\n'
              '• You explain why something happened or what might happen next.\n'
              '• You go beyond the exact words in the text.',
        },
      ],
    },
    {
      'type': 'example',
      'title': 'Inferring a cause',
      'image': 'assets/Imagenes de ejemplos/Level3/3.1 A Uprotted trees.webp',
      'text': 'In the morning, we noticed that the trees were uprooted, and some homes had lost their roofs.\n\n'
          '🔵 Here, you infer: This probably happened because of a storm, even though the storm isn\'t mentioned.',
    },
    {
      'type': 'example',
      'title': 'Inferring a consequence',
      'image': 'assets/Imagenes de ejemplos/Level3/3.1 B Campfire.webp',
      'text': 'The campfire started to burn uncontrollably. Tom grabbed a bucket of water.\n\n'
          ' 🔵 You infer that Tom was trying to put the fire out, based on the notion that water puts out fire.',
    },
  ];

  void _goToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondRoomPage()),
    );
  }

  void _exit() {
    Navigator.pop(context);
  }

  Widget _buildDefinitionCard(Map<String, dynamic> page) {
    final List<Map<String, dynamic>> content =
        List<Map<String, dynamic>>.from(page['content']);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Container(
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
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      page['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ...content.map((section) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (section['subtitle'] != null) ...[
                      const Divider(color: Color(0xFF90CAF9)),
                      const SizedBox(height: 10),
                      Text(
                        section['subtitle'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0D47A1),
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                    Text(
                      section['text'],
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF0D1B2A),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExampleCard(Map<String, dynamic> page) {
    final String fullText = page['text'] as String;
    final List<String> parts = fullText.split('\n\n');
    final String scenePart = parts.isNotEmpty ? parts[0] : '';
    final String explanationPart =
        parts.length > 1 ? parts.sublist(1).join('\n\n') : '';
    final String? imagePath = page['image'] as String?;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE3F2FD),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF90CAF9), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.15),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Título
              Row(
                children: [
                  const Icon(Icons.lightbulb_outline,
                      color: Color(0xFF0277BD), size: 22),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      page['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                  ),
                ],
              ),

              // Imagen debajo del título
              if (imagePath != null) ...[
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ],

              const SizedBox(height: 14),

              // Texto en itálica (la oración de ejemplo)
              Center(
                child: Text(
                  scenePart,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF0D47A1),
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Explicación con el 🔵
              if (explanationPart.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  explanationPart,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF0D1B2A),
                    height: 1.5,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLast = _currentPage == _pages.length - 1;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Cause & Consequence",
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

                const SizedBox(height: 12),

                const SizedBox(height: 12),

                // PageView con todas las cards
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _pages.length,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemBuilder: (context, index) {
                      final page = _pages[index];
                      if (page['type'] == 'definition') {
                        return _buildDefinitionCard(page);
                      } else {
                        return _buildExampleCard(page);
                      }
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // Botón: solo en la última card navega, sino avanza
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
                      backgroundColor: const Color.fromARGB(255, 34, 100, 198),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
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
          ),
        ),
      ),
    );
  }
}

class SecondRoomPage extends StatefulWidget {
  const SecondRoomPage({super.key});

  @override
  State<SecondRoomPage> createState() => _SecondRoomPageState();
}

class _SecondRoomPageState extends State<SecondRoomPage> {
  int _visibleCount = 0;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> examples = [
    {
      'title': '🔹 Inferring a Cause',
      'image': 'assets/Imagenes de ejemplos/Level3/3.1 C Soccer field.webp',
      'text': '- The soccer field was soaked and muddy by the afternoon.\n'
          '💡 Inference: It must have rained earlier.'
    },
    {
      'title': '🔹 Inferring a Cause',
      'image': 'assets/Imagenes de ejemplos/Level3/3.1 D Fire alarm.webp',
      'text': '- The fire alarm suddenly went off during class.\n'
          '💡 Inference: There was probably smoke or someone pulled the alarm.'
    },
    {
      'title': '🔹 Inferring a Consequence',
      'image': 'assets/Imagenes de ejemplos/Level3/3.1 E Emma.webp',
      'text': '- Emma forgot to set her alarm last night.\n'
          '💡 Inference: She will probably wake up late or miss something important.'
    },
    {
      'title': '🔹 Inferring a Consequence',
      'image': 'assets/Imagenes de ejemplos/Level3/3.1 F Leo.webp',
      'text': '- Leo didn\'t wear sunscreen at the beach all day.\n'
          '💡 Inference: He might get sunburned.'
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
      MaterialPageRoute(builder: (context) => const ThirdRoomPage()),
    );
  }

  void _exit() {
    Navigator.pop(context);
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
              // Título
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Color(0xFF0D47A1),
                ),
              ),
              const SizedBox(height: 12),
              // Imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),
              // Texto
              Text(
                text,
                style: const TextStyle(
                  fontSize: 15,
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
                      "Inferring Causes and \nconsequences",
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
                    'Read each example and practice your inference skills.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),

                const SizedBox(height: 10),

                // Dots indicadores
                if (_visibleCount > 0) ...[
                  _buildDots(),
                  const SizedBox(height: 6),
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
                            final example = examples[index];
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
                    onPressed: _visibleCount < examples.length
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

class ThirdRoomPage extends StatefulWidget {
  const ThirdRoomPage({super.key});

  @override
  State<ThirdRoomPage> createState() => _ThirdRoomPageState();
}

class _ThirdRoomPageState extends State<ThirdRoomPage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  final List<String> steps = [
    '🔷 1. Read the Sentences Carefully\n\nLook at the details in the sentence. What happened?\n\n➡️ The trees were uprooted.\n➡️ Some homes lost their roofs.',
    '🔷 2. Ask: What\'s Missing?\n\nIs the cause of these events directly mentioned?\n\n No — the sentence shows the effects, but not the cause.',
    '🔷 3. Activate Background Knowledge\n\nThink about real-life situations where trees are uprooted and roofs are damaged.\n\n💭 What do you already know that can cause this kind of destruction?\n\n➡️ Storms, hurricanes, or tornadoes can do this.',
    '🔷 4. Make the Inference\n\nUse your knowledge to explain what probably happened.\n\n Inference: A strong storm (like a hurricane or tornado) probably happened overnight.',
    '🔷 5. Check for Coherence\n\nDoes your inference make the sentence make more sense?\n\n Yes! Storm damage explains why the trees and homes were affected.',
    '🔵 Final Answer:\n\nThe sentence is describing storm damage, even though the storm isn\'t directly mentioned.\n\n🔹 You used elaborative explanatory inference to figure out the cause based on clues + what you know about the world.',
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

  List<TextSpan> _buildStepSpans(String text) {
    final List<TextSpan> spans = [];
    final lines = text.split('\n');

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      final bool isTitle =
          line.startsWith('🔷') || line.startsWith('🔵');

      spans.add(TextSpan(
        text: i < lines.length - 1 ? '$line\n' : line,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isTitle ? FontWeight.bold : FontWeight.w400,
          color: isTitle
              ? const Color(0xFF0D47A1)
              : const Color(0xFF0D1B2A),
          height: 1.6,
        ),
      ));
    }

    return spans;
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
                            "Let's infer the causes and \nconsequences in the \nnext sentence:",
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
                        '"In the morning, we noticed that the trees were uprooted, and some homes had lost their roofs."',
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
                          child: RichText(
                            text: TextSpan(
                              children: _buildStepSpans(steps[index]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // Botones
                Row(
                  children: [
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
                          isLast ? "Next" : "Next step",
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
                              'Readers use their own know to figure out the cause, consequence, or motivation behind something in the text — even when it isn\'t directly stated.',
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
                                  'In the morning, we noticed that the trees were uprooted, and some homes had lost their roofs.',
                              inference:
                                  'We infer that this probably happened because of a storm, even though the storm isn\'t mentioned.',
                            ),
                            _buildExample(
                              sentence:
                                  'The campfire started to burn uncontrollably. Tom grabbed a bucket of water.',
                              inference:
                                  'We infer that Tom was trying to put the fire out, using our knowledge that water puts out fire.',
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
                                      'Use your world knowledge to connect the dots — even when the text doesn\'t say it directly!',
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
    '🔷 1. Read the Sentences Carefully\n\n🔹 Understand what is stated in the text.',
    '🔷 2. Ask: What\'s Missing?\n\n🔹 Is the cause or effect directly mentioned?',
    '🔷 3. Use Background Knowledge\n\n🔹 Think about what you already know from real life.',
    '🔷 4. Make the Inference\n\n🔹 Connect the text to your knowledge to explain why something happened.',
    '🔷 5. Check for Coherence\n\n🔹 Does your inference make the meaning clearer and more logical?',
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
                              '"In the morning, we noticed that the trees were uprooted, and some homes had lost their roofs."',
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
        'Liam left his umbrella at home. Later, he came in soaking wet.\n\nWhat is the most likely cause of Liam being wet?',
    options: [
      "A) He went swimming",
      "B) He spilled water on himself",
      "C) It rained and he had no umbrella",
      "D) He was sweating a lot"
    ],
    correctIndex: 2,
    explanation:
        '💙 Since Liam didn’t take his umbrella and ended up soaking wet, the most logical cause is that it rained and he got caught in it.',
    incorrectExplanations: [
      ' A) Swimming is not mentioned in the text and doesn’t connect logically to the story.',
      ' B) There’s no evidence that Liam spilled water on himself.',
      ' C) Rain without an umbrella is the most reasonable explanation.',
      ' D) Sweating heavily wouldn’t make someone “soaking wet” in this context.',
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
  String? _missingInfoAnswer;
  String? _realLifeAnswer;
  String? _logicalCauseAnswer;
  double _progressValue = 0.2;

  void _nextStep() {
    if (_currentStep == 1 && _missingInfoAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select what information is missing')),
      );
      return;
    }
    if (_currentStep == 2 && _realLifeAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select what likely happened')),
      );
      return;
    }
    if (_currentStep == 3 && _logicalCauseAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select the most logical cause')),
      );
      return;
    }

    setState(() {
      _progressValue = (_currentStep + 1) * 0.2;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
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
                  ? const Color.fromARGB(255, 255, 255, 255).withOpacity(0.12)
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
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
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
                      ? (isCorrect
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : Colors.red[700])
                      : const Color(0xFF0D1B2A),
                ),
              ),
            ),
            if (isSelected)
              Icon(
                isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                color: isCorrect
                    ? const Color.fromARGB(255, 255, 255, 255)
                    : Colors.red,
                size: 22,
              ),
          ],
        ),
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

  // ─── STEP 1 ───────────────────────────────────────────────────────────────

  Widget _buildStep1() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "📖 Step 1: Read the whole sentence",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1)),
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
                    '"Liam left his umbrella at home. Later, he came in soaking wet."',
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
                const Text(
                  "What do we know from the sentence?",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0D47A1)),
                ),
                const SizedBox(height: 10),
                _buildKnowledgePoint("Liam forgot his umbrella at home."),
                const SizedBox(height: 8),
                _buildKnowledgePoint("He arrived completely wet."),
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
            "🤔 Step 2: What do we not know yet?",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1)),
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
                      "What is missing?",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D47A1)),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "Choose the best answer:",
                  style: TextStyle(fontSize: 15, color: Color(0xFF0D1B2A)),
                ),
              ],
            ),
          ),
          _buildOptionCard(
            text: "A) That Liam has an umbrella",
            isSelected: _missingInfoAnswer == "A",
            isCorrect: false,
            onTap: () => setState(() => _missingInfoAnswer = "A"),
          ),
          _buildOptionCard(
            text: "B) That Liam was soaking wet",
            isSelected: _missingInfoAnswer == "B",
            isCorrect: false,
            onTap: () => setState(() => _missingInfoAnswer = "B"),
          ),
          _buildOptionCard(
            text: "C) That Liam left home",
            isSelected: _missingInfoAnswer == "C",
            isCorrect: false,
            onTap: () => setState(() => _missingInfoAnswer = "C"),
          ),
          _buildOptionCard(
            text: "D) Why Liam got wet",
            isSelected: _missingInfoAnswer == "D",
            isCorrect: true,
            onTap: () => setState(() => _missingInfoAnswer = "D"),
          ),
          if (_missingInfoAnswer != null) ...[
            const SizedBox(height: 16),
            _buildFeedbackCard(
              isCorrect: _missingInfoAnswer == "D",
              message: _missingInfoAnswer == "D"
                  ? "The sentence doesn't explicitly say why Liam got wet."
                  : "Think about what connects the two parts of the sentence.",
            ),
            const SizedBox(height: 16),
            _buildContinueButton("Continue"),
          ],
        ],
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
            "🌧️ Step 3: Apply Real-World Knowledge",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1)),
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
                      "What do you know about real life?",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D47A1)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D47A1).withOpacity(0.07),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF90CAF9)),
                  ),
                  child: const Text(
                    'If someone leaves their umbrella at home and ends up soaking wet, what likely happened?',
                    style: TextStyle(
                        fontSize: 15, color: Color(0xFF0D1B2A), height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          _buildOptionCard(
            text: "A) A water balloon popped",
            isSelected: _realLifeAnswer == "A",
            isCorrect: false,
            onTap: () => setState(() => _realLifeAnswer = "A"),
          ),
          _buildOptionCard(
            text: "B) They were sweating",
            isSelected: _realLifeAnswer == "B",
            isCorrect: false,
            onTap: () => setState(() => _realLifeAnswer = "B"),
          ),
          _buildOptionCard(
            text: "C) They went swimming",
            isSelected: _realLifeAnswer == "C",
            isCorrect: false,
            onTap: () => setState(() => _realLifeAnswer = "C"),
          ),
          _buildOptionCard(
            text: "D) It rained",
            isSelected: _realLifeAnswer == "D",
            isCorrect: true,
            onTap: () => setState(() => _realLifeAnswer = "D"),
          ),
          if (_realLifeAnswer != null) ...[
            const SizedBox(height: 16),
            _buildFeedbackCard(
              isCorrect: _realLifeAnswer == "D",
              message: _realLifeAnswer == "D"
                  ? "Rain is the most common reason people get soaked when outside without an umbrella."
                  : "Consider what would make someone 'soaking wet' in normal circumstances.",
            ),
            const SizedBox(height: 16),
            _buildContinueButton("Continue"),
          ],
        ],
      ),
    );
  }

  // ─── STEP 4 ───────────────────────────────────────────────────────────────

  Widget _buildStep4() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "🔍 Step 4: Determine the Most Logical Cause",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1)),
          ),
          _buildProgressIndicator(),
          _buildInfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.lightbulb_outline,
                        color: Color(0xFF0277BD), size: 20),
                    SizedBox(width: 8),
                    Text(
                      "Choose the best explanation:",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D47A1)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D47A1).withOpacity(0.07),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF90CAF9)),
                  ),
                  child: const Text(
                    '"Liam left his umbrella at home. Later, he came in soaking wet."',
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
          _buildOptionCard(
            text: "A) He jumped in a pool",
            isSelected: _logicalCauseAnswer == "A",
            isCorrect: false,
            onTap: () => setState(() => _logicalCauseAnswer = "A"),
          ),
          _buildOptionCard(
            text: "B) He spilled juice on himself",
            isSelected: _logicalCauseAnswer == "B",
            isCorrect: false,
            onTap: () => setState(() => _logicalCauseAnswer = "B"),
          ),
          _buildOptionCard(
            text: "C) It rained and he had no umbrella",
            isSelected: _logicalCauseAnswer == "C",
            isCorrect: true,
            onTap: () => setState(() => _logicalCauseAnswer = "C"),
          ),
          _buildOptionCard(
            text: "D) He took a shower with his clothes on",
            isSelected: _logicalCauseAnswer == "D",
            isCorrect: false,
            onTap: () => setState(() => _logicalCauseAnswer = "D"),
          ),
          if (_logicalCauseAnswer != null) ...[
            const SizedBox(height: 16),
            _buildFeedbackCard(
              isCorrect: _logicalCauseAnswer == "C",
              message: _logicalCauseAnswer == "C"
                  ? "This explanation connects both parts of the sentence logically."
                  : "Look for the explanation that best fits both clues.",
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
                color: Color(0xFF0D47A1)),
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
                  child: const Text(
                    "C) It rained and he had no umbrella",
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
                _buildExplanationPoint(
                    "The sentence doesn't say 'it rained' explicitly."),
                const SizedBox(height: 8),
                _buildExplanationPoint(
                    "Based on clues (umbrella, soaking wet) and real-world knowledge."),
                const SizedBox(height: 8),
                _buildExplanationPoint(
                    "This is the most logical cause that connects both parts of the sentence."),
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
    '💡 General Hint: What went wrong that led to her being late?',
    '📌 More Specific: People often oversleep when alarms don\'t ring.',
    '📝 Little Explanation: No alarm → overslept → late to school.'
  ];

  final List<String> hints2 = [
    '💡 General Hint: What made his shoes wet?',
    '📌 More Specific: Puddles usually come from rain.',
    '📝 Little Explanation: He walked through puddles all day — it likely rained.'
  ];

  final List<String> hints3 = [
    '💡 General Hint: What usually causes a burning smell?',
    '📌 More Specific: Smoke coming from the oven is a big clue.',
    '📝 Little Explanation: If smoke is in the oven, something inside is probably burning.'
  ];

  final List<String> hints4 = [
    '💡 General Hint: What makes people really tired?',
    '📌 More Specific: Running a marathon is a big physical challenge.',
    '📝 Little Explanation: Jake was exhausted because he ran a long, tiring race.'
  ];

  final List<String> hints5 = [
    '💡 General Hint: What happens when someone skips meals?',
    '📌 More Specific: Skipping breakfast can leave you with low energy.',
    '📝 Little Explanation: Ella felt dizzy by mid-morning because she hadn\'t eaten anything.'
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "The alarm didn't go off this morning. Mia arrived late to school.\n\nWhat caused Mia to be late?",
      "options": [
        "A) She took the wrong bus",
        "B) There was traffic",
        "C) She got distracted watching TV",
        "D) She overslept because the alarm didn't ring"
      ],
      "correctIndex": 3,
      "feedback": [
        "If her alarm didn't go off, she likely overslept — causing her to arrive late.",
        "Traffic is possible, but the scenario points to oversleeping.",
        "Watching TV is not mentioned in the context.",
        "Correct: Oversleeping because the alarm didn't ring explains her being late."
      ]
    },
    {
      "question":
          "Noah's shoes were soaked. He had been walking through puddles all day.\n\nWhat caused Noah's shoes to get wet?",
      "options": [
        "A) He was washing his shoes when it started to rain",
        "B) It was raining, and he walked through water",
        "C) He spilled his drink",
        "D) He stepped in the shower"
      ],
      "correctIndex": 1,
      "feedback": [
        "Washing shoes isn't mentioned in the context.",
        "Correct: Walking through puddles while it's raining would naturally cause shoes to get soaked.",
        "Spilling a drink wouldn't soak shoes entirely.",
        "Stepping in the shower is unrelated to the context."
      ]
    },
    {
      "question":
          "The kitchen smelled like something was burning. Smoke came from the oven.\n\nWhat is the most likely cause of the smell?",
      "options": [
        "A) Someone was making toast",
        "B) A fire started in the living room",
        "C) Something in the oven was burning",
        "D) The stove was turned off"
      ],
      "correctIndex": 2,
      "feedback": [
        "Toast could cause a smell, but the context points to the oven.",
        "A fire in the living room doesn't match smoke coming from the oven.",
        "Correct: The smell of burning and smoke from the oven clearly suggest something inside it is burning.",
        "The stove being off wouldn't produce a burning smell."
      ]
    },
    {
      "question":
          "After running the marathon, Jake collapsed on the grass, exhausted.\n\nWhat most likely caused Jake's exhaustion?",
      "options": [
        "A) He didn't eat breakfast",
        "B) He had a long day at work",
        "C) He stayed up late with his friends",
        "D) He ran a long and tiring race"
      ],
      "correctIndex": 3,
      "feedback": [
        "Not eating breakfast could contribute, but the main reason is the marathon.",
        "A long workday is tiring, but the context is about running.",
        "Staying up late could cause tiredness, but not this level of exhaustion.",
        "Correct: A marathon is very physically demanding, explaining why Jake was so exhausted."
      ]
    },
    {
      "question":
          "Ella didn't eat breakfast. By mid-morning, she felt dizzy.\n\nWhat is the most likely cause of Ella feeling dizzy?",
      "options": [
        "A) She skipped lunch",
        "B) She was nervous about a test",
        "C) She hadn't eaten anything",
        "D) She drank too much water"
      ],
      "correctIndex": 2,
      "feedback": [
        "Skipping lunch wouldn't explain feeling dizzy by mid-morning.",
        "Nervousness can cause dizziness, but here it's more about not eating.",
        "Correct: Feeling dizzy by mid-morning is a common result of not eating breakfast.",
        "Too much water isn't mentioned in the context."
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
        'Olivia forgot her notebook. She couldn’t study for the test during lunch.\n\nWhat was the consequence of forgetting her notebook?',
    options: [
      "A) She had to borrow a pencil",
      "B) She couldn’t eat lunch",
      "C) She had to retake the test",
      "D) She couldn’t review her notes"
    ],
    correctIndex: 3,
    explanation:
        '✔️ Explanation: Without her notebook, she didn’t have her notes to study from — so she couldn’t review them during lunch.',
    incorrectExplanations: [
      ' Borrowing a pencil wouldn’t solve the problem of missing her notes.',
      ' She still could have eaten lunch; the issue was about studying.',
      ' There’s no mention she had to retake the test — only that she couldn’t prepare during lunch.',
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
  String? _sequenceAnswer;
  String? _consequenceAnswer;
  String? _paraphraseAnswer;
  // ignore: unused_field
  bool _isProcessing = false;

  double _progressValue = 0.2;

  void _nextStep() {
    if (_currentStep == 0 && _paraphraseAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an answer')),
      );
      return;
    }

    if (_currentStep == 1 && _sequenceAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select what happened first')),
      );
      return;
    }

    if (_currentStep == 3 && _consequenceAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select the consequence')),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
      _progressValue = (_currentStep + 2) * (1 / 6);
    });

    Future.delayed(const Duration(milliseconds: 400), () {
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

  // ─── helpers ────────────────────────────────────────────────────────────────

  Widget _buildProgressIndicator() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        value: _progressValue,
        backgroundColor: Colors.white.withOpacity(0.3),
        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0D47A1)),
        minHeight: 8,
      ),
    );
  }

  Widget _sectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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

  Widget _continueButton(String label) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _nextStep,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 34, 100, 198),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 4,
        ),
        child: Text(label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _feedbackCard(bool isCorrect, String correctMsg, String incorrectMsg) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect
            ? const Color.fromARGB(255, 255, 255, 255).withOpacity(0.08)
            : const Color(0xFFEF5350).withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCorrect ? const Color(0xFF0D47A1) : const Color(0xFFEF5350),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isCorrect ? " Correct!" : " Try again",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: isCorrect
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : const Color(0xFFD32F2F),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            isCorrect ? correctMsg : incorrectMsg,
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: isCorrect
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : const Color(0xFFD32F2F),
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionCard({
    required String text,
    required bool isSelected,
    required bool isCorrect,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect
                  ? const Color(0xFF0D47A1).withOpacity(0.12)
                  : const Color(0xFFEF5350).withOpacity(0.12))
              : const Color(0xFFE3F2FD),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? (isCorrect
                    ? const Color(0xFF0D47A1)
                    : const Color(0xFFEF5350))
                : const Color(0xFF90CAF9),
            width: isSelected ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.08),
              offset: const Offset(0, 3),
              blurRadius: 6,
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
                  color: const Color(0xFF0D1B2A),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                color: isCorrect
                    ? const Color(0xFF0D47A1)
                    : const Color(0xFFEF5350),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  // ─── steps ──────────────────────────────────────────────────────────────────

  Widget _buildStep1() {
    final bool answered = _paraphraseAnswer != null;
    final bool correct = _paraphraseAnswer == "D";

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("📖 Step 1: Read the Sentence",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1))),
          const SizedBox(height: 10),
          _buildProgressIndicator(),
          const SizedBox(height: 16),
          _sectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Analyze the sentence carefully:",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1))),
                SizedBox(height: 10),
                Text(
                  '"Olivia forgot her notebook. She couldn\'t study for the test during lunch."',
                  style: TextStyle(
                    fontSize: 17,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF0D1B2A),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _sectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Which option best paraphrases the sentence without changing its meaning?",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _optionCard(
            text: "A) Olivia skipped lunch to study for the test.",
            isSelected: _paraphraseAnswer == "A",
            isCorrect: false,
            onTap: () => setState(() => _paraphraseAnswer = "A"),
          ),
          _optionCard(
            text: "B) Olivia remembered her notebook and reviewed at lunch.",
            isSelected: _paraphraseAnswer == "B",
            isCorrect: false,
            onTap: () => setState(() => _paraphraseAnswer = "B"),
          ),
          _optionCard(
            text: "C) Olivia lost her notebook after reviewing at lunch.",
            isSelected: _paraphraseAnswer == "C",
            isCorrect: false,
            onTap: () => setState(() => _paraphraseAnswer = "C"),
          ),
          _optionCard(
            text:
                "D) Olivia left her notebook behind and was unable to review at lunch.",
            isSelected: _paraphraseAnswer == "D",
            isCorrect: true,
            onTap: () => setState(() => _paraphraseAnswer = "D"),
          ),
          if (answered) ...[
            const SizedBox(height: 12),
            _feedbackCard(
              correct,
              "Option D replaces the original verbs with synonyms while keeping the meaning the same.",
              "Think about which option keeps the same meaning using different words.",
            ),
            const SizedBox(height: 16),
            if (correct) _continueButton("Continue"),
          ],
        ],
      ),
    );
  }

  Widget _buildStep2() {
    final bool answered = _sequenceAnswer != null;
    final bool correct = _sequenceAnswer == "B";

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("🕒 Step 2: Sequence of Events",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1))),
          const SizedBox(height: 10),
          _buildProgressIndicator(),
          const SizedBox(height: 16),
          _sectionCard(
            child: const Text(
              "What happened first in the story?\n\nChoose the event that came first:",
              style: TextStyle(
                  fontSize: 15, color: Color(0xFF0D1B2A), height: 1.5),
            ),
          ),
          const SizedBox(height: 12),
          _optionCard(
            text: "A) Olivia took the test",
            isSelected: _sequenceAnswer == "A",
            isCorrect: false,
            onTap: () => setState(() => _sequenceAnswer = "A"),
          ),
          _optionCard(
            text: "B) Olivia forgot her notebook",
            isSelected: _sequenceAnswer == "B",
            isCorrect: true,
            onTap: () => setState(() => _sequenceAnswer = "B"),
          ),
          _optionCard(
            text: "C) Olivia passed the test",
            isSelected: _sequenceAnswer == "C",
            isCorrect: false,
            onTap: () => setState(() => _sequenceAnswer = "C"),
          ),
          _optionCard(
            text: "D) Olivia ate lunch",
            isSelected: _sequenceAnswer == "D",
            isCorrect: false,
            onTap: () => setState(() => _sequenceAnswer = "D"),
          ),
          if (answered) ...[
            const SizedBox(height: 12),
            _feedbackCard(
              correct,
              "Forgetting the notebook happened first, which led to not being able to study.",
              "Think about which event causes the other events.",
            ),
            const SizedBox(height: 16),
            if (correct) _continueButton("Continue"),
          ],
        ],
      ),
    );
  }

  Widget _buildStep3() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("📚 Step 3: Notebook Contents",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1))),
          const SizedBox(height: 10),
          _buildProgressIndicator(),
          const SizedBox(height: 16),
          _sectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "What do students usually keep in notebooks?",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1)),
                ),
                const SizedBox(height: 10),
                const Text("Think about what Olivia lost access to:",
                    style: TextStyle(fontSize: 14, color: Color(0xFF0D1B2A))),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    "Notes",
                    "Homework",
                    "Practice questions",
                    "Study guides"
                  ]
                      .map((t) => Chip(
                            label: Text(t,
                                style: const TextStyle(
                                    color: Color(0xFF0D47A1), fontSize: 13)),
                            backgroundColor:
                                const Color(0xFF90CAF9).withOpacity(0.4),
                            side: const BorderSide(color: Color(0xFF90CAF9)),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D47A1).withOpacity(0.07),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF90CAF9)),
                  ),
                  child: const Text(
                    "Without her notebook, Olivia probably didn't have access to her notes, which she needed to study.",
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF0D1B2A),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _continueButton("Continue"),
        ],
      ),
    );
  }

  Widget _buildStep4() {
    final bool answered = _consequenceAnswer != null;
    final bool correct = _consequenceAnswer == "D";

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("❗ Step 4: Consequences",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1))),
          const SizedBox(height: 10),
          _buildProgressIndicator(),
          const SizedBox(height: 16),
          _sectionCard(
            child: const Text(
              "What was the consequence of forgetting her notebook?\n\nChoose the best explanation:",
              style: TextStyle(
                  fontSize: 15, color: Color(0xFF0D1B2A), height: 1.5),
            ),
          ),
          const SizedBox(height: 12),
          _optionCard(
            text: "A) She had to borrow a pencil",
            isSelected: _consequenceAnswer == "A",
            isCorrect: false,
            onTap: () => setState(() => _consequenceAnswer = "A"),
          ),
          _optionCard(
            text: "B) She couldn't eat lunch",
            isSelected: _consequenceAnswer == "B",
            isCorrect: false,
            onTap: () => setState(() => _consequenceAnswer = "B"),
          ),
          _optionCard(
            text: "C) She had to retake the test",
            isSelected: _consequenceAnswer == "C",
            isCorrect: false,
            onTap: () => setState(() => _consequenceAnswer = "C"),
          ),
          _optionCard(
            text: "D) She couldn't review her notes",
            isSelected: _consequenceAnswer == "D",
            isCorrect: true,
            onTap: () => setState(() => _consequenceAnswer = "D"),
          ),
          if (answered) ...[
            const SizedBox(height: 12),
            _feedbackCard(
              correct,
              "This directly connects forgetting the notebook to the study problem.",
              "Look for the consequence that follows logically.",
            ),
            const SizedBox(height: 16),
            if (correct) _continueButton("See Final Answer"),
          ],
        ],
      ),
    );
  }

  Widget _buildFinalStep() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("🏁 Final Answer",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1))),
          const SizedBox(height: 10),
          _buildProgressIndicator(),
          const SizedBox(height: 16),
          _sectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "✔ Correct Answer:",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1)),
                ),
                const SizedBox(height: 10),
                const Text(
                  "D) She couldn't review her notes",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D1B2A)),
                ),
                const SizedBox(height: 14),
                const Divider(color: Color(0xFF90CAF9), thickness: 1.5),
                const SizedBox(height: 12),
                const Text(
                  "Explanation:",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1)),
                ),
                const SizedBox(height: 10),
                const Text(
                  "• Olivia's notes were in her notebook\n\n"
                  "• Forgetting it meant she couldn't access her study materials\n\n"
                  "• This directly explains why she couldn't study during lunch",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF0D1B2A),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _continueButton("Start Practice Exercises"),
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
                const SizedBox(height: 12),
                Expanded(child: _buildCurrentStep()),
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
    '💡 General Hint: What happens when someone forgets their lunch?',
    '📌 More Specific: If you don\'t have food, you usually can\'t eat at lunchtime.',
    '📝 Little Explanation: She forgot her lunch → didn\'t eat → skipped lunch.'
  ];

  final List<String> hints2 = [
    '💡 General Hint: What usually happens if you drink a lot of water before bed?',
    '📌 More Specific: Drinking a lot before sleeping often makes you wake up.',
    '📝 Little Explanation: She drank three bottles of water → woke up to use the bathroom.'
  ];

  final List<String> hints3 = [
    '💡 General Hint: What usually happens if you stay up all night?',
    '📌 More Specific: Staying up late can make you tired the next day.',
    '📝 Little Explanation: He stayed up watching movies → felt very tired in class.'
  ];

  final List<String> hints4 = [
    '💡 General Hint: What happens when you spend a lot of time in the sun without protection?',
    '📌 More Specific: Too much sun can cause redness and pain.',
    '📝 Little Explanation: He stayed in the sun all day without sunscreen → got sunburned.'
  ];

  final List<String> hints5 = [
    '💡 General Hint: What usually happens if someone doesn\'t prepare for a test?',
    '📌 More Specific: Not studying often leads to bad scores.',
    '📝 Little Explanation: He didn\'t prepare → likely got a low grade → felt disappointed.'
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Ella forgot her lunch at home. At noon, she sat quietly while her classmates ate.\n\nWhat is the most likely consequence?",
      "options": [
        "A) She skipped lunch",
        "B) She shared her food",
        "C) She bought extra snacks",
        "D) She played outside"
      ],
      "correctIndex": 0,
      "feedback": [
        "Correct: Since she didn't bring lunch and wasn't eating, the most logical consequence is that she skipped lunch.",
        "Sharing food isn't possible since she had no lunch.",
        "Buying extra snacks isn't mentioned in the context.",
        "Playing outside isn't connected to forgetting lunch."
      ]
    },
    {
      "question":
          "Sophia drank three large bottles of water before bed. She woke up in the middle of the night.\n\nWhat is the most likely consequence?",
      "options": [
        "A) She had a dream",
        "B) She felt thirsty",
        "C) She was late for school",
        "D) She needed to use the bathroom"
      ],
      "correctIndex": 3,
      "feedback": [
        "Having a dream is unrelated to drinking water before bed.",
        "Feeling thirsty would be the opposite of what's expected after drinking so much water.",
        "Being late for school is not mentioned.",
        "Correct: Drinking that much water before bed usually leads to waking up to use the bathroom."
      ]
    },
    {
      "question":
          "Mason stayed up all night watching movies. The next day, he kept yawning during class.\n\nWhat is the most likely consequence?",
      "options": [
        "A) He learned a lot",
        "B) He forgot his homework at home",
        "C) He skipped breakfast",
        "D) He was very tired in school"
      ],
      "correctIndex": 3,
      "feedback": [
        "Learning a lot isn't supported by the context.",
        "Forgetting homework isn't mentioned here.",
        "Skipping breakfast is unrelated to his yawning.",
        "Correct: Staying up late often leads to fatigue the next day — that's why Mason was yawning."
      ]
    },
    {
      "question":
          "Leo didn't wear sunscreen at the beach all day. The next morning, his skin was red and sore.\n\nWhat is the most likely consequence?",
      "options": [
        "A) He caught a cold",
        "B) He got sunburned",
        "C) He had an allergic reaction",
        "D) He went swimming"
      ],
      "correctIndex": 1,
      "feedback": [
        "Catching a cold isn't connected to sun exposure.",
        "Correct: Leo's skin is red and sore after being in the sun without protection — a clear sign of sunburn.",
        "An allergic reaction isn't suggested by the context.",
        "Going swimming wouldn't cause the described skin symptoms."
      ]
    },
    {
      "question":
          "Jackson didn't study for his science test. When he got his results back, he looked disappointed.\n\nWhat probably happened?",
      "options": [
        "A) He didn't take the test",
        "B) He failed or got a low grade",
        "C) He forgot his homework",
        "D) He lost his textbook"
      ],
      "correctIndex": 1,
      "feedback": [
        "Not taking the test isn't mentioned in the context.",
        "Correct: Jackson's disappointment suggests he did poorly on the test, likely because he didn't prepare.",
        "Forgetting homework is unrelated to the test result.",
        "Losing his textbook isn't part of the situation described."
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
        .set({'completedInstructionSpot3': true}, SetOptions(merge: true));

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
      'completedInstructionSpot3': true, // Repetido por seguridad
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
                "Well done! 🎉",
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
                      'Inferring causes and consequences helps you connect clues with what you already know to figure out hidden causes or predict what might happen next.',
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
                            color: const Color(0xFF42A5F5).withOpacity(0.7),
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
                      'Good readers ask not just what happened, but also why and what comes next.',
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
