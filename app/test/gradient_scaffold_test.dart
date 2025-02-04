import 'package:app/ui/widget_utils/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GradientScaffold Tests', () {

    testWidgets('GradientScaffold contains a Scaffold with AppBar', (WidgetTester tester) async {
      // Créer un widget pour tester
      await tester.pumpWidget(
        MaterialApp(
          home: GradientScaffold(
            child: Container(),
          ),
        ),
      );

      // Vérifier que le Scaffold est présent
      expect(find.byType(Scaffold), findsOneWidget);

      // Vérifier que l'AppBar est présent et a une couleur de fond transparente
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.backgroundColor, Colors.transparent);
    });

    testWidgets('GradientScaffold passes the child widget to the Scaffold body', (WidgetTester tester) async {
      // Créer un widget enfant pour tester
      const testChild = Text('Test Child');

      // Créer le widget GradientScaffold avec un enfant
      await tester.pumpWidget(
        const MaterialApp(
          home: GradientScaffold(
            child: testChild,
          ),
        ),
      );

      // Vérifier que l'enfant est bien présent dans le body du Scaffold
      expect(find.text('Test Child'), findsOneWidget);
    });
  });
}
