import 'package:flutter/material.dart';

class Navbar extends StatefulWidget{
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {

  int page = 0;

  void changePage(int index){
    setState(() {
      page = index;
    });
    gotoPage(page);
  }

  Widget gotoPage(int page){
    if(page == 0){
      Navigator.pushReplacementNamed(context, '/memberpage');
      print("0");
    }
    else if(page == 1){
      Navigator.pushReplacementNamed(context, '/memberpage');
      print("1");
    }
    else if(page == 2){
      Navigator.pushReplacementNamed(context, '/memberpage');
      print("2");
    }
    else if(page == 3){
      Navigator.pushReplacementNamed(context, '/pairs');
      print("3");
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
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: SizedBox(
              height: 0,
            ),
          ),
        ],
      )
    );
  }
}
