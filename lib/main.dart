import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:web_prototype/screens/Cart.dart';
import 'package:web_prototype/check.dart';
import 'package:web_prototype/screens/PurchaseHistory.dart';
import 'package:web_prototype/screens/signup.dart';
import 'package:web_prototype/screens/splashscreen.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key,}) : super(key: key);
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routes = <String, WidgetBuilder>{
    '/check': (BuildContext context) => new Check(),
    '/homepage': (BuildContext context) => new HomePage(),
    '/loginpage': (BuildContext context) => new LoginPage(),
    '/signup': (BuildContext context) => new Signup(),
    '/cartpage': (BuildContext context) => new Cart(),
    '/purchasehistory': (BuildContext context) => new PurchaseHistory(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'web_prototypeApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Nunito',
      ),
      home: SplashScreen(),
      routes: routes,
    );
  }
}
