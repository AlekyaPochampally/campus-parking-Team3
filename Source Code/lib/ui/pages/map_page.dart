import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'ParkingLotList.dart';
import 'package:campusparking/ui/widgets/app_bar.dart';

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
    lots.forEach((element) {
      allMarkers.add(Marker(
          markerId: MarkerId(element.lotNumber),
          draggable: false,
          infoWindow: InfoWindow(
            title: element.lotNumber,
            snippet: element.availableParkingLots.toString(),
          ),
          position: element.locationCoords));
    });
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }

  // Widget _LotsList(int index) {
  //   return AnimatedBuilder(
  //     animation: _pageController,
  //     builder: (BuildContext context, Widget widget) {
  //       double value = 1;
  //       if (_pageController.position.haveDimensions) {
  //         value = _pageController.page - index;
  //         value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
  //       }
  //       return Center(
  //         child: SizedBox(
  //           height: Curves.easeInOut.transform(value) * 125.0,
  //           width: Curves.easeInOut.transform(value) * 350.0,
  //           child: widget,
  //         ),
  //       );
  //     },
  //     child: InkWell(
  //         onTap: () {
  //           // moveCamera();
  //         },
  //         child: Stack(children: [
  //           Center(
  //               child: Container(
  //                   margin: EdgeInsets.symmetric(
  //                     horizontal: 10.0,
  //                     vertical: 20.0,
  //                   ),
  //                   height: 125.0,
  //                   width: 275.0,
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(10.0),
  //                       boxShadow: [
  //                         BoxShadow(
  //                           color: Colors.black54,
  //                           offset: Offset(0.0, 4.0),
  //                           blurRadius: 10.0,
  //                         ),
  //                       ]),
  //                   child: Container(
  //                       decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(10.0),
  //                           color: Colors.white),
  //                       child: Row(children: [
  //                         Container(
  //                             height: 90.0,
  //                             width: 90.0,
  //                             decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.only(
  //                                     bottomLeft: Radius.circular(10.0),
  //                                     topLeft: Radius.circular(10.0)),
  //                                 image: DecorationImage(
  //                                     image:
  //                                         NetworkImage(lots[index].thumbNail),
  //                                     fit: BoxFit.cover))),
  //                         SizedBox(width: 5.0),
  //                         Column(
  //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 lots[index].lotNumber,
  //                                 style: TextStyle(
  //                                     fontSize: 12.5,
  //                                     fontWeight: FontWeight.bold),
  //                               ),
  //                               Text(
  //                                 lots[index].lotaddress,
  //                                 style: TextStyle(
  //                                     fontSize: 12.0,
  //                                     fontWeight: FontWeight.w600),
  //                               ),
  //                               Container(
  //                                 width: 170.0,
  //                                 child: Text(
  //                                   lots[index].totalParkingLots,
  //                                   style: TextStyle(
  //                                       fontSize: 11.0,
  //                                       fontWeight: FontWeight.w300),
  //                                 ),
  //                               )
  //                             ])
  //                       ]))))
  //         ])),
  //   );
  // }

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
                //   },
              )),
          //),
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
}
