import 'package:flutter/material.dart';

import 'src/ui/translator_page.dart';

void main() {
  runApp(const AiTranslatorApp());
}

class AiTranslatorApp extends StatelessWidget {
  const AiTranslatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Translator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TranslatorPage(),
    );
  }
}
