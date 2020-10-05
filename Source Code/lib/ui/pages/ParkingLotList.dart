import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParkingLot {
  String LotNumber;
  String Lotaddress;
  String AvailableParkingLots;
  String TotalParkingLots;
  String thumbNail;
  LatLng locationCoords;

  ParkingLot(
      {this.LotNumber,
      this.Lotaddress,
      this.AvailableParkingLots,
      this.TotalParkingLots,
      this.thumbNail,
      this.locationCoords});
}

final List<ParkingLot> lots = [
  ParkingLot(
      LotNumber: 'Lot1',
      Lotaddress: 'Olive Deluce',
      AvailableParkingLots: '2',
      TotalParkingLots: '20',
      locationCoords: LatLng(40.348806, -94.88442),
      thumbNail:
          'https://lh5.googleusercontent.com/p/AF1QipNNzoa4RVMeOisc0vQ5m3Z7aKet5353lu0Aah0a=w90-h90-n-k-no'),
  ParkingLot(
    LotNumber: 'Lot2',
    Lotaddress: 'Olive Deluce',
    AvailableParkingLots: '10',
    TotalParkingLots: '30',
    thumbNail:
        'https://lh5.googleusercontent.com/p/AF1QipNNzoa4RVMeOisc0vQ5m3Z7aKet5353lu0Aah0a=w90-h90-n-k-no',
    locationCoords: LatLng(40.34841, -94.884125),
  ),
  ParkingLot(
    LotNumber: 'Lot3',
    Lotaddress: 'Wellness Center',
    AvailableParkingLots: '10',
    TotalParkingLots: '30',
    thumbNail:
        'https://lh5.googleusercontent.com/p/AF1QipNNzoa4RVMeOisc0vQ5m3Z7aKet5353lu0Aah0a=w90-h90-n-k-no',
    locationCoords: LatLng(40.355160, -94.890433),
  ),
  ParkingLot(
    LotNumber: 'Lot3',
    Lotaddress: 'Wellness Center',
    AvailableParkingLots: '10',
    TotalParkingLots: '30',
    thumbNail:
        'https://lh5.googleusercontent.com/p/AF1QipNNzoa4RVMeOisc0vQ5m3Z7aKet5353lu0Aah0a=w90-h90-n-k-no',
    locationCoords: LatLng(40.355052, -94.890128),
  ),
];
