import 'package:flutter/material.dart';

import '../models/flashcard.dart';
import '../widgets/flashcard_widget.dart';

class FlashcardScreen extends StatefulWidget {
  final List<Flashcard> flashcards;
  final int initialIndex;

  const FlashcardScreen({
    super.key,
    required this.flashcards,
    required this.initialIndex,
  });

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  void nextCard() {
    if (currentIndex < widget.flashcards.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void previousCard() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final flashcard = widget.flashcards[currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Study Flashcards')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlashcardWidget(flashcard: flashcard),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: currentIndex == 0 ? null : previousCard,
                  child: const Text('Previous'),
                ),

                Text(
                  '${currentIndex + 1}/${widget.flashcards.length}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                ElevatedButton(
                  onPressed: currentIndex == widget.flashcards.length - 1
                      ? null
                      : nextCard,
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
