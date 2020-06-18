import 'package:flutter/material.dart';
import 'package:newapp/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDrawer extends StatefulWidget {
    @override
    _ProfileDrawerState createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer>{
  String userId;
  String apiToken;
  String authToken;
  String username;
  String fullname;
  String emailUser;
  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double screenHeight(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).height / dividedBy;
  }

  double screenWidth(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).width / dividedBy;
  }

  void getSessions() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString("user_id");
      apiToken = prefs.getString("apiToken");
      authToken = prefs.getString("authToken");
      username = prefs.getString("username");
      fullname = prefs.getString("fullname");
      emailUser = prefs.getString("email");
    });
  }

  void initState() {
    super.initState();
    getSessions();
  }

  @override
  Widget build (BuildContext context){
    return Drawer(
      child : Column(
        children:<Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(50),
            color: Colors.black87,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    margin : EdgeInsets.only(top:10.0),
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/logo.png'), )
                    )
                  )
                ],
              ),
            ),
          ),
          SizedBox(height : 20.0,),
          ListTile(
            leading: Icon(Icons.person,color : Colors.black,size : 30.0),
            onTap: () => Icons.forward_30,
            title: Text('$fullname',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height : 10.0,),
          ListTile(
            leading: Icon(Icons.person_outline,color : Colors.black,size : 30.0),
            onTap: () => Icons.forward_30,
            title: Text('$username',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height : 10.0,),
          ListTile(
            leading: Icon(Icons.mail,color : Colors.black,size : 30.0),
            onTap: () => Icons.forward_30,
            title: Text('$emailUser',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height : 10.0,),
          ListTile(
            leading: Icon(Icons.lock_outline,color : Colors.black,size : 30.0),
            onTap: () => Icons.forward_30,
            title: Text('$authToken',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: screenHeight(context,dividedBy:5),),
          ListTile(
            leading: Icon(Icons.exit_to_app,color : Colors.black,size : 30.0),
            onTap: () =>{ 
              Icons.forward_30,
              _logout()
            },
            title: Text(
              'Çıkış Yap',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
          ),
        ]
      ) 
    );
  }

  void _logout() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user_id", null);
    prefs.setString("apiToken", null);
    prefs.setString("authToken", null);
    prefs.setString("username", null);
    prefs.setString("fullname", null);
    prefs.setString("email", null);
    prefs.setBool("isLoggedIn", false);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

}