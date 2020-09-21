//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campusparking/ui/widgets/app_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'
    show
        CameraPosition,
        CameraUpdate,
        GoogleMap,
        GoogleMapController,
        LatLng,
        MapType;

// ignore: camel_case_types
class mapPage extends StatefulWidget {
  static const String route = '/map';

  @override
  _mapPageState createState() => _mapPageState();
}

// ignore: camel_case_types
class _mapPageState extends State<mapPage> {
  @override
  void initState() {
    super.initState();
  }

  GoogleMapController _controller;
  final CameraPosition _initialPosition =
      CameraPosition(target: LatLng(39.8411, 96.6472));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ApplicationBar(),
        body: GoogleMap(
          initialCameraPosition: _initialPosition,
          mapType: MapType.normal,
          onMapCreated: (controller) {
            setState(() {
              _controller = controller;
            });
          },
          onTap: (cordinate) {
            _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
          },
          // child: ListView(children: <Widget>[
          //   Container(
          //     alignment: Alignment.center,
          //     padding: EdgeInsets.all(10),
          //     child: Text(
          //       'University Map',
          //       style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
          //     ),
          //   ),
          //   Container(
          //     alignment: Alignment.center,
          //     child: Text(
          //       'Zoom in and out for better view',
          //     ),
          //   ),
          //   SizedBox(
          //   height: 20,
          //   ),
          //   Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Image.asset('assets/images/map.jpg'),
          //   ),
          //   ),//Expanded
          // ]),
        ));
  }
}
//Expanded(
//child: Padding(
//padding: const EdgeInsets.all(8.0),
//child: Zoom(
//width: 1800,
//height: 1800,
//child: Image.asset('assets/images/map.jpg')
//),
//),
//),
