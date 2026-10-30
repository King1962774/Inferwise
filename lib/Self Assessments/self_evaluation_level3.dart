import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ─────────────────────────────────────────────────────────────────────────────
// LEVEL 3 — DARK BLUE (#1565C0 / #1E88E5)
// Banner key:  completedCheckpoint3  →  selfEvalDone3
// Firestore collection: selfEvaluations  (field level: 3)
// ─────────────────────────────────────────────────────────────────────────────

class QuizCompletedBannerLevel3 extends StatefulWidget {
  const QuizCompletedBannerLevel3({super.key});

  @override
  State<QuizCompletedBannerLevel3> createState() =>
      _QuizCompletedBannerLevel3State();
}

class _QuizCompletedBannerLevel3State
    extends State<QuizCompletedBannerLevel3>
    with SingleTickerProviderStateMixin {
  bool _showBanner = false;
  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;


  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _fadeAnim =
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, -0.25),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutBack));
    _checkShouldShow();
  }

  Future<void> _checkShouldShow() async {
    final prefs = await SharedPreferences.getInstance();
    final quizDone = prefs.getBool('completedCheckpoint3') ?? false;
    final evalDone = prefs.getBool('selfEvalDone3') ?? false;
    if (quizDone && !evalDone && mounted) {
      setState(() => _showBanner = true);
      _animCtrl.forward();
    }
  }

  void _goToEvaluation() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, anim, __) => const SelfEvaluationPageLevel3(),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    ).then((_) {
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
          child: _BannerCardL3(onTap: _goToEvaluation),
        ),
      ),
    );
  }
}

class _BannerCardL3 extends StatefulWidget {
  final VoidCallback onTap;
  const _BannerCardL3({required this.onTap});

  @override
  State<_BannerCardL3> createState() => _BannerCardL3State();
}

