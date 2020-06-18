import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newapp/imports/navbar.dart';
import 'package:newapp/pages/profile_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './profile_drawer.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double _borderRadius = 24;
  String username;
  String fullname;
  String apiToken;
  String authToken;
  bool checkStatus;
  String requestFullname;
  String requestUsername;
  String requestSenderID;

  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double screenHeight(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).height / dividedBy;
  }

  double screenWidth(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).width / dividedBy;
  }

  void getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      fullname = prefs.getString("fullname");
      apiToken = prefs.getString("apiToken");
      authToken = prefs.getString("authToken");
      prefs.setInt("navbarIndex", 1);
    });

    Map<String,String> headers = {
      'Content-type' : 'application/json', 
      'Accept': 'application/json',
      'Authorization':'$apiToken'
    };

    final response = await http.post("http://34.72.70.18/api/users/checkPair", headers: headers);
    if(response.statusCode == 200){
      var datauser = json.decode(response.body);
      setState(() {
        checkStatus = false;
      });
      if(datauser["data"]["success"] == true) {
        setState(() {
          requestFullname = datauser["data"]["data"]["fullname"];
          requestUsername = datauser["data"]["data"]["username"];
          requestSenderID = datauser["data"]["data"]["id"];
          checkStatus = true;
        });
      }
    }
  }

  @override
  void initState() {
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
      ),
      drawer: ProfileDrawer(),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.white),
        child: Navbar()
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 8.0, left: 8.0),
              child: Stack(
                children: <Widget>[
                  SizedBox(height: 20.0,),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_borderRadius),
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow:[
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        )
                      ],
                    )
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: CustomPaint(
                      size: Size(100, 150),
                      painter: CustomCardShapePainter(
                        _borderRadius, Colors.blue, Colors.green
                      ),
                    )
                  ),
                  Positioned.fill(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 35.0,),
                        ListTile(
                          leading: Icon(Icons.person_pin,color: Colors.white, size: 60.0),
                          title: Text(
                            "$fullname",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Avenir',
                              fontSize: 22.0,
                              fontWeight: FontWeight.w500
                            )
                          ),
                          subtitle: Text(
                            "$username",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontFamily: 'Avenir',
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if(checkStatus == true) ...[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 40.0, bottom: 0, left: 110.0, right: 0),
                  child: Icon(Icons.arrow_downward,color: Colors.blueGrey, size: 80.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40.0, bottom: 0, left: 10.0, right: 0),
                  child: Icon(Icons.arrow_upward,color: Colors.blueGrey, size: 80.0),
                )    
              ],
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, right: 8.0, left: 8.0),
                child: Stack(
                  children: <Widget>[
                    SizedBox(height: 20.0,),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(_borderRadius),
                        gradient: LinearGradient(
                          colors: [Colors.yellow, Colors.orange],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          )
                        ],
                      )
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: CustomPaint(
                        size: Size(100, 150),
                        painter: CustomCardShapePainter(_borderRadius, Colors.orange, Colors.yellow),
                      )
                    ),
                    Positioned.fill(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 35.0,),
                          ListTile(
                            leading: Icon(Icons.person_pin,color: Colors.white, size: 60.0),
                            title: Text(
                              "$requestFullname",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Avenir',
                                fontSize: 22.0,
                                fontWeight: FontWeight.w500
                              )
                            ),
                            subtitle: Text(
                              "$requestUsername",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontFamily: 'Avenir',
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          if(checkStatus == false)...[
            SizedBox(height: screenHeight(context,dividedBy: 9)),
            const Divider(
              color: Colors.grey,
              height: 0,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height: screenHeight(context,dividedBy: 9)),
            Text(
              "Herhangi bir eşleşmeniz yok.",
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Avenir',
                fontSize: 15.0,
              ),
            ),
            SizedBox(height: screenHeight(context,dividedBy:80),),
            Text(
              'Eşleşmek için lütfen "Bağlan" tuşuna basınız.',
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Avenir',
                fontSize: 15.0,
              ),
            ),
            SizedBox(height: screenHeight(context,dividedBy:30),),
            RaisedButton(
              onPressed: (){
                Navigator.pushReplacementNamed(context, '/pairs');
              },
              shape: RoundedRectangleBorder( 
                borderRadius: BorderRadius.circular(50.0),
              ),
              
              child: Text("Bağlan"),
              color: Colors.orange[500],
            )
          ],
        ],
      ),
    );
  }
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;
    var paint = Paint();

    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  bool shouldRepa(Canvas canvas, sigate) {
    throw UnimplementedError();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
