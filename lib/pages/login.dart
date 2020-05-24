import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
    @override
   _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
            SizedBox(height : 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children : <Widget>[
                  Text("Login",style: TextStyle(color: Colors.white, fontSize : 40),),
                  SizedBox(height : 20,),
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
                    child: Column(
                      children : <Widget>[
                        SizedBox(height:60,),
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
                        SizedBox(height:40,),
                        RaisedButton(
                          onPressed: () {
                            if(email.text.isNotEmpty && password.text.isNotEmpty){
                                debugPrint("selamlar!!");
                                debugPrint(email.text);
                                debugPrint(password.text);  
                                return _buildErrorDialog(context, "Giriş başarılı!!");
                            } else {
                                return _buildErrorDialog(context, "Şifre veya email boş olamaz!");
                            }
                          },
                          child: Center(
                            child: Text("Login",style:TextStyle(color: Colors.white,fontWeight :FontWeight.bold),),
                          ),
                        ),
                        SizedBox(height:40,),
                        Container(
                          child: InkWell(
                            child: Text("Sign Up" ,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,decoration:TextDecoration.underline),)
                          ),
                        ),
                        Container(
                          child: InkWell(
                            child: Text("Don't have an account?",style: TextStyle(color:Colors.grey),),
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
}