import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/flashcard.dart';

class FlashcardProvider extends ChangeNotifier {
  List<Flashcard> _flashcards = [];

  List<Flashcard> get flashcards => _flashcards;

  Future loadFlashcards() async {
    _flashcards = await DatabaseHelper.instance.getFlashcards();
    print(_flashcards);
    notifyListeners();
  }

  Future addFlashcard(Flashcard flashcard) async {
    await DatabaseHelper.instance.insertFlashcard(flashcard);
    await loadFlashcards();
  }

  Future updateFlashcard(Flashcard flashcard) async {
    await DatabaseHelper.instance.updateFlashcard(flashcard);
    await loadFlashcards();
  }

  Future deleteFlashcard(int id) async {
    await DatabaseHelper.instance.deleteFlashcard(id);
    await loadFlashcards();
  }
}
