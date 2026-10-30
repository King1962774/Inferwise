// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Purple/Content/Spot3/Spot_Page/Reading_Spot.dart';

import 'dart:math' as math;

class RoseSplashScreen extends StatefulWidget {
  const RoseSplashScreen({super.key});

  @override
  State<RoseSplashScreen> createState() => _RoseSplashScreenState();
}

class _RoseSplashScreenState extends State<RoseSplashScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgCtrl;
  late AnimationController _iconCtrl;
  late AnimationController _roseFloatCtrl;
  late AnimationController _glowCtrl;
  late AnimationController _petal1Ctrl;   // outer petals
  late AnimationController _petal2Ctrl;   // mid petals
  late AnimationController _petal3Ctrl;   // inner petals
  late AnimationController _blood1Ctrl;   // blood drop 1
  late AnimationController _blood2Ctrl;   // blood drop 2
  late AnimationController _orbit1Ctrl;
  late AnimationController _orbit2Ctrl;
  late AnimationController _orbit3Ctrl;
  late AnimationController _starsCtrl;
  late AnimationController _shootCtrl;
  late AnimationController _textCtrl;

  late Animation<double> _bgFade;
  late Animation<double> _iconScale;
  late Animation<double> _iconRotate;

  // Rose float — asymmetric 3-point
  late Animation<double> _roseFloatY;
  late Animation<double> _roseFloatR;

  // Glow
  late Animation<double> _innerGlow, _outerGlow, _roseGlow;

  // Petal breathe
  late Animation<double> _petal1Scale;
  late Animation<double> _petal2Scale;
  late Animation<double> _petal3Scale;

  // Blood drips: 0→1 progress
  late Animation<double> _blood1T;
  late Animation<double> _blood2T;

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
    _iconRotate = Tween<double>(begin: -8 * math.pi / 180, end: 0).animate(
        CurvedAnimation(parent: _iconCtrl, curve: Curves.easeOut));
    Future.delayed(const Duration(milliseconds: 200),
        () { if (mounted) _iconCtrl.forward(); });

    // Rose float — 3-point asymmetric
    _roseFloatCtrl = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this)
      ..repeat();
    _roseFloatY = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 0, end: -5)
              .chain(CurveTween(curve: Curves.easeInOut)), weight: 33),
      TweenSequenceItem(
          tween: Tween<double>(begin: -5, end: -8)
              .chain(CurveTween(curve: Curves.easeInOut)), weight: 33),
      TweenSequenceItem(
          tween: Tween<double>(begin: -8, end: 0)
              .chain(CurveTween(curve: Curves.easeInOut)), weight: 34),
    ]).animate(_roseFloatCtrl);
    _roseFloatR = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 0, end: 1.5 * math.pi / 180)
              .chain(CurveTween(curve: Curves.easeInOut)), weight: 33),
      TweenSequenceItem(
          tween: Tween(begin: 1.5 * math.pi / 180, end: -1.0 * math.pi / 180)
              .chain(CurveTween(curve: Curves.easeInOut)), weight: 33),
      TweenSequenceItem(
          tween: Tween<double>(begin: -1.0 * math.pi / 180, end: 0)
              .chain(CurveTween(curve: Curves.easeInOut)), weight: 34),
    ]).animate(_roseFloatCtrl);

    // Glow
    _glowCtrl = AnimationController(
        duration: const Duration(milliseconds: 3500), vsync: this)
      ..repeat(reverse: true);
    _innerGlow = Tween<double>(begin: .12, end: .35).animate(
        CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));
    _outerGlow = Tween<double>(begin: .08, end: .22).animate(
        CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));
    _roseGlow  = Tween<double>(begin: .28, end: .55).animate(
        CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));

    // Petal breathe — 3 independent cycles
    _petal1Ctrl = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this)
      ..repeat(reverse: true);
    _petal1Scale = Tween<double>(begin: 1.0, end: 1.04).animate(
        CurvedAnimation(parent: _petal1Ctrl, curve: Curves.easeInOut));

    _petal2Ctrl = AnimationController(
        duration: const Duration(milliseconds: 3400), vsync: this)
      ..repeat(reverse: true);
    _petal2Scale = Tween<double>(begin: 1.0, end: 1.04).animate(
        CurvedAnimation(parent: _petal2Ctrl, curve: Curves.easeInOut));
    _petal2Ctrl.value = .3 / 3.4;

    _petal3Ctrl = AnimationController(
        duration: const Duration(milliseconds: 2800), vsync: this)
      ..repeat(reverse: true);
    _petal3Scale = Tween<double>(begin: 1.0, end: 1.04).animate(
        CurvedAnimation(parent: _petal3Ctrl, curve: Curves.easeInOut));
    _petal3Ctrl.value = .6 / 2.8;

    // Blood drips — 2.8s each, staggered
    _blood1Ctrl = AnimationController(
        duration: const Duration(milliseconds: 2800), vsync: this)
      ..repeat();
    _blood1T = CurvedAnimation(parent: _blood1Ctrl, curve: Curves.easeIn);

    _blood2Ctrl = AnimationController(
        duration: const Duration(milliseconds: 2800), vsync: this)
      ..repeat();
    _blood2T = CurvedAnimation(parent: _blood2Ctrl, curve: Curves.easeIn);
    _blood2Ctrl.value = .9 / 2.8;

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
          MaterialPageRoute(builder: (_) => const Rose()));
    });
  }

  @override
  void dispose() {
    _bgCtrl.dispose();
    _iconCtrl.dispose();
    _roseFloatCtrl.dispose();
    _glowCtrl.dispose();
    _petal1Ctrl.dispose();
    _petal2Ctrl.dispose();
    _petal3Ctrl.dispose();
    _blood1Ctrl.dispose();
    _blood2Ctrl.dispose();
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
                Color(0xFF1A080E), Color(0xFF100408),
                Color(0xFF080206), Color(0xFF040103),
              ],
              stops: [0.0, .45, .75, 1.0],
            ),
          ),
          child: Stack(children: [

            // Milky Way — rose tinted
            Positioned.fill(
              child: Transform.rotate(
                angle: -16 * math.pi / 180,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent, Color(0x05781428),
                        Color(0x08A01838), Color(0x05781428),
                        Colors.transparent,
                      ],
                      stops: [0.0, .20, .38, .60, 1.0],
                    ),
                  ),
                ),
              ),
            ),

            // Nebulae
            _RoseNebula(color: const Color(0xFF641020),
                alignment: const Alignment(-1.0, -.85), size: 400),
            _RoseNebula(color: const Color(0xFF520818),
                alignment: const Alignment(1.0, .80), size: 300, delay: 2000),
            _RoseNebula(color: const Color(0xFF780A50),
                alignment: const Alignment(.80, .20), size: 220, delay: 4000),

            // Star field
            AnimatedBuilder(
              animation: Listenable.merge([_starsCtrl, _shootCtrl]),
              builder: (_, __) => CustomPaint(
                painter: _RoseStarPainter(
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

            // Floating particles — rose tinted
            _RoseParticle(xF:.18,yF:.20,sz:5,shape:0,durMs:3400,delayMs:0),
            _RoseParticle(xF:.84,yF:.22,sz:4,shape:1,durMs:2900,delayMs:500),
            _RoseParticle(xF:.11,yF:.43,sz:3,shape:0,durMs:4000,delayMs:900),
            _RoseParticle(xF:.87,yF:.41,sz:4,shape:1,durMs:3100,delayMs:300),
            _RoseParticle(xF:.22,yF:.27,sz:5,shape:2,durMs:3600,delayMs:700),
            _RoseParticle(xF:.80,yF:.38,sz:4,shape:3,durMs:2800,delayMs:1100),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Rose icon
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _iconCtrl, _roseFloatCtrl, _glowCtrl,
                      _petal1Ctrl, _petal2Ctrl, _petal3Ctrl,
                      _blood1Ctrl, _blood2Ctrl,
                      _orbit1Ctrl, _orbit2Ctrl, _orbit3Ctrl,
                    ]),
                    builder: (_, __) {
                      final floatY = _iconCtrl.isCompleted
                          ? _roseFloatY.value : 0.0;
                      final floatR = _iconCtrl.isCompleted
                          ? _roseFloatR.value : _iconRotate.value;
                      return Transform.translate(
                        offset: Offset(0, floatY),
                        child: Transform.rotate(
                          angle: floatR,
                          child: Transform.scale(
                            scale: _iconScale.value,
                            child: SizedBox(
                              width: 180, height: 180,
                              child: CustomPaint(
                                painter: _RosePainter(
                                  innerGlow:    _innerGlow.value,
                                  outerGlow:    _outerGlow.value,
                                  roseGlow:     _roseGlow.value,
                                  petal1Scale:  _petal1Scale.value,
                                  petal2Scale:  _petal2Scale.value,
                                  petal3Scale:  _petal3Scale.value,
                                  blood1T:      _blood1T.value,
                                  blood2T:      _blood2T.value,
                                  orbit1T:      _orbit1Ctrl.value,
                                  orbit2T:      _orbit2Ctrl.value,
                                  orbit3T:      _orbit3Ctrl.value,
                                  orbitStars:   _orbitStars,
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
                                color: const Color(0xFFB43C64).withOpacity(.45))),
                            const SizedBox(width: 8),
                            const Icon(Icons.star_rounded,
                                color: Color(0xFFDC6488), size: 14),
                            const SizedBox(width: 8),
                            Expanded(child: Container(height: 1,
                                color: const Color(0xFFB43C64).withOpacity(.45))),
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
                          'The Nightingale\nand the Rose',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFFFE0E8),
                            letterSpacing: .4,
                            height: 1.3,
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
                        'By Oscar Wilde, 1888',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: const Color(0xFFDC8CAA).withOpacity(.68),
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
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: const Color(0xFFDC8CAA).withOpacity(.68),
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

// ─── Rose + Petals + Blood + Orbit painter ────────────────────────────
class _RosePainter extends CustomPainter {
  final double innerGlow, outerGlow, roseGlow;
  final double petal1Scale, petal2Scale, petal3Scale;
  final double blood1T, blood2T;
  final double orbit1T, orbit2T, orbit3T;
  final List<List<double>> orbitStars;

  const _RosePainter({
    required this.innerGlow,   required this.outerGlow,
    required this.roseGlow,    required this.petal1Scale,
    required this.petal2Scale, required this.petal3Scale,
    required this.blood1T,     required this.blood2T,
    required this.orbit1T,     required this.orbit2T,
    required this.orbit3T,     required this.orbitStars,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx  = size.width  / 2;
    final cy  = size.height / 2;
    final scl = size.width  / 180;

    // ── AMBIENT GLOWS ─────────────────────────────────────────────
    canvas.drawCircle(Offset(cx, cy), 82 * scl,
        Paint()..shader = RadialGradient(colors: [
          const Color(0xFFC03060).withOpacity(outerGlow),
          const Color(0xFFC03060).withOpacity(0),
        ]).createShader(Rect.fromCircle(
            center: Offset(cx, cy), radius: 82 * scl)));

    canvas.drawCircle(Offset(cx, cy), 58 * scl,
        Paint()..shader = RadialGradient(colors: [
          const Color(0xFFA02050).withOpacity(innerGlow),
          const Color(0xFF801840).withOpacity(innerGlow * .2),
          const Color(0xFF801840).withOpacity(0),
        ], stops: const [0.0, .55, 1.0]).createShader(Rect.fromCircle(
            center: Offset(cx, cy), radius: 58 * scl)));

    // ── ORBITING STARS — rose tinted ──────────────────────────────
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
        Paint()..color = const Color(0xFFDC78A8).withOpacity(.78 * pop),
      );

      if ((ring == 1 || ring == 2) && offsetDeg == 0) {
        final arm = starR * 1.8 * pop;
        final sx = cx + rawX; final sy = cy + rawY;
        final sp = Paint()
          ..color = const Color(0xFFFF9EC8)
              .withOpacity(ring == 1 ? .78 * pop : .65 * pop)
          ..strokeWidth = 1.0
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(Offset(sx - arm, sy), Offset(sx + arm, sy), sp);
        canvas.drawLine(Offset(sx, sy - arm), Offset(sx, sy + arm), sp);
      }
    }

    // ── ROSE GLOW ─────────────────────────────────────────────────
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, cy - 4 * scl),
          width: 76 * scl, height: 72 * scl),
      Paint()..shader = RadialGradient(colors: [
        const Color(0xFFCC2050).withOpacity(roseGlow * .55),
        const Color(0xFFCC2050).withOpacity(0),
      ]).createShader(Rect.fromCenter(
          center: Offset(cx, cy - 4 * scl),
          width: 76 * scl, height: 72 * scl)),
    );

    // ── STEM + LEAVES ─────────────────────────────────────────────
    final stemPaint = Paint()
      ..shader = LinearGradient(colors: const [
        Color(0xFF184018), Color(0xFF286828), Color(0xFF184018),
      ]).createShader(Rect.fromLTWH(
          cx - 3 * scl, cy + 30 * scl, 6 * scl, 35 * scl))
      ..strokeWidth = scl * 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final stemPath = Path()
      ..moveTo(cx, cy + 30 * scl)
      ..quadraticBezierTo(
          cx - 4 * scl, cy + 47 * scl,
          cx - 6 * scl, cy + 62 * scl)
      ..quadraticBezierTo(
          cx, cy + 70 * scl,
          cx, cy + 65 * scl);
    canvas.drawPath(stemPath, stemPaint);

    // Leaves
    final leafPaint = Paint()..color = const Color(0xFF286828).withOpacity(.85);
    // Left leaf
    final leftLeaf = Path()
      ..moveTo(cx, cy + 48 * scl)
      ..quadraticBezierTo(
          cx - 20 * scl, cy + 42 * scl,
          cx - 16 * scl, cy + 35 * scl)
      ..quadraticBezierTo(
          cx - 8 * scl, cy + 44 * scl,
          cx, cy + 48 * scl);
    canvas.drawPath(leftLeaf, leafPaint);
    // Right leaf
    final rightLeaf = Path()
      ..moveTo(cx, cy + 44 * scl)
      ..quadraticBezierTo(
          cx + 20 * scl, cy + 40 * scl,
          cx + 16 * scl, cy + 33 * scl)
      ..quadraticBezierTo(
          cx + 8 * scl, cy + 40 * scl,
          cx, cy + 44 * scl);
    canvas.drawPath(rightLeaf,
        leafPaint..color = const Color(0xFF286828).withOpacity(.80));

    // Thorns
    final thornPaint = Paint()..color = const Color(0xFF1A4018);
    canvas.drawPath(
        Path()
          ..moveTo(cx - 4 * scl, cy + 55 * scl)
          ..lineTo(cx - 14 * scl, cy + 51 * scl)
          ..lineTo(cx - 4 * scl, cy + 53 * scl)
          ..close(),
        thornPaint);
    canvas.drawPath(
        Path()
          ..moveTo(cx + 4 * scl, cy + 60 * scl)
          ..lineTo(cx + 14 * scl, cy + 56 * scl)
          ..lineTo(cx + 4 * scl, cy + 58 * scl)
          ..close(),
        thornPaint);

    // ── OUTER PETALS (5) ──────────────────────────────────────────
    _drawPetalLayer(canvas, cx, cy, scl,
        petalRx: 14, petalRy: 18, pivotOffset: -22,
        count: 5, angleStep: 72, rotOffset: 0,
        scale: petal1Scale,
        gradient: const RadialGradient(
          center: Alignment(0, .6),
          radius: .58,
          colors: [Color(0xFFFF6080), Color(0xFFCC1840), Color(0xFF880820)],
          stops: [0.0, .50, 1.0],
        ),
        opacity: .90);

    // ── MID PETALS (5) ────────────────────────────────────────────
    _drawPetalLayer(canvas, cx, cy, scl,
        petalRx: 11, petalRy: 15, pivotOffset: -18,
        count: 5, angleStep: 72, rotOffset: 36,
        scale: petal2Scale,
        gradient: const RadialGradient(
          center: Alignment(-.1, .55),
          radius: .55,
          colors: [Color(0xFFFF7090), Color(0xFFDD2050), Color(0xFF991030)],
          stops: [0.0, .60, 1.0],
        ),
        opacity: .95);

    // ── INNER PETALS (4) ──────────────────────────────────────────
    _drawPetalLayer(canvas, cx, cy, scl,
        petalRx: 8, petalRy: 11, pivotOffset: -12,
        count: 4, angleStep: 90, rotOffset: 0,
        scale: petal3Scale,
        gradient: const RadialGradient(
          center: Alignment(-.2, .5),
          radius: .52,
          colors: [Color(0xFFFF9090), Color(0xFFEE3060), Color(0xFFAA1840)],
          stops: [0.0, .55, 1.0],
        ),
        opacity: 1.0);

    // ── ROSE CENTER ───────────────────────────────────────────────
    canvas.drawCircle(Offset(cx, cy), 7 * scl,
        Paint()..color = const Color(0xFFCC1840).withOpacity(.95));
    canvas.drawCircle(Offset(cx, cy), 4 * scl,
        Paint()..color = const Color(0xFFEE3060).withOpacity(.80));
    canvas.drawCircle(Offset(cx - 2 * scl, cy - 2 * scl), 2 * scl,
        Paint()..color = const Color(0xFFFF90A8).withOpacity(.70));

    // ── PETAL SHINE ───────────────────────────────────────────────
    canvas.save();
    canvas.translate(cx - 6 * scl, cy - 14 * scl);
    canvas.rotate(-20 * math.pi / 180);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero,
          width: 10 * scl, height: 7 * scl),
      Paint()..color = Colors.white.withOpacity(.38),
    );
    canvas.restore();

    // ── BLOOD DRIPS ───────────────────────────────────────────────
    _drawBloodDrip(canvas, cx - 12 * scl, cy + 55 * scl, scl, blood1T);
    _drawBloodDrip(canvas, cx + 14 * scl, cy + 60 * scl, scl, blood2T);
  }

  void _drawPetalLayer(
    Canvas canvas, double cx, double cy, double scl, {
    required double petalRx,
    required double petalRy,
    required double pivotOffset, // negative = up
    required int count,
    required double angleStep,
    required double rotOffset,
    required double scale,
    required RadialGradient gradient,
    required double opacity,
  }) {
    for (int i = 0; i < count; i++) {
      final angleDeg = rotOffset + i * angleStep;
      final angleRad = angleDeg * math.pi / 180;

      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(angleRad);
      canvas.scale(scale);

      final rect = Rect.fromCenter(
        center: Offset(0, pivotOffset * scl),
        width:  petalRx * 2 * scl,
        height: petalRy * 2 * scl,
      );

      canvas.drawOval(
        rect,
        Paint()
          ..shader = gradient.createShader(rect)
          ..color = Colors.white.withOpacity(opacity), // blend
      );

      canvas.restore();
    }
  }

  void _drawBloodDrip(Canvas canvas, double x, double y,
      double scl, double t) {
    // t: 0→1, drip falls 12px, opacity ramp-up 0→0.15 full 0.15→0.8 fade 0.8→1
    final dy   = t * 12 * scl;
    final op   = t < .15 ? t / .15 : t > .80 ? (1 - t) / .20 : 1.0;
    if (op <= 0) return;
    canvas.drawCircle(
      Offset(x, y + dy),
      2.5 * scl,
      Paint()..color = const Color(0xFFCC1030).withOpacity(op * .85),
    );
  }

  @override
  bool shouldRepaint(covariant _RosePainter o) =>
      o.innerGlow   != innerGlow   || o.outerGlow   != outerGlow   ||
      o.roseGlow    != roseGlow    || o.petal1Scale != petal1Scale  ||
      o.petal2Scale != petal2Scale || o.petal3Scale != petal3Scale  ||
      o.blood1T     != blood1T     || o.blood2T     != blood2T     ||
      o.orbit1T     != orbit1T     || o.orbit2T     != orbit2T     ||
      o.orbit3T     != orbit3T;
}

