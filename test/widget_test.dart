import 'package:flutter_test/flutter_test.dart';
import 'package:optizenqor/main.dart';

void main() {
  testWidgets('renders OptiZenqor dashboard content', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const OptiZenqorApp());

    expect(find.text('OptiZenqor'), findsOneWidget);
    expect(
      find.textContaining('keeps your goals, habits, and focus sessions'),
      findsOneWidget,
    );
    expect(find.text('Today\'s focus map'), findsOneWidget);
    expect(find.text('Habit consistency'), findsOneWidget);
    expect(find.text('Daily rhythm'), findsOneWidget);
  });
}
