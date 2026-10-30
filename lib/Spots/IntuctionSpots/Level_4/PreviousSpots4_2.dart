import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_4/Animation4_1.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_4/Animations.dart';

class PreviousSpotsPage extends StatelessWidget {
  const PreviousSpotsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> spots = [
      {
        "label": "Instrumental Stage",
        "icon": Icons.handyman,
        "summary":
            "Use context to infer tools, time, people and relations in a text.",
        "widget": const InstructionSpotLoaderPage4(
          title: 'Instrumental Stage',
          instructions: [
            'You will learn to use clues in a text to infer tools, time, place, people, and relationships, helping you understand texts more clearly.\n\nSometimes, we need to connect ideas that are not directly stated in a text. Elaborative inferences help us make these connections using our background knowledge and context clues.',
          ],
          tipTitle: 'Tip',
          tips: [],
          finalNote: 'Remember to ...', description: '',
        ),
      },
      {
        "label": "Spatial Stage",
        "icon": Icons.map_outlined,
        "summary":
            "Learn to locate and connect spatial relationships using text clues.",
        "widget": const InstructionSpotLoaderPage4_1(
          title: 'Spatial Stage',
          instructions: [
            'You will learn to use clues in a text to infer tools, time, place, people, and relationships, helping you understand texts more clearly.\n\nSometimes, we need to connect ideas that are not directly stated in a text. Elaborative inferences help us make these connections using our background knowledge and context clues.',
          ],
          tipTitle: '',
          tips: [],
          finalNote: '', description: '',
        ),
      },
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Previous Spots",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(blurRadius: 3, color: Colors.black26)],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
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
          gradient: RadialGradient(
            center: Alignment(0, -0.5),
            radius: 1.4,
            colors: [
              Color(0xFFFFE0B2), // naranja claro
              Color(0xFFFFB74D), // más intenso
              Color(0xFFF57C00), // fuerte
            ],
            stops: [0.2, 0.7, 1.0],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 110, 20, 30),
          itemCount: spots.length,
          itemBuilder: (context, index) {
            final spot = spots[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => spot["widget"]),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFCC80), Color(0xFFFFA726)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Ícono circular
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(14),
                          child: Icon(
                            spot['icon'],
                            size: 34,
                            color: const Color(0xFFF57C00),
                          ),
                        ),
                        const SizedBox(width: 18),

                        // Texto
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                spot['label'],
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                spot['summary'],
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
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
