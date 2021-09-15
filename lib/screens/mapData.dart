import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Coffee {
  String shopName;
  String address;
  String description;
  String thumbNail;
  LatLng locationCoords;

  Coffee(
      {this.shopName,
        this.address,
        this.description,
        this.thumbNail,
        this.locationCoords});
}

final List<Coffee> coffeeShops = [
  Coffee(
      shopName: 'Wide Area Works',
      address: '56 Fulham Rd, Brixton, Johanne...',
      description:
      'Hello I Am Andrew and I do Decor',
      locationCoords: LatLng(-26.190913, 27.995585),
      thumbNail: 'https://www.yourfreecareertest.com/wp-content/uploads/2017/12/what_does_a_painter_do.jpg'
  ),
//  Coffee(
//      shopName: 'Wide Area Works',
//      address: 'Cnr Kingsway & University Roads, Auckland Park, Johannesburg, 2092',
//      description:
//      'Hello I Am Andrew and I do Decor',
//      locationCoords: LatLng(-26.1811711, 28.0001275),
//      thumbNail: 'https://www.yourfreecareertest.com/wp-content/uploads/2017/12/what_does_a_painter_do.jpg'
//  ),
//  Coffee(
//      shopName: 'Wide Area Works',
//      address: 'Cnr Kingsway & University Roads, Auckland Park, Johannesburg, 2092',
//      description:
//      'Hello I Am Andrew and I do Decor',
//      locationCoords: LatLng(-26.1811711, 28.0001275),
//      thumbNail: 'https://www.yourfreecareertest.com/wp-content/uploads/2017/12/what_does_a_painter_do.jpg'
//  ),
  Coffee(
      shopName: 'House Decor',
      address: 'Cnr Kingsway & University R...',
      description:
      'Hello I Am James and I do Decor',
      locationCoords: LatLng(-26.1811711, 28.0001275),
      thumbNail: 'https://firebasestorage.googleapis.com/v0/b/gkc01-20278.appspot.com/o/uploads%2Fmanchester-united-striker-zlatan-ibrahimovic.jpg?alt=media&token=4478e9dd-0145-4819-999d-a6aa543d815b'
  ),Coffee(
      shopName: 'Cromwell Constructions',
      address: '116 Kwagga St, Langlaagte, Johann...',
      description:
      'Hello I Am Martin and I do Architecture',
      locationCoords: LatLng(-26.2049339, 27.9846177),
      thumbNail: 'ttps://www.yourfreecareertest.com/wp-content/uploads/2017/12/what_does_a_painter_do.jpg'
  ),
];



