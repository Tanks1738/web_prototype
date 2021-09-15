import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web_prototype/add_pro/add_product.dart';
import 'package:web_prototype/chat_services/chatMain.dart';
import 'package:web_prototype/screens/PurchaseHistory.dart';
import 'package:web_prototype/helper/fryo_icons.dart';
import 'package:web_prototype/screens/cosmetics.dart';
import 'package:web_prototype/screens/fresh_produce.dart';
import 'package:web_prototype/screens/groceries.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_prototype/screens/plumbers.dart';
import 'package:web_prototype/screens/tilers.dart';

import 'dart:ui' as ui;
import 'SpendingDetails.dart';
import 'SpendingDetails.dart';
import 'architects.dart';
import 'builders.dart';
import 'civil_engineers.dart';
import 'clothing.dart';
import 'electronics.dart';
import 'painters.dart';

class near_you_Page extends StatefulWidget {
  near_you_Page({Key key, this.title}) : super(key: key);
  final String title;

  @override
  near_you_PageState createState() => near_you_PageState();
}

class near_you_PageState extends State<near_you_Page> {
  User user;

  final _key = GlobalKey<ScaffoldState>();

  Future<void> getUserData() async {
    User userData = await FirebaseAuth.instance.currentUser;
    setState(() {
      user = userData;
      print(userData.uid);
    });
  }

  Future<void> getUser() async {
    DocumentSnapshot cn = await FirebaseFirestore.instance
        .collection('users')
        .doc('${user.uid}')
        .get();
    return cn;
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      appBar: buildAppBar(),

      ///BODY
      body: Container(
        height: 1000,
        width: 500,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "images/Construction-Industry-Health-and-Safety-scaled.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),  ///Background image
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              ///Search bar
              Container(
                decoration: BoxDecoration(
                  // color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 8, right: 8, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      title: TextField(
                        textInputAction: TextInputAction.search,
                        onSubmitted: (pattern) async {
                          // await productProvider.search(productName: pattern);
                          // changeScreen(context, ProductSearchScreen());
                        },
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  // color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
              ),

              SizedBox(
                height: 10,
              ),

              ///Contractors list text
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Contractors',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 25,
                      // decoration: TextDecoration.underline,
                      letterSpacing: 5),
                  textAlign: TextAlign.center,
                ),
              ),
              buildStreamBuilder(),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot> buildStreamBuilder() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("contractors")
        // .where("producttyp", isEqualTo: "groceries")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null)
            return Text(
              'Loading',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          return Container(
              height: 700,    ///Contractor list big container height
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot products = snapshot.data.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ItemCard(products: products),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 5);
                  }));
        });
  }

  AppBar buildAppBar() {                                                                  ///Appbar
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.yellow[700],
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        "Construction List",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w300,
          fontSize: 25,
        ),
      ),
      // actions: [
      //   IconButton(
      //     icon: Icon(
      //       Icons.shopping_cart,
      //       color: Colors.black,
      //     ),
      //     onPressed: () {
      //       Navigator.of(context).pushNamed('/cartpage');
      //     },
      //   )
      // ],
    );
  }


}

//This is the part that shows up on the home screen
class ItemCard extends StatelessWidget {
  const ItemCard({
    Key key,
    @required this.products,
  }) : super(key: key);

  final DocumentSnapshot products;

  @override
  Widget build(BuildContext context) {
    String _userId;
    User loginUser;

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userId = user.uid;
    }

    return Container(
      width: 222,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ScanCard(products: products)));
            },
            child: Stack(
              children: <Widget>[
                Container(
                  height: 130,                  ///Contractor card height
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                        colors: [Color(0xff6DC8F3), Color(0xff73A1F9)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff73A1F9),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: CustomPaint(
                    size: Size(90, 150),       ///Contact number colour width and height
                    painter: CustomCardShapePainter(
                        24, Color(0xffFFB157), Color(0xffFFA057)),
                  ),
                ),
                Positioned.fill(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Image.network(
                          products['ImageURL'],
                          height: 64,
                          width: 64,
                        ),
                        flex: 2,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              products['Name'] + " " + products['Surname'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              products['Area of Expertise'],
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Avenir',
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Flexible(
                                  child: Text(
                                    products['Location'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Avenir',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              products['Contact Number'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Avenir',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScanCard extends StatelessWidget {
  const ScanCard({
    Key key,
    @required this.products,
  }) : super(key: key);
  final DocumentSnapshot products;

  @override
  Widget build(BuildContext context) {
    String _userId;

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userId = user.uid;
    }

    ///Contractor Info
    return Scaffold(
      appBar: AppBar(
        title: Text("Contractor Info"),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(products["ImageURL"]),
              radius: 80.0,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              products["Name"] + " " + products["Surname"],
              style: TextStyle(fontSize: 32.0),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Hello I am " +
                  products["Name"] +
                  " " +
                  products["Surname"] +
                  " and I am a " +
                  products["Area of Expertise"] +
                  " if you'd like to hire me my contact information is below ",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.work,
                          color: Colors.black,
                          size: 36,
                        ),
                        Text(
                          products["Area of Expertise"],
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.home_work_outlined,
                          color: Colors.blue,
                          size: 36,
                        ),
                        Text(
                          products["Company Name"],
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () =>
                          launch("tel://${products["Contact Number"]}"),
                      // style: ButtonStyle(
                      //   shape:
                      //       MaterialStateProperty.all<RoundedRectangleBorder>(
                      //     RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(10.0),
                      //         side: BorderSide(color: Colors.red)),
                      //   ),
                      // ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.green,
                            size: 36,
                          ),
                          Text(
                            products["Contact Number"],
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                    // Text(
                    //   products["Area of Expertise"],
                    //   style: TextStyle(fontSize: 16.0),
                    // ),
                    // Text(
                    //   products["Company Name"],
                    //   style: TextStyle(fontSize: 16.0),
                    // ),
                    // Text(
                    //   products["Contact Number"],
                    //   style: TextStyle(fontSize: 16.0),
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.brown,
                          radius: 32,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          products["Location"],
                          // textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () =>
                          launch("mailto://${products["Email address"]}"),
                      // style: ButtonStyle(
                      //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      //     RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //       // side: BorderSide(color: Colors.red),
                      //     ),
                      //   ),
                      // ),
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.brown,
                            radius: 32,
                            child: Icon(
                              Icons.email,
                              color: Colors.white,
                              size: 36,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            products["Email address"],
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 250.0,
              width: double.infinity,
              color: Colors.brown[300],
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Image.asset('images/builder.jpg'),
                  Image.asset('images/female-architect.jpg'),
                  Image.asset('images/female-tiler.jpg'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



Widget sectionHeader(String headerTitle, {onViewMore}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 15, top: 10),
        child: Text(headerTitle,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            )),
      ),

    ],
  );
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class PlaceInfo {
  final String name;
  final String areaOfExpertise;
  final String location;
  final String contact;
  final String companyName;
  final String image;
  final String email;
  final String surname;

  PlaceInfo(this.name, this.surname, this.companyName, this.image,
      this.location, this.areaOfExpertise, this.contact, this.email);
}
