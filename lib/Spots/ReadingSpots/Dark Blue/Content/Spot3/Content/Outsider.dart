// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Dark Blue/Content/Spot3/Spot_Page/ReadingSpot.dart';

import 'dart:math' as math;

class TheOutsiderLovecraftSplash extends StatefulWidget {
  const TheOutsiderLovecraftSplash({super.key});

  @override
  State<TheOutsiderLovecraftSplash> createState() =>
      _TheOutsiderLovecraftSplashState();
}

class _TheOutsiderLovecraftSplashState extends State<TheOutsiderLovecraftSplash>
    with TickerProviderStateMixin {
  late AnimationController _bgCtrl;
  late AnimationController _iconCtrl;
  late AnimationController _personFloatCtrl;
  late AnimationController _glowCtrl;
  late AnimationController _beamCtrl;
  late AnimationController _shadowCtrl;
  late AnimationController _orbit1Ctrl;
  late AnimationController _orbit2Ctrl;
  late AnimationController _orbit3Ctrl;
  late AnimationController _starsCtrl;
  late AnimationController _shootCtrl;
  late AnimationController _textCtrl;

  late Animation<double> _bgFade;
  late Animation<double> _iconScale;
  late Animation<double> _iconY;

  // Person float — 3-keypoint asymmetric
  late Animation<double> _personY;

  late Animation<double> _innerGlow;
  late Animation<double> _outerGlow;
  late Animation<double> _iconGlow;
  late Animation<double> _beamOpacity;

  // Shadow: scaleX, scaleY, opacity
  late Animation<double> _shadowScaleX;
  late Animation<double> _shadowScaleY;
  late Animation<double> _shadowOpacity;

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

  // ring, offsetDeg, radius, starR — slower orbits
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
    [3, 0, 58, 3.0],
    [3, 120, 58, 2.0],
    [3, 240, 58, 2.5],
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
    _iconScale = Tween<double>(begin: .3, end: 1.0)
        .animate(CurvedAnimation(parent: _iconCtrl, curve: Curves.elasticOut));
    _iconY = Tween<double>(begin: 24, end: 0)
        .animate(CurvedAnimation(parent: _iconCtrl, curve: Curves.easeOut));
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _iconCtrl.forward();
    });

    // Person float — asymmetric 3-point via TweenSequence
    _personFloatCtrl = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this)
      ..repeat();
    _personY = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: -5.0)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 33),
      TweenSequenceItem(
          tween: Tween<double>(begin: -5, end: -9)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 33),
      TweenSequenceItem(
          tween: Tween<double>(begin: -9, end: 0)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 34),
    ]).animate(_personFloatCtrl);

    // Glow — slower/dimmer
    _glowCtrl = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this)
      ..repeat(reverse: true);
    _innerGlow = Tween<double>(begin: .12, end: .28)
        .animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));
    _outerGlow = Tween<double>(begin: .08, end: .18)
        .animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));
    _iconGlow = Tween<double>(begin: .22, end: .45)
        .animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));

    // Spotlight beam pulse
    _beamCtrl = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this)
      ..repeat(reverse: true);
    _beamOpacity = Tween<double>(begin: .07, end: .18)
        .animate(CurvedAnimation(parent: _beamCtrl, curve: Curves.easeInOut));

    // Shadow stretches as figure floats up
    _shadowCtrl = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this)
      ..repeat(reverse: true);
    _shadowScaleX = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.15), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.15, end: 1.25), weight: 50),
    ]).animate(CurvedAnimation(parent: _shadowCtrl, curve: Curves.easeInOut));
    _shadowScaleY = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: .75), weight: 50),
      TweenSequenceItem(tween: Tween(begin: .75, end: .60), weight: 50),
    ]).animate(CurvedAnimation(parent: _shadowCtrl, curve: Curves.easeInOut));
    _shadowOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: .45, end: .35), weight: 50),
      TweenSequenceItem(tween: Tween(begin: .35, end: .28), weight: 50),
    ]).animate(CurvedAnimation(parent: _shadowCtrl, curve: Curves.easeInOut));

    // Orbits — slower
    _orbit1Ctrl = AnimationController(
        duration: const Duration(milliseconds: 9000), vsync: this)
      ..repeat();
    _orbit2Ctrl = AnimationController(
        duration: const Duration(milliseconds: 15000), vsync: this)
      ..repeat();
    _orbit3Ctrl = AnimationController(
        duration: const Duration(milliseconds: 22000), vsync: this)
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

    _shootCtrl = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this)
      ..repeat();

    // Text
    _textCtrl = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    _dividerOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _textCtrl,
        curve: const Interval(.0, .6, curve: Curves.easeOut)));
    _dividerScale = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _textCtrl,
        curve: const Interval(.0, .6, curve: Curves.easeOut)));
    _titleOpacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut));
    _titleSlide = Tween<double>(begin: 16, end: 0)
        .animate(CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut));
    _authorOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _textCtrl,
        curve: const Interval(.4, 1.0, curve: Curves.easeOut)));
    Future.delayed(const Duration(milliseconds: 750), () {
      if (mounted) _textCtrl.forward();
    });

    // Navigate
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Outsider()));
    });
  }

  @override
  void dispose() {
    _bgCtrl.dispose();
    _iconCtrl.dispose();
    _personFloatCtrl.dispose();
    _glowCtrl.dispose();
    _beamCtrl.dispose();
    _shadowCtrl.dispose();
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
            _OutsiderNebula(
                color: const Color(0xFF0A1964),
                alignment: const Alignment(-1.0, -.85),
                size: 400),
            _OutsiderNebula(
                color: const Color(0xFF052882),
                alignment: const Alignment(1.0, .80),
                size: 300,
                delay: 2000),
            _OutsiderNebula(
                color: const Color(0xFF140A78),
                alignment: const Alignment(.80, .20),
                size: 220,
                delay: 4000),

            // Star field
            AnimatedBuilder(
              animation: Listenable.merge([_starsCtrl, _shootCtrl]),
              builder: (_, __) => CustomPaint(
                painter: _OutsiderStarPainter(
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
            _OutsiderParticle(
                xF: .18, yF: .20, sz: 5, shape: 0, durMs: 3400, delayMs: 0),
            _OutsiderParticle(
                xF: .84, yF: .22, sz: 4, shape: 1, durMs: 2900, delayMs: 500),
            _OutsiderParticle(
                xF: .11, yF: .43, sz: 3, shape: 0, durMs: 4000, delayMs: 900),
            _OutsiderParticle(
                xF: .87, yF: .41, sz: 4, shape: 1, durMs: 3100, delayMs: 300),
            _OutsiderParticle(
                xF: .22, yF: .27, sz: 5, shape: 2, durMs: 3600, delayMs: 700),
            _OutsiderParticle(
                xF: .80, yF: .38, sz: 4, shape: 3, durMs: 2800, delayMs: 1100),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Figure icon
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _iconCtrl,
                      _personFloatCtrl,
                      _glowCtrl,
                      _beamCtrl,
                      _shadowCtrl,
                      _orbit1Ctrl,
                      _orbit2Ctrl,
                      _orbit3Ctrl,
                    ]),
                    builder: (_, __) {
                      final entranceY =
                          _iconCtrl.isCompleted ? 0.0 : _iconY.value;
                      final floatY =
                          _iconCtrl.isCompleted ? _personY.value : 0.0;
                      return Transform.translate(
                        offset: Offset(0, entranceY),
                        child: Transform.scale(
                          scale: _iconScale.value,
                          child: SizedBox(
                            width: 180,
                            height: 200,
                            child: CustomPaint(
                              painter: _OutsiderFigurePainter(
                                innerGlow: _innerGlow.value,
                                outerGlow: _outerGlow.value,
                                iconGlow: _iconGlow.value,
                                beamOpacity: _beamOpacity.value,
                                shadowScaleX: _shadowScaleX.value,
                                shadowScaleY: _shadowScaleY.value,
                                shadowOpacity: _shadowOpacity.value,
                                orbit1T: _orbit1Ctrl.value,
                                orbit2T: _orbit2Ctrl.value,
                                orbit3T: _orbit3Ctrl.value,
                                orbitStars: _orbitStars,
                              ),
                              child: Align(
                                alignment: const Alignment(0, -.1),
                                child: Transform.translate(
                                  offset: Offset(0, floatY),
                                  child: ShaderMask(
                                    shaderCallback: (bounds) =>
                                        const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFFC8DCFF),
                                        Color(0xFF5888D8),
                                        Color(0xFF1030A0),
                                      ],
                                      stops: [0.0, .45, 1.0],
                                    ).createShader(bounds),
                                    child: const FaIcon(
                                      FontAwesomeIcons.person,
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

                  const SizedBox(height: 14),

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
                                        .withOpacity(.35))),
                            const SizedBox(width: 8),
                            const Icon(Icons.star_rounded,
                                color: Color(0xFF5888D8), size: 14),
                            const SizedBox(width: 8),
                            Expanded(
                                child: Container(
                                    height: 1,
                                    color: const Color(0xFF5090FF)
                                        .withOpacity(.35))),
                          ]),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Title
                  AnimatedBuilder(
                    animation: _textCtrl,
                    builder: (_, __) => Transform.translate(
                      offset: Offset(0, _titleSlide.value),
                      child: Opacity(
                        opacity: _titleOpacity.value,
                        child: Text(
                          'The Outsider',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFD8E8FF),
                            letterSpacing: 1.1,
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
                        'By H. P. Lovecraft 1926',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF8CB4FF).withOpacity(.62),
                          letterSpacing: .8,
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
                        'From Arkhamarchivist.com',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF8CB4FF).withOpacity(.62),
                          letterSpacing: .8,
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

// ─── Figure + Spotlight + Shadow + Orbit painter ──────────────────────
class _OutsiderFigurePainter extends CustomPainter {
  final double innerGlow, outerGlow, iconGlow;
  final double beamOpacity;
  final double shadowScaleX, shadowScaleY, shadowOpacity;
  final double orbit1T, orbit2T, orbit3T;
  final List<List<double>> orbitStars;

  const _OutsiderFigurePainter({
    required this.innerGlow,
    required this.outerGlow,
    required this.iconGlow,
    required this.beamOpacity,
    required this.shadowScaleX,
    required this.shadowScaleY,
    required this.shadowOpacity,
    required this.orbit1T,
    required this.orbit2T,
    required this.orbit3T,
    required this.orbitStars,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height * .47; // slightly above center
    final scl = size.width / 180;

    // ── SPOTLIGHT BEAM ────────────────────────────────────────────
    // Triangle from top-center downward
    final beamPath = Path()
      ..moveTo(cx, 0)
      ..lineTo(cx - 45 * scl, size.height * .75)
      ..lineTo(cx + 45 * scl, size.height * .75)
      ..close();
    canvas.drawPath(
      beamPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF8CB4FF).withOpacity(beamOpacity * 1.5),
            const Color(0xFF8CB4FF).withOpacity(0),
          ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height * .75)),
    );

    // ── AMBIENT GLOWS ─────────────────────────────────────────────
    canvas.drawCircle(
        Offset(cx, cy),
        82 * scl,
        Paint()
          ..shader = RadialGradient(colors: [
            const Color(0xFF3060CC).withOpacity(outerGlow),
            const Color(0xFF3060CC).withOpacity(0),
          ]).createShader(
              Rect.fromCircle(center: Offset(cx, cy), radius: 82 * scl)));

    canvas.drawCircle(
        Offset(cx, cy),
        55 * scl,
        Paint()
          ..shader = RadialGradient(colors: [
            const Color(0xFF1840AA).withOpacity(innerGlow),
            const Color(0xFF1040CC).withOpacity(innerGlow * .15),
            const Color(0xFF1040CC).withOpacity(0),
          ], stops: const [
            0.0,
            .55,
            1.0
          ]).createShader(
              Rect.fromCircle(center: Offset(cx, cy), radius: 55 * scl)));

    // ── ORBITING STARS ────────────────────────────────────────────
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

      // dimmer stars for Lovecraft mood
      canvas.drawCircle(
        Offset(cx + rawX, cy + rawY),
        starR * pop,
        Paint()..color = const Color(0xFF8CC8FF).withOpacity(.65 * pop),
      );

      if ((ring == 1 || ring == 2) && offsetDeg == 0) {
        final arm = starR * 1.8 * pop;
        final sx = cx + rawX;
        final sy = cy + rawY;
        final sp = Paint()
          ..color = const Color(0xFFB4D8FF)
              .withOpacity(ring == 1 ? .70 * pop : .58 * pop)
          ..strokeWidth = 1.0
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(Offset(sx - arm, sy), Offset(sx + arm, sy), sp);
        canvas.drawLine(Offset(sx, sy - arm), Offset(sx, sy + arm), sp);
      }
    }

    // ── SHADOW beneath figure ─────────────────────────────────────
    final shadowCy = size.height * .80;
    canvas.save();
    canvas.translate(cx, shadowCy);
    canvas.scale(shadowScaleX, shadowScaleY);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: 52 * scl, height: 12 * scl),
      Paint()
        ..shader = RadialGradient(colors: [
          const Color(0xFF000A28).withOpacity(shadowOpacity),
          const Color(0xFF000A28).withOpacity(0),
        ]).createShader(Rect.fromCenter(
            center: Offset.zero, width: 52 * scl, height: 12 * scl)),
    );
    canvas.restore();

    // ── ICON GLOW (under fa-person) ───────────────────────────────
    canvas.drawCircle(
        Offset(cx, cy),
        44 * scl,
        Paint()
          ..shader = RadialGradient(colors: [
            const Color(0xFF2868CC).withOpacity(iconGlow * .55),
            const Color(0xFF2868CC).withOpacity(0),
          ]).createShader(
              Rect.fromCircle(center: Offset(cx, cy), radius: 44 * scl)));
  }

  @override
  bool shouldRepaint(covariant _OutsiderFigurePainter o) =>
      o.innerGlow != innerGlow ||
      o.outerGlow != outerGlow ||
      o.iconGlow != iconGlow ||
      o.beamOpacity != beamOpacity ||
      o.shadowScaleX != shadowScaleX ||
      o.shadowScaleY != shadowScaleY ||
      o.shadowOpacity != shadowOpacity ||
      o.orbit1T != orbit1T ||
      o.orbit2T != orbit2T ||
      o.orbit3T != orbit3T;
}

