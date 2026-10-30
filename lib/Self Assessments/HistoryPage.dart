import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

// ─────────────────────────────────────────────────────────────────────────────
// METADATA POR NIVEL
// ─────────────────────────────────────────────────────────────────────────────

class _LevelMeta {
  final String label;
  final Color accent;
  final Color accentLight;
  final Color bgCard;
  final List<Map<String, String>> questions;
  final List<String> feedback;

  const _LevelMeta({
    required this.label,
    required this.accent,
    required this.accentLight,
    required this.bgCard,
    required this.questions,
    required this.feedback,
  });
}

const _levels = <int, _LevelMeta>{
  1: _LevelMeta(
    label: 'Level 1 · Reference Planet',
    accent: Color(0xFF4CAF50),
    accentLight: Color(0xFFA8E6B0),
    bgCard: Color(0xFF0D2B1A),
    questions: [
      {'emoji': '🎯', 'question': 'I can identify pronouns.'},
      {'emoji': '🎯', 'question': 'I can find what a pronoun refers to.'},
      {'emoji': '🎯', 'question': 'I can use context clues to decide meaning.'},
      {
        'emoji': '🎯',
        'question': 'I can link different words to the same idea.'
      },
      {'emoji': '🎯', 'question': 'I can explain my answers using the text.'},
    ],
    feedback: [
      "Pronouns replace nouns to avoid repetition. Try underlining every 'he', 'she', 'it', 'they' you find in a paragraph and ask yourself what noun each one replaces.",
      "To find what a pronoun refers to, look at the sentence just before it — the answer is almost always there. Practice by drawing an arrow from the pronoun back to its noun.",
      "Context clues are the words around an unknown word that hint at its meaning. Try reading the full sentence and the one before/after before making your guess.",
      "Words like 'the researcher… the scientist… she…' all refer to the same person. Highlight chains of words that point to the same idea in any text you read.",
      "Supporting your answer with the text means quoting or paraphrasing a specific part. Practice by adding 'because the text says…' to every answer you give.",
    ],
  ),
  2: _LevelMeta(
    label: 'Level 2 · Lexical Moon',
    accent: Color(0xFF00BFA5),
    accentLight: Color(0xFF80CBC4),
    bgCard: Color(0xFF0A1F1C),
    questions: [
      {'emoji': '🔤', 'question': 'I can recognize cognates.'},
      {'emoji': '🧩', 'question': 'I can use prefixes to understand words.'},
      {'emoji': '🔧', 'question': 'I can use suffixes to understand words.'},
      {'emoji': '🔍', 'question': 'I can use context clues to guess meaning.'},
      {
        'emoji': '💬',
        'question': "I can explain how I found a word's meaning."
      },
    ],
    feedback: [
      "Cognates are words that look similar across languages and share meaning — like 'animal' or 'information'. Try spotting them in texts you read!",
      "Prefixes like un-, re-, or pre- change a word's meaning. Practice breaking words apart to see what each piece adds.",
      "Suffixes like -tion, -ly, or -ful signal a word's role. Noticing them helps you decode new words faster.",
      "Context clues are hints around an unfamiliar word. Try reading the whole sentence before guessing — the answer is usually right there!",
      "Being able to explain your thinking shows real understanding. Try writing one sentence about how you figured out a word's meaning.",
    ],
  ),
  3: _LevelMeta(
    label: 'Level 3 · Explanation Sun',
    accent: Color(0xFF1E88E5),
    accentLight: Color(0xFF90CAF9),
    bgCard: Color(0xFF071428),
    questions: [
      {'emoji': '🔎', 'question': 'I can infer causes from clues.'},
      {'emoji': '🔮', 'question': 'I can predict consequences.'},
      {
        'emoji': '🌍',
        'question': 'I can use real-world knowledge to explain ideas.'
      },
      {
        'emoji': '🎭',
        'question': "I can identify a character's goal or motive."
      },
      {
        'emoji': '📝',
        'question': 'I can explain my inferences using the text.'
      },
    ],
    feedback: [
      "Inferring causes means reading between the lines. Ask yourself: 'Why did this happen?' and look for clues before and after the event.",
      "Predicting consequences is like thinking one step ahead. Use what you know about characters and situations to imagine what might come next.",
      "Connecting a text to real-world knowledge makes you a stronger reader. Think: 'Does this remind me of something I know or have experienced?'",
      "Characters always want something. Try asking: 'What does this character need, fear, or hope for?' — that's their motive!",
      "Backing up your ideas with text evidence is a key skill. Try finding at least one sentence in the text that supports each inference you make.",
    ],
  ),
  4: _LevelMeta(
    label: 'Level 4 · Constellation of Ideas',
    accent: Color(0xFFFF8C28),
    accentLight: Color(0xFFFFCC80),
    bgCard: Color(0xFF1A0F00),
    questions: [
      {'emoji': '🔧', 'question': 'I can infer tools or methods used.'},
      {'emoji': '📍', 'question': 'I can infer where something happens.'},
      {'emoji': '⏰', 'question': 'I can infer when something happens.'},
      {
        'emoji': '👤',
        'question': 'I can infer who is responsible for an action.'
      },
      {'emoji': '🤝', 'question': 'I can infer relationships between people.'},
    ],
    feedback: [
      "Inferring tools or methods means reading action words carefully. What verbs or objects in the text hint at how something was done?",
      "To figure out where, look for setting details: weather, sounds, objects, or descriptions that point to a specific place or type of environment.",
      "Time clues can be subtle — seasons, light levels, historical references, or sequences of events all help you figure out when something takes place.",
      "Think about who has the skills, access, or motive for an action. The text may not say directly, but the clues are often right there.",
      "Look at how characters speak to each other, what they know, and how they react. These details reveal whether people are friends, rivals, family, or strangers.",
    ],
  ),
  5: _LevelMeta(
    label: 'Level 5 · Galaxy of Predictions',
    accent: Color(0xFFAD3CFE),
    accentLight: Color(0xFFE1BEF8),
    bgCard: Color(0xFF110A1F),
    questions: [
      {'emoji': '📖', 'question': 'I can use titles to predict events.'},
      {'emoji': '🧍', 'question': 'I can use characters to make predictions.'},
      {'emoji': '🎭', 'question': 'I can use genre to predict outcomes.'},
      {'emoji': '⚡', 'question': 'I can predict outcomes from actions.'},
      {'emoji': '🔍', 'question': 'I can explain my predictions using clues.'},
    ],
    feedback: [
      "Titles often hint at the main theme or turning point. Before you read, ask yourself: what story does this title promise? What might happen?",
      "Characters give away a lot — their personality, decisions, and past behavior are clues. Ask: what would this character do in a tough situation?",
      "Every genre has patterns. In mysteries, problems get solved. In tragedies, things go wrong. Knowing the genre helps you predict the ending before it comes.",
      "Actions have consequences. When a character does something bold, risky, or kind, think about what that might set in motion later in the story.",
      "Strong predictions aren't guesses — they're supported by evidence. Practice picking one clue from the text that backs up each prediction you make.",
    ],
  ),
};

