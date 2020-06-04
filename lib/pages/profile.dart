import 'package:flutter/material.dart';
import 'package:newapp/imports/navbar.dart';
import 'package:newapp/pages/profile_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './profile_drawer.dart';
import 'dart:ui' as ui;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double _borderRadius = 24;
  String username;
  String fullname;

  void getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      fullname = prefs.getString("fullname");
      prefs.setInt("navbarIndex", 1);
    });
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
          'Profile',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
      ),
      drawer: ProfileDrawer(),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.grey[300]),
          child: Navbar()),
      body: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 8.0, left: 8.0),
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(_borderRadius),
                        gradient: LinearGradient(
                          colors: [Colors.green, Colors.blue],
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
                      )),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: CustomPaint(
                        size: Size(100, 150),
                        painter: CustomCardShapePainter(
                            _borderRadius, Colors.blue, Colors.green),
                      )),
                  Positioned.fill(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 35.0,
                        ),
                        ListTile(
                          leading: Container(
                            width: 60.0,
                            height: 64.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(62.5),
                              border: Border.all(
                                color: Colors.grey[100],
                                width: 2,
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/Sembolic.jpg'),
                              ),
                            ),
                          ),
                          title: Text("Alperen Sarınay",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Avenir',
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w500)),
                          subtitle: Text("alperensarinay",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontFamily: 'Avenir',
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                      top: 40.0, bottom: 0, left: 0.0, right: 0),
                  child: Icon(Icons.arrow_downward,
                      color: Colors.blueGrey, size: 80.0))
            ],
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, right: 8.0, left: 8.0),
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
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
                      )),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: CustomPaint(
                        size: Size(100, 150),
                        painter: CustomCardShapePainter(
                          _borderRadius, Colors.orange, Colors.yellow),
                      )),
                  Positioned.fill(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 35.0,
                        ),
                        ListTile(
                          leading: Container(
                            width: 60.0,
                            height: 64.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(62.5),
                              border: Border.all(
                                color: Colors.grey[100],
                                width: 2,
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/Sembolic.jpg'),
                              ),
                            ),
                          ),
                          title: Text("Merthan Karadeniz",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Avenir',
                              fontSize: 22.0,
                              fontWeight: FontWeight.w500
                            )
                          ),
                          subtitle: Text("merthankaradeniz",
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

  @override
  bool shouldRepa(Canvas canvas, Sigate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
