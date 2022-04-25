import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:test/Screens/Accueil/components/background.dart';
import 'package:test/services/auth.dart';

class welcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreen createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<welcomeScreen> {
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    readToken();
  }

  void readToken() async {
    String? token = await storage.read(key: 'token');
    Provider.of<Auth>(context, listen: false).tryToken(token: token);
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<Auth>(
        builder: (context, auth, child) {
          if (auth.authenticated) {
            print(auth.user.name);
            return Text(
              auth.user.name,
            );
          } else {
            return Text("rien");
          }
        },
      ),
    );
  }
}
