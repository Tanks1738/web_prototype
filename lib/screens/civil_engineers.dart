
import 'package:flutter/material.dart';

class civilEngineers_Page extends StatefulWidget {
  civilEngineers_Page({Key key})
      : super(key: key); //? for making the key to be non-null
  @override
  civilEngineers_PageState createState() => civilEngineers_PageState();
}

class civilEngineers_PageState extends State< civilEngineers_Page> {
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
                    child: RichText(textAlign: TextAlign.center, text: TextSpan(text:
                    " \n"
                    "CIVIL ENGINEERS \n",
                      style:TextStyle(color: Colors.pink, fontSize: 30, fontFamily: 'Montserrat', fontWeight: FontWeight.w600,),

                      children:[
                        WidgetSpan( child: Align(alignment: Alignment.center,child:
                        Text(
                             "\n"
                             " The type of people who create, improve and project our environment."
                             " Their purpose is to plan, design, and oversee the construction"
                             " and maintain the building structures and infrastructures.\n",
                          style:TextStyle(fontSize: 18, fontFamily: 'Montserrat', fontWeight: FontWeight.w500, color: Colors.black,),) ,),),
                        WidgetSpan(child:Text(" "),),
                      ],
                    ),
                    )
                ),
                Container(child: new Image.asset('images/CivilEngineers.png',
                  height: 345.0, width: 334.0,
                  fit: BoxFit.cover,),),
                Container(child: new Image.asset('',
                  height: 45.0, width: 334.0,
                  fit: BoxFit.cover,),),
                Container(child: new Image.asset('images/CivilEngineersVR.jpg',
                  height: 345.0, width: 334.0,
                  fit: BoxFit.cover,),),
                Container(child: new Image.asset('',
                  height: 45.0, width: 334.0,
                  fit: BoxFit.cover,),),
              ]
          ),
        ),
      ),

    );
  }
}