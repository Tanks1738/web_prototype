
import 'package:flutter/material.dart';

class painters_Page extends StatefulWidget {
  painters_Page({Key key})
      : super(key: key); //? for making the key to be non-null
  @override
  painters_PageState createState() => painters_PageState();
}

class painters_PageState extends State< painters_Page> {
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
                  padding: const EdgeInsets.only(top:50, bottom: 2,left: 15,right: 15),
                  child: RichText(textAlign: TextAlign.center, text: TextSpan(text:
                              "Painters \n\n",
                      style:TextStyle(color: Colors.pink, fontSize: 30, fontFamily: 'Montserrat', fontWeight: FontWeight.w600,),

                        children:[

                          WidgetSpan( child: Align(alignment: Alignment.center,child:Text(
                            "People who paint households to make them look bright and beautiful. \n",
                            style:TextStyle(fontSize: 20, fontFamily: 'Montserrat', fontWeight: FontWeight.w400, color: Colors.black,),) ),),

                          WidgetSpan( child: Align(alignment: Alignment.center,child:Text(
                            "Types of paints that can be used for your household include: \n\n",
                            style:TextStyle(fontSize: 20, fontFamily: 'Montserrat', fontWeight: FontWeight.w700, color: Colors.black, fontStyle: FontStyle.italic),) ),),

                          WidgetSpan( child: Align(alignment: Alignment.center,child:Text(
                            " Flat/Matte paint ",
                            style:TextStyle(fontSize: 20, fontFamily: 'Montserrat', fontWeight: FontWeight.w600, color: Colors.pink,),) ,),),

                          WidgetSpan( child: Align(alignment: Alignment.center,child:
                          Text(
                            " \n"
                            "Flat/Matte paint is a type of paint that has least amount"
                            "of shine. It can be used to cover holes, nails, or the side"
                            " that is least used on the house because they are easily"
                            " damageable.",
                            style:TextStyle(fontSize: 18, fontFamily: 'Montserrat', fontWeight: FontWeight.w400, color: Colors.black,),) ,),),

                          WidgetSpan(child:Text(" "),),
                        ],
                        ),
                      )
                  ),
                Container(child: new Image.asset('images/paint.jpg',
                  height: 345.0, width: 334.0,
                  fit: BoxFit.cover,),),

                ///Eggshell
                Padding(
                    padding: const EdgeInsets.only(top:30, bottom: 2,left: 15,right: 15),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text:
                      TextSpan(
                        children:[
                          WidgetSpan( child:Align(alignment: Alignment.center,
                            child:Text(
                              "\n\n"
                               "Eggshell\n",
                              style: TextStyle(fontSize: 20, fontFamily: 'Montserrat', fontWeight: FontWeight.w600, color: Colors.pink,),),),),
                          WidgetSpan( child: Align(alignment: Alignment.center,child:Text(
                            "This type of paint is shinier that flat paint and has"
                            "medium duration but is it also damageable which"
                            "is why it can be used on hallways, dining rooms, "
                            "entryways etc.",
                            style:TextStyle(fontSize: 20, fontFamily: 'Montserrat', fontWeight: FontWeight.w400, color: Colors.black,),) ),),
                          WidgetSpan(child:Text(" "),),
                        ],
                      ),
                    )
                ),
                Container(child: new Image.asset('images/Paint2.png',
                  height: 345.0, width: 334.0,
                  fit: BoxFit.cover,),),


                ///Satin
                Padding(
                    padding: const EdgeInsets.only(top:80, bottom: 2,left: 15,right: 15),
                    child: RichText(textAlign: TextAlign.justify, text:
                      TextSpan(
                        children:[
                          WidgetSpan( child:Align(alignment: Alignment.center,
                            child:Text(
                              "Satin\n",
                              style: TextStyle(fontSize: 20, fontFamily: 'Montserrat', fontWeight: FontWeight.w600, color: Colors.pink,),),),),
                          WidgetSpan( child: Align(alignment: Alignment.center,child:Text(

                                "This paint has a velvety sheen look and not easily damageable "
                                "with a high duration span. Which is why it is recommendable "
                                "to use it in rooms like kitchens, bathrooms, playrooms, laundry "
                                "rooms, as well as sleeping rooms..",

                            style:TextStyle(fontSize: 20, fontFamily: 'Montserrat', fontWeight: FontWeight.w400, color: Colors.black,),) ),),
                          WidgetSpan(child:Text(" "),),
                        ],
                      ),
                    )
                ),
                Container(child: new Image.asset('images/Paint_Satin.png',
                  height: 345.0, width: 334.0,
                  fit: BoxFit.cover,),),


                ///Semi gloss
                Padding(
                    padding: const EdgeInsets.only(top:80, bottom: 2,left: 15,right: 15),
                    child: RichText(textAlign: TextAlign.justify, text:
                    TextSpan(
                      children:[
                        WidgetSpan( child:Align(alignment: Alignment.center,
                          child:Text(
                            "Semi-gloss \n",
                            style: TextStyle(fontSize: 20, fontFamily: 'Montserrat', fontWeight: FontWeight.w600, color: Colors.pink,),),),),
                        WidgetSpan( child: Align(alignment: Alignment.center,child:Text(

                              "The semi-gloss paint is shinier than satin paint and high duration "
                              "span as well. They can be used for outdoor trimming or sides that "
                              "get moisture mostly.",

                          style:TextStyle(fontSize: 20, fontFamily: 'Montserrat', fontWeight: FontWeight.w400, color: Colors.black,),) ),),
                        WidgetSpan(child:Text(" "),),
                      ],
                    ),
                    )
                ),
                Container(child: new Image.asset('images/Semi_Gloss.png',
                  height: 345.0, width: 334.0,
                  fit: BoxFit.cover,),),


                ///High gloss
                Padding(
                    padding: const EdgeInsets.only(top:80, bottom: 2,left: 15,right: 15),
                    child: RichText(textAlign: TextAlign.justify, text:
                    TextSpan(
                      children:[
                        WidgetSpan( child:Align(alignment: Alignment.center,
                          child:Text(
                            "High-gloss\n",
                            style: TextStyle(fontSize: 20, fontFamily: 'Montserrat', fontWeight: FontWeight.w600, color: Colors.pink,),),),),
                        WidgetSpan( child: Align(alignment: Alignment.center,child:Text(

                          "This paint is the shiniest of them all and it has high duration span. "
                          "It can be used to paints outdoors, trimming as well, and doors.",

                          style:TextStyle(fontSize: 20, fontFamily: 'Montserrat', fontWeight: FontWeight.w400, color: Colors.black,),) ),),
                        WidgetSpan(child:Text(" "),),
                      ],
                    ),
                    )
                ),
                Container(child: new Image.asset('images/High_Gloss.png',
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

//
// 1.	PAINTERS - are people who paints households to make them look bright and beautiful.
// 	Types of paints that can be done on your household:
// •	Flat/Matte paint – is a type of paint that has least amount of shine. It can be used to cover holes, nails, or the side that is least used on the house because they are easily damageable.
