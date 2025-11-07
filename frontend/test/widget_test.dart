import 'package:ai_translator/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Translator app renders home page', (tester) async {
    await tester.pumpWidget(const AiTranslatorApp());

    expect(find.text('AI Translator (mock)'), findsOneWidget);
    expect(find.text('Traduire'), findsOneWidget);
  });
}
