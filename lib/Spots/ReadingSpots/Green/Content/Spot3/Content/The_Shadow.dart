// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inferwise/Spots/ReadingSpots/Green/Content/Spot3/Spot_Page/Reading_Spot.dart';
import 'dart:math' as math;

class TheShadowSplashScreen extends StatefulWidget {
  const TheShadowSplashScreen({super.key});

  @override
  State<TheShadowSplashScreen> createState() => _TheShadowSplashScreenState();
}

class _TheShadowSplashScreenState extends State<TheShadowSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _bgCtrl;
  late AnimationController _iconCtrl;
  late AnimationController _iconFloatCtrl;
  late AnimationController _glowCtrl;
  late AnimationController _flicker1Ctrl;
  late AnimationController _flicker2Ctrl;
  late AnimationController _flicker3Ctrl;
  late AnimationController _shadowCtrl;
  late AnimationController _orbit1Ctrl;
  late AnimationController _orbit2Ctrl;
  late AnimationController _orbit3Ctrl;
  late AnimationController _starsCtrl;
  late AnimationController _shootCtrl;
  late AnimationController _textCtrl;

  late AnimationController _shadowBaseCtrl;
  late Animation<double> _shadowBaseScale;

  late Animation<double> _bgFade;
  late Animation<double> _iconScale;
  late Animation<double> _iconY;
  late Animation<double> _iconFloatY;
  late Animation<double> _innerGlow;
  late Animation<double> _outerGlow;
  late Animation<double> _candleGlow;

  // Flame layers — scaleY, scaleX, opacity
  late Animation<double> _flame1ScaleY, _flame1ScaleX, _flame1Opacity;
  late Animation<double> _flame2ScaleY, _flame2ScaleX, _flame2Opacity;
  late Animation<double> _flame3ScaleY;

  // Shadow wave
  late Animation<double> _shadowSkew;
  late Animation<double> _shadowScaleX;
  late Animation<double> _shadowOpacity;


  late Animation<double> _titleOpacity, _titleSlide;
  late Animation<double> _authorOpacity;
  late Animation<double> _dividerOpacity, _dividerScale;

  final List<Animation<double>> _starAnim = [];

  // x%, y%, r, dur(s), delay(s), type(0=dot 1=cross)
  static const List<List<double>> _stars = [
    [.07, .03, 1.0, 2.2, .0, 0], [.28, .05, 1.0, 2.9, .3, 0],
    [.52, .02, .75, 2.5, .6, 0],
    [.76, .04, 1.25, 2.0, .9, 0], [.92, .08, .75, 3.1, .2, 0],
    [.14, .12, .75, 2.7, .5, 0],
    [.44, .10, .5, 2.3, 1.0, 0], [.65, .07, 1.0, 3.3, .7, 0],
    [.85, .15, .5, 2.1, .4, 0],
    [.05, .18, 1.0, 2.8, 1.2, 0], [.38, .20, .75, 2.4, .8, 0],
    [.72, .22, .75, 3.0, .3, 0],
    [.95, .25, .5, 1.9, 1.1, 0], [.04, .60, .75, 2.6, .6, 0],
    [.25, .64, 1.0, 2.2, .9, 0],
    [.58, .68, .5, 3.2, .4, 0], [.82, .72, 1.0, 2.0, 1.3, 0],
    [.42, .76, .5, 2.9, .7, 0],
    [.16, .80, .75, 2.5, .2, 0], [.68, .85, .5, 2.7, 1.0, 0],
    [.90, .89, .75, 3.1, .5, 0],
    [.33, .93, .5, 2.3, .8, 0],
    // sparkles
    [.36, .06, 4.0, 2.6, .4, 1], [.91, .18, 3.5, 3.0, .9, 1],
    [.88, .75, 3.5, 2.8, 1.1, 1],
  ];

  static const List<List<double>> _shoots = [
    [.09, .12, 100, 2.0],
    [.28, .06, 65, 7.0],
  ];

  // ring, offsetDeg, radius (in 160×190 space), starR
  static const List<List<double>> _orbitStars = [
    [1, 0, 68, 2.5],
    [1, 90, 68, 2.0],
    [1, 180, 68, 2.5],
    [1, 270, 68, 2.0],
    [2, 0, 78, 2.0],
    [2, 72, 78, 1.5],
    [2, 144, 78, 2.5],
    [2, 216, 78, 1.5],
    [2, 288, 78, 2.0],
    [3, 0, 52, 3.0],
    [3, 120, 52, 2.0],
    [3, 240, 52, 2.5],
  ];



