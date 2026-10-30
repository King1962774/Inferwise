// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_4/Animation4_4.dart';
import 'package:inferwise/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InstructionSpotPage4_4 extends StatefulWidget {
  final String title;
  final List<String> instructions;
  final String tipTitle;
  final List<String> tips;
  final String finalNote;

  const InstructionSpotPage4_4({
    super.key,
    required this.title,
    required this.instructions,
    required this.tipTitle,
    required this.tips,
    required this.finalNote,
  });

  @override
  State<InstructionSpotPage4_4> createState() => _InstructionSpotPage4_4State();
}

class _InstructionSpotPage4_4State extends State<InstructionSpotPage4_4> {
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
              color: Colors.black.withOpacity(0.15),
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
                          color: Color(0xFFFF6F00), // Naranja oscuro
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close,
                            color: Color(0xFFFFCC80)), // Naranja claro
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
                        color: const Color(0xFFE65100)
                            .withOpacity(0.75), // Naranja quemado
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFFF9800)
                              .withOpacity(0.95), // Naranja medio
                        ),
                      ),
                      child: Text(
                        widget.instructions[_currentStep],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFFF57C00), // Naranja botón
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
  // ignore: unused_field
  int _currentPage = 0;

  final List<Map<String, String>> examples = [
    {
      'title': 'Example 1',
      'image': 'assets/Imagenes de ejemplos/Level4/4.5 A Sophia.webp',
      'text':
          'Sophia whispered to Lucas, and they both started laughing.\n✴️ Here, you use social inference to understand they are probably friends or close classmates.',
    },
    {
      'title': 'Example 2',
      'image': 'assets/Imagenes de ejemplos/Level4/4.5 B The students 4.5.webp',
      'text':
          'The students stood up when the woman entered the room.\n✴️ Here, you use social inference to understand she is likely a teacher or someone in authority.',
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
      MaterialPageRoute(builder: (context) => const InfoPage()),
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
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
          border: Border.all(color: const Color(0xFFFF9800).withOpacity(0.3)),
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
                  color: Color(0xFFE65100),
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                text,
                style: const TextStyle(
                    fontSize: 14, color: Colors.black87, height: 1.5),
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
              Color(0xFFFFF3E0),
              Color(0xFFFFE0B2),
              Color(0xFFFFCC80),
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
                      "Inferring the Social \nDynamics",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE65100),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black54),
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
                        color: const Color(0xFFFF9800).withOpacity(0.2)),
                  ),
                  child: const Text(
                    'Readers figure out relationships or social roles between people in a sentence or text by connecting it to what you already know about social interactions.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),

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
                      backgroundColor: const Color(0xFFF57C00),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 2,
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

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  int _visibleCount = 0;
  final PageController _pageController = PageController();
  // ignore: unused_field
  int _currentPage = 0;

  final List<Map<String, String>> examples = [
    {
      'title': 'Example 1',
      'image': 'assets/Imagenes de ejemplos/Level4/4.5 C Jake.webp',
      'text':
          'Jake glared at Ethan from across the room, refusing to speak or even look away.\n✴️ Here, you infer that Jake and Ethan probably don\'t get along and may be enemies or have a tense, unfriendly relationship.',
    },
    {
      'title': 'Example 2',
      'image': 'assets/Imagenes de ejemplos/Level4/4.5 D Grandma.webp',
      'text':
          'The children ran to hug an old woman as she arrived.\n✴️ Social inference: The older woman is probably a family member.',
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
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F000000),
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
          border: Border.all(color: Color(0xFFFF9800).withOpacity(0.3)),
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
                  color: Color(0xFFE65100),
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
                text,
                style: const TextStyle(
                    fontSize: 14, color: Colors.black87, height: 1.3),
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
              Color(0xFFFFF3E0),
              Color(0xFFFFE0B2),
              Color(0xFFFFCC80),
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
                      "Inferring the Social \nDynamics",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE65100),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black54),
                      onPressed: _exit,
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Info card principal
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: const Color(0xFFFF9800).withOpacity(0.2)),
                  ),
                  child: const Text(
                    'Special note: \nWriters often don\'t explain social roles or relationships directly, expecting you to understand based on how people behave and interact.',
                  ),
                ),

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
                      backgroundColor: const Color(0xFFF57C00),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 2,
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