// ─── Nebula ───────────────────────────────────────────────────────────
class _OutsiderNebula extends StatefulWidget {
  final Color color;
  final Alignment alignment;
  final double size;
  final int delay;
  const _OutsiderNebula(
      {required this.color,
      required this.alignment,
      required this.size,
      this.delay = 0});
  @override
  State<_OutsiderNebula> createState() => _OutsiderNebulaState();
}

class _OutsiderNebulaState extends State<_OutsiderNebula>
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
class _OutsiderParticle extends StatefulWidget {
  final double xF, yF, sz;
  final int shape, durMs, delayMs;
  const _OutsiderParticle(
      {required this.xF,
      required this.yF,
      required this.sz,
      required this.shape,
      required this.durMs,
      required this.delayMs});
  @override
  State<_OutsiderParticle> createState() => _OutsiderParticleState();
}

class _OutsiderParticleState extends State<_OutsiderParticle>
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
                    color: const Color(0xFF3264C8).withOpacity(.22),
                  ),
                )
              : Container(
                  width: widget.sz,
                  height: widget.sz,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF3264C8).withOpacity(.35),
                  ),
                ),
        ),
      ),
    );
  }
}

// ─── Star field + shooting stars ─────────────────────────────────────
class _OutsiderStarPainter extends CustomPainter {
  final List<List<double>> stars;
  final List<double> starOpacities;
  final double shootT;
  final List<List<double>> shoots;
  final Size canvasSize;

