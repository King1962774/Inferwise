// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_2/Animation2_2.dart';
import 'package:inferwise/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: unused_import
import 'package:animations/animations.dart';

class InstructionSpotPage4 extends StatefulWidget {
  final String title;
  final List<String> instructions;
  final String tipTitle;
  final List<String> tips;
  final String finalNote;

  const InstructionSpotPage4({
    super.key,
    required this.title,
    required this.instructions,
    required this.tipTitle,
    required this.tips,
    required this.finalNote,
  });

  @override
  State<InstructionSpotPage4> createState() => _InstructionSpotPage4State();
}

class _InstructionSpotPage4State extends State<InstructionSpotPage4> {
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
      'suffix': '-ness',
      'text': 'Kind + ness → Kindness\n(the state of being kind)',
      'image': 'assets/Imagenes de ejemplos/Level2/2.3 A Kindness.webp',
    },
    {
      'title': 'Example 2',
      'suffix': '-hood',
      'text': 'Brother + hood → Brotherhood\n(the bond of brothers)',
      'image': 'assets/Imagenes de ejemplos/Level2/2.3 B Brotherhood.webp',
    },
    {
      'title': 'Example 3',
      'suffix': '-ly',
      'text': 'Slow + ly → Slowly\n(in a slow way)',
      'image': 'assets/Imagenes de ejemplos/Level2/2.3 C Slowly.webp',
    },
    {
      'title': 'Example 4',
      'suffix': '-er',
      'text': 'Teach + er → Teacher\n(a person who teaches)',
      'image': 'assets/Imagenes de ejemplos/Level2/2.3 D Teacher.webp',
    },
    {
      'title': 'Example 5',
      'suffix': '-able',
      'text': 'Wash + able → Washable\n(can be washed)',
      'image': 'assets/Imagenes de ejemplos/Level2/2.3 E Washable.webp',
    },
    {
      'title': 'Example 6',
      'suffix': '-less',
      'text': 'Hope + less → Hopeless\n(without hope)',
      'image': 'assets/Imagenes de ejemplos/Level2/2.3 F Hopeless.webp',
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
            // Content first
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title badge + suffix pill
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
                          example['suffix']!,
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
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(24)),
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
                      "Identifying Suffixes",
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
                    '🔎 What is a Suffix?\n\nA suffix is added to the end of a word to change its meaning or function.',
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
      'body': 'Word: "Kindness"',
    },
    {
      'title': '🔵 2. Identify the Suffix',
      'body': 'Suffix to analyze: "-ness" 💠',
    },
    {
      'title': '🔵 3. Know the Meaning of the Suffix',
      'body': '"-ness" means "the state or quality of being" something.',
    },
    {
      'title': '🔵 4. Combine the Suffix with the Base Word',
      'body': '"Kind" + "-ness" = "The state of being kind."',
    },
    {
      'title': '🔵 5. Confirm with Context',
      'body': '"Kindness" fits when talking about the quality of being nice or considerate.',
    },
    {
      'title': '➡️ Identifying Suffixes',
      'body': '"Kindness" means "the state of being kind" because the suffix "-ness" shows a quality or state.',
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

                // Context Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.65),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: const Color(0xFF4DD0C4).withOpacity(0.4),
                        width: 1.5),
                  ),
                  child: const Text(
                    'Let\'s identify suffixes in the next word:',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 15,
                      color: Color(0xFF00695C),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),

                Center(
                  child: Text(
                    "✩ How to do it? ✩",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF00695C),
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
                          isLast ? "Finish" : "Next",
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F7F4), // aguamarina muy claro
              Color(0xFFB2EBE5), // aguamarina suave
              Color(0xFF80CBC4), // aguamarina medio
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: const Color(0xFF4DD0C4).withOpacity(0.5),
                    width: 1.5,
                  ),
                ),
                color: Colors.white.withOpacity(0.88),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '🔍 Remember',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00695C),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Readers figure out the meaning of words by recognizing patterns like suffixes. These word endings give us clues about how a word is used or what it means.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        '📚 Examples:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF00897B),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildExample(
                        sentence: 'Dark + ness → Darkness',
                        inference: '(the state of being dark)',
                      ),
                      _buildExample(
                        sentence: 'Neighbor + hood → Neighborhood',
                        inference: '(the area or community of neighbors)',
                      ),
                      _buildExample(
                        sentence: 'Child + hood → Childhood',
                        inference: '(period of being a child)',
                      ),
                      _buildExample(
                        sentence: 'Quick + ly → Quickly',
                        inference: '(in a fast manner)',
                      ),
                      _buildExample(
                        sentence: 'Build + er → Builder',
                        inference: '(a person who builds)',
                      ),
                      _buildExample(
                        sentence: 'Comfort + able → Comfortable',
                        inference: '(easy to be in or use)',
                      ),
                      _buildExample(
                        sentence: 'Care + less → Careless',
                        inference: '(without care or caution)',
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(14),
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
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '🔷 Recognizing suffixes helps you understand a word\'s meaning and function more easily!',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF00695C),
                                  fontWeight: FontWeight.w600,
                                  height: 1.4,
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
              const SizedBox(height: 16),
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
                  icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  label: const Text(
                    'Next',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 24),
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
                      color: Color(0xFF00695C),
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
    '🔷 2. Identify the suffix (e.g., "-ness").',
    '🔷 3. Know the meaning of the suffix (e.g., "-ness" means "the state of being").',
    '🔷 4. Combine the suffix with the base word (e.g., "kindness" = "the state of being kind").',
    '🔷 5. Confirm with context to ensure the inferred meaning fits.',
    '➡️ Inference: Use the suffix to guess the word\'s meaning.',
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
                  itemCount: steps.length, // ✅ fixed: removed +1
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
        'Complete the sentence\n\nShe handled the situation with great _______.',
    options: ["A) Kinder", "B) Kindly", "C) Kindful", "D) Kindness"],
    correctIndex: 3,
    explanation: '✔️ Explanation: “Kindness” means the quality of being kind.',
    incorrectExplanations: [
      'Don\'t worry\'s is a common error',
      'Don\'t worry\'s is a common error',
      'Don\'t worry\'s is a common error',
      '✅',
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
  bool? _confirmationAnswer;

  // Blue color scheme matching your preference
  final Color _primaryColor = const Color(0xFF00897B);  // turquesa profundo
  final Color _darkBlue    = const Color(0xFF00695C);
  final Color _lightBlue   = const Color(0xFFB2EBE5);  // turquesa suave
  final Color _softBlue    = const Color(0xFF80CBC4);  // turquesa medio-claro


  // Interactive states

  final Set<String> _correctClues = {
    "D) someonoe’s manner of handling a situation"
  };

  // ignore: unused_field
  bool _sentenceAnalyzed = true;
  List<String> _selectedClues = [];
  final Map<String, bool> _suffixAnalysis = {
    'Kinder': false,
    'Kindly': false,
    'Kindful': false,
    'Kindness': true,
  };

  bool _isCorrect = false;

  // Interactive animation
  bool _handlingAnimation = false;
  bool _suffixAnimation = false;

  bool _suffixExplained = false;

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
    _sentenceAnalyzed = true;
    _selectedClues = [];
    _suffixAnalysis.forEach((key, value) {
      _suffixAnalysis[key] = false;
    });
    _handlingAnimation = false;
    _suffixAnimation = false;
    _selectedAnswer = null;
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

              // ================= INTERACTIVE SENTENCE CARD =================
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_lightBlue, Colors.white],
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // HANDLING
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _handlingAnimation = !_handlingAnimation;
                            });
                          },
                          child: AnimatedScale(
                            scale: _handlingAnimation ? 1.1 : 1.0,
                            duration: const Duration(milliseconds: 300),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _handlingAnimation
                                    ? _lightBlue
                                    : Colors.white,
                                border:
                                    Border.all(color: _primaryColor, width: 3),
                                boxShadow: _handlingAnimation
                                    ? [
                                        BoxShadow(
                                          color: Colors.blue.withOpacity(0.4),
                                          blurRadius: 12,
                                        )
                                      ]
                                    : [],
                              ),
                              child: Icon(
                                Icons.psychology,
                                size: 50,
                                color: _handlingAnimation
                                    ? Colors.blue
                                    : _darkBlue,
                              ),
                            ),
                          ),
                        ),

                        // SUFFIX
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _suffixAnimation = !_suffixAnimation;
                            });
                          },
                          child: AnimatedScale(
                            scale: _suffixAnimation ? 1.1 : 1.0,
                            duration: const Duration(milliseconds: 300),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _suffixAnimation
                                    ? _lightBlue
                                    : Colors.white,
                                border:
                                    Border.all(color: _primaryColor, width: 3),
                                boxShadow: _suffixAnimation
                                    ? [
                                        BoxShadow(
                                          color: Colors.green.withOpacity(0.4),
                                          blurRadius: 12,
                                        )
                                      ]
                                    : [],
                              ),
                              child: Icon(
                                Icons.text_increase,
                                size: 50,
                                color:
                                    _suffixAnimation ? Colors.green : _darkBlue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Complete the sentence",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: _darkBlue,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _lightBlue.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _primaryColor),
                      ),
                      child: Text(
                        "She handled the situation with great _____.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                          color: _darkBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (_handlingAnimation && _suffixAnimation)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.emoji_events, color: Colors.amber),
                            SizedBox(width: 8),
                            Text(
                              "Concept unlocked!",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // ================= CONTEXT CLUES =================
              Card(
                elevation: 6,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is the sentence about?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _buildClueButton(
                              "A) someone’s weakness in dealing with problems"),
                          _buildClueButton("B) Someone's power over others"),
                          _buildClueButton(
                              "C) someone's effort to avoid conflict"),
                          _buildClueButton(
                              "D) someonoe’s manner of handling a situation"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // ================= NEXT STEP =================
                            const SizedBox(height: 20),
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
                    "Understand Suffixes ➡️",
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

  Widget _buildClueButton(String text) {
    final isSelected = _selectedClues.contains(text);
    final isCorrect = _correctClues.contains(text);

    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 80, // evita overflow
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (isSelected) {
                  _selectedClues.remove(text);
                } else {
                  _selectedClues.add(text);
                }
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? (isCorrect
                        ? Colors.green.withOpacity(0.15)
                        : Colors.red.withOpacity(0.15))
                    : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? (isCorrect ? Colors.green : Colors.red)
                      : Colors.grey[300]!,
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max, // 🔥 ocupa el ancho permitido
                children: [
                  Expanded(
                    // 🔥 permite que el texto haga wrap
                    child: Text(
                      text,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  if (isSelected) ...[
                    const SizedBox(width: 8),
                    Icon(
                      isCorrect ? Icons.check_circle : Icons.cancel,
                      size: 18,
                      color: isCorrect ? Colors.green : Colors.red,
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
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
                "🔍 Step 2: Understand Suffixes",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),

              // ================= SUFFIX DEFINITION =================
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
                        "What are suffixes?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _suffixExplained = !_suffixExplained;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _lightBlue.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: _primaryColor),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.language, color: _primaryColor),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Tap to reveal definition",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: _darkBlue,
                                    ),
                                  ),
                                ],
                              ),
                              if (_suffixExplained) ...[
                                const SizedBox(height: 10),
                                const Text(
                                  "Suffixes are letters added to the end of a word.\n\nThe suffix -ness turns adjectives into nouns that describe a quality or state.",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ]
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ================= READING PANEL =================
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
                        "📖 Reading Panel: Word Meanings",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Read how different suffixes change the meaning of the word “kind”:",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      _buildReadingItem(
                        word: "Kinder",
                        meaning:
                            "The comparative form of kind. The suffix -er means “more,” so kinder means “more kind.” This is an adjective.",
                      ),
                      _buildReadingItem(
                        word: "Kindly",
                        meaning:
                            "The suffix -ly turns kind into an adverb, meaning “in a kind way.”",
                      ),
                      _buildReadingItem(
                        word: "Kindful",
                        meaning:
                            "The suffix -ful usually means “full of,” but kindful is not a standard word in English.",
                      ),
                      _buildReadingItem(
                        word: "Kindness",
                        meaning:
                            "The suffix -ness turns the adjective kind into the noun kindness, meaning the quality of being kind.",
                      ),
                    ],
                  ),
                ),
              ),

              // ================= NEXT STEP =================
              Padding(
                padding: const EdgeInsets.only(top: 20),
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
                      "Combine Context + Grammar ➡️",
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

  Widget _buildReadingItem({
    required String word,
    required String meaning,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _lightBlue.withOpacity(0.15),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _primaryColor.withOpacity(0.6)),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$word: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _darkBlue,
              ),
            ),
            TextSpan(
              text: meaning,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ],
        ),
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
              horizontalOffset: 50.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              Text(
                "🤔 Step 3: Combine Context + Grammar",
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
                        "Key Takeaways",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Combined Analysis Cards
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightBlue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _primaryColor),
                        ),
                        child: Column(
                          children: [
                            _buildAnalysisCard(
                              "Context Analysis",
                              "The sentence needs a word to describe HOW she handled the situation.",
                            ),

                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      const SizedBox(height: 25),

                      Text(
                        "Which option makes the most sense?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 15),

                      _buildLogicOption(
                        "A) Kinder  ",
                        false,
                      ),
                      _buildLogicOption(
                        "B) Kindly",
                        false,
                      ),
                      _buildLogicOption(
                        "C) Kindful ",
                        false,
                      ),
                      _buildLogicOption(
                        "D) Kindness",
                        true,
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
                                        ? "✅ Perfect Analysis!"
                                        : "💡 Re-evaluate...",
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
                                _confirmationAnswer == true
                                    ? "Correct! 'Kindness' is the only noun that fits grammatically and contextually."
                                    : "Think about what part of speech follows 'with great'.",
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
                    "Complete the Sentence ➡️",
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

  Widget _buildAnalysisCard(String title, String description) {
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
          child: Icon(Icons.analytics, color: _primaryColor),
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
                  color: _darkBlue,
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

  Widget _buildLogicOption(String text, bool isCorrect) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: _lightBlue.withOpacity(0.5)),
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
            color: _darkBlue,
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
                "✍️ Step 4: Choose the Right Word",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),

              /// CARD PRINCIPAL
              Card(
                elevation: 6,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Complete the sentence:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 20),

                      /// SENTENCE
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightBlue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _primaryColor),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "She handled the situation",
                              style: TextStyle(fontSize: 20, color: _darkBlue),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                Text(
                                  "with great",
                                  style:
                                      TextStyle(fontSize: 20, color: _darkBlue),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeOutBack,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _isCorrect
                                            ? Colors.green
                                            : _primaryColor,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: _isCorrect
                                          ? [
                                              BoxShadow(
                                                color: Colors.green
                                                    .withOpacity(0.4),
                                                blurRadius: 12,
                                                spreadRadius: 2,
                                              )
                                            ]
                                          : [],
                                    ),
                                    child: Center(
                                      child: AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            _selectedAnswer == "D"
                                                ? "KINDNESS"
                                                : "______",
                                            key: ValueKey<String?>(
                                                _selectedAnswer),
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: _selectedAnswer == "D"
                                                  ? Colors.green
                                                  : _darkBlue,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(".",
                                    style: TextStyle(
                                        fontSize: 20, color: _darkBlue)),
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

                      _buildFinalOption("Kinder", "A", false),
                      _buildFinalOption("Kindly", "B", false),
                      _buildFinalOption("Kindful", "C", false),
                      _buildFinalOption("Kindness", "D", true),
                      /// FEEDBACK
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _selectedAnswer == null
                            ? const SizedBox()
                            : _isCorrect
                                ? Padding(
                                    key: const ValueKey("correct"),
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.emoji_events,
                                            color: Colors.green),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            "Excellent! You chose the correct noun.",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    key: const ValueKey("wrong"),
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.lightbulb,
                                            color: Colors.orange),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            "Hint: after 'with great' we need a noun.",
                                            style: TextStyle(fontSize: 16),
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

              /// BOTÓN FINAL
              SizedBox(
                width: double.infinity,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _isCorrect ? 1 : 0.4,
                  child: ElevatedButton(
                    onPressed: _isCorrect ? _nextStep : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      backgroundColor: _primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Reveal Final Answer ➡️",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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

  Widget _buildFinalOption(String text, String option, bool isCorrect) {
    final bool isSelected = _selectedAnswer == option;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
        onTap: _isCorrect
            ? null
            : () {
                setState(() {
                  _selectedAnswer = option;
                  _isCorrect = isCorrect;
                });

                if (isCorrect) {
                  HapticFeedback.mediumImpact();
                } else {
                  HapticFeedback.lightImpact();
                }
              },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: isSelected
                    ? (isCorrect ? Colors.green : Colors.orange)
                    : _lightBlue,
                child: Text(option,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 16),
              Expanded(child: Text(text)),
              if (isSelected)
                Icon(
                  isCorrect ? Icons.check_circle : Icons.cancel,
                  color: isCorrect ? Colors.green : Colors.orange,
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
                    "✅ Final Answer:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Answer
                  Text(
                    "D) Kindness",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue,
                    ),
                    textAlign: TextAlign.left,
                  ),

                  const Divider(height: 32),

                  // Explanation Title
                  Text(
                    "Explanation:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Explanation List
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
                              "The suffix -ness turns the adjective 'kind' into the noun 'kindness'.\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "'Kindness' refers to the quality or state of being kind.\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "This fits perfectly in the sentence about how she handled the situation.",
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
                            "Suffix Strategy: Understanding how -ness forms nouns from adjectives",
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
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              onPressed: () {
                _completeActivity();
              },
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
            colors: [_lightBlue, _softBlue, const Color(0xFF90CAF9)],
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
    '💡 General Hint: Focus on the action word for how something is done, like walking.',
    '📌 More Specific: Which word describes the manner in which someone walks?',
  ];

  final List<String> hints2 = [
    '💡 General Hint: Think about a word that represents a bond or unity between people, especially in a team.',
    '📌 More Specific: Which word describes a shared connection, often between close friends or members of a group?',
  ];

  final List<String> hints3 = [
    '💡 General Hint: Think about a word that means lacking hope or feeling despair.',
    '📌 More Specific: Which word describes a state of being without hope, often after repeated failures?',
  ];

  final List<String> hints4 = [
    '💡 General Hint: Think about a word that describes something that can be cleaned or washed.',
    '📌 More Specific: Which word means that these shoes can be cleaned easily?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question": "My grandmother walks very ______ because of her age.",
      "options": ["A) Slowly", "B) Slow", "C) Slowness", "D) Slowful"],
      "correctIndex": 0,
      "feedback": [
        " Explanation: “Slowly” describes how she walks — it’s an adverb.",
        " “Slow” is an adjective, not an adverb, so it doesn’t fit.",
        " “Slowness” is a noun, not correct in this sentence.",
        " “Slowful” is not a real word."
      ]
    },
    {
      "question": "We all felt a sense of ______ among the team.",
      "options": [
        "A) Brotherhood",
        "B) Brotherly",
        "C) Brothering",
        "D) Brotherer"
      ],
      "correctIndex": 0,
      "feedback": [
        " Explanation: “Brotherhood” refers to a strong bond or unity between men.",
        " “Brotherly” is an adjective, doesn’t fit after 'sense of'.",
        " “Brothering” is not commonly used and incorrect here.",
        " “Brotherer” is not a real word."
      ]
    },
    {
      "question": "After so many failures, she started to feel ______.",
      "options": ["A) Hoper", "B) Hopely", "C) Hopelessly", "D) Hopeless"],
      "correctIndex": 3,
      "feedback": [
        " “Hoper” is not a standard noun.",
        " “Hopely” is not a real word.",
        " “Hopelessly” is an adverb, not the correct form here.",
        " Explanation: “Hopeless” means feeling without hope."
      ]
    },
    {
      "question": "These shoes are ______, so you can clean them easily.",
      "options": ["A) Washing", "B) Washer", "C) Washable", "D) Washness"],
      "correctIndex": 2,
      "feedback": [
        " “Washing” is a verb form, not appropriate here.",
        " “Washer” refers to a person or machine that washes.",
        " Explanation: “Washable” means something that can be washed.",
        " “Washness” is not a real word."
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
        'I don\'t like *hopely* movies — they make me sad.\n\nFix the sentence.',
    options: ["A) Hopeless", "B) Hopeful", "C) Hopelessly", "D) Hopeness"],
    correctIndex: 0,
    explanation:
        ' Explanation: "Hopeless" correctly describes the kind of movies.',
    incorrectExplanations: [
      '',
      'Don\'t worry\'s is a common error',
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

class WordOption {
  final String id;
  final String title;
  final bool isCorrect;
  final String explanation;

  const WordOption({
    required this.id,
    required this.title,
    required this.isCorrect,
    required this.explanation,
  });
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
  double _progressValue = 0.2;
  late AnimationController _animationController;
  // ignore: unused_field
  bool? _confirmationAnswer;
  // ignore: unused_field
  final bool _isCorrectAnswer = false;

  // Blue color scheme matching your preference
  final Color _primaryColor    = const Color(0xFF00897B); // turquesa profundo
  final Color _darkBlue        = const Color(0xFF00695C); // turquesa oscuro
  final Color _lightBlue       = const Color(0xFFB2EBE5); // turquesa suave
  final Color _backgroundLight = const Color(0xFFE0F7F4); // turquesa muy claro
  // ignore: unused_field
  final Color _backgroundDark  = const Color(0xFF80CBC4); // turquesa medio
  final Color _softBlue        = const Color(0xFF4DD0C4); // turquesa acento

  // Interactive states

  String? _selectedAnswerStep1;
  bool _isAnswerCorrect = false;
  // ignore: unused_field
  final bool _checkedAnySuffix = false;

  final Map<String, Map<String, dynamic>> _step1Answers = {
    "Hating action movies": {
      "correct": false,
      "feedback": "The sentence does not mention action movies specifically.",
    },
    "Inspirational movies": {
      "correct": false,
      "feedback":
          "Inspirational movies usually make people feel hopeful, not sad.",
    },
    "Sad or negative movies": {
      "correct": true,
      "feedback": "Correct! These movies create sadness or negative emotions.",
    },
    "Personal sadness": {
      "correct": false,
      "feedback":
          "The sentence focuses on the movies, not the speaker’s personal life.",
    },
  };

  // ignore: unused_field
  bool _sentenceAnalyzed = false;
  final Map<String, bool> _suffixAnalysis = {
    'Hopeless': true,
    'Hopeful': false,
    'Hopelessly': false,
    'Hopeness': false,
  };

  // ignore: unused_field
  bool _suffixHighlight = false;

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
    _sentenceAnalyzed = false;
    _suffixAnalysis.forEach((key, value) {
      _suffixAnalysis[key] = false;
    });
    _suffixHighlight = false;
    _selectedAnswer = null;
    _confirmationAnswer = null;
  }

  Widget _buildProgressIndicator() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0,
        end: _progressValue.clamp(0.0, 1.0),
      ),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 8,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation(_primaryColor),
          ),
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
              horizontalOffset: 50,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              Text(
                "🎬 Step 1: Understand the Sentence",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),
              _buildSentenceCard(),
              _infoCard(
                icon: Icons.search,
                title: "What should you focus on?",
                content:
                    "Pay attention to the emotion caused by the movies, not the type of movies themselves.",
                color: Colors.blue,
              ),
              _highlightCard(),
              Card(
                elevation: 6,
                color: _backgroundLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: _primaryColor.withOpacity(0.3)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is the sentence mainly about?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        children: _step1Answers.keys.map((answer) {
                          return _buildAnswerOptionStep1(answer);
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: _selectedAnswerStep1 == null
                            ? const SizedBox()
                            : _feedbackBox(),
                      ),
                    ],
                  ),
                ),
              ),
              if (_isAnswerCorrect) ...[
                const SizedBox(height: 20),
                _infoCard(
                  icon: Icons.school,
                  title: "Why this answer works",
                  content:
                      "The phrase 'they make me sad' describes the emotional effect of the movies. This tells us the movies are negative or depressing.",
                  color: Colors.green,
                ),
              ],
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isAnswerCorrect ? _nextStep : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 18),
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

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String content,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _darkBlue,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  content,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _highlightCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _primaryColor.withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "KEY CLUE",
            style: TextStyle(
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(fontSize: 18, color: _darkBlue),
              children: [
                const TextSpan(text: "The phrase "),
                TextSpan(
                  text: "\"make me sad\"",
                  style: TextStyle(
                    backgroundColor: Colors.yellow.withOpacity(0.3),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const TextSpan(text: " is the most important part!"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _feedbackBox() {
    final feedback = _step1Answers[_selectedAnswerStep1]!["feedback"];
    final isCorrect = _step1Answers[_selectedAnswerStep1]!["correct"];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCorrect ? Colors.green : Colors.red,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isCorrect ? Icons.check_circle : Icons.error,
            color: isCorrect ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              feedback,
              style: TextStyle(
                color: isCorrect ? Colors.green[800] : Colors.red[800],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerOptionStep1(String text) {
    final bool isSelected = _selectedAnswerStep1 == text;
    final bool isCorrect = _step1Answers[text]!["correct"];

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAnswerStep1 = text;
          _isAnswerCorrect = isCorrect;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect
                  ? Colors.green.withOpacity(0.15)
                  : Colors.red.withOpacity(0.15))
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? (isCorrect ? Colors.green : Colors.red)
                : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? (isCorrect ? Icons.check_circle : Icons.cancel)
                  : Icons.help_outline,
              color: isSelected
                  ? (isCorrect ? Colors.green : Colors.red)
                  : _darkBlue,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: _darkBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSentenceCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _lightBlue.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _primaryColor, width: 2),
      ),
      child: Text(
        "I don't like _____ movies — they make me sad.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
          color: _darkBlue,
        ),
      ),
    );
  }

  // --- UPDATED STEP 2 ---

  Widget _buildStep2() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 30),
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
                "🔍 Step 2: Master the Suffixes",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),

              // Reading Panel for Suffixes
              _buildSuffixReadingPanel(),

              const SizedBox(height: 20),

              // Root Word and Options Panel
              _buildRootWordAnalysisPanel(),

              const SizedBox(height: 30),

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Continue to Final Step ➡️",
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

  Widget _buildSuffixReadingPanel() {
    return Card(
      elevation: 4,
      color: _backgroundLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: _primaryColor.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Use what you know about suffixes.",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _darkBlue,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Suffixes help show a word’s meaning or role in a sentence. Here’s what to focus on:",
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
            const SizedBox(height: 16),
            _suffixDefinitionRow("-less", "without"),
            _suffixDefinitionRow("-ful", "full of"),
            _suffixDefinitionRow("-ly", "in a ... way"),
            _suffixDefinitionRow("-ness", "quality of …"),
          ],
        ),
      ),
    );
  }

  Widget _suffixDefinitionRow(String suffix, String meaning) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              suffix,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _primaryColor,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            "= $meaning",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildRootWordAnalysisPanel() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 18, color: Colors.black87),
                children: [
                  const TextSpan(text: "Now look at the root word: "),
                  TextSpan(
                    text: "hope",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _primaryColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "We want a word that describes the kind of movie — so we need an adjective (a describing word).",
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const Divider(height: 30),
            Text(
              "Let’s check the choices:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _darkBlue,
              ),
            ),
            const SizedBox(height: 16),
            _choiceExplanationRow("A) Hopeless",
                "means “without hope,” which fits perfectly with sad movies."),
            _choiceExplanationRow("B) Hopeful",
                "means “full of hope,” which is the opposite of a movie that make people sad."),
            _choiceExplanationRow("C) Hopelessly",
                "describes how something is done, not what kind of movie it is."),
            _choiceExplanationRow(
                "D) Hopeness", "is not a real word in English."),
          ],
        ),
      ),
    );
  }

  Widget _choiceExplanationRow(String option, String explanation) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            option,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: option.contains("A)") ? Colors.green[700] : _darkBlue,
              fontSize: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 2),
            child: Text(
              explanation,
              style: const TextStyle(fontSize: 15, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  // --- UPDATED STEP 4 ---

  Widget _buildStep4() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 30),
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
                "✅ Step 3: Final Selection",
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
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select the complete word:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 16),

                      _buildFinalOption("A) Hopeless", "A", true),
                      _buildFinalOption("B) Hopeful", "B", false),
                      _buildFinalOption("C) Hopelessly", "C", false),
                      _buildFinalOption("D) Hopeness", "D", false),

                      // Feedback, Why it works, and Tip now appear AFTER options
                      if (_selectedAnswer != null) ...[
                        const SizedBox(height: 25),
                        _feedbackBoxStep4(),
                        if (_selectedAnswer == "A") ...[
                          const SizedBox(height: 20),
                          _infoCard(
                            icon: Icons.check_circle,
                            title: "Why this word works",
                            content:
                                "“Hopeless” describes a feeling of no hope. When movies make you sad, they often feel hopeless or depressing. It is an adjective that correctly describes the noun 'movies'.",
                            color: Colors.green,
                          ),
                          _infoCard(
                            icon: Icons.lightbulb,
                            title: "Tip: In English...",
                            content:
                                "Adjectives (describing words) almost always come BEFORE the noun they describe.\n\nExample: hopeless movies, sad songs, happy people.",
                            color: Colors.blue,
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedAnswer == "A" ? _nextStep : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Finish Activity ✅",
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

  Widget _buildFinalOption(String text, String option, bool isCorrect) {
    final bool isSelected = _selectedAnswer == option;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAnswer = option;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect
                  ? Colors.green.withOpacity(0.1)
                  : Colors.red.withOpacity(0.1))
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? (isCorrect ? Colors.green : Colors.red)
                : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? (isCorrect ? Icons.check_circle : Icons.cancel)
                  : Icons.radio_button_off,
              color: isSelected
                  ? (isCorrect ? Colors.green : Colors.red)
                  : _darkBlue,
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: _darkBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _feedbackBoxStep4() {
    final bool isCorrect = _selectedAnswer == "A";
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isCorrect ? Colors.green : Colors.red),
      ),
      child: Text(
        isCorrect
            ? "Correct! 'Hopeless' is the right adjective for this context."
            : "Not quite. Try to find the adjective that means 'without hope'.",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isCorrect ? Colors.green[800] : Colors.red[800],
        ),
      ),
    );
  }

  // --- STEP 5 ---

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
                    "✅ Final Answer:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Answer with suffix highlighted
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _darkBlue,
                      ),
                      children: [
                        const TextSpan(text: "A) "),
                        TextSpan(
                          text: "Hope",
                          style: TextStyle(color: _darkBlue),
                        ),
                        TextSpan(
                          text: "less",
                          style: TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 32),

                  // Explanation Title
                  Text(
                    "Explanation:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Explanation List
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
                              "The suffix -less means 'without'. So hopeless means 'without hope'.\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "The sentence is about movies that make the speaker sad, so we need a negative word.\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "Hopeless is the correct adjective to describe sad, negative movies.",
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 32),

                  // Common Mistakes
                  Text(
                    "Common Mistakes to Avoid:",
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
                        Row(
                          children: [
                            Icon(Icons.warning, color: Colors.orange),
                            const SizedBox(width: 10),
                            Text(
                              "Hopeful = Opposite meaning!",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Hopeful means 'full of hope' - this would describe happy, inspirational movies, not sad ones.",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _lightBlue.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.warning, color: Colors.orange),
                            const SizedBox(width: 10),
                            Text(
                              "Hopelessly = Wrong part of speech",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Hopelessly is an adverb (ends in -ly). We need an adjective to describe 'movies'.",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Strategy Summary
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
                    "📚 Strategy Used:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.text_fields, color: _primaryColor),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          "Suffix Analysis: Understanding how -less creates adjectives with negative meaning",
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
                          "Context Clues: Using emotional context (sad) to determine word meaning",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
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

  void _completeActivity() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SecondActyvityAnimation(),
      ),
    );
    setState(() {
      _currentStep = 0;
      _progressValue = 0.2;
      _resetInteractiveStates();
    });
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
            colors: [_lightBlue, _softBlue, const Color(0xFF90CAF9)],
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

// Re-defining AnimationLimiter and related widgets as they are often from external packages
class AnimationLimiter extends StatelessWidget {
  final Widget child;
  const AnimationLimiter({super.key, required this.child});
  @override
  Widget build(BuildContext context) => child;
}

class AnimationConfiguration {
  static List<Widget> toStaggeredList({
    required Duration duration,
    required Widget Function(Widget) childAnimationBuilder,
    required List<Widget> children,
  }) =>
      children.map((c) => childAnimationBuilder(c)).toList();
}

class SlideAnimation extends StatelessWidget {
  final double horizontalOffset;
  final Widget child;
  const SlideAnimation(
      {super.key, required this.horizontalOffset, required this.child});
  @override
  Widget build(BuildContext context) => child;
}

class FadeInAnimation extends StatelessWidget {
  final Widget child;
  const FadeInAnimation({super.key, required this.child});
  @override
  Widget build(BuildContext context) => child;
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
    '💡 General Hint: Think about a word that represents a bond or unity between women.',
    '📌 More Specific: Which suffix often refers to a group with a common bond?',
  ];

  final List<String> hints2 = [
    '💡 General Hint: Which word describes something that can be cleaned?',
    '📌 More Specific: Which suffix often indicates the ability to do something?',
  ];

  final List<String> hints3 = [
    '💡 General Hint: Look for a noun that describes the role of the person.',
    '📌 More Specific: Which suffix often refers to a profession?',
  ];

  final List<String> hints4 = [
    '💡 General Hint: Focus on the word that describes someone who easily makes friends.',
    '📌 More Specific: The word \'friendless\' means without friends — think about the opposite of that.',
  ];

  // Each entry: 'before', 'highlight', 'after'
  final List<Map<String, String>> questionParts = [
    {
      'before': 'There was a lot of ',
      'highlight': 'sisterer',
      'after': ' in the group. Fix the sentence.',
    },
    {
      'before': 'They gave her a ',
      'highlight': 'cleanly',
      'after': ' blanket for her baby. Fix the sentence.',
    },
    {
      'before': 'She\'s such a good ',
      'highlight': 'bartenderable',
      'after': '. Fix the sentence.',
    },
    {
      'before': 'My dog is very ',
      'highlight': 'friendless',
      'after': ', he likes everyone! Fix the sentence.',
    },
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question": "There was a lot of sisterer in the group. Fix the sentence.",
      "options": [
        "A) Sistering",
        "B) Sisterness",
        "C) Sisterable",
        "D) Sisterhood"
      ],
      "correctIndex": 3,
      "feedback": [
        " 'Sistering' is not a correct noun for this context.",
        " 'Sisterness' is not a standard word.",
        " 'Sisterable' is not a real word.",
        " Explanation: 'Sisterhood' is the correct noun for unity or strong bond between women."
      ]
    },
    {
      "question":
          "They gave her a cleanly blanket for her baby. Fix the sentence.",
      "options": ["A) Cleanless", "B) Cleanable", "C) Cleaness", "D) Cleaner"],
      "correctIndex": 1,
      "feedback": [
        " 'Cleanless' is not a real word.",
        " Explanation: 'Cleanable' is the correct adjective to describe the blanket.",
        " 'Cleaness' is not a correct form.",
        " 'Cleaner' refers to a person or tool, not suitable here."
      ]
    },
    {
      "question": "She's such a good bartenderable. Fix the sentence.",
      "options": [
        "A) Bartenderly",
        "B) Bartender",
        "C) Bartenderness",
        "D) Bartenderhood"
      ],
      "correctIndex": 1,
      "feedback": [
        " 'Bartenderly' is not a real word.",
        " Explanation: 'Bartender' means someone who serves drinks at a bar.",
        " 'Bartenderness' is not a real word.",
        " 'Bartenderhood' is not standard English."
      ]
    },
    {
      "question":
          "My dog is very friendless, he likes everyone! Fix the sentence.",
      "options": [
        "A) Friendly",
        "B) Friendable",
        "C) Friendness",
        "D) The sentence is already correct"
      ],
      "correctIndex": 0,
      "feedback": [
        " Explanation: 'Friendly' is the correct word. 'Friendless' means without friends, which doesn't match the context.",
        " Friendable' is not a real word.",
        " Friendness' is not a correct form.",
        " The sentence is not correct as written — 'friendless' is the wrong word here."
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

  /// Builds the question text with the keyword highlighted
  Widget _buildQuestionText(int index) {
    final parts = questionParts[index];
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 16,
          fontStyle: FontStyle.italic,
          color: Colors.black87,
          height: 1.5,
        ),
        children: [
          TextSpan(text: parts['before']),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFF00897B),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                parts['highlight']!,
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          TextSpan(text: parts['after']),
        ],
      ),
    );
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
                    style: TextStyle(fontSize: 16, color: Color(0xFF37474F)),
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
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF4DD0C4).withOpacity(0.4),
                        width: 1.5,
                      ),
                    ),
                    child: _buildQuestionText(currentQuestionIndex),
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
                                : const Color(0xFFD32F2F),
                          ),
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
                            child: const Text(
                              "Next",
                              style: TextStyle(
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
    question: 'Match the word: Reusable',
    options: [
      "A) Cannot be cleaned",
      "B) Needs washing",
      "C) Can be reused",
      "D) Used for washing"
    ],
    correctIndex: 2,
    explanation:
        '✔️ Explanation: “Reusable” means it can be reused over and over again.',
    incorrectExplanations: [
      'Don\'t worry\'s is a common error',
      'Don\'t worry\'s is a common error',
      '✅',
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

  // Blue color scheme matching your preference
  final Color _primaryColor = const Color(0xFF00897B);  // turquesa profundo
  final Color _darkBlue    = const Color(0xFF00695C);  // turquesa oscuro
  final Color _accentColor = const Color(0xFF4DB6AC);  // turquesa medio
  final Color _successColor = const Color.fromARGB(255, 76, 175, 80);
  final Color _warningColor = const Color.fromARGB(255, 255, 152, 0);
  final Color _lightBlue   = const Color(0xFFB2EBE5);  // turquesa suave
  final Color _lightBlueBg = const Color(0xFFE0F7F4);  // turquesa muy claro
  final Color _softBlue    = const Color(0xFF80CBC4);  // turquesa medio-claro

  // Interactive states
  // ignore: unused_field
  bool _wordDeconstructed = false;
  final List<String> _wordParts = [];
  final Map<String, bool> _suffixMeanings = {
    'Without something': false,
    'Full of something': false,
    'Capable of': true,
    'Happening before something': false,
  };

  // Puzzle pieces
  // ignore: unused_field
  final List<String> _puzzlePieces = ['Re', 'use', 'able'];
  final List<String> _selectedPieces = [];
  // ignore: unused_field
  bool _puzzleCompleted = false;

  // Word examples
  final List<Map<String, dynamic>> _wordExamples = [
    {'word': 'Washable', 'meaning': 'Can be washed', 'color': Colors.blue},
    {'word': 'Breakable', 'meaning': 'Can be broken', 'color': Colors.orange},
    {'word': 'Readable', 'meaning': 'Can be read', 'color': Colors.green},
    {'word': 'Drinkable', 'meaning': 'Can be drunk', 'color': Colors.purple},
  ];

  // Matching game variables
  // ignore: unused_field
  bool _gameStarted = false;
  bool _lastMatch = false;
  int _gameTime = 0;
  int _totalMoves = 0;
  // ignore: unused_field
  int _accuracy = 0;
  List<Map<String, dynamic>> _gameCards = [];
  Timer? _gameTimer;
  final List<int> _selectedCards = []; // <-- AQUÍ ESTÁ LA VARIABLE FALTANTE

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _initializeMatchingGame();
    _initializeGame(); // Inicializar el juego mejorado
  }

  @override
  void dispose() {
    _animationController.dispose();
    _gameTimer?.cancel(); // Cancelar el timer del juego
    super.dispose();
  }

  void _initializeMatchingGame() {
    // Este método ya no se usa en la versión mejorada, pero lo mantenemos por compatibilidad
  }

  void _initializeGame() {
    _gameCards = [];
    _selectedCards.clear(); // Limpiar las cartas seleccionadas

    // Pares de palabras y significados mejorados
    final pairs = [
      {'word': 'Reusable', 'meaning': 'Can be reused'},
      {'word': 'Washable', 'meaning': 'Can be washed'},
      {'word': 'Breakable', 'meaning': 'Can be broken'},
      {'word': 'Readable', 'meaning': 'Can be read'},
      {'word': 'Drinkable', 'meaning': 'Can be drunk'},
      {'word': 'Returnable', 'meaning': 'Can be returned'},
    ];

    // Crear cartas para palabras
    for (var pair in pairs) {
      _gameCards.add({
        'id': '${pair['word']}_word',
        'content': pair['word'],
        'type': 'word',
        'pairId': pair['word'],
        'flipped': false,
        'matched': false,
      });

      // Crear cartas para significados
      _gameCards.add({
        'id': '${pair['word']}_meaning',
        'content': pair['meaning'],
        'type': 'meaning',
        'pairId': pair['word'],
        'flipped': false,
        'matched': false,
      });
    }

    // Mezclar las cartas
    _gameCards.shuffle();

    // Iniciar timer
    _gameStarted = true;
    _gameTime = 0;
    _totalMoves = 0;
    _accuracy = 0;
    // Resetear contador de pares
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _gameTime++;
      });
    });
  }

