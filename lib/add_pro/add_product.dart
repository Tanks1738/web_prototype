import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web_prototype/services/product_crud.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String surname;
  String name;
  String price;
  String location;
  // String imageUrl;
  String jobTitle;
  String _scanBarcode;

  @override
  Widget build(BuildContext context) {
    crudProduct crudObj = new crudProduct();

    return Scaffold(
      // floatingActionButton: floatingBar(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      body: Container(
        height: 1000,
        width: 500,
        decoration: BoxDecoration(
          image: DecorationImage(
            ///Background Image
            image: AssetImage('images/add_job3.png'),

            fit: BoxFit.cover,
          ),
        ),
        child: Builder(
          builder: (context) => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 70.0),
                Container(
                  color: Colors.white30,
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Create Job',
                        style: TextStyle(
                            color: Colors.blueGrey[500],
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            fontSize: 45),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60),
                Container(
                  width: 350,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    style:
                        TextStyle(fontFamily: 'Raleway', color: Colors.white),

                    ///Surname
                    decoration: InputDecoration(
                      labelText: "Surname",
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 20,
                          color: Colors.white),
                      border: OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide:
                            const BorderSide(color: Colors.white, width: 0.0),
                      ),
                    ),
                    onChanged: (value) {
                      this.surname = value;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 350,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    style:
                        TextStyle(fontFamily: 'Raleway', color: Colors.white),

                    ///Name
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 20,
                          color: Colors.white),
                      border: OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide:
                            const BorderSide(color: Colors.white, width: 0.0),
                      ),
                    ),
                    onChanged: (value) {
                      this.name = value;
                    },
                  ),
                ),
                SizedBox(height: 20),
                // Container(
                //   height: 40,
                //   width: 350,
                //   child: Text(
                //     'Barcode $_scanBarcode',
                //     style: TextStyle(fontSize: 20),
                //   ),
                //   decoration: BoxDecoration(
                //     border: Border.all(),
                //     borderRadius: BorderRadius.vertical(),
                //     shape: BoxShape.rectangle,
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                Container(
                  width: 350,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    maxLength: 25,
                    style:
                        TextStyle(fontFamily: 'Raleway', color: Colors.white),

                    ///Location
                    decoration: InputDecoration(
                      counterStyle: TextStyle(color: Colors.white),
                      labelText: "Location",
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 20,
                          color: Colors.white),
                      border: OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide:
                            const BorderSide(color: Colors.white, width: 0.0),
                      ),
                    ),
                    onChanged: (value) {
                      this.location = value;
                    },
                  ),
                ),
                Container(
                  width: 350,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    maxLength: 15,
                    style:
                        TextStyle(fontFamily: 'Raleway', color: Colors.white),

                    ///Job title
                    decoration: InputDecoration(
                      counterStyle: TextStyle(color: Colors.white),
                      labelText: "Job Title",
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 20,
                          color: Colors.white),
                      border: OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide:
                            const BorderSide(color: Colors.white, width: 0.0),
                      ),
                    ),
                    onChanged: (value) {
                      this.jobTitle = value;
                    },
                  ),
                ),
                Container(
                  width: 350,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 5,
                    style:
                        TextStyle(fontFamily: 'Raleway', color: Colors.white),

                    ///Price Range
                    decoration: InputDecoration(
                      counterStyle: TextStyle(color: Colors.white),
                      labelText: "Price Range",
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 20,
                          color: Colors.white),
                      border: OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide:
                            const BorderSide(color: Colors.white, width: 0.0),
                      ),
                    ),
                    onChanged: (value) {
                      this.price = value;
                    },
                  ),
                ),
                // Container(
                //   width: 350,
                //   child: TextField(
                //     keyboardType: TextInputType.number,
                //     maxLength: 5,
                //     style: TextStyle(fontFamily: 'Raleway', color: Colors.black),
                //     decoration: InputDecoration(
                //       labelText: "Point",
                //       labelStyle:
                //           TextStyle(fontWeight: FontWeight.w200, fontSize: 20),
                //       border: OutlineInputBorder(),
                //     ),
                //     onChanged: (value) {
                //       this.point = value;
                //     },
                //   ),
                // ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        Map<String, dynamic> products = {
                          // 'barcode': '$_scanBarcode',
                          'surname': this.surname,
                          'name': this.name,
                          'location': this.location,
                          'price': this.price,
                          // 'point': this.point,
                          'jobTitle': this.jobTitle,
                        };
                        crudObj.addData(products).then((result) {
                          dialogTrigger(context);
                        }).catchError((e) {
                          print(e);
                        });
                      },
                      elevation: 4.0,
                      splashColor: Colors.yellow,
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                      ),
                    ),
                    RaisedButton(
                      color: Colors.red.shade400,
                      onPressed: () {
                        Navigator.of(context).pop();
                        FirebaseAuth.instance.signOut().then((value) {
                          Navigator.of(context)
                              .pushReplacementNamed('loginpage');
                        }).catchError((e) {
                          print(e);
                        });
                      },
                      elevation: 4.0,
                      splashColor: Colors.white,
                      child: Text(
                        'Back',
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

//   Widget floatingBar() => Ink(
//         decoration: ShapeDecoration(
//           shape: StadiumBorder(),
//         ),
//         child: FloatingActionButton.extended(
//           onPressed: () => scanBarcodeNormal(),
//           backgroundColor: Colors.black,
//           icon: Icon(
//             FontAwesomeIcons.barcode,
//             color: Colors.white,
//           ),
//           label: Text(
//             "SCAN",
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ),
//       );
}

Future<bool> dialogTrigger(BuildContext context) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Job done', style: TextStyle(fontSize: 22.0)),
          content: Text(
            'Added Successfully',
            style: TextStyle(fontSize: 20.0),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Alright',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
