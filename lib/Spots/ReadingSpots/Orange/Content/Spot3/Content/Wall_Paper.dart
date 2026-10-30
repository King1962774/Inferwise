// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Orange/Content/Spot3/Spot_Page/Reading_Spot.dart';

import 'dart:math' as math;

class TheYellowWallSplashScreen extends StatefulWidget {
  const TheYellowWallSplashScreen({super.key});

  @override
  State<TheYellowWallSplashScreen> createState() =>
      _TheYellowWallSplashScreenState();
}

class _TheYellowWallSplashScreenState extends State<TheYellowWallSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _bgCtrl;
  late AnimationController _iconCtrl;
  late AnimationController _eyeFloatCtrl;
  late AnimationController _glowCtrl;
  late AnimationController _pupilCtrl;
  late AnimationController _irisCtrl;
  late AnimationController _veinCtrl;
  late AnimationController _orbit1Ctrl;
  late AnimationController _orbit2Ctrl;
  late AnimationController _orbit3Ctrl;
  late AnimationController _starsCtrl;
  late AnimationController _shootCtrl;
  late AnimationController _textCtrl;

  late Animation<double> _bgFade;
  late Animation<double> _iconScale;

  // Eye float — 3-point asymmetric
  late Animation<double> _eyeFloatY;

  // Glow rings
  late Animation<double> _innerGlow;
  late Animation<double> _outerGlow;
  late Animation<double> _eyeGlow;

  // Pupil dilate
  late Animation<double> _pupilScale;

  // Iris shimmer
  late Animation<double> _irisOpacity;

  // Veins pulse
  late Animation<double> _veinOpacity;

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
    _iconScale = Tween<double>(begin: .35, end: 1.0)
        .animate(CurvedAnimation(parent: _iconCtrl, curve: Curves.elasticOut));
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _iconCtrl.forward();
    });

    // Eye float — 3-point asymmetric
    _eyeFloatCtrl = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this)
      ..repeat();
    _eyeFloatY = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: -4.0)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 33),
      TweenSequenceItem(
          tween: Tween(begin: -4.0, end: -8.0)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 33),
      TweenSequenceItem(
          tween: Tween<double>(begin: -8.0, end: 0.0)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 34),
    ]).animate(_eyeFloatCtrl);

    // Glow
    _glowCtrl = AnimationController(
        duration: const Duration(milliseconds: 3500), vsync: this)
      ..repeat(reverse: true);
    _innerGlow = Tween<double>(begin: .16, end: .35)
        .animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));
    _outerGlow = Tween<double>(begin: .10, end: .22)
        .animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));
    _eyeGlow = Tween<double>(begin: .24, end: .50)
        .animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));

    // Pupil dilate — 3s
    _pupilCtrl = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this)
      ..repeat(reverse: true);
    _pupilScale = Tween<double>(begin: 1.0, end: 1.18)
        .animate(CurvedAnimation(parent: _pupilCtrl, curve: Curves.easeInOut));

    // Iris shimmer — 3.5s
    _irisCtrl = AnimationController(
        duration: const Duration(milliseconds: 3500), vsync: this)
      ..repeat(reverse: true);
    _irisOpacity = Tween<double>(begin: .55, end: .90)
        .animate(CurvedAnimation(parent: _irisCtrl, curve: Curves.easeInOut));

    // Veins pulse — 3s
    _veinCtrl = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this)
      ..repeat(reverse: true);
    _veinOpacity = Tween<double>(begin: .18, end: .40)
        .animate(CurvedAnimation(parent: _veinCtrl, curve: Curves.easeInOut));

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
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const The_Yellow_WallPaper()));
    });
  }

  @override
  void dispose() {
    _bgCtrl.dispose();
    _iconCtrl.dispose();
    _eyeFloatCtrl.dispose();
    _glowCtrl.dispose();
    _pupilCtrl.dispose();
    _irisCtrl.dispose();
    _veinCtrl.dispose();
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
            _YWNebula(
                color: const Color(0xFF0A1964),
                alignment: const Alignment(-1.0, -.85),
                size: 400),
            _YWNebula(
                color: const Color(0xFF052882),
                alignment: const Alignment(1.0, .80),
                size: 300,
                delay: 2000),
            _YWNebula(
                color: const Color(0xFF140A78),
                alignment: const Alignment(.80, .20),
                size: 220,
                delay: 4000),

            // Star field
            AnimatedBuilder(
              animation: Listenable.merge([_starsCtrl, _shootCtrl]),
              builder: (_, __) => CustomPaint(
                painter: _YWStarPainter(
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
            _YWParticle(
                xF: .18, yF: .20, sz: 5, shape: 0, durMs: 3400, delayMs: 0),
            _YWParticle(
                xF: .84, yF: .22, sz: 4, shape: 1, durMs: 2900, delayMs: 500),
            _YWParticle(
                xF: .11, yF: .43, sz: 3, shape: 0, durMs: 4000, delayMs: 900),
            _YWParticle(
                xF: .87, yF: .41, sz: 4, shape: 1, durMs: 3100, delayMs: 300),
            _YWParticle(
                xF: .22, yF: .27, sz: 5, shape: 2, durMs: 3600, delayMs: 700),
            _YWParticle(
                xF: .80, yF: .38, sz: 4, shape: 3, durMs: 2800, delayMs: 1100),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Eye icon
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _iconCtrl,
                      _eyeFloatCtrl,
                      _glowCtrl,
                      _pupilCtrl,
                      _irisCtrl,
                      _veinCtrl,
                      _orbit1Ctrl,
                      _orbit2Ctrl,
                      _orbit3Ctrl,
                    ]),
                    builder: (_, __) {
                      final floatY =
                          _iconCtrl.isCompleted ? _eyeFloatY.value : 0.0;
                      return Transform.translate(
                        offset: Offset(0, floatY),
                        child: Transform.scale(
                          scale: _iconScale.value,
                          child: SizedBox(
                            width: 180,
                            height: 180,
                            child: CustomPaint(
                              painter: _YWEyePainter(
                                innerGlow: _innerGlow.value,
                                outerGlow: _outerGlow.value,
                                eyeGlow: _eyeGlow.value,
                                pupilScale: _pupilScale.value,
                                irisOpacity: _irisOpacity.value,
                                veinOpacity: _veinOpacity.value,
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

                  const SizedBox(height: 18),

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
                          'The Yellow Wallpaper',
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
                        'By Charlotte Perkins Stetson, 1892',
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
                        'From The Project Gutenberg',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
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

// ─── Eye + Orbit painter ──────────────────────────────────────────────
class _YWEyePainter extends CustomPainter {
  final double innerGlow, outerGlow, eyeGlow;
  final double pupilScale, irisOpacity, veinOpacity;
  final double orbit1T, orbit2T, orbit3T;
  final List<List<double>> orbitStars;

  const _YWEyePainter({
    required this.innerGlow,
    required this.outerGlow,
    required this.eyeGlow,
    required this.pupilScale,
    required this.irisOpacity,
    required this.veinOpacity,
    required this.orbit1T,
    required this.orbit2T,
    required this.orbit3T,
    required this.orbitStars,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final scl = size.width / 180;

    // ── AMBIENT GLOWS ─────────────────────────────────────────────
    canvas.drawCircle(
        Offset(cx, cy),
        82 * scl,
        Paint()
          ..shader = RadialGradient(colors: [
            const Color(0xFF4080FF).withOpacity(outerGlow),
            const Color(0xFF4080FF).withOpacity(0),
          ]).createShader(
              Rect.fromCircle(center: Offset(cx, cy), radius: 82 * scl)));

    canvas.drawCircle(
        Offset(cx, cy),
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
          ]).createShader(
              Rect.fromCircle(center: Offset(cx, cy), radius: 58 * scl)));

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

      canvas.drawCircle(
        Offset(cx + rawX, cy + rawY),
        starR * pop,
        Paint()..color = const Color(0xFF8CC8FF).withOpacity(.78 * pop),
      );

      if ((ring == 1 || ring == 2) && offsetDeg == 0) {
        final arm = starR * 1.8 * pop;
        final sx = cx + rawX;
        final sy = cy + rawY;
        final sp = Paint()
          ..color = const Color(0xFFB4E0FF)
              .withOpacity(ring == 1 ? .80 * pop : .70 * pop)
          ..strokeWidth = 1.0
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(Offset(sx - arm, sy), Offset(sx + arm, sy), sp);
        canvas.drawLine(Offset(sx, sy - arm), Offset(sx, sy + arm), sp);
      }
    }

    // ── EYE ───────────────────────────────────────────────────────
    // Eye dimensions in canvas coords (120×80 eye centered on 180×180)
    final ew = 110 * scl; // eye width
    final eh = 70 * scl; // eye height
    final el = cx - ew / 2; // eye left
    final er = cx + ew / 2; // eye right

    // Eye shape path: almond/leaf shape
    final eyePath = Path()
      ..moveTo(el, cy)
      ..cubicTo(
          el + ew * .15, cy - eh * .6, er - ew * .15, cy - eh * .6, er, cy)
      ..cubicTo(
          er - ew * .15, cy + eh * .6, el + ew * .15, cy + eh * .6, el, cy)
      ..close();

    // Eye glow behind
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(cx, cy), width: ew * 1.3, height: eh * 1.3),
      Paint()
        ..shader = RadialGradient(colors: [
          const Color(0xFF4878FF).withOpacity(eyeGlow * .5),
          const Color(0xFF4878FF).withOpacity(0),
        ]).createShader(Rect.fromCenter(
            center: Offset(cx, cy), width: ew * 1.3, height: eh * 1.3)),
    );

    // Sclera fill
    canvas.drawPath(
        eyePath,
        Paint()
          ..shader = RadialGradient(
            center: const Alignment(0, 0),
            colors: const [
              Color(0xFFE8F0FF),
              Color(0xFFC0D4F8),
              Color(0xFF8AAAE8),
            ],
            stops: const [0.0, .65, 1.0],
          ).createShader(
              Rect.fromCenter(center: Offset(cx, cy), width: ew, height: eh)));

    // Blood veins
    canvas.save();
    canvas.clipPath(eyePath);
    final veinPaint = Paint()
      ..color = const Color(0xFFB45050).withOpacity(veinOpacity)
      ..strokeWidth = scl * .7
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    // Left veins
    final v1 = Path()
      ..moveTo(el + ew * .15, cy - eh * .05)
      ..quadraticBezierTo(
          el + ew * .28, cy - eh * .15, el + ew * .38, cy - eh * .05);
    canvas.drawPath(v1, veinPaint);
    final v2 = Path()
      ..moveTo(el + ew * .10, cy + eh * .05)
      ..quadraticBezierTo(
          el + ew * .25, cy + eh * .18, el + ew * .35, cy + eh * .08);
    canvas.drawPath(
        v2,
        veinPaint
          ..color = const Color(0xFFB45050).withOpacity(veinOpacity * .8));
    // Right veins
    final v3 = Path()
      ..moveTo(er - ew * .15, cy - eh * .05)
      ..quadraticBezierTo(
          er - ew * .28, cy - eh * .15, er - ew * .38, cy - eh * .05);
    canvas.drawPath(
        v3,
        veinPaint
          ..color = const Color(0xFFB45050).withOpacity(veinOpacity * .9));
    canvas.restore();

    // Iris
    final ir = eh * .42; // iris radius
    canvas.save();
    canvas.clipPath(eyePath);
    canvas.drawCircle(
        Offset(cx, cy),
        ir,
        Paint()
          ..shader = RadialGradient(
            center: const Alignment(-.25, -.3),
            radius: .62,
            colors: const [
              Color(0xFFA0C8FF),
              Color(0xFF4878E8),
              Color(0xFF1838B0),
              Color(0xFF080E50),
            ],
            stops: const [0.0, .40, .75, 1.0],
          ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: ir)));

    // Iris detail rings
    canvas.drawCircle(
        Offset(cx, cy),
        ir,
        Paint()
          ..color = const Color(0xFF5090FF).withOpacity(.25 * irisOpacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = scl);
    canvas.drawCircle(
        Offset(cx, cy),
        ir * .80,
        Paint()
          ..color = const Color(0xFF5090FF).withOpacity(.20 * irisOpacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = scl * .8);
    canvas.restore();

    // Pupil
    final pr = ir * .50 * pupilScale;
    canvas.save();
    canvas.clipPath(eyePath);
    canvas.drawCircle(
        Offset(cx, cy),
        pr,
        Paint()
          ..shader = RadialGradient(
            center: const Alignment(-.3, -.3),
            colors: const [Color(0xFF1A1A3A), Color(0xFF000010)],
          ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: pr)));
    canvas.restore();

    // Shine 1 — large
    canvas.save();
    canvas.clipPath(eyePath);
    canvas.save();
    canvas.translate(cx - 14 * scl, cy - 12 * scl);
    canvas.rotate(-20 * math.pi / 180);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: 9 * scl, height: 6 * scl),
      Paint()..color = Colors.white.withOpacity(.70),
    );
    canvas.restore();
    // Shine 2 — micro glint
    canvas.drawCircle(
      Offset(cx - 17 * scl, cy - 16 * scl),
      1.8 * scl,
      Paint()..color = Colors.white.withOpacity(.88),
    );
    canvas.restore();

    // Eye outline
    canvas.drawPath(
        eyePath,
        Paint()
          ..color = const Color(0xFF64A0FF).withOpacity(.35)
          ..style = PaintingStyle.stroke
          ..strokeWidth = scl * 1.2);

    // Lashes — top
    final lashPaint = Paint()
      ..color = const Color(0xFF8CB4FF).withOpacity(.55)
      ..strokeWidth = scl * 1.2
      ..strokeCap = StrokeCap.round;

    // 6 lashes evenly distributed along top lid
    final lashAngles = [-60.0, -40.0, -18.0, 0.0, 18.0, 40.0];
    for (final la in lashAngles) {
      final lx = cx + math.sin(la * math.pi / 180) * ew * .45;
      final ly = cy - eh * (.5 + (1 - (la.abs() / 70)) * .1);
      final ex2 = lx + math.sin(la * math.pi / 180) * scl * 5;
      final ey2 = ly - scl * 9;
      canvas.drawLine(Offset(lx, ly), Offset(ex2, ey2), lashPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _YWEyePainter o) =>
      o.innerGlow != innerGlow ||
      o.outerGlow != outerGlow ||
      o.eyeGlow != eyeGlow ||
      o.pupilScale != pupilScale ||
      o.irisOpacity != irisOpacity ||
      o.veinOpacity != veinOpacity ||
      o.orbit1T != orbit1T ||
      o.orbit2T != orbit2T ||
      o.orbit3T != orbit3T;
}

// ─── Nebula ───────────────────────────────────────────────────────────
class _YWNebula extends StatefulWidget {
  final Color color;
  final Alignment alignment;
  final double size;
  final int delay;
  const _YWNebula(
      {required this.color,
      required this.alignment,
      required this.size,
      this.delay = 0});
  @override
  State<_YWNebula> createState() => _YWNebulaState();
}

class _YWNebulaState extends State<_YWNebula>
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
class _YWParticle extends StatefulWidget {
  final double xF, yF, sz;
  final int shape, durMs, delayMs;
  const _YWParticle(
      {required this.xF,
      required this.yF,
      required this.sz,
      required this.shape,
      required this.durMs,
      required this.delayMs});
  @override
  State<_YWParticle> createState() => _YWParticleState();
}

class _YWParticleState extends State<_YWParticle>
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
class _YWStarPainter extends CustomPainter {
  final List<List<double>> stars;
  final List<double> starOpacities;
  final double shootT;
  final List<List<double>> shoots;
  final Size canvasSize;

  const _YWStarPainter({
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
  bool shouldRepaint(covariant _YWStarPainter o) =>
      o.shootT != shootT || o.starOpacities != starOpacities;
}

class The_Yellow_WallPaper extends StatefulWidget {
  const The_Yellow_WallPaper({super.key});

  @override
  State<The_Yellow_WallPaper> createState() => _The_Yellow_WallPaperState();
}

class _The_Yellow_WallPaperState extends State<The_Yellow_WallPaper> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is postpartum depression (PPD)?",
      "options": [
        "A) A short period of sadness, known as 'baby blues,' that lasts for a few days after childbirth.",
        "B) A serious medical condition that is a form of major depression linked to childbirth.",
        "C) A form of anxiety that is only experienced by mothers who have had a difficult delivery.",
        "D) A psychological disorder that is cured with rest and a change of scenery."
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. 'Baby blues' is temporary and not the same as PPD.",
        " Correct! Postpartum depression is a specific type of major depression that occurs after a woman gives birth.",
        " Incorrect. PPD is not limited to anxiety or to mothers with difficult deliveries.",
        " Incorrect. PPD requires proper treatment, not just rest."
      ]
    },
    {
      "question": "How is PPD different from the 'baby blues'?",
      "options": [
        "A) PPD lasts for months.",
        "B) PPD is less common.",
        "C) 'Baby blues' is more severe.",
        "D) 'Baby blues' can only be treated with medication."
      ],
      "correct": 0,
      "feedback": [
        " Correct! 'Baby blues' usually fade within weeks, while PPD can last for months or more.",
        " Incorrect. PPD is not simply about frequency but duration and severity.",
        " Incorrect. 'Baby blues' are not more severe than PPD.",
        " Incorrect. 'Baby blues' do not typically require medication."
      ]
    },
    {
      "question": "What is a common symptom of PPD?",
      "options": [
        "A) Feeling very happy.",
        "B) A desire to spend time with others.",
        "C) Feeling disconnected from the baby.",
        "D) Having more energy."
      ],
      "correct": 2,
      "feedback": [
        " Incorrect. PPD is not associated with excessive happiness.",
        " Incorrect. People with PPD often withdraw rather than seek company.",
        "💙 Correct! A key symptom of PPD is feeling detached or lacking interest in the baby.",
        " Incorrect. Fatigue and low energy are more typical of PPD."
      ]
    },
    {
      "question": "Who can get PPD?",
      "options": [
        "A) Only mothers.",
        "B) Only new mothers.",
        "C) Only people with a history of mental health issues.",
        "D) Anyone who has recently had a baby."
      ],
      "correct": 3,
      "feedback": [
        " Incorrect. Fathers and adoptive parents can also experience PPD.",
        " Incorrect. PPD can affect anyone after childbirth, not just biological mothers.",
        " Incorrect. PPD can occur even without prior mental health issues.",
        " Correct! PPD can affect any new parent, regardless of gender or history."
      ]
    },
    {
      "question": "What is the best first step if you think you have PPD?",
      "options": [
        "A) Wait for it to go away.",
        "B) Hide your feelings from others.",
        "C) Talk to a doctor or a therapist.",
        "D) Look for answers online."
      ],
      "correct": 2,
      "feedback": [
        " Incorrect. Waiting may worsen symptoms without help.",
        " Incorrect. Hiding emotions can increase isolation.",
        "💛 Correct! Seeking professional help ensures proper diagnosis and treatment.",
        " Incorrect. Online information cannot replace professional care."
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
                    title: "The yellow wallpaper",
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
It is very rare for ordinary people like John and me to rent an old, grand house for the summer.

A colonial mansion, a family estate, I would even say a haunted house—that would be the height of romantic happiness. But that would be asking too much from fate!

Still, I will proudly say that there is something strange about this house.

Otherwise, why would it be rented so cheaply? And why has it been empty for so long?

John laughs at me, of course, but that’s what you expect in marriage.

John is extremely practical. He has no patience for faith, hates superstition, and openly mocks anything that can’t be seen, touched, or measured.

John is a doctor, and perhaps—(I wouldn’t say this to anyone else, of course, but this is just paper and a great relief to my mind)—perhaps that’s one reason I’m not getting better faster.

You see, he doesn’t believe I’m sick!

And what can I do?

If a highly respected doctor, and my own husband, tells friends and family that there’s nothing wrong with me except temporary nervous depression—a slight hysterical tendency—what can I do?

My brother is also a doctor, and also highly respected, and he says the same thing.

So I take phosphates or phosphites—whichever it is—and tonics, and go on trips, and get fresh air, and exercise, and I’m absolutely forbidden to “work” until I’m well again.

Personally, I disagree with their ideas.

Personally, I believe that enjoyable work, with excitement and change, would do me good.

But what can I do?

I did write for a while despite them, but it exhausts me a lot—having to be so secret about it, or else face strong opposition.

Sometimes I think that in my condition, if I had less opposition and more company and stimulation—but John says the worst thing I can do is think about my condition, and I admit it always makes me feel worse.


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
                  child: Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 12, 137, 193),
                      ),
                      onPressed: _goToQuestions,
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.black),
                      label: const Text(
                        "Go to Questions",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
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
        "Where is the narrator most likely spending her time in the passage?",
    options: [
      "A) In a busy hospital",
      "B) In a summer old rental house",
      "C) In a city apartment near social gatherings",
      "D) In a crowded café or marketplace"
    ],
    correctIndex: 1,
    explanation:
        "She talks about renting an 'old, grand house for the summer' and describes the house as empty and cheap, so we infer the setting is a secluded summer home.",
    incorrectExplanations: [
      "She isn’t in a hospital or medical facility.",
      "Correct answer!",
      "She avoids social settings; this is inconsistent with the story.",
      "There is no mention of her being in public spaces."
    ],
  ),
  QuestionData(
    question: "When does the narrator engage in secret writing?",
    options: [
      "A) During public events and social visits",
      "B) Randomly with no connection to her schedule",
      "C) Only during daylight in outdoor gardens",
      "D) At times when her husband or family are not watching"
    ],
    correctIndex: 3,
    explanation:
        "She mentions writing 'secretly' because of strong opposition, so we infer she chooses times when others aren’t around, and that it happens repeatedly.",
    incorrectExplanations: [
      "She avoids public settings.",
      "It’s not random; she writes intentionally in private.",
      "She writes indoors, not outdoors.",
      "Correct answer!"
    ],
  ),
  QuestionData(
    question:
        "What method or “tool” does the narrator use to follow her doctor’s treatment plan?",
    options: [
      "A) She uses only her intuition and avoids medical advice",
      "B) She uses writing and work as a primary form of treatment",
      "C) She consults only her husband without taking any medicine",
      "D) She takes phosphates or phosphites, and exercises as prescribed"
    ],
    correctIndex: 3,
    explanation:
        "Although she doubts it, she follows the treatment plan prescribed by doctors, so we infer the 'tools' are medicine, rest, and controlled activity.",
    incorrectExplanations: [
      "She doesn’t rely on intuition or reject medical advice.",
      "Her writing is done secretly, not as prescribed therapy.",
      "Her husband consults doctors, but medicine is still part of her routine.",
      "Correct answer!"
    ],
  ),
  QuestionData(
    question:
        "Who is controlling the narrator’s daily activities and decisions about her work?",
    options: [
      "A) The narrator herself, independently choosing what she wants",
      "B) John, her husband, and her brother",
      "C) Her friends, who encourage her secret writing",
      "D) Neighbors, who oversee the household"
    ],
    correctIndex: 1,
    explanation:
        "She repeatedly references her husband and brother’s authority, implying they are responsible for regulating her routine and forbidding certain activities.",
    incorrectExplanations: [
      "She has very little autonomy in the story.",
      "Correct answer!",
      "Her friends are not involved in her confinement or writing restrictions.",
      "Neighbors play no role in her supervision."
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
  late Animation<double> _fadeAnimation;

  final String biographyTextSecond = '''
So I’ll stop talking about that and talk about the house instead.

It’s the most beautiful place! It’s very private, set far back from the road, about three miles from the village. It reminds me of English estates you read about, with hedges, walls, and locked gates, and many small houses for gardeners and workers.

There’s a wonderful garden! I’ve never seen such a garden—large and shady, with paths lined by boxwood, and long grape-covered arbors with seats underneath.

There were greenhouses too, but they’re all broken now.

I believe there was some legal trouble, something about the heirs; anyway, the place has been empty for years.

That ruins the idea of it being haunted, I’m afraid, but I don’t care—there’s something strange about the house—I can feel it.

I even told John this one moonlit evening, but he said what I felt was a draft and closed the window.

I sometimes get unreasonably angry with John. I’m sure I wasn’t so sensitive before. I think it’s because of this nervous condition.

But John says if I feel this way, I’m neglecting self-control; so I try hard to control myself—at least in front of him—and that makes me very tired.

I don’t like our room at all. I wanted one downstairs that opened onto the porch and had roses all over the window, and pretty old-fashioned chintz curtains! But John wouldn’t allow it.

He said there was only one window and not enough room for two beds, and no nearby room for him if he took another.

He is very careful and loving, and hardly lets me move without specific instructions.

I have a schedule for every hour of the day; he takes all responsibility from me, and so I feel terribly ungrateful for not appreciating it more.

He said we came here only for my sake, so I could have perfect rest and all the fresh air I needed. “Your exercise depends on your strength, my dear,” he said, “and your food somewhat on your appetite; but you can always breathe fresh air.” So we took the nursery, at the top of the house.

It’s a big, airy room, almost the entire floor, with windows on all sides, and plenty of air and sunlight. It was first a nursery, then a playroom and gymnasium, I think, because the windows are barred for little children, and there are rings and things in the walls.

The paint and wallpaper look like they were used by a boys’ school. The wallpaper is torn off in large patches around the head of my bed, as far as I can reach, and in a big spot on the other side of the room, low down. I’ve never seen worse wallpaper in my life.

It’s one of those sprawling, flashy patterns that breaks every rule of art.

It’s dull enough to confuse the eye, but bold enough to constantly irritate and provoke study. When you follow the awkward, shaky curves for a while, they suddenly turn sharply and destroy themselves in impossible ways.

The color is disgusting, almost revolting; a dirty, faded yellow, strangely dulled by the slow-turning sunlight.

In some places, it’s a dull yet bright orange; in others, a sickly yellow.

No wonder the children hated it! I’d hate it too if I had to live in this room for long.
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
                Text(
                  biographyTextSecond,
                  style: const TextStyle(fontSize: 18, height: 1.6),
                ),
                const SizedBox(height: 32),
                AnimatedOpacity(
                  opacity: showButton ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  child: Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 12, 137, 193),
                      ),
                      onPressed: _goToQuestions,
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.black),
                      label: const Text(
                        "Go to Questions",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
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
    question: "Where is the narrator’s bedroom located in the house?",
    options: [
      "A) On the ground floor, opening directly onto a garden porch",
      "B) At the top floor, in a large, airy room",
      "C) In a small, dark room near the kitchen",
      "D) In a secluded basement with little sunlight"
    ],
    correctIndex: 1,
    explanation:
        "She says they 'took the nursery, at the top of the house,' which has windows on all sides and plenty of sunlight.",
    incorrectExplanations: [
      "There’s no mention of a garden porch room.",
      "Correct answer!",
      "She’s not staying near the kitchen.",
      "It’s bright and airy, not dark or basement-like."
    ],
  ),
  QuestionData(
    question:
        "When does the narrator describe discussing the strange feeling in the house with John?",
    options: [
      "A) On a bright, sunny afternoon",
      "B) On a moonlit evening",
      "C) Early in the morning before breakfast",
      "D) During a stormy night"
    ],
    correctIndex: 1,
    explanation:
        "She explicitly mentions telling John 'this one moonlit evening,' showing the setting of their conversation.",
    incorrectExplanations: [
      "It wasn’t daytime or bright.",
      "Correct answer!",
      "No mention of morning events in that context.",
      "There was no storm when this occurred."
    ],
  ),
  QuestionData(
    question:
        "What feature of the room shows that it was originally designed for children?",
    options: [
      "A) Its large windows and sunlight",
      "B) Barred windows, and gym-like features",
      "C) The beautiful garden visible from the room",
      "D) The high ceiling and airy space"
    ],
    correctIndex: 1,
    explanation:
        "She notices 'the windows are barred for little children, and there are rings and things in the walls,' implying a child-friendly design.",
    incorrectExplanations: [
      "Those describe light, not child-related design.",
      "Correct answer!",
      "The garden view is unrelated to children’s safety.",
      "The high ceiling doesn’t suggest a nursery."
    ],
  ),
  QuestionData(
    question:
        "What does the narrator’s relationship with John suggest about authority within their marriage?",
    options: [
      "A) John holds primary authority in the marriage, adopting a paternal role and expecting the narrator’s obedience",
      "B) Authority in the marriage is shared equally, with both partners influencing decisions",
      "C) The narrator holds greater authority, directing decisions about her own life and care",
      "D) Neither partner exercises authority, as their marriage is based on complete independence"
    ],
    correctIndex: 0,
    explanation:
        "John’s actions reflect a caretaker role, controlling her environment and expecting her to comply, reflecting the husband-wife dynamics and gender norms.",
    incorrectExplanations: [
      "Correct answer!",
      "She lacks autonomy and is under his control.",
      "Their relationship is hierarchical, not equal.",
      "They are married, not simply sharing space casually."
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
  late Animation<double> _fadeAnimation;

  final String biographyTextSecond = '''
Here comes John, and I must put this away—he hates when I write.

We’ve been here two weeks, and I haven’t felt like writing before, since that first day.

I’m sitting by the window now, up in this awful nursery, and there’s nothing to stop me from writing as much as I want, except my lack of strength.

John is away all day, and sometimes at night when his cases are serious.

I’m glad my case isn’t serious!

But these nervous problems are terribly depressing.

John doesn’t know how much I really suffer. He knows there’s no reason to suffer, and that’s enough for him.

Of course, it’s just nervousness. It weighs on me so much not to be able to do my duty in any way!

I wanted to be such a help to John, such a real source of rest and comfort, and here I am, already a burden!

No one would believe how hard it is to do the little I can—to dress, entertain, and manage things.

It’s lucky Mary is so good with the baby. Such a dear baby!

And yet I can’t be with him; it makes me too nervous.

I don’t think John has ever been nervous in his life. He laughs at me so much about this wallpaper!

At first, he planned to change the wallpaper, but later he said I was letting it bother me too much, and that nothing was worse for a nervous patient than to give in to such ideas.
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
                  child: Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 12, 137, 193),
                      ),
                      onPressed: _goToQuestions,
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.black),
                      label: const Text(
                        "Go to Questions",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
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

final List<QuestionData> sampleQuestionsThird = [
  QuestionData(
    question: "Where is the narrator writing in the house?",
    options: [
      "A) In a small, cozy bedroom downstairs",
      "B) On a balcony overlooking the garden",
      "C) Up in the nursery at the top of the house",
      "D) In the living room near the entrance"
    ],
    correctIndex: 2,
    explanation:
        "She says, 'I’m sitting by the window now, up in this awful nursery.'",
    incorrectExplanations: [
      "Correct answer!",
      "The nursery is not downstairs or near the entrance.",
      "She clearly mentions being in the nursery at the top of the house.",
      "There is no mention of a balcony or garden view."
    ],
  ),
  QuestionData(
    question: "When does the narrator find the opportunity to write?",
    options: [
      "A) Only in the mornings before John wakes up",
      "B) While John is away during the day and sometimes at night",
      "C) Constantly, without worrying about John or her brother",
      "D) Only on weekends when the household is quiet"
    ],
    correctIndex: 1,
    explanation:
        "She notes, 'John is away all day, and sometimes at night when his cases are serious.'",
    incorrectExplanations: [
      "Correct answer!",
      "She writes in secret while John is gone.",
      "She cannot write constantly due to John’s control.",
      "There is no mention of weekends as writing time."
    ],
  ),
  QuestionData(
    question:
        "How would you describe the relationship between the narrator and John based on this passage?",
    options: [
      "A) Equal partners sharing responsibilities",
      "B) Friends with no social hierarchy",
      "C) Distant acquaintances with minimal interaction",
      "D) Protective and controlling"
    ],
    correctIndex: 3,
    explanation:
        "John dismisses her concerns about the wallpaper and limits her writing, reflecting a controlling, paternalistic role.",
    incorrectExplanations: [
      "Correct answer!",
      "Their relationship lacks equality or friendship.",
      "They are not distant but rather in a dominant–submissive dynamic.",
      "John exercises authority over her decisions."
    ],
  ),
  QuestionData(
    question:
        "What is the main tool or activity the narrator uses to cope with her nervousness?",
    options: [
      "A) Cooking and housekeeping",
      "B) Writing in her journal",
      "C) Gardening in the estate",
      "D) Talking to Mary about the baby"
    ],
    correctIndex: 1,
    explanation:
        "She explicitly mentions writing as an outlet: 'there’s nothing to stop me from writing as much as I want.'",
    incorrectExplanations: [
      "Correct answer!",
      "Her relief comes from expressing herself through writing, not chores.",
      "Gardening or talking to Mary are never described as coping methods.",
      "Writing in secret helps her manage her emotions."
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
        MaterialPageRoute(builder: (_) => BiographyReadingPageFinal()),
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

class BiographyReadingPageFinal extends StatefulWidget {
  const BiographyReadingPageFinal({super.key});

  @override
  State<BiographyReadingPageFinal> createState() =>
      _BiographyReadingPageFinalState();
}

class _BiographyReadingPageFinalState extends State<BiographyReadingPageFinal>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;
  int _lastQuestionIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final String biographyTextSecond = '''
He said that after the wallpaper, it would be the heavy bed, then the barred windows, then the gate at the top of the stairs, and so on.

“You know the place is doing you good,” he said, “and really, dear, I don’t want to fix up the house just for a three-month rental.”

“Then let’s go downstairs,” I said, “there are such pretty rooms there.”

Then he hugged me and called me a silly goose, and said he’d even go down to the cellar if I wanted, and have it whitewashed too.

But he’s right about the beds and windows and things.

It’s as airy and comfortable a room as anyone could want, and of course, I wouldn’t be so silly as to make him uncomfortable just for a whim.

I’m really starting to like the big room, except for that horrible wallpaper.

From one window, I can see the garden, those mysterious shaded arbors, the wild old-fashioned flowers, and the twisted trees.

From another, I get a lovely view of the bay and a small private dock belonging to the estate. There’s a beautiful shaded path leading down to it from the house. I often imagine I see people walking on the paths and in the arbors, but John has warned me not to let my imagination run wild. He says that with my creative mind and habit of making up stories, a nervous condition like mine is sure to lead to all kinds of wild ideas, and that I should use my willpower and common sense to stop it. So I try.

Sometimes I think that if I were well enough to write a little, it would help me relax and clear my mind.

But I get very tired when I try.

It’s so discouraging not to have any advice or companionship about my work. When I’m truly well, John says we’ll invite Cousin Henry and Julia for a long visit, but he says having such stimulating people around now would be like putting fireworks in my pillow.

I wish I could get better faster.

But I mustn’t think about that. This wallpaper seems to know how bad it is!
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
        builder: (_) => QuestionPageFinal(
          questions: sampleQuestionsFinal,
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
                  child: Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 12, 137, 193),
                      ),
                      onPressed: _goToQuestions,
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.black),
                      label: const Text(
                        "Go to Questions",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
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

final List<QuestionData> sampleQuestionsFinal = [
  QuestionData(
    question:
        "When does the narrator hope to have visitors like Cousin Henry and Julia?",
    options: [
      "A) As soon as they arrive at the house",
      "B) Only when she is fully well",
      "C) During the evenings to avoid distraction",
      "D) Immediately, to lift her spirits"
    ],
    correctIndex: 1,
    explanation:
        "She says, 'When I’m truly well, John says we’ll invite Cousin Henry and Julia…'",
    incorrectExplanations: [
      "Correct answer!",
      "She is only allowed visitors once she is 'well enough,' showing John’s control.",
      "There is no mention of evening visits or immediate invitations.",
      "Her wish for company is postponed until John approves."
    ],
  ),
  QuestionData(
    question:
        "Who is responsible for maintaining the house and deciding what changes are made?",
    options: [
      "A) John, who controls what should be fixed",
      "B) The narrator herself, making all decisions",
      "C) The household staff, following her directions",
      "D) Cousin Henry, who manages the estate"
    ],
    correctIndex: 0,
    explanation:
        "John comments on what needs to be fixed and cautions her about 'wild ideas,' showing his control.",
    incorrectExplanations: [
      "Correct answer!",
      "The narrator has little say over the house.",
      "There is no mention of household staff taking her orders.",
      "Cousin Henry does not manage the estate."
    ],
  ),
  QuestionData(
    question:
        "What activity does the narrator feel might help her relax, if she could do it?",
    options: [
      "A) Walking in the garden",
      "B) Writing",
      "C) Inviting guests",
      "D) Painting the walls"
    ],
    correctIndex: 1,
    explanation:
        "She notes, 'Sometimes I think that if I were well enough to write a little, it would help me relax and clear my mind.'",
    incorrectExplanations: [
      "Correct answer!",
      "Writing is her main emotional outlet, though it’s restricted by John.",
      "She is not permitted to have guests or paint the room.",
      "Walking is mentioned but not as her main wish."
    ],
  ),
  QuestionData(
    question: "Which features can the narrator see from her windows?",
    options: [
      "A) The garden, shaded arbors, flowers, and twisted trees",
      "B) Only the nearby garden and house walls",
      "C) The village road and other houses",
      "D) A forest, a lake and some distant mountains"
    ],
    correctIndex: 0,
    explanation:
        "She describes multiple elements visible from different windows: garden paths, bay, dock, and arbors.",
    incorrectExplanations: [
      "Correct answer!",
      "Her description includes many outdoor details, not just the nearby garden.",
      "There is no mention of a village or distant mountains.",
      "Her focus is on the natural scenery around the house."
    ],
  ),
];

class QuestionPageFinal extends StatefulWidget {
  final List<QuestionData> questions;
  final int startIndex;

  const QuestionPageFinal(
      {super.key, required this.questions, this.startIndex = 0});

  @override
  State<QuestionPageFinal> createState() => _QuestionPageFinalState();
}

class _QuestionPageFinalState extends State<QuestionPageFinal> {
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