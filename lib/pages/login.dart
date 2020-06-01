import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:newapp/pages/memberpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

String user_id;
String apiToken;
String authToken;
String username;
String fullname;
String emailUser;

class LoginPage extends StatefulWidget {
    @override
    _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  final email = TextEditingController();
  final password = TextEditingController();
  String msg='';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Container(
        padding: EdgeInsets.symmetric(vertical:0),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient : LinearGradient(
            begin: Alignment.topCenter,
            colors: [Colors.blue[600],Colors.blue[500],Colors.blue[100]]
          )
        ),
        child: Column(
          children:<Widget>[
            SizedBox(height : 50,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children : <Widget>[
                  Text("Login",style: TextStyle(color: Colors.white, fontSize : 40.0,fontWeight: FontWeight.w900),),
                  SizedBox(height : 10,),
                ]
              ),
            ),
            SizedBox(height:10,),
            Expanded(
              child: Container(
                decoration : BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft : Radius.circular(60),topRight : Radius.circular(60)) 
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      children : <Widget>[
                        SizedBox(height:40,),
                        Container(
                          decoration:  BoxDecoration(
                          color: Colors.white,
                          borderRadius:BorderRadius.circular(10),
                            boxShadow:[BoxShadow(
                            color: Color.fromRGBO(8, 84, 145, .5),
                            blurRadius: 20,
                            offset: Offset(0, 10)
                            )]
                          ),
                          child: Column(
                            children : <Widget>[
                              Container(
                                padding: EdgeInsets.all(10.0),
                                decoration : BoxDecoration(
                                  border: Border(bottom : BorderSide(color:Colors.grey[200]))
                                ),
                                child: TextField(
                                  controller: email,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration : InputDecoration(
                                    icon: Icon(Icons.person,color: Colors.grey,),
                                    border: InputBorder.none,
                                    hintText : "Email or Username",
                                    hintStyle : TextStyle(color:Colors.grey)
                                  )
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10.0),
                                decoration : BoxDecoration(
                                  border: Border(bottom : BorderSide(color:Colors.grey[200]))
                                ),
                                child: TextField(
                                  controller: password,
                                  obscureText: true,
                                  decoration : InputDecoration(
                                    icon: Icon(Icons.lock,color: Colors.grey,),
                                    hintText : "Password",
                                    hintStyle : TextStyle(color:Colors.grey),
                                    border: InputBorder.none
                                  ),
                                ),
                              )
                            ]
                          ),
                        ),
                        SizedBox(height:30,),
                        Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.red),),
                        SizedBox(height:20,),
                          RaisedButton(
                            onPressed: () {
                              _login();
                            },
                            color: Colors.blue[500],
                            shape: RoundedRectangleBorder( 
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text("Login",style:TextStyle(color: Colors.white,fontWeight :FontWeight.bold,),),
                            ),
                          ),
                        SizedBox(height:30,),
                        Container(
                          child: InkWell(
                            onTap: () => { Navigator.pushReplacementNamed(context, '/register') },
                            child: Text("Sign Up" ,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,decoration:TextDecoration.underline),)
                          ),
                        ),
                        SizedBox(height:10,),
                        Container(
                          child: InkWell(
                            child: Text("Forgot Password" ,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,decoration:TextDecoration.underline),)
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ) 
          ]
        ),
      ) 
    );
  }
  Future _buildErrorDialog(BuildContext context, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Error Message'),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              }
            )
          ],
        );
      },
      context: context,
    );
  }

  Future<List> _login() async {
    final response = await http.post("http://34.72.70.18/api/users/login", body: {
      "email": email.text.trim(),
      "password": password.text.trim()
    });
    if(response.statusCode == 200){
      var datauser = json.decode(response.body);
      if(datauser["data"]["success"] == false){
        setState(() {
          msg="Login Fail";
        });
      } else {
        setState(() {
          print(datauser);
          user_id = datauser["data"]["data"]["id"];
          apiToken = datauser["data"]["token"];
          authToken = datauser["data"]["data"]["authtoken"];
          username = datauser["data"]["data"]["username"];
          fullname = datauser["data"]["data"]["fullname"];
          emailUser = datauser["data"]["data"]["email"];
        });

        final prefs = await SharedPreferences.getInstance();
        prefs.setString("user_id", user_id);
        prefs.setString("apiToken","Bearer " + apiToken);
        prefs.setString("authToken", authToken);
        prefs.setString("username", username);
        prefs.setString("fullname", fullname);
        prefs.setString("email", emailUser);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MemberPage(),
          ),
        );
      }  
    } else {
      setState(() {
        msg="Service unavailable!";
      });
    }
  }
}