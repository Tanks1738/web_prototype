import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/cupertino.dart';


class alan_Page extends StatefulWidget {
  alan_Page({key})
      : super(key: key); //? for making the key to be non-null
  @override
  alan_PageState createState() => alan_PageState();
}
class alan_PageState extends State< alan_Page> {


  @override
  Widget build(BuildContext context) {
    /// Init Alan Button with project key from Alan Studio
    AlanVoice.addButton("57b5839c1e30b4e6817638653c99352b2e956eca572e1d8b807a3e2338fdd0dc/stage");

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command) {
      debugPrint("got new command ${command.toString()}");
    });
  }

//  _AlanPageState() {
//    /// Init Alan Button with project key from Alan Studio
//    AlanVoice.addButton("57b5839c1e30b4e6817638653c99352b2e956eca572e1d8b807a3e2338fdd0dc/stage");
//
//    /// Handle commands from Alan Studio
//    AlanVoice.onCommand.add((command) {
//      debugPrint("got new command ${command.toString()}");
//    });
  }