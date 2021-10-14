import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
void main() {
  runApp( const MaterialApp(
    home:  Loc()
  ));
}

class Loc extends StatefulWidget {
  const Loc({Key? key}) : super(key: key);

  @override
  _LocState createState() => _LocState();
}

class _LocState extends State<Loc> {

  void getLocation() async{
    Location location = Location();
    try {
      location.enableBackgroundMode(enable: true);
    }catch(e){
      print("error");
    }
    location.changeSettings( interval: 10000);
    location.onLocationChanged.listen((LocationData currentLocation) {
      print(currentLocation);
    });
  }

  void ServiceEnable() async {

    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    }

    @override
    void initState() {
      super.initState();
      ServiceEnable();
      getLocation();

    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Package"),
      ),
    );
  }
}
