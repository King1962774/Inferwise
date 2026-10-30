import 'package:flutter/material.dart';
import 'package:inferwise/Spots/ReadingSpots/Purple/Content/Spot1/Spot_Page/reading_spot_page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:math' as math;

// ── Reemplaza con tu import real ──────────────────────────────────
// import 'biography_giuseppina.dart';
// ─────────────────────────────────────────────────────────────────

class GiuseppinaSplashScreen extends StatefulWidget {
  const GiuseppinaSplashScreen({super.key});

  @override
  State<GiuseppinaSplashScreen> createState() => _GiuseppinaSplashScreenState();
}

class _GiuseppinaSplashScreenState extends State<GiuseppinaSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _particlesController;
  late AnimationController _glowController;
  late Animation<double> _fadeIn;
  late Animation<double> _scaleUp;
  late Animation<double> _glowOpacity;

  // 6 partículas / bacterias con distintas trayectorias
  static const List<_ParticleData> _particles = [
    _ParticleData(
        x: 0.08,
        y: 0.08,
        w: 10,
        h: 6,
        dur: 2800,
        delay: 0,
        dx: -4,
        dy: -5,
        shape: _ParticleShape.circle),
    _ParticleData(
        x: 0.82,
        y: 0.12,
        w: 7,
        h: 7,
        dur: 3200,
        delay: 400,
        dx: 5,
        dy: -4,
        shape: _ParticleShape.square),
    _ParticleData(
        x: 0.06,
        y: 0.62,
        w: 9,
        h: 5,
        dur: 2500,
        delay: 800,
        dx: -3,
        dy: 4,
        shape: _ParticleShape.triangle),
    _ParticleData(
        x: 0.84,
        y: 0.65,
        w: 6,
        h: 9,
        dur: 3500,
        delay: 200,
        dx: 4,
        dy: 3,
        shape: _ParticleShape.circle),
    _ParticleData(
        x: 0.04,
        y: 0.40,
        w: 8,
        h: 5,
        dur: 3000,
        delay: 1000,
        dx: -5,
        dy: 2,
        shape: _ParticleShape.square),
    _ParticleData(
        x: 0.88,
        y: 0.38,
        w: 5,
        h: 8,
        dur: 2600,
        delay: 600,
        dx: 3,
        dy: -3,
        shape: _ParticleShape.triangle),
  ];

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _fadeIn = CurvedAnimation(parent: _mainController, curve: Curves.easeIn);
    _scaleUp = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.elasticOut),
    );
    _mainController.forward();

    // Partículas flotando (loop 4 s)
    _particlesController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    )..repeat();

    // Halo pulsante (2.2 s)
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2200),
      vsync: this,
    )..repeat(reverse: true);

    _glowOpacity = Tween<double>(begin: 0.18, end: 0.40).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BiographyGiuseppina()),
      );
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _particlesController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF8D6),
              Color(0xFFFDE87A),
              Color(0xFFF5C030),
              Color(0xFFE09010),
            ],
            stops: [0.0, 0.38, 0.65, 1.0],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeIn,
            child: ScaleTransition(
              scale: _scaleUp,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ── Microscopio + partículas ───────────────────────
                  SizedBox(
                    width: 130,
                    height: 120,
                    child: AnimatedBuilder(
                      animation: Listenable.merge(
                          [_particlesController, _glowController]),
                      builder: (_, __) => CustomPaint(
                        painter: _MicroscopePainter(
                          particlesT: _particlesController.value,
                          glowOpacity: _glowOpacity.value,
                          particles: _particles,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Giuseppina Cattani,\nthe Unknown Co-Discoverer of\nthe Antitetanus Serum",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E1200),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    "By Marta Macho Stadler, 2025",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF5C3000),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "From Mujeres con ciencia",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF5C3000),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Datos de cada partícula ──────────────────────────────────────────
enum _ParticleShape { circle, square, triangle }

class _ParticleData {
  final double x, y; // posición base (0..1)
  final double w, h; // tamaño en px (viewBox 130×120)
  final int dur, delay;
  final double dx, dy; // desplazamiento máximo en px
  final _ParticleShape shape; // Forma de la partícula

  const _ParticleData({
    required this.x,
    required this.y,
    required this.w,
    required this.h,
    required this.dur,
    required this.delay,
    required this.dx,
    required this.dy,
    required this.shape,
  });
}

// ─── Microscopio + partículas — CustomPainter ─────────────────────────
// ─── Microscopio Vintage — CustomPainter ─────────────────────────────
class _MicroscopePainter extends CustomPainter {
  final double particlesT;
  final double glowOpacity;
  final List<_ParticleData> particles;

  _MicroscopePainter({
    required this.particlesT,
    required this.glowOpacity,
    required this.particles,
  });

  Offset p(Size s, double x, double y) =>
      Offset(x / 130 * s.width, y / 120 * s.height);
  double sc(Size s, double v) => v / 130 * s.width;

  // ignore: unused_element
  Paint _brass(double opacity) => Paint()
    ..style = PaintingStyle.fill
    ..color = const Color(0xFF8B5000).withOpacity(opacity);

  Paint _darkBrass(double opacity) => Paint()
    ..style = PaintingStyle.fill
    ..color = const Color(0xFF4A2800).withOpacity(opacity);

  Paint _highlight(double opacity) => Paint()
    ..style = PaintingStyle.fill
    ..color = const Color(0xFFFFD080).withOpacity(opacity);

  Paint _stroke(
          {required double width, Color color = const Color(0xFF4A2800)}) =>
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..strokeWidth = width
        ..color = color;

  @override
  void paint(Canvas canvas, Size size) {
    // ── HALO PULSANTE ─────────────────────────────────────────────
    final glowCenter = p(size, 65, 62);
    canvas.drawCircle(
      glowCenter,
      sc(size, 42),
      Paint()
        ..shader = RadialGradient(colors: [
          const Color(0xFF8B5000).withOpacity(glowOpacity * 0.8),
          const Color(0xFFF5C030).withOpacity(glowOpacity * 0.3),
          const Color(0xFFF5C030).withOpacity(0.0),
        ], stops: const [
          0.0,
          0.5,
          1.0
        ]).createShader(
          Rect.fromCircle(center: glowCenter, radius: sc(size, 42)),
        ),
    );

    // ── PARTÍCULAS ────────────────────────────────────────────────
    for (final pt in particles) {
      final totalMs = pt.dur + pt.delay;
      final elapsed = (particlesT * 4000) % totalMs;
      if (elapsed < pt.delay) continue;
      final prog = ((elapsed - pt.delay) / pt.dur).clamp(0.0, 1.0);
      final wave = math.sin(prog * math.pi * 2);
      final ox = pt.x * size.width + pt.dx * wave;
      final oy = pt.y * size.height + pt.dy * wave;
      final opacity = 0.30 + wave.abs() * 0.25;
      final scaleF = 1.0 + wave * 0.15;

      final particlePaint = Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF8B5000).withOpacity(opacity);

      switch (pt.shape) {
        case _ParticleShape.circle:
          // Bacteria con núcleo
          canvas.drawOval(
            Rect.fromCenter(
              center: Offset(ox, oy),
              width: pt.w * scaleF / 130 * size.width,
              height: pt.h * scaleF / 120 * size.height,
            ),
            particlePaint,
          );
          canvas.drawOval(
            Rect.fromCenter(
              center: Offset(ox - sc(size, 0.8), oy - sc(size, 0.5)),
              width: pt.w * scaleF / 130 * size.width * 0.45,
              height: pt.h * scaleF / 120 * size.height * 0.45,
            ),
            Paint()
              ..style = PaintingStyle.fill
              ..color = const Color(0xFF4A2800).withOpacity(opacity * 0.7),
          );
          break;
        case _ParticleShape.square:
          // Célula cuadrada con borde
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromCenter(
                center: Offset(ox, oy),
                width: pt.w * scaleF / 130 * size.width,
                height: pt.h * scaleF / 120 * size.height,
              ),
              Radius.circular(sc(size, 1.2)),
            ),
            particlePaint,
          );
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromCenter(
                center: Offset(ox, oy),
                width: pt.w * scaleF / 130 * size.width,
                height: pt.h * scaleF / 120 * size.height,
              ),
              Radius.circular(sc(size, 1.2)),
            ),
            _stroke(
                width: sc(size, 0.8),
                color: const Color(0xFF4A2800).withOpacity(opacity * 0.9)),
          );
          break;
        case _ParticleShape.triangle:
          final path = Path();
          path.moveTo(ox, oy - pt.h * scaleF / 120 * size.height / 2);
          path.lineTo(ox - pt.w * scaleF / 130 * size.width / 2,
              oy + pt.h * scaleF / 120 * size.height / 2);
          path.lineTo(ox + pt.w * scaleF / 130 * size.width / 2,
              oy + pt.h * scaleF / 120 * size.height / 2);
          path.close();
          canvas.drawPath(path, particlePaint);
          break;
      }
    }

    // ═══════════════════════════════════════════════════════════════
    //  MICROSCOPIO VINTAGE
    // ═══════════════════════════════════════════════════════════════

    // ── BASE HORSESHOE ────────────────────────────────────────────
    // Sombra de la base
    canvas.drawOval(
      Rect.fromCenter(
          center: p(size, 65, 111), width: sc(size, 72), height: sc(size, 12)),
      Paint()
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4)
        ..color = const Color(0xFF2E1200).withOpacity(0.30),
    );
    // Base principal con degradado
    final baseRect = Rect.fromCenter(
        center: p(size, 65, 108), width: sc(size, 68), height: sc(size, 13));
    canvas.drawOval(
      baseRect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFB07020),
            const Color(0xFF8B5000),
            const Color(0xFF5C3000),
          ],
        ).createShader(baseRect),
    );
    canvas.drawOval(baseRect, _stroke(width: sc(size, 1.8)));
    // Reflejo en la base
    canvas.drawOval(
      Rect.fromCenter(
          center: p(size, 58, 105), width: sc(size, 28), height: sc(size, 4)),
      _highlight(0.30),
    );

    // ── PATAS con curva ───────────────────────────────────────────
    // Pata izquierda
    final leftLegPath = Path()
      ..moveTo(p(size, 52, 103).dx, p(size, 52, 103).dy)
      ..cubicTo(
        p(size, 44, 104).dx,
        p(size, 44, 104).dy,
        p(size, 35, 106).dx,
        p(size, 35, 106).dy,
        p(size, 30, 110).dx,
        p(size, 30, 110).dy,
      );
    canvas.drawPath(leftLegPath, _stroke(width: sc(size, 3.5)));
    canvas.drawPath(
        leftLegPath,
        _stroke(
            width: sc(size, 1.8),
            color: const Color(0xFFB07020).withOpacity(0.70)));

    // Pata derecha
    final rightLegPath = Path()
      ..moveTo(p(size, 78, 103).dx, p(size, 78, 103).dy)
      ..cubicTo(
        p(size, 86, 104).dx,
        p(size, 86, 104).dy,
        p(size, 95, 106).dx,
        p(size, 95, 106).dy,
        p(size, 100, 110).dx,
        p(size, 100, 110).dy,
      );
    canvas.drawPath(rightLegPath, _stroke(width: sc(size, 3.5)));
    canvas.drawPath(
        rightLegPath,
        _stroke(
            width: sc(size, 1.8),
            color: const Color(0xFFB07020).withOpacity(0.70)));

    // ── COLUMNA VERTICAL con degradado ────────────────────────────
    final colLeft = p(size, 59, 38);
    final colRight = p(size, 72, 104);
    final colRect =
        Rect.fromLTRB(colLeft.dx, colLeft.dy, colRight.dx, colRight.dy);
    final colRR =
        RRect.fromRectAndRadius(colRect, Radius.circular(sc(size, 4)));
    canvas.drawRRect(
      colRR,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            const Color(0xFF5C3000),
            const Color(0xFFB07020),
            const Color(0xFFD4900A),
            const Color(0xFFB07020),
            const Color(0xFF5C3000),
          ],
          stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
        ).createShader(colRect),
    );
    canvas.drawRRect(colRR, _stroke(width: sc(size, 1.6)));
    // Líneas de detalle en la columna
    for (double yy in [50.0, 62.0, 74.0, 86.0]) {
      canvas.drawLine(
        p(size, 60.5, yy),
        p(size, 70.5, yy),
        _stroke(
            width: sc(size, 0.8),
            color: const Color(0xFF4A2800).withOpacity(0.45)),
      );
    }

    // ── SOPORTE HORIZONTAL (brazo) ────────────────────────────────
    final armRect = Rect.fromLTWH(
        p(size, 48, 37).dx, p(size, 48, 37).dy, sc(size, 34), sc(size, 9));
    final armRR =
        RRect.fromRectAndRadius(armRect, Radius.circular(sc(size, 3)));
    canvas.drawRRect(
      armRR,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFD4900A),
            const Color(0xFF8B5000),
            const Color(0xFF5C3000),
          ],
        ).createShader(armRect),
    );
    canvas.drawRRect(armRR, _stroke(width: sc(size, 1.5)));
    // Reflejo en el brazo
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(p(size, 51, 38).dx, p(size, 51, 38).dy, sc(size, 18),
            sc(size, 2.5)),
        Radius.circular(sc(size, 1)),
      ),
      _highlight(0.40),
    );

    // ── TUBO ÓPTICO ───────────────────────────────────────────────
    canvas.save();
    canvas.translate(p(size, 62, 28).dx, p(size, 62, 28).dy);
    canvas.rotate(-6 * math.pi / 180);

    final tubeRect = Rect.fromCenter(
        center: Offset.zero, width: sc(size, 15), height: sc(size, 36));
    final tubeRR =
        RRect.fromRectAndRadius(tubeRect, Radius.circular(sc(size, 5)));
    canvas.drawRRect(
      tubeRR,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            const Color(0xFF4A2800),
            const Color(0xFFB07020),
            const Color(0xFFE0A030),
            const Color(0xFFB07020),
            const Color(0xFF4A2800),
          ],
          stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
        ).createShader(tubeRect),
    );
    canvas.drawRRect(tubeRR, _stroke(width: sc(size, 1.8)));
    // Líneas decorativas en el tubo
    for (double yy in [-12.0, -4.0, 4.0, 12.0]) {
      canvas.drawLine(
        Offset(-sc(size, 6), sc(size, yy / 10)),
        Offset(sc(size, 6), sc(size, yy / 10)),
        _stroke(
            width: sc(size, 0.6),
            color: const Color(0xFF4A2800).withOpacity(0.50)),
      );
    }
    canvas.restore();

    // ── OCULAR con detalles ───────────────────────────────────────
    canvas.save();
    canvas.translate(p(size, 60, 11).dx, p(size, 60, 11).dy);
    canvas.rotate(-6 * math.pi / 180);

    // Cuerpo del ocular
    final eyepieceRect = Rect.fromCenter(
        center: Offset.zero, width: sc(size, 18), height: sc(size, 11));
    canvas.drawOval(
      eyepieceRect,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.3, -0.3),
          colors: [
            const Color(0xFFD4900A),
            const Color(0xFF8B5000),
            const Color(0xFF4A2800),
          ],
        ).createShader(eyepieceRect),
    );
    canvas.drawOval(eyepieceRect, _stroke(width: sc(size, 1.6)));
    // Lente interior
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset.zero, width: sc(size, 11), height: sc(size, 7)),
      _darkBrass(0.85),
    );
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(sc(size, -1.5), sc(size, -1)),
          width: sc(size, 4),
          height: sc(size, 3)),
      _highlight(0.60),
    );
    canvas.restore();

    // ── REVÓLVER / OBJETIVO ───────────────────────────────────────
    // Cuerpo del revólver
    canvas.drawOval(
      Rect.fromCenter(
          center: p(size, 65, 44), width: sc(size, 18), height: sc(size, 10)),
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.2, -0.4),
          colors: [
            const Color(0xFFD4900A),
            const Color(0xFF8B5000),
            const Color(0xFF4A2800),
          ],
        ).createShader(Rect.fromCenter(
            center: p(size, 65, 44),
            width: sc(size, 18),
            height: sc(size, 10))),
    );
    canvas.drawOval(
      Rect.fromCenter(
          center: p(size, 65, 44), width: sc(size, 18), height: sc(size, 10)),
      _stroke(width: sc(size, 1.6)),
    );
    // Lente interior del objetivo
    canvas.drawOval(
      Rect.fromCenter(
          center: p(size, 65, 44), width: sc(size, 9), height: sc(size, 6)),
      _darkBrass(0.90),
    );
    canvas.drawOval(
      Rect.fromCenter(
          center: p(size, 63, 43), width: sc(size, 3.5), height: sc(size, 2.5)),
      _highlight(0.55),
    );

    // Tubo del objetivo hacia abajo
    final objTubeRect = Rect.fromCenter(
        center: p(size, 65, 52), width: sc(size, 8), height: sc(size, 16));
    canvas.drawRRect(
      RRect.fromRectAndRadius(objTubeRect, Radius.circular(sc(size, 3))),
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            const Color(0xFF4A2800),
            const Color(0xFFB07020),
            const Color(0xFF4A2800),
          ],
        ).createShader(objTubeRect),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(objTubeRect, Radius.circular(sc(size, 3))),
      _stroke(width: sc(size, 1.4)),
    );
    // Anillos del objetivo
    for (double yy in [46.0, 50.0, 54.0, 58.0]) {
      canvas.drawLine(
        p(size, 61.5, yy),
        p(size, 68.5, yy),
        _stroke(
            width: sc(size, 0.9),
            color: const Color(0xFF4A2800).withOpacity(0.55)),
      );
    }

    // ── PLATINA con detalle ───────────────────────────────────────
    final stageRect = Rect.fromLTWH(
        p(size, 44, 69).dx, p(size, 44, 69).dy, sc(size, 42), sc(size, 7));
    final stageRR =
        RRect.fromRectAndRadius(stageRect, Radius.circular(sc(size, 2)));
    canvas.drawRRect(
      stageRR,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFD4900A).withOpacity(0.90),
            const Color(0xFF8B5000),
          ],
        ).createShader(stageRect),
    );
    canvas.drawRRect(stageRR, _stroke(width: sc(size, 1.5)));
    // Agujero central de la platina
    canvas.drawOval(
      Rect.fromCenter(
          center: p(size, 65, 72), width: sc(size, 12), height: sc(size, 5)),
      _darkBrass(0.70),
    );
    canvas.drawOval(
      Rect.fromCenter(
          center: p(size, 65, 72), width: sc(size, 12), height: sc(size, 5)),
      _stroke(width: sc(size, 1.2)),
    );

    // Portaobjetos sobre la platina
    final slideRect = Rect.fromLTWH(
        p(size, 52, 66).dx, p(size, 52, 66).dy, sc(size, 24), sc(size, 4));
    canvas.drawRRect(
      RRect.fromRectAndRadius(slideRect, Radius.circular(sc(size, 1))),
      Paint()
        ..shader = LinearGradient(
          colors: [
            const Color(0xFFFFEE88).withOpacity(0.75),
            const Color(0xFFFFD040).withOpacity(0.55),
          ],
        ).createShader(slideRect),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(slideRect, Radius.circular(sc(size, 1))),
      _stroke(
          width: sc(size, 1.0),
          color: const Color(0xFF8B5000).withOpacity(0.80)),
    );

    // ── TORNILLO MACROMÉTRICO ─────────────────────────────────────
    final knobRect = Rect.fromCenter(
        center: p(size, 74, 57), width: sc(size, 7), height: sc(size, 18));
    canvas.drawRRect(
      RRect.fromRectAndRadius(knobRect, Radius.circular(sc(size, 3))),
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            const Color(0xFF4A2800),
            const Color(0xFFD4900A),
            const Color(0xFF4A2800),
          ],
        ).createShader(knobRect),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(knobRect, Radius.circular(sc(size, 3))),
      _stroke(width: sc(size, 1.3)),
    );
    // Estrías del tornillo
    for (double yy in [49.0, 52.5, 56.0, 59.5, 63.0, 66.0]) {
      canvas.drawLine(
        p(size, 71, yy),
        p(size, 77, yy),
        _stroke(
            width: sc(size, 0.7),
            color: const Color(0xFF4A2800).withOpacity(0.60)),
      );
    }

    // ── TORNILLO MICROMÉTRICO (más pequeño, debajo) ───────────────
    final microKnobRect = Rect.fromCenter(
        center: p(size, 74, 76), width: sc(size, 5.5), height: sc(size, 11));
    canvas.drawRRect(
      RRect.fromRectAndRadius(microKnobRect, Radius.circular(sc(size, 2))),
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            const Color(0xFF4A2800),
            const Color(0xFFB07020),
            const Color(0xFF4A2800),
          ],
        ).createShader(microKnobRect),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(microKnobRect, Radius.circular(sc(size, 2))),
      _stroke(width: sc(size, 1.1)),
    );
    for (double yy in [71.5, 74.5, 77.5, 80.5]) {
      canvas.drawLine(
        p(size, 71.8, yy),
        p(size, 76.2, yy),
        _stroke(
            width: sc(size, 0.6),
            color: const Color(0xFF4A2800).withOpacity(0.55)),
      );
    }

    // ── ESPEJO / CONDENSADOR (base) ───────────────────────────────
    canvas.drawOval(
      Rect.fromCenter(
          center: p(size, 65, 98), width: sc(size, 20), height: sc(size, 7)),
      Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFFFFEE88).withOpacity(0.70),
            const Color(0xFF8B5000).withOpacity(0.50),
          ],
        ).createShader(Rect.fromCenter(
            center: p(size, 65, 98), width: sc(size, 20), height: sc(size, 7))),
    );
    canvas.drawOval(
      Rect.fromCenter(
          center: p(size, 65, 98), width: sc(size, 20), height: sc(size, 7)),
      _stroke(width: sc(size, 1.3)),
    );
  }

  // ignore: unused_element
  void _rrect(Canvas c, Size s, double x, double y, double w, double h,
      double radius, Paint fill, Paint stroke,
      {bool centered = false}) {
    final rect = centered
        ? Rect.fromCenter(
            center: Offset(x / 130 * s.width, y / 120 * s.height),
            width: w / 130 * s.width,
            height: h / 120 * s.height)
        : Rect.fromLTWH(x / 130 * s.width, y / 120 * s.height,
            w / 130 * s.width, h / 120 * s.height);
    final rr =
        RRect.fromRectAndRadius(rect, Radius.circular(radius / 130 * s.width));
    c.drawRRect(rr, fill);
    c.drawRRect(rr, stroke);
  }

  @override
  bool shouldRepaint(covariant _MicroscopePainter old) =>
      old.particlesT != particlesT || old.glowOpacity != glowOpacity;
}

