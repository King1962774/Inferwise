import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inferwise/Self%20Assessments/self_evaluation_level2.dart';
import 'package:inferwise/Self%20Assessments/self_evaluation_level3.dart';
import 'package:inferwise/Self%20Assessments/self_evaluation_level4.dart';
import 'package:inferwise/Self%20Assessments/self_evaluation_level5.dart';
import 'package:inferwise/Spots/Final-Test/Question.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_4/PreviousSpotsSummaryPage.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_5/PreviousSpotsSummaryPage.dart';
import 'package:inferwise/Spots/ReadingSpots/Dark%20Blue/Content/Test/Test.dart';
import 'package:inferwise/Spots/ReadingSpots/Green/Content/Spot1/Spot_Page/reading_spot_page.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_2/PreviousSpotsSummaryPage.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_1/PreviousSpotsSummaryPage.dart';
import 'package:inferwise/Spots/IntuctionSpots/Level_3/PreviousSpotsSummaryPage.dart';
import 'package:inferwise/Spots/ReadingSpots/Orange/Content/Spot1/Spot_Page/reading_spot_page.dart';
import 'package:inferwise/Spots/ReadingSpots/Orange/Content/Spot3/Spot_Page/Reading_Spot.dart';
import 'package:inferwise/Spots/ReadingSpots/Orange/Content/Spot4/Spot_Page/Reading_Spot_Page.dart';
import 'package:inferwise/Spots/ReadingSpots/Orange/Content/Test/Test.dart';
import 'package:inferwise/Spots/ReadingSpots/Purple/Content/Spot1/Spot_Page/reading_spot_page.dart';
import 'package:inferwise/Spots/ReadingSpots/Purple/Content/Spot2/Spot_Page/Reading_Spot_Page.dart';
import 'package:inferwise/Spots/ReadingSpots/Purple/Content/Spot3/Spot_Page/Reading_Spot.dart';
import 'package:inferwise/Spots/ReadingSpots/Purple/Content/Spot4/Spot_Page/Reading_Spot_Page.dart';
import 'package:inferwise/Spots/ReadingSpots/Purple/Content/Test/Test.dart';
import 'package:inferwise/Spots/Settings/Settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inferwise/Spots/ReadingSpots/Blue/Content/Spot1/Spot_Page/ReadingSpot.dart';
import 'package:inferwise/Spots/ReadingSpots/Blue/Content/Spot2/Spot_Page/Reading_Spot.dart';
import 'package:inferwise/Spots/ReadingSpots/Blue/Content/Spot3/Spot_Page/ReadingSpot.dart';
import 'package:inferwise/Spots/ReadingSpots/Blue/Content/Spot4/Spot_Page/ReadingSpot.dart';
import 'package:inferwise/Spots/ReadingSpots/Blue/Content/Test/Test.dart';
import 'package:inferwise/Spots/ReadingSpots/Dark%20Blue/Content/Spot1/Spot_Page/ReadingSpot.dart';
import 'package:inferwise/Spots/ReadingSpots/Dark%20Blue/Content/Spot2/Spot_Page/Reading_Spot.dart';
import 'package:inferwise/Spots/ReadingSpots/Dark%20Blue/Content/Spot3/Spot_Page/ReadingSpot.dart';
import 'package:inferwise/Spots/ReadingSpots/Dark%20Blue/Content/Spot4/Spot_Page/ReadingSpot.dart';
import 'package:inferwise/Spots/ReadingSpots/Green/Content/Spot2/Spot_Page/Reading_Spot_Page.dart';
import 'package:inferwise/Spots/ReadingSpots/Green/Content/Spot3/Spot_Page/Reading_Spot.dart';
import 'package:inferwise/Spots/ReadingSpots/Green/Content/Spot4/Spot_Page/Reading_Spot_Page.dart';
import 'package:inferwise/Spots/ReadingSpots/Green/Content/Test/Test.dart';

import '../ReadingSpots/Orange/Content/Spot2/Spot_Page/Reading_Spot_Page.dart';

import 'package:inferwise/Self%20Assessments/Self_Assessment.dart'; // ajusta la ruta a donde guardaste el archivo

// Definimos los tipos de Spot
enum SpotType { normal, instruction, checkpoint, finalTest }

class SpotWidget extends StatelessWidget {
  final String title;
  final String description;
  final SpotType type;
  final IconData? icon;
  final Color? color;
  final Gradient? gradient;
  final String? imagePath;
  final double? imageSize;
  final VoidCallback? onTap;
  final bool alreadyCompleted;
  final Color? iconColor;
  final bool isLocked;