// ─── Nebula ───────────────────────────────────────────────────────────
class _RoseNebula extends StatefulWidget {
  final Color color;
  final Alignment alignment;
  final double size;
  final int delay;
  const _RoseNebula({required this.color, required this.alignment,
      required this.size, this.delay = 0});
  @override State<_RoseNebula> createState() => _RoseNebulaState();
}
class _RoseNebulaState extends State<_RoseNebula>
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
class _RoseParticle extends StatefulWidget {
  final double xF, yF, sz;
  final int shape, durMs, delayMs;
  const _RoseParticle({required this.xF, required this.yF, required this.sz,
      required this.shape, required this.durMs, required this.delayMs});
  @override State<_RoseParticle> createState() => _RoseParticleState();
}
class _RoseParticleState extends State<_RoseParticle>
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
                    color: const Color(0xFFA03050).withOpacity(.22),
                  ),
                )
              : Container(
                  width: widget.sz, height: widget.sz,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFA03050).withOpacity(.35),
                  ),
                ),
        ),
      ),
    );
  }
}

// ─── Star field + shooting stars ─────────────────────────────────────
class _RoseStarPainter extends CustomPainter {
  final List<List<double>> stars;
  final List<double> starOpacities;
  final double shootT;
  final List<List<double>> shoots;
  final Size canvasSize;

