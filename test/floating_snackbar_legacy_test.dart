import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:floating_snackbar/floating_snackbar.dart';

void main() {
  setUp(() {
    // Reset global theme between tests.
    FloatingSnackBar.theme = const FloatingSnackBarTheme();
  });

  testWidgets('floatingSnackBar renders the message', (tester) async {
    late BuildContext ctx;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(builder: (context) {
            ctx = context;
            return const SizedBox();
          }),
        ),
      ),
    );

    floatingSnackBar(message: 'hello legacy', context: ctx);
    await tester.pump(); // schedule
    await tester.pump(const Duration(milliseconds: 100)); // animate in

    expect(find.text('hello legacy'), findsOneWidget);
  });

  testWidgets('floatingSnackBar honors backgroundColor', (tester) async {
    late BuildContext ctx;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(builder: (context) {
            ctx = context;
            return const SizedBox();
          }),
        ),
      ),
    );

    floatingSnackBar(
      message: 'colored',
      context: ctx,
      backgroundColor: const Color(0xFF123456),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
    expect(snackBar.backgroundColor, const Color(0xFF123456));
    expect(snackBar.behavior, SnackBarBehavior.floating);
  });

  testWidgets('floatingSnackBar replaces the previous snackbar',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => Column(
              children: [
                TextButton(
                  onPressed: () =>
                      floatingSnackBar(message: 'msg-first', context: context),
                  child: const Text('btn-first'),
                ),
                TextButton(
                  onPressed: () =>
                      floatingSnackBar(message: 'msg-second', context: context),
                  child: const Text('btn-second'),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('btn-first'));
    await tester.pump();
    await tester.tap(find.text('btn-second'));
    await tester.pumpAndSettle();

    expect(find.text('msg-first'), findsNothing);
    expect(find.text('msg-second'), findsOneWidget);
  });
}
