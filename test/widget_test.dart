import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_playground/main.dart';

void main() {
  testWidgets('should render home success', (WidgetTester tester) async {
    await tester.pumpWidget(const Application());
    expect(find.text('Yeaha 🚀'), findsOneWidget);
  });
}
