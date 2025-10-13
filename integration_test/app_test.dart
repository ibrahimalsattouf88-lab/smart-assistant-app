import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:smart_assistant_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Smart Assistant App Integration Tests', () {
    testWidgets('App launches successfully', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify app title is displayed
      expect(find.text('المعاون الذكي'), findsOneWidget);
    });

    testWidgets('Voice assistant button is present', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify voice assistant button exists
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.mic_none), findsOneWidget);
    });

    testWidgets('Voice assistant button toggles on tap', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Tap the voice assistant button
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      // Verify the icon changes to mic (listening state)
      expect(find.byIcon(Icons.mic), findsOneWidget);
    });

    testWidgets('Navigation between sections works', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify initial section (Accounting)
      expect(find.text('🧮 قسم المحاسبة'), findsOneWidget);

      // Navigate to Currency section
      await tester.tap(find.text('العملات والمخاطر'));
      await tester.pumpAndSettle();
      expect(find.text('💱 العملات وإدارة المخاطر'), findsOneWidget);

      // Navigate to Personal Assistant section
      await tester.tap(find.text('المساعد الشخصي'));
      await tester.pumpAndSettle();
      expect(find.text('👨‍💼 المساعد الشخصي'), findsOneWidget);

      // Navigate to Tips section
      await tester.tap(find.text('النصائح'));
      await tester.pumpAndSettle();
      expect(find.text('💡 النصائح'), findsOneWidget);
    });

    testWidgets('Accounting section displays total fund card', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify total fund card is displayed
      expect(find.text('الصندوق الكلي'), findsOneWidget);
      expect(find.text('125,450.00 ر.س'), findsOneWidget);
      expect(find.text('شخصي'), findsOneWidget);
      expect(find.text('تجاري'), findsOneWidget);
    });

    testWidgets('Currency section displays converter', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to Currency section
      await tester.tap(find.text('العملات والمخاطر'));
      await tester.pumpAndSettle();

      // Verify currency converter is displayed
      expect(find.text('محول العملات'), findsOneWidget);
      expect(find.text('أسعار العملات'), findsOneWidget);
    });

    testWidgets('Personal Assistant section displays specialization selector', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to Personal Assistant section
      await tester.tap(find.text('المساعد الشخصي'));
      await tester.pumpAndSettle();

      // Verify specialization selector is displayed
      expect(find.text('اختر تخصصك'), findsOneWidget);
    });

    testWidgets('Tips section displays tips list', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to Tips section
      await tester.tap(find.text('النصائح'));
      await tester.pumpAndSettle();

      // Verify tips are displayed
      expect(find.textContaining('نصيحة'), findsWidgets);
    });

    testWidgets('Settings button is present', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify settings button exists
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
    });
  });
}