@override
void initState() {
  super.initState();

  // BG fade
  _bgCtrl = AnimationController(
      duration: const Duration(milliseconds: 600), vsync: this);
  _bgFade = CurvedAnimation(parent: _bgCtrl, curve: Curves.easeOut);
  _bgCtrl.forward();

  // Icon entrance
  _iconCtrl = AnimationController(
      duration: const Duration(milliseconds: 1000), vsync: this);
  _iconScale = Tween<double>(begin: .4, end: 1.0)
      .animate(CurvedAnimation(parent: _iconCtrl, curve: Curves.elasticOut));
  _iconY = Tween<double>(begin: 20, end: 0)
      .animate(CurvedAnimation(parent: _iconCtrl, curve: Curves.easeOut));
  Future.delayed(const Duration(milliseconds: 200), () {
    if (mounted) _iconCtrl.forward();
  });

  // Candle float
  _iconFloatCtrl = AnimationController(
      duration: const Duration(milliseconds: 4500), vsync: this)
    ..repeat(reverse: true);
  _iconFloatY = Tween<double>(begin: 0, end: -5).animate(
      CurvedAnimation(parent: _iconFloatCtrl, curve: Curves.easeInOut));

  // Ambient glow
  _glowCtrl = AnimationController(
      duration: const Duration(milliseconds: 2800), vsync: this)
    ..repeat(reverse: true);
  _innerGlow = Tween<double>(begin: .25, end: .48)
      .animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));
  _outerGlow = Tween<double>(begin: .12, end: .22)
      .animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));
  _candleGlow = Tween<double>(begin: .30, end: .55)
      .animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));

  // Flame layer 1 — 1.1s
  _flicker1Ctrl = AnimationController(
      duration: const Duration(milliseconds: 1100), vsync: this)
    ..repeat(reverse: true);
  _flame1ScaleY = Tween<double>(begin: 1.0, end: .88).animate(
      CurvedAnimation(parent: _flicker1Ctrl, curve: Curves.easeInOut));
  _flame1ScaleX = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _flicker1Ctrl, curve: Curves.easeInOut));
  _flame1Opacity = Tween<double>(begin: 1.0, end: .85).animate(
      CurvedAnimation(parent: _flicker1Ctrl, curve: Curves.easeInOut));

  // Flame layer 2 — 1.4s
  _flicker2Ctrl = AnimationController(
      duration: const Duration(milliseconds: 1400), vsync: this)
    ..repeat(reverse: true);
  _flame2ScaleY = Tween<double>(begin: 1.0, end: 1.10).animate(
      CurvedAnimation(parent: _flicker2Ctrl, curve: Curves.easeInOut));
  _flame2ScaleX = Tween<double>(begin: 1.0, end: .92).animate(
      CurvedAnimation(parent: _flicker2Ctrl, curve: Curves.easeInOut));
  _flame2Opacity = Tween<double>(begin: .85, end: .75).animate(
      CurvedAnimation(parent: _flicker2Ctrl, curve: Curves.easeInOut));

  // Flame layer 3 — 0.9s
  _flicker3Ctrl = AnimationController(
      duration: const Duration(milliseconds: 900), vsync: this)
    ..repeat(reverse: true);
  _flame3ScaleY = Tween<double>(begin: 1.0, end: .85).animate(
      CurvedAnimation(parent: _flicker3Ctrl, curve: Curves.easeInOut));

  // Shadow wave — 2.2s
  _shadowCtrl = AnimationController(
      duration: const Duration(milliseconds: 2200), vsync: this)
    ..repeat(reverse: true);
  _shadowSkew = Tween<double>(begin: 0, end: 4 * math.pi / 180)
      .animate(CurvedAnimation(parent: _shadowCtrl, curve: Curves.easeInOut));
  _shadowScaleX = Tween<double>(begin: 1.0, end: 1.06)
      .animate(CurvedAnimation(parent: _shadowCtrl, curve: Curves.easeInOut));
  _shadowOpacity = Tween<double>(begin: .75, end: .88)
      .animate(CurvedAnimation(parent: _shadowCtrl, curve: Curves.easeInOut));

  // ✅ CORREGIDO: controller con nombre, se puede disponer
  _shadowBaseCtrl = AnimationController(
      duration: const Duration(milliseconds: 3000), vsync: this)
    ..repeat(reverse: true);
  _shadowBaseScale = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _shadowBaseCtrl, curve: Curves.easeInOut));

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

  // Text entrance
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
  Future.delayed(const Duration(milliseconds: 700), () {
    if (mounted) _textCtrl.forward();
  });

  // Navigate
  Future.delayed(const Duration(seconds: 4), () {
    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const TheShadow()));
  });
}