  const SpotWidget({
    super.key,
    required this.title,
    this.description = '',
    this.type = SpotType.normal,
    this.icon,
    this.color = Colors.blueAccent,
    this.imagePath,
    this.imageSize,
    this.onTap,
    this.alreadyCompleted = false,
    this.gradient,
    this.iconColor,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    const Color busuuGold = Color.fromARGB(255, 255, 255, 255);

    return GestureDetector(
        onTap: onTap,
        child: Opacity(
          opacity: isLocked ? 0.6 : 1.0,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isLocked
                  ? Colors.grey.withOpacity(0.2)
                  : Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: isLocked
                            ? const LinearGradient(
                                colors: [Colors.grey, Colors.grey])
                            : alreadyCompleted
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFFFFB3BA),
                                      Color(0xFFFFDFBA),
                                      Color(0xFFFFFFBA),
                                      Color(0xFFBAFFBA),
                                      Color(0xFFBAE0FF),
                                      Color(0xFFDDBAFF),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : gradient,
                        boxShadow: [
                          if (!isLocked)
                            BoxShadow(
                              color: (alreadyCompleted
                                      ? busuuGold
                                      : Color.fromARGB(255, 255, 255, 255))
                                  .withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                        ],
                      ),
                      child: Center(
                        child: isLocked
                            ? const Icon(Icons.lock,
                                color: Colors.white, size: 28)
                            : (imagePath != null
                                ? ClipOval(
                                    child: Image.asset(imagePath!,
                                        width: 45,
                                        height: 45,
                                        fit: BoxFit.cover))
                                : Icon(
                                    icon ?? Icons.play_arrow,
                                    color: alreadyCompleted
                                        ? Colors.black //color icon all
                                        : (iconColor ?? Colors.white),
                                    size: 36,
                                  )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Consumer(
                    builder: (context, ref, _) {
                      final isDark =
                          ref.watch(themeNotifierProvider).isDarkMode;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? const Color.fromARGB(255, 255, 255, 255)
                                  : const Color.fromARGB(255, 249, 249, 249),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (description.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                description,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isDark
                                      ? const Color.fromARGB(255, 255, 255, 255)
                                      : const Color.fromARGB(
                                          255, 255, 255, 255),
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class ChapterSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;
  final bool isLocked;
  final Color themeColor;
  final IconData? icon;

  const ChapterSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
    this.isLocked = false,
    required this.themeColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cabecera del Nivel (Carpeta siempre abierta)
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(
                255, 30, 74, 89), // fondo de los titulos de niveles
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: themeColor.withOpacity(0.5), width: 1.5),
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: themeColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isLocked ? Icons.lock : (icon ?? Icons.public),
                  color: isLocked ? Colors.grey : themeColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Contenido del Nivel (Spots)
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            children: List.generate(children.length, (index) {
              return Column(
                children: [
                  children[index],
                  if (index != children.length - 1)
                    Transform.translate(
                      offset: const Offset(-103, 0),
                      child: Container(
                        width: 3,
                        height: 30,
                        margin:
                            const EdgeInsets.only(left: 0, top: 0, bottom: 0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              themeColor,
                              themeColor,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final GlobalKey progressBarKey = GlobalKey();

  Future<String?> showBlueSpotDialog({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required List<Map<String, dynamic>> actions,
  }) {
    return showDialog<String>(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFF), // 👈 fondo claro fijo
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 22,
                offset: const Offset(0, 12),
              ),
            ],
            border: Border.all(
              color: const Color(0xFFE3ECF5),
              width: 1.2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 56, color: const Color(0xFF1565C0)),
              const SizedBox(height: 18),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D1B2A),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 15,
                  color: Color(0xFF334155), // 👈 gris oscuro elegante
                ),
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: actions.map((a) {
                  return ElevatedButton.icon(
                    onPressed: () =>
                        Navigator.pop(context, a['value'] as String),
                    icon: Icon(a['icon']),
                    label: Text(a['label']),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1976D2),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      elevation: 6,
                      shadowColor: const Color(0xFF1976D2).withOpacity(0.35),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Total number of spots (shared across methods)
  static const int totalSpots = 41;

  //----------------------// lvl1
  bool completedInstruction1 = false;
  bool completedInstruction1_1 = false;

  bool completedReading1 = false;
  bool completedReading2 = false;
  bool completedReading3 = false;
  bool completedReading4 = false;
  bool completedCheckpoint1 = false;
  //-----------------------// lvl2
  bool completedInstruction2 = false;
  bool completedInstruction2_1 = false;
  bool completedInstruction2_2 = false;
  bool completedInstruction2_3 = false;

  bool completedReading5 = false;
  bool completedReading6 = false;
  bool completedReading7 = false;
  bool completedReading8 = false;
  bool completedCheckpoint2 = false;
  //-----------------------// lvl3
  bool completedInstruction3 = false;
  bool completedInstruction3_1 = false;

  bool completedReading9 = false;
  bool completedReading10 = false;
  bool completedReading11 = false;
  bool completedReading12 = false;
  bool completedCheckpoint3 = false;

  //-----------------------// lvl4
  bool completedInstruction4 = false; //Instrumental
  bool completedInstruction4_1 = false; //Spatial
  bool completedInstruction4_2 = false; //Temporal
  bool completedInstruction4_3 = false; //Agent
  bool completedInstruction4_4 = false; //Social

  bool completedReading13 = false;
  bool completedReading14 = false;
  bool completedReading15 = false;
  bool completedReading16 = false;
  bool completedCheckpoint4 = false;
  //-----------------------// lvl5
  bool completedInstruction5 = false; //Contextual
  bool completedInstruction5_1 = false; //Outcome

  bool completedReading17 = false;
  bool completedReading18 = false;
  bool completedReading19 = false;
  bool completedReading20 = false;
  bool completedCheckpoint5 = false;
  //-----------------------// lvl final
  bool completedFinalTest = false;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('userProgress')
        .doc(user.uid)
        .get();

    final data = doc.data();
    if (data != null && mounted) {
      setState(() {
        completedInstruction1 = data['completedInstructionSpot1'] ?? false;
        completedInstruction1_1 = data['completedInstructionSpot1_1'] ?? false;
        completedReading1 = data['completedReadingSpot1'] ?? false;
        completedReading2 = data['completedReadingSpot2'] ?? false;
        completedReading3 = data['completedReadingSpot3'] ?? false;
        completedReading4 = data['completedReadingSpot4'] ?? false;
        completedCheckpoint1 = data['completedCheckpoint1'] ?? false;
        //------------------------------------------------------------ Lvl2
        completedInstruction2 = data['completedInstructionSpot2'] ?? false;
        completedInstruction2_1 = data['completedInstructionSpot2_1'] ?? false;
        completedInstruction2_2 = data['completedInstructionSpot2_2'] ?? false;
        completedInstruction2_3 = data['completedInstructionSpot2_3'] ?? false;
        completedReading5 = data['completedReadingSpot5'] ?? false;
        completedReading6 = data['completedReadingSpot6'] ?? false;
        completedReading7 = data['completedReadingSpot7'] ?? false;
        completedReading8 = data['completedReadingSpot8'] ?? false;
        completedCheckpoint2 = data['completedCheckpoint2'] ?? false;
        //------------------------------------------------------------ Lvl3
        completedInstruction3 = data['completedInstructionSpot3'] ?? false;
        completedInstruction3_1 = data['completedInstructionSpot3_1'] ?? false;
        completedReading9 = data['completedReadingSpot9'] ?? false;
        completedReading10 = data['completedReadingSpot10'] ?? false;
        completedReading11 = data['completedReadingSpot11'] ?? false;
        completedReading12 = data['completedReadingSpot12'] ?? false;
        completedCheckpoint3 = data['completedCheckpoint3'] ?? false;
        //------------------------------------------------------------ Lvl4
        completedInstruction4 = data['completedInstructionSpot4'] ?? false;
        completedInstruction4_1 = data['completedInstructionSpot4_1'] ?? false;
        completedInstruction4_2 = data['completedInstructionSpot4_2'] ?? false;
        completedInstruction4_3 = data['completedInstructionSpot4_3'] ?? false;
        completedInstruction4_4 = data['completedInstructionSpot4_4'] ?? false;
        completedReading13 = data['completedReadingSpot13'] ?? false;
        completedReading14 = data['completedReadingSpot14'] ?? false;
        completedReading15 = data['completedReadingSpot15'] ?? false;
        completedReading16 = data['completedReadingSpot16'] ?? false;
        completedCheckpoint4 = data['completedCheckpoint4'] ?? false;
        //------------------------------------------------------------ Lvl5
        completedInstruction5 = data['completedInstructionSpot5'] ?? false;
        completedInstruction5_1 = data['completedInstructionSpot5_1'] ?? false;
        completedReading17 = data['completedReadingSpot17'] ?? false;
        completedReading18 = data['completedReadingSpot18'] ?? false;
        completedReading19 = data['completedReadingSpot19'] ?? false;
        completedReading20 = data['completedReadingSpot20'] ?? false;
        completedCheckpoint5 = data['completedCheckpoint5'] ?? false;
        //------------------------------------------------------------ Lvl final
        completedFinalTest = data['completedFinalTest'] ?? false;
      });
    }
  }

  Map<String, bool> get allSpots => {
        "instruction1": completedInstruction1,
        "instruction1_1": completedInstruction1_1,
        "reading1": completedReading1,
        "reading2": completedReading2,
        "reading3": completedReading3,
        "reading4": completedReading4,
        "checkpoint1": completedCheckpoint1,
        "instruction2": completedInstruction2,
        "instruction2_1": completedInstruction2_1,
        "instruction2_2": completedInstruction2_2,
        "instruction2_3": completedInstruction2_3,
        "reading5": completedReading5,
        "reading6": completedReading6,
        "reading7": completedReading7,
        "reading8": completedReading8,
        "checkpoint2": completedCheckpoint2,
        "instruction3": completedInstruction3,
        "instruction3_1": completedInstruction3_1,
        "reading9": completedReading9,
        "reading10": completedReading10,
        "reading11": completedReading11,
        "reading12": completedReading12,
        "checkpoint3": completedCheckpoint3,
        "instruction4": completedInstruction4,
        "instruction4_1": completedInstruction4_1,
        "instruction4_2": completedInstruction4_2,
        "instruction4_3": completedInstruction4_3,
        "instruction4_4": completedInstruction4_4,
        "reading13": completedReading13,
        "reading14": completedReading14,
        "reading15": completedReading15,
        "reading16": completedReading16,
        "checkpoint4": completedCheckpoint4,
        "instruction5": completedInstruction5,
        "instruction5_1": completedInstruction5_1,
        "reading17": completedReading17,
        "reading18": completedReading18,
        "reading19": completedReading19,
        "reading20": completedReading20,
        "checkpoint5": completedCheckpoint5,
      };

  Future<void> updateProgressBar() async {
    final prefs = await SharedPreferences.getInstance();

    // Cantidad total de spots que existen (usa la constante de clase)
    int completed = prefs.getInt('completedSpotsCount') ?? 0;

    // Evitamos que se pase del max
    if (completed < totalSpots) {
      await prefs.setInt('completedSpotsCount', completed + 1);
    }
  }

  Future<void> increaseProgressIfNeeded(
      bool alreadyCompleted, String keyName) async {
    if (alreadyCompleted) return;

    final prefs = await SharedPreferences.getInstance();

    // Marca el spot como completado
    await prefs.setBool(keyName, true);

    // Suma al contador global
    int completed = prefs.getInt('completedSpotsCount') ?? 0;

    if (completed < totalSpots) {
      await prefs.setInt('completedSpotsCount', completed + 1);
    }
  }

  Future<double> getProgressPercent() async {
    final prefs = await SharedPreferences.getInstance();
    int completed = prefs.getInt('completedSpotsCount') ?? 0;
    return completed / totalSpots;
  }

  // Lista de todos los SpotWidgets con sus datos
  List<SpotWidget> _getSpotWidgets() {
    return [
      SpotWidget(
          isLocked: false,
          title: 'Referential Command Center',
          description: 'Learn how references work',
          alreadyCompleted: completedInstruction1_1,
          iconColor: const Color.fromARGB(255, 255, 255, 255),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF2E7D32), // verde medio fuerte
              Color(0xFF43A047), // verde natural
              Color(0xFF66BB6A), // verde claro
              Color(0xFF81C784), // verde suave
              Color(0xFFA5D6A7), // verde pastel
              Color(0xFFC8E6C9), // verde muy claro
              Color(0xFFE8F5E9), // casi blanco verdoso
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          icon: Icons.rocket_launch_rounded,
          onTap: () async {
            // Ambos stages completados
            if (completedInstruction1 && completedInstruction1_1) {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  backgroundColor: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF66BB6A), // verde medio claro
                          Color(
                              0xFF81C784), // verde pastel ligeramente más suave
                          Color(0xFFA5D6A7), // verde claro pastel
                          Color(0xFFC8E6C9), // verde muy claro
                          Color(0xFFE8F5E9), // casi blanco con tinte verde
                          Color(0xFFF1F8E9), // blanco verdoso súper tenue
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.black12,
                        width: 1.2,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.school_rounded,
                          size: 54,
                          color: Color(0xFF424242), // gris metálico oscuro
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Instruction Spot Completed",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Cinzel',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B1B1B), // negro profundo
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          "You've already completed this level.\nWould you like to revisit it to reinforce your skills?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            color: Color(0xFF444444), // gris oscuro
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => Navigator.pop(context, true),
                              icon: const Icon(Icons.refresh_rounded),
                              label: const Text("View All Stages"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                    0xFF66BB6A), // verde profesional
                                foregroundColor:
                                    const Color.fromARGB(255, 0, 0, 0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                elevation: 5,
                                shadowColor:
                                    const Color(0xFF66BB6A).withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );

              if (confirm == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RepeatInstructionSpot1Page(),
                  ),
                );
                return;
              } else {
                return;
              }
            }

            // Ya completó el primer stage
            if (completedInstruction1) {
              final choice = await showDialog<String>(
                context: context,
                builder: (_) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  backgroundColor: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF66BB6A),
                          Color(0xFF81C784),
                          Color(0xFFA5D6A7),
                          Color(0xFFC8E6C9),
                          Color(0xFFE8F5E9),
                          Color(0xFFF1F8E9),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.black12,
                        width: 1.2,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.school_rounded,
                          size: 56,
                          color: Color(0xFF424242),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Stage Completed!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Cinzel',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B1B1B),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          "You've already completed the first stage.\nWhat would you like to do next?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            color: Color(0xFF444444),
                          ),
                        ),
                        const SizedBox(height: 30),

                        /// BOTONES
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => Navigator.pop(context, 'next'),
                              icon: const Icon(Icons.arrow_forward_rounded),
                              label: const Text("Continue"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF81C784),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                elevation: 5,
                                shadowColor:
                                    const Color(0xFF81C784).withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );

              /// NAVEGACIÓN
              if (choice == 'repeat') {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RepeatInstructionSpot1Page(),
                  ),
                );
              } else if (choice == 'next') {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RepeatInstructionSpot1Page(),
                  ),
                );

                if (result == true && !completedInstruction1_1) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('completedInstructionSpot1_1', true);

                  setState(() {
                    completedInstruction1_1 = true;
                  });
                }
              }

              return;
            }

            // No ha completado nada aún
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const RepeatInstructionSpot1Page(),
              ),
            );

            if (result == true && !completedInstruction1) {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('completedInstructionSpot1', true);

              setState(() {
                completedInstruction1 = true;
              });
            }
          }),
      SpotWidget(
        isLocked: !completedInstruction1_1,
        title: 'Lives & Legacies',
        description: 'Meet people who changed the world',
        alreadyCompleted: completedInstruction1_1,
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2E7D32), // verde medio fuerte
            Color(0xFF43A047), // verde natural
            Color(0xFF66BB6A), // verde claro
            Color(0xFF81C784), // verde suave
            Color(0xFFA5D6A7), // verde pastel
            Color(0xFFC8E6C9), // verde muy claro
            Color(0xFFE8F5E9), // casi blanco verdoso
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.person_rounded,
        imageSize: 20,
        onTap: () async {
          // Verificar si el anterior Spot está completado
          if (!completedInstruction1_1) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFFFE0), // Verde suave
                    border: Border.all(
                        color: Colors.green, width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous  Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              const Color.fromARGB(255, 0, 0, 0), //Letras
                          backgroundColor: Colors.green, // color del btn
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }

