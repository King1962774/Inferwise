import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inferwise',
      home: SplashScreen(), // Pantalla de carga inicial
    );
  }
}



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  // Controllers
  late AnimationController _bgController;
  late AnimationController _moonController;
  late AnimationController _moonFloatController;
  late AnimationController _moonGlowController;
  late AnimationController _lettersController;
  late AnimationController _tagController;
  late AnimationController _barController;
  late AnimationController _starsController;
  late AnimationController _shootController;

  // Animations
  late Animation<double> _bgFade;
  late Animation<double> _moonScale;
  late Animation<double> _moonRotate;
  late Animation<double> _moonFloatY;
  late Animation<double> _moonFloatR;
  late Animation<double> _moonGlow;
  late Animation<double> _moonGlow2;
  late Animation<double> _tagOpacity;
  late Animation<double> _tagSpacing;
  late Animation<double> _barWidth;

  // Letter animations (9 letters)
  final List<Animation<double>> _letterOpacity = [];
  final List<Animation<double>> _letterY = [];

  // Star twinkle animations
  final List<Animation<double>> _starOpacity = [];

  // ignore: unused_field
  static const _brown = Color(0xFF060D22);

  // Star data: x%, y%, size, animDuration, animDelay, type(0=circle,1=cross)
  static const List<List<double>> _stars = [
    [0.06, 0.02, 2.0,  2.1, 0.0,  0],
    [0.23, 0.03, 2.5,  3.0, 0.3,  0],
    [0.47, 0.02, 2.0,  2.4, 0.6,  0],
    [0.72, 0.04, 3.0,  1.9, 0.9,  0],
    [0.91, 0.03, 2.0,  2.7, 0.2,  0],
    [0.13, 0.08, 1.5,  3.2, 0.5,  0],
    [0.35, 0.07, 2.0,  2.5, 1.0,  0],
    [0.60, 0.09, 1.5,  2.2, 0.7,  0],
    [0.84, 0.06, 2.0,  3.1, 0.4,  0],
    [0.04, 0.12, 1.0,  2.8, 1.2,  0],
    [0.28, 0.14, 2.5,  1.8, 0.1,  0],
    [0.52, 0.16, 1.5,  2.6, 0.8,  0],
    [0.77, 0.13, 2.0,  3.3, 0.3,  0],
    [0.95, 0.18, 1.0,  2.0, 1.1,  0],
    [0.10, 0.22, 1.5,  2.9, 0.6,  0],
    [0.42, 0.20, 2.0,  2.3, 0.9,  0],
    [0.67, 0.25, 1.5,  3.4, 0.4,  0],
    [0.88, 0.28, 1.0,  2.1, 1.3,  0],
    [0.18, 0.32, 2.0,  2.7, 0.7,  0],
    [0.78, 0.35, 1.5,  3.0, 0.2,  0],
    [0.05, 0.58, 2.0,  2.4, 0.5,  0],
    [0.22, 0.62, 1.5,  3.1, 1.0,  0],
    [0.48, 0.60, 2.5,  2.2, 0.3,  0],
    [0.70, 0.65, 1.0,  2.8, 0.8,  0],
    [0.91, 0.63, 2.0,  1.9, 0.2,  0],
    [0.12, 0.70, 1.5,  3.3, 1.2,  0],
    [0.38, 0.72, 2.0,  2.5, 0.6,  0],
    [0.62, 0.75, 1.0,  2.9, 0.4,  0],
    [0.84, 0.78, 2.0,  2.1, 0.9,  0],
    [0.25, 0.82, 1.5,  3.2, 0.7,  0],
    [0.55, 0.85, 2.5,  2.4, 0.1,  0],
    [0.75, 0.88, 1.0,  2.7, 1.4,  0],
    [0.38, 0.92, 2.0,  2.0, 0.3,  0],
    [0.85, 0.94, 1.5,  3.0, 0.8,  0],
    // 4-point sparkles
    [0.38, 0.05, 4.5,  2.6, 0.4,  1],
    [0.93, 0.20, 3.5,  3.0, 0.9,  1],
    [0.16, 0.80, 3.5,  2.8, 1.2,  1],
    [0.60, 0.70, 4.0,  2.3, 0.5,  1],
  ];

  // Shooting star data: top%, right%, width, delay
  static const List<List<double>> _shootingStars = [
    [0.08, 0.14, 110, 1.5],
    [0.26, 0.05,  70, 7.0],
    [0.14, 0.28,  55, 12.0],
  ];

  @override
  void initState() {
    super.initState();

    // ── BG FADE ───────────────────────────────────────────────────
    _bgController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _bgFade = CurvedAnimation(parent: _bgController, curve: Curves.easeOut);
    _bgController.forward();

    // ── MOON ENTRANCE ─────────────────────────────────────────────
    _moonController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _moonScale = Tween<double>(begin: .40, end: 1.0).animate(
        CurvedAnimation(parent: _moonController, curve: Curves.elasticOut));
    _moonRotate = Tween<double>(begin: -30 * math.pi / 180, end: 0).animate(
        CurvedAnimation(parent: _moonController, curve: Curves.easeOut));
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _moonController.forward();
    });

    // ── MOON FLOAT ────────────────────────────────────────────────
    _moonFloatController = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this)
      ..repeat(reverse: true);
    _moonFloatY = Tween<double>(begin: 0, end: -6).animate(
        CurvedAnimation(parent: _moonFloatController, curve: Curves.easeInOut));
    _moonFloatR = Tween<double>(begin: 0, end: 2 * math.pi / 180).animate(
        CurvedAnimation(parent: _moonFloatController, curve: Curves.easeInOut));

    // ── MOON GLOW PULSE ───────────────────────────────────────────
    _moonGlowController = AnimationController(
        duration: const Duration(milliseconds: 3500), vsync: this)
      ..repeat(reverse: true);
    _moonGlow = Tween<double>(begin: .30, end: .55).animate(
        CurvedAnimation(parent: _moonGlowController, curve: Curves.easeInOut));
    _moonGlow2 = Tween<double>(begin: .12, end: .22).animate(
        CurvedAnimation(parent: _moonGlowController, curve: Curves.easeInOut));

    // ── LETTERS ───────────────────────────────────────────────────
    // "INFERWISE" — 9 letters, staggered from 650ms
    _lettersController = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this);
    const delays = [0.0, .06, .12, .18, .24, .33, .39, .45, .51];
    for (int i = 0; i < 9; i++) {
      final start = delays[i];
      final end = (start + .45).clamp(0.0, 1.0);
      _letterOpacity.add(Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _lettersController,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      ));
      _letterY.add(Tween<double>(begin: -20, end: 0).animate(
        CurvedAnimation(
          parent: _lettersController,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      ));
    }
    Future.delayed(const Duration(milliseconds: 650), () {
      if (mounted) _lettersController.forward();
    });

    // ── TAGLINE ───────────────────────────────────────────────────
    _tagController = AnimationController(
        duration: const Duration(milliseconds: 900), vsync: this);
    _tagOpacity = Tween<double>(begin: 0, end: .55).animate(
        CurvedAnimation(parent: _tagController, curve: Curves.easeOut));
    _tagSpacing = Tween<double>(begin: 10, end: 3.5).animate(
        CurvedAnimation(parent: _tagController, curve: Curves.easeOut));
    Future.delayed(const Duration(milliseconds: 1250), () {
      if (mounted) _tagController.forward();
    });

    // ── LOADING BAR ───────────────────────────────────────────────
    _barController = AnimationController(
        duration: const Duration(milliseconds: 2800), vsync: this);
    _barWidth = CurvedAnimation(
        parent: _barController,
        curve: const Cubic(.4, 0, .15, 1));
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) _barController.forward();
    });

    // ── STARS TWINKLE ─────────────────────────────────────────────
    _starsController = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this)
      ..repeat();
    for (int i = 0; i < _stars.length; i++) {
      final dur = _stars[i][3];
      final delay = _stars[i][4];
      final totalCycle = dur + delay;
      _starOpacity.add(Tween<double>(begin: .9, end: .1).animate(
        CurvedAnimation(
          parent: _starsController,
          curve: Interval(
            (delay / totalCycle).clamp(0.0, 1.0),
            1.0,
            curve: Curves.easeInOut,
          ),
        ),
      ));
    }

    // ── SHOOTING STARS ────────────────────────────────────────────
    _shootController = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this)
      ..repeat();

    // ── NAVIGATE ──────────────────────────────────────────────────
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const MainScreen()));
    });
  }

  @override
  void dispose() {
    _bgController.dispose();
    _moonController.dispose();
    _moonFloatController.dispose();
    _moonGlowController.dispose();
    _lettersController.dispose();
    _tagController.dispose();
    _barController.dispose();
    _starsController.dispose();
    _shootController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: FadeTransition(
        opacity: _bgFade,
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(-0.4, -0.3),
              radius: 1.4,
              colors: [
                Color(0xFF0E1D45),
                Color(0xFF07102A),
                Color(0xFF040918),
                Color(0xFF010509),
              ],
              stops: [0.0, 0.40, 0.70, 1.0],
            ),
          ),
          child: Stack(
            children: [
              // ── MILKY WAY BAND ─────────────────────────────────
              Positioned.fill(
                child: Transform.rotate(
                  angle: -16 * math.pi / 180,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.transparent,
                          Color(0x0D375FA0),
                          Color(0x175A6ED2),
                          Color(0x12825AC3),
                          Color(0x0A375FA0),
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.18, 0.36, 0.52, 0.68, 1.0],
                      ),
                    ),
                  ),
                ),
              ),

              // ── NEBULAE ────────────────────────────────────────
              _Nebula(alignment: const Alignment(-1.0, -0.85),
                  color: const Color(0xFF412DAF), size: 440),
              _Nebula(alignment: const Alignment(1.0, 0.80),
                  color: const Color(0xFF1955C3), size: 320, delay: 2200),
              _Nebula(alignment: const Alignment(0.80, 0.30),
                  color: const Color(0xFF7D37CD), size: 240, delay: 4000),
              _Nebula(alignment: const Alignment(-0.95, 0.55),
                  color: const Color(0xFF2373AF), size: 190, delay: 1200),

              // ── STARS ──────────────────────────────────────────
              AnimatedBuilder(
                animation: _starsController,
                builder: (_, __) {
                  return CustomPaint(
                    painter: _StarFieldPainter(
                      stars: _stars,
                      starOpacities: List.generate(
                          _stars.length, (i) => _starOpacity[i].value),
                      shootT: _shootController.value,
                      shootingStars: _shootingStars,
                      screenSize: size,
                    ),
                    size: size,
                  );
                },
              ),

              // ── MAIN CONTENT ───────────────────────────────────
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Moon
                    AnimatedBuilder(
                      animation: Listenable.merge([
                        _moonController,
                        _moonFloatController,
                        _moonGlowController,
                      ]),
                      builder: (_, __) {
                        return Transform.translate(
                          offset: Offset(0, _moonFloatY.value),
                          child: Transform.rotate(
                            angle: _moonController.isCompleted
                                ? _moonFloatR.value
                                : _moonRotate.value,
                            child: Transform.scale(
                              scale: _moonScale.value,
                              child: SizedBox(
                                width: 90,
                                height: 90,
                                child: CustomPaint(
                                  painter: _MoonPainter(
                                    glow: _moonGlow.value,
                                    glow2: _moonGlow2.value,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 28),

                    // INFERWISE letters
                    AnimatedBuilder(
                      animation: _lettersController,
                      builder: (_, __) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: List.generate(9, (i) {
                            final isWise = i >= 5;
                            final letter = 'INFERWISE'[i];
                            return Transform.translate(
                              offset: Offset(0, _letterY[i].value),
                              child: Opacity(
                                opacity: _letterOpacity[i].value,
                                child: isWise
                                    ? ShaderMask(
                                        shaderCallback: (bounds) =>
                                            const LinearGradient(
                                          colors: [
                                            Color(0xFF6382DC),
                                            Color(0xFFA07FE8),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ).createShader(bounds),
                                        child: Text(
                                          letter,
                                          style: GoogleFonts.playfairDisplay(
                                            fontSize: 46,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        letter,
                                        style: GoogleFonts.playfairDisplay(
                                          fontSize: 46,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFFE8EEFF),
                                          letterSpacing: 2,
                                        ),
                                      ),
                              ),
                            );
                          }),
                        );
                      },
                    ),

                    const SizedBox(height: 10),

                    // Tagline
                    AnimatedBuilder(
                      animation: _tagController,
                      builder: (_, __) {
                        return Opacity(
                          opacity: _tagOpacity.value,
                          child: Text(
                            'Learn  ·  Infer  ·  Grow',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              letterSpacing: _tagSpacing.value,
                              color: const Color(0xFFA0B4F0),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 50),

                    // Loading bar
                    AnimatedBuilder(
                      animation: _barController,
                      builder: (_, __) {
                        return SizedBox(
                          width: 180,
                          child: Column(
                            children: [
                              // Bar track
                              Container(
                                height: 1.5,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6382DC)
                                      .withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: FractionallySizedBox(
                                  widthFactor: _barWidth.value,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF6382DC),
                                          Color(0xFFA07FE8),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Dot indicators
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(3, (i) {
                                  return _PulsingDot(
                                    color: [
                                      const Color(0xFF6382DC),
                                      const Color(0xFF8080D8),
                                      const Color(0xFFA07FE8),
                                    ][i],
                                    delay: Duration(
                                        milliseconds: i * 250),
                                  );
                                }),
                              ),
                            ],
                          ),
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
}

// ─── Nebula widget ────────────────────────────────────────────────────
class _Nebula extends StatefulWidget {
  final Alignment alignment;
  final Color color;
  final double size;
  final int delay;

  const _Nebula({
    required this.alignment,
    required this.color,
    required this.size,
    this.delay = 0,
  });

  @override
  State<_Nebula> createState() => _NebulaState();
}

class _NebulaState extends State<_Nebula>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        duration: Duration(milliseconds: 8000 + widget.delay ~/ 2),
        vsync: this)
      ..repeat(reverse: true);
    _opacity = Tween<double>(begin: .08, end: .20).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    _scale = Tween<double>(begin: 1.0, end: 1.07).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));

    if (widget.delay > 0) {
      _ctrl.value = widget.delay / 10000;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: widget.alignment,
        child: AnimatedBuilder(
          animation: _ctrl,
          builder: (_, __) => Opacity(
            opacity: _opacity.value,
            child: Transform.scale(
              scale: _scale.value,
              child: Container(
                width: widget.size,
                height: widget.size * 0.6,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius:
                      BorderRadius.circular(widget.size),
                  gradient: RadialGradient(
                    colors: [
                      widget.color.withOpacity(1),
                      widget.color.withOpacity(0),
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

// ─── Pulsing dot ──────────────────────────────────────────────────────
class _PulsingDot extends StatefulWidget {
  final Color color;
  final Duration delay;

  const _PulsingDot({required this.color, required this.delay});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this)
      ..repeat(reverse: true);
    _scale = Tween<double>(begin: 1.0, end: 1.7).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    _opacity = Tween<double>(begin: .3, end: .95).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));

    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) => Opacity(
          opacity: _opacity.value,
          child: Transform.scale(
            scale: _scale.value,
            child: Container(
              width: 3,
              height: 3,
              decoration: BoxDecoration(
                  color: widget.color, shape: BoxShape.circle),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Star field + shooting stars painter ─────────────────────────────
class _StarFieldPainter extends CustomPainter {
  final List<List<double>> stars;
  final List<double> starOpacities;
  final double shootT;
  final List<List<double>> shootingStars;
  final Size screenSize;

  _StarFieldPainter({
    required this.stars,
    required this.starOpacities,
    required this.shootT,
    required this.shootingStars,
    required this.screenSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Regular stars
    for (int i = 0; i < stars.length; i++) {
      final s = stars[i];
      final x = s[0] * size.width;
      final y = s[1] * size.height;
      final r = s[2] / 2;
      final type = s[5].toInt();
      final opacity = starOpacities[i].clamp(0.0, 1.0);
      final paint = Paint()
        ..color = Colors.white.withOpacity(opacity)
        ..style = PaintingStyle.fill;

      if (type == 0) {
        canvas.drawCircle(Offset(x, y), r, paint);
      } else {
        // 4-point sparkle
        final armLen = r * 2;
        final strokePaint = Paint()
          ..color = Colors.white.withOpacity(opacity)
          ..strokeWidth = 1.0
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(
            Offset(x - armLen, y), Offset(x + armLen, y), strokePaint);
        canvas.drawLine(
            Offset(x, y - armLen), Offset(x, y + armLen), strokePaint);
      }
    }

    // Shooting stars
    for (final ss in shootingStars) {
      final delay = ss[3];
      final cycle = 5.0;
      final elapsed = (shootT * cycle * shootingStars.length) % cycle;
      if (elapsed < delay || elapsed > delay + 1.5) continue;

      final prog = ((elapsed - delay) / 1.5).clamp(0.0, 1.0);
      final startX = size.width * (1.0 - ss[1]);
      final startY = size.height * ss[0];
      final len = ss[2];
      final dx = -prog * len * 2.5;
      final dy = prog * len * 1.2;
      final opacity = prog < 0.1
          ? prog / 0.1
          : prog > 0.8
              ? (1.0 - prog) / 0.2
              : 1.0;

      final shootPaint = Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.white.withOpacity(opacity * .95),
            Colors.white.withOpacity(opacity * .4),
            Colors.transparent,
          ],
        ).createShader(Rect.fromPoints(
          Offset(startX + dx, startY + dy),
          Offset(startX + dx + len, startY + dy - len * 0.5),
        ))
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      canvas.drawLine(
        Offset(startX + dx, startY + dy),
        Offset(startX + dx + len, startY + dy - len * 0.5),
        shootPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _StarFieldPainter old) =>
      old.shootT != shootT ||
      old.starOpacities != starOpacities;
}

// ─── Moon CustomPainter ───────────────────────────────────────────────
class _MoonPainter extends CustomPainter {
  final double glow;
  final double glow2;

  _MoonPainter({required this.glow, required this.glow2});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.244; // ~22 on 90px

    // Outer ambient glow
    canvas.drawCircle(
      Offset(cx, cy),
      size.width * 0.467,
      Paint()
        ..shader = RadialGradient(colors: [
          const Color(0xFFA0B8FF).withOpacity(glow2),
          const Color(0xFFA0B8FF).withOpacity(0),
        ]).createShader(
            Rect.fromCircle(center: Offset(cx, cy), radius: size.width * 0.467)),
    );

    // Inner glow halo
    canvas.drawCircle(
      Offset(cx, cy),
      size.width * 0.356,
      Paint()
        ..shader = RadialGradient(colors: [
          const Color(0xFFC8D8FF).withOpacity(glow),
          const Color(0xFFC8D8FF).withOpacity(0),
        ]).createShader(
            Rect.fromCircle(center: Offset(cx, cy), radius: size.width * 0.356)),
    );

    // Moon body — bright white
    canvas.drawCircle(
      Offset(cx, cy),
      r,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.4, -0.44),
          radius: 0.72,
          colors: const [
            Color(0xFFFFFFFF),
            Color(0xFFF0F4FF),
            Color(0xFFD0DCF8),
            Color(0xFF98B0E0),
          ],
          stops: const [0.0, 0.30, 0.65, 1.0],
        ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: r)),
    );

    // Crescent cutout — offset dark circle
    final cutR = r * 0.864;
    final cutX = cx + r * 0.318;
    final cutY = cy - r * 0.182;
    canvas.drawCircle(
      Offset(cutX, cutY),
      cutR,
      Paint()..color = const Color(0xFF060D22).withOpacity(0.96),
    );

    // Craters on visible crescent slice
    final craterPaint = Paint()
      ..color = const Color(0xFFB4CDF5).withOpacity(0.22)
      ..style = PaintingStyle.fill;
    final craterPositions = [
      [cx - r * .36, cy - r * .09, r * .10],
      [cx - r * .50, cy + r * .23, r * .07],
      [cx - r * .27, cy + r * .51, r * .08],
      [cx - r * .68, cy + r * .00, r * .05],
      [cx - r * .36, cy - r * .55, r * .05],
    ];
    for (final c in craterPositions) {
      canvas.drawCircle(Offset(c[0], c[1]), c[2], craterPaint);
    }

    // Bright rim light on crescent edge
    final rimPath = Path()
      ..moveTo(cx, cy - r)
      ..quadraticBezierTo(cx - r * 1.2, cy, cx - r * .45, cy + r * .75);
    canvas.drawPath(
      rimPath,
      Paint()
        ..color = Colors.white.withOpacity(0.28)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round,
    );

    // 3 small stars near moon tip
    final smallStarPaint = Paint()..color = Colors.white;
    canvas.drawCircle(
        Offset(cx + r * 1.2, cy - r * .86), 1.5, smallStarPaint..opacity);
    for (final st in [
      [cx + r * 1.44, cy - r * .29, 1.0],
      [cx + r * 0.89, cy - r * 1.11, 1.2],
    ]) {
      canvas.drawCircle(
          Offset(st[0], st[1]), st[2], Paint()..color = Colors.white.withOpacity(.65));
    }
  }

  @override
  bool shouldRepaint(covariant _MoonPainter old) =>
      old.glow != glow || old.glow2 != glow2;
}

extension on Paint {
  double get opacity => 0;
}