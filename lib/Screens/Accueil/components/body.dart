import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/Screens/Accueil/components/background.dart';
import 'package:test/Screens/Inscription/inscription_screen.dart';
import 'package:test/Screens/Login/login_screen.dart';
import 'package:test/color.dart';

import '../../../components/roundedButton.dart';
import '../../../services/auth.dart';

class body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "ACCUEIL",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        Image.asset(
          "assets/images/font_1.png",
          height: size.height * 0.45,
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        RoundedButton(
          text: "CONNEXION",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ),
            );
          },
        ),
        RoundedButton(
          text: "INSCRIPTION",
          color: ligthColor,
          textColor: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return InscriptionScreen();
                },
              ),
            );
          },
        )
      ],
    ));
  }
}
