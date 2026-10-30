import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class LexicalClass1 extends StatefulWidget {
  final Future<void> Function() onFinish;

  const LexicalClass1({super.key, required this.onFinish});

  @override
  State<LexicalClass1> createState() => _LexicalClass1State();
}

class _LexicalClass1State extends State<LexicalClass1> {
  int step = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: switch (step) {
        // 1️⃣ Puzzle
        0 => PuzzleWidget(
            onCompleted: () async {
              setState(() => step = 1);
            },
          ),

        // 2️⃣ Pantalla intermedia
        1 => IntermediateScreen(
            onContinue: () {
              setState(() => step = 2);
            },
          ),

        // 3️⃣ Quiz
        _ => QuizWidget(
            onCorrect: () async {
              await widget.onFinish();
            },
          ),
      },
    );
  }
}

class IntermediateScreen extends StatefulWidget {
  final VoidCallback onContinue;

  const IntermediateScreen({
    super.key,
    required this.onContinue,
  });

  @override
  State<IntermediateScreen> createState() => _IntermediateScreenState();
}

class _IntermediateScreenState extends State<IntermediateScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scale = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
                      Color(0xFF00796B), // aquamarina profunda
                      Color(0xFF009688), // teal aquamarina
                      Color(0xFF26A69A), // aquamarina vibrante
                      Color(0xFF4DB6AC), // aquamarina suave
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: FadeTransition(
              opacity: _fade,
              child: ScaleTransition(
                scale: _scale,
                child: Container(
                  padding: const EdgeInsets.all(28),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 30,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber.withOpacity(0.15),
                        ),
                        child: const Icon(
                          Icons.emoji_events,
                          size: 70,
                          color: Colors.amber,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Well done!",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You completed the puzzle successfully.\nGet ready to answer the questions and show what you learned.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton.icon(
                        onPressed: widget.onContinue,
                        icon: const Icon(Icons.quiz),
                        label: const Text(
                          "Start Questions",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Color(0xFF4DB6AC),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 36,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          elevation: 6,
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
}

class QuizWidget extends StatefulWidget {
  final VoidCallback onCorrect;

  const QuizWidget({super.key, required this.onCorrect});

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> questions = [
    {
      "q":
          "What does the word “unbeatable” most likely mean in “unbeatable prices”?",
      "options": [
        "A) Prices that cannot be matched",
        "B) Prices that are very high",
        "C) Prices that are temporary",
        "D) Prices that cause problems"
      ],
      "correct": 0,
      "optionFeedback": [
        "Correct. The prefix “un-” means “not,” so “unbeatable” means prices that cannot be beaten or matched.",
        "High prices are the opposite of what “unbeatable prices” suggests.",
        "There is no indication that the prices are temporary.",
        "Prices causing problems does not match the positive meaning of the phrase."
      ],
      "explanation":
          "The word “unbeatable” means that no other prices can be better, emphasizing that the prices cannot be matched by competitors."
    },
    {
      "q": "What does the word “exclusive” in “exclusive discounts” mean?",
      "options": [
        "A) Discounts available to everyone",
        "B) Discounts that are special and limited",
        "C) Discounts that increase prices",
        "D) Discounts for shipping only"
      ],
      "correct": 1,
      "optionFeedback": [
        "Exclusive discounts are not available to everyone.",
        "Correct. “Exclusive” suggests something special and limited that not everyone can access.",
        "Discounts reduce prices, not increase them.",
        "There is no indication that the discounts are only for shipping."
      ],
      "explanation":
          "The word “exclusive” implies that the discounts are special and limited, available only to certain people or for a short time."
    },
    {
      "q": "What does “affordable” mean in the ad?",
      "options": [
        "A) Too expensive",
        "B) Easy to pay for",
        "C) Difficult to find",
        "D) Limited in supply"
      ],
      "correct": 1,
      "optionFeedback": [
        "Affordable does not mean expensive.",
        "Correct. “Affordable” means something is easy to pay for or within a reasonable price range.",
        "Difficulty of finding something is unrelated to price.",
        "Limited supply does not define affordability."
      ],
      "explanation":
          "The suffix “-able” means “able to,” so “affordable” means able to be afforded or easy to pay for."
    },
    {
      "q": "In “flash sales,” what does the word “flash” most likely mean?",
      "options": [
        "A) A quick and short sale",
        "B) A camera light",
        "C) A type of payment",
        "D) A brand name"
      ],
      "correct": 0,
      "optionFeedback": [
        "Correct. “Flash” refers to something that happens very quickly and lasts a short time.",
        "A camera light is not relevant in this context.",
        "Flash is not a type of payment.",
        "There is no indication that flash is a brand name."
      ],
      "explanation":
          "Context clues show that “flash sale” refers to a quick, limited-time offer."
    },
    {
      "q": "What does the phrase “at your fingertips” mean in the ad?",
      "options": [
        "A) Literally touching your fingers",
        "B) Easy to access on your phone",
        "C) Something dangerous",
        "D) A type of jewelry"
      ],
      "correct": 1,
      "optionFeedback": [
        "The phrase is not meant literally.",
        "Correct. “At your fingertips” means something is easy and instantly accessible, often digitally.",
        "There is no negative or dangerous meaning implied.",
        "Jewelry is unrelated to the phrase."
      ],
      "explanation":
          "The phrase “at your fingertips” suggests that shopping or information is instantly available and easy to access, usually through a device like a phone."
    }
  ];

  int currentQuestion = 0;
  int? selectedOption;
  Set<int> wrongAnswers = {};
  bool answeredCorrectly = false;
  bool _showCongrats = false;

  void _autoScroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[currentQuestion];

    return Scaffold(
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF00796B), // aquamarina profunda
                      Color(0xFF009688), // teal aquamarina
                      Color(0xFF26A69A), // aquamarina vibrante
                      Color(0xFF4DB6AC), // aquamarina suave
                    ],
                  ),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),

                            // 👉 Question X of Y ARRIBA de la imagen
                            Center(
                              child: _questionHeader(),
                            ),

                            const SizedBox(height: 12),

                            // Imagen de referencia
                            Center(
                              child: Container(
                                height: 250,
                                width: 250,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    "assets/PUZZLES/L2-1.webp",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),
                            _questionCard(q),
                            const SizedBox(height: 16),
                            _options(q),
                            if (answeredCorrectly) _finalExplanation(q),
                            if (answeredCorrectly) _nextButton(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          if (_showCongrats) _buildCongratsOverlay(),
        ],
      ),
    );
  }

  Widget _buildCongratsOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.8),
      child: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 800),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.stars,
                    color: Colors.amber,
                    size: 100,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "CONGRATS!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Challenge Completed Successfully",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _questionHeader() => Text(
        "Question ${currentQuestion + 1} of ${questions.length}",
        style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      );

  Widget _questionCard(Map q) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.white],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Text(
          q["q"],
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      );

  Widget _options(Map q) => Column(
        children: List.generate(q["options"].length, (i) {
          final isCorrect = i == q["correct"];
          final isWrong = wrongAnswers.contains(i);

          return GestureDetector(
            onTap: answeredCorrectly || isWrong
                ? null
                : () {
                    setState(() {
                      selectedOption = i;
                      if (isCorrect) {
                        answeredCorrectly = true;
                      } else {
                        wrongAnswers.add(i);
                      }
                      _autoScroll();
                    });
                  },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isCorrect && answeredCorrectly
                    ? Colors.green.shade200
                    : isWrong
                        ? Colors.red.shade200
                        : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(child: Text(q["options"][i])),
                ],
              ),
            ),
          );
        }),
      );

