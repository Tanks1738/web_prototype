
import 'package:flutter/material.dart';

class builders_Page extends StatefulWidget {
  builders_Page({key})
      : super(key: key); //? for making the key to be non-null
  @override
  builders_PageState createState() => builders_PageState();
}

class builders_PageState extends State< builders_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.yellow[700],
      //   centerTitle: true,
      //   title: Text("What we do?"),
      // ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black12,
          child: Column(
              children: <Widget> [
                Padding(
                    padding: const EdgeInsets.only(top:30, bottom: 2,left: 15,right: 15),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(text:
                          "\n"
                    "BUILDERS  \n\n",
                      style:TextStyle(
                        color: Colors.pink,
                        fontSize: 30, fontFamily:
                      'Montserrat', fontWeight:
                      FontWeight.w600,),

                      children:[
                        WidgetSpan( child: Align(alignment:
                        Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              " "
                              " People who manage, coordinate and work on the construction site."
                              " They can build, repair, or renovate your household.\n "
                            ,
                            style:TextStyle(fontSize: 18, fontFamily: 'Montserrat', fontWeight: FontWeight.w500, color: Colors.black,),),
                          ) ,),),
                        WidgetSpan(child:Text(" "),),
                      ],
                    ),
                    )
                ),
                Container(child: new Image.asset('images/bldr1.png',
                  height: 345.0, width: 334.0,
                  fit: BoxFit.cover,),),
                Container(child: new Image.asset('', height: 50.0, width: 500.0, fit: BoxFit.cover,),),
                Container(child: new Image.asset('images/bldr2.png',
                  height: 345.0, width: 334.0,
                  fit: BoxFit.cover,),),
                Container(child: new Image.asset('', height: 50.0, width: 500.0, fit: BoxFit.cover,),),
              ]
          ),
        ),
      ),
    );
  }
}
