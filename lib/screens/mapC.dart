import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NearyouMap extends StatefulWidget {
  @override
  _NearyouMapState createState() => _NearyouMapState();
}

class _NearyouMapState extends State<NearyouMap> {
  bool mapToggle = false;
  bool clientsToggle = false;
  bool resetToggle = false;

  var currentLocation;

  var clients = [];
  List<Marker> allMarkers = [];

  var currentClient;
  var currentBearing;

  GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initState() {
    super.initState();
//    setState(() {
//      mapToggle = true;
//      populateClients();
//    });
    Geolocator.getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
        populateClients();
      });
    });
  }

  populateClients() {
    clients = [];
    FirebaseFirestore.instance.collection('markers').get().then((docs) {
      if (docs.docs.isNotEmpty) {
        setState(() {
          clientsToggle = true;
        });
        for (int i = 0; i < docs.docs.length; ++i) {
          clients.add(docs.docs[i].data());
          initMarker(docs.docs[i].data,docs.docs[i].id);
        }
      }
    });
  }

  initMarker(client,clientid) {
    var markerIdVal = clientid;
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
        markerId: MarkerId('$markerId'),
        icon: BitmapDescriptor.defaultMarker,
        position:
        LatLng(client['location'].latitude, client['location'].longitude),
        draggable: false,
        infoWindow: InfoWindow(title:client['clientName'], snippet:'Cool')
    );

        setState(() {
          // adding a new marker to map
          markers[markerId] = marker;
        });
    //    mapController.clearMarkers().then((val) {
    //      mapController.addMarker(MarkerOptions(
    //          position:
    //          LatLng(client['location'].latitude, client['location'].longitude),
    //          draggable: false,
    //          infoWindowText: InfoWindowText(client['clientName'], 'Nice')));
    //    });
  }

  Widget clientCard(client) {
    return Padding(
        padding: EdgeInsets.only(left: 2.0, top: 10.0),
        child: InkWell(
            onTap: () {
              setState(() {
                currentClient = client;
                currentBearing = 90.0;
              });
              zoomInMarker(client);
            },
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                  height: 100.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white),
                  child: Center(child: Text(client['clientName']))),
            )));
  }

  zoomInMarker(client) {
    mapController
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
            client['location'].latitude, client['location'].longitude),
        zoom: 17.0,
        bearing: 90.0,
        tilt: 45.0)))
        .then((val) {
      setState(() {
        resetToggle = true;
      });
    });
  }

  resetCamera() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(currentLocation.latitude, currentLocation.longitude), zoom: 10.0))).then((val) {
      setState(() {
        resetToggle = false;
      });
    });
  }

  addBearing() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(currentClient['location'].latitude,
                currentClient['location'].longitude
            ),
            bearing: currentBearing == 360.0 ? currentBearing : currentBearing + 90.0,
            zoom: 17.0,
            tilt: 45.0
        )
    )
    ).then((val) {
      setState(() {
        if(currentBearing == 360.0) {}
        else {
          currentBearing = currentBearing + 90.0;
        }
      });
    });
  }

  removeBearing() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(currentClient['location'].latitude,
                currentClient['location'].longitude
            ),
            bearing: currentBearing == 0.0 ? currentBearing : currentBearing - 90.0,
            zoom: 17.0,
            tilt: 45.0
        )
    )
    ).then((val) {
      setState(() {
        if(currentBearing == 0.0) {}
        else {
          currentBearing = currentBearing - 90.0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Near you'),
        ),
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height - 80.0,
                    width: double.infinity,
                    child: mapToggle
                        ? GoogleMap(
                      onMapCreated: onMapCreated,
                      markers: Set<Marker>.of(markers.values),
                      initialCameraPosition: CameraPosition(
                          target: LatLng(currentLocation.latitude, currentLocation.longitude),
                          zoom: 10.0),)
                        : Center(
                        child: Text(
                          'Loading.. Please wait..',
                          style: TextStyle(fontSize: 20.0),
                        ))),
                Positioned(
                    top: MediaQuery.of(context).size.height - 250.0,
                    left: 10.0,
                    child: Container(
                        height: 125.0,
                        width: MediaQuery.of(context).size.width,
                        child: clientsToggle
                            ? ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.all(8.0),
                          children: clients.map((element) {
                            return clientCard(element);
                          }).toList(),
                        )
                            : Container(height: 1.0, width: 1.0))),
                resetToggle
                    ? Positioned(
                    top: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height -
                            50.0),
                    right: 15.0,
                    child: FloatingActionButton(
                      onPressed: resetCamera,
                      mini: true,
                      backgroundColor: Colors.red,
                      child: Icon(Icons.refresh),
                    ))
                    : Container(),
                resetToggle
                    ? Positioned(
                    top: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height -
                            50.0),
                    right: 60.0,
                    child: FloatingActionButton(
                        onPressed: addBearing,
                        mini: true,
                        backgroundColor: Colors.green,
                        child: Icon(Icons.rotate_left
                        ))
                )
                    : Container(),
                resetToggle
                    ? Positioned(
                    top: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height -
                            50.0),
                    right: 110.0,
                    child: FloatingActionButton(
                        onPressed: removeBearing,
                        mini: true,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.rotate_right)
                    ))
                    : Container()
              ],
            )
          ],
        ));
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
}