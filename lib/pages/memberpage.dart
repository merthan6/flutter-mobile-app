import 'package:flutter/material.dart';
import 'package:newapp/imports/navbar.dart';

class MemberPage extends StatefulWidget {
    @override
    _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  Navbar navbar = new Navbar();
  @override
  Widget build(BuildContext context) {
    final String username = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text("Sevgilim Nerede?"),),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.grey[100]),
        child: navbar,
      ),
      body: Column(
        children: <Widget>[
          Text("$username"),
        ],
      )
    );
  }
}

