import 'package:flutter_test/flutter_test.dart';
import 'package:optizenqor/app.dart';

void main() {
  testWidgets('renders splash then auth choice screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const OptiZenqor());

    expect(find.text('Shob Bazaar'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Welcome To Shob Bazaar'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);
    expect(find.text('SIgn Up'), findsOneWidget);
  });
}
