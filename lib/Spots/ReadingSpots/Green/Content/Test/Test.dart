import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Green/Content/Test/Final_Test.dart';

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
        '- Kevin dropped the glass on the floor. \n- It shattered instantly.\n\n What does "it" refer to?',
    options: [
      "A) The glass",
      "B) The floor",
      "C) Kevin",
      "D) The sound",
    ],
    correctIndex: 0,
    explanation:
        ' "It" clearly refers to the glass, which shattered after falling.',
    incorrectExplanations: [
      '✅ Correct answer!',
      ' The floor did not shatter; it was the surface where the glass fell.',
      ' Kevin didn’t shatter; he dropped the glass.',
      ' The sound is a result, not what "it" refers to.',
    ],
  ),
  QuestionData(
    question: ' - Emma told Lucy a funny story. \n- She laughed so hard she cried. \n\n Who laughed so hard she cried?',
    options: [
      "A) Emma",
      "B) Lucy",
      "C) Both",
      "D) It’s unclear",
    ],
    correctIndex: 1,
    explanation:
        ' Since Lucy was the listener, it’s most likely she laughed at the story.',
    incorrectExplanations: [
      ' Emma told the story, but the laughter is attributed to the listener.',
      '✅ Correct answer!',
      ' The sentence does not imply both laughed.',
      ' The pronoun "she" has a likely referent: Lucy.',
    ],
  ),
  QuestionData(
    question:
        '- The ball hit the window and cracked it. \n- Then it fell to the ground. \n\n What does "it" refer to in the second sentence?',
    options: [
      "A) The ball",
      "B) The window",
      "C) The ground",
      "D) The crack",
    ],
    correctIndex: 0,
    explanation:
        ' The ball hit the window and then fell, so "it" refers to the ball.',
    incorrectExplanations: [
      '✅ Correct answer!',
      ' The window did not fall.',
      ' The ground is the destination, not the subject.',
      ' The crack is a result, not what fell.',
    ],
  ),
  QuestionData(
    question: '- Natalie baked cookies for her classmates. \n- They were thrilled with them. \n\n What does "them" refer to?',
    options: [
      "A) The classmates",
      "B) The ingredients",
      "C) The cookies",
      "D) The oven",
    ],
    correctIndex: 2,
    explanation:
        ' "Them" refers to the cookies, which made the classmates thrilled.',
    incorrectExplanations: [
      ' The classmates are the ones who felt thrilled, not the object referred to.',
      ' The ingredients are part of the cookies, but not what "them" refers to.',
      '✅ Correct answer!',
      ' The oven is not what thrilled the classmates.',
    ],
  ),
  QuestionData(
    question: '- The painting hung in the museum for years. \n- People admired it every day. \n\n What does "it" refer to?',
    options: [
      "A) The museum",
      "B) The painting",
      "C) The wall",
      "D) The time",
    ],
    correctIndex: 1,
    explanation: ' "It" refers to the painting being admired.',
    incorrectExplanations: [
      ' The museum is a place, not what was admired.',
      '✅ Correct answer!',
      ' The wall is irrelevant to what’s being admired.',
      ' The time is not an object of admiration.',
    ],
  ),
  QuestionData(
    question: '- Olivia met with Ava after her meeting.\n - She seemed distracted the whole time. \n\n Who seemed distracted?',
    options: [
      "A) Olivia",
      "B) Ava",
      "C) Both",
      "D) It’s unclear",
    ],
    correctIndex: 3,
    explanation:
        ' "She" could refer to either person, and the sentence doesn’t specify.',
    incorrectExplanations: [
      ' The sentence doesn’t clearly indicate Olivia.',
      ' Ava is a possible referent, but not certain.',
      ' Both are not confirmed to be distracted.',
      '✅ Correct answer!',
    ],
  ),
  QuestionData(
    question: '- The box didn’t fit through the door because it was too narrow. \n\n What was too narrow?',
    options: [
      "A) The door",
      "B) The box",
      "C) The hallway",
      "D) It’s unclear",
    ],
    correctIndex: 0,
    explanation:
        ' The door was too narrow, which is why the box didn’t fit.',
    incorrectExplanations: [
      '✅ Correct answer!',
      ' The box tried to go through but wasn’t the narrow one.',
      ' The hallway isn’t mentioned as narrow.',
      ' The sentence clearly implies the door was too narrow.',
    ],
  ),
  QuestionData(
    question: '- Sam promised Alex to clean the kitchen before dinner. \n- He didn’t do it. \n\n Who didn’t clean the kitchen?',
    options: [
      "A) Sam",
      "B) Alex",
      "C) Both",
      "D) It’s unclear",
    ],
    correctIndex: 0,
    explanation:
        ' "He" refers to Sam (the promiser).',
    incorrectExplanations: [
      '✅ Correct answer!',
      ' It’s not certain Alex was supposed to do it.',
      ' "Both" is incorrect because only one didn’t do it.',
      ' The context leans toward Sam being the one who didn’t clean.',
    ],
  ),
  QuestionData(
    question: '- Jessica texted Chloe while she was driving. \n- This worried her mother. \n\n Who was driving?',
    options: [
      "A) Jessica",
      "B) Chloe",
      "C) Her mother",
      "D) It’s unclear",
    ],
    correctIndex: 0,
    explanation:
        ' Likely Jessica was texting while driving, which worried her mother—though ambiguity exists.',
    incorrectExplanations: [
      '✅ Correct answer!',
      ' Chloe is only mentioned as the one receiving the text.',
      ' The mother isn’t described as driving.',
      ' The context suggests Jessica, despite some ambiguity.',
    ],
  ),
  QuestionData(
    question: '- The children painted the fence and then washed their hands. \n- They were covered in red and blue. \n\n What does "they" refer to?',
    options: [
      "A) The children",
      "B) The hands",
      "C) The fence",
      "D) The paint",
    ],
    correctIndex: 1,
    explanation:
        ' "They" refers to the children’s hands, which were covered in red and blue paint.',
    incorrectExplanations: [
      ' The children aren’t what were covered in paint.',
      '✅ Correct answer!',
      ' The fence was painted, not covered in paint.',
      ' The paint is the substance, not the referent of "they".',
    ],
  ),
  QuestionData(
    question: '- Max helped Leo carry his backpack.\n - It was heavy and full of books. \n\n What does "it" refer to?',
    options: [
      "A) Max",
      "B) The backpack",
      "C) Leo",
      "D) The help",
    ],
    correctIndex: 1,
    explanation:
        ' "It" refers to the backpack, which was heavy and full of books.',
    incorrectExplanations: [
      ' Max is the subject, not the object referred to as "it".',
      '✅ Correct answer!',
      ' Leo is not the item being described.',
      ' "Help" is not a concrete object in this sentence.',
    ],
  ),
  QuestionData(
    question: '- Anna took her dog to the vet because she was worried. \n\n Who was worried?',
    options: [
      "A) Anna",
      "B) The dog",
      "C) The vet",
      "D) It’s unclear",
    ],
    correctIndex: 0,
    explanation:
        ' "She" most likely refers to Anna, who was worried enough to take the dog to the vet.',
    incorrectExplanations: [
      '✅ Correct answer!',
      ' The dog being worried isn’t implied clearly.',
      ' The vet is not part of the worry context.',
      ' The sentence provides enough context to infer Anna was worried.',
    ],
  ),
  QuestionData(
    question: '- The lawyer met with the client before court. \n- He reviewed the documents carefully. \n\n Who reviewed the documents?',
    options: [
      "A) Both",
      "B) The client",
      "C) The lawyer",
      "D) It’s unclear",
    ],
    correctIndex: 2,
    explanation:
        ' Contextually, it’s more plausible that the lawyer reviewed the documents before court.',
    incorrectExplanations: [
      ' "Both" isn’t supported clearly by the context.',
      ' It’s unlikely the client did the review.',
      '✅ Correct answer!',
      ' The sentence leans toward the lawyer doing the review.',
    ],
  ),
  QuestionData(
    question: '- Emily sent photos to Rachel while she was on vacation.\n- They made her smile. \n\n Who was on vacation?',
    options: [
      "A) Emily",
      "B) Rachel",
      "C) It’s unclear",
      "D) Both",
    ],
    correctIndex: 0,
    explanation:
        ' "She" refers to Emily (sending while away).',
    incorrectExplanations: [
      '✅ Correct answer!',
      ' Rachel may be the one receiving while on vacation—still unclear.',
      ' The context suggests Emily was on vacation, making it less likely to be unclear.',
      ' "Both" is speculative without clear evidence.',
    ],
  ),
  QuestionData(
    question: '- After the interview, Jordan thanked Casey for her time. \n- She appreciated the gesture. \n\nWhat does "the gesture" refer to?',
    options: [
      "A) The interview",
      "B) The time spent talking",
      "C) Jordan thanking Casey",
      "D) The opportunity",
    ],
    correctIndex: 2,
    explanation:
        ' "The gesture" refers to Jordan’s act of thanking Casey, which was appreciated.',
    incorrectExplanations: [
      ' The interview itself isn’t the gesture.',
      ' The time talking isn’t framed as a gesture.',
      '✅ Correct answer!',
      ' "The opportunity" is unrelated to the act being appreciated.',
    ],
  ),
];


class TestIntroGreen extends StatefulWidget {
  const TestIntroGreen({super.key});

  @override
  State<TestIntroGreen> createState() => _TestIntroGreenState();
}

class _TestIntroGreenState extends State<TestIntroGreen>
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
              Color(0xFF0B3D2E), // verde oscuro profundo
              Color(0xFF0F5E46),
              Color(0xFF1E8E5A),
              Color(0xFF3CB371), // verde medio
              Color(0xFF9BE7C4), // verde claro suave
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
                // 🌿 Icono principal
                Icon(
                  Icons.emoji_events_rounded,
                  size: 92,
                  color: Colors.greenAccent.shade200,
                ),

                const SizedBox(height: 30),

                // 🏆 Título
                Text(
                  "Final Test 🌱",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 20),

                // 📘 Descripción
                Text(
                  "You've made it to the final test! Show everything you've learned and finish strong. Growth comes from effort — this is your moment! 🌟📚",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    height: 1.5,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 60),

                // 🚀 Botón animado
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.greenAccent.shade400,
                        Colors.teal.shade400,
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
                              FinalTest(questions: FinalTestfirst),
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
