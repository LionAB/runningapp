import 'package:flutter/material.dart';
import 'package:test/color.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    required this.login,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? " Tu as déjà un compte" : " Tu n'as pas de compte ?",
          style: TextStyle(color: primaryColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? " Connecte toi " : " Inscrit toi",
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
