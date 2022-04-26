import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:test/Screens/Accueil/components/background.dart';
import 'package:test/Screens/Accueil/components/body.dart';
import 'package:test/services/auth.dart';
import 'package:test/widget/line_chart_widget.dart';

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
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            buildAppBar(context),
          ],
          
        ),
      );
      

  SliverAppBar buildAppBar(BuildContext context) => SliverAppBar(
      flexibleSpace: FlexibleSpaceBar(
        background: LineChartWidget(),
      ) ,
        expandedHeight: MediaQuery.of(context).size.height * 0.5,
        stretch: true,
        title: Text("Statistics"),
        centerTitle: true,
        pinned: true,
        leading: Icon(Icons.menu),
        actions: [
          Icon(Icons.person, size: 28),
        ],
        
        
      );
  /*
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
  }*/
}
