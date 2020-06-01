import 'package:flutter/material.dart';
import 'package:newapp/imports/navbar.dart';
import 'package:newapp/pages/profile_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberPage extends StatefulWidget {
  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {

  String userid;
  String apiToken;

  getSessions() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString("user_id") ?? null;
      apiToken = prefs.getString("apiToken") ?? null;
    });
  }

  initState(){
    super.initState();
    getSessions();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sevgilim Nerede?"),),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.grey[100]),
        child: Navbar(),
      ),
      drawer: ProfileDrawer(),
      body: Column(
        children: <Widget>[
          Text("$userid"),
        ],
      )
    );
  }
}