          if (completedReading1) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFAF3D3), // beige claro
                        Color(0xFFF6D365), // amarillo pastel
                        Color(0xFFFDAE6B), // naranja suave dorado
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.25),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.menu_book_rounded,
                        size: 50,
                        color: Color(0xFF8B6B2F), // dorado quemado
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Biography Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You've already completed this reading.\nWould you like to explore it again?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.2),
                              foregroundColor: Colors.black,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Close"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFFFBC02D), // Amarillo suave
                              foregroundColor: Colors.black,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Read Again"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReadingSpot1Page()),
          );

          if (result == true && !completedReading1) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedReadingSpot1', true);

            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            if (completedCount < totalSpots) {
              await prefs.setInt('completedSpotsCount', completedCount + 1);
            }

            setState(() {
              completedReading1 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedReading1,
        title: 'Daily Dispatch',
        description: 'Practice with real-world news',
        alreadyCompleted: completedReading2,
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2E7D32), // verde medio fuerte
            Color(0xFF43A047), // verde natural
            Color(0xFF66BB6A), // verde claro
            Color(0xFF81C784), // verde suave
            Color(0xFFA5D6A7), // verde pastel
            Color(0xFFC8E6C9), // verde muy claro
            Color(0xFFE8F5E9), // casi blanco verdoso
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.newspaper_rounded,
        imageSize: 20,
        onTap: () async {
          if (!completedReading1) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFFFE0), // Verde suave
                    border: Border.all(
                        color: Colors.green, width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }

          if (completedReading2) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1B3A2F), // verde bosque oscuro
                        Color(0xFF2F5D3F), // verde oliva
                        Color(0xFF7ABF8E), // verde suave
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.08),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.book_rounded,
                        size: 50,
                        color: Colors.white70,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "News Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You've already completed this reading.\nWould you like to revisit it?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.4),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Close"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF4CAF50), // verde principal
                              foregroundColor: Colors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Read Again"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReadingSpot2Page()),
          );

          if (result == true && !completedReading2) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedReadingSpot2', true);

            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            if (completedCount < totalSpots) {
              await prefs.setInt('completedSpotsCount', completedCount + 1);
            }

            setState(() {
              completedReading2 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedReading2,
        title: 'Tales Rocket',
        description: 'Explore stories and narratives',
        alreadyCompleted: completedReading3,
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2E7D32), // verde medio fuerte
            Color(0xFF43A047), // verde natural
            Color(0xFF66BB6A), // verde claro
            Color(0xFF81C784), // verde suave
            Color(0xFFA5D6A7), // verde pastel
            Color(0xFFC8E6C9), // verde muy claro
            Color(0xFFE8F5E9), // casi blanco verdoso
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.interests_rounded,
        imageSize: 20,
        onTap: () async {
          if (!completedReading2) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFFFE0), // Verde suave
                    border: Border.all(
                        color: Colors.green, width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }
          if (completedReading3) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1E2A38),
                        Color(0xFF2F3D4C),
                        Color(0xFF5C7893), // azul grisáceo
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.08),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.auto_stories_outlined,
                        size: 50,
                        color: Colors.white70,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Story Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You've already explored this tale.\nWould you like to read it again?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.4),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Close"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF4B99C3), // azul pastel
                              foregroundColor: Colors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Read Again"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReadingSpot3Page()),
          );

          if (result == true && !completedReading3) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedReadingSpot3', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedReading3 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedReading3,
        title: 'Knowledge Capsule',
        description: 'Dive into in-depth content',
        alreadyCompleted: completedReading4,
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2E7D32), // verde medio fuerte
            Color(0xFF43A047), // verde natural
            Color(0xFF66BB6A), // verde claro
            Color(0xFF81C784), // verde suave
            Color(0xFFA5D6A7), // verde pastel
            Color(0xFFC8E6C9), // verde muy claro
            Color(0xFFE8F5E9), // casi blanco verdoso
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.search_rounded,
        imageSize: 20,
        onTap: () async {
          if (!completedReading3) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFFFE0), // Verde suave
                    border: Border.all(
                        color: Colors.green, width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }
          if (completedReading4) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF2B1B3D), // morado oscuro
                        Color(0xFF4B326F), // violeta medio
                        Color(0xFF9F87C3), // lila claro
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.06),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.article_rounded,
                        size: 52,
                        color: Colors.white70,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "📰 Article Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You've already completed this article.\nWould you like to read it again?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.3),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Close"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF9C27B0), // morado brillante
                              foregroundColor: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Read Again"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ReadingSpot4Page()),
          );

          if (result == true && !completedReading4) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedReadingSpot4', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedReading4 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedReading4,
        title: 'Reference Dock',
        description: 'Test your referential inference skills',
        alreadyCompleted: completedCheckpoint1,
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2E7D32), // verde medio fuerte
            Color(0xFF43A047), // verde natural
            Color(0xFF66BB6A), // verde claro
            Color(0xFF81C784), // verde suave
            Color(0xFFA5D6A7), // verde pastel
            Color(0xFFC8E6C9), // verde muy claro
            Color(0xFFE8F5E9), // casi blanco verdoso
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.star_rounded,
        imageSize: 20,
        onTap: () async {
          if (!completedReading4) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFFFE0), // Verde suave
                    border: Border.all(
                        color: Colors.green, width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }
          if (completedCheckpoint1) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 46, 125, 50), // verde medio fuerte
                        Color(0xFF43A047), // verde natural
                        Color(0xFF66BB6A), // verde claro
                        Color(0xFF81C784), // verde suave
                        Color(0xFFA5D6A7), // verde pastel
                        Color(0xFFC8E6C9), // verde muy claro
                        Color(0xFFE8F5E9), // casi blanco verdoso
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 46, 125, 50),
                        blurRadius: 22,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Color.fromARGB(255, 46, 125, 50),
                      width: 1.4,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.fact_check_outlined,
                        size: 52,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Test Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Título negro
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        "You've already completed this test.\nWould you like to try it again to reinforce your learning?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.black87, // Texto gris oscuro
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context, true),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: Colors.white,
                                shadowColor: Color.fromARGB(255, 46, 125, 50),
                                elevation: 4,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.refresh,
                                      color: Color.fromARGB(255, 46, 125, 50)),
                                  SizedBox(width: 6),
                                  Text(
                                    "Repeat Test",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 46, 125, 50),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TestIntroGreen()),
          );

          if (result == true && !completedCheckpoint1) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedCheckpoint1', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedCheckpoint1 = true;
            });
          }
        },
      ),
