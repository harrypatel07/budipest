import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        FlutterI18n.translate(context, "title"),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'v2.0.0',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(FlutterI18n.translate(context, "addToilet")),
                    onTap: () {
                      Navigator.pushNamed(context, '/addToilet');
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                  ListTile(
                    title:
                        Text(FlutterI18n.translate(context, "aboutUs.title")),
                    onTap: () {
                      Navigator.pushNamed(context, '/about');
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
