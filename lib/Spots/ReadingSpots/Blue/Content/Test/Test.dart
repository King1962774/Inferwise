import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Blue/Content/Test/FinalTest.dart';

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
List<QuestionData> FinalTestSecond = [
  QuestionData(
    question:
        '- The movie was so moving; I couldn’t stop crying.\n\nWhat does "moving" mean in this context?',
    options: [
      "A) Something that is physically moving",
      "B) Causing strong emotions",
      "C) Moving from one place to another",
      "D) A type of dance",
    ],
    correctIndex: 1,
    explanation:
        ' "Moving" here refers to something that touches your emotions deeply, not physically moving.',
    incorrectExplanations: [
      'Incorrect answer!',
      ' This is a literal meaning and doesn’t fit the emotional context.',
      ' This refers to motion, not emotion.',
      ' A type of dance is unrelated to the sentence.',
    ],
  ),
  QuestionData(
    question:
        '- I need to take a break; I feel so exhausted from running.\n\nWhich word is a false cognate for "exhausted" in Spanish?',
    options: [
      "A) Excitado",
      "B) Exhausto",
      "C) Agotado",
      "D) Energizado",
    ],
    correctIndex: 0,
    explanation:
        ' "Excitado" in Spanish means excited, not exhausted. "Exhausto" and "agotado" are the correct translations for "exhausted."',
    incorrectExplanations: [
      'Incorrect answer!',
      ' "Exhausto" is actually a correct cognate.',
      ' "Agotado" is a valid translation for exhausted.',
      ' "Energizado" means energized, the opposite of exhausted, but not a false cognate.',
    ],
  ),
  QuestionData(
    question:
        '- She has a tremendous amount of energy for someone who works so much.\n\nWhat does "tremendous" mean in this context?',
    options: [
      "A) Average",
      "B) Terrible",
      "C) Very large or impressive",
      "D) Not noticeable",
    ],
    correctIndex: 2,
    explanation:
        ' "Tremendous" means something large in size or impact, here referring to a lot of energy.',
    incorrectExplanations: [
      'Incorrect answer!',
      ' "Terrible" is unrelated here; the sentence is positive.',
      ' "Average" means ordinary, which doesn’t match the context.',
      ' "Not noticeable" is the opposite of "tremendous."',
    ],
  ),
  QuestionData(
    question:
        '- Her speech was very informative and full of useful facts.\n\nWhat does "informative" mean in this context?',
    options: [
      "A) Fun and entertaining",
      "B) Full of information",
      "C) Quiet and peaceful",
      "D) Emotional",
    ],
    correctIndex: 1,
    explanation:
        ' "Informative" means providing valuable or detailed information.',
    incorrectExplanations: [
      'Incorrect answer!',
      ' "Fun and entertaining" might apply elsewhere, but here the focus is facts.',
      ' "Quiet and peaceful" does not fit the context of content.',
      ' "Emotional" isn’t related to usefulness of information.',
    ],
  ),
  QuestionData(
    question:
        '- I can’t believe he completed the task so efficiently.\n\nWhat does "efficiently" mean?',
    options: [
      "A) Slowly",
      "B) With difficulty",
      "C) In a quick and effective way",
      "D) Without thinking",
    ],
    correctIndex: 2,
    explanation:
        ' "Efficiently" means doing something in a way that maximizes productivity with minimal waste.',
    incorrectExplanations: [
      'Incorrect  answer!',
      ' "Slowly" is the opposite of efficiently.',
      ' "With difficulty" contradicts the smooth performance implied.',
      ' "Without thinking" implies carelessness, not efficiency.',
    ],
  ),
  QuestionData(
    question:
        '- After the long hike, I felt completely parched.\n\nWhat does "parched" mean in this sentence?',
    options: [
      "A) Thirsty",
      "B) Tired",
      "C) Hot",
      "D) Cold",
    ],
    correctIndex: 0,
    explanation:
        ' "Parched" means extremely thirsty, especially from heat or exertion.',
    incorrectExplanations: [
      'Incorrect answer!',
      ' "Tired" is a result of exertion but not what "parched" means.',
      ' "Hot" may relate to the situation but is not the meaning of the word.',
      ' "Cold" is unrelated in this context.',
    ],
  ),
  QuestionData(
    question:
        '- The teacher asked us to recheck our answers before handing in the test.\n\nWhat does the prefix "re-" mean in this sentence?',
    options: [
      "A) Without",
      "B) Again",
      "C) Before",
      "D) After",
    ],
    correctIndex: 1,
    explanation:
        ' "Re-" as a prefix means to do something again, like "recheck" means to check again.',
    incorrectExplanations: [
      'Incorrect answer!',
      ' "Without" is what "in-" or "un-" might mean.',
      ' "Before" is related to "pre-", not "re-".',
      ' "After" is irrelevant here.',
    ],
  ),
  QuestionData(
    question:
        '- He said the new plan was impossible to complete in such a short time.\n\nWhat does "impossible" mean?',
    options: [
      "A) Something that can be done",
      "B) Something that cannot be done",
      "C) Something easy",
      "D) Something expected",
    ],
    correctIndex: 1,
    explanation:
        ' "Impossible" means something that cannot be done or achieved, as the prefix “im-” negates the root word.',
    incorrectExplanations: [
      'Incorrect answer!',
      ' "Possible" means it can be done, the opposite.',
      ' "Easy" is about difficulty, not possibility.',
      ' "Expected" refers to anticipation, not feasibility.',
    ],
  ),
  QuestionData(
    question:
        '- After the accident, she felt completely helpless.\n\nWhat does the suffix “-less” mean in this sentence?',
    options: [
      "A) Without",
      "B) Again ",
      "C) Before",
      "D) After",
    ],
    correctIndex: 0,
    explanation:
        'The suffix “-less” in the word "helpless" means without help.',
    incorrectExplanations: [
      'Incorrect answer!',
      ' "Helper" is a noun but does not contain the suffix "–ness."',
      ' "Helped" is a verb form, not a noun.',
      ' "Helpless" is still an adjective, not a noun.',
    ],
  ),
  QuestionData(
    question:
        '- His opinion was based on a misconception about the project.\n\nWhat is the meaning of "misconception"?',
    options: [
      "A) A correct belief",
      "B) A mistaken belief",
      "C) A proven theory",
      "D) A clear understanding",
    ],
    correctIndex: 1,
    explanation:
        ' "Misconception" refers to a belief or idea that is incorrect or misunderstood.',
    incorrectExplanations: [
      'Incorrect answer!',
      ' "Correct belief" is the opposite of misconception.',
      ' "Proven theory" implies accuracy, not error.',
      ' "Clear understanding" suggests full and correct knowledge.',
    ],
  ),
  QuestionData(
    question:
        '- The team was working late into the night.\n- They finally completed the task by morning.\n\nWhat does "they" refer to?',
    options: ["A) The task", "B) The team", "C) The night", "D) The morning"],
    correctIndex: 1,
    explanation:
        ' "They" refers to the team, who completed the task.',
    incorrectExplanations: [
      'Incorrect answer!',
      ' The task was completed, not the subject performing the action.',
      ' The night is a time reference, not a person or group.',
      ' The morning marks when it was finished, not who did it.',
    ],
  ),
  QuestionData(
    question:
        '- Sarah went to the bakery and bought a loaf of bread.\n- She was looking forward to making sandwiches for lunch.\n\nWhat does "she" refer to?',
    options: ["A) The bakery", "B) The bread", "C) Sarah", "D) The sandwiches"],
    correctIndex: 2,
    explanation:
        ' "She" refers to Sarah, who went to the bakery and bought the bread.',
    incorrectExplanations: [
      'Incorrect answer!',
      ' The bakery is a place, not a person.',
      ' Bread doesn’t perform actions like looking forward to lunch.',
      ' The sandwiches are the goal of the action, not the subject.',
    ],
  ),
  QuestionData(
    question:
        '- Emma found a beautiful book at the library.\n- She borrowed it to read during her vacation.\n\nWhat does "it" refer to?',
    options: ["A) The book", "B) The library", "C) Emma", "D) The vacation"],
    correctIndex: 0,
    explanation:
        ' "It" refers to the book Emma found at the library.',
    incorrectExplanations: [
      'Incorrect answer!',
      ' The library is a location, not what was borrowed.',
      ' Emma is the person who did the borrowing.',
      ' The vacation is when she read it, not what she borrowed.',
    ],
  ),
  QuestionData(
    question:
        '- The storm caused significant damage to the buildings.\n- The destruction was worse than anticipated.\n\nWhat does "destruction" refer to?',
    options: ["A) Construction", "B) Storm", "C) Buildings", "D) Damage"],
    correctIndex: 3,
    explanation:
        ' "Destruction" is a synonym for "damage," indicating harm or ruin.',
    incorrectExplanations: [
      'Incorrect answer!',
      ' "Construction" is the opposite of destruction.',
      ' The storm caused the destruction, it is not what was destroyed.',
      ' The buildings were affected, but "destruction" names the damage.',
    ],
  ),
  QuestionData(
    question:
        '- The director gave the actors detailed instructions before the performance.\n- The guidelines were clear and concise.\n\nWhat does "guidelines" refer to?',
    options: ["A) Rules", "B) Freedom", "C) Suggestions", "D) Restrictions"],
    correctIndex: 0,
    explanation:
        ' "Guidelines" is a synonym for "rules," indicating directions or instructions to follow.',
    incorrectExplanations: [
      'Incorrect answer!',
      ' "Freedom" implies a lack of rules or restrictions.',
      ' "Suggestions" are optional, but guidelines imply required structure.',
      ' "Restrictions" are limits, but guidelines are broader instructions.',
    ],
  ),
];

