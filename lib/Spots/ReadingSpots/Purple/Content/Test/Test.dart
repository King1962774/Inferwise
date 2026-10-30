import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Purple/Content/Test/Final_Test.dart';

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

// ignore: non_constant_identifier_names
final List<QuestionData> FinalTestfirst = [
// --- Question 1 ---
  QuestionData(
    question:
        "Title: Race to the North Pole\nWhat will the story most likely include?",
    options: [
      "A) Explorers traveling in icy conditions ",
      "B) A family going to the water park",
      "C) Students in a classroom",
      "D) A chef making ice soup",
    ],
    correctIndex: 0,
    explanation:
        "🍀 Explanation: “North Pole” suggests adventure, cold, and exploration.",
    incorrectExplanations: [
      " Correct answer: ",
      "Incorrect.",
      "Incorrect.",
      "Incorrect.",
    ],
  ),

// --- Question 2 ---
  QuestionData(
    question:
        "Subtitle: How Rosa Learned to Fly\nWhat is the story most likely about?",
    options: [
      "A) Rosa opening a bakery ",
      "B) Rosa becoming a pilot",
      "C) Rosa painting a picture",
      "D) Rosa buying new shoes",
    ],
    correctIndex: 1,
    explanation:
        "🍀 Explanation: “Learned to fly” suggests airplanes or even magical flying, not baking or painting.",
    incorrectExplanations: [
      "Incorrect.",
      " Correct answer",
      "Incorrect.",
      "Incorrect.",
    ],
  ),

// --- Question 3 ---
  QuestionData(
    question:
        "Character: A clumsy detective in a mystery story\nWhat will probably happen?",
    options: [
      "A) He suddenly becomes clever",
      "B) He becomes a superhero",
      "C) He unexpectedly solves the case ",
      "D) He goes swimming in a resort",
    ],
    correctIndex: 2,
    explanation:
        "🍀 Explanation: A clumsy detective will still reach the solution, but with humor or mistakes.",
    incorrectExplanations: [
      "Incorrect.",
      "Incorrect.",
      " Correct answer",
      "Incorrect.",
    ],
  ),

// --- Question 4 ---
  QuestionData(
    question:
        "Genre: Fairy Tale — The Enchanted Forest\nWhat is most likely to appear in the story?",
    options: [
      "A) Talking / magical creatures ",
      "B) Police officers and robbers",
      "C) Scientists in a lab",
      "D) Soldiers in a war",
    ],
    correctIndex: 0,
    explanation:
        "🍀 Explanation: Fairy tales often include enchanted animals, magic, or fantasy settings.",
    incorrectExplanations: [
      " Correct answer",
      "Incorrect.",
      "Incorrect.",
      "Incorrect.",
    ],
  ),

// --- Question 5 ---
  QuestionData(
    question:
        "Maria left a pot of soup on the stove and forgot about it.\nWhat will most likely happen?",
    options: [
      "A) The soup will stay perfect forever",
      "B) The soup will freeze",
      "C) The soup will turn into ice cream",
      "D) The soup will burn ",
    ],
    correctIndex: 3,
    explanation: "🍀 Explanation: Food left unattended on heat usually burns.",
    incorrectExplanations: [
      "Incorrect.",
      "Incorrect.",
      "Incorrect.",
      " Correct answer: D",
    ],
  ),

// --- Question 6 ---
  QuestionData(
    question:
        "Ethan left his wet clothes in a pile for three days.\nWhat will most likely happen?",
    options: [
      "A) The clothes will smell bad ",
      "B) The clothes will become brand new",
      "C) The clothes will turn into paper",
      "D) The clothes will disappear",
    ],
    correctIndex: 0,
    explanation:
        "🍀 Explanation: Wet clothes left too long usually get smelly or moldy.",
    incorrectExplanations: [
      " Correct answer",
      "Incorrect.",
      "Incorrect.",
      "Incorrect.",
    ],
  ),

// --- Question 7 ---
  QuestionData(
    question:
        "Leo dropped his phone in the bathtub full of water.\nWhat will most likely happen?",
    options: [
      "A) The phone will call someone automatically",
      "B) The phone will grow wings",
      "C) The phone will charge itself",
      "D) The phone will stop working ",
    ],
    correctIndex: 3,
    explanation: "🍀 Explanation: Water usually damages electronics.",
    incorrectExplanations: [
      "Incorrect.",
      "Incorrect.",
      "Incorrect.",
      " Correct answer",
    ],
  ),

// --- Question 8 ---
  QuestionData(
    question:
        "Nora forgot to close the refrigerator door overnight.\nWhat will most likely happen?",
    options: [
      "A) The food inside will spoil ",
      "B) The food will get colder",
      "C) The fridge will turn into an oven",
      "D) The food will disappear",
    ],
    correctIndex: 0,
    explanation:
        "🍀 Explanation: Leaving the fridge open warms the inside and spoils the food.",
    incorrectExplanations: [
      " Correct answer",
      "Incorrect.",
      "Incorrect.",
      "Incorrect.",
    ],
  ),

// --- Question 9 ---
  QuestionData(
    question:
        "Maya left the window open during a heavy rainstorm.\nWhat will most likely happen?",
    options: [
      "A) The room will stay perfectly dry.",
      "B) Water will come inside and make things wet. ",
      "C) The rain will stop immediately.",
      "D) The window will close by itself.",
    ],
    correctIndex: 1,
    explanation:
        "🍀 Explanation: Leaving a window open during rain usually makes the inside wet.",
    incorrectExplanations: [
      "Incorrect.",
      "Correct answer:",
      "Incorrect.",
      "Incorrect.",
    ],
  ),

// --- Question 10 ---
  QuestionData(
    question:
        "Clara went to the beach on a very sunny day but didn’t use sunscreen.\nWhat will most likely happen?",
    options: [
      "A) She will get a sunburn. ",
      "B) She will stay completely safe from the sun.",
      "C) She will turn into a mermaid.",
      "D) She will get covered in snow.",
    ],
    correctIndex: 0,
    explanation:
        "🍀 Explanation: Without sunscreen, being in the sun too long usually causes sunburn.",
    incorrectExplanations: [
      " Correct answer",
      "Incorrect.",
      "Incorrect.",
      "Incorrect.",
    ],
  ),

  QuestionData(
    question:
        "After the interview, Jordan thanked Casey for her time.\nShe appreciated the gesture.\n\nWhat does “the gesture” refer to?",
    options: [
      "A) The interview",
      "B) The time spent talking",
      "C) Jordan thanking Casey",
      "D) The opportunity"
    ],
    correctIndex: 2,
    explanation:
        "The gesture refers to Jordan’s act of thanking Casey, which was appreciated.",
    incorrectExplanations: [
      "Incorrect. The gesture is not the interview itself.",
      "Incorrect. The gesture refers to something done, not the time spent.",
      "Correct answer!",
      "Incorrect. The gesture refers specifically to the act of thanking."
    ],
  ),
  QuestionData(
    question:
        "His opinion was based on a misconception about the project.\n\nWhat is the meaning of “misconception”?",
    options: [
      "A) A correct belief",
      "B) A mistaken belief",
      "C) A proven theory",
      "D) A clear understanding"
    ],
    correctIndex: 1,
    explanation:
        "“Misconception” refers to a belief or idea that is incorrect or misunderstood.",
    incorrectExplanations: [
      "Incorrect. A misconception is not correct.",
      "Correct answer!",
      "Incorrect. A misconception is not a proven theory.",
      "Incorrect. Clear understanding is the opposite of misconception."
    ],
  ),
  QuestionData(
    question:
        "Nina was nervous about speaking in front of her class, so she practiced every day in front of the mirror. She even recorded herself to improve tone and pacing. When her turn came, she gave her speech with confidence.\n\nWhy did Nina practice her speech so thoroughly?",
    options: [
      "A) She had a lot of free time",
      "B) She wanted to overcome her fear",
      "C) She enjoyed hearing herself talk",
      "D) She was forced to participate"
    ],
    correctIndex: 1,
    explanation:
        "Nina’s preparation stemmed from her desire to manage anxiety and succeed in a difficult situation.",
    incorrectExplanations: [
      "Incorrect. Her motivation was overcoming fear, not free time.",
      "Correct answer!",
      "Incorrect. Her practice was to improve confidence, not enjoyment.",
      "Incorrect. There is no evidence she was forced."
    ],
  ),
  QuestionData(
    question:
        "The doctor entered the room and the patient immediately sat up on the hospital bed.\n\nWhat is the setting of this scene?",
    options: [
      "A) A school",
      "B) A clinic or hospital",
      "C) An airport",
      "D) A restaurant"
    ],
    correctIndex: 1,
    explanation:
        "The presence of a doctor, a patient, and a hospital bed indicates this scene is taking place in a hospital or clinic.",
    incorrectExplanations: [
      "Incorrect. A school would not have this scene.",
      "Correct answer!",
      "Incorrect. Airports do not typically involve hospital beds.",
      "Incorrect. Restaurants do not include doctors treating patients."
    ],
  ),
];

