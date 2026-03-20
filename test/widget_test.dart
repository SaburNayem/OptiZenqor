import 'package:flutter_test/flutter_test.dart';
import 'package:optizenqor/app.dart';

void main() {
  testWidgets('renders splash then home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const OptiZenqor());

    expect(find.text('OptiZenqor'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Welcome to OptiZenqor'), findsOneWidget);
    expect(find.text('Today Plan'), findsOneWidget);
    expect(find.text('Habit Track'), findsOneWidget);
    expect(find.text('Energy Check'), findsOneWidget);
  });
}
