import 'package:flutter/material.dart';
import 'package:nod_flur/floatingSnackBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyHomePage({Key? key, required this.title});

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
                  FloatingSnackBar(
                    message: 'Showing SnackBar..',
                    context: context,
                    // textColor: Colors.black,
                    // textStyle: const TextStyle(color: Colors.red),
                    // duration: const Duration(milliseconds: 4000),
                    // backgroundColor: Colors.white,
                  );
                },
                child: const Text('Show SnackBar')),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
