// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/Screens/Inscription/inscription_screen.dart';
import 'package:test/Screens/Login/components/background.dart';
import 'package:test/Screens/Login/login_screen.dart';
import 'package:test/Screens/Welcome/welcome_screen.dart';
import 'package:test/color.dart';
import 'package:test/components/already_have_account.dart';
import 'package:test/components/roundedButton.dart';
import 'package:test/components/rounded_input_field.dart';
import 'package:test/components/rounded_password_field.dart';
import 'package:test/components/text_field_container.dart';

import '../../../services/auth.dart';

class body extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final myControllerEmail = TextEditingController();
    final myControllerMdp = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return background(
        child: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "LOGIN",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Image.asset(
            "assets/images/run.png",
            height: size.height * 0.2,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          RoundedInputField(
            hintText: "EMAIL",
            myController: myControllerEmail,
          ),
          RoundedPasswordField(
            myController: myControllerMdp,
          ),
          RoundedButton(
            text: "CONNEXION",
            onPressed: () {
              Map creds = {
                'email': myControllerEmail.text,
                'password': myControllerMdp.text,
              };
              if (_formKey.currentState!.validate()) {
                Provider.of<Auth>(context, listen: false).login(creds: creds);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return welcomeScreen();
                    },
                  ),
                );
              }
            },
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
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
      ),
    ));
  }
}
