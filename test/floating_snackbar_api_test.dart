import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:floating_snackbar/floating_snackbar.dart';

void main() {
  setUp(() {
    FloatingSnackBar.theme = const FloatingSnackBarTheme();
    FloatingSnackBar.navigatorKey = GlobalKey<NavigatorState>();
  });

  /// Pumps a host app and returns a context located beneath the [Overlay].
  Future<BuildContext> pumpHost(WidgetTester tester,
      {GlobalKey<NavigatorState>? navigatorKey}) async {
    late BuildContext ctx;
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        home: Scaffold(
          body: Builder(builder: (context) {
            ctx = context;
            return const SizedBox();
          }),
        ),
      ),
    );
    return ctx;
  }

  testWidgets('show renders message via overlay', (tester) async {
    final ctx = await pumpHost(tester);
    FloatingSnackBar.show(ctx, 'overlay message');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('overlay message'), findsOneWidget);
    // Cleanup pending timers.
    FloatingSnackBar.dismiss(ctx);
    await tester.pumpAndSettle();
  });

  testWidgets('success shows the default success icon', (tester) async {
    final ctx = await pumpHost(tester);
    FloatingSnackBar.success(ctx, 'done');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('done'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
    FloatingSnackBar.dismiss(ctx);
    await tester.pumpAndSettle();
  });

  testWidgets('renders an optional title', (tester) async {
    final ctx = await pumpHost(tester);
    FloatingSnackBar.info(ctx, 'body', title: 'Heads up');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('Heads up'), findsOneWidget);
    expect(find.text('body'), findsOneWidget);
    FloatingSnackBar.dismiss(ctx);
    await tester.pumpAndSettle();
  });

  testWidgets('auto-dismisses after the duration', (tester) async {
    final ctx = await pumpHost(tester);
    FloatingSnackBar.show(ctx, 'temporary',
        duration: const Duration(milliseconds: 500));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('temporary'), findsOneWidget);

    // Past the duration + exit animation.
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();
    expect(find.text('temporary'), findsNothing);
  });

  testWidgets('tapping dismisses when dismissOnTap is true', (tester) async {
    final ctx = await pumpHost(tester);
    FloatingSnackBar.show(ctx, 'tap me',
        dismissOnTap: true, duration: const Duration(seconds: 10));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('tap me'), findsOneWidget);

    await tester.tap(find.text('tap me'));
    await tester.pumpAndSettle();
    expect(find.text('tap me'), findsNothing);
  });

  testWidgets('action button fires its callback', (tester) async {
    final ctx = await pumpHost(tester);
    var pressed = false;
    FloatingSnackBar.show(
      ctx,
      'with action',
      duration: const Duration(seconds: 10),
      action: FloatingSnackBarAction(
        label: 'UNDO',
        onPressed: () => pressed = true,
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    await tester.tap(find.text('UNDO'));
    await tester.pumpAndSettle();
    expect(pressed, isTrue);
    expect(find.text('with action'), findsNothing); // dismissOnPressed default
  });

  testWidgets('top position anchors near the top', (tester) async {
    final ctx = await pumpHost(tester);
    FloatingSnackBar.show(ctx, 'top msg',
        position: FloatingSnackBarPosition.top,
        duration: const Duration(seconds: 10));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    final screenHeight = tester.getSize(find.byType(MaterialApp)).height;
    final pos = tester.getCenter(find.text('top msg'));
    expect(pos.dy, lessThan(screenHeight / 2));
    FloatingSnackBar.dismiss(ctx);
    await tester.pumpAndSettle();
  });

  testWidgets('global theme overrides default color', (tester) async {
    FloatingSnackBar.theme = const FloatingSnackBarTheme(
      successColor: Color(0xFF00FF00),
    );
    final ctx = await pumpHost(tester);
    FloatingSnackBar.success(ctx, 'themed',
        duration: const Duration(seconds: 10));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    final container = tester.widget<Container>(
      find
          .descendant(
            of: find.byType(FloatingSnackBarWidget),
            matching: find.byType(Container),
          )
          .first,
    );
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.color, const Color(0xFF00FF00));
    FloatingSnackBar.dismiss(ctx);
    await tester.pumpAndSettle();
  });

  testWidgets('context-free display works via navigatorKey', (tester) async {
    final key = GlobalKey<NavigatorState>();
    FloatingSnackBar.navigatorKey = key;
    await pumpHost(tester, navigatorKey: key);

    final ok = FloatingSnackBar.show(null, 'no context');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(ok, isTrue);
    expect(find.text('no context'), findsOneWidget);
    FloatingSnackBar.dismiss(null);
    await tester.pumpAndSettle();
  });

  testWidgets('returns false when no overlay can be resolved', (tester) async {
    final result = FloatingSnackBar.show(null, 'nowhere');
    expect(result, isFalse);
  });
}
