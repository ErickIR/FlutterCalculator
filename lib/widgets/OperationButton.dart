import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const foregroundColor = Color(0xffd4d3d8);
const operationButtonColor = Color(0xffee9327);
const highlightColor = Color(0xffffffff);

class OperationButton extends StatefulWidget {
  final String text;
  final Color textColor;
  final double textSize;
  final bool isOperationSelected;
  final Function onOperationPressed;
  OperationButton({
    Key key,
    @required this.text,
    this.textColor,
    this.textSize,
    @required this.isOperationSelected,
    @required this.onOperationPressed,
  }) : super(key: key);

  @override
  _OperationButtonState createState() => _OperationButtonState();
}

class _OperationButtonState extends State<OperationButton> {
  void _executeFunction(PointerDownEvent event) {
    widget.onOperationPressed(this.widget.text == 'x' ? '*' : this.widget.text);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final squareSizeLength = width / 5;
    final buttonWidth = squareSizeLength * (1);
    final buttonSize = Size(buttonWidth, squareSizeLength);

    return SizedBox(
      height: buttonSize.height,
      width: buttonSize.width,
      child: Listener(
        onPointerDown: _executeFunction,
        child: Stack(
          children: <Widget>[
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: EdgeInsets.all(width / 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(buttonSize.width),
                color: this.widget.isOperationSelected
                    ? highlightColor
                    : operationButtonColor,
                // boxShadow: _isPressed ? showInnerShadow() : showShadow(),
              ),
            ),
            Align(
              alignment: Alignment(0, 0),
              child: Text(
                this.widget.text,
                style: GoogleFonts.montserrat(
                  fontSize: this.widget.textSize ?? 30,
                  fontWeight: FontWeight.w400,
                  color: this.widget.isOperationSelected
                      ? operationButtonColor
                      : highlightColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
