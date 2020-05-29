import 'package:flutter/material.dart';
import 'package:newapp/imports/navbar.dart';

class Pairs extends StatefulWidget {
  @override
  _PairesPageState createState() => _PairesPageState();
}

class _PairesPageState extends State<Pairs> {

  Navbar navbar = new Navbar();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bağlantı"),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.grey[300]),
        child: navbar
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[ 
            Container(
              height : 180,
              child :Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                elevation: 5.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.person, size: 50),
                      title: Text('Name Surname'),
                      subtitle: Text('Username'),
                    ),
                    SizedBox(height :30,),
                    ButtonBar(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {},
                          color: Colors.green[500],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                          child: Center(child: Text("Kabul et",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),),
                        ),
                        RaisedButton(
                          onPressed: () {},
                          color: Colors.red[500],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                          child: Center(child: Text("Reddet",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height : 180,
              child :Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                elevation: 5.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(title: Text('Kod Giriniz',style: TextStyle(fontSize : 20,fontWeight: FontWeight.w900),),),
                    TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.edit),
                        border: InputBorder.none,
                        hintText: 'Bağlantı kodunu giriniz.'
                      ),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {},
                          color: Colors.blue[500],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                          child: Center(child: Text("Gönder",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height : 180,
              child :Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                elevation: 5.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      title: Text('Kodunuz',style: TextStyle(fontSize : 20,fontWeight: FontWeight.w900),),
                      subtitle: Text('23467ABGHL54SD'),
                    ),
                    SizedBox(height : 30,),
                    ButtonBar(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {},
                          color: Colors.blue[500],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                          child: Center(child: Text("Sıfırla",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
