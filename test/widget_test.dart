import 'package:flutter_test/flutter_test.dart';
import 'package:sustaenofest/main.dart';

void main() {
  testWidgets('App smoke test - verifies splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const SustaenofestApp());
    expect(find.text('Mulai'), findsOneWidget);
  });
}
