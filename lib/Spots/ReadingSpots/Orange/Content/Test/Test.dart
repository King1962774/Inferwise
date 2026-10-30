import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Orange/Content/Test/Final_Test.dart';

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
  QuestionData(
    question:
        'The car pulled up to the curb, and a family with two suitcases got out. A man came out of the house and greeted them with a hug.\n\nWhat is the likely relationship between the man and the family?',
    options: [
      "A) He is their boss.",
      "B) He is their taxi driver.",
      "C) He is their friend or relative.",
      "D) He is their landlord."
    ],
    correctIndex: 2,
    explanation:
        'The action of greeting with a hug suggests a close social or family relationship.',
    incorrectExplanations: [
      'Incorrect. A boss is unlikely to greet with a hug.',
      'Incorrect. Taxi drivers do not usually hug passengers.',
      'Correct answer!',
      'Incorrect. A landlord is unlikely to greet tenants this way.',
    ],
  ),
  QuestionData(
    question:
        'The woman opened a book and began to read to the children sitting on the rug around her.\n\nWhat is the woman’s likely role?',
    options: [
      "A) A librarian or a teacher.",
      "B) A child in the group.",
      "C) An unknown stranger.",
      "D) The children’s friend."
    ],
    correctIndex: 0,
    explanation:
        'Reading a book to a group of children suggests a role as an educator or caregiver, such as a librarian or teacher.',
    incorrectExplanations: [
      'Correct answer!',
      'Incorrect. Children typically do not read to groups.',
      'Incorrect. An unknown stranger is unlikely.',
      'Incorrect. Friends do not usually take on this role.',
    ],
  ),
  QuestionData(
    question:
        'The students took out a small blue book and began to write down the numbers the teacher was saying.\n\nWhat is the most likely purpose of the small blue book?',
    options: [
      "A) It is a fun storybook.",
      "B) It is a notebook.",
      "C) It is a recipe book.",
      "D) It is an empty container."
    ],
    correctIndex: 1,
    explanation:
        'Writing numbers dictated by a teacher indicates that the object is a notebook for taking notes.',
    incorrectExplanations: [
      'Incorrect. Storybooks are rarely used for note-taking.',
      'Correct answer!',
      'Incorrect. Recipe books are not typically used in this setting.',
      'Incorrect. It needs to contain paper for notes.',
    ],
  ),
  QuestionData(
    question:
        'The boy was shivering as he waited for the bus to arrive.\n\nWhat time of year is it most likely?',
    options: [
      "A) It is probably summer.",
      "B) It is probably a rainy season.",
      "C) It is probably winter.",
      "D) It is probably spring."
    ],
    correctIndex: 2,
    explanation:
        'The boy’s shivering suggests a cold environment, which is most likely in winter.',
    incorrectExplanations: [
      'Incorrect. Summer is unlikely to be cold.',
      'Incorrect. Rainy season does not imply cold.',
      'Correct answer!',
      'Incorrect. Spring is not typically this cold.',
    ],
  ),
  QuestionData(
    question:
        'He used a long, thin rod to roast the marshmallow until it was golden brown.\n\nWhat was he most likely doing?',
    options: [
      "A) Fishing.",
      "B) Toasting a marshmallow over a fire.",
      "C) Cleaning a chimney.",
      "D) Building a fence."
    ],
    correctIndex: 1,
    explanation:
        'Using a "long, thin rod" to "roast" a "marshmallow" until it is "golden brown" is a clear description of toasting a marshmallow over a campfire.',
    incorrectExplanations: [
      'Incorrect. Fishing is not described here.',
      'Correct answer!',
      'Incorrect. Chimney cleaning is unrelated.',
      'Incorrect. Fence building is not relevant.',
    ],
  ),
  QuestionData(
    question:
        'The lights came on, the music began, and the audience hushed.\n\nWhere is the most likely setting?',
    options: [
      "A) A library.",
      "B) A movie theater.",
      "C) A concert or play.",
      "D) A cafeteria."
    ],
    correctIndex: 2,
    explanation:
        '🏆 Explanation: The combination of lights, music, and a hushed audience are all common occurrences at the beginning of a public performance, such as a concert or a play.',
    incorrectExplanations: [
      'Incorrect. Libraries are typically quiet but do not have music or lights in this context.',
      'Incorrect. Movie theaters do have lights and music, but the term "audience hushed" is more commonly associated with live performances.',
      'correct answer.',
      'Incorrect. Cafeterias do not typically involve music and hushed audiences.',
    ],
  ),
  QuestionData(
    question:
        'He put on his apron and gloves and began to wash the dishes in the sink.\n\nWho is the person performing the action?',
    options: [
      "A) A professional chef.",
      "B) A dishwasher.",
      "C) A housekeeper.",
      "D) The homeowner."
    ],
    correctIndex: 1,
    explanation:
        '🏆 Explanation: The individual putting on an apron and gloves specifically to wash dishes is performing the role of a dishwasher.',
    incorrectExplanations: [
      'Incorrect. Professional chefs may wear aprons, but in this scenario, the primary action is washing dishes, not cooking.',
      'correct answer.',
      'Incorrect. Housekeepers may wash dishes, but the context here points more specifically to someone whose main job is dishwashing.',
      'Incorrect. Homeowners may wash dishes, but the context of putting on apron and gloves suggests a specific role, like a dishwasher.',
    ],
  ),
  QuestionData(
    question:
        'The family pulled out a picnic basket and a large checkered blanket in a field surrounded by wildflowers.\n\nWhat is the most likely location?',
    options: [
      "A) At a beach.",
      "B) In their backyard.",
      "C) In a busy street.",
      "D) At a park or meadow."
    ],
    correctIndex: 3,
    explanation:
        '🏆 Explanation: The scene described—a field with wildflowers, a picnic basket, and a blanket—is most consistent with a park or a meadow.',
    incorrectExplanations: [
      'Incorrect. A beach does not typically have wildflowers and fields.',
      'Incorrect. Backyards are less likely to have large fields surrounded by wildflowers.',
      'Incorrect. Busy streets are not places where picnics or wildflowers are found.',
      'correct answer.',
    ],
  ),
  QuestionData(
    question:
        'The little girl put on her bathing suit and ran outside to the back yard.\n\nWhat time of year is it most likely?',
    options: ["A) Autumn.", "B) Winter.", "C) Spring.", "D) Summer."],
    correctIndex: 3,
    explanation:
        '🏆 Explanation: A bathing suit is worn for swimming, which is an activity most commonly done in the summer when the weather is warm.',
    incorrectExplanations: [
      'Incorrect. Autumn is unlikely for swimming outdoors due to colder weather.',
      'Incorrect. Winter is typically too cold for outdoor swimming.',
      'Incorrect. Spring can be warm but summer is the most common season for bathing suits outside.',
      'correct answer.',
    ],
  ),
  QuestionData(
    question:
        'The doctor entered the room and the patient immediately sat up on the hospital bed.\n\nWhat is the setting of this scene?',
    options: [
      "A) A school.",
      "B) A clinic or hospital.",
      "C) An airport.",
      "D) A restaurant."
    ],
    correctIndex: 1,
    explanation:
        '🏆 Explanation: The presence of a doctor, a patient, and a hospital bed strongly indicates that the scene is taking place in a hospital or clinic.',
    incorrectExplanations: [
      'Incorrect. Schools do not typically have doctors or hospital beds.',
      'correct answer.',
      'Incorrect. Airports are not settings for doctors and hospital beds.',
      'Incorrect. Restaurants do not have hospital beds or doctors seeing patients.',
    ],
  ),
  QuestionData(
    question:
        'Kevin dropped the glass on the floor.\n- It shattered instantly.\n\nWhat does "it" refer to?',
    options: ["A) The glass.", "B) The floor.", "C) Kevin.", "D) The sound."],
    correctIndex: 0,
    explanation:
        '"It" clearly refers to the glass, which shattered after falling.',
    incorrectExplanations: [
      'correct answer.',
      'Incorrect. "It" does not refer to the floor, which did not shatter.',
      'Incorrect. "It" does not refer to Kevin.',
      'Incorrect. "It" refers to the object that shattered, which is the glass.',
    ],
  ),
  QuestionData(
    question:
        'Natalie baked cookies for her classmates.\n- They were thrilled with them.\n\nWhat does "them" refer to?',
    options: [
      "A) The classmates.",
      "B) The ingredients.",
      "C) The cookies.",
      "D) The oven."
    ],
    correctIndex: 2,
    explanation:
        '"Them" refers to the cookies, which made the classmates thrilled.',
    incorrectExplanations: [
      'Incorrect. "Them" does not refer to the classmates.',
      'Incorrect. "Them" does not refer to ingredients.',
      'correct answer.',
      'Incorrect. "Them" does not refer to the oven.',
    ],
  ),
  QuestionData(
    question:
        'The movie was so moving; I couldn\'t stop crying.\n\nWhat does "moving" mean in this context?',
    options: [
      "A) Something that is physically moving.",
      "B) Causing strong emotions.",
      "C) Moving from one place to another.",
      "D) A type of dance."
    ],
    correctIndex: 1,
    explanation:
        '"Moving" here refers to something that touches your emotions deeply, not physically moving.',
    incorrectExplanations: [
      'Incorrect. It’s not about physical movement.',
      'correct answer.',
      'Incorrect. The context is not about changing locations.',
      'Incorrect. "Moving" does not refer to a type of dance in this context.',
    ],
  ),
  QuestionData(
    question:
        '- After the accident, she felt completely helpless.\n\nWhat does the suffix “-less” mean in this sentence?',
    options: [
      "A) Without",
      "B) Again ",
      "C) Before",
      "D) After"
    ],
    correctIndex: 0,
    explanation:
        'The suffix "-less" means "without." In "helpless," it means "without help."',
    incorrectExplanations: [
      'correct answer.',
      'Incorrect. "-less" does not mean "again."',
      'Incorrect. "-less" does not mean "before."',
      'Incorrect. "-less" does not mean "after."',
    ],
  ),
  QuestionData(
    question:
        'After struggling to stay focused during online classes, Tasha rearranged her room to create a quiet study corner. She removed distractions, set up better lighting, and created a daily routine. Over time, her grades began to improve.\n\nWhy did Tasha rearrange her room and set a routine?',
    options: [
      "A) She wanted to try a new decorating style for her bedroom.",
      "B) She was bored with her old look.",
      "C) She needed more space for furniture and clothes.",
      "D) She wanted to improve her academic performance."
    ],
    correctIndex: 3,
    explanation:
        'Tasha made purposeful changes to her environment with the goal of focusing better and achieving academic success.',
    incorrectExplanations: [
      'Incorrect. The reason was about improving her focus, not style.',
      'Incorrect. The goal was not about boredom but about school success.',
      'Incorrect. There’s no mention of needing more space for furniture or clothing.',
      'correct answer.',
    ],
  ),
  QuestionData(
    question:
        'David used to forget to bring his gym clothes every Thursday. After missing three classes in a row, he began setting a reminder on his phone and packing his bag the night before. He hasn\'t missed a class since.\nWhy did David change his routine?',
    options: [
      "A) He wanted to buy new clothes",
      "B) He needed to leave his house earlier",
      "C) He liked packing early",
      "D) He wanted to avoid missing gym class again"
    ],
    correctIndex: 3,
    explanation:
        "🏆 Explanation: David’s new habit was a direct response to repeatedly forgetting something important, driven by a goal to stay consistent.",
    incorrectExplanations: [
      'Incorrect. The change was not for buying new clothes.',
      'Incorrect. The routine change was not due to his schedule.',
      'Incorrect. The main reason was not enjoying packing early.',
      'correct answer.',
    ],
  )
];

class TestIntro4 extends StatefulWidget {
  const TestIntro4({super.key});

  @override
  State<TestIntro4> createState() => _TestIntro4State();
}

class _TestIntro4State extends State<TestIntro4>
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
              Color.fromARGB(255, 255, 180, 75), // Naranja brillante
              Color.fromARGB(255, 255, 160, 50), // Naranja intenso
              Color.fromARGB(255, 255, 140, 40), // Naranja medio
              Color.fromARGB(255, 245, 120, 35), // Naranja quemado
              Color.fromARGB(255, 230, 100, 30), // Naranja oscuro
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
                  FontAwesomeIcons.rocket,
                  size: 90,
                  color: Colors.amber.shade300,
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
                  "You're at the final challenge! Let’s put those lexical, referential, explanatory, and elaborative skills to the ultimate test — finish with power and pride! 💡📚",
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
                        Colors.amber.shade400,
                        Colors.deepOrange.shade300,
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
