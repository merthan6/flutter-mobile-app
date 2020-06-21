import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newapp/pages/profile.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  State<StatefulWidget> createState() {
    return StartState();
  }
}

class StartState extends State<Home> {
  @override
  void initState() {
    super.initState();
    startTimer();
    checkRememberMe();
  }

  checkRememberMe() async{
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getBool("isLoggedIn") == true){

    var pw = prefs.getString("pw");
    String apiToken;

    final response = await http.post("http://34.72.70.18/api/users/login", body: {
      "email": prefs.getString("email"),
      "password": pw,
    }); 
    
    if(response.statusCode == 200){
      var datauser = json.decode(response.body);
      if(datauser["data"]["success"] == true){
        setState(() {
          apiToken = datauser["data"]["token"];
        });
        prefs.setString("apiToken","Bearer " + apiToken);
      }  
    }

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(),
        ),
      );
    }
  }
  
  startTimer() async {
    var duration = Duration(seconds: 2);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacementNamed(context, '/');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[500],
      body: Container(
        child: Column(children: <Widget>[
          SizedBox(
            height: 200,
          ),
          Container(
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/logo.png'),
              )
            )
          ),
          SizedBox(
            height: 30,
          ),
          CircularProgressIndicator(
            backgroundColor: Colors.white,
            strokeWidth: 2,
          )
        ]),
      ),
    );
  }
}
