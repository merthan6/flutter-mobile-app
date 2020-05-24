import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
/* TO DO:  register */

class Register extends StatelessWidget {

  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final username = TextEditingController();

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
              Colors.blue[900],
              Colors.blue[800],
              Colors.blue[400]
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
                  Text("Register",style: TextStyle(color: Colors.white, fontSize : 40),),
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
                                    controller: username,
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
                          SizedBox(height:50,),
                          RaisedButton(
                          onPressed: () {
                            if(email.text.isNotEmpty && password.text.isNotEmpty && name.text.isNotEmpty && username.text.isNotEmpty){
                                debugPrint("selamlar!!");
                                debugPrint(email.text);
                                debugPrint(password.text); 
                                debugPrint(name.text);
                                debugPrint(username.text); 
                                _Register();
                                return _buildErrorDialog(context, "Succcessful Register");
                            } else {
                                return _buildErrorDialog(context, "Bütün bilgileri Doldurunuz!");
                            }
                          },
                          color: Colors.blue[800],
                          
                          shape: RoundedRectangleBorder( 
                            borderRadius: BorderRadius.circular(18.0),),
                          
                          child: Center(
                            child: Text("Register",style:TextStyle(color: Colors.white,fontWeight :FontWeight.bold),),
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
                })
          ],
        );
      },
      context: context,
    );
}
  Future<List> _Register() async {
  final response = await http.post("http://34.72.70.18/api/users/register", body: {
    "email": email.text,
    "password": password.text,
    "name" : name.text,
    "username" : username.text,
  });

  }
}