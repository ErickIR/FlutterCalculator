import 'package:calculator/widgets/HistoryList.dart';
import 'package:calculator/widgets/Numpad.dart';
import 'package:calculator/models/history.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

const normalButtonColor = Color(0xffa5a5a5);

class CalculatorView extends StatefulWidget {
  @override
  _CalculatorViewState createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  List<ExpressionHistory> expressionHistory = [];
  String selectedOperation = '';
  String value = '';
  String expression = '';
  bool isResultReady = false;
  String result = '';
  bool showHistory = false;

  void onOperationPressed(String newOperation) {
    if (selectedOperation == (newOperation == '*' ? 'x' : newOperation)) {
      final String newSelectedOperator = '';
      final String newExpression =
          expression.substring(0, expression.length - 1);
      expression = newExpression;

      setState(() {
        selectedOperation = newSelectedOperator;
      });
    } else {
      final String newSelectedOperator = newOperation;
      final String newExpression = selectedOperation.isEmpty
          ? expression + (value.isEmpty ? '0' : value)
          : expression.substring(0, expression.length - 1);
      // final String newExpression = expression + value;
      final double evaluation = calculateExpression(newExpression);

      expression = newExpression + newSelectedOperator;
      setState(() {
        isResultReady = true;
        result = evaluation.toStringAsFixed(2);
        selectedOperation =
            newSelectedOperator == '*' ? 'x' : newSelectedOperator;
        value = '';
      });
    }
    print(expression);
  }

  void calculateAndClear() {
    if (selectedOperation.isNotEmpty) return;
    final String newExpression = expression + value;
    final double evaluation = calculateExpression(newExpression);
    saveNewHistory(newExpression, evaluation);
    expression = '';
    setState(() {
      isResultReady = true;
      result = evaluation.toStringAsFixed(2);
      selectedOperation = '';
      value = '';
    });
  }

  void saveNewHistory(String expr, double evaluation) {
    final historyItem = ExpressionHistory(
      id: UniqueKey().toString(),
      expression: '$expr = $evaluation',
      dateCreated: DateTime.now(),
    );

    setState(() {
      expressionHistory.add(historyItem);
    });
    print({historyItem.expression});
  }

  void onNumericButtonPressed(String newNumber) {
    final String newValue = value + newNumber;
    setState(() {
      value = newValue;
      isResultReady = false;
      selectedOperation = '';
    });
    print(expression);
  }

  void clearTextBox() {
    setState(() {
      value = '';
      result = '';
    });
  }

  void clearAll() {
    setState(() {
      value = '';
      result = '';
      isResultReady = false;
      expression = '';
      selectedOperation = '';
    });
  }

  double calculateExpression(String strExpression) {
    Parser parser = Parser();
    Expression expResult = parser.parse(strExpression);
    ContextModel ctxModel = ContextModel();
    final double eval = expResult.evaluate(EvaluationType.REAL, ctxModel);
    return eval;
  }

  void absoluteValue() {
    final String newValue = (int.parse(value) * -1).toString();
    setState(() {
      value = newValue;
      isResultReady = false;
    });
  }

  List<String> prompText() {
    final String text = (isResultReady ? result : value);
    final List<String> textList = [];
    for (var i = 0; i < text.length; i++) {
      textList.add(text[i]);
    }
    return textList;
  }

  void calculatePercentage() {
    final String newResult = (int.parse(value) / 100).toString();
    setState(() {
      isResultReady = true;
      value = '';
      result = newResult;
    });
  }

  Widget _buildCalculatorView(double appBarHeight) {
    final mediaQuery = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: (mediaQuery.height - appBarHeight) * 0.20,
          child: Text(
            (isResultReady ? result : value),
            maxLines: 2,
            textAlign: TextAlign.end,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 45,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
        Container(
          height: (mediaQuery.height - appBarHeight) * 0.70,
          child: Numpad(
            selectedOperation: this.selectedOperation,
            onOperationPressed: this.onOperationPressed,
            onNumberPressed: this.onNumericButtonPressed,
            onClearValuePressed: this.clearTextBox,
            onAbsoluteValuePressed: this.absoluteValue,
            onPercentagePressed: this.calculatePercentage,
            onEqualOperatorPressed: this.calculateAndClear,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: showHistory ? Text('Calculations History') : Text(''),
      backgroundColor: Colors.black,
      actions: [
        IconButton(
          icon: Icon(Icons.schedule),
          onPressed: () => setState(() => showHistory = !showHistory),
        )
      ],
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        backgroundColor: Colors.black,
        body: showHistory
            ? HistoryList(
                history: expressionHistory,
              )
            : _buildCalculatorView(appBar.preferredSize.height),
      ),
    );
  }
}
