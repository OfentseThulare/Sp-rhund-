import 'package:flutter_test/flutter_test.dart';
import 'package:spurhund/app.dart';

void main() {
  testWidgets('App builds without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const SpurhundApp());
    expect(find.text('SPÜRHUND'), findsOneWidget);
  });
}
