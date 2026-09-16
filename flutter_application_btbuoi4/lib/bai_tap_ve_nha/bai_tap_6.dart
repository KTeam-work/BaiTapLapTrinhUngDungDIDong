import 'package:flutter/material.dart';

class nghenhac extends StatelessWidget{
  const nghenhac({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "bai_6",
      debugShowCheckedModeBanner: false,

      home:Scaffold(
        backgroundColor:const Color(0xFFE0E0E0),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(padding: EdgeInsets.only(left: 10,top: 40),
                    child: Container(
                      width: 50,
                      height: 60,
                      decoration: BoxDecoration(
                          color:const Color(0xFFE0E0E0),
                          borderRadius: BorderRadiusDirectional.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 1,
                              blurRadius: 8,

                            )
                          ]
                      ),
                      child: Center(
                        child: Icon(Icons.arrow_back,size: 20,),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10,),

                  Padding(padding: EdgeInsets.only(top: 40),
                     child: Text("PLAYLIST",style:TextStyle(color: Colors.grey,fontSize: 21),),
                  ),

                  const SizedBox(width: 10,),

                  Padding(padding: EdgeInsets.only(top: 40,right: 10),
                    child: Container(
                      width: 50,
                      height: 60,
                      decoration: BoxDecoration(
                          color:const Color(0xFFE0E0E0),
                          borderRadius: BorderRadiusDirectional.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 1,
                              blurRadius: 8,

                            )
                          ]
                      ),
                      child: Center(
                        child: Icon(Icons.menu,size: 20,),
                      ),
                    ),
                  )

                ],
              ),

              const SizedBox(height: 30,),
              Container(
                height: 400,
                margin: EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                  color:const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      spreadRadius: 1,
                      blurRadius: 8,

                    ),
                  ],

                ),

                child: Column(
                  children: [
                    Container(
                      width: 400,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage("assets/anh1.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                      children: [
                         Column(
                           children: [
                             Padding(padding: EdgeInsetsGeometry.only(left: 10,top: 5),
                               child: RichText(
                                 text: TextSpan(
                                   text: "Kota The Friend",
                                   style: TextStyle(color: Colors.grey, fontSize: 16),
                                   children: <TextSpan>[
                                     TextSpan(
                                       text: "\nBride",
                                       style: TextStyle(
                                         color: Colors.black,
                                         fontSize: 24,
                                         fontWeight: FontWeight.bold,
                                       ),
                                     ),
                                   ],
                                 ),
                               ),


                             ),



                           ],
                         ),

                        Padding(padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.favorite,color: Colors.red,size: 30,),
                        ),
                      ],
                    ),




                  ],
                ),
              ),


              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(padding: EdgeInsets.only(left: 20),
                    child: Text("0:00",style: TextStyle(color: Colors.grey,fontSize: 20),),
                  ),

                  Padding(padding: EdgeInsets.only(),
                    child: Icon(Icons.shuffle,size: 20,)
                  ),

                  Padding(padding: EdgeInsets.all(1),
                    child: Icon(Icons.repeat,size: 20,)
                  ),

                  Padding(padding: EdgeInsets.only(right: 20),
                    child: Text("4:22",style: TextStyle(color: Colors.grey,fontSize: 20),),
                  )
                ],
              ),

              const SizedBox(height: 30,),
              Container(
                height: 10,
                margin: EdgeInsets.only(left: 50),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-2, -2),
                      blurRadius: 8,
                      spreadRadius: 1
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(2, 2),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.7,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                      color:Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.shade300,
                          spreadRadius: 1,
                          blurRadius: 8
                        )
                      ]
                    ),
                    child: Center(
                      child:Icon(Icons.skip_previous,size: 26,),
                    ),
                  ),

                  Container(
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                        color:Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blueGrey.shade300,
                              spreadRadius: 1,
                              blurRadius: 8
                          )
                        ]
                    ),
                    child: Center(
                      child:Icon(Icons.play_arrow,size: 26,),
                    ),
                  ),

                  Container(
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                        color:Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blueGrey.shade300,
                              spreadRadius: 1,
                              blurRadius: 8
                          )
                        ]
                    ),
                    child: Center(
                      child:Icon(Icons.skip_next,size: 26,),
                    ),
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );

  }
}