bool _isProcessing = false; // ✅ nuevo flag — agrégalo junto a los demás campos de estado

  void _flipCard(int index) {
    // ✅ Guards: bloquear si se está procesando un par, si ya coincidió, o si ya está volteada
    if (_isProcessing) return;
    if (_gameCards[index]['matched'] as bool) return;
    if (_gameCards[index]['flipped'] as bool) return;
    if (_selectedCards.length >= 2) return;

    setState(() {
      _gameCards[index]['flipped'] = true;
      _selectedCards.add(index);

      if (_selectedCards.length == 2) {
        _totalMoves++;
        _isProcessing = true; // ✅ bloquear taps hasta que termine el delay
        _checkForMatch();
      }
    });
  }

  void _checkForMatch() {
    if (_selectedCards.length != 2) return;

    int firstIndex = _selectedCards[0];
    int secondIndex = _selectedCards[1];

    var firstCard = _gameCards[firstIndex];
    var secondCard = _gameCards[secondIndex];

    bool isMatch = firstCard['pairId'] == secondCard['pairId'];

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() {
        _lastMatch = isMatch;

        if (isMatch) {
          _gameCards[firstIndex]['matched'] = true;
          _gameCards[secondIndex]['matched'] = true;
          if (_countMatches() == 6) {
            _gameTimer?.cancel();
          }
        } else {
          _gameCards[firstIndex]['flipped'] = false;
          _gameCards[secondIndex]['flipped'] = false;
        }

        _selectedCards.clear();
        _isProcessing = false; // ✅ desbloquear taps después del delay
      });
    });
  }

  void _resetGame() {
    setState(() {
      _isProcessing = false; // ✅ resetear flag también aquí
      _selectedCards.clear();
      _gameTime = 0;
      _totalMoves = 0;
      _accuracy = 0;
      _lastMatch = false;
      _gameTimer?.cancel();
      _initializeGame();
    });
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 16, color: color),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _darkBlue,
          ),
        ),
      ],
    );
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
    _wordDeconstructed = false;
    _wordParts.clear();
    _suffixMeanings.forEach((key, value) {
      _suffixMeanings[key] = false;
    });
    _selectedPieces.clear();
    _puzzleCompleted = false;
    _selectedCards.clear();
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
                "🧩 Step 1: Deconstruct the Word",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),

              // Word Circle
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
                        child: Text(
                          "Reusable",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: _darkBlue,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Icon(
                        Icons.search,
                        size: 40,
                        color: _primaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Word Parts display
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
                        "Word parts of \"Reusable\":",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Static word parts row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStaticPart("Re-", const Color(0xFF1565C0)),
                          _buildStaticPart("use", const Color(0xFF2E7D32)),
                          _buildStaticPart("-able", const Color(0xFFE65100)),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Breakdown confirmation
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _successColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _successColor, width: 2),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: _successColor),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Here are all the parts:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: _darkBlue,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: _darkBlue,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: "Re-",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF1565C0),
                                          ),
                                        ),
                                        const TextSpan(
                                            text: " (prefix = again) + "),
                                        const TextSpan(
                                          text: "use",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF2E7D32),
                                          ),
                                        ),
                                        const TextSpan(
                                            text: " (root word) + "),
                                        const TextSpan(
                                          text: "-able",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFE65100),
                                          ),
                                        ),
                                        const TextSpan(text: " (suffix)"),
                                      ],
                                    ),
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

              // Explanation of Parts
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
                        "What do these parts mean?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildPartMeaning(
                          "Re-", "Prefix", "Means 'again' or 'back'"),
                      _buildPartMeaning(
                          "use", "Root Word", "The main action verb"),
                      _buildPartMeaning(
                          "-able", "Suffix", "Means 'able to be'"),
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
                    "Learn About -able ➡️",
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

  Widget _buildStaticPart(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color, width: 2),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Color _getPieceColor(String piece) {
    switch (piece) {
      case 'Re':
        return Colors.blue;
      case 'use':
        return Colors.green;
      case 'able':
        return Colors.orange;
      default:
        return _primaryColor;
    }
  }

  Widget _buildPartMeaning(String part, String type, String meaning) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getPieceColor(part).withOpacity(0.1),
              border: Border.all(color: _getPieceColor(part), width: 2),
            ),
            child: Center(
              child: Text(
                part,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _getPieceColor(part),
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
                  type,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _darkBlue,
                  ),
                ),
                Text(
                  meaning,
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

Widget _buildStep2() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 30.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              Text(
                "🔤 Step 2: The -able Suffix",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),

              // Suffix Spotlight
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.orange, Colors.deepOrange],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.3),
                                blurRadius: 15,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: const Text(
                            "-able",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      Text(
                        "What does -able mean?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Main meaning highlight
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: _successColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(color: _successColor, width: 1.5),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: _successColor.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.check_circle_outline,
                                  color: _successColor, size: 28),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Capable of / Able to be",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: _darkBlue,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    "The suffix -able creates adjectives from verbs, meaning something CAN be done.",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Three key uses
                      Row(
                        children: [
                          Expanded(
                            child: _buildMeaningChip(
                              icon: Icons.loop,
                              label: "Re-usable",
                              sub: "can be used again",
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildMeaningChip(
                              icon: Icons.visibility,
                              label: "Visible",
                              sub: "able to be seen",
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildMeaningChip(
                              icon: Icons.local_laundry_service,
                              label: "Washable",
                              sub: "can be washed",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Word Examples Carousel
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
                        "Examples of -able words:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 180,
                        child: PageView.builder(
                          itemCount: _wordExamples.length,
                          itemBuilder: (context, index) {
                            final example = _wordExamples[index];
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    example['color'] as Color,
                                    (example['color'] as Color)
                                        .withOpacity(0.7),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: (example['color'] as Color)
                                        .withOpacity(0.3),
                                    blurRadius: 10,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    example['word'],
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    "= ${example['meaning']}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: Text(
                          "Swipe to see more examples →",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
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
                    backgroundColor: _primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                  ),
                  onPressed: _nextStep,
                  child: const Text(
                    "Play Matching Game ➡️",
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

  Widget _buildMeaningChip({
    required IconData icon,
    required String label,
    required String sub,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: _lightBlue.withOpacity(0.4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _primaryColor.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: _primaryColor, size: 22),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: _darkBlue,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            sub,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black54,
              height: 1.3,
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
              horizontalOffset: 30.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              Text(
                "🎮 Step 3: Memory Match Challenge",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),

              // Game Instructions
              Card(
                elevation: 8,
                margin: const EdgeInsets.only(bottom: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _primaryColor.withOpacity(0.1),
                          border: Border.all(color: _primaryColor, width: 2),
                        ),
                        child: const Icon(
                          Icons.games,
                          size: 30,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Memory Game:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _darkBlue,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Match each -able word with its definition. Find all 6 pairs!",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Game Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard(
                    "Matches",
                    "${_countMatches()}/6",
                    Icons.check_circle,
                    _successColor,
                  ),
                  _buildStatCard(
                    "Moves",
                    "$_totalMoves",
                    Icons.swap_horiz,
                    _accentColor,
                  ),
                  _buildStatCard(
                    "Time",
                    "${_gameTime}s",
                    Icons.timer,
                    Colors.orange,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Game Board
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
                      // Game Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Find the Matching Pairs",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: _darkBlue,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.restart_alt),
                            onPressed: _resetGame,
                            color: _primaryColor,
                            tooltip: "Restart Game",
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Tap to flip cards and find matching word-definition pairs",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Game Grid
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // tamaño de la cuadricula
                          crossAxisSpacing: 0, // espacio entre columnas
                          mainAxisSpacing: 4, // espacio entre filas
                          childAspectRatio:
                              0.7, // relación de aspecto de cada tarjeta
                        ),
                        itemCount: _gameCards.length,
                        itemBuilder: (context, index) {
                          final card = _gameCards[index];
                          bool isFlipped = card['flipped'] as bool;
                          bool isMatched = card['matched'] as bool;

                          return GestureDetector(
                            onTap: () => _flipCard(index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: isMatched
                                    ? _successColor.withOpacity(0.15)
                                    : isFlipped
                                        ? Colors.white
                                        : _primaryColor.withOpacity(0.1),
                                border: Border.all(
                                  color: isMatched
                                      ? _successColor
                                      : isFlipped
                                          ? _accentColor
                                          : _primaryColor.withOpacity(0.3),
                                  width: isMatched ? 3 : 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: (isMatched
                                            ? _successColor
                                            : _primaryColor)
                                        .withOpacity(isFlipped ? 0.2 : 0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Front of card (hidden)
                                  if (!isFlipped && !isMatched)
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.help_outline,
                                          size: 32,
                                          color: _primaryColor.withOpacity(0.6),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "?",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: _primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),

                                  // Back of card (content)
                                  if (isFlipped || isMatched)
                                    AnimatedOpacity(
                                      opacity: isFlipped || isMatched ? 1 : 0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Type indicator
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                color: card['type'] == 'word'
                                                    ? Colors.blue
                                                        .withOpacity(0.1)
                                                    : Colors.green
                                                        .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                card['type'] == 'word'
                                                    ? 'WORD'
                                                    : 'MEANING',
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.bold,
                                                  color: card['type'] == 'word'
                                                      ? Colors.blue
                                                      : Colors.green,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8),

                                            // Content
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  card['content'] as String,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize:
                                                        card['type'] == 'word'
                                                            ? 12
                                                            : 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: isMatched
                                                        ? _successColor
                                                        : _darkBlue,
                                                    fontStyle: card['type'] ==
                                                            'meaning'
                                                        ? FontStyle.italic
                                                        : FontStyle.normal,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            // Match indicator
                                            if (isMatched)
                                              Icon(
                                                Icons.check_circle,
                                                size: 20,
                                                color: _successColor,
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),

                                  // Overlay for matched cards
                                  if (isMatched)
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: _successColor.withOpacity(0.05),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      // Game Feedback
                      if (_selectedCards.length == 2)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _lastMatch
                                ? _successColor.withOpacity(0.1)
                                : Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _lastMatch ? _successColor : Colors.orange,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _lastMatch
                                    ? Icons.celebration
                                    : Icons.lightbulb_outline,
                                color:
                                    _lastMatch ? _successColor : Colors.orange,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _lastMatch
                                      ? "Great match! 🎉 The suffix -able means 'able to be'"
                                      : "Not a match. Remember: -able words describe what can be done",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: _darkBlue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      if (_countMatches() == 6)
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                _successColor.withOpacity(0.1),
                                _primaryColor.withOpacity(0.05)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: _successColor, width: 2),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.emoji_events,
                                size: 50,
                                color: _successColor,
                              ),
                              const SizedBox(height: 15),
                              Text(
                                "Perfect Memory! 🏆",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: _successColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "You mastered all -able words!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: _darkBlue,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildScoreItem("Time", "${_gameTime}s"),
                                  const SizedBox(width: 20),
                                  _buildScoreItem("Moves", "$_totalMoves"),
                                  const SizedBox(width: 20),
                                  _buildScoreItem(
                                      "Accuracy", "${_calculateAccuracy()}%"),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Text(
                                "Now you understand how -able creates adjectives!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text(
                    "Continue to Apply Knowledge",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor:
                        _countMatches() == 6 ? _primaryColor : Colors.grey,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                  ),
                  onPressed: _countMatches() == 6 ? _nextStep : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _countMatches() {
    int matches = 0;
    for (var card in _gameCards) {
      if (card['matched'] as bool) {
        matches++;
      }
    }
    return matches ~/ 2; // Cada par tiene 2 cartas
  }

  int _calculateAccuracy() {
    if (_totalMoves == 0) return 0;
    int matchedPairs = _countMatches();
    return ((matchedPairs / _totalMoves) * 100).toInt();
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
                "💡 Step 4: Apply Your Knowledge",
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
                        "What does 'Reusable' mean?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Interactive Definition Builder
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildWordPartChip(
                                    "Re-", "Prefix", Colors.blue),
                                const SizedBox(width: 5),
                                _buildWordPartChip("use", "Verb", Colors.green),
                                const SizedBox(width: 5),
                                _buildWordPartChip(
                                    "-able", "Suffix", Colors.orange),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Combine the meanings:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "'again' + 'use' + 'able to be' = ?",
                              style: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                color: _darkBlue,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Multiple Choice Options
                      Text(
                        "Choose the correct definition:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 15),

                      _buildDefinitionOption(
                        "A) Cannot be cleaned",
                        "A",
                        false,
                        Icons.clean_hands,
                      ),
                      _buildDefinitionOption(
                        "B) Needs washing",
                        "B",
                        false,
                        Icons.local_laundry_service,
                      ),
                      _buildDefinitionOption(
                        "C) Can be reused",
                        "C",
                        true,
                        Icons.replay,
                      ),
                      _buildDefinitionOption(
                        "D) Used for washing",
                        "D",
                        false,
                        Icons.wash,
                      ),

                      const SizedBox(height: 20),

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
                                                ? Icons.check_circle
                                                : Icons.help_outline,
                                            color: _correctAnswer
                                                ? _successColor
                                                : _warningColor,
                                            size: 28,
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            _correctAnswer
                                                ? " Perfect! "
                                                : " Think again...",
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
                                        _correctAnswer
                                            ? "Exactly! 'Reusable' = 'able to be used again'"
                                            : _getDefinitionFeedback(
                                                _selectedAnswer!),
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
                                  icon: const Icon(Icons.refresh,
                                      color: Colors.white),
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
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _successColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: _successColor),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.emoji_events, color: _successColor),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Text(
                                  "You've successfully analyzed the word parts and applied the suffix meaning!",
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
                      "See Final Analysis ➡️",
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

  Widget _buildWordPartChip(String text, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.1),
            border: Border.all(color: color, width: 2),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildDefinitionOption(
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
                  ? _successColor.withOpacity(0.1)
                  : _warningColor.withOpacity(0.1))
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? (isCorrect ? _successColor : _warningColor)
                : Colors.grey[300]!,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? (isCorrect
                      ? _successColor.withOpacity(0.2)
                      : _warningColor.withOpacity(0.2))
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
                    ? (isCorrect ? _successColor : _warningColor)
                    : _lightBlue,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : _darkBlue,
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
                  color: _darkBlue,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                isCorrect ? Icons.check_circle : Icons.help,
                color: isCorrect ? _successColor : _warningColor,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  String _getDefinitionFeedback(String option) {
    switch (option) {
      case "A":
        return "'Cannot be cleaned' doesn't relate to 'use'. Think about the -able suffix.";
      case "B":
        return "'Needs washing' is not the definition. Remember: -able means 'able to be'.";
      case "D":
        return "'Used for washing' focuses on purpose, not on being able to be used again.";
      default:
        return "Combine the parts: re- (again) + use + -able (able to be)";
    }
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
                    "✅ Final Answer:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Answer
                  Text(
                    "C) Can be reused",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue,
                    ),
                    textAlign: TextAlign.left,
                  ),

                  const Divider(height: 32),

                  // Explanation Title
                  Text(
                    "Word Breakdown:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Word Parts Visualization
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _lightBlue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildFinalPart(
                                "Re-", "Prefix", Colors.blue, "'again'"),
                            const Text(" + ", style: TextStyle(fontSize: 20)),
                            _buildFinalPart(
                                "use", "Verb", Colors.green, "'use'"),
                            const Text(" + ", style: TextStyle(fontSize: 20)),
                            _buildFinalPart("-able", "Suffix", Colors.orange,
                                "'able to be'"),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "= able to be used again",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _darkBlue,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 32),

                  // Detailed Explanation
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
                          text: "The prefix re- means 'again' or 'back'.\n\n",
                        ),
                        TextSpan(
                          text: "2. ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "The root word is 'use' - a verb meaning to employ something.\n\n",
                        ),
                        TextSpan(
                          text: "3. ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "The suffix -able means 'able to be' or 'capable of'.\n\n",
                        ),
                        TextSpan(
                          text: "4. ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "When combined: re- (again) + use + -able (able to be) = 'able to be used again'.",
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 32),

                  // Strategy Summary
                  Text(
                    "Skills You Practiced:",
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
                            Icon(Icons.pie_chart_outline, color: _primaryColor),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                "Word Deconstruction: Breaking words into prefixes, roots, and suffixes",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.text_fields, color: _primaryColor),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                "Suffix Analysis: Understanding -able means 'able to be'",
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
                                "Logical Combination: Putting word parts together to find meaning",
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

          // Real-world Application
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
                    "🌍 Real-world Examples:",
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
                        label: const Text("Reusable bags"),
                        backgroundColor: Colors.green.withOpacity(0.1),
                      ),
                      Chip(
                        label: const Text("Reusable water bottles"),
                        backgroundColor: Colors.blue.withOpacity(0.1),
                      ),
                      Chip(
                        label: const Text("Reusable containers"),
                        backgroundColor: Colors.orange.withOpacity(0.1),
                      ),
                      Chip(
                        label: const Text("Reusable batteries"),
                        backgroundColor: Colors.purple.withOpacity(0.1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "These are items that can be used multiple times!",
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

  Widget _buildFinalPart(
      String part, String type, Color color, String meaning) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.1),
            border: Border.all(color: color, width: 2),
          ),
          child: Text(
            part,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          type,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          meaning,
          style: TextStyle(
            fontSize: 11,
            color: color,
          ),
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
    '💡 General Hint: Look at the suffix \'-hood.\' It often refers to a state or condition.',
    '📌 More Specific: Think about the stage of life when you\'re not yet an adult.',
  ];

  final List<String> hints2 = [
    '💡 General Hint: Focus on the suffix \'-less.\' It usually means \'without\' or \'lacking\'.',
    '📌 More Specific: The word \'careless\' describes someone who doesn\'t show care or attention.',
  ];

  final List<String> hints3 = [
    '💡 General Hint: Focus on the suffix \'-ly.\' It often describes how something is done.',
    '📌 More Specific: Think about the meaning of \'kind\' and what it would mean if something is done in a \'kindly\' way.',
  ];

  final List<String> hints4 = [
    '💡 General Hint: What state does the word \'mad\' describe when using \'-ness\'?',
    '📌 More Specific: The suffix \'-ness\' creates a noun describing a state.',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question": "Match the word: Childhood",
      "options": [
        "A) The state of being old",
        "B) The time of being an adult",
        "C) The period of being a child",
        "D) The feeling of being young"
      ],
      "correctIndex": 2,
      "feedback": [
        " 'The state of being old' doesn't relate to 'childhood'.",
        " 'The time of being an adult' is the opposite of childhood.",
        " Explanation: 'Childhood' refers to the period in life when someone is a child.",
        " 'The feeling of being young' is not precise — childhood is a life stage, not just a feeling."
      ]
    },
    {
      "question": "Match the word: Careless",
      "options": [
        "A) Without care",
        "B) Full of care",
        "C) Shows kindness",
        "D) Easy to wash"
      ],
      "correctIndex": 0,
      "feedback": [
        " Explanation: 'Careless' means not showing attention or care.",
        " 'Full of care' is actually the opposite — 'careful'.",
        " 'Shows kindness' is unrelated.",
        " 'Easy to wash' is not related to 'careless'."
      ]
    },
    {
      "question": "Match the word: Kindly",
      "options": [
        "A) In a rude way",
        "B) In a gentle and friendly way",
        "C) In a strange way",
        "D) In a fast way"
      ],
      "correctIndex": 1,
      "feedback": [
        " 'In a rude way' is the opposite meaning.",
        " Explanation: 'Kindly' means to do something in a considerate or friendly manner.",
        " 'In a strange way' is unrelated.",
        " 'In a fast way' is unrelated to kindness."
      ]
    },
    {
      "question": "Match the word: Madness",
      "options": [
        "A) The action of being fast",
        "B) A person who teaches",
        "C) The state of being mad",
        "D) The act of washing"
      ],
      "correctIndex": 2,
      "feedback": [
        " 'The action of being fast' doesn’t relate to madness.",
        " 'A person who teaches' refers to a teacher, not madness.",
        " Explanation: 'Madness' is a noun that means the state of being mad / crazy.",
        " 'The act of washing' is unrelated."
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
        .set({'completedInstructionSpot2_2': true}, SetOptions(merge: true));

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
      'completedInstructionSpot2_2': true, // Repetido por seguridad
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
                  "You did amazing! The more you practice with suffixes, the better you'll become! Keep up the fantastic work! 🌟🩵⚡", 
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
                      "To sum up...\n\nSuffixes are powerful tools, helping you decode new words and expand your vocabulary!",
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
