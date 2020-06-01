import 'package:flutter/material.dart';

class ProfileDrawer extends StatelessWidget{

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
                      margin : EdgeInsets.only(top:10.0
                      ),
                      decoration : BoxDecoration(
                        borderRadius: BorderRadius.circular(62.5),
                          border: Border.all(
                            color: Colors.grey[100],
                            width: 2,
                          ),
                        image : DecorationImage(
                          fit: BoxFit.cover,
                          image : AssetImage('assets/images/Sembolic.jpg'),
                        )
                      )
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height : 20.0,),
            ListTile(
              leading: Icon(Icons.person,color : Colors.black,size : 30.0),
              onTap: () => Icons.forward_30,
              title: Text('Alperen Sarınay',
                style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15.0,
                color: Colors.black,
          ),),
            ),
            SizedBox(height : 10.0,),
            ListTile(
              leading: Icon(Icons.person_outline,color : Colors.black,size : 30.0),
              onTap: () => Icons.forward_30,
              title: Text('Phaladis',
                style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15.0,
                color: Colors.black,
          ),),
            ),
            SizedBox(height : 10.0,),
            ListTile(
              leading: Icon(Icons.mail,color : Colors.black,size : 30.0),
              onTap: () => Icons.forward_30,
              title: Text('alperen@alperen.com',
                style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15.0,
                color: Colors.black,
          ),),
            ),
            SizedBox(height : 10.0,),
            ListTile(
              leading: Icon(Icons.lock_outline,color : Colors.black,size : 30.0),
              onTap: () => Icons.forward_30,
              title: Text('*****',
                style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20.0,
                color: Colors.black,
          ),),
            ),
            SizedBox(height : 140.0,),
              ListTile(
              leading: Icon(Icons.exit_to_app,color : Colors.black,size : 30.0),
              onTap: () => Icons.forward_30,
              title: Text('Logout',
                style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15.0,
                color: Colors.black,
          ),),
            ),
          ]
        ) 
      );
}

}