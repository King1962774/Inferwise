import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_2/Animation2_1.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_2/Animation2_2.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_2/Animation2_3.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_2/Animations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AllInstructionSpotsPage extends StatefulWidget {
  const AllInstructionSpotsPage({super.key});

  @override
  State<AllInstructionSpotsPage> createState() =>
      _AllInstructionSpotsPageState();
}

class _AllInstructionSpotsPageState extends State<AllInstructionSpotsPage> {
  List<bool> completedStages = [false, false, false, false];

  final List<String> _keys = [
    'completedInstructionSpot2',
    'completedInstructionSpot2_1',
    'completedInstructionSpot2_2',
    'completedInstructionSpot2_3',
  ];

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
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
        "icon": Icons.explore,
        "title": "Identifying Cognates",
        "description":
            "Readers recognize cognates to understand new words by noticing similarities between English and Spanish, while watching out for false matches.",
        "widget": const InstructionSpotLoaderPage2(
          title: "Identifying Cognates",
          instructions: [
            "You will learn to use cognates, prefixes, suffixes, and context clues to understand unfamiliar words."
          ],
          tipTitle: "Helpful Tips",
          tips: ["Here are some tips to follow."],
          finalNote: "This is the final note.",
          description: '',
        ),
      },
      {
        "icon": Icons.visibility_off,
        "title": "Identifying Prefixes",
        "description":
            "Readers look at prefixes to figure out a word's meaning by focusing on the beginning word part.",
        "widget": const InstructionSpotLoaderPage2_1(
          title: "Identifying Prefixes",
          instructions: [
            "You will learn to use cognates, prefixes, suffixes, and context clues to understand unfamiliar words, boosting your reading comprehension and expanding your vocabulary!"
          ],
          tipTitle: "Watch Out!",
          tips: ["False friends can trick even advanced readers."],
          finalNote: "Understanding these improves comprehension!",
          description: '',
        ),
      },
      {
        "icon": Icons.auto_stories,
        "title": "Identifying Suffixes",
        "description":
            "Readers look at suffixes to understand a word's meaning or role by focusing on the ending word part.",
        "widget": const InstructionSpotLoaderPage2_2(
          title: "Identifying Suffixes",
          instructions: [
            "You will learn to use cognates, prefixes, suffixes, and context clues to understand unfamiliar words, boosting your reading comprehension and expanding your vocabulary!"
          ],
          tipTitle: "Helpful Tips",
          tips: ["Here are some tips for this stage."],
          finalNote: "Nice work!",
          description: '',
        ),
      },
      {
        "icon": Icons.rocket_launch,
        "title": "Identifying Context Clues",
        "description":
            "Readers use context clues to figure out word meanings by reading the surrounding words and sentences.🚀",
        "widget": const InstructionSpotLoaderPage2_3(
          title: "Identifying Context Clues",
          instructions: [
            "You will learn to use cognates, prefixes, suffixes, and context clues to understand unfamiliar words, boosting your reading comprehension and expanding your vocabulary!"
          ],
          tipTitle: "Final Tips",
          tips: ["Trust what you've learned and give it your best!"],
          finalNote: "You've reached the end—great job!",
          description: '',
        ),
      },
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close_rounded,
                color: Color(0xFF00695C), size: 28),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE0F7F4),
              Color(0xFFB2EBE5),
              Color(0xFF80CBC4),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 120, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Choose a section to review:",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF00695C),
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
                            ).then((_) => _loadProgress());
                          },
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 120),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: isLocked
                                ? Colors.black.withOpacity(0.05)
                                : const Color(0xFF00897B).withOpacity(0.12),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            // ── Fondo base ──────────────────────────────
                            Positioned.fill(
                              child: Container(
                                color: isLocked
                                    ? Colors.grey[200]
                                    : Colors.white.withOpacity(0.92),
                              ),
                            ),

                            // ── Overlay dorado animado ───────────────────
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

                            // ── Contenido ────────────────────────────────
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
                                              ? Colors.grey
                                              : const Color(0xFF00897B),
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
                                                  : isLocked
                                                      ? Colors.grey[600]
                                                      : const Color(
                                                          0xFF00695C),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            stage['description'],
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: isCompleted
                                                  ? Colors.white
                                                      .withOpacity(0.88)
                                                  : isLocked
                                                      ? Colors.grey[500]
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
                                          : isLocked
                                              ? Colors.grey
                                              : const Color(0xFF00897B),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // ── Overlay de bloqueado ─────────────────────
                            if (isLocked)
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.65),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.15),
                                              blurRadius: 10,
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.lock_outline,
                                          size: 28,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Complete previous level to unlock",
                                        style: GoogleFonts.poppins(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[700],
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