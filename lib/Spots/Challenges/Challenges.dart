// ignore_for_file: unused_element

import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:inferwise/Spots/Challenges/Activities/Submenu.dart';
import 'package:inferwise/Spots/Challenges/Imagen_Library.dart';

class ChallengesPage extends StatefulWidget {
  const ChallengesPage({super.key});
  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage>
    with TickerProviderStateMixin {
  final PageController _pageController =
      PageController(viewportFraction: 0.62, initialPage: 1000);

  final List<String> items = [
    "Reference\nPlanet",
    "Lexical\nMoon",
    "Explanation\nSun",
    "Constellation\nof Ideas",
    "Galaxy\nof\nPredictions",
  ];

  final List<String> descriptions = [
    "Let's apply your referential skills using tweet-style texts.",
    "Let's put your lexical skills to work by exploring some advertising content.",
    "Let's strengthen your explicative skills by working with short comic strips.",
    "Let's develop your elaborative skills by analyzing Instagram-style posts.",
    "Let's sharpen your predictive skills by interpreting images of different situations.",
  ];

  final List<List<Color>> gradients = [
    [const Color(0xFF1a4a1e), const Color(0xFF2E7D32), const Color(0xFF43A047), const Color(0xFF66BB6A), const Color(0xFFa5d6a7)],
    [const Color(0xFF003d4d), const Color(0xFF00607a), const Color(0xFF0097a7), const Color(0xFF26c6da), const Color(0xFF80deea)],
    [const Color(0xFF0A2472), const Color(0xFF0D47A1), const Color(0xFF1565C0), const Color(0xFF1976D2), const Color(0xFF42A5F5)],
    [const Color(0xFFBF360C), const Color(0xFFE64A19), const Color(0xFFF57C00), const Color(0xFFFFB300), const Color(0xFFFFD54F)],
    [const Color(0xFF4A148C), const Color(0xFF6A1B9A), const Color(0xFF7B1FA2), const Color(0xFF8269F0), const Color(0xFFAD3CFE)],
  ];

  final List<Color> glowColors = [
    const Color(0xFF4CAF50),
    const Color(0xFF00BCD4),
    const Color(0xFF1565C0), // ← Explanation Sun: azul oscuro, no amarillo
    const Color(0xFFFFB300),
    const Color(0xFFAD3CFE),
  ];

  final List<Color> borderColors = [
    const Color(0xFFa5d6a7),
    const Color(0xFF26c6da),
    const Color(0xFF64B5F6),
    const Color(0xFFFFD54F),
    const Color(0xFFCE93D8),
  ];

  double currentPage = 1000;
  late AnimationController _bgAnimation;
  late AnimationController _hintController;
  late Animation<double> _hintOpacity;

  // Estrella fugaz — anima dentro de las cards
  late AnimationController _shootingStarController;
  late Animation<double> _shootingStarAnim;

  // Pulso del glow central
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  bool _hintVisible = true;
  bool _pageReady = false;

  static const String _wallpaperAsset = "assets/Wallpapers/2. Wallpaper User.png";

  void _handleVerticalSwipe(DragEndDetails details) {
    if (details.primaryVelocity != null && details.primaryVelocity! < -600) {
      _openImageLibrary();
    }
  }

  void _openImageLibrary() async {
    if (!mounted) return;
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 50,
        left: 20, right: 20,
        child: Material(
          color: Colors.transparent,
          child: _FloatingMessage(message: "📸 Entering image library..."),
        ),
      ),
    );
    overlay.insert(overlayEntry);
    await Future.delayed(const Duration(milliseconds: 1200));
    overlayEntry.remove();
    if (!mounted) return;
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (_, __, ___) => const ImageLibraryPage(),
        transitionsBuilder: (_, animation, __, child) {
          final tween = Tween(begin: const Offset(0, 1), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeOutCubic));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      final p = _pageController.page;
      if (p != null && _pageReady) setState(() => currentPage = p);
    });

    _bgAnimation = AnimationController(vsync: this, duration: const Duration(seconds: 18));

    _hintController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _hintOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _hintController, curve: Curves.easeIn),
    );

    _shootingStarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _shootingStarAnim = CurvedAnimation(
      parent: _shootingStarController,
      curve: Curves.easeInOut,
    );
    _startShootingStarLoop();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _pageReady = true;
      _bgAnimation.repeat();
      _hintController.forward();
      Future.delayed(const Duration(seconds: 4), () {
        if (mounted && _hintVisible) {
          _hintVisible = false;
          _hintController.reverse();
        }
      });
    });
  }

  void _startShootingStarLoop() async {
    while (mounted) {
      await Future.delayed(const Duration(milliseconds: 4200));
      if (!mounted) break;
      await _shootingStarController.forward(from: 0);
      if (!mounted) break;
      _shootingStarController.reset();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage(_wallpaperAsset), context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _bgAnimation.dispose();
    _hintController.dispose();
    _shootingStarController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  int _realIndex(int index) => index % items.length;

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    // Cards más altas y anchas
    final double cardW = (screenW * 0.96).clamp(230.0, 380.0);
    final double cardHCenter = (screenH * 0.52).clamp(360.0, 460.0);
    final double cardHSide = cardHCenter * 0.82;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragEnd: _handleVerticalSwipe,
        child: Stack(
          children: [
            // Wallpaper original
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage(_wallpaperAsset),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.15),
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
            ),

            // NeonBackgroundPainter original
            AnimatedBuilder(
              animation: _bgAnimation,
              builder: (context, _) => CustomPaint(
                painter: _NeonBackgroundPainter(_bgAnimation.value),
                size: Size.infinite,
              ),
            ),

            // Contenido
            Column(
              children: [
                const SizedBox(height: 40),
                Expanded(
                  child: Center(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (notif) {
                        if (_hintVisible) {
                          _hintVisible = false;
                          _hintController.reverse();
                        }
                        return false;
                      },
                      child: SizedBox(
                        height: cardHCenter + 60,
                        child: PageView.builder(
                          controller: _pageController,
                          itemBuilder: (context, index) {
                            final int real = _realIndex(index);
                            final double diff = currentPage - index;
                            final bool isCenter = diff.abs() < 0.25;
                            final double scale =
                                (1 - diff.abs() * 0.23).clamp(0.78, 1.0);
                            final double opacity =
                                (1 - diff.abs() * 0.35).clamp(0.25, 1.0);

                            return Center(
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..scale(scale)
                                  ..rotateY(diff * 0.22)
                                  ..rotateX(diff * 0.1),
                                child: Opacity(
                                  opacity: opacity,
                                  child: GestureDetector(
                                    onTap: isCenter
                                        ? () => _openChallengeCard(real)
                                        : null,
                                    // AnimatedBuilder para pulso + estrella fugaz
                                    child: AnimatedBuilder(
                                      animation: Listenable.merge(
                                          [_pulseAnim, _shootingStarAnim]),
                                      builder: (context, _) {
                                        return _ChallengeCard(
                                          index: real,
                                          title: items[real],
                                          width: cardW,
                                          height: isCenter ? cardHCenter : cardHSide,
                                          gradient: gradients[real],
                                          glowColor: glowColors[real],
                                          borderColor: borderColors[real],
                                          isCenter: isCenter,
                                          glowPulse: isCenter ? _pulseAnim.value : 1.0,
                                          // La estrella fugaz solo se pinta en la card central
                                          shootingStarProgress: isCenter
                                              ? _shootingStarAnim.value
                                              : 0.0,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Hint original
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FadeTransition(
                        opacity: _hintOpacity,
                        child: const Text("Swipe to switch",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                letterSpacing: 1.2)),
                      ),
                      const SizedBox(height: 8),
                      FadeTransition(
                        opacity: _hintOpacity,
                        child: const Text(
                          "If you want to enter the image library,\nswipe the card up.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white70, fontSize: 16, height: 1.3),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
              ],
            ),
          ],
        ),
      ),
    );
  }

 // ═══════════════════════════════════════════════════════════════════════
  //  MODAL — fondo animado con estrellas + estrella fugaz
  // ═══════════════════════════════════════════════════════════════════════

  void _openChallengeCard(int index) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.65),
      builder: (_) => _ChallengeModal(
        index: index,
        gradient: gradients[index],
        glowColor: glowColors[index],
        borderColor: borderColors[index],
        title: items[index],
        description: descriptions[index],
        onOpen: () {
          // ignore: no_wildcard_variable_uses
          Navigator.pop(_);
          _openSection(items[index], descriptions[index]);
        },
      ),
    );
  }

  void _openSection(String name, String description) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SubMenuPage(sectionName: name, description: description),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  CHALLENGE MODAL — widget propio con sus animaciones
// ═══════════════════════════════════════════════════════════════════════════

class _ChallengeModal extends StatefulWidget {
  final int index;
  final List<Color> gradient;
  final Color glowColor;
  final Color borderColor;
  final String title;
  final String description;
  final VoidCallback onOpen;

  const _ChallengeModal({
    required this.index,
    required this.gradient,
    required this.glowColor,
    required this.borderColor,
    required this.title,
    required this.description,
    required this.onOpen,
  });

  @override
  State<_ChallengeModal> createState() => _ChallengeModalState();
}

class _ChallengeModalState extends State<_ChallengeModal>
    with TickerProviderStateMixin {
  // Escala de entrada
  late AnimationController _scaleController;
  late Animation<double> _scaleAnim;

  // Twinkle (parpadeo de estrellas)
  late AnimationController _twinkleController;
  late Animation<double> _twinkleAnim;

  // Estrella fugaz
  late AnimationController _shootingController;
  late Animation<double> _shootingAnim;

  // Segunda estrella fugaz (ruta diferente)
  late AnimationController _shooting2Controller;
  late Animation<double> _shooting2Anim;

  // Pulso del glow
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  // Rotación lenta del icono
  late AnimationController _iconRotController;
  late Animation<double> _iconRotAnim;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 380),
    );
    _scaleAnim = CurvedAnimation(
        parent: _scaleController, curve: Curves.easeOutBack);
    _scaleController.forward();

    _twinkleController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _twinkleAnim = CurvedAnimation(
        parent: _twinkleController, curve: Curves.easeInOut);

    _shootingController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1300),
    );
    _shootingAnim = CurvedAnimation(
        parent: _shootingController, curve: Curves.easeInOut);
    _startShootingLoop(_shootingController, 3200);

    _shooting2Controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1100),
    );
    _shooting2Anim = CurvedAnimation(
        parent: _shooting2Controller, curve: Curves.easeInOut);
    _startShootingLoop(_shooting2Controller, 5600);

    _pulseController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.88, end: 1.12).animate(
        CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));

    _iconRotController = AnimationController(
      vsync: this, duration: const Duration(seconds: 12),
    )..repeat();
    _iconRotAnim = Tween<double>(begin: 0, end: 2 * 3.14159).animate(
        CurvedAnimation(parent: _iconRotController, curve: Curves.linear));
  }

  void _startShootingLoop(AnimationController ctrl, int delayMs) async {
    await Future.delayed(Duration(milliseconds: delayMs ~/ 3));
    while (mounted) {
      await Future.delayed(Duration(milliseconds: delayMs));
      if (!mounted) break;
      await ctrl.forward(from: 0);
      if (!mounted) break;
      ctrl.reset();
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _twinkleController.dispose();
    _shootingController.dispose();
    _shooting2Controller.dispose();
    _pulseController.dispose();
    _iconRotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnim,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 40),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Container(
              // Gradiente y borde son estáticos — fuera del AnimatedBuilder
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: widget.borderColor.withOpacity(0.75),
                  width: 2.2,
                ),
              ),
              child: Stack(
                children: [
                  // ── Fondo animado: solo escucha twinkle + shooting ────
                  // Separado del resto para no arrastrar el contenido
                  Positioned.fill(
                    child: RepaintBoundary(
                      child: AnimatedBuilder(
                        animation: Listenable.merge([
                          _twinkleAnim,
                          _shootingAnim,
                          _shooting2Anim,
                        ]),
                        builder: (_, __) => CustomPaint(
                          painter: _ModalBackgroundPainter(
                            index: widget.index,
                            glowColor: widget.glowColor,
                            twinkle: _twinkleAnim.value,
                            shootingProgress: _shootingAnim.value,
                            shooting2Progress: _shooting2Anim.value,
                            pulse: 1.0, // pulse sacado del fondo
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ── Icono animado: solo escucha pulse + rotation ──────
                  // Aislado con RepaintBoundary para no redibujar el texto
                  Positioned(
                    top: 32,
                    left: 0,
                    right: 0,
                    child: RepaintBoundary(
                      child: AnimatedBuilder(
                        animation: Listenable.merge([
                          _pulseAnim,
                          _iconRotAnim,
                        ]),
                        builder: (_, __) => Center(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: CustomPaint(
                              painter: _ModalIconPainter(
                                index: widget.index,
                                glowColor: widget.glowColor,
                                pulse: _pulseAnim.value,
                                rotation: _iconRotAnim.value,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ── Textos y botones — completamente estáticos ────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 148, 24, 28),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                            letterSpacing: 0.3,
                            shadows: [
                              Shadow(
                                color: Colors.black45,
                                blurRadius: 12,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        Container(
                          width: 40,
                          height: 2,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 12),

                        Text(
                          widget.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.82),
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 28),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: widget.onOpen,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black87,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22)),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Open section",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Close",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 14,
                            ),
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
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  MODAL BACKGROUND PAINTER
//  Pinta: glow blob, estrellas con twinkle, 2 estrellas fugaces
// ═══════════════════════════════════════════════════════════════════════════

class _ModalBackgroundPainter extends CustomPainter {
  final int index;
  final Color glowColor;
  final double twinkle;
  final double shootingProgress;
  final double shooting2Progress;
  final double pulse;

  const _ModalBackgroundPainter({
    required this.index,
    required this.glowColor,
    required this.twinkle,
    required this.shootingProgress,
    required this.shooting2Progress,
    required this.pulse,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;

    // Glow blob superior (detrás del icono)
    canvas.drawCircle(
      Offset(cx, size.height * 0.22),
      90 * pulse,
      Paint()
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40)
        ..color = glowColor.withOpacity(0.28),
    );
    canvas.drawCircle(
      Offset(cx, size.height * 0.22),
      52 * pulse,
      Paint()
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20)
        ..color = glowColor.withOpacity(0.18),
    );

    // Estrellas con parpadeo
    _paintStars(canvas, size);

    // Sparkles (rombos)
    _paintSparkles(canvas, size);

    // Estrella fugaz 1 — diagonal principal
    if (shootingProgress > 0 && shootingProgress < 1) {
      _paintShootingStar(
        canvas, size, shootingProgress,
        startFx: 0.04, startFy: 0.04,
        endFx: 0.92, endFy: 0.55,
        strokeW: 2.0,
      );
    }

    // Estrella fugaz 2 — diagonal diferente
    if (shooting2Progress > 0 && shooting2Progress < 1) {
      _paintShootingStar(
        canvas, size, shooting2Progress,
        startFx: 0.60, startFy: 0.02,
        endFx: 0.96, endFy: 0.40,
        strokeW: 1.4,
      );
    }
  }

  void _paintStars(Canvas canvas, Size size) {
    final rng = Random(index * 137 + 99);
    final lp = Paint()..strokeCap = StrokeCap.round;
    const count = 48;

    for (int i = 0; i < count; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height * 0.80;
      final baseR = i % 6 == 0 ? 2.2 : i % 3 == 0 ? 1.4 : i % 2 == 0 ? 0.9 : 0.6;
      final baseOp = 0.22 + rng.nextDouble() * 0.52;

      // Parpadeo: cada estrella titila con una fase distinta
      final phase = (i * 0.37) % 1.0;
      final twinkleFactor = 0.6 + 0.4 * ((twinkle + phase) % 1.0);
      final r = baseR * twinkleFactor;
      final op = (baseOp * twinkleFactor).clamp(0.08, 0.85);

      canvas.drawCircle(
          Offset(x, y), r, Paint()..color = Colors.white.withOpacity(op));

      if (i % 6 == 0) {
        lp
          ..color = Colors.white.withOpacity(op * 0.55)
          ..strokeWidth = 0.7;
        canvas.drawLine(Offset(x - r * 3, y), Offset(x + r * 3, y), lp);
        canvas.drawLine(Offset(x, y - r * 3), Offset(x, y + r * 3), lp);
      } else if (i % 10 == 0) {
        lp
          ..color = Colors.white.withOpacity(op * 0.38)
          ..strokeWidth = 0.45;
        canvas.drawLine(Offset(x - r * 2, y), Offset(x + r * 2, y), lp);
        canvas.drawLine(Offset(x, y - r * 2), Offset(x, y + r * 2), lp);
      }
    }
  }

  void _paintSparkles(Canvas canvas, Size size) {
    final rng = Random(index * 71 + 33);
    for (int i = 0; i < 8; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height * 0.70;
      final r = 1.0 + rng.nextDouble() * 1.8;
      final op = 0.12 + rng.nextDouble() * 0.24;
      final path = Path()
        ..moveTo(x, y - r * 2.2)
        ..lineTo(x + r * 0.85, y)
        ..lineTo(x, y + r * 2.2)
        ..lineTo(x - r * 0.85, y)
        ..close();
      canvas.drawPath(path, Paint()..color = Colors.white.withOpacity(op));
    }
  }

  void _paintShootingStar(
    Canvas canvas, Size size, double progress, {
    required double startFx, required double startFy,
    required double endFx, required double endFy,
    required double strokeW,
  }) {
    final sx = size.width * startFx;
    final sy = size.height * startFy;
    final ex = size.width * endFx;
    final ey = size.height * endFy;

    final hx = sx + (ex - sx) * progress;
    final hy = sy + (ey - sy) * progress;

    const tailFrac = 0.24;
    final tailT = (progress - tailFrac).clamp(0.0, 1.0);
    final tx = sx + (ex - sx) * tailT;
    final ty = sy + (ey - sy) * tailT;

    final op = progress < 0.12
        ? progress / 0.12
        : progress > 0.70
            ? ((1 - progress) / 0.30).clamp(0.0, 1.0)
            : 1.0;
    if (op <= 0) return;

    // Cola gruesa
    canvas.drawLine(
      Offset(tx, ty), Offset(hx, hy),
      Paint()
        ..strokeWidth = strokeW
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..shader = LinearGradient(
          colors: [
            Colors.white.withOpacity(0),
            Colors.white.withOpacity(0.90 * op),
          ],
        ).createShader(Rect.fromPoints(Offset(tx, ty), Offset(hx, hy))),
    );

    // Cola fina
    canvas.drawLine(
      Offset(tx, ty), Offset(hx, hy),
      Paint()
        ..strokeWidth = strokeW * 0.38
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..shader = LinearGradient(
          colors: [
            Colors.white.withOpacity(0),
            Colors.white.withOpacity(0.42 * op),
          ],
        ).createShader(Rect.fromPoints(Offset(tx, ty), Offset(hx, hy))),
    );

    // Cabeza
    canvas.drawCircle(
        Offset(hx, hy), 2.6, Paint()..color = Colors.white.withOpacity(0.96 * op));
    canvas.drawCircle(
      Offset(hx, hy), 5.5,
      Paint()
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4)
        ..color = Colors.white.withOpacity(0.48 * op),
    );

    if (op > 0.45) {
      final sparkOp = ((op - 0.45) / 0.55).clamp(0.0, 1.0);
      const sr = 2.8;
      canvas.drawPath(
        Path()
          ..moveTo(hx, hy - sr * 1.9)
          ..lineTo(hx + sr * 0.7, hy)
          ..lineTo(hx, hy + sr * 1.9)
          ..lineTo(hx - sr * 0.7, hy)
          ..close(),
        Paint()..color = Colors.white.withOpacity(0.52 * sparkOp),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ModalBackgroundPainter old) =>
      old.twinkle != twinkle ||
      old.shootingProgress != shootingProgress ||
      old.shooting2Progress != shooting2Progress ||
      old.pulse != pulse;
}

// ═══════════════════════════════════════════════════════════════════════════
//  MODAL ICON PAINTER
//  Icono grande con glow pulsante y anillo orbital giratorio
// ═══════════════════════════════════════════════════════════════════════════

class _ModalIconPainter extends CustomPainter {
  final int index;
  final Color glowColor;
  final double pulse;
  final double rotation;

  const _ModalIconPainter({
    required this.index,
    required this.glowColor,
    required this.pulse,
    required this.rotation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.38;

    // Anillo orbital exterior giratorio
    canvas.save();
    canvas.translate(cx, cy);
    canvas.rotate(rotation);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: r * 2.6, height: r * 0.7),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = Colors.white.withOpacity(0.18),
    );
    // Punto en el anillo
    canvas.drawCircle(
      Offset(r * 1.3, 0), 3.5,
      Paint()..color = Colors.white.withOpacity(0.55),
    );
    canvas.restore();

    // Segundo anillo más pequeño, gira al revés
    canvas.save();
    canvas.translate(cx, cy);
    canvas.rotate(-rotation * 0.6);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: r * 2.0, height: r * 0.5),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8
        ..color = Colors.white.withOpacity(0.10),
    );
    canvas.restore();

    // Glow del icono
    canvas.drawCircle(
      Offset(cx, cy), r * pulse,
      Paint()
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 22)
        ..color = glowColor.withOpacity(0.35),
    );

    // Icono
    _paintIcon(canvas, size, cx, cy, r * 0.75);
  }

  void _paintIcon(
      Canvas canvas, Size size, double cx, double cy, double iconR) {
    switch (index) {
      case 0:
        _paintMaterialIcon(canvas, Icons.public, cx, cy, iconR * 0.72);
        break;
      case 1:
        _paintMoon(canvas, cx, cy, iconR * 0.78);
        break;
      case 2:
        _paintMaterialIcon(canvas, Icons.wb_sunny, cx, cy, iconR * 0.72);
        break;
      case 3:
        _paintConstellation(canvas, size, cx, cy, iconR);
        break;
      case 4:
        _paintGalaxy(canvas, cx, cy, iconR * 0.82);
        break;
    }
  }

  void _paintMaterialIcon(
      Canvas canvas, IconData icon, double cx, double cy, double size) {
    final tp = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: size * 2,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: Colors.white.withOpacity(0.95),
          shadows: [
            Shadow(color: Colors.white.withOpacity(0.5), blurRadius: 24),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(cx - tp.width / 2, cy - tp.height / 2));
  }

  void _paintMoon(Canvas canvas, double cx, double cy, double r) {
    final moon = Path()..addOval(Rect.fromCircle(center: Offset(cx, cy), radius: r));
    final cut = Path()..addOval(
        Rect.fromCircle(center: Offset(cx + r * 0.42, cy), radius: r * 0.82));
    canvas.drawPath(
      Path.combine(PathOperation.difference, moon, cut),
      Paint()..color = Colors.white.withOpacity(0.95),
    );
    final sp = Paint();
    sp.color = Colors.white.withOpacity(0.65);
    canvas.drawCircle(Offset(cx + r * 1.1, cy - r * 0.65), 3.5, sp);
    sp.color = Colors.white.withOpacity(0.48);
    canvas.drawCircle(Offset(cx + r * 1.4, cy + r * 0.5), 2.2, sp);
    sp.color = Colors.white.withOpacity(0.55);
    canvas.drawCircle(Offset(cx + r * 0.72, cy - r * 1.05), 1.8, sp);
  }

  void _paintConstellation(
      Canvas canvas, Size size, double cx, double cy, double r) {
    // Constelación centrada en (cx, cy) escalada por r
    final offsets = [
      Offset(-r * 0.45, -r * 0.60),
      Offset(0, -r * 0.68),
      Offset(r * 0.52, -r * 0.38),
      Offset(r * 0.28, 0),
      Offset(-r * 0.12, -r * 0.10),
      Offset(-r * 0.62, -r * 0.18),
      Offset(0, r * 0.32),
      Offset(r * 0.45, r * 0.22),
    ].map((o) => Offset(cx + o.dx, cy + o.dy)).toList();

    const lines = [
      [0, 1], [1, 2], [2, 3], [3, 4],
      [4, 5], [4, 6], [3, 7], [1, 4], [0, 4]
    ];

    final lp = Paint()
      ..color = Colors.white.withOpacity(0.42)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    for (final l in lines) {
      canvas.drawLine(offsets[l[0]], offsets[l[1]], lp);
    }

    for (int i = 0; i < offsets.length; i++) {
      final sr = i == 1 || i == 3 ? 5.0 : i == 0 || i == 6 ? 4.0 : 3.0;
      canvas.drawCircle(offsets[i], sr * 2.2,
          Paint()..color = Colors.white.withOpacity(0.10));
      canvas.drawCircle(offsets[i], sr,
          Paint()..color = Colors.white.withOpacity(0.92));
    }
  }

  void _paintGalaxy(Canvas canvas, double cx, double cy, double r) {
    void ellipse(double rx, double ry, double sw, double op) {
      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(-18 * 3.14159 / 180);
      canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: rx * 2, height: ry * 2),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = sw
          ..color = Colors.white.withOpacity(op),
      );
      canvas.restore();
    }

    ellipse(r * 1.50, r * 0.43, 1.3, 0.28);
    ellipse(r * 1.09, r * 0.30, 1.6, 0.42);
    ellipse(r * 0.64, r * 0.16, 2.2, 0.62);

    canvas.drawCircle(Offset(cx, cy), 12,
        Paint()..color = Colors.white.withOpacity(0.38));
    canvas.drawCircle(Offset(cx, cy), 6,
        Paint()..color = Colors.white.withOpacity(0.80));

    final rocket = Path()
      ..moveTo(cx + r * 0.30, cy - r * 0.55)
      ..lineTo(cx + r * 0.46, cy - r * 0.88)
      ..lineTo(cx + r * 0.19, cy - r * 0.72)
      ..close();
    canvas.drawPath(rocket, Paint()..color = Colors.white.withOpacity(0.68));

    final sp = Paint();
    sp.color = Colors.white.withOpacity(0.65);
    canvas.drawCircle(Offset(cx - r, cy - r * 0.27), 3.5, sp);
    sp.color = Colors.white.withOpacity(0.52);
    canvas.drawCircle(Offset(cx + r * 1.05, cy + r * 0.19), 2.5, sp);
  }

  @override
  bool shouldRepaint(covariant _ModalIconPainter old) =>
      old.pulse != pulse || old.rotation != rotation || old.index != index;
}

// ═══════════════════════════════════════════════════════════════════════════
//  CHALLENGE CARD WIDGET
// ═══════════════════════════════════════════════════════════════════════════

class _ChallengeCard extends StatelessWidget {
  final int index;
  final String title;
  final double width;
  final double height;
  final List<Color> gradient;
  final Color glowColor;
  final Color borderColor;
  final bool isCenter;
  final double glowPulse;
  final double shootingStarProgress;

  const _ChallengeCard({
    required this.index,
    required this.title,
    required this.width,
    required this.height,
    required this.gradient,
    required this.glowColor,
    required this.borderColor,
    required this.isCenter,
    this.glowPulse = 1.0,
    this.shootingStarProgress = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: glowColor
                .withOpacity(isCenter ? (0.68 * glowPulse).clamp(0.4, 0.75) : 0.2),
            blurRadius: isCenter ? 60 * glowPulse : 16,
            spreadRadius: isCenter ? 6 * glowPulse : 1,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(isCenter ? 0.45 : 0.22),
            blurRadius: isCenter ? 28 : 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: CustomPaint(
          painter: _ChallengeCardPainter(
            index: index,
            gradient: gradient,
            glowColor: glowColor,
            borderColor: borderColor,
            isCenter: isCenter,
            glowPulse: glowPulse,
            shootingStarProgress: shootingStarProgress,
          ),
          child: SizedBox(
            width: width,
            height: height,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 26),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isCenter ? 24 : 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.22,
                    letterSpacing: 0.2,
                    shadows: const [
                      Shadow(
                          color: Colors.black54,
                          blurRadius: 16,
                          offset: Offset(0, 2)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  CHALLENGE CARD PAINTER
// ═══════════════════════════════════════════════════════════════════════════

class _ChallengeCardPainter extends CustomPainter {
  final int index;
  final List<Color> gradient;
  final Color glowColor;
  final Color borderColor;
  final bool isCenter;
  final double glowPulse;
  final double shootingStarProgress;

  const _ChallengeCardPainter({
    required this.index,
    required this.gradient,
    required this.glowColor,
    required this.borderColor,
    required this.isCenter,
    this.glowPulse = 1.0,
    this.shootingStarProgress = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(32));
    final cx = size.width / 2;
    final cy = size.height * 0.30;

    // 1 — Gradiente de fondo
    canvas.drawRRect(
      rrect,
      Paint()
        ..shader = LinearGradient(
          colors: gradient,
          begin: const Alignment(0.3, -1),
          end: const Alignment(0.7, 1),
        ).createShader(rect),
    );

    // 2 — Glow blob con pulso
    if (isCenter) {
      canvas.drawCircle(
        Offset(cx, cy),
        72 * glowPulse,
        Paint()
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 32)
          ..color = glowColor.withOpacity(0.24),
      );
      canvas.drawCircle(
        Offset(cx, cy),
        42 * glowPulse,
        Paint()
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16)
          ..color = glowColor.withOpacity(0.15),
      );
    }

    // 3 — Estrellas densas
    _paintStars(canvas, size);

    // 4 — Estrella fugaz DENTRO de la card (solo central)
    if (isCenter && shootingStarProgress > 0 && shootingStarProgress < 1) {
      _paintShootingStar(canvas, size, shootingStarProgress);
    }

    // 5 — Icono
    _paintIcon(canvas, size, cx, cy);

    // 6 — Sparkles decorativos (rombos)
    _paintSparkles(canvas, size);

    // 7 — Shimmer top-left
    canvas.drawRRect(
      rrect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(isCenter ? 0.15 : 0.07),
            Colors.transparent,
          ],
          stops: const [0.0, 0.50],
        ).createShader(rect),
    );

    // 8 — Fade inferior
    canvas.drawRRect(
      rrect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black.withOpacity(0.55)],
          stops: const [0.40, 1.0],
        ).createShader(rect),
    );

    // 9 — Borde luminoso
    canvas.drawRRect(
      rrect,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = isCenter ? 2.6 : 1.4
        ..color = borderColor.withOpacity(isCenter ? 0.78 : 0.28),
    );

    // 10 — Inner glow borde (solo central)
    if (isCenter) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect.deflate(1.5), const Radius.circular(31)),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0
          ..color = Colors.white.withOpacity(0.12),
      );
    }
  }

  // ── Estrella fugaz DENTRO de la card ─────────────────────────────────
  void _paintShootingStar(Canvas canvas, Size size, double progress) {
    // Trayectoria dentro de la card: esquina top-left → zona media-derecha
    final startX = size.width * 0.05;
    final startY = size.height * 0.06;
    final endX = size.width * 0.88;
    final endY = size.height * 0.45;

    final headX = startX + (endX - startX) * progress;
    final headY = startY + (endY - startY) * progress;

    // Cola larga (22% del trayecto total)
    final tailFrac = 0.22;
    final tailT = (progress - tailFrac).clamp(0.0, 1.0);
    final tailX = startX + (endX - startX) * tailT;
    final tailY = startY + (endY - startY) * tailT;

    // Opacidad con fade-in y fade-out
    final op = progress < 0.12
        ? progress / 0.12
        : progress > 0.72
            ? ((1 - progress) / 0.28).clamp(0.0, 1.0)
            : 1.0;

    if (op <= 0) return;

    // Cola con gradiente de transparente → blanco
    final tailPaint = Paint()
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..shader = LinearGradient(
        colors: [
          Colors.white.withOpacity(0),
          Colors.white.withOpacity(0.88 * op),
        ],
      ).createShader(
          Rect.fromPoints(Offset(tailX, tailY), Offset(headX, headY)));

    canvas.drawLine(Offset(tailX, tailY), Offset(headX, headY), tailPaint);

    // Segundo trazo más fino para profundidad
    final tailPaint2 = Paint()
      ..strokeWidth = 0.8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..shader = LinearGradient(
        colors: [
          Colors.white.withOpacity(0),
          Colors.white.withOpacity(0.45 * op),
        ],
      ).createShader(
          Rect.fromPoints(Offset(tailX, tailY), Offset(headX, headY)));
    canvas.drawLine(Offset(tailX, tailY), Offset(headX, headY), tailPaint2);

    // Cabeza — punto brillante
    canvas.drawCircle(
      Offset(headX, headY),
      2.8,
      Paint()..color = Colors.white.withOpacity(0.97 * op),
    );

    // Glow en la cabeza
    canvas.drawCircle(
      Offset(headX, headY),
      6.0,
      Paint()
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5)
        ..color = Colors.white.withOpacity(0.50 * op),
    );

    // Destellito en la cabeza (rombo pequeño)
    if (op > 0.5) {
      final sparkOp = (op - 0.5) * 2;
      const sr = 3.0;
      final sparkPath = Path()
        ..moveTo(headX, headY - sr * 1.8)
        ..lineTo(headX + sr * 0.7, headY)
        ..lineTo(headX, headY + sr * 1.8)
        ..lineTo(headX - sr * 0.7, headY)
        ..close();
      canvas.drawPath(
        sparkPath,
        Paint()..color = Colors.white.withOpacity(0.55 * sparkOp),
      );
    }
  }

  // ── Estrellas densas ──────────────────────────────────────────────────
  void _paintStars(Canvas canvas, Size size) {
    final rng = Random(index * 137 + 42);
    final lp = Paint()..strokeCap = StrokeCap.round;
    const count = 42;

    for (int i = 0; i < count; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height * 0.76;
      final r = i % 6 == 0
          ? 2.4
          : i % 3 == 0
              ? 1.5
              : i % 2 == 0
                  ? 1.0
                  : 0.65;
      final op = 0.25 + rng.nextDouble() * 0.58;

      canvas.drawCircle(
          Offset(x, y), r, Paint()..color = Colors.white.withOpacity(op));

      if (i % 6 == 0) {
        lp
          ..color = Colors.white.withOpacity(op * 0.6)
          ..strokeWidth = 0.8;
        canvas.drawLine(Offset(x - r * 3.2, y), Offset(x + r * 3.2, y), lp);
        canvas.drawLine(Offset(x, y - r * 3.2), Offset(x, y + r * 3.2), lp);
      } else if (i % 9 == 0) {
        lp
          ..color = Colors.white.withOpacity(op * 0.42)
          ..strokeWidth = 0.5;
        canvas.drawLine(Offset(x - r * 2, y), Offset(x + r * 2, y), lp);
        canvas.drawLine(Offset(x, y - r * 2), Offset(x, y + r * 2), lp);
      }
    }
  }

  // ── Sparkles (rombos) ─────────────────────────────────────────────────
  void _paintSparkles(Canvas canvas, Size size) {
    final rng = Random(index * 53 + 17);
    for (int i = 0; i < 7; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height * 0.65;
      final r = 1.2 + rng.nextDouble() * 1.6;
      final op = 0.16 + rng.nextDouble() * 0.28;
      final path = Path()
        ..moveTo(x, y - r * 2.2)
        ..lineTo(x + r * 0.9, y)
        ..lineTo(x, y + r * 2.2)
        ..lineTo(x - r * 0.9, y)
        ..close();
      canvas.drawPath(path, Paint()..color = Colors.white.withOpacity(op));
    }
  }

  // ── Router de iconos ──────────────────────────────────────────────────
  void _paintIcon(Canvas canvas, Size size, double cx, double cy) {
    switch (index) {
      case 0:
        _paintMaterialIcon(canvas, Icons.public, cx, cy, 46);
        break;
      case 1:
        _paintMoon(canvas, cx, cy, 40);
        break;
      case 2:
        _paintMaterialIcon(canvas, Icons.wb_sunny, cx, cy, 46);
        break;
      case 3:
        _paintConstellation(canvas, size);
        break;
      case 4:
        _paintGalaxy(canvas, cx, cy, 48);
        break;
    }
  }

  void _paintMaterialIcon(
      Canvas canvas, IconData icon, double cx, double cy, double size) {
    final tp = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: size * 2,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: Colors.white.withOpacity(0.93),
          shadows: [
            Shadow(color: Colors.white.withOpacity(0.45), blurRadius: 20),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(cx - tp.width / 2, cy - tp.height / 2));
  }

  void _paintMoon(Canvas canvas, double cx, double cy, double r) {
    final moonPath = Path()
      ..addOval(Rect.fromCircle(center: Offset(cx, cy), radius: r));
    final cutPath = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(cx + r * 0.42, cy), radius: r * 0.82));
    final crescent =
        Path.combine(PathOperation.difference, moonPath, cutPath);
    canvas.drawPath(crescent, Paint()..color = Colors.white.withOpacity(0.93));
    final sp = Paint();
    sp.color = Colors.white.withOpacity(0.62);
    canvas.drawCircle(Offset(cx + r * 1.1, cy - r * 0.65), 3.0, sp);
    sp.color = Colors.white.withOpacity(0.46);
    canvas.drawCircle(Offset(cx + r * 1.4, cy + r * 0.50), 2.0, sp);
    sp.color = Colors.white.withOpacity(0.52);
    canvas.drawCircle(Offset(cx + r * 0.72, cy - r * 1.05), 1.5, sp);
  }

  void _paintConstellation(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final pts = [
      Offset(0.28 * w, 0.10 * h * 1.05 + h * 0.04),
      Offset(0.55 * w, 0.08 * h * 1.05 + h * 0.04),
      Offset(0.76 * w, 0.18 * h * 1.05 + h * 0.04),
      Offset(0.62 * w, 0.30 * h * 1.05 + h * 0.04),
      Offset(0.40 * w, 0.26 * h * 1.05 + h * 0.04),
      Offset(0.18 * w, 0.22 * h * 1.05 + h * 0.04),
      Offset(0.50 * w, 0.38 * h * 1.05 + h * 0.04),
      Offset(0.72 * w, 0.34 * h * 1.05 + h * 0.04),
    ];
    const lines = [
      [0, 1], [1, 2], [2, 3], [3, 4],
      [4, 5], [4, 6], [3, 7], [1, 4], [0, 4]
    ];
    final lp = Paint()
      ..color = Colors.white.withOpacity(0.38)
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke;
    for (final l in lines) {
      canvas.drawLine(pts[l[0]], pts[l[1]], lp);
    }
    for (int i = 0; i < pts.length; i++) {
      final r = i == 1 || i == 3 ? 5.5 : i == 0 || i == 6 ? 4.5 : 3.5;
      canvas.drawCircle(
          pts[i], r * 2.5, Paint()..color = Colors.white.withOpacity(0.09));
      canvas.drawCircle(
          pts[i], r, Paint()..color = Colors.white.withOpacity(0.92));
    }
  }

  void _paintGalaxy(Canvas canvas, double cx, double cy, double r) {
    void drawEllipse(double rx, double ry, double sw, double op) {
      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(-18 * pi / 180);
      canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: rx * 2, height: ry * 2),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = sw
          ..color = Colors.white.withOpacity(op),
      );
      canvas.restore();
    }

    drawEllipse(r * 1.50, r * 0.43, 1.1, 0.25);
    drawEllipse(r * 1.09, r * 0.30, 1.5, 0.38);
    drawEllipse(r * 0.64, r * 0.16, 2.0, 0.58);

    canvas.drawCircle(
        Offset(cx, cy), 11, Paint()..color = Colors.white.withOpacity(0.35));
    canvas.drawCircle(
        Offset(cx, cy), 6, Paint()..color = Colors.white.withOpacity(0.78));

    final rocket = Path()
      ..moveTo(cx + 14, cy - 26)
      ..lineTo(cx + 22, cy - 42)
      ..lineTo(cx + 9, cy - 35)
      ..close();
    canvas.drawPath(rocket, Paint()..color = Colors.white.withOpacity(0.65));

    final sp = Paint();
    sp.color = Colors.white.withOpacity(0.65);
    canvas.drawCircle(Offset(cx - r, cy - 13), 3.5, sp);
    sp.color = Colors.white.withOpacity(0.55);
    canvas.drawCircle(Offset(cx + r * 1.07, cy + 9), 2.5, sp);
    sp.color = Colors.white.withOpacity(0.50);
    canvas.drawCircle(Offset(cx - r * 0.64, cy + 20), 2.0, sp);
  }

  @override
  bool shouldRepaint(covariant _ChallengeCardPainter old) =>
      old.index != index ||
      old.isCenter != isCenter ||
      old.glowPulse != glowPulse ||
      old.shootingStarProgress != shootingStarProgress;
}

