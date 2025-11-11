// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:postos_locais/main.dart';
import 'package:postos_locais/repositories/postos_repository.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      Provider<PostosRepository>(
        create: (_) => PostosRepository(),
        child: const App(),
      ),
    );

    // Verify that the app title is present.
    expect(find.text('Postos Locais'), findsOneWidget);
  });
}
