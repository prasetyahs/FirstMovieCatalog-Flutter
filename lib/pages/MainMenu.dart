import 'package:flutter/material.dart';
import 'package:flutter_app/tabmenu/Home.dart';
import 'package:flutter_app/tabmenu/MoviesPage.dart';

class MainMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainMenuState();
  }
}

class MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return new Container(
        width: width,
        height: height,
        color: Colors.white,
        child: new DefaultTabController(
            length: 2,
            child: new DefaultTabController(
              child: new Scaffold(
                appBar: new AppBar(
                  title: new Text("Movie Catalog"),
                  centerTitle: true,
                  backgroundColor: Colors.indigo,
                  bottom: new TabBar(tabs: [
                    new Tab(
                      text: "Home",
                    ),
                    new Tab(
                      text: "Movies",
                    ),
                  ]),
                ),
                body: new TabBarView(children: [
                  new Home(),
                  new MoviesPage(),
                ]),
              ), length: 2,
            )));
  }
}
