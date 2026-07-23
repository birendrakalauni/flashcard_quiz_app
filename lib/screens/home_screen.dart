import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/flashcard_provider.dart';
import 'add_flashcard_screen.dart';
import 'flashcard_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcard Quiz App'),
        centerTitle: true,
      ),

      body: Consumer<FlashcardProvider>(
        builder: (context, provider, child) {
          final flashcards = provider.flashcards;

          // EMPTY STATE
          if (flashcards.isEmpty) {
            return const Center(
              child: Text(
                'No Flashcards Available\nTap + to add one',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          // LIST VIEW
          return ListView.builder(
            itemCount: flashcards.length,
            itemBuilder: (context, index) {
              final flashcard = flashcards[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                elevation: 3,
                child: ListTile(
                  leading: const Icon(Icons.style),
                  title: Text(
                    flashcard.question,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    flashcard.answer,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Open Study Screen
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FlashcardScreen(
                          flashcards: flashcards,
                          initialIndex: index,
                        ),
                      ),
                    );
                  },

                  // DELETE BUTTON
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await provider.deleteFlashcard(flashcard.id!);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Flashcard deleted')),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),

      //  ADD BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddFlashcardScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
