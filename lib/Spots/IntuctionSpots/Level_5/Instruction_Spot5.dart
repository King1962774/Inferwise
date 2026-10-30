// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_5/Animations.dart';
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
      'title': '⚔️  Title: "The Brave Little Soldier"',
      'image': 'assets/Imagenes de ejemplos/Level5/5.1 A Soldier.webp',
      'text':
          '⚛️ Contextual Inference: He will face danger and win the battle.',
    },
    {
      'title': '🏆  Subtitle: "How Maria Became a Champion"',
      'image': 'assets/Imagenes de ejemplos/Level5/5.1 B Maria.webp',
      'text':
          '⚛️ Contextual Inference: The story will show Maria winning a competition.',
    },
    {
      'title': '🔦  Character: a curious young boy exploring a cave',
      'image': 'assets/Imagenes de ejemplos/Level5/5.1 C Young boy.webp',
      'text':
          '⚛️ Contextual Inference: He will discover something hidden or important.',
    },
    {
      'title': '🚂  Genre: Romance — "Two Strangers on a Train"',
      'image': 'assets/Imagenes de ejemplos/Level5/5.1 D Train.webp',
      'text':
          '⚛️ Contextual Inference: The strangers will fall in love by the end.',
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
      MaterialPageRoute(builder: (context) => const MoreInfoPage2()),
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
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF7C3AED),
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
                      "Predicting Content",
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
                    'Readers figure out what will probably happen in a story by using clues such as the title, subtitle, character traits (age, role, personality), and the genre (horror, sci-fi, romance, fable, etc.). These signals often guide the reader to expect a certain type of ending. ',
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

class MoreInfoPage2 extends StatefulWidget {
  const MoreInfoPage2({super.key});

  @override
  State<MoreInfoPage2> createState() => _MoreInfoPage2State();
}

class _MoreInfoPage2State extends State<MoreInfoPage2> {
  int _visibleCount = 0;
  final PageController _pageController = PageController();
  // ignore: unused_field
  int _currentPage = 0;

