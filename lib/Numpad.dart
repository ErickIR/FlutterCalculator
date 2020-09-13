import 'package:flutter/material.dart';
import 'package:calculator/CalculatorButton.dart';
import 'package:calculator/NumericButton.dart';
import 'CalculatorRow.dart';
import 'OperationButton.dart';

const normalButtonColor = Color(0xffa5a5a5);

class Numpad extends StatelessWidget {
  final String selectedOperation;
  final Function onOperationPressed;
  final Function onNumberPressed;
  final Function onClearValuePressed;
  final Function onAbsoluteValuePressed;
  final Function onPercentagePressed;
  final Function onDecimalPointPressed;
  final Function onEqualOperatorPressed;
  final Function onClearDoubleTap;

  Numpad({
    this.selectedOperation,
    this.onOperationPressed,
    this.onNumberPressed,
    this.onClearValuePressed,
    this.onAbsoluteValuePressed,
    this.onPercentagePressed,
    this.onDecimalPointPressed,
    this.onEqualOperatorPressed,
    this.onClearDoubleTap,
  });

  @override
  Widget build(BuildContext context) {
    var children2 = <Widget>[
      CalculatorRow(
        children: [
          CalculatorButton(
            text: 'AC',
            buttonColor: normalButtonColor,
            textColor: Colors.black,
            onPressedAction: onClearValuePressed,
          ),
          CalculatorButton(
            text: '+/-',
            buttonColor: normalButtonColor,
            textColor: Colors.black,
            onPressedAction: onAbsoluteValuePressed,
          ),
          CalculatorButton(
            text: '%',
            buttonColor: normalButtonColor,
            textColor: Colors.black,
            onPressedAction: onPercentagePressed,
          ),
          OperationButton(
            text: '/',
            isOperationSelected: selectedOperation == '/',
            onOperationPressed: this.onOperationPressed,
          ),
        ],
      ),
      CalculatorRow(
        children: [
          NumericButton(
            text: '7',
            onButtonPressed: onNumberPressed,
          ),
          NumericButton(
            text: '8',
            onButtonPressed: onNumberPressed,
          ),
          NumericButton(
            text: '9',
            onButtonPressed: onNumberPressed,
          ),
          OperationButton(
            text: 'x',
            isOperationSelected: selectedOperation == 'x',
            onOperationPressed: this.onOperationPressed,
          ),
        ],
      ),
      CalculatorRow(
        children: [
          NumericButton(
            text: '4',
            onButtonPressed: onNumberPressed,
          ),
          NumericButton(
            text: '5',
            onButtonPressed: onNumberPressed,
          ),
          NumericButton(
            text: '6',
            onButtonPressed: onNumberPressed,
          ),
          OperationButton(
            text: '-',
            isOperationSelected: selectedOperation == '-',
            onOperationPressed: this.onOperationPressed,
          ),
        ],
      ),
      CalculatorRow(
        children: [
          NumericButton(
            text: '3',
            onButtonPressed: onNumberPressed,
          ),
          NumericButton(
            text: '2',
            onButtonPressed: onNumberPressed,
          ),
          NumericButton(
            text: '1',
            onButtonPressed: onNumberPressed,
          ),
          OperationButton(
            text: '+',
            isOperationSelected: selectedOperation == '+',
            onOperationPressed: this.onOperationPressed,
          ),
        ],
      ),
      CalculatorRow(
        children: [
          NumericButton(
            text: '0',
            isPill: true,
            onButtonPressed: onNumberPressed,
          ),
          CalculatorButton(
            text: '=',
            buttonColor: normalButtonColor,
            textColor: Colors.black,
            textSize: 45,
            isPill: true,
            onPressedAction: this.onEqualOperatorPressed,
          ),
        ],
      )
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: children2,
      ),
    );
  }
}