//-------------------------------------------------------------------------------------------------------
      SpotWidget(
        isLocked: !completedCheckpoint1,
        title: 'Lexical Lab',
        description: 'Grasp how words work',
        alreadyCompleted: completedInstruction2_3,
        gradient: const LinearGradient(
          colors: [
            Color(0xFF00BCD4), // cian intenso (base fuerte)
            Color(0xFF26C6DA), // cian brillante
            Color(
                0xFF4DD0E1), // cian claro equilibrado (muy parecido al de la imagen)
            Color(0xFF80DEEA), // cian suave
            Color(0xFFB2EBF2), // cian pastel
            Color(0xFFE0F7FA), // cian muy claro / casi blanco
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.rocket_launch_rounded,
        onTap: () async {
          /// 🔒 CHECKPOINT
          if (!completedCheckpoint1) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 200, 221, 249),
                    border: Border.all(
                        color: const Color.fromARGB(255, 74, 231, 255),
                        width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              const Color.fromARGB(255, 74, 231, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }

          /// 🏆 TODOS COMPLETOS
          if (completedInstruction2 &&
              completedInstruction2_1 &&
              completedInstruction2_2 &&
              completedInstruction2_3) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF00897B), // teal medio
                        Color(0xFF26A69A), // teal suave
                        Color(0xFF4DB6AC), // teal claro
                        Color(0xFF80CBC4), // teal pastel
                        Color(0xFFB2EBE5), // teal muy claro
                        Color(0xFFE0F7F4), // casi blanco teal
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.black12,
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.school_rounded,
                        size: 54,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Instruction Spot Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        "You've already completed all stages.\nWould you like to review them?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => Navigator.pop(context, true),
                            icon: const Icon(Icons.refresh_rounded),
                            label: const Text("View All Stages"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF00695C),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                              elevation: 5,
                              shadowColor:
                                  const Color(0xFF00695C).withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm == true) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AllInstructionSpotsPage(),
                ),
              );
              return;
            } else {
              return;
            }
          }

          /// ✅ STAGE 3 COMPLETO
          if (completedInstruction2_2) {
            final choice = await showBlueSpotDialog(
              context: context,
              icon: Icons.workspace_premium_rounded,
              title: "Third Stage Completed",
              description:
                  "Would you like to review previous stages or continue to the final one?",
              actions: [
                {
                  'label': 'See Spots',
                  'icon': Icons.arrow_forward,
                  'value': 'next',
                },
              ],
            );
            if (choice == 'next') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AllInstructionSpotsPage(),
                ),
              );
            }
            return;
          }

          /// ▶️ STAGE 2 COMPLETO
          if (completedInstruction2_1) {
            final choice = await showBlueSpotDialog(
              context: context,
              icon: Icons.layers_rounded,
              title: "Stages Completed",
              description:
                  "You’ve completed the first two stages.\nWhat would you like to do?",
              actions: [
                {
                  'label': 'Next',
                  'icon': Icons.arrow_forward,
                  'value': 'next',
                },
              ],
            );

            if (choice == 'next') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AllInstructionSpotsPage(),
                ),
              );
            }
            return;
          }

          /// 🟡 STAGE 1 COMPLETO
          if (completedInstruction2 && !completedInstruction2_1) {
            final choice = await showBlueSpotDialog(
              context: context,
              icon: Icons.check_circle_rounded,
              title: "First Stage Completed",
              description:
                  "You’ve completed the first stage.\nWhat would you like to do next?",
              actions: [
                {
                  'label': 'View Stages',
                  'icon': Icons.arrow_forward,
                  'value': 'next',
                },
              ],
            );

            if (choice == 'repeat1') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AllInstructionSpotsPage(),
                ),
              );
            } else if (choice == 'next') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AllInstructionSpotsPage(),
                ),
              );
            }
            return;
          }

          /// 🚀 PRIMER ACCESO
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AllInstructionSpotsPage(),
            ),
          );

          if (result == true && !completedInstruction2) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedInstructionSpot2', true);

            final completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedInstruction2 = true;
              completedInstruction2_1 = true;
              completedInstruction2_2 = true;
              completedInstruction2_3 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedInstruction2_3,
        title: 'History Makers',
        alreadyCompleted: completedReading5,
        description: 'Cross paths with history makers',
        gradient: const LinearGradient(
          colors: [
            Color(0xFF00BCD4), // cian intenso (base fuerte)
            Color(0xFF26C6DA), // cian brillante
            Color(
                0xFF4DD0E1), // cian claro equilibrado (muy parecido al de la imagen)
            Color(0xFF80DEEA), // cian suave
            Color(0xFFB2EBF2), // cian pastel
            Color(0xFFE0F7FA), // cian muy claro / casi blanco
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.person_rounded,
        imageSize: 20,
        onTap: () async {
          if (!completedInstruction2_3) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 200, 221, 249),
                    border: Border.all(
                        color: const Color.fromARGB(255, 74, 231, 255),
                        width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              const Color.fromARGB(255, 74, 231, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }
          if (completedReading5) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFAF3D3), // beige claro
                        Color(0xFFF6D365), // amarillo pastel
                        Color(0xFFFDAE6B), // naranja suave dorado
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.25),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.menu_book_rounded,
                        size: 50,
                        color: Color(0xFF8B6B2F), // dorado quemado
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Biography Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You've already completed this reading.\nWould you like to explore it again?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.2),
                              foregroundColor: Colors.black,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Close"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFFFBC02D), // Amarillo suave
                              foregroundColor: Colors.black,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Read Again"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReadingSpot_2_1_Page()),
          );

          if (result == true && !completedReading5) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedReadingSpot5', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedReading5 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedReading5,
        title: ' News Around Us',
        description: 'Keep up with the news ',
        alreadyCompleted: completedReading6,
        gradient: const LinearGradient(
          colors: [
            Color(0xFF00BCD4), // cian intenso (base fuerte)
            Color(0xFF26C6DA), // cian brillante
            Color(
                0xFF4DD0E1), // cian claro equilibrado (muy parecido al de la imagen)
            Color(0xFF80DEEA), // cian suave
            Color(0xFFB2EBF2), // cian pastel
            Color(0xFFE0F7FA), // cian muy claro / casi blanco
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.newspaper_rounded,
        imageSize: 20,
        onTap: () async {
          if (!completedReading5) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 200, 221, 249), // Verde suave
                    border: Border.all(
                        color: const Color.fromARGB(255, 74, 231, 255),
                        width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              const Color.fromARGB(255, 74, 231, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }
          if (completedReading6) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1B3A2F), // verde bosque oscuro
                        Color(0xFF2F5D3F), // verde oliva
                        Color(0xFF7ABF8E), // verde suave
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.08),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.book_rounded,
                        size: 50,
                        color: Colors.white70,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "News Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You've already completed this reading.\nWould you like to revisit it?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.4),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Close"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF4CAF50), // verde principal
                              foregroundColor: Colors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Read Again"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReadingSpot_2_2_Page()),
          );

          if (result == true && !completedReading5) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedReadingSpot6', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedReading6 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedReading6,
        title: 'Imagination Station',
        description: 'Immerse yourself in stories',
        alreadyCompleted: completedReading7,
        gradient: const LinearGradient(
          colors: [
            Color(0xFF00BCD4), // cian intenso (base fuerte)
            Color(0xFF26C6DA), // cian brillante
            Color(
                0xFF4DD0E1), // cian claro equilibrado (muy parecido al de la imagen)
            Color(0xFF80DEEA), // cian suave
            Color(0xFFB2EBF2), // cian pastel
            Color(0xFFE0F7FA), // cian muy claro / casi blanco
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.interests_rounded,
        imageSize: 20,
        onTap: () async {
          if (!completedReading6) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 200, 221, 249), // Verde suave
                    border: Border.all(
                        color: const Color.fromARGB(255, 74, 231, 255),
                        width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              const Color.fromARGB(255, 74, 231, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }
          if (completedReading7) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1E2A38),
                        Color(0xFF2F3D4C),
                        Color(0xFF5C7893), // azul grisáceo
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.08),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.auto_stories_outlined,
                        size: 50,
                        color: Colors.white70,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Story Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You've already explored this tale.\nWould you like to read it again?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.4),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Close"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF4B99C3), // azul pastel
                              foregroundColor: Colors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Read Again"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReadingSpot_2_3_Page()),
          );

          if (result == true && !completedReading7) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedReadingSpot7', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedReading7 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedReading7,
        // Cambiar
        title: 'Idea Vault',
        description: 'Unlock new words ',
        alreadyCompleted: completedReading8,
        gradient: const LinearGradient(
          colors: [
            Color(0xFF00BCD4), // cian intenso (base fuerte)
            Color(0xFF26C6DA), // cian brillante
            Color(
                0xFF4DD0E1), // cian claro equilibrado (muy parecido al de la imagen)
            Color(0xFF80DEEA), // cian suave
            Color(0xFFB2EBF2), // cian pastel
            Color(0xFFE0F7FA), // cian muy claro / casi blanco
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.search_rounded,
        imageSize: 20,
        onTap: () async {
          if (!completedReading7) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 200, 221, 249), // Verde suave
                    border: Border.all(
                        color: const Color.fromARGB(255, 74, 231, 255),
                        width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              const Color.fromARGB(255, 74, 231, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }
          if (completedReading8) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF2B1B3D), // morado oscuro
                        Color(0xFF4B326F), // violeta medio
                        Color(0xFF9F87C3), // lila claro
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.06),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.article_rounded,
                        size: 52,
                        color: Colors.white70,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "📰 Article Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You've already completed this article.\nWould you like to read it again?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.3),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Close"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF9C27B0), // morado brillante
                              foregroundColor: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Read Again"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReadingSpot_2_4_Page()),
          );

          if (result == true && !completedReading8) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedReadingSpot8', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedReading8 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedReading8,
        title: 'Lexical Lockdown',
        description: 'Test your lexical inference skills',
        alreadyCompleted: completedCheckpoint2,
        gradient: const LinearGradient(
          colors: [
            Color(0xFF00BCD4), // cian intenso (base fuerte)
            Color(0xFF26C6DA), // cian brillante
            Color(
                0xFF4DD0E1), // cian claro equilibrado (muy parecido al de la imagen)
            Color(0xFF80DEEA), // cian suave
            Color(0xFFB2EBF2), // cian pastel
            Color(0xFFE0F7FA), // cian muy claro / casi blanco
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.star_rounded,
        imageSize: 20,
        onTap: () async {
          if (!completedReading8) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 200, 221, 249),
                    border: Border.all(
                        color: const Color.fromARGB(255, 74, 231, 255),
                        width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              const Color.fromARGB(255, 74, 231, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }
          if (completedCheckpoint2) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF00BCD4), // cian intenso (base fuerte)
                        Color(0xFF26C6DA), // cian brillante
                        Color(
                            0xFF4DD0E1), // cian claro equilibrado (muy parecido al de la imagen)
                        Color(0xFF80DEEA), // cian suave
                        Color(0xFFB2EBF2), // cian pastel
                        Color(0xFFE0F7FA), // cian muy claro / casi blanco
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 25, 118, 210),
                        blurRadius: 22,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Color.fromARGB(255, 25, 118, 210),
                      width: 1.4,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.fact_check_outlined,
                        size: 52,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Test Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Título negro
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        "You've already completed this test.\nWould you like to try it again to reinforce your learning?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.black87, // Texto gris oscuro
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context, true),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: Colors.white,
                                shadowColor: Color.fromARGB(255, 25, 118, 210),
                                elevation: 4,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.refresh,
                                      color: Color.fromARGB(255, 25, 118, 210)),
                                  SizedBox(width: 6),
                                  Text(
                                    "Repeat Test",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 25, 118, 210),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TestIntroBlue()),
          );

          if (result == true && !completedCheckpoint2) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedCheckpoint2', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedCheckpoint2 = true;
            });
          }
        },
      ),
