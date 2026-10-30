import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/orange/Content/Spot2/Spot_Page/Reading_Spot_Page.dart';
import 'dart:math';
import 'dart:math' as math;

class WarAnimationOne extends StatefulWidget {
  const WarAnimationOne({super.key});

  @override
  State<WarAnimationOne> createState() => _WarAnimationOneState();
}

class _WarAnimationOneState extends State<WarAnimationOne>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _floatController;
  late AnimationController _bgController;
  late AnimationController _pulseController;
  late AnimationController _flameController;

  late Animation<double> _fadeIn;
  late Animation<double> _scaleUp;
  late Animation<double> _titleSlide;
  late Animation<double> _authorFade;
  late Animation<double> _dividerWidth;
  late Animation<double> _iconPulse;
  late Animation<double> _glowPulse;
  late Animation<double> _warmGlow;
  late Animation<double> _flameScaleY;
  late Animation<double> _flameScaleX;
  late Animation<double> _flameTranslateY;

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
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat(reverse: true);

    _flameController = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    )..repeat(reverse: true);

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

    _glowPulse = Tween<double>(begin: 0.12, end: 0.42).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _warmGlow = Tween<double>(begin: 0.2, end: 0.45).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _flameScaleY = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.08), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.08, end: 0.97), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.97, end: 1.10), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.10, end: 0.98), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.98, end: 1.0), weight: 20),
    ]).animate(_flameController);

    _flameScaleX = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.96), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.96, end: 1.04), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.04, end: 0.94), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.94, end: 1.02), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.02, end: 1.0), weight: 20),
    ]).animate(_flameController);

    _flameTranslateY = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -2.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: -2.0, end: 1.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: -3.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: -3.0, end: 1.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 20),
    ]).animate(_flameController);

    _mainController.forward();

    Future.delayed(const Duration(milliseconds: 4500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const News_Recovery(),
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
    _flameController.dispose();
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
                      // Icono flotante — llama orgánica
                      AnimatedBuilder(
                        animation: Listenable.merge([
                          _floatController,
                          _pulseController,
                          _flameController,
                        ]),
                        builder: (_, __) => Transform.translate(
                          offset: Offset(0, -9 * _floatController.value + 4.5),
                          child: SizedBox(
                            width: 120,
                            height: 120,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Warm glow anaranjado
                                Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        const Color(0xFFFFB43C)
                                            .withOpacity(_warmGlow.value),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),

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

                                // Círculo principal
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
                                    child: Center(
                                      child: Transform(
                                        alignment: Alignment.bottomCenter,
                                        transform: Matrix4.identity()
                                          ..scale(
                                            _flameScaleX.value,
                                            _flameScaleY.value,
                                          )
                                          ..translate(
                                            0.0,
                                            _flameTranslateY.value,
                                          ),
                                        child: CustomPaint(
                                          size: const Size(52, 58),
                                          painter: _FlameIconPainter(),
                                        ),
                                      ),
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
                          "Syrians Turn War Missiles\ninto Heaters as Winter Grips",
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
                          "By Sonia el-Ali, 2022",
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

// ── Icono llama orgánica ──────────────────────────────────────────────────

class _FlameIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Llama exterior — forma orgánica fluida
    final outerPaint = Paint()
      ..color = Colors.white.withOpacity(0.92)
      ..style = PaintingStyle.fill;

    final outerFlame = Path()
      ..moveTo(w * 0.5, h)
      ..cubicTo(w * 0.18, h, w * 0.02, h * 0.82, w * 0.05, h * 0.66)
      ..cubicTo(w * 0.07, h * 0.54, w * 0.05, h * 0.46, w * 0.14, h * 0.36)
      ..cubicTo(w * 0.14, h * 0.5, w * 0.22, h * 0.53, w * 0.23, h * 0.44)
      ..cubicTo(w * 0.25, h * 0.33, w * 0.30, h * 0.23, w * 0.31, h * 0.12)
      ..cubicTo(w * 0.37, h * 0.23, w * 0.43, h * 0.28, w * 0.41, h * 0.38)
      ..cubicTo(w * 0.39, h * 0.46, w * 0.46, h * 0.49, w * 0.47, h * 0.39)
      ..cubicTo(w * 0.51, h * 0.24, w * 0.46, h * 0.16, w * 0.49, h * 0.07)
      ..cubicTo(w * 0.57, h * 0.18, w * 0.63, h * 0.28, w * 0.59, h * 0.43)
      ..cubicTo(w * 0.57, h * 0.52, w * 0.63, h * 0.53, w * 0.65, h * 0.44)
      ..cubicTo(w * 0.69, h * 0.53, w * 0.68, h * 0.66, w * 0.65, h * 0.73)
      ..cubicTo(w * 0.61, h * 0.84, w * 0.72, h * 0.86, w * 0.75, h * 0.77)
      ..cubicTo(w * 0.80, h * 0.88, w * 0.78, h * 0.96, w * 0.72, h * 1.0)
      ..cubicTo(w * 0.64, h, w * 0.55, h, w * 0.5, h)
      ..close();

    canvas.drawPath(outerFlame, outerPaint);

    // Llama interior — detalle más claro
    final innerPaint = Paint()
      ..color = Colors.white.withOpacity(0.45)
      ..style = PaintingStyle.fill;

    final innerFlame = Path()
      ..moveTo(w * 0.5, h * 0.88)
      ..cubicTo(w * 0.32, h * 0.88, w * 0.22, h * 0.76, w * 0.24, h * 0.65)
      ..cubicTo(w * 0.26, h * 0.56, w * 0.24, h * 0.50, w * 0.31, h * 0.43)
      ..cubicTo(w * 0.31, h * 0.54, w * 0.36, h * 0.56, w * 0.37, h * 0.49)
      ..cubicTo(w * 0.38, h * 0.41, w * 0.42, h * 0.33, w * 0.43, h * 0.24)
      ..cubicTo(w * 0.47, h * 0.33, w * 0.51, h * 0.39, w * 0.49, h * 0.47)
      ..cubicTo(w * 0.48, h * 0.53, w * 0.54, h * 0.55, w * 0.55, h * 0.47)
      ..cubicTo(w * 0.58, h * 0.54, w * 0.57, h * 0.64, w * 0.54, h * 0.70)
      ..cubicTo(w * 0.51, h * 0.78, w * 0.57, h * 0.79, w * 0.59, h * 0.74)
      ..cubicTo(w * 0.62, h * 0.81, w * 0.60, h * 0.87, w * 0.55, h * 0.88)
      ..cubicTo(w * 0.53, h * 0.88, w * 0.51, h * 0.88, w * 0.5, h * 0.88)
      ..close();

    canvas.drawPath(innerFlame, innerPaint);
  }

  @override
  bool shouldRepaint(_FlameIconPainter old) => false;
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
    final rng = Random(22);

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

    // Cuadrícula
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
          _drawFlame(canvas, opacity, p.$4 * 5 + 12);
          break;
        case 1:
          _drawSnowflake(canvas, opacity, p.$4 * 4 + 9);
          break;
        case 2:
          _drawRadiator(canvas, opacity, p.$4 * 5 + 13);
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

  void _drawFlame(Canvas canvas, double opacity, double sz) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.fill;

    final h = sz * 2.2;
    final path = Path()
      ..moveTo(0, h * 0.5)
      ..cubicTo(-sz * 0.45, h * 0.5, -sz * 0.55, h * 0.25, -sz * 0.45, 0)
      ..cubicTo(
          -sz * 0.45, h * 0.15, -sz * 0.25, h * 0.18, -sz * 0.22, h * 0.08)
      ..cubicTo(-sz * 0.15, h * 0.18, -sz * 0.08, h * 0.14, -sz * 0.1, 0)
      ..cubicTo(-sz * 0.02, h * 0.12, sz * 0.02, h * 0.12, sz * 0.1, 0)
      ..cubicTo(sz * 0.08, h * 0.14, sz * 0.15, h * 0.18, sz * 0.22, h * 0.08)
      ..cubicTo(sz * 0.25, h * 0.18, sz * 0.45, h * 0.15, sz * 0.45, 0)
      ..cubicTo(sz * 0.55, h * 0.25, sz * 0.45, h * 0.5, 0, h * 0.5)
      ..close();
    canvas.drawPath(path, paint);
  }

  void _drawSnowflake(Canvas canvas, double opacity, double sz) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..strokeWidth = 1.1
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 4; i++) {
      final angle = i * pi / 4;
      canvas.drawLine(
        Offset(-sz * cos(angle), -sz * sin(angle)),
        Offset(sz * cos(angle), sz * sin(angle)),
        paint,
      );
    }
    // Endpoint dots
    for (int i = 0; i < 8; i++) {
      final angle = i * pi / 4;
      canvas.drawCircle(
        Offset(sz * cos(angle), sz * sin(angle)),
        sz * 0.12,
        Paint()
          ..color = Colors.white.withOpacity(opacity)
          ..style = PaintingStyle.fill,
      );
    }
  }

  void _drawRadiator(Canvas canvas, double opacity, double sz) {
    final fillPaint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = Colors.white.withOpacity(opacity * 1.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(opacity * 0.7)
      ..strokeWidth = 0.7
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset.zero, width: sz * 1.8, height: sz * 1.2),
        Radius.circular(sz * 0.15),
      ),
      fillPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset.zero, width: sz * 1.8, height: sz * 1.2),
        Radius.circular(sz * 0.15),
      ),
      strokePaint,
    );

    // Vertical divider lines
    for (final x in [-sz * 0.4, 0.0, sz * 0.4]) {
      canvas.drawLine(
        Offset(x, -sz * 0.5),
        Offset(x, sz * 0.5),
        linePaint,
      );
    }
    // Horizontal center line
    canvas.drawLine(
      Offset(-sz * 0.8, 0),
      Offset(sz * 0.8, 0),
      linePaint,
    );
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

