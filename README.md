
  

<!--

This README describes the package. If you publish this package to pub.dev,

this README's contents appear on the landing page for your package.

  

For information about how to write a good package README, see the guide for

[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

  

For general information about developing packages, see the Dart guide for

[creating packages](https://dart.dev/guides/libraries/create-library-packages)

and the Flutter guide for

[developing packages and plugins](https://flutter.dev/developing-packages).![loader](https://raw.githubusercontent.com/muhd-ameen/FloatingSnackBar/master/assets/image/flutter_02.png)-->

  
# floating_snackbar

[![pub package](https://img.shields.io/pub/v/floating_snackbar.svg)](https://pub.dev/packages/floating_snackbar)
![tests](https://github.com/britannio/in_app_review/workflows/tests/badge.svg?branch=master)

A Flutter plugin for showing toasts/snackbar. 🚀 <br><br>
![In-App Review Android Demo](https://raw.githubusercontent.com/muhd-ameen/FloatingSnackBar/main/assets/image/fsb-ss.png)


| **Support 🖥️** | Android | iOS   | Linux | macOS  | Web | Windows     |
|-------------|---------|-------|-------|--------|-----|-------------|

This Flutter package offers a customizable solution for integrating floating Snackbars into your applications. providing a seamless user experience. 🔥

***
  ## Getting started <br> <br>
  
  To use this plugin, add `floating_snackbar` as a [dependency in your pubspec.yaml file](https://flutter.dev/platform-plugins/).


import the package in your dart file

```dart
import  'package:floating_snackbar/floatingSnackBar.dart';
```  
***
## Usage #1

**Minimalistic snackbar 👨🏼‍🌾**

```dart
TextButton(
  onPressed: () {
    FloatingSnackBar(
       message: 'Hi there! I am a floating SnackBar!',
	   context: context,
	);
},
child:  const  Text('Show SnackBar 1'),
),
```
***
## Usage #2

**Detailed snackbar 🦹🏻**

```dart
TextButton(
  onPressed: () {
	FloatingSnackBar(
        message: 'Developed by @emeenx on Twitter!',
		context: context,
		textColor:  Colors.black,
		textStyle:  const  TextStyle(color:  Colors.red),
		duration:  const  Duration(milliseconds:  4000),
		backgroundColor:  Colors.white,
	);
},
child:  const  Text('Show SnackBar 2'),
),
``` 

 

`Parse the required 'message' and 'context' to the FloatingSnackBar widget to use your custom toast. 🎉`

**Support**

For support and feedback, feel free to reach out through the issues page. 🛠️
***
Enjoy using the Floating Snackbar package to enhance your Flutter app! 🚀
<br><br><br>