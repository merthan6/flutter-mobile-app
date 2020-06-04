import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class FindLocation extends StatefulWidget{
  @override
  _FindLocationState createState() => _FindLocationState();
}

class _FindLocationState extends State<FindLocation>{

  String _locationMessage = "";

  void _getCurrentLocation() async {
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    setState(() {
      _locationMessage = "${position.latitude}, ${position.longitude}";
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("$_locationMessage"),
            FlatButton(
              onPressed: () {
                _getCurrentLocation();
              },
              color: Colors.green,
              child: Text("Find Location"),
            )
          ],
        )
      ),
    );
  }
}