class TestIntroBlue extends StatefulWidget {
  const TestIntroBlue({super.key});

  @override
  State<TestIntroBlue> createState() => _TestIntroBlueState();
}

class _TestIntroBlueState extends State<TestIntroBlue>
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

    _fadeIn = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0A1E33), // azul profundo
              Color(0xFF0E3A5D),
              Color(0xFF1C6FB8),
              Color(0xFF4FC3F7), // azul claro
              Color(0xFFB3E5FC), // cielo suave
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeIn,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 💎 Icono
                Icon(
                  Icons.auto_graph_rounded,
                  size: 90,
                  color: Colors.lightBlueAccent.shade100,
                ),

                const SizedBox(height: 30),

                // 🏆 Título
                Text(
                  "Final Test 💙",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 20),

                // 📘 Texto principal
                Text(
                  "You've made it to the final test! Time to flex those lexical and referential skills and finish strong! 🏆↗️✨",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    height: 1.5,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 60),

                // 🚀 Botón
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.lightBlueAccent.shade200,
                        Colors.blueAccent.shade400,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.35),
                        blurRadius: 12,
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
                              FinalTest(questions: FinalTestSecond),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: const Icon(
                      Icons.play_arrow_rounded,
                      size: 26,
                      color: Colors.white,
                    ),
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