class News_Recovery extends StatefulWidget {
  const News_Recovery({super.key});

  @override
  State<News_Recovery> createState() => _News_RecoveryState();
}

class _News_RecoveryState extends State<News_Recovery> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is the capital city of Syria?",
      "options": ["A) Aleppo", "B) Damascus", "C) Homs", "D) Palmyra"],
      "correct": 1,
      "feedback": [
        " Incorrect. Aleppo is an important city but not the capital of Syria.",
        "🎯 Correct! Damascus is the capital of Syria and is one of the oldest continuously inhabited cities in the world.",
        " Incorrect. Homs is another city in Syria, not the capital.",
        " Incorrect. Palmyra is an ancient historical site, not the capital."
      ]
    },
    {
      "question": "Syria is located in which region of the world?",
      "options": [
        "A) East Asia",
        "B) South America",
        "C) The Middle East",
        "D) North Africa"
      ],
      "correct": 2,
      "feedback": [
        " Incorrect. East Asia includes countries like China and Japan.",
        " Incorrect. South America is a different continent.",
        "🎯 Correct! Syria is located in Western Asia, in the Middle East region, bordered by Turkey, Iraq, and Jordan.",
        " Incorrect. North Africa includes countries like Egypt and Libya."
      ]
    },
    {
      "question":
          "What type of climate is most characteristic of the vast majority of Syria’s land?",
      "options": [
        "A) Mediterranean",
        "B) Continental",
        "C) Tropical",
        "D) Arid and semi-arid"
      ],
      "correct": 3,
      "feedback": [
        " Incorrect. The Mediterranean climate occurs only along the coast.",
        " Incorrect. Continental climates are found in more inland northern regions.",
        " Incorrect. Tropical climates are hot and humid, not characteristic of Syria.",
        "🎯 Correct! Most of Syria is covered by desert or semi-desert, with an arid and semi-arid climate."
      ]
    },
    {
      "question":
          "In the inland steppe regions of Syria, when is frost most likely to occur?",
      "options": [
        "A) During the summer",
        "B) In the spring and fall",
        "C) In the winter",
        "D) Never"
      ],
      "correct": 2,
      "feedback": [
        " Incorrect. Summers in Syria are typically hot and dry.",
        " Incorrect. Frosts are more likely in colder seasons.",
        "🎯 Correct! Frosts are common during the cold winters in Syria’s inland regions.",
        " Incorrect. Frost does occur in Syria’s colder areas during winter."
      ]
    },
    {
      "question":
          "What is a significant environmental issue in Syria directly related to its climate?",
      "options": [
        "A) Excessive flooding due to heavy rainfall",
        "B) A sudden shift to a tropical climate",
        "C) Desertification and a high risk of drought",
        "D) Extremely low humidity across all regions"
      ],
      "correct": 2,
      "feedback": [
        " Incorrect. Syria does not experience excessive rainfall or flooding regularly.",
        " Incorrect. Syria’s climate has not shifted to a tropical type.",
        "🎯 Correct! Due to low rainfall and long drying trends, Syria faces drought and desertification issues.",
        " Incorrect. While some regions are dry, this is not the main environmental issue."
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
                  title:
                      "Syrians Turn War Missiles\ninto Heaters as Winter Grips",
                  nextPage: BiographyReadingPage())),
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
Amid a shortage of humanitarian aid and increased fuel prices, Syrians have discovered a cheap way to get warm in the harsh winter — by recycling missiles.

