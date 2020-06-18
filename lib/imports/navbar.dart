import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Navbar extends StatefulWidget{
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {

  void getNavbarIndex() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      page = prefs.getInt("navbarIndex");
    });
  }

  @override
  void initState(){
    getNavbarIndex();
  }
  
  int page = 1;

  void changePage(int index){
    setState(() {
      page = index;
    });
    gotoPage(page);
  }

  gotoPage(int page){
    if(page == 0){
      Navigator.pushReplacementNamed(context, '/location');
    }
    else if(page == 1){
      Navigator.pushReplacementNamed(context, '/profile');
    }
    else if(page == 2){
      Navigator.pushReplacementNamed(context, '/pairs');
    }
  }

  Widget build(BuildContext context){
    return(
      BottomNavigationBar(
        currentIndex: page,
        onTap: changePage,
        type: BottomNavigationBarType.fixed,
        iconSize: 35,
        fixedColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.location_on),title: SizedBox( height: 0,),),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),title: SizedBox(height: 0,),),
          BottomNavigationBarItem(icon: Icon(Icons.people),title: SizedBox(height: 0,),),
        ],
      )
    );
  }
}
