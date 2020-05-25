import 'package:flutter/material.dart';
import "package:flutter/material.dart";

class MemberPage extends StatefulWidget {
    @override
    _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {

  int page = 0;
  void changePage(int index){
    setState(() {
      page = index;
    });
    gotoPage(page);
  }

  Widget gotoPage(int page){
    if(page == 0){
      Navigator.pushReplacementNamed(context, '/register');
    }
    else if(page == 1){
      Navigator.pushReplacementNamed(context, '/register');
    }
    else if(page == 2){
      Navigator.pushReplacementNamed(context, '/register');
    }
  }

  // _MemberPageState({this.username});
  // final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sevgilim Nerede?"),),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.grey[100]),
          child: BottomNavigationBar(
            currentIndex: page,
            onTap: changePage,
            type: BottomNavigationBarType.fixed,
            iconSize: 35,
            fixedColor: Colors.black,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: SizedBox(
                  height: 0,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                title: SizedBox(
                  height: 0,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: SizedBox(
                  height: 0,
                ),
              ),
            ],
          ),
        // children: <Widget>[
          //Text('Hallo $username', style: TextStyle(fontSize: 20.0),),
          // RaisedButton(
          //   child: Text("Logout"),
          //   onPressed: (){
          //     Navigator.pushReplacementNamed(context,'/');
          //   },
          // ),
        // ],

      ),
      body: Column(
        
      )
    );
  }
}

