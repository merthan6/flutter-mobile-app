import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:newapp/imports/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Pairs extends StatefulWidget {
  @override
  _PairesPageState createState() => _PairesPageState();
}

class _PairesPageState extends State<Pairs> {

  Navbar navbar = new Navbar();

  final receiverTokenCTRL = TextEditingController();  

  String userid;
  String apiToken;
  String authToken;
  String newAuthToken;
  bool checkStatus = false;

  String requestUsername;
  String requestFullname;

  getSessions() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString("user_id") ?? "null";
      apiToken = prefs.getString("apiToken") ?? "null";
      authToken = prefs.getString("authToken") ?? "null";
      newAuthToken = authToken;
    });
  }

  checkPairRequests() async{
    final http.Response response = await http.post(
      'http://34.72.70.18/api/users/pairs/check',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: apiToken,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
        "authtoken": authToken
        }
      ),
    );
    print(response.statusCode);
    if(response.statusCode == 200){
      var datauser = json.decode(response.body);
      if(datauser["data"]["data"]["success"] == true){
        checkStatus = true;
        requestFullname = datauser["data"]["data"]["fullname"];
        requestUsername = datauser["data"]["data"]["username"];
      }
    }
  }

  initState(){
    super.initState();
    getSessions();
    checkPairRequests();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bağlantı"),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.grey[300]),
        child: navbar
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[ 
            Container(
              height : 180,
              child :Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                elevation: 5.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.person, size: 50),
                      title: Text("$requestFullname"),
                      subtitle: Text("$requestUsername"),
                    ),
                    SizedBox(height :30,),
                    ButtonBar(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {},
                          color: Colors.green[500],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                          child: Center(child: Text("Kabul et",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),),
                        ),
                        RaisedButton(
                          onPressed: resetAuthToken,
                          color: Colors.red[500],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                          child: Center(child: Text("Reddet",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height : 180,
              child :Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                elevation: 5.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(title: Text('Kod Giriniz',style: TextStyle(fontSize : 20,fontWeight: FontWeight.w900),),),
                    TextField(
                      controller: receiverTokenCTRL,
                      decoration: InputDecoration(
                        icon: Icon(Icons.edit),
                        border: InputBorder.none,
                        hintText: 'Bağlantı kodunu giriniz.'
                      ),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: requestPair,
                          color: Colors.blue[500],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                          child: Center(child: Text("Gönder",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height : 180,
              child :Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                elevation: 5.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text('Kodunuz',style: TextStyle(fontSize : 20,fontWeight: FontWeight.w900),),
                      subtitle: Text('$newAuthToken'),
                    ),
                    SizedBox(height : 30,),
                    ButtonBar(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: resetAuthToken,
                          color: Colors.blue[500],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                          child: Center(child: Text("Sıfırla",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
  Future<List> resetAuthToken() async {
    
    final response = await http.post("http://34.72.70.18/api/users/resettoken", headers: {
      "Authorization": apiToken,
    });
  
    if(response.statusCode == 200){
      var datauser = json.decode(response.body);
      if(datauser["data"]["success"] == false){
        // Service unavailable!
      } else {
        setState(() {
          newAuthToken = datauser["data"]["data"];
          authToken = newAuthToken;
        });
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("authToken", authToken);
      }  
    } else {
     // Service unavailable!
    }
  }

  Future<List> requestPair() async {
    print("deneme");
    final response = await http.post("http://34.72.70.18/api/users/pairs/create", headers: {
      "Authorization": apiToken,
    },
    body: {
      "receiver-token": receiverTokenCTRL.text.trim(),
    });
    print(receiverTokenCTRL.text.trim());
    print(response.statusCode);
    if(response.statusCode == 200){
      print("deneme2");
      var datauser = json.decode(response.body);
      if(datauser["data"]["success"] == false){
        print("There is no matching token!");
      } else {
        print("Request created");
      }  
    } else {
     // Service unavailable!
    }
  }
}
