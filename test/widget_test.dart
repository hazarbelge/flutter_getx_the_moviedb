import 'package:flutter_getx_the_moviedb/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Movie App Pump Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MovieApp());
  });
}
