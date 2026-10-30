import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_1/Animation1_1.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_1/Animations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RepeatInstructionSpot1Page extends StatefulWidget {
  const RepeatInstructionSpot1Page({super.key});

  @override
  State<RepeatInstructionSpot1Page> createState() =>
      _RepeatInstructionSpot1PageState();
}

class _RepeatInstructionSpot1PageState
    extends State<RepeatInstructionSpot1Page> {
  bool completedInstruction1 = false;
  bool completedInstruction2 = false;

  @override
  void initState() {
    super.initState();
    _loadCompletionStatus();
  }

  Future<void> _loadCompletionStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final user = FirebaseAuth.instance.currentUser;

    bool completed1 = prefs.getBool('completedInstructionSpot1') ?? false;
    bool completed2 = prefs.getBool('completedInstructionSpot1_1') ?? false;

    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('userProgress')
          .doc(user.uid)
          .get();

      if (doc.exists && doc.data() != null) {
        completed1 = doc.data()!['completedInstructionSpot1'] == true;
        completed2 = doc.data()!['completedInstructionSpot1_1'] == true;

        await prefs.setBool('completedInstructionSpot1', completed1);
        await prefs.setBool('completedInstructionSpot1_1', completed2);
      }
    }

    if (mounted) {
      setState(() {
        completedInstruction1 = completed1;
        completedInstruction2 = completed2;
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
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 153, 255, 133), Color(0xFFe0f7fa)],
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
                  color: const Color.fromARGB(255, 0, 105, 32),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _buildOptionCard(
                context,
                icon: Icons.person_pin_circle_outlined,
                title: "Identifying Pronouns",
                description:
                    "Readers figure out who or what a pronoun refers to in a sentence or a text.",
                isLocked: false,
                isCompleted: completedInstruction1,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const InstructionSpotLoaderPage1(
                        title: 'Identifying Pronouns',
                        instructions: [
                          'You will learn how to use clues in a text to understand what pronouns and other words refer to.\nThis will help you read more clearly and accurately.'
                        ],
                        tipTitle: 'Pronoun Tips',
                        tips: ['Look at the noun before the pronoun.'],
                        finalNote: 'That\u2019s how we use pronouns.',
                        description: '',
                      ),
                    ),
                  ).then((_) => _loadCompletionStatus());
                },
              ),
              const SizedBox(height: 25),
              _buildOptionCard(
                context,
                icon: Icons.link,
                title: "Looking Back for References",
                description:
                    "Readers look back in the text to connect a word or phrase (not just a pronoun) to something that was mentioned earlier.",
                isLocked: !completedInstruction1,
                isCompleted: completedInstruction2,
                onTap: () {
                  if (completedInstruction1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const InstructionSpotLoaderPage1_1(
                          title: 'Looking Back for \nReferences',
                          instructions: [
                            "You will learn how to use clues in a text to understand what pronouns and other words refer to.\nThis will help you read more clearly and accurately."
                          ],
                          tipTitle: '',
                          tips: [],
                          finalNote: '',
                          description: '',
                        ),
                      ),
                    ).then((_) => _loadCompletionStatus());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
    required bool isLocked,
    bool isCompleted = false,
  }) {
    return InkWell(
      onTap: isLocked ? null : onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        // Sin altura fija — crece según el contenido
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isLocked
                  ? Colors.black.withOpacity(0.05)
                  : const Color.fromARGB(255, 0, 150, 90).withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // ── Fondo base ────────────────────────────────────────────
              Positioned.fill(
                child: Container(
                  color: isLocked
                      ? Colors.grey[200]
                      : Colors.white.withOpacity(0.96),
                ),
              ),

              // ── Overlay dorado animado ─────────────────────────────────
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

              // ── Contenido principal ────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 22,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icono
                    Icon(
                      icon,
                      size: 42,
                      color: isCompleted
                          ? Colors.white
                          : isLocked
                              ? Colors.grey.withOpacity(0.5)
                              : const Color.fromARGB(255, 0, 121, 61),
                    ),
                    const SizedBox(width: 18),

                    // Textos
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: isCompleted
                                  ? Colors.white
                                  : isLocked
                                      ? Colors.grey[500]
                                      : const Color.fromARGB(255, 0, 77, 30),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            description,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              height: 1.45,
                              color: isCompleted
                                  ? Colors.white.withOpacity(0.88)
                                  : isLocked
                                      ? Colors.grey[400]
                                      : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Icono de estado (check / lock / arrow)
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
                              ? Colors.grey[400]
                              : const Color.fromARGB(255, 0, 121, 61),
                    ),
                  ],
                ),
              ),

              // ── Overlay de bloqueado ───────────────────────────────────
              if (isLocked)
                Positioned.fill(
                  child: Container(
                    color: Colors.white.withOpacity(0.60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.lock_outline_rounded,
                            size: 34,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Complete previous level to unlock",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
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
    );
  }
}