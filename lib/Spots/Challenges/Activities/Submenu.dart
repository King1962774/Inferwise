import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';
import 'dart:math';

import 'package:inferwise/Spots/Challenges/Activities/Challenges/Elaborative/Elaborative.dart';
import 'package:inferwise/Spots/Challenges/Activities/Challenges/Elaborative/Elaborative2.dart';
import 'package:inferwise/Spots/Challenges/Activities/Challenges/Elaborative/Elaborative3.dart';
import 'package:inferwise/Spots/Challenges/Activities/Challenges/Elaborative/Elaborative4.dart';
import 'package:inferwise/Spots/Challenges/Activities/Challenges/Explanatory/Explanatory.dart';
import 'package:inferwise/Spots/Challenges/Activities/Challenges/Explanatory/Explanatory2.dart';
import 'package:inferwise/Spots/Challenges/Activities/Challenges/Explanatory/Explanatory3.dart';
import 'package:inferwise/Spots/Challenges/Activities/Challenges/Explanatory/Explanatory4.dart';
import 'package:inferwise/Spots/Challenges/Activities/Challenges/Lexical/Lexical.dart';
import 'package:inferwise/Spots/Challenges/Activities/Challenges/Lexical/Lexical2.dart';
import 'package:inferwise/Spots/Challenges/Activities/Challenges/Lexical/Lexical3.dart';
import 'package:inferwise/Spots/Challenges/Activities/Challenges/Lexical/Lexical4.dart';
import 'package:inferwise/Spots/Challenges/Activities/Challenges/Predective/Predective2.dart';
import 'package:inferwise/Spots/Challenges/Activities/Challenges/Predective/Predective3.dart';
import 'package:inferwise/Spots/Challenges/Activities/Challenges/Predective/Predective4.dart';
import 'package:inferwise/Spots/Challenges/Activities/Challenges/Predective/Predictive.dart';
import 'package:inferwise/Spots/Challenges/Activities/Challenges/Referential/Referential.dart';
import 'package:inferwise/Spots/Challenges/Activities/Challenges/Referential/Referential2.dart';
import 'package:inferwise/Spots/Challenges/Activities/Challenges/Referential/Referential3.dart';
import 'package:inferwise/Spots/Challenges/Activities/Challenges/Referential/Referential4.dart';


class SubMenuPage extends StatefulWidget {
  final String sectionName;
  final String description;

  const SubMenuPage({
    super.key,
    required this.sectionName,
    required this.description,
  });

  @override
  State<SubMenuPage> createState() => _SubMenuPageState();
}

