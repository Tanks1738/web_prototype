
import 'package:flutter/material.dart';

class plumbers_Page extends StatefulWidget {
  plumbers_Page({Key key})
      : super(key: key); //? for making the key to be non-null
  @override
  plumbers_PageState createState() => plumbers_PageState();
}

class plumbers_PageState extends State< plumbers_Page> {
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
                        "\n"
                            "PLUMBERS \n\n",
                      style:TextStyle(color: Colors.pink, fontSize: 30, fontFamily: 'Montserrat', fontWeight: FontWeight.w600,),

                      children:[
                        WidgetSpan( child: Align(alignment: Alignment.center,child:
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(   " "
                              "Plumbers are people that install pipes that supply water and gases"
                              "as well as the pipes that take waste out and away from your home."
                              "They also install dishwashers, washing machines, sinks, toilets,"
                              " bathtubs and other appliances in your home.\n"
                              ,
                            style:TextStyle(fontSize: 18, fontFamily: 'Montserrat', fontWeight: FontWeight.w500, color: Colors.black,),),
                        ) ,),),
                        WidgetSpan(child:Text(" "),),
                      ],
                    ),
                    )
                ),
                Container(child: new Image.asset('images/plumber.jpg',
                  height: 345.0, width: 334.0,
                  fit: BoxFit.cover,),),
                Container(child: new Image.asset('',
                  height: 45.0, width: 334.0,
                  fit: BoxFit.cover,),),
                Container(child: new Image.asset('images/plumber2.png',
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

//
// 1.	PAINTERS - are people who paints households to make them look bright and beautiful.
// 	Types of paints that can be done on your household:
// •	Flat/Matte paint – is a type of paint that has least amount of shine. It can be used to cover holes, nails, or the side that is least used on the house because they are easily damageable.
