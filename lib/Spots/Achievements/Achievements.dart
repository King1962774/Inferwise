import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

class ProgressBar extends StatelessWidget {
  final Map<String, bool> allSpots;

  const ProgressBar({
    super.key,
    required this.allSpots,
  });

  @override
  Widget build(BuildContext context) {
    final total = allSpots.length;
    final completed = allSpots.values.where((v) => v == true).length;
    final progress = total == 0 ? 0 : completed / total;

    return Card(
      elevation: 10,
      shadowColor: const Color.fromARGB(255, 51, 92, 136).withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      color: Colors.deepPurple.shade50,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 25,
          bottom: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TÍTULO
            const Text(
              "Progress Bar",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 51, 92, 136),
              ),
            ),

            const SizedBox(height: 18),

            /// PROGRESS BAR
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 108, 166, 217)
                          .withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Stack(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOut,
                          width: constraints.maxWidth * progress,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(
                                    255, 108, 166, 217), // Powder blue
                                Color(0xFF497BAD),
                                Color.fromARGB(255, 51, 92, 136),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    /// TEXTO CENTRADO
                    Center(
                      child: Text(
                        "${(progress * 100).toStringAsFixed(0)}%",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({super.key});

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  String _username = "User";
  String? _avatarPath;

  // Añade un ValueNotifier para los spots
  final ValueNotifier<Map<String, bool>> _spotsNotifier =
      ValueNotifier<Map<String, bool>>({});

  // Completion flags for all spots (initialized to false)
  bool completedInstruction1 = false;
  bool completedInstruction1_1 = false;

  bool completedReading1 = false;
  bool completedReading2 = false;
  bool completedReading3 = false;
  bool completedReading4 = false;

  bool completedCheckpoint1 = false;

  bool completedInstruction2 = false;
  bool completedInstruction2_1 = false;
  bool completedInstruction2_2 = false;
  bool completedInstruction2_3 = false;

  bool completedReading5 = false;
  bool completedReading6 = false;
  bool completedReading7 = false;
  bool completedReading8 = false;

  bool completedCheckpoint2 = false;

  bool completedInstruction3 = false;
  bool completedInstruction3_1 = false;

  bool completedReading9 = false;
  bool completedReading10 = false;
  bool completedReading11 = false;
  bool completedReading12 = false;

  bool completedCheckpoint3 = false;

  bool completedInstruction4 = false;
  bool completedInstruction4_1 = false;
  bool completedInstruction4_2 = false;
  bool completedInstruction4_3 = false;
  bool completedInstruction4_4 = false;

  bool completedReading13 = false;
  bool completedReading14 = false;
  bool completedReading15 = false;
  bool completedReading16 = false;

  bool completedCheckpoint4 = false;

  bool completedInstruction5 = false;
  bool completedInstruction5_1 = false;

  bool completedReading17 = false;
  bool completedReading18 = false;
  bool completedReading19 = false;
  bool completedReading20 = false;

  bool completedCheckpoint5 = false;

  bool completedFinalTest = false;

  // Cambia el getter por un método
  Map<String, bool> _getAllSpots() {
    return {
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
      "finalTest": completedFinalTest,
    };
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final user = FirebaseAuth.instance.currentUser;

    // --- 1. Cargar datos desde Firestore o SharedPreferences ---
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final data = doc.data();

      if (!mounted) return;

      setState(() {
        _username = data?['username'] ?? prefs.getString('username') ?? "User";
        _avatarPath = data?["profileImage"] ?? prefs.getString("profileImage");
      });
    } else {
      if (!mounted) return;

      setState(() {
        _username = prefs.getString('username') ?? "User";
        _avatarPath = prefs.getString("profileImage");
      });
    }

    // --- 2. Cargar TODOS los completedX desde prefs ---
    if (!mounted) return;

    setState(() {
      completedInstruction1 = prefs.getBool('instruction1') ?? false;
      completedInstruction1_1 = prefs.getBool('instruction1_1') ?? false;

      completedReading1 = prefs.getBool('reading1') ?? false;
      completedReading2 = prefs.getBool('reading2') ?? false;
      completedReading3 = prefs.getBool('reading3') ?? false;
      completedReading4 = prefs.getBool('reading4') ?? false;

      completedCheckpoint1 = prefs.getBool('checkpoint1') ?? false;

      completedInstruction2 = prefs.getBool('instruction2') ?? false;
      completedInstruction2_1 = prefs.getBool('instruction2_1') ?? false;
      completedInstruction2_2 = prefs.getBool('instruction2_2') ?? false;
      completedInstruction2_3 = prefs.getBool('instruction2_3') ?? false;

      completedReading5 = prefs.getBool('reading5') ?? false;
      completedReading6 = prefs.getBool('reading6') ?? false;
      completedReading7 = prefs.getBool('reading7') ?? false;
      completedReading8 = prefs.getBool('reading8') ?? false;

      completedCheckpoint2 = prefs.getBool('checkpoint2') ?? false;

      completedInstruction3 = prefs.getBool('instruction3') ?? false;
      completedInstruction3_1 = prefs.getBool('instruction3_1') ?? false;

      completedReading9 = prefs.getBool('reading9') ?? false;
      completedReading10 = prefs.getBool('reading10') ?? false;
      completedReading11 = prefs.getBool('reading11') ?? false;
      completedReading12 = prefs.getBool('reading12') ?? false;

      completedCheckpoint3 = prefs.getBool('checkpoint3') ?? false;

      completedInstruction4 = prefs.getBool('instruction4') ?? false;
      completedInstruction4_1 = prefs.getBool('instruction4_1') ?? false;
      completedInstruction4_2 = prefs.getBool('instruction4_2') ?? false;
      completedInstruction4_3 = prefs.getBool('instruction4_3') ?? false;
      completedInstruction4_4 = prefs.getBool('instruction4_4') ?? false;

      completedReading13 = prefs.getBool('reading13') ?? false;
      completedReading14 = prefs.getBool('reading14') ?? false;
      completedReading15 = prefs.getBool('reading15') ?? false;
      completedReading16 = prefs.getBool('reading16') ?? false;

      completedCheckpoint4 = prefs.getBool('checkpoint4') ?? false;

      completedInstruction5 = prefs.getBool('instruction5') ?? false;
      completedInstruction5_1 = prefs.getBool('instruction5_1') ?? false;

      completedReading17 = prefs.getBool('reading17') ?? false;
      completedReading18 = prefs.getBool('reading18') ?? false;
      completedReading19 = prefs.getBool('reading19') ?? false;
      completedReading20 = prefs.getBool('reading20') ?? false;

      completedCheckpoint5 = prefs.getBool('checkpoint5') ?? false;

      completedFinalTest = prefs.getBool('finalTest') ?? false;
    });

    // --- NUEVO: Sincronizar progreso desde Firestore ---
    if (user != null) {
      final progressDoc = await FirebaseFirestore.instance
          .collection('userProgress')
          .doc(user.uid)
          .get();

      if (progressDoc.exists) {
        final progressData = progressDoc.data() ?? {};

        // Recorremos todos los campos del documento userProgress
        progressData.forEach((key, value) {
          if (value == true) {
            switch (key) {
              case "completedInstructionSpot1":
                completedInstruction1 = true;
                break;
              case "completedInstructionSpot1_1":
                completedInstruction1_1 = true;
                break;

              case "completedReadingSpot1":
                completedReading1 = true;
                break;
              case "completedReadingSpot2":
                completedReading2 = true;
                break;
              case "completedReadingSpot3":
                completedReading3 = true;
                break;
              case "completedReadingSpot4":
                completedReading4 = true;
                break;

              case "completedCheckpoint1":
                completedCheckpoint1 = true;
                break;

// -------------------- Lvl 2
              case "completedInstructionSpot2":
                completedInstruction2 = true;
                break;
              case "completedInstructionSpot2_1":
                completedInstruction2_1 = true;
                break;
              case "completedInstructionSpot2_2":
                completedInstruction2_2 = true;
                break;
              case "completedInstructionSpot2_3":
                completedInstruction2_3 = true;
                break;

              case "completedReadingSpot5":
                completedReading5 = true;
                break;
              case "completedReadingSpot6":
                completedReading6 = true;
                break;
              case "completedReadingSpot7":
                completedReading7 = true;
                break;
              case "completedReadingSpot8":
                completedReading8 = true;
                break;

              case "completedCheckpoint2":
                completedCheckpoint2 = true;
                break;

// -------------------- Lvl 3
              case "completedInstructionSpot3":
                completedInstruction3 = true;
                break;
              case "completedInstructionSpot3_1":
                completedInstruction3_1 = true;
                break;

              case "completedReadingSpot9":
                completedReading9 = true;
                break;
              case "completedReadingSpot10":
                completedReading10 = true;
                break;
              case "completedReadingSpot11":
                completedReading11 = true;
                break;
              case "completedReadingSpot12":
                completedReading12 = true;
                break;

              case "completedCheckpoint3":
                completedCheckpoint3 = true;
                break;

// -------------------- Lvl 4
              case "completedInstructionSpot4":
                completedInstruction4 = true;
                break;
              case "completedInstructionSpot4_1":
                completedInstruction4_1 = true;
                break;
              case "completedInstructionSpot4_2":
                completedInstruction4_2 = true;
                break;
              case "completedInstructionSpot4_3":
                completedInstruction4_3 = true;
                break;
              case "completedInstructionSpot4_4":
                completedInstruction4_4 = true;
                break;

              case "completedReadingSpot13":
                completedReading13 = true;
                break;
              case "completedReadingSpot14":
                completedReading14 = true;
                break;
              case "completedReadingSpot15":
                completedReading15 = true;
                break;
              case "completedReadingSpot16":
                completedReading16 = true;
                break;

              case "completedCheckpoint4":
                completedCheckpoint4 = true;
                break;

// -------------------- Lvl 5
              case "completedInstructionSpot5":
                completedInstruction5 = true;
                break;
              case "completedInstructionSpot5_1":
                completedInstruction5_1 = true;
                break;

              case "completedReadingSpot17":
                completedReading17 = true;
                break;
              case "completedReadingSpot18":
                completedReading18 = true;
                break;
              case "completedReadingSpot19":
                completedReading19 = true;
                break;
              case "completedReadingSpot20":
                completedReading20 = true;
                break;

              case "completedCheckpoint5":
                completedCheckpoint5 = true;
                break;

// -------------------- Final
              case "completedFinalTest":
                completedFinalTest = true;
                break;
            }
          }
        });
      }
    }

    // --- 3. Actualizar el ValueNotifier después de cargar los datos ---
    // Usamos addPostFrameCallback para asegurarnos que el setState ya terminó
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _spotsNotifier.value = _getAllSpots();
      });
    }
  }

  Future<void> _updateUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _username);
    if (_avatarPath != null) {
      await prefs.setString('profileImage', _avatarPath!);
    }

    // También guardar en Firestore
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'username': _username,
        'profileImage': _avatarPath,
      }, SetOptions(merge: true));
    }
  }

