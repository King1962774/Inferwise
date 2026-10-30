// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_4/Animation4_2.dart';
import 'package:inferwise/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InstructionSpotPage4_2 extends StatefulWidget {
  final String title;
  final List<String> instructions;
  final String tipTitle;
  final List<String> tips;
  final String finalNote;

  const InstructionSpotPage4_2({
    super.key,
    required this.title,
    required this.instructions,
    required this.tipTitle,
    required this.tips,
    required this.finalNote,
  });

  @override
  State<InstructionSpotPage4_2> createState() => _InstructionSpotPage4_2State();
}

class _InstructionSpotPage4_2State extends State<InstructionSpotPage4_2> {
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
      'image': 'assets/Imagenes de ejemplos/Level4/4.3 A Leaves.webp',
      'text':
          'The leaves turned orange and fell from the trees.\n✴️ Here, you use temporal inference to understand that it is probably autumn.',
    },
    {
      'title': 'Example 2',
      'image': 'assets/Imagenes de ejemplos/Level4/4.3 B Streetlights.webp',
      'text':
          'The streetlights turned on, and people started heading home.\n✴️ Here, you use temporal inference to understand that it is likely evening.',
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
                      "Inferring the Time",
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
                    'Readers figure out when something happens in a sentence or text by connecting it to related ideas you already know.',
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
      'image': 'assets/Imagenes de ejemplos/Level4/4.3 C Jump out of bed.webp',
      'text':
          'The alarm clock rang, and she jumped out of bed.\n✴️ Temporal inference: It is probably morning.',
    },
    {
      'title': 'Example 2',
      'image': 'assets/Imagenes de ejemplos/Level4/4.3 D Fireworks.webp',
      'text':
          'The fireworks lit up the sky, and the crowd cheered loudly.\n✴️ Temporal inference: It is probably night time, maybe during a celebration.',
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
                  fontSize: 15,
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
                      "Inferring the time",
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
                      color: const Color(0xFFFF9800).withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Special note:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Sometimes the exact time isn\'t mentioned because the writer expects you to fill in the gap from common knowledge.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
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
    '🟠 2. Think about possible times or seasons \n\nCoats and umbrellas are usually used in cold or rainy weather — maybe fall, winter, or a rainy day.',
    '🟠 3. Look for context clues\n\nThe sentence doesn\u2019t say when, but the clothing and umbrella hint at chilly or wet weather.',
    '🟠 4. Use real-world knowledge and plausibility\n\nPeople wear coats and use umbrellas when it\u2019s cold or raining.',
    '🟠 5. Confirm the inference\n\nJake is most likely getting ready to go outside during a cold or rainy time, probably fall, winter, or a rainy day.',
    ' Final Answer:\n\nJake is probably preparing to go out on a cold or rainy day.',
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
      margin: const EdgeInsets.symmetric(vertical: 8),
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
            color: Color(0xFFFF9800),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: const Text(
        '💡 Quick note\n\nIf more context appears (e.g., "in the early morning" or "during the spring shower"), update your inference. When details are missing, say "probably" or "most likely" instead of being certain.',
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
              "Let's infer the time in the next sentence:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Oración de contexto
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
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
                '"Jake put on his coat and grabbed his umbrella."',
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

            // PageView de pasos
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

            // Botones de navegación
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
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Readers figure out when something happens in a sentence by connecting it to what you know about the world.',
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
                          'The bakery was filled with the smell of fresh bread, and customers lined up early.',
                      inference:
                          'Temporal inference: It is probably morning, since bakeries usually open early and bread is freshly baked then.',
                    ),
                    _buildExample(
                      sentence:
                          'The children put on their pajamas and got ready for bed.',
                      inference:
                          'Temporal inference: It is likely nighttime, as pajamas and bedtime routines happen then.',
                    ),
                    _buildExample(
                      sentence:
                          'The school bell rang, and students rushed outside.',
                      inference:
                          'Temporal inference: It is probably the end of the school day or recess time.',
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
                                'Sometimes the exact time isn’t mentioned because it’s assumed you know it. If more than one time fits, choose the most likely based on context.',
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
    '1. Identify time-related words or clues in the sentence.',
    '2. Think about when these events or actions usually happen.',
    '3. Look for extra clues nearby (words like “early,” “bedtime,” “bell”).',
    '4. Use real-world knowledge — when do these activities or changes typically occur?',
    '5. State your inference clearly; if uncertain, say “most likely” or offer alternatives.',
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
                  ' Quick tip: If new information appears later, revise your inference — inferring the time depends on clues and aren’t always definite.',
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
        'The children put on their pajamas and brushed their teeth before getting into bed.\n\nWhen is this probably happening?',
    options: [
      "A) In the morning",
      "B) At lunchtime",
      "C) At night",
      "D) In the afternoon"
    ],
    correctIndex: 2,
    explanation:
        'Putting on pajamas and brushing teeth before bed strongly indicates nighttime.',
    incorrectExplanations: [
      'Don\'t worry\'s is a common error',
      'Don\'t worry\'s is a common error',
      '',
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
    if (_currentStep == 3 && _inferenceAnswer == null) {
      _showFeedbackMessage('Please make your inference');
      return;
    }

    _animationController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
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
    "The children have pajamas on": false,
    "They are brushing their teeth before bed": false,
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
                                "\"The children put on their pajamas and brushed their teeth before getting into bed.\"",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: _darkOrange),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.bedtime, color: _primaryColor, size: 30),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      Text(
                        "What is the sentence mainly about?",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: _darkOrange),
                      ),
                      const SizedBox(height: 12),

                      _buildStep1Option(
                        "A) The children are getting dressed for school.",
                        "A",
                        false,
                        "Not quite — pajamas are not school clothes.",
                      ),
                      _buildStep1Option(
                        "B) The children are getting ready to go outside.",
                        "B",
                        false,
                        "Not really — pajamas and brushing teeth before bed suggest staying in.",
                      ),
                      _buildStep1Option(
                        "C) The children are cleaning their room.",
                        "C",
                        false,
                        "No — there's no mention of cleaning anything.",
                      ),
                      _buildStep1Option(
                        "D) The children are getting ready for bed.",
                        "D",
                        true,
                        "Correct! ✅ Putting on pajamas, brushing teeth, and getting into bed are actions people do to prepare for sleeping.",
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
                // Limpiar todas las opciones y seleccionar solo esta
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
                                "\"The children put on their pajamas and brushed their teeth before getting into bed.\"",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: _darkOrange),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.bedtime, color: _primaryColor, size: 24),
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
                        "A) Who put on their pajamas",
                        "A",
                        false,
                        "We already know — the children are clearly mentioned.",
                      ),
                      _buildMissingOption(
                        "B) What the children put on",
                        "B",
                        false,
                        "The sentence already tells us — pajamas.",
                      ),
                      _buildMissingOption(
                        "C) What the children did before bed",
                        "C",
                        false,
                        "This is stated — they put on pajamas and brushed their teeth.",
                      ),
                      _buildMissingOption(
                        "D) What time of day it was",
                        "D",
                        true,
                        "Correct! ✅ The sentence describes bedtime activities but doesn't say exactly what time it was.",
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

  // ─── STEP 3 (solo lectura) ────────────────────────────────────────────
  String? _selectedTimeOfDay;

  Widget _buildStep3() {
    final List<Map<String, dynamic>> timeOptions = [
      {
        "label": "In the morning",
        "emoji": "🌅",
        "color": const Color(0xFFBBDEFB),
        "borderColor": const Color(0xFF1E88E5),
        "isCorrect": false,
      },
      {
        "label": "At night",
        "emoji": "🌙",
        "color": const Color(0xFFFFE0B2),
        "borderColor": const Color(0xFFFF9800),
        "isCorrect": true,
      },
      {
        "label": "At lunchtime",
        "emoji": "☀️",
        "color": const Color(0xFFFFF9C4),
        "borderColor": const Color(0xFFF9A825),
        "isCorrect": false,
      },
      {
        "label": "In the afternoon",
        "emoji": "🌤️",
        "color": const Color(0xFFFFCCBC),
        "borderColor": const Color(0xFFE64A19),
        "isCorrect": false,
      },
    ];

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
                "🌍 Step 3: Real World Knowledge",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: _darkOrange),
              ),
              const SizedBox(height: 12),
              _buildProgressIndicator(),

              // Panel de lectura
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
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
                                  color: _darkOrange),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _lightOrange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: _primaryColor.withOpacity(0.2)),
                        ),
                        child: Text(
                          "💭 If children put on their pajamas, brush their teeth, and get into bed, when is this most likely happening?",
                          style: TextStyle(
                              fontSize: 16, color: _darkOrange, height: 1.5),
                        ),
                      ),
                      const SizedBox(height: 12),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 14),
                        decoration: BoxDecoration(
                          color: _primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: _primaryColor.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.touch_app,
                                color: _primaryColor, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              "✴️ Think about the time of day\n when people usually get \nready to sleep.",
                              style: TextStyle(
                                fontSize: 14,
                                color: _primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Opciones de tiempo del día como tarjetas de color
                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 2.2,
                        children: timeOptions.map((opt) {
                          final bool isSelected =
                              _selectedTimeOfDay == opt['label'];
                          final bool isCorrect = opt['isCorrect'] as bool;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedTimeOfDay = opt['label'] as String;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? (opt['color'] as Color)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? (opt['borderColor'] as Color)
                                      : Colors.grey.shade300,
                                  width: isSelected ? 2.5 : 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    opt['emoji'] as String,
                                    style: const TextStyle(fontSize: 22),
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      opt['label'] as String,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: _darkOrange,
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Icon(
                                        isCorrect
                                            ? Icons.check_circle
                                            : Icons.cancel,
                                        color: isCorrect
                                            ? _primaryColor
                                            : Colors.red,
                                        size: 18,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      // Feedback al seleccionar
                      if (_selectedTimeOfDay != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: _selectedTimeOfDay == "At night"
                                  ? _lightOrange.withOpacity(0.3)
                                  : Colors.red[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _selectedTimeOfDay == "At night"
                                    ? _primaryColor
                                    : Colors.redAccent,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  _selectedTimeOfDay == "At night"
                                      ? Icons.check_circle
                                      : Icons.info_outline,
                                  color: _selectedTimeOfDay == "At night"
                                      ? _primaryColor
                                      : Colors.redAccent,
                                  size: 22,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    _selectedTimeOfDay == "At night"
                                        ? "Correct! ✅ People usually put on pajamas and brush their teeth at night before sleeping."
                                        : "Think again — when do people usually put on pajamas to sleep?",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: _darkOrange,
                                        fontWeight: FontWeight.w500),
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
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                  ),
                  onPressed: _selectedTimeOfDay != null ? _nextStep : null,
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
                        "Based on what you read and what you know.",
                        style: TextStyle(fontSize: 15, color: _darkOrange),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "What's the most logical time for children to go to bed?",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _darkOrange),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Choose the best explanation:",
                        style: TextStyle(fontSize: 15, color: _darkOrange),
                      ),
                      const SizedBox(height: 16),
                      _buildInferenceOption(
                        "A) Children usually go to bed in the morning.",
                        "A",
                        false,
                        "Not quite — mornings are when people wake up, not go to sleep.",
                      ),
                      _buildInferenceOption(
                        "B) Children usually go to bed at night.",
                        "B",
                        true,
                        "Correct! ✅ Children usually go to bed at night, after putting on pajamas and brushing their teeth.",
                      ),
                      _buildInferenceOption(
                        "C) Children are taking a midday nap.",
                        "C",
                        false,
                        "A nap is possible, but pajamas and teeth brushing suggest a full night's sleep.",
                      ),
                      _buildInferenceOption(
                        "D) Children usually go to bed in the afternoon.",
                        "D",
                        false,
                        "Afternoons are typically active times — bedtime routines happen at night.",
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
                                ? "Correct! ✅ Children usually go to bed at night, after putting on pajamas and brushing their teeth."
                                : "Think about when children typically follow a bedtime routine.",
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
                    "The children are on a hiking trail or nature walk",
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
                                "Backpacks and walking on a narrow dirt path into a forest strongly suggest the children are on a hiking trail\n\n"),
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(
                            text:
                                "This is not an urban or indoor setting based on the description\n\n"),
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(
                            text:
                                "The combination of backpacks, dirt path, and forest points to outdoor recreation"),
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
                // Botón cerrar sin AppBar
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: _darkOrange),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Expanded(child: _buildCurrentStep()),
                // Sin botón Back
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
    '💡 General Hint: What time of day does the sun appear above the horizon?',
    '📌 More Specific: What is the term for the moment the sky begins to brighten and birds become active?',
  ];

  final List<String> hints2 = [
    '💡 General Hint: When do streetlights need to be turned on?',
    '📌 More Specific: What time is it when the sun has just set and the sky is transitioning from light to dark?',
  ];

  final List<String> hints3 = [
    '💡 General Hint: When do students typically get ready to leave for school?',
    '📌 More Specific: Which part of the day precedes the start of the school day?',
  ];

  final List<String> hints4 = [
    '💡 General Hint: What holiday season is traditionally associated with colorful lights and wreaths?',
    '📌 More Specific: In what month do people commonly put up Christmas decorations?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "The sun rose over the horizon, and birds started singing loudly. When is this probably happening?",
      "options": [
        "A) At sunrise",
        "B) At noon",
        "C) At sunset",
        "D) At midnight"
      ],
      "correctIndex": 0,
      "feedback": [
        "Explanation: The sun rising and birds singing indicates early morning or sunrise.",
        "At noon would be too late for sunrise.",
        "At sunset the sun goes down, not up.",
        "At midnight it's completely dark, not when birds sing."
      ]
    },
    {
      "question":
          "Sarah switched on the streetlights as the sky turned dark. When is this probably happening?",
      "options": [
        "A) Early morning",
        "B) Midday or midnight",
        "C) Evening or dusk",
        "D) Late at night"
      ],
      "correctIndex": 2,
      "feedback": [
        "Explanation: Streetlights are typically turned on at dusk or evening when it starts getting dark.",
        "Early morning would be when lights are turned off, not on.",
        "Midday is bright, and midnight is much later than dusk.",
        "Late at night the lights are already on, not just being switched on."
      ]
    },
    {
      "question":
          "Jack packed his lunchbox and grabbed his backpack before leaving for school. When is this probably happening?",
      "options": [
        "A) At lunchtime",
        "B) Late afternoon",
        "C) At bedtime",
        "D) Early morning"
      ],
      "correctIndex": 3,
      "feedback": [
        "Explanation: Packing a lunchbox and leaving for school usually happens early in the morning before classes begin.",
        "At lunchtime he would already be in school.",
        "Late afternoon is after school hours.",
        "At bedtime is too late for school preparation."
      ]
    },
    {
      "question":
          "The neighbors put up colorful lights and hung wreaths on their doors. When is this probably happening?",
      "options": [
        "A) Halloween",
        "B) Summer vacation",
        "C) Easter",
        "D) December"
      ],
      "correctIndex": 3,
      "feedback": [
        "Explanation: Putting up colorful lights and wreaths is a common decoration tradition during the Christmas season in December.",
        "Halloween decorations are usually spooky, not wreaths and lights.",
        "Summer vacation doesn’t involve holiday decorations.",
        "Easter typically uses pastel colors and eggs, not wreaths and lights."
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
  //Ponerse al dia
  QuestionData(
    question:
        'The farmers gathered their crops and stored them away carefully.\n\nIt was probably ____.',
    options: [
      "A) Planting season",
      "B) Harvest season",
      "C) Rainy season",
      "D) Dry season"
    ],
    correctIndex: 1,
    explanation:
        '✔️ Explanation: Harvest season is the time when farmers gather their crops.',
    incorrectExplanations: [
      ' Planting season is when seeds are sown, not when crops are gathered.',
      ' Correct! Harvest season is when crops are collected.',
      ' Rainy season affects planting and growth, not harvesting.',
      ' Dry season comes after crops have already been harvested.'
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
  final Set<String> _selectedOptions = {};
  String? _inferenceAnswer;
  late AnimationController _animationController;
  bool _correctInference = false;

  final Color _primaryColor = const Color(0xFFFF9800);
  final Color _lightOrange = const Color(0xFFFFE0B2);
  final Color _darkOrange = const Color(0xFFE65100);

  // Estado separado para Step 3
  String? _selectedSeason;

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
    if (_currentStep == 2 && _selectedSeason == null) {
      _showFeedbackMessage('Please select a season');
      return;
    }
    if (_currentStep == 3 && _inferenceAnswer == null) {
      _showFeedbackMessage('Please make your inference');
      return;
    }

    _animationController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
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
    "The farmers gathered their crops": false,
    "They stored them away carefully": false,
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
                                "\"The farmers gathered their crops and stored them away carefully.\"",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: _darkOrange),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.grass, color: _primaryColor, size: 30),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      Text(
                        "What is the sentence mainly about?",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: _darkOrange),
                      ),
                      const SizedBox(height: 12),

                      _buildStep1Option(
                        "A) The farmers are planting new crops.",
                        "A",
                        false,
                        "Not quite — the sentence says 'gathered', not 'planted'.",
                      ),
                      _buildStep1Option(
                        "B) The farmers are preparing food for a meal.",
                        "B",
                        false,
                        "No — storing crops away carefully suggests preservation, not cooking.",
                      ),
                      _buildStep1Option(
                        "C) The farmers are harvesting and storing their crops.",
                        "C",
                        true,
                        "Correct! ✅ Gathering and carefully storing crops are actions people do when they are harvesting and preserving their produce for later use.",
                      ),
                      _buildStep1Option(
                        "D) The farmers are selling their crops at the market.",
                        "D",
                        false,
                        "Not quite — storing crops away is different from selling them.",
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
                                "\"The farmers gathered their crops and stored them away carefully.\"",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: _darkOrange),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.grass, color: _primaryColor, size: 24),
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
                        "A) When the crops were gathered",
                        "A",
                        true,
                        "Correct! ✅ The sentence tells us what the farmers did and how they stored the crops, but it does not mention when the harvesting took place.",
                      ),
                      _buildMissingOption(
                        "B) What crops were gathered",
                        "B",
                        false,
                        "While we don't know the type of crops, the key missing detail is when this happened.",
                      ),
                      _buildMissingOption(
                        "C) Who gathered the crops",
                        "C",
                        false,
                        "We already know who — the farmers are clearly mentioned.",
                      ),
                      _buildMissingOption(
                        "D) How the farmers stored the crops",
                        "D",
                        false,
                        "The sentence already tells us — they stored them away carefully.",
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

  // ─── STEP 3 ───────────────────────────────────────────────────────────
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
                "🌾 Step 3: Farming Knowledge",
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
                                  color: _darkOrange),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Pregunta reflexiva
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _lightOrange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: _primaryColor.withOpacity(0.2)),
                        ),
                        child: Text(
                          "💭 When do farmers typically gather and store crops?",
                          style: TextStyle(
                              fontSize: 16, color: _darkOrange, height: 1.5),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Hint
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 14),
                        decoration: BoxDecoration(
                          color: _primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: _primaryColor.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.touch_app,
                                color: _primaryColor, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "✴️ Think about the farming cycle and when crops are ready.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: _primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Info educativa
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _lightOrange.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: _primaryColor.withOpacity(0.2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Think about farming cycles:",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: _darkOrange),
                            ),
                            const SizedBox(height: 10),
                            _buildCycleInfo("🌱 Planting season",
                                "when seeds are sown, crops aren't ready yet"),
                            _buildCycleInfo("🌾 Harvest season",
                                "when crops are collected and stored"),
                            _buildCycleInfo("🌧️ Rainy and dry seasons",
                                "affect farming but don't directly indicate harvesting"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      Text(
                        "Based on this knowledge, when are the farmers gathering crops?",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _darkOrange),
                      ),
                      const SizedBox(height: 12),

                      // Opciones de estación — sin revelar respuesta automáticamente
                      _buildSeasonOption(
                        "🌱  Planting season",
                        "A",
                        false,
                        "Not quite — during planting season, seeds are sown, not gathered.",
                      ),
                      _buildSeasonOption(
                        "🌾  Harvest season",
                        "B",
                        true,
                        "Correct! ✅ Harvest season is when crops are collected and stored after growing.",
                      ),
                      _buildSeasonOption(
                        "🌧️  Rainy season",
                        "C",
                        false,
                        "The rainy season affects crops but doesn't mean they're being harvested.",
                      ),
                      _buildSeasonOption(
                        "☀️  Dry season",
                        "D",
                        false,
                        "The dry season isn't typically when crops are gathered and stored.",
                      ),

                      // Feedback al seleccionar
                      if (_selectedSeason != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: _selectedSeason == "B"
                                  ? _lightOrange.withOpacity(0.3)
                                  : Colors.red[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _selectedSeason == "B"
                                    ? _primaryColor
                                    : Colors.redAccent,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  _selectedSeason == "B"
                                      ? Icons.check_circle
                                      : Icons.info_outline,
                                  color: _selectedSeason == "B"
                                      ? _primaryColor
                                      : Colors.redAccent,
                                  size: 22,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    _selectedSeason == "B"
                                        ? "Correct! ✅ Harvest season is when crops are collected and stored after growing."
                                        : "Think again — during which season do farmers typically gather and store their crops?",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: _darkOrange,
                                        fontWeight: FontWeight.w500),
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
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                  ),
                  onPressed: _selectedSeason != null ? _nextStep : null,
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

  Widget _buildCycleInfo(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _darkOrange),
                ),
                Text(
                  description,
                  style: TextStyle(
                      fontSize: 13, color: _darkOrange.withOpacity(0.8)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeasonOption(
      String text, String option, bool isCorrect, String feedback) {
    final bool isSelected = _selectedSeason == option;
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
                _selectedSeason = option;
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
      ],
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
                        "Based on what you read and what you know.",
                        style: TextStyle(fontSize: 15, color: _darkOrange),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "What is the most likely season for the farmers to gather and store their crops?",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _darkOrange),
                      ),
                      const SizedBox(height: 16),
                      _buildInferenceOption(
                        "🌱  Planting season",
                        "A",
                        false,
                        "Not quite — seeds are sown during planting season, crops aren't ready to gather yet.",
                      ),
                      _buildInferenceOption(
                        "🌾  Harvest season",
                        "B",
                        true,
                        "Correct! ✅ Gathering and storing crops is something farmers do during harvest season.",
                      ),
                      _buildInferenceOption(
                        "🌧️  Rainy season",
                        "C",
                        false,
                        "The rainy season affects growth, but crops aren't typically gathered then.",
                      ),
                      _buildInferenceOption(
                        "☀️  Dry season",
                        "D",
                        false,
                        "The dry season is not typically when crops are gathered and stored.",
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
                                ? "Correct! ✅ Gathering and storing crops is something farmers do during harvest season."
                                : "Think about when farmers typically gather and store their crops.",
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
                    "🌾 Harvest season",
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
                                "Gathering and storing crops is something farmers do during harvest season\n\n"),
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(
                            text:
                                "This is when crops have grown and are ready to be collected\n\n"),
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(
                            text:
                                "The sentence describes farmers gathering and storing crops, which fits perfectly with harvest season activities"),
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
    '💡 General Hint: What kind of season is characterized by thunder, dark clouds, and rainfall?',
    '📌 More Specific: When do people typically need to carry umbrellas and raincoats outdoors?',
  ];

  final List<String> hints2 = [
    '💡 General Hint: Which season follows winter and is marked by widespread flowering?',
    '📌 More Specific: What time of year are bees most active gathering nectar from new blooms?',
  ];

  final List<String> hints3 = [
    '💡 General Hint: What type of season is defined by high heat and a lack of precipitation?',
    '📌 More Specific: When does the weather get so hot that people frequently stay indoors to avoid it?',
  ];

  final List<String> hints4 = [
    '💡 General Hint: What natural event causes riverbanks to overflow and water levels to rise dramatically?',
    '📌 More Specific: Which season is defined by excessive rain leading directly to water inundation?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Dark clouds filled the sky, and the sound of thunder was heard. People grabbed umbrellas and raincoats. It was likely ____.",
      "options": ["A) Dry season", "B) Rainy season", "C) Winter", "D) Summer"],
      "correctIndex": 1,
      "feedback": [
        "Explanation: Thunder, rain, and umbrellas are signs of the rainy season.",
        "Dry season usually has little to no rain.",
        "Winter is associated with cold, not thunderstorms.",
        "Summer can be hot but not necessarily stormy."
      ]
    },
    {
      "question":
          "Flowers started blooming everywhere, and bees buzzed around the garden. The air felt fresh and cool. It was probably ____.",
      "options": ["A) Spring", "B) Autumn", "C) Winter", "D) Dry season"],
      "correctIndex": 0,
      "feedback": [
        "Explanation: Blooming flowers and buzzing bees are typical signs of spring.",
        "Autumn is when leaves fall, not when flowers bloom.",
        "Winter is too cold for most flowers to bloom.",
        "Dry season refers to climate, not to blooming cycles."
      ]
    },
    {
      "question":
          "The days were long and very hot, with little rain for weeks. People stayed indoors during the afternoon. It was likely ____.",
      "options": [
        "A) Dry season",
        "B) Rainy season",
        "C) Winter",
        "D) Harvest season"
      ],
      "correctIndex": 0,
      "feedback": [
        "Explanation: Long, hot, and dry days usually happen during the dry season.",
        "Rainy season has frequent rain, not dryness.",
        "Winter is cold, not hot.",
        "Harvest season focuses on crops, not weather patterns."
      ]
    },
    {
      "question":
          "The riverbanks were flooded, and many people stayed indoors, watching the water rise. It was likely ____.",
      "options": [
        "A) Dry season",
        "B) Flood season",
        "C) Spring",
        "D) Harvest season"
      ],
      "correctIndex": 1,
      "feedback": [
        "Explanation: Flooded riverbanks and rising water usually happen during the rainy or flood season.",
        "Dry season is characterized by a lack of rain, not floods.",
        "Spring involves blooming, not flooding.",
        "Harvest season is related to farming, not weather conditions."
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
    question: 'Which sentence has a temporal mistake?',
    options: [
      "A) Sarah decorated her house with pumpkins and carved a jack-o’-lantern.",
      "B) Mark wore a Santa hat and sang Christmas carols in July.",
      "C) Emily wore a green outfit and hunted for Easter eggs.",
      "D) John watched fireworks on the Fourth of July."
    ],
    correctIndex: 1,
    explanation:
        '✔️ Explanation: Mark’s action is a temporal mistake because Christmas activities like wearing Santa hats and singing carols do not occur in July.',
    incorrectExplanations: [
      ' Decorating with pumpkins and carving a jack-o’-lantern is correct for Halloween season.',
      ' Correct! Singing Christmas carols in July is out of season.',
      ' Hunting Easter eggs is appropriate for Easter time in spring.',
      ' Watching fireworks on the Fourth of July fits the U.S. Independence Day celebration.'
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
  // Step 2 eliminado → ahora son 4 steps (0,1,2,3) + final (4)
  // Mapeado: 0=Step1, 1=Step3(calendar), 2=Step4(inference), 3=Final
  int _currentStep = 0;
  final Set<String> _selectedOptions = {};
  String? _inferenceAnswer;
  late AnimationController _animationController;
  bool _correctInference = false;
  // ignore: unused_field
  final List<String> _calendarItems = [];
  String? _feedbackText;

  final Color _primaryColor = const Color(0xFFFF9800);
  final Color _lightOrange = const Color(0xFFFFE0B2);
  final Color _darkOrange = const Color(0xFFE65100);
  final Color _christmasRed = const Color(0xFFD32F2F);
  final Color _christmasGreen = const Color(0xFF388E3C);

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
    if (_currentStep == 0 && _selectedOptions.isEmpty) {
      _showFeedbackMessage('Please select at least one option');
      return;
    }
    if (_currentStep == 2 && _inferenceAnswer == null) {
      _showFeedbackMessage('Please make your inference');
      return;
    }

    _animationController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!mounted) return;
        setState(() {
          if (_currentStep < 3) {
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
    final List<String> stepLabels = ["", "", "", ""];
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
            value: (_currentStep + 1) / 4.0,
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
                "🎄 Step 1: The Christmas Mystery",
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
                        "Read the sentence:",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _darkOrange),
                      ),
                      const SizedBox(height: 12),

                      // Oración con gradiente navideño
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _lightOrange.withOpacity(0.4),
                              _christmasRed.withOpacity(0.1)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: _primaryColor.withOpacity(0.3)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "\"Mark wore a Santa hat and sang Christmas carols in July.\"",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: _darkOrange),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.emoji_events,
                                    color: _christmasRed, size: 20),
                                const SizedBox(width: 6),
                                Text(
                                  "Spot the odd detail!",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    color: _christmasRed,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      Text(
                        "What is wrong with this sentence?",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: _darkOrange),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "🔍 What does not make sense?",
                        style: TextStyle(
                            fontSize: 15,
                            color: _darkOrange,
                            fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Choose the best answer:",
                        style: TextStyle(fontSize: 14, color: _darkOrange),
                      ),
                      const SizedBox(height: 12),

                      _buildStep1Option(
                        "A) People do not usually sing songs in July.",
                        "A",
                        false,
                        "People do sing songs in July — that's not the odd part here.",
                      ),
                      _buildStep1Option(
                        "B) People do not usually wear hats outside.",
                        "B",
                        false,
                        "People wear hats outside all the time — that's not the problem.",
                      ),
                      _buildStep1Option(
                        "C) People do not usually celebrate Christmas before December.",
                        "C",
                        true,
                        "Correct! ✅ Santa hats and Christmas carols are usually associated with December, not July, so the timing in the sentence does not make sense.",
                      ),
                      _buildStep1Option(
                        "D) People do not usually celebrate holidays.",
                        "D",
                        false,
                        "People celebrate holidays all the time — that's not what's wrong here.",
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
                  child: const Text("Investigate Further",
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

  // ─── STEP 2 (ex Step 3) — CALENDAR DETECTIVE ─────────────────────────
  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimationLimiter(
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
                    "📅 Step 2: Calendar Detective",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: _darkOrange),
                  ),
                  const SizedBox(height: 12),
                  _buildProgressIndicator(),
                ],
              ),
            ),
          ),
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
                    "When do these activities normally happen?",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _darkOrange),
                  ),
                  const SizedBox(height: 12),
                  _buildInteractiveCalendar(),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _christmasRed.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _christmasRed.withOpacity(0.3)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.warning, color: _christmasRed),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Wearing Santa hats and singing carols in July doesn't fit the usual timing!",
                            style: TextStyle(
                                color: _christmasRed,
                                fontWeight: FontWeight.bold),
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
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 5,
              ),
              onPressed: _nextStep,
              child: const Text("Reveal the Truth",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveCalendar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: _primaryColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            "Drag the Christmas items to the correct month:",
            style: TextStyle(fontWeight: FontWeight.bold, color: _darkOrange),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildDraggableItem("Santa Hat", "🎅", _christmasRed),
              _buildDraggableItem("Christmas Tree", "🎄", _christmasGreen),
              _buildDraggableItem("Carols", "🎵", Colors.blue),
              _buildDraggableItem("Gifts", "🎁", Colors.purple),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMonthDropTarget(
                    "July", Icons.wb_sunny, Colors.orange),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMonthDropTarget(
                    "December", Icons.ac_unit, _christmasGreen),
              ),
            ],
          ),
          if (_feedbackText != null) ...[
            const SizedBox(height: 16),
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _feedbackText!.contains("Perfect")
                    ? _christmasGreen.withOpacity(0.15)
                    : _christmasRed.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _feedbackText!.contains("Perfect")
                      ? _christmasGreen.withOpacity(0.5)
                      : _christmasRed.withOpacity(0.4),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    _feedbackText!.contains("Perfect")
                        ? Icons.check_circle
                        : Icons.warning,
                    color: _feedbackText!.contains("Perfect")
                        ? _christmasGreen
                        : _christmasRed,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _feedbackText!,
                      style: TextStyle(
                        color: _feedbackText!.contains("Perfect")
                            ? _christmasGreen
                            : _christmasRed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 300.ms),
          ],
        ],
      ),
    );
  }

  Widget _buildDraggableItem(String text, String emoji, Color color) {
    return Draggable<String>(
      data: text,
      feedback: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color),
          ),
          child: Text("$emoji $text",
              style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Text("$emoji $text", style: TextStyle(color: color)),
      ),
    );
  }

  Widget _buildMonthDropTarget(String month, IconData icon, Color color) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          height: 120,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: candidateData.isNotEmpty ? color : color.withOpacity(0.3),
              width: candidateData.isNotEmpty ? 3 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 6),
              Text(month,
                  style: TextStyle(color: color, fontWeight: FontWeight.bold)),
              if (candidateData.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text("Drop it here!",
                      style: TextStyle(color: color, fontSize: 12)),
                ),
            ],
          ),
        );
      },
      onWillAccept: (data) => true,
      onAccept: (data) {
        setState(() {
          if (month == "December") {
            _feedbackText = "🎉 Perfect! $data belongs in December!";
          } else {
            _feedbackText = "🤔 $data in $month? That seems unusual...";
          }
        });
      },
    );
  }

  // ─── STEP 3 (ex Step 4) — INFERENCE ──────────────────────────────────
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
                "🎯 Step 3: The Big Reveal",
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
                        "What's the final conclusion?",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _darkOrange),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _lightOrange.withOpacity(0.3),
                              _christmasRed.withOpacity(0.1)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Based on all the clues you've gathered, choose the best explanation:",
                          style: TextStyle(color: _darkOrange),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildConclusionOption(
                        "A) Mark hates Christmas.",
                        "A",
                        false,
                        "The sentence doesn't say anything about Mark's feelings toward Christmas.",
                      ),
                      _buildConclusionOption(
                        "B) Mark's Christmas activities are happening at the wrong time.",
                        "B",
                        true,
                        "Correct! ✅ Santa hats and Christmas carols belong in December, not July — that's the temporal inconsistency.",
                      ),
                      _buildConclusionOption(
                        "C) Mark was in the Southern Hemisphere.",
                        "C",
                        false,
                        "Even in the Southern Hemisphere, Christmas is still celebrated in December.",
                      ),
                      _buildConclusionOption(
                        "D) Mark invented a new holiday.",
                        "D",
                        false,
                        "There's no evidence in the sentence that Mark invented anything.",
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
                                ? "🎉 Brilliant! You've spotted the temporal inconsistency!"
                                : "Think about when Christmas traditions normally happen.",
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
                  child: const Text("See Final Solution",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConclusionOption(
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
                        : Icons.psychology,
                    color: isSelected
                        ? (isCorrect ? _primaryColor : Colors.red)
                        : _darkOrange.withOpacity(0.5),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
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
            "🏆 Case Solved!",
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
                  Row(
                    children: [
                      Icon(Icons.verified, color: _christmasGreen, size: 32),
                      const SizedBox(width: 12),
                      Text(
                        "Mystery Solved:",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: _primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _christmasGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _christmasGreen),
                    ),
                    child: Text(
                      "Mark's Christmas activities are happening at the wrong time",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _christmasGreen),
                    ),
                  ),
                  const Divider(height: 32),
                  Text(
                    "Detective's Report:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _darkOrange),
                  ),
                  const SizedBox(height: 12),
                  _buildReportItem(
                      "🔍 Christmas traditions like wearing Santa hats occur in December"),
                  _buildReportItem(
                      "📅 Doing these in July creates a temporal inconsistency"),
                  _buildReportItem(
                      "🎯 This is a classic case of seasonal mismatch"),
                  _buildReportItem(
                      "💡 The sentence highlights unusual timing through contrast"),
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

  Widget _buildReportItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          Expanded(
            child:
                Text(text, style: TextStyle(color: _darkOrange, fontSize: 16)),
          ),
        ],
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
                // Botón cerrar sin AppBar
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: _darkOrange),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Expanded(child: _buildCurrentStep()),
                // Sin botón Back
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
    '💡 General Hint: What is the correct date/month for the holiday Halloween?',
    '📌 More Specific: Is the activity of trick-or-treating done in the spring month of April?',
  ];

  final List<String> hints2 = [
    '💡 General Hint: What are the standard activities/attire associated with Thanksgiving in November?',
    '📌 More Specific: Is wearing a full turkey costume a common tradition for the Thanksgiving holiday?',
  ];

  final List<String> hints3 = [
    '💡 General Hint: What month does the Christmas season usually begin, and when is the tree decorated?',
    '📌 More Specific: Is January the typical month for setting up Christmas decorations?',
  ];

  final List<String> hints4 = [
    '💡 General Hint: What holiday is associated with the character of Santa Claus and his hat?',
    '📌 More Specific: Is Easter Sunday (a spring holiday) the correct time to wear a Santa hat?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question": "Which sentence has a temporal mistake?",
      "options": [
        "A) Sophia wore red and green for Christmas in December.",
        "B) Liam went trick-or-treating for Halloween in April.",
        "C) Mia baked hot cross buns for Easter in spring.",
        "D) Lucas watched fireworks for New Year's Eve on December 31st."
      ],
      "correctIndex": 1,
      "feedback": [
        "Explanation: Halloween is on October 31st, so trick-or-treating in April is too early.",
        "Sophia’s sentence is correct — red and green are typical Christmas colors in December.",
        "Mia’s sentence is correct for Easter in spring.",
        "Lucas’s sentence is correct — fireworks on New Year’s Eve happen on December 31st."
      ]
    },
    {
      "question": "Which sentence has a temporal mistake?",
      "options": [
        "A) Isabella wore a turkey costume for Thanksgiving in April. .",
        "B) Ethan set off fireworks on the Fourth of July.",
        "C) Ava wore pastel clothes for Easter Sunday in the spring.",
        "D) William wore a shamrock pin on St. Patrick’s Day in March."
      ],
      "correctIndex": 0,
      "feedback": [
        "Isabella’s sentence is incorrect — she wore a turkey costume in April instead of November.",
        "Ethan’s sentence is correct — fireworks are common on the Fourth of July.",
        "Ava’s sentence is correct — pastel clothes are typical for Easter Sunday in spring.",
        "William’s sentence is correct — shamrocks are symbols of St. Patrick’s Day in March."
      ]
    },
    {
      "question": "Which sentence has a temporal mistake?",
      "options": [
        "A) James hung spooky decorations for Halloween at the end of October.",
        "B) Charlotte bought chocolates for Valentine’s Day in February.",
        "C) Henry decorated the Christmas tree in January.",
        "D) Amelia wore green on St. Patrick’s Day in March."
      ],
      "correctIndex": 2,
      "feedback": [
        "Explanation: Christmas trees are decorated in December, not January. This is a timing error.",
        "James’s sentence is correct — Halloween decorations belong to October.",
        "Charlotte’s sentence is correct — chocolates are for Valentine’s Day in February.",
        "Amelia’s sentence is correct — wearing green fits St. Patrick’s Day in March."
      ]
    },
    {
      "question": "Which sentence has a temporal mistake?",
      "options": [
        "A) Benjamin went to a fireworks show on New Year’s Eve.",
        "B) Ella wore a red dress on Valentine’s Day in February.",
        "C) Michael wore a Santa hat on Easter Sunday.",
        "D) Grace dressed up as a witch for Halloween in October."
      ],
      "correctIndex": 2,
      "feedback": [
        "Explanation: Santa hats are for Christmas in December, not Easter. This is a timing mismatch.",
        "Benjamin’s sentence is correct — fireworks are common on New Year’s Eve.",
        "Ella’s sentence is correct — red dresses fit Valentine’s Day.",
        "Grace’s sentence is correct — witches are for Halloween in October."
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
        .set({'completedInstructionSpot4_2': true}, SetOptions(merge: true));

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
      'completedInstructionSpot4_2': true, // Repetido por seguridad
      'completedSpotsCount': FieldValue.increment(1),
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ── Trofeo y felicitación ──
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
                            color: const Color(0xFFFF9800).withOpacity(0.4),
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
                      "🎉 You did amazing!",
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
                        "The more you practice how to infer the time, the better you'll become! 🌟👏",
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

                // ── Sección resumen ──
                FadeTransition(
                  opacity: const AlwaysStoppedAnimation(1.0),
                  child: Container(
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
                      children: const [
                        Center(
                          child: Text(
                            "To sum up...",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF57C00),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          " inferring the time means using clues in a sentence and our real-world knowledge to figure out when events happen.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF5D4037),
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ── Botón Back to Home ──
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
                      backgroundColor: const Color(0xFFF57C00),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 6,
                      shadowColor: const Color(0xFFF57C00).withOpacity(0.5),
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
