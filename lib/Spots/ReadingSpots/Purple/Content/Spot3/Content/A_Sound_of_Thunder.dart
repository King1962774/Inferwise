import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Purple/Content/Spot3/Spot_Page/Reading_Spot.dart';

import 'dart:math' as math;


class ThunderSplashScreen extends StatefulWidget {
  const ThunderSplashScreen({super.key});

  @override
  State<ThunderSplashScreen> createState() => _ThunderSplashScreenState();
}

class _ThunderSplashScreenState extends State<ThunderSplashScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgCtrl;
  late AnimationController _iconCtrl;
  late AnimationController _clockFloatCtrl;
  late AnimationController _glowCtrl;
  late AnimationController _hourHandCtrl;
  late AnimationController _minHandCtrl;
  late AnimationController _boltCtrl;
  late AnimationController _ripple1Ctrl;
  late AnimationController _ripple2Ctrl;
  late AnimationController _ripple3Ctrl;
  late AnimationController _orbit1Ctrl;
  late AnimationController _orbit2Ctrl;
  late AnimationController _orbit3Ctrl;
  late AnimationController _starsCtrl;
  late AnimationController _shootCtrl;
  late AnimationController _textCtrl;

  late Animation<double> _bgFade;
  late Animation<double> _iconScale;
  late Animation<double> _iconRotate;

  // Clock float — 3-point asymmetric
  late Animation<double> _clockFloatY;
  late Animation<double> _clockFloatR;

  late Animation<double> _innerGlow, _outerGlow, _clockGlow;

  // Clock hands
  late Animation<double> _hourAngle;
  late Animation<double> _minAngle;

  // Bolt flash — opacity + glow
  late Animation<double> _boltOpacity;

  // Time ripples: scale + opacity
  late Animation<double> _ripple1Scale, _ripple1Opacity;
  late Animation<double> _ripple2Scale, _ripple2Opacity;
  late Animation<double> _ripple3Scale, _ripple3Opacity;

  late Animation<double> _titleOpacity, _titleSlide;
  late Animation<double> _authorOpacity;
  late Animation<double> _dividerOpacity, _dividerScale;

  final List<Animation<double>> _starAnim = [];

  static const List<List<double>> _stars = [
    [.07,.03,1.0,2.2,.0,0],[.28,.05,1.0,2.9,.3,0],[.52,.02,.75,2.5,.6,0],
    [.76,.04,1.25,2.0,.9,0],[.92,.08,.75,3.1,.2,0],[.14,.12,.75,2.7,.5,0],
    [.44,.10,.50,2.3,1.0,0],[.65,.07,1.0,3.3,.7,0],[.85,.15,.50,2.1,.4,0],
    [.05,.18,1.0,2.8,1.2,0],[.38,.20,.75,2.4,.8,0],[.72,.22,.75,3.0,.3,0],
    [.95,.25,.50,1.9,1.1,0],[.04,.60,.75,2.6,.6,0],[.25,.64,1.0,2.2,.9,0],
    [.58,.68,.50,3.2,.4,0],[.82,.72,1.0,2.0,1.3,0],[.42,.76,.50,2.9,.7,0],
    [.16,.80,.75,2.5,.2,0],[.68,.85,.50,2.7,1.0,0],[.90,.89,.75,3.1,.5,0],
    [.33,.93,.50,2.3,.8,0],
    [.36,.06,4.5,2.6,.4,1],[.91,.18,3.5,3.0,.9,1],[.12,.76,4.0,2.8,1.2,1],
  ];

  static const List<List<double>> _shoots = [
    [.09,.12,100,2.0],
    [.28,.06, 65,7.0],
  ];

  static const List<List<double>> _orbitStars = [
    [1,  0,74,2.5],[1, 90,74,2.0],[1,180,74,2.5],[1,270,74,2.0],
    [2,  0,84,2.0],[2, 72,84,1.5],[2,144,84,2.5],[2,216,84,1.5],[2,288,84,2.0],
    [3,  0,58,3.0],[3,120,58,2.0],[3,240,58,2.5],
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
    _iconScale = Tween<double>(begin: .35, end: 1.0).animate(
        CurvedAnimation(parent: _iconCtrl, curve: Curves.elasticOut));
    _iconRotate = Tween<double>(begin: -10 * math.pi / 180, end: 0).animate(
        CurvedAnimation(parent: _iconCtrl, curve: Curves.easeOut));
    Future.delayed(const Duration(milliseconds: 200),
        () { if (mounted) _iconCtrl.forward(); });

    // Clock float — 3-point asymmetric
    _clockFloatCtrl = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this)
      ..repeat();
    _clockFloatY = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: -5.0)
              .chain(CurveTween(curve: Curves.easeInOut)), weight: 33),
      TweenSequenceItem(
          tween: Tween<double>(begin: -5.0, end: -8.0)
              .chain(CurveTween(curve: Curves.easeInOut)), weight: 33),
      TweenSequenceItem(
          tween: Tween<double>(begin: -8, end: 0)
              .chain(CurveTween(curve: Curves.easeInOut)), weight: 34),
    ]).animate(_clockFloatCtrl);
    _clockFloatR = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 0, end: -2 * math.pi / 180)
              .chain(CurveTween(curve: Curves.easeInOut)), weight: 33),
      TweenSequenceItem(
          tween: Tween(begin: -2 * math.pi / 180, end: 2 * math.pi / 180)
              .chain(CurveTween(curve: Curves.easeInOut)), weight: 33),
      TweenSequenceItem(
          tween: Tween<double>(begin: 2 * math.pi / 180, end: 0)
              .chain(CurveTween(curve: Curves.easeInOut)), weight: 34),
    ]).animate(_clockFloatCtrl);

    // Glow
    _glowCtrl = AnimationController(
        duration: const Duration(milliseconds: 3500), vsync: this)
      ..repeat(reverse: true);
    _innerGlow = Tween<double>(begin: .16, end: .36).animate(
        CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));
    _outerGlow = Tween<double>(begin: .10, end: .22).animate(
        CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));
    _clockGlow = Tween<double>(begin: .28, end: .55).animate(
        CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));

    // Hour hand — 12s
    _hourHandCtrl = AnimationController(
        duration: const Duration(milliseconds: 12000), vsync: this)
      ..repeat();
    _hourAngle = Tween<double>(begin: 0, end: 2 * math.pi)
        .animate(_hourHandCtrl);

    // Minute hand — 3s
    _minHandCtrl = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this)
      ..repeat();
    _minAngle = Tween<double>(begin: 0, end: 2 * math.pi)
        .animate(_minHandCtrl);

    // Bolt flash — 2.5s
    _boltCtrl = AnimationController(
        duration: const Duration(milliseconds: 2500), vsync: this)
      ..repeat();
    _boltOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(.70), weight: 85),
      TweenSequenceItem(tween: Tween(begin: .70, end: 1.0), weight: 3),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: .85), weight: 4),
      TweenSequenceItem(tween: Tween(begin: .85, end: .70), weight: 8),
    ]).animate(_boltCtrl);

    // Time ripples — 2.4s each, staggered
    _ripple1Ctrl = AnimationController(
        duration: const Duration(milliseconds: 2400), vsync: this)..repeat();
    _ripple1Scale   = Tween<double>(begin: .6, end: 2.2).animate(
        CurvedAnimation(parent: _ripple1Ctrl, curve: Curves.easeOut));
    _ripple1Opacity = Tween<double>(begin: .55, end: 0).animate(
        CurvedAnimation(parent: _ripple1Ctrl, curve: Curves.easeOut));

    _ripple2Ctrl = AnimationController(
        duration: const Duration(milliseconds: 2400), vsync: this)..repeat();
    _ripple2Scale   = Tween<double>(begin: .6, end: 2.2).animate(
        CurvedAnimation(parent: _ripple2Ctrl, curve: Curves.easeOut));
    _ripple2Opacity = Tween<double>(begin: .40, end: 0).animate(
        CurvedAnimation(parent: _ripple2Ctrl, curve: Curves.easeOut));
    _ripple2Ctrl.value = .8 / 2.4;

    _ripple3Ctrl = AnimationController(
        duration: const Duration(milliseconds: 2400), vsync: this)..repeat();
    _ripple3Scale   = Tween<double>(begin: .6, end: 2.2).animate(
        CurvedAnimation(parent: _ripple3Ctrl, curve: Curves.easeOut));
    _ripple3Opacity = Tween<double>(begin: .30, end: 0).animate(
        CurvedAnimation(parent: _ripple3Ctrl, curve: Curves.easeOut));
    _ripple3Ctrl.value = 1.6 / 2.4;

    // Orbits
    _orbit1Ctrl = AnimationController(
        duration: const Duration(milliseconds: 8000), vsync: this)..repeat();
    _orbit2Ctrl = AnimationController(
        duration: const Duration(milliseconds: 13000), vsync: this)..repeat();
    _orbit3Ctrl = AnimationController(
        duration: const Duration(milliseconds: 18000), vsync: this)..repeat();

    // Stars
    _starsCtrl = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this)..repeat();
    for (int i = 0; i < _stars.length; i++) {
      final delay = _stars[i][4];
      _starAnim.add(Tween<double>(begin: .85, end: .08).animate(
        CurvedAnimation(
          parent: _starsCtrl,
          curve: Interval(
            (delay / 4.0).clamp(0.0, .9), 1.0,
            curve: Curves.easeInOut,
          ),
        ),
      ));
    }

    _shootCtrl = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this)..repeat();

    // Text
    _textCtrl = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    _dividerOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _textCtrl,
            curve: const Interval(.0, .6, curve: Curves.easeOut)));
    _dividerScale   = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _textCtrl,
            curve: const Interval(.0, .6, curve: Curves.easeOut)));
    _titleOpacity   = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut));
    _titleSlide     = Tween<double>(begin: 16, end: 0).animate(
        CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut));
    _authorOpacity  = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _textCtrl,
            curve: const Interval(.4, 1.0, curve: Curves.easeOut)));
    Future.delayed(const Duration(milliseconds: 750),
        () { if (mounted) _textCtrl.forward(); });

    // Navigate
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const Thunder()));
    });
  }

  @override
  void dispose() {
    _bgCtrl.dispose();
    _iconCtrl.dispose();
    _clockFloatCtrl.dispose();
    _glowCtrl.dispose();
    _hourHandCtrl.dispose();
    _minHandCtrl.dispose();
    _boltCtrl.dispose();
    _ripple1Ctrl.dispose();
    _ripple2Ctrl.dispose();
    _ripple3Ctrl.dispose();
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
                Color(0xFF080F1E), Color(0xFF040A18),
                Color(0xFF020610), Color(0xFF010306),
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
                        Colors.transparent, Color(0x05142878),
                        Color(0x081E3CA0), Color(0x05142878),
                        Colors.transparent,
                      ],
                      stops: [0.0, .20, .38, .60, 1.0],
                    ),
                  ),
                ),
              ),
            ),

            // Nebulae
            _TNebula(color: const Color(0xFF0A1964),
                alignment: const Alignment(-1.0, -.85), size: 400),
            _TNebula(color: const Color(0xFF052882),
                alignment: const Alignment(1.0, .80), size: 300, delay: 2000),
            _TNebula(color: const Color(0xFF140A78),
                alignment: const Alignment(.80, .20), size: 220, delay: 4000),

            // Star field
            AnimatedBuilder(
              animation: Listenable.merge([_starsCtrl, _shootCtrl]),
              builder: (_, __) => CustomPaint(
                painter: _TStarPainter(
                  stars: _stars,
                  starOpacities: List.generate(
                      _stars.length, (i) => _starAnim[i].value),
                  shootT: _shootCtrl.value,
                  shoots: _shoots,
                  canvasSize: size,
                ),
                size: size,
              ),
            ),

            // Floating particles
            _TParticle(xF:.18,yF:.20,sz:5,shape:0,durMs:3400,delayMs:0),
            _TParticle(xF:.84,yF:.22,sz:4,shape:1,durMs:2900,delayMs:500),
            _TParticle(xF:.11,yF:.43,sz:3,shape:0,durMs:4000,delayMs:900),
            _TParticle(xF:.87,yF:.41,sz:4,shape:1,durMs:3100,delayMs:300),
            _TParticle(xF:.22,yF:.27,sz:5,shape:2,durMs:3600,delayMs:700),
            _TParticle(xF:.80,yF:.38,sz:4,shape:3,durMs:2800,delayMs:1100),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Clock + Bolt icon
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _iconCtrl, _clockFloatCtrl, _glowCtrl,
                      _hourHandCtrl, _minHandCtrl, _boltCtrl,
                      _ripple1Ctrl, _ripple2Ctrl, _ripple3Ctrl,
                      _orbit1Ctrl, _orbit2Ctrl, _orbit3Ctrl,
                    ]),
                    builder: (_, __) {
                      final floatY = _iconCtrl.isCompleted
                          ? _clockFloatY.value : 0.0;
                      final floatR = _iconCtrl.isCompleted
                          ? _clockFloatR.value : _iconRotate.value;
                      return Transform.translate(
                        offset: Offset(0, floatY),
                        child: Transform.rotate(
                          angle: floatR,
                          child: Transform.scale(
                            scale: _iconScale.value,
                            child: SizedBox(
                              width: 180, height: 180,
                              child: CustomPaint(
                                painter: _ClockBoltPainter(
                                  innerGlow:      _innerGlow.value,
                                  outerGlow:      _outerGlow.value,
                                  clockGlow:      _clockGlow.value,
                                  hourAngle:      _hourAngle.value,
                                  minAngle:       _minAngle.value,
                                  boltOpacity:    _boltOpacity.value,
                                  ripple1Scale:   _ripple1Scale.value,
                                  ripple1Opacity: _ripple1Opacity.value,
                                  ripple2Scale:   _ripple2Scale.value,
                                  ripple2Opacity: _ripple2Opacity.value,
                                  ripple3Scale:   _ripple3Scale.value,
                                  ripple3Opacity: _ripple3Opacity.value,
                                  orbit1T:        _orbit1Ctrl.value,
                                  orbit2T:        _orbit2Ctrl.value,
                                  orbit3T:        _orbit3Ctrl.value,
                                  orbitStars:     _orbitStars,
                                ),
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
                            Expanded(child: Container(height: 1,
                                color: const Color(0xFF5090FF).withOpacity(.40))),
                            const SizedBox(width: 8),
                            const Icon(Icons.star_rounded,
                                color: Color(0xFF64A0FF), size: 14),
                            const SizedBox(width: 8),
                            Expanded(child: Container(height: 1,
                                color: const Color(0xFF5090FF).withOpacity(.40))),
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
                          'A Sound of Thunder',
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
                        'By Ray Bradbury, 1952',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
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
                        'From Stony Brook University',
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

// ─── Clock + Bolt + Ripples + Orbit painter ───────────────────────────
class _ClockBoltPainter extends CustomPainter {
  final double innerGlow, outerGlow, clockGlow;
  final double hourAngle, minAngle, boltOpacity;
  final double ripple1Scale, ripple1Opacity;
  final double ripple2Scale, ripple2Opacity;
  final double ripple3Scale, ripple3Opacity;
  final double orbit1T, orbit2T, orbit3T;
  final List<List<double>> orbitStars;

  const _ClockBoltPainter({
    required this.innerGlow,      required this.outerGlow,
    required this.clockGlow,      required this.hourAngle,
    required this.minAngle,       required this.boltOpacity,
    required this.ripple1Scale,   required this.ripple1Opacity,
    required this.ripple2Scale,   required this.ripple2Opacity,
    required this.ripple3Scale,   required this.ripple3Opacity,
    required this.orbit1T,        required this.orbit2T,
    required this.orbit3T,        required this.orbitStars,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx  = size.width  / 2;
    final cy  = size.height / 2;
    final scl = size.width  / 180;
    final cr  = 36 * scl; // clock radius

    // ── AMBIENT GLOWS ─────────────────────────────────────────────
    canvas.drawCircle(Offset(cx, cy), 82 * scl,
        Paint()..shader = RadialGradient(colors: [
          const Color(0xFF4080FF).withOpacity(outerGlow),
          const Color(0xFF4080FF).withOpacity(0),
        ]).createShader(Rect.fromCircle(
            center: Offset(cx, cy), radius: 82 * scl)));

    canvas.drawCircle(Offset(cx, cy), 58 * scl,
        Paint()..shader = RadialGradient(colors: [
          const Color(0xFF2060FF).withOpacity(innerGlow),
          const Color(0xFF1040CC).withOpacity(innerGlow * .2),
          const Color(0xFF1040CC).withOpacity(0),
        ], stops: const [0.0, .55, 1.0]).createShader(Rect.fromCircle(
            center: Offset(cx, cy), radius: 58 * scl)));

    // ── TIME RIPPLES ──────────────────────────────────────────────
    final baseR = 46 * scl;
    for (final rp in [
      [ripple1Scale, ripple1Opacity, 1.5],
      [ripple2Scale, ripple2Opacity, 1.0],
      [ripple3Scale, ripple3Opacity, 1.0],
    ]) {
      if (rp[1] > 0) {
        canvas.drawCircle(
          Offset(cx, cy),
          baseR * rp[0],
          Paint()
            ..color = const Color(0xFF64A0FF).withOpacity(rp[1])
            ..style = PaintingStyle.stroke
            ..strokeWidth = scl * rp[2],
        );
      }
    }

    // ── ORBITING STARS ────────────────────────────────────────────
    for (final os in orbitStars) {
      final ring      = os[0].toInt();
      final offsetDeg = os[1];
      final radius    = os[2] * scl;
      final starR     = os[3] * scl;
      final t = ring == 1 ? orbit1T : ring == 2 ? orbit2T : orbit3T;
      final tiltRad = ring == 2 ?  20 * math.pi / 180
                    : ring == 3 ? -30 * math.pi / 180
                    : 0.0;
      final angleRad = (offsetDeg + t * 360) * math.pi / 180;
      final rawX = math.cos(angleRad) * radius;
      final rawY = math.sin(angleRad) * radius * math.cos(tiltRad);
      final pop  = .7 + .3 * math.sin(angleRad * 2 + t * math.pi * 2).abs();
      canvas.drawCircle(
        Offset(cx + rawX, cy + rawY),
        starR * pop,
        Paint()..color = const Color(0xFF8CC8FF).withOpacity(.78 * pop),
      );
      if ((ring == 1 || ring == 2) && offsetDeg == 0) {
        final arm = starR * 1.8 * pop;
        final sx = cx + rawX; final sy = cy + rawY;
        final sp = Paint()
          ..color = const Color(0xFFB4E0FF)
              .withOpacity(ring == 1 ? .80 * pop : .70 * pop)
          ..strokeWidth = 1.0
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(Offset(sx - arm, sy), Offset(sx + arm, sy), sp);
        canvas.drawLine(Offset(sx, sy - arm), Offset(sx, sy + arm), sp);
      }
    }

    // ── CLOCK GLOW ────────────────────────────────────────────────
    canvas.drawCircle(Offset(cx, cy), 46 * scl,
        Paint()..shader = RadialGradient(colors: [
          const Color(0xFF4878FF).withOpacity(clockGlow * .55),
          const Color(0xFF4878FF).withOpacity(0),
        ]).createShader(Rect.fromCircle(
            center: Offset(cx, cy), radius: 46 * scl)));

    // ── CLOCK RIM ─────────────────────────────────────────────────
    canvas.drawCircle(Offset(cx, cy), 38 * scl,
        Paint()
          ..color = const Color(0xFF64A0FF).withOpacity(.55)
          ..style = PaintingStyle.stroke
          ..strokeWidth = scl * 2.5);

    // ── CLOCK FACE ────────────────────────────────────────────────
    canvas.drawCircle(Offset(cx, cy), cr,
        Paint()..shader = RadialGradient(colors: const [
          Color(0xFF1A2A5A), Color(0xFF0E1A40), Color(0xFF060E28),
        ], stops: const [0.0, .60, 1.0]).createShader(
            Rect.fromCircle(center: Offset(cx, cy), radius: cr)));

    // ── HOUR MARKERS ─────────────────────────────────────────────
    final majorPaint = Paint()
      ..color = const Color(0xFFA0C8FF).withOpacity(.60)
      ..strokeWidth = scl * 2.0
      ..strokeCap = StrokeCap.round;
    final minorPaint = Paint()
      ..color = const Color(0xFF7898FF).withOpacity(.35)
      ..strokeWidth = scl * 1.2
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 12; i++) {
      final a = i * math.pi / 6;
      final isMajor = i % 3 == 0;
      final inner = isMajor ? cr * .82 : cr * .88;
      final outer = cr * .97;
      canvas.drawLine(
        Offset(cx + math.sin(a) * inner, cy - math.cos(a) * inner),
        Offset(cx + math.sin(a) * outer, cy - math.cos(a) * outer),
        isMajor ? majorPaint : minorPaint,
      );
    }

    // ── HOUR HAND ─────────────────────────────────────────────────
    canvas.save();
    canvas.translate(cx, cy);
    canvas.rotate(hourAngle);
    canvas.drawLine(
      Offset(0, cr * .12),
      Offset(0, -cr * .58),
      Paint()
        ..color = const Color(0xFFB4D8FF).withOpacity(.90)
        ..strokeWidth = scl * 2.5
        ..strokeCap = StrokeCap.round,
    );
    canvas.restore();

    // ── MINUTE HAND ───────────────────────────────────────────────
    canvas.save();
    canvas.translate(cx, cy);
    canvas.rotate(minAngle);
    canvas.drawLine(
      Offset(0, cr * .12),
      Offset(0, -cr * .78),
      Paint()
        ..color = const Color(0xFF88C0FF).withOpacity(.75)
        ..strokeWidth = scl * 1.8
        ..strokeCap = StrokeCap.round,
    );
    canvas.restore();

    // ── CENTER DOT ────────────────────────────────────────────────
    canvas.drawCircle(Offset(cx, cy), scl * 3,
        Paint()..color = const Color(0xFFC8E8FF).withOpacity(.90));

    // ── LIGHTNING BOLT ────────────────────────────────────────────
    // Positioned bottom-right of clock face
    final bx = cx + cr * .45;
    final by = cy + cr * .20;
    final bs = scl * 14; // bolt scale

    final boltPath = Path()
      ..moveTo(bx + bs * .5,  by)
      ..lineTo(bx,             by + bs * .5)
      ..lineTo(bx + bs * .3,  by + bs * .5)
      ..lineTo(bx - bs * .1,  by + bs)
      ..lineTo(bx + bs * .6,  by + bs * .42)
      ..lineTo(bx + bs * .3,  by + bs * .42)
      ..close();

    // Bolt glow when flashing
    final glowIntensity = (boltOpacity - .70) / .30;
    if (glowIntensity > 0) {
      canvas.drawPath(
        boltPath,
        Paint()
          ..color = const Color(0xFF96D8FF).withOpacity(glowIntensity * .45)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, scl * 8),
      );
    }

    canvas.drawPath(
      boltPath,
      Paint()..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFFC8E8FF).withOpacity(boltOpacity),
          const Color(0xFF7AB8FF).withOpacity(boltOpacity),
          const Color(0xFF3878F0).withOpacity(boltOpacity),
        ],
      ).createShader(Rect.fromLTWH(bx - bs * .1, by, bs * .7, bs)),
    );
  }

  @override
  bool shouldRepaint(covariant _ClockBoltPainter o) =>
      o.innerGlow      != innerGlow      || o.outerGlow      != outerGlow      ||
      o.clockGlow      != clockGlow      || o.hourAngle      != hourAngle      ||
      o.minAngle       != minAngle       || o.boltOpacity    != boltOpacity    ||
      o.ripple1Scale   != ripple1Scale   || o.ripple1Opacity != ripple1Opacity ||
      o.ripple2Scale   != ripple2Scale   || o.ripple2Opacity != ripple2Opacity ||
      o.ripple3Scale   != ripple3Scale   || o.ripple3Opacity != ripple3Opacity ||
      o.orbit1T        != orbit1T        || o.orbit2T        != orbit2T        ||
      o.orbit3T        != orbit3T;
}

// ─── Nebula ───────────────────────────────────────────────────────────
class _TNebula extends StatefulWidget {
  final Color color;
  final Alignment alignment;
  final double size;
  final int delay;
  const _TNebula({required this.color, required this.alignment,
      required this.size, this.delay = 0});
  @override State<_TNebula> createState() => _TNebulaState();
}
class _TNebulaState extends State<_TNebula>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _opacity, _scale;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(
        duration: const Duration(milliseconds: 9000), vsync: this)
      ..repeat(reverse: true);
    _opacity = Tween<double>(begin: .08, end: .18).animate(
        CurvedAnimation(parent: _c, curve: Curves.easeInOut));
    _scale   = Tween<double>(begin: 1.0, end: 1.07).animate(
        CurvedAnimation(parent: _c, curve: Curves.easeInOut));
    if (widget.delay > 0) {
      _c.value = (widget.delay / 9000.0).clamp(0.0, 1.0);
    }
  }
  @override void dispose() { _c.dispose(); super.dispose(); }
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
                width: widget.size, height: widget.size * .6,
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
class _TParticle extends StatefulWidget {
  final double xF, yF, sz;
  final int shape, durMs, delayMs;
  const _TParticle({required this.xF, required this.yF, required this.sz,
      required this.shape, required this.durMs, required this.delayMs});
  @override State<_TParticle> createState() => _TParticleState();
}
class _TParticleState extends State<_TParticle>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<Offset> _pos;
  static const _offsets = [
    Offset(-8,-12), Offset(9,-8), Offset(-6,10), Offset(8,8),
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
  @override void dispose() { _c.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Positioned(
      left: widget.xF * s.width,
      top:  widget.yF * s.height,
      child: AnimatedBuilder(
        animation: _c,
        builder: (_, __) => Transform.translate(
          offset: _pos.value,
          child: widget.shape >= 2
              ? Transform.rotate(
                  angle: math.pi / 4,
                  child: Container(
                    width: widget.sz, height: widget.sz,
                    color: const Color(0xFF3264C8).withOpacity(.25),
                  ),
                )
              : Container(
                  width: widget.sz, height: widget.sz,
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
class _TStarPainter extends CustomPainter {
  final List<List<double>> stars;
  final List<double> starOpacities;
  final double shootT;
  final List<List<double>> shoots;
  final Size canvasSize;

  const _TStarPainter({
    required this.stars,        required this.starOpacities,
    required this.shootT,       required this.shoots,
    required this.canvasSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < stars.length; i++) {
      final s  = stars[i];
      final x  = s[0] * size.width;
      final y  = s[1] * size.height;
      final r  = s[2];
      final op = starOpacities[i].clamp(0.0, 1.0);
      if (s[5].toInt() == 0) {
        canvas.drawCircle(Offset(x, y), r,
            Paint()..color = Colors.white.withOpacity(op));
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
      final delay   = sh[3];
      const cycle   = 5.0;
      final elapsed = (shootT * cycle * shoots.length) % cycle;
      if (elapsed < delay || elapsed > delay + 1.5) continue;
      final prog = ((elapsed - delay) / 1.5).clamp(0.0, 1.0);
      final sx   = size.width  * (1.0 - sh[1]);
      final sy   = size.height * sh[0];
      final len  = sh[2];
      final dx   = -prog * len * 2.5;
      final dy   =  prog * len * 1.2;
      final op   = prog < .1 ? prog / .1
                 : prog > .8 ? (1 - prog) / .2
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
  bool shouldRepaint(covariant _TStarPainter o) =>
      o.shootT != shootT || o.starOpacities != starOpacities;
}

class Thunder extends StatefulWidget {
  const Thunder({super.key});

  @override
  State<Thunder> createState() => _ThunderState();
}

class _ThunderState extends State<Thunder> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Genre: Sci-Fi. \n\nWhat is most likely to happen in this story?",
      "options": [
        "A) A historical figure will deliver a lecture on philosophy",
        "B) A person will recount their real-life experiences",
        "C) The story will provide step-by-step instructions for daily life",
        "D) Characters will encounter futuristic or speculative technology"
      ],
      "correct": 3,
      "feedback": [
        "Incorrect. Science fiction typically focuses on imaginative or speculative scenarios, not historical lectures.",
        "Incorrect. Sci-fi stories usually do not revolve around real-life personal experiences.",
        "Incorrect. Sci-fi is not intended to provide practical daily-life instructions.",
        "Correct. Science fiction often involves advanced technology, space travel, or speculative concepts."
      ]
    },
    {
      "question": "What is a common concept in time travel stories?",
      "options": [
        "A) Traveling to the future or past",
        "B) Teleporting to another planet",
        "C) Transforming into animals",
        "D) Reading minds"
      ],
      "correct": 0,
      "feedback": [
        "Correct. Time travel stories often involve moving forward or backward in time.",
        "Incorrect. Teleportation is more common in other sci-fi subgenres.",
        "Incorrect. Animal transformation is more typical in fantasy genres.",
        "Incorrect. Mind reading is unrelated to traditional time travel themes."
      ]
    },
    {
      "question":
          "Which problem is often highlighted in time travel theories or stories?",
      "options": [
        "A) Running out of money",
        "B) Paradoxes, like changing past events",
        "C) Learning a new language",
        "D) Losing physical strength"
      ],
      "correct": 1,
      "feedback": [
        "Incorrect. Running out of money is not a central issue in time travel theory.",
        "Correct. Paradoxes explore the consequences of altering events in the past.",
        "Incorrect. Language learning is not a major theme in time travel stories.",
        "Incorrect. Physical weakness is unrelated to time travel theory."
      ]
    },
    {
      "question": "What is a potential danger of time travel in stories?",
      "options": [
        "A) Becoming invisible",
        "B) Learning new skills too quickly",
        "C) Creating unintended consequences",
        "D) Losing weight instantly"
      ],
      "correct": 2,
      "feedback": [
        "Incorrect. Invisibility is unrelated to typical time travel themes.",
        "Incorrect. Time travel is not generally portrayed as a rapid learning tool.",
        "Correct. Changing events in the past can drastically affect the future.",
        "Incorrect. Instant weight loss is not associated with time travel."
      ]
    },
    {
      "question": "Is time travel to the past possible in real life?",
      "options": [
        "A) Yes, with current technology",
        "B) No, it is considered impossible",
        "C) Only for very short periods",
        "D) Only astronauts can do it"
      ],
      "correct": 1,
      "feedback": [
        "Incorrect. Current technology does not allow travel to the past.",
        "Correct. According to modern physics, traveling to the past is not possible.",
        "Incorrect. No form of backward time travel has been demonstrated.",
        "Incorrect. Astronauts experience tiny relativistic effects, but not past time travel."
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
          MaterialPageRoute(builder: (_) => const BlueCardDeckAnimation(title: "A Sound of Thunder", nextPage: BiographyReadingPage())),
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
  State<BlueCardDeckAnimation> createState() =>
      _BlueCardDeckAnimationState();
}

class _BlueCardDeckAnimationState
    extends State<BlueCardDeckAnimation> with TickerProviderStateMixin {
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
  // ignore: unused_field
  late final Animation<double> _card3Fan;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;
  // ignore: unused_field
  late final Animation<double> _dotsScale;
  late final Animation<double> _exitFade;
  late final Animation<double> _glow;
  late final Animation<double> _floatY;
  late final Animation<double> _floatRot;
  late final Animation<double> _shimmer;

  // ── Paleta azul ───────────────────────────────────────────────────
  static const _bg1    = Color(0xFF010814);
  static const _bg2    = Color(0xFF010D1F);
  static const _bg3    = Color(0xFF01152E);
  static const _accent  = Color(0xFF60A5FA); // blue-400
  static const _accent2 = Color(0xFF93C5FD); // blue-300
  static const _accent3 = Color(0xFFBFDBFE); // blue-200

  static const _cardBg   = Color(0xFF0B1E3D);
  static const _cardBg2  = Color(0xFF0F2850);
  static const _cardBdr  = Color(0xFF1E4080);
  static const _cardLight = Color(0xFF1A3870);
  // ignore: unused_field
  static const _ink       = Color(0xFFE0EEFF);

  // Colores de las cartas abanicadas
  static const _card1Color = Color(0xFF0E224A);
  static const _card2Color = Color(0xFF102960);
  // ignore: unused_field
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
        animation:
            Listenable.merge([_masterCtrl, _glowCtrl, _floatCtrl, _shuffleCtrl]),
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
                    child: Container(color: const Color.fromARGB(255, 231, 231, 231)),
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
The sign on the wall seemed to shake as if seen through a layer of warm, flowing water. Eckels blinked, and in that brief moment of darkness, the sign burned brightly:

TIME SAFARI, INC.  
SAFARIS TO ANY YEAR IN THE PAST.  
YOU NAME THE ANIMAL. 
WE TAKE YOU THERE. 
YOU SHOOT IT.

Eckels felt a lump in his throat. He swallowed hard and forced a smile. Slowly, he reached into his pocket and pulled out a check for ten thousand dollars. He waved it in the air and handed it to the man behind the desk.

“Does this safari guarantee I’ll come back alive?” Eckels asked.

“We guarantee nothing,” the official replied, “except the dinosaurs.” He turned and pointed to another man. “This is Mr. Travis, your Safari Guide in the Past. He’ll tell you what and where to shoot. If he says no shooting, there’s no shooting. If you disobey, there’s a penalty of ten thousand dollars, plus possible government action when you return.”

Eckels looked across the large office. He saw a tangled mass of wires and steel boxes, glowing with flickering lights—orange, silver, and blue. There was a sound like a huge fire burning all of Time itself, all the years and calendars, all the hours piled high and set ablaze.

With just a touch, this burning could reverse itself. Eckels remembered the words from the advertisements: *Out of ashes and dust, the old years could return. Roses would smell sweet again, white hair would turn black, wrinkles would vanish. Everything would go back to its beginning. Suns would rise in the west and set in the east. Time would flow backward, like a film running in reverse.*

The Machine roared. Time was like a film running backward. Suns and moons raced across the sky. “Think about it,” Eckels said. “Every hunter who ever lived would envy us today. This makes Africa seem like Illinois.”

The Machine slowed, its scream fading to a murmur. Then it stopped completely.

The sun froze in the sky.

The fog around the Machine cleared, and they found themselves in an ancient time—three hunters and two Safari Guides with their blue metal guns resting on their knees.

“Christ isn’t born yet,” said Travis. “Moses hasn’t gone to the mountains to talk to God. The Pyramids are still buried in the earth, waiting to be built. Remember that. Alexander, Caesar, Napoleon, Hitler—none of them exist yet.” He pointed ahead. “That,” he said, “is the jungle of sixty million two thousand and fifty-five years before President Keith.”


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
        "Eckels handed over ten thousand dollars to go on a Time Safari despite warnings of danger. \n\nWhat is most likely to happen in the future?",
    options: [
      "A) Eckels will face real risks that threaten his safety",
      "B) Eckels will be fully protected by guarantees",
      "C) The safari will cost him nothing in the end",
      "D) Eckels will change his mind before entering the past"
    ],
    correctIndex: 0,
    explanation:
        "The official warned that there are no guarantees of survival, which suggests Eckels is likely to face genuine danger in the past.",
    incorrectExplanations: [
      "The story clearly indicates there are real dangers involved.",
      "There is no evidence that Eckels will be fully protected.",
      "Nothing suggests the safari will become free or costless for him.",
      "He has already paid and intends to continue."
    ],
  ),
  QuestionData(
    question:
        "The hunters and guides have just arrived sixty million years in the past, in a dangerous prehistoric jungle.\n\n What is most likely to happen next?",
    options: [
      "A) They will safely return without any encounters",
      "B) They will encounter dinosaurs",
      "C) They will meet famous historical figures",
      "D) They will instantly travel back to the future"
    ],
    correctIndex: 1,
    explanation:
        "The safari is specifically designed for hunting prehistoric animals, so the group is most likely to encounter dinosaurs and other threats in the ancient jungle.",
    incorrectExplanations: [
      "The environment is described as dangerous, making a safe and uneventful return unlikely.",
      "Correct answer.",
      "Historical figures would not exist sixty million years in the past.",
      "Instant return is not suggested by the story."
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
He pointed to a metal path that stretched into the green wilderness, over swamps, among giant ferns and palms.

“And that,” he said, “is the Path. It’s made by Time Safari for your use. It floats six inches above the ground. It doesn’t touch a single blade of grass, flower, or tree. It’s made of anti-gravity metal. Its purpose is to keep you from touching this world of the past in any way. Stay on the Path. Don’t go off it. I repeat: Don’t go off it. For any reason! If you fall off, there’s a penalty. And don’t shoot any animal we don’t approve.”

“Why?” asked Eckels.

They sat in the ancient wilderness. The cries of distant birds carried on the wind, and the air smelled of tar, saltwater, moist grass, and blood-red flowers.

“We don’t want to change the Future,” Travis explained. “We don’t belong here in the Past. The government doesn’t like us here. We have to pay a lot of money to keep our license. A Time Machine is delicate. Without realizing it, we might kill an important animal—a small bird, a bug, or even a flower—and destroy a key link in a species’ development.”

“I don’t understand,” said Eckels.

“Okay,” Travis continued, “imagine we accidentally kill one mouse here. That means all the future families of that mouse are destroyed, right?”

“Right,” said Eckels.

“And all the families of those families, and so on. With one step, you could wipe out first one mouse, then a dozen, then a thousand, a million, a billion possible mice!”

“So they’re dead,” said Eckels. “So what?”
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
        "Travis strictly warned Eckels to stay on the Path and not disturb the past in any way.\n\n What is most likely to happen in the future?",
    options: [
      "A) Eckels will carefully follow every rule",
      "B) Someone may step off the Path, risking serious consequences",
      "C) The group will leave the past unchanged no matter what",
      "D) The Path will protect them from every danger automatically"
    ],
    correctIndex: 1,
    explanation:
        "The text emphasizes the dangers of leaving the Path, suggesting that this rule may be broken later with dramatic results.",
    incorrectExplanations: [
      "There is no indication that Eckels will follow every rule carefully.",
      "Correct answer.",
      "The story suggests the past can be changed easily through carelessness.",
      "The Path is not described as providing automatic protection."
    ],
  ),
  QuestionData(
    question:
        "Travis explained that killing even a tiny creature in the past could erase countless future generations.\n\n What is most likely to happen next?",
    options: [
      "A) Eckels will fully understand and respect the warning",
      "B) Eckels will dismiss the warning, showing carelessness",
      "C) The hunters will stop the safari and return home",
      "D) The government will cancel the license immediately"
    ],
    correctIndex: 1,
    explanation:
        "Eckels’s reaction ('So they're dead. So what?') shows he doesn’t grasp the seriousness of the warning, making it likely he will act recklessly.",
    incorrectExplanations: [
      "The text shows Eckels does not understand or respect the warning.",
      "Correct answer.",
      "There is no indication that the hunters will stop the safari.",
      "Government intervention is not mentioned in the story."
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
“So what?” Travis snorted. “What about the foxes that need those mice to survive? Without mice, a fox dies. Without foxes, a lion starves. Without lions, countless other animals are thrown into chaos. Eventually, it all leads to this: fifty-nine million years later, a caveman—one of only a few in the world—goes hunting for food. But you’ve wiped out all the animals he depends on by stepping on one mouse. So the caveman starves. And that caveman isn’t just any man—he’s an entire future nation. From him would come ten sons, and from them a hundred more, and so on, until a whole civilization is born. Destroy this one man, and you destroy a race, a people, an entire history. It’s like killing some of Adam’s grandchildren. The stomp of your foot, on one mouse, could start an earthquake that shakes the foundations of Time itself. With the death of that one caveman, a billion others yet to be born are lost. Maybe Rome never rises. Maybe Europe remains a dark forest, and only Asia thrives. Step on a mouse, and you crush the Pyramids. Step on a mouse, and you leave your mark, like a Grand Canyon, across Eternity. Queen Elizabeth might never be born. Washington might not cross the Delaware. There might never be a United States at all. So be careful. Stay on the Path. Never step off!”

“I see,” said Eckels. “So we shouldn’t even touch the grass?”

“Correct. Crushing certain plants could have huge effects over sixty million years. A small mistake here could grow into something massive. Of course, maybe we’re wrong. Maybe Time can’t be changed by us. Or maybe it can only be changed in small, subtle ways. A dead mouse here might cause an insect imbalance there, leading to a bad harvest, a depression, mass starvation, and finally, a change in society. Something so small, like a whisper or a breath, that you wouldn’t notice unless you looked closely. Who knows? We don’t. We’re guessing. But until we know for sure whether messing with Time causes big or small changes, we’re being careful. This Machine, this Path, your clothing, and your bodies were sterilized before the journey. We wear these oxygen helmets so we don’t introduce our bacteria into the ancient air.”

“How do we know which animals to shoot?” Eckels asked.

“They’re marked with red paint,” said Travis. “Before our journey, we sent Lesperance here back with the Machine. He came to this era and followed certain animals.”

“Studying them?” asked Eckels.
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
        "Travis said the animals to be hunted are already marked with red paint after careful study.\n\n What is most likely to happen next?",
    options: [
      "A) The hunters will shoot any animal they like",
      "B) Eckels will ignore the markings and fire recklessly",
      "C) The hunters will only shoot the painted animals",
      "D) The group will decide not to hunt at all"
    ],
    correctIndex: 2,
    explanation:
        "The safari is designed to allow only the killing of pre-selected animals that would have died naturally soon, suggesting the hunters are expected to follow this strict system.",
    incorrectExplanations: [
      "The rules clearly prohibit shooting freely at any animal.",
      "Although Eckels is careless, the text does not suggest he will be allowed to fire recklessly.",
      "Correct answer.",
      "There is no indication that the group will stop hunting entirely."
    ],
  ),
  QuestionData(
    question:
        "Travis warns that even crushing grass or introducing bacteria could change history.\n\n What is most likely the reason for wearing oxygen helmets?",
    options: [
      "A) To protect hunters from poisonous air",
      "B) To make them look more professional",
      "C) To help them breathe more easily during the hunt",
      "D) To prevent them from changing the ancient environment"
    ],
    correctIndex: 3,
    explanation:
        "Travis explains they sterilized everything to avoid introducing modern bacteria. The helmets are not for comfort, but to protect the past from contamination that could alter the future.",
    incorrectExplanations: [
      "The air is not described as poisonous.",
      "The helmets serve a practical purpose, not appearance.",
      "Breathing assistance is not mentioned as an issue.",
      "Correct answer."
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
“Right,” said Lesperance. “I tracked them through their entire lives, noting which ones live the longest. Very few. I also noted how many times they mate—not often. Life is short here. When I found an animal that was going to die—like one crushed by a falling tree or drowned in a tar pit—I noted the exact time. Then I shot a paint bomb at it, leaving a red mark. We can’t miss it. We time our arrival so that we meet the animal no more than two minutes before it would have died anyway. This way, we only kill animals with no future—ones that will never mate again. You see how careful we are?”

“But if you came back this morning in Time,” said Eckels eagerly, “you must have seen us on our safari! How did it turn out? Was it successful? Did we all survive?”

Travis and Lesperance exchanged a look.

“That would be a paradox,” said Lesperance. “Time doesn’t allow that kind of mess—a man meeting himself. When such things threaten to happen, Time steps aside. Like an airplane hitting an air pocket. You felt the Machine jump just before we stopped? That was us passing ourselves on the way back to the Future. We saw nothing. There’s no way to know if this expedition was a success, if we got our monster, or if all of us—including you, Mr. Eckels—made it out alive.”

Eckels smiled weakly.

“Enough of that,” said Travis sharply. “Everyone on your feet!”

They were ready to leave the Machine.

The jungle was vast and endless, filling the world. Strange sounds filled the air—like music and like the flapping of giant wings. Above them, pterodactyls soared with huge gray wings, like enormous bats.
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
        "Lesperance explains that only animals already close to death are hunted.\n\n What will most likely happen if hunters shoot an animal that was not marked with paint?",
    options: [
      "A) Nothing, because it's just one animal",
      "B) The hunt will be canceled",
      "C) The animal will come back to life",
      "D) They could change the entire future"
    ],
    correctIndex: 3,
    explanation:
        "The paint system ensures only animals that were about to die are hunted. Killing any other animal could alter the future by preventing reproduction or changing the food chain.",
    incorrectExplanations: [
      "Even one animal can drastically impact the future.",
      "Nothing in the text suggests the hunt would be canceled.",
      "There is no suggestion that animals can come back to life.",
      "Correct answer."
    ],
  ),
  QuestionData(
    question:
        "The hunters leave the safety of the Time Machine and step into the prehistoric jungle. \n\nWhat will most likely happen?",
    options: [
      "A) They will be overwhelmed by the beauty and strangeness of the environment",
      "B) They will immediately find and kill the dinosaur without difficulty",
      "C) They will decide not to hunt and return to the future at once",
      "D) They will discover other time travelers already in the jungle"
    ],
    correctIndex: 0,
    explanation:
        "The text describes the jungle as vast and endless with strange sounds and giant pterodactyls, foreshadowing that the hunters will first be awestruck before the real dangers—like the dinosaur—appear.",
    incorrectExplanations: [
      "Correct answer.",
      "The text does not suggest the hunt will be easy.",
      "There is no indication they will decide to stop the mission immediately.",
      "There is no mention of other time travelers."
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