class TestIntro5 extends StatefulWidget {
  const TestIntro5({super.key});

  @override
  State<TestIntro5> createState() => _TestIntro5State();
}

class _TestIntro5State extends State<TestIntro5>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
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
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(247, 173, 60, 254), // Morado fuerte
              Color.fromARGB(247, 150, 80, 245), // Morado intermedio
              Color.fromARGB(255, 130, 105, 240), // Morado-azulado
              Color.fromARGB(255, 115, 120, 238), // Azul violeta
              Color.fromARGB(255, 102, 129, 237), // Azul
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeIn,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.book,
                  size: 90,
                  color: const Color.fromARGB(247, 173, 60, 254),
                ),
                const SizedBox(height: 30),
                Text(
                  "Final Challenge 🚀",
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  "You're at the final challenge! Let’s put those lexical, referential, explanatory, elaborative, and predictive skills to the ultimate test—finish with power and pride! 💡📚🚀                                        ",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    height: 1.5,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 60),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(247, 150, 80, 245), // Morado intermedio
                        Color.fromARGB(255, 130, 105, 240), // Morado-azulado
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FinalTest(questions: FinalTestfirst),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: const Icon(Icons.play_arrow_rounded,
                        size: 26, color: Colors.white),
                    label: Text(
                      "Go to Test!",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
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
      ),
    );
  }
}
