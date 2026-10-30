import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_3/Animation3_1.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_3/Animations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepeatInstructionSpot3Page extends StatefulWidget {
  const RepeatInstructionSpot3Page({super.key});

  @override
  State<RepeatInstructionSpot3Page> createState() =>
      _RepeatInstructionSpot3PageState();
}

class _RepeatInstructionSpot3PageState
    extends State<RepeatInstructionSpot3Page> {
  List<bool> completedStages = [false, false];

  final List<String> _keys = [
    'completedInstructionSpot3',
    'completedInstructionSpot3_1',
  ];

  @override
  void initState() {
    super.initState();
    _loadCompletionStatus();
  }

  Future<void> _loadCompletionStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final user = FirebaseAuth.instance.currentUser;

    List<bool> loaded = _keys
        .map((key) => prefs.getBool(key) ?? false)
        .toList();

    if (mounted) {
      setState(() => completedStages = loaded);
    }

    if (user != null) {
      try {
        final doc = await FirebaseFirestore.instance
            .collection('userProgress')
            .doc(user.uid)
            .get();

        if (doc.exists && doc.data() != null) {
          final data = doc.data()!;

          for (int i = 0; i < _keys.length; i++) {
            final val = data[_keys[i]];
            debugPrint('🔑 ${_keys[i]} = $val');
            loaded[i] = val == true;
            await prefs.setBool(_keys[i], loaded[i]);
          }

          debugPrint('✅ completedStages loaded: $loaded');

          if (mounted) {
            setState(() => completedStages = loaded);
          }
        }
      } catch (e) {
        debugPrint("Error loading progress from Firebase: $e");
      }
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
        "icon": Icons.link,
        "title": "Inferring Causes and Consequences",
        "description":
            "Readers identify causes, consequences, and motives by connecting real-life knowledge with the text.",
        "widget": const InstructionSpotLoaderPage3(
          title: 'Inferring Causes and \n Consequences',
          instructions: [
            'You will use cause-and-effect and goal-oriented inferences to figure out causes, consequences, and motives in a reading, bridging your real-life knowledge with the text.'
          ],
          tipTitle: 'Inference Tips',
          tips: [
            'Think about what could have led to an event.',
            'Consider the goals and motives of characters.'
          ],
          finalNote: 'Cause-and-effect thinking helps connect ideas logically.',
          description: '',
        ),
      },
      {
        "icon": Icons.bubble_chart_outlined,
        "title": "Inferring Goals",
        "description":
            "Readers figure out a character's motive or intended action based on clues in the text and your background knowledge.",
        "widget": const InstructionSpotLoaderPage3_1(
          title: 'Inferring Goals',
          instructions: [
            'You will use cause-and-effect and goal-oriented inferences to figure out causes, consequences, and motives in a reading, bridging your real-life knowledge with the text.'
          ],
          tipTitle: 'Inference Tips',
          tips: [
            'Think about what could have led to an event.',
            'Consider the goals and motives of characters.'
          ],
          finalNote: 'Cause-and-effect thinking helps connect ideas logically.',
          description: '',
        ),
      },
    ];

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF90CAF9),
              Color(0xFF42A5F5),
              Color(0xFF1976D2),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Color(0xFF014F86)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Text(
                  "Choose a section to view:",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF0D47A1),
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                ...List.generate(stages.length, (index) {
                  final stage = stages[index];
                  final bool isCompleted = completedStages[index];
                  final bool isLocked =
                      index == 0 ? false : !completedStages[index - 1];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
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
                                  : Colors.blue.withOpacity(0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              // ── Fondo base ────────────────────────────
                              Positioned.fill(
                                child: Container(
                                  color: isLocked
                                      ? Colors.white.withOpacity(0.25)
                                      : const Color(0xFFE3F2FD),
                                ),
                              ),

                              // ── Overlay dorado animado ─────────────────
                              if (isCompleted)
                                Positioned.fill(
                                  child: TweenAnimationBuilder<double>(
                                    tween: Tween(begin: 0, end: 1),
                                    duration:
                                        const Duration(milliseconds: 1200),
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

                              // ── Contenido ──────────────────────────────
                              Opacity(
                                opacity: isLocked ? 0.35 : 1.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(22),
                                  child: Row(
                                    children: [
                                      Icon(
                                        stage['icon'],
                                        size: 40,
                                        color: isCompleted
                                            ? Colors.white
                                            : isLocked
                                                ? Colors.white
                                                : const Color(0xFF0277BD),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              stage['title'],
                                              style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: isCompleted
                                                    ? Colors.white
                                                    : isLocked
                                                        ? Colors.white
                                                        : const Color(
                                                            0xFF0D47A1),
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              stage['description'],
                                              style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                height: 1.4,
                                                color: isCompleted
                                                    ? Colors.white
                                                        .withOpacity(0.88)
                                                    : isLocked
                                                        ? Colors.white70
                                                        : const Color(
                                                                0xFF0D1B2A)
                                                            .withOpacity(0.75),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Icon(
                                        isCompleted
                                            ? Icons.check_circle_rounded
                                            : isLocked
                                                ? Icons.lock_rounded
                                                : Icons
                                                    .arrow_forward_ios_rounded,
                                        size: 22,
                                        color: isCompleted
                                            ? Colors.white
                                            : isLocked
                                                ? Colors.white
                                                : const Color(0xFF0277BD),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // ── Overlay de bloqueado ───────────────────
                              if (isLocked)
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(14),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.9),
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 10,
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            Icons.lock_outline,
                                            size: 38,
                                            color: Color(0xFF0277BD),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
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
                }),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}