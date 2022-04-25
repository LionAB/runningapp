import 'package:flutter/material.dart';
import 'package:test/color.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: ligthColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}