//---------------------------------------------------------------------------------------------------------------------
      SpotWidget(
          isLocked: !completedCheckpoint2,
          title: 'Explanatory Hub',
          description: 'Understand how ideas are explained',
          alreadyCompleted: completedInstruction3_1,
          gradient: const LinearGradient(
            colors: [
              Color(0xFF0D47A1), // azul muy oscuro
              Color(0xFF1565C0), // azul fuerte
              Color(0xFF1976D2), // azul medio
              Color(0xFF42A5F5), // azul claro
              Color(0xFF90CAF9), // azul muy claro
              Color(0xFFE3F2FD), // casi blanco con tinte azul
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          icon: Icons.rocket_launch_rounded,
          onTap: () async {
            if (!completedCheckpoint2) {
              await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => AlertDialog(
                  backgroundColor: Colors.transparent,
                  contentPadding: EdgeInsets.zero,
                  insetPadding: const EdgeInsets.all(20),
                  content: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                          255, 189, 205, 255), // Verde suave
                      border: Border.all(
                          color: const Color.fromARGB(255, 64, 80, 253),
                          width: 2), // Borde verde
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                            backgroundColor:
                                const Color.fromARGB(255, 64, 80, 253),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  ),
                ),
              );
              return;
            }
            // Ambos stages completados
            if (completedInstruction3 && completedInstruction3_1) {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  backgroundColor: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF0D47A1), // azul muy oscuro
                          Color(0xFF1565C0), // azul fuerte
                          Color(0xFF1976D2), // azul medio
                          Color(0xFF42A5F5), // azul claro
                          Color(0xFF90CAF9), // azul muy claro
                          Color(0xFFE3F2FD), // casi blanco con tinte azul
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.black12,
                        width: 1.2,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.school_rounded,
                          size: 54,
                          color: Color.fromARGB(
                              255, 255, 255, 255), // gris metálico oscuro
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Instruction Spot Completed",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Cinzel',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B1B1B), // negro profundo
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          "You've already completed this level.\nWould you like to revisit it to reinforce your skills?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            color: Color.fromARGB(255, 1, 1, 1), // gris oscuro
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => Navigator.pop(context, true),
                              icon: const Icon(Icons.refresh_rounded,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              label: const Text("View All Stages"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                    0xFF0D47A1), // verde profesional
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                elevation: 5,
                                shadowColor:
                                    const Color(0xFF0D47A1).withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );

              if (confirm == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RepeatInstructionSpot3Page(),
                  ),
                );
                return;
              } else {
                return;
              }
            }

            // Ya completó el primer stage
            if (completedInstruction3) {
              final choice = await showDialog<String>(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 207, 240, 250),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: Color(0xFF0D47A1),
                      width: 2,
                    ),
                  ),
                  titlePadding:
                      const EdgeInsets.only(top: 24, left: 24, right: 24),
                  title: const Center(
                    child: Text(
                      "Stage Completed!",
                      style: TextStyle(
                        color: Color.fromARGB(255, 67, 34, 255),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  content: const Text(
                    "You've already completed the first stage.\nWould you like to repeat it or go to the next one?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 12),
                        Flexible(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context, 'next'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 139, 151, 255),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text("Continue to see the next",
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
              if (choice == 'next') {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RepeatInstructionSpot3Page(),
                  ),
                );

                if (result == true && !completedInstruction3_1) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('completedInstructionSpot3_1', true);

                  setState(() {
                    completedInstruction3_1 = true;
                  });
                }
              }

              return;
            }

            // Primer acceso
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const RepeatInstructionSpot3Page(),
              ),
            );

            if (result == true && !completedInstruction3) {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('completedInstructionSpot3', true);

              int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
              await prefs.setInt('completedSpotsCount', completedCount + 1);

              setState(() {
                completedInstruction3 = true;
              });
            }
          }),
//---------------------------------------------------------------------------------------------------------------------
      SpotWidget(
        isLocked: !completedInstruction3,
        title: 'Motivations & Paths',
        description: 'Explore what drives people',
        alreadyCompleted: completedReading9,
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0D47A1), // azul muy oscuro
            Color(0xFF1565C0), // azul fuerte
            Color(0xFF1976D2), // azul medio
            Color(0xFF42A5F5), // azul claro
            Color(0xFF90CAF9), // azul muy claro
            Color(0xFFE3F2FD), // casi blanco con tinte azul
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.person_rounded, //Maybe change the icon color
        imageSize: 20,
        onTap: () async {
          if (!completedInstruction3) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 189, 205, 255), // Verde suave
                    border: Border.all(
                        color: const Color.fromARGB(255, 64, 80, 253),
                        width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              const Color.fromARGB(255, 64, 80, 253),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }

          if (completedReading9) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFAF3D3), // beige claro
                        Color(0xFFF6D365), // amarillo pastel
                        Color(0xFFFDAE6B), // naranja suave dorado
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.25),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.menu_book_rounded,
                        size: 50,
                        color: Color(0xFF8B6B2F), // dorado quemado
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Biography Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You've already completed this reading.\nWould you like to explore it again?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.2),
                              foregroundColor: Colors.black,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Close"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFFFBC02D), // Amarillo suave
                              foregroundColor: Colors.black,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Read Again"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReadingSpot_3_1_Page()),
          );

          if (result == true && !completedReading9) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedReadingSpot9', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedReading9 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedReading9,
        title: 'The World Today',
        description: 'Follow current events',
        alreadyCompleted: completedReading10,
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0D47A1), // azul muy oscuro
            Color(0xFF1565C0), // azul fuerte
            Color(0xFF1976D2), // azul medio
            Color(0xFF42A5F5), // azul claro
            Color(0xFF90CAF9), // azul muy claro
            Color(0xFFE3F2FD), // casi blanco con tinte azul
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.newspaper_rounded, //Maybe change the icon color
        imageSize: 20,
        onTap: () async {
          if (!completedReading9) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 209, 227, 249), // Verde suave
                    border: Border.all(
                        color: const Color.fromARGB(255, 64, 80, 253),
                        width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              const Color.fromARGB(255, 64, 80, 253),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }
          if (completedReading10) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1B3A2F), // verde bosque oscuro
                        Color(0xFF2F5D3F), // verde oliva
                        Color(0xFF7ABF8E), // verde suave
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.08),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.book_rounded,
                        size: 50,
                        color: Colors.white70,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "News Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You've already completed this reading.\nWould you like to revisit it?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.4),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Close"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF4CAF50), // verde principal
                              foregroundColor: Colors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Read Again"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReadingSpot_3_2_Page()),
          );

          if (result == true && !completedReading9) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedReadingSpot10', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedReading10 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedReading10,
        title: 'The Story Room',
        description: 'Uncover meaning in stories',
        alreadyCompleted: completedReading11,
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0D47A1), // azul muy oscuro
            Color(0xFF1565C0), // azul fuerte
            Color(0xFF1976D2), // azul medio
            Color(0xFF42A5F5), // azul claro
            Color(0xFF90CAF9), // azul muy claro
            Color(0xFFE3F2FD), // casi blanco con tinte azul
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.interests_rounded, //Maybe change the icon color
        imageSize: 20,
        onTap: () async {
          if (!completedReading10) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 209, 227, 249), // Verde suave
                    border: Border.all(
                        color: const Color.fromARGB(255, 64, 80, 253),
                        width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              const Color.fromARGB(255, 64, 80, 253),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }
          if (completedReading11) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1E2A38),
                        Color(0xFF2F3D4C),
                        Color(0xFF5C7893), // azul grisáceo
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.08),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.auto_stories_outlined,
                        size: 50,
                        color: Colors.white70,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Story Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You've already explored this tale.\nWould you like to read it again?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.4),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Close"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF4B99C3), // azul pastel
                              foregroundColor: Colors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Read Again"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReadingSpot_3_3_Page()),
          );

          if (result == true && !completedReading9) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedReadingSpot11', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedReading11 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedReading11,
        title: ' Insight Station',
        description: 'Break down complex ideas',
        alreadyCompleted: completedReading12,
        icon: Icons.search_rounded, //Maybe change the icon color
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0D47A1), // azul muy oscuro
            Color(0xFF1565C0), // azul fuerte
            Color(0xFF1976D2), // azul medio
            Color(0xFF42A5F5), // azul claro
            Color(0xFF90CAF9), // azul muy claro
            Color(0xFFE3F2FD), // casi blanco con tinte azul
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        onTap: () async {
          if (!completedReading11) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 209, 227, 249), // Verde suave
                    border: Border.all(
                        color: const Color.fromARGB(255, 64, 80, 253),
                        width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              const Color.fromARGB(255, 64, 80, 253),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }
          if (completedReading12) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF2B1B3D), // morado oscuro
                        Color(0xFF4B326F), // violeta medio
                        Color(0xFF9F87C3), // lila claro
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.06),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.article_rounded,
                        size: 52,
                        color: Colors.white70,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "📰 Article Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You've already completed this article.\nWould you like to read it again?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.3),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Close"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF9C27B0), // morado brillante
                              foregroundColor: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Read Again"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReadingSpot_3_4_Page()),
          );

          if (result == true && !completedReading9) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedReadingSpot12', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedReading12 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedReading12,
        title: 'Explanation Gate',
        description: 'Test your explanatory inference skills',
        alreadyCompleted: completedCheckpoint3,
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0D47A1), // azul muy oscuro
            Color(0xFF1565C0), // azul fuerte
            Color(0xFF1976D2), // azul medio
            Color(0xFF42A5F5), // azul claro
            Color(0xFF90CAF9), // azul muy claro
            Color(0xFFE3F2FD), // casi blanco con tinte azul
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.star_rounded,
        imageSize: 20,
        onTap: () async {
          if (!completedReading12) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 209, 227, 249), // Verde suave
                    border: Border.all(
                        color: const Color.fromARGB(255, 64, 80, 253),
                        width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              const Color.fromARGB(255, 64, 80, 253),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }
          if (completedCheckpoint3) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 13, 71, 161), // azul muy oscuro
                        Color(0xFF1565C0), // azul fuerte
                        Color(0xFF1976D2), // azul medio
                        Color(0xFF42A5F5), // azul claro
                        Color(0xFF90CAF9), // azul muy claro
                        Color(0xFFE3F2FD), // casi blanco con tinte azul
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 13, 71, 161),
                        blurRadius: 22,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Color.fromARGB(255, 13, 71, 161),
                      width: 1.4,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.fact_check_outlined,
                        size: 52,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Test Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Título negro
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        "You've already completed this test.\nWould you like to try it again to reinforce your learning?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.black87, // Texto gris oscuro
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context, true),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: Colors.white,
                                shadowColor: Color.fromARGB(255, 13, 71, 161),
                                elevation: 4,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.refresh,
                                      color: Color.fromARGB(255, 13, 71, 161)),
                                  SizedBox(width: 6),
                                  Text(
                                    "Repeat Test",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 13, 71, 161),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TestIntroDarkBlue()),
          );

          if (result == true && !completedCheckpoint3) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedCheckpoint3', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedCheckpoint3 = true;
            });
          }
        },
      ),
