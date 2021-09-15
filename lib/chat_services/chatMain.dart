import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'preChat.dart';
import 'AppConfig.dart';

import 'chatHome.dart';
//import 'package:web_prototype/chatbot-watson-android-master/app/src/main/java/com/example/vmac/WatBot/MainActivity.java';

//void main() => runApp(MyApp());

class chat_Main_Page extends StatefulWidget {
  @override
  chat_Main_PageState createState() => chat_Main_PageState();
 //  static const methodChannel = const MethodChannel('myChannel');
 //
 // // Future <Null>
 //  void onCreate() async {
 //    try{
 //      await methodChannel.invokeMethod('onCreate');
 //    } on Exception catch (e) {}
 //  }

}


//class HomeController extends GetxController {
  // static const methodChannel = const MethodChannel('myChannel');
 // @override
 // void onInit(){
 //    super.onInit();
 //  }
 //
 //  @override
 //  void onReady(){
 //    super.onReady();
 //  }
 //  @override
 //  void onClose() {}

  // Future <Null> MainActivity() async {
  //   try{
  //     await methodChannel.invokeMethod('MainActivity');
  //   } on Exception catch (e) {}
  // }
//}


class chat_Main_PageState extends State<chat_Main_Page> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[700],
          title:  Text(
            'Golden Key Construction Chat',
              // style:TextStyle()
          ),
        ),
        body:
        //onCreate(),
        LoginPage(),
      ),
    );
  }
  onCreate() {
  }
}

// ignore: must_be_immutable

class LoginPage extends StatelessWidget {
  TextEditingController userId = new TextEditingController();
  TextEditingController password = new TextEditingController();

  void loginUser(context) {
    dynamic user = {
      'userId': userId.text,
      'password': password.text,
      'appId': AppConfig.APP_ID
    };

    KommunicateFlutterPlugin.login(user).then((result) {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>
          HomePage()
      ));
      print("Login successful : " + result.toString());
    }).catchError((error) {
      print("Login failed : " + error.toString());
    });
  }

  void loginAsVisitor(context) {
    KommunicateFlutterPlugin.loginAsVisitor(AppConfig.APP_ID).then((result) {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      print("Login as visitor successful : " + result.toString());
    }).catchError((error) {
      print("Login as visitor failed : " + error.toString());
    });
  }

  void buildConversation() {
    dynamic conversationObject = {'appId': AppConfig.APP_ID};

    KommunicateFlutterPlugin.buildConversation(conversationObject)
        .then((result) {
      print("Conversation builder success : " + result.toString());
    }).catchError((error) {
      print("Conversation builder error occurred : " + error.toString());
    });
  }

  void buildConversationWithPreChat(context) {
    try {
      KommunicateFlutterPlugin.isLoggedIn().then((value) {
        print("Logged in : " + value.toString());
        if (value) {
          KommunicateFlutterPlugin.buildConversation(
              {'isSingleConversation': true, 'appId': AppConfig.APP_ID})
              .then((result) {
            print("Conversation builder success : " + result.toString());
          }).catchError((error) {
            print("Conversation builder error occurred : " + error.toString());
          });
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PreChatPage()));
        }
      });
    } on Exception catch (e) {
      print("isLogged in error : " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      KommunicateFlutterPlugin.isLoggedIn().then((value) {
        print("Logged in : " + value.toString());
        if (value) {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      });
    } on Exception catch (e) {
      print("isLogged in error : " + e.toString());
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 155.0,
              child: Image.asset(
                "assets/ic_launcher_without_shape.png",
                fit: BoxFit.contain,
              ),
            ),
            new TextField(
              controller: userId,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Enter a Username for Guide",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0))),
            ),
            SizedBox(height: 10),
            new TextField(
              controller: password,
              obscureText: true,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Enter Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0))),
            ),
            SizedBox(height: 10),
            new Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.blueAccent,

                //Login button
                child: new MaterialButton(
                  onPressed: ()async{
                   try{                            // The APP_ID obtained from kommunicate dashboard.
                        dynamic conversationObject = {'appId': '2593bb203bd8cdb36944a71d074a16ca0' };

                        dynamic result = await KommunicateFlutterPlugin.buildConversation(conversationObject);
                   // .then((clientConversationId)
                        print("Conversation builder success : " + result.toString());
                    // loginUser(context);
                        } on Exception catch(error){
                          print("Conversation builder error : " + error.toString());
                         };
                       },
                  minWidth: 400,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  child: Text(
                       "Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)
                          .copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                )),
            SizedBox(height: 10),

            //Login as visitor button
            // new Material(
            //     elevation: 5.0,
            //     borderRadius: BorderRadius.circular(30.0),
            //     color: Colors.yellow[700],
            //     child: new MaterialButton(
            //       onPressed: () {
            //         loginAsVisitor(context);
            //       },
            //       minWidth: 400,
            //       padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            //       child: Text("Login as Visitor",
            //           textAlign: TextAlign.center,
            //           style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)
            //               .copyWith(
            //               color: Colors.white,
            //               fontWeight: FontWeight.bold)),
            //     )),
            // SizedBox(height: 10),

            // //Use conversation builder button
            // new Material(
            //     elevation: 5.0,
            //     borderRadius: BorderRadius.circular(30.0),
            //     color:Colors.yellow[700],
            //     child: new MaterialButton(
            //       onPressed: () {
            //         buildConversation();
            //       },
            //       minWidth: 400,
            //       padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            //       child: Text("Use conversation builder",
            //           textAlign: TextAlign.center,
            //           style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)
            //               .copyWith(
            //               color: Colors.white,
            //               fontWeight: FontWeight.bold)),
            //     )),
            // SizedBox(height: 10),


            //Builder with Pre chat form button
            // new Material(
            //     elevation: 5.0,
            //     borderRadius: BorderRadius.circular(30.0),
            //     color: Colors.yellow[700],
            //     child: new MaterialButton(
            //         onPressed: () {
            //           buildConversationWithPreChat(context);
            //         },
            //         minWidth: 400,
            //         padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            //         child: Text("Builder with Pre chat form",
            //             textAlign: TextAlign.center,
            //             style:
            //             TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)
            //                 .copyWith(
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.bold))))
          ],
        ),
      ),
    );
  }
}