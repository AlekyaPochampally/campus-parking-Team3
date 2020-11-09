import 'package:campusparking/ui/pages/Parking.dart';
import 'package:campusparking/ui/pages/user_home_page.dart';
import 'package:campusparking/ui/pages/user_home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'ParkingLotList.dart';
import 'user_home_page.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

// ignore: camel_case_types
class mapPage extends StatefulWidget {
  static const String route = '/map';

  @override
  _mapPageState createState() => _mapPageState();
}

// ignore: camel_case_types
class _mapPageState extends State<mapPage> {
  GoogleMapController mapController;
  List<Marker> allMarkers = [];
  PageController _pageController;
  int prevPage;

  @override
  void initState() {
    super.initState();
    UserHomePage.Lot_name = "PA1";
    getAvailableSlots();
    UserHomePage.Lot_name = "PA2";
    getAvailableSlots();
    UserHomePage.Lot_name = "PA3";
    getAvailableSlots();
    UserHomePage.Lot_name = "PA4";
    getAvailableSlots();
    _callLast();
    //  print('Available Maps ${UserHomePage.available}');

    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  getAvailableSlots() {
    UserHomePage.available = 0;
    _availableSlots();
  }

  _callLast() {
    lots.forEach((element) {
      print('inside another for loop');
      allMarkers.add(Marker(
          markerId: MarkerId(element.lotName),
          draggable: false,
          infoWindow: InfoWindow(
            title: element.lotName,
            snippet: 'Available Maps ${element.availableParkingLots}',
          ),
          position: element.locationCoords));
    });
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('University Map'),
        ),
        body: Stack(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 80.0,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: CameraPosition(
                    target: LatLng(40.3520, -94.8825), zoom: 15.0),
                markers: Set.from(allMarkers),
                onMapCreated: onMapCreated),
          ),
          // ignore: missing_required_param
          Positioned(
              bottom: 20.0,
              child: Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                // child: PageView.builder(
                //   controller: _pageController,
                //   itemCount: lots.length,
                //   itemBuilder: (BuildContext context, int index) {
                //     return _LotsList(index);
                //     },
              )),
          //  ),
        ]));
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  moveCamera() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: lots[_pageController.page.toInt()].locationCoords,
        zoom: 14.0,
        bearing: 30.0,
        tilt: 45.0)));
  }

  //code for available number of slots
  _availableSlots() {
    print('this is available slot function');
    print(UserHomePage.Lot_name);
    for (var slot in UserHomePage.snapshotGlobal.documentChanges) {
      //print('got inside for');
      if (slot.document.documentID.contains(UserHomePage.Lot_name)) {
        print("check parking page");
        print(slot.document.documentID);
        print(UserHomePage.Lot_name);
        //print('got inside 1st if');
        if (slot.document.data['Is_Occupied']) {
          setState(() {
            UserHomePage.available--;
            print("check parking count occupied: ${UserHomePage.available}");
            print(slot.document.documentID);
          });
        } else {
          setState(() {
            UserHomePage.available++;
            print(
                "check parking count not occupied: ${UserHomePage.available}");
            // print(slot.document.documentID);
          });
        }
      }
      //print('Available ${UserHomePage.available}');
    }
    if (UserHomePage.Lot_name.contains("PA1")) {
      print("In PA1 ${UserHomePage.available}");
      UserHomePage.parkingLot1 = UserHomePage.available;
    } else if (UserHomePage.Lot_name.contains("PA2")) {
      print("In PA2 ${UserHomePage.available}");
      UserHomePage.parkingLot2 = UserHomePage.available;
    } else if (UserHomePage.Lot_name.contains("PA3")) {
      print("In PA3 ${UserHomePage.available}");
      UserHomePage.parkingLot3 = UserHomePage.available;
    } else if (UserHomePage.Lot_name.contains("PA4")) {
      print("In PA4 ${UserHomePage.available}");
      UserHomePage.parkingLot4 = UserHomePage.available;
    }
  }
}
