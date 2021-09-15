import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Groceries extends StatefulWidget {
  @override
  _GroceriesState createState() => _GroceriesState();
}

class _GroceriesState extends State<Groceries> {
  String _userId;
  User loginUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        // body: buildStreamElectronics(),
        body: buildStreamMaterials()
    );
  }

  StreamBuilder<QuerySnapshot> buildStreamMaterials() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("materials")
//            .where("Area of Expertise", isEqualTo: "Window Repair")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null)
            return Text(
              'Loading',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          return Padding(
            padding: const EdgeInsets.all(9.0),
            child: GridView.builder(
              // scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.docs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                maxCrossAxisExtent: 200,
                crossAxisCount: 1,
                childAspectRatio: 3 / 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemBuilder: (context, index) {
                DocumentSnapshot products = snapshot.data.docs[index];
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  _userId = user.uid;
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.0),
                      height: 180,
                      width: 160,
                      decoration: BoxDecoration(
                          color: Color(0xFF3D82AE),
                          borderRadius: BorderRadius.circular(16)),
                      child: Image.network(products['img']),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0 / 4),
                      child: Text(
                        products['name'],
                        style: TextStyle(
                          color: Color(0xFF535353),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Row(
                        children: [
                          Text(
                            "\R " + products['price'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          IconButton(
                            icon: Icon(
                              // CupertinoIcons.cart_fill_badge_plus,
                              Icons.add,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () {
                              DocumentReference documentReference =
                              FirebaseFirestore.instance
                                  .collection('userData')
                                  .doc(_userId)
                                  .collection('cartData')
                                  .doc();
                              documentReference
                                  .set({
                                'uid': _userId,
                                'img': products['img'],
                                'name': products['name'],
                                'price': products['price'],
//                                    'points': products['points'],
                                'materialtype': products['materialtype'],
                                'id': documentReference.id
                              })
                                  .then((result) {})
                                  .catchError((e) {
                                print(e);
                              });
                              Scaffold.of(context).showSnackBar(new SnackBar(
                                content: new Text(
                                  'Added to List Calculator',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                  textAlign: TextAlign.start,
                                ),
                                duration: Duration(milliseconds: 300),
                                backgroundColor: Color(0xFF3D82AE),
                              )
                              );
                            },
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          Text(
                            products['materialtype'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
              // separatorBuilder: (BuildContext context, int index) {
              //   return SizedBox(width: 10);
              // }
            ),
          );
        });
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        "Material List",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.calculate_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed('/cartpage');
          },
        )
      ],
    );
  }
}