  const _RoseStarPainter({
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
            Paint()..color = Colors.white.withOpacity(op * .85));
      } else {
        final p = Paint()
          ..color = const Color(0xFFDC78A8).withOpacity(op)
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
            const Color(0xFFC87898).withOpacity(op * .88),
            const Color(0xFFB05070).withOpacity(op * .35),
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
  bool shouldRepaint(covariant _RoseStarPainter o) =>
      o.shootT != shootT || o.starOpacities != starOpacities;
}

class Rose extends StatefulWidget {
  const Rose({super.key});

  @override
  State<Rose> createState() => _RoseState();
}

class _RoseState extends State<Rose> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is most likely to happen in a Fairy Tale story?",
      "options": [
        "A) Characters will engage in realistic political debates.",
        "B) A person will recount their real-life experiences.",
        "C) The story will provide step-by-step instructions for daily life.",
        "D) Fantastical events will occur, often with a moral lesson."
      ],
      "correct": 3,
      "feedback": [
        "Correct. Fairy tales typically involve magic, talking animals, or extraordinary events and usually convey a moral or lesson.",
        "Incorrect. Fairy tales do not focus on realistic political topics.",
        "Incorrect. Fairy tales are fictional and do not give practical instructions.",
        "Incorrect. This option is actually the correct one."
      ]
    },
    {
      "question": "What is nightingales' most famous feature?",
      "options": [
        "A) Their colorful feathers",
        "B) Their large size",
        "C) Their long migrations",
        "D) Their beautiful singing"
      ],
      "correct": 3,
      "feedback": [
        "Incorrect. Nightingales are not known for colorful feathers.",
        "Incorrect. Nightingales are relatively small birds.",
        "Incorrect. Their migrations are notable, but not their most famous trait.",
        "Correct. Nightingales are renowned for their melodious and complex songs."
      ]
    },
    {
      "question": "When are nightingales most likely to sing?",
      "options": [
        "A) Only during the day",
        "B) Mostly at night",
        "C) Only in winter",
        "D) Only while flying"
      ],
      "correct": 1,
      "feedback": [
        "Incorrect. Nightingales do sing during the day, but this is not when they sing the most.",
        "Correct. Male nightingales often sing at night during the breeding season to attract mates and defend territory.",
        "Incorrect. Nightingales migrate in winter and do not sing actively then.",
        "Incorrect. Nightingales sing while perched, not in flight."
      ]
    },
    {
      "question": "Where are nightingales commonly found?",
      "options": [
        "A) Tropical rainforests",
        "B) Deserts and Meadows",
        "C) Antarctica and Patagonia",
        "D) Europe, Asia, and parts of Africa"
      ],
      "correct": 3,
      "feedback": [
        "Incorrect. Nightingales do not inhabit tropical rainforests.",
        "Incorrect. Deserts are not a habitat for nightingales.",
        "Incorrect. Nightingales are not found in polar regions.",
        "Correct. Nightingales breed in Europe and Asia and migrate to sub-Saharan Africa for the winter."
      ]
    },
    {
      "question": "Why is the nightingale's song important?",
      "options": [
        "A) To attract mates and mark territory",
        "B) To scare predators",
        "C) To navigate during migration",
        "D) To signal storms"
      ],
      "correct": 0,
      "feedback": [
        "Correct. Singing helps male nightingales attract females and warn other males to stay away from their territory.",
        "Incorrect. Their song is not used to scare predators.",
        "Incorrect. Nightingales do not navigate migration through singing.",
        "Incorrect. Their song is not related to weather signals."
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
          MaterialPageRoute(builder: (_) => const BlueCardDeckAnimation(title: "The nightingale and the rose", nextPage: BiographyReadingPage(),)),
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
  static const _ink       = Color(0xFFE0EEFF);

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
“She said she would dance with me if I brought her a red rose,” cried the young Student. “But in my whole garden, there is no red rose.”

From her nest in the oak tree, the Nightingale heard him. She looked out through the leaves and wondered.

“No red rose in my garden!” he cried, his beautiful eyes filling with tears. “Ah, how happiness depends on such small things! I have read all the wise men’s books, and I know the secrets of philosophy, yet my life is miserable because I don’t have a red rose.”

“Here is a true lover,” said the Nightingale. “Night after night, I have sung about love, though I didn’t know what it was. Night after night, I told the stars about love, and now I see him. His hair is as dark as the hyacinth flower, and his lips are as red as the rose he desires. But passion has made his face pale, and sorrow has marked his brow.”

“The Prince is giving a ball tomorrow night,” murmured the Student. “My love will be there. If I bring her a red rose, she will dance with me until dawn. If I bring her a red rose, I will hold her in my arms, and she will rest her head on my shoulder. But there is no red rose in my garden, so I will sit alone, and she will ignore me. She won’t care about me, and my heart will break.”

“Here is the true lover,” said the Nightingale. “What I sing about, he suffers. What brings me joy brings him pain. Love is a wonderful thing. It is more precious than emeralds and more valuable than fine opals. Pearls and pomegranates cannot buy it, and it is not sold in the market. It cannot be bought from merchants or weighed in gold.”



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
        "The Student cried because he had no red rose for the girl he loved. \n\nWhat will most likely happen?",
    options: [
      "A) He will forget about the ball and be happy again",
      "B) He will be heartbroken and ignored at the ball",
      "C) He will find a rose in his garden at the last moment",
      "D) He will stop caring about love forever"
    ],
    correctIndex: 1,
    explanation:
        "The Student already predicts he will sit alone and be ignored, making heartbreak the most likely outcome.",
    incorrectExplanations: [
      "He does not simply forget about the ball; he is very distressed.",
      "Correct answer!",
      "There is no indication that he will suddenly find a rose.",
      "He does not renounce love completely; he is just sorrowful in the moment."
    ],
  ),
  QuestionData(
    question:
        "The Nightingale heard the Student’s sorrow and called him a true lover. \n\nWhat will most likely happen?",
    options: [
      "A) The Nightingale will ignore him",
      "B) The Nightingale will mock him",
      "C) The Nightingale will try to help him get a red rose",
      "D) The Nightingale will leave the oak tree and fly away"
    ],
    correctIndex: 2,
    explanation:
        "Since the Nightingale sees the Student as the true embodiment of the love she sings about, she is foreshadowed to help him obtain the red rose.",
    incorrectExplanations: [
      "The Nightingale does not ignore genuine sorrow.",
      "She does not mock him; she admires his devotion.",
      "Correct answer!",
      "She does not simply leave; she feels compelled to act."
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
“The musicians will sit in their gallery,” said the Student, “and play their instruments. My love will dance to the sound of the harp and violin. She will dance so lightly that her feet won’t touch the floor, and the courtiers in their bright clothes will crowd around her. But she won’t dance with me because I have no red rose to give her.” He threw himself on the grass, buried his face in his hands, and cried.

“Why is he crying?” asked a little Green Lizard as he ran past with his tail in the air.

“Why, indeed?” said a Butterfly, fluttering after a sunbeam.

“Why, indeed?” whispered a Daisy to its neighbor in a soft voice.

“He is crying for a red rose,” said the Nightingale.

“For a red rose?” they cried. “How silly!” The little Lizard, who was a bit of a cynic, laughed out loud.

But the Nightingale understood the Student’s pain. She sat silently in the oak tree, thinking about the mystery of love.

Suddenly, she spread her brown wings and flew into the air. She passed through the grove like a shadow and flew across the garden.

In the center of the garden stood a beautiful rose tree. When she saw it, she flew over and landed on a branch.

“Give me a red rose,” she cried, “and I will sing you my sweetest song.”

But the tree shook its head.

“My roses are white,” it said. “As white as sea foam and whiter than mountain snow. Go to my brother near the old sundial. Maybe he can help you.”

So the Nightingale flew to the rose tree near the sundial.

“Give me a red rose,” she cried, “and I will sing you my sweetest song.”

But the tree shook its head.

“My roses are yellow,” it said. “As yellow as the hair of a mermaid sitting on an amber throne, and yellower than daffodils in the meadow. Go to my brother under the Student’s window. Maybe he can help you.”

So the Nightingale flew to the rose tree under the Student’s window.

“Give me a red rose,” she cried, “and I will sing you my sweetest song.”
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
        "The Student believes his love won’t dance with him because he has no red rose. \n\nWhat will most likely happen?",
    options: [
      "A) He will remain heartbroken at the ball",
      "B) He will invent a new kind of music to win her heart",
      "C) He will laugh at his worries and enjoy the night",
      "D) He will never think of the girl again"
    ],
    correctIndex: 0,
    explanation:
        "His despair and hopeless tone suggest he will carry his sadness with him into the ball.",
    incorrectExplanations: [
      "Correct answer!",
      "He does not plan to create anything new; he feels defeated.",
      "He is in no mood to laugh or enjoy the night.",
      "He is still very focused on the girl; he does not forget her."
    ],
  ),
  QuestionData(
    question:
        "The Nightingale has asked two rose trees for help but has not yet found a red rose. \n\nWhat will most likely happen next?",
    options: [
      "A) She will not stop until she obtains the rose",
      "B) She will abandon her search and leave the garden",
      "C) She will ask the Student to grow one",
      "D) She will sing until the girl changes her mind"
    ],
    correctIndex: 0,
    explanation:
        "The Nightingale's devotion to true love foreshadows she will make a sacrifice to secure the red rose.",
    incorrectExplanations: [
      "Correct answer!",
      "She remains dedicated and does not give up.",
      "The Student cannot grow a rose in time, and she knows this.",
      "The Nightingale focuses on obtaining a rose, not persuading the girl."
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
But the tree shook its head.

“My roses are red,” it said. “As red as a dove’s feet and redder than coral in the ocean. But winter has chilled my veins, frost has killed my buds, and the storm has broken my branches. I will have no roses this year.”

“I only need one red rose,” cried the Nightingale. “Is there no way to get it?”

“There is a way,” said the tree, “but it is so terrible that I dare not tell you.”

“Tell me,” said the Nightingale. “I am not afraid.”

“If you want a red rose,” said the tree, “you must build it out of music by moonlight and stain it with your heart’s blood. You must sing to me with your chest against a thorn. All night long, you must sing, and the thorn must pierce your heart. Your blood must flow into my veins and become mine.”

“Death is a high price for a red rose,” cried the Nightingale. “Life is precious to everyone. It is pleasant to sit in the green wood, to watch the sun in his golden chariot and the moon in her pearl chariot. The scent of hawthorn is sweet, and the bluebells in the valley and the heather on the hill are lovely. But Love is better than Life, and what is the heart of a bird compared to the heart of a man?”

So she spread her brown wings and flew into the air. She swept over the garden like a shadow and flew through the grove.

The Student was still lying on the grass, his tears not yet dry.

“Be happy,” cried the Nightingale. “You will have your red rose. I will build it out of music by moonlight and stain it with my heart’s blood. All I ask in return is that you be a true lover, for Love is wiser than Philosophy and stronger than Power. His wings are the color of flame, and his body is like fire. His lips are as sweet as honey, and his breath is like incense.”

The Student looked up and listened, but he didn’t understand the Nightingale’s words. He only knew what was written in books.

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
        "The rose tree explains that the Nightingale must sacrifice her life to create a red rose. \n\nWhat will most likely happen next?",
    options: [
      "A) The Nightingale will give her life to make the rose",
      "B) The Nightingale will abandon the task and fly away",
      "C) The Student will find another rose in the garden",
      "D) The rose tree will change its mind and grow one rose"
    ],
    correctIndex: 0,
    explanation:
        "The Nightingale values true love above life itself, which foreshadows her sacrifice.",
    incorrectExplanations: [
      "Correct answer!",
      "The Nightingale remains committed to the cause.",
      "There is no indication another rose exists or can be found.",
      "The rose tree has explained clearly that only sacrifice can produce the red rose."
    ],
  ),
  QuestionData(
    question:
        "The Student listens to the Nightingale’s promise but does not understand her words. \n\nWhat will most likely happen as a result?",
    options: [
      "A) He will write about her sacrifice in his books",
      "B) He will warn the Nightingale not to continue",
      "C) He will sing along to help her create the rose",
      "D) He will not appreciate the cost of the rose"
    ],
    correctIndex: 3,
    explanation:
        "His reliance on books over feelings suggests he will not realize the depth of her sacrifice.",
    incorrectExplanations: [
      "He does not yet grasp that she is going to sacrifice herself.",
      "He does not understand her intentions well enough to stop her.",
      "He shows no inclination to participate emotionally or musically.",
      "Correct answer!"
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
But the oak tree understood and felt sad, for he loved the little Nightingale who had built her nest in his branches.

“Sing me one last song,” he whispered. “I will feel lonely when you are gone.”

So the Nightingale sang to the oak tree, and her voice was like water bubbling from a silver jar.

When she finished, the Student stood up and took out a notebook and pencil.

“She has talent,” he said to himself as he walked away. “But does she have feeling? I don’t think so. She is like most artists—all style, no sincerity. She wouldn’t sacrifice herself for others. She only thinks of music, and everyone knows art is selfish. Still, her voice has some beautiful notes. What a pity they don’t mean anything or do any good.” He went to his room, lay on his small bed, and thought about his love. Soon, he fell asleep.

When the moon rose, the Nightingale flew to the rose tree and pressed her chest against a thorn. All night long, she sang with the thorn in her chest, and the cold moon listened. As she sang, the thorn went deeper into her heart, and her life’s blood flowed away.

First, she sang of the birth of love in a boy and girl’s hearts. A rose began to bloom on the tree, petal by petal, as song followed song. At first, it was pale, like mist over a river—pale as the morning’s feet and silver as the dawn’s wings. It was like the shadow of a rose in a mirror or a pool of water.

But the tree told the Nightingale to press closer. “Press closer, little Nightingale,” it said, “or the day will come before the rose is finished.”
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
        "The oak tree sadly asks the Nightingale for one last song before her sacrifice. \n\nWhat will most likely happen after she finishes singing?",
    options: [
      "A) The rose tree will no longer need her blood",
      "B) The oak tree will give her strength to survive",
      "C) The Student will finally recognize her sacrifice",
      "D) The oak tree will grieve her loss"
    ],
    correctIndex: 3,
    explanation:
        "The oak tree’s sorrow and love for the Nightingale foreshadow his grief once she dies.",
    incorrectExplanations: [
      "The rose tree still depends on her sacrifice; nothing has changed.",
      "The oak tree is powerless to save her from her fate.",
      "The Student remains unaware and does not recognize her sacrifice.",
      "Correct answer!"
    ],
  ),
  QuestionData(
    question:
        "As the Nightingale presses her chest against the thorn and sings all night. \n\nWhat will most likely happen by morning?",
    options: [
      "A) The rose will fully bloom red",
      "B) The Student will awaken and save her in time",
      "C) The tree will heal her and spare her life",
      "D) The rose will remain unfinished and pale"
    ],
    correctIndex: 0,
    explanation:
        "The text shows her life’s blood flowing into the tree, foreshadowing her death as the rose turns red.",
    incorrectExplanations: [
      "Correct answer!",
      "The Student does not awaken in time to intervene.",
      "The tree cannot save her; the sacrifice is irreversible.",
      "The story foreshadows that the rose will indeed turn red."
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