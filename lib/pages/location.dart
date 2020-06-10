import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:newapp/imports/navbar.dart';
import 'package:newapp/pages/profile_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FindLocation extends StatefulWidget{
  @override
  _FindLocationState createState() => _FindLocationState();
}

class _FindLocationState extends State<FindLocation>{

  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  GoogleMapController _controller;
  Marker marker;
  Circle circle;
  double initZoom = 15;
  Timer timer;
  Timer timer2;
  bool isSwitched=false;
  int timerCnt = 1000;
  String apiToken;

  double latitude;
  double longitude;
  double myLatitude;
  double myLongitude;

  String responseMessage;

  void doStuff() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt("navbarIndex", 0);
      apiToken =  prefs.getString("apiToken");
    });

    Map<String,String> headers = {
      'Content-type' : 'application/json', 
      'Accept': 'application/json',
      'Authorization':'$apiToken'
    };

    final response = await http.post("http://34.72.70.18/api/users/pairLocation", headers: headers);

    if(response.statusCode == 200){
      var datauser = json.decode(response.body);
      setState(() {
        responseMessage = datauser["data"]["message"];
        longitude = double.parse(datauser["data"]["longitude"]);
        latitude = double.parse(datauser["data"]["latitude"]);
      });
      print(responseMessage);
      print("Pair latitude:" + latitude.toString());
      print("Pair longitude:" + longitude.toString());
    }
  }

  void shareLocation(String activeStatus) async{
    Map<String,String> headers = {
      'Content-type' : 'application/json', 
      'Accept': 'application/json',
      'Authorization':'$apiToken'
    };
    
    getMyLocation();

    var body = json.encode({
      "isActive": activeStatus,
      "y_cordinate": myLatitude,
      "x_cordinate": myLongitude,
    });

    print("Location Update: 5 seconds");
    final response = await http.post("http://34.72.70.18/api/users/savelocation", headers: headers, body: body);
  }

  @override
  void initState() {
    doStuff();
  }

  void getMyLocation() async {
    var location = await _locationTracker.getLocation();
    setState(() {
        myLatitude = location.latitude;
        myLongitude = location.longitude;
    });
  }

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(41.08, 29),
    zoom: 15.0
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/images/car_icon.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData){
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
        markerId: MarkerId("home"),
        position: latlng, 
        rotation: newLocalData.heading, // kullanıcının baktığı yer
        draggable: false, 
        zIndex: 2,
        flat: true, // Map'i eğince yapışık kalması
        anchor: Offset(0.5,0.5), // image'ın orta noktasını seçiyor
        icon: BitmapDescriptor.fromBytes(imageData) 
      );
      circle = Circle(
        circleId: CircleId("car"),
        radius: newLocalData.accuracy,
        zIndex: 1,
        strokeColor: Colors.blue,
        center: latlng,
        fillColor: Colors.blue.withAlpha(70)
      );
    });
  }

  void getPairLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var dataMap = new Map<String, double>();
      doStuff();

      setState(() {
        dataMap = {
          'latitude': latitude,
          'longitude': longitude,
          'accuracy': 0,
          'altitude': 0,
          'speed': 0,
          'speed_accuracy': 0,
          'heading': 0,
          'time' : 0,
        };
      });
      
      var location = new LocationData.fromMap(dataMap);

      updateMarkerAndCircle(location,imageData);

      if(_locationSubscription != null){
        _locationSubscription.cancel();
      }

      if(_controller != null){
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            new CameraPosition(
              bearing: 0.0,
              target: LatLng(latitude, longitude),
              tilt: 0,
              zoom: initZoom
            )
          )
        );
        updateMarkerAndCircle(location,imageData);
      }
      
    } on PlatformException catch (e) {
      if(e.code == "PERMISSION_DENIED"){
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose(){
    if(_locationSubscription != null){
        _locationSubscription.cancel();
      }
    super.dispose();
    timer.cancel();
    timer2.cancel();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Find Pair"),),
      drawer: ProfileDrawer(),
      body:GoogleMap(
        zoomGesturesEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: initialLocation,
        markers: Set.of((marker != null) ? [marker]: []),
        circles: Set.of((circle != null) ? [circle]: []),
        onMapCreated: (GoogleMapController controller){
          _controller = controller;
        },
        onCameraMove:(CameraPosition cameraPosition){
          initZoom = cameraPosition.zoom;
        },
      ),
      persistentFooterButtons: <Widget>[
        Text("Share your location"),
        Switch(
          value: isSwitched,
          onChanged: (value){
            setState(() {
              isSwitched=value;
              if(value == true){
                timerCnt = 5;
                timer = Timer.periodic(Duration(seconds: timerCnt), (Timer t) => shareLocation("1"));
              }else if(value == false){
                shareLocation("0");
                timer.cancel();
              }
            });
          },
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.green,
        ),
      ],
      bottomNavigationBar: Navbar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching),
        onPressed: (){
          //timer2 = Timer.periodic(Duration(seconds: 1), (Timer t) => getPairLocation());
          getPairLocation();
        },
      ),
    );
  }
}