// ═══════════════════════════════════════════════════════════════════════════
//  ICON ONLY PAINTER — modal
// ═══════════════════════════════════════════════════════════════════════════

class _IconOnlyPainter extends CustomPainter {
  final int index;
  const _IconOnlyPainter({required this.index});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final p = _ChallengeCardPainter(
      index: index,
      gradient: const [Colors.transparent],
      glowColor: Colors.transparent,
      borderColor: Colors.transparent,
      isCenter: true,
    );
    p._paintIcon(canvas, size, cx, cy);
  }

  @override
  bool shouldRepaint(covariant _IconOnlyPainter old) => old.index != index;
}

// ═══════════════════════════════════════════════════════════════════════════
//  NEON BACKGROUND PAINTER — original sin cambios
// ═══════════════════════════════════════════════════════════════════════════

class _NeonBackgroundPainter extends CustomPainter {
  final double t;
  const _NeonBackgroundPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (int i = 0; i < 3; i++) {
      final double radius = (400 + i * 150).toDouble();
      final dx = size.width * (0.5 + sin(t * 2 + i) * 0.2);
      final dy = size.height * (0.5 + cos(t * 2 + i) * 0.2);
      paint.shader = RadialGradient(
        colors: [
          Colors.primaries[(i * 2) % Colors.primaries.length].withOpacity(0.25),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: Offset(dx, dy), radius: radius));
      canvas.drawCircle(Offset(dx, dy), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _NeonBackgroundPainter old) => true;
}

// ═══════════════════════════════════════════════════════════════════════════
//  FLOATING MESSAGE — original sin cambios
// ═══════════════════════════════════════════════════════════════════════════

class _FloatingMessage extends StatefulWidget {
  final String message;
  const _FloatingMessage({required this.message});

  @override
  State<_FloatingMessage> createState() => _FloatingMessageState();
}

class _FloatingMessageState extends State<_FloatingMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 6)),
          ],
          border: Border.all(color: Colors.white.withOpacity(0.15)),
        ),
        child: Center(
          child: Text(widget.message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}