import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_4/Animation4_1.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_4/Animation4_2.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_4/Animation4_3.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_4/Animation4_4.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_4/Animations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllInstructionSpotsPageFinal extends StatefulWidget {
  const AllInstructionSpotsPageFinal({super.key});

  @override
  State<AllInstructionSpotsPageFinal> createState() =>
      _AllInstructionSpotsPageFinalState();
}

class _AllInstructionSpotsPageFinalState
    extends State<AllInstructionSpotsPageFinal> {
  List<bool> completedStages = [false, false, false, false, false];

  @override
  void initState() {
    super.initState();
    _loadCompletionStatus();
  }

 Future<void> _loadCompletionStatus() async {
  final prefs = await SharedPreferences.getInstance();
  final user = FirebaseAuth.instance.currentUser;

  // Las claves reales que guarda cada Animation
  final List<String> keys = [
    'completedInstructionSpot4',
    'completedInstructionSpot4_1',
    'completedInstructionSpot4_2',
    'completedInstructionSpot4_3',
    'completedInstructionSpot4_4',
  ];

  List<bool> loaded = [];

  for (final key in keys) {
    bool completed = prefs.getBool(key) ?? false;

    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('userProgress')
          .doc(user.uid)
          .get();

      if (doc.exists && doc.data() != null) {
        final val = doc.data()![key];
        debugPrint('🔑 $key = $val');
        completed = val == true;
        await prefs.setBool(key, completed);
      }
    }
    loaded.add(completed);
  }

  debugPrint('✅ completedStages loaded: $loaded');

  if (mounted) {
    setState(() {
      completedStages = loaded;
    });
  }
}

  LinearGradient _goldGradient() {
    return const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFFF6E27A),
        Color(0xFFE6C767),
        Color(0xFFC9A44B),
        Color(0xFFB38A3E),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> stages = [
      {
        "label": "Inferring the Tool",
        "icon": Icons.construction,
        "summary":
            "Readers figure out what tool or method was used by connecting clues to what you already know.",
        "widget": const InstructionSpotLoaderPage4(
          title: "Inferring the Tool",
          instructions: [
            "You will learn to use clues in a text to infer tools, time, place, people, and relationships, helping you understand texts more clearly.",
          ],
          tipTitle: "Helpful Tip",
          tips: [
            "Look for action verbs like 'cut', 'wrote', or 'painted' — they often suggest the instrument used."
          ],
          finalNote:
              "Instrumental inference improves your understanding of cause and method in reading comprehension.",
          description: '',
        ),
      },
      {
        "label": "Inferring the Location",
        "icon": Icons.map,
        "summary":
            "Readers determine where something happens by linking clues in the text to familiar locations or contexts.",
        "widget": const InstructionSpotLoaderPage4_1(
          title: "Inferring the Location",
          instructions: [
            "You will learn to use clues in a text to infer tools, time, place, people, and relationships, helping you understand texts more clearly.",
          ],
          tipTitle: "Watch Out!",
          tips: [
            "Pay attention to descriptive words that signal environments — like 'shore', 'hallway', or 'forest'."
          ],
          finalNote:
              "Spatial inference strengthens your ability to visualize and comprehend textual environments.",
          description: '',
        ),
      },
      {
        "label": "Inferring the Time",
        "icon": Icons.access_time,
        "summary":
            "Readers infer when something happens by connecting events to time-related clues.",
        "widget": const InstructionSpotLoaderPage4_2(
          title: "Inferring the Time",
          instructions: [
            "You will learn to use clues in a text to infer tools, time, place, people, and relationships, helping you understand texts more clearly.",
          ],
          tipTitle: "Helpful Tips",
          tips: [
            "Look for temporal indicators like 'before', 'after', 'yesterday', or specific months and seasons."
          ],
          finalNote:
              "Understanding temporal relations helps ensure your interpretation aligns with the intended timeline.",
          description: '',
        ),
      },
      {
        "label": "Inferring the Agent",
        "icon": Icons.person_search,
        "summary":
            "Readers identify who performed an action, even when the text doesn't say it directly.",
        "widget": const InstructionSpotLoaderPage4_3(
          title: "Inferring the Agent",
          instructions: [
            "You will learn to use clues in a text to infer tools, time, place, people, and relationships, helping you understand texts more clearly."
          ],
          tipTitle: "Final Tip",
          tips: [
            "Pay attention to actions, motivations, and results — they often reveal who the agent is."
          ],
          finalNote:
              "You've mastered inferential reasoning! 🎉 Now you can identify methods, places, times, and agents through logical connections in any text.",
          description: '',
        ),
      },
      {
        "label": "Inferring the Social Dynamics",
        "icon": Icons.psychology_alt,
        "summary":
            "Readers understand the relationships or roles between people in a text by connecting it to your knowledge of social interactions.",
        "widget": const InstructionSpotLoaderPage4_4(
          title: "Inferring the Social \nDynamics",
          instructions: [
            "You will learn to use clues in a text to infer tools, time, place, people, and relationships, helping you understand texts more clearly.",
          ],
          tipTitle: "Final Tip",
          tips: [
            "Pay attention to actions, motivations, and results — they often reveal who the agent is."
          ],
          finalNote:
              "You've mastered inferential reasoning! 🎉 Now you can identify methods, places, times, and agents through logical connections in any text.",
          description: '',
        ),
      },
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.6),
            radius: 1.4,
            colors: [
              Color(0xFFFFE0B2),
              Color(0xFFFFB74D),
              Color(0xFFF57C00),
            ],
            stops: [0.2, 0.7, 1.0],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 110, 20, 30),
          itemCount: stages.length,
          itemBuilder: (context, index) {
            final stage = stages[index];
            final bool isCompleted =
                index < completedStages.length ? completedStages[index] : false;
            final bool isLocked =
                index == 0 ? false : !completedStages[index - 1];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                onTap: isLocked
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => stage['widget']),
                        ).then((_) => _loadCompletionStatus());
                      },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: isLocked
                            ? Colors.black.withOpacity(0.05)
                            : Colors.black.withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        // ── Fondo base ──────────────────────────────────
                        Positioned.fill(
                          child: Container(
                            color: isLocked
                                ? const Color(0xFFFFB74D).withOpacity(0.35)
                                : Colors.white,
                          ),
                        ),

                        // ── Overlay dorado animado ──────────────────────
                        if (isCompleted)
                          Positioned.fill(
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0, end: 1),
                              duration: const Duration(milliseconds: 1200),
                              curve: Curves.easeOutCubic,
                              builder: (context, value, _) {
                                return FractionallySizedBox(
                                  widthFactor: value,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: _goldGradient(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                        // ── Contenido ───────────────────────────────────
                        Opacity(
                          opacity: isLocked ? 0.4 : 1.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 24),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Avatar / icono
                                CircleAvatar(
                                  backgroundColor: isCompleted
                                      ? Colors.white.withOpacity(0.30)
                                      : const Color(0xFFFFE0B2),
                                  radius: 28,
                                  child: Icon(
                                    stage['icon'],
                                    size: 30,
                                    color: isCompleted
                                        ? Colors.white
                                        : const Color(0xFFF57C00),
                                  ),
                                ),
                                const SizedBox(width: 16),

                                // Textos
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        stage['label'],
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: isCompleted
                                              ? Colors.white
                                              : const Color(0xFFF57C00),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        stage['summary'],
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          height: 1.45,
                                          color: isCompleted
                                              ? Colors.white.withOpacity(0.88)
                                              : const Color(0xFFF57C00),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // Icono de estado
                                Icon(
                                  isCompleted
                                      ? Icons.check_circle_rounded
                                      : isLocked
                                          ? Icons.lock_rounded
                                          : Icons.arrow_forward_ios_rounded,
                                  size: 22,
                                  color: isCompleted
                                      ? Colors.white
                                      : isLocked
                                          ? const Color(0xFFF57C00)
                                          : const Color(0xFFF57C00),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // ── Overlay de bloqueado ─────────────────────────
                        if (isLocked)
                          Positioned.fill(
                            child: Container(
                              color: Colors.black.withOpacity(0.15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.black.withOpacity(0.10),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.lock_outline_rounded,
                                      size: 34,
                                      color: Color(0xFFF57C00),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Complete previous level to unlock",
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}