import 'package:flutter/material.dart';
import 'package:newapp/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDrawer extends StatefulWidget {
    @override
    _ProfileDrawerState createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer>{
  @override

  String user_id;
  String apiToken;
  String authToken;
  String username;
  String fullname;
  String emailUser;

  void getSessions() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getString("user_id");
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
                    width : 100,
                    height : 100,
                    margin : EdgeInsets.only(top:10.0),
                    decoration : BoxDecoration(
                      borderRadius: BorderRadius.circular(62.5),
                      border: Border.all(color: Colors.grey[100],width: 2,),
                      image : DecorationImage(fit: BoxFit.cover, image : AssetImage('assets/images/Sembolic.jpg'),),
                    ),
                    child: Icon(Icons.add_a_photo,color: Colors.grey,),
                    alignment: Alignment(-1.1,1.35)
                  ),
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
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height : 140.0,),
          ListTile(
            leading: Icon(Icons.exit_to_app,color : Colors.black,size : 30.0),
            onTap: () =>{ 
              Icons.forward_30,
              _logout()
            },
            title: Text('Logout',
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

}