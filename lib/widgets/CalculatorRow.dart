import 'package:flutter/material.dart';

class CalculatorRow extends StatelessWidget {
  final List<Widget> children;

  const CalculatorRow({
    Key key,
    @required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }
}
