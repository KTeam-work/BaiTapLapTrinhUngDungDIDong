import 'dart:ffi';

import 'package:flutter/material.dart';

class vidientu extends StatelessWidget{
  const vidientu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "bai_tap_4",
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.all(30),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "My",
                            style: TextStyle(fontSize: 22,color: Colors.black,fontWeight: FontWeight.bold)
                          ),

                          
                          TextSpan(
                            text: "  Cards",
                            style: TextStyle(fontSize: 22,fontWeight: FontWeight.w300,color: Colors.black)
                          )
                        ],
                      ),

                    )
                  ),

                  const SizedBox(width: 10,),

                  Container(
                    margin: EdgeInsets.all(22),
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(14)
                    ),
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.add,size: 16,)),
                  )
                ],
              ),

              const SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadiusDirectional.circular(15)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 20,left: 15),
                       child: Text("Balance",
                         style: TextStyle(fontSize: 16,color: Colors.white),

                       ),
                    ),

                    Padding(padding: EdgeInsets.only(top: 10,left: 15),
                      child: Text(
                        r'$5250.25',
                        style: TextStyle(fontSize: 32, color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                    ),

                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(padding: EdgeInsetsGeometry.only(left: 20),
                          child:  Text("12345678",style: TextStyle(color: Colors.white),),
                        ),

                        Padding(padding: EdgeInsetsGeometry.only(right: 20),
                          child:  Text("10/24",style: TextStyle(color: Colors.white),),
                        )
                      ],
                    )
                  ],
                ),

              ),

              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    height: 22,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),


                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    height: 20,
                    width: 18,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),


                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    height: 20,
                    width: 18,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ]
                        ),
                        child: const Icon(Icons.email, size: 60, color: Colors.green),
                      ),

                      const SizedBox(height: 6),
                      const Text(
                        'Pay',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      ),

                    ],
                  ),

                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color:Colors.white,
                            borderRadius: BorderRadiusDirectional.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ]
                        ),
                        child: const Icon(Icons.credit_card, size: 60, color: Colors.blue),
                      ),

                      const SizedBox(height: 6),
                      const Text(
                        'Pay',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      ),

                    ],
                  ),

                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color:Colors.white,
                            borderRadius: BorderRadiusDirectional.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ]
                        ),
                        child: const Icon(Icons.receipt_long, size: 60, color: Colors.orange),
                      ),

                      const SizedBox(height: 6),
                      const Text(
                        'Pay',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      ),

                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30,),
              Column(
                children: [
                  Row(

                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 30),
                         height: 80,
                         decoration: BoxDecoration(
                           color: Colors.white, 
                           borderRadius: BorderRadiusDirectional.circular(15)
                         ),
                        child: const Icon(Icons.bar_chart, color: Colors.green, size: 80),
                      ),

                      const SizedBox(width: 20,),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Statistics',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),

                          SizedBox(height: 2),
                          Text(
                            'Payment and Income',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )),

                      Padding(padding: EdgeInsets.only(right: 20),
                       child: const Icon(Icons.chevron_right, color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),

              const SizedBox(height: 20,),
              Column(
                children: [
                  Row(

                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadiusDirectional.circular(15)
                        ),
                        child: const Icon(Icons.swap_horiz, color: Colors.green, size: 80),
                      ),

                      const SizedBox(width: 20,),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transactions',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Transaction History',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )),

                      Padding(padding: EdgeInsets.only(right: 20),
                        child: const Icon(Icons.chevron_right, color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),




            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.pink,
          shape: const CircleBorder(),
          elevation: 4,
          child: const Text(
            r'$',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,


      ),
    );
  }
}