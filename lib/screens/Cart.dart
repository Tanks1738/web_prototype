import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:web_prototype/screens/PurchaseHistory.dart';
import 'package:toast/toast.dart';
//import 'package:flutter_rave/flutter_rave.dart';

class Cart extends StatefulWidget {
  Cart({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _Cart createState() => _Cart();
}

class _Cart extends State<Cart> {
  final _key = GlobalKey<ScaffoldState>();
  User user;
  Razorpay razorpay;
  int price;
  String phoneNumber;
  int points;

  Future<void> getUserData() async {
    User userData = await FirebaseAuth.instance.currentUser;
    setState(() {
      user = userData;
      print(userData.uid);
//      getUsercontact();
    });
  }

//  Future<void> getUsercontact() async {
//    DocumentSnapshot cn = await FirebaseFirestore.instance
//        .collection('users')
//        .doc('${user.uid}')
//        .get();
//    String number = cn.data()['phoneNumber'];
//    setState(() {
//      phoneNumber = number;
//      return phoneNumber;
//    });
//  }

  Stream gettotalId() async* {
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('userData')
        .doc('${user.uid}')
        .collection('cartData')
        .get();
    yield qn.docs.length.toString();
  }

  Future getpointsId() async {
    QuerySnapshot qnB = await FirebaseFirestore.instance
        .collection('userData')
        .doc('${user.uid}')
        .collection('cartData')
        .get();
    return qnB.docs.length.toString();
  }

  Stream gettotal() async* {
    int total = 0;
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('userData')
        .doc('${user.uid}')
        .collection('cartData')
        .get();
    for (int i = 0; i < qn.docs.length; i++) {
      total = total + int.parse(qn.docs[i]['price']);
      price = total;
    }
    setState(() {
      price = total;
      return price;
    });
    yield total;
  }

  Future getpoints() async {
    int point = 0;
    QuerySnapshot qnB = await FirebaseFirestore.instance
        .collection('userData')
        .doc('${user.uid}')
        .collection('cartData')
        .get();
    for (int i = 0; i < qnB.docs.length; i++) {
      point = point + int.parse(qnB.docs[i]['point']);
      points = point;
    }
    setState(() {
      points = point;
      return points;
    });
    return point;
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    gettotalId();
    getpointsId();
    gettotal();
    getpoints();
//    getUsercontact();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  _pay(BuildContext context) {
    final snackBarOnFailure = SnackBar(content: Text('Transaction failed'));
    final snackBarOnClosed = SnackBar(content: Text('Transaction closed'));
//    final _rave = RaveCardPayment(
//      isDemo: true,
//      encKey: "FLWSECK_TEST433cb384db13",
//      publicKey: "FLWPUBK_TEST-9eae3b8634acbdd9a801947fc50358c5-X",
//      transactionRef: "SCH${DateTime.now().millisecondsSinceEpoch}",
//      amount: price.toDouble(),
//      email: "${user.email}",
//      onSuccess: (response) async {
//        print("$response");
//        print("Transaction Successful");
//        await FirebaseFirestore.instance
//            .collection('userData')
//            .doc('${user.uid}')
//            .collection('cartData')
//            .get()
//            .then((querySnapshot) {
//          querySnapshot.docs.forEach((result) {
//            FirebaseFirestore.instance
//                .collection('userOrders')
//                .doc('${user.uid}')
//                .collection('orders')
//                .doc()
//                .set(result.data());
//          });
//        });
//        Navigator.push(
//            context,
//            MaterialPageRoute(
//                builder: (BuildContext context) => PurchaseHistory()));
//        if (mounted) {
//          Scaffold.of(context).showSnackBar(
//            SnackBar(
//              content: Text("Transaction Sucessful!"),
//              backgroundColor: Colors.green,
//              duration: Duration(
//                seconds: 5,
//              ),
//            ),
//          );
//        }
//      },
//      onFailure: (err) {
//        print("$err");
//        print("Transaction failed");
//        _key.currentState.showSnackBar(snackBarOnFailure);
//      },
//      onClosed: () {
//        print("Transaction closed");
//        _key.currentState.showSnackBar(snackBarOnClosed);
//      },
//      context: context,
//    );
//    _rave.process();
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_XMAhis5jshTTUn ',
      'amount': price * 100,
      'name': 'Acme Corp.',
      'description': 'Grocery Product',
      'prefill': {'contact': phoneNumber, 'email': '${user.email}'},
      'external': {
        'wallet': ['paytm']
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) async {
    print('Payment success');
    Toast.show('Payment success', context);
    await FirebaseFirestore.instance
        .collection('userData')
        .doc('${user.uid}')
        .collection('cartData')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        FirebaseFirestore.instance
            .collection('userOrders')
            .doc('${user.uid}')
            .collection('orders')
            .doc()
            .set(result.data());
      });
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => PurchaseHistory()));
    razorpay.clear();
  }

  void handlerErrorFailure() {
    print('payment Error');
    Toast.show('Payment Error', context);
  }

  void handlerExternalWallet() {
    print('External wallet');
    Toast.show('External wallet', context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children:<Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder(
                    stream: gettotalId(),
                    builder: (context, snapshot) {
                      return Container(
//                        margin: EdgeInsets.only(left: 35, bottom: 25),
                        child: Column(
//                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            StreamBuilder(
                                stream: gettotal(),
                                builder: (context, price) {
                                  return Text(
                                    "Total:   " + 'R ${price.data}',
                                    style: TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.w300),
                                  );
                                }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Items: ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    )),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                    snapshot.data != null
                                        ? snapshot.data
                                        : 'Loading',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Divider(
                              height: 1,
                              color: Colors.grey[700],
                            ),
                            SizedBox(height: 10.0,),
//                            GestureDetector(
//                              child: Container(
////                                margin: EdgeInsets.only(right: 25),
//                                padding: EdgeInsets.all(15),
//                                decoration: BoxDecoration(
//                                    color: Colors.blue[600],
//                                    borderRadius: BorderRadius.circular(15)),
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: <Widget>[
//                                    Text(
//                                      "Pay",
//                                      textAlign: TextAlign.center,
//                                      style: TextStyle(
//                                        fontWeight: FontWeight.w900,
//                                        fontSize: 17,
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                              ),
//                              onTap: () {
//                                // openCheckout();
//                                _pay(context);
//                              },
//                            ),
                          ],
                        ),
                      );
                    }),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("userData")
                      .doc('${user.uid}')
                      .collection('cartData')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null)
                      return Text(
                        'No Items in Calculator List',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      );
                    return Container(
                      height: 510,
//                        width: 395,
                      child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot products =
                          snapshot.data.docs[index];
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Card(
                              child: ListTile(
                                leading: Image.network(products['img']),
                                title: Text(
                                  products['name'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "\R " + products['price'],
                                      style:
                                      TextStyle(fontWeight: FontWeight.bold),
                                    ),
//                                      Text(
//                                        products['materialtype'],
//                                        style:
//                                        TextStyle(fontWeight: FontWeight.bold),
//                                      ),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      gettotalId();
                                    });
                                    FirebaseFirestore.instance
                                        .collection("userData")
                                        .doc('${user.uid}')
                                        .collection('cartData')
                                        .doc(products['id'])
                                        .delete()
                                        .then((result) {print(user.uid);})
                                        .catchError((e) {
                                      print(e);
                                    });
                                    Scaffold.of(context)
                                        .showSnackBar(new SnackBar(
                                      content: new Text(
                                        'Deleted',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15),
                                        textAlign: TextAlign.start,
                                      ),
                                      duration: Duration(milliseconds: 300),
                                      backgroundColor: Color(0xFF3D82AE),
                                    ));
                                  },
                                ),
                              ),
                            ),
                          );
                        },
//                          separatorBuilder:
//                              (BuildContext context, int index) {
//                            return SizedBox(height: 20);
//                          }
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.white70,
    iconTheme: IconThemeData(color: Colors.black),
    title: Text(
      "My Calculator",
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
  );
}
