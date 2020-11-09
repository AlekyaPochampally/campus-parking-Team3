import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:campusparking/ui/pages/user_home_page.dart';

class ParkingLot {
  String lotName;
  int availableParkingLots;
  LatLng locationCoords;
  
  void set availableSlots(int slots) {
    availableParkingLots = slots;
  }

  ParkingLot({this.lotName, this.availableParkingLots, this.locationCoords});
}

List<ParkingLot> lots = [
  ParkingLot(
    lotName: 'PA1',
    availableParkingLots: UserHomePage.parkingLot1,
    locationCoords: LatLng(40.34841, -94.884125),
  ),
  ParkingLot(
    lotName: 'PA2',
    availableParkingLots: UserHomePage.parkingLot2,
    locationCoords: LatLng(40.355160, -94.890433),
  ),
  ParkingLot(
    lotName: 'PA3',
    availableParkingLots: UserHomePage.parkingLot3,
    locationCoords: LatLng(40.351838, -94.886817),
  ),
  ParkingLot(
    lotName: 'PA4',
    availableParkingLots: UserHomePage.parkingLot4,
    locationCoords: LatLng(40.354085, -94.880663),
  ),
];