class _ThirdRoomPageState extends State<ThirdRoomPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final List<String> steps = [
    '🟠 1. Identify time-related clues\n\nPutting on a coat and grabbing an umbrella suggests a certain weather and possibly a time of day or year.',
    '🟠 2. Think about possible times or seasons \n\nCoats and umbrellas are usually used in cold or rainy weather — maybe fall, winter, or a rainy day. ',
    '🟠 3. Look for context clues\n\nThe sentence doesn\u2019t say when, but the clothing and umbrella hint at chilly or wet weather.',
    '🟠 4. Use real-world knowledge and plausibility\n\nPeople wear coats and use umbrellas when it\u2019s cold or raining.',
    '🟠 5. Confirm the inference\n\nJake is most likely getting ready to go outside during a cold or rainy time, probably fall, winter, or a rainy day.',
    '✅ Final Answer:\n\nJake is probably preparing to go out on a cold or rainy day.',
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
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
        MaterialPageRoute(builder: (context) => const QuestionRoom()),
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
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.white,
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
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.6,
            ),
          ),
          TextSpan(
            text: '\n$body',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCard(String text, {bool isFinal = false}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFF9800),
            Color(0xFFE65100),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Color(0x59E65100),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: _buildStepText(text),
      ),
    );
  }

  Widget _buildQuickTipCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFCC80),
            Color(0xFFFF9800),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0x4DFF9800),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: const Text(
        '💡 Quick tip\n\n If more context appears (like "at a wedding" or "on a date"), update your inference accordingly. When details are missing, say "probably" or "most likely" instead of being certain.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.white,
          height: 1.6,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isFinalStep = _currentStep == steps.length - 1;

    if (isFinalStep) {
      _fadeController.forward();
    } else {
      _fadeController.reset();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF3E0),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, size: 30, color: Colors.black54),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          children: [
            // Header actualizado
            const Text(
              "Let's make a social inference:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Card de contexto
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFF9800), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x26FF9800),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                '"Liam gently held Emma\'s hand and smiled warmly at her."',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
                  color: Color(0xFFE65100),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),

            // Indicador de pasos
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(steps.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentStep == index ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentStep == index
                        ? const Color(0xFFE65100)
                        : const Color(0xFFFFCC80),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            // PageView de cards
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentStep = index),
                itemCount: steps.length,
                itemBuilder: (context, index) {
                  if (index == steps.length - 1) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildStepCard(steps[index], isFinal: true),
                          const SizedBox(height: 16),
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: _buildQuickTipCard(),
                          ),
                        ],
                      ),
                    );
                  }
                  return _buildStepCard(steps[index]);
                },
              ),
            ),

            const SizedBox(height: 20),

            // Botones
            Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _goBack,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFE0B2),
                        foregroundColor: const Color(0xFFE65100),
                        elevation: 1,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        "Back",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 12),
                Expanded(
                  flex: 4,
                  child: ElevatedButton(
                    onPressed: _nextStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF57C00),
                      foregroundColor: Colors.white,
                      elevation: 3,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      _currentStep == steps.length - 1 ? "Finish" : "Next",
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
              Color(0xFFFFF3E0), // Naranja muy claro
              Color(0xFFFFE0B2), // Naranja suave
              Color(0xFFFFCC80), // Naranja medio suave
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Card de pregunta
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFF9800), // Naranja medio
                        Color(0xFFE65100), // Naranja oscuro
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE65100).withOpacity(0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Text(
                    "Is everything clear, or would you like a quick recap?",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),

                // Botones
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
                          backgroundColor: const Color(0xFFF57C00),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
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
                          backgroundColor: Colors.white.withOpacity(0.9),
                          foregroundColor: const Color(0xFFE65100),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(
                              color: Color(0xFFFF9800),
                              width: 1.5,
                            ),
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
      backgroundColor: const Color(0xFFFFF3E0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shadowColor: const Color(0xFFFF9800).withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: const BorderSide(
                  color: Color(0xFFFF9800),
                  width: 1.5,
                ),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            fontSize: 16, color: Colors.black87, height: 1.5),
                        children: [
                          TextSpan(
                            text: 'Remember: ',
                            style: TextStyle(
                                color: Color(0xFFE65100),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          TextSpan(
                            text:
                                'Readers figure out the relationship or social roles between people in a sentence by connecting it to what you know about how people interact and relate to each other.',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Examples:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE65100),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildExample(
                      sentence:
                          'Two coworkers shared a laugh while looking at the computer screen.',
                      inference:
                          'Social inference: They probably have a friendly or cooperative working relationship.',
                    ),
                    _buildExample(
                      sentence:
                          'When the principal entered the classroom, all the students stood up quietly',
                      inference:
                          'Social inference: The principal holds an authority role, and the students respect them.',
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            fontSize: 16, color: Colors.black87, height: 1.5),
                        children: [
                          TextSpan(
                            text: 'Also: ',
                            style: TextStyle(
                                color: Color(0xFFE65100),
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Sometimes relationships or roles aren’t stated outright because the writer expects you to understand from behavior, tone, or setting. If more than one relationship fits, pick the most likely based on context.. If more than one tool could fit, choose the most likely based on context.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
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
                  backgroundColor: const Color(0xFFF57C00),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 3,
                ),
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                label: const Text(
                  'Next',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildExample(
      {required String sentence, required String inference}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF9800),
              Color(0xFFE65100),
            ],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE65100).withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '• $sentence',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 1.4),
            ),
            const SizedBox(height: 8),
            Text(
              '✩ $inference',
              style: const TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                color: Colors.white,
                height: 1.4,
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
    '1. Identify social interaction or behavior clues in the sentence.',
    '2. Think about what these clues say about how people feel or relate to each other.',
    '3. Look for extra details nearby (words about tone, gestures, or setting).',
    '4. Use your real-world knowledge about social roles and common relationships.',
    '5. State your inference clearly; if unsure, say “most likely” or suggest options.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "🔶 Step-by-Step",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE65100),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close,
                        size: 28, color: Colors.black54),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Quick tip
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 4, bottom: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFCC80),
                      Color(0xFFFF9800),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF9800).withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text(
                  'Quick tip:  If more information appears later about the people or their roles, revise your inference. Inferring the social dynamics relies on clues and are often assumptions, not facts.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Lista de pasos
              Expanded(
                child: ListView.builder(
                  itemCount: steps.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFFF9800),
                            Color(0xFFE65100),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFE65100).withOpacity(0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        steps[index],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          height: 1.6,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Botón Finish
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Start()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF57C00),
                    foregroundColor: Colors.white,
                    elevation: 3,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Finish",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        'Marcos stared at Jackson silently during the whole meeting, avoiding eye contact.\n\nWhat can you infer about their social relationship?',
    options: [
      "A) They are close friends",
      "B) They are strangers meeting for the first time",
      "C) They are ignoring everyone else",
      "D) They are uncomfortable with each other"
    ],
    correctIndex: 3,
    explanation:
        'Avoiding eye contact and silence during a meeting suggests discomfort between them.',
    incorrectExplanations: [
      ' Close friends usually interact comfortably, not avoid eye contact.',
      ' Strangers might be neutral rather than uncomfortable.',
      ' They are not focused on ignoring others; rather, they are uneasy with each other.',
      '✅ Their behavior shows discomfort, indicating they are uncomfortable with each other.',
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
      backgroundColor: const Color(0xFFFFF3E0),
      body: SafeArea(
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
                        size: 28, color: Color(0xFFF57C00)),
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
                      Color(0xFFFF9800),
                      Color(0xFFE65100),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFE65100),
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
                            ? const Color(0xFFFFF3E0)
                            : const Color(0xFFFFEBEE);
                        borderColor = isCorrect == true
                            ? const Color(0xFFF57C00)
                            : const Color(0xFFEF9A9A);
                        textColor = isCorrect == true
                            ? const Color(0xFFE65100)
                            : Colors.red.shade800;
                      } else if (isSelected) {
                        bgColor = const Color(0xFFF57C00);
                        borderColor = const Color(0xFFE65100);
                        textColor = Colors.white;
                      } else {
                        bgColor = Colors.white;
                        borderColor = const Color(0xFFFFCC80);
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
                        ? const Color(0xFFFFF3E0)
                        : const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isCorrect == true
                          ? const Color(0xFFF57C00)
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
                            ? const Color(0xFFF57C00)
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
                                    ? const Color(0xFFE65100)
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
                    backgroundColor: const Color(0xFFF57C00),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 4,
                    shadowColor: const Color(0xFFE65100),
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
  final Set<String> _selectedOptions = {}; // solo Step 2
  String? _step3Answer; // solo Step 3 — FIX BUG
  String? _inferenceAnswer;
  late AnimationController _animationController;
  // ignore: unused_field
  bool _correctInference = false;

  final Color _primaryColor = const Color(0xFFFF9800);
  final Color _lightOrange = const Color(0xFFFFE0B2);
  final Color _darkOrange = const Color(0xFFE65100);

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

  // ─── STEP 1 state ─────────────────────────────────────────────────────
  final Map<String, bool> _selectedOptionsStep1 = {
    "A": false,
    "B": false,
    "C": false,
    "D": false,
  };

  void _nextStep() {
    if (_currentStep == 0 && !_selectedOptionsStep1.containsValue(true)) {
      _showFeedbackMessage('Please select at least one option');
      return;
    }
    if (_currentStep == 1 && _selectedOptions.isEmpty) {
      _showFeedbackMessage('Please select at least one option');
      return;
    }
    if (_currentStep == 2 && _step3Answer == null) {
      _showFeedbackMessage('Please select an option to continue');
      return;
    }
    if (_currentStep == 3 && _inferenceAnswer == null) {
      _showFeedbackMessage('Please make your inference');
      return;
    }

    setState(() {
      if (_currentStep < 4) {
        _currentStep++;
      } else {
        _completeAnalysis();
      }
    });
  }

  void _showFeedbackMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: _darkOrange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ─── PROGRESS BAR ────────────────────────────────────────────────────
  Widget _buildProgressIndicator() {
    final List<String> stepLabels = ["", "", "", "", ""];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(stepLabels.length, (i) {
            final bool isActive = i == _currentStep;
            final bool isDone = i < _currentStep;
            return Column(
              children: [
                const SizedBox(height: 4),
                Text(
                  stepLabels[i],
                  style: TextStyle(
                    fontSize: 9,
                    color: isActive || isDone
                        ? _darkOrange
                        : _darkOrange.withOpacity(0.5),
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            );
          }),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: (_currentStep + 1) / 5.0,
            backgroundColor: Colors.white.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // ─── STEP 1 ───────────────────────────────────────────────────────────
  Widget _buildStep1() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                "📖 Step 1: Read the Sentence Carefully",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: _darkOrange),
              ),
              const SizedBox(height: 12),
              _buildProgressIndicator(),

              // Oración destacada
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF9800), Color(0xFFE65100)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: _darkOrange.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.format_quote,
                            color: Colors.white70, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          "Read carefully:",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '"Marcos stared at Jackson silently during the whole meeting, avoiding eye contact."',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: _primaryColor.withOpacity(0.1),
                      blurRadius: 16,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  border: Border.all(color: _lightOrange, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: _primaryColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: _primaryColor.withOpacity(0.3)),
                      ),
                      child: Text(
                        "What is the sentence mainly about?",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: _darkOrange,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _buildStep1Option(
                      "Marcos is speaking to Jackson during the meeting.",
                      "A",
                      false,
                      " The sentence says Marcos was silent, not speaking.",
                    ),
                    _buildStep1Option(
                      "Marcos is ignoring Jackson during the meeting.",
                      "B",
                      true,
                      "✅ Staring silently and avoiding eye contact are actions that show someone is ignoring or refusing to engage.",
                    ),
                    _buildStep1Option(
                      "Marcos is leading the meeting.",
                      "C",
                      false,
                      " Nothing in the sentence suggests Marcos is leading or running the meeting.",
                    ),
                    _buildStep1Option(
                      "Marcos is taking notes during the meeting.",
                      "D",
                      false,
                      " The sentence describes Marcos staring silently, not writing or taking notes.",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 4,
                    shadowColor: _primaryColor.withOpacity(0.4),
                  ),
                  onPressed: _selectedOptionsStep1.containsValue(true)
                      ? _nextStep
                      : null,
                  child: const Text("Continue  →",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep1Option(
      String text, String option, bool isCorrect, String feedback) {
    final bool isSelected = _selectedOptionsStep1[option] ?? false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedOptionsStep1.updateAll((key, value) => false);
              _selectedOptionsStep1[option] = true;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            decoration: BoxDecoration(
              color: isSelected
                  ? (isCorrect ? _lightOrange : Colors.red.shade50)
                  : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected
                    ? (isCorrect ? _primaryColor : Colors.red.shade400)
                    : Colors.grey.shade300,
                width: isSelected ? 2 : 1.5,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: (isCorrect ? _primaryColor : Colors.red)
                            .withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      )
                    ]
                  : [],
            ),
            child: Row(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    isSelected
                        ? (isCorrect
                            ? Icons.check_circle_rounded
                            : Icons.cancel_rounded)
                        : Icons.radio_button_unchecked,
                    key: ValueKey(isSelected),
                    color: isSelected
                        ? (isCorrect ? _primaryColor : Colors.red.shade400)
                        : Colors.grey.shade400,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "$option) $text",
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected
                          ? (isCorrect ? _darkOrange : Colors.red.shade700)
                          : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isSelected)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: BoxDecoration(
              color: isCorrect
                  ? _lightOrange.withOpacity(0.5)
                  : Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isCorrect ? _primaryColor : Colors.red.shade300,
                width: 1.5,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                  color: isCorrect ? _primaryColor : Colors.red.shade400,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    feedback.replaceFirst(isCorrect ? "✅ " : " ", ""),
                    style: TextStyle(
                      fontSize: 13,
                      color: isCorrect ? _darkOrange : Colors.red.shade700,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 300.ms),
      ],
    );
  }

  // ─── STEP 2 ───────────────────────────────────────────────────────────
  Widget _buildStep2() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "🔍 Step 2: Let's Identify",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _darkOrange),
                ),
                const SizedBox(height: 12),
                _buildProgressIndicator(),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: _primaryColor.withOpacity(0.1),
                        blurRadius: 16,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    border: Border.all(color: _lightOrange, width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                          color: _primaryColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: _primaryColor.withOpacity(0.3)),
                        ),
                        child: Text(
                          "What does this behavior tell us about their social relationship?",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: _darkOrange,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _buildMissingOption(
                        "They are close friends",
                        "A",
                        false,
                        " Close friends usually interact comfortably, not avoid eye contact.",
                      ),
                      _buildMissingOption(
                        "They are strangers meeting for the first time",
                        "B",
                        false,
                        " Strangers might act neutral, not show this kind of specific discomfort.",
                      ),
                      _buildMissingOption(
                        "They are ignoring everyone else",
                        "C",
                        false,
                        " The behavior focuses on discomfort between them specifically, not others.",
                      ),
                      _buildMissingOption(
                        "They are uncomfortable with each other",
                        "D",
                        true,
                        "✅ Avoiding eye contact and silence suggests discomfort between them.",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              elevation: 4,
              shadowColor: _primaryColor.withOpacity(0.4),
            ),
            onPressed: _selectedOptions.isNotEmpty ? _nextStep : null,
            child: const Text("Continue  →",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildMissingOption(
      String text, String option, bool isCorrect, String feedback) {
    final bool isSelected = _selectedOptions.contains(option);
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedOptions.clear();
              _selectedOptions.add(option);
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            decoration: BoxDecoration(
              color: isSelected
                  ? (isCorrect ? _lightOrange : Colors.red.shade50)
                  : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected
                    ? (isCorrect ? _primaryColor : Colors.red.shade400)
                    : Colors.grey.shade300,
                width: isSelected ? 2 : 1.5,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: (isCorrect ? _primaryColor : Colors.red)
                            .withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      )
                    ]
                  : [],
            ),
            child: Row(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    isSelected
                        ? (isCorrect
                            ? Icons.check_circle_rounded
                            : Icons.cancel_rounded)
                        : Icons.radio_button_unchecked,
                    key: ValueKey(isSelected),
                    color: isSelected
                        ? (isCorrect ? _primaryColor : Colors.red.shade400)
                        : Colors.grey.shade400,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "$option) $text",
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected
                          ? (isCorrect ? _darkOrange : Colors.red.shade700)
                          : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isSelected)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: BoxDecoration(
              color: isCorrect
                  ? _lightOrange.withOpacity(0.5)
                  : Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isCorrect ? _primaryColor : Colors.red.shade300,
                width: 1.5,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                  color: isCorrect ? _primaryColor : Colors.red.shade400,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    feedback.replaceFirst(isCorrect ? "✅ " : " ", ""),
                    style: TextStyle(
                      fontSize: 13,
                      color: isCorrect ? _darkOrange : Colors.red.shade700,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 300.ms),
      ],
    );
  }

  // ─── STEP 3 — FIX COMPLETO ────────────────────────────────────────────
  Widget _buildStep3() {
    final List<Map<String, dynamic>> knowledgeCards = [
      {
        "key": "A",
        "emoji": "👥",
        "title": "Close Friends",
        "description":
            "Maintain eye contact, smile, chat freely and feel comfortable around each other",
        "icon": Icons.favorite_outline,
        "correct": false,
        "feedback":
            " Close friends are relaxed and interact openly — the opposite of what Marcos is doing.",
      },
      {
        "key": "B",
        "emoji": "😤",
        "title": "People in Conflict",
        "description":
            "Avoid eye contact, stay silent, create distance — signs of tension or unresolved issues",
        "icon": Icons.bolt,
        "correct": true,
        "feedback":
            "✅ Correct! Avoiding eye contact and staying silent toward a specific person signals tension or conflict.",
      },
      {
        "key": "C",
        "emoji": "😐",
        "title": "Strangers",
        "description":
            "May feel awkward but stay neutral — they don't specifically avoid one person",
        "icon": Icons.person_outline,
        "correct": false,
        "feedback":
            " Strangers might be a little awkward, but they wouldn't deliberately avoid one specific person like this.",
      },
      {
        "key": "D",
        "emoji": "🎭",
        "title": "Professional Colleagues",
        "description":
            "Keep things formal — but deliberate silence toward one person shows something personal",
        "icon": Icons.work_outline,
        "correct": false,
        "feedback":
            " A professional setting explains formality, but not the specific avoidance directed only at Jackson.",
      },
    ];

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "🌍 Step 3: Real World Knowledge",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _darkOrange),
                ),
                const SizedBox(height: 12),
                _buildProgressIndicator(),

                // Recap oración
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF9800), Color(0xFFE65100)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: _darkOrange.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.format_quote,
                          color: Colors.white70, size: 18),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          '"Marcos stared at Jackson silently during the whole meeting, avoiding eye contact."',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Pregunta
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: _primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: _primaryColor.withOpacity(0.3)),
                  ),
                  child: Text(
                    "Which of these situations best matches what Marcos is doing?",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _darkOrange,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.touch_app,
                        color: _primaryColor.withOpacity(0.7), size: 14),
                    const SizedBox(width: 4),
                    Text(
                      "Tap a card to select it",
                      style: TextStyle(
                        fontSize: 12,
                        color: _darkOrange.withOpacity(0.6),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Cards verticales — sin overflow
                ...knowledgeCards.map((card) {
                  final key = card["key"] as String;
                  final isSelected = _step3Answer == key; // ← usa _step3Answer
                  final isCorrect = card["correct"] as bool;

                  return GestureDetector(
                    onTap: () => setState(() => _step3Answer = key),
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.only(bottom: 6),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (isCorrect
                                    ? _lightOrange
                                    : Colors.red.shade50)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? (isCorrect
                                      ? _primaryColor
                                      : Colors.red.shade400)
                                  : Colors.grey.shade300,
                              width: isSelected ? 2 : 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected
                                    ? (isCorrect ? _primaryColor : Colors.red)
                                        .withOpacity(0.12)
                                    : Colors.black.withOpacity(0.04),
                                blurRadius: isSelected ? 10 : 4,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Emoji container
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? (isCorrect
                                          ? _primaryColor.withOpacity(0.15)
                                          : Colors.red.withOpacity(0.1))
                                      : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    card["emoji"] as String,
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),

                              // Texto
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            card["title"] as String,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: isSelected
                                                  ? (isCorrect
                                                      ? _darkOrange
                                                      : Colors.red.shade700)
                                                  : Colors.black87,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          card["icon"] as IconData,
                                          size: 16,
                                          color: isSelected
                                              ? (isCorrect
                                                  ? _primaryColor
                                                  : Colors.red.shade300)
                                              : Colors.grey.shade400,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      card["description"] as String,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isSelected
                                            ? (isCorrect
                                                ? _darkOrange.withOpacity(0.75)
                                                : Colors.red.shade400)
                                            : Colors.black45,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),

                              // Icono de selección
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 250),
                                child: Icon(
                                  isSelected
                                      ? (isCorrect
                                          ? Icons.check_circle_rounded
                                          : Icons.cancel_rounded)
                                      : Icons.radio_button_unchecked,
                                  key: ValueKey(isSelected),
                                  color: isSelected
                                      ? (isCorrect
                                          ? _primaryColor
                                          : Colors.red.shade400)
                                      : Colors.grey.shade400,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Feedback inline
                        if (isSelected)
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 12),
                            decoration: BoxDecoration(
                              color: isCorrect
                                  ? _lightOrange.withOpacity(0.5)
                                  : Colors.red.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isCorrect
                                    ? _primaryColor
                                    : Colors.red.shade300,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  isCorrect
                                      ? Icons.check_circle_rounded
                                      : Icons.cancel_rounded,
                                  color: isCorrect
                                      ? _primaryColor
                                      : Colors.red.shade400,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    (card["feedback"] as String).replaceFirst(
                                        isCorrect ? "✅ " : " ", ""),
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: isCorrect
                                          ? _darkOrange
                                          : Colors.red.shade700,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ).animate().fadeIn(duration: 300.ms),
                      ],
                    ),
                  );
                }).toList(),

                // Did you know?
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _primaryColor.withOpacity(0.25)),
                    boxShadow: [
                      BoxShadow(
                        color: _primaryColor.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: _primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.psychology,
                                color: _primaryColor, size: 18),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Did you know?",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _darkOrange,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _infoRow(
                        Icons.visibility_off,
                        "Avoiding eye contact is one of the strongest nonverbal signs of discomfort or conflict between two people.",
                      ),
                      const SizedBox(height: 8),
                      _infoRow(
                        Icons.record_voice_over,
                        "Deliberate silence toward a specific person in a shared space is a form of social distancing.",
                      ),
                      const SizedBox(height: 8),
                      _infoRow(
                        Icons.group,
                        "In social psychology, this behavior pattern is often linked to unresolved tension or a past disagreement.",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),

        // Botón siempre visible fuera del scroll
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.shade300,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 4,
                shadowColor: _primaryColor.withOpacity(0.4),
              ),
              onPressed: _step3Answer != null ? _nextStep : null,
              child: const Text(
                "Draw Conclusion  →",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _primaryColor.withOpacity(0.7), size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: _darkOrange.withOpacity(0.8),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  // ─── STEP 4 ───────────────────────────────────────────────────────────
  Widget _buildStep4() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "🎯 Step 4: Make an Inference",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _darkOrange),
                ),
                const SizedBox(height: 12),
                _buildProgressIndicator(),

                // Recap de evidencia
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _lightOrange.withOpacity(0.6),
                        const Color(0xFFFF9800).withOpacity(0.2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: _primaryColor.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.summarize, color: _primaryColor, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            "Evidence gathered:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _darkOrange,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ...[
                        "👁️  Marcos stared at Jackson without making eye contact",
                        "🤐  He remained silent throughout the entire meeting",
                        "🎯  The avoidance was directed specifically at Jackson",
                      ].map((e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Text(
                              e,
                              style: TextStyle(
                                fontSize: 13,
                                color: _darkOrange,
                                height: 1.4,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: _primaryColor.withOpacity(0.1),
                        blurRadius: 16,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    border: Border.all(color: _lightOrange, width: 1.5),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                          color: _primaryColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: _primaryColor.withOpacity(0.3)),
                        ),
                        child: Text(
                          "What's the most logical conclusion?",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: _darkOrange,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _buildInferenceOption(
                        "Marcos was shy in general.",
                        "A",
                        false,
                        " Shyness would affect all interactions — this behavior is directed specifically at Jackson.",
                      ),
                      _buildInferenceOption(
                        "Marcos was distracted by other things.",
                        "B",
                        false,
                        " Distraction doesn't explain the deliberate avoidance of eye contact with one person.",
                      ),
                      _buildInferenceOption(
                        "They probably feel uneasy with each other.",
                        "C",
                        true,
                        "✅ The specific avoidance of eye contact and silence suggests tension between them.",
                      ),
                      _buildInferenceOption(
                        "Marcos wanted to surprise Jackson.",
                        "D",
                        false,
                        " Nothing in the sentence hints at a surprise — the behavior shows avoidance, not excitement.",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              elevation: 4,
              shadowColor: _primaryColor.withOpacity(0.4),
            ),
            onPressed: _inferenceAnswer != null ? _nextStep : null,
            child: const Text("See Final Answer  →",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildInferenceOption(
      String text, String option, bool isCorrect, String feedback) {
    final bool isSelected = _inferenceAnswer == option;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _inferenceAnswer = option;
              _correctInference = isCorrect;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            decoration: BoxDecoration(
              color: isSelected
                  ? (isCorrect ? _lightOrange : Colors.red.shade50)
                  : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected
                    ? (isCorrect ? _primaryColor : Colors.red.shade400)
                    : Colors.grey.shade300,
                width: isSelected ? 2 : 1.5,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: (isCorrect ? _primaryColor : Colors.red)
                            .withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      )
                    ]
                  : [],
            ),
            child: Row(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    isSelected
                        ? (isCorrect
                            ? Icons.check_circle_rounded
                            : Icons.cancel_rounded)
                        : Icons.radio_button_unchecked,
                    key: ValueKey(isSelected),
                    color: isSelected
                        ? (isCorrect ? _primaryColor : Colors.red.shade400)
                        : Colors.grey.shade400,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "$option) $text",
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected
                          ? (isCorrect ? _darkOrange : Colors.red.shade700)
                          : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isSelected)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: BoxDecoration(
              color: isCorrect
                  ? _lightOrange.withOpacity(0.5)
                  : Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isCorrect ? _primaryColor : Colors.red.shade300,
                width: 1.5,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                  color: isCorrect ? _primaryColor : Colors.red.shade400,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    feedback.replaceFirst(isCorrect ? "✅ " : " ", ""),
                    style: TextStyle(
                      fontSize: 13,
                      color: isCorrect ? _darkOrange : Colors.red.shade700,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 300.ms),
      ],
    );
  }

  // ─── FINAL STEP ───────────────────────────────────────────────────────
  Widget _buildFinalStep() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (w) => SlideAnimation(
              verticalOffset: 40.0,
              child: FadeInAnimation(child: w),
            ),
            children: [
              Text(
                "🏁 Final Answer",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: _darkOrange),
              ),
              const SizedBox(height: 12),
              _buildProgressIndicator(),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _primaryColor, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: _primaryColor.withOpacity(0.2),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.verified, color: _primaryColor, size: 26),
                        const SizedBox(width: 10),
                        Text(
                          "Correct Answer:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: _primaryColor.withOpacity(0.4)),
                      ),
                      child: Text(
                        "C) Marcos and Jackson are uncomfortable with each other.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _darkOrange,
                        ),
                      ),
                    ),
                    Divider(height: 28, thickness: 1, color: _lightOrange),
                    Row(
                      children: [
                        Icon(Icons.psychology, color: _darkOrange, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          "Explanation:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _darkOrange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...[
                      {
                        "icon": Icons.visibility_off,
                        "text":
                            "Prolonged avoidance of eye contact toward a specific person signals tension or unease."
                      },
                      {
                        "icon": Icons.favorite,
                        "text":
                            "Friends typically maintain comfortable eye contact and interact freely."
                      },
                      {
                        "icon": Icons.warning_amber_rounded,
                        "text":
                            "Selective avoidance during a shared activity like a meeting suggests a strained relationship."
                      },
                    ].map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: _primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                item["icon"] as IconData,
                                color: _primaryColor,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                item["text"] as String,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _darkOrange.withOpacity(0.85),
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.play_arrow, color: Colors.white),
                  label: const Text(
                    "Start Practice Exercises",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 5,
                    shadowColor: _primaryColor.withOpacity(0.5),
                  ),
                  onPressed: _completeAnalysis,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFF3E0),
              Color(0xFFFFE0B2),
              Color(0xFFFFCC80),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: _darkOrange, size: 26),
                    onPressed: () => Navigator.pop(context),
                  ),
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

  // Variables para el efecto del bombillo de inactividad
  Timer? _inactivityTimer;
  bool _isInactive = false;
  late AnimationController _glowController;

  final List<String> hints1 = [
    '💡 General Hint: What does sudden silence show when an authority figure enters?',
    '📌 More Specific: Do employees act this way from comfort or fear of the boss?',
  ];

  final List<String> hints2 = [
    '💡 General Hint: What kind of bond allows for private whispering and laughing?',
    '📌 More Specific: Does this shared, closed behavior indicate closeness?',
  ];

  final List<String> hints3 = [
    '💡 General Hint: What does actively avoiding proximity suggest about a relationship?',
    '📌 More Specific: Does this action show a positive or a strained connection?',
  ];

  final List<String> hints4 = [
    '💡 General Hint: Why would someone stare at a peer right after being told to partner up?',
    '📌 More Specific: Does the stare signify a choice or disagreement in this context?',
  ];

  final List<String> hints5 = [
    '💡 General Hint: What feelings do avoided eye contact and crossed arms convey?',
    '📌 More Specific: Do these closed non-verbal signs suggest comfort or annoyance/tension?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "When the boss entered the room, the employees immediately straightened up and stopped talking. \n\nWhat does this social behavior tell you about the relationship?",
      "options": [
        "A) The employees are indifferent to the boss",
        "B) The employees feel intimidated by the boss",
        "C) The employees dislike the boss",
        "D) The employees don’t know the boss"
      ],
      "correctIndex": 1,
      "feedback": [
        "Explanation: Stopping conversation and straightening up shows respect or possible intimidation towards authority.",
        "Being indifferent would mean no change in behavior.",
        "Disliking doesn’t necessarily cause this reaction; it’s more about authority.",
        "They clearly know who the boss is since they reacted to their presence."
      ]
    },
    {
      "question":
          "During lunch, Jake and Mia kept whispering and laughing together, while others sat quietly.\n\n What can you infer about Jake and Mia’s relationship?",
      "options": [
        "A) They are likely good friends",
        "B) They are avoiding each other",
        "C) They don’t know each other well",
        "D) They are competing against each other"
      ],
      "correctIndex": 0,
      "feedback": [
        "Explanation: Whispering and laughing together suggests they feel comfortable and close to one another.",
        "Avoiding each other would mean keeping distance, not sharing laughter.",
        "Their behavior shows familiarity, not lack of it.",
        "Competition is not suggested by their interaction."
      ]
    },
    {
      "question":
          "Liam avoided sitting next to Noah even though there were empty chairs nearby.\n\n What can you infer about Liam and Noah’s relationship?",
      "options": [
        "A) They are best friends",
        "B) They might not get along well",
        "C) They are family members",
        "D) They don’t know each other at all"
      ],
      "correctIndex": 1,
      "feedback": [
        "Explanation: Avoiding close proximity usually shows discomfort or strained relations.",
        "Their avoidance indicates tension, not friendship.",
        "Family members would usually not act this way without conflict.",
        "If they didn’t know each other, he wouldn’t actively avoid him."
      ]
    },
    {
      "question":
          "The teacher asked the students to work in pairs. Marcos stared at Jackson. \n\nWhat does Marcos’s stare most likely mean?",
      "options": [
        "A) Marcos wants to sit somewhere else",
        "B) Marcos is ignoring the teacher",
        "C) Marcos is upset with Jackson",
        "D) Marcos wants to work with Jackson"
      ],
      "correctIndex": 3,
      "feedback": [
        "Explanation: When asked to pair up, staring at someone often means wanting to work together or teaming up.",
        "Ignoring the teacher wouldn’t explain his focus on Jackson.",
        "There’s no sign of anger or upset behavior.",
        "He’s likely signaling interest in partnering."
      ]
    },
    {
      "question":
          "During the meeting, Kevin avoided eye contact with Sarah. When she spoke, he crossed his arms and didn’t respond.\n\n What is most likely true about Kevin’s feelings toward Sarah?",
      "options": [
        "A) He admires her and wants to work closely with her",
        "B) He is indifferent but polite",
        "C) He is trying to surprise her with something",
        "D) He feels uncomfortable or annoyed with her"
      ],
      "correctIndex": 3,
      "feedback": [
        "Explanation: Avoiding eye contact and closing off body language (crossed arms) during her speaking suggests discomfort, annoyance, or tension.",
        "If he were indifferent, he wouldn’t show clear avoidance.",
        "Surprise doesn’t explain his withdrawn behavior.",
        "His body language clearly indicates discomfort."
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
      setState(() => _isInactive = false);
    }
    _inactivityTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && !showFeedback) {
        setState(() => _isInactive = true);
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
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 16,
              backgroundColor: const Color(0xFFFFF3E0), // Naranja muy claro
              titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              title: Row(
                children: const [
                  Icon(Icons.emoji_events, color: Color(0xFFF57C00), size: 30),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Level Complete!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE65100),
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
                    style: TextStyle(fontSize: 16, color: Color(0xFF383838)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Get ready for the next challenge!",
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFFE65100),
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
                    foregroundColor: const Color(0xFFE65100),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  label: const Text("Advance"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF57C00),
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
      backgroundColor: const Color(0xFFFFF3E0),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF3E0), // Naranja muy claro
              Color(0xFFFFE0B2), // Naranja suave
              Color(0xFFFFCC80), // Naranja un poco más intenso pero suave
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
                  // Barra de progreso
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: const Color(0xFFFFCC80),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFFF57C00)),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    "Choose the right option",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE65100),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Card de pregunta
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFE0B2), Color(0xFFFFF3E0)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: const Color(0xFFFF9800).withOpacity(0.4)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF9800).withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      question['question'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFFE65100),
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Opciones
                  for (int i = 0; i < options.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ElevatedButton(
                        onPressed:
                            showFeedback ? null : () => handleOptionTap(i),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedOptionIndex == i
                              ? (i == correctIndex
                                  ? const Color(0xFFFFE0B2)
                                  : Colors.red.shade100)
                              : Colors.white,
                          foregroundColor: const Color(0xFFE65100),
                          disabledBackgroundColor: selectedOptionIndex == i
                              ? (i == correctIndex
                                  ? const Color(0xFFFFE0B2)
                                  : Colors.red.shade100)
                              : Colors.white.withOpacity(0.7),
                          disabledForegroundColor: selectedOptionIndex == i
                              ? (i == correctIndex
                                  ? const Color(0xFFE65100)
                                  : Colors.red.shade700)
                              : Colors.black45,
                          minimumSize: const Size.fromHeight(52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: BorderSide(
                              color: selectedOptionIndex == i
                                  ? (i == correctIndex
                                      ? const Color(0xFFF57C00)
                                      : Colors.red)
                                  : const Color(0xFFFF9800).withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          elevation: 1,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            options[i],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Feedback
                  if (showFeedback && selectedOptionIndex != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: selectedOptionIndex == correctIndex
                                ? const Color(0xFFFFE0B2)
                                : Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selectedOptionIndex == correctIndex
                                  ? const Color(0xFFF57C00)
                                  : Colors.red.shade300,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            selectedOptionIndex == correctIndex
                                ? "✩ ${feedback[selectedOptionIndex!]}"
                                : " ${feedback[selectedOptionIndex!]}",
                            style: TextStyle(
                              fontSize: 18,
                              height: 1.5,
                              color: selectedOptionIndex == correctIndex
                                  ? const Color(0xFFE65100)
                                  : Colors.red.shade700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  selectedOptionIndex == correctIndex
                                      ? const Color(0xFFF57C00)
                                      : const Color(0xFFFFE0B2),
                              foregroundColor:
                                  selectedOptionIndex == correctIndex
                                      ? Colors.white
                                      : const Color(0xFFE65100),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 2,
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
                                  : "Try Again",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 30),

                  // Botón de pistas
                  if (!showFeedback)
                    Row(
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
                                            color: const Color(0xFFFF9800)
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
                                      ? const Color(0xFFFF9800)
                                      : const Color(0xFFFFCC80),
                                  size: 40,
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
                                else if (currentQuestionIndex == 3)
                                  hintStep4++;
                                else if (currentQuestionIndex == 4) hintStep5++;
                              }
                            });
                          },
                        ),
                        const SizedBox(width: 12),
                        if (currentHint != null)
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: const Color(0xFFFF9800), width: 1.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFF9800)
                                        .withOpacity(0.15),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      currentHint,
                                      style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xFFE65100),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close,
                                        size: 20, color: Color(0xFFE65100)),
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
        'During the meeting, Carla rolled her eyes when Ben started speaking.\n\nWhat is their relationship most likely like?',
    options: [
      "A) They have a tense or unpleasant working relationship. ",
      "B) They are close friends who joke with each other.",
      "C) They are family members spending time together.",
      "D) They have a respectful mentor–student relationship."
    ],
    correctIndex: 0,
    explanation:
        'Rolling one’s eyes during a meeting suggests annoyance or disrespect, which is most consistent with a tense or unpleasant working relationship.',
    incorrectExplanations: [
      ' Her best friend would not usually cause eye-rolling in a professional setting.',
      ' Her younger brother implies a family relationship, not a work one.',
      ' Her mentor would be someone she respects, not someone she finds unpleasant.'
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
      backgroundColor: const Color(0xFFFFF3E0),
      body: SafeArea(
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
                        size: 28, color: Color(0xFFF57C00)),
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
                      Color(0xFFFF9800),
                      Color(0xFFE65100),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFE65100),
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
                            ? const Color(0xFFFFF3E0)
                            : const Color(0xFFFFEBEE);
                        borderColor = isCorrect == true
                            ? const Color(0xFFF57C00)
                            : const Color(0xFFEF9A9A);
                        textColor = isCorrect == true
                            ? const Color(0xFFE65100)
                            : Colors.red.shade800;
                      } else if (isSelected) {
                        bgColor = const Color(0xFFF57C00);
                        borderColor = const Color(0xFFE65100);
                        textColor = Colors.white;
                      } else {
                        bgColor = Colors.white;
                        borderColor = const Color(0xFFFFCC80);
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
                        ? const Color(0xFFFFF3E0)
                        : const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isCorrect == true
                          ? const Color(0xFFF57C00)
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
                            ? const Color(0xFFF57C00)
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
                                    ? const Color(0xFFE65100)
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
                    backgroundColor: const Color(0xFFF57C00),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 4,
                    shadowColor: const Color(0xFFE65100),
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
  // ignore: unused_field
  final Set<String> _selectedOptions = {}; // Step 2 y 3
  String? _step1Answer;
  String? _step2Answer;
  String? _step3Answer;
  String? _inferenceAnswer;
  late AnimationController _animationController;

  final Color _primaryColor = const Color(0xFFF57C00);
  final Color _lightOrange = const Color(0xFFFFE0B2);
  final Color _darkOrange = const Color(0xFFE65100);
  final Color _accentColor = const Color(0xFFFF9800);
  final Color _backgroundLight = const Color(0xFFFFF3E0);
  final Color _backgroundDark = const Color(0xFFFFCC80);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep == 0 && _step1Answer == null) {
      _showSnack('Please select an answer to continue');
      return;
    }
    if (_currentStep == 1 && _step2Answer == null) {
      _showSnack('Please identify Carla\'s behavior');
      return;
    }
    if (_currentStep == 2 && _step3Answer == null) {
      _showSnack('Please select what eye-rolling signals');
      return;
    }
    if (_currentStep == 3 && _inferenceAnswer == null) {
      _showSnack('Please choose your conclusion');
      return;
    }

    _animationController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (!mounted) return;
        setState(() {
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

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: _darkOrange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ── Shared design widgets ───────────────────────────────────────────
  Widget _sentenceCard(String sentence) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF9800), Color(0xFFE65100)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: _darkOrange.withOpacity(0.25),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.format_quote, color: Colors.white70, size: 16),
              const SizedBox(width: 6),
              Text(
                "Read carefully:",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            sentence,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _questionBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _primaryColor.withOpacity(0.12),
            _accentColor.withOpacity(0.06)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _primaryColor.withOpacity(0.35)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: _darkOrange,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _whiteCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.1),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: _lightOrange, width: 1.5),
      ),
      child: child,
    );
  }

  Widget _feedbackBubble(String feedback, bool isCorrect) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isCorrect ? _lightOrange.withOpacity(0.5) : Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCorrect ? _primaryColor : Colors.red.shade300,
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
            color: isCorrect ? _primaryColor : Colors.red.shade400,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              feedback,
              style: TextStyle(
                fontSize: 13,
                color: isCorrect ? _darkOrange : Colors.red.shade700,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionTile({
    required String label,
    required String text,
    required bool isSelected,
    required bool isCorrect,
    required VoidCallback onTap,
    String? feedback,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            decoration: BoxDecoration(
              color: isSelected
                  ? (isCorrect ? _lightOrange : Colors.red.shade50)
                  : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected
                    ? (isCorrect ? _primaryColor : Colors.red.shade400)
                    : Colors.grey.shade300,
                width: isSelected ? 2 : 1.5,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: (isCorrect ? _primaryColor : Colors.red)
                            .withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      )
                    ]
                  : [],
            ),
            child: Row(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    isSelected
                        ? (isCorrect
                            ? Icons.check_circle_rounded
                            : Icons.cancel_rounded)
                        : Icons.radio_button_unchecked,
                    key: ValueKey(isSelected),
                    color: isSelected
                        ? (isCorrect ? _primaryColor : Colors.red.shade400)
                        : Colors.grey.shade400,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "$label) $text",
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected
                          ? (isCorrect ? _darkOrange : Colors.red.shade700)
                          : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isSelected && feedback != null)
          _feedbackBubble(feedback, isCorrect),
      ],
    );
  }

  Widget _continueBtn(String label, {VoidCallback? onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _primaryColor,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey.shade300,
            disabledForegroundColor: Colors.grey.shade500,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 4,
            shadowColor: _primaryColor.withOpacity(0.4),
          ),
          onPressed: onPressed,
          child: Text(label,
              style:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _primaryColor.withOpacity(0.8), size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: _darkOrange.withOpacity(0.85),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════
  // STEP 1 — What is the sentence mainly about?
  // ══════════════════════════════════════════════════════
  Widget _buildStep1() {
    final opts = {
      "A": {
        "text": "Carla is carefully listening to Ben's ideas.",
        "correct": false,
        "feedback":
            "Rolling one's eyes is the opposite of careful listening — it shows disengagement.",
      },
      "B": {
        "text": "Carla is showing annoyance toward Ben.",
        "correct": true,
        "feedback":
            "Correct! Rolling one's eyes usually shows irritation or annoyance, especially when someone begins speaking.",
      },
      "C": {
        "text": "Carla is leading the meeting discussion.",
        "correct": false,
        "feedback":
            "Nothing in the sentence suggests Carla is in charge of the meeting.",
      },
      "D": {
        "text": "Carla is agreeing with what Ben is saying.",
        "correct": false,
        "feedback":
            "Agreement is shown through nodding or positive reactions — eye-rolling is the opposite.",
      },
    };

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _sentenceCard(
                    '"During the meeting, Carla rolled her eyes when Ben started speaking."'),
                const SizedBox(height: 16),
                _whiteCard(
                  child: Column(
                    children: [
                      _questionBox("What is the sentence mainly about?"),
                      const SizedBox(height: 16),
                      ...opts.entries.map((e) => _optionTile(
                            label: e.key,
                            text: e.value["text"] as String,
                            isSelected: _step1Answer == e.key,
                            isCorrect: e.value["correct"] as bool,
                            feedback: e.value["feedback"] as String,
                            onTap: () => setState(() => _step1Answer = e.key),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Info extra
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _primaryColor.withOpacity(0.25)),
                    boxShadow: [
                      BoxShadow(
                        color: _primaryColor.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: _primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.psychology,
                                color: _primaryColor, size: 16),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Did you know?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _darkOrange,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _infoRow(Icons.visibility,
                          "Eye-rolling is one of the most universally recognized nonverbal signs of annoyance or dismissal."),
                      _infoRow(Icons.work,
                          "In professional settings, it's often seen as disrespectful toward the person speaking."),
                      _infoRow(Icons.emoji_people,
                          "Body language like this reveals emotions that people don't always express in words."),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        _continueBtn("Continue  →",
            onPressed: _step1Answer != null ? _nextStep : null),
      ],
    );
  }

  // ══════════════════════════════════════════════════════
  // STEP 2 — Let's Identify: which behavior shows annoyance?
  // ══════════════════════════════════════════════════════
  Widget _buildStep2() {
    final opts = {
      "A": {
        "text": "She rolls her eyes when Ben starts speaking.",
        "correct": true,
        "feedback":
            "Rolling one's eyes is a common behavior that shows annoyance or frustration toward someone.",
      },
      "B": {
        "text": "She listens carefully to Ben's ideas.",
        "correct": false,
        "feedback":
            "Careful listening shows interest or respect — the opposite of what Carla is doing.",
      },
      "C": {
        "text": "She agrees with Ben during the meeting.",
        "correct": false,
        "feedback":
            "Agreement usually involves nodding or verbal confirmation, not eye-rolling.",
      },
      "D": {
        "text": "She takes notes while Ben is talking.",
        "correct": false,
        "feedback":
            "Taking notes shows engagement — eye-rolling shows the opposite.",
      },
    };

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Sentence recap
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF9800), Color(0xFFE65100)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: _darkOrange.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.format_quote,
                          color: Colors.white70, size: 16),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          '"During the meeting, Carla rolled her eyes when Ben started speaking."',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                _whiteCard(
                  child: Column(
                    children: [
                      _questionBox(
                          "Which of Carla's behaviors shows that she is annoyed with Ben?"),
                      const SizedBox(height: 16),
                      ...opts.entries.map((e) => _optionTile(
                            label: e.key,
                            text: e.value["text"] as String,
                            isSelected: _step2Answer == e.key,
                            isCorrect: e.value["correct"] as bool,
                            feedback: e.value["feedback"] as String,
                            onTap: () => setState(() => _step2Answer = e.key),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Reactions guide
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _primaryColor.withOpacity(0.25)),
                    boxShadow: [
                      BoxShadow(
                        color: _primaryColor.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: _primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.compare_arrows,
                                color: _primaryColor, size: 16),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Behavior guide:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _darkOrange,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ...[
                        {
                          "emoji": "🙄",
                          "label": "Eye-rolling",
                          "meaning": "Annoyance, dismissal, disrespect"
                        },
                        {
                          "emoji": "😊",
                          "label": "Smiling / nodding",
                          "meaning": "Agreement, support, interest"
                        },
                        {
                          "emoji": "✍️",
                          "label": "Taking notes",
                          "meaning": "Engagement, focus, attentiveness"
                        },
                        {
                          "emoji": "👂",
                          "label": "Careful listening",
                          "meaning": "Respect, curiosity, openness"
                        },
                      ].map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Text(item["emoji"] as String,
                                    style: const TextStyle(fontSize: 18)),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "${item["label"]}:  ",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: _darkOrange,
                                          ),
                                        ),
                                        TextSpan(
                                          text: item["meaning"] as String,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                _darkOrange.withOpacity(0.75),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        _continueBtn("Identify the Behavior  →",
            onPressed: _step2Answer != null ? _nextStep : null),
      ],
    );
  }

  // ══════════════════════════════════════════════════════
  // STEP 3 — Real-world knowledge: what does eye-rolling mean?
  // ══════════════════════════════════════════════════════
  Widget _buildStep3() {
    final opts = {
      "A": {
        "text": "Annoyance, impatience, or disrespect toward someone.",
        "correct": true,
        "feedback":
            "Eye-rolling is a clear nonverbal cue of negative feelings toward the person speaking.",
      },
      "B": {
        "text": "Support and encouragement for the speaker.",
        "correct": false,
        "feedback":
            "Supportive reactions include nodding, smiling, or leaning in — not eye-rolling.",
      },
      "C": {
        "text": "Confusion or curiosity about the topic.",
        "correct": false,
        "feedback":
            "Confused people usually look thoughtful or ask questions — eye-rolling shows a different emotion.",
      },
      "D": {
        "text": "Agreement and approval of the speaker's ideas.",
        "correct": false,
        "feedback":
            "Agreement is shown through positive body language like nodding — eye-rolling signals the opposite.",
      },
    };

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Context card
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _lightOrange.withOpacity(0.6),
                        _accentColor.withOpacity(0.15),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _primaryColor.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.emoji_people,
                              color: _primaryColor, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            "Real-life context:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _darkOrange,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Rolling your eyes is a gesture that people typically make when they are frustrated, bored, or annoyed by what someone is doing or saying.",
                        style: TextStyle(
                          fontSize: 13,
                          color: _darkOrange,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                _whiteCard(
                  child: Column(
                    children: [
                      _questionBox(
                          "In real life, rolling your eyes is generally a sign of:"),
                      const SizedBox(height: 16),
                      ...opts.entries.map((e) => _optionTile(
                            label: e.key,
                            text: e.value["text"] as String,
                            isSelected: _step3Answer == e.key,
                            isCorrect: e.value["correct"] as bool,
                            feedback: e.value["feedback"] as String,
                            onTap: () => setState(() => _step3Answer = e.key),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Important reminder
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _primaryColor.withOpacity(0.25)),
                    boxShadow: [
                      BoxShadow(
                        color: _primaryColor.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: _primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.lightbulb_outline,
                                color: _primaryColor, size: 16),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Remember:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _darkOrange,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _infoRow(Icons.group,
                          "People usually don't roll their eyes at mentors or people they respect."),
                      _infoRow(Icons.favorite_border,
                          "Best friends might do it playfully, but in a formal meeting it signals real frustration."),
                      _infoRow(Icons.work_outline,
                          "In professional settings, eye-rolling is often seen as disrespectful or hostile behavior."),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        _continueBtn("Apply Knowledge  →",
            onPressed: _step3Answer != null ? _nextStep : null),
      ],
    );
  }

  // ══════════════════════════════════════════════════════
  // STEP 4 — Make the inference about their relationship
  // ══════════════════════════════════════════════════════
  Widget _buildStep4() {
    final opts = {
      "A": {
        "text":
            "Carla and Ben have a tense or unpleasant working relationship.",
        "correct": true,
        "feedback":
            "Rolling one's eyes during a meeting suggests annoyance or disrespect — most consistent with a tense working relationship.",
      },
      "B": {
        "text": "Carla and Ben are close friends who joke with each other.",
        "correct": false,
        "feedback":
            "Close friends might tease each other, but eye-rolling in a formal meeting shows real frustration, not playfulness.",
      },
      "C": {
        "text": "Carla and Ben are family members spending time together.",
        "correct": false,
        "feedback":
            "The sentence is set in a professional meeting — there's no indication of a family relationship.",
      },
      "D": {
        "text": "Carla and Ben have a respectful mentor–student relationship.",
        "correct": false,
        "feedback":
            "A mentor–student relationship involves respect and support — eye-rolling contradicts this entirely.",
      },
    };

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Evidence recap
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _lightOrange.withOpacity(0.6),
                        _accentColor.withOpacity(0.2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _primaryColor.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.summarize, color: _primaryColor, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            "Evidence gathered:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _darkOrange,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ...[
                        "🙄  Carla rolled her eyes when Ben started speaking",
                        "🏢  The action took place during a professional meeting",
                        "⚡  Eye-rolling signals annoyance or disrespect toward someone",
                      ].map((e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Text(
                              e,
                              style: TextStyle(
                                fontSize: 13,
                                color: _darkOrange,
                                height: 1.4,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                _whiteCard(
                  child: Column(
                    children: [
                      _questionBox(
                          "What does Carla's behavior tell us about her relationship with Ben?"),
                      const SizedBox(height: 14),
                      ...opts.entries.map((e) => _optionTile(
                            label: e.key,
                            text: e.value["text"] as String,
                            isSelected: _inferenceAnswer == e.key,
                            isCorrect: e.value["correct"] as bool,
                            feedback: e.value["feedback"] as String,
                            onTap: () => setState(() {
                              _inferenceAnswer = e.key;
                            }),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Relationship comparison
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _primaryColor.withOpacity(0.25)),
                    boxShadow: [
                      BoxShadow(
                        color: _primaryColor.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: _primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.people_alt,
                                color: _primaryColor, size: 16),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Relationship signals:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _darkOrange,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ...[
                        {
                          "emoji": "😤",
                          "label": "Tense coworkers",
                          "signal": "Eye-rolling, avoiding, cold body language"
                        },
                        {
                          "emoji": "😊",
                          "label": "Close friends",
                          "signal": "Smiling, joking, comfortable interaction"
                        },
                        {
                          "emoji": "🎓",
                          "label": "Mentor–student",
                          "signal": "Active listening, note-taking, respect"
                        },
                        {
                          "emoji": "👨‍👩‍👧",
                          "label": "Family",
                          "signal": "Casual tone, personal topics, familiarity"
                        },
                      ].map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item["emoji"] as String,
                                    style: const TextStyle(fontSize: 18)),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "${item["label"]}:  ",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: _darkOrange,
                                          ),
                                        ),
                                        TextSpan(
                                          text: item["signal"] as String,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                _darkOrange.withOpacity(0.75),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        _continueBtn("See Final Answer  →",
            onPressed: _inferenceAnswer != null ? _nextStep : null),
      ],
    );
  }

  // ══════════════════════════════════════════════════════
  // STEP 5 — Final Answer (intacto)
  // ══════════════════════════════════════════════════════
  Widget _buildFinalStep() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (w) => SlideAnimation(
              verticalOffset: 40.0,
              child: FadeInAnimation(child: w),
            ),
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _primaryColor, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: _primaryColor.withOpacity(0.2),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.verified, color: _primaryColor, size: 26),
                        const SizedBox(width: 10),
                        Text(
                          "Correct Answer:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: _primaryColor.withOpacity(0.4)),
                      ),
                      child: Text(
                        "Carla is frustrated or annoyed by Ben in a work setting.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _darkOrange,
                        ),
                      ),
                    ),
                    Divider(height: 28, thickness: 1, color: _lightOrange),
                    Row(
                      children: [
                        Icon(Icons.psychology, color: _darkOrange, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          "Explanation:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _darkOrange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...[
                      {
                        "icon": Icons.visibility,
                        "text":
                            "Rolling your eyes in a meeting is a nonverbal cue of annoyance or disdain."
                      },
                      {
                        "icon": Icons.work,
                        "text":
                            "In a professional setting, this behavior suggests frustration with that person."
                      },
                      {
                        "icon": Icons.people,
                        "text":
                            "Carla likely sees Ben as an unpleasant or irritating coworker."
                      },
                    ].map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: _primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                item["icon"] as IconData,
                                color: _primaryColor,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                item["text"] as String,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _darkOrange.withOpacity(0.85),
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.play_arrow, color: Colors.white),
                  label: const Text(
                    "Start Practice Exercises",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 5,
                    shadowColor: _primaryColor.withOpacity(0.5),
                  ),
                  onPressed: _completeAnalysis,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  void _completeAnalysis() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondActyvityAnimation()),
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
    final titles = [
      "📖 Read the Sentence",
      "🔍 Let's Identify",
      "🌍 Real World Knowledge",
      "🎯 Make an Inference",
      "🏁 Final Answer",
    ];

    return Scaffold(
      backgroundColor: _backgroundLight,
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
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.close, color: _darkOrange, size: 26),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                // Progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: (_currentStep + 1) / 5.0,
                    backgroundColor: const Color(0xFFFFCC80),
                    valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
                    minHeight: 7,
                  ),
                ),
                const SizedBox(height: 10),

                // Step title
                Text(
                  titles[_currentStep],
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: _darkOrange,
                  ),
                ),
                const SizedBox(height: 10),

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
    '💡 General Hint: What does purposefully ignoring someone you’ve made eye contact with mean?',
    '📌 More Specific: Does this deliberate oversight suggest tension or closeness?',
  ];

  final List<String> hints2 = [
    '💡 General Hint: What emotion does a loud sigh usually express in response to a plan?',
    '📌 More Specific: Does this reaction indicate enthusiasm or reluctance/frustration about partnering?',
  ];

  final List<String> hints3 = [
    '💡 General Hint: What kind of relationship involves saving a seat and giving a warm smile?',
    '📌 More Specific: Do strangers or close acquaintances typically perform this thoughtful gesture?',
  ];

  final List<String> hints4 = [
    '💡 General Hint: What does using an intermediary suggest about direct communication?',
    '📌 More Specific: Why would someone avoid direct contact with a close family member?',
  ];

  final List<String> hints5 = [
    '💡 General Hint: What social signals are sent by leaning closer and laughing readily at someone?',
    '📌 More Specific: Do these actions indicate disinterest or common signs of attraction/interest?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "At university, Liam walked past Sarah without saying hello, even though they made eye contact.\n\n What is their relationship most likely like?",
      "options": [
        "A) They are avoiding each other",
        "B) They are close friends",
        "C) They are siblings",
        "D) They are classmates who study together often"
      ],
      "correctIndex": 0,
      "feedback": [
        "Explanation: Ignoring someone on purpose often indicates tension, conflict, or avoidance in a relationship.",
        "Close friends would normally greet each other.",
        "Siblings might avoid each other sometimes, but this seems more like social tension.",
        "Classmates who study together usually maintain some communication."
      ]
    },
    {
      "question":
          "When the teacher assigned partners, Maria sighed loudly after hearing she would work with Lucas. \n\nHow does Maria probably feel about Lucas?",
      "options": [
        "A) She doesn’t enjoy working with him",
        "B) She is excited to team up with him",
        "C) She thinks he is very smart",
        "D) She wants to be friends with him"
      ],
      "correctIndex": 0,
      "feedback": [
        "Explanation: A loud sigh in this context suggests frustration or disappointment, indicating a strained relationship.",
        "If she were excited, she wouldn’t sigh in frustration.",
        "Admiration or thinking someone is smart usually wouldn’t cause a sigh.",
        "A sigh suggests the opposite of wanting to be friends."
      ]
    },
    {
      "question":
          "Jacob smiled warmly and saved a seat for Emily at the café. \n\nWhat is most likely their relationship?",
      "options": [
        "A) They are close friends",
        "B) They are strangers",
        "C) They are work rivals",
        "D) They are classmates who never talk"
      ],
      "correctIndex": 0,
      "feedback": [
        "Explanation: Saving a seat and smiling warmly are friendly and affectionate actions that show a close, positive connection.",
        "Strangers wouldn’t reserve a seat for each other.",
        "Work rivals would not typically show such kindness.",
        "If they never talk, he wouldn’t save her a seat."
      ]
    },
    {
      "question":
          "Jhovanna texted her brother to give a message to their mom. She didn’t want to text her directly.\n\n What is most likely the relationship between Jhovanna and her mom right now?",
      "options": [
        "A) They are not speaking",
        "B) They are planning a surprise together",
        "C) They just had a fun conversation",
        "D) They work together every day"
      ],
      "correctIndex": 0,
      "feedback": [
        "Explanation: Avoiding direct contact and sending messages through someone else often suggests tension, conflict, or poor communication in a relationship.",
        "Planning a surprise would not require avoiding contact.",
        "If they just had a fun conversation, she would text her directly.",
        "Working together daily implies frequent communication, not avoidance."
      ]
    },
    {
      "question":
          "Mia smiled and leaned closer when Daniel started talking. She laughed at his jokes, even the not-so-funny ones. \n\n What is most likely true about Mia’s feelings toward Daniel?",
      "options": [
        "A) She finds him annoying",
        "B) She is ignoring him",
        "C) She is upset with him",
        "D) She is interested in him"
      ],
      "correctIndex": 3,
      "feedback": [
        "Explanation: Smiling, leaning in, and laughing at someone’s jokes (even common signs of interest) suggest Mia likes Daniel.",
        "Finding someone annoying usually leads to avoiding or dismissive behavior.",
        "Ignoring someone is the opposite of leaning in and smiling.",
        "Being upset would not involve friendly laughter and closeness."
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
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 16,
              backgroundColor: const Color(0xFFFFF3E0),
              titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              title: Row(
                children: const [
                  Icon(Icons.emoji_events, color: Color(0xFFF57C00), size: 30),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Level Complete!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE65100),
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
                    style: TextStyle(fontSize: 16, color: Color(0xFF383838)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Get ready for the next challenge!",
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFFE65100),
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
                    foregroundColor: const Color(0xFFE65100),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  label: const Text("Advance"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF57C00),
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
      backgroundColor: const Color(0xFFFFF3E0),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF3E0),
              Color(0xFFFFE0B2),
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
                  // Barra de progreso
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: const Color(0xFFFFCC80),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFFF57C00)),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    "Choose the right option",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE65100),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Card de pregunta con degradado
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF9800), Color(0xFFE65100)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFE65100).withOpacity(0.25),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      question['question'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Opciones
                  for (int i = 0; i < options.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ElevatedButton(
                        onPressed:
                            showFeedback ? null : () => handleOptionTap(i),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedOptionIndex == i
                              ? (i == correctIndex
                                  ? const Color(0xFFFFE0B2)
                                  : Colors.red.shade100)
                              : Colors.white,
                          foregroundColor: const Color(0xFFE65100),
                          disabledBackgroundColor: selectedOptionIndex == i
                              ? (i == correctIndex
                                  ? const Color(0xFFFFE0B2)
                                  : Colors.red.shade100)
                              : Colors.white.withOpacity(0.7),
                          disabledForegroundColor: selectedOptionIndex == i
                              ? (i == correctIndex
                                  ? const Color(0xFFE65100)
                                  : Colors.red.shade700)
                              : Colors.black45,
                          minimumSize: const Size.fromHeight(52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: BorderSide(
                              color: selectedOptionIndex == i
                                  ? (i == correctIndex
                                      ? const Color(0xFFF57C00)
                                      : Colors.red)
                                  : const Color(0xFFFF9800).withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          elevation: 1,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            options[i],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Feedback
                  if (showFeedback && selectedOptionIndex != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: selectedOptionIndex == correctIndex
                                ? const Color(0xFFFFE0B2)
                                : Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selectedOptionIndex == correctIndex
                                  ? const Color(0xFFF57C00)
                                  : Colors.red.shade300,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            selectedOptionIndex == correctIndex
                                ? "✩ ${feedback[selectedOptionIndex!]}"
                                : " ${feedback[selectedOptionIndex!]}",
                            style: TextStyle(
                              fontSize: 18,
                              height: 1.5,
                              color: selectedOptionIndex == correctIndex
                                  ? const Color(0xFFE65100)
                                  : Colors.red.shade700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  selectedOptionIndex == correctIndex
                                      ? const Color(0xFFF57C00)
                                      : const Color(0xFFFFE0B2),
                              foregroundColor:
                                  selectedOptionIndex == correctIndex
                                      ? Colors.white
                                      : const Color(0xFFE65100),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 2,
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
                                  : "Try Again",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 30),

                  // Botón de pistas
                  if (!showFeedback)
                    Row(
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
                                            color: const Color(0xFFFF9800)
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
                                      ? const Color(0xFFFF9800)
                                      : const Color(0xFFFFCC80),
                                  size: 40,
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
                                else if (currentQuestionIndex == 3)
                                  hintStep4++;
                                else if (currentQuestionIndex == 4) hintStep5++;
                              }
                            });
                          },
                        ),
                        const SizedBox(width: 12),
                        if (currentHint != null)
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFFF9800),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFF9800)
                                        .withOpacity(0.15),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      currentHint,
                                      style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xFFE65100),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close,
                                        size: 20, color: Color(0xFFE65100)),
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
        .set({'completedInstructionSpot4_4': true}, SetOptions(merge: true));

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
      'completedInstructionSpot4_4': true, // Repetido por seguridad
      'completedSpotsCount': FieldValue.increment(1),
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF3E0),
              Color(0xFFFFE0B2),
              Color(0xFFFFCC80),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ── Sección superior: trofeo y felicitación ──
                      Column(
                        children: [
                          // Trofeo con glow
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFFE0B2), Color(0xFFFFCC80)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFFFF9800).withOpacity(0.4),
                                  blurRadius: 24,
                                  spreadRadius: 4,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                              border: Border.all(
                                color: const Color(0xFFF57C00),
                                width: 3,
                              ),
                            ),
                            child: const Icon(
                              Icons.emoji_events,
                              size: 70,
                              color: Color(0xFFF57C00),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Título
                          const Text(
                            "🎉 Amazing Work!",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE65100),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),

                          // Subtítulo motivacional
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF57C00).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: const Color(0xFFFF9800).withOpacity(0.4),
                                width: 1.5,
                              ),
                            ),
                            child: const Text(
                              "You did amazing! The more you practice how to infer the social dynamics, the better you'll become! 🌟👏",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFE65100),
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // ── Sección central: resumen ──
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF9800).withOpacity(0.15),
                              blurRadius: 20,
                              offset: const Offset(0, 6),
                            ),
                          ],
                          border: Border.all(
                            color: const Color(0xFFFF9800).withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "To sum up...",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFF57C00),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Punto 1
                            _buildSummaryPoint(
                              Icons.search,
                              "inferring social dynamics means using clues from people’s words, actions, and body language—along with our real-world knowledge—to understand their relationships, feelings, and roles.",
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ── Botón Back to Home ──
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.home_rounded,
                              color: Colors.white, size: 24),
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
                            backgroundColor: const Color(0xFFF57C00),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 6,
                            shadowColor:
                                const Color(0xFFF57C00).withOpacity(0.5),
                          ),
                        ),
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

  Widget _buildSummaryPoint(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFFF9800).withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFFF57C00), size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF5D4037),
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