  const _OutsiderStarPainter({
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
          ..color = const Color(0xFF5888D8).withOpacity(op)
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
            const Color(0xFF96C8FF).withOpacity(op * .85),
            const Color(0xFF96C8FF).withOpacity(op * .30),
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
  bool shouldRepaint(covariant _OutsiderStarPainter o) =>
      o.shootT != shootT || o.starOpacities != starOpacities;
}

class Outsider extends StatefulWidget {
  const Outsider({super.key});
  @override
  State<Outsider> createState() => _OutsiderState();
}

class _OutsiderState extends State<Outsider> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What usually defines a “monster” in stories?",
      "options": [
        "A)  Big eyes and sharp fangs",
        "B)  Unusual talents",
        "C)  Threatening behavior",
        "D)  Being tall and strong"
      ],
      "correct": 2,
      "feedback": [
        " Physical features like big eyes and fangs might appear, but they aren't the defining trait.",
        " Unusual talents don’t make a character monstrous.",
        " Correct! 😈  Monsters are typically defined not just by looks, but by dangerous, violent, or threatening actions.",
        " Strength alone doesn't define a monster."
      ]
    },
    {
      "question": "Can a character look scary but be kind?",
      "options": [
        "A)  No, appearance always reflects personality",
        "B)  Yes, it can exist behind a frightening appearance",
        "C)  Only in fairy tales",
        "D)  Not in serious literature"
      ],
      "correct": 1,
      "feedback": [
        " This idea is challenged in many stories — appearance doesn't always match personality.",
        " Correct! 👻 Many stories challenge the idea that looks determine goodness—some “scary” characters are actually gentle or misunderstood.",
        " Not only in fairy tales — this theme appears across many genres.",
        " Serious literature often explores this very theme."
      ]
    },
    {
      "question":
          "Which of the following could make someone a \"monster\" in moral terms?",
      "options": [
        "A)  Having sharp teeth",
        "B)  Being physically strong",
        "C)  Causing harm without remorse",
        "D)  Being quiet"
      ],
      "correct": 2,
      "feedback": [
        " Sharp teeth are physical traits, not moral failings.",
        " Strength does not equal moral monstrosity.",
        " Correct! 🩸 Being monstrous is often tied to behavior—such as cruelty or lack of empathy—rather than appearance.",
        " Silence doesn’t make someone morally monstrous."
      ]
    },
    {
      "question": "What is a common reason monsters are feared in stories?",
      "options": [
        "A) They are always silent",
        "B) They are unknown",
        "C) They wear costumes",
        "D) They live in castles"
      ],
      "correct": 1,
      "feedback": [
        " Silence can add mystery, but it's not the main source of fear.",
        ' Correct! 🕳️  Fear often comes from not understanding something—many "monsters" in stories are feared simply because they are different or unfamiliar.',
        " Costumes are symbolic, not a core reason.",
        " Living in castles doesn’t make a monster fearful."
      ]
    },
    {
      "question":
          "Why do some authors create monsters who feel human emotions like sadness or loneliness?",
      "options": [
        "A) To help readers question what “humanity” really means",
        "B) To confuse readers",
        "C) To make them more popular and iconic",
        "D) To make the story longer and keep reader's attention"
      ],
      "correct": 0,
      "feedback": [
        " Correct! 🧠 Giving monsters human emotions makes us reflect on empathy, identity, and the true nature of monstrosity.",
        " Confusion is not the goal — reflection is.",
        " Emotional depth is not for popularity, but for meaning.",
        " The goal is not story length, but emotional impact."
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
                title: "Outsider", nextPage: BiographyReadingPage()),
          ),
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

