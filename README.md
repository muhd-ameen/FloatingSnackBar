
<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).![loader](https://raw.githubusercontent.com/muhd-ameen/FloatingSnackBar/master/assets/image/flutter_02.png)

-->

A package that provides custom floating snackbar for your project.

## Features

Can provider custom floating snackbar for an minimalistic toast.

<img height="400" src="https://raw.githubusercontent.com/muhd-ameen/FloatingSnackBar/master/assets/image/flutter_02.png"> 
<img height="400" src="https://raw.githubusercontent.com/muhd-ameen/FloatingSnackBar/master/assets/image/flutter_02.png">


## Getting started

import the package in your dart file

```dart
import  'package:floating_snackbar/floatingSnackBar.dart';```

## Usage

FloatingSnackBar

```dart

TextButton(
	onPressed: () {
		FloatingSnackBar(
			message:  'Showing SnackBar!',
			context: context,
			textColor:  Colors.black,
			textStyle:  const  TextStyle(color:  Colors.red),
			duration:  const  Duration(milliseconds:  4000),
			backgroundColor:  Colors.white,
		);
	},
	child:  const  Text('Show SnackBar'),
),
            
```

Parse the required 'message' and 'context' to the FloatingSnackBar widget for using your custom toast.