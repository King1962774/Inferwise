// ignore_for_file: unused_field, duplicate_ignore

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Green/Content/Spot3/Spot_Page/Reading_Spot.dart';

import 'dart:math' as math;

class TheStarbeastSplashScreen extends StatefulWidget {
  const TheStarbeastSplashScreen({super.key});

  @override
  State<TheStarbeastSplashScreen> createState() =>
      _TheStarbeastSplashScreenState();
}

class _TheStarbeastSplashScreenState extends State<TheStarbeastSplashScreen>
    with TickerProviderStateMixin {
  // ── Controllers ──────────────────────────────────────────────────
  late AnimationController _bgCtrl;
  late AnimationController _skullCtrl;
  late AnimationController _skullFloatCtrl;
  late AnimationController _glowCtrl;
  late AnimationController _eyeCtrl;
  late AnimationController _orbit1Ctrl; // ring 1 — 4 stars, 8s
  late AnimationController _orbit2Ctrl; // ring 2 — 5 stars, 13s
  late AnimationController _orbit3Ctrl; // ring 3 — 3 stars, 18s
  late AnimationController _starsCtrl; // background twinkle
  late AnimationController _shootCtrl; // shooting stars
  late AnimationController _textCtrl;

  // ── Animations ───────────────────────────────────────────────────
  late Animation<double> _bgFade;
  late Animation<double> _skullScale;
  late Animation<double> _skullRotate;
  late Animation<double> _skullFloatY;
  late Animation<double> _skullFloatR;
  late Animation<double> _innerGlow;
  late Animation<double> _outerGlow;
  late Animation<double> _eyeGlow;
  // ignore: unused_field
  late Animation<double> _textOpacity;
  // ignore: unused_field
  late Animation<double> _textY;
  late Animation<double> _titleOpacity;
  late Animation<double> _titleY;
  late Animation<double> _authorOpacity;
  late Animation<double> _dividerOpacity;
  late Animation<double> _dividerScale;

  // background star opacities (22 stars)
  final List<Animation<double>> _starAnim = [];

  // ── Star field data ──────────────────────────────────────────────
  // x%, y%, radius, twinkleDuration(s), twinkleDelay(s), type(0=dot,1=cross)
  static const List<List<double>> _stars = [
    [.07, .03, 1.0, 2.2, 0.0, 0], [.28, .05, 1.25, 2.9, .3, 0],
    [.52, .02, 1.0, 2.5, .6, 0],
    [.76, .04, 1.5, 2.0, .9, 0], [.92, .08, .75, 3.1, .2, 0],
    [.14, .12, 1.0, 2.7, .5, 0],
    [.44, .10, .75, 2.3, 1.0, 0], [.65, .07, 1.0, 3.3, .7, 0],
    [.85, .15, .5, 2.1, .4, 0],
    [.05, .18, 1.25, 2.8, 1.2, 0], [.38, .20, .75, 2.4, .8, 0],
    [.72, .22, 1.0, 3.0, .3, 0],
    [.95, .25, .5, 1.9, 1.1, 0], [.04, .60, .75, 2.6, .6, 0],
    [.25, .64, 1.0, 2.2, .9, 0],
    [.58, .67, .5, 3.2, .4, 0], [.82, .70, 1.25, 2.0, 1.3, 0],
    [.42, .75, .75, 2.9, .7, 0],
    [.16, .80, 1.0, 2.5, .2, 0], [.68, .84, .5, 2.7, 1.0, 0],
    [.90, .88, 1.0, 3.1, .5, 0],
    [.33, .92, .75, 2.3, .8, 0],
    // 4-point sparkles
    [.36, .06, 4.5, 2.6, .4, 1], [.91, .18, 3.5, 3.0, .9, 1],
    [.14, .78, 4.0, 2.8, 1.2, 1],
  ];

  // Shooting stars: topFraction, rightFraction, widthPx, delayS
  static const List<List<double>> _shoots = [
    [.09, .12, 100, 2.0],
    [.28, .06, 65, 7.0],
  ];

  // Orbiting stars:
  // ring(1/2/3), offsetAngleDeg, radius, starRadius, durationS
  static const List<List<double>> _orbitStars = [
    // Ring 1 — r=62, 4 stars, 8s
    [1, 0, 62, 2.5, 8.0],
    [1, 90, 62, 2.0, 8.0],
    [1, 180, 62, 2.5, 8.0],
    [1, 270, 62, 2.0, 8.0],
    // Ring 2 — r=75, 5 stars, 13s
    [2, 0, 75, 2.0, 13.0],
    [2, 72, 75, 1.5, 13.0],
    [2, 144, 75, 2.5, 13.0],
    [2, 216, 75, 1.5, 13.0],
    [2, 288, 75, 2.0, 13.0],
    // Ring 3 — r=50, 3 stars, 18s
    [3, 0, 50, 3.0, 18.0],
    [3, 120, 50, 2.0, 18.0],
    [3, 240, 50, 2.5, 18.0],
  ];

  @override
  void initState() {
    super.initState();

    // BG
    _bgCtrl = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    _bgFade = CurvedAnimation(parent: _bgCtrl, curve: Curves.easeOut);
    _bgCtrl.forward();

    // Skull entrance
    _skullCtrl = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _skullScale = Tween<double>(begin: .5, end: 1.0)
        .animate(CurvedAnimation(parent: _skullCtrl, curve: Curves.elasticOut));
    _skullRotate = Tween<double>(begin: -15 * math.pi / 180, end: 0)
        .animate(CurvedAnimation(parent: _skullCtrl, curve: Curves.easeOut));
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _skullCtrl.forward();
    });

    // Skull float
    _skullFloatCtrl = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this)
      ..repeat(reverse: true);
    _skullFloatY = Tween<double>(begin: 0, end: -8).animate(
        CurvedAnimation(parent: _skullFloatCtrl, curve: Curves.easeInOut));
    _skullFloatR = Tween<double>(begin: 0, end: 3 * math.pi / 180).animate(
        CurvedAnimation(parent: _skullFloatCtrl, curve: Curves.easeInOut));

    // Glow pulse
    _glowCtrl = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this)
      ..repeat(reverse: true);
    _innerGlow = Tween<double>(begin: .20, end: .45)
        .animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));
    _outerGlow = Tween<double>(begin: .15, end: .35)
        .animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));

    // Eye glow
    _eyeCtrl = AnimationController(
        duration: const Duration(milliseconds: 2500), vsync: this)
      ..repeat(reverse: true);
    _eyeGlow = Tween<double>(begin: .5, end: 1.0)
        .animate(CurvedAnimation(parent: _eyeCtrl, curve: Curves.easeInOut));

    // Orbit controllers
    _orbit1Ctrl = AnimationController(
        duration: const Duration(milliseconds: 8000), vsync: this)
      ..repeat();
    _orbit2Ctrl = AnimationController(
        duration: const Duration(milliseconds: 13000), vsync: this)
      ..repeat();
    _orbit3Ctrl = AnimationController(
        duration: const Duration(milliseconds: 18000), vsync: this)
      ..repeat();

    // Background stars
    _starsCtrl = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this)
      ..repeat();
    for (int i = 0; i < _stars.length; i++) {
      final delay = _stars[i][4];
      _starAnim.add(Tween<double>(begin: .9, end: .1).animate(
        CurvedAnimation(
          parent: _starsCtrl,
          curve: Interval(
            (delay / 4.0).clamp(0.0, .9),
            1.0,
            curve: Curves.easeInOut,
          ),
        ),
      ));
    }

    // Shooting stars
    _shootCtrl = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this)
      ..repeat();

    // Text entrance
    _textCtrl = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    _textOpacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut));
    _textY = Tween<double>(begin: 16, end: 0)
        .animate(CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut));
    _titleOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _textCtrl,
        curve: const Interval(.4, 1.0, curve: Curves.easeOut)));
    _titleY = Tween<double>(begin: 16, end: 0).animate(CurvedAnimation(
        parent: _textCtrl,
        curve: const Interval(.4, 1.0, curve: Curves.easeOut)));
    _authorOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _textCtrl,
        curve: const Interval(.6, 1.0, curve: Curves.easeOut)));
    _dividerOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _textCtrl,
        curve: const Interval(.2, .8, curve: Curves.easeOut)));
    _dividerScale = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _textCtrl,
        curve: const Interval(.2, .8, curve: Curves.easeOut)));
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) _textCtrl.forward();
    });

    // Navigate
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const TheStarBeast()));
    });
  }

  @override
  void dispose() {
    _bgCtrl.dispose();
    _skullCtrl.dispose();
    _skullFloatCtrl.dispose();
    _glowCtrl.dispose();
    _eyeCtrl.dispose();
    _orbit1Ctrl.dispose();
    _orbit2Ctrl.dispose();
    _orbit3Ctrl.dispose();
    _starsCtrl.dispose();
    _shootCtrl.dispose();
    _textCtrl.dispose();
    super.dispose();
  }

  // ignore: unused_element
  AnimationController _orbitCtrl(int ring) {
    if (ring == 1) return _orbit1Ctrl;
    if (ring == 2) return _orbit2Ctrl;
    return _orbit3Ctrl;
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
              center: Alignment(-.4, -.3),
              radius: 1.4,
              colors: [
                Color(0xFF0A1628),
                Color(0xFF060E1E),
                Color(0xFF020810),
                Color(0xFF010408),
              ],
              stops: [0.0, .45, .75, 1.0],
            ),
          ),
          child: Stack(
            children: [
              // Milky Way band
              Positioned.fill(
                child: Transform.rotate(
                  angle: -16 * math.pi / 180,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Color(0x061E3CA0),
                          Color(0x0A3258C8),
                          Color(0x061E3CA0),
                          Colors.transparent,
                        ],
                        stops: [0.0, .20, .38, .60, 1.0],
                      ),
                    ),
                  ),
                ),
              ),

              // Nebulae
              _Nebula(
                  color: const Color(0xFF142890),
                  alignment: const Alignment(-1.0, -.85),
                  size: 400),
              _Nebula(
                  color: const Color(0xFF0A3CB4),
                  alignment: const Alignment(1.0, .80),
                  size: 300,
                  delay: 2000),
              _Nebula(
                  color: const Color(0xFF2814B4),
                  alignment: const Alignment(.80, .20),
                  size: 220,
                  delay: 4000),

              // Star field + shooting stars
              AnimatedBuilder(
                animation: Listenable.merge([_starsCtrl, _shootCtrl]),
                builder: (_, __) => CustomPaint(
                  painter: _StarFieldPainter(
                    stars: _stars,
                    starOpacities:
                        List.generate(_stars.length, (i) => _starAnim[i].value),
                    shootT: _shootCtrl.value,
                    shoots: _shoots,
                    size: size,
                  ),
                  size: size,
                ),
              ),

              // Floating particles
              ..._buildParticles(),

              // Main content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Skull + orbiting stars
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: AnimatedBuilder(
                        animation: Listenable.merge([
                          _skullCtrl,
                          _skullFloatCtrl,
                          _glowCtrl,
                          _eyeCtrl,
                          _orbit1Ctrl,
                          _orbit2Ctrl,
                          _orbit3Ctrl,
                        ]),
                        builder: (_, __) {
                          final floatY =
                              _skullCtrl.isCompleted ? _skullFloatY.value : 0.0;
                          final floatR = _skullCtrl.isCompleted
                              ? _skullFloatR.value
                              : _skullRotate.value;
                          return Transform.translate(
                            offset: Offset(0, floatY),
                            child: Transform.rotate(
                              angle: floatR,
                              child: Transform.scale(
                                scale: _skullScale.value,
                                child: CustomPaint(
                                  painter: _SkullPainter(
                                    innerGlow: _innerGlow.value,
                                    outerGlow: _outerGlow.value,
                                    eyeGlow: _eyeGlow.value,
                                    orbit1T: _orbit1Ctrl.value,
                                    orbit2T: _orbit2Ctrl.value,
                                    orbit3T: _orbit3Ctrl.value,
                                    orbitStars: _orbitStars,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Divider
                    AnimatedBuilder(
                      animation: _textCtrl,
                      builder: (_, __) => Opacity(
                        opacity: _dividerOpacity.value,
                        child: Transform.scale(
                          scaleX: _dividerScale.value,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                        height: 1,
                                        color: const Color(0xFF5090FF)
                                            .withOpacity(.45))),
                                const SizedBox(width: 8),
                                const Icon(Icons.star_rounded,
                                    color: Color(0xFF64A0FF), size: 14),
                                const SizedBox(width: 8),
                                Expanded(
                                    child: Container(
                                        height: 1,
                                        color: const Color(0xFF5090FF)
                                            .withOpacity(.45))),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Title
                    AnimatedBuilder(
                      animation: _textCtrl,
                      builder: (_, __) => Transform.translate(
                        offset: Offset(0, _titleY.value),
                        child: Opacity(
                          opacity: _titleOpacity.value,
                          child: Text(
                            'The Star Beast',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFE0EEFF),
                              letterSpacing: .5,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Author
                    AnimatedBuilder(
                      animation: _textCtrl,
                      builder: (_, __) => Opacity(
                        opacity: _authorOpacity.value,
                        child: Text(
                          'by Damon Knight, 1949',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: const Color(0xFF8CB4FF).withOpacity(.70),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Source
                    AnimatedBuilder(
                      animation: _textCtrl,
                      builder: (_, __) => Opacity(
                        opacity: _authorOpacity.value,
                        child: Text(
                          'From The Project Gutenberg',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: const Color(0xFF8CB4FF).withOpacity(.70),
                          ),
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
    );
  }

  // Floating ambient particles
  List<Widget> _buildParticles() {
    const pts = [
      [.18, .20, 5.0, 0, 3400, 0],
      [.84, .22, 4.0, 1, 2900, 500],
      [.12, .42, 3.0, 0, 4000, 900],
      [.86, .40, 4.0, 2, 3100, 300],
      [.22, .26, 6.0, 3, 3500, 700],
      [.80, .38, 5.0, 1, 2800, 1100],
    ];
    return pts
        .map((p) => _FloatingParticle(
              xFrac: p[0] as double,
              yFrac: p[1] as double,
              size: p[2] as double,
              shape: p[3].toInt(),
              durationMs: p[4].toInt(),
              delayMs: p[5].toInt(),
            ))
        .toList();
  }
}

// ─── Floating particle ────────────────────────────────────────────────
class _FloatingParticle extends StatefulWidget {
  final double xFrac, yFrac, size;
  final int shape, durationMs, delayMs;
  const _FloatingParticle({
    required this.xFrac,
    required this.yFrac,
    required this.size,
    required this.shape,
    required this.durationMs,
    required this.delayMs,
  });
  @override
  State<_FloatingParticle> createState() => _FloatingParticleState();
}

class _FloatingParticleState extends State<_FloatingParticle>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<Offset> _pos;
  @override
  void initState() {
    super.initState();
    final offsets = [
      [const Offset(-8, -12), const Offset(0, 0)],
      [const Offset(9, -8), const Offset(0, 0)],
      [const Offset(-6, 10), const Offset(0, 0)],
      [const Offset(8, 8), const Offset(0, 0)],
    ];
    final pair = offsets[widget.shape % offsets.length];
    _c = AnimationController(
        duration: Duration(milliseconds: widget.durationMs), vsync: this)
      ..repeat(reverse: true);
    _pos = Tween<Offset>(begin: Offset.zero, end: pair[0])
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));
    if (widget.delayMs > 0) {
      _c.value = (widget.delayMs / widget.durationMs).clamp(0.0, 1.0);
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrSize = MediaQuery.of(context).size;
    return Positioned(
      left: widget.xFrac * scrSize.width,
      top: widget.yFrac * scrSize.height,
      child: AnimatedBuilder(
        animation: _c,
        builder: (_, __) => Transform.translate(
          offset: _pos.value,
          child: widget.shape >= 2
              ? Transform.rotate(
                  angle: math.pi / 4,
                  child: Container(
                    width: widget.size,
                    height: widget.size,
                    color: const Color(0xFF5090FF).withOpacity(.32),
                  ),
                )
              : Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF5090FF).withOpacity(.42),
                  ),
                ),
        ),
      ),
    );
  }
}

// ─── Nebula ───────────────────────────────────────────────────────────
class _Nebula extends StatefulWidget {
  final Color color;
  final Alignment alignment;
  final double size;
  final int delay;
  const _Nebula(
      {required this.color,
      required this.alignment,
      required this.size,
      this.delay = 0});
  @override
  State<_Nebula> createState() => _NebulaState();
}

class _NebulaState extends State<_Nebula> with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _opacity, _scale;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(
        duration: const Duration(milliseconds: 9000), vsync: this)
      ..repeat(reverse: true);
    _opacity = Tween<double>(begin: .08, end: .20)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));
    _scale = Tween<double>(begin: 1.0, end: 1.07)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));
    if (widget.delay > 0) {
      _c.value = (widget.delay / 9000.0).clamp(0.0, 1.0);
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: widget.alignment,
        child: AnimatedBuilder(
          animation: _c,
          builder: (_, __) => Opacity(
            opacity: _opacity.value,
            child: Transform.scale(
              scale: _scale.value,
              child: Container(
                width: widget.size,
                height: widget.size * .6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.size),
                  gradient: RadialGradient(
                    colors: [
                      widget.color.withOpacity(1),
                      widget.color.withOpacity(0)
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

// ─── Star field painter ───────────────────────────────────────────────
class _StarFieldPainter extends CustomPainter {
  final List<List<double>> stars;
  final List<double> starOpacities;
  final double shootT;
  final List<List<double>> shoots;
  final Size size;

  const _StarFieldPainter({
    required this.stars,
    required this.starOpacities,
    required this.shootT,
    required this.shoots,
    required this.size,
  });

  @override
  void paint(Canvas canvas, Size canvasSize) {
    // Stars
    for (int i = 0; i < stars.length; i++) {
      final s = stars[i];
      final x = s[0] * canvasSize.width;
      final y = s[1] * canvasSize.height;
      final r = s[2];
      final type = s[5].toInt();
      final op = starOpacities[i].clamp(0.0, 1.0);

      if (type == 0) {
        canvas.drawCircle(
            Offset(x, y), r, Paint()..color = Colors.white.withOpacity(op));
      } else {
        final p = Paint()
          ..color = const Color(0xFF64A0FF).withOpacity(op)
          ..strokeWidth = 1.0
          ..strokeCap = StrokeCap.round;
        final arm = r * .9;
        canvas.drawLine(Offset(x - arm, y), Offset(x + arm, y), p);
        canvas.drawLine(Offset(x, y - arm), Offset(x, y + arm), p);
      }
    }

    // Shooting stars
    for (final sh in shoots) {
      final delay = sh[3];
      final cycle = 5.0;
      final elapsed = (shootT * cycle * shoots.length) % cycle;
      if (elapsed < delay || elapsed > delay + 1.5) continue;
      final prog = ((elapsed - delay) / 1.5).clamp(0.0, 1.0);
      final sx = canvasSize.width * (1.0 - sh[1]);
      final sy = canvasSize.height * sh[0];
      final len = sh[2];
      final dx = -prog * len * 2.5;
      final dy = prog * len * 1.2;
      final op = prog < .1
          ? prog / .1
          : prog > .8
              ? (1 - prog) / .2
              : 1.0;
      canvas.drawLine(
        Offset(sx + dx, sy + dy),
        Offset(sx + dx + len, sy + dy - len * .5),
        Paint()
          ..shader = LinearGradient(colors: [
            const Color(0xFF96C8FF).withOpacity(op * .95),
            const Color(0xFF96C8FF).withOpacity(op * .4),
            Colors.transparent,
          ]).createShader(Rect.fromPoints(
            Offset(sx + dx, sy + dy),
            Offset(sx + dx + len, sy + dy - len * .5),
          ))
          ..strokeWidth = 1.5
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _StarFieldPainter o) =>
      o.shootT != shootT || o.starOpacities != starOpacities;
}

// ─── Skull + orbiting stars painter ──────────────────────────────────
class _SkullPainter extends CustomPainter {
  final double innerGlow, outerGlow, eyeGlow;
  final double orbit1T, orbit2T, orbit3T;
  final List<List<double>> orbitStars;

  const _SkullPainter({
    required this.innerGlow,
    required this.outerGlow,
    required this.eyeGlow,
    required this.orbit1T,
    required this.orbit2T,
    required this.orbit3T,
    required this.orbitStars,
  });

  // Map from 200×200 canvas to internal 110×110 coord space
  Offset p(Size s, double x, double y) =>
      Offset(x / 110 * s.width, y / 110 * s.height);
  double sc(Size s, double v) => v / 110 * s.width;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2; // 100
    final cy = size.height / 2; // 100

    // ── ORBITING STARS ────────────────────────────────────────────
    for (final os in orbitStars) {
      final ring = os[0].toInt();
      final offsetDeg = os[1];
      final radius = os[2] / 110 * size.width;
      final starR = sc(size, os[3]);
      final t = ring == 1
          ? orbit1T
          : ring == 2
              ? orbit2T
              : orbit3T;

      // tilt the ring differently per ring
      final tiltRad = ring == 1
          ? 0.0
          : ring == 2
              ? 20 * math.pi / 180
              : -30 * math.pi / 180;

      final angleDeg = offsetDeg + t * 360;
      final angleRad = angleDeg * math.pi / 180;

      // apply tilt: squash Y to simulate perspective
      final rawX = math.cos(angleRad) * radius;
      final rawY = math.sin(angleRad) * radius;
      // rotate by tilt around X axis (perspective squash)
      final tiltedY = rawY * math.cos(tiltRad);

      final sx = cx + rawX;
      final sy = cy + tiltedY;

      // pop scale based on position in orbit
      final pop = .7 + .3 * math.sin(angleRad * 2 + t * math.pi * 2);

      canvas.drawCircle(
        Offset(sx, sy),
        starR * pop,
        Paint()..color = const Color(0xFF8CC8FF).withOpacity(.75 * pop),
      );

      // Some sparkle cross stars on ring 1
      if (ring == 1 && offsetDeg == 0) {
        final crossPaint = Paint()
          ..color = const Color(0xFFB4E0FF).withOpacity(.80 * pop)
          ..strokeWidth = 1.0
          ..strokeCap = StrokeCap.round;
        final arm = starR * 1.8 * pop;
        canvas.drawLine(Offset(sx - arm, sy), Offset(sx + arm, sy), crossPaint);
        canvas.drawLine(Offset(sx, sy - arm), Offset(sx, sy + arm), crossPaint);
      }
      if (ring == 2 && offsetDeg == 0) {
        final crossPaint = Paint()
          ..color = const Color(0xFF8CB8FF).withOpacity(.70 * pop)
          ..strokeWidth = .9
          ..strokeCap = StrokeCap.round;
        final arm = starR * 1.6 * pop;
        canvas.drawLine(Offset(sx - arm, sy), Offset(sx + arm, sy), crossPaint);
        canvas.drawLine(Offset(sx, sy - arm), Offset(sx, sy + arm), crossPaint);
      }
    }

    // ── AMBIENT GLOWS ─────────────────────────────────────────────
    canvas.drawCircle(
        Offset(cx, cy),
        sc(size, 52),
        Paint()
          ..shader = RadialGradient(colors: [
            const Color(0xFF4080FF).withOpacity(outerGlow * .6),
            const Color(0xFF4080FF).withOpacity(0),
          ]).createShader(
              Rect.fromCircle(center: Offset(cx, cy), radius: sc(size, 52))));

    canvas.drawCircle(
        Offset(cx, cy),
        sc(size, 38),
        Paint()
          ..shader = RadialGradient(colors: [
            const Color(0xFF2060FF).withOpacity(innerGlow),
            const Color(0xFF1040CC).withOpacity(innerGlow * .3),
            const Color(0xFF1040CC).withOpacity(0),
          ], stops: const [
            0.0,
            .55,
            1.0
          ]).createShader(
              Rect.fromCircle(center: Offset(cx, cy), radius: sc(size, 38))));

    // ── SKULL BODY ────────────────────────────────────────────────
    // Cranium path (in 110×110 space scaled to canvas)
    final skullPath = Path();
    // ignore: unused_local_variable
    final pts = [
      [55, 14],
      [20, 46],
      [20, 46],
      [34, 70],
      [34, 80],
      [38, 84],
      [72, 84],
      [76, 80],
      [76, 70],
      [90, 46],
      [55, 14],
    ];
    skullPath.moveTo(p(size, 55, 14).dx, p(size, 55, 14).dy);
    // Left side
    skullPath.cubicTo(
      p(size, 34, 14).dx,
      p(size, 34, 14).dy,
      p(size, 20, 28).dx,
      p(size, 20, 28).dy,
      p(size, 20, 46).dx,
      p(size, 20, 46).dy,
    );
    skullPath.quadraticBezierTo(
      p(size, 20, 62).dx,
      p(size, 20, 62).dy,
      p(size, 34, 70).dx,
      p(size, 34, 70).dy,
    );
    skullPath.lineTo(p(size, 34, 80).dx, p(size, 34, 80).dy);
    skullPath.quadraticBezierTo(
      p(size, 34, 84).dx,
      p(size, 34, 84).dy,
      p(size, 38, 84).dx,
      p(size, 38, 84).dy,
    );
    skullPath.lineTo(p(size, 72, 84).dx, p(size, 72, 84).dy);
    skullPath.quadraticBezierTo(
      p(size, 76, 84).dx,
      p(size, 76, 84).dy,
      p(size, 76, 80).dx,
      p(size, 76, 80).dy,
    );
    skullPath.lineTo(p(size, 76, 70).dx, p(size, 76, 70).dy);
    skullPath.quadraticBezierTo(
      p(size, 90, 62).dx,
      p(size, 90, 62).dy,
      p(size, 90, 46).dx,
      p(size, 90, 46).dy,
    );
    skullPath.cubicTo(
      p(size, 90, 28).dx,
      p(size, 90, 28).dy,
      p(size, 76, 14).dx,
      p(size, 76, 14).dy,
      p(size, 55, 14).dx,
      p(size, 55, 14).dy,
    );
    skullPath.close();

    // Body fill
    canvas.drawPath(
      skullPath,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-.2, -.3),
          radius: .65,
          colors: const [
            Color(0xFFC8DCFF),
            Color(0xFF7AAAF0),
            Color(0xFF3060CC),
            Color(0xFF0A2060),
          ],
          stops: const [0.0, .35, .70, 1.0],
        ).createShader(Rect.fromLTWH(
          p(size, 20, 14).dx,
          p(size, 20, 14).dy,
          p(size, 70, 0).dx - p(size, 20, 0).dx,
          p(size, 0, 70).dy,
        )),
    );

    // Highlight
    final highlightPath = Path()
      ..moveTo(p(size, 45, 20).dx, p(size, 45, 20).dy)
      ..quadraticBezierTo(p(size, 55, 16).dx, p(size, 55, 16).dy,
          p(size, 65, 20).dx, p(size, 65, 20).dy)
      ..quadraticBezierTo(p(size, 72, 24).dx, p(size, 72, 24).dy,
          p(size, 74, 32).dx, p(size, 74, 32).dy)
      ..quadraticBezierTo(p(size, 65, 26).dx, p(size, 65, 26).dy,
          p(size, 55, 26).dx, p(size, 55, 26).dy)
      ..quadraticBezierTo(p(size, 45, 26).dx, p(size, 45, 26).dy,
          p(size, 36, 32).dx, p(size, 36, 32).dy)
      ..quadraticBezierTo(p(size, 38, 24).dx, p(size, 38, 24).dy,
          p(size, 45, 20).dx, p(size, 45, 20).dy)
      ..close();
    canvas.drawPath(highlightPath,
        Paint()..color = const Color(0xFFC8E1FF).withOpacity(.30));

    // Jaw line
    canvas.drawLine(
        p(size, 34, 72),
        p(size, 76, 72),
        Paint()
          ..color = const Color(0xFF143CB4).withOpacity(.55)
          ..strokeWidth = sc(size, 1.0));

    // Teeth
    final teethData = [
      [38.0, 7.0, 9.0],
      [47.0, 7.0, 10.0],
      [56.0, 7.0, 10.0],
      [65.0, 7.0, 9.0],
    ];
    for (int i = 0; i < teethData.length; i++) {
      final td = teethData[i];
      final toothRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          p(size, td[0], 84).dx,
          p(size, 0, 84).dy,
          sc(size, td[1]),
          sc(size, td[2]),
        ),
        Radius.circular(sc(size, 2)),
      );
      canvas.drawRRect(
          toothRect,
          Paint()
            ..color = (i == 0 || i == 3)
                ? const Color(0xFFB4D2FF).withOpacity(.70)
                : const Color(0xFFC8E1FF).withOpacity(.80));
    }
    // tooth dividers
    for (final tx in [45.0, 54.0, 63.0]) {
      canvas.drawLine(
        p(size, tx, 84),
        p(size, tx, 94),
        Paint()
          ..color = const Color(0xFF0A1E64).withOpacity(.40)
          ..strokeWidth = sc(size, .8),
      );
    }

    // Nose
    final nosePath = Path()
      ..moveTo(p(size, 52, 56).dx, p(size, 52, 56).dy)
      ..lineTo(p(size, 55, 50).dx, p(size, 55, 50).dy)
      ..lineTo(p(size, 58, 56).dx, p(size, 58, 56).dy)
      ..quadraticBezierTo(p(size, 58, 62).dx, p(size, 58, 62).dy,
          p(size, 55, 63).dx, p(size, 55, 63).dy)
      ..quadraticBezierTo(p(size, 52, 62).dx, p(size, 52, 62).dy,
          p(size, 52, 56).dx, p(size, 52, 56).dy)
      ..close();
    canvas.drawPath(
        nosePath, Paint()..color = const Color(0xFF050F50).withOpacity(.75));

    // ── EYES ──────────────────────────────────────────────────────
    for (final ex in [40.0, 70.0]) {
      final eyeCenter = p(size, ex, 46);
      // ignore: unused_local_variable
      final eyeOffset = ex == 40.0 ? .0 : .4; // delay offset

      // Glow halo
      canvas.drawOval(
        Rect.fromCenter(
            center: eyeCenter, width: sc(size, 22), height: sc(size, 20)),
        Paint()
          ..shader = RadialGradient(colors: [
            const Color(0xFF40B0FF).withOpacity(eyeGlow * .6),
            const Color(0xFF40B0FF).withOpacity(0),
          ]).createShader(Rect.fromCenter(
              center: eyeCenter, width: sc(size, 22), height: sc(size, 20))),
      );

      // Socket dark
      canvas.drawOval(
        Rect.fromCenter(
            center: eyeCenter, width: sc(size, 18), height: sc(size, 16)),
        Paint()..color = const Color(0xFF050F50).withOpacity(.90),
      );

      // Iris
      canvas.drawOval(
        Rect.fromCenter(
            center: eyeCenter, width: sc(size, 11), height: sc(size, 10)),
        Paint()
          ..shader = RadialGradient(
            center: const Alignment(-.35, -.35),
            colors: const [Color(0xFF60A0FF), Color(0xFF0820A0)],
          ).createShader(Rect.fromCenter(
              center: eyeCenter, width: sc(size, 11), height: sc(size, 10))),
      );

      // Pupil
      canvas.drawOval(
        Rect.fromCenter(
            center: eyeCenter, width: sc(size, 5), height: sc(size, 4.4)),
        Paint()..color = const Color(0xFF000528).withOpacity(.95),
      );

      // Shine
      canvas.drawOval(
        Rect.fromCenter(
          center:
              Offset(eyeCenter.dx - sc(size, 2), eyeCenter.dy - sc(size, 2)),
          width: sc(size, 3),
          height: sc(size, 2.4),
        ),
        Paint()..color = const Color(0xFFA0D2FF).withOpacity(.75),
      );
    }

    // ── CRACKS ────────────────────────────────────────────────────
    final crackOpacity = .4 + (.9 - .4) * math.sin(orbit1T * math.pi * 2).abs();

    final crack1 = Path()
      ..moveTo(p(size, 55, 20).dx, p(size, 55, 20).dy)
      ..lineTo(p(size, 52, 30).dx, p(size, 52, 30).dy)
      ..lineTo(p(size, 57, 36).dx, p(size, 57, 36).dy)
      ..lineTo(p(size, 53, 44).dx, p(size, 53, 44).dy);
    canvas.drawPath(
        crack1,
        Paint()
          ..color = const Color(0xFF64A0FF).withOpacity(crackOpacity)
          ..strokeWidth = sc(size, 1.2)
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);

    final crack2 = Path()
      ..moveTo(p(size, 68, 22).dx, p(size, 68, 22).dy)
      ..lineTo(p(size, 65, 32).dx, p(size, 65, 32).dy)
      ..lineTo(p(size, 70, 38).dx, p(size, 70, 38).dy);
    canvas.drawPath(
        crack2,
        Paint()
          ..color = const Color(0xFF5090FF).withOpacity(crackOpacity * .75)
          ..strokeWidth = sc(size, .9)
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);

    // Skull outline
    canvas.drawPath(
        skullPath,
        Paint()
          ..color = const Color(0xFF5090FF).withOpacity(.35)
          ..strokeWidth = sc(size, 1.2)
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant _SkullPainter o) =>
      o.innerGlow != innerGlow ||
      o.outerGlow != outerGlow ||
      o.eyeGlow != eyeGlow ||
      o.orbit1T != orbit1T ||
      o.orbit2T != orbit2T ||
      o.orbit3T != orbit3T;
}

class TheStarBeast extends StatefulWidget {
  const TheStarBeast({super.key});

  @override
  State<TheStarBeast> createState() => _TheStarBeastState();
}

class _TheStarBeastState extends State<TheStarBeast> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "What is the term used to describe life that originates from outside Earth?",
      "options": [
        "A) Terrestrial life",
        "B) Extraterrestrial life",
        "C) Marine life",
        "D) Plant life"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Terrestrial life refers to life on Earth.",
        "🛸 Correct! Extraterrestrial life refers to life that originates from another world rather than Earth.",
        " Incorrect. Marine life refers to ocean-based organisms on Earth.",
        " Incorrect. Plant life is a category of Earth-based organisms."
      ]
    },
    {
      "question":
          "Which equation is used to estimate the number of active, communicative extraterrestrial civilizations in the Milky Way galaxy?",
      "options": [
        "A) Einstein's equation",
        "B) Drake equation",
        "C) Schrödinger equation",
        "D) Newton's equation"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Einstein's equation is related to relativity, not extraterrestrial life.",
        "🛸 Correct! The Drake equation is used to estimate the number of extraterrestrial civilizations.",
        " Incorrect. Schrödinger’s equation applies to quantum mechanics.",
        " Incorrect. Newton's equation deals with motion and gravity."
      ]
    },
    {
      "question":
          "When are humans expected to start living in space permanently?",
      "options": ["A) By 2030", "B) By 2040", "C) By 2050", "D) By 2100"],
      "correct": 2,
      "feedback": [
        " Incorrect. 2030 is too soon based on current plans.",
        " Incorrect. 2040 is optimistic but not the most widely accepted estimate.",
        "🛸 Correct! Experts predict permanent space living may begin around 2050.",
        " Incorrect. While possible, 2100 is considered a more distant milestone."
      ]
    },
    {
      "question":
          "What is one common theory about the appearance of extraterrestrial beings?",
      "options": [
        "A) They look exactly like humans",
        "B) They are invisible",
        "C) They resemble animals on Earth",
        "D) They have green skin and large eyes"
      ],
      "correct": 3,
      "feedback": [
        " Incorrect. This is a less common theory.",
        " Incorrect. While intriguing, there’s no strong basis for invisibility.",
        " Incorrect. This is speculative and not the most popular theory.",
        "🛸 Correct! Green skin and large eyes are commonly depicted in popular culture."
      ]
    },
    {
      "question":
          "Will humans and extraterrestrials communicate easily if contact is made?",
      "options": [
        "A) Yes, they will understand each other perfectly",
        "B) No, communication may be challenging due to different languages and forms of communication",
        "C) Yes, they will use telepathy",
        "D) No, they will avoid communication altogether"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Perfect understanding is unlikely due to vast differences.",
        "🛸 Correct! Communication may be difficult due to language and cultural barriers.",
        " Incorrect. Telepathy is speculative and lacks scientific basis.",
        " Incorrect. Most theories suggest attempts at communication would occur."
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
              builder: (_) => const BlueCardDeckAnimation(
                  title: "The Star Beast", nextPage: BiographyReadingPage())),
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
                  "assets/Wallpapers/WallPaperReadingSpots/FONDO GOAL INSTRUCTION 3 Y stories.webp",
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
                        Color.fromARGB(255, 115, 215, 205), // teal suave
                        Color(0xFF264E82), // azul oscuro elegante
                      ],
                    ),
                  ),
                ),

// 🔹 SUAVIZAR FONDO GENERAL
                Container(
                  color: Colors.white.withOpacity(0.08),
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
                                                255, 12, 137, 193)
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
                                    const Color.fromARGB(255, 12, 137, 193),
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

// ══════════════════════════════════════════════════════════════════
//  BlueCardDeckAnimation
//  Pantalla de transición genérica con baraja de cartas animada.
//
//  USO:
//    BlueCardDeckAnimation(
//      title: "Tu titular aquí\nSegunda línea",
//      nextPage: TuSiguientePagina(),
//    )
// ══════════════════════════════════════════════════════════════════
class BlueCardDeckAnimation extends StatefulWidget {
  const BlueCardDeckAnimation({
    super.key,
    required this.title,
    required this.nextPage,
  });

  final String title;
  final Widget nextPage;

  @override
  State<BlueCardDeckAnimation> createState() => _BlueCardDeckAnimationState();
}

class _BlueCardDeckAnimationState extends State<BlueCardDeckAnimation>
    with TickerProviderStateMixin {
  // ── Controladores ────────────────────────────────────────────────
  late final AnimationController _masterCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _floatCtrl;
  late final AnimationController _shuffleCtrl;

  // ── Animations ───────────────────────────────────────────────────
  late final Animation<double> _bgFade;
  late final Animation<double> _deckScale;
  late final Animation<double> _deckReveal;
  late final Animation<double> _card1Fan;
  late final Animation<double> _card2Fan;
  late final Animation<double> _card3Fan;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _dotsScale;
  late final Animation<double> _exitFade;
  late final Animation<double> _glow;
  late final Animation<double> _floatY;
  late final Animation<double> _floatRot;
  late final Animation<double> _shimmer;

  // ── Paleta azul ───────────────────────────────────────────────────
  static const _bg1 = Color(0xFF010814);
  static const _bg2 = Color(0xFF010D1F);
  static const _bg3 = Color(0xFF01152E);
  static const _accent = Color(0xFF60A5FA); // blue-400
  static const _accent2 = Color(0xFF93C5FD); // blue-300
  static const _accent3 = Color(0xFFBFDBFE); // blue-200

  static const _cardBg = Color(0xFF0B1E3D);
  static const _cardBg2 = Color(0xFF0F2850);
  static const _cardBdr = Color(0xFF1E4080);
  static const _cardLight = Color(0xFF1A3870);
  static const _ink = Color(0xFFE0EEFF);

  // Colores de las cartas abanicadas
  static const _card1Color = Color(0xFF0E224A);
  static const _card2Color = Color(0xFF102960);
  static const _card3Color = Color(0xFF0A1D3E);

  @override
  void initState() {
    super.initState();

    _masterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    );

    _bgFade = CurvedAnimation(
      parent: _masterCtrl,
      curve: const Interval(0.0, 0.12, curve: Curves.easeIn),
    );

    _deckScale = Tween<double>(begin: 0.55, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.05, 0.28, curve: Curves.elasticOut),
      ),
    );

    _deckReveal = Tween<double>(begin: -0.10, end: 0.0).animate(
      CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.05, 0.32, curve: Curves.easeOutCubic),
      ),
    );

    // Fan-out de las cartas laterales
    _card1Fan = Tween<double>(begin: 0.0, end: -0.38).animate(
      CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.22, 0.50, curve: Curves.easeOutBack),
      ),
    );

    _card2Fan = Tween<double>(begin: 0.0, end: 0.38).animate(
      CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.25, 0.53, curve: Curves.easeOutBack),
      ),
    );

    _card3Fan = Tween<double>(begin: 0.0, end: -0.12).animate(
      CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.28, 0.48, curve: Curves.easeOut),
      ),
    );

    _titleFade = CurvedAnimation(
      parent: _masterCtrl,
      curve: const Interval(0.42, 0.62, curve: Curves.easeOut),
    );

    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _masterCtrl,
      curve: const Interval(0.42, 0.64, curve: Curves.easeOut),
    ));

    _dotsScale = CurvedAnimation(
      parent: _masterCtrl,
      curve: const Interval(0.58, 0.74, curve: Curves.elasticOut),
    );

    _exitFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _masterCtrl,
        curve: const Interval(0.83, 1.0, curve: Curves.easeIn),
      ),
    );

    // Glow pulsante
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _glow = Tween<double>(begin: 6, end: 24).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );

    // Float suave
    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3400),
    )..repeat(reverse: true);
    _floatY = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );
    _floatRot = Tween<double>(begin: -0.015, end: 0.015).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );

    // Shimmer en la carta central
    _shuffleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
    _shimmer = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _shuffleCtrl, curve: Curves.easeInOut),
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
    _shuffleCtrl.dispose();
    super.dispose();
  }

  // ── BUILD ────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge(
            [_masterCtrl, _glowCtrl, _floatCtrl, _shuffleCtrl]),
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
                        _buildDeck(),
                        const SizedBox(height: 36),
                        _buildTitle(),
                        const SizedBox(height: 22),
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
              center: const Alignment(0, -0.25),
              radius: 0.85,
              colors: [_accent.withOpacity(0.07), Colors.transparent],
            ),
          ),
        ),
      ),
    );
  }

  // ── PARTÍCULAS ───────────────────────────────────────────────────
  Widget _buildParticles() {
    const pts = [
      (0.08, 0.11, 3.0, 0.0),
      (0.85, 0.17, 4.0, 0.5),
      (0.17, 0.75, 3.0, 0.9),
      (0.79, 0.64, 5.0, 0.2),
      (0.53, 0.06, 3.0, 0.7),
      (0.04, 0.52, 3.0, 1.1),
      (0.92, 0.44, 4.0, 0.3),
      (0.42, 0.88, 3.0, 0.6),
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
                  color: _accent2.withOpacity(0.40),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ── BARAJA ───────────────────────────────────────────────────────
  Widget _buildDeck() {
    return Transform.translate(
      offset: Offset(0, _floatY.value),
      child: Transform.rotate(
        angle: _deckReveal.value + _floatRot.value,
        child: ScaleTransition(
          scale: _deckScale,
          child: SizedBox(
            width: 280,
            height: 210,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Carta izquierda (fan)
                _buildFanCard(
                  angle: _card1Fan.value,
                  offsetX: -68,
                  color: _card1Color,
                  suit: '♠',
                  rank: 'A',
                  isLeft: true,
                ),
                // Carta derecha (fan)
                _buildFanCard(
                  angle: _card2Fan.value,
                  offsetX: 68,
                  color: _card2Color,
                  suit: '♥',
                  rank: 'K',
                  isLeft: false,
                ),
                // Sombra del mazo (extra profundidad)
                Transform.translate(
                  offset: const Offset(4, 6),
                  child: _buildShadowDeck(),
                ),
                // Carta superior izquierda del mazo
                Transform.translate(
                  offset: const Offset(-1.5, -1.5),
                  child: _buildStackCard(color: _cardBg.withOpacity(0.7)),
                ),
                // Carta del mazo principal con shimmer
                _buildMainCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFanCard({
    required double angle,
    required double offsetX,
    required Color color,
    required String suit,
    required String rank,
    required bool isLeft,
  }) {
    return Transform.translate(
      offset: Offset(offsetX * 0.85, 10),
      child: Transform.rotate(
        angle: angle,
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 110,
          height: 160,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _cardBdr.withOpacity(0.8),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: _accent.withOpacity(0.10),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Patrón de fondo de la carta
              ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: CustomPaint(
                  size: const Size(110, 160),
                  painter: _CardPatternPainter(accentColor: _cardBdr),
                ),
              ),
              // Rank + suit esquina superior izq
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: isLeft
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    Text(
                      rank,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _accent2.withOpacity(0.9),
                        height: 1,
                      ),
                    ),
                    Text(
                      suit,
                      style: TextStyle(
                        fontSize: 14,
                        color: _accent.withOpacity(0.75),
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              // Suit central grande
              Center(
                child: Text(
                  suit,
                  style: TextStyle(
                    fontSize: 42,
                    color: _accent.withOpacity(0.18),
                  ),
                ),
              ),
              // Rank + suit esquina inferior der (invertido)
              Positioned(
                bottom: 8,
                right: 8,
                child: RotatedBox(
                  quarterTurns: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rank,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _accent2.withOpacity(0.9),
                          height: 1,
                        ),
                      ),
                      Text(
                        suit,
                        style: TextStyle(
                          fontSize: 14,
                          color: _accent.withOpacity(0.75),
                          height: 1,
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
    );
  }

  Widget _buildShadowDeck() {
    return Container(
      width: 130,
      height: 175,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        color: Colors.black.withOpacity(0.35),
      ),
    );
  }

  Widget _buildStackCard({required Color color}) {
    return Container(
      width: 130,
      height: 175,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _cardBdr.withOpacity(0.5), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: CustomPaint(
          painter: _CardBackPainter(
            accentColor: _cardBdr.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  Widget _buildMainCard() {
    return Container(
      width: 130,
      height: 175,
      decoration: BoxDecoration(
        color: _cardBg2,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _cardBdr, width: 1.4),
        boxShadow: [
          BoxShadow(
            color: _accent.withOpacity(_glow.value / 55),
            blurRadius: _glow.value * 2.2,
          ),
          const BoxShadow(
            color: Color(0x55000000),
            blurRadius: 10,
            offset: Offset(4, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: Stack(
          children: [
            // Patrón dorso
            CustomPaint(
              size: const Size(130, 175),
              painter: _CardBackPainter(accentColor: _cardLight),
            ),
            // Shimmer sweep
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _shimmer,
                builder: (_, __) {
                  return ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        begin: Alignment(_shimmer.value - 0.4, -0.5),
                        end: Alignment(_shimmer.value + 0.2, 0.5),
                        colors: [
                          Colors.transparent,
                          _accent3.withOpacity(0.12),
                          Colors.transparent,
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcOver,
                    child: Container(
                        color: const Color.fromARGB(255, 231, 231, 231)),
                  );
                },
              ),
            ),
            // Logo central
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    '✦',
                    style: TextStyle(
                      fontSize: 26,
                      color: _accent2.withOpacity(0.45),
                    ),
                  ),
                ],
              ),
            ),
            // Borde interior decorativo
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _accent.withOpacity(0.15),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
              color: const Color(0xFFEFF6FF),
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
//  CustomPainter: patrón dorso de carta (rombos / damero azul)
// ══════════════════════════════════════════════════════════════════
class _CardBackPainter extends CustomPainter {
  final Color accentColor;
  const _CardBackPainter({required this.accentColor});

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = accentColor
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    const step = 14.0;

    // Patrón de rombos
    for (double x = -step; x < size.width + step; x += step) {
      for (double y = -step; y < size.height + step; y += step) {
        final cx = x + (((y / step).floor() % 2) == 0 ? step / 2 : 0);
        final path = Path()
          ..moveTo(cx, y - step * 0.45)
          ..lineTo(cx + step * 0.45, y)
          ..lineTo(cx, y + step * 0.45)
          ..lineTo(cx - step * 0.45, y)
          ..close();
        canvas.drawPath(path, p);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CardBackPainter old) =>
      old.accentColor != accentColor;
}

// ══════════════════════════════════════════════════════════════════
//  CustomPainter: patrón frontal de cartas laterales
// ══════════════════════════════════════════════════════════════════
class _CardPatternPainter extends CustomPainter {
  final Color accentColor;
  const _CardPatternPainter({required this.accentColor});

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = accentColor.withOpacity(0.35)
      ..strokeWidth = 0.6
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    // Líneas diagonales finas
    const spacing = 10.0;
    for (double i = -size.height; i < size.width + size.height; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i + size.height, size.height), p);
    }
  }

  @override
  bool shouldRepaint(covariant _CardPatternPainter old) => false;
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

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final String biographyText = '''
The observation deck of the President Marcus was empty early in the ship’s artificial morning, except for two figures. One of them was dead.

The body lay sprawled on the curved deck, halfway between two entrance wells. It had arms and legs, though they were hidden under a tangle of clothes. The face was purple, and a gray beard covered the chin.

The other figure had no limbs or face. It was black and looked like a pile of mud—a five-foot lump, slightly flattened on the sides, with a cluster of short, black tentacles on top. It moved slightly, lowering the filaments toward the dead body, then flowed away again, pointing the filaments toward the stars.

Phil Horitz arrived at the forward end of the deck. He let the levitor push him gently out of the well, then stepped over to the glass wall and looked out at the tiny blue disk of Earth. His back was to the body and its watcher. He lit a cigarette, took a deep breath, and turned around.

He cursed and threw the cigarette away, jumping forward at the same time. He skidded to a stop in front of the body and knelt beside it. “Dead,” he said. “Oh, no.”

He quickly searched the body and found a flat metal box attached to a silver chain around the waist. He opened the box—it was empty.

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

  void _goToQuestions() {
    setState(() => animating = true);
    _fadeController.forward();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => QuestionPage(questions: sampleQuestions),
        ),
      );
    });
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
                                const Color.fromARGB(255, 12, 137, 193),
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
                          color: Color.fromARGB(255, 12, 137, 193)),
                      SizedBox(height: 16),
                      Text(
                        "Going to Questions...",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 12, 137, 193),
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
        'The observation deck of the President Marcus was empty early in the ship\'s artificial morning, except for two figures. One of them was dead.\n\nWhat does “them” refer to?',
    options: [
      "A) The entrance wells",
      "B) The stars outside the ship",
      "C) The two figures on the observation deck",
      "D) The crew members of the ship"
    ],
    correctIndex: 2,
    explanation:
        '“Them” refers to the two figures on the observation deck, one of whom is described as dead.',
    incorrectExplanations: [
      ' The entrance wells are not mentioned as figures.',
      ' The stars are not referred to as “them.”',
      ' Correct answer!',
      ' The crew members are not the two figures mentioned in the sentence.',
    ],
  ),
  QuestionData(
    question:
        'Phil Horitz arrived at the forward end of the deck. He let the levitor push him gently out of the well.\n\nWho does “he” refer to?',
    options: [
      "A) The dead man",
      "B) The black, tentacled figure",
      "C) A crew member nearby",
      "D) Phil Horitz"
    ],
    correctIndex: 3,
    explanation:
        '“He” refers to Phil Horitz, the character named in the preceding sentence who arrives on the deck and performs the actions described.',
    incorrectExplanations: [
      ' The dead man is not performing the action described.',
      ' The black, tentacled figure is not mentioned in this sentence.',
      ' A crew member nearby is not identified as the subject.',
      ' Correct answer!',
    ],
  ),
];

// Pantalla de preguntas con animación simple
class QuestionPage extends StatefulWidget {
  final List<QuestionData> questions;

  const QuestionPage({super.key, required this.questions});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int currentQuestionIndex = 0;
  int? selected;
  bool showFeedback = false;
  bool _isCorrect = false;
  String _feedbackText = '';

  static const Color accentDark = Color(0xFF1565C0);  // azul oscuro
  static const Color cardBg = Color(0xFFE3F2FD);      // azul muy claro

  void _submitAnswer() {
    final current = widget.questions[currentQuestionIndex];
    final isCorrect = selected == current.correctIndex;

    String explanationText;
    if (isCorrect) {
      explanationText = current.explanation;
    } else if (current.incorrectExplanations != null &&
        selected != null &&
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
      body: Stack(
        children: [
          // Fondo degradado azul
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                        Color.fromARGB(255, 115, 215, 205), // teal suave
                        Color(0xFF264E82), // azul oscuro elegante
                ],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Column(
                  key: ValueKey<int>(currentQuestionIndex),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    // Tarjeta de pregunta
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF42A5F5), // azul medio
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

                    const SizedBox(height: 10),

                    // Botones de opciones
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
                                  ? const Color(0xFF42A5F5) // azul medio
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

                    // Botón enviar o feedback
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E88E5), // azul botón
                            disabledBackgroundColor:
                                accentDark.withOpacity(0.35),
                            elevation: 4,
                            shadowColor: accentDark.withOpacity(0.4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
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
                      )
                    else
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
                              onPressed: _goNext,
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
        ],
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

class _BiographyReadingPageSecondState
    extends State<BiographyReadingPageSecond> {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  final String biographyTextSecond = '''
Horitz sighed and lifted the dead man’s chin. Under the beard was a deep red line around the throat.

He stood up and pressed a button on his wrist communicator. “Walsh, Sommers,” he said. “Get to the observation deck. Thomasson has been murdered.”

A deep voice swore loudly in his ear. Horitz didn’t wait for a response. He adjusted the communicator and said, “Captain Tooker, please. This is Philip Horitz.” A grumpy voice answered: “Yes, Horitz? What do you want?”

Horitz repeated his message and added, “I’m bringing the body to Thomasson’s room. Get the ship’s doctor and meet me there.”
''';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkScrollEnd);
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

  void _goToQuestions() {
    setState(() => animating = true);

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => QuestionPageSecond(questions: sampleQuestionsSecond),
        ),
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
                                const Color.fromARGB(255, 12, 137, 193),
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
                        color: Color.fromARGB(255, 12, 137, 193)),
                    SizedBox(height: 16),
                    Text(
                      "Going to Questions...",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 12, 137, 193),
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
        'Horitz sighed and lifted the dead man\'s chin (...) he pressed a button on his wrist communicator. "Walsh, Sommers," he said. "(...) Thomasson has been murdered."\n\nWho does “Thomasson” refer to?',
    options: [
      "A) The dead man",
      "B) One of Horitz's colleagues",
      "C) The ship's captain",
      "D) The ship's doctor"
    ],
    correctIndex: 0,
    explanation:
        '“Thomasson” refers to the man whose body Horitz examined on the observation deck, identified as the victim of the murder.',
    incorrectExplanations: [
      ' Correct answer!',
      ' Horitz’s colleagues are mentioned, but Thomasson is identified as the victim.',
      ' The ship’s captain is contacted later, not identified as the victim.',
      ' The ship’s doctor is not described as the murdered person.',
    ],
  ),
  QuestionData(
    question:
        'He adjusted the communicator and said, "Captain Tooker, please. This is Philip Horitz." A grumpy voice answered: "Yes, Horitz? What do you want?"\n\nWho does “a grumpy voice” refer to?',
    options: [
      "A) Walsh",
      "B) Sommers",
      "C) The ship's doctor",
      "D) Captain Tooker"
    ],
    correctIndex: 3,
    explanation:
        '“A grumpy voice” refers to Captain Tooker, who answers Horitz after being contacted through the wrist communicator.',
    incorrectExplanations: [
      ' Walsh is not the one who answers the communicator.',
      ' Sommers is not the one speaking in this moment.',
      ' The ship’s doctor is not mentioned as responding.',
      ' Correct answer!',
    ],
  ),
];

class QuestionPageSecond extends StatefulWidget {
  final List<QuestionData> questions;

  const QuestionPageSecond({super.key, required this.questions});

  @override
  State<QuestionPageSecond> createState() => _QuestionPageSecondState();
}

class _QuestionPageSecondState extends State<QuestionPageSecond> {
  int currentQuestionIndex = 0;
  int? selected;
  bool showFeedback = false;
  bool _isCorrect = false;
  String _feedbackText = '';

  static const Color accentDark = Color(0xFF1565C0);  // azul oscuro
  static const Color cardBg = Color(0xFFE3F2FD);      // azul muy claro

  void _submitAnswer() {
    final current = widget.questions[currentQuestionIndex];
    final isCorrect = selected == current.correctIndex;

    String explanationText;
    if (isCorrect) {
      explanationText = current.explanation;
    } else if (current.incorrectExplanations != null &&
        selected != null &&
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
      body: Stack(
        children: [
          // Fondo degradado azul
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                        Color.fromARGB(255, 115, 215, 205), // teal suave
                        Color(0xFF264E82), // azul oscuro elegante
                ],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Column(
                  key: ValueKey<int>(currentQuestionIndex),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    // Tarjeta de pregunta
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF42A5F5), // azul medio
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

                    const SizedBox(height: 10),

                    // Botones de opciones
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
                                  ? const Color(0xFF42A5F5) // azul medio
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

                    // Botón enviar o feedback
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E88E5), // azul botón
                            disabledBackgroundColor:
                                accentDark.withOpacity(0.35),
                            elevation: 4,
                            shadowColor: accentDark.withOpacity(0.4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
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
                      )
                    else
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
                              onPressed: _goNext,
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
        ],
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

class _BiographyReadingPageThirdState extends State<BiographyReadingPageThird> {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  final String biographyTextSecond = '''
Two figures burst out of the levitor well a dozen yards away—one large and gray-haired, the other slim and young. They ran to Horitz, breathing heavily. The large one, Walsh, was still swearing.

“I watched him like a baby,” Walsh protested. “He said he’d get up at nine, so I set my alarm for eight. Why did he—”

“Save it,” said Horitz. “He’s dead. I’ll take his head, Sommers, you take his feet. Walsh, can you carry Oscar?”

“Phil,” Sommers said suddenly, “are the Equations gone?”

“Yes,” Horitz replied. “They’re gone.”

Walsh grunted, bent down, and wrapped his arms around the black shape. He lifted it easily. The short filaments waved toward him, then straightened again, ignoring him. The other two picked up Thomasson’s body, and all three walked back to the levitor well.

Captain Tooker and the ship’s doctor, Dr. Evans, met them at the door of Thomasson’s room. Tooker was furious. “Do you call yourselves Security agents?” he shouted. “Three of you to protect one man, and you couldn’t do it. I’ll make sure everyone hears about this, Horitz.”
''';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkScrollEnd);
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

  void _goToQuestions() {
    setState(() => animating = true);

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => QuestionPageThird(questions: sampleQuestionsThird),
        ),
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
                                const Color.fromARGB(255, 12, 137, 193),
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
                        color: Color.fromARGB(255, 12, 137, 193)),
                    SizedBox(height: 16),
                    Text(
                      "Going to Questions...",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 12, 137, 193),
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
        '"Phil," Sommers said suddenly, "are the Equations gone?"\n"Yes," Horitz replied. "They\'re gone."\n\nWhat does “they” refer to?',
    options: [
      "A) Mathematical calculations made by Sommers",
      "B) Ship navigation formulas",
      "C) Thomasson's equations",
      "D) Security instructions from Captain Tooker"
    ],
    correctIndex: 2,
    explanation:
        '“They” refers to the equations, the valuable information associated with Thomasson, whose disappearance is linked to his murder.',
    incorrectExplanations: [
      ' Sommers is not described as creating the equations.',
      ' Navigation formulas are not mentioned in this context.',
      ' Correct answer!',
      ' Security instructions are not discussed here.',
    ],
  ),
  QuestionData(
    question:
        '"— Walsh, can you carry Oscar?\n— (...) Walsh grunted, bent down, and wrapped his arms around the black shape."\n\nWhat does “the black shape” refer to?',
    options: [
      "A) A pile of equipment",
      "B) A shadow on the floor",
      "C) Oscar, the black tentacled creature",
      "D) Thomasson's body"
    ],
    correctIndex: 2,
    explanation:
        '“The black shape” refers to Oscar, the black, tentacled being described earlier and identified as a distinct figure separate from Thomasson’s body.',
    incorrectExplanations: [
      ' A pile of equipment is not mentioned in the scene.',
      ' A shadow on the floor is not identified as a character.',
      ' Correct answer!',
      ' Thomasson’s body is a different figure and not the one being carried.',
    ],
  ),
];

class QuestionPageThird extends StatefulWidget {
  final List<QuestionData> questions;

  const QuestionPageThird({super.key, required this.questions});

  @override
  State<QuestionPageThird> createState() => _QuestionPageThirdState();
}

class _QuestionPageThirdState extends State<QuestionPageThird> {
  int currentQuestionIndex = 0;
  int? selected;
  bool showFeedback = false;
  bool _isCorrect = false;
  String _feedbackText = '';

  static const Color accentDark = Color(0xFF1565C0);  // azul oscuro
  static const Color cardBg = Color(0xFFE3F2FD);      // azul muy claro

  void _submitAnswer() {
    final current = widget.questions[currentQuestionIndex];
    final isCorrect = selected == current.correctIndex;

    String explanationText;
    if (isCorrect) {
      explanationText = current.explanation;
    } else if (current.incorrectExplanations != null &&
        selected != null &&
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
        MaterialPageRoute(builder: (_) => BiographyReadingPageFinal()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      body: Stack(
        children: [
          // Fondo degradado azul
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                        Color.fromARGB(255, 115, 215, 205), // teal suave
                        Color(0xFF264E82), // azul oscuro elegante
                ],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Column(
                  key: ValueKey<int>(currentQuestionIndex),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    // Tarjeta de pregunta
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF42A5F5), // azul medio
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

                    const SizedBox(height: 10),

                    // Botones de opciones
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
                                  ? const Color(0xFF42A5F5) // azul medio
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

                    // Botón enviar o feedback
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E88E5), // azul botón
                            disabledBackgroundColor:
                                accentDark.withOpacity(0.35),
                            elevation: 4,
                            shadowColor: accentDark.withOpacity(0.4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
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
                      )
                    else
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
                              onPressed: _goNext,
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
        ],
      ),
    );
  }
}

class BiographyReadingPageFinal extends StatefulWidget {
  const BiographyReadingPageFinal({super.key});

  @override
  State<BiographyReadingPageFinal> createState() =>
      _BiographyReadingPageFinalState();
}

class _BiographyReadingPageFinalState extends State<BiographyReadingPageFinal> {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  final String biographyTextSecond = '''
Horitz and Sommers placed the body on the bed, and Dr. Evans began examining it. “We’ll find the killer,” Horitz said firmly, “or any trouble you cause will be nothing compared to what’s coming. You don’t know the half of this yet.”

“I know a man was murdered on my ship,” said Tooker.

“A man!” said Sommers, staring at him. “A whole planet might be in danger unless we get the Equations back.”

“What equations?” said Tooker. “What are you talking about?”

“The Thomasson Equations,” said Sommers, “are the key to faster-than-light space travel. Professor Thomasson created them from observations he made on the space shell that Oscar arrived in last year.”

Captain Tooker glanced at Oscar with dislike. “Well,” he said, “what are you going to do about it?”

“Search the ship,” said Horitz calmly, “but that won’t help. There are a hundred ways to hide the Equations. Our only chance is to get the only witness to tell us who killed Thomasson.”

“The witness?” said the captain, confused. “Who?”

Horitz turned to the black, five-foot lump with its waving filaments. “Oscar,” he said.

Oscar had arrived almost a year ago, spinning out of interstellar space in a thin, cloudy shell. The shell was damaged and out of control, but a supply ship found it and brought it to Pluto. Scientists had studied Oscar for a year but learned very little. He had no eyes, ears, or brain, yet he was aware of his surroundings. He had no lungs, no skeleton, and no way to remove waste. He seemed to get energy from cosmic radiation, but no one was sure.
''';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkScrollEnd);
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

  void _goToQuestions() {
    setState(() => animating = true);

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => QuestionPageFinal(questions: sampleQuestionsFinal),
        ),
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
                                const Color.fromARGB(255, 12, 137, 193),
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
                        color: Color.fromARGB(255, 12, 137, 193)),
                    SizedBox(height: 16),
                    Text(
                      "Going to Questions...",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 12, 137, 193),
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

final List<QuestionData> sampleQuestionsFinal = [
  QuestionData(
    question:
        '"The witness?" said the captain, confused. "Who?"\nHoritz turned to the black, five-foot lump with its waving filaments. "Oscar," he said.\n\nWho does “the witness” refer to?',
    options: [
      "A) Captain Tooker",
      "B) Sommers",
      "C) Oscar",
      "D) The supply ship"
    ],
    correctIndex: 2,
    explanation:
        '“The witness” is an anaphoric reference to Oscar, the alien figure who was present at the time of the murder. Horitz clarifies this by turning to Oscar and naming him directly.',
    incorrectExplanations: [
      ' Captain Tooker is asking the question and is not the witness.',
      ' Sommers is present but not identified as the witness.',
      ' Correct answer!',
      ' The supply ship is not a character in the scene.',
    ],
  ),
  QuestionData(
    question:
        '"The witness?" said the captain, confused. "Who?"\nHoritz turned to the black, five-foot lump with its waving filaments. "Oscar," he said.\n\nWho does “he” refer to?',
    options: ["A) Thomasson", "B) Captain Tooker", "C) Oscar", "D) Horitz"],
    correctIndex: 3,
    explanation:
        '“He” refers to Horitz, who speaks and identifies Oscar as the witness.',
    incorrectExplanations: [
      ' Thomasson is not speaking in this moment.',
      ' Captain Tooker is asking the question, not answering it.',
      ' Oscar is being identified, not the speaker.',
      ' Correct answer!',
    ],
  ),
];

class QuestionPageFinal extends StatefulWidget {
  final List<QuestionData> questions;

  const QuestionPageFinal({super.key, required this.questions});

  @override
  State<QuestionPageFinal> createState() => _QuestionPageFinalState();
}

class _QuestionPageFinalState extends State<QuestionPageFinal> {
  int currentQuestionIndex = 0;
  int? selected;
  bool showFeedback = false;
  bool _isCorrect = false;
  String _feedbackText = '';

  static const Color accentDark = Color(0xFF1565C0);  // azul oscuro
  static const Color cardBg = Color(0xFFE3F2FD);      // azul muy claro

  void _submitAnswer() {
    final current = widget.questions[currentQuestionIndex];
    final isCorrect = selected == current.correctIndex;

    String explanationText;
    if (isCorrect) {
      explanationText = current.explanation;
    } else if (current.incorrectExplanations != null &&
        selected != null &&
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
      body: Stack(
        children: [
          // Fondo degradado azul
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                        Color.fromARGB(255, 115, 215, 205), // teal suave
                        Color(0xFF264E82), // azul oscuro elegante
                ],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Column(
                  key: ValueKey<int>(currentQuestionIndex),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    // Tarjeta de pregunta
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF42A5F5), // azul medio
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

                    const SizedBox(height: 10),

                    // Botones de opciones
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
                                  ? const Color(0xFF42A5F5) // azul medio
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

                    // Botón enviar o feedback
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E88E5), // azul botón
                            disabledBackgroundColor:
                                accentDark.withOpacity(0.35),
                            elevation: 4,
                            shadowColor: accentDark.withOpacity(0.4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
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
                      )
                    else
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
                              onPressed: _goNext,
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
        ],
      ),
    );
  }
}