import 'package:flutter/material.dart';
import 'package:calculator/widgets/CalculatorView.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
          backgroundColor: Colors.blue, primaryColor: Colors.blueGrey),
      home: CalculatorView(),
    );
  }
}
