import 'package:flutter/material.dart';
import 'package:message_app/menu/common_divider.dart';
import 'package:message_app/menu/common_scaffold.dart';
import 'package:message_app/menu/profile_tile.dart';

class menu extends StatefulWidget {
  static const String id="drawer";
  @override
  _menuState createState() => _menuState();
}

class _menuState extends State<menu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:_scaffold() ,);
  }
}
Widget _scaffold() => CommonScaffold(
  appTitle: "View Profile",



  showDrawer: true,
  floatingIcon: Icons.person_add,
);