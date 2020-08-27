import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clean_study/ui/pages/pages.dart';

void main() {
  Future<void> loadPage(WidgetTester tester) async {
    final loginPage = MaterialApp(home: LoginPage());
    await tester.pumpWidget(loginPage);
  }

  testWidgets(
    'Should load with correct initial state',
    (WidgetTester tester) async {
      await loadPage(tester);

      final emailTextchildren = find.descendant(
        of: find.bySemanticsLabel('Email'),
        matching: find.byType(Text),
      );

      expect(
        emailTextchildren,
        findsOneWidget,
        reason:
            'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the label',
      );

      final passwordTextchildren = find.descendant(
        of: find.bySemanticsLabel('Senha'),
        matching: find.byType(Text),
      );

      expect(
        passwordTextchildren,
        findsOneWidget,
        reason:
            'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the label',
      );

      final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
      expect(button.onPressed, null);
    },
  );
}
