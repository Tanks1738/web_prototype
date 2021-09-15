// import 'package:flutter/material.dart';
// import 'package:kommunicate_flutter/kommunicate_flutter.dart';
//
// class chatbot_Page extends StatefulWidget {
//   chatbot_Page({key})
//       : super(key: key); //? for making the key to be non-null
//   @override
//   chatbot_PageState createState() => chatbot_PageState();
// }
//
// class chatbot_PageState extends State< chatbot_Page> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // appBar: AppBar(
//         //   backgroundColor: Colors.yellow[700],
//         //   centerTitle: true,
//         //   title: Text("What we do?"),
//         // ),
//         body: Center(
//
//             dynamic conversationObject = {
//         'appId': '<2593bb203bd8cdb36944a71d074a16ca0 >',
//         };
//
//             KommunicateFlutterPlugin.buildConversation(conversationObject)
//             .then((clientConversationId) {
//           print("Conversation builder success : " + clientConversationId.toString());
//         }).catchError((error) {
//           print("Conversation builder error : " + error.toString());
//         });
//         )
//     );
//   }
// }
