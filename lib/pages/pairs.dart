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
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: 500,
          height: 540,
          child: Material(
            color: Colors.grey[300],
            elevation: 14.0,
            borderRadius: BorderRadius.circular(10.0),
            shadowColor: Colors.blue,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: <Widget>[
                      Container(
                        height: 50,
                        child: const Text.rich(
                          TextSpan(
                            text: 'Gönderen:', // default text style
                            children: <TextSpan>[
                              TextSpan(
                                text: ' atakde ',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.green[500],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
                        child: Center(
                          child: Text(
                            "Kabul et",
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.red[500],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
                        child: Center(
                          child: Text(
                            "Reddet",
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
                          ),
                        ),
                      ),
                      Divider(),
                      Container(
                        height: 50,
                        child: Text(
                          "Bağlantı Ekle:",
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Bağlantı kodunu giriniz.'
                          ),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.blue[500],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
                        child: Center(
                          child: Text(
                            "Gonder",
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
                          ),
                        ),
                      ),
                      Divider(),
                      Text(
                        "Bağlantı Kodunuz:",
                        style:TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      SizedBox( height: 5,),
                      Container(
                        height: 30,
                        child: Text(
                          "15123AXEQWE%?ADSF",
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(height: 10,),
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.purple[500],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
                        child: Center(
                          child: Text(
                            "Sıfırla",
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