//---------------------------------------------------------------------------------------------------------------------
      SpotWidget(
          isLocked: !completedCheckpoint3,
          title: 'Elaboration Core',
          description: 'Organize and connect ideas',
          type: SpotType.instruction,
          icon: Icons.rocket_launch_rounded,
          alreadyCompleted: completedInstruction4_4,
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 180, 75), // Naranja brillante
              Color.fromARGB(255, 255, 160, 50), // Naranja intenso
              Color.fromARGB(255, 255, 140, 40), // Naranja medio
              Color.fromARGB(255, 245, 120, 35), // Naranja quemado
              Color.fromARGB(255, 230, 100, 30), // Naranja oscuro
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          onTap: () async {
            if (!completedCheckpoint3) {
              await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => AlertDialog(
                  backgroundColor: Colors.transparent,
                  contentPadding: EdgeInsets.zero,
                  insetPadding: const EdgeInsets.all(20),
                  content: Container(
                    decoration: BoxDecoration(
                      color:
                          const Color(0xFFFFE3C0), // Fondo naranja claro suave
                      border: Border.all(
                        color:
                            const Color(0xFFFF9800), // Borde naranja vibrante
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(
                                0xFF5A2E00), // Marrón oscuro para contraste
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(
                                0xFFFF9800), // Botón naranja brillante
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            shadowColor: const Color(0xFFFF6F00),
                            elevation: 4,
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  ),
                ),
              );
              return;
            }

            if (completedInstruction4_4) {
              final bool? result = await showDialog<bool>(
                context: context,
                builder: (_) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  backgroundColor: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(
                              255, 255, 180, 75), // Naranja brillante
                          Color.fromARGB(255, 255, 160, 50), // Naranja intenso
                          Color.fromARGB(255, 255, 140, 40), // Naranja medio
                          Color.fromARGB(255, 245, 120, 35), // Naranja quemado
                          Color.fromARGB(255, 230, 100, 30), // Naranja oscuro
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.black12,
                        width: 1.2,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.school_rounded,
                          size: 54,
                          color: Color(0xFF424242),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Instruction Spot Completed",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Cinzel',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B1B1B),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          "You've already completed this level.\nWould you like to revisit it to reinforce your skills?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            color: Color(0xFF444444),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => Navigator.pop(context, true),
                              icon: const Icon(
                                Icons.refresh_rounded,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              label: const Text("View All Stages"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 180, 75),
                                foregroundColor:
                                    const Color.fromARGB(255, 0, 0, 0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                elevation: 5,
                                shadowColor:
                                    const Color.fromARGB(255, 255, 180, 75),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );

              // ✅ AQUÍ YA FUNCIONA
              if (result == true) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AllInstructionSpotsPageFinal(),
                  ),
                );
              }

              return;
            }

            if (completedInstruction4_3) {
              final choice = await showDialog<String>(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color.fromARGB(
                      255, 255, 243, 224), // Fondo crema cálido
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color:
                          Color.fromARGB(255, 255, 171, 64), // Naranja fuerte
                      width: 2,
                    ),
                  ),
                  titlePadding: const EdgeInsets.only(
                    top: 24,
                    left: 24,
                    right: 24,
                    bottom: 0,
                  ),
                  title: Stack(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "🔥 Fourth Stage Completed!",
                          style: TextStyle(
                            color: Color.fromARGB(
                                255, 230, 81, 0), // Naranja intenso
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: -8,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.black87),
                          onPressed: () => Navigator.pop(context, 'cancel'),
                          tooltip: 'Close',
                        ),
                      ),
                    ],
                  ),
                  content: const Text(
                    "You’ve successfully completed the Fourth stage! 🎯\n\nWould you like to review the previous stages or move on to the final challenge?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 121, 85, 72), // Marrón suave
                    ),
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, 'continue5'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 255, 111, 0), // Botón ámbar fuerte
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                      ),
                      child: const Text("⏭ Continue"),
                    ),
                  ],
                ),
              );
              if (choice == 'continue5') {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AllInstructionSpotsPageFinal(),
                  ),
                );
              }
            }

//-------------------------------------------------------------------------------------stage 4
            else if (completedInstruction4_2) {
              // Si ya completó el tercer stage, mostrar diálogo especial
              final choice = await showDialog<String>(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color.fromARGB(
                      255, 255, 243, 224), // Fondo crema cálido
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color:
                          Color.fromARGB(255, 255, 171, 64), // Naranja fuerte
                      width: 2,
                    ),
                  ),
                  titlePadding: const EdgeInsets.only(
                    top: 24,
                    left: 24,
                    right: 24,
                    bottom: 0,
                  ),
                  title: Stack(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "🔥 Third Stage Completed!",
                          style: TextStyle(
                            color: Color.fromARGB(
                                255, 230, 81, 0), // Naranja intenso
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: -8,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.black87),
                          onPressed: () => Navigator.pop(context, 'cancel'),
                          tooltip: 'Close',
                        ),
                      ),
                    ],
                  ),
                  content: const Text(
                    "You’ve already completed the third stage.\n\nWould you like to review the previous stages or continue to the next one?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 121, 85, 72), // Marrón suave
                    ),
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, 'continue4'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 255, 111, 0), // Botón ámbar fuerte
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                      ),
                      child: const Text("⏭️ Continue to 4th Stage"),
                    ),
                  ],
                ),
              );
              if (choice == 'continue4') {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AllInstructionSpotsPageFinal(),
                  ),
                );
              }

//-------------------------------------------------------------- tercer Stage
            } else if (completedInstruction4_1) {
              final choice = await showDialog<String>(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor:
                      const Color(0xFFFFF3E0), // Fondo naranja suave
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: Color(0xFFFF9800), // Borde naranja fuerte
                      width: 2,
                    ),
                  ),
                  titlePadding: const EdgeInsets.only(
                      top: 24, left: 24, right: 24, bottom: 0),
                  title: Stack(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Stage Completed!",
                          style: TextStyle(
                            color: Color(0xFFFF9800),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: -8,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.black54),
                          onPressed: () => Navigator.pop(context, 'cancel'),
                          tooltip: 'Close',
                        ),
                      ),
                    ],
                  ),
                  content: const Text(
                    "You've completed this stage successfully!\n\nWould you like to move on to the next one or explore the previous spots?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Color(0xFFEF6C00)),
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal, // 🔸 Scroll horizontal
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 16),
                          ElevatedButton.icon(
                            onPressed: () => Navigator.pop(context, 'next'),
                            icon: const Icon(Icons.arrow_forward_ios,
                                color: Colors.white),
                            label: const Text("Next Spot"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFB74D),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
              if (choice == 'next') {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AllInstructionSpotsPageFinal(),
                  ),
                );
              }

