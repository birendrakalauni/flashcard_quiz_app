import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'providers/flashcard_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize database for Windows/Linux/macOS
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MyApp()); //It loads the MyApp widget.
}

class MyApp extends StatelessWidget {
  //This is the root widget of the application.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //This creates the UI of the app.
    return ChangeNotifierProvider(
      //It allows every screen to access flashcard data.
      create: (_) => FlashcardProvider()..loadFlashcards(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flashcard Quiz App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen(),
      ),
    );
  }
}
