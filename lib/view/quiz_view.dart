import 'package:flutter/material.dart';
import '../models/quiz_question.dart';
import '../presenter/quiz_presenter.dart'; // note: singular 'presenter'
import 'completion_view.dart';

class QuizView extends StatefulWidget {
  static const route = '/quiz';
  const QuizView({super.key});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  late QuizPresenter presenter;
  List<String> chat = []; // index 0 = Stranger line, index 1 = Your reply

  // Flash feedback overlay
  Color? _flashColor;
  bool _showFlash = false;

  @override
  void initState() {
    super.initState();
    presenter = QuizPresenter(const [
      QuizQuestion(
        prompt:
            "Hey! I'm new in the game. What's your real name and what school do you go to?",
        options: [
          "It's fine, here's my name and school.",
          "I'll ask my friend first.",
          "I don’t share that. Blocking/reporting.",
        ],
        correctIndex: 2,
      ),
      QuizQuestion(
        prompt: "You receive a link for a 'free prize.' What is the safest action?",
        options: [
          "Click it—free stuff!",
          "Ignore it; it could be a scam or virus.",
          "Share it with classmates to check.",
        ],
        correctIndex: 1,
      ),
      QuizQuestion(
        prompt: "Your password should be:",
        options: [
          "Short and easy to remember, like 'cat123'.",
          "Long and unique, with letters, numbers, and symbols.",
          "The same for every account so it’s easy.",
        ],
        correctIndex: 1,
      ),
    ]);
    _resetChat();
  }

  void _resetChat() {
    chat = [presenter.currentQuestion.prompt]; // Stranger’s first message
  }

  // Ensure only one reply bubble (replace if they change their mind)
  void _select(int index) {
    setState(() {
      final reply = presenter.currentQuestion.options[index];

      if (presenter.hasSelected) {
        if (chat.length > 1) {
          chat[1] = reply; // replace prior reply
        } else {
          chat.add(reply);
        }
      } else {
        chat.add(reply); // first reply
      }

      presenter.selectAnswer(index);
    });
  }

  Future<void> _next() async {
    if (!presenter.hasSelected) return;

    final isCorrect =
        presenter.currentQuestion.correctIndex == presenter.selectedIndex;

    // 1) Flash feedback
    setState(() {
      _flashColor = isCorrect ? Colors.greenAccent : Colors.redAccent;
      _showFlash = true;
    });
    await Future.delayed(const Duration(milliseconds: 350));
    if (!mounted) return;
    setState(() => _showFlash = false);

    // 2) Apply score
    presenter.commitAnswer();

    // 3) Move on
    if (presenter.nextQuestion()) {
      setState(_resetChat);
    } else {
      await presenter.saveProgress();
      if (!mounted) return;
      Navigator.pushReplacementNamed(
        context,
        CompletionView.route,
        arguments: CompletionArgs(
          score: presenter.score,
          total: presenter.total,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = presenter.currentQuestion;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Safe Chat Simulator',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
        ),
      ),
      body: Stack(
        children: [
          // Main content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Push stranger bubble a bit lower from the AppBar
                const SizedBox(height: 24),
                // Question progress text
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Question ${presenter.current + 1} of ${presenter.total}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // CHAT AREA
                Expanded(
                  flex: 2,
                  child: ListView.separated(
                    itemCount: chat.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, i) {
                      final fromUser = i > 0; // first bubble is Stranger
                      return Row(
                        mainAxisAlignment: fromUser
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!fromUser)
                            const CircleAvatar(
                              radius: 18,
                              child: Text("👤", style: TextStyle(fontSize: 20)),
                            ),
                          if (!fromUser) const SizedBox(width: 8),

                          // Animated chat bubble (slide + fade with small delay)
                          Flexible(
                            child: ChatBubbleAnimated(
                              text: chat[i],
                              fromUser: fromUser,
                              delayMs: 60 * i, // tiny stagger per bubble
                            ),
                          ),

                          if (fromUser) const SizedBox(width: 8),
                          if (fromUser)
                            const CircleAvatar(
                              radius: 18,
                              child: Text("🙂", style: TextStyle(fontSize: 20)),
                            ),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // OPTIONS + NEXT (evenly spaced & bigger)
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...List.generate(
                        q.options.length,
                        (i) => SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _select(i),
                            style: ElevatedButton.styleFrom(
                              alignment: Alignment.center, // keep text centered
                              padding:
                                  const EdgeInsets.symmetric(vertical: 18),
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              backgroundColor:
                                  const Color(0xFFEFF7F0), // soft mint
                              foregroundColor:
                                  const Color(0xFF1F4D2E), // dark green text
                              elevation: 0,
                            ),
                            child: Text(
                              q.options[i],
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: presenter.hasSelected ? _next : null,
                          style: FilledButton.styleFrom(
                            padding:
                                const EdgeInsets.symmetric(vertical: 20),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: Text(
                            presenter.current == presenter.total - 1
                                ? 'Finish'
                                : 'Next',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Flash overlay (green/red)
          if (_flashColor != null)
            AnimatedOpacity(
              opacity: _showFlash ? 0.45 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: IgnorePointer(
                ignoring: true, // don't block touches
                child: Container(
                  color: _flashColor,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/* ---------- Reusable animated chat bubble with gradients ---------- */

class ChatBubbleAnimated extends StatefulWidget {
  final String text;
  final bool fromUser;
  final int delayMs;

  const ChatBubbleAnimated({
    super.key,
    required this.text,
    required this.fromUser,
    this.delayMs = 0,
  });

  @override
  State<ChatBubbleAnimated> createState() => _ChatBubbleAnimatedState();
}

class _ChatBubbleAnimatedState extends State<ChatBubbleAnimated>
    with SingleTickerProviderStateMixin {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    // Staggered reveal
    Future.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final fromUser = widget.fromUser;

    // Gradients (user = blue, stranger = tinted green)
    final gradient = fromUser
        ? const LinearGradient(
            colors: [Color(0xFF64B6F7), Color(0xFF4285F4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : const LinearGradient(
            colors: [Color(0xFFBDEEC9), Color(0xFF8CD19D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );

    final radius = BorderRadius.only(
      topLeft: const Radius.circular(18),
      topRight: const Radius.circular(18),
      bottomLeft: Radius.circular(fromUser ? 18 : 6),
      bottomRight: Radius.circular(fromUser ? 6 : 18),
    );

    final slideOffset =
        fromUser ? const Offset(0.08, 0) : const Offset(-0.08, 0);

    return AnimatedSlide(
      offset: _visible ? Offset.zero : slideOffset,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          constraints: const BoxConstraints(maxWidth: 320),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: radius,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
          ),
        ),
      ),
    );
  }
}