//-------------------------------------------------------------- segundo Stage
            } else if (completedInstruction4) {
              final choice = await showDialog<String>(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 255, 237, 182),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 255, 149, 1),
                      width: 2,
                    ),
                  ),
                  titlePadding: const EdgeInsets.only(
                      top: 24, left: 24, right: 24, bottom: 0),
                  title: Stack(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Stage already completed",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 149, 1),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: -8,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.black),
                          onPressed: () => Navigator.pop(context, 'cancel'),
                          tooltip: 'Close',
                        ),
                      ),
                    ],
                  ),
                  content: const Text(
                    "You've already completed this first stage.\n\nWould you like to repeat it or continue to the next one?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, 'next'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 149, 1),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Next"),
                    ),
                  ],
                ),
              );

              if (choice == 'next') {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AllInstructionSpotsPageFinal(),
                  ),
                );
              }
            } else {
//----------------------------------------- Primer acceso
              // Primer acceso
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AllInstructionSpotsPageFinal(),
                ),
              );

              if (result == true && !completedInstruction4) {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('completedInstructionSpot4', true);

                int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
                await prefs.setInt('completedSpotsCount', completedCount + 1);

                setState(() {
                  completedInstruction4 = true;
                  completedInstruction4_1 = true;
                  completedInstruction4_2 = true;
                  completedInstruction4_3 = true;
                  completedInstruction4_4 = true;
                });
              }
            }
          }),
      SpotWidget(
        isLocked: !completedInstruction4_4,
        title: 'Depth Profiles',
        description: 'Examine lives in depth',
        icon: Icons.person_rounded,
        alreadyCompleted: completedReading13,
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 180, 75), // Naranja brillante
            Color.fromARGB(255, 255, 160, 50), // Naranja intenso
            Color.fromARGB(255, 255, 140, 40), // Naranja medio
            Color.fromARGB(255, 245, 120, 35), // Naranja quemado
            Color.fromARGB(255, 230, 100, 30), // Naranja oscuro
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        onTap: () async {
          if (!completedInstruction4_4) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        255, 255, 232, 200), // Fondo naranja claro
                    border: Border.all(
                      color: const Color.fromARGB(
                          255, 255, 145, 0), // Borde naranja intenso
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromARGB(
                              255, 255, 145, 0), // Botón naranja vibrante
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          shadowColor: const Color.fromARGB(150, 255, 94, 0),
                          elevation: 4,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }

          if (completedReading13) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFAF3D3), // beige claro
                        Color(0xFFF6D365), // amarillo pastel
                        Color(0xFFFDAE6B), // naranja suave dorado
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.25),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.menu_book_rounded,
                        size: 50,
                        color: Color(0xFF8B6B2F), // dorado quemado
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Biography Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You've already completed this reading.\nWould you like to explore it again?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.2),
                              foregroundColor: Colors.black,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Close"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFFFBC02D), // Amarillo suave
                              foregroundColor: Colors.black,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Read Again"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReadingSpot4_1Page()),
          );

          if (result == true && !completedReading5) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedReadingSpot13', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedReading13 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedReading13,
        title: 'The News Desk',
        description: 'Make sense of the news',
        icon: Icons.newspaper_rounded,
        alreadyCompleted: completedReading14,
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 180, 75), // Naranja brillante
            Color.fromARGB(255, 255, 160, 50), // Naranja intenso
            Color.fromARGB(255, 255, 140, 40), // Naranja medio
            Color.fromARGB(255, 245, 120, 35), // Naranja quemado
            Color.fromARGB(255, 230, 100, 30), // Naranja oscuro
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        onTap: () async {
          if (!completedReading13) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        255, 255, 232, 200), // Fondo naranja claro
                    border: Border.all(
                      color: const Color.fromARGB(
                          255, 255, 145, 0), // Borde naranja intenso
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromARGB(
                              255, 255, 145, 0), // Botón naranja vibrante
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          shadowColor: const Color.fromARGB(150, 255, 94, 0),
                          elevation: 4,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }

          if (completedReading14) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1B3A2F), // verde bosque oscuro
                        Color(0xFF2F5D3F), // verde oliva
                        Color(0xFF7ABF8E), // verde suave
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.08),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.book_rounded,
                        size: 50,
                        color: Colors.white70,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "News Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You've already completed this reading.\nWould you like to revisit it?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.4),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Close"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF4CAF50), // verde principal
                              foregroundColor: Colors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Read Again"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReadingSpot4_2Page()),
          );

          if (result == true && !completedReading5) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedReadingSpot14', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedReading14 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedReading14,
        title: 'Wonder Tales',
        description: 'Grow ideas through stories',
        icon: Icons.interests_rounded,
        alreadyCompleted: completedReading15,
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 180, 75), // Naranja brillante
            Color.fromARGB(255, 255, 160, 50), // Naranja intenso
            Color.fromARGB(255, 255, 140, 40), // Naranja medio
            Color.fromARGB(255, 245, 120, 35), // Naranja quemado
            Color.fromARGB(255, 230, 100, 30), // Naranja oscuro
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        onTap: () async {
          if (!completedReading14) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        255, 255, 232, 200), // Fondo naranja claro
                    border: Border.all(
                      color: const Color.fromARGB(
                          255, 255, 145, 0), // Borde naranja intenso
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromARGB(
                              255, 255, 145, 0), // Botón naranja vibrante
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          shadowColor: const Color.fromARGB(150, 255, 94, 0),
                          elevation: 4,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }

          if (completedReading15) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1E2A38),
                        Color(0xFF2F3D4C),
                        Color(0xFF5C7893), // azul grisáceo
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.08),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.auto_stories_outlined,
                        size: 50,
                        color: Colors.white70,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Story Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You've already explored this tale.\nWould you like to read it again?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.4),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Close"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF4B99C3), // azul pastel
                              foregroundColor: Colors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Read Again"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReadingSpot4_3Page()),
          );

          if (result == true && !completedReading5) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedReadingSpot15', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedReading15 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedReading15,
        title: 'Think Tank',
        description: 'Develop deeper thinking',
        icon: Icons.search_rounded,
        alreadyCompleted: completedReading16,
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 180, 75), // Naranja brillante
            Color.fromARGB(255, 255, 160, 50), // Naranja intenso
            Color.fromARGB(255, 255, 140, 40), // Naranja medio
            Color.fromARGB(255, 245, 120, 35), // Naranja quemado
            Color.fromARGB(255, 230, 100, 30), // Naranja oscuro
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        onTap: () async {
          if (!completedReading15) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        255, 255, 232, 200), // Fondo naranja claro
                    border: Border.all(
                      color: const Color.fromARGB(
                          255, 255, 145, 0), // Borde naranja intenso
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromARGB(
                              255, 255, 145, 0), // Botón naranja vibrante
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          shadowColor: const Color.fromARGB(150, 255, 94, 0),
                          elevation: 4,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }

          if (completedReading16) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF2B1B3D), // morado oscuro
                        Color(0xFF4B326F), // violeta medio
                        Color(0xFF9F87C3), // lila claro
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.06),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.article_rounded,
                        size: 52,
                        color: Colors.white70,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        " Article Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You've already completed this article.\nWould you like to read it again?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.3),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Close"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF9C27B0), // morado brillante
                              foregroundColor: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Read Again"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReadingSpot4_4Page()),
          );

          if (result == true && !completedReading5) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedReadingSpot16', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedReading16 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedReading16,
        title: 'Elaboration Portal',
        description: 'Test your informational inference skills',
        type: SpotType.checkpoint,
        icon: Icons.star_rounded,
        alreadyCompleted: completedCheckpoint4,
        color: null, // eliminamos color directo para usar gradient
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 180, 75), // Naranja brillante
            Color.fromARGB(255, 255, 160, 50), // Naranja intenso
            Color.fromARGB(255, 255, 140, 40), // Naranja medio
            Color.fromARGB(255, 245, 120, 35), // Naranja quemado
            Color.fromARGB(255, 230, 100, 30), // Naranja oscuro
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        onTap: () async {
          if (!completedReading16) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        255, 255, 232, 200), // Fondo naranja claro
                    border: Border.all(
                      color: const Color.fromARGB(
                          255, 255, 145, 0), // Borde naranja intenso
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromARGB(
                              255, 255, 145, 0), // Botón naranja vibrante
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          shadowColor: const Color.fromARGB(150, 255, 94, 0),
                          elevation: 4,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }
          if (completedCheckpoint4) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 180, 75), // Naranja brillante
                        Color.fromARGB(255, 255, 160, 50), // Naranja intenso
                        Color.fromARGB(255, 255, 140, 40), // Naranja medio
                        Color.fromARGB(255, 245, 120, 35), // Naranja quemado
                        Color.fromARGB(255, 230, 100, 30), // Naranja oscuro
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 255, 180, 75),
                        blurRadius: 22,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Color.fromARGB(255, 255, 180, 75),
                      width: 1.4,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.fact_check_outlined,
                        size: 52,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Test Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Título negro
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        "You've already completed this test.\nWould you like to try it again to reinforce your learning?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.black87, // Texto gris oscuro
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context, true),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: Colors.white,
                                shadowColor: Color.fromARGB(255, 255, 140, 40),
                                elevation: 4,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.refresh,
                                      color: Color.fromARGB(255, 255, 140, 40)),
                                  SizedBox(width: 6),
                                  Text(
                                    "Repeat Test",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 255, 180, 75),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TestIntro4()),
          );

          if (result == true && !completedCheckpoint4) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedCheckpoint4', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedCheckpoint4 = true;
            });
          }
        },
      ),

