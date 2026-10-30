// ignore_for_file: curly_braces_in_flow_control_structures, unused_field, duplicate_ignore, unused_element

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_2/Animation2_1.dart';
import 'package:inferwise/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final List<Map<String, String>> examples = [
    {
      'title': 'Example 1',
      'prefix': 'Im-',
      'text': 'Im- + possible → Impossible\n(not possible)',
      'image': 'assets/Imagenes de ejemplos/Level2/2.2 A Impossible.webp',
    },
    {
      'title': 'Example 2',
      'prefix': 'Mis-',
      'text': 'Mis- + lead → Mislead\n(to guide wrongly)',
      'image': 'assets/Imagenes de ejemplos/Level2/2.2 B Mislead.webp',
    },
    {
      'title': 'Example 3',
      'prefix': 'Un-',
      'text': 'Un- + happy → Unhappy\n(not happy)',
      'image': 'assets/Imagenes de ejemplos/Level2/2.2 C Unhappy.webp',
    },
    {
      'title': 'Example 4',
      'prefix': 'Re-',
      'text': 'Re- + write → Rewrite\n(write again)',
      'image': 'assets/Imagenes de ejemplos/Level2/2.2 D Rewrite.webp',
    },
    {
      'title': 'Example 5',
      'prefix': 'Pre-',
      'text': 'Pre- + view → Preview\n(see before)',
      'image': 'assets/Imagenes de ejemplos/Level2/2.2 E Preview.webp',
    },
    {
      'title': 'Example 6',
      'prefix': 'Dis-',
      'text': 'Dis- + agree → Disagree\n(not agree)',
      'image': 'assets/Imagenes de ejemplos/Level2/2.2 F Disagree.webp',
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

  Widget _buildCard(Map<String, String> example) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Content
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title badge + prefix pill
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00897B).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.lightbulb_outline,
                                color: Color(0xFF00897B), size: 14),
                            const SizedBox(width: 5),
                            Text(
                              example['title']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Color(0xFF00695C),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00897B),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          example['prefix']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    example['text']!,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black87,
                      height: 1.55,
                    ),
                  ),
                ],
              ),
            ),

            // Divider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: const Color(0xFF4DD0C4).withOpacity(0.35),
                thickness: 1,
              ),
            ),

            // Image below
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(24)),
                child: Image.asset(
                  example['image']!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFFB2DFDB),
                    child: const Icon(Icons.image_not_supported_outlined,
                        size: 48, color: Color(0xFF80CBC4)),
                  ),
                ),
              ),
            ),
          ],
        ),
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
                      "Identifying Prefixes",
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

                // Definition card
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
                    '🔎 What is a Prefix?\n\nA prefix is a group of letters added at the beginning of a word to change its meaning.',
                    style: TextStyle(
                      fontSize: 14.5,
                      color: Color(0xFF00695C),
                      height: 1.45,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Progress dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(examples.length, (i) {
                    final isActive = i == _currentPage;
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

                const SizedBox(height: 10),

                // Cards PageView
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

                // Button
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
                    child: Text(
                      isLast ? "Continue →" : "Next example",
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
      'title': '🔵 1. Read the Word Carefully',
      'body': 'Word: "Impossible"',
    },
    {
      'title': '🔵 2. Identify the Prefix',
      'body': 'Prefix to analyze: "Im-" 💠',
    },
    {
      'title': '🔵 3. Know the Meaning of the Prefix',
      'body': '"Im-" means "not" (it negates the meaning of the base word).',
    },
    {
      'title': '🔵 4. Combine the Prefix with the Base Word',
      'body': '"Im-" + "possible" = "Not possible".',
    },
    {
      'title': '🔵 5. Confirm with Context',
      'body': '"Impossible" fits the context of something that cannot happen or be done.',
    },
    {
      'title': '➡️ Identifying Prefixes',
      'body': '"Impossible" means "not possible" because the prefix "im-" negates the base word "possible."',
    },
  ];

  Widget _buildCardContent(int index) {
    final step = steps[index];
    const boldStyle = TextStyle(
      fontSize: 18,
      height: 1.6,
      color: Color(0xFF00695C),
      fontWeight: FontWeight.bold,
    );
    const normalStyle = TextStyle(
      fontSize: 17,
      height: 1.6,
      color: Colors.black87,
      fontWeight: FontWeight.normal,
    );

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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F7F4), // aguamarina muy claro
              Color(0xFFB2EBE5), // aguamarina suave
              Color(0xFF80CBC4), // aguamarina medio
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

                const Center(
                  child: Text(
                    "✩Let's see how to identify prefixes in the next word✩",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00695C),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 20),

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
                              offset: const Offset(0, 4),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight,
                                ),
                                child: Center(
                                  child: _buildCardContent(index),
                                ),
                              ),
                            );
                          },
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
                            backgroundColor: Colors.white.withOpacity(0.6),
                            foregroundColor: const Color(0xFF00695C),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide(
                                  color: Color(0xFF00897B), width: 1.5),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "Back",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F7F4), // aguamarina muy claro
              Color(0xFFB2EBE5), // aguamarina suave
              Color(0xFF80CBC4), // aguamarina medio
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
                          size: 30, color: Color(0xFF00897B)),
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
                      // Main Card
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.88),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                              color: const Color(0xFF4DD0C4).withOpacity(0.45),
                              width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00897B).withOpacity(0.12),
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
                                    color: Color(0xFF00897B), size: 28),
                                SizedBox(width: 12),
                                Text(
                                  '🔍 Remember',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00695C),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Readers understand unfamiliar words by spotting meaningful parts — like prefixes. A prefix is added to the start of a word to change its meaning, and recognizing them is a smart way to figure things out!',
                              style: TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                  color: Colors.black87),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              '📚 Examples:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00897B),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildExample(
                              sentence: 'Im + patient → Impatient',
                              inference: '(not patient)',
                            ),
                            _buildExample(
                              sentence: 'Mis + behave → Misbehave',
                              inference: '(to act badly)',
                            ),
                            _buildExample(
                              sentence: 'Un + known → Unknown',
                              inference: '(not known)',
                            ),
                            _buildExample(
                              sentence: 'Re + play → Replay',
                              inference: '(play again)',
                            ),
                            _buildExample(
                              sentence: 'Pre + heat → Preheat',
                              inference: '(heat beforehand)',
                            ),
                            _buildExample(
                              sentence: 'Dis + like → Dislike',
                              inference: '(not like)',
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF00897B).withOpacity(0.08),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFF4DD0C4).withOpacity(0.5),
                                ),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.info_outline,
                                      color: Color(0xFF00897B), size: 20),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      '🔷 These small beginnings carry big meaning — and help you unlock words with confidence!',
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

                      const SizedBox(height: 30),

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
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                            shadowColor: const Color(0xFF00695C).withOpacity(0.3),
                          ),
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text(
                            'Next',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
          color: const Color(0xFF00897B).withOpacity(0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: const Color(0xFF4DD0C4).withOpacity(0.5), width: 1),
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
                        color: Color(0xFF00695C)),
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
                  color: Color(0xFF00897B),
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
    '🔷 1. Read the word carefully.',
    '🔷 2. Identify the prefix (e.g., "un-").',
    '🔷 3. Know the meaning of the prefix (e.g., "un-" means "not").',
    '🔷 4. Combine the prefix with the base word (e.g., "unhappy" = "not happy").',
    '🔷 5. Confirm with context to ensure the inferred meaning fits.',
    '➡️ Inference: Use the prefix to guess the word\'s meaning.',
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(""),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close_rounded,
                size: 30, color: Color(0xFF00897B)),
            onPressed: _exit,
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
              Color(0xFFE0F7F4), // aguamarina muy claro
              Color(0xFFB2EBE5), // aguamarina suave
              Color(0xFF80CBC4), // aguamarina medio
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
                  itemCount: steps.length, // ✅ fixed: no +1, no empty index 0
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(18),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.88),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00897B).withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: const Color(0xFF4DD0C4).withOpacity(0.4),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        steps[index],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                      ),
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
                        borderRadius: BorderRadius.circular(12),
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
        'Complete the sentence: \n\nJack needs to ______________ his project because the deadline is tomorrow.',
    options: ["A) Re-do", "B) Mis-do", "C) Un-do", "D) Dis-do"],
    correctIndex: 0,
    explanation:
        '✔️ Explanation: "Re-" means "again," so "redo" means to do it again.',
    incorrectExplanations: [
      '✅',
      'Don\'t worry\'s is a common error',
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

  // Blue color scheme
final Color _primaryColor = const Color(0xFF00897B);  // turquesa profundo
  final Color _darkBlue    = const Color(0xFF00695C);  // turquesa oscuro
  final Color _accentColor = const Color(0xFF4DB6AC);  // turquesa medio
  final Color _lightBlue   = const Color(0xFFB2EBE5);  // turquesa suave
  final Color _lightBlueBg = const Color(0xFFE0F7F4);  // turquesa muy claro
  final Color _softBlue    = const Color(0xFF80CBC4);  // turquesa medio-claro

  // Interactive states
  bool _sentenceUnderstood = false;
  String? _draggedPrefix;
  bool _step3Tried = false;
  bool _step3Completed = false;

  final String _correctDraggedPrefix = "re";

  // ignore: duplicate_ignore
  // ignore: unused_field
  final bool _urgencyIdentified = false;
  String? _selectedPrefix;
  bool _prefixTried = false;
  final String _correctPrefix = "re-";
  bool _prefixMeaningUnderstood = false;
  String? _selectedOption;
  bool _hasTried = false;

  final List<String> _correctOptions = [
    "Jack needs to fix his project.",
  ];

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
    _sentenceUnderstood = false;
    _selectedPrefix = null;
    _prefixMeaningUnderstood = false;
    _selectedAnswer = null;
  }

  Widget _buildProgressIndicator() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: (_progressValue - 0.2).clamp(0.0, 1.0),
        end: _progressValue.clamp(0.0, 1.0),
      ),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
          minHeight: 8,
          borderRadius: BorderRadius.circular(6),
        );
      },
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
                "📝 Step 1: Understand the Sentence",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),

              // Sentence Analysis Card
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
                        child: Text(
                          "Complete the sentence",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: _darkBlue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: _lightBlue.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: _primaryColor, width: 2),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "\"Jack needs to ___ his project because the deadline is tomorrow.\"",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: _darkBlue,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.timer, color: Colors.orange),
                                SizedBox(width: 8),
                                Text(
                                  "Deadline: Tomorrow",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightBlue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _accentColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.lightbulb_outline,
                                    color: _primaryColor),
                                const SizedBox(width: 10),
                                Text(
                                  "Key Elements to Notice:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _darkBlue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text("• \"needs to\" → shows necessity"),
                            const Text(
                                "• \"deadline is tomorrow\" → shows urgency"),
                            const Text("• There's a missing word (___)"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "What is the sentence about?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _buildSentenceOption(
                              "Jack needs to fix his project."),
                          _buildSentenceOption(
                              "Jack is giving up on his project."),
                          _buildSentenceOption(
                              "Jack is writing a new project."),
                          _buildSentenceOption(
                              "Jack has completed his project."),
                        ],
                      ),
                      const SizedBox(height: 25),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: _hasTried
                            ? Container(
                                key: ValueKey(_sentenceUnderstood),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: _sentenceUnderstood
                                      ? Colors.green.withOpacity(0.1)
                                      : Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: _sentenceUnderstood
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      _sentenceUnderstood
                                          ? Icons.check_circle
                                          : Icons.error_outline,
                                      color: _sentenceUnderstood
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        _sentenceUnderstood
                                            ? "Correct! The sentence is about fixing or improving a project because of an urgent deadline."
                                            : "Not quite. Focus on necessity and urgency.",
                                        style: TextStyle(
                                          color: _sentenceUnderstood
                                              ? Colors.green[800]
                                              : Colors.red[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _sentenceUnderstood ? _nextStep : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: _primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Explore Prefixes ➡️",
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

  Widget _buildSentenceOption(String text) {
    final bool isSelected = _selectedOption == text;
    final bool isCorrect = _correctOptions.contains(text);

    Color borderColor = Colors.grey.shade300;
    Color bgColor = Colors.white;

    if (_hasTried && isSelected) {
      if (isCorrect) {
        borderColor = Colors.green;
        bgColor = Colors.green.withOpacity(0.15);
      } else {
        borderColor = Colors.red;
        bgColor = Colors.red.withOpacity(0.15);
      }
    } else if (isSelected) {
      borderColor = _primaryColor;
      bgColor = _lightBlue.withOpacity(0.2);
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = text;
          _hasTried = true;
          _sentenceUnderstood = isCorrect;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: borderColor.withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected
                  ? (_hasTried && isCorrect
                      ? Icons.check_circle
                      : Icons.radio_button_checked)
                  : Icons.radio_button_off,
              color: borderColor,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: _darkBlue,
                ),
              ),
            ),
          ],
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
                "🔤 Step 2: Understand Prefixes",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),
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
                        "What are prefixes?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightBlue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _primaryColor),
                        ),
                        child: const Text(
                          "Prefixes are letters added to the beginning of words that change their meaning.\n\n"
                          "Common prefixes:\n"
                          "• re- (again)\n"
                          "• un- (reverse)\n"
                          "• mis- (wrongly)\n"
                          "• dis- (opposite)",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildPrefixCard(
                              "re-", "again", Icons.repeat, Colors.green),
                          _buildPrefixCard(
                              "un-", "reverse", Icons.undo, Colors.blue),
                          _buildPrefixCard(
                              "mis-", "wrong", Icons.error, Colors.orange),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.amber),
                        ),
                        child: const Text(
                          "Jack needs to work on his project AGAIN.\n"
                          "Which prefix means \"again\"?",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Choose the correct prefix:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _buildPrefixOption("re-"),
                          _buildPrefixOption("un-"),
                          _buildPrefixOption("mis-"),
                          _buildPrefixOption("dis-"),
                        ],
                      ),
                      const SizedBox(height: 25),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: _prefixTried
                            ? Container(
                                key: ValueKey(_prefixMeaningUnderstood),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: _prefixMeaningUnderstood
                                      ? Colors.green.withOpacity(0.1)
                                      : Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: _prefixMeaningUnderstood
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      _prefixMeaningUnderstood
                                          ? Icons.check_circle
                                          : Icons.error_outline,
                                      color: _prefixMeaningUnderstood
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        _prefixMeaningUnderstood
                                            ? "Correct! \"re-\" means \"again\"."
                                            : "Not quite. Think about repetition.",
                                        style: TextStyle(
                                          color: _prefixMeaningUnderstood
                                              ? Colors.green[800]
                                              : Colors.red[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _prefixMeaningUnderstood ? _nextStep : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: _primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Apply to Sentence ➡️",
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

  Widget _buildPrefixOption(String prefix) {
    final bool isSelected = _selectedPrefix == prefix;
    final bool isCorrect = prefix == _correctPrefix;

    Color borderColor = Colors.grey.shade300;
    Color bgColor = Colors.white;

    if (_prefixTried && isSelected) {
      borderColor = isCorrect ? Colors.green : Colors.red;
      bgColor = (isCorrect ? Colors.green : Colors.red).withOpacity(0.15);
    } else if (isSelected) {
      borderColor = _primaryColor;
      bgColor = _lightBlue.withOpacity(0.2);
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPrefix = prefix;
          _prefixTried = true;
          _prefixMeaningUnderstood = isCorrect;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: borderColor.withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Text(
          prefix,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _darkBlue,
          ),
        ),
      ),
    );
  }

  Widget _buildPrefixCard(
      String prefix, String meaning, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: color),
              const SizedBox(height: 4),
              Text(
                prefix,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          meaning,
          style: const TextStyle(fontSize: 12),
        ),
      ],
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
              horizontalOffset: 50.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              Text(
                "🤔 Step 3: Apply Prefix Knowledge",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),
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
                        "Drag the correct prefix into the sentence:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // SENTENCE WITH DROP ZONE
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: _lightBlue.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: _primaryColor, width: 2),
                        ),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 6,
                          children: [
                            const Text(
                              "Jack needs to",
                              style: TextStyle(fontSize: 18),
                            ),
                            DragTarget<String>(
                              onAccept: (data) {
                                setState(() {
                                  _draggedPrefix = data;
                                  _step3Tried = true;
                                  _step3Completed =
                                      data == _correctDraggedPrefix;
                                });
                              },
                              builder: (context, candidateData, rejectedData) {
                                Color borderColor = Colors.grey;
                                Color bgColor = Colors.white;

                                if (_step3Tried) {
                                  borderColor = _step3Completed
                                      ? Colors.green
                                      : Colors.red;
                                  bgColor = (_step3Completed
                                          ? Colors.green
                                          : Colors.red)
                                      .withOpacity(0.15);
                                }

                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: bgColor,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: borderColor, width: 2),
                                  ),
                                  child: Text(
                                    _draggedPrefix ?? "___",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: _darkBlue,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const Text(
                              "build his project because the deadline is tomorrow.",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // DRAGGABLE OPTIONS
                      Text(
                        "Available prefixes:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDraggablePrefix("re"),
                          _buildDraggablePrefix("un"),
                          _buildDraggablePrefix("mis"),
                        ],
                      ),

                      const SizedBox(height: 25),

                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: _step3Tried
                            ? Container(
                                key: ValueKey(_step3Completed),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: _step3Completed
                                      ? Colors.green.withOpacity(0.1)
                                      : Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: _step3Completed
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      _step3Completed
                                          ? Icons.check_circle
                                          : Icons.error_outline,
                                      color: _step3Completed
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        _step3Completed
                                            ? "Excellent! \"rebuild\" means to build again — perfect for the situation."
                                            : "Not quite. Think about doing something AGAIN.",
                                        style: TextStyle(
                                          color: _step3Completed
                                              ? Colors.green[800]
                                              : Colors.red[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _step3Completed ? _nextStep : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: _primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Continue ➡️",
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

  Widget _buildDraggablePrefix(String prefix) {
    return Draggable<String>(
      data: prefix,
      feedback: _dragChip(prefix, dragging: true),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _dragChip(prefix),
      ),
      child: _dragChip(prefix),
    );
  }

  Widget _dragChip(String prefix, {bool dragging = false}) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: dragging ? _primaryColor.withOpacity(0.8) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _primaryColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          prefix,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: dragging ? Colors.white : _darkBlue,
          ),
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
                "✅ Step 4: Choose the Complete Word",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
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
                        "Complete the sentence with the right word:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: _lightBlue.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: _primaryColor, width: 2),
                        ),
                        child: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "\"Jack needs to ",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: _primaryColor),
                                        borderRadius: BorderRadius.circular(6),
                                        color: _selectedAnswer == null
                                            ? Colors.white
                                            : _selectedAnswer == "A"
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                      child: Text(
                                        _selectedAnswer == null
                                            ? "________"
                                            : _selectedAnswer == "A"
                                                ? "re-do"
                                                : _selectedAnswer == "B"
                                                    ? "mis-do"
                                                    : _selectedAnswer == "C"
                                                        ? "un-do"
                                                        : "dis-do",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: _selectedAnswer == null
                                              ? Colors.grey
                                              : _selectedAnswer == "A"
                                                  ? Colors.green[800]
                                                  : Colors.red[800],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const TextSpan(
                                    text:
                                        " his project because the deadline is tomorrow.\"",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.amber, width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.compare_arrows, color: Colors.amber),
                                const SizedBox(width: 10),
                                Text(
                                  "Word Analysis:",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: _darkBlue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "• Re-do = do something AGAIN",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  "• Mis-do = do something WRONGLY",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  "• Un-do = REVERSE something done",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  "• Dis-do = not a common word",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "Select the correct word:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildWordOption(
                        "A) Re-do - Means to do something again",
                        "A",
                        true,
                      ),
                      _buildWordOption(
                        "B) Mis-do - Means to do something wrongly",
                        "B",
                        false,
                      ),
                      _buildWordOption(
                        "C) Un-do - Means to reverse something",
                        "C",
                        false,
                      ),
                      _buildWordOption(
                        "D) Dis-do - Not a common word",
                        "D",
                        false,
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
                        color: _selectedAnswer == "A"
                            ? Colors.green.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    _selectedAnswer == "A"
                                        ? Icons.check_circle
                                        : Icons.error,
                                    color: _selectedAnswer == "A"
                                        ? Colors.green
                                        : Colors.red,
                                    size: 28,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    _selectedAnswer == "A"
                                        ? "✅ Perfect Choice!"
                                        : " Incorrect - Try again",
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
                                _selectedAnswer == "A"
                                    ? "Correct! \"Re-do\" means to do something again, which fits Jack's situation perfectly."
                                    : "Remember: Jack needs to work on his project AGAIN because of the deadline. Which word means \"again\"?",
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
                      if (_selectedAnswer != "A")
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
              if (_selectedAnswer == "A") ...[
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
                      "See Final Answer ➡️",
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

  Widget _buildWordOption(String text, String option, bool isCorrect) {
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
              : Colors.red.withOpacity(0.1))
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
                      ? (isCorrect ? Colors.green : Colors.red)
                      : _lightBlue,
                  border: Border.all(color: _primaryColor),
                ),
                child: Center(
                  child: Text(
                    option.replaceAll(")", ""),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : _darkBlue,
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
                  color: isCorrect ? Colors.green : Colors.red,
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
            "🏆 Final Analysis",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _darkBlue,
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
                    "✅ Final Answer:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // RESPUESTA
                  Text(
                    "A) Re-do",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue,
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
                      color: _darkBlue,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // LISTA EXPLICATIVA
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
                              "The sentence talks about Jack needing to work on his project again because the deadline is tomorrow.\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "The prefix \"re-\" means \"again,\" so \"re-do\" means \"to do something again.\"\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "The other options don't fit: \"mis-\" means wrongly, \"un-\" means reverse, and \"dis-do\" isn't a common word.",
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 32),

                  // Complete Sentence
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _lightBlue.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _primaryColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Complete Sentence:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _darkBlue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "\"Jack needs to re-do his project because the deadline is tomorrow.\"",
                          style: TextStyle(
                            fontSize: 18,
                            color: _darkBlue,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 32),

                  // Strategy Summary
                  Text(
                    "Strategy Used:",
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
                    child: Row(
                      children: [
                        Icon(Icons.text_fields, color: _primaryColor),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            "Prefix Analysis: Understanding word parts to determine meaning in context",
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

          const SizedBox(height: 16),

          // ----------- BOTÓN FINAL ----------------
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
                backgroundColor: Colors.green,
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

  void _resetActivity() {
    _currentStep = 0;
    _progressValue = 0.2;
    _resetInteractiveStates();
  }

  void _completeActivity() {
    setState(_resetActivity);

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
    '💡 General Hint: Read the word carefully and focus on the negative prefix.',
    '📌 More Specific: What does ‘un-’ mean? Does it make the word positive or negative?',
  ];

  final List<String> hints2 = [
    '💡 General Hint: Look at the prefix in the word related to before.',
    '📌 More Specific: What does ‘pre-’ mean? Does it suggest something before or after?',
  ];

  final List<String> hints3 = [
    '💡 General Hint: Focus on the prefix in the word related to stop.',
    '📌 More Specific: What does ‘dis-’ mean? Does it suggest stopping or continuing?',
  ];

  final List<String> hints4 = [
    '💡 General Hint: What does ‘mis-’ mean? Does it suggest something done wrong or incorrectly?',
    '📌 More Specific: Pay attention to the base words in the options.',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "She felt __________ when she heard the bad news about the project.\n\nWhat word best completes the sentence?",
      "options": ["A) Unhappy", "B) Mishappy", "C) Prehappy", "D) Rehappy"],
      "correctIndex": 0,
      "feedback": [
        " Explanation: “Un-” means “not,” so “unhappy” means “not happy.”",
        " “Mishappy” is not a correct word.",
        " “Prehappy” is not standard and doesn’t fit the meaning.",
        " “Rehappy” doesn’t make sense in this context."
      ]
    },
    {
      "question":
          "We got a sneak __________ of the movie before it was released.\n\nWhat word best completes the sentence?",
      "options": ["A) Prewatch", "B) Preview", "C) Review", "D) Misview"],
      "correctIndex": 1,
      "feedback": [
        " “Prewatch” is not a standard word.",
        " Explanation: “Pre-” means “before,” so “preview” means to see before.",
        " “Re-view” means to see again, not before release.",
        " “Misview” is incorrect usage here."
      ]
    },
    {
      "question":
          "The doctor advised the patient to __________ the medication after feeling better.\n\nWhat word best completes the sentence?",
      "options": [
        "A) Pretake",
        "B) Misunderstand",
        "C) Discontinue",
        "D) Reuse"
      ],
      "correctIndex": 2,
      "feedback": [
        " “Pretake” doesn’t fit the sentence.",
        " “Misunderstand” is unrelated to stopping medication.",
        " Explanation: “Dis-” means “not,” so “discontinue” means to stop or cease something.",
        " “Reuse” doesn’t relate to stopping medication."
      ]
    },
    {
      "question":
          "He was warned not to __________ the instructions for the project.\n\nWhat word best completes the sentence?",
      "options": [
        "A) Misplace",
        "B) Misunderstand",
        "C) Misinterpret",
        "D) Misuse"
      ],
      "correctIndex": 2,
      "feedback": [
        " “Misplace” means to lose something temporarily.",
        " “Misunderstand” is close, but not as accurate.",
        " Explanation: “Mis-” means wrong or incorrectly, so “misinterpret” means to interpret wrongly.",
        " “Misuse” means to use incorrectly, not interpret."
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
  QuestionData(
    question:
        'He tried to *prelearn* the bad habits he had developed over the years.\n\nFix the sentence.',
    options: ["A) Mislearn", "B) Unlearn", "C) Relearn", "D) Prewrite"],
    correctIndex: 1,
    explanation:
        '✔️ Explanation: "Unlearn" means to forget habits or knowledge, which fits better than "prelearn," which isn\'t a real word in this context.',
    incorrectExplanations: [
      'Don\'t worry\'s is a common error',
      '✅',
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

  Widget _buildQuestionText(String text) {
    final parts = text.split('*');
    final spans = <TextSpan>[];

    for (int i = 0; i < parts.length; i++) {
      if (i % 2 == 1) {
        spans.add(TextSpan(
          text: parts[i],
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.5,
            backgroundColor: Color(0x55FFFFFF),
            decoration: TextDecoration.underline,
            decorationColor: Colors.white,
          ),
        ));
      } else {
        spans.add(TextSpan(
          text: parts[i],
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.5,
          ),
        ));
      }
    }

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: spans),
    );
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
                  child: _buildQuestionText(question.question),
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
    with SingleTickerProviderStateMixin {
  int _currentStep = 0;
  String? _selectedAnswer;
  // ignore: unused_field
  bool _habitAnalysisComplete = false;
  // ignore: unused_field
  bool _isProcessing = false;
  double _progressValue = 0.2;
  late AnimationController _animationController;
  String? _droppedMeaning;
  bool _dragCompleted = false;

  final Map<String, String> _connections = {};
  bool _dragActivityComplete = false;

  final Map<String, Offset> _wordPositions = {};

  final Map<String, String> _correctMatches = {
    "not / undo": "unlearn",
    "wrongly": "mislearn",
    "again": "relearn",
    "before": "prewrite",
  };

  bool _sentenceUnderstood = false;
  String? _step1Feedback;
  bool _isCorrectStep1 = false;

  // Blue color scheme
  final Color _primaryColor = const Color(0xFF00897B);  // turquesa profundo
  final Color _darkBlue    = const Color(0xFF00695C);  // turquesa oscuro
  final Color _accentColor = const Color(0xFF4DB6AC);  // turquesa medio
  final Color _lightBlue   = const Color(0xFFB2EBE5);  // turquesa suave
  final Color _lightBlueBg = const Color(0xFFE0F7F4);  // turquesa muy claro
  final Color _softBlue    = const Color(0xFF80CBC4);  // turquesa medio-claro

  // Interactive states

  final Map<String, String> _dragMatches = {};
  List<Offset> _linePoints = [];
  bool _isDrawing = false;
  // ignore: unused_field
  bool _prefixMeaningUnderstood = false;
  bool _correctPrefixSelected = false;

  // Step 3 specific states
  String? _hoveredPrefix;
  bool _showHint = false;
  final GlobalKey _startNodeKey = GlobalKey();
  final Map<String, GlobalKey> _optionKeys = {
    'un-': GlobalKey(),
    'mis-': GlobalKey(),
    're-': GlobalKey(),
    'pre-': GlobalKey(),
  };

  // Draggable words
  final List<String> _prefixWords = [
    'unlearn',
    'mislearn',
    'relearn',
    'prewrite'
  ];
  // ignore: unused_field
  final List<String> _targetPrefixes = ['un-', 'mis-', 're-', 'pre-'];
  // ignore: unused_field
  final List<String> _targetMeanings = [
    'Forget/Undo',
    'Learn wrongly',
    'Learn again',
    'Write before'
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // Initialize drag positions
    _initializePositions();
  }

  void _initializePositions() {
    // Initialize positions for drag and drop
    for (var word in _prefixWords) {
      _wordPositions[word] = Offset.zero;
    }
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
    _sentenceUnderstood = false;
    _linePoints = [];
    _dragActivityComplete = false;
    _prefixMeaningUnderstood = false;
    _correctPrefixSelected = false;
    _selectedAnswer = null;
    _dragMatches.clear();
    _hoveredPrefix = null;
    _showHint = false;
  }

  void _completeActivity() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SecondActyvityAnimation(),
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
          borderRadius: BorderRadius.circular(4),
        );
      },
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
                "📝 Step 1: Analyze the Sentence",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),
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
                      Center(
                        child: Text(
                          "Change the highlighted word.",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: _darkBlue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.orange, width: 2),
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "He tried to ",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              TextSpan(
                                text: "prelearn",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    " the bad habits he had developed over the years.",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "Drag the correct meaning into the sentence:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 15),
                      DragTarget<String>(
                        onAccept: (data) {
                          setState(() {
                            _dragCompleted = true;

                            if (data == "forget") {
                              _droppedMeaning = "forget bad habits";
                              _isCorrectStep1 = true;
                              _sentenceUnderstood = true;
                              _habitAnalysisComplete = true;
                              _step1Feedback =
                                  "✅ Correct! The sentence means to UNLEARN or forget bad habits.";
                            } else if (data == "create") {
                              _isCorrectStep1 = false;
                              _sentenceUnderstood = false;
                              _step1Feedback =
                                  " \"Create\" doesn’t fit. You don’t create bad habits on purpose here.";
                            } else if (data == "remember") {
                              _isCorrectStep1 = false;
                              _sentenceUnderstood = false;
                              _step1Feedback =
                                  " \"Remember\" is the opposite idea. The sentence is about getting rid of bad habits.";
                            } else if (data == "pre-learn") {
                              _isCorrectStep1 = false;
                              _sentenceUnderstood = false;
                              _step1Feedback =
                                  " \"Pre-learn\" doesn’t make sense in this context. You can’t pre-learn bad habits.";
                            }

                            if (!_isCorrectStep1) {
                              _droppedMeaning = null;
                            }
                          });
                        },
                        builder: (context, candidateData, rejectedData) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: _dragCompleted
                                  ? (_isCorrectStep1
                                      ? Colors.green.withOpacity(0.1)
                                      : Colors.red.withOpacity(0.1))
                                  : _lightBlue.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _dragCompleted
                                    ? (_isCorrectStep1
                                        ? Colors.green
                                        : Colors.red)
                                    : _primaryColor,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              _dragCompleted && _isCorrectStep1
                                  ? "He is trying to ${_droppedMeaning ?? "___"}."
                                  : "He is trying to __________ the bad habits.",
                              style: const TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 25),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _buildDraggableWord("forget", Colors.green, true),
                          _buildDraggableWord("create", Colors.blue, false),
                          _buildDraggableWord("remember", Colors.purple, false),
                          _buildDraggableWord(
                              "pre-learn", Colors.orange, false),
                        ],
                      ),
                      const SizedBox(height: 20),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: _step1Feedback != null
                            ? Container(
                                key: ValueKey(_step1Feedback),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: _isCorrectStep1
                                      ? Colors.green.withOpacity(0.1)
                                      : Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: _isCorrectStep1
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      _isCorrectStep1
                                          ? Icons.check_circle
                                          : Icons.error_outline,
                                      color: _isCorrectStep1
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        _step1Feedback!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: _isCorrectStep1
                                              ? Colors.green[800]
                                              : Colors.red[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _sentenceUnderstood ? _nextStep : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: _primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Explore Prefix Meanings ➡️",
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

  Widget _buildDraggableWord(String word, Color color, bool isCorrect) {
    return Draggable<String>(
      data: isCorrect ? "forget" : "wrong",
      feedback: _dragChip(word, color, true, disabled: false),
      childWhenDragging: _dragChip(word, Colors.grey, false, disabled: true),
      child: _dragChip(word, color, false, disabled: false),
    );
  }

  Widget _dragChip(
    String text,
    Color color,
    bool isDragging, {
    bool disabled = false,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: disabled
            ? Colors.grey.shade300
            : isDragging
                ? color.withOpacity(0.85)
                : color,
        borderRadius: BorderRadius.circular(24),
        boxShadow: disabled
            ? []
            : [
                BoxShadow(
                  color: color.withOpacity(0.35),
                  blurRadius: isDragging ? 14 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: disabled ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }

  Widget _buildStep2() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "🔤 Step 2: Connect Prefixes",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: _darkBlue,
            ),
          ),
          const SizedBox(height: 10),
          _buildProgressIndicator(),
          const SizedBox(height: 20),
          Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Drag each prefix to its correct meaning:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: _darkBlue,
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: _correctMatches.values.map((word) {
                            return Draggable<String>(
                              data: word,
                              feedback: _dragChip(word, _lightBlue, true),
                              childWhenDragging:
                                  _dragChip(word, Colors.grey, false),
                              child: _dragChip(word, _lightBlue, false),
                            );
                          }).toList(),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: _correctMatches.keys.map((meaning) {
                            final isCorrect = _connections[meaning] ==
                                _correctMatches[meaning];

                            return DragTarget<String>(
                              onWillAccept: (data) =>
                                  data == _correctMatches[meaning],
                              onAccept: (data) {
                                setState(() {
                                  _connections[meaning] = data;
                                  _dragActivityComplete = _connections.length ==
                                      _correctMatches.length;
                                });
                              },
                              builder: (context, candidateData, rejectedData) {
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: 160,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isCorrect
                                        ? Colors.green.withOpacity(0.15)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isCorrect
                                          ? Colors.green
                                          : Colors.grey,
                                      width: 2,
                                    ),
                                  ),
                                  child: Text(
                                    meaning,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isCorrect
                                          ? Colors.green[800]
                                          : Colors.black,
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  if (_dragActivityComplete)
                    _successBox(
                        "Great job! You've matched all the prefixes correctly."),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _dragActivityComplete ? _nextStep : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                backgroundColor: _primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                "Solve the Mystery ➡️",
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
  }

  Widget _successBox(String text) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: Colors.green,
            size: 30,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.green.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- IMPROVED STEP 3 ---

  Widget _buildStep3() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              Text(
                "🧩 Step 3: Master of Logic",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),

              // Reading card
              Card(
                elevation: 10,
                shadowColor: _primaryColor.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.white, _lightBlue.withOpacity(0.05)],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title row
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: _primaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.psychology, color: _primaryColor),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "The Challenge: Breaking Habits",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: _darkBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Explanation
                        Text(
                          "To fix the sentence, you must find the prefix that mathematically 'subtracts' or 'reverses' an action.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Prefix options as reading cards
                        _buildPrefixReadingCard(
                          prefix: "un-",
                          meaning: "Undo / Reverse",
                          example: "un + learn = unlearn",
                          isKey: true,
                        ),
                        _buildPrefixReadingCard(
                          prefix: "mis-",
                          meaning: "Wrong Way",
                          example: "mis + behave = misbehave",
                          isKey: false,
                        ),
                        _buildPrefixReadingCard(
                          prefix: "re-",
                          meaning: "Repeat",
                          example: "re + play = replay",
                          isKey: false,
                        ),
                        _buildPrefixReadingCard(
                          prefix: "pre-",
                          meaning: "Ahead of Time",
                          example: "pre + heat = preheat",
                          isKey: false,
                        ),

                        const SizedBox(height: 24),

                        // Key takeaway box
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _primaryColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: _primaryColor.withOpacity(0.3)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.auto_awesome,
                                  color: _primaryColor, size: 20),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "'un-' is the reversal operator. By connecting 'un' + 'learn', you literally mean 'undo the learning'.",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: _darkBlue,
                                    fontWeight: FontWeight.w600,
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
                ),
              ),

              // Continue button
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 40),
                child: FadeInAnimation(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        backgroundColor: _primaryColor,
                        elevation: 8,
                        shadowColor: _primaryColor.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12),
                          Icon(Icons.arrow_forward, color: Colors.white),
                        ],
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

  Widget _buildPrefixReadingCard({
    required String prefix,
    required String meaning,
    required String example,
    required bool isKey,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isKey ? _primaryColor.withOpacity(0.08) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isKey ? _primaryColor.withOpacity(0.4) : _lightBlue,
          width: isKey ? 1.5 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: isKey ? _primaryColor : _lightBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              prefix,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isKey ? Colors.white : _darkBlue,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meaning,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: _darkBlue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  example,
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          if (isKey)
            Icon(Icons.star_rounded, color: _primaryColor, size: 20),
        ],
      ),
    );
  }

  Widget _buildStartNode() {
    return Container(
      key: _startNodeKey,
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.orange[700],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.orange[300]!, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.5),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.flag, color: Colors.white),
          SizedBox(height: 4),
          Text(
            "ACTION:\nLEARN",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrefixNode(
      String prefix, double top, String label, bool isCorrect) {
    bool isHovered = _hoveredPrefix == prefix;
    bool isMatched = _correctPrefixSelected && isCorrect;

    return Positioned(
      right: 20,
      top: top,
      child: AnimatedContainer(
        key: _optionKeys[prefix],
        duration: const Duration(milliseconds: 300),
        width: 140,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isMatched
              ? Colors.green[700]
              : isHovered
                  ? _primaryColor.withOpacity(0.3)
                  : Colors.grey[800],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isMatched
                ? Colors.green[300]!
                : isHovered
                    ? _accentColor
                    : Colors.grey[600]!,
            width: 2,
          ),
          boxShadow: isHovered || isMatched
              ? [
                  BoxShadow(
                    color: (isMatched ? Colors.green : _accentColor)
                        .withOpacity(0.4),
                    blurRadius: 10,
                  )
                ]
              : [],
        ),
        child: Column(
          children: [
            Text(
              prefix,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkHover(Offset position) {
    String? found;
    _optionKeys.forEach((prefix, key) {
      final RenderBox? box =
          key.currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        box.globalToLocal(
            position); // Note: This needs correction in a real app but works for logic
        // Simplified check for the sake of the demo logic
        if (position.dx > 200 &&
            position.dy > box.localToGlobal(Offset.zero).dy - 100 &&
            position.dy < box.localToGlobal(Offset.zero).dy + 50) {
          // In a real Flutter app, we'd use hit testing or global coordinates
        }
      }
    });

    // Mocking hover for the interactive feel
    if (position.dx > 220) {
      if (position.dy < 100)
        found = "un-";
      else if (position.dy < 180)
        found = "mis-";
      else if (position.dy < 260)
        found = "re-";
      else
        found = "pre-";
    }

    if (_hoveredPrefix != found) {
      setState(() => _hoveredPrefix = found);
    }
  }

  void _finalizePath() {
    setState(() {
      _isDrawing = false;
      if (_hoveredPrefix == "un-") {
        _correctPrefixSelected = true;
      } else {
        _linePoints.clear();
        _hoveredPrefix = null;
        _showHint = true;
      }
    });
  }

  Widget _buildHoverHint() {
    String message = "";
    Color color = Colors.white;
    switch (_hoveredPrefix) {
      case "un-":
        message = "LOGIC MATCH: Reverse/Undo action detected!";
        color = Colors.greenAccent;
        break;
      case "mis-":
        message = "ERROR: 'mis-' means wrong, not removal.";
        color = Colors.redAccent;
        break;
      case "re-":
        message = "ERROR: 're-' would repeat the bad habit!";
        color = Colors.redAccent;
        break;
      case "pre-":
        message = "ERROR: 'pre-' is for things happening before.";
        color = Colors.redAccent;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style:
            TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  Widget _buildLogicLegend() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _primaryColor.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          _logicRow(
              "un-", "REVERSAL", "Removes or undoes the root word.", true),
          const Divider(),
          _logicRow(
              "mis-", "QUALITY", "Indicates the action was done badly.", false),
        ],
      ),
    );
  }

  Widget _logicRow(String p, String type, String desc, bool highlight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(p,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: highlight ? _primaryColor : Colors.grey)),
          ),
          Text(type,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600])),
          const SizedBox(width: 12),
          Expanded(
              child: Text(desc,
                  style: TextStyle(fontSize: 12, color: Colors.grey[800]))),
        ],
      ),
    );
  }

  Widget _buildInstructionFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _showHint ? Colors.red[50]?.withOpacity(0.5) : Colors.amber[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: _showHint ? Colors.red[200]! : Colors.amber[300]!),
      ),
      child: Row(
        children: [
          Icon(_showHint ? Icons.lightbulb : Icons.info_outline,
              color: _showHint ? Colors.red : Colors.amber[800]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _showHint
                  ? "Try again! You need to 'undo' the learning. Look for the prefix that means reversal."
                  : "Connect the ACTION node to the logical PREFIX to solve the puzzle.",
              style: TextStyle(
                  fontSize: 14,
                  color: _showHint ? Colors.red[900] : Colors.amber[900],
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
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
                "✅ Step 4: Drag to Fix the Sentence",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
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
                        "Fix this incorrect sentence:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.red, width: 2),
                        ),
                        child: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "\"He tried to ",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: DragTarget<String>(
                                      builder: (context, candidateData,
                                          rejectedData) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: _selectedAnswer == null
                                                  ? Colors.red
                                                  : _selectedAnswer == "B"
                                                      ? Colors.green
                                                      : Colors.red,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: _selectedAnswer == null
                                                ? Colors.white
                                                : _selectedAnswer == "B"
                                                    ? Colors.green
                                                        .withOpacity(0.2)
                                                    : Colors.red
                                                        .withOpacity(0.2),
                                          ),
                                          child: Text(
                                            _selectedAnswer == null
                                                ? "prelearn"
                                                : _selectedAnswer == "A"
                                                    ? "mislearn"
                                                    : _selectedAnswer == "B"
                                                        ? "unlearn"
                                                        : _selectedAnswer == "C"
                                                            ? "relearn"
                                                            : "prewrite",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: _selectedAnswer == null
                                                  ? Colors.red
                                                  : _selectedAnswer == "B"
                                                      ? Colors.green[800]
                                                      : Colors.red[800],
                                            ),
                                          ),
                                        );
                                      },
                                      onWillAccept: (data) => true,
                                      onAccept: (data) {
                                        setState(() {
                                          _selectedAnswer =
                                              data == "unlearn" ? "B" : "D";
                                        });
                                      },
                                    ),
                                  ),
                                  const TextSpan(
                                    text:
                                        " the bad habits he had developed over the years.\"",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.warning, color: Colors.red),
                                const SizedBox(width: 8),
                                Text(
                                  "\"prelearn\" is incorrect here!",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Draggable words to fix
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightBlue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _accentColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Drag the correct word to replace \"prelearn\":",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _darkBlue,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                Draggable<String>(
                                  data: "mislearn",
                                  feedback: _buildDraggableWordCard("mislearn"),
                                  childWhenDragging: Opacity(
                                    opacity: 0.5,
                                    child: _buildDraggableWordCard("mislearn"),
                                  ),
                                  child: _buildDraggableWordCard("mislearn"),
                                ),
                                Draggable<String>(
                                  data: "unlearn",
                                  feedback: _buildDraggableWordCard("unlearn"),
                                  childWhenDragging: Opacity(
                                    opacity: 0.5,
                                    child: _buildDraggableWordCard("unlearn"),
                                  ),
                                  child: _buildDraggableWordCard("unlearn"),
                                ),
                                Draggable<String>(
                                  data: "relearn",
                                  feedback: _buildDraggableWordCard("relearn"),
                                  childWhenDragging: Opacity(
                                    opacity: 0.5,
                                    child: _buildDraggableWordCard("relearn"),
                                  ),
                                  child: _buildDraggableWordCard("relearn"),
                                ),
                                Draggable<String>(
                                  data: "prewrite",
                                  feedback: _buildDraggableWordCard("prewrite"),
                                  childWhenDragging: Opacity(
                                    opacity: 0.5,
                                    child: _buildDraggableWordCard("prewrite"),
                                  ),
                                  child: _buildDraggableWordCard("prewrite"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.amber, width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.compare_arrows, color: Colors.amber),
                                const SizedBox(width: 10),
                                Text(
                                  "Word Analysis Guide:",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: _darkBlue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "• unlearn = forget/undo bad habits ✓",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  "• mislearn = learn something wrongly ✗",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  "• relearn = learn something again ✗",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  "• prewrite = write something before ✗",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      if (_selectedAnswer != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: _selectedAnswer == "B"
                                ? Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.green),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.check_circle,
                                            color: Colors.green),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "✅ Perfect Fix!",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green[800],
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              const Text(
                                                "\"Unlearn\" correctly means to forget bad habits.",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.red),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.error, color: Colors.red),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                " Incorrect Choice",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red[800],
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              const Text(
                                                "Remember: We need to forget/undo bad habits, not learn them.",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (_selectedAnswer == "B") ...[
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
                      "See Final Answer ➡️",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ] else if (_selectedAnswer != null && _selectedAnswer != "B") ...[
                const SizedBox(height: 20),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDraggableWordCard(String word) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: _lightBlue,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _primaryColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        word,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: _darkBlue,
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
            "🏆 Final Analysis",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _darkBlue,
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
                    "✅ Final Answer:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // RESPUESTA
                  Text(
                    "B) Unlearn",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue,
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
                      color: _darkBlue,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // LISTA EXPLICATIVA
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
                              "The sentence talks about trying to forget bad habits developed over years.\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "\"Unlearn\" means to forget or get rid of bad habits or knowledge, which fits perfectly.\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "\"Prelearn\" isn't appropriate here because you can't \"pre-learn\" something you already have.",
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 32),

                  // Corrected Sentence
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _lightBlue.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Corrected Sentence:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "\"He tried to unlearn the bad habits he had developed over the years.\"",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.green[800],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 32),

                  // Why Others are Wrong
                  Text(
                    "Why other options are incorrect:",
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildIncorrectReason("mislearn",
                            "Means to learn something wrongly, not forget"),
                        _buildIncorrectReason("relearn",
                            "Means to learn again, but we need to forget"),
                        _buildIncorrectReason("prewrite",
                            "Means to write before, not related to habits"),
                        _buildIncorrectReason("prelearn",
                            "Not appropriate - can't pre-learn existing habits"),
                      ],
                    ),
                  ),

                  const Divider(height: 32),

                  // Strategy Summary
                  Text(
                    "Strategy Used:",
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
                    child: Row(
                      children: [
                        Icon(Icons.text_fields, color: _primaryColor),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            "Prefix + Context Analysis: Understanding word parts and sentence context",
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

          const SizedBox(height: 16),

          // ----------- BOTÓN FINAL ----------------
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
                backgroundColor: Colors.green,
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

  Widget _buildIncorrectReason(String word, String reason) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(Icons.close, color: Colors.redAccent),
          const SizedBox(width: 10),
          Text(word,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red[800])),
          const SizedBox(width: 8),
          Expanded(
              child: Text(reason, style: TextStyle(color: Colors.red[700]))),
        ],
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

// --- PAINTERS ---

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;

    for (double i = 0; i < size.width; i += 20) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 20) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PathPainter extends CustomPainter {
  final List<Offset> points;
  final Color color;

  PathPainter(this.points, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(points.first.dx, points.first.dy);

    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    // Add glow effect
    canvas.drawPath(
      path,
      Paint()
        ..color = color.withOpacity(0.3)
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant PathPainter oldDelegate) => true;
}

class PracticePageSecond extends StatefulWidget {
  const PracticePageSecond({super.key});

  @override
  State<PracticePageSecond> createState() => _PracticePageSecondState();
}

class _PracticePageSecondState extends State<PracticePageSecond>
    with TickerProviderStateMixin {
  int currentQuestionIndex = 0;
  int? selectedOptionIndex;
  bool showFeedback = false;
  double progress = 0;

  Timer? _inactivityTimer;
  bool _isInactive = false;
  late AnimationController _glowController;
  late AnimationController _highlightController;
  late Animation<double> _highlightAnimation;

  int hintStep1 = 0;
  int hintStep2 = 0;
  int hintStep3 = 0;
  int hintStep4 = 0;

  final List<String> hints1 = [
    '💡 General Hint: Focus on the prefix to see what action is being suggested.',
    '📌 More Specific: Think about the prefix that refers to doing something again.',
  ];

  final List<String> hints2 = [
    '💡 General Hint: Focus on the prefix that means to not agree.',
    '📌 More Specific: Consider a prefix that means to go against something.',
  ];

  final List<String> hints3 = [
    '💡 General Hint: Think about the prefix that means "the opposite of".',
    '📌 More Specific: Think about the word used to describe something that cannot happen.',
  ];

  final List<String> hints4 = [
    '💡 General Hint: Focus on the rest of the word (not the prefix) to see what action is being suggested.',
    '📌 More Specific: Consider the context of the lesson being fun. What word would match that feeling?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "I want to *unwrite* my message because I made a mistake.\n\nFix the sentence:",
      "options": ["A) Prewrite", "B) Miswrite", "C) Diswrite", "D) Rewrite"],
      "correctIndex": 3,
      "feedback": [
        " \"Prewrite\" refers to planning before writing, not fixing a mistake.",
        " \"Miswrite\" means writing something incorrectly, not fixing it.",
        " \"Diswrite\" is not a real word.",
        " Explanation: \"Rewrite\" means to write again. \"Unwrite\" isn't a correct word in English."
      ]
    },
    {
      "question":
          "She had to *reagree* with the decision, even though she changed her mind.\n\nFix the sentence:",
      "options": ["A) Disagree", "B) Preagree", "C) Unagree", "D) Misagree"],
      "correctIndex": 0,
      "feedback": [
        " Explanation: \"Disagree\" means to not agree — \"reagree\" isn't commonly used and doesn't make sense in this context.",
        " \"Preagree\" is not a standard word.",
        " \"Unagree\" is not correct usage.",
        " \"Misagree\" is not a proper word either."
      ]
    },
    {
      "question":
          "He felt *unpossible* winning the race after falling behind.\n\nFix the sentence:",
      "options": [
        "A) Impossible",
        "B) Dispossible",
        "C) Mispossible",
        "D) Prepossible"
      ],
      "correctIndex": 0,
      "feedback": [
        " Explanation: \"Impossible\" is the correct form using the prefix 'im-' meaning not possible.",
        " \"Dispossible\" is not standard English.",
        " \"Mispossible\" is not a real word.",
        " \"Prepossible\" is not a recognized word either."
      ]
    },
    {
      "question":
          "She decided to *dislike* the class after the first fun lesson.\n\nFix the sentence:",
      "options": ["A) Like", "B) Mislike", "C) Unlike", "D) Prelike"],
      "correctIndex": 0,
      "feedback": [
        " Explanation: \"Dislike\" means to not like — but the sentence says the class was fun, so \"like\" fits better. We don't need a prefix here.",
        " \"Mislike\" is not commonly used in modern English.",
        " \"Unlike\" means different from, not the opposite of liking.",
        " \"Prelike\" is not a real word."
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

    _highlightController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _highlightAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _highlightController, curve: Curves.easeInOut),
    );

    _startInactivityTimer();
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel();
    _glowController.dispose();
    _highlightController.dispose();
    super.dispose();
  }

  /// Renders question text with *asterisk* words highlighted in amber glow.
  Widget _buildHighlightedQuestion(String text) {
    final regex = RegExp(r'\*([^*]+)\*');
    final spans = <InlineSpan>[];
    int lastEnd = 0;

    const baseStyle = TextStyle(
      fontSize: 16,
      fontStyle: FontStyle.italic,
      color: Colors.black87,
    );

    for (final match in regex.allMatches(text)) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: baseStyle,
        ));
      }

      final word = match.group(1)!;
      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: AnimatedBuilder(
            animation: _highlightAnimation,
            builder: (context, _) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.22),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: Colors.amber.withOpacity(_highlightAnimation.value),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber
                          .withOpacity(0.35 * _highlightAnimation.value),
                      blurRadius: 10 * _highlightAnimation.value,
                      spreadRadius: 1.5 * _highlightAnimation.value,
                    ),
                  ],
                ),
                child: Text(
                  word,
                  style: baseStyle.copyWith(
                    color: Colors.orange.shade800,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              );
            },
          ),
        ),
      );

      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: baseStyle,
      ));
    }

    return RichText(
      text: TextSpan(children: spans),
    );
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
              backgroundColor: const Color(0xFFE0F7F4),
              titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              title: Row(
                children: const [
                  Icon(Icons.emoji_events,
                      color: Color(0xFF4DB6AC), size: 30),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Level Complete!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF00695C),
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
                      color: Color(0xFF00897B),
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
                    foregroundColor: const Color(0xFF00897B),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  label: const Text("Advance"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4DB6AC),
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
      backgroundColor: const Color(0xFFE0F7F4),
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
                        Color(0xFF4DB6AC)),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Choose the right option",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00695C),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Question card with highlighted word
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _buildHighlightedQuestion(question['question']),
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
                                  ? const Color(0xFF00695C)
                                  : const Color(0xFFD32F2F)),
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  selectedOptionIndex == correctIndex
                                      ? const Color(0xFF4DB6AC)
                                      : const Color(0xFFB2EBE5),
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
                                                color: const Color(0xFF4DB6AC)
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
                                          ? const Color(0xFF4DB6AC)
                                          : const Color(0xFF80CBC4),
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
                                    color: const Color(0xFF4DB6AC)),
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
    question: 'Match the word: Impossible',
    options: [
      "A) Not possible",
      "B) To make possible",
      "C) Possibly",
      "D) Before possible"
    ],
    correctIndex: 0,
    explanation:
        '✔️ Explanation: "Im-" means "not," so "impossible" means "not possible."',
    incorrectExplanations: [
      '✅',
      'Don\'t worry\'s is a common error',
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
  // ignore: unused_field
  bool _isProcessing = false;
  double _progressValue = 0.2;
  late AnimationController _animationController;

  // Blue color scheme (manteniendo los mismos colores)
  final Color _primaryColor = const Color(0xFF00897B);  // turquesa profundo
  final Color _darkBlue    = const Color(0xFF00695C);  // turquesa oscuro
  final Color _accentColor = const Color(0xFF4DB6AC);  // turquesa medio
  final Color _lightBlue   = const Color(0xFFB2EBE5);  // turquesa suave
  final Color _lightBlueBg = const Color(0xFFE0F7F4);  // turquesa muy claro
  final Color _softBlue    = const Color(0xFF80CBC4);  // turquesa medio-claro

  // Estados para las interacciones (simplificados)
  bool _step1Completed = false;
  // ignore: unused_field
  bool _step2Completed = false;
  bool _step3Completed = false;
  // ignore: unused_field
  bool _step4Completed = false;

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
          } else {
            _completeActivity();
          }
        });
      });
    });
  }

  Widget _buildProgressIndicator() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(
          begin: 0,
          end: _progressValue.clamp(0.0, 1.0),
        ),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        builder: (context, value, _) {
          return LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
            minHeight: 10,
          );
        },
      ),
    );
  }

  Widget _buildStep1() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 450),
            childAnimationBuilder: (child) => SlideAnimation(
              horizontalOffset: 30,
              child: FadeInAnimation(child: child),
            ),
            children: [
              /// TITLE
              Text(
                "📖 Step 1 · Explore the Word",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Change the highlighted word.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 12),
              _buildProgressIndicator(),
              const SizedBox(height: 22),

              /// MAIN CARD
              Card(
                elevation: 8,
                shadowColor: _primaryColor.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// INSTRUCTION
                      Text(
                        "👀 Observe this word",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 14),

                      /// WORD DISPLAY (INTERACTIVE)
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Tap idea: Some words look long, but they’re built from smaller parts 👀",
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 26,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                _primaryColor.withOpacity(0.9),
                                _accentColor.withOpacity(0.9),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: _primaryColor.withOpacity(0.25),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "IMPOSSIBLE",
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      /// THINKING PROMPTS
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightBlue.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "💭 Ask yourself:",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 8),
                            Text("• Does it look positive or negative?"),
                            Text("• Can you spot a smaller word inside?"),
                            Text("• What do you think it means?"),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),

                      /// DID YOU KNOW
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: _step1Completed
                            ? buildSuccessBox(
                                title: "Nice observation! 👏",
                                message:
                                    "Many long words are made of prefixes and roots. You’re ready for the next step.",
                              )
                            : Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: Colors.amber.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: Colors.amber),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.lightbulb_outline,
                                        color: Colors.amber),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        "Tip: You don’t need to know the meaning yet — just observe carefully.",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),

                      const SizedBox(height: 18),

                      /// CONFIRMATION
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          "I’ve explored the word and thought about it",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        value: _step1Completed,
                        onChanged: (value) {
                          setState(() {
                            _step1Completed = value ?? false;
                          });
                        },
                        activeColor: _primaryColor,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// NEXT STEP BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _step1Completed ? _nextStep : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: _primaryColor,
                    disabledBackgroundColor: _primaryColor.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    "Next: Learn About Prefixes ➜",
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

  Widget buildSuccessBox({
    required String title,
    required String message,
    IconData icon = Icons.check_circle,
    Color color = Colors.green,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedScale(
            duration: const Duration(milliseconds: 400),
            scale: 1.1,
            child: Icon(
              icon,
              color: color,
              size: 34,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _showPrefix = true;

  Widget _buildStep2() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 450),
            childAnimationBuilder: (child) => SlideAnimation(
              horizontalOffset: 30,
              child: FadeInAnimation(child: child),
            ),
            children: [
              /// TITLE
              Text(
                "🔤 Step 2 · Break the Word",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Words are built from smaller pieces. Let’s explore one.",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 12),
              _buildProgressIndicator(),
              const SizedBox(height: 22),

              /// MAIN CARD
              Card(
                elevation: 8,
                shadowColor: _primaryColor.withOpacity(0.25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// SECTION HEADER
                      Text(
                        "🧩 What is a prefix?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "A prefix is added at the beginning of a word to change its meaning.",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      ),

                      const SizedBox(height: 24),

                      /// PREFIX CARD
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: _lightBlue.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          children: [
                            /// PREFIX VISUAL (NO OVERFLOW)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: _primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: _primaryColor),
                              ),
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 12,
                                runSpacing: 8,
                                children: [
                                  Text(
                                    "im-",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: _primaryColor,
                                    ),
                                  ),
                                  const Icon(Icons.arrow_forward),
                                  const Text(
                                    "means “not”",
                                    style: TextStyle(fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 22),

                            /// TOGGLE INTERACTION
                            Text(
                              "🔄 Turn the prefix on / off",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: _darkBlue,
                              ),
                            ),
                            const SizedBox(height: 10),

                            SwitchListTile(
                              title: Text(
                                _showPrefix
                                    ? "Prefix ON → impossible"
                                    : "Prefix OFF → possible",
                              ),
                              value: _showPrefix,
                              activeColor: _primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _showPrefix = value;
                                });
                              },
                            ),

                            const SizedBox(height: 12),

                            /// WORD RESULT
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color:
                                      _showPrefix ? Colors.red : Colors.green,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  _showPrefix ? "IMPOSSIBLE" : "POSSIBLE",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                    color:
                                        _showPrefix ? Colors.red : Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 26),

                      /// MINI QUIZ
                      Text(
                        "🧠 Quick Question",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 12),

                      _quizOption("The word becomes negative", "correct"),
                      _quizOption("The word becomes plural", "wrong"),
                      _quizOption("The word changes tense", "wrong"),

                      const SizedBox(height: 20),

                      /// FEEDBACK
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: _selectedAnswer == "correct"
                            ? buildSuccessBox(
                                title: "🎉 Correct!",
                                message:
                                    "Prefixes often change the meaning of a word.",
                              )
                            : _selectedAnswer != null
                                ? Container(
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: const Text(
                                      "Not quite. Try again!",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// NEXT BUTTON
              if (_selectedAnswer == "correct")
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _nextStep,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      backgroundColor: _primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      "Next: Meaning in Context ➜",
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

  Widget _quizOption(String text, String value) {
    final bool selected = _selectedAnswer == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAnswer = value;
          _step2Completed = value == "correct";
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected
              ? _primaryColor.withOpacity(0.15)
              : Colors.grey.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? _primaryColor : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.check_circle : Icons.circle_outlined,
              color: selected ? _primaryColor : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(text)),
          ],
        ),
      ),
    );
  }

  Widget _wordPart(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 2),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildStep3() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 450),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 30,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              /// TITLE
              Text(
                "💭 Step 3: Think About Meaning",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              const SizedBox(height: 6),
              _buildProgressIndicator(),
              const SizedBox(height: 18),

              /// MAIN CARD
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// EXPLANATION
                      Text(
                        "What does \"Impossible\" mean?",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightBlue.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Think about what \"impossible\" means. What do we say when something cannot happen?",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 12),
                            Text(
                              "💤 Impossible means that something cannot be done or is not possible.",
                              style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      /// MEANING ANALYSIS
                      const Text(
                        "So, \"impossible\" directly means:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 12),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.green, width: 2),
                        ),
                        child: Center(
                          child: Text(
                            "\"not possible\"",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      /// REASONING
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightBlue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Why? Because:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text("• The prefix \"im-\" means \"not\""),
                            Text("• It negates the word \"possible\""),
                            Text("• So \"impossible\" = \"not possible\""),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      /// COMPREHENSION CHECK
                      CheckboxListTile(
                        title: const Text(
                            "I understand that \"impossible\" means \"not possible\""),
                        value: _step3Completed,
                        onChanged: (value) {
                          setState(() {
                            _step3Completed = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),

                      const SizedBox(height: 26),

                      /// FEEDBACK
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _step3Completed
                            ? buildSuccessBox(
                                title: "Great Thinking!",
                                message:
                                    "You've correctly identified the meaning of \"impossible\".",
                              )
                            : Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.orange),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.lightbulb_outline,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        "Remember: \"im-\" = \"not\", so \"impossible\" = \"not possible\"",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
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
              ),

              const SizedBox(height: 18),

              /// NEXT
              if (_step3Completed)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _nextStep,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      backgroundColor: _primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      "Test Your Knowledge ➡️",
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  "📝 Step 4: Choose the Answer",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _darkBlue,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),
              Card(
                elevation: 8,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [_primaryColor, _accentColor],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: _primaryColor.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Text(
                              "Final Test",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.quiz,
                            color: _primaryColor,
                            size: 28,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Now look at the answer choices and use what you figured out:",
                        style: TextStyle(
                          fontSize: 18,
                          color: _darkBlue,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "What does \"impossible\" mean?",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: _darkBlue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Answer Options
                      Column(
                        children: [
                          _buildAnswerOption(
                            "A) Not possible",
                            "A",
                            true,
                          ),
                          _buildAnswerOption(
                            "B) To make possible",
                            "B",
                            false,
                          ),
                          _buildAnswerOption(
                            "C) Possibly",
                            "C",
                            false,
                          ),
                          _buildAnswerOption(
                            "D) Before possible",
                            "D",
                            false,
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // Feedback Area
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _selectedAnswer == null
                            ? Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.blue),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.help, color: _primaryColor),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        "Select the correct answer based on what you learned",
                                        style: TextStyle(
                                          color: _darkBlue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : _selectedAnswer == "A"
                                ? buildSuccessBox(
                                    title: "✅ Correct!",
                                    message:
                                        "Yes! \"Not possible\" matches the meaning of \"impossible.\"",
                                    color: Colors.green,
                                  )
                                : Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.red),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.close,
                                            color: Colors.red),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            _selectedAnswer == "B"
                                                ? "This would mean the opposite of impossible, but it doesn't fit. ✗"
                                                : _selectedAnswer == "C"
                                                    ? "Means \"maybe,\" but it's not the same as \"impossible.\" ✗"
                                                    : "Doesn't make sense in this context. ✗",
                                            style: TextStyle(
                                              color: Colors.red[800],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                      ),

                      const SizedBox(height: 30),

                      // Explanation
                      if (_selectedAnswer != null)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _lightBlue.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Explanation:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "\"impossible\" means \"not possible,\" because the prefix \"im-\" means \"not,\" and it negates the word \"possible.\"",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Next Button
              if (_selectedAnswer == "A") ...[
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: _primaryColor.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 32,
                      ),
                      backgroundColor: _primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    onPressed: _nextStep,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "See Final Summary ➡️",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.arrow_forward, size: 22),
                      ],
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

  Widget _buildAnswerOption(String text, String value, bool isCorrect) {
    final isSelected = _selectedAnswer == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAnswer = value;
          if (isCorrect) {
            _step4Completed = true;
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          elevation: isSelected ? 4 : 2,
          color: isSelected
              ? (isCorrect
                  ? Colors.green.withOpacity(0.95)
                  : Colors.red.withOpacity(0.95))
              : Colors.white,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? (isCorrect ? Colors.green : Colors.red)
                    : Colors.grey[300]!,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? Colors.white
                        : (isCorrect
                            ? Colors.green.withOpacity(0.2)
                            : Colors.red.withOpacity(0.2)),
                    border: Border.all(
                      color: isSelected
                          ? (isCorrect ? Colors.green : Colors.red)
                          : _primaryColor,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? (isCorrect ? Colors.green[800] : Colors.red[800])
                            : _darkBlue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(
                    isCorrect ? Icons.check_circle : Icons.cancel,
                    color: isCorrect ? Colors.green : Colors.red,
                  ),
              ],
            ),
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
            "🏆 Final Analysis",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _darkBlue,
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
                    "✅ Final Answer:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // RESPUESTA
                  Text(
                    "A) Not possible",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue,
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
                      color: _darkBlue,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // LISTA EXPLICATIVA
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
                              "The word \"impossible\" is made of two parts: \"im-\" + \"possible\"\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "\"im-\" is a prefix that means \"not\" or \"opposite of\" (like in indirect, imperfect)\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "When we add \"im-\" to \"possible,\" it becomes \"not possible\"",
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 32),

                  // Visual Breakdown
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _lightBlue.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _primaryColor),
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _wordPart("im-", _primaryColor),
                        Icon(Icons.add, color: _darkBlue, size: 28),
                        _wordPart("possible", _primaryColor),
                        Icon(Icons.equalizer, color: _darkBlue, size: 28),
                        _wordPart("not possible", Colors.green),
                      ],
                    ),
                  ),

                  const Divider(height: 32),

                  // Examples
                  Text(
                    "Examples:",
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
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("• It's impossible to fly without wings."),
                        Text("• Finding a unicorn is impossible."),
                        Text("• Completing this in 5 minutes is impossible!"),
                      ],
                    ),
                  ),

                  const Divider(height: 32),

                  // Strategy Summary
                  Text(
                    "Strategy Used:",
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
                    child: Row(
                      children: [
                        Icon(Icons.text_fields, color: _primaryColor),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            "Prefix Analysis + Word Breakdown: Breaking words into parts to understand meaning",
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

          const SizedBox(height: 16),

          // ----------- BOTÓN FINAL ----------------
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
                backgroundColor: Colors.green,
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
  Widget _summaryBox(String text, Color color, String subtitle) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  void _completeActivity() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ThirdActyvityAnimation(),
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
    '💡 General Hint: Think about the prefix "mis-" and what it usually means in other words.',
    '📌 More Specific: Focus on the meaning of "lead" and how it could be done wrongly.',
    '🧐 Little Explanation: Which word means to lead in the wrong way?'
  ];

  final List<String> hints2 = [
    '💡 General Hint: Focus on the opposite of agreeing.',
    '📌 More Specific: Think about \'dis-\' meaning not."',
  ];

  final List<String> hints3 = [
    '💡 General Hint: Think about \'pre-\' meaning before.',
    '📌 More Specific: Which word means to heat something in advance?',
    '🧐 Little Explanation: Focus on the action of heating something before use.'
  ];

  final List<String> hints4 = [
    '💡 General Hint: Think about \'un-\' meaning to reverse or undo something.',
    '📌 More Specific: Focus on the action of removing something, like wrapping.',
    '🧐 Little Explanation: Which option means to remove the wrapping from something?'
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Match the word: Mislead\n\nWhat does 'mislead' most likely mean?",
      "options": [
        "A) To lead again",
        "B) To lead wrongly",
        "C) To agree",
        "D) To lead before"
      ],
      "correctIndex": 1,
      "feedback": [
        " 'To lead again' is not correct — the prefix 'mis-' does not mean again.",
        " Explanation: 'Mis-' means 'wrong,' so 'mislead' means to lead wrongly.",
        " 'To agree' is unrelated to the word 'lead.'",
        " 'To lead before' is not supported by any known prefix or context."
      ]
    },
    {
      "question":
          "Match the word: Disagree\n\nWhat does 'disagree' most likely mean?",
      "options": [
        "A) To agree again",
        "B) To agree",
        "C) To partially agree",
        "D) To not agree"
      ],
      "correctIndex": 3,
      "feedback": [
        " 'To agree again' would imply repetition, but 'dis-' means not.",
        "'To agree' is the opposite of what 'disagree' means.",
        " 'To partially agree' is too specific and not what 'disagree' means.",
        " Explanation: 'Dis-' means 'not,' so 'disagree' means 'to not agree.'"
      ]
    },
    {
      "question":
          "Match the word: Preheat\n\nWhat does 'preheat' most likely mean?",
      "options": [
        "A) To cool down",
        "B) To heat before use",
        "C) To stop heating",
        "D) To heat after use"
      ],
      "correctIndex": 1,
      "feedback": [
        " 'To cool down' is the opposite of heating.",
        " Explanation: 'Pre-' means 'before,' so 'preheat' means to heat something before use.",
        " 'To stop heating' doesn’t relate to the prefix or context.",
        " 'To heat after use' doesn’t make logical sense."
      ]
    },
    {
      "question":
          "Match the word: Unwrap\n\nWhat does 'unwrap' most likely mean?",
      "options": [
        "A) To wrap again",
        "B) To remove the wrapping",
        "C) To add more wrapping",
        "D) To gift wrap"
      ],
      "correctIndex": 1,
      "feedback": [
        " 'To wrap again' would be 'rewrap,' not 'unwrap.'",
        " Explanation: 'Un-' means reverse action, so 'unwrap' means to remove the wrapping.",
        " 'To add more wrapping' is not correct — that's 'double wrap' or similar.",
        " 'To gift wrap' is unrelated to the meaning of the prefix 'un-'."
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
                      MaterialPageRoute(builder: (context) => const FinalPart1()),
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

class FinalPartSummary extends StatelessWidget {
  const FinalPartSummary({super.key});

  Future<void> _completeFinalLevel(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // 🔥 Guarda en Firestore el paso básico
    await FirebaseFirestore.instance
        .collection('userProgress')
        .doc(user.uid)
        .set({'completedInstructionSpot2_1': true}, SetOptions(merge: true));

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
      'completedInstructionSpot2_1': true, // Repetido por seguridad
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
              Color(0xFFE0F7F4), // aguamarina muy claro
              Color(0xFFB2EBE5), // aguamarina suave
              Color(0xFF80CBC4), // aguamarina medio
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
                  color: Color(0xFF4DB6AC), // aguamarina acento
                ),
                const SizedBox(height: 12),
                const Text(
                  "Great job with prefixes! Keep up the fantastic work, and you'll be a pro in no time! 🌟🩵",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00695C), // aguamarina oscuro
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Card(
                  elevation: 0,
                  color: Colors.white.withOpacity(0.85),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: const Color(0xFF4DD0C4).withOpacity(0.4),
                      width: 1.5,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "To sum up...\n\nRecognizing prefixes helps you make quick, accurate guesses about new words. \n\n💠It's one more way inferring makes learning vocabulary easier and smarter!",
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.5,
                        color: Color(0xFF1F2937),
                      ),
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
                      backgroundColor: const Color(0xFF00897B), // aguamarina profundo
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
