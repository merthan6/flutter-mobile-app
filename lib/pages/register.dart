import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newapp/pages/memberpage.dart';

class Register extends StatefulWidget {
    @override
    _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<Register> {

  String username='';
  String msg = '';
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final usernameC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Container(
        padding: EdgeInsets.symmetric(vertical:0),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient : LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.blue[600],
              Colors.blue[500],
              Colors.blue[100]
            ]
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
                  Text("Register",style: TextStyle(color: Colors.white, fontSize : 40,fontWeight: FontWeight.w900),),
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
                          SizedBox(height:20,),
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
                                  padding: EdgeInsets.all(5.0),
                                  decoration : BoxDecoration(
                                    border: Border(bottom : BorderSide(color:Colors.grey[200]))
                                  ),
                                  child: TextField(
                                    controller: name,
                                    decoration : InputDecoration(
                                      icon: Icon(Icons.person,color: Colors.grey,),
                                      border: InputBorder.none,
                                      hintText : "Name and Surname",
                                      hintStyle : TextStyle(color:Colors.grey)
                                    )
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  decoration : BoxDecoration(
                                    border: Border(bottom : BorderSide(color:Colors.grey[200]))
                                  ),
                                  child: TextField(
                                    controller: usernameC,
                                    decoration : InputDecoration(
                                      icon: Icon(Icons.account_box,color: Colors.grey,),
                                      border: InputBorder.none,
                                      hintText : "Username",
                                      hintStyle : TextStyle(color:Colors.grey)
                                    )
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  decoration : BoxDecoration(
                                    border: Border(bottom : BorderSide(color:Colors.grey[200]))
                                  ),
                                  child: TextField(
                                    controller: email,
                                    decoration : InputDecoration(
                                      icon: Icon(Icons.mail,color: Colors.grey,),
                                      border: InputBorder.none,
                                      hintText : "Email",
                                      hintStyle : TextStyle(color:Colors.grey)
                                    )
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5.0),
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
                            if(email.text.isNotEmpty && password.text.isNotEmpty && name.text.isNotEmpty && usernameC.text.isNotEmpty){
                              _Register();
                            }else{
                              setState(() {
                                msg="Fields must be filled!";
                              });
                            }
                          },
                          color: Colors.blue[500],
                          shape: RoundedRectangleBorder( 
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Center(
                            child: Text("Register",style:TextStyle(color: Colors.white,fontWeight :FontWeight.bold),),
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Container(
                          child: InkWell(
                            onTap: () => {
                              Navigator.pushReplacementNamed(context, '/')
                            },
                            child: Text("Already have an account?",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,decoration:TextDecoration.underline),),
                          ),
                        ),
                        SizedBox(height:10,),
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
                })
          ],
        );
      },
      context: context,
    );
}
  Future<List> _Register() async {
    final response = await http.post("http://34.72.70.18/api/users/register", body: {
      "email": email.text.trim(),
      "password": password.text.trim(),
      "fullname" : name.text.trim(),
      "username" : usernameC.text.trim()
    });
    
    if(response.statusCode == 200){
      Navigator.pushReplacementNamed(context, '/');
    } else {
      setState(() {
        msg="Servers are now unavailable!";
      });
    }
  }
}