class _SubMenuPageState extends State<SubMenuPage>
    with TickerProviderStateMixin {

  // ── Animaciones del fondo espacial ─────────────────────────────────────
  // Un solo controller de 20s para todo el fondo (muy bajo coste de CPU)
  late AnimationController _bgController;

  // Estrella fugaz — dispara sola cada ~5s
  late AnimationController _shootingStarController;
  late Animation<double> _shootingStarAnim;

  void _reload() => setState(() {});

  LinearGradient goldGradient() {
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

  final Map<String, List<String>> sectionClasses = {
    "Reference\nPlanet": ["Lives & Legacies", "Daily Dispatch", "Tales Rocket", "Knowledge Capsule"],
    "Lexical\nMoon": ["History Makers", "News Around Us", "Imagination Station", "Idea Vault"],
    "Explanation\nSun": [" Motivations & Paths", "The World Today", "The Story Room", "Insight Station"],
    "Constellation\nof Ideas": ["Depth Profiles", "The News Desk", "Wonder Tales", "Think Tank"],
    "Galaxy\nof\nPredictions": ["Great Lives", "Today's Reports", "Timeless Tales", "Curiosity Lab"],
  };

  final Map<String, List<int>> sectionSpotIndex = {
    "Reference\nPlanet": [1, 2, 3, 4],
    "Lexical\nMoon": [5, 6, 7, 8],
    "Explanation\nSun": [9, 10, 11, 12],
    "Constellation\nof Ideas": [13, 14, 15, 16],
    "Galaxy\nof\nPredictions": [17, 18, 19, 20],
  };

  final Map<String, List<Color>> sectionColors = {
    "Reference\nPlanet": [
      Color(0xFF2E7D32), Color(0xFF43A047), Color(0xFF66BB6A), Color(0xFF81C784),
    ],
    "Lexical\nMoon": [
      Color(0xFF006D77), Color(0xFF008C8C), Color(0xFF00A8A8), Color(0xFF00BFCF),
    ],
    "Explanation\nSun": [
      Color(0xFF0D47A1), Color(0xFF1565C0), Color(0xFF1976D2), Color(0xFF42A5F5),
    ],
    "Constellation\nof Ideas": [
      Color(0xFFFFB44B), Color(0xFFFFA032), Color(0xFFFF8C28), Color(0xFFF57823),
    ],
    "Galaxy\nof\nPredictions": [
      Color(0xFFAD3CFE), Color(0xFF9650F5), Color(0xFF8269F0), Color(0xFF7378EE),
    ],
  };

  // Color de acento para la estrella fugaz
  Color get _accentColor =>
      (sectionColors[widget.sectionName] ?? [Colors.white])[1];

  int get _sectionSeed {
    const keys = [
      "Reference\nPlanet", "Lexical\nMoon", "Explanation\nSun",
      "Constellation\nof Ideas", "Galaxy\nof\nPredictions",
    ];
    return keys.indexOf(widget.sectionName).clamp(0, 4);
  }

  @override
  void initState() {
    super.initState();

    // Controller lento de fondo — bajo consumo, solo drive la nebulosa
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // Estrella fugaz — 1.2s de animación, se repite cada ~5s
    _shootingStarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _shootingStarAnim = CurvedAnimation(
      parent: _shootingStarController,
      curve: Curves.easeInOut,
    );
    _startShootingLoop();
  }

  void _startShootingLoop() async {
    // Primer disparo con un pequeño delay para que no arranque al instante
    await Future.delayed(const Duration(milliseconds: 2500));
    while (mounted) {
      await Future.delayed(const Duration(milliseconds: 5000));
      if (!mounted) break;
      await _shootingStarController.forward(from: 0);
      if (!mounted) break;
      _shootingStarController.reset();
    }
  }

  @override
  void dispose() {
    _bgController.dispose();
    _shootingStarController.dispose();
    super.dispose();
  }

  Widget? getClassPage(String section, String challenge,
      Future<void> Function() onFinish) {
    switch (section) {
      case "Reference\nPlanet":
        return {
          "Lives & Legacies": ReferentialClass1(onFinish: onFinish),
          "Daily Dispatch": ReferentialClass2(onFinish: onFinish),
          "Tales Rocket": ReferentialClass3(onFinish: onFinish),
          "Knowledge Capsule": ReferentialClass4(onFinish: onFinish),
        }[challenge];
      case "Lexical\nMoon":
        return {
          "History Makers": LexicalClass1(onFinish: onFinish),
          "News Around Us": LexicalClass2(onFinish: onFinish),
          "Imagination Station": LexicalClass3(onFinish: onFinish),
          "Idea Vault": LexicalClass4(onFinish: onFinish),
        }[challenge];
      case "Explanation\nSun":
        return {
          " Motivations & Paths": ExplanatoryClass1(onFinish: onFinish),
          "The World Today": ExplanatoryClass2(onFinish: onFinish),
          "The Story Room": ExplanatoryClass3(onFinish: onFinish),
          "Insight Station": ExplanatoryClass4(onFinish: onFinish),
        }[challenge];
      case "Constellation\nof Ideas":
        return {
          "Depth Profiles": ElaborativeClass1(onFinish: onFinish),
          "The News Desk": ElaborativeClass2(onFinish: onFinish),
          "Wonder Tales": ElaborativeClass3(onFinish: onFinish),
          "Think Tank": ElaborativeClass4(onFinish: onFinish),
        }[challenge];
      case "Galaxy\nof\nPredictions":
        return {
          "Great Lives": PredectiveClass1(onFinish: onFinish),
          "Today's Reports": PredectiveClass2(onFinish: onFinish),
          "Timeless Tales": PredectiveClass3(onFinish: onFinish),
          "Curiosity Lab": PredectiveClass4(onFinish: onFinish),
        }[challenge];
    }
    return null;
  }

  Future<void> markChallengeCompleted(String section, int index) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection("userProgress")
        .doc(uid)
        .update({
      "completed${section}Challenge${index + 1}": true,
    });
  }

 @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final classes = sectionClasses[widget.sectionName]!;
    final colors = sectionColors[widget.sectionName]!;
    final spots = sectionSpotIndex[widget.sectionName]!;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // ── Fondo espacial ───────────────────────────────────────────
          Positioned.fill(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _bgController,
                _shootingStarAnim,
              ]),
              builder: (_, __) => RepaintBoundary(
                child: CustomPaint(
                  painter: _SpaceBgPainter(
                    seed: _sectionSeed,
                    accentColor: _accentColor,
                    bgT: _bgController.value,
                    shootingT: _shootingStarAnim.value,
                  ),
                  size: Size.infinite,
                ),
              ),
            ),
          ),

          // ── Contenido ────────────────────────────────────────────────
          FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection("userProgress")
                .doc(uid)
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              final data =
                  snapshot.data!.data() as Map<String, dynamic>? ?? {};

              return ListView(
                padding: EdgeInsets.fromLTRB(
                  20,
                  MediaQuery.of(context).padding.top + 64,
                  20,
                  20,
                ),
                children: [
                  Text(
                    widget.sectionName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),

                  ...List.generate(classes.length, (i) {
                    final unlocked =
                        data["completedReadingSpot${spots[i]}"] == true;
                    final completed =
                        data["completed${widget.sectionName}Challenge${i + 1}"] ==
                            true;

                    return GestureDetector(
                      onTap: () {
                        if (!unlocked) {
                          showLockedCard(context, spots[i]);
                          return;
                        }
                        final page = getClassPage(
                          widget.sectionName,
                          classes[i],
                          () async {
                            await markChallengeCompleted(widget.sectionName, i);
                            Navigator.pop(context);
                          },
                        );
                        if (page != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => page),
                          ).then((_) => _reload());
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 18),
                        height: 75,
                        child: Stack(
                          children: [
                            // BASE
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                gradient: LinearGradient(colors: colors),
                              ),
                            ),

                            // DORADO ANIMADO
                            if (completed)
                              TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0, end: 1),
                                duration: const Duration(milliseconds: 1200),
                                curve: Curves.easeOutCubic,
                                builder: (context, value, _) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: FractionallySizedBox(
                                      widthFactor: value,
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: goldGradient(),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                            // TEXTO + ICONO
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    classes[i],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Icon(
                                    completed
                                        ? Icons.check_circle
                                        : unlocked
                                            ? Icons.play_arrow
                                            : Icons.lock,
                                    color: Colors.white70,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              );
            },
          ),

          // ── Flecha de regreso flotante ────────────────────────────────
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 12,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.35),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.18),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  SPACE BACKGROUND PAINTER — optimizado para bajo consumo
//
//  Estrategia de rendimiento:
//  • Estrellas con posición fija (Random con seed fijo, calculado una sola
//    vez — no se recalcula en cada frame).
//  • Solo la nebulosa y la estrella fugaz son dinámicas.
//  • shouldRepaint devuelve false cuando nada cambió.
//  • RepaintBoundary en el widget padre aísla el repaint del resto del árbol.
// ═══════════════════════════════════════════════════════════════════════════

