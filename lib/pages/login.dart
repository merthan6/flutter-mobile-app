import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:newapp/pages/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

String userId;
String apiToken;
String authToken;
String username;
String fullname;
String emailUser;
String myPairID;

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
            SizedBox(height : 30,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children : <Widget>[
                  Positioned(
              child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                  )
                  )
                  )
                  ),
                ]
              ),
            ),
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
                        Text("Giriş",style:TextStyle(color: Colors.grey,fontSize: 25.0),),
                        SizedBox(height:20,),
                        Container(
                          decoration:  BoxDecoration(
                          color: Colors.white,
                          borderRadius:BorderRadius.circular(10),
                            boxShadow:[BoxShadow(
                            color: Color.fromRGBO(8, 84, 145, .5),
                            blurRadius: 15,
                            offset: Offset(0, 6)
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
                                    hintText : "Email",
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
                                    hintText : "Şifre",
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
                              login();
                            },
                            color: Colors.blue[500],
                            shape: RoundedRectangleBorder( 
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text("Giriş Yap",style:TextStyle(color: Colors.white,fontWeight :FontWeight.bold,),),
                            ),
                          ),
                        SizedBox(height:30,),
                        Container(
                          child: InkWell(
                            onTap: () => { Navigator.pushReplacementNamed(context, '/register') },
                            child: Text("Kayıt ol" ,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,decoration:TextDecoration.underline),)
                          ),
                        ),
                        SizedBox(height:10,),
                        Container(
                          child: InkWell(
                            child: Text("Şifremi unuttum" ,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,decoration:TextDecoration.underline),)
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

  Future<void> login() async {
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
          userId = datauser["data"]["data"]["id"];
          apiToken = datauser["data"]["token"];
          authToken = datauser["data"]["data"]["authtoken"];
          username = datauser["data"]["data"]["username"];
          fullname = datauser["data"]["data"]["fullname"];
          emailUser = datauser["data"]["data"]["email"];
          if(datauser["data"]["data"]["pair_id"] != null)
            myPairID = datauser["data"]["data"]["pair_id"];
          else
            myPairID = null;
        });

        final prefs = await SharedPreferences.getInstance();
        prefs.setString("user_id", userId);
        prefs.setString("apiToken","Bearer " + apiToken);
        prefs.setString("authToken", authToken);
        prefs.setString("username", username);
        prefs.setString("fullname", fullname);
        prefs.setString("email", emailUser);
        prefs.setString("pair_id", myPairID);
        prefs.setInt("navbarIndex",1);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
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