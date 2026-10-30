import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ─────────────────────────────────────────────────────────────────────────────
// CLAVE que FinalTest ya guarda en SharedPreferences:
//   prefs.setBool('completedCheckpoint1', true)
//
// USO en HomePage (o donde quieras dentro de MainScreen):
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const QuizCompletedBanner(),   // ← añade esta línea
//         // ... resto de tu UI
//       ],
//     );
//   }
// ─────────────────────────────────────────────────────────────────────────────

/// Banner que se muestra automáticamente cuando el quiz fue completado
/// y todavía no se hizo la autoevaluación.
class QuizCompletedBanner extends StatefulWidget {
  const QuizCompletedBanner({super.key});

  @override
  State<QuizCompletedBanner> createState() => _QuizCompletedBannerState();
}

class _QuizCompletedBannerState extends State<QuizCompletedBanner>
    with SingleTickerProviderStateMixin {
  bool _showBanner = false;
  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, -0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutBack));

    _checkShouldShow();
  }

  Future<void> _checkShouldShow() async {
    final prefs = await SharedPreferences.getInstance();
    final quizDone = prefs.getBool('completedCheckpoint1') ?? false;
    final evalDone = prefs.getBool('selfEvalDone') ?? false;

    if (quizDone && !evalDone && mounted) {
      setState(() => _showBanner = true);
      _animCtrl.forward();
    }
  }

  void _goToEvaluation() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, anim, __) => const SelfEvaluationPage(),
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: anim,
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    ).then((_) {
      // Cuando vuelve, vuelve a chequear por si ya completó la eval
      _animCtrl.reset();
      setState(() => _showBanner = false);
      _checkShouldShow();
    });
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_showBanner) return const SizedBox.shrink();

    return SlideTransition(
      position: _slideAnim,
      child: FadeTransition(
        opacity: _fadeAnim,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: _BannerCard(onTap: _goToEvaluation),
        ),
      ),
    );
  }
}

// ─── Card visual ──────────────────────────────────────────────────────────────
class _BannerCard extends StatefulWidget {
  final VoidCallback onTap;
  const _BannerCard({required this.onTap});

  @override
  State<_BannerCard> createState() => _BannerCardState();
}

