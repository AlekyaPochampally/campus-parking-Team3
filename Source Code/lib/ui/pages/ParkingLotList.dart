import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:campusparking/ui/pages/user_home_page.dart';

class ParkingLot {
  String lotNumber;
  String lotaddress;
  int availableParkingLots;
  String totalParkingLots;
  String thumbNail;
  LatLng locationCoords;

  ParkingLot(
      {this.lotNumber,
      this.lotaddress,
      this.availableParkingLots,
      this.totalParkingLots,
      this.thumbNail,
      this.locationCoords});
}

final List<ParkingLot> lots = [
  ParkingLot(
    lotNumber: 'Lot1',
    lotaddress: 'Olive Deluce',
    availableParkingLots: UserHomePage.available,
    totalParkingLots: '20',
    locationCoords: LatLng(40.348806, -94.88442),
    // thumbNail:
    //'https://lh5.googleusercontent.com/p/AF1QipNNzoa4RVMeOisc0vQ5m3Z7aKet5353lu0Aah0a=w90-h90-n-k-no'
  ),
  ParkingLot(
    lotNumber: 'Lot2',
    lotaddress: 'Olive Deluce',
    availableParkingLots: UserHomePage.available,
    totalParkingLots: '30',
    // thumbNail:
    // 'https://lh5.googleusercontent.com/p/AF1QipNNzoa4RVMeOisc0vQ5m3Z7aKet5353lu0Aah0a=w90-h90-n-k-no',
    locationCoords: LatLng(40.34841, -94.884125),
  ),
  ParkingLot(
    lotNumber: 'Lot3',
    lotaddress: 'Wellness Center',
    availableParkingLots: UserHomePage.available,
    totalParkingLots: '30',
    //thumbNail:
    //'https://lh5.googleusercontent.com/p/AF1QipNNzoa4RVMeOisc0vQ5m3Z7aKet5353lu0Aah0a=w90-h90-n-k-no',
    locationCoords: LatLng(40.355160, -94.890433),
  ),
  ParkingLot(
    lotNumber: 'Lot4',
    lotaddress: 'Wellness Center',
    availableParkingLots: UserHomePage.available,
    totalParkingLots: '30',
    // thumbNail:
    // 'https://lh5.googleusercontent.com/p/AF1QipNNzoa4RVMeOisc0vQ5m3Z7aKet5353lu0Aah0a=w90-h90-n-k-no'
    //,
    locationCoords: LatLng(40.351528, -94.889182),
  ),
  ParkingLot(
    lotNumber: 'Lot5',
    lotaddress: 'Admin Building Parking lot',
    availableParkingLots: UserHomePage.available,
    totalParkingLots: '30',
    // thumbNail:
    // 'https://lh5.googleusercontent.com/p/AF1QipNNzoa4RVMeOisc0vQ5m3Z7aKet5353lu0Aah0a=w90-h90-n-k-no'
    //,
    locationCoords: LatLng(40.355605, -94.883010),
  ),
  ParkingLot(
    lotNumber: 'Lot6',
    lotaddress: 'Facility Services East',
    availableParkingLots: UserHomePage.available,
    totalParkingLots: '30',
    // thumbNail:
    // 'https://lh5.googleusercontent.com/p/AF1QipNNzoa4RVMeOisc0vQ5m3Z7aKet5353lu0Aah0a=w90-h90-n-k-no'
    //,
    locationCoords: LatLng(40.354085, -94.880663),
  ),
];
