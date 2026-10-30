// ignore_for_file: curly_braces_in_flow_control_structures, duplicate_ignore

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_2/Animations.dart';
import 'package:inferwise/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InstructionSpotPage2 extends StatefulWidget {
  final String title;
  final List<String> instructions;
  final String tipTitle;
  final List<String> tips;
  final String finalNote;

  const InstructionSpotPage2({
    super.key,
    required this.title,
    required this.instructions,
    required this.tipTitle,
    required this.tips,
    required this.finalNote,
  });

  @override
  State<InstructionSpotPage2> createState() => _InstructionSpotPage2State();
}

class _InstructionSpotPage2State extends State<InstructionSpotPage2> {
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
                            , // Azul claro fondo
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
//              Color(0xFF6EE7D8),
//             Color(0xFF2DD4BF),

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
      'title': '',
      'text':
          'Some words in English and Spanish look and mean the same. These are called cognates.',
      'image': '',
    },
    {
      'title': 'Example 1',
      'text': 'Double (English) → Doble (Spanish) ',
      'image': 'assets/Imagenes de ejemplos/Level2/2.1 A Double.webp',
    },
    {
      'title': 'Example 2',
      'text': 'To admire (English) → Admirar (Spanish) ',
      'image': 'assets/Imagenes de ejemplos/Level2/2.1 B Admiring.webp',
    },
    {
      'title': 'Example 3',
      'text': 'Photo (English) → Foto (Spanish) ',
      'image': 'assets/Imagenes de ejemplos/Level2/2.1 C Photo.webp',
    },
    {
      'title': 'Example 4',
      'text': 'Intelligent (English) → Inteligente (Spanish) ',
      'image': 'assets/Imagenes de ejemplos/Level2/2.1 D Intelligent.webp',
    },
    {
      'title': 'Example 5',
      'text': 'Problem (English) → Problema (Spanish) ',
      'image': 'assets/Imagenes de ejemplos/Level2/2.1 E Problem.webp',
    },
    {
      'title': '',
      'text':
          'Cognates help you guess meanings quickly!\n\nBut watch out for false cognates — words that look similar but have different meanings.',
      'image': '',
    },
    {
      'title': 'Example 1',
      'text':
          'Embarrassed (English) → Embarazada (Spanish) \n("Embarazada" means "pregnant")',
      'image': 'assets/Imagenes de ejemplos/Level2/2.1 F Embarrassed.webp',
    },
    {
      'title': 'Example 2',
      'text':
          'Library (English) → Librería (Spanish) \n(Librería means "bookstore")',
      'image': 'assets/Imagenes de ejemplos/Level2/2.1 G Library.webp',
    },
    {
      'title': 'Example 3',
      'text': 'Exit (English) → Éxito (Spanish) \n(Éxito means "success")',
      'image': 'assets/Imagenes de ejemplos/Level2/2.1 H Exit.webp',
    },
    {
      'title': 'Example 4',
      'text':
          'Fabric (English) → Fábrica (Spanish) \n(Fábrica means "factory")',
      'image': 'assets/Imagenes de ejemplos/Level2/2.1 I Fabric.webp',
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
    final hasImage = example['image']!.isNotEmpty;
    final hasTitle = example['title']!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
              color: const Color(0xFF4DD0C4), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00897B),
              offset: const Offset(0, 6),
              blurRadius: 16,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image (only on example slides)
            if (hasImage)
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
                child: SizedBox(
                  height: 200,
                  child: Image.asset(
                    example['image']!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      color: const Color(0xFFB2DFDB),
                      child: const Icon(Icons.image_not_supported_outlined,
                          size: 48, color: Color(0xFF80CBC4)),
                    ),
                  ),
                ),
              ),

            // Intro slides: decorative top accent strip
            if (!hasImage)
              Container(
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF00897B),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
              ),

            // Text content (sin scroll)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: hasImage
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  crossAxisAlignment: hasImage
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    if (hasTitle) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00897B),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.lightbulb_outline,
                                color: Color(0xFF00897B), size: 16),
                            const SizedBox(width: 6),
                            Text(
                              example['title']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xFF00695C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    Text(
                      example['text']!,
                      style: TextStyle(
                        fontSize: hasImage ? 15 : 18,
                        color:
                            hasImage ? Colors.black87 : const Color(0xFF00695C),
                        height: 1.55,
                        fontWeight:
                            hasImage ? FontWeight.normal : FontWeight.w500,
                      ),
                      textAlign: hasImage ? TextAlign.left : TextAlign.center,
                    ),
                  ],
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
                      "Identifying Cognates",
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                        color: const Color(0xFF4DD0C4),
                        width: 1.5),
                  ),
                  child: const Text(
                    'Readers figuring out a word\'s meaning from its relationship with other words. Cognates are words in different languages with a shared origin.\n\n'
                    '💠 Recognizing these similarities helps in understanding new words.',
                    style: TextStyle(
                      fontSize: 14.5,
                      color: Color(0xFF00695C),
                      height: 1.45,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

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
                      shadowColor: const Color(0xFF00695C),
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

  // Each step split into title + body for bold title styling
  final List<Map<String, String>> steps = [
    {
      'title': '🔵 1. Read the Sentences Carefully',
      'body':
          'First sentence: "We took a boat to the island." \n\nSecond sentence: \n\n"It was surrounded by water on all sides."',
    },
    {
      'title': '🔵 2. Identify the Word to Link',
      'body': 'The word to analyze: "island" 🏝️',
    },
    {
      'title': '🔵 3. Check for Cognates',
      'body':
          '"Island" looks like the Spanish word "isla."\n\nBoth words refer to a piece of land completely surrounded by water.',
    },
    {
      'title': '🔵 4. Confirm with Context',
      'body':
          'The second sentence describes a place surrounded by water, which matches the definition of "island".',
    },
    {
      'title': '➡️ Identifying Cognates',
      'body':
          '"Island" means "a piece of land surrounded by water" because it is a cognate of "isla" in Spanish, both referring to the same concept.',
    },
  ];

  // Builds card text: bold title, normal body, with aquamarine highlight
  // on the specific phrase only in step index 2
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
    const aquaStyle = TextStyle(
      fontSize: 17,
      height: 1.6,
      color: Color(0xFF00897B),
      fontWeight: FontWeight.normal,
    );

    // Step 3 (index 2): highlight the specific phrase in aquamarine
    if (index == 2) {
      const highlighted = '"Island" looks like the Spanish word "isla."';
      const rest =
          '\n\nBoth words refer to a piece of land completely surrounded by water.';

      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(text: step['title'], style: boldStyle),
            const TextSpan(text: '\n\n', style: normalStyle),
            TextSpan(text: highlighted, style: aquaStyle),
            TextSpan(text: rest, style: normalStyle),
          ],
        ),
      );
    }

    // Step 2 (index 1): show image above the text
    if (index == 1) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(text: step['title'], style: boldStyle),
                TextSpan(text: '\n\n${step['body']}', style: normalStyle),
              ],
            ),
          ),
        ],
      );
    }

    // Step 1 (index 0): bold labels for "First sentence:" and "Second sentence:"
    if (index == 0) {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(text: step['title'], style: boldStyle),
            const TextSpan(text: '\n\n', style: normalStyle),
            TextSpan(text: 'First sentence:', style: boldStyle),
            const TextSpan(
              text: ' "We took a boat to the island." \n\n',
              style: normalStyle,
            ),
            TextSpan(text: 'Second sentence:', style: boldStyle),
            const TextSpan(
              text: ' "It was surrounded by water on all sides."',
              style: normalStyle,
            ),
          ],
        ),
      );
    }

    // All other steps: bold title + normal body
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: const Color(0xFF4DD0C4),
                        width: 1.5),
                  ),
                  child: const Text(
                    '"We took a boat to the island. It was surrounded by water on all sides."',
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                              color: const Color(0xFF4DD0C4),
                              width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00897B),
                              offset: const Offset(0, 4),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Center(
                            child: _buildCardContent(index),
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
                            backgroundColor: Colors.white,
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
                          shadowColor: const Color(0xFF00695C),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                        color: const Color(0xFF4DD0C4),
                        width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00897B),
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
                          shadowColor: const Color(0xFF00695C),
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
                          backgroundColor: Colors.white,
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
              Color(0xFFE0F7F4), // turquesa muy claro
              Color(0xFFB2EBE5), // turquesa suave
              Color(0xFF80CBC4), // turquesa medio
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
                      // Main Info Card
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                              color: const Color(0xFF4DD0C4),
                              width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00897B),
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
                              'Readers guess word meanings by spotting familiar patterns. Cognates often look and mean the same — but false cognates can be misleading!',
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
                                color: Color(0xFF00897B),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildExample(
                              sentence: 'Hospital → Hospital',
                              inference: '(Same meaning)',
                            ),
                            _buildExample(
                              sentence: 'Animal → Animal',
                              inference: '(Same meaning)',
                            ),
                            _buildExample(
                              sentence: 'Asistir → Not to assist!',
                              inference: 'It means "to attend"',
                            ),
                            _buildExample(
                              sentence: 'Sopa → Not soap!',
                              inference: 'It means "soup"',
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFF00897B),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: const Color(0xFF4DD0C4)
                                        ),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.info_outline,
                                      color: Color(0xFF00897B), size: 20),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Let word similarities guide you — just double-check their meanings!',
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
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 6,
                            shadowColor:
                                const Color(0xFF00695C),
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
          color: const Color(0xFF00897B),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: const Color(0xFF4DD0C4), width: 1),
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
    '🔷 1. Read the sentences and understand the context.',
    '🔷 2. Identify the word to analyze.',
    '🔷 3. Check for cognates (e.g., Spanish "isla" for "island").',
    '🔷 4. Confirm with context to make sure it fits.',
    '➡️ Inference: Use the cognate to understand the word\'s meaning.',
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
              Color(0xFFE0F7F4), // turquesa muy claro
              Color(0xFFB2EBE5), // turquesa suave
              Color(0xFF80CBC4), // turquesa medio
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
                  itemCount: steps.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // Context card
                      return Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                              color: const Color(0xFF4DD0C4),
                              width: 1.5),
                        ),
                        child: const Text(
                          '"We took a boat to the island. It was surrounded by water on all sides."',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                            color: Color(0xFF00695C),
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    // Step cards
                    final stepIndex = index - 1;
                    return Container(
                      padding: const EdgeInsets.all(18),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00897B),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: const Color(0xFF4DD0C4),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        steps[stepIndex],
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
                      shadowColor: const Color(0xFF00695C),
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
        'We had dinner at a beautiful __________ near the beach.\n\nWhat word best completes the sentence?',
    options: [
      "A) Bookstore",
      "B) Restaurant",
      "C) Factory",
      "D) Folder"
    ],
    correctIndex: 1,
    explanation:
        '✔️ Explanation: “Restaurante” is a cognate of “restaurant” — a place to eat.',
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
  double _progressValue = 0.25; // Ajustado para 4 pasos (0.25, 0.5, 0.75, 1.0)
  late AnimationController _animationController;
  bool? _confirmationAnswer;

  // Paleta de colores azulados claros (Refinada)
  final Color _primaryBlue = const Color(0xFF00695C); // turquesa oscuro
  final Color _accentBlue = const Color(0xFF4DB6AC); // turquesa medio
  final Color _lightBlueBg = const Color(0xFFE0F7F4); // turquesa muy claro
  final Color _softBlue = const Color(0xFFB2EBE5); // turquesa suave
  final Color _deepBlue = const Color(0xFF00897B); // turquesa profundo

  // Estados interactivos
  // ignore: unused_field
  bool _beachAnimation = false;
  // ignore: unused_field
  bool _dinnerAnimation = false;
  final Map<String, bool> _cognateAnalysis = {
    'Bookstore': false,
    'Restaurant': false,
    'Factory': false,
    'Folder': false,
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
      _progressValue = (_currentStep + 1) * 0.25;
    });

    _animationController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 400), () {
        setState(() {
          if (_currentStep < 3) {
            // Ahora son 4 pasos en total (0, 1, 2, 3)
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
    _beachAnimation = false;
    _dinnerAnimation = false;
    _selectedAnswer = null;
    _confirmationAnswer = null;
    _cognateAnalysis.updateAll((key, value) => false);
  }

  void _completeActivity() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const Second()));
  }

  Widget _buildProgressIndicator() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return LinearProgressIndicator(
          value: Tween<double>(
            begin: _progressValue - 0.25,
            end: _progressValue,
          ).animate(_animationController).value,
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(_accentBlue),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        );
      },
    );
  }

  // STEP 1: Pregunta sobre de qué es la pregunta + Iconos + Oración inicial
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
                "📝 Step 1: Topic Identification",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _primaryBlue),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),

              // Tarjeta de Oración e Iconos (Mantenida)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _accentBlue, width: 2),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.beach_access, size: 50, color: _accentBlue),
                        Icon(Icons.restaurant,
                            size: 50, color: Colors.orangeAccent),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "We had dinner at a beautiful ___ near the beach.",
                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          color: _primaryBlue,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Nueva Pregunta del Step 1
              Text(
                "What is this sentence mainly about?",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _primaryBlue),
              ),
              const SizedBox(height: 15),
              _buildSelectionOption("A) Buying books", false),
              _buildSelectionOption("B) Eating at a place", true),
              _buildSelectionOption("C) Working in a factory", false),

              const SizedBox(height: 30),
              if (_confirmationAnswer != null)
                Center(
                  child: ElevatedButton(
                    onPressed: _confirmationAnswer == true ? _nextStep : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accentBlue,
                      minimumSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Continue ➡️",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // STEP 2: What are cognates + Which is a spanish cognate
  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("🔍 Step 2: Vocabulary Strategy",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _primaryBlue)),
        const SizedBox(height: 10),
        _buildProgressIndicator(),
        const SizedBox(height: 20),

        // Cuadro de texto Cognates (Mantenido)
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _accentBlue),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("What are cognates?",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _primaryBlue)),
              const SizedBox(height: 8),
              const Text(
                "Cognates are words that look and sound similar in two languages and have the same meaning.",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),

        // Pregunta sobre Cognados
        Text("Which is a Spanish cognate from the options?",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _primaryBlue)),
        const SizedBox(height: 15),
        _buildSelectionOption("A) Bookstore", false),
        _buildSelectionOption("B) Restaurant", true),
        _buildSelectionOption("C) Folder", false),

        const Spacer(),
        if (_confirmationAnswer == true)
          Center(
            child: ElevatedButton(
              onPressed: _nextStep,
              style: ElevatedButton.styleFrom(
                  backgroundColor: _accentBlue,
                  minimumSize: const Size(200, 50)),
              child: const Text("Next Step ➡️",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
      ],
    );
  }

  // STEP 3: Which option makes the most sense? (Sin logical conclusion)
  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("💡 Step 3: Contextual Sense",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _primaryBlue)),
        const SizedBox(height: 10),
        _buildProgressIndicator(),
        const SizedBox(height: 30),
        Text(
          "Which option makes the most sense for 'having dinner near the beach'?",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: _primaryBlue),
        ),
        const SizedBox(height: 20),
        _buildSelectionOption("A) Bookstore (Librería)", false),
        _buildSelectionOption("B) Restaurant (Restaurante)", true),
        _buildSelectionOption("C) Factory (Fábrica)", false),
        const Spacer(),
        if (_confirmationAnswer == true)
          Center(
            child: ElevatedButton(
              onPressed: _nextStep,
              style: ElevatedButton.styleFrom(
                  backgroundColor: _accentBlue,
                  minimumSize: const Size(200, 50)),
              child: const Text("Final Step ➡️",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
      ],
    );
  }

  // STEP 4: Explicación de la respuesta correcta (Mantenida como el Step 5 original)
  Widget _buildStep4() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "🏆 Final Analysis",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _deepBlue,
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
                      color: _accentBlue,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Answer
                  Text(
                    "B) Restaurant",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _deepBlue,
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
                      color: _deepBlue,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Explanation List
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        color: _deepBlue,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "The sentence mentions 'had dinner' - so we need a place where people eat.\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "'Restaurant' is a cognate of the Spanish word 'restaurante' - words that look and sound similar.\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "It makes the most logical and grammatical sense in this sentence about having dinner near the beach.",
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
                      color: _deepBlue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _lightBlueBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.translate, color: _accentBlue),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            "Cognate Strategy: Using similar words in Spanish and English",
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
              onPressed: _completeActivity,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionOption(String text, bool isCorrect) {
    bool isSelected = _selectedAnswer == text;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedAnswer = text;
            _confirmationAnswer = isCorrect;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected
                ? _accentBlue
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: isSelected ? _accentBlue : Colors.white,
                width: 2),
          ),
          child: Row(
            children: [
              Icon(
                isSelected
                    ? (isCorrect ? Icons.check_circle : Icons.cancel)
                    : Icons.radio_button_off,
                color: isSelected
                    ? (isCorrect ? Colors.green : Colors.red)
                    : _primaryBlue,
              ),
              const SizedBox(width: 15),
              Expanded(
                  child: Text(text,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal))),
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
    '💡 General Hint: Find a word that looks similar to a Spanish word about tooth health.',
    '📌 More Specific: Which word fits a visit about teeth?',
    '🧐 Little Explanation: He correct word is similar to ‘dentista’ and refers to a tooth doctor.'
  ];

  final List<String> hints2 = [
    '💡 General Hint: Look for a word that is similar to a Spanish word for a state of matter.',
    '📌 More Specific: Which word fits in a documentary about rare things on Earth?',
    '🧐 Little Explanation: The correct word is similar to ‘líquido’ and refers to one of the states of matter.'
  ];

  final List<String> hints3 = [
    '💡 General Hint: Look for a word that is similar to the Spanish word for a medical facility.',
    '📌 More Specific: Which word refers to a place where doctors and nurses work?',
    '🧐 Little Explanation: The word is similar to ‘hospital’ in Spanish.'
  ];

  final List<String> hints4 = [
    '💡 General Hint: Look for a word similar to the Spanish word for something used in school.',
    '📌 More Specific: Which word makes sense for school supplies?',
    '🧐 Little Explanation: Be careful—‘carpeta’ means ‘folder,’ not ‘carpet’.'
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Julia visited the __________ to get her tooth checked.\n\nWhat word best completes the sentence?",
      "options": ["A) Dentist", "B) Soup", "C) Success", "D) Folder"],
      "correctIndex": 0,
      "feedback": [
        " Explanation: “Dentista” and “dentist” share meaning and spelling.",
        " “Soup” is not related to dental care.",
        " “Success” doesn’t relate to visiting someone for a tooth problem.",
        " “Folder” doesn’t fit the context of medical checkups."
      ]
    },
    {
      "question":
          "They watched a documentary about the most rare __________ on Earth.\n\nWhat word best completes the sentence?",
      "options": ["A) Library", "B) Exit", "C) Liquid", "D) Factory"],
      "correctIndex": 2,
      "feedback": [
        " “Library” is unrelated to something rare on Earth in a scientific context.",
        " “Exit” doesn’t logically fit the sentence.",
        " Explanation: “Liquid” is a cognate of “Liquido” — it is one of the states of matter: gas, solid, liquid, so on. ",
        " “Factory” is unrelated to rarity in the natural world."
      ]
    },
    {
      "question":
          "The __________ was filled with doctors and nurses.\n\nWhat word best completes the sentence?",
      "options": ["A) Hospital", "B) Office", "C) Success", "D) Folder"],
      "correctIndex": 0,
      "feedback": [
        " Explanation: “Hospital” means the same in English and Spanish — a place for medical care.",
        " “Office” could have people, but not specifically doctors and nurses.",
        " “Success” doesn’t describe a place with people.",
        " “Folder” is an object, not a place."
      ]
    },
    {
      "question":
          "My mom bought me a new __________ for school.\n\nWhat word best completes the sentence?",
      "options": ["A) Folder", "B) Soup", "C) Carpet", "D) Current"],
      "correctIndex": 0,
      "feedback": [
        " Explanation: “Carpeta” is a false cognate — it means “folder,” not “carpet.”",
        " “Soup” is unrelated to school supplies.",
        " “Carpet” is a false friend — it seems like “carpeta,” but it means something else.",
        " “Current” refers to flow or time — not a school item."
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
                    backgroundColor: Colors.white,
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
                      color: Colors.white,
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
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(options[i],
                              style: const TextStyle(fontSize: 18)),
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
                              fontSize: 16,
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
                                                color: const Color(0xFF4DB6AC) // _accentBlue
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
                                color: Colors.white,
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
        'The company received many solicitations after posting the job offer.\n\nWhich word may be incorrectly used in this context?',
    options: ["A) Company", "B) Received", "C) Solicitations", "D) Folder"],
    correctIndex: 2,
    explanation:
        '✔️ Explanation:“Solicitations” means requests for donations or services. It\'s confused with “applications” due to the Spanish solicitudes. The correct word here is “applications',
    incorrectExplanations: [
      'Don\'t worry\'s is a common error',
      'Don\'t worry\'s is a common error',
      '',
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
    with SingleTickerProviderStateMixin {
  int _currentStep = 0;
  String? _selectedAnswer;
  double _progressValue = 0.2;
  late AnimationController _animationController;
  bool _correctAnswer = false;
  bool? _confirmationAnswer;

  // Blue color scheme matching your preference
  final Color _primaryColor = const Color(0xFF00897B); // turquesa profundo
  final Color _darkBlue = const Color(0xFF00695C); // turquesa oscuro
  final Color _accentColor = const Color(0xFF4DB6AC); // turquesa medio
  final Color _lightBlue = const Color(0xFFB2EBE5); // turquesa suave
  final Color _lightBlueBg = const Color(0xFFE0F7F4); // turquesa muy claro
  final Color _softBlue = const Color(0xFF80CBC4); // turquesa medio-claro

  // Interactive states
  bool _sentenceAnalyzed = false;
  List<String> _selectedMeanings = [];
  final Map<String, bool> _wordAnalysis = {
    'Company': true,
    'Received': true,
    'Solicitations': false,
    'Posting': true,
  };

  // Interactive animation
  bool _jobOfferAnimation = false;
  bool _applicationsAnimation = false;

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
    _selectedMeanings = [];
    _wordAnalysis.forEach((key, value) {
      _wordAnalysis[key] = false;
    });
    _jobOfferAnimation = false;
    _applicationsAnimation = false;
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
                "🔍 Step 1: Analyze the Sentence",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),

              // Interactive Sentence Card

              GestureDetector(
                onTap: () {
                  setState(() {
                    _jobOfferAnimation = !_jobOfferAnimation;
                    _applicationsAnimation = !_applicationsAnimation;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
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
                        color: _primaryColor,
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                 child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tap the icons to analyze the sentence:",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _jobOfferAnimation
                                  ? _lightBlue
                                  : Colors.white,
                              border:
                                  Border.all(color: _primaryColor, width: 3),
                              boxShadow: _jobOfferAnimation
                                  ? [
                                      BoxShadow(
                                        color: Colors.blue,
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.work,
                                size: 50,
                                color: _jobOfferAnimation
                                    ? Colors.blue
                                    : _darkBlue,
                              ),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _applicationsAnimation
                                  ? _lightBlue
                                  : Colors.white,
                              border:
                                  Border.all(color: _primaryColor, width: 3),
                              boxShadow: _applicationsAnimation
                                  ? [
                                      BoxShadow(
                                        color: Colors.green,
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.description,
                                size: 50,
                                color: _applicationsAnimation
                                    ? Colors.green
                                    : _darkBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Read the sentence carefully:",
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
                          color: _lightBlue,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _primaryColor, width: 1),
                        ),
                        child: Text(
                          "The company received many solicitations after posting the job offer.",
                          style: TextStyle(
                            fontSize: 22,
                            fontStyle: FontStyle.italic,
                            color: _darkBlue,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (_jobOfferAnimation && _applicationsAnimation)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "💼 Job Offer → 📄 Applications",
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

              // What is the sentence about?
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
                        "What is the sentence about?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Meaning Options
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _buildMeaningButton("A company giving away money"),
                          _buildMeaningButton(
                              "A company getting requests from customers"),
                          _buildMeaningButton(
                              "A company getting responses to a job opening"),
                          _buildMeaningButton(
                              "A company posting advertisements"),
                        ],
                      ),

                      const SizedBox(height: 20),
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
                  onPressed: _sentenceAnalyzed ? _nextStep : null,
                  child: const Text(
                    "Identify False Cognate ➡️",
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

  Widget _buildMeaningButton(String text) {
    final isSelected = _selectedMeanings.contains(text);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMeanings = [text]; // Solo una selección

          // Validar respuesta correcta
          if (text == "A company getting responses to a job opening") {
            _sentenceAnalyzed = true;
          } else {
            _sentenceAnalyzed = false;
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? _primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? _primaryColor : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? _darkBlue : Colors.black87,
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
                "⚠️ Step 2: Watch Out for False Cognates!",
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
                        "What are false cognates?",
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
                          color: _lightBlue,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _primaryColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.warning, color: Colors.orange),
                                const SizedBox(width: 10),
                                Text(
                                  "False Cognate Alert:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange[800],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "False cognates are words that look and sound similar in two languages but have different meanings.\n\n"
                              "\"Solicitations\" looks like the Spanish word \"solicitudes\", but it's a false cognate!",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Text(
                          "In English, 'solicitations' means requests for donations or services — NOT job applications!",
                          style: TextStyle(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Cognate Options
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
                        "Which word is the false cognate?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildCognateOption(
                        "A) Company ",
                        "A",
                        false,
                        Icons.business,
                      ),
                      _buildCognateOption(
                        "B) Received ",
                        "B",
                        false,
                        Icons.download,
                      ),
                      _buildCognateOption(
                        "C) Solicitations  ",
                        "C",
                        true,
                        Icons.warning,
                      ),
                      _buildCognateOption(
                        "D) Posting ",
                        "D",
                        false,
                        Icons.post_add,
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
                            ? Colors.green
                            : Colors.orange,
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
                                        ? "Correct!"
                                        : "Try another option...",
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
                                    ? "Correct! 'Solicitations' is a false cognate with Spanish 'solicitudes'."
                                    : _getCognateFeedback(_selectedAnswer!),
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
                      "Find the Correct Word ➡️",
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

  Widget _buildCognateOption(
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
                  ? const Color.fromARGB(255, 40, 170, 116)
                  : Colors.orange)
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? (isCorrect ? const Color.fromARGB(255, 40, 170, 116) : Colors.orange)
                : Colors.grey[300]!,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? (isCorrect
                      ? const Color.fromARGB(255, 40, 170, 116)
                      : Colors.orange)
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
                    ? (isCorrect ? const Color.fromARGB(255, 67, 222, 157) : Colors.orange)
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
                color: isCorrect ? const Color.fromARGB(255, 255, 255, 255) : Colors.orange,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  String _getCognateFeedback(String option) {
    switch (option) {
      case "A":
        return "Company is correct - it means a business in both English and Spanish.";
      case "B":
        return "Received is correct - it means to get something in both languages.";
      case "D":
        return "Posting is correct - it means to advertise or share in both languages.";
      default:
        return "Look for the word that has a different meaning in Spanish and English.";
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
                "📝 Step 3: Find the Correct Word",
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
                        "What should the sentence say?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Word Replacement Activity
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightBlue,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _primaryColor),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Original sentence with false cognate:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "The company received many SOLICITATIONS after posting the job offer.",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Correct sentence should be:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "The company received many APPLICATIONS after posting the job offer.",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),

                      Text(
                        "What word should replace 'solicitations'?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 15),

                      _buildReplacementOption(
                        "A) Donations",
                        false,
                      ),
                      _buildReplacementOption(
                        "B) Applications",
                        true,
                      ),
                      _buildReplacementOption(
                        "C) Requests",
                        false,
                      ),
                      _buildReplacementOption(
                        "D) Offers",
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
                            ? Colors.green
                            : Colors.orange,
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
                                        ? " Perfect!"
                                        : "💡 Try again!",
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
                                    ? "Correct! 'Applications' is the right word for job requests."
                                    : "Remember: we're talking about responses to a job offer.",
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
                    "Identify the Error ➡️",
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

  Widget _buildReplacementOption(String text, bool isCorrect) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: _lightBlue),
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
                ? Colors.green
                : Colors.orange)
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
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
                    " Final Answer:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // RESPUESTA
                  Text(
                    "C) Solicitations",
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
                              "\"Solicitations\" is a false cognate of the Spanish word \"solicitudes\".\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "In English, it refers to requests for services or donations — not job applications.\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "The correct word in this sentence would be \"applications\".",
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
                      color: _lightBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning, color: Colors.orange),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            "False Cognate Detection: Identifying words that look similar but have different meanings",
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
    '💡 General Hint: Look for a word that doesn’t fit the context of remembering conversation points.',
    '📌 More Specific: Which word is often confused with ‘summary’?',
  ];

  final List<String> hints2 = [
    '💡 General Hint: Look for a word that doesn’t fit the context of a campaign.',
    '📌 More Specific: Which word could be confused with a Spanish word for ‘events’?',
  ];

  final List<String> hints3 = [
    '💡 General Hint: Look for a word that doesn’t fit the context of packing for a vacation.',
    '📌 More Specific: Which word is often confused with the Spanish word for ‘clothes’?',
  ];

  final List<String> hints4 = [
    '💡 General Hint: Look for a word that doesn’t match the type of assignment.',
    '📌 More Specific: Which word is often confused with ‘reading’ in Spanish?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Please send me the resume of our conversation so I can remember the main points.\n\nWhich word is incorrect or misused?",
      "options": ["A) Please", "B) Resume", "C) Conversation", "D) Remember"],
      "correctIndex": 1,
      "feedback": [
        " “Please” is correctly used as a polite request.",
        " “Resume” is a job document. It's likely confused with “summary” because of the Spanish resumen. The right word is “summary” or “recap.”",
        " “Conversation” fits the context of the sentence.",
        " “Remember” makes sense in this context — recalling information."
      ]
    },
    {
      "question":
          "The candidate promised to assist all public acts during the campaign.\n\nWhich word is incorrectly used in this sentence?",
      "options": ["A) Candidate", "B) Assist", "C) Acts", "D) Campaign"],
      "correctIndex": 2,
      "feedback": [
        " “Candidate” is correct — a person running for election.",
        " “Assist” fits logically, meaning to help or attend.",
        " “Acts” usually means performances or actions, not events. It’s likely confused with the Spanish actos. A better word here is “events.”",
        " “Campaign” is appropriate in a political context."
      ]
    },
    {
      "question":
          "He packed all his rope into a suitcase for the beach vacation.\n\nWhich word is incorrectly used in this sentence?",
      "options": ["A) Packed", "B) Vacation", "C) Suitcase", "D) Rope"],
      "correctIndex": 3,
      "feedback": [
        " “Packed” is correct — it means to put items into a container.",
        " “Vacation” is appropriate for a beach trip.",
        " “Suitcase” makes sense as a container for clothes.",
        " “Rope” means a thick cord, not clothing. It seems the speaker meant “clothes,” likely confusing it with ropa in Spanish."
      ]
    },
    {
      "question":
          "I stayed up late finishing the lecture the teacher gave us for homework.\n\nWhich word is incorrectly used in this sentence?",
      "options": ["A) Stayed", "B) Finishing", "C) Lecture", "D) Homework"],
      "correctIndex": 2,
      "feedback": [
        " “Stayed” is correctly used to show staying up late.",
        " “Finishing” fits the context of completing something.",
        " “Lecture” is a spoken presentation, not something you read. It’s probably confused with “reading” (lectura in Spanish).",
        " “Homework” makes sense in this context — a school task."
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
                    backgroundColor: Colors.white,
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
                      color: Colors.white,
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
                          backgroundColor: Colors.white,
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
                                color: Colors.white,
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
    question: 'Match the word: Asistir',
    options: ["A) To Resist", "B) To Help", "C) To Attend", "D) To Assist"],
    correctIndex: 2,
    explanation:
        '✔️ Explanation: “Asistir” looks like “assist,” but means “to attend” — false cognate.',
    incorrectExplanations: [
      'Don\'t worry\'s is a common error',
      'Don\'t worry\'s is a common error',
      '',
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
  String? _selectedContext;
  String? _similarityFeedback;
  final String _correctSimilarity = 'Looks like "assist"';

  bool _wordRecognized = false;

  // Blue color scheme matching your preference
  final Color _primaryColor = const Color.fromARGB(255, 12, 137, 193);
  final Color _darkBlue = const Color.fromARGB(255, 8, 100, 150);
  final Color _accentColor = const Color.fromARGB(255, 83, 163, 255);
  final Color _lightBlue = const Color.fromARGB(255, 210, 231, 255);
  final Color _lightBlueBg = const Color(0xFFE3F2FD);
  final Color _softBlue = const Color(0xFFBBDEFB);

  // Interactive states
  // ignore: unused_field
  List<String> _selectedContexts = [];
  bool _spanishMeaningUnderstood = false;

  // Interactive animation
  bool _assistAnimation = false;
  bool _attendAnimation = false;
  bool _helpAnimation = false;

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
    _wordRecognized = false;
    _selectedContexts = [];
    _spanishMeaningUnderstood = false;
    _assistAnimation = false;
    _attendAnimation = false;
    _helpAnimation = false;
    _selectedAnswer = null;
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
                "🔤 Step 1: Recognize the Word",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              _buildProgressIndicator(),
              const SizedBox(height: 20),

              // Word Recognition Card
              GestureDetector(
                onTap: () {
                  setState(() {
                    _assistAnimation = !_assistAnimation;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
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
                        color: _primaryColor,
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _assistAnimation ? _lightBlue : Colors.white,
                          border: Border.all(color: _primaryColor, width: 3),
                          boxShadow: _assistAnimation
                              ? [
                                  BoxShadow(
                                    color: Colors.blue,
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            "Asistir",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: _assistAnimation ? Colors.blue : _darkBlue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Read the word carefully:",
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
                          color: _lightBlue,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _primaryColor, width: 1),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "\"Asistir\"",
                              style: TextStyle(
                                fontSize: 28,
                                fontStyle: FontStyle.italic,
                                color: _darkBlue,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Ask yourself:\n• Do I recognize this word?\n• Does it look like an English word?",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      if (_assistAnimation)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "⚠️ Looks like English \"assist\"",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Recognition Check
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
                        "Choose the right translation:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Word Similarity Options
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _buildSimilarityButton("Looks like \"assist\""),
                          _buildSimilarityButton("Looks like \"resist\""),
                          _buildSimilarityButton("Looks like \"insist\""),
                          _buildSimilarityButton("Looks like \"persist\""),
                        ],
                      ),

                      if (_similarityFeedback != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: _wordRecognized
                                ? Colors.green
                                : Colors.red,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  _wordRecognized ? Colors.green : Colors.red,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            _similarityFeedback!,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _wordRecognized
                                  ? Colors.green[800]
                                  : Colors.red[800],
                            ),
                          ),
                        ),
                      ],

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // Understanding Check

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
                  onPressed: _wordRecognized ? _nextStep : null,
                  child: const Text(
                    "Check for False Cognate ➡️",
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

  Widget _buildSimilarityButton(String text) {
    final isSelected = _selectedContext == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedContext = text;

          if (text == _correctSimilarity) {
            _similarityFeedback =
                "In this case, “asistir” and “assist” look alike, but they don’t mean the same thing.\n\nThis is a false cognate — it tricks learners because it looks familiar.";
            _wordRecognized = true;
          } else {
            _similarityFeedback =
                " Not quite. \"Asistir\" looks more like \"assist\" in English.";
            _wordRecognized = false;
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? _primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? _primaryColor : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? _darkBlue : Colors.black87,
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
                "⚠️ Step 2: Identify False Cognate",
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
                        "What are cognates?",
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
                          color: _lightBlue,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _primaryColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.translate, color: _primaryColor),
                                const SizedBox(width: 10),
                                Text(
                                  "Cognates vs False Cognates:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _darkBlue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "• Cognates: Words that look similar AND have same meaning\n"
                              "• False Cognates: Words that look similar BUT have different meanings\n\n"
                              "\"Asistir\" looks like \"assist\" but doesn't mean the same thing!",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      Border.all(color: Colors.green, width: 2),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Asistir",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text("Spanish"),
                            ],
                          ),
                          const Icon(Icons.compare_arrows,
                              size: 40, color: Colors.grey),
                          Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: Colors.orange, width: 2),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Assist",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text("English"),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Text(
                          "⚠️ This is a FALSE COGNATE!\n"
                          "It tricks learners because it looks familiar but means something different.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.red[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                    "Find True Meaning ➡️",
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
                "🤔 Step 3: Discover True Meaning",
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
                        "What does \"asistir\" really mean in Spanish?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Context Examples
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightBlue,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _primaryColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Think about these common phrases:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            _buildContextExample(
                              "Asistir a una clase",
                              "Attend a class",
                              Icons.school,
                            ),
                            _buildContextExample(
                              "Asistir a una reunión",
                              "Attend a meeting",
                              Icons.people,
                            ),
                            _buildContextExample(
                              "Asistir a un evento",
                              "Attend an event",
                              Icons.event,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Interactive Meaning Discovery
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _helpAnimation = !_helpAnimation;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: _helpAnimation
                                    ? Colors.red
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: _helpAnimation
                                      ? Colors.red
                                      : Colors.grey[300]!,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.help_outline,
                                    size: 40,
                                    color:
                                        _helpAnimation ? Colors.red : _darkBlue,
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "To Help",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "English: assist",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _attendAnimation = !_attendAnimation;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: _attendAnimation
                                    ? Colors.green
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: _attendAnimation
                                      ? Colors.green
                                      : Colors.grey[300]!,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.event_available,
                                    size: 40,
                                    color: _attendAnimation
                                        ? Colors.green
                                        : _darkBlue,
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "To Attend",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "Spanish: asistir",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.lightbulb, color: Colors.green),
                                const SizedBox(width: 10),
                                Text(
                                  "Key Discovery:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _darkBlue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Even though \"asistir\" looks like \"assist\", it really means \"to attend\" in Spanish.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Understanding Check
                    ],
                  ),
                ),
              ),
              if (_spanishMeaningUnderstood) ...[
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
                      "Choose Correct Translation ➡️",
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

  Widget _buildContextExample(String spanish, String english, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _lightBlue),
      ),
      child: Row(
        children: [
          Icon(icon, color: _primaryColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  spanish,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  english,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
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
                " Step 4: Choose Correct Translation",
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
                        "What does \"asistir\" mean in English?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Word Translation Activity
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _lightBlue,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _primaryColor),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Spanish word:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "ASISTIR",
                              style: TextStyle(
                                fontSize: 32,
                                color: _primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "English translation:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _selectedAnswer == null
                                      ? _primaryColor
                                      : _selectedAnswer == "C"
                                          ? Colors.green
                                          : Colors.red,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  _selectedAnswer == null
                                      ? "Choose an option"
                                      : _selectedAnswer == "A"
                                          ? "To Resist"
                                          : _selectedAnswer == "B"
                                              ? "To Help"
                                              : _selectedAnswer == "C"
                                                  ? "To Attend"
                                                  : "To Assist",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: _selectedAnswer == null
                                        ? _darkBlue
                                        : _selectedAnswer == "C"
                                            ? Colors.green
                                            : Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      Text(
                        "Select the correct meaning:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _darkBlue,
                        ),
                      ),
                      const SizedBox(height: 15),

                      _buildTranslationOption(
                        "A) To Resist",
                        "A",
                        false,
                      ),
                      _buildTranslationOption(
                        "B) To Help ",
                        "B",
                        false,
                      ),
                      _buildTranslationOption(
                        "C) To Attend ",
                        "C",
                        true,
                      ),
                      _buildTranslationOption(
                        "D) To Assist ",
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
                        color: _selectedAnswer == "C"
                            ? Colors.green
                            : Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    _selectedAnswer == "C"
                                        ? Icons.check_circle
                                        : Icons.error,
                                    color: _selectedAnswer == "C"
                                        ? Colors.green
                                        : Colors.red,
                                    size: 28,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    _selectedAnswer == "C"
                                        ? " Perfect Translation!"
                                        : " Try Again!",
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
                                _selectedAnswer == "C"
                                    ? "Correct! \"Asistir\" means \"to attend\" in English."
                                    : "Remember: \"Asistir\" ≠ \"to assist\". It's a false cognate!",
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
                      if (_selectedAnswer != "C")
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
              if (_selectedAnswer == "C") ...[
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

  Widget _buildTranslationOption(String text, String option, bool isCorrect) {
    final bool isSelected = _selectedAnswer == option;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: isSelected
          ? (isCorrect
              ? Colors.green
              : Colors.red)
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
                    " Final Answer:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // RESPUESTA
                  Text(
                    "C) To Attend",
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
                              "\"Asistir\" looks like the English word \"assist,\" but it's a false cognate.\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "In Spanish, \"asistir\" means \"to attend\" (like attending a class or event).\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              "The word \"assist\" means \"to help,\" which would be \"ayudar\" in Spanish.",
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
                      color: _lightBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning, color: Colors.orange),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            "False Cognate Detection: Recognizing words that look similar but have different meanings",
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
    '💡 General Hint: Which option refers to something you wear?',
  ];

  final List<String> hints2 = [
    '💡 General Hint: Which word refers to something fragile or sensitive?',
  ];

  final List<String> hints3 = [
    '💡 General Hint: Which word refers to being with child?',
  ];

  final List<String> hints4 = [
    '💡 General Hint: Which word refers to achieving something great? ',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question": "Match the word: Ropa",
      "options": ["A) Clothes", "B) Rope", "C) Rug", "D) Clock"],
      "correctIndex": 0,
      "feedback": [
        " Correct! 'Ropa' means 'clothes'.",
        " 'Rope' is a false friend — it looks similar, but has a different meaning.",
        " 'Rug' is incorrect. It's 'alfombra' in Spanish.",
        " 'Clock' is incorrect. It's 'reloj' in Spanish."
      ]
    },
    {
      "question": "Match the word: Delicado",
      "options": ["A) Spicy", "B) Sensitive", "C) Delicious", "D) Durable"],
      "correctIndex": 1,
      "feedback": [
        " 'Spicy' is incorrect. That's 'picante' in Spanish.",
        "  Correct! 'Delicado' means 'sensitive' or 'fragile'.",
        " 'Delicious' is a false cognate — 'delicioso' is the right word for that.",
        " 'Durable' is unrelated in this context."
      ]
    },
    {
      "question": "Match the word: Embarazada",
      "options": ["A) Embarrassed", "B) Pregnant", "C) Nervous", "D) Ashamed"],
      "correctIndex": 1,
      "feedback": [
        " 'Embarrassed' is a false cognate — very common confusion!",
        " Correct! 'Embarazada' means 'pregnant' in Spanish.",
        " 'Nervous' is not the correct meaning of 'embarazada'.",
        " 'Ashamed' is not the same as 'embarazada'."
      ]
    },
    {
      "question": "Match the word: Éxito",
      "options": ["A) Exit", "B) Existence", "C) Strategy", "D) Success"],
      "correctIndex": 3,
      "feedback": [
        " 'Exit' is a common false cognate — 'éxito' means 'success'.",
        " 'Existence' is incorrect. That’s 'existencia'.",
        " 'Strategy' is incorrect. That’s 'estrategia'.",
        "  Correct! 'Éxito' means 'success' in Spanish."
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
              backgroundColor: const Color(0xFFEAF3FF), // azul clarito
              titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              title: const Row(
                children: [
                  Icon(Icons.emoji_events, color: Color(0xFF4DA3FF), size: 30),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Level Complete!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E3A8A),
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
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF334155),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Get ready for the next challenge!",
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF2563EB),
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
                    foregroundColor: const Color(0xFF2563EB),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  label: const Text("Advance"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF60A5FA),
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
      backgroundColor: const Color(0xFFEAF2FF),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFEAF2FF),
              Color(0xFFDCEBFF),
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
                    backgroundColor: Colors.white,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF60A5FA),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Choose the right option",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      question['question'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF1F2937),
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
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF1F2937),
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
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
                            fontSize: 16,
                            color: selectedOptionIndex == correctIndex
                                ? const Color(0xFF1E3A8A)
                                : const Color(0xFFDC2626),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  selectedOptionIndex == correctIndex
                                      ? const Color(0xFF93C5FD)
                                      : const Color(0xFFBFDBFE),
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
                                color: Color(0xFF1F2937),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 30),
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
                                            color: const Color(0xFF93C5FD)
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
                                      ? const Color(0xFF60A5FA)
                                      : const Color(0xFF2563EB),
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
                                } else if (currentQuestionIndex == 1) {
                                  hintStep2++;
                                } else if (currentQuestionIndex == 2) {
                                  hintStep3++;
                                } else if (currentQuestionIndex == 3) {
                                  hintStep4++;
                                }
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
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: const Color(0xFF93C5FD)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      currentHint,
                                      style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xFF1F2937),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close, size: 20),
                                    onPressed: () {
                                      setState(() {
                                        if (currentQuestionIndex == 0) {
                                          hintStep1 = hints1.length;
                                        } else if (currentQuestionIndex == 1) {
                                          hintStep2 = hints2.length;
                                        } else if (currentQuestionIndex == 2) {
                                          hintStep3 = hints3.length;
                                        } else if (currentQuestionIndex == 3) {
                                          hintStep4 = hints4.length;
                                        }
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
        .set({'completedInstructionSpot2': true}, SetOptions(merge: true));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('spotCompletado', true);

    await _saveProgressToCloud(user);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (route) => false,
    );
  }

  Future<void> _saveProgressToCloud(User user) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('userProgress').doc(user.uid).set({
      'completedInstructionSpot2': true,
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
                  "Awesome job! Keep up the great work and you'll be a pro in no time! 🎉💪",
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
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: const Color(0xFF4DD0C4),
                      width: 1.5,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'To sum up... \n\nLexical inference, especially through recognizing cognates, is a powerful tool for expanding vocabulary and understanding unfamiliar words. \n\n💠 Just remember to watch out for false friends!',
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
                      shadowColor: const Color(0xFF00695C),
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