class _BannerCardState extends State<_BannerCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _pulse =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);
    _glow = Tween<double>(begin: 6, end: 18)
        .animate(CurvedAnimation(parent: _pulse, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glow,
      builder: (_, child) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4CAF50).withOpacity(0.28),
              blurRadius: _glow.value * 1.5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: child,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0D2B1A), Color(0xFF1B4D2E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF4CAF50).withOpacity(0.45),
                width: 1.2,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Emoji/icono
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF4CAF50).withOpacity(0.4),
                      width: 1,
                    ),
                  ),
                  child: const Center(
                    child: Text('🌟', style: TextStyle(fontSize: 26)),
                  ),
                ),
                const SizedBox(width: 16),

                // Texto
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Hey, how do you feel? 👋',
                        style: TextStyle(
                          color: Color(0xFFA8E6B0),
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Rate your ability on each statement. Be honest to see where you can improve.',
                        style: TextStyle(
                          color: Color(0xFF7DB88A),
                          fontSize: 12.5,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // Flecha
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withOpacity(0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(0xFF81C784),
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  FEEDBACK MESSAGES — LEVEL 1
// ─────────────────────────────────────────────────────────────────────────────

const List<String> _feedbackL1 = [
  "Pronouns replace nouns to avoid repetition. Try underlining every 'he', 'she', 'it', 'they' you find in a paragraph and ask yourself what noun each one replaces.",
  "To find what a pronoun refers to, look at the sentence just before it — the answer is almost always there. Practice by drawing an arrow from the pronoun back to its noun.",
  "Context clues are the words around an unknown word that hint at its meaning. Try reading the full sentence and the one before/after before making your guess.",
  "Words like 'the researcher… the scientist… she…' all refer to the same person. Highlight chains of words that point to the same idea in any text you read.",
  "Supporting your answer with the text means quoting or paraphrasing a specific part. Practice by adding 'because the text says…' to every answer you give.",
];

// ─────────────────────────────────────────────────────────────────────────────
//  SELF EVALUATION PAGE🎯
// ─────────────────────────────────────────────────────────────────────────────

const List<Map<String, String>> _evalQuestions = [
  {
    'emoji': '🎯',
    'question': 'I can identify pronouns.',
  },
  {
    'emoji': '🎯',
    'question': 'I can find what a pronoun refers to.',
  },
  {
    'emoji': '🎯',
    'question': 'I can use context clues to decide meaning.',
  },
  {
    'emoji': '🎯',
    'question': 'I can link different words to the same idea.',
  },
  {
    'emoji': '🎯',
    'question': 'I can explain my answers using the text.',
  },
];

class SelfEvaluationPage extends StatefulWidget {
  const SelfEvaluationPage({super.key});

  @override
  State<SelfEvaluationPage> createState() => _SelfEvaluationPageState();
}

class _SelfEvaluationPageState extends State<SelfEvaluationPage>
    with TickerProviderStateMixin {
  final List<int> _ratings = List.filled(5, 0);
  bool _submitting = false;
  bool _submitted = false;
  bool _showFeedback = false;

  late AnimationController _successCtrl;
  late Animation<double> _successScale;

  @override
  void initState() {
    super.initState();
    _successCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _successScale =
        CurvedAnimation(parent: _successCtrl, curve: Curves.elasticOut);
  }

  @override
  void dispose() {
    _successCtrl.dispose();
    super.dispose();
  }

  bool get _allAnswered => _ratings.every((r) => r > 0);

   Future<void> _submit() async {
    if (!_allAnswered || _submitting) return;
    setState(() => _submitting = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      final prefs = await SharedPreferences.getInstance();

      if (user != null) {
        await FirebaseFirestore.instance.collection('selfEvaluations').add({
          'userId': user.uid,
          'level': 1, // ← AÑADIR para identificar el nivel
          'ratings': {
            'comprension': _ratings[0],
            'confianza': _ratings[1],
            'ritmo': _ratings[2],
            'preparacion': _ratings[3],
            'desempeno': _ratings[4],
          },
          'average': _ratings.reduce((a, b) => a + b) / _ratings.length,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }

      await prefs.setBool('selfEvalDone', true);

      final hasLowRating = _ratings.any((r) => r <= 3); // ← AÑADIR

      setState(() {
        _submitting = false;
        _submitted = true;
        _showFeedback = hasLowRating; // ← AÑADIR
      });
      _successCtrl.forward();

      // Solo auto-cierra si no hay ratings bajos
      if (!hasLowRating) { // ← CAMBIAR (antes era siempre)
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) Navigator.pop(context);
      }
    } catch (e) {
      setState(() => _submitting = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al guardar. Intenta de nuevo.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060F08),
      body: SafeArea(
        child: _submitted ? _buildSuccess() : _buildForm(),
      ),
    );
  }

  // ── Formulario ──────────────────────────────────────────────────────────────
  Widget _buildForm() {
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.12), width: 1),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white70, size: 18),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Self-Assessment',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Subtítulo
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'To be honest with yourself is the first step to improving. Rate your experience with the quiz so we can understand how to support you better.',
            style: TextStyle(
              color: const Color(0xFF7DB88A).withOpacity(0.9),
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Questions
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
            itemCount: _evalQuestions.length,
            itemBuilder: (context, i) => _QuestionCard(
              emoji: _evalQuestions[i]['emoji']!,
              question: _evalQuestions[i]['question']!,
              rating: _ratings[i],
              onRate: (val) => setState(() => _ratings[i] = val),
            ),
          ),
        ),

        // Botón submit
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: AnimatedOpacity(
            opacity: _allAnswered ? 1.0 : 0.4,
            duration: const Duration(milliseconds: 300),
            child: GestureDetector(
              onTap: _allAnswered ? _submit : null,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4CAF50).withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: _submitting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5),
                        )
                      : const Text(
                          'Send my assessment ✨',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Pantalla de éxito ───────────────────────────────────────────────────────
 Widget _buildSuccess() {
    final avg = _ratings.reduce((a, b) => a + b) / _ratings.length;
    return SingleChildScrollView( // ← era Center, ahora scroll por si hay mucho feedback
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 16),
          ScaleTransition(
            scale: _successScale,
            child: Column(
              children: [
                const Text('🎉', style: TextStyle(fontSize: 72)),
                const SizedBox(height: 20),
                const Text(
                  'Thanks for your honesty!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 12),
                Text(
                  'Your average was ${avg.toStringAsFixed(1)} / 5.0 ⭐\nWe\'ll use this to improve your experience.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Color(0xFF81C784), fontSize: 15, height: 1.6),
                ),
              ],
            ),
          ),

          // ── Sección de feedback (solo si hay ratings ≤ 3) ──
          if (_showFeedback) ...[
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: const Color(0xFF4CAF50).withOpacity(0.3), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '💡 A little help for you',
                    style: TextStyle(
                        color: Color(0xFFA8E6B0),
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  ..._buildFeedbackItems(),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: const Color(0xFF4CAF50).withOpacity(0.4), width: 1),
                ),
                child: const Center(
                  child: Text(
                    'Got it, let\'s keep going! 🚀',
                    style: TextStyle(
                        color: Color(0xFFA8E6B0),
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildFeedbackItems() {
    final items = <Widget>[];
    for (int i = 0; i < _ratings.length; i++) {
      if (_ratings[i] <= 3) {
        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_evalQuestions[i]['emoji']!,
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _evalQuestions[i]['question']!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _feedbackL1[i],
                        style: TextStyle(
                            color: const Color(0xFF81C784).withOpacity(0.85),
                            fontSize: 12,
                            height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
    return items;
  }
}

// ─── Tarjeta de pregunta con estrellas ────────────────────────────────────────
class _QuestionCard extends StatelessWidget {
  final String emoji;
  final String question;
  final int rating;
  final ValueChanged<int> onRate;

  const _QuestionCard({
    required this.emoji,
    required this.question,
    required this.rating,
    required this.onRate,
  });

  static const _labels = ['', 'Too Low', 'Low', 'Regular', 'Good', 'Excellent'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: rating > 0
              ? const Color(0xFF4CAF50).withOpacity(0.45)
              : Colors.white.withOpacity(0.09),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  question,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Estrellas
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) {
              final filled = i < rating;
              return GestureDetector(
                onTap: () => onRate(i + 1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Icon(
                    filled ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: filled
                        ? const Color(0xFFFFD54F)
                        : Colors.white.withOpacity(0.25),
                    size: filled ? 36 : 32,
                  ),
                ),
              );
            }),
          ),

          // Label de rating
          if (rating > 0)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    _labels[rating],
                    key: ValueKey(rating),
                    style: const TextStyle(
                      color: Color(0xFF81C784),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
