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
