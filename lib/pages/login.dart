import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
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
                        Container(
                          height: 50,
                          margin : EdgeInsets.symmetric(horizontal:50),
                          decoration : BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue[800]
                          ),
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
}