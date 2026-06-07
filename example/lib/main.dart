import 'package:flutter/material.dart';
import 'package:floating_snackbar/floating_snackbar.dart';

void main() {
  // Optional: set global defaults once for the whole app.
  FloatingSnackBar.theme = const FloatingSnackBarTheme(
    borderRadius: 14,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Floating Snackbar Example',
      debugShowCheckedModeBanner: false,
      // Wiring this key enables context-free calls anywhere in the app.
      navigatorKey: FloatingSnackBar.navigatorKey,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FloatingSnackBarPosition _position = FloatingSnackBarPosition.bottom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('floating_snackbar')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section('Position'),
          SegmentedButton<FloatingSnackBarPosition>(
            segments: const [
              ButtonSegment(
                value: FloatingSnackBarPosition.top,
                label: Text('Top'),
                icon: Icon(Icons.vertical_align_top),
              ),
              ButtonSegment(
                value: FloatingSnackBarPosition.bottom,
                label: Text('Bottom'),
                icon: Icon(Icons.vertical_align_bottom),
              ),
            ],
            selected: {_position},
            onSelectionChanged: (s) => setState(() => _position = s.first),
          ),
          const SizedBox(height: 24),
          _section('Variants'),
          _btn('Success', () {
            FloatingSnackBar.success(context, 'Saved successfully!',
                position: _position);
          }),
          _btn('Error', () {
            FloatingSnackBar.error(context, 'Something went wrong.',
                position: _position);
          }),
          _btn('Warning', () {
            FloatingSnackBar.warning(context, 'Battery is running low.',
                position: _position);
          }),
          _btn('Info', () {
            FloatingSnackBar.info(context, 'A new update is available.',
                position: _position);
          }),
          const SizedBox(height: 24),
          _section('Rich content'),
          _btn('Title + body', () {
            FloatingSnackBar.show(
              context,
              'Your changes have been synced to the cloud.',
              title: 'All set',
              type: FloatingSnackBarType.success,
              position: _position,
            );
          }),
          _btn('With action (UNDO)', () {
            FloatingSnackBar.show(
              context,
              'Item deleted.',
              type: FloatingSnackBarType.normal,
              position: _position,
              duration: const Duration(seconds: 5),
              action: FloatingSnackBarAction(
                label: 'UNDO',
                onPressed: () => FloatingSnackBar.info(context, 'Restored!'),
              ),
            );
          }),
          _btn('With progress bar', () {
            FloatingSnackBar.info(
              context,
              'Downloading… watch the countdown.',
              position: _position,
              showProgress: true,
              duration: const Duration(seconds: 4),
            );
          }),
          _btn('Custom leading widget', () {
            FloatingSnackBar.show(
              context,
              'You earned a new badge!',
              position: _position,
              leading: const Icon(Icons.emoji_events, color: Colors.amber),
              backgroundColor: const Color(0xFF311B92),
            );
          }),
          const SizedBox(height: 24),
          _section('Behavior'),
          _btn('Tap to dismiss', () {
            FloatingSnackBar.show(
              context,
              'Tap me to dismiss early.',
              position: _position,
              dismissOnTap: true,
              duration: const Duration(seconds: 10),
            );
          }),
          _btn('Scale animation', () {
            FloatingSnackBar.success(
              context,
              'Scaled in!',
              position: _position,
              animation: FloatingSnackBarAnimation.scale,
            );
          }),
          _btn('Context-free (no BuildContext)', () {
            // Works because navigatorKey is wired into MaterialApp.
            FloatingSnackBar.info(null, 'Shown without a BuildContext!',
                position: _position);
          }),
          const SizedBox(height: 24),
          _section('Legacy API (still works)'),
          _btn('floatingSnackBar()', () {
            floatingSnackBar(
              message: 'The original one-liner, unchanged.',
              context: context,
            );
          }),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _section(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            fontSize: 12,
          ),
        ),
      );

  Widget _btn(String label, VoidCallback onPressed) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton.tonal(
            onPressed: onPressed,
            child: Text(label),
          ),
        ),
      );
}