@override
void dispose() {
  _bgCtrl.dispose();
  _iconCtrl.dispose();
  _iconFloatCtrl.dispose();
  _glowCtrl.dispose();
  _flicker1Ctrl.dispose();
  _flicker2Ctrl.dispose();
  _flicker3Ctrl.dispose();
  _shadowCtrl.dispose();
  _shadowBaseCtrl.dispose();  // ✅ ahora sí se dispone correctamente
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
              center: Alignment(-.3, -.3),
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
            // Milky Way band
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
            _ShadowNebula(
                color: const Color(0xFF0A1964),
                alignment: const Alignment(-1.0, -.85),
                size: 400),
            _ShadowNebula(
                color: const Color(0xFF052882),
                alignment: const Alignment(1.0, .80),
                size: 300,
                delay: 2000),
            _ShadowNebula(
                color: const Color(0xFF140A78),
                alignment: const Alignment(.80, .20),
                size: 220,
                delay: 4000),

            // Star field + shooting stars
            AnimatedBuilder(
              animation: Listenable.merge([_starsCtrl, _shootCtrl]),
              builder: (_, __) => CustomPaint(
                painter: _ShadowStarPainter(
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
            _ShadowParticle(
                xF: .18, yF: .20, sz: 5, shape: 0, durMs: 3400, delayMs: 0),
            _ShadowParticle(
                xF: .84, yF: .22, sz: 4, shape: 1, durMs: 2900, delayMs: 500),
            _ShadowParticle(
                xF: .11, yF: .43, sz: 3, shape: 0, durMs: 4000, delayMs: 900),
            _ShadowParticle(
                xF: .87, yF: .41, sz: 4, shape: 1, durMs: 3100, delayMs: 300),
            _ShadowParticle(
                xF: .22, yF: .27, sz: 5, shape: 2, durMs: 3600, delayMs: 700),
            _ShadowParticle(
                xF: .80, yF: .38, sz: 4, shape: 3, durMs: 2800, delayMs: 1100),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Candle icon
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _iconCtrl,
                      _iconFloatCtrl,
                      _glowCtrl,
                      _flicker1Ctrl,
                      _flicker2Ctrl,
                      _flicker3Ctrl,
                      _shadowCtrl,
                      _orbit1Ctrl,
                      _orbit2Ctrl,
                      _orbit3Ctrl,
                    ]),
                    builder: (_, __) {
                      final floatY = _iconCtrl.isCompleted
                          ? _iconFloatY.value
                          : _iconY.value;
                      return Transform.translate(
                        offset: Offset(0, floatY),
                        child: Transform.scale(
                          scale: _iconScale.value,
                          child: SizedBox(
                            width: 200,
                            height: 220,
                            child: CustomPaint(
                              painter: _CandlePainter(
                                innerGlow: _innerGlow.value,
                                outerGlow: _outerGlow.value,
                                candleGlow: _candleGlow.value,
                                flame1ScaleY: _flame1ScaleY.value,
                                flame1ScaleX: _flame1ScaleX.value,
                                flame1Opacity: _flame1Opacity.value,
                                flame2ScaleY: _flame2ScaleY.value,
                                flame2ScaleX: _flame2ScaleX.value,
                                flame2Opacity: _flame2Opacity.value,
                                flame3ScaleY: _flame3ScaleY.value,
                                shadowSkew: _shadowSkew.value,
                                shadowScaleX: _shadowScaleX.value,
                                shadowOpacity: _shadowOpacity.value,
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
                                    color: const Color(0xFF3C6EC8)
                                        .withOpacity(.40))),
                            const SizedBox(width: 8),
                            const Icon(Icons.star_rounded,
                                color: Color(0xFF5082DC), size: 14),
                            const SizedBox(width: 8),
                            Expanded(
                                child: Container(
                                    height: 1,
                                    color: const Color(0xFF3C6EC8)
                                        .withOpacity(.40))),
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
                          'The Shadow',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFC8D8F8),
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
                        'By Edith Nesbit, 1905',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: const Color(0xFF6496DC).withOpacity(.65),
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
                        'From Oldstyle Tales Press',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: const Color(0xFF6496DC).withOpacity(.65),
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

// ─── Candle + Orbiting Stars CustomPainter ────────────────────────────
class _CandlePainter extends CustomPainter {
  final double innerGlow, outerGlow, candleGlow;
  final double flame1ScaleY, flame1ScaleX, flame1Opacity;
  final double flame2ScaleY, flame2ScaleX, flame2Opacity;
  final double flame3ScaleY;
  final double shadowSkew, shadowScaleX, shadowOpacity;
  final double orbit1T, orbit2T, orbit3T;
  final List<List<double>> orbitStars;

  const _CandlePainter({
    required this.innerGlow,
    required this.outerGlow,
    required this.candleGlow,
    required this.flame1ScaleY,
    required this.flame1ScaleX,
    required this.flame1Opacity,
    required this.flame2ScaleY,
    required this.flame2ScaleX,
    required this.flame2Opacity,
    required this.flame3ScaleY,
    required this.shadowSkew,
    required this.shadowScaleX,
    required this.shadowOpacity,
    required this.orbit1T,
    required this.orbit2T,
    required this.orbit3T,
    required this.orbitStars,
  });

  // Map from 160×190 viewBox to canvas size
  Offset p(Size s, double x, double y) =>
      Offset(x / 160 * s.width, y / 190 * s.height);
  double sc(Size s, double v) => v / 160 * s.width;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2; // 100 in 200px canvas
    final cy = size.height / 2; // 110 in 220px canvas
    final scl = size.width / 160;

    // ── AMBIENT GLOWS ─────────────────────────────────────────────
    canvas.drawCircle(
        Offset(cx, cy),
        75 * scl,
        Paint()
          ..shader = RadialGradient(colors: [
            const Color(0xFF3060DD).withOpacity(outerGlow),
            const Color(0xFF3060DD).withOpacity(0),
          ]).createShader(
              Rect.fromCircle(center: Offset(cx, cy), radius: 75 * scl)));

    canvas.drawCircle(
        Offset(cx, cy),
        55 * scl,
        Paint()
          ..shader = RadialGradient(colors: [
            const Color(0xFF2050CC).withOpacity(innerGlow),
            const Color(0xFF0820AA).withOpacity(innerGlow * .2),
            const Color(0xFF0820AA).withOpacity(0),
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

      canvas.drawCircle(
        Offset(cx + rawX, cy + rawY),
        starR * pop,
        Paint()..color = const Color(0xFF8CBCE0).withOpacity(.78 * pop),
      );

      if ((ring == 1 || ring == 2) && offsetDeg == 0) {
        final arm = starR * 1.8 * pop;
        final sp = Paint()
          ..color = const Color(0xFFB4C8F0)
              .withOpacity(ring == 1 ? .78 * pop : .68 * pop)
          ..strokeWidth = 1.0
          ..strokeCap = StrokeCap.round;
        final sx = cx + rawX;
        final sy = cy + rawY;
        canvas.drawLine(Offset(sx - arm, sy), Offset(sx + arm, sy), sp);
        canvas.drawLine(Offset(sx, sy - arm), Offset(sx, sy + arm), sp);
      }
    }

    // ── SHADOW cast on floor ──────────────────────────────────────
    // Base of candle in canvas coords
    final candleBase = p(size, 80, 185).dy;
    final candleCx = p(size, 80, 0).dx;

    // Main shadow triangle
    canvas.save();
    canvas.translate(candleCx, candleBase);
    canvas.transform(Matrix4(
      shadowScaleX,
      0,
      0,
      0,
      math.tan(shadowSkew),
      1,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      1,
    ).storage);
    final shadowPath1 = Path()
      ..moveTo(0, 0)
      ..lineTo(-sc(size, 28), sc(size, 85))
      ..lineTo(sc(size, 28), sc(size, 85))
      ..close();
    canvas.drawPath(
        shadowPath1,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF000412).withOpacity(shadowOpacity),
              const Color(0xFF000412).withOpacity(shadowOpacity * .6),
              const Color(0xFF000412).withOpacity(0),
            ],
          ).createShader(
              Rect.fromLTWH(-sc(size, 28), 0, sc(size, 56), sc(size, 85))));
    canvas.restore();

    // Wider softer shadow
    canvas.save();
    canvas.translate(candleCx, p(size, 80, 112).dy);
    final shadowPath2 = Path()
      ..moveTo(0, 0)
      ..lineTo(-sc(size, 50), sc(size, 73))
      ..lineTo(sc(size, 50), sc(size, 73))
      ..close();
    canvas.drawPath(
        shadowPath2,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF000412).withOpacity(shadowOpacity * .65),
              const Color(0xFF000412).withOpacity(0),
            ],
          ).createShader(
              Rect.fromLTWH(-sc(size, 50), 0, sc(size, 100), sc(size, 73))));
    canvas.restore();

    // Ground glow
    canvas.drawOval(
      Rect.fromCenter(
          center: p(size, 80, 185), width: sc(size, 76), height: sc(size, 12)),
      Paint()..color = const Color(0xFF2850C8).withOpacity(.25 * candleGlow),
    );

    // ── CANDLE BODY ───────────────────────────────────────────────
    // Wax drips
    _drawWaxDrip(canvas, size, 71, 130, 70, 148, 73, 130);
    _drawWaxDrip(canvas, size, 73, 125, 71, 139, 74, 125);
    _drawWaxDripRight(canvas, size, 89, 132, 90, 150, 87, 132);

    // Candle cylinder
    final candleRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        p(size, 67, 110).dx,
        p(size, 67, 110).dy,
        sc(size, 26),
        sc(size, 75),
      ),
      Radius.circular(sc(size, 4)),
    );
    canvas.drawRRect(
      candleRect,
      Paint()
        ..shader = LinearGradient(
          colors: const [
            Color(0xFF0A1848),
            Color(0xFF2848A8),
            Color(0xFF3A5CC8),
            Color(0xFF1E3898),
            Color(0xFF0A1848),
          ],
          stops: const [0.0, .25, .55, .80, 1.0],
        ).createShader(Rect.fromLTWH(
          p(size, 67, 110).dx,
          p(size, 67, 110).dy,
          sc(size, 26),
          sc(size, 75),
        )),
    );

    // Top ellipse
    canvas.drawOval(
      Rect.fromCenter(
          center: p(size, 80, 110), width: sc(size, 26), height: sc(size, 8)),
      Paint()..color = const Color(0xFF3A5CC8),
    );
    canvas.drawOval(
      Rect.fromCenter(
          center: p(size, 80, 110), width: sc(size, 26), height: sc(size, 8)),
      Paint()
        ..color = const Color(0xFF5082DC).withOpacity(.45)
        ..style = PaintingStyle.stroke
        ..strokeWidth = sc(size, 1.0),
    );

    // Highlight stripe
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(p(size, 70, 115).dx, p(size, 70, 115).dy, sc(size, 4),
            sc(size, 65)),
        Radius.circular(sc(size, 2)),
      ),
      Paint()..color = const Color(0xFF5078C8).withOpacity(.28),
    );

    // Bottom ellipse
    canvas.drawOval(
      Rect.fromCenter(
          center: p(size, 80, 185), width: sc(size, 26), height: sc(size, 8)),
      Paint()..color = const Color(0xFF0A1848).withOpacity(.70),
    );

    // ── WICK ──────────────────────────────────────────────────────
    canvas.drawLine(
      p(size, 80, 110),
      p(size, 80, 98),
      Paint()
        ..color = const Color(0xFF1A2870)
        ..strokeWidth = sc(size, 1.5)
        ..strokeCap = StrokeCap.round,
    );
    final wickPath = Path()
      ..moveTo(p(size, 80, 98).dx, p(size, 80, 98).dy)
      ..quadraticBezierTo(p(size, 82, 95).dx, p(size, 82, 95).dy,
          p(size, 81, 92).dx, p(size, 81, 92).dy);
    canvas.drawPath(
        wickPath,
        Paint()
          ..color = const Color(0xFF1A2870)
          ..strokeWidth = sc(size, 1.2)
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);

    // ── CANDLE GLOW around flame ──────────────────────────────────
    canvas.drawOval(
      Rect.fromCenter(
          center: p(size, 81, 88), width: sc(size, 44), height: sc(size, 48)),
      Paint()
        ..shader = RadialGradient(colors: [
          const Color(0xFF4878FF).withOpacity(candleGlow),
          const Color(0xFF2050CC).withOpacity(candleGlow * .3),
          const Color(0xFF2050CC).withOpacity(0),
        ]).createShader(Rect.fromCenter(
            center: p(size, 81, 88),
            width: sc(size, 44),
            height: sc(size, 48))),
    );

    // ── FLAME LAYER 2 (outer, behind) ─────────────────────────────
    canvas.save();
    canvas.translate(p(size, 81, 92).dx, p(size, 81, 92).dy);
    canvas.scale(flame2ScaleX, flame2ScaleY);
    final flameOuter = Path()
      ..moveTo(0, 0)
      ..cubicTo(
        -sc(size, 7),
        -sc(size, 7),
        -sc(size, 9),
        -sc(size, 20),
        -sc(size, 5),
        -sc(size, 30),
      )
      ..cubicTo(
        -sc(size, 3),
        -sc(size, 36),
        0,
        -sc(size, 40),
        0,
        -sc(size, 40),
      )
      ..cubicTo(
        0,
        -sc(size, 40),
        sc(size, 3),
        -sc(size, 36),
        sc(size, 5),
        -sc(size, 30),
      )
      ..cubicTo(
        sc(size, 9),
        -sc(size, 20),
        sc(size, 7),
        -sc(size, 7),
        0,
        0,
      )
      ..close();
    canvas.drawPath(
        flameOuter,
        Paint()
          ..shader = RadialGradient(
            center: const Alignment(0, .6),
            radius: .6,
            colors: [
              const Color(0xFF6090FF).withOpacity(flame2Opacity * .9),
              const Color(0xFF2848C8).withOpacity(flame2Opacity * .5),
              const Color(0xFF1030A0).withOpacity(0),
            ],
          ).createShader(Rect.fromCenter(
              center: Offset(0, -sc(size, 20)),
              width: sc(size, 18),
              height: sc(size, 40))));
    canvas.restore();

    // ── FLAME LAYER 1 (mid) ───────────────────────────────────────
    canvas.save();
    canvas.translate(p(size, 81, 88).dx, p(size, 81, 88).dy);
    canvas.scale(flame1ScaleX, flame1ScaleY);
    final flameMid = Path()
      ..moveTo(0, 0)
      ..cubicTo(
        -sc(size, 5),
        -sc(size, 6),
        -sc(size, 7),
        -sc(size, 16),
        -sc(size, 3),
        -sc(size, 24),
      )
      ..cubicTo(
        -sc(size, 1),
        -sc(size, 28),
        0,
        -sc(size, 32),
        0,
        -sc(size, 32),
      )
      ..cubicTo(
        0,
        -sc(size, 32),
        sc(size, 1),
        -sc(size, 28),
        sc(size, 3),
        -sc(size, 24),
      )
      ..cubicTo(
        sc(size, 7),
        -sc(size, 16),
        sc(size, 5),
        -sc(size, 6),
        0,
        0,
      )
      ..close();
    canvas.drawPath(
        flameMid,
        Paint()
          ..shader = RadialGradient(
            center: const Alignment(0, .5),
            radius: .65,
            colors: const [
              Color(0xFFE8F0FF),
              Color(0xFFA0C0FF),
              Color(0xFF4878E8),
              Color(0x001030C0),
            ],
            stops: const [0.0, .30, .70, 1.0],
          ).createShader(Rect.fromCenter(
              center: Offset(0, -sc(size, 16)),
              width: sc(size, 14),
              height: sc(size, 32))));
    canvas.restore();

    // ── FLAME LAYER 3 (inner bright) ─────────────────────────────
    canvas.save();
    canvas.translate(p(size, 81, 84).dx, p(size, 81, 84).dy);
    canvas.scale(1.0, flame3ScaleY);
    final flameInner = Path()
      ..moveTo(0, 0)
      ..cubicTo(
        -sc(size, 2),
        -sc(size, 4),
        -sc(size, 2.5),
        -sc(size, 11),
        -sc(size, 1),
        -sc(size, 15),
      )
      ..cubicTo(
        -sc(size, .5),
        -sc(size, 17),
        0,
        -sc(size, 19),
        0,
        -sc(size, 19),
      )
      ..cubicTo(
        0,
        -sc(size, 19),
        sc(size, .5),
        -sc(size, 17),
        sc(size, 1),
        -sc(size, 15),
      )
      ..cubicTo(
        sc(size, 2.5),
        -sc(size, 11),
        sc(size, 2),
        -sc(size, 4),
        0,
        0,
      )
      ..close();
    canvas.drawPath(
        flameInner, Paint()..color = const Color(0xFFDCEBFF).withOpacity(.90));
    canvas.restore();

    // Flame tip shine
    canvas.drawOval(
      Rect.fromCenter(
          center: p(size, 80, 67), width: sc(size, 3), height: sc(size, 5)),
      Paint()..color = const Color(0xFFF0F8FF).withOpacity(.80 * flame1Opacity),
    );
  }

  void _drawWaxDrip(Canvas canvas, Size size, double x1, double y1, double x2,
      double y2, double x3, double y3) {
    final path = Path()
      ..moveTo(p(size, x1, y1).dx, p(size, x1, y1).dy)
      ..quadraticBezierTo(p(size, x2, (y1 + y2) / 2).dx,
          p(size, x2, (y1 + y2) / 2).dy, p(size, x2, y2).dx, p(size, x2, y2).dy)
      ..quadraticBezierTo(p(size, x3, (y1 + y2) / 2).dx,
          p(size, x3, (y1 + y2) / 2).dy, p(size, x3, y3).dx, p(size, x3, y3).dy)
      ..close();
    canvas.drawPath(
        path, Paint()..color = const Color(0xFF1E3898).withOpacity(.80));
  }

  void _drawWaxDripRight(Canvas canvas, Size size, double x1, double y1,
      double x2, double y2, double x3, double y3) {
    final path = Path()
      ..moveTo(p(size, x1, y1).dx, p(size, x1, y1).dy)
      ..quadraticBezierTo(p(size, x2, (y1 + y2) / 2).dx,
          p(size, x2, (y1 + y2) / 2).dy, p(size, x2, y2).dx, p(size, x2, y2).dy)
      ..quadraticBezierTo(p(size, x3, (y1 + y2) / 2).dx,
          p(size, x3, (y1 + y2) / 2).dy, p(size, x3, y3).dx, p(size, x3, y3).dy)
      ..close();
    canvas.drawPath(
        path, Paint()..color = const Color(0xFF1E3898).withOpacity(.80));
  }

  @override
  bool shouldRepaint(covariant _CandlePainter o) =>
      o.innerGlow != innerGlow ||
      o.outerGlow != outerGlow ||
      o.candleGlow != candleGlow ||
      o.flame1ScaleY != flame1ScaleY ||
      o.flame2ScaleY != flame2ScaleY ||
      o.flame3ScaleY != flame3ScaleY ||
      o.shadowSkew != shadowSkew ||
      o.shadowOpacity != shadowOpacity ||
      o.orbit1T != orbit1T ||
      o.orbit2T != orbit2T ||
      o.orbit3T != orbit3T;
}

