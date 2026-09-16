import 'package:flutter/material.dart';

class nguoidung extends StatelessWidget{
   const nguoidung({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bai_2",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.indigo,
        body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 300,
                  color: Colors.blue,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi, Jared!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                '23 Jan, 2021',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),

                          Container(
                            width: 48,
                            height: 56,
                            decoration: BoxDecoration(
                              color: const Color(0xFF287BD2),
                              borderRadius: BorderRadius.circular(10),


                            ),
                            child: const Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),



                        ],


                      ),

                      const SizedBox(height: 16),
                      // Tim Kiem
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF287BD2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search,size: 16,color: Colors.white,),
                            hintText: "Search",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            ),
                            contentPadding: EdgeInsets.only(top: 12)

                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(padding: EdgeInsetsGeometry.all(4),
                            child: Text("How do you feel",style: TextStyle(fontSize: 16,color:Colors.white,fontWeight: FontWeight.bold),),
                          ),

                          Padding(padding: EdgeInsetsGeometry.all(4),
                            child: Icon(Icons.more_horiz,color: Colors.white,),

                          )
                        ],
                      ),


                      const SizedBox(height: 10,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF287BD2),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child:Align(
                                  alignment: Alignment.center,
                                  child:  Text("😞",style:TextStyle(fontSize: 16),),
                                )
                              ),

                              const SizedBox(height: 10,),
                              Text("Bad",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),)


                            ],
                          ),


                          Column(
                            children: [
                              Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF287BD2),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child:Align(
                                    alignment: Alignment.center,
                                    child:  Text("🙂",style:TextStyle(fontSize: 16),),
                                  )
                              ),

                              const SizedBox(height: 10,),
                              Text("Fine",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),)


                            ],
                          ),


                          Column(
                            children: [
                              Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF287BD2),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child:Align(
                                    alignment: Alignment.center,
                                    child:  Text("😐",style:TextStyle(fontSize: 16),),
                                  )
                              ),

                              const SizedBox(height: 10,),
                              Text("Well",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),)


                            ],
                          ),

                          Column(
                            children: [
                              Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF287BD2),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child:Align(
                                    alignment: Alignment.center,
                                    child:  Text("🥳",style:TextStyle(fontSize: 16),),
                                  )
                              ),

                              const SizedBox(height: 10,),
                              Text("Excellent",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),)


                            ],
                          )
                        ],
                      )





                    ],
                  ),
                ),

                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(padding: EdgeInsetsGeometry.all(12),
                      child: Text('Exericses',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ),

                    Padding(padding: EdgeInsetsGeometry.all(15),
                      child: Text('...',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    )
                  ],
                ),

                const SizedBox(height: 10,),
                Row(
                  children: [
                   Expanded(child:
                   Container(
                     margin: const EdgeInsets.symmetric(horizontal: 16),
                     height: 80,
                     decoration: BoxDecoration(
                         color:Colors.white,
                         borderRadius: BorderRadius.circular(15)

                     ),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                           children: [
                             Container(
                               margin: const EdgeInsets.only(left: 16),
                               width: 60,
                               height: 60,
                               decoration: BoxDecoration(
                                   color: Colors.orange,
                                   borderRadius: BorderRadius.circular(10)
                               ),
                               child: const Icon(
                                 Icons.favorite,
                                 color: Colors.white,
                                 size: 25,
                               ),
                             ),

                             const SizedBox(width: 10,),

                             Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment:  CrossAxisAlignment.start,
                               children: [
                                 Text(
                                   "Speaking Skills",
                                   style: TextStyle(
                                     fontSize: 13,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),

                                 Text(
                                   "16 Exercises",
                                   style: TextStyle(
                                     fontSize: 10,
                                     color: Colors.grey,
                                   ),
                                 ),

                               ],
                             ),


                             const Spacer(),

                             Padding(padding: EdgeInsetsGeometry.only(right: 15),
                             child: Text("...",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),)



                           ],
                         ),



                       ],
                     ),


                   ),




                   ),

                  ],
                ),


                const SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(child:
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      height: 80,
                      decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.circular(15)

                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 16),
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),

                              const SizedBox(width: 10,),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment:  CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Reading Skills",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text(
                                    "8 Exercises",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),

                                ],
                              ),


                              const Spacer(),

                              Padding(padding: EdgeInsetsGeometry.only(right: 15),
                                child: Text("...",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),)



                            ],
                          ),



                        ],
                      ),


                    ),




                    ),

                  ],
                ),


                const SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(child:
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      height: 80,
                      decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.circular(15)

                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 16),
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: const Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),

                              const SizedBox(width: 10,),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment:  CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Writting Skills",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text(
                                    "20 Exercises",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),

                                ],
                              ),


                              const Spacer(),

                              Padding(padding: EdgeInsetsGeometry.only(right: 15),
                                child: Text("...",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),)



                            ],
                          ),



                        ],
                      ),


                    ),




                    ),

                  ],
                )



              ],
            ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor:Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey.shade600,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              label: 'Message',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),

      ),
    );

  }
}