// ---------------------- Giuseppina QUESTIONS ----------------------
class BiographyGiuseppina extends StatefulWidget {
  const BiographyGiuseppina({super.key});
  @override
  State<BiographyGiuseppina> createState() => _BiographyGiuseppinaState();
}

class _BiographyGiuseppinaState extends State<BiographyGiuseppina> {
  int currentQuestion = 0;
  int? selectedOption;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Title: Giuseppina Cattani, the Unknown Co-Discoverer of the Antitetanus Serum\n\nWhat is most likely to be discussed?",
      "options": [
        "A) Her overlooked role in a major scientific breakthrough",
        "B) The invention of a new vaccine in modern times",
        "C) A fictional account of medical experiments",
        "D) The history of antibiotics in the 21st century"
      ],
      "correct": 0,
      "feedback": [
        " Correct! The title emphasizes her as the 'unknown co-discoverer,' suggesting the text will reveal her forgotten scientific contributions.",
        "Incorrect. The invention of a new vaccine in modern times is unrelated to the given title.",
        "No, the text is about a real scientific figure, not a fictional account.",
        "No, the history of antibiotics in the 21st century is unrelated to the Antitetanus Serum."
      ]
    },
    {
      "question": "What is the primary cause of tetanus?",
      "options": [
        "A) Viral infection",
        "B) Bacterial infection",
        "C) Genetic mutation",
        "D) Fungal spores"
      ],
      "correct": 1,
      "feedback": [
        "No, tetanus is not caused by a virus.",
        " Correct! Tetanus is caused by the bacterium *Clostridium tetani*, which produces a toxin affecting the nervous system.",
        "Incorrect. Tetanus is not a genetic condition.",
        "No, fungal spores are unrelated to tetanus."
      ]
    },
    {
      "question": "How is tetanus most commonly transmitted?",
      "options": [
        "A) Through airborne droplets",
        "B) By contaminated water",
        "C) Through wounds or cuts contaminated with soil",
        "D) Via person-to-person contact"
      ],
      "correct": 2,
      "feedback": [
        "No, tetanus is not spread through the air.",
        "Incorrect. Water contamination is not a major cause.",
        " Correct! Tetanus bacteria are commonly found in soil, dust, or animal feces and enter the body through cuts, puncture wounds, or burns.",
        "No, tetanus does not spread from person to person."
      ]
    },
    {
      "question": "Which of the following is a classic symptom of tetanus?",
      "options": [
        "A) Diarrhea and fever",
        "B) Muscle stiffness and spasms",
        "C) Skin rash and nausea",
        "D) Persistent cough and headache"
      ],
      "correct": 1,
      "feedback": [
        "No, those are not typical tetanus symptoms.",
        " Correct! Tetanus primarily affects the nervous system, causing painful muscle contractions, especially in the jaw ('lockjaw') and neck.",
        "Incorrect. Tetanus does not cause a rash or nausea.",
        "No, coughing and headache are unrelated to tetanus."
      ]
    },
    {
      "question": "Why were soldiers in wars at high risk for tetanus?",
      "options": [
        "A) Poor nutrition",
        "B) Contaminated wounds",
        "C) Cold weather",
        "D) Stress"
      ],
      "correct": 1,
      "feedback": [
        "No, nutrition was not the main factor.",
        " Correct! Battlefield injuries often got contaminated with soil or debris, making tetanus infection common before vaccines.",
        "Incorrect. Weather conditions do not cause tetanus.",
        "No, stress does not lead to tetanus infection."
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
          MaterialPageRoute(builder: (_) => const GiuseppinaReadingAnimation()),
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
                  "assets/Wallpapers/WallPaperReadingSpots/FONDO GOAL INSTRUCTION 4 Y Bios.webp",
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
                        Color(0xFFFFE082), // amarillo suave
                        Color(0xFF80CBC4), // aquamarina elegante
                      ],
                    ),
                  ),
                ),
