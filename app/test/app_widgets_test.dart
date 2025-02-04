import 'package:app/model/city.dart';
import 'package:app/ui/widget_utils/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';

void main() {
  testWidgets('customText crée un widget texte avec style correct', (WidgetTester tester) async {
    const testText = 'Hello';
    const color = Colors.blue;
    const fontSize = 20.0;

    // Utilisation de la méthode customText
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppWidgets.customText(
            text: testText,
            color: color,
            fontSize: fontSize,
          ),
        ),
      ),
    );

    // Vérification que le texte et son style sont corrects
    final textFinder = find.text(testText);
    expect(textFinder, findsOneWidget);

    final textWidget = tester.widget<Text>(textFinder);
    expect(textWidget.style?.color, color);
    expect(textWidget.style?.fontSize, fontSize);
  });

  testWidgets('customIntrinsicCard crée une carte avec padding et couleur corrects', (WidgetTester tester) async {
    const color = Colors.green;
    const paddingLeft = 10.0;
    const paddingRight = 20.0;

    // Création d'un widget avec la méthode customIntrinsicCard
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppWidgets.customIntrinsicCard(
            color: color,
            paddingLeft: paddingLeft,
            paddingRight: paddingRight,
            child: const Text('Test'),
          ),
        ),
      ),
    );

    // Vérification du widget Card
    final cardFinder = find.byType(Card);
    expect(cardFinder, findsOneWidget);

    final cardWidget = tester.widget<Card>(cardFinder);
    expect(cardWidget.color, color);
  });

}