//------------------------------------------------------------------------------
      SpotWidget(
        isLocked: !completedCheckpoint4,
        title: 'Prediction Nexus',
        description: 'Anticipate what comes next',
        type: SpotType.instruction,
        icon: Icons.rocket_launch_rounded,
        alreadyCompleted: completedInstruction5_1,
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(247, 173, 60, 254),
            Color.fromARGB(247, 150, 80, 245),
            Color.fromARGB(255, 130, 105, 240),
            Color.fromARGB(255, 115, 120, 238),
            Color.fromARGB(255, 102, 129, 237),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        onTap: () async {
          if (!completedCheckpoint4) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 209, 227, 249), // Verde suave
                    border: Border.all(
                        color: const Color.fromARGB(255, 64, 80, 253),
                        width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              const Color.fromARGB(255, 64, 80, 253),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }
          // Ambos stages completados
          if (completedInstruction5 && completedInstruction5_1) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(247, 173, 60, 254),
                        Color.fromARGB(247, 150, 80, 245),
                        Color.fromARGB(255, 130, 105, 240),
                        Color.fromARGB(255, 115, 120, 238),
                        Color.fromARGB(255, 102, 129, 237),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                      width: 1.4,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.school_rounded,
                        size: 54,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Instruction Spot Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        "You've already completed this level.\nWould you like to revisit it to reinforce your skills?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.pop(context, true),
                        icon: const Icon(Icons.refresh_rounded,
                            color: Colors.black),
                        label: const Text(
                          "View All Stages",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          elevation: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm == true) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RepeatInstructionSpot5Page(),
                ),
              );
              return;
            } else {
              return;
            }
          }

          // Stage 1 completado
          if (completedInstruction5) {
            final choice = await showDialog<String>(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                content: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(247, 173, 60, 254),
                        Color.fromARGB(247, 150, 80, 245),
                        Color.fromARGB(255, 130, 105, 240),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(color: Colors.white70, width: 1.3),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Stage Completed!",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "You've already completed the first stage.\nWould you like to repeat it or go to the next one?",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70, fontSize: 15),
                      ),
                      const SizedBox(height: 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 14),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, 'next'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text("view next stage"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
            if (choice == 'next') {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RepeatInstructionSpot5Page(),
                ),
              );

              if (result == true && !completedInstruction5_1) {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('completedInstructionSpot5_1', true);

                setState(() {
                  completedInstruction5_1 = true;
                });
              }
            }

            return;
          }

          // Primer acceso
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const RepeatInstructionSpot5Page(),
            ),
          );

          if (result == true && !completedInstruction5) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedInstructionSpot5', true);

            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedInstruction5 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedInstruction5_1,
        title: 'Great Lives',
        description: 'Predict paths and outcomes',
        icon: Icons.person_rounded,
        alreadyCompleted: completedReading17,
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(247, 173, 60, 254), // Morado fuerte
            Color.fromARGB(247, 150, 80, 245), // Morado intermedio
            Color.fromARGB(255, 130, 105, 240), // Morado-azulado
            Color.fromARGB(255, 115, 120, 238), // Azul violeta
            Color.fromARGB(255, 102, 129, 237), // Azul
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        onTap: () async {
          if (!completedInstruction5_1) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 209, 227, 249), // Verde suave
                    border: Border.all(
                        color: const Color.fromARGB(255, 64, 80, 253),
                        width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              const Color.fromARGB(255, 64, 80, 253),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }

          if (completedReading17) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFAF3D3), // beige claro
                        Color(0xFFF6D365), // amarillo pastel
                        Color(0xFFFDAE6B), // naranja suave dorado
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.25),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.menu_book_rounded,
                        size: 50,
                        color: Color(0xFF8B6B2F), // dorado quemado
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Biography Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You've already completed this reading.\nWould you like to explore it again?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.2),
                              foregroundColor: Colors.black,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Close"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFFFBC02D), // Amarillo suave
                              foregroundColor: Colors.black,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Read Again"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReadingSpot5_1Page()),
          );

          if (result == true && !completedReading5) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedReadingSpot17', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedReading17 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedReading17,
        title: 'Today’s Reports',
        description: 'Forecast real-world events',
        icon: Icons.newspaper_rounded,
        alreadyCompleted: completedReading18,
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(247, 173, 60, 254), // Morado fuerte
            Color.fromARGB(247, 150, 80, 245), // Morado intermedio
            Color.fromARGB(255, 130, 105, 240), // Morado-azulado
            Color.fromARGB(255, 115, 120, 238), // Azul violeta
            Color.fromARGB(255, 102, 129, 237), // Azul
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        onTap: () async {
          if (!completedReading17) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 209, 227, 249), // Verde suave
                    border: Border.all(
                        color: const Color.fromARGB(255, 64, 80, 253),
                        width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              const Color.fromARGB(255, 64, 80, 253),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }

          if (completedReading18) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1B3A2F), // verde bosque oscuro
                        Color(0xFF2F5D3F), // verde oliva
                        Color(0xFF7ABF8E), // verde suave
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.08),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.book_rounded,
                        size: 50,
                        color: Colors.white70,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "News Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You've already completed this reading.\nWould you like to revisit it?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.4),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Close"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF4CAF50), // verde principal
                              foregroundColor: Colors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Read Again"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReadingSpot5_2Page()),
          );

          if (result == true && !completedReading18) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedReadingSpot18', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedReading18 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedReading18,
        title: 'Timeless Tales',
        description: 'Anticipate story developments',
        icon: Icons.interests_rounded,
        alreadyCompleted: completedReading19,
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(247, 173, 60, 254), // Morado fuerte
            Color.fromARGB(247, 150, 80, 245), // Morado intermedio
            Color.fromARGB(255, 130, 105, 240), // Morado-azulado
            Color.fromARGB(255, 115, 120, 238), // Azul violeta
            Color.fromARGB(255, 102, 129, 237), // Azul
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        onTap: () async {
          if (!completedReading18) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 209, 227, 249), // Verde suave
                    border: Border.all(
                        color: const Color.fromARGB(255, 64, 80, 253),
                        width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              const Color.fromARGB(255, 64, 80, 253),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }

          if (completedReading19) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1E2A38),
                        Color(0xFF2F3D4C),
                        Color(0xFF5C7893),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.08),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.auto_stories_outlined,
                        size: 50,
                        color: Colors.white70,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Story Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You've already explored this tale.\nWould you like to read it again?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.4),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Close"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF4B99C3), // azul pastel
                              foregroundColor: Colors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Read Again"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReadingSpot5_3Page()),
          );

          if (result == true && !completedReading18) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedReadingSpot19', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedReading19 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedReading19,
        title: 'Curiosity Lab',
        description: 'Infer outcomes from ideas',
        icon: Icons.search_rounded,
        alreadyCompleted: completedReading20,
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(247, 173, 60, 254), // Morado fuerte
            Color.fromARGB(247, 150, 80, 245), // Morado intermedio
            Color.fromARGB(255, 130, 105, 240), // Morado-azulado
            Color.fromARGB(255, 115, 120, 238), // Azul violeta
            Color.fromARGB(255, 102, 129, 237), // Azul
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        onTap: () async {
          if (!completedReading19) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 209, 227, 249), // Verde suave
                    border: Border.all(
                        color: const Color.fromARGB(255, 64, 80, 253),
                        width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              const Color.fromARGB(255, 64, 80, 253),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }
          if (completedReading20) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF2B1B3D), // morado oscuro
                        Color(0xFF4B326F), // violeta medio
                        Color(0xFF9F87C3), // lila claro
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.06),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.article_rounded,
                        size: 52,
                        color: Colors.white70,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "📰 Article Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You've already completed this article.\nWould you like to read it again?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.3),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Close"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF9C27B0), // morado brillante
                              foregroundColor: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Read Again"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReadingSpot5_4Page()),
          );

          if (result == true && !completedReading18) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedReadingSpot20', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedReading20 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedReading20,
        title: 'Prediction Star',
        description: 'Test your predictive inference skills',
        type: SpotType.checkpoint,
        icon: Icons.star_rounded,
        alreadyCompleted: completedCheckpoint5,
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(247, 173, 60, 254), // Morado fuerte
            Color.fromARGB(247, 150, 80, 245), // Morado intermedio
            Color.fromARGB(255, 130, 105, 240), // Morado-azulado
            Color.fromARGB(255, 115, 120, 238), // Azul violeta
            Color.fromARGB(255, 102, 129, 237), // Azul
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        onTap: () async {
          if (!completedReading20) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 209, 227, 249), // Verde suave
                    border: Border.all(
                        color: const Color.fromARGB(255, 64, 80, 253),
                        width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Reading Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              const Color.fromARGB(255, 64, 80, 253),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }
          if (completedCheckpoint5) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(247, 173, 60, 254), // Morado fuerte
                        Color.fromARGB(247, 150, 80, 245), // Morado intermedio
                        Color.fromARGB(255, 130, 105, 240), // Morado-azulado
                        Color.fromARGB(255, 115, 120, 238), // Azul violeta
                        Color.fromARGB(255, 102, 129, 237), // Azul
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(247, 173, 60, 254),
                        blurRadius: 22,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Color.fromARGB(247, 173, 60, 254),
                      width: 1.4,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.fact_check_outlined,
                        size: 52,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Test Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Título negro
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        "You've already completed this test.\nWould you like to try it again to reinforce your learning?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.black87, // Texto gris oscuro
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context, true),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: Colors.white,
                                shadowColor: Color.fromARGB(247, 173, 60, 254),
                                elevation: 4,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.refresh,
                                      color: Color.fromARGB(247, 173, 60, 254)),
                                  SizedBox(width: 6),
                                  Text(
                                    "Repeat Test",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(247, 173, 60, 254),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TestIntro5()),
          );

          if (result == true && !completedCheckpoint4) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedCheckpoint5', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedCheckpoint5 = true;
            });
          }
        },
      ),
      SpotWidget(
        isLocked: !completedCheckpoint5,
        title: 'Final Star',
        description: 'The end?  \nProve your mastery now!',
        type: SpotType.finalTest,
        icon: Icons.emoji_events,
        alreadyCompleted: completedFinalTest,
        iconColor: Colors.white,
        gradient: const LinearGradient(
          colors: [
            Color(0xFF000000),
            Color(0xFF333333),
            Color(0xFF666666),
            Color(0xFF999999),
            Color(0xFFCCCCCC),
            Color(0xFFFFFFFF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        onTap: () async {
          if (!completedCheckpoint5) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(20),
                content: Container(
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 209, 227, 249), // Verde suave
                    border: Border.all(
                        color: const Color(0xFF000000),
                        width: 2), // Borde verde
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "📚 Oops! You need to complete the previous Test Spot before unlocking this one. Keep going — you're doing great! 💪",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor: const Color(0xFF000000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return;
          }
          if (completedFinalTest) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF000000),
                        Color(0xFF333333),
                        Color(0xFF666666),
                        Color(0xFF999999),
                        Color(0xFFCCCCCC),
                        Color(0xFFFFFFFF),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 22,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.black,
                      width: 1.4,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        size: 52,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Final Test Already Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Título negro
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        "You've already completed this test.\nWould you like to try it again to reinforce your learning?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.black87, // Texto gris oscuro
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context, true),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: Colors.white,
                                shadowColor: Colors.black,
                                elevation: 4,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.refresh, color: Color(0xFF000000)),
                                  SizedBox(width: 6),
                                  Text(
                                    "Repeat Test",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (confirm != true) return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TestIntroFinal()),
          );

          if (result == true && !completedFinalTest) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('completedFinalTest', true);
            int completedCount = prefs.getInt('completedSpotsCount') ?? 0;
            await prefs.setInt('completedSpotsCount', completedCount + 1);

            setState(() {
              completedFinalTest = true;
            });
          }
        },
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // 🚫 BLOQUEA BACK TOTAL
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Wallpapers/PATHWAY 2.0B.webp"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                if (completedCheckpoint1) const QuizCompletedBanner(),
                if (completedCheckpoint2) const QuizCompletedBannerLevel2(),
                if (completedCheckpoint3) const QuizCompletedBannerLevel3(),
                if (completedCheckpoint4) const QuizCompletedBannerLevel4(),
                if (completedCheckpoint5) const QuizCompletedBannerLevel5(),
                ChapterSection(
                  title: "Reference Planet",
                  subtitle: "Introduction & Basics",
                  isLocked: false,
                  themeColor: const Color(0xFF2E7D32),
                  icon: Icons
                      .public, // Sol para el inicio Icons.public, // Tierra
                  children: _getSpotWidgets().sublist(0, 6),
                ),
                ChapterSection(
                  title: " Lexical Moon",
                  subtitle: "Intermediate Concepts",
                  isLocked: !completedCheckpoint1,
                  themeColor: const Color(0xFF42A5F5),
                  icon: Icons
                      .brightness_3, // Tierra Icons.brightness_3, // Luna/Planeta
                  children: _getSpotWidgets().sublist(6, 12),
                ),
                ChapterSection(
                  title: "Explanation Sun",
                  subtitle: "Advanced Reading",
                  isLocked: !completedCheckpoint2,
                  themeColor: const Color(0xFF1565C0),
                  icon: Icons
                      .wb_sunny, // Luna/Planeta // Icons.wb_sunny, // Sol para el inicio
                  children: _getSpotWidgets().sublist(12, 18),
                ),
                ChapterSection(
                  title: " Constellation of Ideas",
                  subtitle: "Mastery Skills",
                  isLocked: !completedCheckpoint3,
                  themeColor: const Color(0xFFFF8C28),
                  icon: FontAwesomeIcons.meteor, // Planeta gaseoso/grande
                  children: _getSpotWidgets().sublist(18, 24),
                ),
                ChapterSection(
                  title: "Galaxy of Predictions",
                  subtitle: "Final Challenges",
                  isLocked: !completedCheckpoint4,
                  themeColor: const Color(0xF7AD3CFE),
                  icon: Icons.nights_stay, // Otro planeta
                  children: _getSpotWidgets().sublist(24, 30),
                ),
                ChapterSection(
                  title: "Infera Satellite",
                  subtitle: "Test your knowledge",
                  isLocked: !completedCheckpoint5,
                  themeColor: const Color(0xFFF6F6F6),
                  icon: Icons.auto_awesome, // Estrellas/Final
                  children: [_getSpotWidgets().last],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
