// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Blue/Content/Spot3/Spot_Page/ReadingSpot.dart';

import 'dart:math' as math;


class EquationSplashScreen extends StatefulWidget {
  const EquationSplashScreen({super.key});

  @override
  State<EquationSplashScreen> createState() => _EquationSplashScreenState();
}

class _EquationSplashScreenState extends State<EquationSplashScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgCtrl;
  late AnimationController _iconCtrl;
  late AnimationController _driftCtrl;
  late AnimationController _glowCtrl;
  late AnimationController _orbit1Ctrl;
  late AnimationController _orbit2Ctrl;
  late AnimationController _orbit3Ctrl;
  late AnimationController _starsCtrl;
  late AnimationController _shootCtrl;
  late AnimationController _textCtrl;

  late Animation<double> _bgFade;
  late Animation<double> _iconScale;
  late Animation<double> _iconRotate;

  // Drift: translate X, Y + rotate
  late Animation<double> _driftX;
  late Animation<double> _driftY;
  late Animation<double> _driftR;

  late Animation<double> _innerGlow;
  late Animation<double> _outerGlow;

  late Animation<double> _titleOpacity, _titleSlide;
  late Animation<double> _authorOpacity;
  late Animation<double> _dividerOpacity, _dividerScale;

  final List<Animation<double>> _starAnim = [];

  // x%, y%, r, dur(s), delay(s), type(0=dot 1=cross)
  static const List<List<double>> _stars = [
    [.07,.03,1.0,2.2,.0,0],[.28,.05,1.0,2.9,.3,0],[.52,.02,.75,2.5,.6,0],
    [.76,.04,1.25,2.0,.9,0],[.92,.08,.75,3.1,.2,0],[.14,.12,.75,2.7,.5,0],
    [.44,.10,.50,2.3,1.0,0],[.65,.07,1.0,3.3,.7,0],[.85,.15,.50,2.1,.4,0],
    [.05,.18,1.0,2.8,1.2,0],[.38,.20,.75,2.4,.8,0],[.72,.22,.75,3.0,.3,0],
    [.95,.25,.50,1.9,1.1,0],[.04,.60,.75,2.6,.6,0],[.25,.64,1.0,2.2,.9,0],
    [.58,.68,.50,3.2,.4,0],[.82,.72,1.0,2.0,1.3,0],[.42,.76,.50,2.9,.7,0],
    [.16,.80,.75,2.5,.2,0],[.68,.85,.50,2.7,1.0,0],[.90,.89,.75,3.1,.5,0],
    [.33,.93,.50,2.3,.8,0],
    // sparkles
    [.36,.06,4.5,2.6,.4,1],[.91,.18,3.5,3.0,.9,1],[.12,.76,4.0,2.8,1.2,1],
  ];

  static const List<List<double>> _shoots = [
    [.09,.12,100,2.0],
    [.28,.06, 65,7.0],
  ];

  // ring, offsetDeg, radius, starR
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
    _iconScale = Tween<double>(begin: .4, end: 1.0).animate(
        CurvedAnimation(parent: _iconCtrl, curve: Curves.elasticOut));
    _iconRotate = Tween<double>(begin: -20 * math.pi / 180, end: 0).animate(
        CurvedAnimation(parent: _iconCtrl, curve: Curves.easeOut));
    Future.delayed(const Duration(milliseconds: 200),
        () { if (mounted) _iconCtrl.forward(); });

    // Drift — 7s loop with 4 keypoints via TweenSequence
    _driftCtrl = AnimationController(
        duration: const Duration(milliseconds: 7000), vsync: this)
      ..repeat();
    _driftX = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end:  6), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 6, end: -4), weight: 25),
      TweenSequenceItem(tween: Tween(begin:-4, end:  8), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 8, end:  0), weight: 25),
    ]).animate(CurvedAnimation(parent: _driftCtrl, curve: Curves.easeInOut));
    _driftY = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end:  -9), weight: 25),
      TweenSequenceItem(tween: Tween(begin:-9, end: -14), weight: 25),
      TweenSequenceItem(tween: Tween(begin:-14, end: -6), weight: 25),
      TweenSequenceItem(tween: Tween(begin:-6, end:   0), weight: 25),
    ]).animate(CurvedAnimation(parent: _driftCtrl, curve: Curves.easeInOut));
    _driftR = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween(begin: 0, end:  4 * math.pi / 180), weight: 25),
      TweenSequenceItem(
          tween: Tween(begin: 4 * math.pi / 180, end: -3 * math.pi / 180),
          weight: 25),
      TweenSequenceItem(
          tween: Tween(begin: -3 * math.pi / 180, end: 5 * math.pi / 180),
          weight: 25),
      TweenSequenceItem(
          tween: Tween(begin: 5 * math.pi / 180, end: 0), weight: 25),
    ]).animate(CurvedAnimation(parent: _driftCtrl, curve: Curves.easeInOut));

    // Glow
    _glowCtrl = AnimationController(
        duration: const Duration(milliseconds: 3500), vsync: this)
      ..repeat(reverse: true);
    _innerGlow = Tween<double>(begin: .16, end: .36).animate(
        CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));
    _outerGlow = Tween<double>(begin: .10, end: .22).animate(
        CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));

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

    // Shooting stars
    _shootCtrl = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this)..repeat();

    // Text
    _textCtrl = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    _titleOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut));
    _titleSlide   = Tween<double>(begin: 18, end: 0).animate(
        CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut));
    _authorOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _textCtrl,
            curve: const Interval(.4, 1.0, curve: Curves.easeOut)));
    _dividerOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _textCtrl,
            curve: const Interval(.0, .6, curve: Curves.easeOut)));
    _dividerScale   = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _textCtrl,
            curve: const Interval(.0, .6, curve: Curves.easeOut)));
    Future.delayed(const Duration(milliseconds: 750),
        () { if (mounted) _textCtrl.forward(); });

    // Navigate
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const Equation()));
    });
  }

  @override
  void dispose() {
    _bgCtrl.dispose();
    _iconCtrl.dispose();
    _driftCtrl.dispose();
    _glowCtrl.dispose();
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
            _EqNebula(color: const Color(0xFF0A1964),
                alignment: const Alignment(-1.0, -.85), size: 400),
            _EqNebula(color: const Color(0xFF052882),
                alignment: const Alignment(1.0, .80), size: 300, delay: 2000),
            _EqNebula(color: const Color(0xFF140A78),
                alignment: const Alignment(.80, .20), size: 220, delay: 4000),

            // Star field
            AnimatedBuilder(
              animation: Listenable.merge([_starsCtrl, _shootCtrl]),
              builder: (_, __) => CustomPaint(
                painter: _EqStarPainter(
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
            _EqParticle(xF:.18,yF:.20,sz:5,shape:0,durMs:3400,delayMs:0),
            _EqParticle(xF:.84,yF:.22,sz:4,shape:1,durMs:2900,delayMs:500),
            _EqParticle(xF:.11,yF:.43,sz:3,shape:0,durMs:4000,delayMs:900),
            _EqParticle(xF:.87,yF:.41,sz:4,shape:1,durMs:3100,delayMs:300),
            _EqParticle(xF:.22,yF:.27,sz:5,shape:2,durMs:3600,delayMs:700),
            _EqParticle(xF:.80,yF:.38,sz:4,shape:3,durMs:2800,delayMs:1100),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Astronaut
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _iconCtrl, _driftCtrl, _glowCtrl,
                      _orbit1Ctrl, _orbit2Ctrl, _orbit3Ctrl,
                    ]),
                    builder: (_, __) {
                      final driftX = _iconCtrl.isCompleted ? _driftX.value : 0.0;
                      final driftY = _iconCtrl.isCompleted ? _driftY.value : 0.0;
                      final driftR = _iconCtrl.isCompleted ? _driftR.value : 0.0;
                      final entranceR = _iconCtrl.isCompleted
                          ? 0.0 : _iconRotate.value;
                      return Transform.translate(
                        offset: Offset(driftX, driftY),
                        child: Transform.rotate(
                          angle: entranceR + driftR,
                          child: Transform.scale(
                            scale: _iconScale.value,
                            child: SizedBox(
                              width: 180, height: 180,
                              child: CustomPaint(
                                painter: _EqOrbitPainter(
                                  innerGlow: _innerGlow.value,
                                  outerGlow: _outerGlow.value,
                                  orbit1T: _orbit1Ctrl.value,
                                  orbit2T: _orbit2Ctrl.value,
                                  orbit3T: _orbit3Ctrl.value,
                                  orbitStars: _orbitStars,
                                ),
                                child: Center(
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
                                      FontAwesomeIcons.userAstronaut,
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

                  const SizedBox(height: 20),

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
                            Expanded(child: Container(
                                height: 1,
                                color: const Color(0xFF5090FF).withOpacity(.40))),
                            const SizedBox(width: 8),
                            const Icon(Icons.star_rounded,
                                color: Color(0xFF64A0FF), size: 14),
                            const SizedBox(width: 8),
                            Expanded(child: Container(
                                height: 1,
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
                          'The Nothing Equation',
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
                        'By Tom Godwin, 1957',
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

// ─── Orbit + Glow painter ─────────────────────────────────────────────
class _EqOrbitPainter extends CustomPainter {
  final double innerGlow, outerGlow;
  final double orbit1T, orbit2T, orbit3T;
  final List<List<double>> orbitStars;

  const _EqOrbitPainter({
    required this.innerGlow, required this.outerGlow,
    required this.orbit1T, required this.orbit2T, required this.orbit3T,
    required this.orbitStars,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width  / 2;
    final cy = size.height / 2;
    final sc = size.width  / 180;

    // Outer glow
    canvas.drawCircle(Offset(cx, cy), 82 * sc,
        Paint()..shader = RadialGradient(colors: [
          const Color(0xFF4080FF).withOpacity(outerGlow),
          const Color(0xFF4080FF).withOpacity(0),
        ]).createShader(Rect.fromCircle(
            center: Offset(cx, cy), radius: 82 * sc)));

    // Inner glow
    canvas.drawCircle(Offset(cx, cy), 60 * sc,
        Paint()..shader = RadialGradient(colors: [
          const Color(0xFF2060FF).withOpacity(innerGlow),
          const Color(0xFF1040CC).withOpacity(innerGlow * .2),
          const Color(0xFF1040CC).withOpacity(0),
        ], stops: const [0.0, .55, 1.0]).createShader(Rect.fromCircle(
            center: Offset(cx, cy), radius: 60 * sc)));

    // Orbiting stars
    for (final os in orbitStars) {
      final ring      = os[0].toInt();
      final offsetDeg = os[1];
      final radius    = os[2] * sc;
      final starR     = os[3] * sc;
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
  }

  @override
  bool shouldRepaint(covariant _EqOrbitPainter o) =>
      o.innerGlow != innerGlow || o.outerGlow != outerGlow ||
      o.orbit1T   != orbit1T   || o.orbit2T   != orbit2T  ||
      o.orbit3T   != orbit3T;
}

// ─── Nebula ───────────────────────────────────────────────────────────
class _EqNebula extends StatefulWidget {
  final Color color;
  final Alignment alignment;
  final double size;
  final int delay;
  const _EqNebula({required this.color, required this.alignment,
      required this.size, this.delay = 0});
  @override State<_EqNebula> createState() => _EqNebulaState();
}
class _EqNebulaState extends State<_EqNebula>
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
class _EqParticle extends StatefulWidget {
  final double xF, yF, sz;
  final int shape, durMs, delayMs;
  const _EqParticle({required this.xF, required this.yF, required this.sz,
      required this.shape, required this.durMs, required this.delayMs});
  @override State<_EqParticle> createState() => _EqParticleState();
}
class _EqParticleState extends State<_EqParticle>
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
class _EqStarPainter extends CustomPainter {
  final List<List<double>> stars;
  final List<double> starOpacities;
  final double shootT;
  final List<List<double>> shoots;
  final Size canvasSize;

  const _EqStarPainter({
    required this.stars, required this.starOpacities,
    required this.shootT, required this.shoots, required this.canvasSize,
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
  bool shouldRepaint(covariant _EqStarPainter o) =>
      o.shootT != shootT || o.starOpacities != starOpacities;
}

class Equation extends StatefulWidget {
  const Equation({super.key});
  @override
  State<Equation> createState() => _EquationState();
}

class _EquationState extends State<Equation> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "In psychology, what is a modern term often used instead of “madness”?",
      "options": [
        "A) Sleep disorder",
        "B) Emotional delay",
        "C) Mental illness",
        "D) Hyper focus"
      ],
      "correct": 2,
      "feedback": [
        " 'Sleep disorder' is a different condition unrelated to the outdated term 'madness'.",
        " 'Emotional delay' is not a standard clinical term.",
        " Correct! “Mental illness” is the clinical term used today, replacing the outdated term “madness.”",
        " 'Hyper focus' is not a replacement term for madness."
      ]
    },
    {
      "question":
          "Which of these is a condition often associated with the idea of madness?",
      "options": ["A) Asthma", "B) Depression", "C) Psychosis", "D) Flu"],
      "correct": 2,
      "feedback": [
        " Asthma is a physical illness, not associated with madness.",
        " Depression is a mental illness but not commonly linked with the idea of madness in the same way.",
        " Correct! Psychosis, which involves losing touch with reality, is often linked to the idea of madness.",
        " Flu is a viral infection and unrelated to mental health terminology."
      ]
    },
    {
      "question": "What is one harmful stereotype about madness?",
      "options": [
        "A) That it’s caused by stress",
        "B) That people who experience it are violent",
        "C) That it can be treated",
        "D) That it affects many people"
      ],
      "correct": 1,
      "feedback": [
        " While stress can be a factor, it's not the main harmful stereotype.",
        " Correct! The idea that people with mental illness are dangerous is a common and harmful stereotype.",
        " This is actually a positive and accurate view, not a stereotype.",
        " This is a factual statement, not a harmful stereotype."
      ]
    },
    {
      "question": "What should you do if someone seems mentally unwell?",
      "options": [
        "A) Ignore them",
        "B) Make fun of them",
        "C) Support or help them",
        "D) Gossip about it"
      ],
      "correct": 2,
      "feedback": [
        " Ignoring someone in need is not helpful.",
        " Making fun of someone is harmful and stigmatizing.",
        " Correct! Offering help is the kindest and safest response.",
        " Gossiping adds to the stigma and does not support the person."
      ]
    },
    {
      "question":
          "Why is it important to talk about madness and mental illness openly?",
      "options": [
        "A) To criticize people and their behaviors",
        "B) To create fear and misinformation",
        "C) To reduce stigma and support mental health",
        "D) To avoid the topic in school"
      ],
      "correct": 2,
      "feedback": [
        " Criticism does not help reduce stigma or support health.",
        " Creating fear and misinformation is harmful.",
        " Correct! Open discussion helps reduce shame and encourages people to seek help.",
        " Avoiding the topic does not promote understanding or support."
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
              builder: (_) => const BlueCardDeckAnimation(title: "The nothing equation", nextPage: BiographyReadingPage())),
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
The cruiser disappeared into hyperspace, and he was alone in the observation bubble, far beyond the edge of the galaxy. He looked out the windows at the endless emptiness around him and wondered what had scared the men before him so much.

One thing he was sure of: there was nothing outside the bubble waiting to kill him. The first attendant had killed himself, and the second had gone insane. But he believed the danger must have been inside the bubble—or maybe they had just imagined it.

He walked across the small room, his magnetic shoes making loud noises on the thin metal floor. He sat down in the only chair and thought about what he knew.

The bubble was part of Earth’s Galactic Observation Bureau. It was placed far outside the galaxy to collect data that couldn’t be gathered from within. Because the instruments were very sensitive, the bubble had to be small and light. That’s why only one person could work there at a time.

The first attendant, Horne, had been left there for six months. When the cruiser returned with his replacement, they found him dead from an overdose of sleeping pills. His last log entry, written three months earlier, said:

“I haven’t used the instruments for a long time because it hates us and doesn’t want us here. It hates me the most and keeps trying to get inside to kill me. I can hear it when I listen, and I know it won’t be long. I’m afraid, and I want to be asleep when it comes. But I’ll have to do it soon because I only have twenty sleeping pills left...”

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
        'What does the word “overdose” most likely mean in the sentence below?\n\n“When the cruiser returned with his replacement, they found him dead from an overdose of sleeping pills.”',
    options: [
      "A) Taking a small dose of a substance",
      "B) A medicine with a strong flavor",
      "C) Taking too much of a substance",
      "D) A  bunch of colorful pills"
    ],
    correctIndex: 2,
    explanation:
        ' The context clue is “they found him dead,” which shows the overdose was fatal. So, “overdose” means taking too much of a drug or medicine, leading to death or harm.',
    incorrectExplanations: [
      ' A “healthy dose” would not cause death.',
      ' “A strong flavor” does not relate to medicine.',
      ' Correct answer!',
      ' “A missing pill” implies one is gone, not an excess.'
    ],
  ),
  QuestionData(
    question:
        'What does the word “endless” most likely mean in the sentence below?\n\n“He looked out the windows at the endless emptiness around him…”',
    options: [
      "A) Full of endings",
      "B) Without an end or limit",
      "C) Containing many ends",
      "D) Easy to finish"
    ],
    correctIndex: 1,
    explanation:
        ' The suffix “-less” means “without.” So, “endless” means without an end or limit.',
    incorrectExplanations: [
      ' “Endless” is the opposite of “full of endings.”',
      ' Correct answer!',
      ' “Containing many ends” is incorrect because “endless” means there is no end.',
      ' The sentence implies something ongoing, not easy to finish.'
    ],
  ),
  QuestionData(
    question:
        'What does the word “replacement” most likely mean in the sentence below?\n\n“When the cruiser returned with his replacement, they found him dead from an overdose of sleeping pills.”',
    options: [
      "A) A person who takes someone’s place",
      "B) A person who gives medicine",
      "C) A broken object",
      "D) A mistake or accident"
    ],
    correctIndex: 0,
    explanation:
        ' “Replacement” is a true cognate—it looks and means the same in English and Spanish (reemplazo). It refers to a person or thing that takes the place of another.',
    incorrectExplanations: [
      ' Correct answer!',
      ' This refers to a medical role, not taking someone’s place.',
      ' A “replacement” is not a broken object.',
      ' A “replacement” is not an accident or mistake.'
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
The sentence was never finished. The temperature records showed he died that same night.

The bubble was cleaned and checked, but no sign of danger was found.

Silverman was Horne’s replacement. When the cruiser returned six months later with Green, Silverman was completely insane. He talked about something outside the bubble trying to kill him. The closest he came to making sense was when he said:

“Nothing—you can’t really see it. But you feel it watching you, and you hear it trying to get inside to kill you. Once I bumped the wall, and—for God’s sake—take me away from it! Take me back to Earth...”

Then he tried to hide under the captain’s desk, and the doctor took him away.

The bubble was checked again, and the cruiser searched the surrounding space with all its detectors. Nothing was found.

When it was time for Green to take over, he reported to Captain McDowell.

“Everything is ready, Green,” McDowell said. “You’re the next one.” He frowned. “It would be better if I could choose the replacement instead of the Bureau.”
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
        ' What does the word “ observation bubble” most likely mean in the sentence below?\n\n“The cruiser disappeared into hyperspace, and he was alone in the observation bubble, far beyond the edge of the galaxy.”',
    options: [
      "A) A soap bubble",
      "B) A small spaceship",
      "C) A gas floating in space",
      "D) A group of stars"
    ],
    correctIndex: 1,
    explanation:
        ' The context clue is “observation” and “far beyond the edge of the galaxy,” which suggests that the bubble is a small, enclosed structure like a spaceship or room used for scientific observation, not a literal bubble.',
    incorrectExplanations: [
      ' A literal soap bubble doesn’t fit the space context.',
      ' Correct answer!',
      ' This doesn’t make sense in the given context.',
      ' A group of stars isn’t what “bubble” refers to here.'
    ],
  ),
  QuestionData(
    question:
        'What does the word “sentence” most likely mean in the sentence below?\n\n“The sentence was never finished. The temperature records showed he died that same night.”',
    options: ["A) Oración", "B) Castigo", "C) Sentencia", "D) Descubrimiento"],
    correctIndex: 0,
    explanation:
        ' Though “sentence” looks like the Spanish word “sentencia” (a court ruling), it is a false cognate. Here it refers to a grammatical unit of words, “oración” in Spanish.',
    incorrectExplanations: [
      ' Correct answer!',
      ' This is not a legal context, so “castigo” is incorrect.',
      ' This is a false cognate — “sentencia” in Spanish refers to a legal ruling.',
      ' “Descubrimiento” doesn’t relate to the structure of language.'
    ],
  ),
  QuestionData(
    question:
        'What does the word “sign” most likely mean in the sentence below?\n\n“There had been no sign of struggle, no sign of fear, only the silent presence of the logbook.”',
    options: ["A) Señal", "B) Firma", "C) Rótulo", "D) Milagro"],
    correctIndex: 0,
    explanation:
        ' *“Sign” is a false cognate of the Spanish word “signo.”Although they look similar, “sign” in English usually means evidence or a signal of something, closer in meaning to “señal” in Spanish.”',
    incorrectExplanations: [
      ' Correct answer!',
      ' A signature or “firma” is not implied here.',
      ' “Rótulo” refers to a label or signboard, not the intended meaning.',
      ' “Milagro” or miracle doesn’t fit this context at all.'
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
Green felt a little offended. “The Bureau found my intelligence and initiative satisfactory.”

“I know—the qualities you don’t need. What they need is someone like one of my engine room workers—someone too ignorant to get scared and too dumb to go crazy. Then we might get a sane report in six months instead of more madness.”

“I suggest,” Green said stiffly, “that you wait before judging me, sir.”

And that was all Green knew about the danger, real or imagined, that had driven two men to insanity. He had six months to find the answer. Six months minus... He looked at the clock and saw that twenty minutes had passed since the cruiser left. It felt much longer.

He lit a cigarette, and his metal shoes scraped loudly on the floor. The bubble was as silent as a tomb.

It wasn’t much bigger than a tomb—a sphere eighteen feet across, made of thin steel with reinforcing girders on the outside to keep it from bursting. The floor was six feet above the bottom, and the space below held the air system, batteries, and food storage. The room he was in had a chair, a table, a cot, instrument panels, a microfilm projector, and some exercise springs. That was all.

There was no way to communicate with anyone because a communicator would interfere with the instruments. But there was a small library of microfilms to help pass the time.

Still, it wasn’t boredom that worried him. It was the fear that had driven Horne and Silverman mad.

Suddenly, something cracked loudly behind him, like a gunshot. He jumped up and turned around.

It was just a metal reel of data tape falling into a tray.
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
        'What does the word “boredom” most likely mean in the sentence below?\n\n“Still, it wasn’t boredom that worried him. It was the fear that had driven Horne and Silverman mad.”',
    options: [
      "A) A state of curiosity",
      "B) A state of being asleep",
      "C) A state of being uninterested",
      "D) A state of intense fear"
    ],
    correctIndex: 2,
    explanation:
        ' The context clue is “it wasn’t boredom… it was fear,” showing that boredom means a lack of interest or stimulation — not something scary, just dull.',
    incorrectExplanations: [
      ' Curiosity is the opposite of boredom.',
      ' Being asleep is not the same as being bored.',
      ' Correct answer!',
      ' Boredom isn’t intense fear — the sentence contrasts them.'
    ],
  ),
  QuestionData(
    question:
        'What does the word “tomb” most likely mean in the sentence below?\n\n“The bubble was as silent as a tomb.”',
    options: ["A) Tiempo", "B) Cama", "C) Palabra", "D) Tumba"],
    correctIndex: 3,
    explanation:
        ' “Tomb” is a true cognate of the Spanish word “tumba.” Both refer to a grave or burial place. The comparison emphasizes the bubble’s dead silence.',
    incorrectExplanations: [
      ' Tiempo means “time,” which doesn’t fit the metaphor.',
      ' Cama means “bed,” unrelated to the silence described.',
      ' Palabra means “word,” not the intended image.',
      ' Correct answer!'
    ],
  ),
  QuestionData(
    question:
        'What does the word “reinforcing” most likely mean in the sentence below?\n\n“…a sphere eighteen feet across, made of thin steel with reinforcing girders on the outside to keep it from bursting.”',
    options: [
      "A) Making weaker",
      "B) Taking away structure",
      "C) Cleaning carefully",
      "D) Strengthening or supporting"
    ],
    correctIndex: 3,
    explanation:
        ' The prefix “re-” means “again” or “back,” and “reinforcing” means strengthening again or making stronger. The girders are there to support the structure.',
    incorrectExplanations: [
      ' “Reinforcing” means the opposite — it makes something stronger.',
      ' “Taking away” contradicts the idea of support.',
      ' “Reinforcing” is not about cleaning.',
      ' Correct answer!'
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
His heart was racing, and his attempt to laugh at his nervousness sounded hollow. Something—inside or outside the bubble—had driven two men insane. Now that he was alone in the bubble, he couldn’t dismiss their fear as imagination. Both men had been rational and intelligent, just like him.

He searched the bubble carefully, looking everywhere. When he crawled into the lower compartment, he hesitated, then opened his knife before checking the dark corners. He found nothing—not even dust.

Back in his chair, he began to doubt his earlier belief. Maybe there really was something outside the bubble. Both Horne and Silverman had said “it” was trying to get inside to kill them.

They had been very clear about that.

The bubble had six windows, allowing him to see the instruments mounted outside. He looked out each one and saw the same vast emptiness. The galaxy was so far away that its stars looked like dust. In every other direction, the void was so huge that even other galaxies were just tiny specks of light.

Who knew what dangers might be out there?
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
        'What does the word “emptiness” most likely mean in the sentence below?\n\n“He looked out each one and saw the same vast emptiness.”',
    options: [
      "A) A state of being full",
      "B) A state of absence of anything",
      "C) Half empty",
      "D) No empty"
    ],
    correctIndex: 1,
    explanation:
        ' The suffix “-ness” turns an adjective into a noun. “Empty” becomes “emptiness,” meaning the state of being empty or lacking content.',
    incorrectExplanations: [
      ' “Full” is the opposite of “emptiness.”',
      ' Correct answer!',
      ' “Half empty” implies something is still partially full, which is not the meaning here.',
      ' “No empty” is not a proper English phrase and doesn’t explain the sentence.'
    ],
  ),
  QuestionData(
    question:
        'What does the word “attempt” most likely mean in the sentence below?\n\n“His heart was racing, and his attempt to laugh at his nervousness sounded hollow.”',
    options: ["A) Tentación", "B) Atención", "C) Intento", "D) Llamado"],
    correctIndex: 2,
    explanation:
        ' While “attempt” may look like the Spanish word “atento (attentive),” it’s a false cognate. Here, “attempt” means “an effort” — in Spanish, intento.',
    incorrectExplanations: [
      ' “Tentación” means temptation — not effort.',
      ' “Atención” is a false cognate — “attempt” does not mean attention.',
      ' Correct answer!',
      ' “Llamado” means “call” and doesn’t fit the sentence.'
    ],
  ),
  QuestionData(
    question:
        'What does the word “dangers” most likely mean in the sentence below?\n\n“Who knew what dangers might be out there?”',
    options: [
      "A) Threats or risks",
      "B) Fun activities",
      "C) Strange lights",
      "D) Places to visit"
    ],
    correctIndex: 0,
    explanation:
        ' The context clue is the fear and mystery surrounding the void. “Dangers” refers to unknown threats or risks, which is what the character is worrying about.',
    incorrectExplanations: [
      ' Correct answer!',
      ' “Fun activities” doesn’t match the worried tone.',
      ' “Strange lights” is too specific and not supported by context.',
      ' “Places to visit” sounds positive, not fearful.'
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