  final List<Map<String, String>> examples = [
    {
      'title': '💰  Subtitle: "The Fall of the Dishonest Merchant"',
      'image': 'assets/Imagenes de ejemplos/Level5/5.1 E Merchant.webp',
      'text':
          '💟Contextual Inference: The merchant’s dishonesty will eventually cause his downfall.',
    },
    {
      'title': '👑  Character: a greedy king who wants more and more',
      'image': 'assets/Imagenes de ejemplos/Level5/5.1 F King.webp',
      'text':
          '💟 Contextual Inference: He will be punished or lose what he has.',
    },
    {
      'title': '👻  Genre: Horror — "The Haunted House"',
      'image': 'assets/Imagenes de ejemplos/Level5/5.1 G House.webp',
      'text':
          '💟 Contextual Inference: A character will encounter ghosts or a terrifying secret.',
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
                "More examples",
                style: TextStyle(
                  fontSize: 18,
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
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
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
                      "Predicting Content",
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
  final List<Map<String, String>> examples = [
    {
      'title': '',
      'text': '⚛️ Titles and subtitles tell you the theme or focus.',
    },
    {
      'title': '',
      'text': '⚛️ Character roles suggest what the person is likely to do.',
    },
    {
      'title': '',
      'text':
          '⚛️ Genre sets the rules of the world (in horror, expect danger; in comedy, expect a funny twist; in fables, expect a moral).',
    },
    {
      'title': '',
      'text':
          'Recognizing all of these clues helps you make accurate predictions — but also notice when a story breaks the pattern.',
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

  Widget _buildCard(String title, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text,
                style: const TextStyle(fontSize: 14, color: Colors.black87)),
          ],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Predicting Content",
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
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: const Color(0xFF7C3AED).withOpacity(0.2)),
                  ),
                  child: const Text(
                    'Special note:\n✨ Titles, subtitles, character roles, and genre often work together to give you strong hints.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: examples
                        .map((example) =>
                            _buildCard(example['title']!, example['text']!))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: _goToNextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA855F7),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      foregroundColor: Colors.white,
                      elevation: 2,
                    ),
                    child: const Text(
                      "Continue",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
      'title': 'Look at the title or clue',
      'text': '"Never stopped climbing" → persistence and challenge.',
    },
    {
      'label': 'Step 2',
      'title': 'Notice the genre',
      'text': 'Adventure stories usually end with triumph after hardship.',
    },
    {
      'label': 'Step 3',
      'title': 'Connect it to character role',
      'text':
          'A girl as the central hero → likely to succeed through determination.',
    },
    {
      'label': 'Step 4',
      'title': 'Predict the ending',
      'text':
          'Most likely, the girl will reach the top of the mountain or achieve her dream.',
    },
    {
      'label': 'Final Answer',
      'title': 'Contextual Inference',
      'text':
          'The girl will succeed because the title, character role, and genre (adventure) signal perseverance leading to victory.',
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
        // Mismo degradado del sistema de diseño
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
                    // Close button
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
                        TextSpan(
                            text:
                                'Let\'s make a Predicting Content about:\n\n'),
                        TextSpan(
                          text:
                              '"The Girl Who Never Stopped Climbing — Genre: Adventure"',
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

                const SizedBox(height: 16),

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

                const SizedBox(height: 6),

                // Step counter label

                const SizedBox(height: 14),

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
                                      Color(0xFFDDD6FE)
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

                              // Step text
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
                                ' Back',
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
                              isLast ? 'Continue ' : 'Next  ',
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
                    color: const Color.fromARGB(255, 255, 255, 255),
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
              // ── Header (reemplaza AppBar) ────────────────────────
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
                            "Readers figure out what will probably happen "
                            "in a story by connecting clues such as the title, subtitle, character roles, "
                            "or genre to what you already know about common story patterns.",
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
                          emoji: '🏝️',
                          title: 'Title: "The Last Treasure of the Island"',
                          inference:
                              'Someone will discover the hidden treasure by the end.',
                        ),
                        _buildExample(
                          emoji: '🤝',
                          title: 'Subtitle: "Why Daniel Chose Forgiveness"',
                          inference:
                              'Daniel will forgive someone who wronged him.',
                        ),
                        _buildExample(
                          emoji: '👩‍👧',
                          title:
                              'Character: A brave mother protecting her children',
                          inference:
                              'She will sacrifice or act heroically to save them.',
                        ),
                        _buildExample(
                          emoji: '🚀',
                          title: 'Genre: Sci-Fi — "The Last Colony on Mars"',
                          inference:
                              'The characters will struggle to survive in a futuristic or alien environment.',
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
                            "💡 Also: Sometimes the outcome isn't directly mentioned because it's assumed you can recognize the pattern. "
                            "If more than one ending is possible, choose the most likely based on context.",
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
                    '☑ $inference',
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

  final List<Map<String, String>> steps = const [
    {
      'icon': '🔍',
      'text':
          'Identify the main clue (title, subtitle, character role, or genre).',
    },
    {
      'icon': '💡',
      'text': 'Think of the typical outcomes connected with that clue.',
    },
    {
      'icon': '🔎',
      'text':
          'Look for extra context (words like brave, greedy, haunted, final).',
    },
    {
      'icon': '📖',
      'text':
          'Use story-world knowledge — what usually happens in that type of story?',
    },
    {
      'icon': '✅',
      'text':
          'State your inference clearly. If uncertain, say "most likely" or give alternatives.',
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
                      // Quick tip card
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
                              child: const Text('⚡',
                                  style: TextStyle(fontSize: 18)),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Quick tip: If new details appear later, update your inference — contextual inferences are predictions, not guarantees.',
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

                      // ── Step list ────────────────────────────────
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
                            final step = steps[i];
                            final isLast = i == steps.length - 1;
                            return Column(
                              children: [
                                _buildStepRow(
                                  number: i + 1,
                                  icon: step['icon']!,
                                  text: step['text']!,
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
                          'Continue ',
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
        // Number + icon circle
        Column(
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
          ],
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
        'Title: “The Lost Treasure of Atlantis”\n\nWhere will the story most likely lead?',
    options: [
      "A) The characters lose an ancient treasure",
      "B) The characters discover an ancient treasure",
      "C) The characters build Atlantis",
      "D) The characters win all Atlantis' treasures"
    ],
    correctIndex: 1,
    explanation:
        '✔️ Correct! Based on the title “The Lost Treasure of Atlantis,” the most likely outcome is that the characters will discover an ancient treasure. Titles often hint at the central goal of the story.',
    incorrectExplanations: [
      'A) Incorrect',
      'B) Correct — the treasure fits the context of the title.',
      'C) Incorrect',
      'D) Incorrect',
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
  String? _activeKeywordHint;

  // ── Design tokens (pastel purple system) ──────────────────────
  static const Color _primary = Color(0xFF7C3AED);
  static const Color _dark = Color(0xFF5B21B6);
  static const Color _deepDark = Color(0xFF4C1D95);
  static const Color _accent = Color(0xFFA855F7);
  static const Color _pastel1 = Color(0xFFEDE9FE);
  static const Color _pastel2 = Color(0xFFDDD6FE);
  static const Color _pastel3 = Color(0xFFF3E8FF);
  static const Color _textBody = Color(0xFF4C1D95);

  List<String> selectedKeywords = [];

  final Map<String, String> keywordHints = {
    "Lost": "Means something hidden, missing, or forgotten.",
    "Treasure": "Refers to something valuable or precious.",
    "Atlantis": "A legendary ancient city believed to have sunk into the sea.",
  };

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
    setState(() {
      _isProcessing = false;
      _progressValue = (_currentStep + 1) * 0.2;
      if (_currentStep < 4) {
        _currentStep++;
        _selectedAnswer = null;
        _correctAnswer = false;
        _confirmationAnswer = null;
      } else {
        _completeActivity();
      }
    });
  }

  void _completeActivity() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Second()),
    );
    setState(() {
      _currentStep = 0;
      _progressValue = 0.2;
      _selectedAnswer = null;
      _correctAnswer = false;
      _confirmationAnswer = null;
    });
  }

  // ── Shared widgets ─────────────────────────────────────────────

  Widget _buildProgressBar() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        return ClipRRect(
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
        );
      },
    );
  }

  Widget _sectionTitle(String text) {
    final parts = text.split(' ');
    final emoji = parts.first;
    final rest = parts.skip(1).join(' ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                emoji,
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(width: 6),
              ShaderMask(
                shaderCallback: (b) => const LinearGradient(
                  colors: [_dark, _accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(b),
                child: Text(
                  rest,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'How to solve it',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.70),
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  // Glass-white content card
  Widget _glassCard({required Widget child, EdgeInsets? padding}) => Container(
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
        padding: padding ?? const EdgeInsets.all(20),
        child: child,
      );

  // Pastel info box
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

  // ── STEP 1 ─────────────────────────────────────────────────────
  // Title: The Lost Treasure of Atlantis
  // Question: What is the title mainly about?
  Widget _buildStep1() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 450),
            childAnimationBuilder: (w) => SlideAnimation(
              horizontalOffset: 40,
              child: FadeInAnimation(child: w),
            ),
            children: [
              _sectionTitle("📖 Step 1: Read the Title"),
              _buildProgressBar(),
              const SizedBox(height: 16),
              _glassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title display
                    _infoBox(
                      child: const Text(
                        'Title: "The Lost Treasure of Atlantis"',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: _deepDark,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Tap keywords
                    const Text(
                      "Tap the key words in the title:",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: _textBody,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _buildKeywordButton("Lost"),
                        _buildKeywordButton("Treasure"),
                        _buildKeywordButton("Atlantis"),
                      ],
                    ),

                    // ── Keyword hint card (animated) ──
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: _activeKeywordHint != null
                          ? _buildKeywordHintCard(_activeKeywordHint!)
                          : const SizedBox.shrink(),
                    ),

                    const SizedBox(height: 20),

                    // ── QUESTION ──
                    const Text(
                      "What is the title mainly about?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _deepDark,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 14),

                    _buildStep1Option(
                      "A",
                      "A modern treasure found near the ocean.",
                      false,
                      Icons.water,
                    ),
                    _buildStep1Option(
                      "B",
                      "A hidden treasure from the ancient city of Atlantis.",
                      true,
                      Icons.auto_awesome,
                    ),
                    _buildStep1Option(
                      "C",
                      "A treasure owned by a famous explorer.",
                      false,
                      Icons.explore,
                    ),
                    _buildStep1Option(
                      "D",
                      "A treasure used in daily life in Atlantis.",
                      false,
                      Icons.home,
                    ),

                    const SizedBox(height: 16),

                    // Feedback
                    if (_selectedAnswer != null) ...[
                      _buildFeedbackBox(
                        isCorrect: _correctAnswer,
                        correctText:
                            'The phrase "lost treasure" indicates something valuable that is missing, and "Atlantis" refers to a legendary ancient city — so the title is mainly about a hidden treasure connected to Atlantis.',
                        wrongText: _getStep1Feedback(_selectedAnswer!),
                      ),
                      const SizedBox(height: 16),
                      if (!_correctAnswer)
                        _primaryButton("Try Again ↩", () {
                          setState(() => _selectedAnswer = null);
                        }),
                    ],

                    if (_correctAnswer)
                      _primaryButton(
                        "Continue  →",
                        selectedKeywords.isNotEmpty ? _nextStep : null,
                      ),

                    if (_selectedAnswer == null)
                      _primaryButton(
                        "Continue  →",
                        null,
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

  /// Card debajo de los keyword buttons que muestra el hint de la palabra activa.
  /// AnimatedSwitcher hace fade + slide al cambiar de palabra.
  Widget _buildKeywordHintCard(String word) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 280),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.12),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
        child: Container(
          key: ValueKey(word), // dispara AnimatedSwitcher al cambiar palabra
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_dark, _accent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: _primary.withOpacity(0.22),
                blurRadius: 12,
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
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.tips_and_updates,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '"$word"',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      keywordHints[word] ?? "",
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: Colors.white,
                        height: 1.5,
                      ),
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

  Widget _buildStep1Option(
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
                color: isSelected
                    ? Colors.white
                    : null, // ✅ null = color natural del ícono
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

  String _getStep1Feedback(String option) {
    switch (option) {
      case "A":
        return "The title doesn't mention anything modern — Atlantis is an ancient legendary city.";
      case "C":
        return "There's no mention of a famous explorer in the title.";
      case "D":
        return "The treasure is described as 'lost', not as something used in daily life.";
      default:
        return "Think carefully about each word in the title.";
    }
  }

  Widget _buildKeywordButton(String word) {
    final isSelected = selectedKeywords.contains(word);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            // Deseleccionar: quitar keyword y ocultar hint si era el activo
            selectedKeywords.remove(word);
            if (_activeKeywordHint == word) _activeKeywordHint = null;
          } else {
            // Seleccionar: agregar keyword y mostrar su hint card
            selectedKeywords.add(word);
            _activeKeywordHint = word;
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [_dark, _accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.transparent : _pastel2,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? _primary.withOpacity(0.25)
                  : Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          word,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : _dark,
          ),
        ),
      ),
    );
  }

  // ── STEP 2 ─────────────────────────────────────────────────────
  Widget _buildStep2() {
    return AnimationLimiter(
      child: SingleChildScrollView(
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
              _sectionTitle("🤔 Step 2: Make Predictions"),
              _buildProgressBar(),
              const SizedBox(height: 16),
              _glassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Based on the title, what will probably happen?",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: _deepDark,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _infoBox(
                      child: const Text(
                        "Remember: Titles give clues about the story's content. "
                        "Think about what makes sense with 'Lost Treasure' and 'Atlantis'.",
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.55,
                          color: _textBody,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildPredictionOption(
                      "A) The characters lose an ancient treasure",
                      "A",
                      false,
                      Icons.search_off,
                    ),
                    _buildPredictionOption(
                      "B) The characters discover an ancient treasure",
                      "B",
                      true,
                      Icons.auto_awesome,
                    ),
                    _buildPredictionOption(
                      "C) The characters build Atlantis",
                      "C",
                      false,
                      Icons.construction,
                    ),
                    _buildPredictionOption(
                      "D) The characters win all Atlantis' treasures",
                      "D",
                      false,
                      Icons.emoji_events,
                    ),
                    const SizedBox(height: 16),
                    if (_selectedAnswer != null)
                      _buildFeedbackBox(
                        isCorrect: _correctAnswer,
                        correctText:
                            "A treasure hunt fits perfectly with the clues in the title.",
                        wrongText: _getPredictionFeedback(_selectedAnswer!),
                      ),
                    if (_selectedAnswer != null && !_correctAnswer) ...[
                      const SizedBox(height: 14),
                      _primaryButton("Try Again ↩", () {
                        setState(() => _selectedAnswer = null);
                      }),
                    ],
                    if (_correctAnswer) ...[
                      const SizedBox(height: 14),
                      _primaryButton("Continue  →", _nextStep),
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
        return "Losing a treasure is the opposite of what the title hints — 'Lost' describes the treasure's current state, not the outcome.";
      case "C":
        return "Building Atlantis doesn't match 'Lost Treasure' — the story is about finding something, not building.";
      case "D":
        return "Winning all treasures is too extreme compared to what the title suggests.";
      default:
        return "Think about what makes sense with the clues given.";
    }
  }

  // ── STEP 3 ─────────────────────────────────────────────────────
  Widget _buildStep3() {
    return AnimationLimiter(
      child: SingleChildScrollView(
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
              _sectionTitle("🔍 Step 3: Connect to Real\nKnowledge"),
              _buildProgressBar(),
              const SizedBox(height: 16),
              _glassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "What do you know about these concepts?",
                      style: TextStyle(
                        fontSize: 17,
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
                          Row(
                            children: [
                              Icon(Icons.history_edu, color: _accent, size: 20),
                              const SizedBox(width: 8),
                              const Text(
                                "Atlantis Facts:",
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
                            "• Mythical island first mentioned by Plato\n"
                            "• Said to be a powerful civilization that sank\n"
                            "• Often associated with advanced technology\n"
                            "• Many believe it holds hidden treasures",
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.55,
                              color: _textBody,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      "Which statement best uses your real-world knowledge?",
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w600,
                        color: _textBody,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildKnowledgeOption(
                        "Atlantis is a real city we can visit today", false),
                    _buildKnowledgeOption(
                        "Atlantis is a fictional place from mythology", true),
                    _buildKnowledgeOption(
                        "Atlantis is a type of treasure chest", false),
                    _buildKnowledgeOption(
                        "Atlantis is a sports team name", false),
                    const SizedBox(height: 16),
                    if (_confirmationAnswer != null)
                      _buildFeedbackBox(
                        isCorrect: _confirmationAnswer == true,
                        correctText:
                            "Knowing Atlantis is mythological helps predict a fictional adventure story.",
                        wrongText:
                            "Remember: Atlantis is from ancient Greek legends.",
                      ),
                    const SizedBox(height: 14),
                    _primaryButton(
                      _confirmationAnswer == null
                          ? "Check Answer"
                          : "Continue  →",
                      () {
                        if (_confirmationAnswer == null) {
                          setState(() => _confirmationAnswer = true);
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

  Widget _buildKnowledgeOption(String text, bool isCorrect) {
    final bool isSelected =
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
        child: Row(
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
                  ? Icon(
                      isCorrect ? Icons.check : Icons.close,
                      size: 13,
                      color: Colors.white,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
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
  Widget _buildStep4() {
    return AnimationLimiter(
      child: SingleChildScrollView(
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
              _sectionTitle("🧩 Step 4: Logical Reasoning"),
              _buildProgressBar(),
              const SizedBox(height: 16),
              _glassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Putting all the clues together:",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: _deepDark,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _infoBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.psychology, color: _accent, size: 20),
                              const SizedBox(width: 8),
                              const Text(
                                "Clue Analysis:",
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
                            "• 'Lost Treasure' = adventure, discovery\n"
                            "• 'Atlantis' = mythology, ancient civilization\n"
                            "• Together = story about searching for something valuable",
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.55,
                              color: _textBody,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      "What's the most logical outcome?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _deepDark,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _infoBox(
                      child: const Text(
                        "The title suggests mythology, mystery, and a mission. "
                        "Therefore, discovering the treasure is the most logical outcome.",
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.55,
                          color: _textBody,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Horizontal clue cards
                    SizedBox(
                      height: 128,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildClueCard(
                              "📚", "Mythology", "Atlantis is mythical"),
                          const SizedBox(width: 12),
                          _buildClueCard(
                              "💎", "Treasure", "Something valuable"),
                          const SizedBox(width: 12),
                          _buildClueCard("🔍", "Lost", "Needs to be found"),
                          const SizedBox(width: 12),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _primaryButton("See Final Answer  →", _nextStep),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClueCard(String emoji, String title, String desc) => Container(
        width: 110,
        decoration: BoxDecoration(
          color: _pastel1,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _pastel2, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: _primary.withOpacity(0.10),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: _dark,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              desc,
              style: const TextStyle(fontSize: 11, color: _textBody),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );

  // ── STEP 5 — untouched content, upgraded design ─────────────────
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
                    "B) The characters discover an ancient treasure",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _dark,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 1.5,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_pastel2, _pastel3],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
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
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14.5,
                      color: _textBody,
                      height: 1.6,
                    ),
                    children: [
                      const TextSpan(text: "• "),
                      const TextSpan(
                        text:
                            "The title includes words such as 'Lost', 'Treasure' and 'Atlantis', which strongly suggest an adventure theme.\n\n",
                      ),
                      const TextSpan(text: "• "),
                      const TextSpan(
                        text:
                            "Atlantis is associated with mythical secrets and hidden discoveries.\n\n",
                      ),
                      const TextSpan(text: "• "),
                      const TextSpan(
                        text:
                            "Logically, the scenario most consistent with the clues is that the characters discover an ancient treasure.",
                      ),
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

  // ── Shared feedback box ─────────────────────────────────────────
  Widget _buildFeedbackBox({
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
              // ── Header ────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.55), width: 1),
                      ),
                      child: Text(
                        'Step ${_currentStep + 1} of 5',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: _deepDark,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
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
    '💡 General Hint: Think about what the word “Last” suggests.',
    '📌 More Specific: Does a title about the “final” dragon usually imply discovery or conflict?',
  ];
  final List<String> hints2 = [
    '💡 General Hint: What kind of situation requires someone to find courage?',
    '📌 More Specific: Does the subtitle suggest avoidance or facing a fear?',
  ];
  final List<String> hints3 = [
    '💡 General Hint: What is the usual purpose of a key in a mystery story?',
    '📌 More Specific: Does the “mystery” suggest the key unlocks something important?',
  ];
  final List<String> hints4 = [
    '💡 General Hint: What does the word “Fall” usually imply in a city or kingdom context?',
    '📌 More Specific: Does “Fall” suggest destruction, collapse, or victory?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Title: “The Last Dragon of the Kingdom”\nWhat will most likely happen?",
      "options": [
        "A) The dragon is discovered or defeated",
        "B) The dragon opens a store",
        "C) The dragon joins a soccer team",
        "D) The dragon moves to another planet"
      ],
      "correctIndex": 0,
      "feedback": [
        "Explanation: The word “Last” signals conflict or discovery about the final remaining dragon.",
        "Incorrect: Dragons opening stores is not typical in fantasy stories.",
        "Joining a soccer team does not fit the fantasy genre context.",
        "Moving to another planet is unlikely in a medieval-style fantasy setting."
      ]
    },
    {
      "question":
          "Subtitle: “How Ben Found His Courage”\nWhat will most likely happen?",
      "options": [
        "A) Ben becomes a great athlete",
        "B) Ben runs away from all his problems",
        "C) Ben faces a challenge bravely",
        "D) Ben becomes a teacher"
      ],
      "correctIndex": 2,
      "feedback": [
        "Correct: This is the best prediction.",
        "Running away does not match the idea of 'finding courage'.",
        "Explanation: The subtitle hints that the story is about courage and overcoming fear.",
        "Becoming a teacher is unrelated to the theme of courage."
      ]
    },
    {
      "question":
          "Title: “The Mystery of the Silver Key”\nWhat will most likely happen?",
      "options": [
        "A) The key opens something important ",
        "B) The key is thrown away",
        "C) The key turns into food",
        "D) The key is lost forever"
      ],
      "correctIndex": 0,
      "feedback": [
        "Explanation: In mystery stories, keys usually unlock something significant.",
        "Throwing away a key contradicts the idea of a 'mystery'.",
        "Keys do not typically turn into food in stories.",
        "Losing the key forever would not resolve the mystery."
      ]
    },
    {
      "question":
          "Subtitle: “The Fall of the Iron City”\nWhat will likely happen?",
      "options": [
        "A) The city becomes very rich",
        "B) The city collapses or is destroyed",
        "C) The city is rebuilt stronger",
        "D) The city wins a contest"
      ],
      "correctIndex": 1,
      "feedback": [
        "Inconrrect: Becoming rich contradicts the idea of a 'fall'.",
        "Explanation: The term “Fall” in a city or kingdom usually signals collapse, loss, or destruction.",
        "Becoming rich contradicts the idea of a 'fall'.",
        "Rebuilding happens *after* a fall, not before."
      ]
    }
  ];

// ── Colores morados (reemplaza los naranjas) ──────────────────────────
// Primary:    0xFF7B1FA2  (morado oscuro)
// Light:      0xFFE1BEE7  (lavanda claro)
// Dark:       0xFF4A148C  (morado muy oscuro)
// Accent:     0xFF9C27B0  (morado medio)
// BG Light:   0xFFF3E5F5  (lila muy claro)
// BG Mid:     0xFFE1BEE7  (lavanda)
// BG Dark:    0xFFCE93D8  (lila medio)

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
                                : " ${feedback[selectedOptionIndex!]}",
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
    question: 'Character: A clever fox in a fable\nWhat will probably happen?',
    options: [
      "A) The fox will trick others",
      "B) The fox will be tricked himself",
      "C) The fox becomes a king",
      "D) The fox starts farming",
    ],
    correctIndex: 0,
    explanation:
        '✔ Correct answer: A\nIn fables, clever foxes usually trick others.',
    incorrectExplanations: [
      'Foxes in fables rarely get tricked.',
      'Becoming a king does not fit the usual fable pattern.',
      'Farming is unrelated to the typical clever-fox storyline.',
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

  // ── Step 1 state ───────────────────────────────────────────────
  bool _characterUnderstood = false;
  List<String> _selectedTraits = [];

  // "Clever" renamed to "Smart" so it's not obvious
  final Map<String, String> _foxFacts = {
    'Smart': 'Able to solve problems quickly and find clever solutions.',
    'Sly': 'Uses cunning to achieve goals.',
    'Quick-witted': 'Thinks fast in difficult situations.',
    'Adaptable': 'Changes approach when needed.',
    'Observant': 'Notices details others miss.',
  };

  // Which traits are actually correct (3 of the 5)
  final Set<String> _correctTraits = {'Smart', 'Sly', 'Quick-witted'};

  bool _foxIsRunning = false;

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
      _isProcessing = false;
      _progressValue = (_currentStep + 1) * 0.2;
      if (_currentStep < 4) {
        _currentStep++;
        _resetInteractiveStates();
      } else {
        _completeActivity();
      }
    });
  }

  void _resetInteractiveStates() {
    _characterUnderstood = false;
    _selectedTraits = [];
    _foxIsRunning = false;
    _selectedAnswer = null;
    _correctAnswer = false;
    _confirmationAnswer = null;
  }

  void _completeActivity() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondActyvityAnimation()),
    );
    setState(() {
      _currentStep = 0;
      _progressValue = 0.2;
      _resetInteractiveStates();
    });
  }

  // ── Shared design helpers ──────────────────────────────────────

  Widget _buildProgressBar() {
    return AnimatedBuilder(
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
  }

  Widget _sectionTitle(String text) {
    // Separar el emoji del resto del texto
    final parts = text.split(' ');
    final emoji = parts.first;
    final rest = parts.skip(1).join(' ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 22),
          ),
          const SizedBox(width: 6),
          ShaderMask(
            shaderCallback: (b) => const LinearGradient(
              colors: [_dark, _accent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(b),
            child: Text(
              rest,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassCard({required Widget child, EdgeInsets? padding}) => Container(
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
        padding: padding ?? const EdgeInsets.all(20),
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

  Widget _feedbackBox(
          {required bool isCorrect,
          required String correctText,
          required String wrongText}) =>
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
  // - "Clever" renamed "Smart"
  // - Instructions clarified (select 3)
  // - Per-trait feedback on tap
  Widget _buildStep1() {
    final allCorrectSelected =
        _correctTraits.every((t) => _selectedTraits.contains(t)) &&
            _selectedTraits.every((t) => _correctTraits.contains(t));

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
              _sectionTitle("🦊 Step 1: Meet the Character"),
              _buildProgressBar(),
              const SizedBox(height: 16),

              // Fox animated card
              GestureDetector(
                onTap: () {
                  setState(() => _foxIsRunning = true);
                  Future.delayed(const Duration(seconds: 2),
                      () => setState(() => _foxIsRunning = false));
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.90), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: _primary.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _pastel1,
                          border: Border.all(color: _pastel2, width: 2),
                        ),
                        child: const Center(
                          child: Icon(Icons.pets,
                              size: 56, color: Color(0xFFFF9800)),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Character: A clever fox in a fable',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: _deepDark,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (_foxIsRunning)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            "🏃 The fox is running!",
                            style: TextStyle(
                                fontSize: 14,
                                color: _accent,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              _glassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Key words
                    _infoBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Icon(Icons.psychology, color: _accent, size: 20),
                            const SizedBox(width: 8),
                            const Text("Key Words:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _deepDark,
                                    fontSize: 14.5)),
                          ]),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 8,
                            children: ["Smart", "Fox", "Fable"]
                                .map((w) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 7),
                                      decoration: BoxDecoration(
                                        color: _pastel1,
                                        borderRadius:
                                            BorderRadius.circular(999),
                                        border: Border.all(
                                            color: _pastel2, width: 1.5),
                                      ),
                                      child: Text(w,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: _dark,
                                              fontSize: 14)),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Trait selector — clarified instructions
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            fontSize: 15, color: _textBody, height: 1.5),
                        children: [
                          TextSpan(
                            text:
                                "Select the 3 traits that best describe a clever fox in a fable. ",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text:
                                "Tap each one to find out why it fits (or doesn't).",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    ..._foxFacts.keys
                        .map((trait) => _buildTraitSelector(trait))
                        .toList(),

                    const SizedBox(height: 8),

                    // Selected chips summary
                    if (_selectedTraits.isNotEmpty) ...[
                      _infoBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Selected (${_selectedTraits.length}/3):",
                              style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: _deepDark,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              children: _selectedTraits
                                  .map((t) => Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: _correctTraits.contains(t)
                                              ? _primary.withOpacity(0.12)
                                              : Colors.red.shade50,
                                          borderRadius:
                                              BorderRadius.circular(999),
                                          border: Border.all(
                                            color: _correctTraits.contains(t)
                                                ? _primary
                                                : Colors.red.shade300,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              _correctTraits.contains(t)
                                                  ? Icons.check
                                                  : Icons.close,
                                              size: 13,
                                              color: _correctTraits.contains(t)
                                                  ? _primary
                                                  : Colors.red.shade600,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(t,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color:
                                                      _correctTraits.contains(t)
                                                          ? _dark
                                                          : Colors.red.shade700,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],

                    // Fable understanding check
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: _characterUnderstood
                          ? Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: _pastel1.withOpacity(0.70),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: _pastel2, width: 1.5),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.check_circle,
                                      color: _primary, size: 20),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      "In fables, animals represent human traits and teach lessons.",
                                      style: TextStyle(
                                          color: _dark.withOpacity(0.85),
                                          fontSize: 13.5,
                                          height: 1.5),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : _primaryButton(
                              "💡 Learn about fables",
                              () => setState(() => _characterUnderstood = true),
                            ),
                    ),

                    const SizedBox(height: 16),
                    _primaryButton(
                      "Make Predictions  →",
                      allCorrectSelected ? _nextStep : null,
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

  Widget _buildTraitSelector(String trait) {
    final isSelected = _selectedTraits.contains(trait);
    final isCorrect = _correctTraits.contains(trait);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedTraits.remove(trait);
          } else {
            _selectedTraits.add(trait);
          }
        });
        // Show why it fits / doesn't
        final msg = isCorrect
            ? "✅ ${_foxFacts[trait]}"
            : " ${_foxFacts[trait]} — but this isn't a defining trait of a fable fox.";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(12),
            backgroundColor: isCorrect
                ? _primary.withOpacity(0.92)
                : Colors.red.shade700.withOpacity(0.92),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: Text(msg,
                style: const TextStyle(color: Colors.white, fontSize: 14)),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
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
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isSelected && isCorrect
                    ? const LinearGradient(
                        colors: [_dark, _accent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
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
                  ? Icon(
                      isCorrect ? Icons.check : Icons.close,
                      size: 15,
                      color: Colors.white,
                    )
                  : null,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trait,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? (isCorrect ? _dark : Colors.red.shade700)
                          : _textBody,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    _foxFacts[trait]!,
                    style: TextStyle(
                        fontSize: 12.5,
                        color: _textBody.withOpacity(0.60),
                        height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── STEP 2 ─────────────────────────────────────────────────────
  // Symbols added to ALL options so A isn't obvious
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
              _sectionTitle("🔮 Step 2: Predict the Story"),
              _buildProgressBar(),
              const SizedBox(height: 16),
              _glassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "What will probably happen in the story?",
                      style: TextStyle(
                        fontSize: 17,
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
                            Icon(Icons.auto_stories, color: _accent, size: 20),
                            const SizedBox(width: 8),
                            const Text("Fable Facts:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _deepDark,
                                    fontSize: 14.5)),
                          ]),
                          const SizedBox(height: 8),
                          const Text(
                            "• Fables teach moral lessons\n"
                            "• Animals represent human characteristics\n"
                            "• Clever animals usually outsmart others\n"
                            "• Stories often end with a surprise twist",
                            style: TextStyle(
                                fontSize: 14, height: 1.55, color: _textBody),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      "Choose the most likely outcome:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _deepDark,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // All options have emoji so none is singled out
                    _buildPredictionCard("A) The fox will trick others 🦊", "A",
                        true, Icons.psychology),
                    _buildPredictionCard(
                        "B) The fox will be tricked himself 😟",
                        "B",
                        false,
                        Icons.sentiment_dissatisfied),
                    _buildPredictionCard("C) The fox becomes a king 👑", "C",
                        false, Icons.emoji_events),
                    _buildPredictionCard("D) The fox starts farming 🌾", "D",
                        false, Icons.agriculture),

                    const SizedBox(height: 14),

                    if (_selectedAnswer != null) ...[
                      _feedbackBox(
                        isCorrect: _correctAnswer,
                        correctText:
                            "In fables, clever foxes usually outsmart others. Being smart is a clue about their likely actions.",
                        wrongText: _getPredictionFeedback(_selectedAnswer!),
                      ),
                      const SizedBox(height: 14),
                      if (!_correctAnswer)
                        _primaryButton("Try Again ↩",
                            () => setState(() => _selectedAnswer = null)),
                    ],

                    if (_correctAnswer) ...[
                      const SizedBox(height: 14),
                      _primaryButton("Apply Real Knowledge  →", _nextStep),
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

  Widget _buildPredictionCard(
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
        duration: const Duration(milliseconds: 250),
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
      case "B":
        return "Being tricked is possible, but a smart fox in a fable usually stays in control.";
      case "C":
        return "Becoming a king doesn't match typical fable fox stories.";
      case "D":
        return "Farming isn't a common activity for clever foxes in fables.";
      default:
        return "Consider what 'smart' implies about the character's actions.";
    }
  }

  // ── STEP 3 ─────────────────────────────────────────────────────
  // Symbols added to ALL options so B isn't obvious
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
              _sectionTitle("📚 Step 3: Fable Knowledge"),
              _buildProgressBar(),
              const SizedBox(height: 16),
              _glassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "What do you know about foxes in fables?",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: _deepDark,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _infoBox(
                      child: Column(
                        children: [
                          _buildFableExample(
                            "The Fox and the Grapes",
                            "Fox pretends grapes are sour when he can't reach them",
                          ),
                          Divider(
                              height: 20, color: _pastel2.withOpacity(0.80)),
                          _buildFableExample(
                            "The Fox and the Crow",
                            "Fox flatters crow to get the cheese she's holding",
                          ),
                          Divider(
                              height: 20, color: _pastel2.withOpacity(0.80)),
                          _buildFableExample(
                            "The Fox and the Stork",
                            "Fox plays trick on stork, then stork gets revenge",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      "Based on these examples, what pattern do you see?",
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w600,
                        color: _textBody,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // All options have emoji now
                    _buildPatternOption(
                        "Foxes usually need help from others 🤝", false),
                    _buildPatternOption(
                        "Foxes use their cleverness to trick others 🦊", true),
                    _buildPatternOption(
                        "Foxes are always the victims 😢", false),
                    _buildPatternOption("Foxes prefer honest work 🌾", false),

                    const SizedBox(height: 14),

                    if (_confirmationAnswer != null)
                      _feedbackBox(
                        isCorrect: _confirmationAnswer == true,
                        correctText:
                            "In most fables, foxes use their cleverness to outsmart others, not to work honestly.",
                        wrongText:
                            "Review the fable examples — notice how the fox behaves in each story.",
                      ),

                    const SizedBox(height: 14),

                    _primaryButton(
                      _confirmationAnswer == null
                          ? "Check Answer"
                          : "Final Logical Reasoning  →",
                      () {
                        if (_confirmationAnswer == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("Select an option first!"),
                              backgroundColor: _primary,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
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

  Widget _buildFableExample(String title, String desc) => Row(
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
            child: const Icon(Icons.book, color: _primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: _deepDark,
                        fontSize: 14)),
                const SizedBox(height: 3),
                Text(desc,
                    style: TextStyle(
                        fontSize: 13,
                        color: _textBody.withOpacity(0.75),
                        height: 1.4)),
              ],
            ),
          ),
        ],
      );

  Widget _buildPatternOption(String text, bool isCorrect) {
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
        child: Row(
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
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
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
  // Removed redundant "Confirm your final answer" question header.
  // Kept evidence summary + logical conclusion + options.
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
              _sectionTitle("⚖️ Step 4: Logical Conclusion"),
              _buildProgressBar(),
              const SizedBox(height: 16),
              _glassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Putting all the evidence together:",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: _deepDark,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Evidence summary
                    _infoBox(
                      child: Column(
                        children: [
                          _buildEvidencePoint(
                              "Character trait", "Smart (clever)"),
                          const SizedBox(height: 10),
                          _buildEvidencePoint("Story type", "Fable"),
                          const SizedBox(height: 10),
                          _buildEvidencePoint(
                              "Fable pattern", "Foxes trick others"),
                          const SizedBox(height: 10),
                          _buildEvidencePoint("Previous examples",
                              "Support clever fox pattern"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Logical conclusion box
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
                            Icon(Icons.connect_without_contact,
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
                            "Tricking others fits the character description. "
                            "Becoming a king or farming doesn't match a fable fox. "
                            "The most logical outcome is that the fox will trick others.",
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

                    // Options — no redundant question header

                    const SizedBox(height: 16),

                    _primaryButton(
                      "Reveal Final Analysis  →",
                      _nextStep,
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

  Widget _buildEvidencePoint(String label, String value) => Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: _pastel1,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _pastel2, width: 1.5),
            ),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: _dark,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _textBody,
              ),
            ),
          ),
        ],
      );

  // ignore: unused_element
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
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? (isCorrect ? _dark : Colors.red.shade700)
                      : _textBody,
                  height: 1.4,
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

  // ── STEP 5 — untouched ─────────────────────────────────────────
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
                    "A) The fox will trick others 🦊",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _dark,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 1.5,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [_pastel2, _pastel3]),
                  ),
                ),
                const SizedBox(height: 18),
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
                              "The character is described as clever, and fables often show clever animals outsmarting others.\n\n"),
                      TextSpan(text: "• "),
                      TextSpan(
                          text:
                              "In fables, clever foxes usually outsmart others. Being smart is a clue about their likely actions.\n\n"),
                      TextSpan(text: "• "),
                      TextSpan(
                          text:
                              "Using this clue, the most likely outcome is that the fox will trick others."),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                _primaryButton("Start Activity  ▶", _completeActivity),
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
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.55), width: 1),
                      ),
                      child: Text(
                        'Step ${_currentStep + 1} of 5',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: _deepDark,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
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
    '💡 General: What is the common moral lesson or fate for a character who is excessively greedy?',
    '📌 More Specific: Does this character type typically find success or face punishment/loss?',
  ];

  final List<String> hints2 = [
    '💡 General: What is the heroic action expected of a firefighter in a narrative?',
    '📌 More Specific: Does a story about a “brave” rescuer usually end with failure or success in saving others?',
  ];

  final List<String> hints3 = [
    '💡 General: What is the likely resolution for a story centered on a character seeking connection?',
    '📌 More Specific: Does a quest for a friend usually end with finding companionship or giving up?',
  ];

  final List<String> hints4 = [
    '💡 General: What is the typical narrative function of a character who is both wise and old?',
    '📌 More Specific: Does this archetype usually offer advice and direction to the main character?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question": "Character: A greedy merchant. What is the likely outcome?",
      "options": [
        "A) He becomes even richer",
        "B) He saves the village",
        "C) He shares his wealth",
        "D) He loses everything"
      ],
      "correctIndex": 3,
      "feedback": [
        "Greedy characters rarely end up rewarded with more wealth.",
        "Saving the village is not a typical outcome for a greedy character.",
        "Sharing wealth contradicts the greedy character trait.",
        "Correct: Greedy characters usually face downfall or loss."
      ]
    },
    {
      "question":
          "Character: A brave firefighter. What is the most likely outcome?",
      "options": [
        "A) He ignores danger",
        "B) He saves people from a fire",
        "C) He starts the fire",
        "D) He runs away from danger"
      ],
      "correctIndex": 1,
      "feedback": [
        "Ignoring danger does not align with bravery.",
        "Correct: Firefighters in stories are usually heroic rescuers.",
        "Starting a fire contradicts the hero role of a firefighter.",
        "Running away from danger contradicts the firefighter's bravery."
      ]
    },
    {
      "question":
          "Character: A lonely robot searching for a friend. What is the most likely outcome?",
      "options": [
        "A) The robot will find companionship",
        "B) The robot gives up",
        "C) The robot becomes a king",
        "D) The robot goes to sleep forever"
      ],
      "correctIndex": 0,
      "feedback": [
        "Correct: Stories about lonely characters usually end with finding connection.",
        "Giving up is possible but not the typical resolution for this narrative type.",
        "Becoming a king has no narrative relation to searching for a friend.",
        "Sleeping forever does not connect to the theme of companionship."
      ]
    },
    {
      "question": "Character: A wise old wizard. What is the most likely role?",
      "options": [
        "A) He gives guidance to the hero",
        "B) He becomes lost in the forest",
        "C) He opens a restaurant",
        "D) He refuses to help anyone"
      ],
      "correctIndex": 0,
      "feedback": [
        "Correct: Wizards in stories typically guide or advise heroes.",
        "Getting lost contradicts the notion of “wise.”",
        "Opening a restaurant does not align with the wizard archetype.",
        "Refusing to help contradicts the typical mentor role."
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
                                : " ${feedback[selectedOptionIndex!]}",
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
        'Genre: Horror — “The House on Raven Hill”\nWhat is most likely to happen?',
    options: [
      "A) The house is filled with laughter",
      "B) The house has ghosts or a dark secret ",
      "C) The house is full of cute magical creatures",
      "D) The house becomes a museum"
    ],
    correctIndex: 1,
    explanation:
        '✨ Correct answer: B\nHorror stories often involve danger, mystery, or dark secrets.',
    incorrectExplanations: [
      ' This doesn’t fit typical horror themes.',
      ' Second option is correct.',
      ' Happy families are rare in horror settings.',
      ' Museums are not a common horror outcome.'
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
  bool _isProcessing = false;
  double _progressValue = 0.2;
  late AnimationController _animationController;
  bool _correctAnswer = false;
  bool? _confirmationAnswer;
  String? _activeHorrorHint;

  // ── Design tokens (pastel purple system) ──────────────────────
  static const Color _primary = Color(0xFF7C3AED);
  static const Color _dark = Color(0xFF5B21B6);
  static const Color _deepDark = Color(0xFF4C1D95);
  static const Color _accent = Color(0xFFA855F7);
  static const Color _pastel1 = Color(0xFFEDE9FE);
  static const Color _pastel2 = Color(0xFFDDD6FE);
  static const Color _pastel3 = Color(0xFFF3E8FF);
  static const Color _textBody = Color(0xFF4C1D95);

  // ── Step 1 state ──────────────────────────────────────────────
  bool _titleTapped = false;
  bool _genreUnderstood = false;
  List<String> _selectedKeywords = [];
  bool _keywordsSubmitted = false;

  // Correct keywords are "Raven" and "Hill" (House is neutral)
  static const Set<String> _correctKeywords = {'Raven', 'Hill'};

  // ── Step 2 state ──────────────────────────────────────────────
  // (horror elements selection removed)

  // ── Flashlight ────────────────────────────────────────────────
  bool _flashlightOn = false;
  double _flashlightX = 0.5;
  double _flashlightY = 0.5;

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
      _isProcessing = false;
      _progressValue = (_currentStep + 1) * 0.2;
      if (_currentStep < 4) {
        _currentStep++;
        _resetInteractiveStates();
      } else {
        _completeActivity();
      }
    });
  }

  void _resetInteractiveStates() {
    _titleTapped = false;
    _genreUnderstood = false;
    _selectedKeywords = [];
    _keywordsSubmitted = false;
    _flashlightOn = false;
    _selectedAnswer = null;
    _correctAnswer = false;
    _confirmationAnswer = null;
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

  // ── Shared design helpers ──────────────────────────────────────

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

  Widget _sectionTitle(String text) {
    // Separar el emoji del resto del texto
    final parts = text.split(' ');
    final emoji = parts.first;
    final rest = parts.skip(1).join(' ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 22),
          ),
          const SizedBox(width: 6),
          ShaderMask(
            shaderCallback: (b) => const LinearGradient(
              colors: [_dark, _accent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(b),
            child: Text(
              rest,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassCard({required Widget child, EdgeInsets? padding}) => Container(
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
        padding: padding ?? const EdgeInsets.all(20),
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

  // ignore: unused_field
  final Map<String, String> _horrorKeywordHints = {
    "House":
        "An isolated house is a classic horror setting — dark, unknown rooms, creaking floors, but is neutral",
    "Raven":
        "Ravens symbolize death and mystery in literature. A very ominous clue!",
    "Hill": "'On a hill' means isolated, hard to escape — perfect for horror.",
    "Dark":
        "Not in the title — but darkness is a horror element you'd expect inside the story.",
    "Secret":
        "Not in the title — secrets appear in the story, not as a title clue.",
    "Ghost":
        "Not in the title — ghosts may appear in the story, but the title doesn't hint at them directly.",
  };

  Widget _buildStep1() {
    return GestureDetector(
      onPanUpdate: (details) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final offset = box.globalToLocal(details.globalPosition);
        setState(() {
          _flashlightOn = true;
          _flashlightX = offset.dx / box.size.width;
          _flashlightY = offset.dy / box.size.height;
        });
      },
      onPanEnd: (_) => setState(() => _flashlightOn = false),
      child: Stack(
        children: [
          AnimationLimiter(
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
                    _sectionTitle("🔦 Step 1: Explore the \nTitle & Genre"),
                    _buildProgressBar(),
                    const SizedBox(height: 16),

                    // ── Title / Genre interactive card ──────────
                    _glassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Read carefully and tap to reveal clues:",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: _textBody,
                            ),
                          ),
                          const SizedBox(height: 14),

                          GestureDetector(
                            onTap: () =>
                                setState(() => _titleTapped = !_titleTapped),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 350),
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: _titleTapped
                                      ? [_dark, _accent]
                                      : [_pastel1, _pastel3],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: _titleTapped ? _accent : _pastel2,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: _titleTapped
                                        ? _primary.withOpacity(0.30)
                                        : _primary.withOpacity(0.08),
                                    blurRadius: _titleTapped ? 16 : 6,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Genre: Horror",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: _titleTapped
                                          ? Colors.white
                                          : _deepDark,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '"The House on Raven Hill"',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color:
                                          _titleTapped ? Colors.white : _dark,
                                      letterSpacing: 0.8,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  if (_titleTapped)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 14),
                                      child: Text(
                                        "💀 Horror stories create fear through suspense and supernatural elements",
                                        style: TextStyle(
                                          fontSize: 13.5,
                                          color: Colors.white.withOpacity(0.90),
                                          fontStyle: FontStyle.italic,
                                          height: 1.5,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Genre understood toggle
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 350),
                            child: _genreUnderstood
                                ? _infoBox(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.check_circle,
                                            color: _primary, size: 20),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            "Horror often involves ghosts, dark secrets, mystery, fear, and supernatural events.",
                                            style: TextStyle(
                                              fontSize: 13.5,
                                              color: _dark.withOpacity(0.88),
                                              height: 1.55,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : _primaryButton(
                                    "💡 What is Horror?",
                                    () =>
                                        setState(() => _genreUnderstood = true),
                                  ),
                          ),
                        ],
                      ),
                    ),

                    // ── Keyword selection ─────────────────────
                    _glassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Instruction box ──
                          _infoBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.search,
                                        color: _accent, size: 18),
                                    const SizedBox(width: 8),
                                    const Text(
                                      "How to find horror clues:",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: _deepDark,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Look for words in the title that suggest:\n"
                                  "• A scary or isolated place 🏚️\n"
                                  "• Dark or mysterious symbols 🐦\n"
                                  "• Something strange or threatening 😨",
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    height: 1.6,
                                    color: _textBody,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // ── Task label ──
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                  fontSize: 15, color: _textBody, height: 1.5),
                              children: [
                                TextSpan(
                                  text: "Tap each word ",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                TextSpan(
                                  text:
                                      "to explore its meaning, then select the ones that give horror clues from the title.",
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),

                          // ── Keyword chips ──
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              _buildHorrorKeyword("House"),
                              _buildHorrorKeyword("Raven"),
                              _buildHorrorKeyword("Hill"),
                            ],
                          ),

                          // ── Hint card (animated, changes per word) ──
                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: _activeHorrorHint != null
                                ? _buildHorrorHintCard(_activeHorrorHint!)
                                : const SizedBox.shrink(),
                          ),

                          const SizedBox(height: 16),

                          // ── Check / Retry / Continue button ──
                          if (!_keywordsSubmitted)
                            _primaryButton(
                              "Check My Selection ✓",
                              _selectedKeywords.isNotEmpty
                                  ? () =>
                                      setState(() => _keywordsSubmitted = true)
                                  : null,
                            )
                          else ...[
                            // ── Results feedback ──
                            _buildKeywordResults(),
                            const SizedBox(height: 14),

                            // Retry if not all correct, else Continue
                            if (!_allKeywordsCorrect())
                              _primaryButton("Try Again ↩", () {
                                setState(() {
                                  _keywordsSubmitted = false;
                                  _selectedKeywords.clear();
                                  _activeHorrorHint = null;
                                });
                              })
                            else
                              _primaryButton(
                                "Analyze Predictions  →",
                                _genreUnderstood ? _nextStep : null,
                              ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Flashlight overlay
          if (_flashlightOn)
            Positioned(
              left: _flashlightX * MediaQuery.of(context).size.width - 150,
              top: _flashlightY * MediaQuery.of(context).size.height - 150,
              child: IgnorePointer(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withOpacity(0.22),
                        Colors.transparent,
                      ],
                      stops: const [0.1, 0.8],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ── Returns true if the user selected exactly the correct keywords ──────────
  bool _allKeywordsCorrect() {
    return _selectedKeywords.length == _correctKeywords.length &&
        _selectedKeywords.every((kw) => _correctKeywords.contains(kw));
  }

  // ── Results box shown after checking ────────────────────────────────────────
  Widget _buildKeywordResults() {
    final correctSelected =
        _selectedKeywords.where((kw) => _correctKeywords.contains(kw)).length;
    final total = _correctKeywords.length;
    final allCorrect = _allKeywordsCorrect();

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Container(
        key: ValueKey(_keywordsSubmitted),
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: allCorrect ? _pastel1 : Colors.red.shade50,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: allCorrect ? _primary : Colors.red.shade300,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Score header
            Row(
              children: [
                Icon(
                  allCorrect ? Icons.emoji_events : Icons.info_outline,
                  color: allCorrect ? _primary : Colors.red.shade500,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  allCorrect
                      ? "Perfect 🎉"
                      : "$correctSelected of $total horror clues correct",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: allCorrect ? _dark : Colors.red.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Word badges
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _selectedKeywords.map((kw) {
                final correct = _correctKeywords.contains(kw);
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: correct
                        ? _primary.withOpacity(0.12)
                        : Colors.red.shade50,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: correct ? _primary : Colors.red.shade300,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        correct ? Icons.check : Icons.close,
                        size: 13,
                        color: correct ? _primary : Colors.red.shade600,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        kw,
                        style: TextStyle(
                          fontSize: 13,
                          color: correct ? _dark : Colors.red.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 10),

            // Explanation
            Text(
              allCorrect
                  ? "✅  Raven, and Hill all create an eerie, isolated atmosphere — the hallmark of horror settings."
                  : "💡 Hint: focus on words that describe the place in the title. What makes it sound scary or isolated?",
              style: TextStyle(
                fontSize: 13,
                height: 1.55,
                color: allCorrect ? _textBody : Colors.red.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Hint card that appears below keywords (same style as Step 0) ────────────
  Widget _buildHorrorHintCard(String word) {
    const hints = {
      "House":
          "An isolated house is a classic horror setting — dark, unknown rooms, creaking floors...",
      "Raven":
          "Ravens symbolize death and mystery in literature. A very ominous clue!",
      "Hill":
          "'On a hill' means isolated and hard to escape — perfect for horror.",
    };

    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 280),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.12),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
        child: Container(
          key: ValueKey(word),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_dark, _accent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: _primary.withOpacity(0.22),
                blurRadius: 12,
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
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.tips_and_updates,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '"$word"',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      hints[word] ?? "",
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: Colors.white,
                        height: 1.5,
                      ),
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

  Widget _buildHorrorKeyword(String word) {
    final isSelected = _selectedKeywords.contains(word);
    final isCorrect = _correctKeywords.contains(word);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (_keywordsSubmitted) return; // locked after check

          if (isSelected) {
            _selectedKeywords.remove(word);
            if (_activeHorrorHint == word) _activeHorrorHint = null;
          } else {
            _selectedKeywords.add(word);
            _activeHorrorHint = word; // show hint card for this word
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [_dark, _accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: _keywordsSubmitted && isSelected
                ? (isCorrect ? _primary : Colors.red.shade400)
                : (isSelected ? Colors.transparent : _pastel2),
            width: isSelected ? 0 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? _primary.withOpacity(0.28)
                  : Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_keywordsSubmitted && isSelected) ...[
              Icon(
                isCorrect ? Icons.check : Icons.close,
                size: 14,
                color: Colors.white,
              ),
              const SizedBox(width: 5),
            ] else if (isSelected) ...[
              const Icon(Icons.check, size: 14, color: Colors.white),
              const SizedBox(width: 5),
            ],
            Text(
              word,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : _dark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── STEP 2 ─────────────────────────────────────────────────────
  // Horror elements selection removed. Option C changed.
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
              _sectionTitle("🔮 Step 2: Make Horror \nPredictions"),
              _buildProgressBar(),
              const SizedBox(height: 16),
              _glassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What will probably happen in a horror story titled "The House on Raven Hill"?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _deepDark,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _infoBox(
                      child: const Text(
                        "Remember: In horror stories, titles often hint at danger, mystery, or supernatural events. "
                        "Think about what 'Raven Hill' suggests about the mood and plot.",
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.55,
                          color: _textBody,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    _buildPredictionOption(
                        "A) The house is filled with laughter 😄",
                        "A",
                        false,
                        Icons.sentiment_very_satisfied),
                    _buildPredictionOption(
                        "B) The house has ghosts or a dark secret 👻",
                        "B",
                        true,
                        Icons.visibility_off),
                    // C changed to: full of cute magical creatures
                    _buildPredictionOption(
                        "C) The house is full of cute magical creatures 🧚",
                        "C",
                        false,
                        Icons.auto_awesome),
                    _buildPredictionOption("D) The house becomes a museum 🏛️",
                        "D", false, Icons.museum),

                    const SizedBox(height: 14),

                    if (_selectedAnswer != null) ...[
                      _feedbackBox(
                        isCorrect: _correctAnswer,
                        correctText:
                            "Horror stories often involve scary or mysterious events. The title and genre hint at fear, ghosts, or secrets.",
                        wrongText: _getHorrorFeedback(_selectedAnswer!),
                      ),
                      const SizedBox(height: 14),
                      if (!_correctAnswer)
                        _primaryButton("Try Again ↩",
                            () => setState(() => _selectedAnswer = null)),
                    ],

                    if (_correctAnswer) ...[
                      const SizedBox(height: 14),
                      _primaryButton("Apply Real Knowledge  →", _nextStep),
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
        duration: const Duration(milliseconds: 250),
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

  String _getHorrorFeedback(String option) {
    switch (option) {
      case "A":
        return "Laughter contradicts the horror genre's purpose of creating fear and suspense.";
      case "C":
        return "Cute magical creatures belong to fantasy, not horror — they don't create the fear or dread typical of this genre.";
      case "D":
        return "Museums are neutral settings and don't align with the dark, eerie tone suggested by the title.";
      default:
        return "Consider what makes a horror story truly terrifying.";
    }
  }

  // ── STEP 3 ─────────────────────────────────────────────────────
  // More info added to the comparison table and knowledge section
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
              _sectionTitle("🧠 Step 3: Apply Real-World\n Knowledge"),
              _buildProgressBar(),
              const SizedBox(height: 16),
              _glassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "What do you know about horror stories in real life?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _deepDark,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Comparison table — extended
                    _infoBox(
                      child: Column(
                        children: [
                          // Header
                          Row(
                            children: [
                              Expanded(
                                child: Text("Horror Story",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: _dark,
                                      fontSize: 13.5,
                                    )),
                              ),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: _pastel1,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: _pastel2, width: 1.5),
                                ),
                                child: const Icon(Icons.compare_arrows,
                                    color: _primary, size: 18),
                              ),
                              Expanded(
                                child: Text("Happy Story",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.teal.shade700,
                                      fontSize: 13.5,
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Divider(color: _pastel2, height: 1),
                          ...[
                            [
                              "Dark, eerie settings 🌑",
                              "Bright, cheerful settings 🌤️"
                            ],
                            ["Suspense and fear 😨", "Joy and laughter 😄"],
                            [
                              "Supernatural elements 👻",
                              "Realistic everyday events 🏡"
                            ],
                            [
                              "Mystery and secrets 🔒",
                              "Clear, honest explanations 📖"
                            ],
                            [
                              "Isolation and danger 🏚️",
                              "Community and safety 🏘️"
                            ],
                            [
                              "Ravens, shadows, fog 🐦‍⬛",
                              "Flowers, sunshine, music 🌸"
                            ],
                          ].map((pair) => Column(
                                children: [
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(pair[0],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 12.5,
                                                color: _textBody,
                                                height: 1.4)),
                                      ),
                                      const SizedBox(width: 32),
                                      Expanded(
                                        child: Text(pair[1],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 12.5,
                                                color: _textBody,
                                                height: 1.4)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Divider(
                                      color: _pastel2.withOpacity(0.60),
                                      height: 1),
                                ],
                              )),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Extended knowledge note
                    _infoBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            const Icon(Icons.lightbulb_outline,
                                color: _accent, size: 20),
                            const SizedBox(width: 8),
                            const Text("Did you know?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _deepDark,
                                  fontSize: 14.5,
                                )),
                          ]),
                          const SizedBox(height: 8),
                          const Text(
                            "• Ravens have been symbols of death and bad omens since ancient times (Edgar Allan Poe's \"The Raven\").\n\n"
                            "• Old, isolated houses on hills are classic horror settings because they feel cut off and threatening.\n\n"
                            "• The word 'haunted' comes from the idea that spirits linger in places where something terrible happened.\n\n"
                            "• Horror as a genre relies on the reader's fear of the unknown — things that can't be easily explained.",
                            style: TextStyle(
                              fontSize: 13.5,
                              height: 1.65,
                              color: _textBody,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "Which scenario uses horror knowledge correctly?",
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w600,
                        color: _textBody,
                      ),
                    ),
                    const SizedBox(height: 12),

                    _buildKnowledgeOption(
                        "A haunted house would make a great comedy club 😂",
                        false),
                    _buildKnowledgeOption(
                        "An old, isolated house on a hill is perfect for a horror setting 🏚️",
                        true),
                    _buildKnowledgeOption(
                        "Horror stories usually end with everyone getting married 💍",
                        false),
                    _buildKnowledgeOption(
                        "Ravens are symbols of joy in horror literature 🌈",
                        false),

                    const SizedBox(height: 14),

                    if (_confirmationAnswer != null)
                      _feedbackBox(
                        isCorrect: _confirmationAnswer == true,
                        correctText:
                            "Old, isolated locations create perfect horror settings because they emphasize loneliness and vulnerability.",
                        wrongText:
                            "Horror uses symbolism — ravens often represent death or bad omens, not joy. Haunted houses cause fear, not laughter.",
                      ),

                    const SizedBox(height: 14),

                    _primaryButton(
                      _confirmationAnswer == null
                          ? "Check Answer"
                          : "Final Logical Reasoning  →",
                      () {
                        if (_confirmationAnswer == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("Select an option first!"),
                              backgroundColor: _primary,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
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

  Widget _buildKnowledgeOption(String text, bool isCorrect) {
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
        child: Row(
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
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
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
  // Removed redundant "Confirm final answer" section header.
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
              _sectionTitle("⚡ Step 4: Final Logical\n Conclusion"),
              _buildProgressBar(),
              const SizedBox(height: 16),
              _glassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Putting all the clues together:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _deepDark,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Clue assembly
                    _infoBox(
                      child: Column(
                        children: [
                          _cluePiece(
                              "🎭 Genre: Horror", "Creates fear and suspense"),
                          const SizedBox(height: 10),
                          _cluePiece("🏚️ House on Raven Hill",
                              "Isolated, eerie location"),
                          const SizedBox(height: 10),
                          _cluePiece("🐦‍⬛ Raven symbolism",
                              "Represents death or mystery"),
                          const SizedBox(height: 10),
                          _cluePiece(
                              "⛰️ Hill setting", "Remote, difficult to escape"),
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
                            const Icon(Icons.connect_without_contact,
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
                            "The story is horror, and the title suggests something eerie. "
                            "Using these clues, the most likely outcome is that the house has ghosts or a dark secret. 👻",
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

                    // Options — no redundant question header

                    const SizedBox(height: 16),

                    _primaryButton(
                      "Reveal Final Analysis  →",
                      _nextStep,
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

  Widget _cluePiece(String clue, String meaning) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: _pastel1,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _pastel2, width: 1.5),
            ),
            child: Text(clue,
                style: const TextStyle(
                    fontSize: 12.5, fontWeight: FontWeight.bold, color: _dark)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(meaning,
                  style: const TextStyle(
                      fontSize: 13.5, color: _textBody, height: 1.4)),
            ),
          ),
        ],
      );

  // ignore: unused_element
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
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? (isCorrect ? _dark : Colors.red.shade700)
                      : _textBody,
                  height: 1.4,
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

  // ── STEP 5 — untouched content, design upgraded + button fixed ──
  Widget _buildStep5() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
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
                    "B) The house has ghosts or a dark secret 👻",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _dark,
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

                const Text("Explanation:",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: _deepDark)),
                const SizedBox(height: 12),

                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                        fontSize: 14.5, color: _textBody, height: 1.65),
                    children: [
                      TextSpan(text: "• "),
                      TextSpan(
                          text:
                              "The genre is horror — titles like \"Raven Hill\" suggest fear, mystery, or supernatural events.\n\n"),
                      TextSpan(text: "• "),
                      TextSpan(
                          text:
                              "Horror stories often include ghosts, eerie secrets, or unexplained phenomena.\n\n"),
                      TextSpan(text: "• "),
                      TextSpan(
                          text:
                              "Using clues from the title and genre, the most likely outcome is the presence of ghosts or dark secrets."),
                    ],
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

                const Text("Key Takeaways:",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: _deepDark)),
                const SizedBox(height: 12),

                const Text(
                  "• Genre provides crucial context for predictions\n"
                  "• Titles contain symbolic clues\n"
                  "• Real-world knowledge supports interpretation\n"
                  "• Logical reasoning connects all evidence",
                  style:
                      TextStyle(fontSize: 14.5, color: _textBody, height: 1.65),
                ),

                const SizedBox(height: 22),

                // Button fixed: says "Continue" to advance
                _primaryButton("Continue  →", _completeActivity),
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
              // Header
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
    '💡 General: What is the theme of Sci-Fi involving the end of Earth?',
    '📌 More Specific: Does a story with a “Last Ship” suggest escape or staying behind?',
  ];

  final List<String> hints2 = [
    '💡 General: What is the main characteristic of an Adventure story?',
    '📌 More Specific: What typical goals appear after a difficult desert journey?',
  ];

  final List<String> hints3 = [
    '💡 General: What is the defining purpose of the Comedy genre?',
    '📌 More Specific: Does “Trouble” in comedy usually bring serious consequences or humorous mishaps?',
  ];

  final List<String> hints4 = [
    '💡 General: What is the central task of the Mystery genre?',
    '📌 More Specific: Does a story about a “Vanishing” object focus on its loss or its recovery?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Genre: Sci-Fi — “The Last Ship Leaving Earth”. What is most likely to happen?",
      "options": [
        "A) People travel to space for survival",
        "B) People start farming on Earth",
        "C) People ignore the ship",
        "D) People throw a party"
      ],
      "correctIndex": 0,
      "feedback": [
        "Correct: Sci-fi with 'Last Ship' suggests escape from Earth.",
        "Farming on Earth contradicts the idea that Earth is no longer safe.",
        "Ignoring the last ship is illogical in a survival context.",
        "A party would not fit the tone of a Sci-Fi evacuation scenario."
      ]
    },
    {
      "question":
          "Genre: Adventure — “Journey Across the Desert”. What is the most likely event?",
      "options": [
        "A) The travelers find water or treasure",
        "B) The travelers stay home",
        "C) The travelers join a store",
        "D) The travelers open a store"
      ],
      "correctIndex": 0,
      "feedback": [
        "Correct: Adventure stories usually end with discovery or survival.",
        "Staying home goes against the adventure genre.",
        "Joining a store does not match the context of a desert journey.",
        "Opening a store is unrelated to the goal of adventure stories."
      ]
    },
    {
      "question":
          "Genre: Comedy — “The Trouble with Tom’s Shoes”. What is most likely to happen?",
      "options": [
        "A) Tom travels to space",
        "B) Tom wins a serious award",
        "C) Tom loses all his money and reputation",
        "D) Tom’s shoes cause funny problems"
      ],
      "correctIndex": 3,
      "feedback": [
        "Space travel does not fit the tone of a comedy about shoes.",
        "Serious awards are uncommon outcomes in comedic trouble stories.",
        "A complete downfall is too dramatic for a light comedy.",
        "Correct: Comedy stories exaggerate ordinary problems for humor."
      ]
    },
    {
      "question":
          "Genre: Mystery — “The Vanishing Necklace”. What is the likely outcome?",
      "options": [
        "A) The necklace turns into food",
        "B) The necklace is destroyed in fire",
        "C) The necklace is discovered",
        "D) The necklace becomes magic"
      ],
      "correctIndex": 2,
      "feedback": [
        "Turning into food does not match the Mystery genre.",
        "Destruction is possible but not the typical goal of a mystery.",
        "Correct: Mysteries focus on solving the disappearance or crime.",
        "Magic is unlikely unless the story is fantasy, not mystery."
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
                                : " ${feedback[selectedOptionIndex!]}",
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
        .set({'completedInstructionSpot5': true}, SetOptions(merge: true));

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
      'completedInstructionSpot5': true,
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
                  'predicting content means using clues—like the title, characters, or genre—along with our real-world knowledge to guess what will likely happen in a story.',
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
