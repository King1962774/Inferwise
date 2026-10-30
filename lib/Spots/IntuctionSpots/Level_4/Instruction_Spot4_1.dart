// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_4/Animation4_1.dart';
import 'package:inferwise/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';

class InstructionSpotPage4_1 extends StatefulWidget {
  final String title;
  final List<String> instructions;
  final String tipTitle;
  final List<String> tips;
  final String finalNote;

  const InstructionSpotPage4_1({
    super.key,
    required this.title,
    required this.instructions,
    required this.tipTitle,
    required this.tips,
    required this.finalNote,
  });

  @override
  State<InstructionSpotPage4_1> createState() => _InstructionSpotPage4_1State();
}

class _InstructionSpotPage4_1State extends State<InstructionSpotPage4_1> {
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
      'image': 'assets/Imagenes de ejemplos/Level4/4.2 A Liam.webp',
      'text':
          'Liam grabbed his tray and walked to an empty table.\n✴️ Here, you use spatial inference to understand that he is probably in a cafeteria or restaurant.',
    },
    {
      'title': 'Example 2',
      'image': 'assets/Imagenes de ejemplos/Level4/4.2 B Helmet.webp',
      'text':
          'She put on a helmet and adjusted her knee pads before starting.\n✴️ Here, you use spatial inference to understand that she is likely at a place for skateboarding or biking.',
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
                      "Inferring the Location",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 149, 1),
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
                    'Readers figure out where something takes place in a sentence or text by connecting it to related ideas they already know.',
                    style: TextStyle(fontSize: 15),
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
      'image': 'assets/Imagenes de ejemplos/Level4/4.2 C Kids.webp',
      'text':
          'The kids lined up quietly, waiting for the bell to ring.\n✴️ Spatial inference: They are probably at school.',
    },
    {
      'title': 'Example 2',
      'image': 'assets/Imagenes de ejemplos/Level4/4.2 D Fishing rod.webp',
      'text':
          'He grabbed a fishing rod and stepped onto the dock.\n✴️ Spatial inference: He is likely near a lake, river, or ocean.',
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
                  height: 190,
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
                      "Inferring the Location",
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Special note',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Sometimes the location isn\'t directly mentioned because the writer expects you to fill in the gap from common knowledge.',
                        style: TextStyle(fontSize: 15),
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
    '🔸 1. Identify the key action or setting clue\n\n'
        'Sentence: "Maria put on her apron and turned on the oven."\n\n'
        'Here, "put on her apron" and "turned on the oven" give clues about what she is doing and where.',
    '🔸 2. Think of possible places\n\n'
        'Where would someone wear an apron and use an oven?\n\n'
        'Possible answers: Kitchen, bakery, or restaurant.',
    '🔸 3. Look for context clues\n\n'
        'The sentence mentions an oven, which is commonly found in kitchens or bakeries for cooking or baking.',
    '🔸 4. Use real-world knowledge and plausibility\n\n'
        'Aprons and ovens are typically found in kitchens or bakeries. '
        'It would be unusual to find both in unrelated places.',
    '🔸 5. Confirm the inference\n\n'
        'The most likely place is a kitchen or bakery where Maria is cooking or baking.',
    ' Final Answer:\n\n'
        'Maria is probably in a kitchen or bakery.\n\n'
        '💡 Quick note: If the context changes (like "in a chemistry lab" or "on a stage"), revise your inference accordingly.\n'
        'When context is limited, use "probably" or "most likely" instead of absolute certainty.'
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
            color: const Color(0xFFE65100).withOpacity(0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: _buildStepText(text),
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
            // Header
            const Text(
              "Let's infer the location in the next sentence:",
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
                    color: const Color(0xFFFF9800).withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                '"Maria put on her apron and turned on the oven."',
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
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'readers figure out where something happens in a sentence by connecting it to what you know about the world.',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // 📚 Examples
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
                          'Carlos put on his apron and started sweeping hair from the floor.',
                      inference:
                          ' Spatial inference: He is probably in a barbershop or hair salon, since aprons and sweeping hair are common activities in places where hair is cut.',
                    ),
                    _buildExample(
                      sentence:
                          'Maya grabbed her backpack and waited by the bus stop.',
                      inference:
                          ' Spatial inference: She is likely outside, near a road or school.',
                    ),
                    _buildExample(
                      sentence:
                          'The hikers set up their tents and lit a campfire as the sun began to set.',
                      inference:
                          ' Spatial inference: They are probably in a campsite or forest.',
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
                                'Sometimes the place isn’t mentioned directly because it’s assumed you know it. If more than one location fits, choose the most likely based on context.',
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
    '1.Identify the action or details that hint at a place.',
    '2.List possible locations where that action usually happens.',
    '3.Look for context clues in the sentence or nearby text (words like “tray,” “helmet,” “track”).',
    '4.Use real-world knowledge — where do these activities typically take place?',
    '5.State your inference clearly; if uncertain, say “most likely” or suggest options.',
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
                  ' Quick tip: If new context shows up later, update your inference — inferring the locations depends on clues and aren’t always certain.',
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
                            Color.fromARGB(255, 255, 186, 83),
                            Color.fromARGB(255, 253, 105, 26),
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
        'Sophie put on her helmet and grabbed her skateboard.\n\nWhere is Sophie most likely?',
    options: [
      "A) At a library",
      "B) At a skatepark ",
      "C) In a classroom",
      "D) At the grocery store"
    ],
    correctIndex: 1,
    explanation:
        'The helmet and skateboard suggest Sophie is going to a skatepark or a safe area for skateboarding.',
    incorrectExplanations: [
      'A library is unrelated to skateboarding equipment.',
      'Correct answer!',
      'Classrooms don’t involve skateboards and helmets.',
      'A grocery store is not a suitable place for skateboarding.',
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
  final Set<String> _selectedPlaces = {};
  bool _showSkateboardAnimation = false;
  bool _showHelmetAnimation = false;

  String? _selectedFeedback;
  bool _isAnswerCorrect = false;

  String? _inferenceFeedback;
  bool _isInferenceCorrect = false;

  final Color _primaryColor = const Color(0xFFF57C00);
  final Color _lightOrange = const Color(0xFFFFE0B2);
  final Color _darkOrange = const Color(0xFFE65100);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
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
    if (_currentStep == 1 && _selectedPlaces.isEmpty) {
      _showFeedbackMessage('Please select a place');
      return;
    }
    if (_currentStep == 2 && _inferenceAnswer == null) {
      _showFeedbackMessage('Please make your inference');
      return;
    }

    // ✅ Sin animationController ni scroll automático
    setState(() {
      if (_currentStep < 3) {
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

  // ─── PROGRESS BAR MEJORADA ───────────────────────────────────────────
  Widget _buildProgressIndicator() {
    final List<String> stepLabels = ["", "", "", ""];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(stepLabels.length, (i) {
            return Column(
              children: [],
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "🔍 Step 1: Read the Whole Sentence",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _darkOrange,
            ),
          ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.1),
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
                    "Analyze the sentence carefully:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _darkOrange),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _lightOrange.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _primaryColor.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: _darkOrange),
                              children: const [
                                TextSpan(
                                    text:
                                        "\"Sophie put on her helmet and grabbed her skateboard.\""),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.skateboarding,
                            color: _primaryColor, size: 30),
                      ],
                    ),
                  ).animate().scale(delay: 300.ms),
                  const SizedBox(height: 16),
                  Text(
                    "What is the sentence mainly about?",
                    style: TextStyle(
                        fontSize: 16,
                        color: _darkOrange,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  _buildOptionWithFeedback(
                    text: "A) Sophie is fixing her helmet.",
                    option: "A",
                    isCorrect: false,
                    feedback:
                        "Not quite — the sentence doesn't mention fixing anything.",
                  ),
                  _buildOptionWithFeedback(
                    text: "B) Sophie is getting ready to go skating.",
                    option: "B",
                    isCorrect: true,
                    feedback:
                        "Correct!  Putting on a helmet and grabbing a skateboard are actions someone does to prepare for skating.",
                  ),
                  _buildOptionWithFeedback(
                    text: "C) Sophie is buying a new skateboard.",
                    option: "C",
                    isCorrect: false,
                    feedback:
                        "No — there's no mention of buying anything in the sentence.",
                  ),
                  _buildOptionWithFeedback(
                    text: "D) Sophie is watching someone skate.",
                    option: "D",
                    isCorrect: false,
                    feedback:
                        "Not quite — she's the one with the helmet and skateboard.",
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 200.ms),
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
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }

  Widget _buildOptionWithFeedback({
    required String text,
    required String option,
    required bool isCorrect,
    required String feedback,
  }) {
    bool isSelected = _selectedOptions.contains(option);
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
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "💡 Step 2: Real-World Knowledge",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: _darkOrange),
          ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.1),
          const SizedBox(height: 12),
          _buildProgressIndicator(),

          // Animación al inicio
          Container(
            height: 120,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: _lightOrange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 50,
                  top: 35,
                  child: AnimatedOpacity(
                    opacity: _showHelmetAnimation ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Icon(Icons.sports_motorsports,
                        size: 45, color: _primaryColor),
                  ),
                ),
                Positioned(
                  right: 50,
                  top: 35,
                  child: AnimatedOpacity(
                    opacity: _showSkateboardAnimation ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Transform.rotate(
                      angle: 0.3,
                      child: Icon(Icons.skateboarding,
                          size: 45, color: _primaryColor),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton.icon(
                    icon: Icon(
                      _showHelmetAnimation
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: Text(
                      _showHelmetAnimation
                          ? "Hide Items"
                          : "Show Helmet & Skateboard",
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      setState(() {
                        _showHelmetAnimation = !_showHelmetAnimation;
                        _showSkateboardAnimation = !_showSkateboardAnimation;
                      });
                    },
                  ),
                ),
              ],
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
                    "If someone puts on a helmet and carries a skateboard, where do they usually go?",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _darkOrange),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Think about real-world situations. Wearing a helmet is for safety, and skateboards are used where there is space to ride them.",
                    style: TextStyle(
                        fontSize: 16,
                        color: _darkOrange,
                        fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 8),

                  // Instrucción al usuario
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 14),
                    decoration: BoxDecoration(
                      color: _primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _primaryColor.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.touch_app, color: _primaryColor, size: 22),
                        const SizedBox(width: 8),
                        Text(
                          "TAP THE RIGHT OPTION",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _primaryColor,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.1,
                    children: [
                      _buildPlaceOption(
                        text: "A library",
                        subtext: "(Una biblioteca)",
                        icon: Icons.library_books,
                        isCorrect: false,
                        feedback:
                            "Not quite! People don't usually skateboard inside a library.",
                      ),
                      _buildPlaceOption(
                        text: "A skatepark or outdoor area",
                        subtext: "(Un parque)",
                        icon: Icons.park,
                        isCorrect: true,
                        feedback:
                            "Correct! Skateparks are designed for skateboarding with safety in mind.",
                      ),
                      _buildPlaceOption(
                        text: "In a classroom",
                        subtext: "(En un salón de clase)",
                        icon: Icons.school,
                        isCorrect: false,
                        feedback:
                            "Not really — skateboards aren't used in classrooms.",
                      ),
                      _buildPlaceOption(
                        text: "At the grocery store",
                        subtext: "(En el supermercado)",
                        icon: Icons.shopping_cart,
                        isCorrect: false,
                        feedback:
                            "Nope! You wouldn't use a skateboard in a grocery store.",
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  if (_selectedFeedback != null)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _isAnswerCorrect
                            ? _lightOrange.withOpacity(0.3)
                            : Colors.red[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _isAnswerCorrect
                              ? _primaryColor
                              : Colors.redAccent,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _isAnswerCorrect
                                ? Icons.check_circle
                                : Icons.info_outline,
                            color: _isAnswerCorrect
                                ? _primaryColor
                                : Colors.redAccent,
                            size: 24,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _selectedFeedback!,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: _darkOrange,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 300.ms),

                  const SizedBox(height: 20),
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
                      onPressed: _selectedPlaces.isNotEmpty ? _nextStep : null,
                      child: const Text("Continue",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ).animate().fadeIn(delay: 400.ms),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 200.ms),
        ],
      ),
    );
  }

  Widget _buildPlaceOption({
    required String text,
    required String subtext,
    required IconData icon,
    required bool isCorrect,
    required String feedback,
  }) {
    bool isSelected = _selectedPlaces.contains(text);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSelected
            ? (isCorrect ? _lightOrange.withOpacity(0.3) : Colors.red[100])
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? (isCorrect ? _primaryColor : Colors.red)
              : Colors.grey.shade300,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3)),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedPlaces.clear();
            _selectedPlaces.add(text);
            _isAnswerCorrect = isCorrect;
            _selectedFeedback = feedback;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 36,
              color: isSelected
                  ? (isCorrect ? _primaryColor : Colors.red)
                  : _darkOrange,
            ),
            const SizedBox(height: 6),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _darkOrange,
                  fontSize: 13),
            ),
            const SizedBox(height: 2),
            Text(
              subtext,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11,
                  color: _darkOrange.withOpacity(0.65),
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  // ─── STEP 3 ───────────────────────────────────────────────────────────
  Widget _buildStep3() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "🔧 Step 3: Most Logical Place",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: _darkOrange),
          ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.1),
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
                    "Where is Sophie most likely?",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _darkOrange),
                  ),
                  const SizedBox(height: 16),
                  _buildInferenceOption(
                    "A) She is at the library.",
                    "Not quite! Libraries are quiet places for reading, not for skateboarding.",
                    false,
                  ),
                  _buildInferenceOption(
                    "B) She is in an outdoor area.",
                    "Correct!  Using a helmet and a skateboard suggests an outdoor activity, so she is most likely in an outdoor area.",
                    true,
                  ),
                  _buildInferenceOption(
                    "C) She is in a classroom.",
                    "Not really — classrooms are for studying, not skateboarding.",
                    false,
                  ),
                  _buildInferenceOption(
                    "D) She is at the grocery store.",
                    "Nope! Grocery stores aren't meant for riding skateboards.",
                    false,
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 200.ms),
          if (_inferenceFeedback != null)
            Card(
              elevation: 3,
              color: _isInferenceCorrect
                  ? _lightOrange.withOpacity(0.3)
                  : Colors.red[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: _isInferenceCorrect ? _primaryColor : Colors.redAccent,
                  width: 2,
                ),
              ),
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      _isInferenceCorrect
                          ? Icons.check_circle
                          : Icons.info_outline,
                      color: _isInferenceCorrect
                          ? _primaryColor
                          : Colors.redAccent,
                      size: 28,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _inferenceFeedback!,
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
              onPressed: _nextStep,
              child: const Text("See Final Answer",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }

  Widget _buildInferenceOption(String text, String feedback, bool isCorrect) {
    final isSelected = _inferenceAnswer == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          _inferenceAnswer = text;
          _isInferenceCorrect = isCorrect;
          _inferenceFeedback = feedback;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect ? _lightOrange.withOpacity(0.3) : Colors.red[100])
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? (isCorrect ? _primaryColor : Colors.redAccent)
                : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, 3)),
          ],
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? (isCorrect ? Icons.check_circle : Icons.cancel)
                  : Icons.circle_outlined,
              color: isSelected
                  ? (isCorrect ? _primaryColor : Colors.redAccent)
                  : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _darkOrange),
              ),
            ),
          ],
        ),
      ),
    ).animate().slideX(begin: 0.4, duration: 400.ms);
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
          ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.1),
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
                    "B) She is in an outdoor area.",
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
                                "The sentence doesn't say the place directly, but based on the helmet and skateboard\n\n"),
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(
                            text:
                                "Using a helmet and a skateboard suggests an outdoor activity\n\n"),
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(
                            text:
                                "Libraries, classrooms, and grocery stores are not appropriate places for skateboarding"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: _lightOrange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 30,
                          child: Icon(Icons.sports_motorsports,
                                  size: 45, color: _primaryColor)
                              .animate(
                                onPlay: (controller) =>
                                    controller.repeat(reverse: true),
                              )
                              .scale(
                                  duration: 1000.ms,
                                  begin: const Offset(0.8, 0.8),
                                  end: const Offset(1.2, 1.2)),
                        ),
                        Positioned(
                          right: 30,
                          child: Transform.rotate(
                            angle: 0.3,
                            child: Icon(Icons.skateboarding,
                                    size: 45, color: _primaryColor)
                                .animate(
                                  onPlay: (controller) =>
                                      controller.repeat(reverse: true),
                                )
                                .scale(
                                    duration: 1000.ms,
                                    begin: const Offset(0.8, 0.8),
                                    end: const Offset(1.2, 1.2)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 200.ms),
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
            ).animate().fadeIn(delay: 400.ms),
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
        return _buildFinalStep();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sin AppBar
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFFFF3E0),
              const Color(0xFFFFE0B2),
              const Color(0xFFFFCC80),
            ],
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
                // Botón cerrar manual (reemplaza AppBar)
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: _darkOrange),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Expanded(child: _buildCurrentStep()),
                if (_currentStep > 0 && _currentStep < 3)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      children: [],
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

  // 🔹 Hints basados en la imagen
  final List<String> hints1 = [
    '💡 General Hint: What kind of public place requires you to carry your own food on a tray?',
    '📌 More Specific: Which option is an establishment specifically designed for self-service dining?',
  ];

  final List<String> hints2 = [
    '💡 General Hint: What kind of weather condition requires wearing a jacket and boots?',
    '📌 More Specific: Which option is an environment where you would naturally find snow',
  ];

  final List<String> hints3 = [
    '💡 General Hint: Where does a teacher typically use a projector to deliver a lesson?',
    '📌 More Specific: Which option is a setting specifically used for formal academic instruction?',
  ];

  final List<String> hints4 = [
    '💡 General Hint: What is the purpose of a narrow dirt path leading into a forest?',
    '📌 More Specific: Which option is a marked route through nature specifically used by hikers?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Jason grabbed a tray and looked for a place to sit.\n\nWhere is Jason probably?",
      "options": [
        "A) At a cafeteria",
        "B) At a movie theater",
        "C) At a gym",
        "D) At a park"
      ],
      "correctIndex": 0,
      "feedback": [
        " Correct! Using a tray and looking for a place to sit suggests Jason is in a cafeteria or restaurant.",
        " A movie theater doesn’t involve using trays for food.",
        " Gyms are not places where people use trays or sit to eat.",
        " A park doesn’t match the clue about a tray and seating area."
      ]
    },
    {
      "question":
          "Emma put on her boots and jacket, then stepped outside into the snow.\n\nWhere is Emma likely to be?",
      "options": [
        "A) In a warm indoor pool",
        "B) In a snowy place",
        "C) At a beach",
        "D) Inside a classroom"
      ],
      "correctIndex": 1,
      "feedback": [
        " A warm pool doesn’t match wearing boots and a jacket.",
        " Correct! Wearing boots and a jacket and stepping into snow suggests Emma is outside in cold weather.",
        " A beach doesn’t fit because of the snow clue.",
        " Classrooms are indoors and don’t involve snow."
      ]
    },
    {
      "question":
          "The teacher turned on the projector and began the lesson.\n\nWhere is the teacher most likely?",
      "options": [
        "A) At a gym",
        "B) At a concert hall",
        "C) In a classroom",
        "D) In a library"
      ],
      "correctIndex": 2,
      "feedback": [
        " Gyms aren’t places for lessons with projectors.",
        " Concert halls are used for performances, not lessons.",
        " Correct! Using a projector to start a lesson is typically done in a classroom.",
        " A library is for reading or studying quietly, not teaching lessons with projectors."
      ]
    },
    {
      "question":
          "The hikers put on backpacks and followed the narrow dirt path into the forest.\n\nWhere are the hikers probably?",
      "options": [
        "A) At a city park",
        "B) On a hiking trail",
        "C) At a shopping mall",
        "D) In a parking lot"
      ],
      "correctIndex": 1,
      "feedback": [
        " A city park usually has paved paths, not narrow dirt trails.",
        " Correct! Backpacks and a dirt path leading into the forest suggest they’re on a hiking trail.",
        " A shopping mall doesn’t match the outdoor hiking clues.",
        " A parking lot doesn’t fit the description of a forest path."
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
                                : "❌ ${feedback[selectedOptionIndex!]}",
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
        'Keithly and John put on their sneakers and started lifting weights.\n\nWhere are the athletes probably?',
    options: [
      "A) At a gym",
      "B) At a restaurant",
      "C) At a library",
      "D) At a beach"
    ],
    correctIndex: 0,
    explanation:
        '✔️ Explanation: Wearing sneakers and lifting weights suggests they are exercising at a gym.',
    incorrectExplanations: [
      ' Restaurants are for eating, not exercising.',
      ' Libraries are quiet places for reading, not physical activity.',
      ' Beaches are for swimming or relaxing, not weightlifting.'
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
  final Set<String> _selectedPlaces = {};

  final Color _primaryColor = const Color(0xFFF57C00);
  final Color _lightOrange = const Color(0xFFFFE0B2);
  final Color _darkOrange = const Color(0xFFE65100);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
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
    if (_currentStep == 1 && _selectedPlaces.isEmpty) {
      _showFeedbackMessage('Please select a place');
      return;
    }
    if (_currentStep == 2 && _inferenceAnswer == null) {
      _showFeedbackMessage('Please make your inference');
      return;
    }

    setState(() {
      if (_currentStep < 3) {
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
                Text(
                  stepLabels[i],
                  style: TextStyle(
                    fontSize: 10,
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "🔍 Step 1: Read the Whole Sentence",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: _darkOrange),
          ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.1),
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
                      border: Border.all(color: _primaryColor.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "\"Ketlhy and John put on their sneakers and started lifting weights.\"",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _darkOrange),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.fitness_center,
                            color: _primaryColor, size: 30),
                      ],
                    ),
                  ).animate().scale(delay: 300.ms),

                  const SizedBox(height: 16),
                  Text(
                    "What is the sentence mainly about?",
                    style: TextStyle(
                        fontSize: 16,
                        color: _darkOrange,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),

                  _buildMultipleChoiceOption(
                    "A) Ketlhy and John are shopping for sneakers.",
                    "A",
                    false,
                    "Not quite — the sentence doesn't mention shopping for anything.",
                  ),
                  _buildMultipleChoiceOption(
                    "B) Ketlhy and John are getting ready to exercise.",
                    "B",
                    true,
                    "Correct! ✅ Putting on sneakers and lifting weights are actions people do when preparing to exercise.",
                  ),
                  _buildMultipleChoiceOption(
                    "C) Ketlhy and John are cleaning their shoes.",
                    "C",
                    false,
                    "No — there's no mention of cleaning anything in the sentence.",
                  ),
                  _buildMultipleChoiceOption(
                    "D) Ketlhy and John are watching others work out.",
                    "D",
                    false,
                    "Not quite — they are the ones putting on sneakers and lifting, not watching.",
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 200.ms),
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
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }

  Widget _buildMultipleChoiceOption(
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

        // Feedback individual por opción
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "💡 Step 2: Real-World Knowledge",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _darkOrange),
            ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.1),
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
                      "Where do people usually put on sneakers and lift weights?",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _darkOrange),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Sneakers are worn for physical activities, and lifting weights is commonly done at gyms or fitness centers.",
                      style: TextStyle(
                          fontSize: 16,
                          color: _darkOrange,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 12),

                    // Instrucción TAP
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
                          Icon(Icons.touch_app, color: _primaryColor, size: 22),
                          const SizedBox(width: 8),
                          Text(
                            "TAP THE RIGHT OPTION",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _primaryColor,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Grid 2x2
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          alignment: WrapAlignment.center,
                          children: [
                            SizedBox(
                              width: (constraints.maxWidth / 2) - 20,
                              child: _buildPlaceOption(
                                "A place where people do sports",
                                Icons.sports,
                                true,
                              ),
                            ),
                            SizedBox(
                              width: (constraints.maxWidth / 2) - 20,
                              child: _buildPlaceOption(
                                "A place where people read",
                                Icons.menu_book,
                                false,
                              ),
                            ),
                            SizedBox(
                              width: (constraints.maxWidth / 2) - 20,
                              child: _buildPlaceOption(
                                "A place where people talk aloud",
                                Icons.record_voice_over,
                                false,
                              ),
                            ),
                            SizedBox(
                              width: (constraints.maxWidth / 2) - 20,
                              child: _buildPlaceOption(
                                "A place where people buy clothes",
                                Icons.shopping_bag,
                                false,
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // Feedback
                    if (_selectedPlaces.isNotEmpty)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _selectedPlaces
                                  .contains("A place where people do sports")
                              ? _lightOrange.withOpacity(0.3)
                              : Colors.red[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _selectedPlaces
                                    .contains("A place where people do sports")
                                ? _primaryColor
                                : Colors.redAccent,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _selectedPlaces.contains(
                                      "A place where people do sports")
                                  ? Icons.check_circle
                                  : Icons.info_outline,
                              color: _selectedPlaces.contains(
                                      "A place where people do sports")
                                  ? _primaryColor
                                  : Colors.redAccent,
                              size: 24,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                _selectedPlaces.contains(
                                        "A place where people do sports")
                                    ? "Correct! ✅ Gyms and fitness centers are where people put on sneakers and lift weights."
                                    : "Think again — where do people usually lift weights?",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: _darkOrange,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 300.ms),

                    const SizedBox(height: 20),

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
                        onPressed:
                            _selectedPlaces.isNotEmpty ? _nextStep : null,
                        child: const Text("Continue",
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ).animate().fadeIn(delay: 400.ms),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: 200.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceOption(String text, IconData icon, bool isCorrect) {
    final bool isSelected = _selectedPlaces.contains(text);
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPlaces.clear();
          _selectedPlaces.add(text);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect
                  ? _primaryColor.withOpacity(0.2)
                  : Colors.red.withOpacity(0.2))
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? (isCorrect ? _primaryColor : Colors.red)
                : _darkOrange.withOpacity(0.4),
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 4, offset: Offset(2, 2)),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? (isCorrect ? _primaryColor : Colors.red)
                  : _darkOrange,
              size: 26,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 13,
                  color: isSelected
                      ? (isCorrect ? _primaryColor : Colors.red)
                      : _darkOrange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── STEP 3 ───────────────────────────────────────────────────────────
  Widget _buildStep3() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "🔧 Step 3: Most Logical Place",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: _darkOrange),
          ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.1),
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
                  // Oración de referencia
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: _lightOrange.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _primaryColor.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "\"Ketlhy and John put on their sneakers and started lifting weights.\"",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _darkOrange),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.fitness_center,
                            color: _primaryColor, size: 26),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    "Where are Ketlhy and John most likely?",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _darkOrange),
                  ),
                  const SizedBox(height: 16),

                  _buildInferenceOptionFull(
                    "A) They are at the library.",
                    "A",
                    false,
                    "Not quite! Libraries are quiet places for reading, not for lifting weights.",
                  ),
                  _buildInferenceOptionFull(
                    "B) They are at a gym.",
                    "B",
                    true,
                    "Correct! ✅ Putting on sneakers and lifting weights are activities commonly done at a gym.",
                  ),
                  _buildInferenceOptionFull(
                    "C) They are in a classroom.",
                    "C",
                    false,
                    "Not really — classrooms are for studying, not weightlifting.",
                  ),
                  _buildInferenceOptionFull(
                    "D) They are at a grocery store.",
                    "D",
                    false,
                    "Nope! Grocery stores aren't meant for lifting weights.",
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 200.ms),

          // Feedback de la respuesta seleccionada
          if (_inferenceAnswer != null)
            Card(
              elevation: 3,
              color: _correctInference
                  ? _lightOrange.withOpacity(0.3)
                  : Colors.red[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: _correctInference ? _primaryColor : Colors.redAccent,
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
                      color:
                          _correctInference ? _primaryColor : Colors.redAccent,
                      size: 28,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _correctInference
                            ? "Correct! ✅ Putting on sneakers and lifting weights are activities commonly done at a gym, so they are most likely there."
                            : "Think again — where do people normally lift weights?",
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
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }

  Widget _buildInferenceOptionFull(
      String text, String option, bool isCorrect, String feedback) {
    final bool isSelected = _inferenceAnswer == option;
    return GestureDetector(
      onTap: () {
        setState(() {
          _inferenceAnswer = option;
          _correctInference = isCorrect;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect ? _lightOrange.withOpacity(0.3) : Colors.red[100])
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? (isCorrect ? _primaryColor : Colors.redAccent)
                : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 6,
                offset: const Offset(0, 3)),
          ],
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? (isCorrect ? Icons.check_circle : Icons.cancel)
                  : Icons.circle_outlined,
              color: isSelected
                  ? (isCorrect ? _primaryColor : Colors.redAccent)
                  : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _darkOrange),
              ),
            ),
          ],
        ),
      ),
    ).animate().slideX(begin: 0.4, duration: 400.ms);
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
          ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.1),
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
                    "B) They are at a gym.",
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
                                "The sentence mentions putting on sneakers and lifting weights, which are typical gym activities\n\n"),
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(
                            text:
                                "Sneakers are worn for physical activities, and lifting weights is done at gyms or fitness centers\n\n"),
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(
                            text:
                                "Restaurants, libraries, and grocery stores are not typical places for weightlifting activities"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: _lightOrange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 30,
                          child: Icon(Icons.directions_run,
                                  size: 40, color: _primaryColor)
                              .animate(onPlay: (c) => c.repeat(reverse: true))
                              .scale(
                                  duration: 1000.ms,
                                  begin: const Offset(0.8, 0.8),
                                  end: const Offset(1.2, 1.2)),
                        ),
                        Positioned(
                          right: 30,
                          child: Icon(Icons.fitness_center,
                                  size: 40, color: _primaryColor)
                              .animate(onPlay: (c) => c.repeat(reverse: true))
                              .scale(
                                  duration: 1000.ms,
                                  begin: const Offset(0.8, 0.8),
                                  end: const Offset(1.2, 1.2)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 200.ms),
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
            ).animate().fadeIn(delay: 400.ms),
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
        return _buildFinalStep();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sin AppBar
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFFFF3E0),
              const Color(0xFFFFE0B2),
              const Color(0xFFFFCC80),
            ],
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
                // Botón cerrar
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
    '💡 General Hint: What activity requires a helmet and a bike for safety and movement?',
    '📌 More Specific: Which public outdoor place is known to have trails or paths suitable for cycling?',
  ];

  final List<String> hints2 = [
    '💡 General Hint: What kind of location requires you to wear a swimsuit?',
    '📌 More Specific: Which option is a recreational area where people enter the water for swimming or play?',
  ];

  final List<String> hints3 = [
    '💡 General Hint: What kind of establishment sells hot drinks and provides tables or desks for customers to work?',
    '📌 More Specific: Which option is a common social/work space where people buy beverages and use their laptops?',
  ];

  final List<String> hints4 = [
    '💡 General Hint: Where do people go specifically to use exercise equipment like a treadmill',
    '📌 More Specific: Which option is a facility dedicated to physical fitness and weight training?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Mark put on his helmet and checked his bike before leaving. \n\nWhere is Mark probably?",
      "options": [
        "A) In a classroom",
        "B) At a park",
        "C) At a concert",
        "D) In a supermarket"
      ],
      "correctIndex": 1,
      "feedback": [
        "A classroom doesn’t fit since he’s preparing his bike.",
        " Wearing a helmet and preparing a bike indicates Mark is likely at a bike trail or park.",
        "A concert isn’t related to biking.",
        "A supermarket doesn’t relate to checking a bike."
      ]
    },
    {
      "question":
          "The children put on their swimsuits and ran toward the water. \n\nWhere are the children likely?",
      "options": [
        "A) At a zoo",
        "B) At a beach or pool",
        "C) At a library or museum",
        "D) At a mountain trail"
      ],
      "correctIndex": 1,
      "feedback": [
        "A zoo doesn’t fit this context.",
        " Wearing swimsuits and running to water suggests a beach or swimming pool.",
        "Libraries and museums are indoors, not near water.",
        "A mountain trail isn’t related to swimming."
      ]
    },
    {
      "question":
          "Tom ordered a hot drink, opened his laptop, and sat down at the desk. \n\nWhere is Tom most likely?",
      "options": [
        "A) In a café",
        "B) At a grocery store",
        "C) In a park",
        "D) At a bus stop"
      ],
      "correctIndex": 0,
      "feedback": [
        " Using a laptop and having a drink usually happens in a café, home office, or workspace.",
        "A grocery store doesn’t have desks or laptops.",
        "A park could work for sitting, but not usually with a desk and hot drink.",
        "A bus stop isn’t related to laptops and drinks."
      ]
    },
    {
      "question":
          "Mia changed into workout clothes and stepped onto the treadmill.\n\n Where is Mia most likely?",
      "options": [
        "A) At a park",
        "B) At a movie theater",
        "C) At a gym",
        "D) At a grocery store"
      ],
      "correctIndex": 2,
      "feedback": [
        "A park might fit for exercise, but not for a treadmill.",
        "A movie theater doesn’t fit this situation.",
        " Changing into workout clothes and using a treadmill suggests Mia is at a gym.",
        "A grocery store doesn’t relate to working out."
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
                                : "❌ ${feedback[selectedOptionIndex!]}",
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
    question: 'Which sentence has a spatial mistake?',
    options: [
      "A) Sarah put on her swimsuit and grabbed a towel at the beach.",
      "B) Mark sat at his desk and opened his laptop.",
      "C) Emily wore hiking boots and stepped onto the basketball court.",
      "D) Liam parked his car outside the movie theater."
    ],
    correctIndex: 2,
    explanation:
        '✔️ Explanation: The sentence with a spatial mistake is "Emily wore hiking boots and stepped onto the basketball court." Hiking boots are for trails, not for a basketball court.',
    incorrectExplanations: [
      ' This sentence makes sense — Sarah’s actions fit the beach setting.',
      ' This is logical — Mark using a laptop at his desk is correct.',
      ' Correct! The mismatch between hiking boots and a basketball court shows a spatial error.',
      ' Parking outside a movie theater is normal and makes sense.'
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
  final Set<String> _selectedOptions = {};
  String? _inferenceAnswer;
  late AnimationController _animationController;
  bool _correctInference = false;
  final Set<String> _selectedFootwear = {};
  bool _showBootsAnimation = false;
  bool _showCourtAnimation = false;

  final Color _primaryColor = const Color(0xFFFF9800);
  final Color _lightOrange = const Color(0xFFFFE0B2);
  final Color _darkOrange = const Color(0xFFEF6C00);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
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
  if (_currentStep == 1 && _selectedFootwear.isEmpty) {
    _showFeedbackMessage('Please select footwear');
    return;
  }
  if (_currentStep == 2 && _inferenceAnswer == null) {
    _showFeedbackMessage('Please make your inference');
    return;
  }

  setState(() {
    if (_currentStep < 3) {
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
                Text(
                  stepLabels[i],
                  style: TextStyle(
                    fontSize: 10,
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "🔍 Step 1: Read the Whole Sentence",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: _darkOrange),
          ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.1),
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
                      border: Border.all(color: _primaryColor.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "\"Emily wore hiking boots and stepped onto the basketball court.\"",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _darkOrange),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.sports_basketball,
                            color: _primaryColor, size: 30),
                      ],
                    ),
                  ).animate().scale(delay: 300.ms),

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

                  _buildMultipleChoiceOption(
                    "A) People do not usually wear hiking boots to play basketball.",
                    "A",
                    true,
                    "Correct! ✅ Hiking boots are made for rough trails, not for basketball courts.",
                  ),
                  _buildMultipleChoiceOption(
                    "B) People do not usually play basketball in public places.",
                    "B",
                    false,
                    "Not quite — basketball is commonly played in public courts and parks.",
                  ),
                  _buildMultipleChoiceOption(
                    "C) People do not usually go onto basketball courts.",
                    "C",
                    false,
                    "That's not right — people go onto basketball courts all the time to play.",
                  ),
                  _buildMultipleChoiceOption(
                    "D) People do not usually like playing sports.",
                    "D",
                    false,
                    "This isn't true — many people enjoy playing sports regularly.",
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 200.ms),
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
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }

  Widget _buildMultipleChoiceOption(
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

        // Feedback individual
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "💡 Step 2: Real-World Knowledge",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: _darkOrange),
          ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.1),
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
                    "If someone is on a basketball court, what kind of footwear do they usually wear?",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _darkOrange),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Think about common situations. Basketball courts are usually smooth surfaces meant for running and jumping.",
                    style: TextStyle(
                        fontSize: 16,
                        color: _darkOrange,
                        fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 20),

                  // Animación boots & court con íconos correctos
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: _lightOrange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        // Hiking boots - izquierda
                        Positioned(
                          left: 30,
                          top: 20,
                          child: AnimatedOpacity(
                            opacity: _showBootsAnimation ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 500),
                            child: Column(
                              children: [
                                Icon(Icons.hiking,
                                    size: 38, color: Colors.brown[600]),
                                const SizedBox(height: 4),
                                Text(
                                  "Hiking\nBoots",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.brown[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Basketball court - derecha
                        Positioned(
                          right: 30,
                          top: 20,
                          child: AnimatedOpacity(
                            opacity: _showCourtAnimation ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 500),
                            child: Column(
                              children: [
                                Icon(Icons.sports_basketball,
                                    size: 38, color: _primaryColor),
                                const SizedBox(height: 4),
                                Text(
                                  "Basketball\nCourt",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: _darkOrange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: ElevatedButton.icon(
                            icon: Icon(
                              _showBootsAnimation
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                              size: 18,
                            ),
                            label: Text(
                              _showBootsAnimation
                                  ? "Hide Items"
                                  : "Show Boots & Court",
                              style: const TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () {
                              setState(() {
                                _showBootsAnimation = !_showBootsAnimation;
                                _showCourtAnimation = !_showCourtAnimation;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "Select the appropriate footwear for a basketball court:",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _darkOrange),
                  ),
                  const SizedBox(height: 16),

                  // Grid de calzado con íconos corregidos
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildFootwearOption("Hiking boots", Icons.hiking, false),
                      _buildFootwearOption(
                          "Sneakers", Icons.directions_run, true),
                      _buildFootwearOption("Flip-flops", Icons.pool, false),
                      _buildFootwearOption("Sandals", Icons.spa, false),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Feedback
                  if (_selectedFootwear.isNotEmpty)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _selectedFootwear.contains("Sneakers")
                            ? _lightOrange.withOpacity(0.3)
                            : Colors.red[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _selectedFootwear.contains("Sneakers")
                              ? _primaryColor
                              : Colors.redAccent,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _selectedFootwear.contains("Sneakers")
                                ? Icons.check_circle
                                : Icons.info_outline,
                            color: _selectedFootwear.contains("Sneakers")
                                ? _primaryColor
                                : Colors.redAccent,
                            size: 24,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _selectedFootwear.contains("Sneakers")
                                  ? "Correct! ✅ Sneakers are designed for sports on courts with proper grip and support."
                                  : "Think again — what footwear is designed for smooth sports surfaces?",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: _darkOrange,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 300.ms),

                  const SizedBox(height: 20),
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
                      onPressed:
                          _selectedFootwear.isNotEmpty ? _nextStep : null,
                      child: const Text("Continue",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ).animate().fadeIn(delay: 400.ms),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 200.ms),
        ],
      ),
    );
  }

  Widget _buildFootwearOption(String text, IconData icon, bool isCorrect) {
    final isSelected = _selectedFootwear.contains(text);
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFootwear.clear();
          _selectedFootwear.add(text);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 130,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect ? _lightOrange : Colors.red[100])
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? (isCorrect ? _primaryColor : Colors.red)
                : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 38,
              color: isSelected
                  ? (isCorrect ? _primaryColor : Colors.red)
                  : _darkOrange,
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _darkOrange,
                  fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ).animate().scale(
          delay: (text == "Hiking boots"
                  ? 100
                  : text == "Sneakers"
                      ? 200
                      : text == "Flip-flops"
                          ? 300
                          : 400)
              .ms,
        );
  }

  // ─── STEP 3 ───────────────────────────────────────────────────────────
  Widget _buildStep3() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "🔧 Step 3: Most Logical Conclusion",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: _darkOrange),
          ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.1),
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
                    "What's the most logical conclusion?",
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
                    "A) Hiking boots are the best shoes for basketball.",
                    "A",
                    false,
                    "Not quite — hiking boots are bulky and designed for rough trails, not courts.",
                  ),
                  _buildInferenceOption(
                    "B) Sneakers are the appropriate shoes for a basketball court.",
                    "B",
                    true,
                    "Correct! ✅ Sneakers provide the right support and grip for basketball courts.",
                  ),
                  _buildInferenceOption(
                    "C) Sandals are commonly worn to play basketball.",
                    "C",
                    false,
                    "No — sandals don't provide the support or grip needed for basketball.",
                  ),
                  _buildInferenceOption(
                    "D) Flip-flops are appropriate shoes for basketball.",
                    "D",
                    false,
                    "Nope — flip-flops are unsafe for running and jumping on a court.",
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 200.ms),

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
                  color: _correctInference ? _primaryColor : Colors.redAccent,
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
                      color:
                          _correctInference ? _primaryColor : Colors.redAccent,
                      size: 28,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _correctInference
                            ? "Correct! ✅ Sneakers provide the right support and grip for basketball courts."
                            : "Think about what footwear is actually designed for sports activities.",
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
          ).animate().fadeIn(delay: 400.ms),
        ],
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
          ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.1),
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
                    "B) Sneakers are the right choice for a basketball court",
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
                                "The sentence contains a spatial error because hiking boots don't fit the context of a basketball court\n\n"),
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(
                            text:
                                "Based on real-world knowledge, sneakers are the appropriate footwear for that location\n\n"),
                        TextSpan(
                            text: "• ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(
                            text:
                                "Hiking boots are designed for rough trails, while sneakers provide proper support for sports"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: _lightOrange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 30,
                          child: Icon(Icons.directions_run,
                                  size: 40, color: _primaryColor)
                              .animate(onPlay: (c) => c.repeat(reverse: true))
                              .scale(
                                  duration: 1000.ms,
                                  begin: const Offset(0.8, 0.8),
                                  end: const Offset(1.2, 1.2)),
                        ),
                        Positioned(
                          right: 30,
                          child: Icon(Icons.sports_basketball,
                                  size: 40, color: _primaryColor)
                              .animate(onPlay: (c) => c.repeat(reverse: true))
                              .scale(
                                  duration: 1000.ms,
                                  begin: const Offset(0.8, 0.8),
                                  end: const Offset(1.2, 1.2)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 200.ms),
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
            ).animate().fadeIn(delay: 400.ms),
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [
              Color(0xFFFFF3E0),
              Color(0xFFFFE0B2),
              Color(0xFFFFCC80),
            ],
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
                // Botón cerrar (sin AppBar)
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
    '💡 General Hint: What is the purpose of ski goggles?',
    '📌 More Specific: Is safety gear for extreme weather/sports needed while reading quietly indoors?',
  ];

  final List<String> hints2 = [
    '💡 General Hint: What kind of footwear is typically required for exercising or using equipment in a gym?',
    '📌 More Specific: Is it standard practice to be barefoot or wearing only socks inside a gym?',
  ];

  final List<String> hints3 = [
    '💡 General Hint: What is the purpose of sunglasses?',
    '📌 More Specific: Are sunglasses necessary indoors when sitting by a heat source like a fireplace?',
  ];

  final List<String> hints4 = [
    '💡 General Hint: What type of skates are designed to be used on a surface of ice',
    '📌 More Specific: Can roller skates (which have wheels) be used effectively or safely on an ice rink?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question": "Which sentence has a spatial mistake?",
      "options": [
        "A) The students lined up outside the classroom.",
        "B) Josh put on his helmet before riding his bike.",
        "C) Mia wore ski goggles while reading in the library.",
        "D) The chef washed vegetables in the kitchen sink."
      ],
      "correctIndex": 2,
      "feedback": [
        "The students lining up outside the classroom makes sense.",
        "Josh wearing a helmet before biking is logical.",
        "Ski goggles are used for skiing or snowboarding, not for reading indoors at a library.",
        "The chef washing vegetables in the sink is correct and normal."
      ]
    },
    {
      "question": "Which sentence has a spatial mistake?",
      "options": [
        "A) Anna grabbed her notebook and sat under a tree in the park.",
        "B) David took off his shoes before entering the gym.",
        "C) Lucas wore a lab coat and goggles in the science lab.",
        "D) Sophie put on sandals before going to the pool."
      ],
      "correctIndex": 1,
      "feedback": [
        "Sitting under a tree with a notebook in a park makes sense.",
        " Shoes are worn inside a gym for exercise, not removed before entering.",
        "Wearing a lab coat and goggles in the lab is appropriate.",
        "Putting on sandals before going to the pool is logical."
      ]
    },
    {
      "question": "Which sentence has a spatial mistake?",
      "options": [
        "A) Tom put on gloves and started working in the garden.",
        "B) Rachel put on a helmet before biking on the trail.",
        "C) Ella grabbed a map before hiking the mountain.",
        "D) Jack wore sunglasses and sat by the fireplace in winter."
      ],
      "correctIndex": 3,
      "feedback": [
        "Gloves in the garden make sense.",
        "Wearing a helmet before biking is logical.",
        "Grabbing a map before hiking is reasonable.",
        " Sunglasses are used outdoors in bright sunlight, not indoors by a fireplace."
      ]
    },
    {
      "question": "Which sentence has a spatial mistake?",
      "options": [
        "A) Liam wore his raincoat and grabbed an umbrella before leaving the house.",
        "B) Helena put on roller skates before skating on the ice rink.",
        "C) Alex wore a swimsuit and jumped into the pool.",
        "D) Olivia wore a backpack while hiking in the forest."
      ],
      "correctIndex": 1,
      "feedback": [
        "Wearing a raincoat before going outside in the rain is correct.",
        "Roller skates are for smooth surfaces, not ice rinks — ice skates are used for that.",
        "Wearing a swimsuit for swimming makes sense.",
        "Wearing a backpack while hiking is appropriate."
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
                                : "❌ ${feedback[selectedOptionIndex!]}",
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
        .set({'completedInstructionSpot4_1': true}, SetOptions(merge: true));

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
      'completedInstructionSpot4_1': true, // Repetido por seguridad
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
                              "The more you practice how to infer the location, the better you'll become! 🌟👏",
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
                              "inferring the location means using text clues and real-world knowledge to figure out where events happen, helping us better understand and visualize the setting.",
                            ),
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