Humanitarian aid covers only 45 percent of the population’s needs and poverty rates have reached an unprecedented 90 percent in northwest Syria, according to the Syrian Response Coordination Group, leaving many people to resort to makeshift heaters, run on toxic fuels.

As’ad al-Obaid, sitting around one of the repurposed weapons with his children in their home city of Jisr al-Shughur, in Idlib province, tells SciDev.Net: “I couldn’t afford a heater, so got a missile I found nearby, gave it to the blacksmith and got this heater”.

During the country’s decade-long conflict, getting warm has become a luxury that al-Obaid’s family and others like them in the northwest Syrian city cannot afford. The alternative here is to rely on whatever is available, including cheap fuel — regardless of the health risks.

This fledgling recycling industry sees blacksmiths hurry out to gather missiles with a radius of between 28 and 32 cm, and take them to their workshops. Or sometimes they even buy the missiles at a low price.

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
    question:
        'Why do blacksmiths specifically look for missiles with a diameter of 28–32 cm?',
    options: [
      "A) That size fits most available fuel types",
      "B) They are lighter to carry",
      "C) They are easier to find in urban areas",
      "D) That size is safer to store indoors"
    ],
    correctIndex: 0,
    explanation:
        " Explanation: The detail about specific measurements suggests these dimensions are practical for converting into usable heaters.",
    incorrectExplanations: [
      " Correct answer!",
      " The weight of the missiles is not the key reason.",
      " Availability in cities is not mentioned as a factor.",
      " Safety in storage is not discussed in the text."
    ],
  ),
  QuestionData(
    question:
        'Who is responsible for transforming the missiles into usable heaters?',
    options: [
      "A) Local shopkeepers",
      "B) Aid workers",
      "C) Blacksmiths",
      "D) Military personnel"
    ],
    correctIndex: 2,
    explanation:
        " Explanation: The text clearly states that blacksmiths gather the missiles and convert them in their workshops.",
    incorrectExplanations: [
      " Shopkeepers do not play a role in converting missiles.",
      " Aid workers are not involved in this process.",
      " Correct answer!",
      " Military personnel are not mentioned as being responsible."
    ],
  ),
  QuestionData(
    question:
        'When did this practice of recycling missiles likely become common?',
    options: [
      "A) Before the conflict began",
      "B) After international sanctions ended",
      "C) During Syria’s decade-long war",
      "D) In the summer months only"
    ],
    correctIndex: 2,
    explanation:
        " Explanation: The need for makeshift heating arose over years of conflict, when poverty and fuel shortages worsened.",
    incorrectExplanations: [
      " It began during the war, not before.",
      " Sanctions did not cause this practice to start.",
      " Correct answer!",
      " The timing is not limited to specific months."
    ],
  ),
  QuestionData(
    question:
        'Where is this missile-recycling practice most prevalent according to the text?',
    options: [
      "A) An agricultural village in the southeast",
      "B) A city in Idlib province in the northwest",
      "C) A desert community near the Iraqi border",
      "D) A coastal port city on the Mediterranean"
    ],
    correctIndex: 1,
    explanation:
        " Explanation: The text mentions Jisr al-Shughur in Idlib province, which is in Syria’s northwest, as the setting for al-Obaid’s story.",
    incorrectExplanations: [
      " The text does not mention a southeastern village.",
      " Correct answer!",
      " The desert near Iraq is not identified as the main area.",
      " The coastal cities are not described as participating in this practice."
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
Ahmed Hussein al-Othman is a blacksmith in Idlib who has ventured into this line of business. He says: “The big increase in iron prices made it difficult for many residents to purchase expensive heaters, so people turned to this new option.”

Describing the manufacturing process, he says: “The first stage is using the fragments of missiles found, or taking the unexploded ones and breaking them down into pieces. [You need to] get experts to take out [any remaining] explosives and eventually sell these to quarries to be used in blowing out rocks.”

Then, the missile is carried to the workshop where the upper part is removed and a side crack is made to release fumes, al-Othman explains.

He says that the strong metal used in manufacturing the missiles makes them more resilient to sustained high temperatures. They are also cost-effective, he says, at only \$US15, compared to around \$US100 for a new heater.

The missile-turned-heater can work with coal, wood, pyrene or nylon, al-Othman adds.

Al-Obaid obtains pyrene from olive oil press machines in northern Syria, as a by-product that is then compressed, dried and sold in the form of cylinders.
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
    question:
        'What economic factor most influenced residents’ shift toward missile-turned-heaters?',
    options: [
      "A) A government heating subsidy",
      "B) An international ban on imported heaters",
      "C) A cultural tradition of recycling metal",
      "D) A sharp rise in iron prices"
    ],
    correctIndex: 3,
    explanation:
        "Explanation: The text states al-Othman explained that the big increase in iron prices made it difficult to buy metal, so people turned to this new option.",
    incorrectExplanations: [
      "A government subsidy was not mentioned as a reason.",
      "There is no indication of an international ban on heaters.",
      "Cultural tradition is unrelated to this specific shift.",
      "Correct answer!"
    ],
  ),
  QuestionData(
    question:
        'Who typically handles the removal of explosives from unexploded missiles?',
    options: [
      "A) Farmers",
      "B) Quarry workers",
      "C) Trained experts",
      "D) Local shopkeepers"
    ],
    correctIndex: 2,
    explanation:
        "Explanation: The description notes that trained experts must remove explosives for safety.",
    incorrectExplanations: [
      "Farmers are not responsible for handling explosives.",
      "Quarry workers are not mentioned as part of this process.",
      "Correct answer!",
      "Shopkeepers are not involved in missile disarming."
    ],
  ),
  QuestionData(
    question:
        'At which stage in the process is a side crack made to release fumes?',
    options: [
      "A) Before the missile is brought to the workshop",
      "B) While transporting it from the quarry",
      "C) After the upper part is removed in the workshop",
      "D) Once fuel is added for the first time"
    ],
    correctIndex: 2,
    explanation:
        "Explanation: Al-Othman explains that the side crack is made after removing the upper part in the workshop.",
    incorrectExplanations: [
      "The crack is made during workshop preparation, not before.",
      "Transporting from the quarry is not part of the described process.",
      "Correct answer!",
      "Fuel is never added; the process focuses on repurposing, not reuse."
    ],
  ),
  QuestionData(
    question:
        'Which step ensures the safety of repurposing unexploded missiles?',
    options: [
      "A) Painting them with protective coating",
      "B) Removing leftover explosives by specialists",
      "C) Washing them with high-pressure water",
      "D) Cooling them before cutting"
    ],
    correctIndex: 1,
    explanation:
        "Explanation: Al-Othman says experts are needed to remove any remaining explosives before use.",
    incorrectExplanations: [
      "Painting is done after conversion, not for safety.",
      "Correct answer!",
      "Washing is not mentioned as a safety measure.",
      "Cooling is not described in the text as necessary for safety."
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
He believes that, despite its bad smell and health risks, pyrene is still a good option as it includes oils that make it combust more easily than wood. Being cheap, coal is also seen as a perfect fit.

Jalal al-Shardoub, a resident of Kelli refugee camp, north of Idlib and a father-of-five, says he uses coal to fuel his heater, despite its bad smell and negative effect on his children. The coal used is a by-product of primitive oil refining procedures, with 1kg of coal costing about \$US1.5.

Other residents cannot even afford these rudimentary and dangerous heat sources. Instead, they head to landfill sites to sift through piles of waste until they find something to burn to generate heat.

Fatima Al-Terzi lives with her six children in an unfinished house with no doors or windows on the outskirts of Idlib, after losing her husband in a shelling by forces loyal to President Bashar al-Assad. She tells SciDev.Net, about her daily ritual of going with her children to landfill sites and collecting plastic bags and cardboard to burn. Despite their bad smell, she says this is her only choice.
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
        'Who is most likely to face health risks from coal use in Jalal al-Shardoub’s household?',
    options: [
      "A) His neighbors",
      "B) His children",
      "C) The local blacksmith",
      "D) Aid workers"
    ],
    correctIndex: 1,
    explanation:
        "Explanation: The text states that the coal has a negative effect on his children’s health.",
    incorrectExplanations: [
      "Neighbors are not mentioned as being affected by the coal use.",
      "Correct answer!",
      "The blacksmith is unrelated to this household’s health issues.",
      "Aid workers are not living in the home and thus not exposed."
    ],
  ),
  QuestionData(
    question: 'When do Fatima and her children collect materials for heating?',
    options: [
      "A) As part of a morning routine",
      "B) Only during extreme cold waves",
      "C) Before humanitarian aid deliveries",
      "D) At night to avoid crowds"
    ],
    correctIndex: 0,
    explanation:
        "Explanation: She describes it as a daily ritual, implying it is part of her regular morning activity.",
    incorrectExplanations: [
      "Correct answer!",
      "Extreme cold waves are not mentioned as the only time.",
      "Aid deliveries are unrelated to their routine.",
      "There is no mention of avoiding crowds at night."
    ],
  ),
  QuestionData(
    question:
        'Where do some residents go when they cannot afford coal or pyrene?',
    options: [
      "A) Local schools",
      "B) Olive oil press machines",
      "C) Landfill sites",
      "D) Abandoned factories"
    ],
    correctIndex: 2,
    explanation:
        "Explanation: The text explains that they head to landfill sites to find materials to burn.",
    incorrectExplanations: [
      "Local schools are not mentioned as a source for fuel.",
      "Oil press machines are unrelated to heating materials.",
      "Correct answer!",
      "Abandoned factories are not referenced in the passage."
    ],
  ),
  QuestionData(
    question:
        'What does Fatima’s use of plastic bags and cardboard for heating suggest about her access to resources?',
    options: [
      "A) She has access to clean, renewable fuels",
      "B) She has access to affordable coal",
      "C) She relies on aid organizations for fuel",
      "D) She can only use what she can gather herself"
    ],
    correctIndex: 3,
    explanation:
        "Explanation: The passage shows she collects these materials from landfill sites, indicating she lacks access to safer or more reliable heating sources.",
    incorrectExplanations: [
      "She does not have access to clean or renewable fuels.",
      "Coal is not affordable for her, according to the text.",
      "The text does not mention aid organizations providing her fuel.",
      "Correct answer!"
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