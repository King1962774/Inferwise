// ignore_for_file: curly_braces_in_flow_control_structures, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_4/Animation4_3.dart';
import 'dart:async';

import 'package:inferwise/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InstructionSpotPage4_3 extends StatefulWidget {
  final String title;
  final List<String> instructions;
  final String tipTitle;
  final List<String> tips;
  final String finalNote;

  const InstructionSpotPage4_3({
    super.key,
    required this.title,
    required this.instructions,
    required this.tipTitle,
    required this.tips,
    required this.finalNote,
  });

  @override
  State<InstructionSpotPage4_3> createState() => _InstructionSpotPage4_3State();
}

class _InstructionSpotPage4_3State extends State<InstructionSpotPage4_3> {
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
  int _currentPage = 0;

  final List<Map<String, String>> examples = [
    {
      'title': 'Example 1',
      'image': 'assets/Imagenes de ejemplos/Level4/4.4 A The door.webp',
      'text':
          'The door slammed shut behind her.\n✴️ Here, you use agent inference to understand that she is the one who closed the door, even though it\'s not explicitly stated.',
    },
    {
      'title': 'Example 2',
      'image': 'assets/Imagenes de ejemplos/Level4/4.4 B The window.webp',
      'text':
          'The window was broken when I got home.\n✴️ Here, you use agent inference to guess that someone else caused the damage, even if the sentence doesn\'t say who.',
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
              Text(
                text,
                style: const TextStyle(
                    fontSize: 14, color: Colors.black87, height: 1.4),
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
                      "Inferring the Agent",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 157, 19),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
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
                    'Readers figure out who is performing an action or responsible for something in a sentence or text by connecting it to related ideas you already know.',
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
  int _currentPage = 0;

  final List<Map<String, String>> examples = [
    {
      'title': 'Example 1',
      'image': 'assets/Imagenes de ejemplos/Level4/4.4 C The lights.webp',
      'text':
          'The lights went out suddenly.\n✴️ Agent inference: Someone (like a technician or nature) caused the power outage.',
    },
    {
      'title': 'Example 2',
      'image': 'assets/Imagenes de ejemplos/Level4/4.4 D The fridge.webp',
      'text':
          'The cake disappeared from the fridge.\n✴️ Agent inference: Someone ate the cake, even though it\'s not said explicitly.',
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
                    fontSize: 14, color: Colors.black87, height: 1.6),
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
                      "Agent inferences",
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
                      color: const Color(0xFFFF9800).withOpacity(0.2),
                    ),
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF000000),
                      ),
                      children: [
                        TextSpan(
                          text: 'Special note:\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              'Sometimes the agent (the person or thing doing the action) isn\'t directly mentioned because the writer expects you to fill in the gap from common knowledge.',
                        ),
                      ],
                    ),
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
    '🟠 1. Identify the action\n\nWatering the garden is the key event to explain.',
    '🟠 2. Consider who could perform the action\n\nIt could be a gardener, a homeowner, or an automatic sprinkler system.',
    '🟠 3. Look for context clues\n\nThe sentence doesn\u2019t name the agent, so you think about what\u2019s most likely.',
    '🟠 4. Use real-world knowledge and plausibility\n\nGardens are often watered by gardeners or sprinklers early in the morning.',
    '🟠 5. Confirm the inference\n\nMost likely, the garden was watered by a person or an automatic system.',
    '✅ Final Answer:\n\nThe garden was probably watered by a gardener or a sprinkler system.',
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
        '💡 Quick note\n\nIf more context appears (e.g., "John watered the garden"), revise your inference. When the agent isn\'t named, use "probably" or "most likely" to keep it open.',
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
              "Let's infer the agent in the next sentence:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Context card
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
                '"The garden was watered early in the morning."',
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

            // PageView
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
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            height: 1.5),
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
                                'Readers figure out who is doing an action in a sentence by connecting it to what you know about people and situations in the world.',
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
                          'The windows were cleaned before the guests arrived.',
                      inference:
                          'Agent inference: Someone (like a cleaner or homeowner) probably cleaned the windows.',
                    ),
                    _buildExample(
                      sentence: 'Dinner was served promptly at six o’clock.',
                      inference:
                          'Agent inference: Someone (a chef, waiter, or host) prepared and served the meal.',
                    ),

                    const SizedBox(height: 20),

                    // 🔶 Also
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
                                'Sometimes the agent isn’t mentioned directly because it’s assumed you know it. If more than one agent fits, choose the most likely based on the context.',
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
    '1. Identify the action that has an unknown doer.',
    '2. Think about who usually does that action in real life.',
    '3. Look for clues in the sentence or nearby text.',
    '4. Use your knowledge about people and common roles.',
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
                  '✅ Quick tip: If new info appears later naming the agent, update your inference — inferring the agent is often guesses based on clues, not certainties.',
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
        'After fixing the car, the mechanic handed a set of keys to someone waiting near the counter.\n\nWho is the person likely to receive the keys?',
    options: [
      "A) The receptionist",
      "B) The customer",
      "C) The janitor",
      "D) The security guard"
    ],
    correctIndex: 1,
    explanation:
        'The customer is the one who brought the car for repair, so they are the most likely person to receive the keys.',
    incorrectExplanations: [
      ' The receptionist only manages appointments, not the car keys.',
      ' The customer is the owner of the car, so they get the keys back.',
      ' The janitor is not related to the car service.',
      ' The security guard only oversees the premises, not car handling.',
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
  final Set<String> _selectedOptions = {};
  String? _inferenceAnswer;
  late AnimationController _animationController;
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

  void _nextStep() {
    if (_currentStep == 0 && !_selectedOptionsStep1.containsValue(true)) {
      _showFeedbackMessage('Please select at least one option');
      return;
    }
    if (_currentStep == 1 && _selectedOptions.isEmpty) {
      _showFeedbackMessage('Please select at least one option');
      return;
    }
    if (_currentStep == 2 && _selectedOptions.isEmpty) {
      _showFeedbackMessage('Please select an option');
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
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ─── PROGRESS BAR MEJORADA ────────────────────────────────────────────
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
  final Map<String, bool> _selectedOptionsStep1 = {
    "A": false,
    "B": false,
    "C": false,
    "D": false,
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
                    color: _darkOrange),
              ),
              const SizedBox(height: 12),
              _buildProgressIndicator(),
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Analyze the sentence carefully:",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _darkOrange),
                      ),
                      const SizedBox(height: 12),

                      // Oración
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightOrange.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: _primaryColor.withOpacity(0.2)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "\"After fixing the car, the mechanic handed a set of keys to someone waiting near the counter.\"",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: _darkOrange),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.car_repair,
                                color: _primaryColor, size: 30),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      Text(
                        "What is the sentence mainly about?",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: _darkOrange),
                      ),
                      const SizedBox(height: 12),

                      _buildStep1Option(
                        "A) The mechanic is cleaning the shop.",
                        "A",
                        false,
                        "No — the sentence is about handing over keys after fixing a car, not cleaning.",
                      ),
                      _buildStep1Option(
                        "B) The mechanic is repairing a vehicle.",
                        "B",
                        false,
                        "Close, but the repair is already done — the sentence focuses on what happens after.",
                      ),
                      _buildStep1Option(
                        "C) The mechanic is returning a car to a customer.",
                        "C",
                        true,
                        "Correct! ✅ Handing keys to someone after fixing a car suggests the repair is finished and the vehicle is being returned to its owner or customer.",
                      ),
                      _buildStep1Option(
                        "D) The mechanic is selling car parts.",
                        "D",
                        false,
                        "No — there's no mention of selling parts in the sentence.",
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                  ),
                  onPressed: _selectedOptionsStep1.containsValue(true)
                      ? _nextStep
                      : null,
                  child: const Text("Continue",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
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
        Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: isSelected
              ? (isCorrect ? _lightOrange.withOpacity(0.3) : Colors.red[100])
              : Colors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              setState(() {
                _selectedOptionsStep1.updateAll((key, value) => false);
                _selectedOptionsStep1[option] = true;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    isSelected
                        ? (isCorrect ? Icons.check_circle : Icons.cancel)
                        : Icons.circle_outlined,
                    color: isSelected
                        ? (isCorrect ? _primaryColor : Colors.red)
                        : Colors.grey,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 16,
                        color: _darkOrange,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ).animate().slideX(
              begin: 0.5,
              duration: 500.ms,
              delay: (option == 'A'
                      ? 100
                      : option == 'B'
                          ? 200
                          : option == 'C'
                              ? 300
                              : 400)
                  .ms,
            ),
        if (isSelected)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Card(
              color: isCorrect
                  ? _lightOrange.withOpacity(0.3)
                  : Colors.red[50]?.withOpacity(0.8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(feedback,
                    style: TextStyle(fontSize: 15, color: _darkOrange)),
              ),
            ).animate().fadeIn(duration: 300.ms),
          ),
      ],
    );
  }

  // ─── STEP 2 ───────────────────────────────────────────────────────────
  Widget _buildStep2() {
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
                "💭 Step 2: What's Missing?",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: _darkOrange),
              ),
              const SizedBox(height: 12),
              _buildProgressIndicator(),
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Oración de referencia
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _lightOrange.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: _primaryColor.withOpacity(0.2)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "\"After fixing the car, the mechanic handed a set of keys to someone waiting near the counter.\"",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: _darkOrange),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.car_repair,
                                color: _primaryColor, size: 22),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      Text(
                        "What information is missing from the sentence?",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _darkOrange),
                      ),
                      const SizedBox(height: 16),

                      _buildMissingOption(
                        "A) Who received the keys",
                        "A",
                        true,
                        "Correct! ✅ The sentence tells us who acted, what was done, and where — but only says 'someone' received the keys, so we don't know who.",
                      ),
                      _buildMissingOption(
                        "B) What the mechanic handed over",
                        "B",
                        false,
                        "We already know — the sentence clearly says 'a set of keys'.",
                      ),
                      _buildMissingOption(
                        "C) Who fixed the car",
                        "C",
                        false,
                        "We already know — the sentence tells us it was the mechanic.",
                      ),
                      _buildMissingOption(
                        "D) Where the exchange took place",
                        "D",
                        false,
                        "We already know — the sentence says it happened near the counter.",
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                  ),
                  onPressed: _selectedOptions.isNotEmpty ? _nextStep : null,
                  child: const Text("Continue",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMissingOption(
      String text, String option, bool isCorrect, String feedback) {
    final bool isSelected = _selectedOptions.contains(option);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: isSelected
              ? (isCorrect ? _lightOrange.withOpacity(0.3) : Colors.red[100])
              : Colors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              setState(() {
                _selectedOptions.clear();
                _selectedOptions.add(option);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    isSelected
                        ? (isCorrect ? Icons.check_circle : Icons.cancel)
                        : Icons.circle_outlined,
                    color: isSelected
                        ? (isCorrect ? _primaryColor : Colors.red)
                        : Colors.grey,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 16,
                        color: _darkOrange,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ).animate().slideX(
              begin: 0.5,
              duration: 500.ms,
              delay: (option == 'A'
                      ? 100
                      : option == 'B'
                          ? 200
                          : option == 'C'
                              ? 300
                              : 400)
                  .ms,
            ),
        if (isSelected)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Card(
              color: isCorrect
                  ? _lightOrange.withOpacity(0.3)
                  : Colors.red[50]?.withOpacity(0.8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(feedback,
                    style: TextStyle(fontSize: 15, color: _darkOrange)),
              ),
            ).animate().fadeIn(duration: 300.ms),
          ),
      ],
    );
  }

  // ─── STEP 3 — MEJORADO ────────────────────────────────────────────────
  String? _selectedStep3;

  Widget _buildStep3() {
    final List<Map<String, dynamic>> scenarios = [
      {
        "option": "A",
        "icon": Icons.phone,
        "label": "The receptionist",
        "description": "Manages calls & appointments",
        "isCorrect": false,
        "feedback":
            "Receptionists manage clients and calls, not vehicle deliveries.",
      },
      {
        "option": "B",
        "icon": Icons.directions_car,
        "label": "The customer",
        "description": "Brought the car for repair",
        "isCorrect": true,
        "feedback":
            "Correct! ✅ The customer is the one who brought the car — they're the natural recipient of the keys.",
      },
      {
        "option": "C",
        "icon": Icons.cleaning_services,
        "label": "The janitor",
        "description": "Cleans the workshop",
        "isCorrect": false,
        "feedback": "The janitor handles cleaning, not vehicle hand-offs.",
      },
      {
        "option": "D",
        "icon": Icons.security,
        "label": "The security guard",
        "description": "Watches the premises",
        "isCorrect": false,
        "feedback":
            "The security guard's role is surveillance, not delivering repaired cars.",
      },
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final double aspectRatio = screenWidth < 360 ? 1.05 : 1.15;

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
                "🔧 Step 3: Real World Knowledge",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _darkOrange,
                ),
              ),
              const SizedBox(height: 12),
              _buildProgressIndicator(),
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lightbulb_outline,
                              color: _primaryColor, size: 26),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "What do you know about real life?",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _darkOrange,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Escenario visual
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _lightOrange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _primaryColor.withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.car_repair,
                                    color: _primaryColor, size: 22),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "At an auto repair shop, when a mechanic finishes fixing a car and hands keys to someone near the counter...",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: _darkOrange,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.touch_app,
                                    color: _primaryColor, size: 18),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    "Who would most likely receive the keys?",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: _primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ✅ GRID RESPONSIVE SIN OVERFLOW
                      GridView.builder(
                        itemCount: scenarios.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: aspectRatio,
                        ),
                        itemBuilder: (context, index) {
                          final s = scenarios[index];
                          final bool isSelected = _selectedStep3 == s['option'];
                          final bool isCorrect = s['isCorrect'] as bool;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedStep3 = s['option'] as String;
                                _selectedOptions.clear();
                                _selectedOptions.add(s['option'] as String);
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? (isCorrect
                                        ? _lightOrange.withOpacity(0.4)
                                        : Colors.red[50])
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isSelected
                                      ? (isCorrect
                                          ? _primaryColor
                                          : Colors.redAccent)
                                      : Colors.grey.shade300,
                                  width: isSelected ? 2.2 : 1.3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    s['icon'] as IconData,
                                    size: 30,
                                    color: isSelected
                                        ? (isCorrect
                                            ? _primaryColor
                                            : Colors.redAccent)
                                        : _darkOrange.withOpacity(0.6),
                                  ),
                                  const SizedBox(height: 4),
                                  Flexible(
                                    child: Text(
                                      s['label'] as String,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: _darkOrange,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Flexible(
                                    child: Text(
                                      s['description'] as String,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _darkOrange.withOpacity(0.6),
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (isSelected) ...[
                                    const SizedBox(height: 2),
                                    Icon(
                                      isCorrect
                                          ? Icons.check_circle
                                          : Icons.cancel,
                                      color: isCorrect
                                          ? _primaryColor
                                          : Colors.redAccent,
                                      size: 18,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      // Feedback
                      if (_selectedStep3 != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: _selectedStep3 == "B"
                                  ? _lightOrange.withOpacity(0.3)
                                  : Colors.red[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _selectedStep3 == "B"
                                    ? _primaryColor
                                    : Colors.redAccent,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  _selectedStep3 == "B"
                                      ? Icons.check_circle
                                      : Icons.info_outline,
                                  color: _selectedStep3 == "B"
                                      ? _primaryColor
                                      : Colors.redAccent,
                                  size: 22,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    scenarios.firstWhere((s) =>
                                        s['option'] ==
                                        _selectedStep3)['feedback'] as String,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: _darkOrange,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ).animate().fadeIn(duration: 300.ms),
                        ),
                    ],
                  ),
                ),
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
                  onPressed: _selectedStep3 != null ? _nextStep : null,
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

  // ─── STEP 4 ───────────────────────────────────────────────────────────
  Widget _buildStep4() {
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
                "🔍 Step 4: Make an Inference",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: _darkOrange),
              ),
              const SizedBox(height: 12),
              _buildProgressIndicator(),

              Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Based on what you read and what you know,",
                        style: TextStyle(fontSize: 15, color: _darkOrange),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "who most likely received the keys?",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _darkOrange),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Choose the best answer:",
                        style: TextStyle(fontSize: 15, color: _darkOrange),
                      ),
                      const SizedBox(height: 16),
                      _buildInferenceOption(
                        "A) Another mechanic in the shop.",
                        "A",
                        false,
                        "Mechanics don't typically hand keys to coworkers after a repair — they return them to the owner.",
                      ),
                      _buildInferenceOption(
                        "B) A customer waiting for their car.",
                        "B",
                        true,
                        "Correct! ✅ After a repair is done, the mechanic returns the car to the customer by handing over the keys.",
                      ),
                      _buildInferenceOption(
                        "C) A janitor at the counter.",
                        "C",
                        false,
                        "Janitors are not involved in vehicle hand-offs — they handle cleaning duties.",
                      ),
                      _buildInferenceOption(
                        "D) A person buying car parts.",
                        "D",
                        false,
                        "Someone buying parts wouldn't receive car keys — that's a different transaction.",
                      ),
                    ],
                  ),
                ),
              ),

              // Feedback global
              if (_inferenceAnswer != null)
                Card(
                  elevation: 3,
                  color: _correctInference
                      ? _lightOrange.withOpacity(0.3)
                      : Colors.red[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color:
                          _correctInference ? _primaryColor : Colors.redAccent,
                      width: 2,
                    ),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(
                          _correctInference
                              ? Icons.check_circle
                              : Icons.info_outline,
                          color: _correctInference
                              ? _primaryColor
                              : Colors.redAccent,
                          size: 28,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _correctInference
                                ? "Correct! ✅ The customer waiting for their car is the most logical recipient of the keys."
                                : "Think about who typically picks up a repaired car from a mechanic.",
                            style: TextStyle(
                                fontSize: 16,
                                color: _darkOrange,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(duration: 300.ms),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                  ),
                  onPressed: _inferenceAnswer != null ? _nextStep : null,
                  child: const Text("See Final Answer",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInferenceOption(
      String text, String option, bool isCorrect, String feedback) {
    final bool isSelected = _inferenceAnswer == option;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: isSelected
              ? (isCorrect ? _lightOrange.withOpacity(0.3) : Colors.red[100])
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
                  Icon(
                    isSelected
                        ? (isCorrect ? Icons.check_circle : Icons.cancel)
                        : Icons.circle_outlined,
                    color: isSelected
                        ? (isCorrect ? _primaryColor : Colors.red)
                        : Colors.grey,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 16,
                        color: _darkOrange,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ).animate().slideX(
              begin: 0.5,
              duration: 500.ms,
              delay: (option == 'A'
                      ? 100
                      : option == 'B'
                          ? 200
                          : option == 'C'
                              ? 300
                              : 400)
                  .ms,
            ),
        if (isSelected)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Card(
              color: isCorrect
                  ? _lightOrange.withOpacity(0.3)
                  : Colors.red[50]?.withOpacity(0.8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(feedback,
                    style: TextStyle(fontSize: 15, color: _darkOrange)),
              ),
            ).animate().fadeIn(duration: 300.ms),
          ),
      ],
    );
  }

  // ─── FINAL STEP ───────────────────────────────────────────────────────
  Widget _buildFinalStep() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "🏁 Final Answer",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: _darkOrange),
          ),
          const SizedBox(height: 12),
          _buildProgressIndicator(),
          Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                        color: _primaryColor),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "B) A customer waiting for their car",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _darkOrange),
                  ),
                  const Divider(height: 32),
                  Text(
                    "Explanation:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _darkOrange),
                  ),
                  const SizedBox(height: 12),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                          fontSize: 16, color: _darkOrange, height: 1.4),
                      children: [
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(
                            text:
                                "The person who usually receives the keys after a car repair is the customer who brought in the vehicle\n\n"),
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(
                            text:
                                "The mechanic hands over the keys to the customer so they can take their car\n\n"),
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(
                            text:
                                "Other staff members like receptionists or janitors don't usually receive the keys at this stage"),
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
              icon: const Icon(Icons.play_arrow, color: Colors.white),
              label: const Text("Start Practice Exercises",
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: _darkOrange),
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

  // Variables para el efecto del bombillo de inactividad
  Timer? _inactivityTimer;
  bool _isInactive = false;
  late AnimationController _glowController;

  final List<String> hints1 = [
    '💡 General Hint: Who is responsible for delivering food from the kitchen to the dining area?',
    '📌 More Specific: Which restaurant employee acts as the link between the chef and the customer?',
  ];

  final List<String> hints2 = [
    '💡 General Hint: Who often provides support to a teacher with classroom tasks like distributing materials?',
    '📌 More Specific: Which role assists the teacher while the main instructor is occupied at the board?',
  ];

  final List<String> hints3 = [
    '💡 General Hint: What kind of person goes to a library to obtain a book and then leaves?',
    '📌 More Specific: Which option describes a person checking out a book and observing the rule of quiet departure?',
  ];

  final List<String> hints4 = [
    '💡 General Hint: Who receives a key card at the reception desk to access a room?',
    '📌 More Specific: Which person needs a key card to go to their lodging via the elevators in a building like a hotel?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "The chef finished cooking and handed the plate to someone who walked toward the dining area. Who is the person likely to take the plate?",
      "options": [
        "A) The dishwasher",
        "B) The waiter",
        "C) The customer",
        "D) The cashier"
      ],
      "correctIndex": 1,
      "feedback": [
        "Explanation: The waiter usually takes cooked dishes from the kitchen to the customers in the dining area.",
        "The dishwasher works in the kitchen, not in the dining area.",
        "The customer receives the plate from the waiter, not directly from the chef.",
        "The cashier handles payments, not food delivery."
      ]
    },
    {
      "question":
          "The teacher wrote on the board while someone passed out papers to the students. Who is likely passing out the papers?",
      "options": [
        "A) The principal",
        "B) The teacher’s assistant",
        "C) A regular student",
        "D) A janitor"
      ],
      "correctIndex": 1,
      "feedback": [
        "Explanation: A teacher’s assistant often helps by handing out papers during a lesson.",
        "The principal usually doesn’t help with class tasks like passing papers.",
        "A student might help occasionally, but it’s less common than an assistant.",
        "A janitor is responsible for maintenance, not distributing papers."
      ]
    },
    {
      "question":
          "The librarian handed a book to someone who then left the library quietly. Who is this person likely to be?",
      "options": [
        "A) A visitor",
        "B) The librarian",
        "C) A janitor",
        "D) A security guard"
      ],
      "correctIndex": 0,
      "feedback": [
        "Explanation: Visitors often borrow or read books and leave the library quietly, unlike staff or security.",
        "The librarian wouldn’t hand a book to herself.",
        "A janitor doesn’t borrow books while working.",
        "A security guard’s job is to oversee safety, not read or borrow books."
      ]
    },
    {
      "question":
          "The receptionist gave a key card to someone who headed toward the elevators. Who is this person likely to be?",
      "options": [
        "A) A hotel guest",
        "B) A delivery person",
        "C) A cleaner",
        "D) A chef"
      ],
      "correctIndex": 0,
      "feedback": [
        "Explanation: Hotel guests receive key cards from reception and then go to their rooms via the elevators.",
        "A delivery person would drop items at reception, not take a key card.",
        "A cleaner would already have their own staff key.",
        "A chef works in the kitchen, not as a guest using elevators."
      ]
    },
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
                                else if (currentQuestionIndex == 3) hintStep4++;
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
        'The tour guide handed a map to someone who then started taking pictures around the city.\n\nWho is this person likely to be?',
    options: [
      "A) A local resident",
      "B) A tourist",
      "C) A shop owner",
      "D) A security guard"
    ],
    correctIndex: 1,
    explanation:
        ' A tourist often carries a map and takes pictures while exploring a city.',
    incorrectExplanations: [
      ' A local resident already knows the city and wouldn’t need a map.',
      ' Correct! A tourist uses maps and takes pictures when visiting new places.',
      ' A shop owner works in one location and wouldn’t be sightseeing.',
      ' A security guard focuses on safety, not exploring or taking photos.'
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
  String? _step1Answer;
  String? _step2Answer;
  String? _step3Answer;
  String? _inferenceAnswer;
  final Set<String> _selectedClues = {};
  late AnimationController _animationController;
  bool _correctInference = false;

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
      _showSnack('Please identify the mystery person');
      return;
    }
    if (_currentStep == 2 && _step3Answer == null) {
      _showSnack('Please select who uses maps and cameras');
      return;
    }
    if (_currentStep == 3 && _inferenceAnswer == null) {
      _showSnack('Please choose your final conclusion');
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

  Widget _feedbackBubble(String message, {bool showIcon = false}) {
    final ok = message.startsWith("✅");
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: ok ? _lightOrange : Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ok ? _primaryColor : Colors.red.shade300,
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            ok ? Icons.check_circle : Icons.cancel,
            color: ok ? _primaryColor : Colors.red.shade400,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message.replaceFirst(ok ? "✅ " : " ", ""),
              style: TextStyle(
                fontSize: 13,
                color: ok ? _darkOrange : Colors.red.shade700,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _questionContainer(String text) {
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

  Widget _sentenceCard(String sentence) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFFF9800), const Color(0xFFE65100)],
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
      child: Text(
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
          _feedbackBubble(feedback, showIcon: isCorrect),
      ],
    );
  }

  Widget _continueButton(String label, {VoidCallback? onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _primaryColor,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey.shade300,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 4,
            shadowColor: _primaryColor.withOpacity(0.4),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════
  // STEP 1 — What is the sentence mainly about?
  // ══════════════════════════════════════════════════════
  Widget _buildStep1() {
    final opts = {
      "A": {
        "text": "The tour guide is selling souvenirs.",
        "correct": false,
        "feedback":
            " The sentence doesn't mention souvenirs — look at what the guide actually does.",
      },
      "B": {
        "text": "The tour guide is giving directions to a visitor.",
        "correct": false,
        "feedback":
            " Close, but the guide hands a map, not verbal directions.",
      },
      "C": {
        "text": "A tour guide gives a map to someone.",
        "correct": false,
        "feedback":
            " That's only part of it — the sentence also shows what happens next.",
      },
      "D": {
        "text": "A tour guide helps someone start exploring the city.",
        "correct": true,
        "feedback":
            "✅ Correct! The guide hands a map and the person begins taking pictures — helping a visitor explore.",
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
                    '"The tour guide handed a map to someone who then started taking pictures around the city."'),
                const SizedBox(height: 16),
                _whiteCard(
                  child: Column(
                    children: [
                      _questionContainer("What is the sentence mainly about?"),
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
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        _continueButton(
          "Continue  →",
          onPressed: _step1Answer != null ? _nextStep : null,
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════
  // STEP 2 — Who is the mystery person?
  // ══════════════════════════════════════════════════════
  Widget _buildStep2() {
    final opts = {
      "A": {
        "text": "A local resident",
        "correct": false,
        "feedback":
            " Locals usually know the city well and don't need maps from tour guides.",
      },
      "B": {
        "text": "A tourist",
        "correct": true,
        "feedback":
            "✅ Tourists receive maps from guides and take photos while sightseeing!",
      },
      "C": {
        "text": "A shop owner",
        "correct": false,
        "feedback":
            " Shop owners focus on their business and wouldn't be sightseeing.",
      },
      "D": {
        "text": "A security guard",
        "correct": false,
        "feedback":
            " Security guards patrol the area — they wouldn't receive tourist maps.",
      },
    };

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Clue board interactiv
                const SizedBox(height: 14),
                _whiteCard(
                  child: Column(
                    children: [
                      _questionContainer(
                          "Who is the mystery person in the sentence?"),
                      const SizedBox(height: 14),
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
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        _continueButton(
          "Solve the Clue  →",
          onPressed: _step2Answer != null ? _nextStep : null,
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════
  // STEP 3 — Real-world knowledge: who uses maps?
  // ══════════════════════════════════════════════════════
  Widget _buildStep3() {
    final profiles = [
      {
        "key": "A",
        "title": "Local Resident",
        "desc": "Knows the city well, doesn't need maps",
        "icon": Icons.person,
        "correct": false,
        "feedback":
            " Locals don't usually need maps — they already know their way around.",
      },
      {
        "key": "B",
        "title": "Tourist",
        "desc": "Uses maps, takes photos, explores new places",
        "icon": Icons.travel_explore,
        "correct": true,
        "feedback":
            "✅ Exactly! Tourists rely on maps and cameras to explore unfamiliar cities.",
      },
      {
        "key": "C",
        "title": "Shop Owner",
        "desc": "Focused on business, stays in one place",
        "icon": Icons.store,
        "correct": false,
        "feedback":
            " Shop owners run their business — they rarely need tourist maps.",
      },
      {
        "key": "D",
        "title": "Security Guard",
        "desc": "Patrols and monitors, not sightseeing",
        "icon": Icons.security,
        "correct": false,
        "feedback":
            " Guards are working, not exploring the city with a camera.",
      },
    ];

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _whiteCard(
                  child: Column(
                    children: [
                      _questionContainer(
                          "Who typically uses maps and takes photos in a new city?"),
                      const SizedBox(height: 16),
                      ...profiles.map((p) {
                        final key = p["key"] as String;
                        final isSelected = _step3Answer == key;
                        final isCorrect = p["correct"] as bool;
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
                                      : Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: isSelected
                                        ? (isCorrect
                                            ? _primaryColor
                                            : Colors.red.shade400)
                                        : Colors.grey.shade300,
                                    width: isSelected ? 2 : 1.5,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: (isCorrect
                                                    ? _primaryColor
                                                    : Colors.red)
                                                .withOpacity(0.12),
                                            blurRadius: 8,
                                            offset: const Offset(0, 3),
                                          )
                                        ]
                                      : [],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? (isCorrect
                                                ? _primaryColor
                                                    .withOpacity(0.15)
                                                : Colors.red.withOpacity(0.1))
                                            : Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        p["icon"] as IconData,
                                        color: isSelected
                                            ? (isCorrect
                                                ? _primaryColor
                                                : Colors.red.shade400)
                                            : Colors.grey,
                                        size: 22,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            p["title"] as String,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: isSelected
                                                  ? (isCorrect
                                                      ? _darkOrange
                                                      : Colors.red.shade700)
                                                  : Colors.black54,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            p["desc"] as String,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: isSelected
                                                  ? (isCorrect
                                                      ? _darkOrange
                                                          .withOpacity(0.8)
                                                      : Colors.red.shade400)
                                                  : Colors.black38,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: isSelected
                                          ? Icon(
                                              isCorrect
                                                  ? Icons.check_circle_rounded
                                                  : Icons.cancel_rounded,
                                              key: const ValueKey("selected"),
                                              color: isCorrect
                                                  ? _primaryColor
                                                  : Colors.red.shade400,
                                              size: 22,
                                            )
                                          : Icon(
                                              Icons.radio_button_unchecked,
                                              key: const ValueKey("unselected"),
                                              color: Colors.grey.shade400,
                                              size: 22,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                _feedbackBubble(
                                  p["feedback"] as String,
                                  showIcon: isCorrect,
                                ),
                              const SizedBox(height: 4),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        _continueButton(
          "Draw Conclusion  →",
          onPressed: _step3Answer != null ? _nextStep : null,
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════
  // STEP 4 — The Big Reveal
  // ══════════════════════════════════════════════════════
  Widget _buildStep4() {
    final conclusions = {
      "A": {
        "text": "The person is a local resident",
        "correct": false,
        "feedback":
            " A local wouldn't need a tour guide's map — they know the city.",
      },
      "B": {
        "text": "The person is a tourist",
        "correct": true,
        "feedback":
            "✅ Correct! All clues — the map, the guide, the photos — point to a tourist.",
      },
      "C": {
        "text": "The person is a shop owner",
        "correct": false,
        "feedback":
            " Shop owners don't typically receive maps from tour guides.",
      },
      "D": {
        "text": "The person is a security guard",
        "correct": false,
        "feedback":
            " Guards work in the city — they wouldn't need tourist maps.",
      },
    };

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Recap de pistas
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _lightOrange.withOpacity(0.6),
                        _accentColor.withOpacity(0.2)
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
                        "🗺️  A tour guide handed someone a map",
                        "📸  That person started taking pictures",
                        "🏙️  They were exploring the city",
                      ].map((e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: _darkOrange,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                _whiteCard(
                  child: Column(
                    children: [
                      _questionContainer(
                          "Based on the evidence, who is the mystery person?"),
                      const SizedBox(height: 14),
                      ...conclusions.entries.map((e) => _optionTile(
                            label: e.key,
                            text: e.value["text"] as String,
                            isSelected: _inferenceAnswer == e.key,
                            isCorrect: e.value["correct"] as bool,
                            feedback: e.value["feedback"] as String,
                            onTap: () => setState(() {
                              _inferenceAnswer = e.key;
                              _correctInference = e.value["correct"] as bool;
                            }),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        _continueButton(
          "See Final Answer  →",
          onPressed: _inferenceAnswer != null ? _nextStep : null,
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════
  // STEP 5 — Final Answer (intacto en contenido)
  // ══════════════════════════════════════════════════════
  Widget _buildFinalStep() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 600),
            childAnimationBuilder: (w) => SlideAnimation(
              verticalOffset: 40.0,
              child: FadeInAnimation(child: w),
            ),
            children: [
              // Respuesta correcta card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xFFFFF3E0), const Color(0xFFFFE0B2)],
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
                        "B) The person is likely a tourist.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
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
                    const SizedBox(height: 10),
                    Text(
                      "Tour guides give maps to visitors, and those visitors often take photos while sightseeing — this fits the profile of a tourist exploring the city.",
                      style: TextStyle(
                        fontSize: 14,
                        color: _darkOrange.withOpacity(0.85),
                        height: 1.6,
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
    final stepTitles = [
      "🗺️ What's the Sentence About?",
      "🔍 What do we need to figure out?",
      "🌍 Real-World Knowledge",
      "🎯 The Big Reveal",
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
                // ── Header ──
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 14, left: 4),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: _darkOrange, size: 26),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                // ── Progress bar ──
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

                // ── Step title ──
                Text(
                  stepTitles[_currentStep],
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: _darkOrange,
                  ),
                ),
                const SizedBox(height: 10),

                // ── Content ──
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

  Timer? _inactivityTimer;
  bool _isInactive = false;
  late AnimationController _glowController;

  final List<String> hints1 = [
    '💡 General Hint: Who on a sports field is directly responsible for carrying out the coach\'s instructions?',
    '📌 More Specific: Who is the primary recipient of guidance and strategy from a coach during a game?',
  ];

  final List<String> hints2 = [
    '💡 General Hint: Who goes to a flower shop to purchase and receive a finished arrangement?',
    '📌 More Specific: Who is the person making a transaction to take home the goods from the counter?',
  ];

  final List<String> hints3 = [
    '💡 General Hint: Who works with the pilot in the cockpit and cabin to manage pre-flight and safety duties?',
    '📌 More Specific: Which member of the aircrew receives documents from the pilot concerning flight readiness?',
  ];

  final List<String> hints4 = [
    '💡 General Hint: Who is waiting to collect and pay for a piece of clothing that has been custom-made or repaired?',
    '📌 More Specific: Which person is expecting to receive the finished item from the tailor\'s service?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "The coach blew the whistle and gave instructions to someone on the field. Who is this person likely to be?",
      "options": [
        "A) A stadium worker",
        "B) A fan",
        "C) A referee",
        "D) A player"
      ],
      "correctIndex": 3,
      "feedback": [
        "Explanation: Coaches give instructions to players during a game or practice.",
        "A stadium worker maintains the venue, not participates in the game.",
        "A fan watches from the stands, not on the field.",
        "A referee enforces rules, not follows a coach’s directions."
      ]
    },
    {
      "question":
          "The florist arranged a bouquet of flowers and handed it to someone at the shop counter. Who is this person likely to be?",
      "options": [
        "A) A delivery driver",
        "B) A customer",
        "C) The store manager",
        "D) A cleaner"
      ],
      "correctIndex": 1,
      "feedback": [
        "Explanation: Customers buy flowers and receive bouquets at the counter.",
        "A delivery driver would pick up flowers for transport, not as a purchase.",
        "The store manager supervises, not buys flowers.",
        "A cleaner maintains the shop, not receives bouquets."
      ]
    },
    {
      "question":
          "The pilot completed the safety check and handed a checklist to someone before takeoff. Who is this person likely to be?",
      "options": [
        "A) The luggage handler",
        "B) The passenger",
        "C) The air traffic controller",
        "D) The flight attendant"
      ],
      "correctIndex": 3,
      "feedback": [
        "Explanation: Pilots often coordinate with flight attendants for safety procedures before takeoff.",
        "A luggage handler works outside the plane, not in the cockpit.",
        "Passengers don’t handle safety checklists.",
        "Air traffic controllers communicate via radio, not receive physical checklists."
      ]
    },
    {
      "question":
          "The tailor finished sewing a dress and gave it to someone waiting by the counter. Who is this person likely to be?",
      "options": [
        "A) The customer",
        "B) The cashier",
        "C) Another tailor",
        "D) The delivery person"
      ],
      "correctIndex": 0,
      "feedback": [
        "Explanation: Customers receive finished clothes from the tailor at the counter.",
        "A cashier processes payments, not collects tailored items.",
        "Another tailor would be working, not waiting for service.",
        "A delivery person collects or delivers orders, not waits for tailoring results."
      ]
    },
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
                                else if (currentQuestionIndex == 3) hintStep4++;
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
    question: 'Which sentence has an agent mistake?',
    options: [
      "A) The fisherman cast his net into the water.",
      "B) The chef prepared a special meal.",
      "C) The teacher graded the exams.",
      "D) The pilot drove the train to the station."
    ],
    correctIndex: 3,
    explanation:
        ' The pilot drove the train to the station — this is an agent mistake because pilots fly airplanes, not trains. Train conductors or engineers are the correct agents for driving trains.',
    incorrectExplanations: [
      ' The fisherman’s sentence is correct — casting a net is something a fisherman does.',
      ' The chef’s sentence is correct — preparing meals is the chef’s responsibility.',
      ' The teacher’s sentence is correct — grading exams is part of a teacher’s duties.',
      ' Correct! Pilots do not drive trains; they fly planes.',
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

class ExplanationThird extends StatefulWidget {
  const ExplanationThird({super.key});

  @override
  State<ExplanationThird> createState() => _ExplanationThirdState();
}

class _ExplanationThirdState extends State<ExplanationThird>
    with SingleTickerProviderStateMixin {
  int _currentStep = 0;
  String? _step1Answer;
  String? _step2Answer;
  String? _step3Answer;
  String? _inferenceAnswer;
  bool _correctInference = false;
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
      _showSnack('Please select which sentence sounds unusual');
      return;
    }
    if (_currentStep == 1 && _step2Answer == null) {
      _showSnack('Please identify the problem sentence');
      return;
    }
    if (_currentStep == 2 && _step3Answer == null) {
      _showSnack('Please select what you know about this profession');
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

  // ── Shared widgets ──────────────────────────────────────────────
  Widget _feedbackBubble(String message, {bool showIcon = false}) {
    final ok = message.startsWith("✅");
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: ok ? _lightOrange : Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ok ? _primaryColor : Colors.red.shade300,
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            ok ? Icons.check_circle_rounded : Icons.cancel_rounded,
            color: ok ? _primaryColor : Colors.red.shade400,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message.replaceFirst(ok ? "✅ " : " ", ""),
              style: TextStyle(
                fontSize: 13,
                color: ok ? _darkOrange : Colors.red.shade700,
                height: 1.5,
              ),
            ),
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

  Widget _sentencesCard() {
    final sentences = [
      {
        "text": "The fisherman cast his net into the water.",
        "icon": Icons.water,
        "normal": true,
      },
      {
        "text": "The chef prepared a meal.",
        "icon": Icons.restaurant,
        "normal": true,
      },
      {
        "text": "The teacher graded exams.",
        "icon": Icons.school,
        "normal": true,
      },
      {
        "text": "The pilot drove the train to the station.",
        "icon": Icons.train,
        "normal": false,
      },
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
        children: sentences.map((s) {
          final isOdd = !(s["normal"] as bool);
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isOdd
                  ? Colors.white.withOpacity(0.25)
                  : Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
              border:
                  isOdd ? Border.all(color: Colors.white, width: 1.5) : null,
            ),
            child: Row(
              children: [
                Icon(s["icon"] as IconData, color: Colors.white, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    s["text"] as String,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: isOdd ? FontWeight.bold : FontWeight.normal,
                      height: 1.4,
                    ),
                  ),
                ),
                if (isOdd)
                  const Icon(Icons.help_outline, color: Colors.white, size: 18),
              ],
            ),
          );
        }).toList(),
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
          _feedbackBubble(feedback, showIcon: isCorrect),
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

  // ══════════════════════════════════════════════════════
  // STEP 1 — Spot the unusual sentence
  // ══════════════════════════════════════════════════════
  Widget _buildStep1() {
    final opts = {
      "A": {
        "text": "The fisherman cast his net into the water.",
        "correct": false,
        "feedback":
            " Fishermen use nets — this is completely normal for their job.",
      },
      "B": {
        "text": "The chef prepared a meal.",
        "correct": false,
        "feedback":
            " Preparing meals is exactly what chefs do — nothing unusual here.",
      },
      "C": {
        "text": "The teacher graded exams.",
        "correct": false,
        "feedback":
            " Grading exams is a standard teacher task — this is normal.",
      },
      "D": {
        "text": "The pilot drove the train to the station.",
        "correct": true,
        "feedback":
            "✅ Correct! Pilots fly aircraft — they don't drive trains. This is the unusual one.",
      },
    };

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _sentencesCard(),
                const SizedBox(height: 16),
                _whiteCard(
                  child: Column(
                    children: [
                      _questionBox(
                          "Which sentence describes something unusual for that profession?"),
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
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        _continueBtn(
          "Continue  →",
          onPressed: _step1Answer != null ? _nextStep : null,
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════
  // STEP 2 — Why is it a problem?
  // ══════════════════════════════════════════════════════
  Widget _buildStep2() {
    final opts = {
      "A": {
        "text": "Pilots can operate any vehicle they want.",
        "correct": false,
        "feedback":
            " Pilots are licensed for aircraft only — operating a train requires separate training.",
      },
      "B": {
        "text":
            "Pilots fly aircraft, not trains — so this is an agent mistake.",
        "correct": true,
        "feedback":
            "✅ Correct! Assigning an action to the wrong professional is called an agent mistake.",
      },
      "C": {
        "text": "Trains and planes are the same kind of vehicle.",
        "correct": false,
        "feedback":
            " Trains run on rails, planes fly through the air — they are completely different.",
      },
      "D": {
        "text": "The sentence is correct because pilots travel a lot.",
        "correct": false,
        "feedback":
            " Traveling a lot doesn't mean a pilot can operate a train professionally.",
      },
    };

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Highlight de la oración problema
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.red.shade50, Colors.orange.shade50],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.red.shade300, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber_rounded,
                          color: Colors.red.shade400, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "The unusual sentence:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade400,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '"The pilot drove the train to the station."',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: _darkOrange,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                _whiteCard(
                  child: Column(
                    children: [
                      _questionBox("Why does this sentence not make sense?"),
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
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        _continueBtn(
          "Identify the Problem  →",
          onPressed: _step2Answer != null ? _nextStep : null,
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════
  // STEP 3 — Real-world knowledge: who operates what?
  // ══════════════════════════════════════════════════════
  Widget _buildStep3() {
    final professionals = [
      {
        "key": "A",
        "title": "Pilot",
        "vehicle": "Operates aircraft ✈️",
        "desc": "Licensed to fly airplanes and helicopters",
        "icon": Icons.flight,
        "correct": false,
        "feedback":
            " Pilots operate aircraft — not trains. That's the point of the mistake.",
      },
      {
        "key": "B",
        "title": "Train Driver",
        "vehicle": "Operates trains 🚂",
        "desc": "Licensed to drive trains on railways",
        "icon": Icons.train,
        "correct": true,
        "feedback":
            "✅ Correct! Train drivers are the professionals trained to operate trains.",
      },
      {
        "key": "C",
        "title": "Bus Driver",
        "vehicle": "Operates buses 🚌",
        "desc": "Licensed to drive buses on roads",
        "icon": Icons.directions_bus,
        "correct": false,
        "feedback":
            " Bus drivers operate road vehicles, not rail vehicles like trains.",
      },
      {
        "key": "D",
        "title": "Ship Captain",
        "vehicle": "Operates ships ⛴️",
        "desc": "Licensed to navigate sea vessels",
        "icon": Icons.directions_boat,
        "correct": false,
        "feedback":
            " Ship captains navigate the sea — trains are a completely different domain.",
      },
    ];

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _whiteCard(
                  child: Column(
                    children: [
                      _questionBox(
                          "Who is the correct professional to operate a train?"),
                      const SizedBox(height: 16),
                      ...professionals.map((p) {
                        final key = p["key"] as String;
                        final isSelected = _step3Answer == key;
                        final isCorrect = p["correct"] as bool;
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
                                      : Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: isSelected
                                        ? (isCorrect
                                            ? _primaryColor
                                            : Colors.red.shade400)
                                        : Colors.grey.shade300,
                                    width: isSelected ? 2 : 1.5,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: (isCorrect
                                                    ? _primaryColor
                                                    : Colors.red)
                                                .withOpacity(0.12),
                                            blurRadius: 8,
                                            offset: const Offset(0, 3),
                                          )
                                        ]
                                      : [],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? (isCorrect
                                                ? _primaryColor
                                                    .withOpacity(0.15)
                                                : Colors.red.withOpacity(0.1))
                                            : Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        p["icon"] as IconData,
                                        color: isSelected
                                            ? (isCorrect
                                                ? _primaryColor
                                                : Colors.red.shade400)
                                            : Colors.grey,
                                        size: 22,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            p["title"] as String,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: isSelected
                                                  ? (isCorrect
                                                      ? _darkOrange
                                                      : Colors.red.shade700)
                                                  : Colors.black54,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            p["vehicle"] as String,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: isSelected
                                                  ? (isCorrect
                                                      ? _accentColor
                                                      : Colors.red.shade300)
                                                  : Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            p["desc"] as String,
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: isSelected
                                                  ? (isCorrect
                                                      ? _darkOrange
                                                          .withOpacity(0.7)
                                                      : Colors.red.shade300)
                                                  : Colors.black38,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: isSelected
                                          ? Icon(
                                              isCorrect
                                                  ? Icons.check_circle_rounded
                                                  : Icons.cancel_rounded,
                                              key: const ValueKey("sel"),
                                              color: isCorrect
                                                  ? _primaryColor
                                                  : Colors.red.shade400,
                                              size: 22,
                                            )
                                          : Icon(
                                              Icons.radio_button_unchecked,
                                              key: const ValueKey("unsel"),
                                              color: Colors.grey.shade400,
                                              size: 22,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                _feedbackBubble(
                                  p["feedback"] as String,
                                  showIcon: isCorrect,
                                ),
                              const SizedBox(height: 4),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        _continueBtn(
          "Apply Knowledge  →",
          onPressed: _step3Answer != null ? _nextStep : null,
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════
  // STEP 4 — Make the inference
  // ══════════════════════════════════════════════════════
  Widget _buildStep4() {
    final conclusions = {
      "A": {
        "text": "All sentences describe normal actions for each profession.",
        "correct": false,
        "feedback":
            " Not all — the pilot driving a train is outside their professional role.",
      },
      "B": {
        "text":
            "The pilot is performing a task outside their usual professional role.",
        "correct": true,
        "feedback":
            "✅ Correct! This is an agent mistake — the action doesn't match the professional.",
      },
      "C": {
        "text": "The teacher is incorrectly assigned a task.",
        "correct": false,
        "feedback":
            " Teachers grade exams all the time — nothing unusual there.",
      },
      "D": {
        "text": "The fisherman is doing something unusual.",
        "correct": false,
        "feedback":
            " Casting nets is exactly what fishermen do — it's a normal action.",
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
                            "What we know:",
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
                        "✈️  Pilots are trained to fly aircraft",
                        "🚂  Train drivers operate trains",
                        "⚠️  The sentence assigns the wrong role to the pilot",
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
                      _questionBox("What is the most logical conclusion?"),
                      const SizedBox(height: 14),
                      ...conclusions.entries.map((e) => _optionTile(
                            label: e.key,
                            text: e.value["text"] as String,
                            isSelected: _inferenceAnswer == e.key,
                            isCorrect: e.value["correct"] as bool,
                            feedback: e.value["feedback"] as String,
                            onTap: () => setState(() {
                              _inferenceAnswer = e.key;
                              _correctInference = e.value["correct"] as bool;
                            }),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        _continueBtn(
          "See Final Answer  →",
          onPressed: _inferenceAnswer != null ? _nextStep : null,
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════
  // STEP 5 — Final Answer
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
                    colors: [
                      Color(0xFFFFF3E0),
                      Color(0xFFFFE0B2),
                    ],
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
                        "The pilot drove the train — this is an agent mistake.",
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
                        "icon": Icons.flight,
                        "text":
                            "Pilots are trained to operate aircraft, not trains."
                      },
                      {
                        "icon": Icons.train,
                        "text":
                            "Train drivers are the professionals who operate trains."
                      },
                      {
                        "icon": Icons.warning_amber_rounded,
                        "text":
                            "This is an 'agent mistake' — assigning an action to the wrong professional."
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
        return _buildFinalStep();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      "📖 Spot the Unusual Sentence",
      "🔍 Why Is It a Problem?",
      "🌍 Who Does What?",
      "🧠 Make the Inference",
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
                // ── Header ──
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 14, left: 4),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: _darkOrange, size: 26),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                // ── Progress bar ──
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

                // ── Step title ──
                Text(
                  titles[_currentStep],
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: _darkOrange,
                  ),
                ),
                const SizedBox(height: 10),

                // ── Content ──
                Expanded(child: _buildCurrentStep()),
              ],
            ),
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

  final List<String> hints1 = [
    '💡 General Hint: What is the primary job of a librarian versus someone who prepares food?',
    '📌 More Specific: Who is professionally responsible for cooking meals in a cafeteria?',
  ];

  final List<String> hints2 = [
    '💡 General Hint: What is the main job function of a dentist?',
    '📌 More Specific: Who typically performs the outdoor task of cutting grass?',
  ];

  final List<String> hints3 = [
    '💡 General Hint: What is the main responsibility of a cashier?',
    '📌 More Specific: Which professional is specifically hired to apply paint to walls?',
  ];

  final List<String> hints4 = [
    '💡 General Hint: What is the core duty of a pilot versus a flight attendant?',
    '📌 More Specific: Which member of the airplane crew is responsible for serving drinks to passengers?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question": "Which sentence has an agent mistake?",
      "options": [
        "A) The artist painted a portrait on canvas.",
        "B) The gardener planted flowers in the garden.",
        "C) The librarian cooked food in the cafeteria.",
        "D) The nurse checked the patient’s temperature."
      ],
      "correctIndex": 2,
      "feedback": [
        " Cooking is usually done by chefs or kitchen staff, not librarians.",
        "The artist’s action is correct — artists paint portraits.",
        "The gardener’s action fits — gardeners plant flowers.",
        "The nurse’s action is correct — nurses check patient temperatures."
      ]
    },
    {
      "question": "Which sentence has an agent mistake?",
      "options": [
        "A) The mechanic repaired the broken engine.",
        "B) The astronaut fixed the satellite in space.",
        "C) The dentist mowed the lawn.",
        "D) The writer typed a new chapter."
      ],
      "correctIndex": 2,
      "feedback": [
        " Lawn mowing is typically done by gardeners or groundskeepers, not dentists.",
        "The mechanic’s action is correct — mechanics repair engines.",
        "The astronaut’s action is correct — astronauts fix satellites.",
        "The writer’s action is correct — writers type chapters."
      ]
    },
    {
      "question": "Which sentence has an agent mistake?",
      "options": [
        "A) The firefighter rescued the kitten from the tree.",
        "B) The cashier painted the walls in the store.",
        "C) The librarian organized the new books on the shelves.",
        "D) The photographer took pictures at the event."
      ],
      "correctIndex": 1,
      "feedback": [
        " Painting walls is usually done by painters, not cashiers.",
        "The firefighter’s action is correct — firefighters rescue animals or people.",
        "The librarian’s action fits — librarians organize books.",
        "The photographer’s action is correct — photographers take pictures."
      ]
    },
    {
      "question": "Which sentence has an agent mistake?",
      "options": [
        "A) The baker baked fresh bread every morning.",
        "B) The receptionist answered calls and scheduled appointments.",
        "C) The pilot served drinks to passengers.",
        "D) The gardener trimmed the bushes."
      ],
      "correctIndex": 2,
      "feedback": [
        " Flight attendants serve drinks; pilots fly the plane.",
        "The baker’s action is correct — bakers bake bread.",
        "The receptionist’s action is correct — receptionists handle calls and appointments.",
        "The gardener’s action is correct — gardeners trim bushes."
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
                                else if (currentQuestionIndex == 3) hintStep4++;
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
        .set({'completedInstructionSpot4_3': true}, SetOptions(merge: true));

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
      'completedInstructionSpot4_3': true, // Repetido por seguridad
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
                      // ── Sección superior ──
                      Column(
                        children: [
                          // Trofeo con glow
                          Container(
                            width: 120,
                            height: 120,
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
                              size: 64,
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
                              "The more you how to infer the agent, the better you'll become! 🌟👏",
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

                      const SizedBox(height: 20),

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
                            // Header del resumen
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFF9800)
                                        .withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.menu_book_rounded,
                                    color: Color(0xFFF57C00),
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  "To sum up...",
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFF57C00),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Punto 1
                            _buildSummaryPoint(
                              Icons.person_search,
                              " inferring the agent means figuring out who is performing an action, even if they aren’t directly named. By using context clues and our knowledge of common roles, we can identify who is most likely responsible.",
                            ),
                            const SizedBox(height: 16),

                            // Ejemplo visual
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFFFFF3E0),
                                    const Color(0xFFFFE0B2),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color:
                                      const Color(0xFFFF9800).withOpacity(0.4),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("💡",
                                      style: TextStyle(fontSize: 18)),
                                  const SizedBox(width: 10),
                                  const Expanded(
                                    child: Text(
                                      "This kind of inference helps us make sense of texts and conversations by filling in missing information about who does what.",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFFE65100),
                                        fontStyle: FontStyle.italic,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

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
              fontSize: 14,
              color: Color(0xFF5D4037),
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
