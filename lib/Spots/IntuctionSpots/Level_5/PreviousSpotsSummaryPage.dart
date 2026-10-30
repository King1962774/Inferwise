import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_5/Instruction_Spot5.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_5/Instruction_Spot5_1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RepeatInstructionSpot5Page extends StatefulWidget {
  const RepeatInstructionSpot5Page({super.key});

  @override
  State<RepeatInstructionSpot5Page> createState() =>
      _RepeatInstructionSpot5PageState();
}

class _RepeatInstructionSpot5PageState
    extends State<RepeatInstructionSpot5Page> {
  List<bool> completedStages = [false, false];

  final List<String> _keys = [
    'completedInstructionSpot5',
    'completedInstructionSpot5_1',
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
        "icon": Icons.person_pin_circle_outlined,
        "title": "Predicting Content",
        "description":
            "Readers figure out what will probably happen in a story by using clues such as the title, subtitle, character traits, and genre.",
        "widget": InstructionSpotPage5(
          title: 'Predicting Content',
          instructions: [
            'You will learn to use story clues — like titles, characters, genres, and actions — to predict what will happen next.'
          ],
          tipTitle: 'Pronoun Tips',
          tips: ['Look at the noun before the pronoun.'],
          finalNote: 'That\'s how we use pronouns.',
        ),
      },
      {
        "icon": Icons.link,
        "title": "Predicting Outcome",
        "description":
            "Readers uses clues from the text to predict what is most likely to happen next or what the result of an event will be.",
        "widget": const InstructionSpotPage5_1(
          title: 'Predicting Outcome',
          instructions: [
            'You will learn to use story clues — like titles, characters, genres, and actions — to predict what will happen next.'
          ],
          tipTitle: '',
          tips: [],
          finalNote: '',
        ),
      },
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Color(0xFF8e44ad)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9b59b6), Color(0xFFd7bde2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 120, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Choose a section to review:",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4A0072),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              ...List.generate(stages.length, (index) {
                final stage = stages[index];
                final bool isCompleted = completedStages[index];
                final bool isLocked =
                    index == 0 ? false : !completedStages[index - 1];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 25),
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
                            color: const Color(0xFF6c3483).withOpacity(0.20),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
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
                                color: Colors.white
                                    .withOpacity(isLocked ? 0.5 : 0.92),
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
                            Padding(
                              padding: const EdgeInsets.all(22),
                              child: Row(
                                children: [
                                  Icon(
                                    stage['icon'],
                                    size: 40,
                                    color: isCompleted
                                        ? Colors.white
                                        : const Color(0xFF8e44ad),
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
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: isCompleted
                                                ? Colors.white
                                                : const Color(0xFF4A0072),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          stage['description'],
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: isCompleted
                                                ? Colors.white.withOpacity(0.88)
                                                : Colors.grey[700],
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
                                            : Icons.arrow_forward_ios_rounded,
                                    size: 22,
                                    color: isCompleted
                                        ? Colors.white
                                        : const Color(0xFF8e44ad),
                                  ),
                                ],
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
                                          color: Color(0xFF8e44ad),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Complete previous section to unlock",
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
            ],
          ),
        ),
      ),
    );
  }
}