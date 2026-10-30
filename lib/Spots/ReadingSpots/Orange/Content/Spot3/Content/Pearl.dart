// ignore_for_file: unused_field

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Orange/Content/Spot3/Spot_Page/Reading_Spot.dart';

import 'dart:math' as math;

class PearlSplashScreen extends StatefulWidget {
  const PearlSplashScreen({super.key});

  @override
  State<PearlSplashScreen> createState() => _PearlSplashScreenState();
}

class _PearlSplashScreenState extends State<PearlSplashScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgCtrl;
  late AnimationController _iconCtrl;
  late AnimationController _pearlFloatCtrl;
  late AnimationController _pearlShineCtrl;
  late AnimationController _pearlGlowCtrl;
  late AnimationController _irid1Ctrl;
  late AnimationController _irid2Ctrl;
  late AnimationController _orbit1Ctrl;
  late AnimationController _orbit2Ctrl;
  late AnimationController _orbit3Ctrl;
  late AnimationController _starsCtrl;
  late AnimationController _shootCtrl;
  late AnimationController _textCtrl;

  late Animation<double> _bgFade;
  late Animation<double> _iconScale;

  // Pearl float — asymmetric 3-point
  late Animation<double> _pearlFloatY;
  late Animation<double> _pearlFloatR;

  // Pearl surface animations
  late Animation<double> _shine1Opacity;
  late Animation<double> _shine2Opacity;
  late Animation<double> _pearlGlow;
  late Animation<double> _irid1Opacity;
  late Animation<double> _irid2Opacity;

  // Ambient glow rings
  late Animation<double> _innerGlow;
  late Animation<double> _outerGlow;

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

  // Small sparkle crosses around pearl: angleDeg, radius, popDelay
  static const List<List<double>> _sparkles = [
    [  0, 46, 0.1],
    [ 90, 46, 0.6],
    [180, 46, 1.1],
    [300, 42, 1.6],
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
    Future.delayed(const Duration(milliseconds: 200),
        () { if (mounted) _iconCtrl.forward(); });

    // Pearl float — 3-point asymmetric
    _pearlFloatCtrl = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this)
      ..repeat();
    _pearlFloatY = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: -5.0)
              .chain(CurveTween(curve: Curves.easeInOut)), weight: 33),
      TweenSequenceItem(
          tween: Tween(begin: -5.0, end: -9.0)
              .chain(CurveTween(curve: Curves.easeInOut)), weight: 33),
      TweenSequenceItem(
          tween: Tween<double>(begin: -9.0, end: 0.0)
              .chain(CurveTween(curve: Curves.easeInOut)), weight: 34),
    ]).animate(_pearlFloatCtrl);
    _pearlFloatR = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 0, end: 2 * math.pi / 180)
              .chain(CurveTween(curve: Curves.easeInOut)), weight: 33),
      TweenSequenceItem(
          tween: Tween(begin: 2 * math.pi / 180, end: -1.5 * math.pi / 180)
              .chain(CurveTween(curve: Curves.easeInOut)), weight: 33),
      TweenSequenceItem(
          tween: Tween<double>(begin: -1.5 * math.pi / 180, end: 0)
              .chain(CurveTween(curve: Curves.easeInOut)), weight: 34),
    ]).animate(_pearlFloatCtrl);

    // Pearl shine — 3s, staggered
    _pearlShineCtrl = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this)
      ..repeat(reverse: true);
    _shine1Opacity = Tween<double>(begin: .55, end: .90).animate(
        CurvedAnimation(parent: _pearlShineCtrl, curve: Curves.easeInOut));
    _shine2Opacity = Tween<double>(begin: .55, end: .90).animate(
        CurvedAnimation(parent: _pearlShineCtrl,
            curve: const Interval(.13, 1.0, curve: Curves.easeInOut)));

    // Pearl glow
    _pearlGlowCtrl = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this)
      ..repeat(reverse: true);
    _pearlGlow  = Tween<double>(begin: .28, end: .55).animate(
        CurvedAnimation(parent: _pearlGlowCtrl, curve: Curves.easeInOut));
    _innerGlow  = Tween<double>(begin: .16, end: .35).animate(
        CurvedAnimation(parent: _pearlGlowCtrl, curve: Curves.easeInOut));
    _outerGlow  = Tween<double>(begin: .10, end: .22).animate(
        CurvedAnimation(parent: _pearlGlowCtrl, curve: Curves.easeInOut));

    // Iridescent layers — independent cycles
    _irid1Ctrl = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this)
      ..repeat(reverse: true);
    _irid1Opacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: .18, end: .32), weight: 33),
      TweenSequenceItem(tween: Tween(begin: .32, end: .22), weight: 33),
      TweenSequenceItem(tween: Tween(begin: .22, end: .18), weight: 34),
    ]).animate(CurvedAnimation(parent: _irid1Ctrl, curve: Curves.easeInOut));

    _irid2Ctrl = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this)
      ..repeat(reverse: true);
    _irid2Opacity = Tween<double>(begin: .12, end: .28).animate(
        CurvedAnimation(parent: _irid2Ctrl, curve: Curves.easeInOut));
    _irid2Ctrl.value = 1.3 / 4.0; // offset

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
          MaterialPageRoute(builder: (_) => const Pearls()));
    });
  }

  @override
  void dispose() {
    _bgCtrl.dispose();
    _iconCtrl.dispose();
    _pearlFloatCtrl.dispose();
    _pearlShineCtrl.dispose();
    _pearlGlowCtrl.dispose();
    _irid1Ctrl.dispose();
    _irid2Ctrl.dispose();
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
            _PearlNebula(color: const Color(0xFF0A1964),
                alignment: const Alignment(-1.0, -.85), size: 400),
            _PearlNebula(color: const Color(0xFF052882),
                alignment: const Alignment(1.0, .80), size: 300, delay: 2000),
            _PearlNebula(color: const Color(0xFF140A78),
                alignment: const Alignment(.80, .20), size: 220, delay: 4000),

            // Star field
            AnimatedBuilder(
              animation: Listenable.merge([_starsCtrl, _shootCtrl]),
              builder: (_, __) => CustomPaint(
                painter: _PearlStarPainter(
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
            _PearlParticle(xF:.18,yF:.20,sz:5,shape:0,durMs:3400,delayMs:0),
            _PearlParticle(xF:.84,yF:.22,sz:4,shape:1,durMs:2900,delayMs:500),
            _PearlParticle(xF:.11,yF:.43,sz:3,shape:0,durMs:4000,delayMs:900),
            _PearlParticle(xF:.87,yF:.41,sz:4,shape:1,durMs:3100,delayMs:300),
            _PearlParticle(xF:.22,yF:.27,sz:5,shape:2,durMs:3600,delayMs:700),
            _PearlParticle(xF:.80,yF:.38,sz:4,shape:3,durMs:2800,delayMs:1100),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Pearl icon
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _iconCtrl, _pearlFloatCtrl, _pearlShineCtrl,
                      _pearlGlowCtrl, _irid1Ctrl, _irid2Ctrl,
                      _orbit1Ctrl, _orbit2Ctrl, _orbit3Ctrl,
                    ]),
                    builder: (_, __) {
                      final floatY = _iconCtrl.isCompleted
                          ? _pearlFloatY.value : 0.0;
                      final floatR = _iconCtrl.isCompleted
                          ? _pearlFloatR.value : 0.0;
                      return Transform.translate(
                        offset: Offset(0, floatY),
                        child: Transform.rotate(
                          angle: floatR,
                          child: Transform.scale(
                            scale: _iconScale.value,
                            child: SizedBox(
                              width: 180, height: 180,
                              child: CustomPaint(
                                painter: _PearlPainter(
                                  innerGlow:     _innerGlow.value,
                                  outerGlow:     _outerGlow.value,
                                  pearlGlow:     _pearlGlow.value,
                                  shine1Opacity: _shine1Opacity.value,
                                  shine2Opacity: _shine2Opacity.value,
                                  irid1Opacity:  _irid1Opacity.value,
                                  irid2Opacity:  _irid2Opacity.value,
                                  orbit1T:       _orbit1Ctrl.value,
                                  orbit2T:       _orbit2Ctrl.value,
                                  orbit3T:       _orbit3Ctrl.value,
                                  orbitStars:    _orbitStars,
                                  sparkles:      _sparkles,
                                  sparkleT:      _pearlGlowCtrl.value,
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
                          'The Pearl of Love',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 28,
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
                        'By H. G. Wells, 1925',
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
                        'From the Library of Short Stories',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
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

// ─── Pearl + Orbit painter ────────────────────────────────────────────
class _PearlPainter extends CustomPainter {
  final double innerGlow, outerGlow, pearlGlow;
  final double shine1Opacity, shine2Opacity;
  final double irid1Opacity, irid2Opacity;
  final double orbit1T, orbit2T, orbit3T;
  final double sparkleT;
  final List<List<double>> orbitStars;
  final List<List<double>> sparkles;

  const _PearlPainter({
    required this.innerGlow,     required this.outerGlow,
    required this.pearlGlow,     required this.shine1Opacity,
    required this.shine2Opacity, required this.irid1Opacity,
    required this.irid2Opacity,  required this.orbit1T,
    required this.orbit2T,       required this.orbit3T,
    required this.sparkleT,      required this.orbitStars,
    required this.sparkles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx  = size.width  / 2;
    final cy  = size.height / 2;
    final scl = size.width  / 180;
    final pr  = 34 * scl; // pearl radius

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

    // ── PEARL OUTER GLOW ──────────────────────────────────────────
    canvas.drawCircle(Offset(cx, cy), 46 * scl,
        Paint()..shader = RadialGradient(colors: [
          const Color(0xFF8AB8FF).withOpacity(pearlGlow * .6),
          const Color(0xFF4878E8).withOpacity(pearlGlow * .2),
          const Color(0xFF4878E8).withOpacity(0),
        ], stops: const [0.0, .55, 1.0]).createShader(Rect.fromCircle(
            center: Offset(cx, cy), radius: 46 * scl)));

    // ── PEARL BODY ────────────────────────────────────────────────
    canvas.drawCircle(Offset(cx, cy), pr,
        Paint()..shader = RadialGradient(
          center: const Alignment(-.3, -.4),
          radius: .70,
          colors: const [
            Color(0xFFFFFFFF),
            Color(0xFFE8F0FF),
            Color(0xFFA0C0F0),
            Color(0xFF5080D0),
            Color(0xFF1838A0),
          ],
          stops: const [0.0, .20, .55, .80, 1.0],
        ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: pr)));

    // ── IRIDESCENT LAYER 1 (violet) ───────────────────────────────
    canvas.drawCircle(Offset(cx, cy), pr,
        Paint()..shader = RadialGradient(
          center: const Alignment(.3, -.2),
          colors: [
            const Color(0xFFD0A0FF).withOpacity(irid1Opacity),
            const Color(0xFFD0A0FF).withOpacity(0),
          ],
        ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: pr)));

    // ── IRIDESCENT LAYER 2 (teal) ─────────────────────────────────
    canvas.drawCircle(Offset(cx, cy), pr,
        Paint()..shader = RadialGradient(
          center: const Alignment(-.2, .4),
          colors: [
            const Color(0xFF80E8D8).withOpacity(irid2Opacity),
            const Color(0xFF80E8D8).withOpacity(0),
          ],
        ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: pr)));

    // ── SHINE 1 — large soft ellipse ──────────────────────────────
    canvas.save();
    canvas.translate(cx - 12 * scl, cy - 16 * scl);
    canvas.rotate(-25 * math.pi / 180);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero,
          width: 22 * scl, height: 16 * scl),
      Paint()..color = Colors.white.withOpacity(shine1Opacity * .55),
    );
    canvas.restore();

    // ── SHINE 2 — medium ellipse ──────────────────────────────────
    canvas.save();
    canvas.translate(cx - 16 * scl, cy - 20 * scl);
    canvas.rotate(-25 * math.pi / 180);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero,
          width: 10 * scl, height: 7 * scl),
      Paint()..color = Colors.white.withOpacity(shine2Opacity * .80),
    );
    canvas.restore();

    // ── MICRO GLINT ───────────────────────────────────────────────
    canvas.drawCircle(
      Offset(cx - 19 * scl, cy - 23 * scl),
      2 * scl,
      Paint()..color = Colors.white.withOpacity(
          .90 * (0.6 + 0.4 * math.sin(sparkleT * math.pi * 2))),
    );

    // ── PEARL OUTLINE ─────────────────────────────────────────────
    canvas.drawCircle(Offset(cx, cy), pr,
        Paint()
          ..color = const Color(0xFF78AAFF).withOpacity(.22)
          ..style = PaintingStyle.stroke
          ..strokeWidth = scl);

    // ── SMALL SPARKLE CROSSES around pearl ───────────────────────
    for (int i = 0; i < sparkles.length; i++) {
      final sp = sparkles[i];
      final angleDeg = sp[0];
      final radius   = sp[1] * scl;
      final delay    = sp[2];

      final angleRad = angleDeg * math.pi / 180;
      final sx = cx + math.cos(angleRad) * radius;
      final sy = cy + math.sin(angleRad) * radius;

      // Pop scale using sparkleT with delay offset
      final phase = (sparkleT + delay / 3.0) % 1.0;
      final pop = 0.5 + 0.5 * math.sin(phase * math.pi * 2).abs();
      final arm = 4 * scl * pop;

      final sparkPaint = Paint()
        ..color = const Color(0xFFC8E8FF).withOpacity(.65 * pop)
        ..strokeWidth = scl * 1.2
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(Offset(sx - arm, sy), Offset(sx + arm, sy), sparkPaint);
      canvas.drawLine(Offset(sx, sy - arm), Offset(sx, sy + arm), sparkPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _PearlPainter o) =>
      o.innerGlow     != innerGlow     || o.outerGlow     != outerGlow     ||
      o.pearlGlow     != pearlGlow     || o.shine1Opacity != shine1Opacity ||
      o.shine2Opacity != shine2Opacity || o.irid1Opacity  != irid1Opacity  ||
      o.irid2Opacity  != irid2Opacity  || o.orbit1T       != orbit1T       ||
      o.orbit2T       != orbit2T       || o.orbit3T       != orbit3T       ||
      o.sparkleT      != sparkleT;
}

// ─── Nebula ───────────────────────────────────────────────────────────
class _PearlNebula extends StatefulWidget {
  final Color color;
  final Alignment alignment;
  final double size;
  final int delay;
  const _PearlNebula({required this.color, required this.alignment,
      required this.size, this.delay = 0});
  @override State<_PearlNebula> createState() => _PearlNebulaState();
}
class _PearlNebulaState extends State<_PearlNebula>
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
class _PearlParticle extends StatefulWidget {
  final double xF, yF, sz;
  final int shape, durMs, delayMs;
  const _PearlParticle({required this.xF, required this.yF, required this.sz,
      required this.shape, required this.durMs, required this.delayMs});
  @override State<_PearlParticle> createState() => _PearlParticleState();
}
class _PearlParticleState extends State<_PearlParticle>
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
class _PearlStarPainter extends CustomPainter {
  final List<List<double>> stars;
  final List<double> starOpacities;
  final double shootT;
  final List<List<double>> shoots;
  final Size canvasSize;

  const _PearlStarPainter({
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
  bool shouldRepaint(covariant _PearlStarPainter o) =>
      o.shootT != shootT || o.starOpacities != starOpacities;
}



class Pearls extends StatefulWidget {
  const Pearls({super.key});

  @override
  State<Pearls> createState() => _PearlsState();
}

class _PearlsState extends State<Pearls> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
{
  "question": "What is a common psychological consequence of a relentless pursuit of perfectionism?",
  "options": [
    "A) Increased levels of anxiety, stress, and burnout.",
    "B) A sense of freedom from societal expectations.",
    "C) Increased feelings of satisfaction and happiness.",
    "D) A reduced fear of failure."
  ],
  "correct": 0,
  "feedback": [
    " Correct! The constant pressure to meet impossible standards often leads to psychological distress, including anxiety and a fear of making mistakes.",
    " Incorrect. Perfectionism increases stress, not freedom.",
    " Incorrect. Satisfaction is usually reduced, not increased, under perfectionism.",
    " Incorrect. Perfectionists tend to fear failure more, not less."
  ]
},
{
  "question": "Philosophically, what is the core debate surrounding the concept of perfection?",
  "options": [
    "A) Whether perfection is a feeling or an idea.",
    "B) Whether true perfection is achievable or an unattainable ideal.",
    "C) Whether perfection is a social construct or an inborn trait.",
    "D) Whether the pursuit of perfection is a positive or negative endeavor."
  ],
  "correct": 1,
  "feedback": [
    " Incorrect. That focuses on the nature of perfection, not its attainability.",
    " Correct! For centuries, philosophers have debated whether perfection can ever be fully realized or if it is merely an ideal to strive for.",
    " Incorrect. That’s a different philosophical question about origin, not attainability.",
    " Incorrect. This option focuses on moral value, not the central debate of possibility."
  ]
},
{
  "question": "What do many artists think about perfection in art?",
  "options": [
    "A) Imperfections make art unique.",
    "B) Art must be perfect.",
    "C) Perfection is the goal.",
    "D) Art is not about perfection."
  ],
  "correct": 0,
  "feedback": [
    " Correct! Many artists believe that imperfections give a work character and make it special, rather than being flawless.",
    " Incorrect. Artists often value imperfection over flawlessness.",
    " Incorrect. Perfection isn’t typically the goal in art.",
    " Incorrect. Art often involves discussions about perfection and imperfection."
  ]
},
{
  "question": "In modern society, what is a key factor that often contributes to the pressure to be perfect?",
  "options": [
    "A) A complete lack of role models and successful individuals.",
    "B) The reduced influence of social media and advertising.",
    "C) The constant portrayal of idealized lives and images on social media.",
    "D) A global trend toward slower and less competitive lifestyles."
  ],
  "correct": 2,
  "feedback": [
    " Incorrect. There are plenty of role models, which can add pressure.",
    " Incorrect. Social media influence has increased, not decreased.",
    " Correct! Social media shows curated images of perfection, creating unrealistic standards others feel pressured to match.",
    " Incorrect. Society is moving faster and more competitively, not slower."
  ]
},
{
  "question": "Which of the following describes a key symptom of perfectionism?",
  "options": [
    "A) Being able to relax easily after finishing a project.",
    "B) Setting realistic and flexible goals.",
    "C) Accepting mistakes as part of the learning process.",
    "D) Feeling like your efforts are never good enough."
  ],
  "correct": 3,
  "feedback": [
    " Incorrect. Perfectionists struggle to relax after finishing work.",
    " Incorrect. They often set unrealistic, rigid goals instead.",
    " Incorrect. Perfectionists have difficulty accepting mistakes.",
    " Correct! Perfectionism makes people feel their work is never enough, leading to dissatisfaction."
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
          MaterialPageRoute(builder: (_) => const BlueCardDeckAnimation(title: "The pearl of love", nextPage: BiographyReadingPage())),
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

  int _lastQuestionIndex = 0;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final String biographyText = '''
The pearl is more beautiful than the brightest crystal, the moralist says, because it is created through the suffering of a living creature. I can’t say much about this because pearls don’t fascinate me. Their cloudy shine doesn’t move me. Nor can I decide for myself about the long-standing debate: Is the Pearl of Love the cruelest story, or is it just a beautiful tale about the immortality of beauty?

Both the story and the debate are well-known to students of medieval Persian literature. The story is short, but the commentary on it fills many books. Some see it as a poetic invention, others as an allegory with deep meanings. Theologians have discussed it, especially about the resurrection of the body after death. Writers on art have used it as a parable. And many believe it is simply a true story.

The story takes place in North India, a land full of great love stories. It was a country of sunshine, lakes, forests, hills, and fertile valleys. Far away, the great mountains stood with their peaks covered in eternal snow. There was a young prince who ruled the land. He found a maiden of incredible beauty and charm and made her his queen. He loved her deeply, and she became his everything. Their love was full of joy, sweetness, and hope—a love more wonderful than anything you could imagine. It lasted for a year and part of another year. Then, suddenly, she died from a poisonous sting in a thicket.



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
  question: "How long did the prince and the maiden’s love last?",
  options: [
    "A) Several years",
    "B) A few months",
    "C) Around 18 months",
    "D) Only a week"
  ],
  correctIndex: 2,
  explanation:
      "The text says their love 'lasted for a year and part of another year,' indicating around eighteen months.",
  incorrectExplanations: [
    "It wasn’t several years — their love was brief in comparison.",
    "It lasted longer than a few months.",
    "Correct answer!",
    "It was much longer than a single week."
  ],
),

QuestionData(
  question: "Why might scholars use the story of The Pearl of Love in their work?",
  options: [
    "A) To practice calligraphy",
    "B) To explore philosophical ideas",
    "C) To teach geography and history",
    "D) To design jewelry"
  ],
  correctIndex: 1,
  explanation:
      "The text mentions that theologians, writers on art, and literary scholars use the story to explore deep meanings, allegories, and resurrection concepts.",
  incorrectExplanations: [
    "The story isn’t used for handwriting practice.",
    "Correct answer!",
    "It’s not a lesson in geography or history.",
    "The story’s 'pearl' is symbolic, not a jewelry design."
  ],
),

QuestionData(
  question: "Who most likely wrote the commentary on The Pearl of Love story?",
  options: [
    "A) Scholars",
    "B) Students of geography",
    "C) Ordinary villagers",
    "D) Soldiers"
  ],
  correctIndex: 0,
  explanation:
      "The passage mentions that students, theologians, and writers have commented extensively on the story, indicating it was scholars who wrote the commentary.",
  incorrectExplanations: [
    "Correct answer!",
    "Geography students aren’t mentioned in relation to the commentary.",
    "Villagers are not described as commentators.",
    "Soldiers are unrelated to the story’s analysis."
  ],
),

QuestionData(
  question: "What does the widespread discussion of The Pearl of Love suggest about society’s values at the time?",
  options: [
    "A) People preferred simple stories over complex debates",
    "B) Society valued poetry, and the immortality of beauty",
    "C) People only cared about historical events",
    "D) Society ignored stories of love and beauty"
  ],
  correctIndex: 1,
  explanation:
      "The text shows that scholars and theologians spent much time debating the story’s meaning, indicating a cultural emphasis on poetry, morality, and beauty.",
  incorrectExplanations: [
    "Discussions were complex, not simple.",
    "Correct answer!",
    "The focus was on symbolic art, not history.",
    "Love and beauty were deeply appreciated, not ignored."
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

class _BiographyReadingPageSecondState
    extends State<BiographyReadingPageSecond> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;
  int _lastQuestionIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final String biographyTextSecond = '''
Her death left the prince heartbroken. He was silent and still with grief. People feared he might kill himself, and he had no sons or brothers to take his place. For two days and nights, he lay face down, fasting, at the foot of the couch where her calm, beautiful body rested. Then he got up, ate, and went about quietly, as if he had made a big decision. He had her body placed in a coffin of lead mixed with silver. Around that, he had another coffin made of precious, scented wood decorated with gold. Finally, he had a sarcophagus of alabaster, inlaid with precious stones. While these were being made, he spent his time by the pools, in the gardens, pavilions, and palace rooms where they had been happiest together, thinking about her beauty. He didn’t tear his clothes or cover himself in ashes, as was the custom, because his love was too great for such displays. At last, he came before his advisors and the people and told them what he planned to do.

He said he would never love another woman or even think of them. Instead, he would adopt a young boy as his heir and train him to rule. He would do his duties as a prince, but for the rest of his life, he would use all his power, strength, and wealth to build a monument worthy of his incomparable, beloved queen. It would be a building of perfect grace and beauty, more marvelous than anything ever built, so that it would be a wonder for all time. People would treasure it, speak of it, and come from all over the world to see it and remember his queen. He called this building the Pearl of Love.

His advisors and people agreed, and so he began.
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
  question: "Where did the prince spend his time while the coffins and sarcophagus were being made?",
  options: [
    "A) In a distant magical forest very far from the palace",
    "B) At the top of the highest mountain",
    "C) Only in his private chambers",
    "D) In the palace rooms where he was happy with his queen"
  ],
  correctIndex: 3,
  explanation:
      "The text explicitly mentions that he spent time in the rooms of shared happiness, reflecting on his queen’s beauty and their joyful moments together.",
  incorrectExplanations: [
    "He did not isolate himself in a faraway forest.",
    "He didn’t travel to any mountain; his grief kept him inside the palace.",
    "He went beyond his private chambers, revisiting places of shared love.",
    "Correct answer!"
  ],
),

QuestionData(
  question: "How long did the prince lie face down, fasting, in grief?",
  options: [
    "A) One day",
    "B) Around 48 hours",
    "C) A week",
    "D) Several months"
  ],
  correctIndex: 1,
  explanation:
      "The passage clearly states that he lay face down for 'two days and nights,' meaning around 48 hours.",
  incorrectExplanations: [
    "It was longer than a single day.",
    "Correct answer!",
    "He did not remain in grief for a week.",
    "His mourning lasted only two days, not months."
  ],
),

QuestionData(
  question: "What materials did the prince choose for his queen’s burial?",
  options: [
    "A) Ordinary wood and stone",
    "B) Precious stones and some noble metals",
    "C) Clay, stones, and bricks",
    "D) Simple linen and a glass full of exotic flowers"
  ],
  correctIndex: 1,
  explanation:
      "The text describes three layers of coffins and sarcophagus — each crafted from noble and precious materials — showing his desire for an extraordinary burial.",
  incorrectExplanations: [
    "He chose far more luxurious materials than ordinary ones.",
    "Correct answer!",
    "He did not use common materials like clay or brick.",
    "He prepared an elaborate resting place, not a simple one."
  ],
),

QuestionData(
  question: "What does the prince’s decision to focus on the monument instead of remarriage suggest about societal expectations and values?",
  options: [
    "A) That people expected him to quickly find another wife",
    "B) The importance of honoring love and legacy",
    "C) That building monuments was discouraged",
    "D) That heirs were unimportant"
  ],
  correctIndex: 1,
  explanation:
      "The prince prioritizes commemorating his queen’s beauty and love over remarriage, revealing a cultural emphasis on devotion, remembrance, and lasting legacy.",
  incorrectExplanations: [
    "Although some may have expected remarriage, his actions highlight loyalty instead.",
    "Correct answer!",
    "The story actually celebrates the creation of monuments as a tribute to love.",
    "The question of heirs is never emphasized here."
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

class _BiographyReadingPageThirdState extends State<BiographyReadingPageThird> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;
  int _lastQuestionIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final String biographyTextSecond = '''
Year after year, he devoted himself to building and decorating the Pearl of Love. A great foundation was carved out of solid rock in a place with a view of the snowy mountains across the valley. There were villages, hills, a winding river, and three distant cities. They placed the alabaster sarcophagus under a beautifully crafted pavilion. Around it, they built pillars of rare and lovely stone, carved walls, and a grand structure with a dome, pinnacles, and cupolas, as delicate as a jewel. At first, the design was smaller and more detailed, with many carved screens and clusters of pink pillars. The sarcophagus lay like a child sleeping among flowers. The first dome was covered with green tiles held together by silver, but this was later removed because it didn’t feel grand enough for the prince’s growing vision.

By this time, the prince was no longer the young man who had loved the queen. He was now serious and focused, completely dedicated to building the Pearl of Love. With each year, he learned more about arches, walls, and supports. He discovered new stones, colors, and effects he had never imagined at the start. His sense of color became finer and cooler. He no longer liked the bright, gold-lined decorations that had pleased him at first. Now, he wanted colors like the sky, subtle shades of distance, deep shadows, and sudden bursts of purple light. He grew tired of carvings, pictures, and small, detailed work. “Those were pretty things,” he said of his earlier decorations, and he moved them to smaller buildings where they wouldn’t distract from the main design. His artistry grew greater and greater. People watched in awe as the Pearl of Love rose to a superhuman size and magnificence. They had never expected anything so sublime. “Love can work miracles,” they whispered, and women everywhere loved the prince for his devotion.
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
  question: "What does the prince’s changing approach to decoration over time suggest about his growth as a person and artist?",
  options: [
    "A) He became impatient with details and rushed the work",
    "B) He preferred temporary, flashy designs",
    "C) He lost interest in the project entirely",
    "D) He matured, refining his vision and artistic judgment"
  ],
  correctIndex: 3,
  explanation:
      "The text highlights the prince’s evolving taste and appreciation for subtle artistry, showing his personal and artistic maturity over time.",
  incorrectExplanations: [
    "He didn’t lose patience — he became more deliberate with details.",
    "His focus was on refinement, not flashiness.",
    "He remained deeply invested in the project.",
    "Correct answer!"
  ],
),

QuestionData(
  question: "What role did the prince play in building the monument?",
  options: [
    "A) Only funded it",
    "B) Guided the design",
    "C) Delegated all work",
    "D) Followed advisors"
  ],
  correctIndex: 1,
  explanation:
      "He actively guided and shaped the design, showing his involvement in both architecture and artistic decisions.",
  incorrectExplanations: [
    "He did much more than just provide funding.",
    "Correct answer!",
    "He personally directed the creative process rather than delegating all work.",
    "He didn’t simply follow advice — he led the vision."
  ],
),

QuestionData(
  question: "How does the public’s reaction to the Pearl of Love reflect their perception of the prince’s devotion?",
  options: [
    "A) They resented the time he spent on personal grief",
    "B) They interpreted his dedication as a powerful expression of love",
    "C) They were indifferent, seeing it as just another building",
    "D) They envied the wealth spent on decoration"
  ],
  correctIndex: 1,
  explanation:
      "The admiration and awe of the public reveal their recognition of the prince’s extraordinary devotion and love expressed through the monument.",
  incorrectExplanations: [
    "The text doesn’t mention resentment from the people.",
    "Correct answer!",
    "They were moved, not indifferent, by his work.",
    "There’s no focus on envy, only admiration."
  ],
),

QuestionData(
  question: "Why did the prince eventually remove the green-tiled dome held together by silver?",
  options: [
    "A) It didn’t match his vision",
    "B) It was too weak",
    "C) Villagers disliked it",
    "D) It was too costly"
  ],
  correctIndex: 0,
  explanation:
      "The prince’s decision to remove the dome reflects his evolving artistic standards, not practicality — it no longer fit his refined vision.",
  incorrectExplanations: [
    "Correct answer!",
    "There’s no mention of structural weakness.",
    "Public opinion didn’t influence his decision.",
    "The removal was aesthetic, not financial."
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