class _SpaceBgPainter extends CustomPainter {
  final int seed;
  final Color accentColor;
  final double bgT;       // 0..1 loop → nebulosa
  final double shootingT; // 0..1 → estrella fugaz

  const _SpaceBgPainter({
    required this.seed,
    required this.accentColor,
    required this.bgT,
    required this.shootingT,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // 1 — Fondo negro espacial
    canvas.drawRect(rect, Paint()..color = const Color(0xFF060810));

    // 2 — Nebulosa del color del nivel (muy suave, solo se mueve)
    _paintNebula(canvas, size);

    // 3 — Estrellas estáticas (posiciones fijas, sin animar)
    _paintStars(canvas, size);

    // 4 — Estrella fugaz (solo si está activa)
    if (shootingT > 0 && shootingT < 1) {
      _paintShootingStar(canvas, size, shootingT);
    }
  }

  void _paintNebula(Canvas canvas, Size size) {
    // Movimiento suave usando sin/cos del bgT
    final dx = size.width * (0.35 + 0.12 * sin(bgT * 2 * pi));
    final dy = size.height * (0.20 + 0.06 * cos(bgT * 2 * pi));

    canvas.drawCircle(
      Offset(dx, dy),
      size.width * 0.55,
      Paint()
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 70)
        ..color = accentColor.withOpacity(0.10),
    );
  }

