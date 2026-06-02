import 'package:flutter_test/flutter_test.dart';
import 'package:fpersonasset/main.dart';

void main() {
  testWidgets('App renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const JuCaiApp());
    expect(find.text('聚财'), findsWidgets);
  });
}
