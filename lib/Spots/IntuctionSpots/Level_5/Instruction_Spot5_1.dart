// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_5/Animation5_1.dart';
import 'package:inferwise/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InstructionSpotPage5_1 extends StatefulWidget {
  final String title;
  final List<String> instructions;
  final String tipTitle;
  final List<String> tips;
  final String finalNote;

  const InstructionSpotPage5_1({
    super.key,
    required this.title,
    required this.instructions,
    required this.tipTitle,
    required this.tips,
    required this.finalNote,
  });

  @override
  State<InstructionSpotPage5_1> createState() => _InstructionSpotPage5_1State();
}

class _InstructionSpotPage5_1State extends State<InstructionSpotPage5_1> {
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
          // Fondo con wallpaper y filtro violeta
          Positioned.fill(
            child: Image.asset(
              'assets/Wallpapers/Wallpaper  Medals.png',
              fit: BoxFit.cover,
              color: Colors.deepPurple.withOpacity(0.35), // filtro violeta
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
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7B1FA2), // texto violeta claro
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close,
                            color: Color(0xFFD1C4E9)), // morado claro
                        onPressed: _exit,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Contenedor de instrucciones
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(seconds: 1),
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF7B1FA2)
                                .withOpacity(0.85), // morado fuerte
                            Color(0xFF9C27B0).withOpacity(0.85), // violeta
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.purpleAccent.withOpacity(0.95),
                        ),
                      ),
                      child: Text(
                        widget.instructions[_currentStep],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white, // texto claro
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),

                  // Botón Next / Start
                  Center(
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF8E24AA), // morado vibrante
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
      'title':
          '📓  Tom didn\'t study for the test and forgot his notebook at home.',
      'image': 'assets/Imagenes de ejemplos/Level5/5.2 A_Tom.webp',
      'text': '⚛️ Outcome Inference: He will probably fail the test.',
    },
    {
      'title': '🐷  Sarah saved money every week for months.',
      'image': 'assets/Imagenes de ejemplos/Level5/5.2 B_Sarah.webp',
      'text': '⚛️ Outcome Inference: She will buy something important soon.',
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
      MaterialPageRoute(builder: (context) => const SecondRoomPage()),
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
          border: Border.all(color: Color(0xFF7B1FA2).withOpacity(0.3)),
        ),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Examples",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7B1FA2),
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF7C3AED),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                text,
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
              Color(0xFFD8B4FE),
              Color(0xFFC4B5FD),
              Color(0xFFAB8FF7),
              Color(0xFF8B5CF6),
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
                      "Predicting Outcome",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7B1FA2),
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
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: const Color(0xFF7C3AED).withOpacity(0.2)),
                  ),
                  child: const Text(
                    'Readers figure out what will probably happen next in a story or situation by looking at the actions or events that already took place. You use cause-and-effect thinking to predict the outcome.',
                    style: TextStyle(fontSize: 16),
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
                      backgroundColor: const Color(0xFFA855F7),
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
                                : "Continue",
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

class SecondRoomPage extends StatefulWidget {
  const SecondRoomPage({super.key});

  @override
  State<SecondRoomPage> createState() => _SecondRoomPageState();
}

class _SecondRoomPageState extends State<SecondRoomPage> {
  int _visibleCount = 0;
  final PageController _pageController = PageController();
  // ignore: unused_field
  int _currentPage = 0;

  final List<Map<String, String>> examples = [
    {
      'title': '🌅  Liam trained every morning before sunrise.',
      'image': 'assets/Imagenes de ejemplos/Level5/5.2 C Liam Training.webp',
      'text': '⚛️ Outcome Inference: He will become stronger or win in sports.',
    },
    {
      'title': '🥛  A glass was left on the edge of the table.',
      'image': 'assets/Imagenes de ejemplos/Level5/5.2 D A glass.webp',
      'text': '⚛️ Outcome Inference: It will fall and break.',
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
          border: Border.all(color: const Color(0xFF7B1FA2).withOpacity(0.3)),
        ),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Examples",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7B1FA2),
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
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF7C3AED),
                ),
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
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
              Color(0xFFD8B4FE),
              Color(0xFFC4B5FD),
              Color(0xFFAB8FF7),
              Color(0xFF8B5CF6),
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
                      "Contextual Inference",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7B1FA2),
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
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: const Color(0xFF7C3AED).withOpacity(0.2)),
                  ),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                      children: [
                        TextSpan(
                          text: '✨ Special Note: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              '\nWriters don\'t always say the outcome directly — they expect you to recognize the cause-and-effect chain and fill in the missing result using common sense and experience.',
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
                      backgroundColor: const Color(0xFFA855F7),
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
                                : "Continue",
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
      'label': 'Step 1',
      'title': 'Identify the action or event',
      'text': 'Emma is taking care of her plants regularly.',
    },
    {
      'label': 'Step 2',
      'title': 'Think about likely results',
      'text': 'Healthy growth, strong plants, maybe flowers or fruit.',
    },
    {
      'label': 'Step 3',
      'title': 'Connect to cause-and-effect',
      'text': 'Plants thrive with water and sunlight.',
    },
    {
      'label': 'Step 4',
      'title': 'Predict the outcome',
      'text': 'Most likely, the plants will grow well and flourish.',
    },
    {
      'label': 'Final Answer',
      'title': 'Outcome Inference',
      'text':
          'Emma\'s plants will grow healthy and strong because of her care.',
    },
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

  @override
  Widget build(BuildContext context) {
    final bool isLast = _currentStep == steps.length - 1;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFD8B4FE),
              Color(0xFFC4B5FD),
              Color(0xFFAB8FF7),
              Color(0xFF8B5CF6),
            ],
            stops: [0.0, 0.30, 0.65, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                // ── Header ──────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.30),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.50), width: 1),
                        ),
                        child: Icon(Icons.close,
                            size: 18,
                            color: const Color(0xFF4C1D95).withOpacity(0.85)),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // ── Title ────────────────────────────────────────────
                const Text(
                  '✩ Step-by-Step: How to do it? ✩',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.3,
                    shadows: [
                      Shadow(
                        color: Color(0x557C3AED),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 14),

                // ── Context card (top) ───────────────────────────────
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.72),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.88), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6D28D9).withOpacity(0.12),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Color(0xFF4C1D95),
                      ),
                      children: [
                        TextSpan(text: 'Let\'s predict outcome about:\n\n'),
                        TextSpan(
                          text:
                              '"Emma watered her plants every day and made sure they got enough sunlight."',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF6D28D9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // ── Step indicator dots ──────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(steps.length, (i) {
                    final active = i == _currentStep;
                    final done = i < _currentStep;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: active ? 28 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        gradient: active || done
                            ? const LinearGradient(
                                colors: [Color(0xFF5B21B6), Color(0xFFA855F7)],
                              )
                            : null,
                        color: active || done
                            ? null
                            : Colors.white.withOpacity(0.40),
                        boxShadow: active
                            ? [
                                BoxShadow(
                                  color:
                                      const Color(0xFFA855F7).withOpacity(0.5),
                                  blurRadius: 8,
                                )
                              ]
                            : null,
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 12),

                // ── PageView step cards ──────────────────────────────
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) =>
                        setState(() => _currentStep = index),
                    itemCount: steps.length,
                    itemBuilder: (context, index) {
                      final step = steps[index];
                      final isFinal = index == steps.length - 1;

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.75),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isFinal
                                ? const Color(0xFF7C3AED).withOpacity(0.50)
                                : Colors.white.withOpacity(0.88),
                            width: isFinal ? 2 : 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6D28D9).withOpacity(0.15),
                              blurRadius: 30,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(28),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon circle
                              const SizedBox(height: 18),

                              // Label pill
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 3),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFEDE9FE),
                                      Color(0xFFDDD6FE),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(999),
                                  border: Border.all(
                                      color: const Color(0xFFC4B5FD)),
                                ),
                                child: Text(
                                  step['label']!.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF7C3AED),
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10),

                              // Step title
                              Text(
                                step['title']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF5B21B6),
                                  height: 1.3,
                                ),
                              ),

                              const SizedBox(height: 12),

                              // Step body text
                              Text(
                                step['text']!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.5,
                                  height: 1.6,
                                  color:
                                      const Color(0xFF6D28D9).withOpacity(0.85),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // ── Buttons ──────────────────────────────────────────
                Row(
                  children: [
                    if (_currentStep > 0) ...[
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: _goBack,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.35),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.55),
                                width: 1.5,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                '← Back',
                                style: TextStyle(
                                  color: Color(0xFF4C1D95),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: _nextStep,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF5B21B6),
                                Color(0xFF7C3AED),
                                Color(0xFFA855F7),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: const Color(0xFFC4B5FD).withOpacity(0.30),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xFF7C3AED).withOpacity(0.40),
                                blurRadius: 20,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              isLast ? 'Continue  →' : 'Next  →',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),
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
              Color(0xF7AD3CFE),
              Color(0xFF8269F0),
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
                          color: Color(0xF79650F5), size: 28),
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
                    border:
                        Border.all(color: const Color(0xF79650F5), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 93, 41, 88)
                            .withOpacity(0.15),
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
                      color: Color.fromARGB(247, 116, 42, 219),
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
                              const Color.fromARGB(247, 168, 106, 255),
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFD8B4FE),
              Color(0xFFC4B5FD),
              Color(0xFFAB8FF7),
              Color(0xFF8B5CF6),
            ],
            stops: [0.0, 0.30, 0.65, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── Header ──────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const QuestionRoom()),
                          (route) => false,
                        );
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.30),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.50), width: 1),
                        ),
                        child: Icon(Icons.close,
                            size: 18,
                            color: const Color(0xFF4C1D95).withOpacity(0.85)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Scrollable content ───────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.72),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.88), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6D28D9).withOpacity(0.15),
                          blurRadius: 40,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Remember section ─────────────────────
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEDE9FE),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                    color: const Color(0xFFDDD6FE), width: 1.5),
                              ),
                              child: const Text('🔍',
                                  style: TextStyle(fontSize: 22)),
                            ),
                            const SizedBox(width: 12),
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [
                                  Color(0xFF7C3AED),
                                  Color(0xFFA855F7),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds),
                              child: const Text(
                                'Remember:',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFEDE9FE).withOpacity(0.65),
                                const Color(0xFFF5F3FF).withOpacity(0.55),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                                color: const Color(0xFFDDD6FE), width: 1.5),
                          ),
                          child: const Text(
                            "Readers figure out the likely result of an action or event by connecting it to what you know about how cause-and-effect works in the real world.",
                            style: TextStyle(
                              fontSize: 14.5,
                              height: 1.7,
                              color: Color(0xFF4C1D95),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // ── Examples section ─────────────────────
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEDE9FE),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                    color: const Color(0xFFDDD6FE), width: 1.5),
                              ),
                              child: const Text('📚',
                                  style: TextStyle(fontSize: 20)),
                            ),
                            const SizedBox(width: 12),
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [
                                  Color(0xFF7C3AED),
                                  Color(0xFFA855F7),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds),
                              child: const Text(
                                'Examples:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        _buildExample(
                          emoji: '⏰',
                          title: 'Liam forgot to set his alarm last night.',
                          inference: 'He will probably wake up late.',
                        ),
                        _buildExample(
                          emoji: '🎹',
                          title: 'Sofia practiced piano every day for hours.',
                          inference:
                              'She will improve her playing or be ready for a performance.',
                        ),

                        const SizedBox(height: 8),

                        // ── Final note ───────────────────────────
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFF3E8FF).withOpacity(0.80),
                                const Color(0xFFEDE9FE).withOpacity(0.70),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: const Color(0xFFDDD6FE), width: 1.5),
                          ),
                          child: const Text(
                            "💡 Also: Sometimes the result isn't mentioned directly because it's assumed you can predict it. "
                            "If more than one outcome is possible, choose the most likely based on context.",
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.65,
                              fontStyle: FontStyle.italic,
                              color: Color(0xFF5B21B6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Next button ──────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReinforcentPage(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF5B21B6),
                          Color(0xFF7C3AED),
                          Color(0xFFA855F7),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFC4B5FD).withOpacity(0.30),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF7C3AED).withOpacity(0.40),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            letterSpacing: 0.2,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward,
                            color: Colors.white, size: 18),
                      ],
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

  static Widget _buildExample({
    required String emoji,
    required String title,
    required String inference,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F0FF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFDDD6FE), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7C3AED).withOpacity(0.07),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF5B21B6),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '⚛️ Outcome Inference: $inference',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF6D28D9).withOpacity(0.85),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReinforcentPage extends StatelessWidget {
  const ReinforcentPage({super.key});

  static const List<Map<String, String>> steps = [
    {
      'icon': '🎯',
      'text': 'Identify the action/event (what happened).',
    },
    {
      'icon': '💭',
      'text':
          'Think about possible results that normally follow from that action.',
    },
    {
      'icon': '🔎',
      'text':
          'Check for context clues in the sentence or nearby text (words like every day, accidentally, quickly, carefully).',
    },
    {
      'icon': '🔗',
      'text':
          'Use real-world cause-and-effect knowledge — what usually happens when someone does that action?',
    },
    {
      'icon': '✅',
      'text':
          'State your inference, and if there are multiple possibilities, phrase it as "most likely" or suggest alternatives.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFD8B4FE),
              Color(0xFFC4B5FD),
              Color(0xFFAB8FF7),
              Color(0xFF8B5CF6),
            ],
            stops: [0.0, 0.30, 0.65, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── Header ──────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.30),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.50), width: 1),
                        ),
                        child: Icon(Icons.close,
                            size: 18,
                            color: const Color(0xFF4C1D95).withOpacity(0.85)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Title ────────────────────────────────────────────
              const Text(
                '✩ Step-by-Step ✩',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.3,
                  shadows: [
                    Shadow(
                      color: Color(0x557C3AED),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 14),

              // ── Scrollable content ───────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    children: [
                      // ── Quick tip card ───────────────────────────
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.72),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.88),
                              width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6D28D9).withOpacity(0.12),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEDE9FE),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: const Color(0xFFDDD6FE), width: 1.5),
                              ),
                              child: const Text('💟',
                                  style: TextStyle(fontSize: 18)),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Quick tip: If new details appear later, revise your inference —  predicting outcome is probabilistic, not certain.',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  height: 1.6,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFF5B21B6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ── Steps list card ──────────────────────────
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.72),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.88),
                              width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6D28D9).withOpacity(0.15),
                              blurRadius: 30,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: List.generate(steps.length, (i) {
                            final isLast = i == steps.length - 1;
                            return Column(
                              children: [
                                _buildStepRow(
                                  number: i + 1,
                                  icon: steps[i]['icon']!,
                                  text: steps[i]['text']!,
                                ),
                                if (!isLast)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 2, bottom: 2),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 19),
                                        Container(
                                          width: 2,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFFC4B5FD),
                                                Color(0xFFDDD6FE),
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(999),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Finish button ────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Start()),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF5B21B6),
                          Color(0xFF7C3AED),
                          Color(0xFFA855F7),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFC4B5FD).withOpacity(0.30),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF7C3AED).withOpacity(0.40),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue to Practice',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            letterSpacing: 0.2,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.check_circle_outline,
                            color: Colors.white, size: 18),
                      ],
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

  static Widget _buildStepRow({
    required int number,
    required String icon,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF7C3AED), Color(0xFFA855F7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7C3AED).withOpacity(0.28),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(icon, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: const Color(0xFF5B21B6).withOpacity(0.90),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
        "Jake stayed up all night playing video games and didn’t set his alarm.\n\nWhat will most likely happen?",
    options: [
      "A) He will wake up early and be on time",
      "B) He will oversleep and be late",
      "C) He will go jogging in the morning",
      "D) He will clean his room"
    ],
    correctIndex: 1,
    explanation:
        "✨ Correct answer: B\nBecause he didn’t sleep and didn’t set an alarm, it is very likely he will oversleep.",
    incorrectExplanations: [
      " This is unlikely because staying up all night makes waking up early harder.",
      " This is the correct answer because oversleeping is the most realistic outcome.",
      " Going jogging after staying up all night is not realistic.",
      " Cleaning his room is unrelated and unlikely after no sleep."
    ],
  )
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
      backgroundColor: const Color(0xFFF3E5F5),
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
                        size: 28, color: Color(0xFF7E57C2)),
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
                      Color(0xFF9C27B0),
                      Color(0xFF5E35B1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF5E35B1),
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
                            ? const Color(0xFFF3E5F5)
                            : const Color(0xFFFFEBEE);
                        borderColor = isCorrect == true
                            ? const Color(0xFF7E57C2)
                            : const Color(0xFFEF9A9A);
                        textColor = isCorrect == true
                            ? const Color(0xFF5E35B1)
                            : Colors.red.shade800;
                      } else if (isSelected) {
                        bgColor = const Color(0xFF7E57C2);
                        borderColor = const Color(0xFF5E35B1);
                        textColor = Colors.white;
                      } else {
                        bgColor = Colors.white;
                        borderColor = const Color(0xFFCE93D8);
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
                        ? const Color(0xFFF3E5F5)
                        : const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isCorrect == true
                          ? const Color(0xFF7E57C2)
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
                            ? const Color(0xFF7E57C2)
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
                                    ? const Color(0xFF5E35B1)
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
                    backgroundColor: const Color(0xFF7E57C2),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 4,
                    shadowColor: const Color(0xFF5E35B1),
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
  String? _selectedAnswer;
  bool _isProcessing = false;
  double _progressValue = 0.2;
  late AnimationController _animationController;
  bool _correctAnswer = false;
  bool? _confirmationAnswer;

  // ── Design tokens ──────────────────────────────────────────────
  static const Color _primary = Color(0xFF7C3AED);
  static const Color _dark = Color(0xFF5B21B6);
  static const Color _deepDark = Color(0xFF4C1D95);
  static const Color _accent = Color(0xFFA855F7);
  static const Color _pastel1 = Color(0xFFEDE9FE);
  static const Color _pastel2 = Color(0xFFDDD6FE);
  static const Color _pastel3 = Color(0xFFF3E8FF);
  static const Color _textBody = Color(0xFF4C1D95);

  // ── Step 1 state ──────────────────────────────────────────────
  bool _alarmRinging = false;
  bool _situationUnderstood = false;

  // ── Step 2 state ──────────────────────────────────────────────
  final Map<String, bool> _consequences = {
    'Tiredness': false,
    'Missed Alarm': false,
    'Poor Sleep': false,
    'Morning Fatigue': false,
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _nextStep() {
    setState(() {
      _isProcessing = true;
      _progressValue = (_currentStep + 1) * 0.2;
    });
    _animationController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 400), () {
        setState(() {
          _isProcessing = false;
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
    _alarmRinging = false;
    _situationUnderstood = false;
    _consequences.forEach((k, _) => _consequences[k] = false);
    _selectedAnswer = null;
    _correctAnswer = false;
    _confirmationAnswer = null;
  }

  void _completeActivity() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Second()),
    );
    setState(() {
      _currentStep = 0;
      _progressValue = 0.2;
      _resetInteractiveStates();
    });
  }

  // ── Shared helpers ─────────────────────────────────────────────

  Widget _buildProgressBar() => AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) => ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: Tween<double>(
              begin: _progressValue - 0.2,
              end: _progressValue,
            ).animate(_animationController).value,
            backgroundColor: Colors.white.withOpacity(0.35),
            valueColor: const AlwaysStoppedAnimation<Color>(_dark),
            minHeight: 8,
          ),
        ),
      );

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: ShaderMask(
          shaderCallback: (b) => const LinearGradient(
            colors: [_dark, _accent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(b),
          child: Text(text,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.3,
              )),
        ),
      );

  Widget _glassCard({required Widget child}) => Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.75),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.white.withOpacity(0.90), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: _primary.withOpacity(0.13),
              blurRadius: 24,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: child,
      );

  Widget _infoBox({required Widget child}) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_pastel1.withOpacity(0.65), _pastel3.withOpacity(0.55)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _pastel2, width: 1.5),
        ),
        child: child,
      );

  Widget _primaryButton(String label, VoidCallback? onTap) => GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            gradient: onTap != null
                ? const LinearGradient(
                    colors: [_dark, _primary, _accent],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            color: onTap == null ? Colors.white.withOpacity(0.30) : null,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: onTap != null
                  ? _pastel2.withOpacity(0.40)
                  : Colors.white.withOpacity(0.40),
              width: 1,
            ),
            boxShadow: onTap != null
                ? [
                    BoxShadow(
                      color: _primary.withOpacity(0.38),
                      blurRadius: 18,
                      offset: const Offset(0, 4),
                    )
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color:
                    onTap != null ? Colors.white : _deepDark.withOpacity(0.40),
                fontWeight: FontWeight.w700,
                fontSize: 16,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      );

  Widget _feedbackBox({
    required bool isCorrect,
    required String correctText,
    required String wrongText,
  }) =>
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isCorrect ? _pastel1 : Colors.red.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCorrect ? _primary.withOpacity(0.40) : Colors.red.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              isCorrect ? Icons.check_circle : Icons.cancel,
              color: isCorrect ? _primary : Colors.red.shade500,
              size: 22,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                isCorrect ? correctText : wrongText,
                style: TextStyle(
                  fontSize: 13.5,
                  height: 1.6,
                  color: isCorrect ? _dark : Colors.red.shade800,
                ),
              ),
            ),
          ],
        ),
      );

  // ── STEP 1 ─────────────────────────────────────────────────────
  // Replaced "Identify key factors" with a paraphrase question
  Widget _buildStep1() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (w) => SlideAnimation(
              horizontalOffset: 50,
              child: FadeInAnimation(child: w),
            ),
            children: [
              _sectionTitle("📝 Step 1: Analyze the Situation"),
              _buildProgressBar(),
              const SizedBox(height: 16),

              // Animated situation card
              GestureDetector(
                onTap: () => setState(() => _alarmRinging = !_alarmRinging),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 450),
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.90), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: _primary.withOpacity(0.14),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      AnimatedRotation(
                        duration: const Duration(milliseconds: 500),
                        turns: _alarmRinging ? 1 : 0,
                        child: Container(
                          width: 88,
                          height: 88,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                _alarmRinging ? Colors.red.shade50 : _pastel1,
                            border: Border.all(
                              color: _alarmRinging
                                  ? Colors.red.shade300
                                  : _pastel2,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              _alarmRinging ? Icons.alarm_on : Icons.alarm_off,
                              size: 46,
                              color: _alarmRinging
                                  ? Colors.red.shade500
                                  : _primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Read the situation carefully:",
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                          color: _textBody,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _infoBox(
                        child: const Text(
                          '"Jake stayed up all night playing video games and didn\'t set his alarm."',
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: _deepDark,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (_alarmRinging)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "⏰ No alarm = No wake-up call!",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // ── Paraphrase question ────────────────────────────
              _glassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Which option best paraphrases the sentence without changing its meaning?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _deepDark,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _buildParaphraseOption(
                      "A",
                      "Jake set his alarm and played video games for a short time.",
                      false,
                      Icons.alarm_on,
                    ),
                    _buildParaphraseOption(
                      "B",
                      "Jake went to bed early after playing video games.",
                      false,
                      Icons.bedtime,
                    ),
                    _buildParaphraseOption(
                      "C",
                      "Jake played video games all night and forgot to set his alarm.",
                      true,
                      Icons.videogame_asset,
                    ),
                    _buildParaphraseOption(
                      "D",
                      "Jake stayed up all night setting alarms.",
                      false,
                      Icons.alarm_add,
                    ),
                    const SizedBox(height: 14),
                    if (_selectedAnswer != null) ...[
                      _feedbackBox(
                        isCorrect: _correctAnswer,
                        correctText:
                            "Option C keeps the same meaning by restating that Jake stayed awake all night playing video games and did not set his alarm, without adding or changing information.",
                        wrongText: _getParaphraseFeedback(_selectedAnswer!),
                      ),
                      const SizedBox(height: 14),
                      if (!_correctAnswer)
                        _primaryButton("Try Again ↩",
                            () => setState(() => _selectedAnswer = null)),
                    ],
                    if (_correctAnswer) ...[
                      const SizedBox(height: 14),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        child: _situationUnderstood
                            ? _infoBox(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.check_circle,
                                        color: _primary, size: 20),
                                    const SizedBox(width: 10),
                                    const Expanded(
                                      child: Text(
                                        "Two main problems identified:\n1) Lack of sleep\n2) No alarm set",
                                        style: TextStyle(
                                          fontSize: 13.5,
                                          color: _dark,
                                          height: 1.55,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : _primaryButton(
                                "🔍 Analyze Situation",
                                () =>
                                    setState(() => _situationUnderstood = true),
                              ),
                      ),
                      if (_situationUnderstood) ...[
                        const SizedBox(height: 14),
                        _primaryButton(
                          "Predict Consequences  →",
                          _nextStep,
                        ),
                      ],
                    ],
                    if (_selectedAnswer == null)
                      _primaryButton("Continue  →", null),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParaphraseOption(
      String option, String text, bool isCorrect, IconData icon) {
    final bool isSelected = _selectedAnswer == option;

    return GestureDetector(
      onTap: _selectedAnswer != null
          ? null
          : () => setState(() {
                _selectedAnswer = option;
                _correctAnswer = isCorrect;
              }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect ? _pastel1 : Colors.red.shade50)
              : Colors.white.withOpacity(0.80),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? (isCorrect ? _primary : Colors.red.shade400)
                : _pastel2,
            width: isSelected ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? (isCorrect
                      ? _primary.withOpacity(0.15)
                      : Colors.red.withOpacity(0.10))
                  : Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isSelected
                    ? (isCorrect ? _primary : Colors.red.shade400)
                    : _pastel1,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                isSelected ? (isCorrect ? Icons.check : Icons.close) : icon,
                color: isSelected ? Colors.white : _primary,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "$option) $text",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? (isCorrect ? _dark : Colors.red.shade700)
                      : _textBody,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getParaphraseFeedback(String option) {
    switch (option) {
      case "A":
        return "This changes the meaning — Jake did NOT set his alarm and played for a short time. The original says all night.";
      case "B":
        return "This contradicts the original — Jake did not go to bed early, he stayed up all night.";
      case "D":
        return "This inverts the meaning — Jake was up all night playing games, not setting alarms.";
      default:
        return "Read the original sentence again carefully and choose the option that keeps all the same facts.";
    }
  }

  // ── STEP 2 ─────────────────────────────────────────────────────
  // More info added
  Widget _buildStep2() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (w) => SlideAnimation(
              horizontalOffset: 50,
              child: FadeInAnimation(child: w),
            ),
            children: [
              _sectionTitle(" Step 2: Identify Missing Information"),
              _buildProgressBar(),
              const SizedBox(height: 16),
              _glassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "What do we not know yet?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _deepDark,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _infoBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            const Icon(Icons.question_mark,
                                color: _accent, size: 20),
                            const SizedBox(width: 8),
                            const Text("The Unknown:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _deepDark,
                                    fontSize: 14.5)),
                          ]),
                          const SizedBox(height: 8),
                          const Text(
                            "What will probably happen next?\n"
                            "We need to predict the most logical outcome based on the given information.",
                            style: TextStyle(
                                fontSize: 14, height: 1.55, color: _textBody),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Select possible consequences:",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: _textBody,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ..._consequences.keys.map((c) {
                      final isChecked = _consequences[c]!;
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _consequences[c] = !isChecked),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: isChecked
                                ? _pastel1
                                : Colors.white.withOpacity(0.80),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isChecked ? _primary : _pastel2,
                              width: isChecked ? 2 : 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  gradient: isChecked
                                      ? const LinearGradient(
                                          colors: [_dark, _accent],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )
                                      : null,
                                  color: isChecked ? null : Colors.white,
                                  border: Border.all(
                                    color: isChecked
                                        ? Colors.transparent
                                        : _pastel2,
                                    width: 2,
                                  ),
                                ),
                                child: isChecked
                                    ? const Icon(Icons.check,
                                        size: 15, color: Colors.white)
                                    : null,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  c,
                                  style: TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: isChecked
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: isChecked ? _dark : _textBody,
                                  ),
                                ),
                              ),
                              Icon(
                                _getConsequenceIcon(c),
                                color: isChecked ? _primary : _pastel2,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    if (_consequences.values.any((v) => v)) ...[
                      const SizedBox(height: 10),
                      _infoBox(
                        child: const Text(
                          "💡 Multiple consequences often chain together in real life situations — one leads to the next.",
                          style: TextStyle(
                              fontSize: 13.5, height: 1.55, color: _textBody),
                        ),
                      ),
                    ],
                    const SizedBox(height: 18),
                    const Text(
                      "Make your prediction:",
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: _deepDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildPredictionOption(
                        "A) He will wake up early and be on time",
                        "A",
                        false,
                        Icons.sunny),
                    _buildPredictionOption("B) He will oversleep and be late",
                        "B", true, Icons.bedtime),
                    _buildPredictionOption(
                        "C) He will go jogging in the morning",
                        "C",
                        false,
                        Icons.directions_run),
                    _buildPredictionOption("D) He will clean his room", "D",
                        false, Icons.cleaning_services),
                    const SizedBox(height: 14),
                    if (_selectedAnswer != null) ...[
                      _feedbackBox(
                        isCorrect: _correctAnswer,
                        correctText:
                            "Good start! But let's verify with real life experience.",
                        wrongText: _getPredictionFeedback(_selectedAnswer!),
                      ),
                      const SizedBox(height: 14),
                      if (!_correctAnswer)
                        _primaryButton("Try Again ↩",
                            () => setState(() => _selectedAnswer = null)),
                    ],
                    if (_correctAnswer) ...[
                      const SizedBox(height: 14),
                      _primaryButton("Apply Real Life Knowledge  →", _nextStep),
                    ],
                    if (_selectedAnswer == null)
                      _primaryButton("Continue  →", null),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getConsequenceIcon(String c) {
    switch (c) {
      case 'Tiredness':
        return Icons.night_shelter;
      case 'Missed Alarm':
        return Icons.alarm_off;
      case 'Poor Sleep':
        return Icons.bed;
      case 'Morning Fatigue':
        return Icons.energy_savings_leaf;
      default:
        return Icons.warning;
    }
  }

  Widget _buildPredictionOption(
      String text, String option, bool isCorrect, IconData icon) {
    final bool isSelected = _selectedAnswer == option;

    return GestureDetector(
      onTap: _selectedAnswer != null
          ? null
          : () => setState(() {
                _selectedAnswer = option;
                _correctAnswer = isCorrect;
              }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect ? _pastel1 : Colors.red.shade50)
              : Colors.white.withOpacity(0.80),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? (isCorrect ? _primary : Colors.red.shade400)
                : _pastel2,
            width: isSelected ? 2 : 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isSelected
                    ? (isCorrect ? _primary : Colors.red.shade400)
                    : _pastel1,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                isSelected ? (isCorrect ? Icons.check : Icons.close) : icon,
                color: isSelected ? Colors.white : _primary,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? (isCorrect ? _dark : Colors.red.shade700)
                      : _textBody,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getPredictionFeedback(String option) {
    switch (option) {
      case "A":
        return "Waking up early after no sleep and no alarm is very unlikely — the body prioritises rest.";
      case "C":
        return "Jogging requires energy, which he won't have after staying up all night.";
      case "D":
        return "Cleaning requires motivation that exhaustion usually prevents.";
      default:
        return "Consider the logical sequence of events.";
    }
  }

  // ── STEP 3 ─────────────────────────────────────────────────────
  // More info added
  Widget _buildStep3() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (w) => SlideAnimation(
              horizontalOffset: 50,
              child: FadeInAnimation(child: w),
            ),
            children: [
              _sectionTitle("🌍 Step 3: Apply Real Life Experience"),
              _buildProgressBar(),
              const SizedBox(height: 16),
              _glassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "What do you know about real life?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _deepDark,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _infoBox(
                      child: Column(
                        children: [
                          _experienceCard(
                            "🛏️ Sleep Science",
                            "The body needs 7–9 hours of sleep. Staying up all night causes extreme fatigue and puts the brain into a recovery-priority mode when sleep finally happens, making natural waking almost impossible.",
                          ),
                          const SizedBox(height: 12),
                          Divider(color: _pastel2, height: 1),
                          const SizedBox(height: 12),
                          _experienceCard(
                            "⏰ Alarm Function",
                            "Alarms serve as the primary external wake-up trigger. Without one, the sleeper relies on natural circadian rhythms — which are severely disrupted after an all-nighter.",
                          ),
                          const SizedBox(height: 12),
                          Divider(color: _pastel2, height: 1),
                          const SizedBox(height: 12),
                          _experienceCard(
                            "🔗 Cause & Effect",
                            "Actions have consequences. Late night gaming + no alarm creates a chain: fatigue → deep sleep → missed wake-up time → being late.",
                          ),
                          const SizedBox(height: 12),
                          Divider(color: _pastel2, height: 1),
                          const SizedBox(height: 12),
                          _experienceCard(
                            "🎮 Screen Time Impact",
                            "Blue light from screens suppresses melatonin, making it harder to fall asleep and delaying sleep onset — which worsens the fatigue even further the next morning.",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    _infoBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 8,
                            children: const [
                              Icon(Icons.lightbulb, color: _accent, size: 20),
                              Text(
                                "Real Life Principle:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _deepDark,
                                  fontSize: 14.5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Staying up all night and not setting an alarm is a reliable recipe for oversleeping. "
                            "Both factors compound each other — together they make waking up on time nearly impossible.",
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.6,
                              color: _textBody,
                            ),
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Based on real life, which is most probable?",
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w600,
                        color: _textBody,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildRealityOption(
                        "A) Tired people naturally wake up early 🌅", false),
                    _buildRealityOption(
                        "B) No sleep + no alarm = oversleeping 😴", true),
                    _buildRealityOption(
                        "C) Fatigue increases morning energy ⚡", false),
                    _buildRealityOption(
                        "D) Cleaning happens when exhausted 🧹", false),
                    const SizedBox(height: 14),
                    if (_confirmationAnswer != null)
                      _feedbackBox(
                        isCorrect: _confirmationAnswer == true,
                        correctText:
                            "Correct! Real life experience shows this is the most likely outcome. Both factors — no sleep and no alarm — compound each other.",
                        wrongText:
                            "Think about what actually happens when people stay up all night without an alarm. The body and logic both point to one result.",
                      ),
                    const SizedBox(height: 14),
                    _primaryButton(
                      _confirmationAnswer == null
                          ? "Check Answer"
                          : "Draw Logical Conclusion  →",
                      () {
                        if (_confirmationAnswer == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("Select an option first!"),
                              backgroundColor: _primary,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        } else {
                          _nextStep();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _experienceCard(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: _pastel1,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _pastel2, width: 1.5),
          ),
          child: const Icon(Icons.science, color: _primary, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                softWrap: true,
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: _deepDark,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                softWrap: true,
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  fontSize: 13.5,
                  color: _textBody,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRealityOption(String text, bool isCorrect) {
    final isSelected =
        _confirmationAnswer != null && (_confirmationAnswer == isCorrect);

    return GestureDetector(
      onTap: _confirmationAnswer != null
          ? null
          : () => setState(() => _confirmationAnswer = isCorrect),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect ? _pastel1 : Colors.red.shade50)
              : Colors.white.withOpacity(0.80),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? (isCorrect ? _primary : Colors.red.shade400)
                : _pastel2,
            width: isSelected ? 2 : 1.5,
          ),
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 12,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isSelected && isCorrect
                    ? const LinearGradient(colors: [_dark, _accent])
                    : null,
                color: isSelected && !isCorrect
                    ? Colors.red.shade400
                    : Colors.white,
                border: Border.all(
                  color: isSelected ? Colors.transparent : _pastel2,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(isCorrect ? Icons.check : Icons.close,
                      size: 13, color: Colors.white)
                  : null,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: Text(
                text,
                softWrap: true,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected
                      ? (isCorrect ? _dark : Colors.red.shade700)
                      : _textBody,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── STEP 4 ─────────────────────────────────────────────────────
  // Options updated to "It's likely that Jake will…"
  Widget _buildStep4() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (w) => SlideAnimation(
              horizontalOffset: 50,
              child: FadeInAnimation(child: w),
            ),
            children: [
              _sectionTitle("🧠 Step 4: Logical Sequence"),
              _buildProgressBar(),
              const SizedBox(height: 16),
              _glassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Chain of events:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _deepDark,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Timeline
                    _infoBox(
                      child: Column(
                        children: [
                          _timelineStep(
                              1, "Stays up all night", Icons.nightlight),
                          _timelineDivider(),
                          _timelineStep(2, "No alarm set", Icons.alarm_off),
                          _timelineDivider(),
                          _timelineStep(3, "Extreme fatigue", Icons.bedtime),
                          _timelineDivider(),
                          _timelineStep(4, "Deep sleep", Icons.hotel),
                          _timelineDivider(),
                          _timelineStep(
                              5, "Misses wake-up time", Icons.access_time),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Logical conclusion
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _pastel1.withOpacity(0.70),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: _primary.withOpacity(0.45), width: 2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            const Icon(Icons.account_tree,
                                color: _primary, size: 20),
                            const SizedBox(width: 8),
                            const Text(
                              "Logical Conclusion:",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: _deepDark,
                              ),
                            ),
                          ]),
                          const SizedBox(height: 10),
                          const Text(
                            "Each step logically leads to the next. "
                            "The most probable outcome based on this sequence is oversleeping and being late.",
                            style: TextStyle(
                              fontSize: 14,
                              color: _textBody,
                              height: 1.55,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Options — updated wording
                    _buildFinalOption(
                      "A) It's likely that Jake will wake up early and be on time ☀️",
                      "A",
                      false,
                    ),
                    _buildFinalOption(
                      "B) It's likely that Jake will oversleep and be late 😴",
                      "B",
                      true,
                    ),
                    _buildFinalOption(
                      "C) It's likely that Jake will go jogging in the morning 🏃",
                      "C",
                      false,
                    ),
                    _buildFinalOption(
                      "D) It's likely that Jake will clean his room 🧹",
                      "D",
                      false,
                    ),

                    const SizedBox(height: 16),

                    _primaryButton(
                      "Reveal Final Analysis  →",
                      _selectedAnswer == "B" ? _nextStep : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _timelineStep(int number, String text, IconData icon) => Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [_dark, _accent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Text(number.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13)),
            ),
          ),
          const SizedBox(width: 12),
          Icon(icon, color: _primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _textBody)),
          ),
        ],
      );

  Widget _timelineDivider() => Padding(
        padding: const EdgeInsets.only(left: 14, top: 4, bottom: 4),
        child: Container(
          width: 2,
          height: 14,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_pastel2, _pastel2.withOpacity(0.30)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      );

  Widget _buildFinalOption(String text, String option, bool isCorrect) {
    final bool isSelected = _selectedAnswer == option;

    return GestureDetector(
      onTap: () => setState(() => _selectedAnswer = option),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect ? _pastel1 : Colors.red.shade50)
              : Colors.white.withOpacity(0.80),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? (isCorrect ? _primary : Colors.red.shade400)
                : _pastel2,
            width: isSelected ? 2 : 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: isSelected && isCorrect
                    ? const LinearGradient(
                        colors: [_dark, _accent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isSelected && !isCorrect
                    ? Colors.red.shade400
                    : (!isSelected ? _pastel1 : null),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: isSelected ? Colors.transparent : _pastel2),
              ),
              child: Center(
                child: Text(
                  option.replaceAll(")", ""),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : _dark,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? (isCorrect ? _dark : Colors.red.shade700)
                      : _textBody,
                  height: 1.45,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? _primary : Colors.red.shade500,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  // ── STEP 5 ─────────────────────────────────────────────────────
  // Updated content as requested
  Widget _buildStep5() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("🏁 Final Analysis"),
          _buildProgressBar(),
          const SizedBox(height: 16),
          _glassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [_dark, _accent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.check_circle,
                          color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "Final Answer:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: _dark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _infoBox(
                  child: const Text(
                    "B) It's likely that Jake will oversleep and be late 😴",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _dark,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  height: 1.5,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [_pastel2, _pastel3]),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Explanation:",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: _deepDark,
                  ),
                ),
                const SizedBox(height: 12),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                        fontSize: 14.5, color: _textBody, height: 1.65),
                    children: [
                      TextSpan(text: "• "),
                      TextSpan(
                          text:
                              "Staying up all night playing video games causes extreme fatigue, making it difficult for Jake to wake up on time.\n\n"),
                      TextSpan(text: "• "),
                      TextSpan(
                          text:
                              "Not setting an alarm removes the only reliable way for Jake to wake up in the morning.\n\n"),
                      TextSpan(text: "• "),
                      TextSpan(
                          text:
                              "Because of these two factors, oversleeping and being late is the most logical outcome."),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                _primaryButton("Start Activity", _completeActivity),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Router ─────────────────────────────────────────────────────
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFD8B4FE),
              Color(0xFFC4B5FD),
              Color(0xFFAB8FF7),
              Color(0xFF8B5CF6),
            ],
            stops: [0.0, 0.30, 0.65, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.30),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.50), width: 1),
                        ),
                        child: Icon(Icons.close,
                            size: 18, color: _deepDark.withOpacity(0.85)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: AbsorbPointer(
                  absorbing: _isProcessing,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: _buildCurrentStep(),
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
    '💡 General Hint: What result does providing sunlight and water have on plants?',
    '📌 More Specific: Do plants with proper care tend to thrive or die?',
  ];
  final List<String> hints2 = [
    '💡 General Hint: What does the combination of dark clouds and no rain protection lead to?',
    '📌 More Specific: If it starts raining, will Daniel with no umbrella stay dry or get wet?',
  ];
  final List<String> hints3 = [
    '💡 General Hint: What is the universal outcome of regular and focused practice?',
    '📌 More Specific: Does consistent practice usually lead to skill improvement or decline?',
  ];
  final List<String> hints4 = [
    '💡 General Hint: What is the natural consequence of placing an object in an unstable, precarious position?',
    '📌 More Specific: When a glass is left on the very edge, is it likely to stay put or fall?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Maya watered her flowers every morning and kept them in the sun.\nWhat will most likely happen?",
      "options": [
        "A) The flowers will die",
        "B) The flowers will grow healthy",
        "C) The flowers will turn into trees overnight",
        "D) The flowers will disappear"
      ],
      "correctIndex": 1,
      "feedback": [
        "Incorrect: Flowers receiving daily care do not die.",
        "Explanation: Proper care such as watering and sunlight helps flowers grow healthy.",
        "Flowers cannot transform into trees overnight.",
        "Flowers do not disappear under normal conditions."
      ]
    },
    {
      "question":
          "Daniel forgot his umbrella, and the sky turned dark with heavy clouds.\nWhat will most likely happen?",
      "options": [
        "A) Daniel will stay perfectly dry",
        "B) Daniel will stay inside all day",
        "C) Daniel will go swimming",
        "D) Daniel will get wet in the rain"
      ],
      "correctIndex": 3,
      "feedback": [
        "Incorrect: Without an umbrella, staying dry outdoors is unlikely.",
        "Staying inside all day is not implied by the sentence.",
        "Going swimming is unrelated to the situation.",
        "Explanation: Dark clouds often indicate rain, so Daniel will likely get wet without protection."
      ]
    },
    {
      "question":
          "Sophia practiced the piano for two hours every day.\nWhat will most likely happen?",
      "options": [
        "A) She will forget how to play",
        "B) She will improve her skills",
        "C) She will quit playing music",
        "D) She will break the piano"
      ],
      "correctIndex": 1,
      "feedback": [
        "Incorrect: Practicing does not cause someone to forget their skills.",
        "Explanation: Regular practice leads to improvement.",
        "Quitting is not suggested by the information.",
        "Breaking the piano is unrelated to practicing."
      ]
    },
    {
      "question":
          "Carlos left a glass on the very edge of the table.\nWhat will most likely happen?",
      "options": [
        "A) The glass will fall and break",
        "B) The glass will float in the air",
        "C) The glass will disappear",
        "D) The glass will turn into plastic"
      ],
      "correctIndex": 0,
      "feedback": [
        "Explanation: Glasses placed near the edge of a table commonly fall.",
        "Incorrect: Glasses do not float.",
        "The glass disappearing is unrealistic.",
        "Objects do not transform into plastic spontaneously."
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
              backgroundColor: const Color(0xFFF3E5F5),
              titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              title: Row(
                children: const [
                  Icon(Icons.emoji_events, color: Color(0xFF7B1FA2), size: 30),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Level Complete!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4A148C),
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
                      color: Color(0xFF7B1FA2),
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
                    foregroundColor: const Color(0xFF7B1FA2),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  label: const Text("Advance"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B1FA2),
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
      backgroundColor: const Color(0xFFF3E5F5),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF3E5F5), // lila muy claro
              Color(0xFFE1BEE7), // lavanda suave
              Color(0xFFCE93D8), // lila medio
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
                      backgroundColor: const Color(0xFFCE93D8),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF7B1FA2)),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    "Choose the right option",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A148C),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Card de pregunta
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFE1BEE7),
                          Color(0xFFF3E5F5),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: const Color(0xFF9C27B0).withOpacity(0.4)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF9C27B0).withOpacity(0.15),
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
                        color: Color(0xFF4A148C),
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
                                  ? const Color(0xFFE1BEE7)
                                  : Colors.red.shade100)
                              : Colors.white,
                          foregroundColor: const Color(0xFF4A148C),
                          disabledBackgroundColor: selectedOptionIndex == i
                              ? (i == correctIndex
                                  ? const Color(0xFFE1BEE7)
                                  : Colors.red.shade100)
                              : Colors.white.withOpacity(0.7),
                          disabledForegroundColor: selectedOptionIndex == i
                              ? (i == correctIndex
                                  ? const Color(0xFF4A148C)
                                  : Colors.red.shade700)
                              : Colors.black45,
                          minimumSize: const Size.fromHeight(52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: BorderSide(
                              color: selectedOptionIndex == i
                                  ? (i == correctIndex
                                      ? const Color(0xFF7B1FA2)
                                      : Colors.red)
                                  : const Color(0xFF9C27B0).withOpacity(0.3),
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
                                ? const Color(0xFFE1BEE7)
                                : Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selectedOptionIndex == correctIndex
                                  ? const Color(0xFF7B1FA2)
                                  : Colors.red.shade300,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            selectedOptionIndex == correctIndex
                                ? "✩ ${feedback[selectedOptionIndex!]}"
                                : "❌ ${feedback[selectedOptionIndex!]}",
                            style: TextStyle(
                              fontSize: 18,
                              height: 1.5,
                              color: selectedOptionIndex == correctIndex
                                  ? const Color(0xFF4A148C)
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
                                      ? const Color(0xFF7B1FA2)
                                      : const Color(0xFFE1BEE7),
                              foregroundColor:
                                  selectedOptionIndex == correctIndex
                                      ? Colors.white
                                      : const Color(0xFF4A148C),
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
                                            color: const Color(0xFF9C27B0)
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
                                      ? const Color(0xFF9C27B0)
                                      : const Color(0xFFCE93D8),
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
                                    color: const Color(0xFF9C27B0), width: 1.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF9C27B0)
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
                                        color: Color(0xFF4A148C),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close,
                                        size: 20, color: Color(0xFF7B1FA2)),
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
        'Emma trained every day by running long distances.\n\nComplete the sentence: Emma will most likely…',
    options: [
      "A) Become tired forever",
      "B) Grow weaker",
      "C) Become stronger and faster",
      "D) Stop liking running"
    ],
    correctIndex: 2,
    explanation:
        '✨ Correct answer: C\nConsistent training helps improve strength and endurance.',
    incorrectExplanations: [
      ' Nobody stays tired forever; this is unrealistic.',
      ' Training regularly does not make someone weaker.',
      ' This is the correct answer because practice builds ability.',
      ' Losing interest is possible, but not the most logical outcome here.'
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
          MaterialPageRoute(builder: (_) => const SecondActyvityAnimation()),
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
      backgroundColor: const Color(0xFFF3E5F5),
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
                        size: 28, color: Color(0xFF7E57C2)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Question card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF9C27B0),
                      Color(0xFF5E35B1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5E35B1).withOpacity(0.35),
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

              // Opciones
              Expanded(
                child: AbsorbPointer(
                  absorbing: isAnswerSubmitted,
                  child: ListView.builder(
                    itemCount: question.options.length,
                    itemBuilder: (context, i) {
                      final isSelected = selected == i;

                      Color bgColor;
                      Color borderColor;
                      Color textColor;

                      if (isAnswerSubmitted && isSelected) {
                        bgColor = isCorrect == true
                            ? const Color(0xFFF3E5F5)
                            : const Color(0xFFFFEBEE);
                        borderColor = isCorrect == true
                            ? const Color(0xFF7E57C2)
                            : const Color(0xFFEF9A9A);
                        textColor = isCorrect == true
                            ? const Color(0xFF5E35B1)
                            : Colors.red.shade800;
                      } else if (isSelected) {
                        bgColor = const Color(0xFF7E57C2);
                        borderColor = const Color(0xFF5E35B1);
                        textColor = Colors.white;
                      } else {
                        bgColor = Colors.white;
                        borderColor = const Color(0xFF7E57C2).withOpacity(0.3);
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
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
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
                        ? const Color(0xFFF3E5F5)
                        : const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isCorrect == true
                          ? const Color(0xFF7E57C2)
                          : const Color(0xFFEF9A9A),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        isCorrect == true ? Icons.check_circle : Icons.cancel,
                        color: isCorrect == true
                            ? const Color(0xFF7E57C2)
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
                                    ? const Color(0xFF5E35B1)
                                    : Colors.red.shade800,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              feedbackText!,
                              style: const TextStyle(fontSize: 16, height: 1.5),
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
                    backgroundColor: const Color(0xFF7E57C2),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 4,
                    shadowColor: const Color(0xFF5E35B1),
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
  String? _selectedAnswer;
  // ignore: unused_field
  bool _isProcessing = false;
  double _progressValue = 0.2;
  late AnimationController _animationController;
  bool _correctAnswer = false;
  bool? _confirmationAnswer;

  // Purple color scheme — soft tones
  final Color _primaryColor = const Color(0xFF9C27B0);
  final Color _darkPurple = const Color(0xFF6A1B9A);
  final Color _accentColor = const Color(0xFFCE93D8);
  final Color _lightPurple = const Color(0xFFF3E5F5);
  final Color _backgroundLight = const Color(0xFFF8F0FF);
  final Color _backgroundMid = const Color(0xFFEDE7F6);
  final Color _backgroundDark = const Color(0xFFE1D5F0);

  // Interactive states
  // ignore: unused_field
  bool _trainingAnalyzed = false;
  int _trainingDays = 0;
  // ignore: unused_field
  List<String> _selectedEffects = [];
  final Map<String, double> _progressIndicators = {
    'Strength': 0.0,
    'Speed': 0.0,
    'Endurance': 0.0,
    'Energy': 0.0,
  };

  // Running animation
  // ignore: unused_field
  double _runnerPosition = 0.0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _nextStep() {
    setState(() {
      _isProcessing = true;
      _progressValue = (_currentStep + 1) * 0.2;
    });

    _animationController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 400), () {
        setState(() {
          _isProcessing = false;
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
    _trainingAnalyzed = false;
    _trainingDays = 0;
    _selectedEffects = [];
    _progressIndicators.forEach((key, value) {
      _progressIndicators[key] = 0.0;
    });
    _runnerPosition = 0.0;
    _isRunning = false;
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

  // ignore: unused_element
  Widget _buildProgressRow(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _darkPurple,
          ),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 12,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

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
                "🏃‍♀️ Step 1: Training Analysis",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkPurple,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),

              // Swipe instruction hint
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: _accentColor.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: _accentColor, width: 1.2),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.swipe, color: _primaryColor, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "Tap the card to see the training effect!",
                      style: TextStyle(
                        fontSize: 13,
                        color: _darkPurple,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

              // Interactive Training Simulation
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isRunning = true;
                    _runnerPosition = 1.0;
                    if (_trainingDays < 7) {
                      _trainingDays++;
                      _updateProgressIndicators();
                    }
                  });
                  Future.delayed(const Duration(seconds: 1), () {
                    setState(() {
                      _isRunning = false;
                    });
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_lightPurple, Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _primaryColor, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: _primaryColor.withOpacity(0.18),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: Stack(
                          children: [
                            Container(
                              height: 5,
                              color: Colors.grey[300],
                              margin: const EdgeInsets.symmetric(vertical: 48),
                            ),
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 800),
                              left: _isRunning
                                  ? MediaQuery.of(context).size.width - 100
                                  : 0,
                              child: Icon(
                                Icons.directions_run,
                                size: 60,
                                color:
                                    _isRunning ? Colors.green : _primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Emma trained every day by running long distances.",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: _darkPurple,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _accentColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_today,
                                color: _primaryColor, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              "Training Days: $_trainingDays",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _darkPurple,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_isRunning)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "🏃‍♀️ Emma is running!",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Training Effects Card
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                shadowColor: _primaryColor.withOpacity(0.12),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What effects does daily running have?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkPurple,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ..._progressIndicators.keys.map((indicator) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    indicator,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: _darkPurple,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${(_progressIndicators[indicator]! * 100).toInt()}%",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            LinearProgressIndicator(
                              value: _progressIndicators[indicator],
                              backgroundColor: Colors.grey[200],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  _progressIndicators[indicator]! > 0.5
                                      ? Colors.green
                                      : _primaryColor),
                              minHeight: 8,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            const SizedBox(height: 15),
                          ],
                        );
                      }).toList(),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightPurple.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _accentColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.trending_up, color: _primaryColor),
                                const SizedBox(width: 10),
                                Text(
                                  "Training Principle:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _darkPurple,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Regular training causes progressive adaptation. "
                              "The body responds to consistent exercise by improving.",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Understanding Check
              Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.white,
                shadowColor: _primaryColor.withOpacity(0.1),
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
                    elevation: 4,
                  ),
                  onPressed: _trainingDays > 0 ? _nextStep : null,
                  child: const Text(
                    "Predict Outcomes ➡️",
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

  void _updateProgressIndicators() {
    setState(() {
      _progressIndicators['Strength'] =
          (_progressIndicators['Strength']! + 0.2).clamp(0.0, 1.0);
      _progressIndicators['Speed'] =
          (_progressIndicators['Speed']! + 0.15).clamp(0.0, 1.0);
      _progressIndicators['Endurance'] =
          (_progressIndicators['Endurance']! + 0.25).clamp(0.0, 1.0);
      _progressIndicators['Energy'] =
          (_progressIndicators['Energy']! + 0.1).clamp(0.0, 1.0);
    });
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
              horizontalOffset: 50.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              Text(
                "🔮 Step 2: Outcome Prediction",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkPurple,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                shadowColor: _primaryColor.withOpacity(0.12),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What will most likely happen to Emma?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkPurple,
                        ),
                      ),
                      const SizedBox(height: 15),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightPurple.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _primaryColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.question_mark, color: _primaryColor),
                                const SizedBox(width: 10),
                                Text(
                                  "The Unknown:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _darkPurple,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Based on her daily training routine, "
                              "we need to predict the most probable physical outcome.",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      Text(
                        "Training → ? Outcome",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkPurple,
                        ),
                      ),
                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: _primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: _primaryColor),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.directions_run,
                                    color: _primaryColor),
                                const SizedBox(height: 5),
                                const Text("Daily Running"),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward,
                              color: _accentColor, size: 30),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.help_outline, color: Colors.grey),
                                const SizedBox(height: 5),
                                const Text("?"),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      Text(
                        "Choose the most likely outcome:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkPurple,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Step 2: options WITHOUT symbols next to text
                      _buildPredictionOption(
                        "A) Become tired forever",
                        "A",
                        false,
                        Icons.mood_bad,
                      ),
                      _buildPredictionOption(
                        "B) Grow weaker",
                        "B",
                        false,
                        Icons.arrow_downward,
                      ),
                      _buildPredictionOption(
                        "C) Become stronger and faster",
                        "C",
                        true,
                        Icons.trending_up,
                      ),
                      _buildPredictionOption(
                        "D) Stop liking running",
                        "D",
                        false,
                        Icons.favorite_border,
                      ),
                    ],
                  ),
                ),
              ),
              if (_selectedAnswer != null)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    key: ValueKey(_selectedAnswer),
                    children: [
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: _correctAnswer
                            ? Colors.green.withOpacity(0.1)
                            : Colors.orange.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    _correctAnswer
                                        ? Icons.check_circle
                                        : Icons.help_outline,
                                    color: _correctAnswer
                                        ? Colors.green
                                        : Colors.orange,
                                    size: 28,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    _correctAnswer
                                        ? "🎯 Smart Prediction!"
                                        : "💭 Think About...",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: _darkPurple,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _correctAnswer
                                    ? "Good thinking! But let's verify with exercise science."
                                    : _getPredictionFeedback(_selectedAnswer!),
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
                          icon: const Icon(Icons.refresh, color: Colors.white),
                          label: const Text("Try Again"),
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      backgroundColor: _primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                    ),
                    onPressed: _nextStep,
                    child: const Text(
                      "Apply Exercise Science ➡️",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPredictionOption(
      String text, String option, bool isCorrect, IconData icon) {
    final bool isSelected = _selectedAnswer == option;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAnswer = option;
          _correctAnswer = isCorrect;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect
                  ? Colors.green.withOpacity(0.1)
                  : Colors.orange.withOpacity(0.1))
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? (isCorrect ? Colors.green : Colors.orange)
                : Colors.grey[300]!,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? (isCorrect
                      ? Colors.green.withOpacity(0.15)
                      : Colors.orange.withOpacity(0.15))
                  : Colors.transparent,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? (isCorrect ? Colors.green : Colors.orange)
                    : _lightPurple,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : _darkPurple,
                size: 22,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: _darkPurple,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                isCorrect ? Icons.check_circle : Icons.help,
                color: isCorrect ? Colors.green : Colors.orange,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  String _getPredictionFeedback(String option) {
    switch (option) {
      case "A":
        return "Becoming tired forever is unrealistic.";
      case "B":
        return "Growing weaker doesn't match consistent training.";
      case "D":
        return "Stopping liking running isn't implied by training.";
      default:
        return "Consider how the body adapts to exercise.";
    }
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
              horizontalOffset: 50.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              Text(
                "🔬 Step 3: Exercise Science",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkPurple,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                shadowColor: _primaryColor.withOpacity(0.12),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What do you know about exercise adaptation?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkPurple,
                        ),
                      ),
                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightPurple.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _primaryColor),
                        ),
                        child: Column(
                          children: [
                            _buildScienceCard(
                              "Muscle Adaptation",
                              "Muscles grow stronger with consistent training through micro-tears and repair.",
                            ),
                            const SizedBox(height: 15),
                            _buildScienceCard(
                              "Cardiovascular Improvement",
                              "Heart and lungs become more efficient with regular aerobic exercise.",
                            ),
                            const SizedBox(height: 15),
                            _buildScienceCard(
                              "Endurance Development",
                              "Body learns to use oxygen more efficiently during sustained activity.",
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.blue),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.science, color: Colors.blue),
                                const SizedBox(width: 10),
                                Text(
                                  "Scientific Fact:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _darkPurple,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Regular training improves strength and endurance over time. "
                              "This is a well-established principle of exercise physiology.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      Text(
                        "Based on exercise science, which is accurate?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkPurple,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Step 3 option C: no sleep symbol so answer isn't obvious
                      _buildScienceOption(
                        "A) Training causes permanent fatigue",
                        false,
                      ),
                      _buildScienceOption(
                        "B) Exercise makes muscles weaker",
                        false,
                      ),
                      _buildScienceOption(
                        "C) Consistent running improves performance",
                        true,
                      ),
                      _buildScienceOption(
                        "D) People always quit activities they practice",
                        false,
                      ),
                    ],
                  ),
                ),
              ),
              if (_confirmationAnswer != null)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    key: ValueKey(_confirmationAnswer),
                    children: [
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: _confirmationAnswer == true
                            ? Colors.green.withOpacity(0.1)
                            : Colors.orange.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    _confirmationAnswer == true
                                        ? Icons.emoji_objects
                                        : Icons.lightbulb_outline,
                                    color: _confirmationAnswer == true
                                        ? Colors.green
                                        : Colors.orange,
                                    size: 28,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    _confirmationAnswer == true
                                        ? "✅ Science Applied!"
                                        : "💡 Check the Evidence...",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: _darkPurple,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _confirmationAnswer == true
                                    ? "Correct! Exercise science shows that consistent training leads to improvements."
                                    : "Research shows that training causes positive adaptations, not negative ones.",
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
                    ],
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
                    elevation: 4,
                  ),
                  onPressed: () {
                    if (_confirmationAnswer == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Select an option first!"),
                          backgroundColor: _primaryColor,
                        ),
                      );
                    } else {
                      _nextStep();
                    }
                  },
                  child: const Text(
                    "Draw Logical Conclusion ➡️",
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

  Widget _buildScienceCard(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _primaryColor.withOpacity(0.1),
          ),
          child: const Icon(Icons.health_and_safety, color: Colors.green),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _darkPurple,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScienceOption(String text, bool isCorrect) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: _lightPurple.withOpacity(0.5)),
      ),
      color: Colors.white,
      child: ListTile(
        leading: Radio<bool>(
          value: isCorrect,
          groupValue: _confirmationAnswer == isCorrect ? isCorrect : null,
          onChanged: (value) {
            setState(() {
              _confirmationAnswer = isCorrect;
            });
          },
          activeColor: _primaryColor,
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: _darkPurple,
          ),
        ),
        tileColor: _confirmationAnswer == isCorrect
            ? (isCorrect
                ? Colors.green.withOpacity(0.1)
                : Colors.orange.withOpacity(0.1))
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildStep4() {
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
                "⚡ Step 4: Cause and Effect",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkPurple,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                shadowColor: _primaryColor.withOpacity(0.12),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Training → Adaptation Process:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkPurple,
                        ),
                      ),
                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightPurple.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _primaryColor),
                        ),
                        child: Column(
                          children: [
                            _buildAdaptationStep(
                                1, "Daily running", Icons.directions_run),
                            const SizedBox(height: 10),
                            _buildAdaptationStep(
                                2, "Muscle stimulation", Icons.fitness_center),
                            const SizedBox(height: 10),
                            _buildAdaptationStep(
                                3, "Body adaptation", Icons.autorenew),
                            const SizedBox(height: 10),
                            _buildAdaptationStep(
                                4, "Strength increase", Icons.trending_up),
                            const SizedBox(height: 10),
                            _buildAdaptationStep(
                                5, "Speed improvement", Icons.directions_run),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.green, width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.link, color: Colors.green),
                                const SizedBox(width: 10),
                                Text(
                                  "Logical Connection:",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: _darkPurple,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "Becoming stronger and faster fits cause-and-effect. "
                              "This is the most logical outcome based on exercise science and real-world evidence.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Updated question for Step 4
                      Text(
                        "What's the most logical outcome?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _darkPurple,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Choose the best explanation:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 15),

                      _buildFinalOption(
                        "A) It is likely that Emma will feel tired all the time",
                        "A",
                        false,
                      ),
                      _buildFinalOption(
                        "B) It is likely that Emma will lose strength",
                        "B",
                        false,
                      ),
                      _buildFinalOption(
                        "C) It is likely that Emma will become stronger and faster",
                        "C",
                        true,
                      ),
                      _buildFinalOption(
                        "D) It is likely that Emma will stop enjoying running",
                        "D",
                        false,
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
                    backgroundColor: _primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  onPressed: _selectedAnswer == "C" ? _nextStep : null,
                  child: const Text(
                    "Reveal Final Analysis ➡️",
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

  Widget _buildAdaptationStep(int number, String text, IconData icon) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _primaryColor,
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Icon(icon, color: _accentColor),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFinalOption(String text, String option, bool isCorrect) {
    final bool isSelected = _selectedAnswer == option;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: isSelected
          ? (isCorrect
              ? Colors.green.withOpacity(0.1)
              : Colors.orange.withOpacity(0.1))
          : Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          setState(() {
            _selectedAnswer = option;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? (isCorrect ? Colors.green : Colors.orange)
                      : _lightPurple,
                  border: Border.all(color: _primaryColor),
                ),
                child: Center(
                  child: Text(
                    option,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : _darkPurple,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  isCorrect ? Icons.check_circle : Icons.cancel,
                  color: isCorrect ? Colors.green : Colors.orange,
                  size: 24,
                ),
            ],
          ),
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
            "🏁 Final Analysis",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _darkPurple,
            ),
          ),

          _buildProgressIndicator(),
          const SizedBox(height: 16),

          // ----------- CARD PRINCIPAL ----------------
          Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white,
            shadowColor: _primaryColor.withOpacity(0.12),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITULO RESPUESTA
                  Text(
                    "✔️ Final Answer:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // RESPUESTA
                  Text(
                    "C) It is likely that Emma will become stronger and faster",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkPurple,
                    ),
                    textAlign: TextAlign.left,
                  ),

                  const Divider(height: 32),

                  // TITULO EXPLICACIÓN
                  Text(
                    "Explanation:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkPurple,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // LISTA EXPLICATIVA
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        color: _darkPurple,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(
                          text:
                              "Running long distances every day builds endurance and physical strength.\n\n",
                        ),
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(
                          text:
                              "Consistent training helps improve speed and overall fitness.\n\n",
                        ),
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(
                          text:
                              "Therefore, becoming stronger and faster is the most logical outcome.",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ----------- BOTÓN FINAL ----------------
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow, color: Colors.white),
              label: const Text(
                "Start Activity",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
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
              onPressed: _completeActivity,
            ),
          ),
        ],
      ),
    );
  }

  void _completeActivity() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const SecondActyvityAnimation(),
      ),
    );
    setState(() {
      _currentStep = 0;
      _progressValue = 0.2;
      _resetInteractiveStates();
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar removed as requested
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_backgroundLight, _backgroundMid, _backgroundDark],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: _buildCurrentStep(),
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

  // Variables para el efecto del bombillo de inactividad
  Timer? _inactivityTimer;
  bool _isInactive = false;
  late AnimationController _glowController;

  final List<String> hints1 = [
    '💡 General: What happens to any battery-powered device that is not recharged?',
    "📌 More Specific: If a phone's battery isn't replenished, will it stay on or shut down?",
  ];

  final List<String> hints2 = [
    '💡 General: What is the expected result of intensive preparation for an exam?',
    '📌 More Specific: Does dedicated studying usually lead to good performance or failure?',
  ];

  final List<String> hints3 = [
    '💡 General: What happens to electric lights when there is a power outage?',
    '📌 More Specific: If the power is out, will the lights stay lit or go dark?',
  ];

  final List<String> hints4 = [
    '💡 General: What physical change does heat cause in frozen food?',
    '📌 More Specific: Will ice cream left out in the heat keep its shape or turn to liquid?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Olivia forgot to charge her phone before going to school.\nComplete the sentence: Her phone will most likely…",
      "options": [
        "A) Die",
        "B) Last forever",
        "C) Charge by itself",
        "D) Get faster"
      ],
      "correctIndex": 0,
      "feedback": [
        "Explanation: Phones without charging eventually shut off.",
        "Incorrect: Phones cannot last forever without battery.",
        "Phones do not charge themselves.",
        "A phone does not get faster when the battery is low."
      ]
    },
    {
      "question":
          "Henry studied hard all week for the math test.\nComplete the sentence: He will most likely…",
      "options": [
        "A) Fail the test",
        "B) Do well on the test",
        "C) Find the test canceled",
        "D) Forget everything"
      ],
      "correctIndex": 1,
      "feedback": [
        " Incorrect: Studying usually helps performance.",
        "Explanation: Studying increases the chance of success.",
        "There is no information suggesting the test will be canceled.",
        "Studying does not cause forgetting."
      ]
    },
    {
      "question":
          "A storm knocked out the power in the entire town.\nComplete the sentence: The lights will most likely…",
      "options": [
        "A) Be ignored by everyone",
        "B) Stay on",
        "C) Become brighter",
        "D) Go out"
      ],
      "correctIndex": 3,
      "feedback": [
        "Incorrect: People cannot ignore a power outage.",
        "Incorrect: Lights need electricity to stay on.",
        "Lights cannot stay on without electricity.",
        "Explanation: Power outages usually mean no lights."
      ]
    },
    {
      "question":
          "Noah left ice cream outside on a hot day.\nComplete the sentence: The ice cream will most likely…",
      "options": [
        "A) Stay frozen",
        "B) Melt",
        "C) Turn into candy",
        "D) Disappear"
      ],
      "correctIndex": 1,
      "feedback": [
        "Incorrect: Ice cream will not stay frozen in heat.",
        "Explanation: Heat causes ice cream to melt.",
        "Ice cream does not transform into candy.",
        "Ice cream does not disappear by itself."
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
              backgroundColor: const Color(0xFFF3E5F5),
              titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              title: Row(
                children: const [
                  Icon(Icons.emoji_events, color: Color(0xFF7B1FA2), size: 30),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Level Complete!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4A148C),
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
                      color: Color(0xFF7B1FA2),
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
                    foregroundColor: const Color(0xFF7B1FA2),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  label: const Text("Advance"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B1FA2),
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
      backgroundColor: const Color(0xFFF3E5F5),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF3E5F5), // lila muy claro
              Color(0xFFE1BEE7), // lavanda suave
              Color(0xFFCE93D8), // lila medio
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
                      backgroundColor: const Color(0xFFCE93D8),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF7B1FA2)),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    "Choose the right option",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A148C),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Card de pregunta
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFE1BEE7),
                          Color(0xFFF3E5F5),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: const Color(0xFF9C27B0).withOpacity(0.4)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF9C27B0).withOpacity(0.15),
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
                        color: Color(0xFF4A148C),
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
                                  ? const Color(0xFFE1BEE7)
                                  : Colors.red.shade100)
                              : Colors.white,
                          foregroundColor: const Color(0xFF4A148C),
                          disabledBackgroundColor: selectedOptionIndex == i
                              ? (i == correctIndex
                                  ? const Color(0xFFE1BEE7)
                                  : Colors.red.shade100)
                              : Colors.white.withOpacity(0.7),
                          disabledForegroundColor: selectedOptionIndex == i
                              ? (i == correctIndex
                                  ? const Color(0xFF4A148C)
                                  : Colors.red.shade700)
                              : Colors.black45,
                          minimumSize: const Size.fromHeight(52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: BorderSide(
                              color: selectedOptionIndex == i
                                  ? (i == correctIndex
                                      ? const Color(0xFF7B1FA2)
                                      : Colors.red)
                                  : const Color(0xFF9C27B0).withOpacity(0.3),
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
                                ? const Color(0xFFE1BEE7)
                                : Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selectedOptionIndex == correctIndex
                                  ? const Color(0xFF7B1FA2)
                                  : Colors.red.shade300,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            selectedOptionIndex == correctIndex
                                ? "✩ ${feedback[selectedOptionIndex!]}"
                                : "❌ ${feedback[selectedOptionIndex!]}",
                            style: TextStyle(
                              fontSize: 18,
                              height: 1.5,
                              color: selectedOptionIndex == correctIndex
                                  ? const Color(0xFF4A148C)
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
                                      ? const Color(0xFF7B1FA2)
                                      : const Color(0xFFE1BEE7),
                              foregroundColor:
                                  selectedOptionIndex == correctIndex
                                      ? Colors.white
                                      : const Color(0xFF4A148C),
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
                                            color: const Color(0xFF9C27B0)
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
                                      ? const Color(0xFF9C27B0)
                                      : const Color(0xFFCE93D8),
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
                                    color: const Color(0xFF9C27B0), width: 1.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF9C27B0)
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
                                        color: Color(0xFF4A148C),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close,
                                        size: 20, color: Color(0xFF7B1FA2)),
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
    question:
        'Liam left his shoes outside during a rainstorm.\n\nWhich option is the error (unlikely outcome)?',
    options: [
      "A) His shoes will get wet",
      "B) His shoes might smell bad",
      "C) His shoes will dry later",
      "D) His shoes will turn into gold"
    ],
    correctIndex: 3,
    explanation:
        '✨ Correct answer: D\nThis option is impossible. Shoes do not turn into gold.',
    incorrectExplanations: [
      ' This is a normal and likely outcome.',
      ' Shoes can indeed smell bad after rain.',
      ' They dry eventually if left outside.',
      ' This is the correct answer because it is unrealistic.'
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
          MaterialPageRoute(builder: (_) => const ThirdActyvityAnimation()),
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
      backgroundColor: const Color(0xFFF3E5F5),
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
                        size: 28, color: Color(0xFF7E57C2)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Question card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF9C27B0),
                      Color(0xFF5E35B1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5E35B1).withOpacity(0.35),
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

              // Opciones
              Expanded(
                child: AbsorbPointer(
                  absorbing: isAnswerSubmitted,
                  child: ListView.builder(
                    itemCount: question.options.length,
                    itemBuilder: (context, i) {
                      final isSelected = selected == i;

                      Color bgColor;
                      Color borderColor;
                      Color textColor;

                      if (isAnswerSubmitted && isSelected) {
                        bgColor = isCorrect == true
                            ? const Color(0xFFF3E5F5)
                            : const Color(0xFFFFEBEE);
                        borderColor = isCorrect == true
                            ? const Color(0xFF7E57C2)
                            : const Color(0xFFEF9A9A);
                        textColor = isCorrect == true
                            ? const Color(0xFF5E35B1)
                            : Colors.red.shade800;
                      } else if (isSelected) {
                        bgColor = const Color(0xFF7E57C2);
                        borderColor = const Color(0xFF5E35B1);
                        textColor = Colors.white;
                      } else {
                        bgColor = Colors.white;
                        borderColor = const Color(0xFF7E57C2).withOpacity(0.3);
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
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
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
                        ? const Color(0xFFF3E5F5)
                        : const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isCorrect == true
                          ? const Color(0xFF7E57C2)
                          : const Color(0xFFEF9A9A),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        isCorrect == true ? Icons.check_circle : Icons.cancel,
                        color: isCorrect == true
                            ? const Color(0xFF7E57C2)
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
                                    ? const Color(0xFF5E35B1)
                                    : Colors.red.shade800,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              feedbackText!,
                              style: const TextStyle(fontSize: 16, height: 1.5),
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
                    backgroundColor: const Color(0xFF7E57C2),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 4,
                    shadowColor: const Color(0xFF5E35B1),
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
  String? _selectedAnswer;
  // ignore: unused_field
  bool _isProcessing = false;
  double _progressValue = 0.2;
  late AnimationController _animationController;
  bool _correctAnswer = false;
  bool? _confirmationAnswer;

  // Purple color scheme
  final Color _primaryColor = const Color(0xFF9C27B0);
  final Color _darkPurple = const Color(0xFF7B1FA2);
  final Color _accentColor = const Color(0xFFCE93D8);
  final Color _lightPurple = const Color(0xFFF3E5F5);
  final Color _backgroundLight = const Color(0xFFEDE7F6);
  final Color _backgroundDark = const Color(0xFFD1C4E9);

  // Interactive states
  // ignore: unused_field
  bool _situationAnalyzed = false;
  int _rainLevel = 0;
  double _wetnessLevel = 0.0;
  double _smellLevel = 0.0;
  double _dryingProgress = 0.0;

  // Animation states
  // ignore: unused_field
  double _rainPosition = 0.0;
  bool _isRaining = false;
  // ignore: unused_field
  bool _showShoes = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _nextStep() {
    setState(() {
      _isProcessing = true;
      _progressValue = (_currentStep + 1) * 0.2;
    });

    _animationController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 400), () {
        setState(() {
          _isProcessing = false;
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
    _situationAnalyzed = false;
    _rainLevel = 0;
    _wetnessLevel = 0.0;
    _smellLevel = 0.0;
    _dryingProgress = 0.0;
    _rainPosition = 0.0;
    _isRaining = false;
    _showShoes = true;
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

  Widget _buildProgressRow(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _darkPurple,
          ),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 12,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

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
                "👟 Step 1: Understand the Situation",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkPurple,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),

              // Tap instruction hint
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: _accentColor.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: _accentColor, width: 1.2),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.touch_app, color: _primaryColor, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "Tap the cloud to see the consequences!",
                      style: TextStyle(
                        fontSize: 13,
                        color: _darkPurple,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

              // INTERACTIVE RAIN SIMULATION
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isRaining = true;

                    if (_rainLevel < 5) {
                      _rainLevel++;
                      _wetnessLevel = (_rainLevel / 5).clamp(0.0, 1.0);

                      if (_rainLevel >= 3) {
                        _smellLevel = ((_rainLevel - 2) / 3).clamp(0.0, 1.0);
                      }
                    }
                  });

                  Future.delayed(const Duration(seconds: 2), () {
                    setState(() {
                      _isRaining = false;
                    });
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_lightPurple, Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _primaryColor, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: _primaryColor.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                        child: Stack(
                          children: [
                            // SHOES ICON
                            Positioned(
                              bottom: 20,
                              left: MediaQuery.of(context).size.width / 2 - 60,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                child: Image.asset(
                                  'assets/Items/vecteezy_simple-white-shoes-sneakers-vector_11864538.webp',
                                  width: 80,
                                  height: 80,
                                  color: _wetnessLevel > 0.5
                                      ? Colors.blue[800]
                                      : Colors.brown,
                                ),
                              ),
                            ),

                            // CLOUD + RAIN at the top
                            Positioned(
                              top: 0,
                              left: MediaQuery.of(context).size.width / 2 - 80,
                              child: Column(
                                children: [
                                  Icon(
                                    _isRaining
                                        ? Icons.thunderstorm
                                        : Icons.cloud,
                                    size: 50,
                                    color: _isRaining
                                        ? Colors.blueGrey[700]
                                        : Colors.blueGrey[400],
                                  ),
                                  if (_isRaining)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(5, (index) {
                                        return Container(
                                          width: 3,
                                          height: 14,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 3),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.blue[300]!,
                                                Colors.blue[700]!,
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        );
                                      }),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        "Liam left his shoes outside during a rainstorm.",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: _darkPurple,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 15),

                      // RAIN INTENSITY DISPLAY
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _accentColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.water_drop,
                                color: Colors.blue, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              "Rain Intensity: $_rainLevel/5",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _darkPurple,
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (_isRaining)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "🌧️ It's raining!",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // EFFECTS ANALYSIS CARD
              Card(
                elevation: 6,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What happens to shoes in the rain?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkPurple,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // PROGRESS INDICATORS
                      Column(
                        children: [
                          _buildProgressRow(
                              "Wetness Level",
                              _wetnessLevel,
                              _wetnessLevel > 0.5
                                  ? Colors.blue
                                  : Colors.lightBlue),
                          const SizedBox(height: 15),
                          _buildProgressRow("Smell Potential", _smellLevel,
                              _smellLevel > 0.5 ? Colors.brown : Colors.orange),
                          const SizedBox(height: 15),
                          _buildProgressRow("Drying Progress", _dryingProgress,
                              _primaryColor),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightPurple.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _accentColor),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.lightbulb_outline, color: _primaryColor),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Shoes left in rain get wet, may develop odor, and eventually dry out. But do they transform into something else?",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // UNDERSTANDING CHECK
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),

              // NEXT BUTTON
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
                  onPressed: _rainLevel > 0 ? _nextStep : null,
                  child: const Text(
                    "Identify Impossible Outcome ➡️",
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
              horizontalOffset: 50.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              Text(
                "❓ Step 2: What Don't We Know?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkPurple,
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
                      Text(
                        "Which outcome is unlikely or impossible?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkPurple,
                        ),
                      ),
                      const SizedBox(height: 15),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightPurple.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _primaryColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.question_mark, color: _primaryColor),
                                const SizedBox(width: 10),
                                Text(
                                  "The Unknown:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _darkPurple,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "We know shoes in rain get wet, may smell, and dry later. "
                              "But what outcome makes NO sense in reality?",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Cause-Effect Visualization
                      Text(
                        "Rain + Shoes → ? Outcome",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkPurple,
                        ),
                      ),
                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.water_drop, color: Colors.blue),
                                const SizedBox(height: 5),
                                const Text("Rain"),
                              ],
                            ),
                          ),
                          Icon(Icons.add, color: _accentColor, size: 30),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.brown.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.brown),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/Items/vecteezy_simple-white-shoes-sneakers-vector_11864538.webp',
                                  width: 40,
                                  height: 40,
                                ),
                                const SizedBox(height: 5),
                                const Text("Shoes"),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward,
                              color: _accentColor, size: 30),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.help_outline, color: Colors.grey),
                                const SizedBox(height: 5),
                                const Text("?"),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      // Prediction Options
                      Text(
                        "Choose the IMPOSSIBLE outcome:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkPurple,
                        ),
                      ),
                      const SizedBox(height: 15),

                      _buildPredictionOption(
                        "A) His shoes will get wet",
                        "A",
                        false,
                        Icons.water_drop,
                      ),
                      _buildPredictionOption(
                        "B) His shoes might smell bad",
                        "B",
                        false,
                        Icons.smoke_free,
                      ),
                      _buildPredictionOption(
                        "C) His shoes will dry later",
                        "C",
                        false,
                        Icons.wb_sunny,
                      ),
                      _buildPredictionOption(
                        "D) His shoes will turn into gold 💰",
                        "D",
                        true,
                        Icons.attach_money,
                      ),
                    ],
                  ),
                ),
              ),
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
                            ? Colors.green.withOpacity(0.1)
                            : Colors.orange.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    _correctAnswer
                                        ? Icons.check_circle
                                        : Icons.help_outline,
                                    color: _correctAnswer
                                        ? Colors.green
                                        : Colors.orange,
                                    size: 28,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    _correctAnswer
                                        ? "🎯 Logical Thinking!"
                                        : "💭 Think About...",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: _darkPurple,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _correctAnswer
                                    ? "Good! But let's confirm with real-world knowledge."
                                    : _getPredictionFeedback(_selectedAnswer!),
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
                          icon: const Icon(Icons.refresh, color: Colors.white),
                          label: const Text("Try Again"),
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
                      "Apply Real-World Knowledge ➡️",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPredictionOption(
      String text, String option, bool isCorrect, IconData icon) {
    final bool isSelected = _selectedAnswer == option;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAnswer = option;
          _correctAnswer = isCorrect;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect
                  ? Colors.green.withOpacity(0.1)
                  : Colors.orange.withOpacity(0.1))
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? (isCorrect ? Colors.green : Colors.orange)
                : Colors.grey[300]!,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? (isCorrect
                      ? Colors.green.withOpacity(0.2)
                      : Colors.orange.withOpacity(0.2))
                  : Colors.transparent,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? (isCorrect ? Colors.green : Colors.orange)
                    : _lightPurple,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : _darkPurple,
                size: 22,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: _darkPurple,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                isCorrect ? Icons.check_circle : Icons.help,
                color: isCorrect ? Colors.green : Colors.orange,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  String _getPredictionFeedback(String option) {
    switch (option) {
      case "A":
        return "Shoes getting wet is very realistic!";
      case "B":
        return "Wet shoes can definitely smell bad.";
      case "C":
        return "Drying later is perfectly reasonable.";
      default:
        return "Consider what can REALLY happen to shoes.";
    }
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
              horizontalOffset: 50.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              Text(
                "🌍 Step 3: Real-World Knowledge",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkPurple,
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
                      Text(
                        "What do you know about real life?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkPurple,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Real-World Facts Cards
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightPurple.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _primaryColor),
                        ),
                        child: Column(
                          children: [
                            _buildFactCard(
                              "Material Science",
                              "Shoes are made of fabric, leather, or synthetic materials—not magical substances.",
                            ),
                            const SizedBox(height: 15),
                            _buildFactCard(
                              "Water Properties",
                              "Water makes things wet, can cause odors from bacteria, and evaporates over time.",
                            ),
                            const SizedBox(height: 15),
                            _buildFactCard(
                              "Physical Reality",
                              "Objects don't spontaneously change their fundamental composition.",
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.blue),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.science, color: Colors.blue),
                                const SizedBox(width: 10),
                                Text(
                                  "Scientific Fact:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _darkPurple,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Objects maintain their chemical composition unless exposed to specific transformation processes. "
                              "Rainwater cannot transmute materials into gold.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      Text(
                        "Based on real-world knowledge, which is accurate?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkPurple,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Step 3: Option C without emoji so it's not obvious
                      _buildFactOption(
                        "A) Water can turn objects to gold",
                        false,
                      ),
                      _buildFactOption(
                        "B) Rain causes magical transformations",
                        false,
                      ),
                      _buildFactOption(
                        "C) Wet things dry, but don't become gold",
                        true,
                      ),
                      _buildFactOption(
                        "D) Shoes are immune to water effects",
                        false,
                      ),
                    ],
                  ),
                ),
              ),
              if (_confirmationAnswer != null)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    key: ValueKey(_confirmationAnswer),
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: _confirmationAnswer == true
                            ? Colors.green.withOpacity(0.1)
                            : Colors.orange.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    _confirmationAnswer == true
                                        ? Icons.emoji_objects
                                        : Icons.lightbulb_outline,
                                    color: _confirmationAnswer == true
                                        ? Colors.green
                                        : Colors.orange,
                                    size: 28,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    _confirmationAnswer == true
                                        ? "✅ Reality Check!"
                                        : "💡 Check Common \nSense...",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: _darkPurple,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _confirmationAnswer == true
                                    ? "Correct! Real-world knowledge tells us rain affects objects predictably."
                                    : "Think about what actually happens to wet objects in daily life.",
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
                    ],
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
                  onPressed: () {
                    if (_confirmationAnswer == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Select an option first!"),
                          backgroundColor: _primaryColor,
                        ),
                      );
                    } else {
                      _nextStep();
                    }
                  },
                  child: const Text(
                    "Draw Logical Conclusion ➡️",
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

  Widget _buildFactCard(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _primaryColor.withOpacity(0.1),
          ),
          child: Icon(Icons.fact_check, color: Colors.green),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _darkPurple,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFactOption(String text, bool isCorrect) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: _lightPurple.withOpacity(0.5)),
      ),
      color: Colors.white,
      child: ListTile(
        leading: Radio<bool>(
          value: isCorrect,
          groupValue: _confirmationAnswer == isCorrect ? isCorrect : null,
          onChanged: (value) {
            setState(() {
              _confirmationAnswer = isCorrect;
            });
          },
          activeColor: _primaryColor,
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: _darkPurple,
          ),
        ),
        tileColor: _confirmationAnswer == isCorrect
            ? (isCorrect
                ? Colors.green.withOpacity(0.1)
                : Colors.orange.withOpacity(0.1))
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildStep4() {
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
                "⚡ Step 4: Cause and Effect Logic",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkPurple,
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
                      Text(
                        "Rain → Shoes Process:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkPurple,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Process Timeline
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightPurple.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _primaryColor),
                        ),
                        child: Column(
                          children: [
                            _buildProcessStep(
                                1, "Shoes in rain", Icons.water_drop),
                            const SizedBox(height: 10),
                            _buildProcessStep(2, "Get wet", Icons.waves),
                            const SizedBox(height: 10),
                            _buildProcessStep(
                                3, "May develop odor", Icons.smoke_free),
                            const SizedBox(height: 10),
                            _buildProcessStep(
                                4, "Eventually dry", Icons.wb_sunny),
                            const SizedBox(height: 10),
                            _buildProcessStep(
                                5, "Return to normal", Icons.sports_soccer),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.green, width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.link, color: Colors.green),
                                const SizedBox(width: 10),
                                Text(
                                  "Logical Connection:",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: _darkPurple,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "Turning into gold breaks cause-and-effect. "
                              "This is the most illogical outcome based on physics and everyday experience.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Updated question label
                      Text(
                        "What is the least likely outcome?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkPurple,
                        ),
                      ),
                      const SizedBox(height: 15),

                      _buildFinalOption(
                        "A) His shoes will get wet",
                        "A",
                        false,
                      ),
                      _buildFinalOption(
                        "B) His shoes might smell bad",
                        "B",
                        false,
                      ),
                      _buildFinalOption(
                        "C) His shoes will dry later",
                        "C",
                        false,
                      ),
                      // Option D without emoji
                      _buildFinalOption(
                        "D) His shoes will turn into gold",
                        "D",
                        true,
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
                    backgroundColor: _primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                  ),
                  onPressed: _selectedAnswer == "D" ? _nextStep : null,
                  child: const Text(
                    "Reveal Final Analysis ➡️",
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

  Widget _buildProcessStep(int number, String text, IconData icon) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _primaryColor,
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Icon(icon, color: _accentColor),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFinalOption(String text, String option, bool isCorrect) {
    final bool isSelected = _selectedAnswer == option;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: isSelected
          ? (isCorrect
              ? Colors.green.withOpacity(0.1)
              : Colors.orange.withOpacity(0.1))
          : Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          setState(() {
            _selectedAnswer = option;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? (isCorrect ? Colors.green : Colors.orange)
                      : _lightPurple,
                  border: Border.all(color: _primaryColor),
                ),
                child: Center(
                  child: Text(
                    option.replaceAll(")", ""),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : _darkPurple,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  isCorrect ? Icons.check_circle : Icons.cancel,
                  color: isCorrect ? Colors.green : Colors.orange,
                  size: 24,
                ),
            ],
          ),
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
            "🏁 Final Analysis",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _darkPurple,
            ),
          ),

          _buildProgressIndicator(),
          const SizedBox(height: 16),

          // ----------- CARD PRINCIPAL ----------------
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
                  // TITULO RESPUESTA
                  Text(
                    "✔ Final Answer:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // RESPUESTA
                  Text(
                    "D) His shoes will turn into gold 💰",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkPurple,
                    ),
                    textAlign: TextAlign.left,
                  ),

                  const Divider(height: 32),

                  // TITULO EXPLICACIÓN
                  Text(
                    "Explanation:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkPurple,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // LISTA EXPLICATIVA
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        color: _darkPurple,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(
                          text:
                              "Based on real-world knowledge, shoes left in a rainstorm can get wet, smell, or dry later—but they cannot magically turn into gold. 💰\n\n",
                        ),
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(
                          text:
                              "Getting wet is realistic, smelling bad is plausible, and drying later is reasonable—but turning into gold is impossible.\n\n",
                        ),
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(
                          text:
                              "The cause-and-effect relationship between rain exposure and material properties makes this the most illogical outcome.",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ----------- BOTÓN FINAL ----------------
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.arrow_forward, color: Colors.white),
              label: const Text(
                "Continue to Practice",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
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
              onPressed: _completeActivity,
            ),
          ),
        ],
      ),
    );
  }

  void _completeActivity() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ThirdActyvityAnimation()),
    );
    setState(() {
      _currentStep = 0;
      _progressValue = 0.2;
      _resetInteractiveStates();
    });
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
            child: Column(
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: _buildCurrentStep(),
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

  // Variables para el efecto del bombillo de inactividad
  Timer? _inactivityTimer;
  bool _isInactive = false;
  late AnimationController _glowController;

  final List<String> hints1 = [
    '💡 General: What are the typical, physical possibilities when kicking a ball toward a goal?',
    '📌 More Specific: Is it physically possible for a soccer ball to instantly change into a pumpkin?',
  ];

  final List<String> hints2 = [
    '💡 General: What are the usual consequences of low blood sugar (from skipping breakfast)?',
    '📌 More Specific: Does skipping a meal typically cause fatigue and hunger or sudden, magical intelligence?',
  ];

  final List<String> hints3 = [
    '💡 General: What are the normal, gradual changes that occur when ice is exposed to heat?',
    '📌 More Specific: Will ice cubes melt and turn to water, or will they violently explode?',
  ];

  final List<String> hints4 = [
    '💡 General: What happens to dairy products when they are left out at room temperature?',
    '📌 More Specific: Will warm milk spoil and become unsafe, or will it transform into a dessert?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "A boy kicked a soccer ball hard toward the goal.\nWhich option is the error (unlikely outcome)?",
      "options": [
        "A) The ball might go into the goal",
        "B) The ball might miss the goal",
        "C) The ball might hit the goalkeeper",
        "D) The ball might turn into a pumpkin"
      ],
      "correctIndex": 3,
      "feedback": [
        "Incorrect: Scoring a goal is common in soccer.",
        "Incorrect: Missing the goal is normal in soccer.",
        "Incorrect: Balls can hit the goalkeeper.",
        "Explanation: Kicking can score, miss, or be blocked — but balls don’t turn into pumpkins.",
      ]
    },
    {
      "question":
          "A student forgot to eat breakfast before school.\nWhich option is the error (unlikely outcome)?",
      "options": [
        "A) The student might feel hungry",
        "B) The student will instantly know all the answers",
        "C) The student might feel tired",
        "D) The student might lose focus"
      ],
      "correctIndex": 1,
      "feedback": [
        "incorrect: Hunger is a typical result of skipping meals.",
        "Explanation: Skipping breakfast often leads to hunger, low energy, or loss of focus — not instant genius.",
        "Incorrect: Feeling tired is a common consequence.",
        "Incorrect: Losing focus is expected when skipping breakfast."
      ]
    },
    {
      "question":
          "A family left ice cubes outside on the porch in summer.\nWhich option is the error (unlikely outcome)?",
      "options": [
        "A) The ice cubes will explode into fireworks",
        "B) The ice cubes will turn into water",
        "C) The ice cubes might evaporate over time",
        "D) The ice cubes will melt"
      ],
      "correctIndex": 0,
      "feedback": [
        "Explanation: Ice melts into water and eventually evaporates, but it won’t explode into fireworks.",
        "Incorrect: Ice turning into water is normal.",
        "Incorrect: Ice can evaporate after melting.",
        "Incorrect: Melting is the expected outcome."
      ]
    },
    {
      "question":
          "Mia left a glass of milk on the kitchen counter all day.\nWhich option is the error (unlikely outcome)?",
      "options": [
        "A) The milk might spoil",
        "B) The milk could smell bad",
        "C) The milk might make someone sick if they drink it",
        "D) The milk will turn into a chocolate cake"
      ],
      "correctIndex": 3,
      "feedback": [
        "Incorrect: Milk spoiling is common.",
        "Incorrect: Spoiling is expected.",
        "Incorrect: Bad smell is normal when milk spoils.",
        "Explanation: Milk can spoil, smell, and cause sickness if left out — but it won’t magically become cake.",
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
              backgroundColor: const Color(0xFFF3E5F5),
              titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              title: Row(
                children: const [
                  Icon(Icons.emoji_events, color: Color(0xFF7B1FA2), size: 30),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Level Complete!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4A148C),
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
                      color: Color(0xFF7B1FA2),
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
                    foregroundColor: const Color(0xFF7B1FA2),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  label: const Text("Advance"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B1FA2),
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
      backgroundColor: const Color(0xFFF3E5F5),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF3E5F5), // lila muy claro
              Color(0xFFE1BEE7), // lavanda suave
              Color(0xFFCE93D8), // lila medio
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
                      backgroundColor: const Color(0xFFCE93D8),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF7B1FA2)),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    "Choose the right option",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A148C),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Card de pregunta
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFE1BEE7),
                          Color(0xFFF3E5F5),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: const Color(0xFF9C27B0).withOpacity(0.4)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF9C27B0).withOpacity(0.15),
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
                        color: Color(0xFF4A148C),
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
                                  ? const Color(0xFFE1BEE7)
                                  : Colors.red.shade100)
                              : Colors.white,
                          foregroundColor: const Color(0xFF4A148C),
                          disabledBackgroundColor: selectedOptionIndex == i
                              ? (i == correctIndex
                                  ? const Color(0xFFE1BEE7)
                                  : Colors.red.shade100)
                              : Colors.white.withOpacity(0.7),
                          disabledForegroundColor: selectedOptionIndex == i
                              ? (i == correctIndex
                                  ? const Color(0xFF4A148C)
                                  : Colors.red.shade700)
                              : Colors.black45,
                          minimumSize: const Size.fromHeight(52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: BorderSide(
                              color: selectedOptionIndex == i
                                  ? (i == correctIndex
                                      ? const Color(0xFF7B1FA2)
                                      : Colors.red)
                                  : const Color(0xFF9C27B0).withOpacity(0.3),
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
                                ? const Color(0xFFE1BEE7)
                                : Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selectedOptionIndex == correctIndex
                                  ? const Color(0xFF7B1FA2)
                                  : Colors.red.shade300,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            selectedOptionIndex == correctIndex
                                ? "✩ ${feedback[selectedOptionIndex!]}"
                                : "❌ ${feedback[selectedOptionIndex!]}",
                            style: TextStyle(
                              fontSize: 18,
                              height: 1.5,
                              color: selectedOptionIndex == correctIndex
                                  ? const Color(0xFF4A148C)
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
                                      ? const Color(0xFF7B1FA2)
                                      : const Color(0xFFE1BEE7),
                              foregroundColor:
                                  selectedOptionIndex == correctIndex
                                      ? Colors.white
                                      : const Color(0xFF4A148C),
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
                                            color: const Color(0xFF9C27B0)
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
                                      ? const Color(0xFF9C27B0)
                                      : const Color(0xFFCE93D8),
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
                                    color: const Color(0xFF9C27B0), width: 1.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF9C27B0)
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
                                        color: Color(0xFF4A148C),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close,
                                        size: 20, color: Color(0xFF7B1FA2)),
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

    await FirebaseFirestore.instance
        .collection('userProgress')
        .doc(user.uid)
        .set({'completedInstructionSpot5_1': true}, SetOptions(merge: true));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('spotCompletado', true);

    await _saveProgressToCloud(user);

    // ⭐ Previene el error de contexto desmontado
    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (route) => false,
    );
  }

  Future<void> _saveProgressToCloud(User user) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('userProgress').doc(user.uid).set({
      'completedInstructionSpot5_1': true,
      'completedSpotsCount': FieldValue.increment(1),
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    const Color purpleDark = Color(0xFF6A1B9A);
    const Color purple = Color(0xFF9C4DCC);
    const Color purpleAccent = Color(0xFFD500F9);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF3E5F5),
              Color(0xFFE1BEE7),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icono con glow
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: purpleAccent.withOpacity(0.4),
                      blurRadius: 24,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.emoji_events,
                  size: 110,
                  color: purpleAccent,
                ),
              ),

              const SizedBox(height: 24),

              // Card del texto
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: purpleDark.withOpacity(0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                  border: Border.all(
                    color: purple.withOpacity(0.25),
                    width: 1.5,
                  ),
                ),
                child: const Text(
                  'To sum up...\n\n'
                  ' predicting outcomes means using past events and cause-and-effect reasoning to guess what will happen next. By applying common sense and real-world knowledge, we can infer results that writers don’t directly state.',
                  style: TextStyle(
                    fontSize: 17,
                    color: purple,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 36),

              // Botón más pro
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
                    backgroundColor: purpleDark,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    elevation: 10,
                    shadowColor: purpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
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
