// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Blue/Content/Spot3/Spot_Page/ReadingSpot.dart';

import 'dart:math' as math;

class DillSplashScreen extends StatefulWidget {
  const DillSplashScreen({super.key});

  @override
  State<DillSplashScreen> createState() => _DillSplashScreenState();
}

class _DillSplashScreenState extends State<DillSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _bgCtrl;
  late AnimationController _iconCtrl;
  late AnimationController _mugFloatCtrl;
  late AnimationController _glowCtrl;
  late AnimationController _steam1Ctrl;
  late AnimationController _steam2Ctrl;
  late AnimationController _steam3Ctrl;
  late AnimationController _orbit1Ctrl;
  late AnimationController _orbit2Ctrl;
  late AnimationController _orbit3Ctrl;
  late AnimationController _starsCtrl;
  late AnimationController _shootCtrl;
  late AnimationController _textCtrl;

  late Animation<double> _bgFade;
  late Animation<double> _iconScale;
  late Animation<double> _iconY;
  late Animation<double> _mugFloatY;
  late Animation<double> _innerGlow;
  late Animation<double> _outerGlow;

  // Steam: progress 0→1, fades out at top
  late Animation<double> _steam1T;
  late Animation<double> _steam2T;
  late Animation<double> _steam3T;

  late Animation<double> _titleOpacity, _titleSlide;
  late Animation<double> _authorOpacity;
  late Animation<double> _dividerOpacity, _dividerScale;

  final List<Animation<double>> _starAnim = [];

  static const List<List<double>> _stars = [
    [.07, .03, 1.0, 2.2, .0, 0],
    [.28, .05, 1.0, 2.9, .3, 0],
    [.52, .02, .75, 2.5, .6, 0],
    [.76, .04, 1.25, 2.0, .9, 0],
    [.92, .08, .75, 3.1, .2, 0],
    [.14, .12, .75, 2.7, .5, 0],
    [.44, .10, .50, 2.3, 1.0, 0],
    [.65, .07, 1.0, 3.3, .7, 0],
    [.85, .15, .50, 2.1, .4, 0],
    [.05, .18, 1.0, 2.8, 1.2, 0],
    [.38, .20, .75, 2.4, .8, 0],
    [.72, .22, .75, 3.0, .3, 0],
    [.95, .25, .50, 1.9, 1.1, 0],
    [.04, .60, .75, 2.6, .6, 0],
    [.25, .64, 1.0, 2.2, .9, 0],
    [.58, .68, .50, 3.2, .4, 0],
    [.82, .72, 1.0, 2.0, 1.3, 0],
    [.42, .76, .50, 2.9, .7, 0],
    [.16, .80, .75, 2.5, .2, 0],
    [.68, .85, .50, 2.7, 1.0, 0],
    [.90, .89, .75, 3.1, .5, 0],
    [.33, .93, .50, 2.3, .8, 0],
    [.36, .06, 4.5, 2.6, .4, 1],
    [.91, .18, 3.5, 3.0, .9, 1],
    [.12, .76, 4.0, 2.8, 1.2, 1],
  ];

  static const List<List<double>> _shoots = [
    [.09, .12, 100, 2.0],
    [.28, .06, 65, 7.0],
  ];

  // ring, offsetDeg, radius, starR
  static const List<List<double>> _orbitStars = [
    [1, 0, 74, 2.5],
    [1, 90, 74, 2.0],
    [1, 180, 74, 2.5],
    [1, 270, 74, 2.0],
    [2, 0, 84, 2.0],
    [2, 72, 84, 1.5],
    [2, 144, 84, 2.5],
    [2, 216, 84, 1.5],
    [2, 288, 84, 2.0],
    [3, 0, 55, 3.0],
    [3, 120, 55, 2.0],
    [3, 240, 55, 2.5],
  ];

  @override
  void initState() {
    super.initState();

    // BG
    _bgCtrl = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    _bgFade = CurvedAnimation(parent: _bgCtrl, curve: Curves.easeOut);
    _bgCtrl.forward();

    // Icon entrance
    _iconCtrl = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _iconScale = Tween<double>(begin: .4, end: 1.0)
        .animate(CurvedAnimation(parent: _iconCtrl, curve: Curves.elasticOut));
    _iconY = Tween<double>(begin: 18, end: 0)
        .animate(CurvedAnimation(parent: _iconCtrl, curve: Curves.easeOut));
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _iconCtrl.forward();
    });

    // Mug float
    _mugFloatCtrl = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this)
      ..repeat(reverse: true);
    _mugFloatY = Tween<double>(begin: 0, end: -6).animate(
        CurvedAnimation(parent: _mugFloatCtrl, curve: Curves.easeInOut));

    // Glow
    _glowCtrl = AnimationController(
        duration: const Duration(milliseconds: 3500), vsync: this)
      ..repeat(reverse: true);
    _innerGlow = Tween<double>(begin: .16, end: .38)
        .animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));
    _outerGlow = Tween<double>(begin: .10, end: .22)
        .animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));

    // Steam — each loops at different duration, delay via initial value
    _steam1Ctrl = AnimationController(
        duration: const Duration(milliseconds: 2200), vsync: this)
      ..repeat();
    _steam1T = CurvedAnimation(parent: _steam1Ctrl, curve: Curves.easeOut);

    _steam2Ctrl = AnimationController(
        duration: const Duration(milliseconds: 2600), vsync: this)
      ..repeat();
    _steam2T = CurvedAnimation(parent: _steam2Ctrl, curve: Curves.easeOut);
    _steam2Ctrl.value = .4 / 2.6; // offset delay

    _steam3Ctrl = AnimationController(
        duration: const Duration(milliseconds: 2400), vsync: this)
      ..repeat();
    _steam3T = CurvedAnimation(parent: _steam3Ctrl, curve: Curves.easeOut);
    _steam3Ctrl.value = .8 / 2.4; // offset delay

    // Orbits
    _orbit1Ctrl = AnimationController(
        duration: const Duration(milliseconds: 8000), vsync: this)
      ..repeat();
    _orbit2Ctrl = AnimationController(
        duration: const Duration(milliseconds: 13000), vsync: this)
      ..repeat();
    _orbit3Ctrl = AnimationController(
        duration: const Duration(milliseconds: 18000), vsync: this)
      ..repeat();

    // Stars
    _starsCtrl = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this)
      ..repeat();
    for (int i = 0; i < _stars.length; i++) {
      final delay = _stars[i][4];
      _starAnim.add(Tween<double>(begin: .85, end: .08).animate(
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

    // Text
    _textCtrl = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    _titleOpacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut));
    _titleSlide = Tween<double>(begin: 16, end: 0)
        .animate(CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut));
    _authorOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _textCtrl,
        curve: const Interval(.4, 1.0, curve: Curves.easeOut)));
    _dividerOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _textCtrl,
        curve: const Interval(.0, .6, curve: Curves.easeOut)));
    _dividerScale = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _textCtrl,
        curve: const Interval(.0, .6, curve: Curves.easeOut)));
    Future.delayed(const Duration(milliseconds: 750), () {
      if (mounted) _textCtrl.forward();
    });

    // Navigate
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Dill()));
    });
  }

  @override
  void dispose() {
    _bgCtrl.dispose();
    _iconCtrl.dispose();
    _mugFloatCtrl.dispose();
    _glowCtrl.dispose();
    _steam1Ctrl.dispose();
    _steam2Ctrl.dispose();
    _steam3Ctrl.dispose();
    _orbit1Ctrl.dispose();
    _orbit2Ctrl.dispose();
    _orbit3Ctrl.dispose();
    _starsCtrl.dispose();
    _shootCtrl.dispose();
    _textCtrl.dispose();
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
              center: Alignment(-.4, -.3),
              radius: 1.4,
              colors: [
                Color(0xFF080F1E),
                Color(0xFF040A18),
                Color(0xFF020610),
                Color(0xFF010306),
              ],
              stops: [0.0, .45, .75, 1.0],
            ),
          ),
          child: Stack(children: [
            // Milky Way
            Positioned.fill(
              child: Transform.rotate(
                angle: -16 * math.pi / 180,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Color(0x05142878),
                        Color(0x081E3CA0),
                        Color(0x05142878),
                        Colors.transparent,
                      ],
                      stops: [0.0, .20, .38, .60, 1.0],
                    ),
                  ),
                ),
              ),
            ),

            // Nebulae
            _DillNebula(
                color: const Color(0xFF0A1964),
                alignment: const Alignment(-1.0, -.85),
                size: 400),
            _DillNebula(
                color: const Color(0xFF052882),
                alignment: const Alignment(1.0, .80),
                size: 300,
                delay: 2000),
            _DillNebula(
                color: const Color(0xFF140A78),
                alignment: const Alignment(.80, .20),
                size: 220,
                delay: 4000),

            // Star field
            AnimatedBuilder(
              animation: Listenable.merge([_starsCtrl, _shootCtrl]),
              builder: (_, __) => CustomPaint(
                painter: _DillStarPainter(
                  stars: _stars,
                  starOpacities:
                      List.generate(_stars.length, (i) => _starAnim[i].value),
                  shootT: _shootCtrl.value,
                  shoots: _shoots,
                  canvasSize: size,
                ),
                size: size,
              ),
            ),

            // Floating particles
            _DillParticle(
                xF: .18, yF: .20, sz: 5, shape: 0, durMs: 3400, delayMs: 0),
            _DillParticle(
                xF: .84, yF: .22, sz: 4, shape: 1, durMs: 2900, delayMs: 500),
            _DillParticle(
                xF: .11, yF: .43, sz: 3, shape: 0, durMs: 4000, delayMs: 900),
            _DillParticle(
                xF: .87, yF: .41, sz: 4, shape: 1, durMs: 3100, delayMs: 300),
            _DillParticle(
                xF: .22, yF: .27, sz: 5, shape: 2, durMs: 3600, delayMs: 700),
            _DillParticle(
                xF: .80, yF: .38, sz: 4, shape: 3, durMs: 2800, delayMs: 1100),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Mug icon
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _iconCtrl,
                      _mugFloatCtrl,
                      _glowCtrl,
                      _steam1Ctrl,
                      _steam2Ctrl,
                      _steam3Ctrl,
                      _orbit1Ctrl,
                      _orbit2Ctrl,
                      _orbit3Ctrl,
                    ]),
                    builder: (_, __) {
                      final floatY = _iconCtrl.isCompleted
                          ? _mugFloatY.value
                          : _iconY.value;
                      return Transform.translate(
                        offset: Offset(0, floatY),
                        child: Transform.scale(
                          scale: _iconScale.value,
                          child: SizedBox(
                            width: 180,
                            height: 200,
                            child: CustomPaint(
                              painter: _DillMugPainter(
                                innerGlow: _innerGlow.value,
                                outerGlow: _outerGlow.value,
                                steam1T: _steam1T.value,
                                steam2T: _steam2T.value,
                                steam3T: _steam3T.value,
                                orbit1T: _orbit1Ctrl.value,
                                orbit2T: _orbit2Ctrl.value,
                                orbit3T: _orbit3Ctrl.value,
                                orbitStars: _orbitStars,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 38),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: ShaderMask(
                                    shaderCallback: (bounds) =>
                                        const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFFD0E8FF),
                                        Color(0xFF7AB0F0),
                                        Color(0xFF2858C8),
                                      ],
                                      stops: [0.0, .38, 1.0],
                                    ).createShader(bounds),
                                    child: const FaIcon(
                                      FontAwesomeIcons.mugHot,
                                      size: 82,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
                          child: Row(children: [
                            Expanded(
                                child: Container(
                                    height: 1,
                                    color: const Color(0xFF5090FF)
                                        .withOpacity(.40))),
                            const SizedBox(width: 8),
                            const Icon(Icons.star_rounded,
                                color: Color(0xFF64A0FF), size: 14),
                            const SizedBox(width: 8),
                            Expanded(
                                child: Container(
                                    height: 1,
                                    color: const Color(0xFF5090FF)
                                        .withOpacity(.40))),
                          ]),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Title
                  AnimatedBuilder(
                    animation: _textCtrl,
                    builder: (_, __) => Transform.translate(
                      offset: Offset(0, _titleSlide.value),
                      child: Opacity(
                        opacity: _titleOpacity.value,
                        child: Text(
                          'A Dill Pickle',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFE0EEFF),
                            letterSpacing: .5,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Author
                  AnimatedBuilder(
                    animation: _textCtrl,
                    builder: (_, __) => Opacity(
                      opacity: _authorOpacity.value,
                      child: Text(
                        'By Katherine Mansfield, 1917',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: const Color(0xFF8CB4FF).withOpacity(.65),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Author
                  AnimatedBuilder(
                    animation: _textCtrl,
                    builder: (_, __) => Opacity(
                      opacity: _authorOpacity.value,
                      child: Text(
                        'From AmericanLiterature.com',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: const Color(0xFF8CB4FF).withOpacity(.65),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

// ─── Mug + Steam + Orbit painter ──────────────────────────────────────
class _DillMugPainter extends CustomPainter {
  final double innerGlow, outerGlow;
  final double steam1T, steam2T, steam3T;
  final double orbit1T, orbit2T, orbit3T;
  final List<List<double>> orbitStars;

  const _DillMugPainter({
    required this.innerGlow,
    required this.outerGlow,
    required this.steam1T,
    required this.steam2T,
    required this.steam3T,
    required this.orbit1T,
    required this.orbit2T,
    required this.orbit3T,
    required this.orbitStars,
  });

  // Map from 180×200 viewBox to canvas
  Offset p(Size s, double x, double y) =>
      Offset(x / 180 * s.width, y / 200 * s.height);
  double sc(Size s, double v) => v / 180 * s.width;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    // ignore: unused_local_variable
    final cy = size.height / 2; // ~100 = 105 in 200px
    final scl = size.width / 180;

    // ── GLOWS ─────────────────────────────────────────────────────
    canvas.drawCircle(
        Offset(cx, p(size, 0, 105).dy),
        82 * scl,
        Paint()
          ..shader = RadialGradient(colors: [
            const Color(0xFF4080FF).withOpacity(outerGlow),
            const Color(0xFF4080FF).withOpacity(0),
          ]).createShader(Rect.fromCircle(
              center: Offset(cx, p(size, 0, 105).dy), radius: 82 * scl)));

    canvas.drawCircle(
        Offset(cx, p(size, 0, 105).dy),
        58 * scl,
        Paint()
          ..shader = RadialGradient(colors: [
            const Color(0xFF2060FF).withOpacity(innerGlow),
            const Color(0xFF1040CC).withOpacity(innerGlow * .2),
            const Color(0xFF1040CC).withOpacity(0),
          ], stops: const [
            0.0,
            .55,
            1.0
          ]).createShader(Rect.fromCircle(
              center: Offset(cx, p(size, 0, 105).dy), radius: 58 * scl)));

    // ── ORBITING STARS ────────────────────────────────────────────
    final orbCy = p(size, 0, 105).dy;
    for (final os in orbitStars) {
      final ring = os[0].toInt();
      final offsetDeg = os[1];
      final radius = os[2] * scl;
      final starR = os[3] * scl;
      final t = ring == 1
          ? orbit1T
          : ring == 2
              ? orbit2T
              : orbit3T;

      final tiltRad = ring == 2
          ? 20 * math.pi / 180
          : ring == 3
              ? -30 * math.pi / 180
              : 0.0;

      final angleRad = (offsetDeg + t * 360) * math.pi / 180;
      final rawX = math.cos(angleRad) * radius;
      final rawY = math.sin(angleRad) * radius * math.cos(tiltRad);
      final pop = .7 + .3 * math.sin(angleRad * 2 + t * math.pi * 2).abs();

      canvas.drawCircle(
        Offset(cx + rawX, orbCy + rawY),
        starR * pop,
        Paint()..color = const Color(0xFF8CC8FF).withOpacity(.78 * pop),
      );

      if ((ring == 1 || ring == 2) && offsetDeg == 0) {
        final arm = starR * 1.8 * pop;
        final sx = cx + rawX;
        final sy = orbCy + rawY;
        final sp = Paint()
          ..color = const Color(0xFFB4E0FF)
              .withOpacity(ring == 1 ? .80 * pop : .70 * pop)
          ..strokeWidth = 1.0
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(Offset(sx - arm, sy), Offset(sx + arm, sy), sp);
        canvas.drawLine(Offset(sx, sy - arm), Offset(sx, sy + arm), sp);
      }
    }

    // ── STEAM WISPS ───────────────────────────────────────────────
    // Steam top of mug is around y=58 in 200px space
    // Each wiper draws a wavy path that rises as T goes 0→1
    // opacity fades: 0→0.2 ramp up, 0.2→0.8 full, 0.8→1 fade out
    _drawSteam(canvas, size, steam1T,
        baseX: 72, baseY: 58, ctrlDx: -4, amplitude: 5);
    _drawSteam(canvas, size, steam2T,
        baseX: 90, baseY: 55, ctrlDx: 0, amplitude: 4);
    _drawSteam(canvas, size, steam3T,
        baseX: 108, baseY: 58, ctrlDx: 4, amplitude: 5);
  }

  void _drawSteam(
    Canvas canvas,
    Size size,
    double t, {
    required double baseX,
    required double baseY,
    required double ctrlDx,
    required double amplitude,
  }) {
    // t: 0=bottom (at mug), 1=top (fully risen & faded)
    final totalRise = sc(size, 40); // total distance steam rises
    final yOffset = t * totalRise;

    // Opacity: fade in 0→0.2, full 0.2→0.7, fade out 0.7→1.0
    final opacity = t < .2
        ? t / .2
        : t > .7
            ? (1.0 - t) / .3
            : 1.0;
    if (opacity <= 0) return;

    // Wavy path: quadratic bezier
    final startX = p(size, baseX, baseY).dx;
    final startY = p(size, baseX, baseY).dy - yOffset * .2;
    final endY = startY - totalRise * .8;
    final ctrlX =
        startX + sc(size, ctrlDx + amplitude * math.sin(t * math.pi * 2));
    final ctrlY = (startY + endY) / 2;

    final path = Path()
      ..moveTo(startX, startY)
      ..quadraticBezierTo(ctrlX, ctrlY, startX, endY);

    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFFA0C8FF).withOpacity(opacity * .55)
        ..strokeWidth = sc(size, 2.0)
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant _DillMugPainter o) =>
      o.innerGlow != innerGlow ||
      o.outerGlow != outerGlow ||
      o.steam1T != steam1T ||
      o.steam2T != steam2T ||
      o.steam3T != steam3T ||
      o.orbit1T != orbit1T ||
      o.orbit2T != orbit2T ||
      o.orbit3T != orbit3T;
}

// ─── Nebula ───────────────────────────────────────────────────────────
class _DillNebula extends StatefulWidget {
  final Color color;
  final Alignment alignment;
  final double size;
  final int delay;
  const _DillNebula(
      {required this.color,
      required this.alignment,
      required this.size,
      this.delay = 0});
  @override
  State<_DillNebula> createState() => _DillNebulaState();
}

class _DillNebulaState extends State<_DillNebula>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _opacity, _scale;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(
        duration: const Duration(milliseconds: 9000), vsync: this)
      ..repeat(reverse: true);
    _opacity = Tween<double>(begin: .08, end: .18)
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
                  gradient: RadialGradient(colors: [
                    widget.color.withOpacity(1),
                    widget.color.withOpacity(0),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Floating particle ────────────────────────────────────────────────
class _DillParticle extends StatefulWidget {
  final double xF, yF, sz;
  final int shape, durMs, delayMs;
  const _DillParticle(
      {required this.xF,
      required this.yF,
      required this.sz,
      required this.shape,
      required this.durMs,
      required this.delayMs});
  @override
  State<_DillParticle> createState() => _DillParticleState();
}

class _DillParticleState extends State<_DillParticle>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<Offset> _pos;
  static const _offsets = [
    Offset(-8, -12),
    Offset(9, -8),
    Offset(-6, 10),
    Offset(8, 8),
  ];
  @override
  void initState() {
    super.initState();
    _c = AnimationController(
        duration: Duration(milliseconds: widget.durMs), vsync: this)
      ..repeat(reverse: true);
    _pos = Tween<Offset>(
      begin: Offset.zero,
      end: _offsets[widget.shape % _offsets.length],
    ).animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));
    if (widget.delayMs > 0) {
      _c.value = (widget.delayMs / widget.durMs).clamp(0.0, 1.0);
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Positioned(
      left: widget.xF * s.width,
      top: widget.yF * s.height,
      child: AnimatedBuilder(
        animation: _c,
        builder: (_, __) => Transform.translate(
          offset: _pos.value,
          child: widget.shape >= 2
              ? Transform.rotate(
                  angle: math.pi / 4,
                  child: Container(
                    width: widget.sz,
                    height: widget.sz,
                    color: const Color(0xFF3264C8).withOpacity(.25),
                  ),
                )
              : Container(
                  width: widget.sz,
                  height: widget.sz,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF3264C8).withOpacity(.38),
                  ),
                ),
        ),
      ),
    );
  }
}

// ─── Star field + shooting stars ─────────────────────────────────────
class _DillStarPainter extends CustomPainter {
  final List<List<double>> stars;
  final List<double> starOpacities;
  final double shootT;
  final List<List<double>> shoots;
  final Size canvasSize;

  const _DillStarPainter({
    required this.stars,
    required this.starOpacities,
    required this.shootT,
    required this.shoots,
    required this.canvasSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < stars.length; i++) {
      final s = stars[i];
      final x = s[0] * size.width;
      final y = s[1] * size.height;
      final r = s[2];
      final op = starOpacities[i].clamp(0.0, 1.0);

      if (s[5].toInt() == 0) {
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

    for (final sh in shoots) {
      final delay = sh[3];
      const cycle = 5.0;
      final elapsed = (shootT * cycle * shoots.length) % cycle;
      if (elapsed < delay || elapsed > delay + 1.5) continue;

      final prog = ((elapsed - delay) / 1.5).clamp(0.0, 1.0);
      final sx = size.width * (1.0 - sh[1]);
      final sy = size.height * sh[0];
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
            const Color(0xFF96C8FF).withOpacity(op * .90),
            const Color(0xFF96C8FF).withOpacity(op * .35),
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
  bool shouldRepaint(covariant _DillStarPainter o) =>
      o.shootT != shootT || o.starOpacities != starOpacities;
}

class Dill extends StatefulWidget {
  const Dill({super.key});
  @override
  State<Dill> createState() => _DillState();
}

class _DillState extends State<Dill> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "Why do people often break up?",
      "options": [
        "A) Not enough travel",
        "B) Spending too much time together",
        "C) Too much fun",
        "D) Lack of communication"
      ],
      "correct": 3,
      "feedback": [
        " Not enough travel is not typically a main cause of breakups.",
        " Spending too much time together can cause stress, but it's not the most cited reason.",
        " Too much fun isn’t generally a cause for breaking up.",
        "💬 Correct! One of the most common reasons for breakups is poor communication, which can lead to misunderstandings and emotional distance."
      ]
    },
    {
      "question":
          "What physical reaction might you experience when you see your ex unexpectedly?",
      "options": [
        "A) Tiredness",
        "B) Sweating or clammy hands",
        "C) Smiling uncontrollably",
        "D) Stomach growling"
      ],
      "correct": 1,
      "feedback": [
        " Tiredness is not a typical sudden physical reaction to emotional triggers.",
        "💦 Correct! Anxiety or stress can cause sweating, especially in situations where emotions are involved.",
        " Smiling uncontrollably is not a common anxiety reaction.",
        " Stomach growling is related to hunger, not emotion."
      ]
    },
    {
      "question":
          "Which of the following might you feel in your stomach when seeing your ex?",
      "options": [
        "A) Hunger",
        "B) Butterflies or nervousness",
        "C) Thirst",
        "D) Nausea from excitement"
      ],
      "correct": 1,
      "feedback": [
        " Hunger is unrelated to emotional nervousness.",
        "🦋 Correct! The 'butterflies in the stomach' feeling is often caused by nervousness or excitement when seeing someone emotionally significant.",
        " Thirst is not typically a nervous stomach sensation.",
        " Nausea can occur from strong emotions, but 'butterflies' is the more accurate choice here."
      ]
    },
    {
      "question":
          "If you feel your body tense up when seeing your ex, what could this be a sign of?",
      "options": [
        "A) Calmness",
        "B) Emotional discomfort",
        "C) Physical exhaustion",
        "D) Happiness"
      ],
      "correct": 1,
      "feedback": [
        " Calmness would not cause tension.",
        "😬 Correct! Muscle tension is a common response to anxiety, discomfort, or emotional distress.",
        " Physical exhaustion doesn’t typically cause immediate tension in a social situation.",
        " Happiness would likely result in relaxation, not tension."
      ]
    },
    {
      "question": "Would you consider going on a date with your ex?",
      "options": [
        "A) Yes, if we’re friends",
        "B) No, it’s too complicated",
        "C) Yes, to get back together",
        "D) No, I’m still upset"
      ],
      "correct": 0,
      "feedback": [
        "💬 Correct! Many people are open to maintaining a friendship with an ex, as long as there is no romantic tension or unresolved feelings.",
        " Some may find it complicated, but friendship can still make it possible.",
        " Reuniting romantically isn’t always the healthiest motivation for a date.",
        " If you're still upset, it may not be the right time—but it's not the most balanced option here."
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
                  title: "A dill pickle", nextPage: BiographyReadingPage())),
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
After six years, she saw him again. He was sitting at a small bamboo table with a Japanese vase and paper daffodils. In front of him was a plate of fruit, and he was peeling an orange carefully, in a way she remembered well.

He must have felt her looking at him because he raised his head and their eyes met. But he didn’t recognize her! She smiled; he looked confused. She walked toward him. He closed his eyes for a moment, then opened them and his face lit up like a match in a dark room. He put down the orange, stood up, and she took her hand out of her muff to shake his.

“Vera!” he said. “How strange! For a moment, I didn’t recognize you. Please, sit down. Have you had lunch? Would you like some coffee?”

She hesitated but said, “Yes, I’d like some coffee.” She sat down across from him.

“You’ve changed,” he said, looking at her closely. “You look very well. I’ve never seen you look so well.”

“Really?” She lifted her veil and opened her fur collar. “I don’t feel well. I hate this cold weather.”

“Ah, yes. You’ve always hated the cold.”

“I can’t stand it,” she said, shivering. “And it gets worse as you get older…”

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
        'What does the phrase “his face lit up” most likely mean in the sentence below?\n\n*“He closed his eyes for a moment, then opened them and his face lit up like a match in a dark room.”*',
    options: [
      "A) He became very angry",
      "B) He fell asleep",
      "C) He turned red",
      "D) He smiled or looked happy"
    ],
    correctIndex: 3,
    explanation:
        ' The context clue is “like a match in a dark room,” suggesting a sudden change. His expression became bright or joyful—so “lit up” means he looked happy or excited.',
    incorrectExplanations: [
      ' “He became very angry” doesn’t fit the joyful tone of “lit up”.',
      ' Falling asleep contradicts the idea of facial expression lighting up.',
      ' Turning red doesn’t match the metaphor of brightness and joy.',
      ' Correct answer!',
    ],
  ),
  QuestionData(
    question:
        'What does the word “closely” most likely mean in the sentence below?\n\n*“You’ve changed,” he said, looking at her closely.*',
    options: [
      "A) In a distant way",
      "B) Without caring",
      "C) With careful attention",
      "D) With anger"
    ],
    correctIndex: 2,
    explanation:
        ' The suffix “-ly” turns adjectives into adverbs. “Close” becomes “closely,” meaning in a careful or focused way.',
    incorrectExplanations: [
      ' “In a distant way” is the opposite of “closely.”',
      ' “Without caring” does not align with the careful observation implied.',
      ' Correct answer!',
      ' Anger isn’t implied by the word “closely.”',
    ],
  ),
  QuestionData(
    question:
        'What does the word “collar” most likely mean in the sentence below?\n\n*“She lifted her veil and opened her fur collar.”*',
    options: [
      "A) Perro",
      "B) Cuello de ropa",
      "C) Collar de joyas",
      "D) Anillo"
    ],
    correctIndex: 1,
    explanation:
        ' Though “collar” looks like the Spanish word collar (necklace), it’s a false cognate. In English, “collar” here means the neck part of clothing—in Spanish, cuello de la ropa.',
    incorrectExplanations: [
      ' “Perro” is unrelated to the sentence context.',
      ' Correct answer!',
      ' Though “collar de joyas” sounds similar, it doesn’t fit the clothing context.',
      ' “Anillo” means ring, not related to clothing or fur.',
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

  List<TextSpan> _parseItalicText(String text, TextStyle baseStyle) {
    final regex = RegExp(r'\*(.*?)\*', dotAll: true);
    final matches = regex.allMatches(text);

    if (matches.isEmpty) {
      return [TextSpan(text: text, style: baseStyle)];
    }

    List<TextSpan> spans = [];
    int lastEnd = 0;

    for (final match in matches) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: baseStyle,
        ));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: baseStyle.copyWith(fontStyle: FontStyle.italic),
      ));
      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: baseStyle,
      ));
    }

    return spans;
  }

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
                      child: RichText(
                        text: TextSpan(
                          children: _parseItalicText(
                            question.question,
                            const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Opciones
                    ...List.generate(question.options.length, (i) {
                      final isSelected = selected == i;

                      return GestureDetector(
                        onTap: showFeedback
                            ? null
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

                    // Submit o feedback
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E88E5), // azul botón
                            disabledBackgroundColor:
                                accentDark.withOpacity(0.35),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
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
He interrupted her. “Excuse me,” he said, calling the waitress. “Please bring coffee and cream.” Then he turned to Vera. “Are you sure you don’t want something to eat? Some fruit, maybe? The fruit here is very good.”

“No, thank you. Nothing.”

“Alright.” He smiled and picked up the orange again. “You were saying—as you get older…”

“The colder it feels,” she laughed. She remembered how he used to interrupt her like that. Six years ago, it used to annoy her. It felt like he was putting his hand over her mouth, stopping her from speaking, and then smiling too much when he finally listened again.

“The colder!” he repeated, laughing. “You still say the same things. And your voice hasn’t changed—it’s still beautiful.” He leaned closer, and she could smell the orange peel. “I would recognize your voice anywhere. Do you remember our first afternoon at Kew Gardens? You were surprised I didn’t know the names of any flowers. I still don’t know them, but when I see bright colors, I hear your voice saying, ‘Geranium, marigold, and verbena.’ Those words sound like a magical language to me. Do you remember that day?”
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
        'What does the word “waitress” most likely mean in the sentence below?\n\n“Excuse me,” he said, calling the waitress.',
    options: [
      "A) A person who cooks food",
      "B) A woman who serves food and drinks",
      "C) A guest at the restaurant",
      "D) A person who takes reservations"
    ],
    correctIndex: 1,
    explanation:
        ' The context clue is “calling” and the mention of bringing coffee and cream, which suggests she is someone who brings food and drinks — a server at a restaurant.',
    incorrectExplanations: [
      ' A cook works in the kitchen, not serving tables.',
      ' Correct answer!',
      ' A guest is someone who is being served, not the one serving.',
      ' Taking reservations is typically done by a host or receptionist.',
    ],
  ),
  QuestionData(
    question:
        'What does the word “voice” most likely mean in the sentence below?\n\n“And your voice hasn’t changed—it’s still beautiful.”',
    options: ["A) Voz", "B) Vista", "C) Boca", "D) Cara"],
    correctIndex: 0,
    explanation:
        ' “Voice” is a true cognate of the Spanish word voz, meaning the sound we make when we speak.',
    incorrectExplanations: [
      ' Correct answer!',
      ' “Vista” means sight or view, not sound.',
      ' “Boca” means mouth, which is used to make a voice, but not the same as the word itself.',
      ' “Cara” means face and does not relate to the voice.',
    ],
  ),
  QuestionData(
    question:
        'What does the word “leaned” most likely mean in the sentence below?\n\n“He leaned closer, and she could smell the orange peel.”',
    options: [
      "A) Sat down on a chair",
      "B) Moved away from something",
      "C) Looked confused at someone",
      "D) Moved his body forward"
    ],
    correctIndex: 3,
    explanation:
        ' The clue “she could smell the orange peel” suggests that he moved physically closer—“leaned” means to bend or move the body toward something.',
    incorrectExplanations: [
      ' Sitting doesn’t imply leaning forward.',
      ' Moving away contradicts “closer.”',
      ' Looking confused is unrelated to body movement.',
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

  List<TextSpan> _parseItalicText(String text, TextStyle baseStyle) {
    final regex = RegExp(r'\*(.*?)\*', dotAll: true);
    final matches = regex.allMatches(text);

    if (matches.isEmpty) {
      return [TextSpan(text: text, style: baseStyle)];
    }

    List<TextSpan> spans = [];
    int lastEnd = 0;

    for (final match in matches) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: baseStyle,
        ));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: baseStyle.copyWith(fontStyle: FontStyle.italic),
      ));
      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: baseStyle,
      ));
    }

    return spans;
  }

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
                      child: RichText(
                        text: TextSpan(
                          children: _parseItalicText(
                            question.question,
                            const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Opciones
                    ...List.generate(question.options.length, (i) {
                      final isSelected = selected == i;

                      return GestureDetector(
                        onTap: showFeedback
                            ? null
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

                    // Submit o feedback
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E88E5), // azul botón
                            disabledBackgroundColor:
                                accentDark.withOpacity(0.35),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
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
“Yes, I remember it well,” she said softly. But what she really remembered was a silly moment at a tea table. There were many people there, and he was acting strangely, waving at wasps with his hat. Everyone laughed, but she felt embarrassed.

Now, as he spoke, that memory faded. His version of the day felt truer. It had been a wonderful afternoon, full of flowers and warm sunshine. She thought about those words—warm sunshine—as if they were a song.

Another memory came to her. She saw herself sitting on the grass. He was lying next to her, and after a long silence, he put his head in her lap.

“I wish,” he said quietly, “I wish I had taken poison and was about to die—right here, right now.”

At that moment, a little girl in a white dress appeared, holding a water lily. She stared at them, then ran away. But he didn’t notice. Vera leaned over him.

“Why do you say that? I could never say that.”

He sighed and held her hand to his cheek. “Because I know I will love you too much—far too much. And I will suffer because you will never love me.”
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
        'What does the word “sunshine” most likely mean in the sentence below?\n\n“…a wonderful afternoon, full of flowers and warm sunshine.”',
    options: [
      "A) A type of flower or plant",
      "B) Bright light and warmth from the sun",
      "C) Afternoon wind and cloudy",
      "D) A cold memory"
    ],
    correctIndex: 1,
    explanation:
        ' The context clue is the phrase “full of flowers and warm sunshine”—both describe pleasant natural weather, so “sunshine” refers to sunlight and warmth.',
    incorrectExplanations: [
      ' Flowers are mentioned, but “sunshine” is not a flower.',
      ' Correct answer!',
      ' This contradicts the warm and pleasant tone of the sentence.',
      ' Nothing in the sentence suggests coldness or memory.',
    ],
  ),
  QuestionData(
    question:
        'What does the word “table” most likely mean in the sentence below?\n\n“…she really remembered was a silly moment at a tea table.”',
    options: ["A) Tabla", "B) Horario", "C) Mesa", "D) Tarjeta"],
    correctIndex: 2,
    explanation:
        ' Although “table” may look like the Spanish word “tabla” (a board or chart), here it means “mesa,” a piece of furniture for eating — a false cognate.',
    incorrectExplanations: [
      ' “Tabla” is a false cognate; in English, a “table” for tea is “mesa.”',
      ' “Horario” means schedule, not a piece of furniture.',
      ' Correct answer!',
      ' “Tarjeta” means card, which doesn’t make sense here.',
    ],
  ),
  QuestionData(
    question:
        'What does the word “wasps” most likely mean in the sentence below?\n\n“…he was acting strangely, waving at wasps with his hat.”',
    options: [
      "A) Flowers or exotic plants",
      "B) Bees or stinging insects",
      "C) Children and elderly people",
      "D) Waiters and bartenders"
    ],
    correctIndex: 1,
    explanation:
        ' The phrase “waving at wasps with his hat” gives a clue that wasps are something annoying or flying, likely insects—which they are.',
    incorrectExplanations: [
      ' Flowers don’t fly or cause someone to wave a hat.',
      ' Correct answer!',
      ' The sentence doesn’t refer to people, especially not in that context.',
      ' Nothing suggests the presence of waiters or bartenders.',
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

  List<TextSpan> _parseItalicText(String text, TextStyle baseStyle) {
    final regex = RegExp(r'\*(.*?)\*', dotAll: true);
    final matches = regex.allMatches(text);

    if (matches.isEmpty) {
      return [TextSpan(text: text, style: baseStyle)];
    }

    List<TextSpan> spans = [];
    int lastEnd = 0;

    for (final match in matches) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: baseStyle,
        ));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: baseStyle.copyWith(fontStyle: FontStyle.italic),
      ));
      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: baseStyle,
      ));
    }

    return spans;
  }

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
                      child: RichText(
                        text: TextSpan(
                          children: _parseItalicText(
                            question.question,
                            const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Opciones
                    ...List.generate(question.options.length, (i) {
                      final isSelected = selected == i;

                      return GestureDetector(
                        onTap: showFeedback
                            ? null
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

                    // Submit o feedback
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E88E5), // azul botón
                            disabledBackgroundColor:
                                accentDark.withOpacity(0.35),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
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
Now, he looked much better than he did back then. He seemed confident, like a man who knew his place in life. He must have made money too. His clothes were nice, and he took out a Russian cigarette case.

“Would you like a cigarette?”

“Yes, thank you.” She looked at them. “They look good.”

“They are. I have them made specially. I don’t smoke much, but when I do, I want the best. Smoking is a luxury for me, like perfume. Do you still like perfumes? Ah, when I was in Russia…”

She interrupted him. “You’ve been to Russia?”

“Yes, for over a year. Don’t you remember how we used to talk about going there?”

“No, I haven’t forgotten.”

He laughed softly. “It’s funny. I’ve done all the trips we planned. I’ve been to all those places we talked about—Spain, Corsica, Siberia, Russia, Egypt. The only place left is China, and I’ll go there after the war.”
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
        'What does the word “luxury” most likely mean in the sentence below?\n\n“Smoking is a luxury for me, like perfume.”',
    options: [
      "A) Something necessary and vital",
      "B) Something cheap and tacky",
      "C) Something expensive and special",
      "D) Something boring and dull"
    ],
    correctIndex: 2,
    explanation:
        ' The context clue is the comparison to “perfume” — a special or costly item. This shows “luxury” means something pleasurable and not essential.',
    incorrectExplanations: [
      ' “Luxury” refers to pleasure, not necessity.',
      ' “Cheap and tacky” is the opposite of luxury.',
      ' Correct answer!',
      ' “Luxury” implies something pleasurable, not dull.',
    ],
  ),
  QuestionData(
    question:
        'What does the word “softly” tell us about how he laughed in the sentence below?\n\n“He laughed softly.”',
    options: [
      "A) That he laughed loudly",
      "B) That he laughed in a soft manner",
      "C) That he didn’t laugh at all",
      "D) That he laughed quickly"
    ],
    correctIndex: 1,
    explanation:
        ' The suffix “-ly” changes the adjective “soft” into an adverb, showing how he laughed — in a soft way.',
    incorrectExplanations: [
      ' “Softly” is the opposite of “loudly.”',
      ' Correct answer!',
      ' He clearly did laugh, just in a soft way.',
      ' The word doesn’t suggest speed.',
    ],
  ),
  QuestionData(
    question:
        'What does the word “case” most likely mean in the sentence below?\n\n“He took out a Russian cigarette case.”',
    options: ["A) Caso", "B) Caja", "C) Maleta", "D) Juicio"],
    correctIndex: 1,
    explanation:
        ' Although “case” looks like the Spanish “caso” (a situation or event), here it means a container — a false cognate. The word “case” refers to a box or holder for cigarettes — “caja” in Spanish.',
    incorrectExplanations: [
      ' “Caso” is a false cognate; this is a physical object.',
      ' Correct answer!',
      ' “Maleta” means suitcase — too big for cigarettes.',
      ' “Juicio” refers to a legal trial, not an object.',
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

  List<TextSpan> _parseItalicText(String text, TextStyle baseStyle) {
    final regex = RegExp(r'\*(.*?)\*', dotAll: true);
    final matches = regex.allMatches(text);

    if (matches.isEmpty) {
      return [TextSpan(text: text, style: baseStyle)];
    }

    List<TextSpan> spans = [];
    int lastEnd = 0;

    for (final match in matches) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: baseStyle,
        ));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: baseStyle.copyWith(fontStyle: FontStyle.italic),
      ));
      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: baseStyle,
      ));
    }

    return spans;
  }

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
                      child: RichText(
                        text: TextSpan(
                          children: _parseItalicText(
                            question.question,
                            const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Opciones
                    ...List.generate(question.options.length, (i) {
                      final isSelected = selected == i;

                      return GestureDetector(
                        onTap: showFeedback
                            ? null
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

                    // Submit o feedback
                    if (!showFeedback)
                      Center(
                        child: ElevatedButton(
                          onPressed: selected != null ? _submitAnswer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E88E5), // azul botón
                            disabledBackgroundColor:
                                accentDark.withOpacity(0.35),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
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