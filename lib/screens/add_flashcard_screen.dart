import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/flashcard.dart';
import '../providers/flashcard_provider.dart';

class AddFlashcardScreen extends StatefulWidget {
  const AddFlashcardScreen({super.key});

  @override
  State<AddFlashcardScreen> createState() => _AddFlashcardScreenState();
}

class _AddFlashcardScreenState extends State<AddFlashcardScreen> {
  final questionController = TextEditingController();
  final answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FlashcardProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Flashcard')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: questionController,
              decoration: const InputDecoration(
                labelText: 'Question',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: answerController,
              decoration: const InputDecoration(
                labelText: 'Answer',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (questionController.text.isNotEmpty &&
                    answerController.text.isNotEmpty) {
                  await provider.addFlashcard(
                    Flashcard(
                      question: questionController.text,
                      answer: answerController.text,
                    ),
                  );

                  Navigator.pop(context);
                }
              },
              child: const Text('Save Flashcard'),
            ),
          ],
        ),
      ),
    );
  }
}
