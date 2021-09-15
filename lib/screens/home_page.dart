import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web_prototype/alan_voice_bot/alan_voice.dart';
import 'package:web_prototype/chat_services/chatMain.dart';
import 'package:web_prototype/helper/fryo_icons.dart';
import 'package:web_prototype/screens/plumbers.dart';
import 'package:web_prototype/screens/products.dart';
import 'package:web_prototype/screens/tilers.dart';

import 'architects.dart';
import 'builders.dart';
import 'civil_engineers.dart';
import 'map.dart';
import 'near_you.dart';
import 'painters.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  User user;

  AnimationController _controller;

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

    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 450), value: 1.0);
    alan_Page();
  }

//  @override
//  void initState() {
//    super.initState();
//   _controller = AnimationController(
//       vsync: this, duration: Duration(milliseconds: 450), value: 1.0);
//       alan_Page();
//     AlanVoice.initButton(
//       "57b5839c1e30b4e6817638653c99352b2e956eca572e1d8b807a3e2338fdd0dc/stage",
//       server:"wss://tutor.alan.app",
//       buttonAlign:AlanVoice.BUTTON_ALIGN_LEFT
//     );

  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      floatingActionButton: floatingBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      appBar: buildAppBar(),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder(
                future: getUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: Colors.orange),
                      currentAccountPicture: new CircleAvatar(
                        radius: 60.0,
                        backgroundColor: Colors.white70,
                        backgroundImage: NetworkImage(
                            "https://cdn2.iconfinder.com/data/icons/website-icons/512/User_Avatar-512.png"),
                      ),
                      accountName: Text(
                        "Name: ${snapshot.data['displayName']}",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      accountEmail: Text(
                        "Email: ${snapshot.data['email']}",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),

            ///SIDENAV
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(
                "Log out",
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).pop();
                FirebaseAuth.instance.signOut().then(
                  (value) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/loginpage', (Route<dynamic> route) => false);
                  },
                );
              },
            ),
          ],
        ),
      ),

      ///BODY
      body: Container(
        height: 1000,
        width: 500,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "images/Construction-Industry-Health-and-Safety-scaled.jpg",

              ///Background image
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.only(bottom: 35.0),
          child: SafeArea(
            child: ListView(
              children: <Widget>[
                ///Top categories
                headerTopCategories(context),
                SizedBox(
                  height: 10,
                ),

                ///Builders page
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 20),
                  child: Card(
                    //color: Colors.black,
                    color: Colors.transparent,
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 7.0, bottom: 7.0),
                      child: ListTile(
                        leading: Image.asset('images/bldr1.png'), //icon image
                        // PreferredSize(
                        //   preferredSize: Size.fromHeight(120.0),
                        //   child: Icon(
                        //       Icons.account_box_rounded,
                        //   ),
                        // ),
                        title: Text(
                          "Builders",
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => builders_Page()),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                ///Tilers page
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 20),
                  child: Card(
                    color: Colors.transparent,
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 35, top: 7.0, bottom: 7.0),
                      child: ListTile(
                        leading: Image.asset('images/tiler1.png'), //icon image
                        title: Text(
                          "Tilers",
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => tilers_Page()),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                ///Architectcts page
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 20),
                  child: Card(
                    color: Colors.transparent,
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 14, top: 7.0, bottom: 7.0),
                      child: ListTile(
                        leading: Image.asset('images/archi1.png'),
                        title: Text(
                          "Architects",
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => archicts_Page()),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                ///Plumbers page
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 20),
                  child: Card(
                    color: Colors.transparent,
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 7.0, bottom: 7.0),
                      child: ListTile(
                        leading: Image.asset('images/plumber.jpg'),
                        title: Text(
                          "Plumbers",
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => plumbers_Page()),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                ///Civil Engineers page
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 20),
                  child: Card(
                    color: Colors.transparent,
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 7.0, bottom: 7.0),
                      child: ListTile(
                        leading: Image.asset('images/CivilEngineers.png'),
                        title: Text(
                          "Civil Engineers",
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => civilEngineers_Page()),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                ///Painters page
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 20),
                  child: Card(
                    color: Colors.transparent,
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 7.0, bottom: 7.0),
                      child: ListTile(
                        leading: Image.asset('images/painter.jpg'),
                        title: Text(
                          "Painters",
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => painters_Page()),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // Padding(
                //    padding: const EdgeInsets.all(8.0),
                //    child: Text(
                //      'Contractors List',
                //      style: TextStyle(
                //          color: Colors.white,
                //          fontWeight: FontWeight.bold,
                //          fontSize: 25,
                //          // decoration: TextDecoration.underline,
                //          letterSpacing: 5),
                //      textAlign: TextAlign.center,
                //    ),
                //  ),   ///Contractors list
                //  buildStreamBuilder(),
                //   SizedBox(
                //     height: 80,
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget headerTopCategories(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // sectionHeader('Categories', onViewMore: () {}),
        SizedBox(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                headerCategoryItem(
                    'Materials', FontAwesomeIcons.tools, Colors.red,
                    onPressed: () {
                  // changeScreen(context, Groceries());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              PortfolioCategoriesAndDisplay()));
                }),
                headerCategoryItem('Near You', Fryo.location, Colors.red,
                    onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => NearYou()));
                }),
                headerCategoryItem(
                    'Contractors', FontAwesomeIcons.userCog, Colors.red,
                    onPressed: () {
                  // changeScreen(context, Electronics());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => near_you_Page()));
                }),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget headerCategoryItem(String name, IconData icon, Color color,
      {onPressed}) {
    return Container(
      margin: EdgeInsets.only(left: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 10),
              width: 65,
              height: 65,
              child: FloatingActionButton(
                elevation: 0.5,
                shape: CircleBorder(),
                heroTag: name,
                onPressed: onPressed,
                backgroundColor: Colors.white,
                child: Icon(icon, size: 30, color: Colors.black87),
              )),
          Text(name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w200,
              ))
        ],
      ),
    );
  }

  // StreamBuilder<QuerySnapshot> buildStreamBuilder() {
  //   return StreamBuilder(
  //       stream: FirebaseFirestore.instance
  //           .collection("contractors")
  //           // .where("producttyp", isEqualTo: "groceries")
  //           .snapshots(),
  //       builder: (context, snapshot) {
  //         if (snapshot.data == null)
  //           return Text(
  //             'Loading',
  //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //           );
  //         return Container(
  //             height: 400,
  //             child: ListView.separated(
  //                 scrollDirection: Axis.vertical,
  //                 itemCount: snapshot.data.docs.length,
  //                 itemBuilder: (context, index) {
  //                   DocumentSnapshot products = snapshot.data.docs[index];
  //                   return Padding(
  //                     padding: const EdgeInsets.all(10.0),
  //                     child: ItemCard(products: products),
  //                   );
  //                 },
  //                 separatorBuilder: (BuildContext context, int index) {
  //                   return SizedBox(width: 5);
  //                 }));
  //       });
  // }  ///StreamBuilders

  AppBar buildAppBar() {
    ///Appbar
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.yellow[700],
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        "Golden Key Construction",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w300,
          fontSize: 25,
        ),
      ),
    );
  }

  ///Add Job
  Widget floatingBar() => Ink(
        decoration: ShapeDecoration(
          shape: StadiumBorder(),
        ),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => chat_Main_Page()));
          },
          backgroundColor: Colors.black,
          icon: Icon(
            FontAwesomeIcons.robot,
            color: Colors.white,
          ),
          label: Text(
            "Guide",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
}