// 🔹 SUAVIZAR FONDO GENERAL
                Container(
                  color: Colors.white.withOpacity(0.10),
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
                                                255, 243, 196, 23)
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
                                    const Color.fromARGB(255, 243, 196, 23),
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

class GiuseppinaReadingAnimation extends StatefulWidget {
  const GiuseppinaReadingAnimation({super.key});

  @override
  State<GiuseppinaReadingAnimation> createState() =>
      _GiuseppinaReadingAnimationState();
}

class _GiuseppinaReadingAnimationState extends State<GiuseppinaReadingAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _entryCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _bgCtrl;
  late final AnimationController _floatCtrl;
  late final AnimationController _particleCtrl;
  late final AnimationController _beamsCtrl;
  late final AnimationController _flameCtrl;
  late final AnimationController _haloCtrl;
  late final AnimationController _linesCtrl;
  late final AnimationController _pageCtrl;
  late final AnimationController _sparkCtrl;

  late final Animation<double> _textFade;
  late final Animation<double> _textSlide;
  late final Animation<double> _dividerWidth;
  late final Animation<double> _glow;
  late final Animation<Color?> _bgColor1;
  late final Animation<Color?> _bgColor2;
  late final Animation<double> _floatY;
  late final Animation<double> _floatRock;
  late final Animation<double> _beamsOpacity;
  late final Animation<double> _flameScaleX;
  late final Animation<double> _flameScaleY;
  late final Animation<double> _flameOpacity;
  late final Animation<double> _haloRadius;
  late final Animation<double> _haloOpacity;
  late final Animation<double> _linesOpacity;
  late final Animation<double> _linesOpacity2;
  late final Animation<double> _pageOpacity;

  final List<_Particle> _particles = [];
  final math.Random _rng = math.Random();

  static const _golden = [
    Color(0xFFFAEEDA),
    Color(0xFFFAC775),
    Color(0xFFEF9F27),
    Color(0xFFBA7517),
  ];

  @override
  void initState() {
    super.initState();
    _spawnParticles();

    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _textFade = CurvedAnimation(
      parent: _entryCtrl,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );
    _textSlide = Tween<double>(begin: 16, end: 0).animate(
      CurvedAnimation(
        parent: _entryCtrl,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
      ),
    );
    _dividerWidth = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryCtrl,
        curve: const Interval(0.25, 0.7, curve: Curves.easeOut),
      ),
    );

    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);
    _glow = Tween<double>(begin: 8, end: 32).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );

    _bgCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat(reverse: true);
    _bgColor1 = ColorTween(
      begin: const Color(0xFF1A0C00),
      end: const Color(0xFF3B2F00),
    ).animate(_bgCtrl);
    _bgColor2 = ColorTween(
      begin: const Color(0xFFB8860B),
      end: const Color(0xFFFFE082),
    ).animate(_bgCtrl);

    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3800),
    )..repeat(reverse: true);
    _floatY = Tween<double>(begin: 0, end: -9).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );
    _floatRock = Tween<double>(begin: -0.021, end: 0.021).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );

    // Llama — ciclo rápido irregular simulado con dos controllers
    _flameCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);
    _flameScaleX = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.85), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.85, end: 1.10), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.10, end: 0.90), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.90, end: 1.0), weight: 25),
    ]).animate(_flameCtrl);
    _flameScaleY = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.12), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.12, end: 0.92), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.92, end: 1.08), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.08, end: 1.0), weight: 25),
    ]).animate(_flameCtrl);
    _flameOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.85), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.85, end: 0.95), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.95, end: 0.9), weight: 25),
    ]).animate(_flameCtrl);

    // Halo vela
    _haloCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _haloRadius = Tween<double>(begin: 28, end: 38).animate(
      CurvedAnimation(parent: _haloCtrl, curve: Curves.easeInOut),
    );
    _haloOpacity = Tween<double>(begin: 0.18, end: 0.38).animate(
      CurvedAnimation(parent: _haloCtrl, curve: Curves.easeInOut),
    );

    // Líneas texto
    _linesCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _linesOpacity = Tween<double>(begin: 0.3, end: 0.85).animate(
      CurvedAnimation(parent: _linesCtrl, curve: Curves.easeInOut),
    );
    _linesOpacity2 = Tween<double>(begin: 0.85, end: 0.3).animate(
      CurvedAnimation(parent: _linesCtrl, curve: Curves.easeInOut),
    );

    // Página volando
    _pageCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);
    _pageOpacity = Tween<double>(begin: 0.45, end: 0.70).animate(
      CurvedAnimation(parent: _pageCtrl, curve: Curves.easeInOut),
    );

    _sparkCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _particleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _beamsCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _beamsOpacity = Tween<double>(begin: 0.06, end: 0.22).animate(
      CurvedAnimation(parent: _beamsCtrl, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await _entryCtrl.forward();
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      _goToNextScreen();
    });
  }

  void _spawnParticles() {
    for (int i = 0; i < 22; i++) {
      _particles.add(_Particle(
        x: _rng.nextDouble(),
        size: 2.5 + _rng.nextDouble() * 4.0,
        speed: 0.5 + _rng.nextDouble() * 1.5,
        color: _golden[_rng.nextInt(_golden.length)],
        offset: _rng.nextDouble(),
      ));
    }
  }

  @override
  void dispose() {
    _entryCtrl.dispose();
    _glowCtrl.dispose();
    _bgCtrl.dispose();
    _floatCtrl.dispose();
    _particleCtrl.dispose();
    _beamsCtrl.dispose();
    _flameCtrl.dispose();
    _haloCtrl.dispose();
    _linesCtrl.dispose();
    _pageCtrl.dispose();
    _sparkCtrl.dispose();
    super.dispose();
  }

  void _goToNextScreen() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (_, __, ___) => const BiographyReadingPage(),
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _bgCtrl,
          _glowCtrl,
          _floatCtrl,
          _particleCtrl,
          _beamsCtrl,
          _flameCtrl,
          _haloCtrl,
          _linesCtrl,
          _pageCtrl,
          _sparkCtrl,
        ]),
        builder: (context, _) {
          return Stack(
            fit: StackFit.expand,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _bgColor1.value ?? const Color(0xFF1A0C00),
                      const Color(0xFF3B2F00),
                      const Color(0xFFB8860B),
                      _bgColor2.value ?? const Color(0xFFFFE082),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.15,
                    colors: [
                      Colors.transparent,
                      const Color(0xFF0C0600).withOpacity(0.76),
                    ],
                  ),
                ),
              ),
              CustomPaint(painter: _BeamsPainter(opacity: _beamsOpacity.value)),
              CustomPaint(
                painter: _ParticlePainter(
                  particles: _particles,
                  progress: _particleCtrl.value,
                ),
              ),
              SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.translate(
                          offset: Offset(0, _floatY.value),
                          child: Transform.rotate(
                            angle: _floatRock.value,
                            child: SizedBox(
                              width: 150,
                              height: 140,
                              child: CustomPaint(
                                painter: _BookCandlePainter(
                                  glow: _glow.value,
                                  flameScaleX: _flameScaleX.value,
                                  flameScaleY: _flameScaleY.value,
                                  flameOpacity: _flameOpacity.value,
                                  haloRadius: _haloRadius.value,
                                  haloOpacity: _haloOpacity.value,
                                  linesOpacity: _linesOpacity.value,
                                  linesOpacity2: _linesOpacity2.value,
                                  pageOpacity: _pageOpacity.value,
                                  sparkProgress: _sparkCtrl.value,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildDivider(thick: true),
                        const SizedBox(height: 22),
                        FadeTransition(
                          opacity: _textFade,
                          child: Transform.translate(
                            offset: Offset(0, _textSlide.value),
                            child: Text(
                              'Step into history.\nThe more you read,\nthe brighter your wisdom shines.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Georgia',
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFFAEEDA),
                                height: 1.6,
                                letterSpacing: 0.4,
                                shadows: [
                                  Shadow(
                                    color: const Color(0xFFEF9F27)
                                        .withOpacity(0.9),
                                    blurRadius: _glow.value,
                                  ),
                                  Shadow(
                                    color: const Color(0xFFBA7517)
                                        .withOpacity(0.55),
                                    blurRadius: _glow.value * 2.4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        _buildDivider(thick: false),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDivider({required bool thick}) {
    return AnimatedBuilder(
      animation: _entryCtrl,
      builder: (_, __) => FractionallySizedBox(
        widthFactor: _dividerWidth.value,
        child: Container(
          height: thick ? 1.5 : 1.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Color(0xFFEF9F27),
                Color(0xFFFAEEDA),
                Color(0xFFEF9F27),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Book + Candle painter ─────────────────────────────────────────────────────
class _BookCandlePainter extends CustomPainter {
  final double glow;
  final double flameScaleX;
  final double flameScaleY;
  final double flameOpacity;
  final double haloRadius;
  final double haloOpacity;
  final double linesOpacity;
  final double linesOpacity2;
  final double pageOpacity;
  final double sparkProgress;

  const _BookCandlePainter({
    required this.glow,
    required this.flameScaleX,
    required this.flameScaleY,
    required this.flameOpacity,
    required this.haloRadius,
    required this.haloOpacity,
    required this.linesOpacity,
    required this.linesOpacity2,
    required this.pageOpacity,
    required this.sparkProgress,
  });

  double sx(Size s, double v) => v / 150 * s.width;
  double sy(Size s, double v) => v / 140 * s.height;
  Offset p(Size s, double px, double py) => Offset(sx(s, px), sy(s, py));

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.5;

    // ── Halo vela ──
    canvas.drawCircle(
      Offset(cx, sy(size, 22)),
      haloRadius,
      Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFFFAC775).withOpacity(haloOpacity),
            Colors.transparent,
          ],
          stops: const [0.0, 1.0],
        ).createShader(
          Rect.fromCircle(center: Offset(cx, sy(size, 22)), radius: haloRadius),
        ),
    );

    // ── Llama ──
    canvas.save();
    canvas.translate(cx, sy(size, 22));
    canvas.scale(flameScaleX, flameScaleY);

    // Llama exterior
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(0, -sy(size, 6)),
          width: sx(size, 10),
          height: sy(size, 20)),
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFFEF9F27), Color(0xFFFAC775), Color(0xFFFAEEDA)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ).createShader(Rect.fromLTWH(-5, -16, 10, 20))
        ..color = const Color(0xFFEF9F27).withOpacity(flameOpacity),
    );
    // Núcleo interior
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(0, -sy(size, 5)),
          width: sx(size, 6),
          height: sy(size, 12)),
      Paint()..color = const Color(0xFFFAEEDA).withOpacity(flameOpacity * 0.7),
    );
    canvas.restore();

    // ── Cuerpo vela ──
    final candleRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(cx - sx(size, 4), sy(size, 28), sx(size, 8), sy(size, 22)),
      const Radius.circular(2),
    );
    canvas.drawRRect(
        candleRect, Paint()..color = const Color(0xFFFAEEDA).withOpacity(0.92));
    // Highlight lateral
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
            cx - sx(size, 4), sy(size, 28), sx(size, 3), sy(size, 22)),
        const Radius.circular(2),
      ),
      Paint()..color = Colors.white.withOpacity(0.35),
    );
    // Cera derramada
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(cx, sy(size, 50)),
          width: sx(size, 12),
          height: sy(size, 5)),
      Paint()..color = const Color(0xFFFAEEDA).withOpacity(0.6),
    );

    // ── Tapa izquierda ──
    final leftCover = Path()
      ..moveTo(sx(size, 8), sy(size, 55))
      ..quadraticBezierTo(sx(size, 8), sy(size, 51), sx(size, 11), sy(size, 51))
      ..lineTo(sx(size, 72), sy(size, 51))
      ..lineTo(sx(size, 72), sy(size, 118))
      ..lineTo(sx(size, 11), sy(size, 118))
      ..quadraticBezierTo(
          sx(size, 8), sy(size, 118), sx(size, 8), sy(size, 115))
      ..close();
    canvas.drawPath(
      leftCover,
      Paint()
        ..shader = LinearGradient(
          colors: const [Color(0xFFFAC775), Color(0xFF854F0B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromLTWH(
            sx(size, 8), sy(size, 51), sx(size, 64), sy(size, 67))),
    );
    canvas.drawPath(
      leftCover,
      Paint()
        ..color = const Color(0xFFBA7517)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.9,
    );

    // ── Lomo ──
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(sx(size, 70), sy(size, 51), sx(size, 10), sy(size, 67)),
        const Radius.circular(1),
      ),
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFFEF9F27), Color(0xFF412402)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(
          Rect.fromLTWH(sx(size, 70), sy(size, 51), sx(size, 10), sy(size, 67)),
        ),
    );

    // ── Tapa derecha ──
    final rightCover = Path()
      ..moveTo(sx(size, 80), sy(size, 51))
      ..lineTo(sx(size, 139), sy(size, 51))
      ..quadraticBezierTo(
          sx(size, 142), sy(size, 51), sx(size, 142), sy(size, 55))
      ..lineTo(sx(size, 142), sy(size, 115))
      ..quadraticBezierTo(
          sx(size, 142), sy(size, 118), sx(size, 139), sy(size, 118))
      ..lineTo(sx(size, 80), sy(size, 118))
      ..close();
    canvas.drawPath(
      rightCover,
      Paint()
        ..shader = LinearGradient(
          colors: const [Color(0xFFFAC775), Color(0xFFBA7517)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ).createShader(Rect.fromLTWH(
            sx(size, 80), sy(size, 51), sx(size, 62), sy(size, 67))),
    );
    canvas.drawPath(
      rightCover,
      Paint()
        ..color = const Color(0xFFBA7517)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.9,
    );

    // ── Páginas izquierda ──
    canvas.drawRect(
      Rect.fromLTWH(sx(size, 11), sy(size, 51), sx(size, 59), sy(size, 67)),
      Paint()
        ..shader = LinearGradient(
          colors: [
            const Color(0xFFFAEEDA),
            const Color(0xFFFAC775).withOpacity(0.55)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(Rect.fromLTWH(sx(size, 11), 0, sx(size, 59), h)),
    );

    // ── Páginas derecha ──
    canvas.drawRect(
      Rect.fromLTWH(sx(size, 80), sy(size, 51), sx(size, 59), sy(size, 67)),
      Paint()
        ..shader = LinearGradient(
          colors: [
            const Color(0xFFFAC775).withOpacity(0.55),
            const Color(0xFFFAEEDA)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(Rect.fromLTWH(sx(size, 80), 0, sx(size, 59), h)),
    );

    // ── Líneas izquierda ──
    final leftYs = [0.62, 0.70, 0.78, 0.86, 0.94, 1.02, 1.10];
    final leftWs = [0.53, 0.53, 0.45, 0.53, 0.41, 0.53, 0.47];
    for (int i = 0; i < leftYs.length; i++) {
      canvas.drawLine(
        Offset(sx(size, 16), h * leftYs[i] / 1.40),
        Offset(sx(size, 16) + w * leftWs[i] * 0.45, h * leftYs[i] / 1.40),
        Paint()
          ..color = const Color(0xFFBA7517)
              .withOpacity(linesOpacity * (0.65 - i * 0.03))
          ..strokeWidth = 1.1
          ..strokeCap = StrokeCap.round,
      );
    }

    // ── Líneas derecha ──
    final rightYs = [0.62, 0.70, 0.78, 0.86, 0.94, 1.02, 1.10];
    final rightWs = [0.53, 0.53, 0.43, 0.53, 0.38, 0.53, 0.47];
    for (int i = 0; i < rightYs.length; i++) {
      canvas.drawLine(
        Offset(sx(size, 86), h * rightYs[i] / 1.40),
        Offset(sx(size, 86) + w * rightWs[i] * 0.45, h * rightYs[i] / 1.40),
        Paint()
          ..color = const Color(0xFFBA7517)
              .withOpacity(linesOpacity2 * (0.65 - i * 0.03))
          ..strokeWidth = 1.1
          ..strokeCap = StrokeCap.round,
      );
    }

    // ── Página volando ──
    final flutterPath = Path()
      ..moveTo(sx(size, 72), sy(size, 68))
      ..quadraticBezierTo(
          sx(size, 85), sy(size, 62), sx(size, 97), sy(size, 68))
      ..lineTo(sx(size, 97), sy(size, 105))
      ..quadraticBezierTo(
          sx(size, 85), sy(size, 99), sx(size, 72), sy(size, 105))
      ..close();
    canvas.drawPath(
      flutterPath,
      Paint()..color = const Color(0xFFFAEEDA).withOpacity(pageOpacity),
    );

    // ── Glow libro ──
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, sy(size, 130)),
        width: w * 0.72,
        height: h * 0.14,
      ),
      Paint()
        ..color = const Color(0xFFEF9F27).withOpacity(0.12)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glow * 0.5),
    );

    // ── Chispas ──
    final sparks = [
      (sx(size, 60), sy(size, 16), 0.1),
      (sx(size, 92), sy(size, 12), 0.5),
      (sx(size, 48), sy(size, 22), 0.9),
      (sx(size, 104), sy(size, 20), 0.3),
      (sx(size, 6), sy(size, 75), 1.1),
      (sx(size, 145), sy(size, 78), 0.7),
    ];
    for (final sp in sparks) {
      final phase = (sparkProgress + sp.$3) % 1.0;
      final s = math.sin(phase * math.pi).clamp(0.0, 1.0);
      canvas.drawCircle(
        Offset(sp.$1, sp.$2),
        2.5 * s,
        Paint()
          ..color = const Color(0xFFFAEEDA).withOpacity(s)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3 * s),
      );
    }
  }

  @override
  bool shouldRepaint(_BookCandlePainter old) =>
      old.glow != glow ||
      old.flameScaleX != flameScaleX ||
      old.flameScaleY != flameScaleY ||
      old.flameOpacity != flameOpacity ||
      old.haloRadius != haloRadius ||
      old.haloOpacity != haloOpacity ||
      old.linesOpacity != linesOpacity ||
      old.linesOpacity2 != linesOpacity2 ||
      old.pageOpacity != pageOpacity ||
      old.sparkProgress != sparkProgress;
}

