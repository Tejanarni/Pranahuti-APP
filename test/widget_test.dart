import 'package:flutter_test/flutter_test.dart';
import 'package:innerpeaceguide/main.dart';
// Change to match your actual project name

void main() {
  testWidgets('HomePage UI loads correctly', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(PranahutiApp());

    // Check that the app title is present
    expect(find.text('Pranahuti'), findsOneWidget);

    // Check for the subtitle
    expect(find.text('Divine Practice Companion'), findsOneWidget);

    // Check for the heading
    expect(find.text('Welcome to Your Spiritual Journey'), findsOneWidget);

    // Check for quote
    expect(
      find.text(
        '"The heart is the hub of all sacred places. Go there and roam in it."',
      ),
      findsOneWidget,
    );

    // Check for Today’s Practice
    expect(find.text("Today's Practice"), findsOneWidget);
    expect(find.text('Morning Meditation'), findsOneWidget);
    expect(find.text('Evening Cleaning'), findsOneWidget);
    expect(find.text('9 PM Prayer'), findsOneWidget);

    // Check for Today's Inspiration
    expect(find.text("Today's Inspiration"), findsOneWidget);
    expect(find.text('- Master\'s Teaching'), findsOneWidget);

    // Check for navigation items
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Schedule'), findsOneWidget);
    expect(find.text('Sessions'), findsOneWidget);
    expect(find.text('Progress'), findsOneWidget);
    expect(find.text('Knowledge'), findsOneWidget);
    expect(find.text('Guide'), findsOneWidget);
  });
}