  int _lastQuestionIndex = 0;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final String biographyText = '''
That night, the Baron dreamed of many terrible things. He saw witches, demons, and giant coffin-worms. His guests also had bad dreams.

Unhappy is the person who remembers their childhood with fear and sadness. Wretched is the one who thinks of lonely hours in dark, gloomy rooms with old brown curtains and endless rows of dusty books. Or who remembers walking in strange, silent forests with twisted trees and hanging vines. This was my life—a gift from the gods. I felt lost, disappointed, and broken. Yet, I strangely find comfort in these memories, even though they are painful.

I don’t know where I was born, but I remember the castle. It was very old and very scary, with dark hallways, high ceilings full of cobwebs, and damp, crumbling stones. The air always smelled of death, as if the walls held the bodies of people who had died long ago. There was no light inside, so I often lit candles to feel some relief. Outside, the sun never reached the ground because the trees were too tall. One black tower rose above the trees, but it was ruined and impossible to climb.


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
    question: 'What emotion does the narrator associate with their childhood?',
    options: [
      "A) Joy and peace",
      "B) Love and security",
      "C) Confusion and curiosity",
      "D) Fear and sadness"
    ],
    correctIndex: 3,
    explanation:
        ' 😢 The narrator describes their childhood as fearful and sad, full of loneliness, darkness, and discomfort.',
    incorrectExplanations: [
      ' The narrator does not recall joy or peace.',
      ' Love and security were absent in their description.',
      ' Confusion and curiosity are not the dominant emotions described.',
      ' Correct answer! 🎯'
    ],
  ),
  QuestionData(
    question:
        'What detail emphasizes the eerie and decaying nature of the castle?',
    options: [
      "A) It smelled of death and had crumbling stones",
      "B) It was surrounded by animals",
      "C) It had no furniture nor decorations",
      "D) It had guards watching the doors"
    ],
    correctIndex: 0,
    explanation:
        ' 💀 The narrator mentions the smell of death and crumbling stones to highlight the castle’s haunting and decayed state.',
    incorrectExplanations: [
      ' Correct answer! 🏰',
      ' Animals are not linked to the castle’s eerie atmosphere.',
      ' Lack of furniture is less specific and not mentioned.',
      ' Guards would imply security, not decay.'
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

  static const Color accentDark = Color(0xFF1565C0); // azul oscuro
  static const Color cardBg = Color(0xFFE3F2FD); // azul muy claro

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
              Color.fromARGB(255, 115, 215, 205), // teal suave
              Color(0xFF264E82), // azul oscuro elegante
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
                            icon: const Icon(Icons.menu_book,
                                color: Colors.white),
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
                              backgroundColor:
                                  const Color(0xFF1E88E5), // azul botón
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
I must have lived there for years, but I can’t remember how long. Someone must have taken care of me, but I don’t remember anyone except myself. The only living things I recall are rats, bats, and spiders. I think the person who cared for me was very old, like the castle itself. To me, the bones and skeletons in the crypts seemed normal, more natural than the pictures of living people in the old books. I learned everything from those books. I had no teacher, and I never heard a human voice—not even my own. I didn’t know what I looked like because there were no mirrors. I only knew I was young because I remembered so little.

Outside, I would lie under the dark trees and dream about the world beyond the forest. I imagined happy crowds and sunny places. Once, I tried to escape, but the forest grew darker and scarier the farther I went. I ran back, afraid of getting lost.

For years, I dreamed and waited, though I didn’t know what I was waiting for. My longing for light grew so strong that I couldn’t rest. I decided to climb the black tower, even if it killed me. I wanted to see the sky, even if only once.

In the dim light, I climbed the old stone stairs until they ended. Then, I clung to small holds in the wall, climbing higher. The tower was dark and terrifying, full of silent bats. But the worst part was how slow my progress was. No matter how high I climbed, the darkness above didn’t fade. I began to shiver, wondering why I couldn’t reach the light.
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
    question: 'Why didn’t the narrator know what they looked like?',
    options: [
      "A) They had no memory of their past",
      "B) They were blind",
      "C) There were no mirrors in the castle",
      "D) They refused to look at themselves"
    ],
    correctIndex: 2,
    explanation:
        ' 🪞 The narrator explicitly states that there were no mirrors, so they had no idea what they looked like.',
    incorrectExplanations: [
      ' Memory loss isn’t mentioned as a reason.',
      ' The narrator is not described as blind.',
      ' Correct answer! 🎯',
      ' There is no mention of refusal to look.'
    ],
  ),
  QuestionData(
    question: 'What drives the narrator to climb the black tower?',
    options: [
      "A) A deep need to see the sky and light",
      "B) A longing to feel the wind",
      "C) A desire to escape the castle forever",
      "D) A dream about someone calling them"
    ],
    correctIndex: 0,
    explanation:
        ' 🌤️ The narrator is driven by a powerful longing for light and sky, which has grown over years of darkness.',
    incorrectExplanations: [
      ' Correct answer! ✨',
      ' Wind is not the main driving force.',
      ' While escape is implied, the key motive is the desire for light.',
      ' There’s no mention of a dream calling them.'
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

  static const Color accentDark = Color(0xFF1565C0); // azul oscuro
  static const Color cardBg = Color(0xFFE3F2FD); // azul muy claro

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
              Color.fromARGB(255, 115, 215, 205), // teal suave
              Color(0xFF264E82), // azul oscuro elegante
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
                            icon: const Icon(Icons.menu_book,
                                color: Colors.white),
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
                              backgroundColor:
                                  const Color(0xFF1E88E5), // azul botón
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
Finally, my head touched something solid. I had reached the top. I felt around and found a stone slab. I pushed it open and crawled through. The slab fell back into place, but I didn’t care. I was exhausted. I believed I was now high above the trees, so I searched for windows to see the sky. But instead, I found shelves with strange, disturbing boxes. I wondered what secrets this place held.

Then, I found a stone door. It was locked, but I forced it open. Inside, I saw the most beautiful sight: the full moon, shining through an iron grating. I had never seen it before, except in dreams. I rushed toward it, but a cloud covered the moon, and I stumbled in the dark. When I reached the grating, I found it unlocked but didn’t open it, afraid of falling. Then, the moon came out again.
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
    question: 'What is the narrator’s reaction when they first see the moon?',
    options: [
      "A) Fear of the light",
      "B) A rush of joy and wonder",
      "C) Confusion about what it is",
      "D) Disappointment it wasn’t the sun"
    ],
    correctIndex: 1,
    explanation:
        ' 🌕 The narrator calls the moon "the most beautiful sight" and rushes toward it, showing awe and wonder.',
    incorrectExplanations: [
      ' Fear is not the narrator’s reaction.',
      ' Correct answer! ✨',
      ' The narrator doesn’t express confusion.',
      ' There’s no disappointment mentioned.'
    ],
  ),
  QuestionData(
    question: 'Why doesn’t the narrator open the grating immediately?',
    options: [
      "A) It was locked",
      "B) They were waiting for daylight",
      "C) They were afraid of falling",
      "D) They heard someone outside"
    ],
    correctIndex: 2,
    explanation:
        ' 🕳️ The narrator says they didn’t open the grating because they were afraid of falling.',
    incorrectExplanations: [
      ' There’s no mention of the grating being locked.',
      ' Daylight is not part of their hesitation.',
      ' Correct answer! 😨',
      ' No one is heard outside at that moment.'
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

  static const Color accentDark = Color(0xFF1565C0); // azul oscuro
  static const Color cardBg = Color(0xFFE3F2FD); // azul muy claro

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
              Color.fromARGB(255, 115, 215, 205), // teal suave
              Color(0xFF264E82), // azul oscuro elegante
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
                            icon: const Icon(Icons.menu_book,
                                color: Colors.white),
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
                              backgroundColor:
                                  const Color(0xFF1E88E5), // azul botón
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