//This is the part that shows up on the home screen
// class ItemCard extends StatelessWidget {
//   const ItemCard({
//     Key key,
//     @required this.products,
//   }) : super(key: key);
//
//   final DocumentSnapshot products;
//
//   @override
//   Widget build(BuildContext context) {
//     String _userId;
//     User loginUser;
//
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       _userId = user.uid;
//     }
//
//     return Container(
//       width: 222,
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (BuildContext context) =>
//                           ScanCard(products: products)));
//             },
//             child: Stack(
//               children: <Widget>[
//                 Container(
//                   height: 120,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(24),
//                     gradient: LinearGradient(
//                         colors: [Color(0xff6DC8F3), Color(0xff73A1F9)],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color(0xff73A1F9),
//                         blurRadius: 12,
//                         offset: Offset(0, 6),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   right: 0,
//                   bottom: 0,
//                   top: 0,
//                   // child: CustomPaint(
//                   //   size: Size(100, 150),
//                   //   painter: CustomCardShapePainter(
//                   //       24, Color(0xffFFB157), Color(0xffFFA057)),
//                   // ),
//                 ),
//                 Positioned.fill(
//                   child: Row(
//                     children: <Widget>[
//                       Expanded(
//                         child: Image.network(
//                           products['ImageURL'],
//                           height: 64,
//                           width: 64,
//                         ),
//                         flex: 2,
//                       ),
//                       SizedBox(
//                         width: 8,
//                       ),
//                       Expanded(
//                         flex: 4,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text(
//                               products['Name'] + " " + products['Surname'],
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontFamily: 'Avenir',
//                                   fontWeight: FontWeight.w700),
//                             ),
//                             Text(
//                               products['Area of Expertise'],
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: 'Avenir',
//                               ),
//                             ),
//                             SizedBox(height: 16),
//                             Row(
//                               children: <Widget>[
//                                 Icon(
//                                   Icons.location_on,
//                                   color: Colors.white,
//                                   size: 16,
//                                 ),
//                                 SizedBox(
//                                   width: 8,
//                                 ),
//                                 Flexible(
//                                   child: Text(
//                                     products['Location'],
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontFamily: 'Avenir',
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         flex: 2,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             Text(
//                               products['Contact Number'],
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontFamily: 'Avenir',
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w700),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ScanCard extends StatelessWidget {
//   const ScanCard({
//     Key key,
//     @required this.products,
//   }) : super(key: key);
//   final DocumentSnapshot products;
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   String _userId;
//   //
//   //   final user = FirebaseAuth.instance.currentUser;
//   //   if (user != null) {
//   //     _userId = user.uid;
//   //   }
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: Text("Contractor Info"),
//   //     ),
//   //     body: SingleChildScrollView(
//   //       // child: Column(
//   //       //   // mainAxisAlignment: MainAxisAlignment.spaceAround,
//   //       //   children: <Widget>[
//   //       //     SizedBox(
//   //       //       height: 10,
//   //       //     ),
//   //       //     CircleAvatar(
//   //       //       backgroundImage: NetworkImage(products["ImageURL"]),
//   //       //       radius: 80.0,
//   //       //     ),
//   //       //     SizedBox(
//   //       //       height: 10,
//   //       //     ),
//   //       //     Text(
//   //       //       products["Name"] + " " + products["Surname"],
//   //       //       style: TextStyle(fontSize: 32.0),
//   //       //     ),
//   //       //     SizedBox(
//   //       //       height: 5,
//   //       //     ),
//   //       //     Text(
//   //       //       "Hello I am " +
//   //       //           products["Name"] +
//   //       //           " " +
//   //       //           products["Surname"] +
//   //       //           " and I am a " +
//   //       //           products["Area of Expertise"] +
//   //       //           " if you'd like to hire me my contact information is below ",
//   //       //       style: TextStyle(fontSize: 16.0),
//   //       //       textAlign: TextAlign.center,
//   //       //     ),
//   //       //     SizedBox(
//   //       //       height: 10,
//   //       //     ),
//   //       //     Padding(
//   //       //       padding: const EdgeInsets.all(10.0),
//   //       //       child: Container(
//   //       //         child: Row(
//   //       //           mainAxisAlignment: MainAxisAlignment.spaceAround,
//   //       //           children: [
//   //       //             Column(
//   //       //               children: [
//   //       //                 Icon(
//   //       //                   Icons.work,
//   //       //                   color: Colors.black,
//   //       //                   size: 36,
//   //       //                 ),
//   //       //                 Text(
//   //       //                   products["Area of Expertise"],
//   //       //                   style: TextStyle(fontSize: 16.0),
//   //       //                 ),
//   //       //               ],
//   //       //             ),
//   //       //             Column(
//   //       //               children: [
//   //       //                 Icon(
//   //       //                   Icons.home_work_outlined,
//   //       //                   color: Colors.blue,
//   //       //                   size: 36,
//   //       //                 ),
//   //       //                 Text(
//   //       //                   products["Company Name"],
//   //       //                   style: TextStyle(fontSize: 16.0),
//   //       //                 ),
//   //       //               ],
//   //       //             ),
//   //       //             TextButton(
//   //       //               onPressed: () =>
//   //       //                   launch("tel://${products["Contact Number"]}"),
//   //       //               // style: ButtonStyle(
//   //       //               //   shape:
//   //       //               //       MaterialStateProperty.all<RoundedRectangleBorder>(
//   //       //               //     RoundedRectangleBorder(
//   //       //               //         borderRadius: BorderRadius.circular(10.0),
//   //       //               //         side: BorderSide(color: Colors.red)),
//   //       //               //   ),
//   //       //               // ),
//   //       //               child: Column(
//   //       //                 children: [
//   //       //                   Icon(
//   //       //                     Icons.phone,
//   //       //                     color: Colors.green,
//   //       //                     size: 36,
//   //       //                   ),
//   //       //                   Text(
//   //       //                     products["Contact Number"],
//   //       //                     style: TextStyle(fontSize: 16.0),
//   //       //                   ),
//   //       //                 ],
//   //       //               ),
//   //       //             ),
//   //       //             // Text(
//   //       //             //   products["Area of Expertise"],
//   //       //             //   style: TextStyle(fontSize: 16.0),
//   //       //             // ),
//   //       //             // Text(
//   //       //             //   products["Company Name"],
//   //       //             //   style: TextStyle(fontSize: 16.0),
//   //       //             // ),
//   //       //             // Text(
//   //       //             //   products["Contact Number"],
//   //       //             //   style: TextStyle(fontSize: 16.0),
//   //       //             // ),
//   //       //           ],
//   //       //         ),
//   //       //       ),
//   //       //     ),
//   //       //     SizedBox(
//   //       //       height: 10,
//   //       //     ),
//   //       //     Padding(
//   //       //       padding: const EdgeInsets.all(8.0),
//   //       //       child: Row(
//   //       //         // mainAxisAlignment: MainAxisAlignment.spaceAround,
//   //       //         children: <Widget>[
//   //       //           Expanded(
//   //       //             child: Column(
//   //       //               children: <Widget>[
//   //       //                 CircleAvatar(
//   //       //                   backgroundColor: Colors.brown,
//   //       //                   radius: 32,
//   //       //                   child: Icon(
//   //       //                     Icons.location_on,
//   //       //                     color: Colors.white,
//   //       //                     size: 36,
//   //       //                   ),
//   //       //                 ),
//   //       //                 SizedBox(
//   //       //                   height: 10.0,
//   //       //                 ),
//   //       //                 Text(
//   //       //                   products["Location"],
//   //       //                   // textAlign: TextAlign.center,
//   //       //                   overflow: TextOverflow.ellipsis,
//   //       //                 )
//   //       //               ],
//   //       //             ),
//   //       //           ),
//   //       //           Expanded(
//   //       //             child: TextButton(
//   //       //               onPressed: () =>
//   //       //                   launch("mailto://${products["Email address"]}"),
//   //       //               // style: ButtonStyle(
//   //       //               //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//   //       //               //     RoundedRectangleBorder(
//   //       //               //       borderRadius: BorderRadius.circular(10.0),
//   //       //               //       // side: BorderSide(color: Colors.red),
//   //       //               //     ),
//   //       //               //   ),
//   //       //               // ),
//   //       //               child: Column(
//   //       //                 children: <Widget>[
//   //       //                   CircleAvatar(
//   //       //                     backgroundColor: Colors.brown,
//   //       //                     radius: 32,
//   //       //                     child: Icon(
//   //       //                       Icons.email,
//   //       //                       color: Colors.white,
//   //       //                       size: 36,
//   //       //                     ),
//   //       //                   ),
//   //       //                   SizedBox(
//   //       //                     height: 10.0,
//   //       //                   ),
//   //       //                   Text(
//   //       //                     products["Email address"],
//   //       //                     overflow: TextOverflow.ellipsis,
//   //       //                   )
//   //       //                 ],
//   //       //               ),
//   //       //             ),
//   //       //           )
//   //       //         ],
//   //       //       ),
//   //       //     ),
//   //       //     SizedBox(
//   //       //       height: 10,
//   //       //     ),
//   //       //     Container(
//   //       //       height: 250.0,
//   //       //       width: double.infinity,
//   //       //       color: Colors.brown[300],
//   //       //       child: ListView(
//   //       //         scrollDirection: Axis.horizontal,
//   //       //         children: [
//   //       //           Image.asset('images/builder.jpg'),
//   //       //           Image.asset('images/female-architect.jpg'),
//   //       //           Image.asset('images/female-tiler.jpg'),
//   //       //         ],
//   //       //       ),
//   //       //     )
//   //       //   ],
//   //       // ),
//   //     ),
//   //   );
//   // }
//
// //}   ///need this one
//
//   Future<bool> dialogTrigger(BuildContext context) async {
//     return showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Job done', style: TextStyle(fontSize: 22.0)),
//             content: Text(
//               'Added Successfully',
//               style: TextStyle(fontSize: 20.0),
//             ),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text(
//                   'Alright',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               )
//             ],
//           );
//         });
//   }
//
//   Widget sectionHeader(String headerTitle, {onViewMore}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Container(
//           margin: EdgeInsets.only(left: 15, top: 10),
//           child: Text(headerTitle,
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 22,
//                 fontWeight: FontWeight.w800,
//               )),
//         ),
//       ],
//     );
//   }
//
//
// // class CustomCardShapePainter extends CustomPainter {
// //   final double radius;
// //   final Color startColor;
// //   final Color endColor;
// //
// //   CustomCardShapePainter(this.radius, this.startColor, this.endColor);
// //
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     var radius = 24.0;
// //
// //     var paint = Paint();
// //     paint.shader = ui.Gradient.linear(
// //         Offset(0, 0), Offset(size.width, size.height), [
// //       HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
// //       endColor
// //     ]);
// //
// //     var path = Path()
// //       ..moveTo(0, size.height)
// //       ..lineTo(size.width - radius, size.height)
// //       ..quadraticBezierTo(
// //           size.width, size.height, size.width, size.height - radius)
// //       ..lineTo(size.width, radius)
// //       ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
// //       ..lineTo(size.width - 1.5 * radius, 0)
// //       ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
// //       ..close();
// //
// //     canvas.drawPath(path, paint);
// //   }
// //
// //   @override
// //   bool shouldRepaint(CustomPainter oldDelegate) {
// //     return true;
// //   }
// // }
// }
// class PlaceInfo {
//   final String name;
//   final String areaOfExpertise;
//   final String location;
//   final String contact;
//   final String companyName;
//   final String image;
//   final String email;
//   final String surname;
//
//   PlaceInfo(this.name, this.surname, this.companyName, this.image,
//       this.location, this.areaOfExpertise, this.contact, this.email);
//  }
