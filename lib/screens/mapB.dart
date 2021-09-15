//import 'dart:async';
//import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:location/location.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//
//class MapSample extends StatefulWidget {
//  @override
//  State<MapSample> createState() => MapSampleState();
//}
//
//class MapSampleState extends State<MapSample> {
//  final FirebaseFirestore _database = FirebaseFirestore.instance;
//  Completer<GoogleMapController> _controller = Completer();
//  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
//
//  @override
//  void initState(){
//    crearmarcadores();
//    super.initState();
//  }
//
//  crearmarcadores(){
//    _database.collection('Lugares')
////        .where('tipo', isEqualTo: 'café')
////        .where('tipo', isEqualTo: 'negocio')
////        .where('tipo', isEqualTo: 'parque')
////        .where('tipo', isEqualTo: 'peluqueria')
////        .where('tipo', isEqualTo: 'plaza')
////        .where('tipo', isEqualTo: 'restaurant')
////        .where('tipo', isEqualTo: 'tienda')
//        .get().then((docs) {
//      if(docs.docs.isNotEmpty){
//        for(int i= 0; i < docs.docs.length; i++) {
//          initMarker(docs.docs[i].data, docs.docs[i].id);
//        }
//      }
//    });
//  }
//  void initMarker(lugar, lugaresid) {
//    var markerIdVal = lugaresid;
//    final MarkerId markerId = MarkerId(markerIdVal);
//
//    // creating a new MARKER
//    final Marker marker = Marker(
//      markerId: markerId,
//      position: LatLng(lugar['Latitud'], lugar['Longitud']),
//      infoWindow: InfoWindow(title: lugar['Lugar'], snippet: lugar['tipo']),
//    );
//
//    setState(() {
//      // adding a new marker to map
//      markers[markerId] = marker;
//    });
//  }
//
//
//  static final CameraPosition _kGooglePlex = CameraPosition(
//    target: LatLng(37.42796133580664, -122.085749655962),
//    zoom: 14.4746,
//  );
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      body: GoogleMap(
//        mapType: MapType.hybrid,
//        initialCameraPosition: _kGooglePlex,
//        onMapCreated: (GoogleMapController controller) {
//          _controller.complete(controller);
//        },
//        myLocationEnabled: true,
//        markers: Set<Marker>.of(markers.values),
//      ),
//      floatingActionButton: FloatingActionButton.extended(
//        onPressed: _currentLocation,
//        label: Text('Ir a mi Ubicacion!'),
//        icon: Icon(Icons.location_on),
//      ),
//    );
//  }
//
//
//
//  void _currentLocation() async {
//    final GoogleMapController controller = await _controller.future;
//    LocationData currentLocation;
//    var location = new Location();
//    try {
//      currentLocation = await location.getLocation();
//    } on Exception {
//      currentLocation = null;
//    }
//
//    controller.animateCamera(CameraUpdate.newCameraPosition(
//      CameraPosition(
//        bearing: 0,
//        target: LatLng(currentLocation.latitude, currentLocation.longitude),
//        zoom: 17.0,
//      ),
//    ));
//  }
//
//}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'mapData.dart';

class NearYouB extends StatefulWidget {
  @override
  _NearYouBState createState() => _NearYouBState();
}

class _NearYouBState extends State<NearYouB> {
  GoogleMapController _controller;

  List<Marker> allMarkers = [];

  PageController _pageController;

  int prevPage;

  var currentLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Geolocator.getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
//        mapToggle = true;
//        populateClients();
      });
    });
    coffeeShops.forEach((element) {
      allMarkers.add(Marker(
          markerId: MarkerId(element.shopName),
          draggable: false,
          infoWindow:
          InfoWindow(title: element.shopName, snippet: element.address),
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



  _coffeeShopList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            // moveCamera();
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    height: 125.0,
                    width: 275.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Row(children: [
                          Container(
                              height: 90.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          coffeeShops[index].thumbNail),
                                      fit: BoxFit.cover))),
                          SizedBox(width: 5.0),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  coffeeShops[index].shopName,
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  coffeeShops[index].address,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  width: 170.0,
                                  child: Text(
                                    coffeeShops[index].description,
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                )
                              ])
                        ]))))
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.yellow[700],
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
        "Near You",
        style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w300,
        fontSize: 25,
        ),
        ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 50.0,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(-26.1870404, 27.9868704), zoom: 12.0),
                markers: Set.from(allMarkers),
                onMapCreated: mapCreated,
                myLocationEnabled: true,
              ),
            ),
            Positioned(
              bottom: 20.0,
              child: Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: coffeeShops.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _coffeeShopList(index);
                  },
                ),
              ),
            )
          ],
        ));
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: coffeeShops[_pageController.page.toInt()].locationCoords,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
}