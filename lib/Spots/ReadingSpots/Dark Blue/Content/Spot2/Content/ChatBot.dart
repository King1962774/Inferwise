import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Dark Blue/Content/Spot2/Spot_Page/Reading_Spot.dart';
import 'dart:math' as math;

import 'dart:math';

class AIDrugResistanceGreenSplash extends StatefulWidget {
  const AIDrugResistanceGreenSplash({super.key});

  @override
  State<AIDrugResistanceGreenSplash> createState() =>
      _AIDrugResistanceGreenSplashState();
}

class _AIDrugResistanceGreenSplashState
    extends State<AIDrugResistanceGreenSplash> with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _floatController;
  late AnimationController _bgController;
  late AnimationController _pulseController;
  late AnimationController _scanController;

  late Animation<double> _fadeIn;
  late Animation<double> _scaleUp;
  late Animation<double> _titleSlide;
  late Animation<double> _authorFade;
  late Animation<double> _dividerWidth;
  late Animation<double> _iconPulse;
  late Animation<double> _glowPulse;
  late Animation<double> _scanAnim;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _floatController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _bgController = AnimationController(
      duration: const Duration(seconds: 9),
      vsync: this,
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scanController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _fadeIn = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    _scaleUp = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _titleSlide = Tween<double>(begin: 28, end: 0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.3, 0.75, curve: Curves.easeOutCubic),
      ),
    );

    _authorFade = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
    );

    _dividerWidth = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 0.9, curve: Curves.easeOutCubic),
      ),
    );

    _iconPulse = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _glowPulse = Tween<double>(begin: 0.12, end: 0.38).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Scan line: -1.0 = top, 1.0 = bottom of icon
    _scanAnim = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(parent: _scanController, curve: Curves.easeInOut),
    );

    _mainController.forward();

    Future.delayed(const Duration(milliseconds: 4500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const ChatBot(),
            transitionsBuilder: (_, anim, __, child) => FadeTransition(
              opacity: anim,
              child: child,
            ),
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _floatController.dispose();
    _bgController.dispose();
    _pulseController.dispose();
    _scanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // ── Fondo verde animado ──
          _AnimatedBackground(
            floatController: _floatController,
            bgController: _bgController,
            size: size,
          ),

          // ── Contenido principal ──
          Center(
            child: FadeTransition(
              opacity: _fadeIn,
              child: ScaleTransition(
                scale: _scaleUp,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icono flotante robot con scan line
                      AnimatedBuilder(
                        animation: Listenable.merge([
                          _floatController,
                          _pulseController,
                          _scanController,
                        ]),
                        builder: (_, __) => Transform.translate(
                          offset: Offset(0, -9 * _floatController.value + 4.5),
                          child: SizedBox(
                            width: 120,
                            height: 120,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Glow ring
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white
                                          .withOpacity(_glowPulse.value),
                                      width: 1,
                                    ),
                                  ),
                                ),

                                // Círculo principal pulsando
                                Transform.scale(
                                  scale: _iconPulse.value,
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.12),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.22),
                                        width: 1.5,
                                      ),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        // Robot icon
                                        CustomPaint(
                                          size: const Size(54, 54),
                                          painter: _RobotIconPainter(),
                                        ),

                                        // Scan line animada
                                        Positioned(
                                          top: 50 + _scanAnim.value * 50 - 1,
                                          left: 0,
                                          right: 0,
                                          child: Opacity(
                                            opacity:
                                                (1.0 - (_scanAnim.value).abs())
                                                    .clamp(0.0, 0.7),
                                            child: Container(
                                              height: 2,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.transparent,
                                                    Colors.white
                                                        .withOpacity(0.6),
                                                    Colors.transparent,
                                                  ],
                                                ),
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
                        ),
                      ),

                      const SizedBox(height: 26),

                      // Título con slide-up
                      AnimatedBuilder(
                        animation: _titleSlide,
                        builder: (_, child) => Transform.translate(
                          offset: Offset(0, _titleSlide.value),
                          child: Opacity(
                            opacity:
                                (1 - _titleSlide.value / 28).clamp(0.0, 1.0),
                            child: child,
                          ),
                        ),
                        child: Text(
                          "AI Chatbot Deployed to Target\nDrug Resistance",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.42,
                            letterSpacing: 0.2,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 12,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Divider animado
                      AnimatedBuilder(
                        animation: _dividerWidth,
                        builder: (_, __) => Container(
                          width: 140 * _dividerWidth.value,
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.white.withOpacity(0.45),
                                Colors.transparent,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Autor
                      FadeTransition(
                        opacity: _authorFade,
                        child: Text(
                          "By Dann Okoth, 2025",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.7),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Autor
                      FadeTransition(
                        opacity: _authorFade,
                        child: Text(
                          "From SciDev.Net",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.7),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),

                      const SizedBox(height: 34),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Fondo animado ─────────────────────────────────────────────────────────

class _AnimatedBackground extends StatelessWidget {
  final AnimationController floatController;
  final AnimationController bgController;
  final Size size;

  const _AnimatedBackground({
    required this.floatController,
    required this.bgController,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([floatController, bgController]),
      builder: (_, __) => CustomPaint(
        size: size,
        painter: _BackgroundPainter(
          floatValue: floatController.value,
          bgValue: bgController.value,
        ),
      ),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final double floatValue;
  final double bgValue;

  _BackgroundPainter({required this.floatValue, required this.bgValue});

  static const Color _darkGreen = Color(0xFF123D23);
  static const Color _midGreen = Color(0xFF1A5C35);
  static const Color _lightGreen = Color(0xFF2D7A4F);

  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(33);

    // Gradiente de fondo
    final bgRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final bgPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_lightGreen, _midGreen, _darkGreen],
        stops: [0.0, 0.45 + 0.05 * sin(bgValue * 2 * pi), 1.0],
        transform: GradientRotation(pi * (0.44 + 0.04 * sin(bgValue * pi))),
      ).createShader(bgRect);
    canvas.drawRect(bgRect, bgPaint);

    // Blobs
    _drawBlob(
        canvas,
        Offset(size.width * 0.2 + 6 * sin(bgValue * 2 * pi),
            size.height * 0.15 - 8 * cos(bgValue * 2 * pi)),
        220,
        Colors.white.withOpacity(0.04 + 0.02 * sin(bgValue * 2 * pi)));
    _drawBlob(canvas, Offset(size.width * 0.85, size.height * 0.85), 180,
        Colors.black.withOpacity(0.12 + 0.04 * cos(bgValue * 2 * pi)));
    _drawBlob(canvas, Offset(size.width * 0.1, size.height * 0.78), 140,
        Colors.white.withOpacity(0.035));

    // Cuadrícula sutil
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.055)
      ..strokeWidth = 0.7;
    const step = 55.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Partículas
    final particles = List.generate(12, (i) {
      final x = (rng.nextDouble() * 0.82 + 0.09) * size.width;
      final baseY = (rng.nextDouble() * 0.82 + 0.09) * size.height;
      final speed = 0.6 + rng.nextDouble() * 1.4;
      final phase = rng.nextDouble() * 2 * pi;
      final y = baseY - 16 * sin(floatValue * pi * speed + phase).abs();
      final rot = 0.14 * sin(floatValue * pi * speed + phase);
      return (x, y, rot, rng.nextDouble(), i % 4);
    });

    for (final p in particles) {
      canvas.save();
      canvas.translate(p.$1, p.$2);
      canvas.rotate(p.$3);
      final opacity = 0.18 + 0.12 * p.$4;
      switch (p.$5) {
        case 0:
          _drawChip(canvas, opacity, p.$4 * 5 + 14);
          break;
        case 1:
          _drawDNAHelix(canvas, opacity, p.$4 * 5 + 13);
          break;
        case 2:
          _drawMolecule(canvas, opacity, p.$4 * 5 + 12);
          break;
        case 3:
          _drawDiamond(canvas, opacity, p.$4 * 4 + 8);
          break;
      }
      canvas.restore();
    }
  }

  void _drawBlob(Canvas canvas, Offset center, double radius, Color color) {
    canvas.drawCircle(center, radius, Paint()..color = color);
  }

  void _drawChip(Canvas canvas, double opacity, double sz) {
    final fillPaint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = Colors.white.withOpacity(opacity * 1.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    final pinPaint = Paint()
      ..color = Colors.white.withOpacity(opacity * 0.85)
      ..strokeWidth = 0.9
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Body
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset.zero, width: sz, height: sz),
        Radius.circular(sz * 0.18),
      ),
      fillPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset.zero, width: sz, height: sz),
        Radius.circular(sz * 0.18),
      ),
      strokePaint,
    );

    // Inner core
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: Offset.zero, width: sz * 0.48, height: sz * 0.48),
        Radius.circular(sz * 0.08),
      ),
      Paint()
        ..color = Colors.white.withOpacity(opacity * 0.55)
        ..style = PaintingStyle.fill,
    );

    // Pins
    final pinPositions = [-sz * 0.25, 0, sz * 0.25];
    for (final pos in pinPositions) {
      canvas.drawLine(Offset(-sz * 0.5, pos.toDouble()),
          Offset(-sz * 0.72, pos.toDouble()), pinPaint);
      canvas.drawLine(Offset(sz * 0.5, pos.toDouble()),
          Offset(sz * 0.72, pos.toDouble()), pinPaint);
      canvas.drawLine(Offset(pos.toDouble(), -sz * 0.5),
          Offset(pos.toDouble(), -sz * 0.72), pinPaint);
    }
  }

  void _drawDNAHelix(Canvas canvas, double opacity, double sz) {
    final strokeL = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final strokeR = Paint()
      ..color = Colors.white.withOpacity(opacity * 0.75)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final rungPaint = Paint()
      ..color = Colors.white.withOpacity(opacity * 0.6)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final h = sz * 2.2;
    final pathL = Path();
    final pathR = Path();
    const steps = 30;
    for (int i = 0; i <= steps; i++) {
      final t = i / steps;
      final y = -h / 2 + t * h;
      final xL = -sz * 0.45 * sin(t * 2 * pi);
      final xR = sz * 0.45 * sin(t * 2 * pi);
      i == 0 ? pathL.moveTo(xL, y) : pathL.lineTo(xL, y);
      i == 0 ? pathR.moveTo(xR, y) : pathR.lineTo(xR, y);
    }
    canvas.drawPath(pathL, strokeL);
    canvas.drawPath(pathR, strokeR);

    for (double t = 0.2; t < 1.0; t += 0.3) {
      final y = -h / 2 + t * h;
      final xL = -sz * 0.45 * sin(t * 2 * pi);
      final xR = sz * 0.45 * sin(t * 2 * pi);
      canvas.drawLine(Offset(xL, y), Offset(xR, y), rungPaint);
    }
  }

  void _drawMolecule(Canvas canvas, double opacity, double sz) {
    final nodePaint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.fill;
    final bondPaint = Paint()
      ..color = Colors.white.withOpacity(opacity * 0.7)
      ..strokeWidth = 0.9
      ..style = PaintingStyle.stroke;

    final nodes = [
      Offset(0, 0),
      Offset(-sz * 0.7, -sz * 0.5),
      Offset(sz * 0.7, -sz * 0.5),
      Offset(-sz * 0.7, sz * 0.5),
      Offset(sz * 0.7, sz * 0.5),
    ];
    final radii = [sz * 0.25, sz * 0.18, sz * 0.18, sz * 0.18, sz * 0.18];

    for (int i = 1; i < nodes.length; i++) {
      canvas.drawLine(nodes[0], nodes[i], bondPaint);
    }
    for (int i = 0; i < nodes.length; i++) {
      canvas.drawCircle(nodes[i], radii[i], nodePaint);
    }
  }

  void _drawDiamond(Canvas canvas, double opacity, double sz) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.fill;
    final stroke = Paint()
      ..color = Colors.white.withOpacity(opacity * 1.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.7;

    final path = Path()
      ..moveTo(0, -sz)
      ..lineTo(sz * 0.6, 0)
      ..lineTo(0, sz)
      ..lineTo(-sz * 0.6, 0)
      ..close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(_BackgroundPainter old) =>
      old.floatValue != floatValue || old.bgValue != bgValue;
}

