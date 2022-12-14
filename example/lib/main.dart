import 'package:flutter/material.dart';
import 'package:nod_flur/floatingSnackBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Bar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  FloatingSnackBar(
                      message: 'text',
                      // textStyle: const TextStyle(color: Colors.red),
                      context: context,
                      backgroundColor: Colors.white,
                      textColor: Colors.black);
                },
                child: const Text('press')),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