Widget _finalExplanation(Map q) => Card(
      color: Colors.green.shade50,
      margin: const EdgeInsets.only(top: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: const Color.fromARGB(255, 77, 218, 82), // verde suave
          width: 2.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          q["explanation"],
          style: const TextStyle(fontSize: 15, color: Color.fromARGB(255, 2, 135, 9)),
        ),
      ),
    );

  Widget _nextButton() => Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          onPressed: () async {
            if (currentQuestion == questions.length - 1) {
              setState(() => _showCongrats = true);
              await Future.delayed(const Duration(seconds: 3));
              widget.onCorrect();
            } else {
              setState(() {
                currentQuestion++;
                selectedOption = null;
                answeredCorrectly = false;
                wrongAnswers.clear();
              });
            }
          },
          child: Text(
            currentQuestion == questions.length - 1
                ? "Finish Quiz"
                : "Next Question",
            style: const TextStyle(color: Colors.black),
          ),
        ),
      );
}

class PuzzleWidget extends StatefulWidget {
  final Future<void> Function() onCompleted;

  const PuzzleWidget({
    super.key,
    required this.onCompleted,
  });

  @override
  State<PuzzleWidget> createState() => _PuzzleWidgetState();
}

class _PuzzleWidgetState extends State<PuzzleWidget>
    with TickerProviderStateMixin {
  final int grid = 3;
  static const double puzzleSize = 350;
  static const double gap = 2;

  late List<int> pieces;
  late List<Offset> piecePositions;
  late int emptyIndex;
  bool solved = false;
  int moves = 0;
  late DateTime startTime;
  Duration elapsedTime = Duration.zero;
  late Timer timer;
  bool _completionSent = false;
  bool _showTutorial = true;

  late AnimationController _animationController;
  late AnimationController _tutorialController;
  late Animation<double> _pulseAnimation;

  final ImageProvider imageProvider =
      const AssetImage("assets/PUZZLES/L2-1.webp");

  @override
  void initState() {
    super.initState();
    _initializePuzzle();
    _startTimer();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.05), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 1.05, end: 1.0), weight: 1),
    ]).animate(_animationController);

    _tutorialController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Ocultar tutorial después de 6 segundos o al primer movimiento
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted && _showTutorial) {
        setState(() => _showTutorial = false);
      }
    });
  }

  void _initializePuzzle() {
    pieces = List.generate(grid * grid, (i) => i);
    pieces[pieces.length - 1] = -1;
    emptyIndex = pieces.length - 1;

    // Shuffle hasta que sea solucionable
    do {
      pieces.shuffle();
      emptyIndex = pieces.indexOf(-1);
    } while (!_isSolvable() || _isAlreadySolved());

    piecePositions = List.generate(
      grid * grid,
      (i) => Offset(
        (i % grid).toDouble(),
        (i ~/ grid).toDouble(),
      ),
    );

    startTime = DateTime.now();
    moves = 0;
    solved = false;
  }

  bool _isSolvable() {
    int inversions = 0;
    List<int> tempPieces = pieces.where((p) => p != -1).toList();

    for (int i = 0; i < tempPieces.length; i++) {
      for (int j = i + 1; j < tempPieces.length; j++) {
        if (tempPieces[i] > tempPieces[j]) {
          inversions++;
        }
      }
    }

    // Para grid impar, el número de inversiones debe ser par
    if (grid % 2 == 1) {
      return inversions % 2 == 0;
    }

    // Para grid par
    int emptyRow = emptyIndex ~/ grid;
    int emptyRowFromBottom = grid - emptyRow;

    if (emptyRowFromBottom % 2 == 0) {
      return inversions % 2 == 1;
    } else {
      return inversions % 2 == 0;
    }
  }

  bool _isAlreadySolved() {
    for (int i = 0; i < pieces.length - 1; i++) {
      if (pieces[i] != i) return false;
    }
    return pieces.last == -1;
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!solved) {
        setState(() {
          elapsedTime = DateTime.now().difference(startTime);
        });
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  bool _isAdjacent(int a, int b) {
    int ax = a % grid, ay = a ~/ grid;
    int bx = b % grid, by = b ~/ grid;
    return (ax - bx).abs() + (ay - by).abs() == 1;
  }

  void _movePiece(int index) {
    if (solved || !_isAdjacent(index, emptyIndex)) return;

    setState(() {
      if (_showTutorial) _showTutorial = false;
      pieces[emptyIndex] = pieces[index];
      pieces[index] = -1;
      emptyIndex = index;
      moves++;

      if (_checkSolved()) {
        solved = true;
        timer.cancel();
        _animationController.forward();
      }
    });
  }

  bool _checkSolved() {
    for (int i = 0; i < pieces.length - 1; i++) {
      if (pieces[i] != i) return false;
    }
    return pieces.last == -1;
  }

  void _shufflePuzzle() {
    setState(() {
      do {
        pieces.shuffle();
        emptyIndex = pieces.indexOf(-1);
      } while (!_isSolvable() || _isAlreadySolved());

      moves = 0;
      solved = false;
      startTime = DateTime.now();
      elapsedTime = Duration.zero;
      _animationController.reset();
      timer.cancel();
      _startTimer();
    });
  }

  Future<void> _completeOnce() async {
    if (_completionSent) return;

    _completionSent = true;
    await widget.onCompleted();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _tutorialController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Información del juego
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoCard(
                        Icons.timer, "Time", _formatDuration(elapsedTime)),
                    _buildInfoCard(Icons.directions, "Moves", "$moves"),
                  ],
                ),
              ),

              // Instrucciones
              if (!solved)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Text(
                    "Tap a piece to move it into the empty space and complete the puzzle.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 21, 192, 155),
                    ),
                  ),
                ),

              // Rompecabezas
              solved
                  ? _buildSolved()
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        _buildPuzzle(),
                        if (_showTutorial && !solved) _buildTutorialOverlay(),
                      ],
                    ),

              // Controles
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildControlButton(
                      Icons.refresh,
                      "Restart",
                      const Color.fromARGB(255, 33, 243, 201),
                      _shufflePuzzle,
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

  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(icon, color: const Color.fromARGB(255, 33, 243, 208), size: 24),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 33, 243, 215),
            )),
      ],
    );
  }

  Widget _buildControlButton(
      IconData icon, String label, Color color, VoidCallback onPressed) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.white),
          onPressed: onPressed,
          style: IconButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(16),
          ),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }

  Widget _buildSolved() {
    return Column(
      children: [
        ScaleTransition(
          scale: _pulseAnimation,
          child: Container(
            width: puzzleSize,
            height: puzzleSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withOpacity(0.5),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/PUZZLES/L2-1.webp",
                width: puzzleSize,
                height: puzzleSize,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color.fromARGB(255, 25, 210, 164), width: 2),
          ),
          child: Column(
            children: [
              const Icon(Icons.celebration, size: 50, color: Color.fromARGB(255, 25, 210, 201)),
              const SizedBox(height: 16),
              const Text(
                "Puzzle Finished!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 25, 210, 164),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Time: ${_formatDuration(elapsedTime)}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "Moves: $moves",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      _shufflePuzzle();
                      await _completeOnce();
                    },
                    icon: const Icon(Icons.replay),
                    label: const Text(
                      "Try again",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: solved
                        ? () async {
                            await _completeOnce(); // 👉 avanza a la pantalla intermedia
                          }
                        : null, // ⛔ bloqueado si el puzzle no está resuelto
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text(
                      "Continue",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 25, 210, 164),
                      disabledBackgroundColor:
                          Color.fromARGB(255, 25, 210, 164).withOpacity(0.4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 6,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPuzzle() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        width: puzzleSize,
        height: puzzleSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: grid,
            mainAxisSpacing: gap,
            crossAxisSpacing: gap,
          ),
          itemCount: pieces.length,
          itemBuilder: (context, index) {
            final piece = pieces[index];

            if (piece == -1) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
              );
            }

            return GestureDetector(
              onTap: () => _movePiece(index),
              child: Draggable<int>(
                data: index,
                feedback: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: puzzleSize / grid - gap,
                    height: puzzleSize / grid - gap,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color.fromARGB(255, 33, 243, 191), width: 2),
                    ),
                    child: _buildPiece(piece),
                  ),
                ),
                childWhenDragging: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onDragCompleted: () {
                  // La lógica de movimiento se maneja en el DragTarget
                },
                child: DragTarget<int>(
                  builder: (context, candidateData, rejectedData) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _isAdjacent(index, emptyIndex)
                            ? const Color.fromARGB(255, 33, 243, 208).withOpacity(0.1)
                            : Colors.transparent,
                        border: Border.all(
                          color: _isAdjacent(index, emptyIndex)
                              ? const Color.fromARGB(255, 33, 243, 191).withOpacity(0.5)
                              : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: candidateData.isNotEmpty
                            ? [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 33, 243, 191)  .withOpacity(0.5),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ]
                            : [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                      ),
                      child: _buildPiece(piece),
                    );
                  },
                  onWillAccept: (data) => _isAdjacent(data!, emptyIndex),
                  onAccept: (data) {
                    if (_isAdjacent(data, emptyIndex)) {
                      _movePiece(data);
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTutorialOverlay() {
    // Encontrar una pieza adyacente al espacio vacío para animar
    int adjacentIndex = -1;
    for (int i = 0; i < pieces.length; i++) {
      if (_isAdjacent(i, emptyIndex)) {
        adjacentIndex = i;
        break;
      }
    }

    if (adjacentIndex == -1) return const SizedBox.shrink();

    final double tileSize = (puzzleSize - 16 - (gap * (grid - 1))) / grid;

    // Calcular posiciones relativas
    double startX = (adjacentIndex % grid) * (tileSize + gap) + 8;
    double startY = (adjacentIndex ~/ grid) * (tileSize + gap) + 8;
    double endX = (emptyIndex % grid) * (tileSize + gap) + 8;
    double endY = (emptyIndex ~/ grid) * (tileSize + gap) + 8;

    return IgnorePointer(
      child: SizedBox(
        width: puzzleSize,
        height: puzzleSize,
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _tutorialController,
              builder: (context, child) {
                final double t = _tutorialController.value;
                double currentX = ui.lerpDouble(startX, endX, t)!;
                double currentY = ui.lerpDouble(startY, endY, t)!;
                double opacity =
                    t < 0.1 ? t * 10 : (t > 0.9 ? (1 - t) * 10 : 1.0);

                return Stack(
                  children: [
                    // Icono de mano
                    Positioned(
                      left: currentX + tileSize / 3,
                      top: currentY + tileSize / 3,
                      child: Opacity(
                        opacity: opacity,
                        child: const Icon(
                          Icons.touch_app,
                          size: 40,
                          color:Color.fromARGB(255, 0, 121, 107),
                        ),
                      ),
                    ),
                    // Texto explicativo flotante
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 20,
                      child: Opacity(
                        opacity: opacity,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPiece(int pieceIndex) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Imagen de la pieza
          PuzzlePiece(
            image: imageProvider,
            index: pieceIndex,
            grid: grid,
          ),

          // Número de la pieza (opcional)
          Positioned(
            top: 4,
            left: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                (pieceIndex + 1).toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Efecto de hover
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: null, // El tap se maneja en el GestureDetector padre
                splashColor: Color(0xFF00796B).withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PuzzlePiece extends StatelessWidget {
  final ImageProvider image;
  final int index;
  final int grid;

  const PuzzlePiece({
    super.key,
    required this.image,
    required this.index,
    required this.grid,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
      future: _loadImage(image),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return CustomPaint(
            painter: PuzzlePiecePainter(
              image: snapshot.data!,
              index: index,
              grid: grid,
            ),
          );
        }
        return Container(
          color: Colors.grey[300],
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Future<ui.Image> _loadImage(ImageProvider provider) async {
    final completer = Completer<ui.Image>();
    final stream = provider.resolve(const ImageConfiguration());
    final listener = ImageStreamListener((info, _) {
      completer.complete(info.image);
    });
    stream.addListener(listener);
    return completer.future.then((image) {
      stream.removeListener(listener);
      return image;
    });
  }
}

class PuzzlePiecePainter extends CustomPainter {
  final ui.Image image;
  final int index;
  final int grid;

  PuzzlePiecePainter({
    required this.image,
    required this.index,
    required this.grid,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final pieceWidth = image.width / grid;
    final pieceHeight = image.height / grid;

    final srcRect = Rect.fromLTWH(
      (index % grid) * pieceWidth,
      (index ~/ grid) * pieceHeight,
      pieceWidth,
      pieceHeight,
    );

    final dstRect = Rect.fromLTWH(0, 0, size.width, size.height);

    final paint = Paint()
      ..filterQuality = FilterQuality.high
      ..isAntiAlias = true;

    // Dibuja la imagen
    canvas.drawImageRect(image, srcRect, dstRect, paint);

    // Bordes sutiles para distinguir piezas
    final borderPaint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..isAntiAlias = true;

    canvas.drawRect(dstRect.deflate(0.5), borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
