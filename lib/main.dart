import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/calculator_screen.dart';
import 'screens/chat_bot_screen.dart';
import 'screens/converter_screen.dart';
import 'screens/video_player_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feature App',
      theme: ThemeData(primarySwatch: Colors.brown),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/calculator': (context) => const CalculatorScreen(),
        '/firebaseChat': (context) => const ChatBotScreen(),
        '/converter': (context) => const ConverterScreen(),
        '/videoPlayer': (context) => const VideoPlayerScreen(),
      },
    );
  }
}

class FirebaseChatScreen {
  const FirebaseChatScreen();
}
