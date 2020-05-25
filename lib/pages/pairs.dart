import 'package:flutter/material.dart';

class pairs extends StatefulWidget {
    @override
    _pairesPageState createState() => _pairesPageState ();
}


class _pairesPageState extends State<pairs> {
@override
  int page = 0;
  void changePage(int index){
    setState(() {
      page = index;
    });
    gotoPage(page);
  }

  Widget gotoPage(int page){
    if(page == 0){
      Navigator.pushReplacementNamed(context, '');
    }
    else if(page == 1){
      Navigator.pushReplacementNamed(context, '');
    }
    else if(page == 2){
      Navigator.pushReplacementNamed(context, '');
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Sevgilim Nerede?"),),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.grey[300]),
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
          ),
          body: Container(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: 500,
              height: 100,
              child: Material(
                color : Colors.white,
                elevation : 14.0,
                borderRadius: BorderRadius.circular(10.0),
                shadowColor : Colors.blue,
                child: Row(
                  children : <Widget>[
                    Expanded(
                      child: Column( 
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                        children: <Widget>[
                          Text(
                            "Name Surname",
                          )
                        ],
                      ),
                      
                    )
                  ]
                ),
              ),
            ),
          ),
    );
  }
}