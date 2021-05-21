import 'package:google_maps_flutter/google_maps_flutter.dart';

class TestP {
  String locationName;
  LatLng location;

  TestP({this.locationName,this.location});
  
}

final List<TestP> testplist = [
  TestP(
    locationName: "大恩館",
    location: LatLng(25.136493, 121.5389585), 
  ),
   TestP(
    locationName: "大義館",
    location: LatLng(25.1360958, 121.5393095),
  )
];