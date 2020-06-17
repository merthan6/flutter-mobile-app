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
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FindLocation extends StatefulWidget{
  @override
  _FindLocationState createState() => _FindLocationState();
}

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).height / dividedBy;
}

double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
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
  bool doesHavePair = false;

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

    final responseCheck = await http.post("http://34.72.70.18/api/users/checkPair", headers: headers);
    if(responseCheck.statusCode == 200){
      var datauser = json.decode(responseCheck.body);
      setState(() {
        doesHavePair = datauser["data"]["success"];
        print(doesHavePair);
      });
    }

    final response = await http.post("http://34.72.70.18/api/users/pairLocation", headers: headers);

    if(response.statusCode == 200){
      var datauser = json.decode(response.body);
      setState(() {
        responseMessage = datauser["data"]["message"];
        if(datauser["data"]["longitude"] != null){
          longitude = double.parse(datauser["data"]["longitude"]);
          latitude = double.parse(datauser["data"]["latitude"]);
        }
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
      "y_cordinate": myLongitude,
      "x_cordinate": myLatitude,
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
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/images/128x128_heart.png");
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
    if(timer != null)
      timer.cancel();
    if(timer2 != null)
      timer2.cancel();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Konum"),
      centerTitle: true,
      ),
      drawer: ProfileDrawer(),
      body:
      Column(
        children: <Widget>[
          if(doesHavePair == true)...[
            Expanded(
                child: GoogleMap(
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
            ),
          ],
          if(doesHavePair == false)...[
            SizedBox(height: screenHeight(context,dividedBy: 7)),
            const Divider(
              color: Colors.grey,
              height: 0,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height: screenHeight(context,dividedBy: 18)),
            Icon(Icons.warning, color: Colors.red,size: screenHeight(context,dividedBy: 16),),
            SizedBox(height: screenHeight(context,dividedBy: 18)),
            Text(
              "Herhangi bir eşleşmeniz yok.",
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Avenir',
                fontSize: 15.0,
              ),
            ),
            SizedBox(height: screenHeight(context,dividedBy:80),),
            Text(
              'Eşleşmek için lütfen "Bağlan" tuşuna basınız.',
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Avenir',
                fontSize: 15.0,
              ),
            ),
            SizedBox(height: screenHeight(context,dividedBy:17),),
            RaisedButton(
              onPressed: (){
                Navigator.pushReplacementNamed(context, '/pairs');
              },
              shape: RoundedRectangleBorder( 
                borderRadius: BorderRadius.circular(50.0),
              ),
              
              child: Text("Bağlan"),
              color: Colors.orange[500],
            ),
            SizedBox(height: screenHeight(context,dividedBy: 15)),
            const Divider(
              color: Colors.grey,
              height: 0,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
          ]
        ],
      ),
      persistentFooterButtons: <Widget>[
        if(doesHavePair == true)...[
          Text("Konum verilerini paylaş"),
          Switch(
            value: isSwitched,
            onChanged: (value){
              setState(() {
                isSwitched=value;
                if(value == true){
                  timerCnt = 5;
                  timer = Timer.periodic(Duration(seconds: timerCnt), (Timer t  ) => shareLocation("1"));
                }else if(value == false){
                  shareLocation("0");
                  timer.cancel();
                }
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
        ]
      ],
      bottomNavigationBar: Navbar(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          if(doesHavePair) ...[
            FloatingActionButton(
              child: Icon(Icons.location_searching),
              onPressed: (){
                //timer2 = Timer.periodic(Duration(seconds: 1), (Timer t) => getPairLocation());
                if(latitude == null || longitude == null){
                  print(responseMessage);
                  return Alert(
                    context: context,
                    title: "Konum Bulma Hatası",
                    desc: "Eşleştiğiniz kişinin konum verisi henüz girilmemiş.",
                    buttons: [
                      DialogButton(
                        child: Text("Anladım."),
                        onPressed: () => Navigator.pop(context),
                      )
                    ]
                  ).show();
                }
                else{
                  getPairLocation();
                }
              },
            ),
          ], 
        ],
      ),
    );
  }
}