//-----------------------------------------------------
  void _selectAvatar() {
    final TextEditingController controller =
        TextEditingController(text: _username);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (context) {
        String? selectedAvatar = _avatarPath;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Drag handle
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const Center(
                      child: Text(
                        'Choose Your Avatar',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF334155),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // 🧠 PREVIEW DEL AVATAR (TIEMPO REAL)
                    Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: CircleAvatar(
                          key: ValueKey(selectedAvatar),
                          radius: 42,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: selectedAvatar != null
                              ? AssetImage(selectedAvatar!)
                              : null,
                          child: selectedAvatar == null
                              ? const Icon(Icons.person,
                                  size: 40, color: Colors.grey)
                              : null,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 🔹 GRID DE AVATARES
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: _avatarOptions.length,
                        itemBuilder: (context, index) {
                          final avatar = _avatarOptions[index];
                          final bool isSelected = selectedAvatar == avatar;

                          return GestureDetector(
                            onTap: () {
                              setModalState(() {
                                selectedAvatar = avatar;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: isSelected
                                    ? Border.all(
                                        width: 3,
                                        color: const Color.fromARGB(
                                            255, 30, 74, 89),
                                      )
                                    : null,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  avatar,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 10),

                    // 🔹 USERNAME
                    TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        labelText: "Username",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 30, 74, 89),
                            width: 2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // ✅ CONFIRMAR (ya con preview)
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 30, 74, 89),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 3,
                        ),
                        onPressed: () {
                          setState(() {
                            _username = controller.text.trim().isEmpty
                                ? "User"
                                : controller.text.trim();
                            _avatarPath = selectedAvatar;
                          });

                          _updateUserData();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Confirm",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  final List<String> _avatarOptions = [
    "assets/User Profile Illustrations/Designer (1).png",
    "assets/User Profile Illustrations/Designer (2).png",
    "assets/User Profile Illustrations/Designer (3).png",
    "assets/User Profile Illustrations/Designer (4).png",
    "assets/User Profile Illustrations/Designer (5).png",
    "assets/User Profile Illustrations/Designer (6).png",
    "assets/User Profile Illustrations/Designer (7).png",
    "assets/User Profile Illustrations/Designer (8).png",
    "assets/User Profile Illustrations/Designer (9).png",
    "assets/User Profile Illustrations/Designer (10).png",
    "assets/User Profile Illustrations/Designer (11).png",
    "assets/User Profile Illustrations/Designer (12).png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(''),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Wallpapers/2. Wallpaper User.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 80),
              GestureDetector(
                onTap: _selectAvatar,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: _avatarPath != null
                            ? AssetImage(_avatarPath!)
                            : null,
                      ),
                    ),
                    if (_avatarPath == null)
                      const Icon(Icons.camera_alt,
                          color: Colors.white, size: 30),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _username,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 30, 74, 89),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit,
                        size: 20, color: Color.fromARGB(255, 30, 74, 89)),
                    onPressed: _editUsername,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ProgressBar con ValueListenableBuilder
              ValueListenableBuilder<Map<String, bool>>(
                valueListenable: _spotsNotifier,
                builder: (context, spots, child) {
                  return ProgressBar(allSpots: spots);
                },
              ),

              const SizedBox(height: 0),
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(height: 20),
                    _buildStyledButton(
                      text: "Stamps",
                      icon: Icons.sticky_note_2,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StampsPage()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildStyledButton(
                      text: "Medals",
                      icon: Icons.workspace_premium,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MedalsPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _spotsNotifier.dispose();
    super.dispose();
  }

  void _editUsername() {
    final TextEditingController controller =
        TextEditingController(text: _username);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Username'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: "Username",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _username = controller.text.trim().isEmpty
                      ? "User"
                      : controller.text.trim();
                });
                _updateUserData();
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStyledButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 30, 74, 89),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        text,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}

class StampsPage extends StatefulWidget {
  final Map<String, Map<String, String>>? stampImagesOverride;

  const StampsPage({super.key, this.stampImagesOverride});

  @override
  _StampsPageState createState() => _StampsPageState();
}

class _StampsPageState extends State<StampsPage>
    with SingleTickerProviderStateMixin {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<String> _categoriesOrder = [
    'News',
    'Stories',
    'Articles',
    'Biography'
  ];

  // -------------------------------
  // GRADIENTES POR CATEGORÍA (NUEVO)
  // -------------------------------
  final Map<String, LinearGradient> _categoryGradients = {
    "News": LinearGradient(
      colors: [
        Color(0xFF1B3A2F), // verde bosque oscuro
        Color(0xFF2F5D3F), // verde oliva
        Color(0xFF7ABF8E), // verde suave
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    "Stories": LinearGradient(
      colors: [
        Color(0xFF1E2A38),
        Color(0xFF2F3D4C),
        Color(0xFF5C7893), // azul grisáceo
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    "Articles": LinearGradient(
      colors: [
        Color(0xFF2B1B3D), // morado oscuro
        Color(0xFF4B326F), // violeta medio
        Color(0xFF9F87C3), // lila claro
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    "Biography": LinearGradient(
      colors: [
        Color(0xFFFAF3D3), // beige claro
        Color(0xFFF6D365), // amarillo pastel
        Color(0xFFFDAE6B), // naranja suave dorado
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  };

  late final Map<String, Map<String, String>> _stampImages =
      widget.stampImagesOverride ??
          {
            "Biography": {
              "achievements": "assets/Biography Stamps/Biography 1.png",
              "serpent": "assets/Biography Stamps/Biography 2.png",
              "learned": "assets/Biography Stamps/Biography 3.png",
              "recognized": "assets/Biography Stamps/Biography 4.png",
              "feathers": "assets/Biography Stamps/Biography 5.png",
              "strong": "assets/Biography Stamps/Biography 6.png",
              "speak": "assets/Biography Stamps/Biography 7.png",
              "South Africa": "assets/Biography Stamps/Biography 8.png",
              "Angel": "assets/Biography Stamps/Biography 9.png",
              "wings": "assets/Biography Stamps/Biography 10.png",
              "Lincoln": "assets/Biography Stamps/Biography 11.png",
              "Jane": "assets/Biography Stamps/Biography 12.png",
              "Giuseppina": "assets/Biography Stamps/Biography 13.png",
              "battle": "assets/Biography Stamps/Biography 14.png",
              "poison": "assets/Biography Stamps/Biography 15.png",
            },
            "News": {
              "Colombian": "assets/News Stamps/News 1.png",
              "communities": "assets/News Stamps/News 2.png",
              "genuine love": "assets/News Stamps/News 3.png",
              "£": "assets/News Stamps/News 4.png",
              "Malawi": "assets/News Stamps/News 5.png",
              "Casa Rosada": "assets/News Stamps/News 6.png",
              "Chinese": "assets/News Stamps/News 7.png",
              "India": "assets/News Stamps/News 8.png",
              "resistance": "assets/News Stamps/News 9.png",
              "Peru": "assets/News Stamps/News 10.png",
              "Syrians": "assets/News Stamps/News 11.png",
              "Brazilian": "assets/News Stamps/News 12.png",
              "White House": "assets/News Stamps/News 13.png",
              "Canada": "assets/News Stamps/News 14.png",
              "Africa": "assets/News Stamps/News 15.png",
            },
            "Stories": {
              "slowly": "assets/Stories Stamps/Story 1.png",
              "never returned": "assets/Stories Stamps/Story 2.png",
              "inherited": "assets/Stories Stamps/Story 3.png",
              "Nothing": "assets/Stories Stamps/Story 4.png",
              "Vera": "assets/Stories Stamps/Story 5.png",
              "heart": "assets/Stories Stamps/Story 6.png",
              "Dr. Manners": "assets/Stories Stamps/Story 7.png",
              "Delia": "assets/Stories Stamps/Story 8.png",
              "monster": "assets/Stories Stamps/Story 9.png",
              "Mr. Wehling,": "assets/Stories Stamps/Story 10.png",
              "he": "assets/Stories Stamps/Story 11.png",
              "John": "assets/Stories Stamps/Story 12.png",
              "butterfly": "assets/Stories Stamps/Story 13.png",
              "rose": "assets/Stories Stamps/Story 14.png",
              "room #7": "assets/Stories Stamps/Story 15.png",
            },
            "Articles": {
              "mHealth": "assets/Articles Stamps/Article 1.png",
              "Stereotypical": "assets/Articles Stamps/Article 2.png",
              "ecological": "assets/Articles Stamps/Article 3.png",
              "solar": "assets/Articles Stamps/Article 4.png",
              "isolation": "assets/Articles Stamps/Article 5.png",
              "materials": "assets/Articles Stamps/Article 6.png",
              "3D": "assets/Articles Stamps/Article 7.png",
              "symbolic": "assets/Articles Stamps/Article 8.png",
              "bamboo": "assets/Articles Stamps/Article 9.png",
              "Mars": "assets/Articles Stamps/Article 10.png",
              "Exhaustion": "assets/Articles Stamps/Article 11.png",
              "historical": "assets/Articles Stamps/Article 12.png",
              "cybersecurity": "assets/Articles Stamps/Article 13.png",
              "citizens": "assets/Articles Stamps/Article 14.png",
              "International Cooperation":
                  "assets/Articles Stamps/Article 15.png",
            },
          };

  final Map<String, Map<String, Timestamp?>> _unlockedFromDb = {};
  int _currentCategoryIndex = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    for (final cat in _categoriesOrder) {
      _unlockedFromDb[cat] = {};
    }
    _fetchUnlockedFromFirestore();
  }

  Future<void> _fetchUnlockedFromFirestore() async {
    setState(() => _loading = true);

    final uid = _auth.currentUser!.uid;

    for (final category in _categoriesOrder) {
      final path = _db
          .collection("users")
          .doc(uid)
          .collection("stamps")
          .doc(category)
          .collection("items");

      final snap = await path.get();

      final map = <String, Timestamp?>{};
      for (var d in snap.docs) {
        if (d.data()["unlocked"] == true) {
          map[d.id] = d.data()["timestamp"];
        }
      }
      _unlockedFromDb[category] = map;
    }

    setState(() => _loading = false);
  }

  List<_StampItem> _buildStampListForCategory(String category) {
    final map = _stampImages[category]!;
    final unlocked = _unlockedFromDb[category]!;

    return map.entries.map((e) {
      return _StampItem(
        word: e.key,
        imagePath: e.value,
        unlockedTimestamp: unlocked[e.key],
      );
    }).toList();
  }

  // ---------------------------
  // POPUP CON GRADIENTE (NUEVO)
  // ---------------------------
  void _showStampDetailsDialog(_StampItem item) {
    final category = _categoriesOrder[_currentCategoryIndex];
    final gradient = _categoryGradients[category]!;

    final dateFormatted = item.unlockedTimestamp != null
        ? DateFormat('yyyy-MM-dd – hh:mm a')
            .format(item.unlockedTimestamp!.toDate())
        : "-";

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(.6),
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 80),
        backgroundColor:
            Colors.transparent, // Fondo transparente para ver el gradiente
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient, // 🔥 GRADIENTE EN TODA LA CARD
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.3),
                blurRadius: 12,
                offset: Offset(0, 6),
              )
            ],
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.word,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Texto blanco para mejor contraste
                ),
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  item.imagePath,
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.20), // Transparente suave
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white.withOpacity(.4)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lock_open_rounded,
                        size: 26, color: Colors.white),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Unlocked on:\n$dateFormatted",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(.85),
                  minimumSize: const Size(140, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Close",
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------
  // CARD NORMAL (NO CAMBIO)
  // ---------------------------
  Widget _buildStampTile(_StampItem item) {
    final unlocked = item.unlockedTimestamp != null;

    return GestureDetector(
      onTap: unlocked
          ? () => _showStampDetailsDialog(item)
          : () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  backgroundColor: Colors.white,
                  elevation: 12,
                  title: Row(
                    children: const [
                      Icon(Icons.lock, color: Colors.redAccent, size: 28),
                      SizedBox(width: 10),
                      Text(
                        "Locked",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  content: const Text(
                    "This stamp hasn't been unlocked yet.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"),
                    ),
                  ],
                ),
              ),
      child: AnimatedScale(
        scale: 1.0,
        duration: const Duration(milliseconds: 200),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: ColorFiltered(
            colorFilter: unlocked
                ? const ColorFilter.mode(
                    Colors.transparent,
                    BlendMode.saturation,
                  )
                : const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.saturation,
                  ),
            child: Image.asset(
              item.imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

@override
Widget build(BuildContext context) {
  final category = _categoriesOrder[_currentCategoryIndex];
  final list = _buildStampListForCategory(category);

  return Scaffold(
    backgroundColor: Colors.white,
    body: _loading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [

              // ── Header (cubre status bar) ─────────────────────────────
              Container(
                color: const Color(0xFF1E4A59),
                padding: EdgeInsets.fromLTRB(
                  4,
                  MediaQuery.of(context).padding.top + 8, // 👈 status bar
                  16,
                  8,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white, size: 20),
                    ),
                    Expanded(
                      child: Text(
                        "Stamp Album",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 44),
                  ],
                ),
              ),

              // ── Instrucción Stamp Album ──
              Container(
                color: const Color(0xFF1E4A59).withOpacity(0.08),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.search_rounded,
                        color: Color(0xFF1E4A59), size: 16),
                    const SizedBox(width: 8),
                    Flexible(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                            color: Color(0xFF1E4A59),
                            fontSize: 12,
                            height: 1.4,
                          ),
                          children: [
                            TextSpan(text: 'Hunt for hidden stamps in the library texts to '),
                            TextSpan(
                              text: 'complete your album!',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Navegación de categorías ──────────────────────────────
              Container(
                color: const Color(0xFF1E4A59).withOpacity(0.08),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _currentCategoryIndex > 0
                          ? () => setState(() => _currentCategoryIndex--)
                          : null,
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 18,
                        color: _currentCategoryIndex > 0
                            ? const Color(0xFF1E4A59)
                            : Colors.black26,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "$category  ·  ${_unlockedFromDb[category]!.length}/${list.length}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0xFF1E4A59),
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _currentCategoryIndex < _categoriesOrder.length - 1
                          ? () => setState(() => _currentCategoryIndex++)
                          : null,
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                        color: _currentCategoryIndex < _categoriesOrder.length - 1
                            ? const Color(0xFF1E4A59)
                            : Colors.black26,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),

              // ── Grid ─────────────────────────────────────────────────
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(14),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.80,
                  ),
                  itemCount: list.length,
                  itemBuilder: (_, i) => _buildStampTile(list[i]),
                ),
              ),
            ],
          ),
  );
}
}

class _StampItem {
  final String word;
  final String imagePath;
  final Timestamp? unlockedTimestamp;

  _StampItem({
    required this.word,
    required this.imagePath,
    required this.unlockedTimestamp,
  });
}




// ─── Datos de medallas ───────────────────────────────────────────────────────

class MedalData {
  final String name;
  final String image;
  final Color bgColor;
  final String quote;
  final String? displayName;

  const MedalData({
    required this.name,
    required this.image,
    required this.bgColor,
    required this.quote,
    this.displayName,
  });
}

const List<MedalData> kMedals = [
  MedalData(
    name: "Prediction Pioner",
    image: "assets/Medals/5. Prediction Pioner.png",
    bgColor: Color.fromARGB(255, 203, 71, 226),
    quote: "You can now predict what comes next in a text. You use clues and patterns to anticipate outcomes with confidence.",
  ),
  MedalData(
    name: "Referential Ranger",
    image: "assets/Medals/1. Referential Ranger.png",
    bgColor: Color.fromARGB(255, 102, 236, 107),
    quote: "You can now track what words refer to in a text. You understand pronouns and connections, helping you read with clarity and precision.",
  ),
  MedalData(
    name: "Infera Champion",
    image: "assets/Medals/6. Infera Champion.png",
    bgColor: Color.fromARGB(255, 254, 205, 60),
    quote: "You are now an Infera Champion.You’ve mastered the art of infering—uncovering meaning, connecting ideas, and predicting what comes next.",
  ),
  MedalData(
    name: "Associative Architect",
    image: "assets/Medals/4. Associative Architect.png",
    bgColor: Color.fromARGB(255, 255, 172, 47),
    quote: "You can now connect and expand ideas across a text.You organize information and build deeper understanding by linking concepts together.",
  ),
  MedalData(
    name: "Lexical Linker",
    image: "assets/Medals/2. Lexical Linker.png",
    bgColor: Color.fromARGB(255, 40, 230, 211),
    quote: "You can now unlock the meaning of new words.You use cognates, word parts, and context to grow your vocabulary with confidence.",
    displayName: "Lexical\nLinker",
  ),
  MedalData(
    name: "Explanation Expert",
    image: "assets/Medals/3. Explanation Expert.png",
    bgColor: Color.fromARGB(255, 97, 115, 219),
    quote: "You can now explain why things happen in a text.You understand causes, consequences, and motivations using logic and real-world knowledge.",
  ),
];

// ─── Modelo estrella ─────────────────────────────────────────────────────────

class _Star {
  final double x, y, r, a, phase, speed;
  const _Star({
    required this.x,
    required this.y,
    required this.r,
    required this.a,
    required this.phase,
    required this.speed,
  });
}

// ─── Modelo cometa ───────────────────────────────────────────────────────────

class _Comet {
  double x, y, vx, vy, alpha, length, width;
  final List<double> color;

  _Comet({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.alpha,
    required this.length,
    required this.width,
    required this.color,
  });

  static _Comet spawn(math.Random r, double w, double h) {
    final fromTop = r.nextDouble() < 0.6;
    double x, y, angle;
    if (fromTop) {
      x = w * 0.1 + r.nextDouble() * w * 0.8;
      y = 0;
      angle = math.pi / 4 + r.nextDouble() * math.pi / 6;
    } else {
      x = w;
      y = r.nextDouble() * h * 0.5;
      angle = math.pi + math.pi / 6 + r.nextDouble() * math.pi / 8;
    }
    final speed = 2.5 + r.nextDouble() * 2;
    final colorChoice = r.nextDouble();
    List<double> col;
    if (colorChoice < 0.7) {
      col = [255, 224, 130];
    } else if (colorChoice < 0.85) {
      col = [180, 150, 255];
    } else {
      col = [130, 230, 255];
    }
    return _Comet(
      x: x,
      y: y,
      vx: math.cos(angle) * speed,
      vy: math.sin(angle) * speed,
      alpha: 1.0,
      length: 70 + r.nextDouble() * 80,
      width: 1 + r.nextDouble() * 1.2,
      color: col,
    );
  }

  void update() {
    x += vx;
    y += vy;
    alpha -= 0.006;
  }

  bool isDead(double h) => alpha <= 0 || x < -100 || y > h + 100;
}

// ─── CustomPainter fondo espacial ────────────────────────────────────────────

class _SpacePainter extends CustomPainter {
  final List<_Star> stars;
  final List<_Comet> comets;
  final double time;

  const _SpacePainter({
    required this.stars,
    required this.comets,
    required this.time,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFF06080F),
    );

    // Nebulosas
    final nebulas = [
      (0.2 * w, 0.3 * h, 0.6 * w, 0.4 * h, const Color(0xFF534AB7), 0.18),
      (0.8 * w, 0.7 * h, 0.5 * w, 0.35 * h, const Color(0xFF1D9E75), 0.12),
      (0.6 * w, 0.15 * h, 0.45 * w, 0.30 * h, const Color(0xFFD4537E), 0.10),
      (0.3 * w, 0.8 * h, 0.55 * w, 0.45 * h, const Color(0xFF378ADD), 0.10),
    ];
    for (final n in nebulas) {
      final paint = Paint()
        ..shader = ui.Gradient.radial(
          Offset(n.$1, n.$2),
          math.max(n.$3, n.$4),
          [
            (n.$5).withOpacity(n.$6),
            Colors.transparent,
          ],
          [0.0, 1.0],
        );
      canvas.drawOval(
        Rect.fromCenter(
            center: Offset(n.$1, n.$2), width: n.$3, height: n.$4),
        paint,
      );
    }

    // Estrellas
    for (final s in stars) {
      final twinkle =
          s.a * (0.5 + 0.5 * math.sin(time * s.speed + s.phase));
      canvas.drawCircle(
        Offset(s.x * w, s.y * h),
        s.r,
        Paint()..color = Colors.white.withOpacity(twinkle),
      );
    }

    // Cometas
    for (final c in comets) {
      final dist = math.sqrt(c.vx * c.vx + c.vy * c.vy);
      final dx = c.vx / dist;
      final dy = c.vy / dist;
      final tailX = c.x - dx * c.length;
      final tailY = c.y - dy * c.length;
      final ri = c.color[0].toInt();
      final gi = c.color[1].toInt();
      final bi = c.color[2].toInt();

      final tailPaint = Paint()
        ..shader = ui.Gradient.linear(
          Offset(tailX, tailY),
          Offset(c.x, c.y),
          [
            Color.fromRGBO(ri, gi, bi, 0),
            Color.fromRGBO(ri, gi, bi, c.alpha * 0.4),
            Color.fromRGBO(ri, gi, bi, c.alpha * 0.95),
          ],
          [0.0, 0.6, 1.0],
        )
        ..strokeWidth = c.width
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      canvas.drawLine(Offset(tailX, tailY), Offset(c.x, c.y), tailPaint);

      final headPaint = Paint()
        ..shader = ui.Gradient.radial(
          Offset(c.x, c.y),
          c.width * 3.5,
          [
            Colors.white.withOpacity(c.alpha),
            Color.fromRGBO(ri, gi, bi, c.alpha * 0.7),
            Color.fromRGBO(ri, gi, bi, 0),
          ],
          [0.0, 0.4, 1.0],
        )
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(c.x, c.y), c.width * 3.5, headPaint);
    }
  }

  @override
  bool shouldRepaint(_SpacePainter old) => true;
}