// ── Icono Robot central ───────────────────────────────────────────────────

class _RobotIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final whitePaint = Paint()
      ..color = Colors.white.withOpacity(0.88)
      ..style = PaintingStyle.fill;
    final accentPaint = Paint()
      ..color = const Color(0xFF1E643C).withOpacity(0.5)
      ..style = PaintingStyle.fill;
    final dimPaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.fill;
    final eyeGlowPaint = Paint()
      ..color = Colors.white.withOpacity(0.85)
      ..style = PaintingStyle.fill;

    // Head body
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.18, h * 0.26, w * 0.64, h * 0.52),
        const Radius.circular(6),
      ),
      whitePaint,
    );

    // Left eye
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.26, h * 0.38, w * 0.18, h * 0.14),
        const Radius.circular(3),
      ),
      accentPaint,
    );
    canvas.drawCircle(Offset(w * 0.305, h * 0.43), w * 0.035, eyeGlowPaint);

    // Right eye
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.56, h * 0.38, w * 0.18, h * 0.14),
        const Radius.circular(3),
      ),
      accentPaint,
    );
    canvas.drawCircle(Offset(w * 0.595, h * 0.43), w * 0.035, eyeGlowPaint);

    // Mouth data bar background
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.26, h * 0.60, w * 0.48, h * 0.08),
        const Radius.circular(3),
      ),
      accentPaint..color = const Color(0xFF1E643C).withOpacity(0.3),
    );
    // Mouth data bar fill
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.26, h * 0.60, w * 0.30, h * 0.08),
        const Radius.circular(3),
      ),
      accentPaint..color = const Color(0xFF1E643C).withOpacity(0.55),
    );

    // Antenna stem
    final antennaPaint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(w * 0.5, h * 0.26),
      Offset(w * 0.5, h * 0.13),
      antennaPaint,
    );
    // Antenna tip
    canvas.drawCircle(
      Offset(w * 0.5, h * 0.10),
      w * 0.055,
      Paint()
        ..color = Colors.white.withOpacity(0.85)
        ..style = PaintingStyle.fill,
    );

    // Left ear
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.09, h * 0.38, w * 0.09, h * 0.18),
        const Radius.circular(3),
      ),
      dimPaint,
    );
    // Right ear
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.82, h * 0.38, w * 0.09, h * 0.18),
        const Radius.circular(3),
      ),
      dimPaint,
    );

    // DNA accent at bottom
    final dnaStroke = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final dnaPath = Path()
      ..moveTo(w * 0.28, h * 0.82)
      ..cubicTo(w * 0.37, h * 0.77, w * 0.44, h * 0.87, w * 0.5, h * 0.82)
      ..cubicTo(w * 0.56, h * 0.77, w * 0.63, h * 0.87, w * 0.72, h * 0.82);
    canvas.drawPath(dnaPath, dnaStroke);
  }

  @override
  bool shouldRepaint(_RobotIconPainter old) => false;
}