// ─── Nebula ───────────────────────────────────────────────────────────
class _ShadowNebula extends StatefulWidget {
  final Color color;
  final Alignment alignment;
  final double size;
  final int delay;
  const _ShadowNebula(
      {required this.color,
      required this.alignment,
      required this.size,
      this.delay = 0});
  @override
  State<_ShadowNebula> createState() => _ShadowNebulaState();
}

class _ShadowNebulaState extends State<_ShadowNebula>
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
class _ShadowParticle extends StatefulWidget {
  final double xF, yF, sz;
  final int shape, durMs, delayMs;
  const _ShadowParticle(
      {required this.xF,
      required this.yF,
      required this.sz,
      required this.shape,
      required this.durMs,
      required this.delayMs});
  @override
  State<_ShadowParticle> createState() => _ShadowParticleState();
}

class _ShadowParticleState extends State<_ShadowParticle>
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
class _ShadowStarPainter extends CustomPainter {
  final List<List<double>> stars;
  final List<double> starOpacities;
  final double shootT;
  final List<List<double>> shoots;
  final Size canvasSize;

  const _ShadowStarPainter({
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
          ..color = const Color(0xFF5082DC).withOpacity(op)
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
            const Color(0xFF78AAE8).withOpacity(op * .90),
            const Color(0xFF5082DC).withOpacity(op * .35),
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
  bool shouldRepaint(covariant _ShadowStarPainter o) =>
      o.shootT != shootT || o.starOpacities != starOpacities;
}

class TheShadow extends StatefulWidget {
  const TheShadow({super.key});

  @override
  State<TheShadow> createState() => _TheShadowState();
}

class _TheShadowState extends State<TheShadow> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "How is a shadow created?",
      "options": [
        "A) By reflecting light",
        "B) By emitting light",
        "C) By absorbing light",
        "D) By blocking light"
      ],
      "correct": 3,
      "feedback": [
        " Incorrect. Reflected light does not create shadows.",
        " Incorrect. Emitting light generates illumination, not shadows.",
        " Incorrect. Absorbing light may darken an object but does not create a shadow.",
        " Correct! A shadow is created when an object blocks light."
      ]
    },
    {
      "question": "What factors determine the size and shape of a shadow?",
      "options": [
        "A) The color of the object",
        "B) The speed of the object",
        "C) The temperature of the object",
        "D) The distance and angle of the light source"
      ],
      "correct": 3,
      "feedback": [
        " Incorrect. The color of the object doesn’t affect the shadow's size or shape.",
        " Incorrect. The speed of the object isn’t a factor in shadow formation.",
        " Incorrect. Temperature is not related to the shape of a shadow.",
        " Correct! Shadow size and shape are affected by the light source’s distance and angle."
      ]
    },
    {
      "question": "Can shadows change color?",
      "options": [
        "A) Yes, they can be any color",
        "B) No, they are always black",
        "C) It depends on the light source",
        "D) Only if the object is colorful"
      ],
      "correct": 2,
      "feedback": [
        " Incorrect. Shadows don’t have arbitrary colors; lighting matters.",
        " Incorrect. Shadows can vary in color depending on surroundings.",
        " Correct! Shadows can change color depending on the light source.",
        " Incorrect. The object’s color alone doesn’t determine the shadow’s color."
      ]
    },
    {
      "question": "What is the only object without a shadow?",
      "options": [
        "A) A solid object",
        "B) A transparent object",
        "C) A reflective object",
        "D) A colored object"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Solid objects cast shadows.",
        " Correct! Transparent objects like clean glass or water don’t cast shadows.",
        " Incorrect. Reflective objects still block light and cast shadows.",
        " Incorrect. Color does not prevent shadows."
      ]
    },
    {
      "question":
          "Why do shadows sometimes appear or cross our field of vision when we are staring at something?",
      "options": [
        "A) Because shadows are always moving",
        "B) Because of changes in the light source and our brain's perception",
        "C) Because shadows are invisible",
        "D) Because shadows are only behind us"
      ],
      "correct": 1,
      "feedback": [
        " Incorrect. Not all shadows move, and motion alone doesn’t explain this.",
        " Correct! Changes in light and brain perception make shadows appear to move.",
        " Incorrect. Shadows are visible under most conditions.",
        " Incorrect. Shadows can appear in any direction based on the light source."
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
          MaterialPageRoute(builder: (_) => const BlueCardDeckAnimation(title: "The Shadow",nextPage: BiographyReadingPage(),)),
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
This is not a neatly crafted ghost story, and nothing in it is explained. There seems to be no reason why any of it happened. But that doesn’t mean it shouldn’t be told. You’ve probably noticed that all real ghost stories are like this—no explanation, no clear logic. Here is the story.

There were three of us and another girl, but she had fainted suddenly during the second dance at the Christmas party and had been put to bed in the dressing room next to the room we three shared. It had been one of those lively, old-fashioned dances where almost everyone stays the night, and the big country house was packed with guests sleeping on sofas, couches, benches, and even mattresses on the floor. Some of the young men, I believe, even slept on the large dining table.

We had talked about our dance partners, as girls do, and then the quiet of the manor house, broken only by the wind whispering in the cedar branches and the sound of their rough fingers scraping against our windows, made us feel so safe and cozy in our bright, cheerful room with its candles and firelight that we dared to talk about ghosts—though we all said we didn’t believe in them at all. We told stories about phantom coaches, strange haunted beds, a lady in an old-fashioned dress, and the house in Berkeley Square.


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
        '“There were three of us and another girl, but she had fainted suddenly during the second dance at the Christmas party.”\n\nWho does “she” refer to?',
    options: [
      "A) One of the young men",
      "B) The fainted girl",
      "C) The narrator",
      "D) A ghost"
    ],
    correctIndex: 1,
    explanation:
        '“She” refers to the fourth girl, distinct from the three girls sharing the room, who fainted during the dance and was placed in the adjacent dressing room.',
    incorrectExplanations: [
      ' The young men are not mentioned as fainting.',
      ' Correct answer!',
      ' The narrator is one of the three, not the fainted girl.',
      ' A ghost is not part of the scene.',
    ],
  ),
  QuestionData(
    question:
        '“The quiet of the manor house, broken only by the wind whispering in the cedar branches and the sound of their rough fingers scraping against our windows …”\n\nWhat does “their” refer to?',
    options: [
      "A) The wind",
      "B) The cedar branches",
      "C) The manor house",
      "D) The windows"
    ],
    correctIndex: 1,
    explanation:
        '“Their” refers to the cedar branches, whose movement in the wind produces the scraping sound against the windows.',
    incorrectExplanations: [
      ' The wind causes the movement but does not have fingers.',
      ' Correct answer!',
      ' The manor house is the setting, not the source of the sound.',
      ' The windows receive the sound but do not produce it.',
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
None of us believed in ghosts, but my heart leaped to my throat when a faint tap came at our door—a tap so soft but unmistakable.

“Who’s there?” said the youngest of us, leaning her thin neck toward the door. It opened slowly, and I swear the moment of suspense that followed is still one of the most unsettling moments of my life. Almost at once, the door opened fully, and Miss Eastwich, my aunt’s housekeeper, companion, and general helper, looked in at us.

We all said, “Come in,” but she stood there. She was, at normal times, the quietest woman I had ever known. She stood and looked at us, shivering a little. So did we—because in those days, hallways weren’t heated, and the air from the door was cold.

“I saw your light,” she said at last, “and I thought it was late for you to be up after all the excitement. I thought perhaps—” Her glance turned toward the dressing room door.
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
        '"And Miss Eastwich, my aunt\'s housekeeper, companion, and general helper, looked in at us."\n\nWho does "us" refer to?',
    options: [
      "A) Miss Eastwich and the aunt",
      "B) The ghosts in the house",
      "C) The young men at the party",
      "D) The group of girls in the room"
    ],
    correctIndex: 3,
    explanation:
        '"Us" refers to the girls in the room, the group being addressed by Miss Eastwich when she looks in at them.',
    incorrectExplanations: [
      " Miss Eastwich is the person looking in, not part of the group referred to as 'us'.",
      " There is no indication that ghosts are being addressed in this scene.",
      " The young men at the party are not present in the room at this moment.",
      " Correct answer!",
    ],
  ),
  QuestionData(
    question:
        '"Her glance turned toward the dressing room door."\n\nWho does "her" refer to?',
    options: [
      "A) The youngest girl",
      "B) The aunt",
      "C) Miss Eastwich",
      "D) A ghost"
    ],
    correctIndex: 2,
    explanation:
        '"Her" refers to Miss Eastwich, whose glance turns toward the dressing room door as she speaks to the girls.',
    incorrectExplanations: [
      " The youngest girl is not described as directing her glance in this sentence.",
      " The aunt is not mentioned as performing this action.",
      " Correct answer!",
      " There is no reference to a ghost performing this action.",
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
“No,” I said, “she’s fast asleep.” I should have added a goodnight, but the youngest of us spoke first. She didn’t know Miss Eastwich as we did; she didn’t know how her constant silence had built a wall around her—a wall no one dared to break with small talk or casual friendliness. Miss Eastwich’s silence had taught us to treat her like a machine, and we never thought of her as anything else. But the youngest of us had only met Miss Eastwich that day. She was young, impulsive, and prone to sudden, thoughtless actions. She was also the heiress of a wealthy candle-maker, but that has nothing to do with this part of the story. She jumped up from the rug by the fire, her expensive silk dressing gown slipping off her thin shoulders, and ran to the door, putting an arm around Miss Eastwich’s stiff, lace-covered neck. I gasped. I would have sooner dared to hug a stone monument. “Come in,” said the youngest of us, “come in and get warm. There’s lots of cocoa left.” She pulled Miss Eastwich in and shut the door.

The look of pure joy in the housekeeper’s pale eyes struck me like a knife. It would have been so easy to put an arm around her neck, if only we had thought she wanted one. But it wasn’t me who had thought of it—and perhaps my arm wouldn’t have brought the same light to her eyes as the thin arm of the youngest of us.

“Now,” the youngest said eagerly, “you shall have the biggest, nicest chair, and the cocoa pot’s here on the hearth, still hot—and we’ve all been telling ghost stories, though we don’t believe in them at all. When you’re warm, you ought to tell one too.”

Miss Eastwich—the model of proper behavior and duty—tell a ghost story!

“You’re sure I’m not in your way,” Miss Eastwich said, holding her hands to the fire. I wondered if housekeepers even had fires in their rooms at Christmas.

“Not at all,” I said, and I hope I said it as warmly as I felt. “I—Miss Eastwich—I’d have asked you to come in other times, but I didn’t think you’d care for girls’ chatter.”
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
        '"Come in," said the youngest of us, "come in and get warm. There\'s lots of cocoa left." She pulled Miss Eastwich in and shut the door.\n\nWho does "she" refer to?',
    options: [
      "A) The narrator",
      "B) Miss Eastwich",
      "C) The youngest of the girls",
      "D) The aunt"
    ],
    correctIndex: 2,
    explanation:
        '"She" refers to the youngest of the girls, who invites Miss Eastwich inside and pulls her into the room.',
    incorrectExplanations: [
      " The narrator is not described as performing this action.",
      " Miss Eastwich is the person being pulled in, not the one acting.",
      " Correct answer!",
      " The aunt is not present in this moment.",
    ],
  ),
  QuestionData(
    question:
        '"—Miss Eastwich—I\'d have asked you to come in other times, but I didn\'t think you\'d care for girls\' chatter."\n\nWho does "I" refer to?',
    options: [
      "A) The narrator",
      "B) Miss Eastwich",
      "C) The youngest of the girls",
      "D) The aunt"
    ],
    correctIndex: 0,
    explanation:
        '"I" refers to the narrator, who is speaking directly to Miss Eastwich and explaining why she had not invited her in before.',
    incorrectExplanations: [
      " Correct answer!",
      " Miss Eastwich is being spoken to, not speaking.",
      " The youngest girl invited Miss Eastwich in, but is not the speaker here.",
      " The aunt is not the one addressing Miss Eastwich in this dialogue.",
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

The third girl, who was really unimportant and that’s why I haven’t mentioned her before, poured cocoa for our guest. I put my soft shawl around Miss Eastwich’s shoulders. I couldn’t think of anything else to do for her, and I desperately wanted to do something. The smiles she gave us were quite lovely. People can smile beautifully even at forty or fifty, or older, though girls don’t realize this. It struck me, like another knife to the heart, that I had never seen Miss Eastwich smile—a real smile—before. Her usual polite smiles were nothing like this warm, happy, transforming look.

“This is very pleasant,” she said, and it seemed to me that I had never before heard her real voice. It pained me to think that at the cost of cocoa, a fire, and an arm around her neck, I might have heard this new voice any time in the past six years.

“We’ve been telling ghost stories,” I said. “The worst of it is, we don’t believe in ghosts. No one we know has ever seen one.”

“It’s always what somebody told somebody, who told somebody you know,” said the youngest of us, “and you can’t believe that, can you?”

“What the soldier said is not evidence,” said Miss Eastwich. Would you believe that the little quote from Dickens cut deeper than her new smile or her new voice?

“And all the ghost stories are so neatly wrapped up—a murder committed on the spot, or hidden treasure, or a warning—I think that makes them harder to believe. The scariest ghost story I ever heard was one that was quite silly.”

“Tell it.”

“I can’t—it doesn’t sound like much to tell. Miss Eastwich ought to tell one.”

“Oh, do,” said the youngest of us, her eyes wide with excitement as she leaned forward and put a pleading hand on our guest’s knee.

“The only thing I ever knew of was—was hearsay,” she said slowly, “until the very end.”

I knew she would tell her story, and I knew she had never told it before, and I knew she was only telling it now because she was proud and felt she owed us something for the fire, the cocoa, and the arm around her neck.

“Don’t tell it,” I said suddenly. “I know you would rather not.”
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
        '"The youngest of us had only met Miss Eastwich that day. She was young, impulsive, and prone to sudden, thoughtless actions."\n\nWho does "she" refer to?',
    options: [
      "A) The narrator",
      "B) Miss Eastwich",
      "C) The third girl",
      "D) The youngest of the girls"
    ],
    correctIndex: 3,
    explanation:
        '"She" refers to the youngest of the girls, who is described as young, impulsive, and prone to sudden, thoughtless actions.',
    incorrectExplanations: [
      " The narrator is not being described in this sentence.",
      " Miss Eastwich is mentioned, but the description applies to the youngest girl.",
      " The third girl is not discussed in this part.",
      " Correct answer!",
    ],
  ),
  QuestionData(
    question:
        '"I knew she would tell her story, and I knew she had never told it before."\n\nWho does "she" refer to?',
    options: [
      "A) The youngest of the girls",
      "B) Miss Eastwich",
      "C) The third girl",
      "D) The narrator"
    ],
    correctIndex: 1,
    explanation:
        '"She" refers to Miss Eastwich, who is about to tell her story and has never shared it before.',
    incorrectExplanations: [
      " The youngest girl is not the one expected to tell the story.",
      " Correct answer!",
      " The third girl is not mentioned as telling a story.",
      " The narrator is speaking, not being referred to.",
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