// ── Beams ─────────────────────────────────────────────────────────────────────
class _BeamsPainter extends CustomPainter {
  final double opacity;
  const _BeamsPainter({required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    const beams = [
      (frac: 0.28, angle: -0.38, alpha: 1.0),
      (frac: 0.50, angle: -0.26, alpha: 0.70),
      (frac: 0.68, angle: -0.18, alpha: 0.40),
    ];
    for (final b in beams) {
      final cx = size.width * b.frac;
      final paint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFFFFE082).withOpacity(opacity * b.alpha),
            const Color(0xFFEF9F27).withOpacity(opacity * 0.55 * b.alpha),
            Colors.transparent,
          ],
        ).createShader(Rect.fromLTWH(cx - 1, 0, 2, size.height));
      canvas.save();
      canvas.translate(cx, size.height * 0.5);
      canvas.rotate(b.angle);
      canvas.drawRect(
        Rect.fromLTWH(-1, -size.height * 0.9, 2, size.height * 1.8),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_BeamsPainter old) => old.opacity != opacity;
}

// ── Particles ─────────────────────────────────────────────────────────────────
class _Particle {
  final double x, size, speed, offset;
  final Color color;
  const _Particle({
    required this.x,
    required this.size,
    required this.speed,
    required this.color,
    required this.offset,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  const _ParticlePainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final t = (progress * p.speed + p.offset) % 1.0;
      final y = size.height * (1.0 - t * 0.85);
      final dx = math.sin(t * math.pi * 3 + p.offset * 5) * 16;
      final opacity = t < 0.12
          ? t / 0.12
          : t > 0.72
              ? 1 - (t - 0.72) / 0.28
              : 1.0;
      canvas.drawCircle(
        Offset(p.x * size.width + dx, y),
        p.size * 0.5,
        Paint()
          ..color = p.color.withOpacity(opacity * 0.72)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, p.size * 0.55),
      );
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => old.progress != progress;
}

class BiographyReadingPage extends StatefulWidget {
  const BiographyReadingPage({super.key});

