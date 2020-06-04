import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:newapp/imports/navbar.dart';
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

  void doStuff() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt("navbarIndex", 0);
    });
  }
  @override
  void initState() {
    doStuff();
  }

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(37.427961133580664, 122.0855749655962),
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

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location,imageData);

      if(_locationSubscription != null){
        _locationSubscription.cancel();
      }

      _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData){
        if(_controller != null){
          _controller.animateCamera(
            CameraUpdate.newCameraPosition(
              new CameraPosition(
                bearing: 0.0,
                target: LatLng(newLocalData.latitude, newLocalData.longitude),
                tilt: 0,
                zoom: initZoom
              )
            )
          );
          updateMarkerAndCircle(newLocalData,imageData);
        }
      });
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
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Find Pair"),),
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
          print(cameraPosition.zoom);
        },
      ),
      bottomNavigationBar: Navbar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching),
        onPressed: (){
          getCurrentLocation();
        },
      ),
    );
  }
}