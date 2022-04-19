import 'package:flutter/material.dart';
import 'package:test/color.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color, textColor;
  final VoidCallback? onPressed;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = primaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 70),
          color: color,
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