  void _paintStars(Canvas canvas, Size size) {
    // Seed fijo → posiciones siempre iguales → no recalcula
    final rng = Random(seed * 317 + 41);
    const count = 55; // suficientes estrellas sin sobrecargar

    for (int i = 0; i < count; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height;
      final r = i % 8 == 0 ? 1.9 : i % 4 == 0 ? 1.2 : i % 2 == 0 ? 0.8 : 0.5;
      final op = 0.20 + rng.nextDouble() * 0.55;

      canvas.drawCircle(
        Offset(x, y),
        r,
        Paint()..color = Colors.white.withOpacity(op),
      );

      // Cruz solo en las más grandes para no inflar el path count
      if (i % 8 == 0) {
        final lp = Paint()
          ..color = Colors.white.withOpacity(op * 0.45)
          ..strokeWidth = 0.6
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(Offset(x - r * 2.8, y), Offset(x + r * 2.8, y), lp);
        canvas.drawLine(Offset(x, y - r * 2.8), Offset(x, y + r * 2.8), lp);
      }
    }
  }

  void _paintShootingStar(Canvas canvas, Size size, double t) {
    const sx = 0.04, sy = 0.07, ex = 0.88, ey = 0.44;

    final hx = size.width  * (sx + (ex - sx) * t);
    final hy = size.height * (sy + (ey - sy) * t);

    const tail = 0.20;
    final tailT = (t - tail).clamp(0.0, 1.0);
    final tx = size.width  * (sx + (ex - sx) * tailT);
    final ty = size.height * (sy + (ey - sy) * tailT);

    final op = t < 0.12
        ? t / 0.12
        : t > 0.72
            ? ((1 - t) / 0.28).clamp(0.0, 1.0)
            : 1.0;
    if (op <= 0) return;

    final from = Offset(tx, ty);
    final to   = Offset(hx, hy);
    final gradRect = Rect.fromPoints(from, to);

    // Cola coloreada del nivel
    canvas.drawLine(
      from, to,
      Paint()
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..shader = LinearGradient(
          colors: [
            accentColor.withOpacity(0),
            accentColor.withOpacity(0.88 * op),
          ],
        ).createShader(gradRect),
    );

    // Brillo blanco central encima
    canvas.drawLine(
      from, to,
      Paint()
        ..strokeWidth = 0.7
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..shader = LinearGradient(
          colors: [
            Colors.white.withOpacity(0),
            Colors.white.withOpacity(0.70 * op),
          ],
        ).createShader(gradRect),
    );

    // Cabeza
    canvas.drawCircle(
      to, 2.5,
      Paint()..color = Colors.white.withOpacity(0.95 * op),
    );
    canvas.drawCircle(
      to, 6.0,
      Paint()
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4)
        ..color = accentColor.withOpacity(0.50 * op),
    );
  }

  @override
  bool shouldRepaint(covariant _SpaceBgPainter old) =>
      old.bgT != bgT ||
      old.shootingT != shootingT ||
      old.seed != seed;
}

// ═══════════════════════════════════════════════════════════════════════════
//  LOCKED CARD DIALOG — sin cambios
// ═══════════════════════════════════════════════════════════════════════════

void showLockedCard(BuildContext context, int spotNumber) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.8, end: 1),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        builder: (context, scale, _) {
          return Transform.scale(
            scale: scale,
            child: Dialog(
              backgroundColor: Colors.white.withOpacity(0.08),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.lock, color: Colors.white, size: 55),
                        const SizedBox(height: 15),
                        const Text(
                          "This challenge is locked",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Complete Reading Spot $spotNumber first.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}