import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Dark Blue/Content/Test/FinalTest.dart';

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
List<QuestionData> FinalTestThird = [
QuestionData(
  question:
      'Maria had been preparing for her art school interview for weeks. Every evening after work, she would lock herself in her studio to refine her portfolio. Even when she was tired, she stayed up late adding final touches to her sketches.\n\nWhy did Maria spend so much time on her portfolio?',
  options: [
    "A) She wanted to avoid chores",
    "B) She was paid for each sketch",
    "C) She hoped to impress the art school panel",
    "D) She wanted to post them online"
  ],
  correctIndex: 2,
  explanation:
      ' Maria’s consistent effort and late-night dedication suggest she had a clear goal: impressing the interview panel at the art school.',
  incorrectExplanations: [
    ' Avoiding chores doesn’t align with the context of preparation and artistic effort.',
    ' There’s no mention of payment being involved.',
    '✅ Correct answer!',
    ' Posting online is unrelated to preparing for an interview.'
  ],
),
QuestionData(
  question:
      'After struggling to stay focused during online classes, Tasha rearranged her room to create a quiet study corner. She removed distractions, set up better lighting, and created a daily routine. Over time, her grades began to improve.\n\nWhy did Tasha rearrange her room and set a routine?',
  options: [
    "A) She wanted to try a new decorating style for her bedroom",
    "B) She was bored with her old room",
    "C) She needed more space for furniture and clothes",
    "D) She wanted to improve her academic performance"
  ],
  correctIndex: 3,
  explanation:
      ' Tasha made purposeful changes to her environment with the goal of focusing better and achieving academic success.',
  incorrectExplanations: [
    ' The goal was academic improvement, not decorating.',
    ' Boredom is not supported by the text.',
    ' Space wasn’t mentioned as a need.',
    '✅ Correct answer!',
  ],
),
QuestionData(
  question:
      'Lena knew her best friend had been having a tough week. Even though she had plans to relax at home, Lena decided to surprise her friend with a visit, bringing snacks and a movie to cheer her up.\n\nWhat motivated Lena to visit her friend?',
  options: [
    "A) She didn’t want to be alone",
    "B) She was bored at home",
    "C) She wanted to support her friend",
    "D) She had to return something to her friend"
  ],
  correctIndex: 2,
  explanation:
      ' Lena’s decision to visit was a compassionate, intentional response aimed at making her friend feel better.',
  incorrectExplanations: [
    ' Lena’s motivation was not about being alone.',
    ' There is no mention of boredom as her reason.',
    '✅ Correct answer!',
    ' Returning something wasn’t her purpose.',
  ],
),
QuestionData(
  question:
      'The old bridge had been making strange creaking noises for weeks. Concerned about safety, the town council decided to close it for repairs, even though it was the main route into town.\n\nWhy did the town council close the bridge?',
  options: [
    "A) To ensure public safety",
    "B) To paint it a new color",
    "C) To build a new shopping center",
    "D) To slow down traffic"
  ],
  correctIndex: 0,
  explanation:
      'The council chose safety over convenience, showing cause (creaking sounds) and effect (closing the bridge).',
  incorrectExplanations: [
    '✅ Correct answer!',
    ' Painting was not the reason given.',
    ' There’s no mention of any construction projects.',
    ' Traffic control wasn’t a factor in this decision.'
  ],
),
QuestionData(
  question:
      'David used to forget to bring his gym clothes every Thursday. After missing three classes in a row, he began setting a reminder on his phone and packing his bag the night before. He hasn’t missed a class since.\n\nWhy did David change his routine?',
  options: [
    "A) He wanted to buy new clothes",
    "B) He needed to leave his house earlier",
    "C) He liked packing early",
    "D) He wanted to avoid missing gym class again"
  ],
  correctIndex: 3,
  explanation:
      ' David’s new habit was a direct response to repeatedly forgetting something important, driven by a goal to stay consistent.',
  incorrectExplanations: [
    ' Buying clothes isn’t mentioned or related to the cause.',
    ' Leaving earlier isn’t supported in the text.',
    ' There’s no indication he liked packing early.',
    '✅ Correct answer!'
  ],
),
QuestionData(
  question:
      'After her bike was stolen outside the café, Sonia started locking it to a metal rack every time she went somewhere. She also bought a stronger lock and kept it with her bag.\n\nWhat caused Sonia to change her behavior?',
  options: [
    "A) She got a new bike",
    "B) Her friend advised her to",
    "C) She didn’t trust the weather",
    "D) Her previous experience with theft"
  ],
  correctIndex: 3,
  explanation:
      ' Having her bike stolen led Sonia to take precautions. Her actions are a clear effect of a past negative experience.',
  incorrectExplanations: [
    ' There’s no mention of her getting a new bike.',
    ' Advice from friends isn’t mentioned.',
    ' Weather is unrelated.',
    '✅ Correct answer!'
  ],
),
QuestionData(
  question:
      'Every day, Kai helped clean up the park after school, picking up trash others left behind. He believed that if everyone contributed a little, their neighborhood could become a more beautiful and welcoming place.\n\nWhat motivated Kai to clean the park regularly?',
  options: [
    "A) He was paid to do it",
    "B) He didn’t have homework",
    "C) He wanted his neighborhood to be cleaner",
    "D) He was waiting for his friends at the park"
  ],
  correctIndex: 2,
  explanation:
      ' Kai’s belief in shared responsibility and his vision for a better environment drove his consistent effort.',
  incorrectExplanations: [
    ' No payment is mentioned.',
    ' Homework isn’t discussed.',
    '✅ Correct answer!',
    ' Waiting for friends doesn’t align with the narrative.'
  ],
),
QuestionData(
  question:
      'The bakery’s sales had been low during the winter, so the owner started offering free samples and posting photos of new items on social media. Within weeks, more customers began coming in.\n\nWhy did the owner offer samples and post online?',
  options: [
    "A) To use up extra ingredients",
    "B) To practice photography",
    "C) To hire new employees",
    "D) To attract more customers"
  ],
  correctIndex: 3,
  explanation:
      " The owner's actions were clearly aimed at increasing sales, making them purposeful and goal-driven.",
  incorrectExplanations: [
    ' No mention of ingredient surplus.',
    ' Photography isn’t part of the motivation.',
    ' Hiring isn’t the focus.',
    '✅ Correct answer!'
  ],
),
QuestionData(
  question:
      'Despite never having run long distances before, Arjun signed up for a half marathon. He created a training schedule, followed a strict diet, and stayed committed for months. On race day, he completed the run proudly.\n\nWhy did Arjun follow a strict training routine?',
  options: [
    "A) He was preparing to finish the half marathon",
    "B) He wanted to lose weight for the marathon",
    "C) He was training for a sprint",
    "D) He needed a new hobby and started running"
  ],
  correctIndex: 0,
  explanation:
      ' Arjun’s disciplined preparation shows a clear connection between his goal (the race) and the cause (his training).',
  incorrectExplanations: [
    '✅ Correct answer!',
    ' Weight loss isn’t the stated goal.',
    ' A sprint is much shorter and unrelated to the described routine.',
    ' Starting a new hobby is too vague and doesn’t reflect his commitment.'
  ],
),
QuestionData(
  question:
      'Nina was nervous about speaking in front of her class, so she practiced every day in front of the mirror. She even recorded herself to improve her tone and pacing. When her turn came, she gave her speech with confidence.\n\nWhy did Nina practice her speech so thoroughly?',
  options: [
    "A) She had a lot of free time",
    "B) She wanted to overcome her fear",
    "C) She enjoyed hearing herself talk",
    "D) She was forced to participate"
  ],
  correctIndex: 1,
  explanation:
      ' Nina’s preparation stemmed from her desire to manage anxiety and succeed in a difficult situation.',
  incorrectExplanations: [
    ' Free time isn’t a motivating factor here.',
    '✅ Correct answer!',
    ' Enjoyment of her voice is not relevant.',
    ' There’s no indication she was forced.'
  ],
),


QuestionData(
  question:
      'The teacher explained the lesson clearly. She then gave the students a short quiz to assess their understanding.\n\nWhat does “she” refer to?',
  options: [
    "A) The students",
    "B) The teacher",
    "C) The lesson",
    "D) The quiz"
  ],
  correctIndex: 1,
  explanation:
      'She refers to the teacher, who was the subject in the first sentence.',
  incorrectExplanations: [
    ' The students are the ones assessed, not doing the action.',
    '✅ Correct answer!',
    ' The lesson is not a person.',
    ' The quiz is an object, not the subject performing an action.'
  ],
),
QuestionData(
  question:
      'Tommy found an old notebook in the attic. It had a collection of his grandfather’s poems.\n\nWhat does “it” refer to?',
  options: [
    "A) The attic",
    "B) His grandfather",
    "C) The poems",
    "D) The notebook"
  ],
  correctIndex: 3,
  explanation:
      ' It refers to the notebook that Tommy found, as it is the subject of the first sentence.',
  incorrectExplanations: [
    ' The attic is where the notebook was found.',
    ' His grandfather is not the subject.',
    ' The poems are inside the notebook, not the main subject.',
    '✅ Correct answer!'
  ],
),
QuestionData(
  question:
      'The rain poured down heavily throughout the afternoon, soaking the streets and creating large puddles. The water quickly drained away when the storm passed.\n\nWhat does “the water” refer to?',
  options: [
    "A) The rain",
    "B) The streets",
    "C) The storm",
    "D) The puddles"
  ],
  correctIndex: 3,
  explanation:
      ' The water refers to the water in the puddles that formed as a result of the rain.',
  incorrectExplanations: [
    ' Rain is what caused the water, not what is being referred to.',
    ' Streets do not represent “the water.”',
    ' The storm is the cause, not the object referred to.',
    '✅ Correct answer!'
  ],
),
QuestionData(
  question:
      'After the storm, the town was in disarray, with fallen trees and scattered debris everywhere.\n\nWhat does “disarray” most likely mean?',
  options: [
    "A) In a state of disorder or mess",
    "B) Full of joy, pleasure and calmness",
    "C) Neatly arranged",
    "D) Covered in snow and thick ice"
  ],
  correctIndex: 0,
  explanation:
      ' The description of fallen trees and debris shows the town was disorganized and messy—disarray.',
  incorrectExplanations: [
    '✅ Correct answer!',
    ' The sentence doesn’t describe happiness or calmness.',
    ' “Neatly arranged” is the opposite of disarray.',
    ' Snow/ice are not mentioned.'
  ],
),
QuestionData(
  question:
      'The invention was previewed at the science fair, giving the audience a look before it was finished.\n\nWhat does “previewed” most likely mean?',
  options: [
    "A) Watched again",
    "B) Shown after",
    "C) Seen ahead of time",
    "D) Rejected completely"
  ],
  correctIndex: 2,
  explanation:
      ' The prefix pre- means “before” and view means “see”—so previewed means seen in advance.',
  incorrectExplanations: [
    ' “Watched again” would be “reviewed,” not previewed.',
    ' “Shown after” contradicts “before it was finished.”',
    '✅ Correct answer!',
    ' There is no mention of rejection.'
  ],
),
QuestionData(
  question:
      'The volcano erupted suddenly, sending lava down the mountain.\n\nWhat does “volcano” most likely mean, based on its similarity to other languages?',
  options: [
    "A) A tall tree",
    "B) A mountain that explodes",
    "C) A desert rock",
    "D) A frozen lake"
  ],
  correctIndex: 1,
  explanation:
      ' Volcano is a word used in many languages (e.g., volcán in Spanish) that refers to a mountain that erupts with lava and gas.',
  incorrectExplanations: [
    ' A tall tree doesn’t relate to eruptions.',
    '✅ Correct answer!',
    ' Desert rock is unrelated.',
    ' Frozen lakes don’t erupt.'
  ],
),


];

class TestIntroDarkBlue extends StatefulWidget {
  const TestIntroDarkBlue({super.key});

  @override
  State<TestIntroDarkBlue> createState() => _TestIntroDarkBlueState();
}

class _TestIntroDarkBlueState extends State<TestIntroDarkBlue>
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
              Color(0xFF020A18), // casi negro azulado
              Color(0xFF041C32), // azul noche
              Color(0xFF0A3D62), // azul profundo
              Color(0xFF1B4F72), // azul acero
              Color(0xFF2E86C1), // azul vivo controlado
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
                // 🧠 Icono
                Icon(
                  Icons.lightbulb_rounded,
                  size: 92,
                  color: Colors.lightBlueAccent.shade100,
                ),

                const SizedBox(height: 30),

                // 🏁 Título
                Text(
                  "Final Challenge ",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 20),

                // 📚 Texto
                Text(
                  "You're at the final challenge! Let’s put those lexical, referential, and explanatory skills to the ultimate test — finish with power and pride! 💡📚🚀",
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
                        Color(0xFF5DADE2),
                        Color(0xFF2874A6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 14,
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
                              FinalTest(questions: FinalTestThird),
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