class _BannerCardL3State extends State<_BannerCardL3>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;
  late Animation<double> _glow;

  static const _accent = Color(0xFF1E88E5);
  static const _accentLight = Color(0xFF90CAF9);

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
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
              color: _accent.withOpacity(0.28),
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
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF080F1A), Color(0xFF0D1F3C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: _accent.withOpacity(0.45), width: 1.2),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: _accent.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: _accent.withOpacity(0.4), width: 1),
                  ),
                  child: const Center(
                      child: Text('🌟', style: TextStyle(fontSize: 26))),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hey, how do you feel? 👋',
                        style: TextStyle(
                          color: _accentLight,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Take a moment and rate yourself with this self-assessment — so we can see what we can improve together.',
                        style: TextStyle(
                          color: _accentLight.withOpacity(0.7),
                          fontSize: 12.5,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _accent.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.arrow_forward_ios_rounded,
                      color: _accentLight, size: 16),
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
//  SELF EVALUATION PAGE — LEVEL 3
// ─────────────────────────────────────────────────────────────────────────────

const List<Map<String, String>> _evalQuestionsL3 = [
  {'emoji': '🔎', 'question': 'I can infer causes from clues.'},
  {'emoji': '🔮', 'question': 'I can predict consequences.'},
  {'emoji': '🌍', 'question': 'I can use real-world knowledge to explain ideas.'},
  {'emoji': '🎭', 'question': "I can identify a character's goal or motive."},
  {'emoji': '📝', 'question': 'I can explain my inferences using the text.'},
];

const List<String> _feedbackL3 = [
  "Inferring causes means reading between the lines. Ask yourself: 'Why did this happen?' and look for clues before and after the event.",
  "Predicting consequences is like thinking one step ahead. Use what you know about characters and situations to imagine what might come next.",
  "Connecting a text to real-world knowledge makes you a stronger reader. Think: 'Does this remind me of something I know or have experienced?'",
  "Characters always want something. Try asking: 'What does this character need, fear, or hope for?' — that's their motive!",
  "Backing up your ideas with text evidence is a key skill. Try finding at least one sentence in the text that supports each inference you make.",
];

class SelfEvaluationPageLevel3 extends StatefulWidget {
  const SelfEvaluationPageLevel3({super.key});

  @override
  State<SelfEvaluationPageLevel3> createState() =>
      _SelfEvaluationPageLevel3State();
}

class _SelfEvaluationPageLevel3State
    extends State<SelfEvaluationPageLevel3> with TickerProviderStateMixin {
  final List<int> _ratings = List.filled(5, 0);
  bool _submitting = false;
  bool _submitted = false;
  bool _showFeedback = false;

  late AnimationController _successCtrl;
  late Animation<double> _successScale;

  static const _accent = Color(0xFF1E88E5);
  static const _accentLight = Color(0xFF90CAF9);
  static const _starColor = Color(0xFF82B1FF);
  static const _bgDeep = Color(0xFF060810);

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
          'level': 3,
          'ratings': {
            'inferCauses': _ratings[0],
            'predictConsequences': _ratings[1],
            'realWorldKnowledge': _ratings[2],
            'characterMotive': _ratings[3],
            'textEvidence': _ratings[4],
          },
          'average':
              _ratings.reduce((a, b) => a + b) / _ratings.length,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }

      await prefs.setBool('selfEvalDone3', true);
      final hasLowRating = _ratings.any((r) => r <= 3);

      setState(() {
        _submitting = false;
        _submitted = true;
        _showFeedback = hasLowRating;
      });
      _successCtrl.forward();

      if (!hasLowRating) {
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) Navigator.pop(context);
      }
    } catch (e) {
      setState(() => _submitting = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error saving. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgDeep,
      body: SafeArea(
        child: _submitted ? _buildSuccess() : _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
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
                      letterSpacing: 0.3),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _accent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: _accent.withOpacity(0.4), width: 1),
                ),
                child: const Text('Level 3',
                    style: TextStyle(
                        color: _accentLight,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'To be honest with yourself is the first step to improving. Rate your experience with the quiz so we can understand how to support you better.',
            style: TextStyle(
                color: _accentLight.withOpacity(0.9),
                fontSize: 13,
                height: 1.5),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
            itemCount: _evalQuestionsL3.length,
            itemBuilder: (context, i) => _QuestionCardL3(
              emoji: _evalQuestionsL3[i]['emoji']!,
              question: _evalQuestionsL3[i]['question']!,
              rating: _ratings[i],
              accent: _accent,
              accentLight: _accentLight,
              starColor: _starColor,
              onRate: (val) => setState(() => _ratings[i] = val),
            ),
          ),
        ),
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
                    colors: [Color(0xFF1565C0), Color(0xFF1E88E5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: _accent.withOpacity(0.4),
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
                              letterSpacing: 0.3),
                        ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccess() {
    final avg = _ratings.reduce((a, b) => a + b) / _ratings.length;
    return SingleChildScrollView(
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
                      color: _accentLight, fontSize: 15, height: 1.6),
                ),
              ],
            ),
          ),
          if (_showFeedback) ...[
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _accent.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border:
                    Border.all(color: _accent.withOpacity(0.3), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '💡 A little help for you',
                    style: TextStyle(
                        color: _accentLight,
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
                  color: _accent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                  border:
                      Border.all(color: _accent.withOpacity(0.4), width: 1),
                ),
                child: const Center(
                  child: Text('Got it, let\'s keep going! 🚀',
                      style: TextStyle(
                          color: _accentLight,
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
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
        items.add(Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_evalQuestionsL3[i]['emoji']!,
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _evalQuestionsL3[i]['question']!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _feedbackL3[i],
                      style: TextStyle(
                          color: _accentLight.withOpacity(0.85),
                          fontSize: 12,
                          height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
      }
    }
    return items;
  }
}

// ─── Question Card ────────────────────────────────────────────────────────────
class _QuestionCardL3 extends StatelessWidget {
  final String emoji, question;
  final int rating;
  final Color accent, accentLight, starColor;
  final ValueChanged<int> onRate;

  const _QuestionCardL3({
    required this.emoji,
    required this.question,
    required this.rating,
    required this.accent,
    required this.accentLight,
    required this.starColor,
    required this.onRate,
  });

  static const _labels = [
    '',
    'Too Low',
    'Low',
    'Regular',
    'Good',
    'Excellent'
  ];

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
              ? accent.withOpacity(0.45)
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
                child: Text(question,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.4)),
              ),
            ],
          ),
          const SizedBox(height: 14),
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
                    filled
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: filled
                        ? starColor
                        : Colors.white.withOpacity(0.25),
                    size: filled ? 36 : 32,
                  ),
                ),
              );
            }),
          ),
          if (rating > 0)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    _labels[rating],
                    key: ValueKey(rating),
                    style: TextStyle(
                        color: accentLight,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
