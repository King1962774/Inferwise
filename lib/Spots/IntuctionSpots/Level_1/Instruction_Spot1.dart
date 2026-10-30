import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:inferwise/Spots/IntuctionSpots/Level_1/Animations.dart';
import 'package:inferwise/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InstructionSpotPage1 extends StatefulWidget {
  final String title;
  final List<String> instructions;
  final String tipTitle;
  final List<String> tips;
  final String finalNote;

  const InstructionSpotPage1({
    super.key,
    required this.title,
    required this.instructions,
    required this.tipTitle,
    required this.tips,
    required this.finalNote,
  });

  @override
  State<InstructionSpotPage1> createState() => _InstructionSpotPage1State();
}

class _InstructionSpotPage1State extends State<InstructionSpotPage1> {
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
      // Eliminamos el color de fondo para que se vea la imagen
      body: Stack(
        children: [
          // Imagen de fondo que ocupa todo el espacio
          Positioned.fill(
            child: Image.asset(
              'assets/Wallpapers/Wallpaper  Medals.png', // Reemplaza con tu ruta real
              fit: BoxFit.cover,
            ),
          ),
          // Contenido original envuelto en SafeArea
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título y botón de salir
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 19, 209, 48),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: _exit,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Contenedor de instrucciones con animación de fade
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(seconds: 1),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        // Agregamos un poco de opacidad al fondo para que el texto sea legible
                        color: const Color.fromARGB(255, 168, 255, 181)
                            .withOpacity(1.0),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        widget.instructions[_currentStep],
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const Spacer(),

                  // Solo botón Next/Start
                  Center(
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF43B53F),
                        minimumSize: const Size(140, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        foregroundColor: Colors.black,
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      child: Text(
                        isLast ? "Start" : "Next",
                        style: const TextStyle(color: Colors.black),
                      ),
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
      'image': 'assets/Imagenes de ejemplos/Level1/1.1 A Marie.webp',
      'sentence': '❇️Marie opened the window because she was hot.',
      'explanation': '❇️Here, "she" refers to Marie.',
    },
    {
      'title': 'Example 2',
      'image': 'assets/Imagenes de ejemplos/Level1/1.1 B Phone.webp',
      'sentence':
          '❇️The phone rang loudly, but it stopped before I could answer.',
      'explanation': '❇️Here, "it" refers to the phone.',
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

  Widget _buildCard(
      String title, String image, String sentence, String explanation) {
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
          border: Border.all(color: Colors.green.withOpacity(0.2)),
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
                  color: Color(0xFF1B5E20),
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
              const SizedBox(height: 8),
              // Oración en verde oscuro
              Text(
                sentence,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1B5E20),
                  fontWeight: FontWeight.w600,
                  height: 1.6,
                ),
              ),
              // Explicación en negro
              Text(
                explanation,
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
                ? const Color(0xFF2E7D32)
                : Colors.green.withOpacity(0.4),
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
              Color(0xFFE8F5E9),
              Color(0xFFC8E6C9),
              Color(0xFFA5D6A7),
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
                      "Identifying Pronouns",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
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
                    border: Border.all(color: Colors.green.withOpacity(0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '📘 What is this strategy about?',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'It helps you figure out who or what pronouns are referring to in a sentence or text.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Dots
                if (_visibleCount > 0) ...[
                  _buildDots(),
                  const SizedBox(height: 8),
                ],

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
                              example['sentence']!,
                              example['explanation']!,
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
                      backgroundColor: const Color(0xFF43B53F),
                      foregroundColor: Colors.black,
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
      'title': '🔹 Example 1',
      'image': 'assets/Imagenes de ejemplos/Level1/1.1 C Table.webp',
      'sentence':
          'Someone left their phone on the table.\n I hope they come back for it.',
      'explanation':
          ' "They" refers to someone (we don\'t know if it\'s a man or a woman).',
    },
    {
      'title': '🔹 Example 2',
      'image': 'assets/Imagenes de ejemplos/Level1/1.1 D Student.webp',
      'sentence':
          'If a student wants to ask a question, they should raise their hand.',
      'explanation':
          ' "They" refers to a student (singular, gender unknown or not specified).',
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

  void _goToNextRoom() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ThirdRoomPage()),
    );
  }

  void _exit() {
    Navigator.pop(context);
  }

  Widget _buildCard(
      String title, String image, String sentence, String explanation) {
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
          border: Border.all(color: Colors.green.withOpacity(0.2)),
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
                  color: Color(0xFF1B5E20),
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
              // Oración en verde oscuro
              Text(
                sentence,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1B5E20),
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
              // Explicación en negro
              Text(
                explanation,
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
                ? const Color(0xFF2E7D32)
                : Colors.green.withOpacity(0.4),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  Widget _buildMainInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.withOpacity(0.1)),
      ),
      child: const Text(
        '📘 As well...\n'
        'We use "they" when we don\'t know the gender or identity of a person. '
        'It\'s very common in spoken and written English to refer to one person in a neutral way.',
        style: TextStyle(fontSize: 16, color: Colors.black87),
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
              Color(0xFFE8F5E9),
              Color(0xFFC8E6C9),
              Color(0xFFA5D6A7),
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
                      "",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black54),
                      onPressed: _exit,
                    ),
                  ],
                ),

                _buildMainInfoCard(),
                const SizedBox(height: 16),

                // Dots
                if (_visibleCount > 0) ...[
                  _buildDots(),
                  const SizedBox(height: 8),
                ],

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
                              example['sentence']!,
                              example['explanation']!,
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
                        : _goToNextRoom,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF43B53F),
                      foregroundColor: Colors.black,
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
                            fontSize: 16, fontWeight: FontWeight.bold),
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
    '🟢 1. Identify the Pronoun\n\nThe pronoun is "it" in the second sentence.',
    '🟢 2. Read the Previous Sentence\n\n"A squirrel was climbing the tree."',
    '🟢 3. Spot the Nouns\n\nPossible nouns: squirrel and tree',
    '🟢 4. Check Pronoun Agreement\n\n"It" = singular, non-human, neutral gender → could refer to either tree or squirrel.',
    '🟢 5. Think About Meaning\n\n"It jumped from branch to branch."\n\n Does a tree jump? No.\n Does a squirrel jump? Yes.',
    '🟢 6. Confirm the Match\n\n"It" clearly refers to the squirrel because squirrels jump from branch to branch — trees don\'t.',
    ' Final Answer\n\n"It" refers to the squirrel.'
  ];

  /// Splits [text] into title + body using the first '\n\n' as separator,
  /// renders the title in bold and the body in normal weight.
  /// Also highlights "squirrel"/"squirrels"/"tree"/"trees" in green on the body.
  Widget _buildStepCard(String text) {
    const titleStyle = TextStyle(
      fontSize: 18,
      height: 1.6,
      color: Colors.black87,
      fontWeight: FontWeight.bold,
    );
    const bodyStyle = TextStyle(
      fontSize: 18,
      height: 1.6,
      color: Colors.black87,
      fontWeight: FontWeight.normal,
    );
    const highlightStyle = TextStyle(
      fontSize: 18,
      height: 1.6,
      color: Color.fromARGB(255, 28, 185, 38),
      fontWeight: FontWeight.normal,
    );

    final splitIndex = text.indexOf('\n\n');
    if (splitIndex == -1) {
      // No separator found — render everything as bold title
      return Text(text, style: titleStyle, textAlign: TextAlign.center);
    }

    final title = text.substring(0, splitIndex);
    final body = text.substring(splitIndex + 2);

    // Build body spans with green highlights
    final regex = RegExp(r'(squirrels?|trees?)', caseSensitive: false);
    final bodySpans = <TextSpan>[];
    int lastEnd = 0;
    for (final match in regex.allMatches(body)) {
      if (match.start > lastEnd) {
        bodySpans.add(TextSpan(text: body.substring(lastEnd, match.start)));
      }
      bodySpans.add(TextSpan(text: match.group(0), style: highlightStyle));
      lastEnd = match.end;
    }
    if (lastEnd < body.length) {
      bodySpans.add(TextSpan(text: body.substring(lastEnd)));
    }

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(text: title, style: titleStyle),
          TextSpan(text: '\n\n'),
          TextSpan(style: bodyStyle, children: bodySpans),
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
              Color(0xFFE8F5E9),
              Color(0xFFC8E6C9),
              Color(0xFFA5D6A7),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Step-by-Step",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black54),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Center(
                  child: Text(
                    "✩ How to do it? ✩",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1B5E20),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),

                // Tarjeta de contexto fija
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.green.withOpacity(0.2)),
                  ),
                  child: const Text(
                    'Let\'s analyze:\n"A squirrel was climbing the tree. It jumped from branch to branch."',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),

                // PageView con tarjetas de tamaño uniforme
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentStep = index;
                      });
                    },
                    itemCount: steps.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.white.withOpacity(0.85),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(32.0),
                            child: Center(
                              child: SingleChildScrollView(
                                child: _buildStepCard(steps[index]),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 15),

                // Indicador de progreso

                const SizedBox(height: 15),

                // Botones de navegación
                Row(
                  children: [
                    if (_currentStep > 0)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _goBack,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.7),
                            foregroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text("Back",
                              style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    if (_currentStep > 0) const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _nextStep,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isLast
                              ? const Color(0xFF2E7D32)
                              : const Color(0xFF43B53F),
                          foregroundColor: isLast ? Colors.white : Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 4,
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
              // Acción del botón cerrar
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
              Color(0xFFE8F5E9), // Verde muy claro
              Color(0xFFC8E6C9), // Verde suave
              Color(0xFFA5D6A7), // Verde un poco más intenso pero suave
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green.withOpacity(0.1)),
                  ),
                  child: const Text(
                    "Is everything clear, or would you like a quick recap?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
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
                          backgroundColor: const Color(0xFF4CAF50),
                          foregroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 2,
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
                          backgroundColor: Colors.white.withOpacity(0.8),
                          foregroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(""),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, size: 30, color: Colors.black54),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const QuestionRoom()),
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
              Color(0xFFE8F5E9), // Verde muy claro
              Color(0xFFC8E6C9), // Verde suave
              Color(0xFFA5D6A7), // Verde un poco más intenso pero suave
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Center(
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.black.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Colors.green.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    color: Colors.white.withOpacity(0.85),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            '🔍 Remember',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B5E20)),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Readers determine what we determine what a pronouns (I, you, she, he, they, it) refer to  in a sentence.',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            '📚 Examples:',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2E7D32)),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          _buildExample(
                            sentence:
                                'John had a great idea for the project. He shared it with the team.',
                            inference: '“He” refers to John.',
                          ),
                          _buildExample(
                            sentence:
                                'The cat ran outside. It chased a butterfly across the yard.',
                            inference: '“It” refers to the cat.',
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            '👤 Singular "they"',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2E7D32)),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          _buildExample(
                            sentence:
                                'A person knocked on the door, but they didn’t leave a name.',
                            inference:
                                '“they” refers to a person whose gender is unspecified.',
                          ),
                        ],
                      ),
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
                      backgroundColor: const Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    label: const Text(
                      'Next',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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

  static Widget _buildExample(
      {required String sentence, required String inference}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green.withOpacity(0.2)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '• $sentence',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Text(
              '🌿 $inference',
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Color(0xFF2E7D32),
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
    '🟢 1. Find the pronoun (e.g., it, she, he, they, you, we, I).',
    '🟢 2. Look back for nouns before it (antecedents).',
    '🟢 3. Check agreement (number, gender, logic).',
    '🟢 4. Use context to decide what makes sense.',
    '🟢 5. Choose the noun the pronoun is replacing.',
  ];

  void _finish() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Start(),
      ),
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
            icon: const Icon(Icons.close, size: 30, color: Colors.black54),
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
              Color(0xFFE8F5E9),
              Color(0xFFC8E6C9),
              Color(0xFFA5D6A7),
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
                    color: Color(0xFF2E7D32),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  itemCount: steps.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(18),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.green.withOpacity(0.15),
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
                      backgroundColor: const Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      "Continue to Practice",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
        'Anna was excited about her trip. She packed her suitcase quickly.\n\nWhat does “She” refer to?',
    options: ["A) The suitcase", "B) The trip", "C) Anna", "D) Her excitement"],
    correctIndex: 2,
    explanation:
        '✔️ Correct! “She” refers to Anna. It makes logical and grammatical sense: Anna is the only person mentioned who could pack a suitcase.',
    incorrectExplanations: [
      ' A) The suitcase can’t pack itself.',
      ' B) The trip is not a person and can’t pack.',
      ' C) Anna is the person who packed — this is correct.',
      ' D) Excitement is a feeling and doesn’t perform actions.',
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
              Color(0xFFE8F5E9),
              Color(0xFFC8E6C9),
              Color(0xFFA5D6A7),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close,
                          size: 24, color: Color(0xFF1B5E20)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Instrucción
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.touch_app_rounded,
                      size: 16,
                      color: Color(0xFF388E3C),
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Tap the option you think is correct",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF388E3C),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Card de pregunta
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF66BB6A),
                        Color(0xFF2E7D32),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1B5E20).withOpacity(0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),

                // Opciones — AbsorbPointer solo aquí
                Expanded(
                  child: AbsorbPointer(
                    absorbing: isAnswerSubmitted,
                    child: ListView.builder(
                      itemCount: question.options.length,
                      itemBuilder: (context, i) {
                        bool isSelected = selected == i;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF4CAF50).withOpacity(0.2)
                                : Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF2E7D32)
                                  : const Color(0xFFA5D6A7),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            dense: true,
                            title: Text(
                              question.options[i],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: Colors.black87,
                              ),
                            ),
                            onTap: () {
                              setState(() => selected = i);
                            },
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
                          ? const Color(0xFFE8F5E9)
                          : const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isCorrect == true
                            ? const Color(0xFF66BB6A)
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
                              ? const Color(0xFF2E7D32)
                              : Colors.red,
                          size: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isCorrect == true ? "Correct!" : "Incorrect",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: isCorrect == true
                                      ? const Color(0xFF1B5E20)
                                      : Colors.red.shade800,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                feedbackText!,
                                style: const TextStyle(
                                    fontSize: 14, height: 1.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 10),

                // Botón Submit / Continue — FUERA del AbsorbPointer
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isAnswerSubmitted
                        ? _continue
                        : selected != null
                            ? _submitAnswer
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 3,
                    ),
                    child: Text(
                      isAnswerSubmitted ? "Continue" : "Submit",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
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

class _ExplanationFirstState extends State<ExplanationFirst> {
  int _currentStep = 0;

  // Oración dividida en palabras para interactividad
  final List<String> _sentenceWords = [
    "Anna",
    "was",
    "excited",
    "about",
    "her",
    "trip.",
    "She",
    "packed",
    "her",
    "suitcase",
    "quickly."
  ];

  // Estado para Step 1 (Pronoun)
  int? _selectedPronounIndex;
  bool _isStep1Correct = false;

  // Estado para Step 2 (Nouns)
  final Set<int> _selectedNounIndices = {};
  final Set<int> _correctNounIndices = {0, 5, 9}; // Anna, trip, suitcase
  bool _isStep2Correct = false;

  // Estado para Step 3 (She refers to...)
  int? _selectedStep3Option;
  bool _isStep3Correct = false;

  // Estado para Step 4 (Context Questions)
  final Map<int, bool?> _step4Answers = {0: null, 1: null, 2: null};
  final Map<int, bool> _step4CorrectAnswers = {0: false, 1: false, 2: true};
  bool _isStep4Correct = false;

  void _nextStep() {
    setState(() {
      if (_currentStep < 4) {
        _currentStep++;
      }
    });
  }

  void _completeAnalysis() {
    // Navegación final a la práctica
    Navigator.push(context, MaterialPageRoute(builder: (_) => const Second()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, size: 30, color: Colors.black54),
            onPressed: () => Navigator.pop(context),
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
              Color(0xFFE8F5E9),
              Color(0xFFC8E6C9),
              Color(0xFFA5D6A7),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                _buildHeader(),
                const SizedBox(height: 20),
                Expanded(
                  child: _buildCurrentStepContent(),
                ),
                if (_currentStep < 4) ...[
                  const SizedBox(height: 20),
                  _buildBottomButton(),
                  const SizedBox(height: 10),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    String title = "";
    switch (_currentStep) {
      case 0:
        title = "🔍 Step 1: Identify the Pronoun";
        break;
      case 1:
        title = "🟢 2. Find Possible Matches";
        break;
      case 2:
        title = "🟢 3. Choose the Best Match";
        break;
      case 3:
        title = "💡 4. Check with Meaning";
        break;
      case 4:
        title = "🎯 Final Answer";
        break;
    }
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1B5E20),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case 0:
        return SingleChildScrollView(child: _buildStep1());
      case 1:
        return SingleChildScrollView(child: _buildStep2());
      case 2:
        return SingleChildScrollView(child: _buildStep3());
      case 3:
        return SingleChildScrollView(child: _buildStep4());
      case 4:
        return _buildStep5(); // El Final Step ya tiene su propio scroll
      default:
        return Container();
    }
  }

  // STEP 1: Identify the Pronoun
  Widget _buildStep1() {
    return Column(
      children: [
        _buildInstructionCard(
            "Read the sentence and tap on the pronoun \"She\"."),
        const SizedBox(height: 24),
        _buildInteractiveSentence(
          onWordTap: (index) {
            if (_isStep1Correct) return;
            setState(() {
              _selectedPronounIndex = index;
              if (_sentenceWords[index].toLowerCase().replaceAll(".", "") ==
                  "she") {
                _isStep1Correct = true;
              }
            });
          },
          wordColorProvider: (index) {
            if (_selectedPronounIndex == index) {
              return _isStep1Correct ? Colors.green : Colors.red;
            }
            return Colors.black87;
          },
        ),
        if (_selectedPronounIndex != null) ...[
          const SizedBox(height: 24),
          _buildFeedbackBox(
              _isStep1Correct
                  ? " Correct! 'She' is the pronoun because it replaces a person."
                  : " Not quite. Try again! Look for a word that replaces 'Anna'.",
              _isStep1Correct),
        ]
      ],
    );
  }

  // STEP 2: Spot the Nouns
  Widget _buildStep2() {
    return Column(
      children: [
        _buildInstructionCard(
            "Now, tap on all the words that are people, places or things."),
        const SizedBox(height: 24),
        _buildInteractiveSentence(
          onWordTap: (index) {
            setState(() {
              if (_selectedNounIndices.contains(index)) {
                _selectedNounIndices.remove(index);
              } else {
                _selectedNounIndices.add(index);
              }
              _isStep2Correct =
                  _selectedNounIndices.containsAll(_correctNounIndices) &&
                      _selectedNounIndices.length == _correctNounIndices.length;
            });
          },
          wordColorProvider: (index) {
            if (_selectedNounIndices.contains(index)) {
              return _correctNounIndices.contains(index)
                  ? Colors.green
                  : Colors.orange;
            }
            return Colors.black87;
          },
        ),
        const SizedBox(height: 24),
        if (_selectedNounIndices.isNotEmpty)
          _buildFeedbackBox(
              _isStep2Correct
                  ? " Great! You found all the words: Anna, trip, and suitcase."
                  : "Keep looking! There are 3 nouns in total. (${_selectedNounIndices.intersection(_correctNounIndices).length}/3 found)",
              _isStep2Correct),
      ],
    );
  }

  // STEP 3: Check the Reference
  Widget _buildStep3() {
    final options = [
      "A) The suitcase",
      "B) The trip",
      "C) Anna",
      "D) Her excitement"
    ];
    return Column(
      children: [
        _buildInstructionCard("What does “She” refer to?"),
        const SizedBox(height: 24),
        ...List.generate(options.length, (i) {
          bool isSelected = _selectedStep3Option == i;
          return _buildOptionTile(options[i], isSelected, () {
            setState(() {
              _selectedStep3Option = i;
              _isStep3Correct = (i == 2); // Anna
            });
          });
        }),
        if (_selectedStep3Option != null) ...[
          const SizedBox(height: 24),
          _buildFeedbackBox(
              _isStep3Correct
                  ? "✔️ Correct! “She” refers to Anna. It makes logical and grammatical sense: Anna is the only person mentioned who could pack a suitcase."
                  : " Think again. Who is packing the suitcase?",
              _isStep3Correct),
        ]
      ],
    );
  }

  // STEP 4: Confirm with Context
  Widget _buildStep4() {
    final questions = [
      "Can a trip pack a suitcase?",
      "Can a suitcase feel excited?",
      "Can a person pack their own suitcase?"
    ];

    return Column(
      children: [
        _buildInstructionCard("Let's use logic to confirm the match:"),
        const SizedBox(height: 20),
        ...List.generate(questions.length, (i) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.green.withOpacity(0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  questions[i],
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildYesNoButton(i, true),
                    const SizedBox(width: 12),
                    _buildYesNoButton(i, false),
                  ],
                ),
              ],
            ),
          );
        }),
        if (_step4Answers.values.every((v) => v != null)) ...[
          const SizedBox(height: 10),
          _buildFeedbackBox(
              _isStep4Correct
                  ? " “She packed her suitcase...” → It makes sense Anna is the one doing this action."
                  : " Some answers are incorrect. Check the logic again!",
              _isStep4Correct),
        ]
      ],
    );
  }

  Widget _buildYesNoButton(int questionIndex, bool isYes) {
    bool isSelected = _step4Answers[questionIndex] == isYes;
    bool isCorrect = _step4CorrectAnswers[questionIndex] == isYes;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _step4Answers[questionIndex] = isYes;
            _isStep4Correct = true;
            _step4Answers.forEach((key, value) {
              if (value != _step4CorrectAnswers[key]) _isStep4Correct = false;
            });
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? (isCorrect
                    ? Colors.green.withOpacity(0.2)
                    : Colors.red.withOpacity(0.2))
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? (isCorrect ? Colors.green : Colors.red)
                  : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              isYes ? "YES" : "NO",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? (isCorrect ? Colors.green.shade800 : Colors.red.shade800)
                    : Colors.black54,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // STEP 5: Final Step (Updated with User's Requested Design)
  Widget _buildStep5() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.white.withOpacity(0.9),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    " Correct Answer:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "C) Anna",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(height: 32),
                  const Text(
                    "Explanation:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              "\"She\" is a singular female pronoun, which matches the name \"Anna.\"\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              "The other words (trip, suitcase) are objects and cannot pack themselves.\n\n",
                        ),
                        TextSpan(
                          text: "• ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              "Using context clues, we confirm that only a person can perform the action of packing.",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow, color: Colors.black),
              label: const Text(
                "Start Practice Exercises",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFF4CAF50), width: 2),
                ),
                elevation: 4,
              ),
              onPressed: _completeAnalysis,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Reusable Widgets
  Widget _buildInstructionCard(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildInteractiveSentence(
      {required Function(int) onWordTap,
      required Color Function(int) wordColorProvider}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15)
        ],
      ),
      child: Wrap(
        spacing: 10,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: List.generate(_sentenceWords.length, (index) {
          return GestureDetector(
            onTap: () => onWordTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: wordColorProvider(index).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: wordColorProvider(index).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                _sentenceWords[index],
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: wordColorProvider(index),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildOptionTile(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.green.withOpacity(0.2)
              : Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4CAF50)
                : Colors.green.withOpacity(0.1),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? const Color(0xFF2E7D32) : Colors.grey,
              size: 26,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? const Color(0xFF1B5E20) : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackBox(String text, bool isSuccess) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isSuccess ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSuccess
              ? const Color.fromARGB(255, 77, 218, 82)
              : Colors.red.shade300,
          width: 2,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: isSuccess
              ? const Color.fromARGB(255, 2, 135, 9)
              : Colors.red.shade700,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildBottomButton() {
    bool canContinue = false;
    if (_currentStep == 0) {
      canContinue = _isStep1Correct;
      // ignore: curly_braces_in_flow_control_structures
    } else if (_currentStep == 1)
      // ignore: curly_braces_in_flow_control_structures
      canContinue = _isStep2Correct;
    // ignore: curly_braces_in_flow_control_structures
    else if (_currentStep == 2)
      // ignore: curly_braces_in_flow_control_structures
      canContinue = _isStep3Correct;
    // ignore: curly_braces_in_flow_control_structures
    else if (_currentStep == 3) canContinue = _isStep4Correct;

    return Row(
      children: [
        if (_currentStep > 0)
          Expanded(
            child: OutlinedButton(
              onPressed: () => setState(() => _currentStep--),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Color(0xFF4CAF50), width: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text("Back",
                  style: TextStyle(
                      color: Color(0xFF2E7D32), fontWeight: FontWeight.bold)),
            ),
          ),
        if (_currentStep > 0) const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: canContinue ? _nextStep : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              elevation: 3,
            ),
            child: const Text(
              "Next",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
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
    '💡 General Hint: Think about what \'it\' is talking about.',
    '📌 More Specific: What was building a nest?',
  ];

  final List<String> hints2 = [
    '💡 General Hint: What was building a nest?',
    '📌 More Specific: Who looked happy to see the teacher?',
  ];

  final List<String> hints3 = [
    '💡 General Hint: Think about who \'he\' could be referring to.',
    '📌 More Specific: Are there multiple possible people it could refer to?',
  ];

  final List<String> hints4 = [
    '💡 General Hint: Think about who ‘they’ is referring to.',
    '📌 More Specific: Who was mentioned first in the sentence?',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "The children saw a bird in the tree. It was building a nest.\n\nWhat does “It” refer to?",
      "options": [
        "A) The tree",
        "B) The bird",
        "C) The nest",
        "D) The children"
      ],
      "correctIndex": 1,
      "feedback": [
        "Explanation: 'It' refers to the bird, since the sentence says it was building a nest — something a bird would do.",
        "Correct: This is the best choice.",
        "A nest doesn't build itself.",
        "The children aren’t building the nest in this context."
      ]
    },
    {
      "question":
          "A teacher entered the room and greeted the students. They looked happy to see her.\n\nWhat does “They” refer to?",
      "options": [
        "A) The teacher",
        "B) The room",
        "C) The students",
        "D) The greeting"
      ],
      "correctIndex": 2,
      "feedback": [
        "The teacher is singular, but 'They' is plural.",
        "The room cannot look happy.",
        "Correct: 'They' refers to the students, who are plural and reacting to the teacher.",
        "A greeting doesn’t look happy."
      ]
    },
    {
      "question":
          "Liam and Noah were playing chess. He made a bold move.\n\nWhat does “He” refer to?",
      "options": [
        "A) Liam",
        "B) Noah",
        "C) It’s not clear",
        "D) The chess game"
      ],
      "correctIndex": 2,
      "feedback": [
        "We don’t know if Liam or Noah made the move.",
        "We don’t know if Liam or Noah made the move.",
        "Correct: Since both Liam and Noah are male, and we don’t have more context, 'he' could refer to either. It’s ambiguous.",
        "The chess game itself wouldn’t make a move."
      ]
    },
    {
      "question":
          "Someone left their backpack in the hallway. I hope they come back for it.\n\nWhat does “They” refer to?",
      "options": ["A) The hallway", "B) The backpack", "C) I", "D) Someone"],
      "correctIndex": 3,
      "feedback": [
        "The hallway isn’t a person.",
        "The backpack doesn’t come back.",
        "This refers to the speaker, not 'they'.",
        "Correct: 'They' is used here as a singular pronoun for 'someone' whose gender is unknown."
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
        // Lógica de fin de nivel (se mantiene igual)
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
        return const SizedBox(); // Required for pageBuilder
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
              backgroundColor: const Color.fromARGB(255, 232, 255, 232),
              titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              title: Row(
                children: const [
                  Icon(Icons.emoji_events,
                      color: Color.fromARGB(255, 76, 175, 80), size: 30),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Level Complete!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 27, 94, 32),
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
                      color: Color.fromARGB(255, 56, 56, 56),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Get ready for the next challenge!",
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 85, 139, 47),
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
                    foregroundColor: Colors.green.shade700,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  label: const Text("Advance"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
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
      // El fondo se define aquí para que sea estático y no se mueva con el scroll
      backgroundColor: const Color(0xFFE8F5E9),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9), // Verde muy suave
              Color(0xFFC8E6C9),
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
                        const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Choose the right option",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
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
                  // Opciones
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

                  // FEEDBACK
                  if (showFeedback && selectedOptionIndex != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedOptionIndex == correctIndex
                              ? "✩ ${feedback[selectedOptionIndex!]}"
                              : " ${feedback[selectedOptionIndex!]}",
                          style: TextStyle(
                              fontSize: 17,
                              color: selectedOptionIndex == correctIndex
                                  ? const Color(0xFF1B5E20)
                                  : Colors.red),
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  selectedOptionIndex == correctIndex
                                      ? Colors.green.shade400
                                      : Colors.green.shade300,
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

                  // BOTÓN DE PISTAS Y EFECTO BRILLANTE
// BOTÓN DE PISTAS Y EFECTO BRILLANTE
                  if (!showFeedback)
                    Row(
                      children: [
                        Column(
                          children: [
                            // El botón de la bombilla que siempre está ahí
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
                                                color: Colors.yellow
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
                                          ? Colors.amber
                                          : const Color(0xFF3CB371),
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
                                      // ignore: curly_braces_in_flow_control_structures
                                      hintStep2++;
                                    else if (currentQuestionIndex == 2)
                                      // ignore: curly_braces_in_flow_control_structures
                                      hintStep3++;
                                    else if (currentQuestionIndex == 3)
                                      // ignore: curly_braces_in_flow_control_structures
                                      hintStep4++;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),

                        // El texto de la pista si está activa
                        if (currentHint != null)
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.green),
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
                                          // ignore: curly_braces_in_flow_control_structures
                                          hintStep2 = hints2.length;
                                        else if (currentQuestionIndex == 2)
                                          // ignore: curly_braces_in_flow_control_structures
                                          hintStep3 = hints3.length;
                                        else if (currentQuestionIndex == 3)
                                          // ignore: curly_braces_in_flow_control_structures
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
        'Lena and her brother went hiking. ___ brought snacks for the trip.',
    options: ["A) They", "B) She", "C) He", "D) It"],
    correctIndex: 0,
    explanation:
        '✔️ Explanation: "They" is the correct pronoun because it refers to both Lena and her brother, making it plural.',
    incorrectExplanations: [
      ' Correct: "They" refers to both Lena and her brother, which is why it’s the right choice.',
      ' "She" only refers to Lena, not both people.',
      ' "He" only refers to her brother, not both.',
      ' "It" is used for objects or animals, not people.',
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
              Color(0xFFE8F5E9),
              Color(0xFFC8E6C9),
              Color(0xFFA5D6A7),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close,
                          size: 24, color: Color(0xFF1B5E20)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Instrucción
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.touch_app_rounded,
                      size: 16,
                      color: Color(0xFF388E3C),
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Select the option you think is correct",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF388E3C),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Card de pregunta
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF66BB6A),
                        Color(0xFF2E7D32),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1B5E20).withOpacity(0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),

                // Opciones — AbsorbPointer solo aquí
                Expanded(
                  child: AbsorbPointer(
                    absorbing: isAnswerSubmitted,
                    child: ListView.builder(
                      itemCount: question.options.length,
                      itemBuilder: (context, i) {
                        bool isSelected = selected == i;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF4CAF50).withOpacity(0.2)
                                : Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF2E7D32)
                                  : const Color(0xFFA5D6A7),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            dense: true,
                            title: Text(
                              question.options[i],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: Colors.black87,
                              ),
                            ),
                            onTap: () {
                              setState(() => selected = i);
                            },
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
                          ? const Color(0xFFE8F5E9)
                          : const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isCorrect == true
                            ? const Color(0xFF66BB6A)
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
                              ? const Color(0xFF2E7D32)
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
                                  fontSize: 18,
                                  color: isCorrect == true
                                      ? const Color(0xFF1B5E20)
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

                const SizedBox(height: 10),

                // Botón Submit / Continue — FUERA del AbsorbPointer
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isAnswerSubmitted
                        ? _continue
                        : selected != null
                            ? _submitAnswer
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 3,
                    ),
                    child: Text(
                      isAnswerSubmitted ? "Continue" : "Submit",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
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
  int _currentPage = 0;
  String? _selectedAnswer;
  final Set<String> _selectedNouns = {};
  String? _step3Answer;
  String? _step4Answer;
  bool _isProcessing = false;
  final int totalSteps = 5;

  double _progressValue = 0.2;

  void _nextPage() {
    setState(() {
      _isProcessing = true;
      _progressValue = (_currentPage + 2) / totalSteps;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isProcessing = false;
          if (_currentPage < totalSteps - 1) {
            _currentPage++;
            _selectedAnswer = null; // Reset for next steps if needed
          } else {
            _startPractice();
          }
        });
      }
    });
  }

  Widget _buildProgressIndicator() {
    return LinearProgressIndicator(
      value: _progressValue,
      backgroundColor: Colors.white.withOpacity(0.3),
      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
      minHeight: 8,
    );
  }

  // Reusable Feedback Widget
  Widget _buildFeedbackBox({required bool isCorrect, required String text}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect
            ? Colors.green.withOpacity(0.15)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isCorrect ? Colors.green : Colors.red, width: 1.5),
      ),
      child: Row(
        children: [
          Icon(isCorrect ? Icons.check_circle : Icons.error,
              color: isCorrect ? Colors.green : Colors.red),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color:
                    isCorrect ? const Color(0xFF1B5E20) : Colors.red.shade900,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // STEP 1: What is missing?
  Widget _buildStep1() {
    final options = [
      "A) An action word",
      "B) Someone who does\n the action",
      "C) A describing word",
      "D) A place"
    ];
    bool isCorrect = _selectedAnswer == "B) Someone who does\n the action";

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Step 1: Read the whole sentence",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20))),
          const SizedBox(height: 8),
          _buildProgressIndicator(),
          const SizedBox(height: 20),
          _buildSentenceCard(
              "\"Lena and her brother went hiking. ___ brought snacks for the trip.\""),
          const SizedBox(height: 20),
          const Text("What is missing in this sentence?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          ...options.map((opt) => _buildOptionTile(
              opt, _selectedAnswer == opt, "B) Someone who does\n the action")),
          if (_selectedAnswer != null)
            _buildFeedbackBox(
              isCorrect: isCorrect,
              text: isCorrect
                  ? " Someone who does the action \n We don’t know who brought the snacks. "
                  : " Not quite. Look at the blank space: we need to know WHO did the action.",
            ),
          const SizedBox(height: 24),
          if (isCorrect) _buildContinueButton(),
        ],
      ),
    );
  }

  // STEP 2: Tap the nouns (Interactivity)
  Widget _buildStep2() {
    final nouns = ["Lena", "her brother", "hiking", "snacks", "trip"];
    final correctNouns = ["Lena", "her brother"];
    bool allCorrect =
        _selectedNouns.containsAll(correctNouns) && _selectedNouns.length == 2;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Step 2: Look for Possible Matches",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20))),
          const SizedBox(height: 8),
          _buildProgressIndicator(),
          const SizedBox(height: 20),
          _buildSentenceCard(
              "Lena and her brother went hiking. ___ brought snacks for the trip."),
          const SizedBox(height: 20),
          const Text("Tap the people who could bring the snacks:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: nouns.map((noun) {
              bool isSelected = _selectedNouns.contains(noun);
              bool isRight = correctNouns.contains(noun);
              return FilterChip(
                label: Text(noun,
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold)),
                selected: isSelected,
                onSelected: (val) {
                  setState(() {
                    val
                        ? _selectedNouns.add(noun)
                        : _selectedNouns.remove(noun);
                  });
                },
                selectedColor: isRight ? Colors.green : Colors.red.shade400,
                backgroundColor: Colors.white.withOpacity(0.8),
                checkmarkColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              );
            }).toList(),
          ),
          if (_selectedNouns.isNotEmpty)
            _buildFeedbackBox(
              isCorrect: allCorrect,
              text: allCorrect
                  ? " Perfect! Lena and her brother are the people who went hiking."
                  : "Keep selecting! We need both people mentioned at the start.",
            ),
          const SizedBox(height: 24),
          if (allCorrect) _buildContinueButton(),
        ],
      ),
    );
  }

  // STEP 3: Match antecedent to pronoun
  Widget _buildStep3() {
    final options = ["They", "She", "He", "It"];
    bool isCorrect = _step3Answer == "They";

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Step 3: Choose the Correct Word",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20))),
          const SizedBox(height: 8),
          _buildProgressIndicator(),
          const SizedBox(height: 20),
          _buildSentenceCard("What word can replace\n “Lena and her brother”?"),
          const SizedBox(height: 20),
          ...options.map((opt) => _buildOptionTile(
              opt, _step3Answer == opt, "They",
              onSelect: (val) => setState(() => _step3Answer = val))),
          if (_step3Answer != null)
            _buildFeedbackBox(
              isCorrect: isCorrect,
              text: isCorrect
                  ? " The pronoun must refer to both Lena and her brother. That’s plural → \"They\""
                  : _step3Answer == "She"
                      ? " \"She\" only refers to Lena."
                      : _step3Answer == "He"
                          ? " \"He\" only refers to her brother."
                          : " \"It\" is used for things, not people.",
            ),
          const SizedBox(height: 24),
          if (isCorrect) _buildContinueButton(),
        ],
      ),
    );
  }

  // STEP 4: Confirm with Context
  Widget _buildStep4() {
    bool isCorrect = _step4Answer == "YES";

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Step 4: Confirm with Context",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20))),
          const SizedBox(height: 8),
          _buildProgressIndicator(),
          const SizedBox(height: 20),
          _buildSentenceCard(
              "Do people usually take snacks with them when hiking?"),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                  child: _buildLogicButton(
                      "YES", Icons.check, Colors.green, _step4Answer == "YES")),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildLogicButton(
                      "NO", Icons.close, Colors.red, _step4Answer == "NO")),
            ],
          ),
          if (_step4Answer != null)
            _buildFeedbackBox(
              isCorrect: isCorrect,
              text: isCorrect
                  ? " \"They brought snacks...\" → makes perfect sense, both went hiking and both could bring snacks."
                  : " Actually, it's very common! It makes the sentence logical.",
            ),
          const SizedBox(height: 24),
          if (isCorrect) _buildContinueButton(),
        ],
      ),
    );
  }

  // STEP 5: Final Step (Unchanged as requested)
  Widget _buildFinalStep() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("🏁 Final Answer",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20))),
          const SizedBox(height: 8),
          _buildProgressIndicator(),
          const SizedBox(height: 16),
          Card(
            elevation: 3,
            color: Colors.white.withOpacity(0.8),
            margin: const EdgeInsets.only(bottom: 24),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    " Correct Answer:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4CAF50)),
                  ),
                  const SizedBox(height: 8),
                  const Text("A) They",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const Divider(height: 32),
                  const Text("Explanation:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text(
                    "• “They” refers to Lena and her brother together — the only word that fits.\n\n"
                    "• The antecedent (Lena and her brother) is plural, so the pronoun must also be plural.\n\n"
                    "• The context supports that both individuals could have brought snacks.",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: ElevatedButton.icon(
              onPressed: _startPractice,
              icon: const Icon(Icons.play_arrow, color: Colors.black),
              label: const Text("Start Practice",
                  style: TextStyle(fontSize: 18, color: Colors.black)),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                backgroundColor: const Color.fromARGB(255, 60, 154, 66),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widgets
  Widget _buildSentenceCard(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 8, offset: const Offset(0, 4))
        ],
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 19, fontStyle: FontStyle.italic, height: 1.4)),
    );
  }

  Widget _buildOptionTile(String title, bool isSelected, String correctVal,
      {Function(String)? onSelect}) {
    bool isCorrect = title == correctVal;
    return GestureDetector(
      onTap: () => onSelect != null
          ? onSelect(title)
          : setState(() => _selectedAnswer = title),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect
                  ? Colors.green.withOpacity(0.2)
                  : Colors.red.withOpacity(0.1))
              : Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: isSelected
                  ? (isCorrect ? Colors.green : Colors.red)
                  : Colors.grey.shade300,
              width: 2),
        ),
        child: Row(
          children: [
            Icon(
                isSelected
                    ? (isCorrect ? Icons.check_circle : Icons.cancel)
                    : Icons.circle_outlined,
                color: isSelected
                    ? (isCorrect ? Colors.green : Colors.red)
                    : Colors.grey),
            const SizedBox(width: 12),
            Text(title,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildLogicButton(
      String label, IconData icon, Color color, bool isSelected) {
    return ElevatedButton.icon(
      onPressed: () => setState(() => _step4Answer = label),
      icon: Icon(icon, color: isSelected ? Colors.white : color),
      label: Text(label,
          style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? color : Colors.white.withOpacity(0.8),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: isSelected ? 4 : 1,
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.green.shade600,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: _isProcessing ? null : _nextPage,
        child: _isProcessing
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2))
            : const Text("Continue",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _startPractice() {
    setState(() => _isProcessing = true);
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const SecondActyvityAnimation(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // El fondo se define aquí para que sea estático y no se mueva con el scroll
      body: Stack(
        children: [
          // Capa de fondo fija
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE8F5E9), // Verde muy suave
                  Color(0xFFC8E6C9),
                  Color(0xFFA5D6A7),
                ],
              ),
            ),
          ),
          // Capa de contenido con scroll
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: _currentPage == 0
                  ? _buildStep1()
                  : _currentPage == 1
                      ? _buildStep2()
                      : _currentPage == 2
                          ? _buildStep3()
                          : _currentPage == 3
                              ? _buildStep4()
                              : _buildFinalStep(),
            ),
          ),
        ],
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
    '💡 General: Think about the pronoun for the car.',
    '📌 More Specific: Is the sentence talking about a person or an object?',
    '📘 Explanation: Use "it" for an object like a car.'
  ];

  final List<String> hints2 = [
    '💡 General: Think about the pronoun for Sarah.',
    '📌 More Specific: What is Sarah’s gender?',
    '📘 Explanation: Use "she" because Sarah is a female.'
  ];

  final List<String> hints3 = [
    '💡 General: Think about the pronoun for an animal.',
    '📌 More Specific: Is the animal’s gender mentioned?',
    '📘 Explanation: Use "it" when the gender of the animal isn’t known.'
  ];

  final List<String> hints4 = [
    '💡 General: Think about matching the pronoun to "someone".',
    '📌 More Specific: Is "someone" clearly male or female?',
    '📘 Explanation: Use "they" for a person when gender isn’t known.'
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question": "My uncle bought a new car. ___ is red and very fast.",
      "options": ["A) He", "B) It", "C) They", "D) She"],
      "correctIndex": 1,
      "feedback": [
        "“He” is incorrect because the subject is the car, not the uncle.",
        "The pronoun refers to the car — “it” is the correct pronoun for an object.",
        "“They” is incorrect; it’s used for plural or gender-neutral people, not objects.",
        "“She” is incorrect; it's for female people, not objects like cars."
      ]
    },
    {
      "question":
          "The teacher gave Sarah a worksheet. ___ asked a question about it.",
      "options": ["A) She", "B) He", "C) They", "D) It"],
      "correctIndex": 0,
      "feedback": [
        "Sarah is a female student, so “she” is the pronoun that fits.",
        "“He” is incorrect because Sarah is not male.",
        "“They” is incorrect because it implies plural or gender neutrality, which isn't needed here.",
        "“It” is for objects or animals, not people like Sarah."
      ]
    },
    {
      "question":
          "A dog was barking in the street. ___ seemed scared and confused.",
      "options": ["A) They", "B) She", "C) It", "D) He"],
      "correctIndex": 2,
      "feedback": [
        "“They” is incorrect; dogs are usually referred to as singular unless talking about more than one.",
        "“She” is possible if the dog's gender is known, but here it’s unspecified.",
        "“It” is the usual pronoun for animals when the gender isn’t specified.",
        "“He” is incorrect since the gender of the dog is not mentioned."
      ]
    },
    {
      "question":
          "Someone left their keys on the table. I hope ___ come back soon.",
      "options": ["A) He", "B) She", "C) They", "D) It"],
      "correctIndex": 2,
      "feedback": [
        "“He” assumes the person is male, which we don’t know.",
        "“She” assumes the person is female, which we don’t know.",
        "“They” is used as a singular gender-neutral pronoun for “someone.”",
        "“It” is incorrect; it refers to objects, not people."
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
        // Lógica de fin de nivel (se mantiene igual)
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
        return const SizedBox(); // Required for pageBuilder
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
              backgroundColor: const Color.fromARGB(255, 232, 255, 232),
              titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              title: Row(
                children: const [
                  Icon(Icons.emoji_events,
                      color: Color.fromARGB(255, 76, 175, 80), size: 30),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Level Complete!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 27, 94, 32),
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
                      color: Color.fromARGB(255, 56, 56, 56),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Get ready for the next challenge!",
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 85, 139, 47),
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
                    foregroundColor: Colors.green.shade700,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  label: const Text("Advance"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
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
      // El fondo se define aquí para que sea estático y no se mueva con el scroll
      backgroundColor: const Color(0xFFE8F5E9),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9), // Verde muy suave
              Color(0xFFC8E6C9),
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
                        const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Choose the right option",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
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
                  // Opciones
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

                  // FEEDBACK
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
                                  ? const Color(0xFF1B5E20)
                                  : Colors.red),
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  selectedOptionIndex == correctIndex
                                      ? Colors.green.shade400
                                      : Colors.green.shade300,
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

                  // BOTÓN DE PISTAS Y EFECTO BRILLANTE
// BOTÓN DE PISTAS Y EFECTO BRILLANTE
                  if (!showFeedback)
                    Row(
                      children: [
                        Column(
                          children: [
                            // El botón de la bombilla que siempre está ahí
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
                                                color: Colors.yellow
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
                                          ? Colors.amber
                                          : const Color(0xFF3CB371),
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
                                      // ignore: curly_braces_in_flow_control_structures
                                      hintStep2++;
                                    else if (currentQuestionIndex == 2)
                                      // ignore: curly_braces_in_flow_control_structures
                                      hintStep3++;
                                    else if (currentQuestionIndex == 3)
                                      // ignore: curly_braces_in_flow_control_structures
                                      hintStep4++;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),

                        // El texto de la pista si está activa
                        if (currentHint != null)
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.green),
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
                                          // ignore: curly_braces_in_flow_control_structures
                                          hintStep2 = hints2.length;
                                        else if (currentQuestionIndex == 2)
                                          // ignore: curly_braces_in_flow_control_structures
                                          hintStep3 = hints3.length;
                                        else if (currentQuestionIndex == 3)
                                          // ignore: curly_braces_in_flow_control_structures
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
    question: 'Which sentence has a word that doesn’t match?',
    options: [
      "A) Ana lost her notebook. She looked everywhere.",
      "B) The baby cried because he was hungry.",
      "C) Tom and Jack play soccer. He trains every day.",
      "D) Someone left their bag on the bus."
    ],
    correctIndex: 2,
    explanation:
        '✔️ Explanation: “Tom and Jack” is plural, so the correct pronoun should be “they,” not “he.”',
    incorrectExplanations: [
      ' “She” refers correctly to Ana.',
      ' “he” refers correctly to the baby.',
      '',
      ' “They” is correct for referring to “someone” in a gender-neutral way.'
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
              Color(0xFFE8F5E9),
              Color(0xFFC8E6C9),
              Color(0xFFA5D6A7),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close,
                          size: 28, color: Color(0xFF1B5E20)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Card de pregunta
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 28),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF66BB6A),
                        Color(0xFF2E7D32),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1B5E20).withOpacity(0.3),
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

                // Opciones — AbsorbPointer solo aquí
                Expanded(
                  child: AbsorbPointer(
                    absorbing: isAnswerSubmitted,
                    child: ListView.builder(
                      itemCount: question.options.length,
                      itemBuilder: (context, i) {
                        bool isSelected = selected == i;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF4CAF50).withOpacity(0.2)
                                : Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF2E7D32)
                                  : const Color(0xFFA5D6A7),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              question.options[i],
                              style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: Colors.black87,
                              ),
                            ),
                            onTap: () {
                              setState(() => selected = i);
                            },
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
                          ? const Color(0xFFE8F5E9)
                          : const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isCorrect == true
                            ? const Color(0xFF66BB6A)
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
                              ? const Color(0xFF2E7D32)
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
                                      ? const Color(0xFF1B5E20)
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

                // Botón Submit / Continue — FUERA del AbsorbPointer
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isAnswerSubmitted
                        ? _continue
                        : selected != null
                            ? _submitAnswer
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 3,
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

class _ExplanationThirdState extends State<ExplanationThird> {
  int _currentStep = 0;
  final Set<String> _selectedAntecedents = {};
  bool? _pronounMatchAnswer;
  bool? _contextConfirmation;

  double _progressValue = 0.2;

  final Color _primaryGreen = const Color(0xFF2E7D32);
  final Color _lightGreen = const Color(0xFFC8E6C9);
  final Color _darkGreen = const Color(0xFF1B5E20);
  final Color _accentGreen = const Color(0xFF4CAF50);

  void _nextStep() {
    if (_currentStep == 1 && _selectedAntecedents.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one antecedent')),
      );
      return;
    }

    if (_currentStep == 2 && _pronounMatchAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please answer the question')),
      );
      return;
    }

    if (_currentStep == 3 && _contextConfirmation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please confirm your answer')),
      );
      return;
    }

    setState(() {
      _progressValue = (_currentStep + 1) * 0.2;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          if (_currentStep < 4) {
            _currentStep++;
          } else {
            _completeAnalysis();
          }
        });
      }
    });
  }

  void _completeAnalysis() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ThirdActyvityAnimation(),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return LinearProgressIndicator(
      value: _progressValue,
      backgroundColor: Colors.white.withOpacity(0.3),
      valueColor: AlwaysStoppedAnimation<Color>(_primaryGreen),
      minHeight: 8,
    );
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("🔍 Step 1: Identify the word mismatching",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20))),
          _buildProgressIndicator(),
          const SizedBox(height: 16),
          Card(
            elevation: 3,
            color: Colors.white.withOpacity(0.8),
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Examine each option:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildPronounOption("A) She → refers to Ana", true),
                  _buildPronounOption("B) It → refers to the baby", true),
                  _buildPronounOption(
                      "C) He → refers to either Tom or Jack (It is unclear)",
                      false),
                  _buildPronounOption(
                      "D) Their → acceptable for 'Someone'", true),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryGreen,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _nextStep,
              child: const Text(
                "Continue",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPronounOption(String text, bool isCorrect) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCorrect ? _lightGreen : Colors.red[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isCorrect ? _primaryGreen : Colors.red,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isCorrect ? Icons.check_circle : Icons.cancel,
            color: isCorrect ? _primaryGreen : Colors.red,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    final bothSelected = _selectedAntecedents.contains("Tom") &&
        _selectedAntecedents.contains("Jack");

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("🔎 Step 2: Find Possible Matches",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20))),
          _buildProgressIndicator(),
          const SizedBox(height: 16),
          Card(
            elevation: 3,
            color: Colors.white.withOpacity(0.8),
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "\"Tom and Jack play soccer. He trains every day.\"",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Click on all the words that “He” could be talking about.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: ["Tom", "Jack", "Day", "Soccer"].map((noun) {
              final isSelected = _selectedAntecedents.contains(noun);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedAntecedents.remove(noun);
                    } else {
                      _selectedAntecedents.add(noun);
                    }
                  });
                },
                child: Chip(
                  label: Text(noun),
                  backgroundColor:
                      isSelected ? _accentGreen : Colors.white.withOpacity(0.9),
                  side: BorderSide(
                      color: isSelected ? Colors.transparent : Colors.grey),
                  avatar: isSelected
                      ? const Icon(Icons.check, size: 18, color: Colors.white)
                      : null,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          if (_selectedAntecedents.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: bothSelected ? _lightGreen : Colors.orange.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Analysis:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          bothSelected
                              ? " Correct! 'Tom and Jack' together are the possible people that 'He' could refer to."
                              : "🤔 Try selecting the two people mentioned in the sentence.",
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                bothSelected ? _darkGreen : Colors.orange[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryGreen,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: bothSelected ? _nextStep : null,
                    child: const Text(
                      "Continue",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }

  Widget _buildStep3() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("⚖️ Step 3: Stop and think",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20))),
          _buildProgressIndicator(),
          const SizedBox(height: 16),
          Card(
            elevation: 3,
            color: Colors.white.withOpacity(0.8),
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Does 'He' correctly match with 'Tom and Jack'?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildChoiceButton("Yes, it matches", true),
                  _buildChoiceButton("No, it's ambiguous", false),
                ],
              ),
            ),
          ),
          if (_pronounMatchAnswer != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: _pronounMatchAnswer == false
                      ? _lightGreen
                      : Colors.orange[100],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      _pronounMatchAnswer == false
                          ? " Exactly! 'He' is singular, but it could refer to either Tom or Jack. This makes it unclear (ambiguous)."
                          : " Not quite. Since there are two boys, we don't know which one 'He' refers to.",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryGreen,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _nextStep,
                    child: const Text(
                      "Continue",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }

  Widget _buildChoiceButton(String text, bool value) {
    final isSelected = _pronounMatchAnswer == value;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: isSelected ? _primaryGreen : null,
            side: BorderSide(color: _primaryGreen),
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () => setState(() => _pronounMatchAnswer = value),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.white : _primaryGreen,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep4() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("🤔 Step 4: Check with Meaning",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20))),
          _buildProgressIndicator(),
          const SizedBox(height: 16),
          Card(
            elevation: 3,
            color: Colors.white.withOpacity(0.8),
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Can we tell for sure who trains every day from the context?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _contextConfirmation == true
                                ? _primaryGreen
                                : Colors.grey[200],
                          ),
                          onPressed: () =>
                              setState(() => _contextConfirmation = true),
                          child: Text("Yes",
                              style: TextStyle(
                                  color: _contextConfirmation == true
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _contextConfirmation == false
                                ? _primaryGreen
                                : Colors.grey[200],
                          ),
                          onPressed: () =>
                              setState(() => _contextConfirmation = false),
                          child: Text("No",
                              style: TextStyle(
                                  color: _contextConfirmation == false
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_contextConfirmation != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: _contextConfirmation == false
                      ? _lightGreen
                      : Colors.orange[100],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      _contextConfirmation == false
                          ? " Correct! Without more information, we can't distinguish between Tom and Jack."
                          : " Actually, we can't. Both are boys who play soccer, so 'He' could be either one.",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryGreen,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _nextStep,
                    child: const Text(
                      "Continue to Final Answer",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              ],
            )
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
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20))),
          _buildProgressIndicator(),
          const SizedBox(height: 16),
          Card(
            elevation: 3,
            color: Colors.white.withOpacity(0.8),
            margin: const EdgeInsets.only(bottom: 24),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    " Correct Answer:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Sentence C is not clear enough.",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Divider(height: 32),
                  const Text(
                    "Explanation:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "• 'He' is a singular pronoun, but there are two possible singular antecedents (Tom and Jack).\n\n"
                    "• Since both are male and play soccer, the context doesn't help us identify which one is training.\n\n"
                    "• This is a classic example of an ambiguous pronoun reference.",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: ElevatedButton.icon(
              onPressed: _completeAnalysis,
              icon: const Icon(Icons.check_circle, color: Colors.black),
              label: const Text(
                "Continue to Practice",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo degradado estático
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE8F5E9),
                  Color(0xFFC8E6C9),
                  Color(0xFFA5D6A7),
                ],
              ),
            ),
          ),
          // Contenido
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _currentStep == 0
                  ? _buildStep1()
                  : _currentStep == 1
                      ? _buildStep2()
                      : _currentStep == 2
                          ? _buildStep3()
                          : _currentStep == 3
                              ? _buildStep4()
                              : _buildFinalStep(),
            ),
          ),
        ],
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
    '💡 General: Think about if the pronoun matches the people in the sentence.',
    '🔍 More Specific: Check the sentence with two people mentioned — is it clear who "she" refers to?',
    '📘 Explanation: When two people are mentioned, using "she" can be confusing. Maybe the sentence needs a name instead.',
  ];

  final List<String> hints2 = [
    '💡 General: Check if the pronoun matches the subject.',
    '🔍 More Specific: Is one person or a group being talked about?',
    '📘 Explanation: "He" doesn\'t match "my parents and I." A group needs a different pronoun.',
  ];

  final List<String> hints3 = [
    '💡 General Hint: Check if the pronoun matches everyone mentioned',
    '🔍 More Specific: Look at sentences with two people — is it clear who the pronoun means?',
    '📘 Explanation: "He" isn’t clear when two people (Charles and Mark) are named.',
  ];

  final List<String> hints4 = [
    '💡 General: Check if the pronoun matches who or what is in the sentence.',
    '🔍 More Specific: Is there a person mentioned before the pronoun?',
    '📘 Explanation: ‘It" fits only if objects are mentioned.',
  ];

  final List<Map<String, dynamic>> questions = [
    {
      "question": "Which sentence has a word that doesn’t match?",
      "options": [
        "A) The car was fast, and it made a loud noise.",
        "B) I saw Paul and greeted him.",
        "C) Maria and her sister arrived, but she forgot her ID.",
        "D) The computer turned off by itself."
      ],
      "correctIndex": 2,
      "feedback": [
        " 'The car was fast...' is correct: 'it' refers to the car.",
        " 'I saw Paul...' is correct: 'him' correctly refers to Paul.",
        " Explanation: “She” is singular, but the sentence mentions two people. It’s unclear who forgot the ID — a clearer pronoun is needed or the name should be repeated.",
        " 'The computer...' is fine: 'itself' refers to the computer."
      ]
    },
    {
      "question": "Which sentence has a word that doesn’t match?",
      "options": [
        "A) My parents and I went shopping. He bought a new coat.",
        "B) The cat hid because it was scared.",
        "C) My friend called. She want to meet later.",
        "D) Eric is late. He missed the bus."
      ],
      "correctIndex": 0,
      "feedback": [
        "  Explanation: “He” refers to no one in the sentence. The subject is “my parents and I,” so a better choice would be “we” or specifying who bought the coat.",
        " 'It' is correct for the cat (animal, gender not specified).",
        " 'They' is fine as a singular pronoun if gender is unknown.",
        " 'He' correctly refers to Eric."
      ]
    },
    {
      "question": "Which sentence has a word that doesn’t match?",
      "options": [
        "A) The students finished the exam. They looked relieved.",
        "B) The phone kept ringing, but it stopped.",
        "C) James gave Maria a gift. She thanked him.",
        "D) Charles and Mark love music. We play guitar very well."
      ],
      "correctIndex": 3,
      "feedback": [
        " 'They' refers to 'the students' — correct.",
        " 'It' correctly refers to 'the phone'.",
        " 'She' correctly refers to Maria — clear subject reference.",
        " Explanation: “We” doesn’t correctly refer to Charles and Mark. Since the speaker is not part of that group, the pronoun should be “They.” Using “We” creates a logic error regarding the subject."
      ]
    },
    {
      "question": "Which sentence has a word that doesn't match?",
      "options": [
        "A) The students finished the project, and they submitted it early.",
        "B) Sarah visited the library because she needed a book. ",
        "C) David loves to cook, so it made dinner for everyone.",
        "D) The trees lost their leaves during the storm."
      ],
      "correctIndex": 2,
      "feedback": [
        "'They' correctly refers to 'the students'.",
        "'She' correctly refers to Sarah.",
        "Explanation: \"It\" doesn't correctly refer to David. We use \"it\" for objects or animals, but for a person like David, the pronoun should be \"he.\" Using \"it\" for a person is grammatically incorrect.", // ← coma aquí
        "'Their' correctly refers to 'the trees'."
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
        // Lógica de fin de nivel (se mantiene igual)
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
        return const SizedBox(); // Required for pageBuilder
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
              backgroundColor: const Color.fromARGB(255, 232, 255, 232),
              titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              title: Row(
                children: const [
                  Icon(Icons.emoji_events,
                      color: Color.fromARGB(255, 76, 175, 80), size: 30),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Level Complete!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 27, 94, 32),
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
                      color: Color.fromARGB(255, 56, 56, 56),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Get ready for the next challenge!",
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 85, 139, 47),
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
                    foregroundColor: Colors.green.shade700,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  label: const Text("Advance"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
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
    }

    return Scaffold(
      // El fondo se define aquí para que sea estático y no se mueva con el scroll
      backgroundColor: const Color(0xFFE8F5E9),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9), // Verde muy suave
              Color(0xFFC8E6C9),
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
                        const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Choose the right option",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
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
                  // Opciones
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

                  // FEEDBACK
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
                                  ? const Color(0xFF1B5E20)
                                  : Colors.red),
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  selectedOptionIndex == correctIndex
                                      ? Colors.green.shade400
                                      : Colors.green.shade300,
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

                  // BOTÓN DE PISTAS Y EFECTO BRILLANTE
// BOTÓN DE PISTAS Y EFECTO BRILLANTE
                  if (!showFeedback)
                    Row(
                      children: [
                        Column(
                          children: [
                            // El botón de la bombilla que siempre está ahí
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
                                                color: Colors.yellow
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
                                          ? Colors.amber
                                          : const Color(0xFF3CB371),
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
                                      // ignore: curly_braces_in_flow_control_structures
                                      hintStep2++;
                                    else if (currentQuestionIndex == 2)
                                      // ignore: curly_braces_in_flow_control_structures
                                      hintStep3++;
                                    else if (currentQuestionIndex == 3)
                                      // ignore: curly_braces_in_flow_control_structures
                                      hintStep4++;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),

                        // El texto de la pista si está activa
                        if (currentHint != null)
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.green),
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
                                          // ignore: curly_braces_in_flow_control_structures
                                          hintStep2 = hints2.length;
                                        else if (currentQuestionIndex == 2)
                                          // ignore: curly_braces_in_flow_control_structures
                                          hintStep3 = hints3.length;
                                        else if (currentQuestionIndex == 3)
                                          // ignore: curly_braces_in_flow_control_structures
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
        .set({'completedInstructionSpot1': true}, SetOptions(merge: true));

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
      'completedInstructionSpot1': true, // Repetido por seguridad
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
              Color(0xFFE8F5E9), // Verde muy claro
              Color(0xFFC8E6C9), // Verde suave
              Color(0xFFA5D6A7), // Verde un poco más intenso
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.emoji_events, size: 100, color: Colors.amber),
                const SizedBox(height: 12),
                const Text(
                  "You did amazing! The more you practice, the better you'll become! 🌟👏",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B5E20),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Card(
                  elevation: 0,
                  color: Colors.white.withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'To sum up... \n\nIdentifying pronouns helps us understand who or what pronouns are referring to, allowing for clearer reading and communication. "They" can also be used when the gender of the person is not specified.',
                      style: TextStyle(
                          fontSize: 18, height: 1.5, color: Colors.black87),
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
                      backgroundColor: const Color(0xFF2E7D32),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
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
