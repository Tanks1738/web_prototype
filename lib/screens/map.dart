//import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//
//class MyHomePage extends StatefulWidget {
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  bool mapToggle = false;
//  bool sitiosToggle = false;
//  bool resetToggle = false;
//
//  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
//
//  var currentLocation;
//
//  var sitios = [];
//
//  var sitioActual;
//  var currentBearing;
//
//  GoogleMapController mapController;
//
//  void initState() {
//    super.initState();
//    setState(() {
//      mapToggle = true;
//      populateClients();
//    });
//  }
//
//  populateClients() {
//    sitios = [];
//    FirebaseFirestore.instance.collection('markers').get().then((docs) {
//      if (docs.docs.isNotEmpty) {
//        setState(() {
//          sitiosToggle = true;
//        });
//        for (int i = 0; i < docs.docs.length; ++i) {
//          sitios.add(docs.docs[i].data());
//          initMarker(docs.docs[i].data,docs.docs[i].id);
//        }
//      }
//    });
//  }
//
//  initMarker(sitio,sitioid) {
//    var markerIdVal = sitioid;
//    final MarkerId markerId = MarkerId(markerIdVal);
//
//    // creating a new MARKER
//    final Marker marker = Marker(
//      markerId: markerId,
//        position:
//          LatLng(sitio['location'].latitude, sitio['location'].longitude),
//          draggable: false,
//          infoWindow: InfoWindow(title:sitio['clientName'], snippet:'Cool')
//    );
//
//    setState(() {
//      // adding a new marker to map
//      markers[markerId] = marker;
//    });
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
////    mapController.clearMarkers().then((val) {
////      mapController.addMarker(Marker(
////          position:
////          LatLng(sitio['location'].latitude, sitio['location'].longitude),
////          draggable: false,
////          infoWindow: InfoWindow(title:sitio['nombreSitio'], snippet:'Cool')));
////    });
//  }
//
//  Widget siteCard(sitio) {
//    return Padding(
//        padding: EdgeInsets.only(left: 2.0, top: 10.0),
//        child: InkWell(
//            onTap: () {
//              setState(() {
//                sitioActual = sitio;
//                currentBearing = 90.0;
//              });
//              zoomInMarker(sitio);
//            },
//            child: Material(
//              elevation: 4.0,
//              borderRadius: BorderRadius.circular(5.0),
//              child: Container(
//                  height: 100.0,
//                  width: 125.0,
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(5.0),
//                      color: Colors.white),
//                  child: Center(child: Text(sitio['clientName']))),
//            )));
//  }
//
//  zoomInMarker(sitio) {
//    mapController
//        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//        target: LatLng(
//            sitio['location'].latitude, sitio['location'].longitude),
//        zoom: 17.0,
//        bearing: 90.0,
//        tilt: 45.0)))
//        .then((val) {
//      setState(() {
//        resetToggle = true;
//      });
//    });
//  }
//
//  markerInicial() {
//    mapController.animateCamera(CameraUpdate.newCameraPosition(
//        CameraPosition(target: LatLng(51.0533076, 5.9260656), zoom: 5.0))).then((val) {//Alemania, Berlin
//      setState(() {
//        resetToggle = false;
//      });
//    });
//  }
//
//  girarDerecha() {
//    mapController.animateCamera(CameraUpdate.newCameraPosition(
//        CameraPosition(
//            target: LatLng(sitioActual['location'].latitude,
//                sitioActual['location'].longitude
//            ),
//            bearing: currentBearing == 360.0 ? currentBearing : currentBearing + 90.0,
//            zoom: 17.0,
//            tilt: 45.0
//        )
//    )
//    ).then((val) {
//      setState(() {
//        if(currentBearing == 360.0) {}
//        else {
//          currentBearing = currentBearing + 90.0;
//        }
//      });
//    });
//  }
//
//  giroIzquierda() {
//    mapController.animateCamera(CameraUpdate.newCameraPosition(
//        CameraPosition(
//            target: LatLng(sitioActual['location'].latitude,
//                sitioActual['location'].longitude
//            ),
//            bearing: currentBearing == 0.0 ? currentBearing : currentBearing - 90.0,
//            zoom: 17.0,
//            tilt: 45.0
//        )
//    )
//    ).then((val) {
//      setState(() {
//        if(currentBearing == 0.0) {}
//        else {
//          currentBearing = currentBearing - 90.0;
//        }
//      });
//    });
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text('Near you'),
//        ),
//        body: Column(
//          children: <Widget>[
//            Stack(
//              children: <Widget>[
//                Container(
//                    height: MediaQuery.of(context).size.height - 80.0,
//                    width: double.infinity,
//                    child: mapToggle
//                        ? GoogleMap(
//                      initialCameraPosition: CameraPosition(
//                          target: LatLng(48.8583998, 2.2932227),//Paris
//                          zoom: 15
//                      ),
//                      onMapCreated: onMapCreated,
//                      myLocationEnabled: true,
//                      mapType: MapType.hybrid,
//                      compassEnabled: true,
//                      markers: Set<Marker>.of(markers.values),
////                      trackCameraPosition: true,
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'mapData.dart';

class NearYou extends StatefulWidget {
  @override
  _NearYouBState createState() => _NearYouBState();
}

class _NearYouBState extends State<NearYou> {
  GoogleMapController _controller;

  List<Marker> allMarkers = [];

  PageController _pageController;

  int prevPage;
  CollectionReference mapData =
      FirebaseFirestore.instance.collection('contractors');
//  LatLng currentPostion;
  static LatLng _initialPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserLocation();
    mapData.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        allMarkers.add(Marker(
          markerId: MarkerId(doc['Company Name']),
          draggable: false,
          infoWindow:
              InfoWindow(title: doc['Company Name-'], snippet: doc['Location']),
          position: LatLng(doc['latlang'].latitude, doc['latlang'].longitude),
        ));
      });
    });
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  void _getUserLocation() async {
    Position position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//    List<Placemark> placemark = await Geolocator()
//        .placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
//      print('${placemark[0].name}');
    });
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
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("contractors")
//            .where("Area of Expertise", isEqualTo: "Window Repair")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    DocumentSnapshot products = snapshot.data.docs[index];
                    return Container(
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
                                    image: NetworkImage(products['ImageURL']),
                                    fit: BoxFit.cover))),
                        SizedBox(width: 5.0),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                products['Company Name'],
                                style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: 170.0,
                                child: Text(
                                  products['Location'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                width: 170.0,
                                child: Text(
                                  'Hello I Am ' +
                                      products['Name'] +
                                      ' and I do ' +
                                      products['Area of Expertise'],
                                  style: TextStyle(
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ]),
                      ]),
                    );
                  }),
            ),
          ),
        ]),
      ),
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
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("contractors")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null)
                return Text(
                  'Loading',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                );
              return _initialPosition == null
                  ? Container(
                      child: Center(
                        child: Text(
                          'loading map..',
                          style: TextStyle(
                              fontFamily: 'Avenir-Medium',
                              color: Colors.grey[400]),
                        ),
                      ),
                    )
                  : Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height - 50.0,
                            width: MediaQuery.of(context).size.width,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target: _initialPosition, zoom: 12.0),
                              markers: Set.from(allMarkers),
                              onMapCreated: mapCreated,
                            ),
                          ),
                          Positioned(
                            bottom: 20.0,
                            child: Container(
                              height: 200.0,
                              width: MediaQuery.of(context).size.width,
                              child: PageView.builder(
                                controller: _pageController,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return _coffeeShopList(index);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    );
            }));
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
