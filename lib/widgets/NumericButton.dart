import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const foregroundColor = Color(0xffd4d3d8);
const numericButtonColor = Color(0xff323232);
const highlightColor = Color(0xff696969);

class NumericButton extends StatefulWidget {
  final String text;
  final Color textColor;
  final double textSize;
  final bool isPill;
  final Function onButtonPressed;
  NumericButton(
      {Key key,
      @required this.text,
      this.textColor,
      this.textSize,
      this.isPill = false,
      @required this.onButtonPressed})
      : super(key: key);

  @override
  _NumericButtonState createState() => _NumericButtonState();
}

class _NumericButtonState extends State<NumericButton> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
      widget.onButtonPressed(widget.text);
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final squareSizeLength = width / 5;
    final buttonWidth = squareSizeLength * (widget.isPill ? 2.3 : 1);
    final buttonSize = Size(buttonWidth, squareSizeLength);

    return SizedBox(
      height: buttonSize.height,
      width: buttonSize.width,
      child: Listener(
        onPointerDown: _onPointerDown,
        onPointerUp: _onPointerUp,
        child: Stack(
          children: <Widget>[
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              padding: EdgeInsets.all(width / 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(buttonSize.width),
                color: _isPressed ? highlightColor : numericButtonColor,
                // boxShadow: _isPressed ? showInnerShadow() : showShadow(),
              ),
            ),
            Align(
                alignment: Alignment(widget.isPill ? -0.6 : 0, 0),
                child: Text(widget.text,
                    style: GoogleFonts.montserrat(
                        fontSize: widget.textSize ?? 30,
                        fontWeight: FontWeight.w400,
                        color: widget.textColor ?? Colors.white)))
          ],
        ),
      ),
    );
  }
}