// ─── Popup de medalla ────────────────────────────────────────────────────────

class MedalPopup extends StatefulWidget {
  final MedalData medal;
  final bool isUnlocked;
  final DateTime? unlockedAt;

  const MedalPopup({
    super.key,
    required this.medal,
    required this.isUnlocked,
    required this.unlockedAt,
  });

  @override
  State<MedalPopup> createState() => _MedalPopupState();
}

class _MedalPopupState extends State<MedalPopup>
    with TickerProviderStateMixin {
  late AnimationController _cometController;
  late AnimationController _orbitController;
  late AnimationController _pulseController;
  late AnimationController _entryController;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  final List<_Comet> _comets = [];
  final List<_Star> _stars = [];
  final math.Random _random = math.Random();

  int _selectedIndex = 0;
  late MedalData _currentMedal;

  @override
  void initState() {
    super.initState();

    _currentMedal = widget.medal;
    _selectedIndex =
        kMedals.indexWhere((m) => m.name == widget.medal.name);
    if (_selectedIndex < 0) _selectedIndex = 0;

    // Estrellas
    for (int i = 0; i < 120; i++) {
      _stars.add(_Star(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        r: 0.4 + _random.nextDouble() * 1.2,
        a: 0.3 + _random.nextDouble() * 0.7,
        phase: _random.nextDouble() * math.pi * 2,
        speed: 0.4 + _random.nextDouble() * 0.8,
      ));
    }

    // Cometas iniciales escalonados
    for (int i = 0; i < 3; i++) {
      Future.delayed(Duration(milliseconds: i * 700), () {
        if (mounted) {
          setState(() => _comets.add(_Comet.spawn(_random, 320, 580)));
        }
      });
    }

    // Controller cometas (~60fps)
    _cometController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..addListener(() {
        if (!mounted) return;
        setState(() {
          for (final c in _comets) {
            c.update();
          }
          _comets.removeWhere((c) => c.isDead(580));
          if (_random.nextDouble() < 0.015) {
            _comets.add(_Comet.spawn(_random, 320, 580));
          }
        });
      });
    _cometController.repeat();

    // Órbita
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Pulso
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();

    // Entrada
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _scaleAnim = CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeOutBack,
    );
    _fadeAnim = CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeIn,
    );
    _entryController.forward();
  }

  @override
  void dispose() {
    _cometController.dispose();
    _orbitController.dispose();
    _pulseController.dispose();
    _entryController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown date';
    const months = [
      '',
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return '${date.day} of ${months[date.month]}, ${date.year}';
  }

  void _selectMedal(int index) {
    setState(() {
      _selectedIndex = index;
      _currentMedal = kMedals[index];
    });
  }

  Widget _buildPulseRing(double value, double maxRadius, Color color) {
    final scale = 0.92 + value * 0.23;
    final opacity = (1 - value) * 0.5;
    return Container(
      width: maxRadius * 2 * scale,
      height: maxRadius * 2 * scale,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: color.withOpacity(opacity),
          width: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: FadeTransition(
          opacity: _fadeAnim,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: SizedBox(
              width: 320,
              height: 560,
              child: Stack(
                children: [
                  // ── Fondo animado ──
                  AnimatedBuilder(
                    animation: _cometController,
                    builder: (_, __) => CustomPaint(
                      painter: _SpacePainter(
                        stars: _stars,
                        comets: _comets,
                        time: DateTime.now().millisecondsSinceEpoch / 1000.0,
                      ),
                      size: const Size(320, 580),
                    ),
                  ),

                  // ── Contenido ──
                  Column(
                    children: [
                      _buildHeader(),
                      Expanded(child: _buildBody()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 28, bottom: 16, left: 24, right: 24),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFFFE082).withOpacity(0.15),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Anillo orbital + medalla
          SizedBox(
            width: 164,
            height: 164,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Pulsos
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (_, __) => Stack(
                    alignment: Alignment.center,
                    children: [
                      _buildPulseRing(
                          _pulseController.value, 78, const Color(0xFFFFE082)),
                      _buildPulseRing(
                          (_pulseController.value + 0.32) % 1.0,
                          78,
                          const Color(0xFFFFE082)),
                    ],
                  ),
                ),

                // Anillo exterior giratorio
                AnimatedBuilder(
                  animation: _orbitController,
                  builder: (_, __) => Transform.rotate(
                    angle: _orbitController.value * 2 * math.pi,
                    child: Container(
                      width: 156,
                      height: 156,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFFFE082).withOpacity(0.22),
                          width: 1,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFFFE082),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xFFFFE082).withOpacity(0.8),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Anillo interior (inverso)
                AnimatedBuilder(
                  animation: _orbitController,
                  builder: (_, __) => Transform.rotate(
                    angle: -_orbitController.value * 2 * math.pi * 1.5,
                    child: Container(
                      width: 144,
                      height: 144,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFFFE082).withOpacity(0.12),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),

                // Imagen de la medalla
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    color: _currentMedal.bgColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFFFE082),
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFE082).withOpacity(0.45),
                        blurRadius: 30,
                        spreadRadius: 8,
                      ),
                      BoxShadow(
                        color: _currentMedal.bgColor.withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 3,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Stack(
                      children: [
                        Image.asset(
                          _currentMedal.image,
                          fit: BoxFit.cover,
                          width: 130,
                          height: 130,
                        ),
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(0.18),
                                  Colors.transparent,
                                ],
                                stops: const [0.0, 0.5],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Nombre
          Text(
            _currentMedal.name,
            style: const TextStyle(
              color: Color(0xFFFFE082),
              fontSize: 19,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 5),

          // Tier
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFFE082).withOpacity(0.5),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                widget.isUnlocked
                    ? 'Medal Unlock'
                    : 'Medal Locked',
                style: TextStyle(
                  color: const Color(0xFFFFE082).withOpacity(0.55),
                  fontSize: 11,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFFE082).withOpacity(0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 24),
      child: Column(
        children: [


          // Strip de miniaturas
          _buildMedalsStrip(),

          // Estrellas decorativas
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (_) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 3),
                child: Icon(Icons.star_rounded,
                    color: Color(0xFFFFE082), size: 17),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Cita
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE082).withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              border: Border(
                left: BorderSide(
                  color: const Color(0xFFFFE082).withOpacity(0.4),
                  width: 2,
                ),
              ),
            ),
            child: Text(
              _currentMedal.quote,
              style: TextStyle(
                color: Colors.white.withOpacity(0.82),
                fontSize: 12,
                fontStyle: FontStyle.italic,
                height: 1.65,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 14),

          // Fecha
          if (widget.isUnlocked) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFFFFE082).withOpacity(0.10),
                    border: Border.all(
                      color: const Color(0xFFFFE082).withOpacity(0.22),
                    ),
                  ),
                  child: const Icon(
                    Icons.calendar_today_rounded,
                    size: 14,
                    color: Color(0xFFFFE082),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Unlocked on',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.35),
                        fontSize: 10,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Text(
                      _formatDate(widget.unlockedAt),
                      style: const TextStyle(
                        color: Color(0xFFFFE082),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
          ] else
            const SizedBox(height: 8),

          // Botón cerrar
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE082).withOpacity(0.11),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFFFFE082).withOpacity(0.32),
                ),
              ),
              child: const Text(
                '¡Great!',
                style: TextStyle(
                  color: Color(0xFFFFE082),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedalsStrip() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(kMedals.length, (i) {
        final m = kMedals[i];
        final isActive = i == _selectedIndex;
        return GestureDetector(
          onTap: () => _selectMedal(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 32,
            height: 32,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive
                    ? const Color(0xFFFFE082)
                    : Colors.white.withOpacity(0.15),
                width: isActive ? 2.5 : 1.5,
              ),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: const Color(0xFFFFE082).withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
            child: ClipOval(
              child: Image.asset(m.image, fit: BoxFit.cover),
            ),
          ),
        );
      }),
    );
  }
}

// ─── MedalsPage ───────────────────────────────────────────────────────────────

class MedalsPage extends StatelessWidget {
  const MedalsPage({super.key});

  Future<Map<String, DateTime?>> _getUnlockedMedals() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return {};

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('medals')
        .get();

    return {
      for (final doc in snapshot.docs)
        doc.id: (doc.data()['unlockedAt'] as Timestamp?)?.toDate(),
    };
  }

  void _showMedalPopup(
    BuildContext context,
    MedalData medal,
    bool isUnlocked,
    DateTime? unlockedAt,
  ) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'medal_popup',
      barrierColor: Colors.black.withOpacity(0.78),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => MedalPopup(
        medal: medal,
        isUnlocked: isUnlocked,
        unlockedAt: unlockedAt,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, DateTime?>>(
      future: _getUnlockedMedals(),
      builder: (context, snapshot) {
        final unlocked = snapshot.data ?? {};
        final double screenW = MediaQuery.of(context).size.width;
        final double smallSize = (screenW - 80) / 3;
        final double largeSize = screenW * 0.38;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black87,
            toolbarHeight: 1,
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Wallpapers/Wallpaper  Medals.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // ── Botón Pathway Saga ──
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 22, bottom: 14),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 39, 120, 147),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(Icons.arrow_back_ios,
                                  color: Colors.white, size: 18),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Pathway Saga',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.90,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const MoreMedalsPage(),
                                  ),
                                );
                              },
                              child: const Icon(Icons.arrow_forward_ios,
                                  color: Colors.white70, size: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // ── Instrucción Pathway Saga ──
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(220, 27, 74, 95),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFFFE082).withOpacity(0.5),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.emoji_events_rounded,
                              color: Color(0xFFFFE082), size: 16),
                          const SizedBox(width: 8),
                          Flexible(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  height: 1.2,
                                ),
                                children: [
                                  TextSpan(text: 'Complete levels, earn medals, and '),
                                  TextSpan(
                                    text: 'collect them all!',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFFE082),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ── Grid de medallas ──
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 28),
                      child: Column(
                        children: [
                          // Fila 1
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildMedalWithLabel(
                                    context, kMedals[1], unlocked,
                                    size: smallSize),
                                _buildMedalWithLabel(
                                    context, kMedals[4], unlocked,
                                    size: smallSize),
                                _buildMedalWithLabel(
                                    context, kMedals[5], unlocked,
                                    size: smallSize),
                              ],
                            ),
                          ),
                          const SizedBox(height: 36),

                          // Fila 2
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildMedalWithLabel(
                                  context, kMedals[3], unlocked,
                                  size: smallSize),
                              SizedBox(width: screenW * 0.12),
                              _buildMedalWithLabel(
                                  context, kMedals[0], unlocked,
                                  size: smallSize),
                            ],
                          ),
                          const SizedBox(height: 36),

                          // Fila 3 — Infera Champion grande
                          Center(
                            child: _buildMedalWithLabel(
                              context, kMedals[2], unlocked,
                              size: largeSize, isCenter: true,
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMedalWithLabel(
    BuildContext context,
    MedalData medal,
    Map<String, DateTime?> unlocked, {
    required double size,
    bool isCenter = false,
  }) {
    final bool isUnlocked = unlocked.containsKey(medal.name);
    final DateTime? unlockedAt = unlocked[medal.name];
    final double fontSize = isCenter ? 13.5 : 11.5;
    final double borderWidth = isCenter ? 4.5 : 3;
    final Color borderColor =
        isCenter ? const Color(0xFFFFE082) : Colors.white;

    return GestureDetector(
      onTap: () => _showMedalPopup(context, medal, isUnlocked, unlockedAt),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: isCenter
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFE082).withOpacity(0.45),
                        blurRadius: 30,
                        spreadRadius: 8,
                      ),
                    ],
                  )
                : null,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: medal.bgColor,
                shape: BoxShape.circle,
                border: Border.all(color: borderColor, width: borderWidth),
                boxShadow: [
                  BoxShadow(
                    color: medal.bgColor.withOpacity(0.5),
                    blurRadius: isCenter ? 20 : 10,
                    spreadRadius: isCenter ? 3 : 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipOval(
                child: ColorFiltered(
                  colorFilter: isUnlocked
                      ? const ColorFilter.mode(
                          Colors.transparent, BlendMode.multiply)
                      : const ColorFilter.mode(
                          Colors.grey, BlendMode.saturation),
                  child: Image.asset(medal.image, fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: size,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 30, 74, 89),
                borderRadius: BorderRadius.circular(8),
                border: isCenter
                    ? Border.all(
                        color: const Color(0xFFFFE082).withOpacity(0.5),
                        width: 1,
                      )
                    : null,
              ),
              child: Text(
                medal.displayName ?? medal.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight:
                      isCenter ? FontWeight.bold : FontWeight.w500,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Datos de las medallas Stamps Saga ───────────────────────────────────────

class StampMedalData {
  final String name;
  final String image;
  final Color bgColor;
  final String category;
  final String quote;

  const StampMedalData({
    required this.name,
    required this.image,
    required this.bgColor,
    required this.category,
    required this.quote,
  });
}

const List<StampMedalData> kStampMedals = [
  StampMedalData(
    name: "Lifetime Teller",
    image: "assets/Medals/7. Lifetime Teller.png",
    bgColor: Colors.deepPurple,
    category: "Biography",
    quote: "You can now understand people’s lives and choices.You recognize motivations, challenges, and the impact of real individuals.",
  ),
  StampMedalData(
    name: "News Nexus",
    image: "assets/Medals/8. News Nexus.png",
    bgColor: Colors.cyan,
    category: "News",
    quote: "You can now understand real-world events clearly.You follow current information and make sense of what’s happening around you.",
  ),
  StampMedalData(
    name: "Narrative Master",
    image: "assets/Medals/9. Narrative Master.png",
    bgColor: Colors.orange,
    category: "Stories",
    quote: "You can now understand and interpret stories deeply.You follow characters, events, and hidden meanings with confidence.",
  ),
  StampMedalData(
    name: "Scholar Star",
    image: "assets/Medals/10. Scholar Star.png",
    bgColor: Colors.pink,
    category: "Articles",
    quote: "You can now understand complex ideas and information.You read in-depth texts and grasp key concepts with clarity.",
  ),
];

// ─── Popup de medalla Stamps ──────────────────────────────────────────────────

class StampMedalPopup extends StatefulWidget {
  final StampMedalData medal;
  final bool isUnlocked;
  final DateTime? unlockedAt;

  const StampMedalPopup({
    super.key,
    required this.medal,
    required this.isUnlocked,
    required this.unlockedAt,
  });

  @override
  State<StampMedalPopup> createState() => _StampMedalPopupState();
}

class _StampMedalPopupState extends State<StampMedalPopup>
    with TickerProviderStateMixin {
  late AnimationController _cometController;
  late AnimationController _orbitController;
  late AnimationController _pulseController;
  late AnimationController _entryController;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  final List<_Comet> _comets = [];
  final List<_Star> _stars = [];
  final math.Random _random = math.Random();

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _selectedIndex =
        kStampMedals.indexWhere((m) => m.name == widget.medal.name);
    if (_selectedIndex < 0) _selectedIndex = 0;

    for (int i = 0; i < 120; i++) {
      _stars.add(_Star(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        r: 0.4 + _random.nextDouble() * 1.2,
        a: 0.3 + _random.nextDouble() * 0.7,
        phase: _random.nextDouble() * math.pi * 2,
        speed: 0.4 + _random.nextDouble() * 0.8,
      ));
    }

    for (int i = 0; i < 3; i++) {
      Future.delayed(Duration(milliseconds: i * 700), () {
        if (mounted) {
          setState(() => _comets.add(_Comet.spawn(_random, 320, 580)));
        }
      });
    }

    _cometController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..addListener(() {
        if (!mounted) return;
        setState(() {
          for (final c in _comets) {
            c.update();
          }
          _comets.removeWhere((c) => c.isDead(580));
          if (_random.nextDouble() < 0.015) {
            _comets.add(_Comet.spawn(_random, 320, 580));
          }
        });
      });
    _cometController.repeat();

    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _scaleAnim = CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeOutBack,
    );
    _fadeAnim = CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeIn,
    );
    _entryController.forward();
  }

  @override
  void dispose() {
    _cometController.dispose();
    _orbitController.dispose();
    _pulseController.dispose();
    _entryController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown Date';
    const months = [
      '',
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return '${date.day} of ${months[date.month]}, ${date.year}';
  }

  Widget _buildPulseRing(double value, double maxRadius, Color color) {
    final scale = 0.92 + value * 0.23;
    final opacity = (1 - value) * 0.5;
    return Container(
      width: maxRadius * 2 * scale,
      height: maxRadius * 2 * scale,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: color.withOpacity(opacity),
          width: 1.5,
        ),
      ),
    );
  }

  StampMedalData get _current => kStampMedals[_selectedIndex];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: FadeTransition(
          opacity: _fadeAnim,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: SizedBox(
              width: 320,
              height: 580,
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: _cometController,
                    builder: (_, __) => CustomPaint(
                      painter: _SpacePainter(
                        stars: _stars,
                        comets: _comets,
                        time: DateTime.now().millisecondsSinceEpoch / 1000.0,
                      ),
                      size: const Size(320, 580),
                    ),
                  ),
                  Column(
                    children: [
                      _buildHeader(),
                      Expanded(child: _buildBody()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 28, bottom: 16, left: 24, right: 24),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFFFE082).withOpacity(0.15),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 164,
            height: 164,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (_, __) => Stack(
                    alignment: Alignment.center,
                    children: [
                      _buildPulseRing(_pulseController.value, 78,
                          const Color(0xFFFFE082)),
                      _buildPulseRing(
                          (_pulseController.value + 0.32) % 1.0,
                          78,
                          const Color(0xFFFFE082)),
                    ],
                  ),
                ),
                AnimatedBuilder(
                  animation: _orbitController,
                  builder: (_, __) => Transform.rotate(
                    angle: _orbitController.value * 2 * math.pi,
                    child: Container(
                      width: 156,
                      height: 156,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFFFE082).withOpacity(0.22),
                          width: 1,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFFFE082),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFE082).withOpacity(0.8),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _orbitController,
                  builder: (_, __) => Transform.rotate(
                    angle: -_orbitController.value * 2 * math.pi * 1.5,
                    child: Container(
                      width: 144,
                      height: 144,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFFFE082).withOpacity(0.12),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    color: _current.bgColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFFFE082),
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFE082).withOpacity(0.45),
                        blurRadius: 30,
                        spreadRadius: 8,
                      ),
                      BoxShadow(
                        color: _current.bgColor.withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 3,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Stack(
                      children: [
                        Image.asset(
                          _current.image,
                          fit: BoxFit.cover,
                          width: 130,
                          height: 130,
                        ),
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(0.18),
                                  Colors.transparent,
                                ],
                                stops: const [0.0, 0.5],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _current.name,
            style: const TextStyle(
              color: Color(0xFFFFE082),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 4, height: 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFFE082).withOpacity(0.5),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                widget.isUnlocked
                    ? 'Medal Unlocked'
                    : 'Medal Locked',
                style: TextStyle(
                  color: const Color(0xFFFFE082).withOpacity(0.55),
                  fontSize: 10,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 4, height: 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFFE082).withOpacity(0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 24),
      child: Column(
        children: [
          // Strip miniaturas
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(kStampMedals.length, (i) {
              final m = kStampMedals[i];
              final isActive = i == _selectedIndex;
              return GestureDetector(
                onTap: () => setState(() => _selectedIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 36,
                  height: 36,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive
                          ? const Color(0xFFFFE082)
                          : Colors.white.withOpacity(0.15),
                      width: isActive ? 2.5 : 1.5,
                    ),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: const Color(0xFFFFE082).withOpacity(0.4),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                  child: ClipOval(
                    child: Image.asset(m.image, fit: BoxFit.cover),
                  ),
                ),
              );
            }),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (_) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 3),
                child: Icon(Icons.star_rounded,
                    color: Color(0xFFFFE082), size: 17),
              ),
            ),
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE082).withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              border: Border(
                left: BorderSide(
                  color: const Color(0xFFFFE082).withOpacity(0.4),
                  width: 2,
                ),
              ),
            ),
            child: Text(
              _current.quote,
              style: TextStyle(
                color: Colors.white.withOpacity(0.82),
                fontSize: 12,
                fontStyle: FontStyle.italic,
                height: 1.65,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 14),

          if (widget.isUnlocked) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFFFFE082).withOpacity(0.10),
                    border: Border.all(
                      color: const Color(0xFFFFE082).withOpacity(0.22),
                    ),
                  ),
                  child: const Icon(Icons.calendar_today_rounded,
                      size: 14, color: Color(0xFFFFE082)),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'unlocked on',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.35),
                        fontSize: 10,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _formatDate(widget.unlockedAt),
                      style: const TextStyle(
                        color: Color(0xFFFFE082),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
          ] else
            const SizedBox(height: 8),

          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE082).withOpacity(0.11),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFFFFE082).withOpacity(0.32),
                ),
              ),
              child: const Text(
                '¡Great!',
                style: TextStyle(
                  color: Color(0xFFFFE082),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── MoreMedalsPage ───────────────────────────────────────────────────────────

class MoreMedalsPage extends StatefulWidget {
  const MoreMedalsPage({super.key});

  @override
  State<MoreMedalsPage> createState() => _MoreMedalsPageState();
}

class _MoreMedalsPageState extends State<MoreMedalsPage> {
  final Map<String, DateTime?> _medalsUnlocked = {
    "Biography": null,
    "News": null,
    "Stories": null,
    "Articles": null,
  };

  @override
  void initState() {
    super.initState();
    _loadMedals();
  }

  Future<void> _loadMedals() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final db = FirebaseFirestore.instance;

    for (final medal in kStampMedals) {
      final category = medal.category;

      final itemsSnapshot = await db
          .collection("users")
          .doc(user.uid)
          .collection("stamps")
          .doc(category)
          .collection("items")
          .get();

      final unlockedCount = itemsSnapshot.docs
          .where((doc) => doc.data()["unlocked"] == true)
          .length;

      if (unlockedCount >= 15) {
        // Leer si ya tiene fecha guardada
        final medalDoc = await db
            .collection("users")
            .doc(user.uid)
            .collection("medals")
            .doc(category)
            .get();

        final existingDate =
            (medalDoc.data()?['unlockedAt'] as Timestamp?)?.toDate();

        // Solo escribir si no existe aún
        if (existingDate == null) {
          await db
              .collection("users")
              .doc(user.uid)
              .collection("medals")
              .doc(category)
              .set({
            "unlocked": true,
            "awardedAt": FieldValue.serverTimestamp(),
            "unlockedAt": FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
        }

        if (mounted) {
          setState(() {
            _medalsUnlocked[category] = existingDate ?? DateTime.now();
          });
        }
      }
    }
  }

  void _showMedalPopup(StampMedalData medal) {
    final isUnlocked = _medalsUnlocked[medal.category] != null;
    final unlockedAt = _medalsUnlocked[medal.category];

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'stamp_medal_popup',
      barrierColor: Colors.black.withOpacity(0.78),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => StampMedalPopup(
        medal: medal,
        isUnlocked: isUnlocked,
        unlockedAt: unlockedAt,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        toolbarHeight: 1,
      ),
      body: SafeArea(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Wallpapers/Wallpaper  Medals.png'),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          child: Column(
            children: [
              _buildHeaderWithNavigation(context),
              const SizedBox(height: 10),
              // ── Instrucción Stamps Saga ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(220, 27, 74, 95),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFFFE082).withOpacity(0.5),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.book_rounded,
                          color: Color(0xFFFFE082), size: 16),
                      const SizedBox(width: 8),
                      Flexible(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              height: 1.4,
                            ),
                            children: [
                              TextSpan(text: 'Read all the pathway texts to earn your medal. '),
                              TextSpan(
                                text: 'Keep reading!',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFE082),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 14, right: 14),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 15,
                      runSpacing: 30,
                      children: kStampMedals
                          .map((medal) => _buildMedalWithLabel(medal))
                          .toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderWithNavigation(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 22, bottom: 4),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 39, 120, 147),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios,
                      color: Colors.white, size: 18),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Stamps Saga',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.90,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(width: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedalWithLabel(StampMedalData medal) {
    final bool unlocked = _medalsUnlocked[medal.category] != null;

    return GestureDetector(
      onTap: () => _showMedalPopup(medal),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ColorFiltered(
            colorFilter: unlocked
                ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
                : const ColorFilter.matrix([
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0,      0,      0,      1, 0,
                  ]),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: unlocked ? medal.bgColor : Colors.grey.shade600,
                shape: BoxShape.circle,
                border: Border.all(
                  color: unlocked
                      ? const Color.fromARGB(255, 149, 144, 128)
                      : Colors.grey.shade400,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 5,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(medal.image, fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 130,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: unlocked
                  ? const Color.fromARGB(221, 30, 74, 89)
                  : Colors.grey.shade700,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              medal.name,
              style: TextStyle(
                color: unlocked ? Colors.white : Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              softWrap: true,
              maxLines: 3,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}