// ─────────────────────────────────────────────────────────────────────────────
// PANTALLA PRINCIPAL
// ─────────────────────────────────────────────────────────────────────────────

class SelfEvaluationsHistoryPage extends StatefulWidget {
  const SelfEvaluationsHistoryPage({super.key});

  @override
  State<SelfEvaluationsHistoryPage> createState() =>
      _SelfEvaluationsHistoryPageState();
}

class _SelfEvaluationsHistoryPageState
    extends State<SelfEvaluationsHistoryPage> {
  List<Map<String, dynamic>> _evals = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchEvaluations();
  }

  Future<void> _fetchEvaluations() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        setState(() {
          _error = 'You must be logged in to view your evaluations.';
          _loading = false;
        });
        return;
      }

      final snapshot = await FirebaseFirestore.instance
          .collection('selfEvaluations')
          .where('userId', isEqualTo: user.uid)
          // .orderBy('timestamp', descending: true)
          .get();

      final evals = snapshot.docs.map((doc) {
        return {...doc.data(), 'id': doc.id};
      }).toList();

// Ordena en memoria mientras el índice se crea
      evals.sort((a, b) {
        final ta = (a['timestamp'] as Timestamp?)?.millisecondsSinceEpoch ?? 0;
        final tb = (b['timestamp'] as Timestamp?)?.millisecondsSinceEpoch ?? 0;
        return tb.compareTo(ta);
      });

      setState(() {
        _evals = evals;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error loading evaluations. Please try again.';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060A0F),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: Colors.white.withOpacity(0.12), width: 1),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white70, size: 18),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Self-Assessments',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
                Text(
                  'Your progress across all levels',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Color(0xFF4CAF50)),
            SizedBox(height: 16),
            Text('Loading your assessments...',
                style: TextStyle(color: Colors.white54, fontSize: 14)),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('⚠️', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 16),
              Text(_error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white54, fontSize: 14)),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _loading = true;
                    _error = null;
                  });
                  _fetchEvaluations();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: const Color(0xFF4CAF50).withOpacity(0.4)),
                  ),
                  child: const Text('Try again',
                      style: TextStyle(
                          color: Color(0xFFA8E6B0),
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_evals.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('🌱', style: TextStyle(fontSize: 64)),
              SizedBox(height: 20),
              Text(
                'No assessments yet',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10),
              Text(
                'Complete a quiz level and submit your self-assessment to see it here.',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white38, fontSize: 13, height: 1.5),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      color: const Color(0xFF4CAF50),
      backgroundColor: const Color(0xFF1A1A1A),
      onRefresh: _fetchEvaluations,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        physics: const BouncingScrollPhysics(),
        itemCount: _evals.length,
        itemBuilder: (context, i) => _EvalCard(evalData: _evals[i]),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CARD DE EVALUACIÓN
// ─────────────────────────────────────────────────────────────────────────────

class _EvalCard extends StatefulWidget {
  final Map<String, dynamic> evalData;
  const _EvalCard({required this.evalData});

  @override
  State<_EvalCard> createState() => _EvalCardState();
}

class _EvalCardState extends State<_EvalCard>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _ctrl;
  late Animation<double> _expandAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    _expandAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
    _expanded ? _ctrl.forward() : _ctrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.evalData;
    final int level = (data['level'] as num?)?.toInt() ?? 1;
    final meta = _levels[level] ?? _levels[1]!;
    final double avg = (data['average'] as num?)?.toDouble() ?? 0;
    final Timestamp? ts = data['timestamp'] as Timestamp?;
    final String dateStr = ts != null
        ? DateFormat('MMM d, yyyy · h:mm a').format(ts.toDate())
        : 'Date unknown';

    // Extraer ratings del mapa de Firestore
    final ratingsMap = data['ratings'] as Map<String, dynamic>? ?? {};
    final List<int> ratings =
        ratingsMap.values.map((v) => (v as num).toInt()).toList();

    return GestureDetector(
      onTap: _toggle,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: meta.bgCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: meta.accent.withOpacity(0.3), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: meta.accent.withOpacity(0.1),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // ── Header de la card ──
            Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  // Nivel badge
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: meta.accent.withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: meta.accent.withOpacity(0.4), width: 1),
                    ),
                    child: Center(
                      child: Text(
                        '$level',
                        style: TextStyle(
                          color: meta.accentLight,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meta.label,
                          style: TextStyle(
                            color: meta.accentLight,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            _StarRow(avg: avg, color: meta.accent),
                            const SizedBox(width: 8),
                            Text(
                              avg.toStringAsFixed(1),
                              style: TextStyle(
                                color: meta.accentLight,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          dateStr,
                          style: const TextStyle(
                              color: Colors.white38, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 350),
                    child: Icon(Icons.keyboard_arrow_down_rounded,
                        color: meta.accentLight, size: 24),
                  ),
                ],
              ),
            ),

            // ── Contenido expandible ──
            SizeTransition(
              sizeFactor: _expandAnim,
              child: Column(
                children: [
                  Container(
                    height: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 18),
                    color: meta.accent.withOpacity(0.2),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Rating por pregunta
                        Text(
                          'Rating per question',
                          style: TextStyle(
                            color: meta.accentLight,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...List.generate(
                          meta.questions.length,
                          (i) => i < ratings.length
                              ? _QuestionRow(
                                  emoji: meta.questions[i]['emoji']!,
                                  question: meta.questions[i]['question']!,
                                  rating: ratings[i],
                                  accent: meta.accent,
                                  accentLight: meta.accentLight,
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),

                  // Panel de recomendaciones (solo si hay rating ≤ 3)
                  if (ratings.any((r) => r <= 3))
                    _FeedbackPanel(
                      meta: meta,
                      ratings: ratings,
                    ),

                  const SizedBox(height: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// FILA DE PREGUNTA CON ESTRELLAS
// ─────────────────────────────────────────────────────────────────────────────

class _QuestionRow extends StatelessWidget {
  final String emoji, question;
  final int rating;
  final Color accent, accentLight;

  const _QuestionRow({
    required this.emoji,
    required this.question,
    required this.rating,
    required this.accent,
    required this.accentLight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              question,
              style: const TextStyle(
                  color: Colors.white70, fontSize: 12, height: 1.4),
            ),
          ),
          const SizedBox(width: 8),
          Row(
            children: List.generate(5, (i) {
              final filled = i < rating;
              return Icon(
                filled ? Icons.star_rounded : Icons.star_outline_rounded,
                color: filled ? accent : Colors.white12,
                size: 16,
              );
            }),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: accent.withOpacity(rating <= 3 ? 0.08 : 0.15),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: accent.withOpacity(rating <= 3 ? 0.2 : 0.35),
                  width: 1),
            ),
            child: Text(
              '$rating/5',
              style: TextStyle(
                color: rating <= 3 ? Colors.orange[300] : accentLight,
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PANEL DE RECOMENDACIONES
// ─────────────────────────────────────────────────────────────────────────────

class _FeedbackPanel extends StatelessWidget {
  final _LevelMeta meta;
  final List<int> ratings;

  const _FeedbackPanel({required this.meta, required this.ratings});

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[];
    for (int i = 0; i < ratings.length; i++) {
      if (ratings[i] <= 3 && i < meta.questions.length) {
        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(meta.questions[i]['emoji']!,
                    style: const TextStyle(fontSize: 17)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meta.questions[i]['question']!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        meta.feedback[i],
                        style: TextStyle(
                            color: meta.accentLight.withOpacity(0.8),
                            fontSize: 11.5,
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

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: meta.accent.withOpacity(0.07),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: meta.accent.withOpacity(0.25), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('💡', style: TextStyle(fontSize: 15)),
                const SizedBox(width: 8),
                Text(
                  'Areas to improve',
                  style: TextStyle(
                    color: meta.accentLight,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items,
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MINI FILA DE ESTRELLAS (para el header de la card)
// ─────────────────────────────────────────────────────────────────────────────

class _StarRow extends StatelessWidget {
  final double avg;
  final Color color;

  const _StarRow({required this.avg, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (i) {
        if (avg >= i + 1) {
          return Icon(Icons.star_rounded, color: color, size: 14);
        } else if (avg > i) {
          return Icon(Icons.star_half_rounded, color: color, size: 14);
        } else {
          return Icon(Icons.star_outline_rounded,
              color: color.withOpacity(0.3), size: 14);
        }
      }),
    );
  }
}