  @override
  State<BiographyReadingPage> createState() => _BiographyReadingPageState();
}

class _BiographyReadingPageState extends State<BiographyReadingPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  final String biographyText = '''
In the small Italian town of Imola, on a spring day in 1859, a baby girl named Giuseppina Cattani was born into a modest family. Her mother Teresa delivered babies as a midwife while her father Tullio alternated between tailoring clothes and guarding prisoners. Though money was often tight, their home was rich with ideas and warmth. As the eldest of three sisters, young Giuseppina grew up surrounded by passionate discussions about society and justice, thanks to family friends like fiery politician Andrea Costa and radical doctor Anna Kulishova.

The Cattani parents did something unusual for their time - they insisted all their daughters receive proper schooling. At nineteen, Giuseppina took this opportunity further than anyone imagined by enrolling at the University of Bologna's medical school. While other young women her age were marrying, she spent her days bent over anatomy books and peering through microscopes. By 1884, she made history twice over - not only becoming the first woman to graduate from the program, but doing so with the highest honors.
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
    _fadeController.forward(from: 0); // 🔑 Iniciar animación

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
                                const Color.fromARGB(255, 243, 196, 23),
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
                          color: Color.fromARGB(255, 243, 196, 23)),
                      SizedBox(height: 16),
                      Text(
                        "Going to Questions...",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 228, 184, 22),
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
        "Giuseppina’s parents insisted all their daughters receive schooling.\n\nWhat is the likely outcome?",
    options: [
      "A) The daughters will remain uneducated",
      "B) The daughters will grow up empowered",
      "C) The daughters will be forbidden from reading",
      "D) The daughters will move away to escape learning"
    ],
    correctIndex: 1,
    explanation:
        " Schooling leads to empowerment and knowledge, not restriction or escape.",
    incorrectExplanations: [
      "No, they are receiving education, so they won’t remain uneducated.",
      "Correct answer! Education empowers and enlightens.",
      "Incorrect. There is no indication that reading would be forbidden.",
      "No, the daughters would not avoid education; they were encouraged to learn."
    ],
  ),
  QuestionData(
    question:
        "At nineteen, Giuseppina enrolled in medical school while others her age were marrying.\n\nWhat will most likely happen?",
    options: [
      "A) She will stand out as different and make history",
      "B) She will abandon her studies to marry",
      "C) She will travel the world as an artist",
      "D) She will start a clothing shop"
    ],
    correctIndex: 0,
    explanation:
        " The contrast with social norms suggests her choice to study medicine leads to historical achievement.",
    incorrectExplanations: [
      "Correct answer! Her determination to study makes her historically significant.",
      "No, the passage shows she chose education, not marriage.",
      "Incorrect. There’s no mention of her becoming an artist.",
      "No, opening a shop is unrelated to her decision to enroll in medical school."
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

  // Paleta: ámbar cálido + crema + terracota suave
  static const Color accentDark = Color(0xFFFF8F00); // ámbar oscuro
  static const Color cardBg = Color(0xFFFFFDE7); // crema casi blanco

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
          // Fondo degradado
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFE082), // amarillo suave
                  Color(0xFF80CBC4), // aquamarina elegante
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
                          color: const Color(0xFFF3C417),
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
                                  ? const Color(0xFFF3C417)
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
                            backgroundColor: Color(0xFFF3C417),
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
                              color: Color.fromARGB(255, 0, 0, 0),
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

class _BiographyReadingPageSecondState extends State<BiographyReadingPageSecond>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  final String biographyTextSecond = '''
Even before receiving her degree, she had already caught the attention of Dr. Guido Tizzoni, who invited her to work in his pathology laboratory. There, among glass slides and surgical instruments, Giuseppina discovered her true calling. Her graduation thesis on birds' nervous systems showed such insight that the examining professors could only nod in admiration as she presented her findings.

As she settled into her role at the laboratory, Giuseppina gradually stepped away from political gatherings, trading street protests for the quiet intensity of research. The scientific community quickly recognized her worth - in 1886, the Medical-Surgical Society of Bologna, which had never before admitted a woman, opened its doors to her. A year later, she earned the right to teach pathology herself, a remarkable achievement for any young scientist of her time.
''';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkScrollEnd);

    //  Inicializamos el controlador y la animación
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

    //  Lanzamos la animación al presionar el botón
    _fadeController.forward(from: 0);

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
    _fadeController.dispose(); //  Muy importante liberar memoria
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
                                const Color.fromARGB(255, 243, 196, 23),
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
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                color: Colors.white.withOpacity(0.5),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                          color: Color.fromARGB(255, 243, 196, 23)),
                      SizedBox(height: 16),
                      Text(
                        "Going to Questions...",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 228, 184, 22),
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
    question:
        "Dr. Tizzoni invited Giuseppina to work in his pathology laboratory.\n\nWhat will most likely happen?",
    options: [
      "A) She will gain valuable experience and recognition",
      "B) She will refuse and stop studying",
      "C) She will return to political protests instead",
      "D) She will switch to farming"
    ],
    correctIndex: 0,
    explanation:
        " Being invited by a respected doctor suggests career growth and recognition, not quitting.",
    incorrectExplanations: [
      "Correct answer! The invitation represents a valuable opportunity for professional development.",
      "No, there’s no indication she would refuse or stop studying.",
      "Incorrect. The focus here is scientific work, not political activity.",
      "No, switching to farming is unrelated to the academic and medical context."
    ],
  ),
  QuestionData(
    question:
        "The Medical-Surgical Society of Bologna admitted Giuseppina, the first woman ever.\n\nWhat is the likely outcome?",
    options: [
      "A) She will hide her achievements",
      "B) She will be banned from teaching",
      "C) She will stop attending scientific meetings",
      "D) She will open new opportunities for other women"
    ],
    correctIndex: 3,
    explanation:
        " Being admitted to the society sets a precedent, paving the way for more women to follow in her footsteps.",
    incorrectExplanations: [
      "No, she will be recognized rather than hiding her success.",
      "Incorrect. Admission implies acceptance, not exclusion.",
      "No, joining the society would encourage her participation, not stop it.",
      "Correct answer! Her success inspires future opportunities for women in science."
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

  // Paleta: ámbar cálido + crema + terracota suave
  static const Color accentDark = Color(0xFFFF8F00); // ámbar oscuro
  static const Color cardBg = Color(0xFFFFFDE7); // crema casi blanco

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
          // Fondo degradado
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFE082), // amarillo suave
                  Color(0xFF80CBC4), // aquamarina elegante
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
                            color: const Color(0xFFF3C417), width: 1.5),
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
                                  ? const Color(0xFFF3C417)
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
                            backgroundColor: Color(0xFFF3C417),
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
                              color: Color.fromARGB(255, 0, 0, 0),
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

class _BiographyReadingPageThirdState extends State<BiographyReadingPageThird>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  final String biographyTextThird = '''
"Her early work focused on unraveling the mysteries of the nervous system, but history had other plans. When cholera began claiming lives across Bologna, Giuseppina and Dr. Tizzoni turned their microscopes toward this invisible killer. Night after night, while most of the city slept, they tested how the disease survived in different conditions. Their discovery that cholera could spread through blood would save countless lives in years to come, though in those momentous days, Giuseppina simply recorded her findings with the same careful attention she gave all her work, unaware of how profoundly her research would change medicine.

The laboratory in Bologna hummed with quiet intensity as Giuseppina and Dr. Tizzoni peered at their latest cultures. It was 1889, and they had just made a breakthrough that would change medicine forever. From the wound of a surgical patient, they had isolated the deadly Clostridium tetani - the bacterium causing tetanus - growing it successfully without oxygen. When they announced their discovery at the Turin Academy of Medicine, the scientific world took notice."     
''';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkScrollEnd);

    //  Inicializamos controlador y animación
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

    //  lanzamos la animación desde 0
    _fadeController.forward(from: 0);

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
    _fadeController.dispose(); //  liberamos memoria
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
                  biographyTextThird,
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
                                const Color.fromARGB(255, 243, 196, 23),
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
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                color: Colors.white.withOpacity(0.5),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                          color: Color.fromARGB(255, 243, 196, 23)),
                      SizedBox(height: 16),
                      Text(
                        "Going to Questions...",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 232, 186, 23),
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
    question:
        "Giuseppina and Dr. Tizzoni discovered that tetanus bacteria can grow without oxygen.\n\nWhat will most likely happen next?",
    options: [
      "A) The discovery will be kept secret and forgotten",
      "B) The bacteria will stop existing altogether",
      "C) People will ignore the danger of tetanus",
      "D) Scientists will develop new ways to fight tetanus"
    ],
    correctIndex: 3,
    explanation:
        " Finding out how the bacteria survives helps researchers create treatments or vaccines, not ignore it.",
    incorrectExplanations: [
      "No, scientific discoveries like this are usually shared and built upon, not forgotten.",
      "Incorrect. Discovering something about bacteria doesn’t make it disappear.",
      "No, learning about the danger leads to prevention, not ignorance.",
      "Correct answer! This type of research leads to developing new methods to fight diseases like tetanus."
    ],
  ),
  QuestionData(
    question:
        "Giuseppina spent long nights testing how cholera spread in different conditions.\n\nWhat will probably happen next?",
    options: [
      "A) She and Dr. Tizzoni will publish results",
      "B) She will abandon medicine completely",
      "C) They will decide cholera is not dangerous",
      "D) The city will forbid their experiments"
    ],
    correctIndex: 0,
    explanation:
        " Careful research into a deadly disease usually produces knowledge that helps future prevention.",
    incorrectExplanations: [
      "Correct answer! Publishing results is the natural next step after scientific experiments.",
      "No, her dedication to research shows she won’t give up medicine.",
      "Incorrect. Cholera was known to be dangerous, and their goal was to understand it better.",
      "No, there’s no sign that authorities would stop their scientific work."
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

  // Paleta: ámbar cálido + crema + terracota suave
  static const Color accentDark = Color(0xFFFF8F00); // ámbar oscuro
  static const Color cardBg = Color(0xFFFFFDE7); // crema casi blanco

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
          // Fondo degradado
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFE082), // amarillo suave
                  Color(0xFF80CBC4), // aquamarina elegante
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
                            color: const Color(0xFFF3C417), width: 1.5),
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
                                  ? const Color(0xFFF3C417)
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
                            backgroundColor: Color(0xFFF3C417),
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
                              color: Color.fromARGB(255, 0, 0, 0),
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

class _BiographyReadingPageFinalState extends State<BiographyReadingPageFinal>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool showButton = false;
  bool animating = false;

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  final String biographyTextSecond = '''
"But discovery was only the beginning. By 1890, their research had advanced further than anyone anticipated. While Danish doctor Knud Faber published similar findings about the tetanus toxin, and German scientists von Behring and Kitasato worked with rabbits, Giuseppina and her team were already steps ahead. That January, in the hallowed halls of Bologna's Academy of Sciences, they demonstrated something remarkable - an immune serum against tetanus, developed from dogs and birds, proven effective both in test tubes and living creatures.

What happened next would save countless lives. While others still speculated about human applications, Giuseppina's serum was already being used on tetanus patients in Bologna. Historical records suggest their serum might have been the only one actually treating people during those critical early years. All their meticulous work - documented with photographic plates and microscopic images in their German publication ""Bakteriologische Untersuchungen über den Tetanus"" - laid the foundation for what would become standard treatment."        
''';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkScrollEnd);

    //  Inicializamos controlador y animación
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

    //  lanzamos animación
    _fadeController.forward(from: 0);

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
    _fadeController.dispose(); //  liberamos memoria
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
                                const Color.fromARGB(255, 243, 196, 23),
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
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                color: Colors.white.withOpacity(0.5),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                          color: Color.fromARGB(255, 243, 196, 23)),
                      SizedBox(height: 16),
                      Text(
                        "Going to Questions...",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 232, 186, 23),
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
        "While German scientists were still experimenting, Giuseppina’s serum was already being applied in Bologna.\n\nWhat is most likely to follow?",
    options: [
      "A) The patients will refuse the treatment",
      "B) Her patients will benefit earlier than in other places",
      "C) The serum will disappear without impact",
      "D) Doctors will decide tetanus cures aren’t important"
    ],
    correctIndex: 1,
    explanation:
        " Since her serum was already in use, Bologna would see positive effects before other regions caught up.",
    incorrectExplanations: [
      "No, there’s no reason to believe patients would refuse the treatment.",
      "Correct answer! Early application means Bologna’s patients would benefit sooner.",
      "Incorrect. The serum’s early use indicates it had a meaningful effect.",
      "No, doctors valued tetanus treatments highly because of their life-saving potential."
    ],
  ),
  QuestionData(
    question:
        "Her serum might have been the only one used on patients during the early years.\n\nWhat will most likely happen next?",
    options: [
      "A) Giuseppina’s team will gain recognition for pioneering treatment",
      "B) People will deny that tetanus exists",
      "C) The serum will immediately cure every disease in the whole world",
      "D) Doctors will stop treating patients"
    ],
    correctIndex: 0,
    explanation:
        " Being the first to apply an effective treatment usually brings recognition and influence in medical history.",
    incorrectExplanations: [
      "Correct answer! Her early success would earn her team acknowledgment and respect.",
      "No, tetanus was a well-known and dangerous disease at the time.",
      "Incorrect. The serum targeted tetanus, not all diseases.",
      "No, doctors would continue to treat patients using the new serum."
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

  // Paleta: ámbar cálido + crema + terracota suave
  static const Color accentDark = Color(0xFFFF8F00); // ámbar oscuro
  static const Color cardBg = Color(0xFFFFFDE7); // crema casi blanco

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
        MaterialPageRoute(builder: (_) => FinalPath()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      body: Stack(
        children: [
          // Fondo degradado
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFE082), // amarillo suave
                  Color(0xFF80CBC4), // aquamarina elegante
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
                            color: const Color(0xFFF3C417), width: 1.5),
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
                                  ? const Color(0xFFF3C417)
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
                            backgroundColor: Color(0xFFF3C417),
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
                              color: Color.fromARGB(255, 0, 0, 0),
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
