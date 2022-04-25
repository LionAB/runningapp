import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_app/screens/history_page.dart';

import '../main.dart';
import '../screens/home_page.dart';
import '../screens/map_page.dart';

class NavBarWidget extends State<MyHomePage> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;

  final screens = [
    // ignore: prefer_const_constructors
    HomePage(),
    MapSample(),
    HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size: 30),
      Icon(Icons.directions_run, size: 30),
      Icon(Icons.history, size: 30),
    ];

    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body:screens[index],
        bottomNavigationBar:Theme(
          data:Theme.of(context).copyWith(
            iconTheme: IconThemeData(color: Colors.black,),
          ),
          child: CurvedNavigationBar(
          key: navigationKey,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.white,
          height: 50,
          index: index,
          items: items,
          onTap:(index)=>setState(()=>this.index=index),
          
          ),
        ),
      );
  }
}
