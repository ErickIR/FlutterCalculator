import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const foregroundColor = Color(0xffd4d3d8);
const operationButtonColor = Color(0xffee9327);

class CalculatorButton extends StatefulWidget {
  final String text;
  final Color textColor;
  final double textSize;
  final Color buttonColor;
  final Function onPressedAction;
  final Function onDoubleTap;
  final isPill;
  CalculatorButton({
    Key key,
    @required this.text,
    this.textColor,
    this.textSize,
    this.isPill = false,
    @required this.buttonColor,
    @required this.onPressedAction,
    this.onDoubleTap,
  }) : super(key: key);

  @override
  _CalculatorButtonState createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> {
  bool _isPressed = false;

  void _onPointerDown() {
    setState(() {
      _isPressed = true;
    });
    widget.onPressedAction();
  }

  void _onPointerUp() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final squareSizeLength = width / 5;
    final buttonWidth = squareSizeLength * (this.widget.isPill ? 2 : 1);
    final buttonSize = Size(buttonWidth, squareSizeLength);

    var isPressed = _isPressed;
    var animatedContainer = AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      padding: EdgeInsets.all(width / 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(buttonSize.width),
        color: isPressed
            ? widget.buttonColor.withOpacity(0.5)
            : widget.buttonColor,
        // boxShadow: _isPressed ? showInnerShadow() : showShadow(),
      ),
    );
    var stack = Stack(
      children: <Widget>[
        animatedContainer,
        Align(
            alignment: Alignment(this.widget.isPill ? 0.5 : 0, 0),
            child: Text(widget.text,
                style: GoogleFonts.montserrat(
                    fontSize: widget.textSize ?? 30,
                    fontWeight: FontWeight.w400,
                    color: widget.textColor ?? Colors.white)))
      ],
    );
    var gestureDetector = GestureDetector(
      onTapDown: (details) => _onPointerDown(),
      onTapUp: (details) => _onPointerUp(),
      child: stack,
    );
    return SizedBox(
      height: buttonSize.height,
      width: buttonSize.width,
      child: gestureDetector,
    );
  }
}
