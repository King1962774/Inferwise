import 'package:flutter/material.dart';
import 'Final-Test.dart';

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
final List<QuestionData> FinalTestfinal = [
  QuestionData(
    question:
        '- A teacher entered the room and greeted the students. They looked happy to see her.\n\n What does "They" refer to?',
    options: [
      "A) The teacher",
      "B) The room",
      "C) The students",
      "D) The greeting",
    ],
    correctIndex: 2,
    explanation:
        ' "They" refers to the students, who are plural and the ones reacting to the teacher.',
    incorrectExplanations: [
      ' Correct answer!',
      ' The room cannot look happy; it’s not a living thing.',
      ' Already the correct answer.',
      ' The greeting is not a group of people who could look happy.',
    ],
  ),
  QuestionData(
    question:
        '- Liam and Noah were playing chess. He made a bold move.\n\n What does "He" refer to?',
    options: [
      "A) Liam",
      "B) Noah",
      "C) It’s not clear",
      "D) The chess game",
    ],
    correctIndex: 2,
    explanation:
        ' Since both Liam and Noah are male, and we don’t have more context, "he" could refer to either. It’s ambiguous.',
    incorrectExplanations: [
      ' Liam could be correct, but there’s no evidence it’s him specifically.',
      ' Noah could be correct, but there’s no evidence it’s him specifically.',
      ' Correct answer!',
      ' The chess game is not a "he".',
    ],
  ),
  QuestionData(
    question:
        '- The children saw a bird in the tree. It was building a nest.\n\n What does "It" refer to?',
    options: [
      "A) The tree",
      "B) The bird",
      "C) The nest",
      "D) The children",
    ],
    correctIndex: 1,
    explanation:
        ' "It" refers to the bird, since the sentence says it was building a nest — something a bird would do.',
    incorrectExplanations: [
      ' The tree doesn’t build nests.',
      ' Correct answer!',
      ' The nest is what is being built, not what is building.',
      ' The children are not "it" and don’t build nests here.',
    ],
  ),
  QuestionData(
    question:
        '- The chef prepared a new recipe. The dish was spicy and flavorful.\n\n Choose what the highlighted word refers to.',
    options: [
      "A) A plate",
      "B) A utensil",
      "C) A recipe",
      "D) A kitchen",
    ],
    correctIndex: 2,
    explanation: ' "Dish" is a near-synonym of a prepared recipe.',
    incorrectExplanations: [
      ' A plate is the container, not the food itself.',
      ' A utensil is used to eat or cook, not what is spicy.',
      ' Correct answer!',
      ' A kitchen is where you cook, not what is flavorful.',
    ],
  ),
  QuestionData(
    question:
        '- Liam opened the gift. The present made him smile.\n\n Choose what the highlighted word refers to.',
    options: [
      "A) A speech",
      "B) A gift",
      "C) A birthday",
      "D) A moment",
    ],
    correctIndex: 1,
    explanation:
        ' "Present" means the same thing as "gift," so it refers to the object Liam opened.',
    incorrectExplanations: [
      ' A speech is not mentioned.',
      ' Correct answer!',
      ' A birthday is the event, not the object opened.',
      ' A moment is abstract and not what made Liam smile here.',
    ],
  ),
  QuestionData(
    question:
        '- The arid desert had no water, and the plants were all dry and brittle.\n\n Which part of the sentence helps you understand the word "arid"?',
    options: [
      "A) The desert",
      "B) No water",
      "C) Plants",
      "D) Brittle",
    ],
    correctIndex: 1,
    explanation: ' "No water" tells us that "arid" means dry.',
    incorrectExplanations: [
      ' The desert is the place, not the clue for the meaning.',
      ' Correct answer!',
      ' Plants don’t explain the meaning of "arid."',
      ' Brittle describes plants, not the definition of "arid."',
    ],
  ),
  QuestionData(
    question:
        '- The movie was hilarious, so funny that everyone in the theater laughed nonstop.\n\n Which part tells you what "hilarious" means?',
    options: [
      "A) So funny",
      "B) Everyone",
      "C) Theater",
      "D) Movie",
    ],
    correctIndex: 0,
    explanation: ' "So funny" is a synonym clue for "hilarious."',
    incorrectExplanations: [
      ' Correct answer!',
      ' "Everyone" refers to the people laughing, not the meaning.',
      ' "Theater" is just the place.',
      ' "Movie" is the subject, not the clue for the meaning.',
    ],
  ),
  QuestionData(
    question: '- Match the word: Childhood',
    options: [
      "A) The state of being old",
      "B) The time of being an adult",
      "C) The period of being a child",
      "D) The feeling of being young",
    ],
    correctIndex: 2,
    explanation:
        ' "Childhood" refers to the period in life when someone is a child.',
    incorrectExplanations: [
      ' The state of being old refers to old age.',
      ' The time of being an adult is adulthood.',
      ' Correct answer!',
      ' The feeling of being young is not the exact definition of "childhood."',
    ],
  ),
  QuestionData(
    question: '- Match the word: Unwrap',
    options: [
      "A) To wrap again",
      "B) To remove the wrapping",
      "C) To add more wrapping",
      "D) To gift wrap",
    ],
    correctIndex: 1,
    explanation:
        ' "Un-" means reverse action, so "unwrap" means to remove the wrapping.',
    incorrectExplanations: [
      ' To wrap again would be "re-wrap," not "unwrap."',
      ' Correct answer!',
      ' To add more wrapping means the opposite of "unwrap."',
      ' To gift wrap is to cover with wrapping, not to remove it.',
    ],
  ),
  QuestionData(
    question: '- Match the word: Éxito',
    options: [
      "A) Exit",
      "B) Existence",
      "C) Strategy",
      "D) Success",
    ],
    correctIndex: 3,
    explanation:
        ' "Éxito" in Spanish means "success," not "exit." It’s a common false cognate mix-up.',
    incorrectExplanations: [
      ' Exit looks similar but is a false cognate.',
      ' Existence is unrelated.',
      ' Strategy is a plan, not the meaning.',
      ' Correct answer!',
    ],
  ),
  QuestionData(
    question:
        '- Liam left his umbrella at home. Later, he came in soaking wet.\n\n What is the most likely cause of Liam being wet?',
    options: [
      "A) He went swimming",
      "B) He spilled water on himself",
      "C) It rained and he had no umbrella",
      "D) He was sweating a lot",
    ],
    correctIndex: 2,
    explanation:
        ' Since Liam didn’t take his umbrella and ended up soaking wet, the most logical cause is that it rained and he got caught in it.',
    incorrectExplanations: [
      ' Swimming is not mentioned in the context.',
      ' Spilling water on himself is unlikely to leave him soaking wet.',
      ' Correct answer!',
      ' Sweating doesn’t usually leave someone soaking wet.',
    ],
  ),
  QuestionData(
    question:
        '- Noah’s shoes were soaked. He had been walking through puddles all day.\n\n What caused Noah’s shoes to get wet?',
    options: [
      "A) He was washing his shoes when it started to rain",
      "B) It was raining, and he walked through water",
      "C) He spilled his drink",
      "D) He stepped in the shower",
    ],
    correctIndex: 1,
    explanation:
        ' Walking through puddles while it’s raining would naturally cause his shoes to get soaked.',
    incorrectExplanations: [
      ' Washing shoes in rain is not implied.',
      'Correct answer!',
      ' Spilling a drink wouldn’t fully soak shoes.',
      ' Showering with shoes is unrealistic in this context.',
    ],
  ),
  QuestionData(
    question:
        '- After running the marathon, Jake collapsed on the grass, exhausted.\n\n What most likely caused Jake’s exhaustion?',
    options: [
      "A) He didn’t eat breakfast",
      "B) He had a long day at work",
      "C) He stayed up late with his friends",
      "D) He ran a long and tiring race",
    ],
    correctIndex: 3,
    explanation:
        ' A marathon is very physically demanding, which explains why Jake was so exhausted afterward.',
    incorrectExplanations: [
      ' Skipping breakfast may cause tiredness but not extreme exhaustion.',
      ' A long workday is unrelated to the marathon context.',
      ' Staying up late doesn’t fully explain collapsing from exhaustion.',
      ' Correct answer!',
    ],
  ),
  QuestionData(
    question:
        '- Ben grabbed his keys and ran to the front door.\n\n What is Ben most likely trying to do?',
    options: [
      "A) Clean his room",
      "B) Take a nap on the couch",
      "C) Watch TV",
      "D) Leave the house",
    ],
    correctIndex: 3,
    explanation:
        ' Grabbing keys and running to the door suggests he’s leaving — possibly for work, school, or an errand.',
    incorrectExplanations: [
      ' Cleaning his room doesn’t require keys.',
      ' Taking a nap isn’t related to grabbing keys.',
      ' Watching TV doesn’t involve running to the door.',
      ' Correct answer!',
    ],
  ),
  QuestionData(
    question:
        '- Lila won the race by pacing herself and sprinting at the end.\n\n How did she win the race?',
    options: [
      "A) She gave up early",
      "B) She skipped the race",
      "C) She ran with smart strategy",
      "D) She walked the whole time",
    ],
    correctIndex: 2,
    explanation:
        ' Using pacing and sprinting helped her win — a strategy-based success.',
    incorrectExplanations: [
      ' Giving up early would prevent winning.',
      'Skipping the race means not competing.',
      ' Correct answer!',
      ' Walking the whole time wouldn’t lead to victory.',
    ],
  ),
  QuestionData(
    question:
        '- Marcos stared at Jackson silently during the whole meeting, avoiding eye contact.\n\n What can you infer about their social relationship?',
    options: [
      "A) They are close friends",
      "B) They are strangers meeting for the first time",
      "C) They are ignoring everyone else",
      "D) They are uncomfortable with each other",
    ],
    correctIndex: 3,
    explanation:
        ' In everyday life, prolonged avoidance of eye contact toward a specific person—especially during a shared activity like a meeting—often signals tension, unease, or a strained relationship.',
    incorrectExplanations: [
      ' Close friends usually don’t avoid eye contact in silence.',
      ' Strangers might avoid eye contact, but the context suggests tension, not first meeting.',
      ' Ignoring everyone else doesn’t explain avoiding only one person.',
      ' Correct answer!',
    ],
  ),
  QuestionData(
    question:
        '- After fixing the car, the mechanic handed a set of keys to someone waiting near the counter.\n\n Who is the person likely to receive the keys?',
    options: [
      "A) The receptionist",
      "B) The customer",
      "C) The janitor",
      "D) The security guard",
    ],
    correctIndex: 1,
    explanation:
        ' The person who usually receives the keys after a car repair is the customer who brought in the vehicle.',
    incorrectExplanations: [
      ' Receptionists don’t typically receive keys after a repair.',
      ' Correct answer!',
      ' Janitors are unrelated to car repairs and keys.',
      ' Security guards don’t handle customer car keys.',
    ],
  ),
  QuestionData(
    question:
        '- The children put on their pajamas and brushed their teeth before getting into bed.\n\n When is this probably happening?',
    options: [
      "A) In the morning",
      "B) At lunchtime",
      "C) At night",
      "D) In the afternoon",
    ],
    correctIndex: 2,
    explanation:
        ' Putting on pajamas and brushing teeth before bed strongly indicates nighttime.',
    incorrectExplanations: [
      ' Morning is when people get dressed for the day, not pajamas.',
      ' Lunchtime doesn’t involve bedtime routines.',
      ' Correct answer!',
      ' Afternoon is too early for this routine.',
    ],
  ),
  QuestionData(
    question:
        '- Sophie put on her helmet and grabbed her skateboard.\n\n Where is Sophie most likely?',
    options: [
      "A) At a library",
      "B) At a skatepark",
      "C) In a classroom",
      "D) At the grocery store",
    ],
    correctIndex: 1,
    explanation:
        ' The helmet and skateboard suggest Sophie is going to a skatepark or a safe area for skateboarding.',
    incorrectExplanations: [
      ' A library is unrelated to skateboarding equipment.',
      ' Correct answer!',
      ' Classrooms don’t involve skateboards and helmets.',
      ' A grocery store is not a suitable place for skateboarding.',
    ],
  ),
  QuestionData(
    question:
        '- Sarah cut the vegetables into thin slices.\n\n What tool did Sarah most likely use?',
    options: [
      "A) A spoon",
      "B) A knife",
      "C) A blender",
      "D) A fork",
    ],
    correctIndex: 1,
    explanation:
        ' The sentence doesn’t name the tool, but based on the action (“cut into thin slices”) and real-world knowledge, the most likely tool is a knife.',
    incorrectExplanations: [
      ' A spoon is not used for slicing vegetables.',
      ' Correct answer!',
      ' A blender chops or blends, not slices.',
      ' A fork is used for eating, not slicing.',
    ],
  ),
  QuestionData(
    question:
        '- Title: “The Mystery of the Silver Key”\n\n What will probably happen?',
    options: [
      "A) The key opens something important",
      "B) The key is thrown away",
      "C) The key turns into food",
      "D) The key is lost forever",
    ],
    correctIndex: 0,
    explanation:
        ' A mystery involving a key usually means it unlocks something important.',
    incorrectExplanations: [
      ' Correct answer!',
      ' Throwing it away doesn’t match the “mystery” setup.',
      ' Keys don’t normally turn into food.',
      ' Lost keys end a mystery, not create one.',
    ],
  ),
  QuestionData(
    question:
        '- Subtitle: “The Fall of the Iron City”\n\n What will likely happen?',
    options: [
      "A) The city becomes very rich",
      "B) The city collapses or is destroyed",
      "C) The city is rebuilt stronger",
      "D) The city wins a contest",
    ],
    correctIndex: 1,
    explanation: '“Fall” in a subtitle signals collapse, loss, or destruction.',
    incorrectExplanations: [
      ' Becoming rich is the opposite of a “fall.”',
      ' Correct answer!',
      ' Being rebuilt stronger comes after destruction, not before.',
      ' Winning a contest is unrelated to collapse.',
    ],
  ),
  QuestionData(
    question:
        '- Character: A lonely robot searching for a friend.\n\n What is the most likely outcome?',
    options: [
      "A) The robot will find companionship",
      "B) The robot gives up",
      "C) The robot becomes a king",
      "D) The robot goes to sleep forever",
    ],
    correctIndex: 0,
    explanation:
        ' Stories about lonely characters usually end with finding connection.',
    incorrectExplanations: [
      ' Correct answer!',
      ' Giving up is unlikely in a hopeful storyline.',
      ' Becoming a king is unrelated to friendship.',
      ' Sleeping forever suggests ending, not connection.',
    ],
  ),
  QuestionData(
    question:
        '- Genre: Sci-Fi — “The Last Ship Leaving Earth”.\n\n What is most likely to happen?',
    options: [
      "A) People travel to space for survival",
      "B) People start farming on Earth",
      "C) People ignore the ship",
      "D) People throw a party",
    ],
    correctIndex: 0,
    explanation:
        'Sci-fi with “Last Ship” suggests escape from Earth for survival.',
    incorrectExplanations: [
      ' Correct answer!',
      ' Farming on Earth contradicts “Last Ship leaving Earth.”',
      ' Ignoring the ship makes no sense in a survival story.',
      ' A party is out of context with survival and escape.',
    ],
  ),
  QuestionData(
    question:
        '- Jake stayed up all night playing video games and didn’t set his alarm.\n\n What will most likely happen?',
    options: [
      "A) He will wake up early and be on time",
      "B) He will oversleep and be late",
      "C) He will go jogging in the morning",
      "D) He will clean his room",
    ],
    correctIndex: 1,
    explanation:
        ' Because Jake stayed up all night and didn’t set an alarm, the most likely outcome is that he will oversleep and be late.',
    incorrectExplanations: [
      ' Waking up early and on time is very unlikely after staying up all night.',
      ' Correct answer!',
      ' Jogging in the morning doesn’t follow from being sleep-deprived.',
      ' Cleaning his room is unrelated to his lack of sleep.',
    ],
  ),
];

class TestIntroFinal extends StatelessWidget {
  const TestIntroFinal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Mensaje principal
              const Text(
                " You've reached \nthe final challenge ",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 4,
                      color: Colors.black54,
                    )
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                "Congratulations! You’ve made it to the final test—now prove your skills and rise as the next Infera Champion! 🏆👏🔥",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 60),

              // Botón brillante
              _GlowingButton(
                text: "Go to Test",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FinalTest(questions: FinalTestfinal),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlowingButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _GlowingButton({required this.text, required this.onTap});

  @override
  State<_GlowingButton> createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<_GlowingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 1.0, end: 1.05).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      ),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.white, Colors.grey],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.7),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Text(
            widget.text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
