import 'package:flutter/material.dart';
import '../data/progress_store.dart';
import 'completion_page.dart';
import '../main.dart'; 

class QuizQuestion {
  final String prompt;          // what the "Stranger" says
  final List<String> options;   // what "You" can reply with
  final int correctIndex;
  const QuizQuestion({
    required this.prompt,
    required this.options,
    required this.correctIndex,
  });
}

class ChatMessage {
  final String text;
  final bool fromUser; // false = Stranger, true = You
  const ChatMessage({required this.text, required this.fromUser});
}

class QuizPage extends StatefulWidget {
  static const route = '/quiz';
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final questions = const <QuizQuestion>[
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
      prompt: "You won a FREE PRIZE! Click this link now!! 🎁",
      options: [
        "Yay! I’ll click it.",
        "Looks sus—I’ll ignore it.",
        "I’ll send it to my class chat to check.",
      ],
      correctIndex: 1,
    ),
    QuizQuestion(
      prompt: "Create a password for your new account:",
      options: [
        "cat123",
        "Long & unique with symbols!",
        "Same password for all my accounts",
      ],
      correctIndex: 1,
    ),
  ];

  int current = 0;
  int score = 0;
  int? selectedIndex;

  // chat log for the current question
  late List<ChatMessage> chat;

  @override
  void initState() {
    super.initState();
    _resetChatForCurrent();
  }

  void _resetChatForCurrent() {
    chat = [
      ChatMessage(text: questions[current].prompt, fromUser: false),
    ];
    selectedIndex = null;
  }

  void _select(int index) {
    // add user's reply bubble
    setState(() {
      selectedIndex = index;
      chat.add(ChatMessage(text: questions[current].options[index], fromUser: true));
    });
  }

  Future<void> _next() async {
    if (selectedIndex == null) return;
    // scoring
    if (questions[current].correctIndex == selectedIndex) {
      score++;
    }

    // next question or finish
    if (current < questions.length - 1) {
      setState(() {
        current++;
        _resetChatForCurrent();
      });
    } else {
      await ProgressStore.recordQuizRun(score: score, total: questions.length);
      if (!mounted) return;
      Navigator.pushReplacementNamed(
        context,
        CompletionPage.route,
        arguments: CompletionArgs(score: score, total: questions.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final q = questions[current];

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Safe Chat Simulator',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Chat "screen"
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
                  child: Column(
                    children: [
                      // top bar inside chat (avatar + "Stranger")
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: (AppColors.cardWhite).withOpacity(.9),
                            child: const Icon(Icons.person_outline, size: 18),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Stranger',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const Spacer(),
                          Text(
                            "Q ${current + 1}/${questions.length}",
                            style: TextStyle(
                              color: cs.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // chat bubbles
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          final m = chat[i];
                          return _ChatBubble(
                            text: m.text,
                            fromUser: m.fromUser,
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemCount: chat.length,
                      ),

                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              
              if (selectedIndex == null) ...[
                _QuickReplies(
                  options: q.options,
                  onSelect: _select,
                ),
                const SizedBox(height: 14),
              ],

              // Big Next button outside the chat card
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: selectedIndex == null ? null : _next,
                  child: Text(current == questions.length - 1 ? 'Finish' : 'Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _ChatBubble extends StatelessWidget {
  final String text;
  final bool fromUser;
  const _ChatBubble({required this.text, required this.fromUser});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = fromUser ? cs.primaryContainer : Colors.white;
    final on = fromUser ? cs.onPrimaryContainer : Colors.black87;

    final align = fromUser ? Alignment.centerRight : Alignment.centerLeft;
    final radius = BorderRadius.only(
      topLeft: const Radius.circular(18),
      topRight: const Radius.circular(18),
      bottomLeft: Radius.circular(fromUser ? 18 : 4),
      bottomRight: Radius.circular(fromUser ? 4 : 18),
    );

    return Align(
      alignment: align,
      child: Container(
        constraints: const BoxConstraints(minWidth: 60, maxWidth: 520),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: radius,
          border: Border.all(
            color: fromUser ? cs.primary : Colors.black12,
            width: fromUser ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        child: Text(
          text,
          style: TextStyle(
            color: on,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 1.35,
          ),
        ),
      ),
    );
  }
}

class _QuickReplies extends StatelessWidget {
  final List<String> options;
  final void Function(int index) onSelect;
  const _QuickReplies({required this.options, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(options.length, (i) {
        return InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () => onSelect(i),
          child: Ink(
            decoration: BoxDecoration(
              color: cs.tertiaryContainer.withOpacity(.7),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.black12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.send_rounded, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    options[i],
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
