import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/Screens/Inscription/components/background.dart';
import 'package:test/Screens/Inscription/inscription_screen.dart';
import 'package:test/Screens/Login/login_screen.dart';
import 'package:test/components/already_have_account.dart';
import 'package:test/components/roundedButton.dart';
import 'package:test/components/rounded_input_field.dart';
import 'package:test/components/rounded_password_field.dart';
import 'package:test/services/auth.dart';

class body extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final myControllerEmail = TextEditingController();
    final myControllerName = TextEditingController();
    final myControllerMdp = TextEditingController();
    final myControllerMdpConfirmation = TextEditingController();
    return background(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/sport centre.jpg",
              height: size.height * 0.2,
            ),
            RoundedInputField(
              hintText: "Name",
              myController: myControllerName,
            ),
            RoundedInputField(
              hintText: "Email",
              myController: myControllerEmail,
            ),
            RoundedPasswordField(
              myController: myControllerMdp,
            ),
            RoundedPasswordField(
              myController: myControllerMdpConfirmation,
            ),
            RoundedButton(
              text: "Inscription",
              onPressed: () {
                Map creds = {
                  'name': myControllerName.text,
                  'email': myControllerEmail.text,
                  'password': myControllerMdp.text,
                  'password_confirmation': myControllerMdp.text,
                };
                if (_formKey.currentState!.validate()) {
                  Provider.of<Auth>(context, listen: false)
                      .register(creds: creds);
                  Navigator.pop(context);
                }
              },
            ),
            AlreadyHaveAnAccountCheck(
              login: true,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