// ── Dots de carga ─────────────────────────────────────────────────────────

class _LoadingDots extends StatefulWidget {
  const _LoadingDots();

  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with TickerProviderStateMixin {
  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _anims = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 3; i++) {
      final c = AnimationController(
        duration: const Duration(milliseconds: 650),
        vsync: this,
      );
      _controllers.add(c);
      _anims.add(Tween<double>(begin: 0, end: -5).animate(
        CurvedAnimation(parent: c, curve: Curves.easeInOut),
      ));
      Future.delayed(Duration(milliseconds: i * 180), () {
        if (mounted) c.repeat(reverse: true);
      });
    }
  }

  @override
  void dispose() {
    // ignore: curly_braces_in_flow_control_structures
    for (final c in _controllers) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        return AnimatedBuilder(
          animation: _anims[i],
          builder: (_, __) => Transform.translate(
            offset: Offset(0, _anims[i].value),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.45),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});
  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "🤖 What is a chatbot designed to do?",
      "options": [
        "A) Clean data from internet",
        "B) Build websites",
        "C) Simulate human conversation",
        "D) Diagnose illnesses and viruses"
      ],
      "correct": 2,
      "feedback": [
        " Cleaning data is a different task; chatbots focus on interaction.",
        " Building websites is a job for developers or site builders, not chatbots.",
        " Correct! Chatbots are designed to simulate human conversation via text or voice.",
        " Diagnosing illnesses is more specific to medical AI, not general chatbots."
      ]
    },
    {
      "question": "🌐 Where are chatbots commonly used?",
      "options": [
        "A) Toy stores",
        "B) Customer service websites",
        "C) Construction sites",
        "D) Gyms"
      ],
      "correct": 1,
      "feedback": [
        " Toy stores rarely use chatbots for practical interaction.",
        " Correct! Chatbots are often found on customer service platforms to assist users.",
        " Construction sites typically don’t rely on chatbot technology.",
        " Gyms may have apps, but chatbots are not commonly integrated there."
      ]
    },
    {
      "question": "🧠 What technology do advanced chatbots like ChatGPT use?",
      "options": [
        "A) HTML",
        "B) Artificial Intelligence",
        "C) Spreadsheets",
        "D) GPS"
      ],
      "correct": 1,
      "feedback": [
        " HTML is for structuring webpages, not powering chatbots.",
        " Correct! AI is the core technology used in chatbots like ChatGPT.",
        " Spreadsheets are not related to chatbot intelligence.",
        " GPS provides location data, not conversation capabilities."
      ]
    },
    {
      "question": "📉 What is one challenge chatbots still face today?",
      "options": [
        "A) Using electricity and other natural resources",
        "B) Learning languages instantly",
        "C) Fully understanding complex human emotions",
        "D) Receiving and printing documents"
      ],
      "correct": 2,
      "feedback": [
        " Power usage is not a main limitation of chatbot intelligence.",
        " Language learning takes time and context; it's not instant.",
        " Correct! Chatbots still struggle with deep emotional understanding.",
        " Chatbots do not handle physical documents."
      ]
    },
    {
      "question": "⏰ What is one benefit of using chatbots?",
      "options": [
        "A) They can work 24/7",
        "B) They give legal advice",
        "C) They fix broken machines",
        "D) They replace all employees"
      ],
      "correct": 0,
      "feedback": [
        " Correct! Chatbots are available anytime, improving support availability.",
        " Chatbots do not provide licensed legal advice.",
        " Fixing machines requires physical interaction, not possible for chatbots.",
        " Chatbots support workers but do not replace all employees."
      ]
    }
  ];
  void handleOptionTap(int index) {
    setState(() {
      selectedOption = index;
      showFeedback = true;
    });
  }

  void tryAgain() {
    setState(() {
      showFeedback = false;
      selectedOption = null;
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestion < questions.length - 1) {
        currentQuestion++;
        selectedOption = null;
        showFeedback = false;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const GreenNewsReadingAnimation(
                    title: 'AI Chatbot Deployed to Target\nDrug Resistance',
                    nextPage: BiographyReadingPage(),
                  )),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[currentQuestion];
    final isCorrect = selectedOption == q["correct"];

    return Scaffold(
      body: Stack(
        children: [
          // 🔹 FONDO GENERAL
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/Wallpapers/WallPaperReadingSpots/FONDO GOAL INSTRUCTION 4 Y Bios.webp",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🔹 SUAVIZAR FONDO GENERAL
          Container(
            color: Colors.white.withOpacity(0.35),
          ),

          // 🔹 CARD FULL SCREEN
          SizedBox.expand(
            child: Stack(
              children: [
                // 🔸 MISMO FONDO DENTRO
                                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF81C784), // verde suave
                        Color(0xFF4DB6AC), // teal elegante
                      ],
                    ),
                  ),
                ),

// 🔹 SUAVIZAR FONDO GENERAL
                Container(
                  color: Colors.white.withOpacity(0.10),
                ),

                // 🔸 CONTENIDO
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question ${currentQuestion + 1} of ${questions.length}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          q["question"],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ...List.generate(q["options"].length, (i) {
                          final isSelected = selectedOption == i;
                          final isRight = i == q["correct"];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: ElevatedButton(
                              onPressed: showFeedback
                                  ? null
                                  : () => handleOptionTap(i),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isSelected
                                    ? (showFeedback
                                        ? (isRight
                                            ? const Color.fromARGB(
                                                255, 21, 147, 23)
                                            : Colors.red)
                                        : Colors.grey.shade300)
                                    : Colors.white,
                                foregroundColor: Colors.black,
                                minimumSize: const Size.fromHeight(52),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 2,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  q["options"][i],
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 24),
                        if (showFeedback && selectedOption != null)
                           Center(
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 8),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: isCorrect
                                    ? Colors.green.shade50
                                    : Colors.red.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isCorrect
                                      ? const Color.fromARGB(255, 77, 218, 82)
                                      : Colors.red.shade300,
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                q["feedback"][selectedOption!],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isCorrect
                                      ? const Color.fromARGB(255, 2, 135, 9)
                                      : Colors.red.shade700,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        const Spacer(),
                        if (showFeedback && isCorrect)
                          Center(
                            child: ElevatedButton(
                              onPressed: nextQuestion,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 21, 147, 23),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 36,
                                  vertical: 14,
                                ),
                              ),
                              child: Text(
                                currentQuestion == questions.length - 1
                                    ? "Continue"
                                    : "Next",
                              ),
                            ),
                          ),
                        if (showFeedback && !isCorrect)
                          Center(
                            child: ElevatedButton(
                              onPressed: tryAgain,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 36,
                                  vertical: 14,
                                ),
                              ),
                              child: const Text("Try Again"),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GreenNewsReadingAnimation extends StatefulWidget {
  const GreenNewsReadingAnimation({
    super.key,
    required this.title,
    required this.nextPage,
  });

  final String title;
  final Widget nextPage;

  @override
  State<GreenNewsReadingAnimation> createState() =>
      _GreenNewsReadingAnimationState();
}

class _GreenNewsReadingAnimationState extends State<GreenNewsReadingAnimation>
    with TickerProviderStateMixin {
  // ── Controladores ────────────────────────────────────────────────
  late final AnimationController _masterCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _floatCtrl;

  // ── Animations ───────────────────────────────────────────────────
  late final Animation<double> _bgFade;
  late final Animation<double> _paperUnfold;
  late final Animation<double> _paperScale;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _exitFade;
  late final Animation<double> _glow;
  late final Animation<double> _floatY;
  late final Animation<double> _floatRot;

  // ── Paleta ───────────────────────────────────────────────────────
  static const _bg1 = Color(0xFF010F0A);
  static const _bg2 = Color(0xFF012010);
  static const _bg3 = Color(0xFF023A20);
  static const _accent = Color(0xFF34D399);
  static const _accent2 = Color(0xFF6EE7B7);

  static const _paper = Color(0xFFF4EFE4);
  // ignore: unused_field
  static const _paperBdr = Color(0xFFC5B899);
  static const _mastBg = Color(0xFF0A2E1A);
  static const _mastBg2 = Color(0xFF0D3620);
  static const _ink = Color(0xFF1A1208);

  @override
  void initState() {
    super.initState();

    _masterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3400),
    );

    _bgFade = CurvedAnimation(
      parent: _masterCtrl,
      curve: const Interval(0.0, 0.12, curve: Curves.easeIn),
    );

    _paperScale = Tween<double>(begin: 0.60, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.05, 0.30, curve: Curves.elasticOut),
      ),
    );

    _paperUnfold = Tween<double>(begin: -0.12, end: 0.0).animate(
      CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.05, 0.35, curve: Curves.easeOutCubic),
      ),
    );

    _titleFade = CurvedAnimation(
      parent: _masterCtrl,
      curve: const Interval(0.38, 0.60, curve: Curves.easeOut),
    );

    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _masterCtrl,
      curve: const Interval(0.38, 0.62, curve: Curves.easeOut),
    ));

    _exitFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.82, 1.0, curve: Curves.easeIn),
      ),
    );

    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
    _glow = Tween<double>(begin: 6, end: 22).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );

    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);
    _floatY = Tween<double>(begin: -5.0, end: 5.0).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );
    _floatRot = Tween<double>(begin: -0.018, end: 0.018).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await _masterCtrl.forward();
      if (!mounted) return;
      _goNext();
    });
  }

  void _goNext() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 750),
        pageBuilder: (_, __, ___) => widget.nextPage,
        transitionsBuilder: (_, anim, __, child) {
          final slide = Tween<Offset>(
            begin: const Offset(0.08, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic));
          return SlideTransition(
            position: slide,
            child: FadeTransition(
              opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _masterCtrl.dispose();
    _glowCtrl.dispose();
    _floatCtrl.dispose();
    super.dispose();
  }

  // ── BUILD ────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([_masterCtrl, _glowCtrl, _floatCtrl]),
        builder: (_, __) {
          return FadeTransition(
            opacity: _exitFade,
            child: Stack(
              fit: StackFit.expand,
              children: [
                _buildBackground(),
                _buildParticles(),
                SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildNewspaper(),
                        const SizedBox(height: 32),
                        _buildTitle(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ── FONDO ────────────────────────────────────────────────────────
  Widget _buildBackground() {
    return FadeTransition(
      opacity: _bgFade,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [_bg1, _bg2, _bg3],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0, -0.3),
              radius: 0.8,
              colors: [_accent.withOpacity(0.08), Colors.transparent],
            ),
          ),
        ),
      ),
    );
  }

  // ── PARTÍCULAS ───────────────────────────────────────────────────
  Widget _buildParticles() {
    const pts = [
      (0.09, 0.13, 3.0, 0.0),
      (0.83, 0.19, 4.0, 0.5),
      (0.19, 0.73, 3.0, 0.9),
      (0.78, 0.66, 5.0, 0.2),
      (0.52, 0.07, 3.0, 0.7),
      (0.05, 0.53, 3.0, 1.1),
      (0.91, 0.47, 3.0, 0.3),
    ];
    return FadeTransition(
      opacity: _titleFade,
      child: LayoutBuilder(
        builder: (_, c) => Stack(
          children: pts.map((p) {
            final dy =
                math.sin(_floatCtrl.value * math.pi * 2 + p.$4 * math.pi) * 9;
            return Positioned(
              left: p.$1 * c.maxWidth,
              top: p.$2 * c.maxHeight + dy,
              child: Container(
                width: p.$3,
                height: p.$3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _accent2.withOpacity(0.45),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ── PERIÓDICO ────────────────────────────────────────────────────
  Widget _buildNewspaper() {
    return Transform.translate(
      offset: Offset(0, _floatY.value),
      child: Transform.rotate(
        angle: _paperUnfold.value + _floatRot.value,
        child: ScaleTransition(
          scale: _paperScale,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: _accent.withOpacity(_glow.value / 50),
                  blurRadius: _glow.value * 2,
                ),
                const BoxShadow(
                  color: Color(0x66000000),
                  blurRadius: 8,
                  offset: Offset(5, 5),
                ),
                const BoxShadow(
                  color: Color(0x22000000),
                  blurRadius: 4,
                  offset: Offset(10, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: SizedBox(
                width: 230,
                child: _buildPaperContent(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaperContent() {
    return Stack(
      children: [
        Container(color: _paper),
        // Línea de doblez
        Positioned.fill(
          child: Row(
            children: [
              const Spacer(),
              Container(
                width: 1,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color(0x1A000000),
                      Color(0x22000000),
                      Color(0x1A000000),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildMasthead(),
            _buildMetaBar(),
            _buildBody(),
            _buildFooter(),
          ],
        ),
      ],
    );
  }

  Widget _buildMasthead() {
    return Container(
      color: _mastBg,
      padding: const EdgeInsets.fromLTRB(12, 9, 12, 8),
      child: Column(
        children: [
          Text(
            'THE GREEN POST',
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: _accent,
              letterSpacing: 3.5,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Sustainable news for a better world',
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 7.5,
              color: _accent2.withOpacity(0.55),
              letterSpacing: 1.5,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 7),
            height: 2,
            color: _accent,
          ),
        ],
      ),
    );
  }

  Widget _buildMetaBar() {
    return Container(
      color: _mastBg2,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _metaText('Vol. XLVII · No. 312'),
          _metaText('★ Est. 1977 ★'),
          _metaText('Free Edition'),
        ],
      ),
    );
  }

  Widget _metaText(String t) => Text(
        t,
        style: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 7,
          color: _accent2.withOpacity(0.45),
        ),
      );

  Widget _buildBody() {
    return Container(
      color: _paper,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPhoto(),
          const SizedBox(height: 8),
          Container(height: 1.5, color: _ink.withOpacity(0.18)),
          const SizedBox(height: 7),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _buildColumn()),
                Container(width: 1, color: _ink.withOpacity(0.10)),
                Expanded(child: _buildColumn(alt: true)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoto() {
    return SizedBox(
      height: 72,
      child: CustomPaint(painter: _NewspaperPhotoPainter()),
    );
  }

  Widget _buildColumn({bool alt = false}) {
    return Padding(
      padding: EdgeInsets.only(
        left: alt ? 7 : 0,
        right: alt ? 0 : 7,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _inkLine(h: 8, w: 1.0, opacity: 0.38),
          const SizedBox(height: 4),
          _inkLine(h: 8, w: 0.75, opacity: 0.32),
          const SizedBox(height: 6),
          Container(height: 1, color: _ink.withOpacity(0.12)),
          const SizedBox(height: 6),
          _inkLine(h: 4.5, w: 1.0),
          const SizedBox(height: 4),
          _inkLine(h: 4.5, w: 0.88),
          const SizedBox(height: 4),
          _inkLine(h: 4.5, w: 1.0),
          const SizedBox(height: 4),
          _inkLine(h: 4.5, w: alt ? 0.70 : 0.80),
          const SizedBox(height: 4),
          _inkLine(h: 4.5, w: 1.0),
          const SizedBox(height: 4),
          _inkLine(h: 4.5, w: alt ? 0.92 : 0.65),
        ],
      ),
    );
  }

  Widget _inkLine({
    required double h,
    required double w,
    double opacity = 0.18,
  }) {
    return FractionallySizedBox(
      widthFactor: w,
      child: Container(
        height: h,
        decoration: BoxDecoration(
          color: _ink.withOpacity(opacity),
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: _mastBg,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _metaText('greenpost.eco'),
          Row(
            children: [
              Icon(Icons.eco, color: _accent.withOpacity(0.6), size: 9),
              const SizedBox(width: 3),
              _metaText('Recycled paper'),
            ],
          ),
          _metaText('Page 1 of 8'),
        ],
      ),
    );
  }

  // ── TÍTULO ───────────────────────────────────────────────────────
  Widget _buildTitle() {
    return FadeTransition(
      opacity: _titleFade,
      child: SlideTransition(
        position: _titleSlide,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Cinzel',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFF0FDF4),
              height: 1.35,
              shadows: [
                Shadow(
                  color: _accent.withOpacity(0.65),
                  blurRadius: _glow.value * 0.9,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
//  CustomPainter: escena genérica para la foto del periódico
// ══════════════════════════════════════════════════════════════════
class _NewspaperPhotoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final p = Paint()..isAntiAlias = true;

    // Cielo
    p.color = const Color(0xFF0F3D22);
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h * 0.58), p);

    // Suelo
    p.color = const Color(0xFF1A5C35);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.58, w, h * 0.42), p);

    // Hierba
    p.color = const Color(0xFF22803A).withOpacity(0.5);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.58, w, h * 0.07), p);

    // Sol
    p.color = const Color(0xFF34D399).withOpacity(0.4);
    canvas.drawCircle(Offset(w * 0.82, h * 0.20), 10, p);
    p.color = const Color(0xFF6EE7B7).withOpacity(0.55);
    canvas.drawCircle(Offset(w * 0.82, h * 0.20), 5.5, p);

    // Nubes
    p.color = const Color(0xFF34D399).withOpacity(0.10);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.22, h * 0.15), width: 36, height: 11),
        p);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.50, h * 0.10), width: 26, height: 9),
        p);

    // Montañas
    void mountain(double x1, double px, double x2, Color c) {
      final path = Path()
        ..moveTo(x1, h * 0.58)
        ..lineTo(px, h * 0.12)
        ..lineTo(x2, h * 0.58)
        ..close();
      p.color = c;
      canvas.drawPath(path, p);
    }

    mountain(0, w * 0.13, w * 0.26, const Color(0xFF155534));
    mountain(w * 0.18, w * 0.35, w * 0.52, const Color(0xFF1A6640));
    mountain(w * 0.44, w * 0.60, w * 0.76, const Color(0xFF155534));
    mountain(w * 0.66, w * 0.80, w * 0.95, const Color(0xFF1A6640));

    // Casas
    void house(
        double bx, double by, double hw, double hh, Color wall, Color roof) {
      p.color = wall;
      canvas.drawRect(Rect.fromLTWH(bx, by - hh, hw, hh), p);
      p.color = const Color(0xFF0A2E1A).withOpacity(0.35);
      canvas.drawRect(
          Rect.fromLTWH(bx + hw * 0.3, by - hh * 0.55, hw * 0.25, hh * 0.55),
          p);
      final r = Path()
        ..moveTo(bx - 1, by - hh)
        ..lineTo(bx + hw / 2, by - hh - hh * 0.55)
        ..lineTo(bx + hw + 1, by - hh)
        ..close();
      p.color = roof;
      canvas.drawPath(r, p);
    }

    house(w * 0.06, h * 0.58, 15, 10, const Color(0xFFE8D9B0),
        const Color(0xFFC8A060));
    house(w * 0.28, h * 0.58, 17, 11, const Color(0xFFEADED8),
        const Color(0xFF34D399));
    house(w * 0.54, h * 0.58, 13, 9, const Color(0xFFE0D4B8),
        const Color(0xFFC8A060));

    // Árboles
    void tree(double tx, double radius) {
      p.color = const Color(0xFF3D2A10);
      canvas.drawRect(
          Rect.fromLTWH(tx - 1.5, h * 0.58 - radius * 1.6, 3, radius * 1.6), p);
      p.color = const Color(0xFF22803A).withOpacity(0.9);
      canvas.drawCircle(Offset(tx, h * 0.58 - radius * 1.6), radius, p);
    }

    tree(w * 0.46, 5.5);
    tree(w * 0.74, 4.5);

    // Borde
    p
      ..color = const Color(0xFF34D399).withOpacity(0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class BiographyReadingPage extends StatefulWidget {
  const BiographyReadingPage({super.key});

  @override
  State<BiographyReadingPage> createState() => _BiographyReadingPageState();
}

class _BiographyReadingPageState extends State<BiographyReadingPage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  bool showButton = false;
  bool animating = false;

  int _lastQuestionIndex = 0;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final String biographyText = '''
[NAIROBI] Scientists have developed an AI chatbot similar to ChatGPT to help governments devise effective policies for battling drug resistance.

Antimicrobial Resistance (AMR), where disease-causing bacteria and viruses no longer respond to the medicines designed to treat them, contributes to millions of deaths a year and results in healthcare costs of up to US\$412 billion a year, according to the World Health Organization (WHO).

In low- and middle-income countries, poor sanitation, limited access to quality medicines, and inappropriate antibiotic use are fueling the rise in AMR, while serious conditions such as HIV, tuberculosis, and malaria are becoming more difficult to treat.

In 2015, the WHO came up with a Global Action Plan to tackle AMR under the One Health model, which recognizes the interconnection between people, animals, plants, and their shared environment.

But “major gaps exist between aspirations and actions” when it comes to developing the necessary policies in low-to-middle-income countries, according to a study published in the journal Environmental Science and Technology.

''';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkScrollEnd);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
  }

  void _checkScrollEnd() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    const threshold = 20.0;

    if (currentScroll >= maxScroll - threshold && !showButton) {
      setState(() => showButton = true);
    } else if (currentScroll < maxScroll - threshold && showButton) {
      setState(() => showButton = false);
    }
  }

  void _goToQuestions() async {
    setState(() => animating = true);
    _fadeController.forward();

    await Future.delayed(const Duration(seconds: 1));

    final result = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (_) => QuestionPage(
          questions: sampleQuestions,
          startIndex: _lastQuestionIndex,
        ),
      ),
    );

    if (result != null) {
      _lastQuestionIndex = result;
    }

    _fadeController.reset();
    setState(() => animating = false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  biographyText,
                  style: const TextStyle(fontSize: 18, height: 1.6),
                ),
                const SizedBox(height: 32),
                AnimatedOpacity(
                  opacity: showButton ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: Column(
                    children: [
                      Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 21, 147, 23),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: _goToQuestions,
                          icon: const Icon(Icons.arrow_forward,
                              color: Colors.black),
                          label: const Text(
                            "Go to Questions",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (animating)
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                color: Colors.white.withOpacity(0.5),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                          color: Color.fromARGB(255, 21, 147, 23)),
                      SizedBox(height: 16),
                      Text(
                        "Going to Questions...",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 21, 147, 23),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Preguntas de ejemplo
final List<QuestionData> sampleQuestions = [
  QuestionData(
    question: '🤖 Why was the AI chatbot developed?',
    options: [
      "A) To replace doctors",
      "B) To teach people about hygiene",
      "C) To help governments create better AMR policies",
      "D) To reduce healthcare costs in rich countries"
    ],
    correctIndex: 2,
    explanation:
        ' The chatbot was designed to assist governments in making better policies to fight antimicrobial resistance (AMR).',
    incorrectExplanations: [
      ' Replacing doctors is not the aim of this AI chatbot.',
      ' While hygiene is important, the chatbot is focused on policy-making, not education.',
      ' Correct answer! It helps governments improve AMR-related decisions.',
      ' Reducing healthcare costs in rich countries is not the chatbot’s goal.'
    ],
  ),
  QuestionData(
    question:
        '🌍 What challenge do low- and middle-income countries face with AMR?',
    options: [
      "A) There are gaps between goals and real action",
      "B) They use only traditional medicine",
      "C) They lack antibiotics entirely",
      "D) Their governments don’t recognize AMR"
    ],
    correctIndex: 0,
    explanation:
        ' The study found that these countries often have strong goals, but struggle to implement them effectively against antimicrobial resistance.',
    incorrectExplanations: [
      ' Correct answer! Many policies exist, but are not fully acted upon.',
      ' Traditional medicine may be used, but that’s not the core issue here.',
      ' They generally have access to antibiotics, though usage may be problematic.',
      ' Governments do recognize AMR, but face challenges in enforcement and resources.'
    ],
  ),
];

// Pantalla de preguntas con animación simple
class QuestionPage extends StatefulWidget {
  final List<QuestionData> questions;
  final int startIndex;

  const QuestionPage({
    super.key,
    required this.questions,
    required this.startIndex,
  });

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late int currentQuestionIndex;
  int? selected;
  bool showFeedback = false;
  bool _isCorrect = false;
  String _feedbackText = '';

  static const Color accentDark = Color(0xFF2E7D32);  // verde oscuro
  static const Color cardBg = Color(0xFFF1F8E9);      // crema verdoso

  @override
  void initState() {
    super.initState();
    currentQuestionIndex = widget.startIndex;
  }

  void _submitAnswer() {
    if (selected == null) return;
    final current = widget.questions[currentQuestionIndex];
    final isCorrect = selected == current.correctIndex;

    String explanationText;
    if (isCorrect) {
      explanationText = current.explanation;
    } else if (current.incorrectExplanations != null &&
        selected! < current.incorrectExplanations!.length) {
      explanationText = current.incorrectExplanations![selected!];
    } else {
      explanationText = 'Incorrect answer.';
    }

    setState(() {
      showFeedback = true;
      _isCorrect = isCorrect;
      _feedbackText = explanationText;
    });
  }

  void _goNext() {
    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selected = null;
        showFeedback = false;
        _isCorrect = false;
        _feedbackText = '';
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => BiographyReadingPageSecond()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF81C784), // verde suave
              Color(0xFF4DB6AC), // teal elegante
            ],
          ),
        ),
        child: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Column(
                  key: ValueKey<int>(currentQuestionIndex),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF66BB6A), // verde medio
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: accentDark.withOpacity(0.18),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Text(
                        question.question,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Option buttons
                    ...List.generate(question.options.length, (i) {
                      final isSelected = selected == i;

                      return GestureDetector(
                        onTap: showFeedback
                            ? () {}
                            : () => setState(() => selected = i),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF66BB6A) // verde medio
                                  : const Color(0xFFE0E0E0),
                              width: 1.8,
                            ),
                          ),
                          child: Text(
                            question.options[i],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 8),

                    // Submit button OR feedback card
                    if (!showFeedback)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // View Text
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context, currentQuestionIndex);
                            },
                            icon: const Icon(Icons.menu_book, color: Colors.white),
                            label: const Text(
                              "View Text",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentDark,
                              elevation: 4,
                              shadowColor: accentDark.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                            ),
                          ),

                          // Submit
                          ElevatedButton(
                            onPressed: selected != null ? _submitAnswer : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF43A047),
                              disabledBackgroundColor:
                                  accentDark.withOpacity(0.35),
                              elevation: 4,
                              shadowColor: accentDark.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 14),
                            ),
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      // Feedback card
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _isCorrect
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _isCorrect
                                ? const Color.fromARGB(255, 77, 218, 82)
                                : Colors.red.shade300,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              _feedbackText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _isCorrect
                                    ? const Color.fromARGB(255, 2, 135, 9)
                                    : Colors.red.shade700,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _goNext,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isCorrect
                                    ? const Color.fromARGB(255, 2, 135, 9)
                                    : Colors.red.shade600,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 11,
                                ),
                              ),
                              child: Text(
                                currentQuestionIndex ==
                                        widget.questions.length - 1
                                    ? "Finish"
                                    : "Next",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BiographyReadingPageSecond extends StatefulWidget {
  const BiographyReadingPageSecond({super.key});

  @override
  State<BiographyReadingPageSecond> createState() =>
      _BiographyReadingPageSecondState();
}

class _BiographyReadingPageSecondState extends State<BiographyReadingPageSecond>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;
  int _lastQuestionIndex = 0;

  late AnimationController _fadeController;

  final String biographyTextSecond = '''

The international team of researchers from the Chinese Academy of Sciences and Durham University, UK, created an AI chatbot designed to bridge these gaps and assist in the preparation of National Action Plans.

The large language model tool called the AMR-Policy GPT, contains information from AMR-related policy documents from 146 countries.

“AMR-Policy GPT is a conversational chatbot,” said David Graham, an environmental engineer at Durham University and lead co-author.

“It allows you to ask questions and provides you with answers related to the questions you ask.”

“Ideally, the tool provides decision-makers with well-researched information from across all disciplines, including animal agriculture, crops, water quality and infectious diseases.”
David Graham, environmental engineer, Durham University

Unlike ChatGPT—which harvests everything from the wider information universe to answer your questions—AMR-Policy GPT filters for quality, selecting technical information relevant to the subject, according to the researchers.
''';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkScrollEnd);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  void _checkScrollEnd() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    const threshold = 20.0;

    if (currentScroll >= maxScroll - threshold && !showButton) {
      setState(() => showButton = true);
    } else if (currentScroll < maxScroll - threshold && showButton) {
      setState(() => showButton = false);
    }
  }

  void _goToQuestions() async {
    setState(() => animating = true);
    _fadeController.forward();

    await Future.delayed(const Duration(seconds: 1));

    final result = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (_) => QuestionPageSecond(
          questions: sampleQuestionsSecond,
          startIndex: _lastQuestionIndex,
        ),
      ),
    );

    if (result != null) {
      _lastQuestionIndex = result;
    }

    _fadeController.reset();
    setState(() => animating = false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🟢 TÍTULO EN NEGRILLA
                const Text(
                  "Smart friend",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    height: 1.8,
                  ),
                ),

                const SizedBox(height: 16),

                /// 📖 TEXTO NORMAL
                Text(
                  biographyTextSecond,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 32),

                AnimatedOpacity(
                  opacity: showButton ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: Column(
                    children: [
                      Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 21, 147, 23),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: _goToQuestions,
                          icon: const Icon(Icons.arrow_forward,
                              color: Colors.black),
                          label: const Text(
                            "Go to Next Questions",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (animating)
            Container(
              color: Colors.white.withOpacity(0.5),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                        color: Color.fromARGB(255, 21, 147, 23)),
                    SizedBox(height: 16),
                    Text(
                      "Going to Questions...",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 21, 147, 23),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class QuestionData {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final List<String>? incorrectExplanations;

  QuestionData({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    this.incorrectExplanations,
  });
}

final List<QuestionData> sampleQuestionsSecond = [
  QuestionData(
    question: '🎯 What is the main purpose of AMR-Policy GPT?',
    options: [
      "A) To give health advice to patients",
      "B) To replace government officials",
      "C) To search random information online",
      "D) To help develop national plans on AMR"
    ],
    correctIndex: 3,
    explanation:
        ' The tool is designed to assist governments in preparing National Action Plans for fighting antimicrobial resistance (AMR).',
    incorrectExplanations: [
      ' Giving patient advice is not its role — that would be a clinical tool.',
      ' It doesn’t replace officials, but supports them.',
      ' Random information is not its focus; it’s built for specific policy support.',
      ' Correct answer! It helps governments create solid national AMR plans.'
    ],
  ),
  QuestionData(
    question: '🤖 How is AMR-Policy GPT different from ChatGPT?',
    options: [
      "A) It uses only handwritten notes",
      "B) It avoids technical subjects",
      "C) It answers questions with jokes",
      "D) It filters for high-quality, relevant info"
    ],
    correctIndex: 3,
    explanation:
        ' Unlike ChatGPT, AMR-Policy GPT selects only technical, subject-specific information for AMR policy-making.',
    incorrectExplanations: [
      ' It doesn’t rely on handwritten notes — it uses trained data.',
      ' On the contrary, it focuses on technical topics.',
      ' It does not provide casual or humorous responses.',
      ' Correct! It’s optimized to deliver only accurate, relevant information for AMR.'
    ],
  ),
];

class QuestionPageSecond extends StatefulWidget {
  final List<QuestionData> questions;
  final int startIndex;

  const QuestionPageSecond({
    super.key,
    required this.questions,
    required this.startIndex,
  });

  @override
  State<QuestionPageSecond> createState() => _QuestionPageSecondState();
}

class _QuestionPageSecondState extends State<QuestionPageSecond> {
  late int currentQuestionIndex;
  int? selected;
  bool showFeedback = false;
  bool _isCorrect = false;
  String _feedbackText = '';

  static const Color accentDark = Color(0xFF2E7D32);  // verde oscuro
  static const Color cardBg = Color(0xFFF1F8E9);      // crema verdoso

  @override
  void initState() {
    super.initState();
    currentQuestionIndex = widget.startIndex;
  }

  void _submitAnswer() {
    if (selected == null) return;
    final current = widget.questions[currentQuestionIndex];
    final isCorrect = selected == current.correctIndex;

    String explanationText;
    if (isCorrect) {
      explanationText = current.explanation;
    } else if (current.incorrectExplanations != null &&
        selected! < current.incorrectExplanations!.length) {
      explanationText = current.incorrectExplanations![selected!];
    } else {
      explanationText = 'Incorrect answer.';
    }

    setState(() {
      showFeedback = true;
      _isCorrect = isCorrect;
      _feedbackText = explanationText;
    });
  }

  void _goNext() {
    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selected = null;
        showFeedback = false;
        _isCorrect = false;
        _feedbackText = '';
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => BiographyReadingPageThird()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF81C784), // verde suave
              Color(0xFF4DB6AC), // teal elegante
            ],
          ),
        ),
        child: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Column(
                  key: ValueKey<int>(currentQuestionIndex),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF66BB6A), // verde medio
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: accentDark.withOpacity(0.18),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Text(
                        question.question,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Option buttons
                    ...List.generate(question.options.length, (i) {
                      final isSelected = selected == i;

                      return GestureDetector(
                        onTap: showFeedback
                            ? () {}
                            : () => setState(() => selected = i),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF66BB6A) // verde medio
                                  : const Color(0xFFE0E0E0),
                              width: 1.8,
                            ),
                          ),
                          child: Text(
                            question.options[i],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 8),

                    // Submit button OR feedback card
                    if (!showFeedback)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // View Text
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context, currentQuestionIndex);
                            },
                            icon: const Icon(Icons.menu_book, color: Colors.white),
                            label: const Text(
                              "View Text",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentDark,
                              elevation: 4,
                              shadowColor: accentDark.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                            ),
                          ),

                          // Submit
                          ElevatedButton(
                            onPressed: selected != null ? _submitAnswer : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF43A047),
                              disabledBackgroundColor:
                                  accentDark.withOpacity(0.35),
                              elevation: 4,
                              shadowColor: accentDark.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 14),
                            ),
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      // Feedback card
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _isCorrect
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _isCorrect
                                ? const Color.fromARGB(255, 77, 218, 82)
                                : Colors.red.shade300,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              _feedbackText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _isCorrect
                                    ? const Color.fromARGB(255, 2, 135, 9)
                                    : Colors.red.shade700,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _goNext,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isCorrect
                                    ? const Color.fromARGB(255, 2, 135, 9)
                                    : Colors.red.shade600,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 11,
                                ),
                              ),
                              child: Text(
                                currentQuestionIndex ==
                                        widget.questions.length - 1
                                    ? "Finish"
                                    : "Next",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BiographyReadingPageThird extends StatefulWidget {
  const BiographyReadingPageThird({super.key});

  @override
  State<BiographyReadingPageThird> createState() =>
      _BiographyReadingPageThirdState();
}

class _BiographyReadingPageThirdState extends State<BiographyReadingPageThird>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;
  int _lastQuestionIndex = 0;
  late AnimationController _fadeController;

  final String biographyTextSecond = '''
“It’s like having a smart friend in the room,” Graham told SciDev.Net.

While the tool cannot formulate policy, it draws on national policy plans, gray literature, and other policy guidance from intergovernmental agencies to encourage lawmakers to consider various policy options, says Graham.

“So, if you are in a country, for example, in Sub-Saharan Africa, and you have hardly any information around your own country, you can ask the bot and it looks around at information that’s related to your question and your place,” he explained.

“Ideally, the tool provides decision-makers with well-researched information from across all disciplines, including animal agriculture, crops, water quality and infectious diseases.”

Although it’s designed with policy in mind, the tool can be used by anyone to ask any questions about AMR. “And you don’t have to have advanced knowledge of AI,” added Graham.
''';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkScrollEnd);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  void _checkScrollEnd() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    const threshold = 20.0;

    if (currentScroll >= maxScroll - threshold && !showButton) {
      setState(() => showButton = true);
    } else if (currentScroll < maxScroll - threshold && showButton) {
      setState(() => showButton = false);
    }
  }

  void _goToQuestions() async {
    setState(() => animating = true);
    _fadeController.forward();

    await Future.delayed(const Duration(seconds: 1));

    final result = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (_) => QuestionPageThird(
          questions: sampleQuestionsThird,
          startIndex: _lastQuestionIndex,
        ),
      ),
    );

    if (result != null) {
      _lastQuestionIndex = result;
    }

    _fadeController.reset();
    setState(() => animating = false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  biographyTextSecond,
                  style: const TextStyle(fontSize: 18, height: 1.6),
                ),
                const SizedBox(height: 32),
                AnimatedOpacity(
                  opacity: showButton ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: Column(
                    children: [
                      Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 21, 147, 23),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: _goToQuestions,
                          icon: const Icon(Icons.arrow_forward,
                              color: Colors.black),
                          label: const Text("Go to Next Questions",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (animating)
            Container(
              color: Colors.white.withOpacity(0.5),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                        color: Color.fromARGB(255, 21, 147, 23)),
                    SizedBox(height: 16),
                    Text(
                      "Going to Questions...",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 21, 147, 23),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

final List<QuestionData> sampleQuestionsThird = [
  QuestionData(
    question:
        '🌍 What is one benefit of using AMR-Policy GPT in countries with limited local data?',
    options: [
      "A) It creates new medicines",
      "B) It offers local weather forecasts",
      "C) It writes legal documents",
      "D) It gathers relevant info from other countries"
    ],
    correctIndex: 3,
    explanation:
        ' The tool can pull relevant data from other regions to support countries lacking their own detailed AMR information.',
    incorrectExplanations: [
      ' It doesn’t create medicines — it informs policies.',
      ' Weather forecasting is unrelated to AMR policy.',
      ' Writing legal documents isn’t its function.',
      ' Correct! It gathers info from other countries to fill data gaps.'
    ],
  ),
  QuestionData(
    question: '🧠 Who can use the AMR-Policy GPT tool?',
    options: [
      "A) Only AI researchers",
      "B) Only doctors and nurses",
      "C) Anyone interested in AMR",
      "D) Only government officials"
    ],
    correctIndex: 2,
    explanation:
        ' The tool is user-friendly and open to anyone curious about antimicrobial resistance, regardless of expertise.',
    incorrectExplanations: [
      ' It’s not restricted to AI experts.',
      ' Medical professionals are not the only audience.',
      ' Correct! It’s made for anyone, including the general public.',
      ' It’s not limited to government use.'
    ],
  ),
];

class QuestionPageThird extends StatefulWidget {
  final List<QuestionData> questions;
  final int startIndex;

  const QuestionPageThird({
    super.key,
    required this.questions,
    this.startIndex = 0,
  });

  @override
  State<QuestionPageThird> createState() => _QuestionPageThirdState();
}

class _QuestionPageThirdState extends State<QuestionPageThird> {
  late int currentQuestionIndex;
  int? selected;
  bool showFeedback = false;
  bool _isCorrect = false;
  String _feedbackText = '';

  static const Color accentDark = Color(0xFF2E7D32);  // verde oscuro
  static const Color cardBg = Color(0xFFF1F8E9);      // crema verdoso

  @override
  void initState() {
    super.initState();
    currentQuestionIndex = widget.startIndex;
  }

  void _submitAnswer() {
    if (selected == null) return;
    final current = widget.questions[currentQuestionIndex];
    final isCorrect = selected == current.correctIndex;

    String explanationText;
    if (isCorrect) {
      explanationText = current.explanation;
    } else if (current.incorrectExplanations != null &&
        selected! < current.incorrectExplanations!.length) {
      explanationText = current.incorrectExplanations![selected!];
    } else {
      explanationText = 'Incorrect answer.';
    }

    setState(() {
      showFeedback = true;
      _isCorrect = isCorrect;
      _feedbackText = explanationText;
    });
  }

  void _goNext() {
    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selected = null;
        showFeedback = false;
        _isCorrect = false;
        _feedbackText = '';
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => Final_Path()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF81C784), // verde suave
              Color(0xFF4DB6AC), // teal elegante
            ],
          ),
        ),
        child: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Column(
                  key: ValueKey<int>(currentQuestionIndex),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF66BB6A), // verde medio
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: accentDark.withOpacity(0.18),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Text(
                        question.question,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Option buttons
                    ...List.generate(question.options.length, (i) {
                      final isSelected = selected == i;

                      return GestureDetector(
                        onTap: showFeedback
                            ? () {}
                            : () => setState(() => selected = i),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF66BB6A) // verde medio
                                  : const Color(0xFFE0E0E0),
                              width: 1.8,
                            ),
                          ),
                          child: Text(
                            question.options[i],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 8),

                    // Submit button OR feedback card
                    if (!showFeedback)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // View Text
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context, currentQuestionIndex);
                            },
                            icon: const Icon(Icons.menu_book, color: Colors.white),
                            label: const Text(
                              "View Text",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentDark,
                              elevation: 4,
                              shadowColor: accentDark.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                            ),
                          ),

                          // Submit
                          ElevatedButton(
                            onPressed: selected != null ? _submitAnswer : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF43A047),
                              disabledBackgroundColor:
                                  accentDark.withOpacity(0.35),
                              elevation: 4,
                              shadowColor: accentDark.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 14),
                            ),
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      // Feedback card
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _isCorrect
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _isCorrect
                                ? const Color.fromARGB(255, 77, 218, 82)
                                : Colors.red.shade300,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              _feedbackText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _isCorrect
                                    ? const Color.fromARGB(255, 2, 135, 9)
                                    : Colors.red.shade700,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _goNext,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isCorrect
                                    ? const Color.fromARGB(255, 2, 135, 9)
                                    : Colors.red.shade600,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 11,
                                ),
                              ),
                              child: Text(
                                currentQuestionIndex ==
                                        widget.questions.length - 1
                                    ? "Finish"
                                    : "Next",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
