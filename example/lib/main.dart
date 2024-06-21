import 'package:flutter/material.dart';
import 'package:floating_snackbar/floating_snackbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Floating Snackbar Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Floating Snackbar Example'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Floating Snackbar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                // minimal usage
                floatingSnackBar(
                  message: 'Hi there! I am a floating SnackBar!',
                  context: context,
                );
              },
              child: const Text('Show SnackBar'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // detailed usage
                floatingSnackBar(
                  message: 'Developed by @emeenx on Twitter!',
                  context: context,
                  textColor: Colors.black,
                  textStyle: const TextStyle(color: Colors.red),
                  duration: const Duration(milliseconds: 4000),
                  backgroundColor: Colors.white,
                );
              },
              child: const Text('Show SnackBar'),
            ),
          ],
        ),
      ),
    );
  }
}
