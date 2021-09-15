import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PortfolioCategoriesAndDisplay extends StatefulWidget {
  @override
  _PortfolioCategoriesAndDisplayState createState() =>
      new _PortfolioCategoriesAndDisplayState();
}

String _showCat = 'plastic'; //default state is All
String _userId;
User loginUser;

class CategoryChoice {
  const CategoryChoice({this.category, this.categoryName});

  final String category;
  final String categoryName; //'category.[Name]' in Firebase

  @override
  String toString() {
    return 'category: $category categoryName: $categoryName';
  }
}

const List<CategoryChoice> categories = const <CategoryChoice>[
  const CategoryChoice(categoryName: 'plastic'),
  const CategoryChoice(categoryName: 'lumber'),
  const CategoryChoice(categoryName: 'decor'),
  const CategoryChoice(categoryName: 'building'),
];

class _PortfolioCategoriesAndDisplayState
    extends State<PortfolioCategoriesAndDisplay> {
  void _select(String newCategory) {
    setState(() {
      _showCat = newCategory;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
          child: Row(
            children: [
              Expanded(
                child:
                Column(children: [
                  Container(
                    height: 40.0,
                    child:
                    ListView(
                      scrollDirection: Axis.horizontal,
                        children: [
                      FlatButton(
                          onPressed: () {
                            _select(categories[0].categoryName);
                          },
                          child: Text(
                            'Plastic',
                          )),

                      FlatButton(
                          onPressed: () {
                            _select(categories[1].categoryName);
                          },
                          child: Text(
                            'Lumber',
                          )),
                      FlatButton(
                          onPressed: () {
                            _select(categories[2].categoryName);
                          },
                          child: Text(
                            'Decor',
                          )),
                      FlatButton(
                          onPressed: () {
                            _select(categories[3].categoryName);
                          },
                          child: Text(
                            'Building',
                          )),
                    ]),
                  ),
                  SizedBox(height: 20.0,),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('materials')
                        .where('materialtype', whereIn: [_showCat])
//                      .orderBy('projectOrder', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
//                      if (!snapshot.hasData) return Text("Loading...");
                      if (!snapshot.hasData)
                        return Text(
                          'Loading...',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        );
                      return Expanded(
                        child: GridView.builder(
                          // scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.docs.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                maxCrossAxisExtent: 200,
                            crossAxisCount: 1,
                            childAspectRatio: 4 / 3,
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
                                  padding: EdgeInsets.all(15.0),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                )
                              ],
                            );
                          },
                          // separatorBuilder: (BuildContext context, int index) {
                          //   return SizedBox(width: 10);
                          // }
                        ),
                      );
                    },
                  )
                ]),
              )
            ],
          )),
    );
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