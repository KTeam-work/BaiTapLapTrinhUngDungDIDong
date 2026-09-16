import 'package:flutter/material.dart';


class may_tinh extends  StatelessWidget{
  const may_tinh({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "bai_1",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFF3F3F3),
        appBar: AppBar(
          title: const Text("Standard",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
          leading:Builder(builder:
          (context) {
            return IconButton(onPressed: (){
              Scaffold.of(context).openDrawer();
            }, icon: Icon(Icons.menu));
          }
          ),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.history))
          ],

        ),

        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                Container(
                  alignment: Alignment.bottomRight,
                  width: 380,
                  height: 200,
                  child: Text(
                    "0",style: TextStyle(fontSize: 34,fontWeight: FontWeight.bold),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.all(20),
                      child: Text(
                        "MC", style: TextStyle(fontSize: 16,color: Colors.grey),
                      ),
                    ),

                     Padding(padding: EdgeInsets.all(20),
                      child: Text(
                        "MR", style: TextStyle(fontSize: 16,color: Colors.grey),
                      ),
                    ),

                     Padding(padding: EdgeInsets.all(20),
                      child: Text(
                        "M+", style: TextStyle(fontSize: 16,color: Colors.grey,fontWeight: FontWeight.bold),
                      ),
                    ),

                     Padding(padding: EdgeInsets.all(20),
                      child: Text(
                        "M-", style: TextStyle(fontSize: 16,color: Colors.grey,fontWeight: FontWeight.bold),
                      ),
                    ),

                     Padding(padding: EdgeInsets.all(20),
                      child: Text(
                        "MS", style: TextStyle(fontSize: 16,color: Colors.grey,fontWeight: FontWeight.bold),
                      ),
                    ),


                     Padding(padding: EdgeInsets.all(20),
                      child: Text(
                        "M", style: TextStyle(fontSize: 16,color: Colors.grey),
                      ),
                    ),
                  ],
                ),


                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // dòng 1
                    Row(
                      children: [
                        Container(
                          height: 70,
                          width: 100,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFAFAFA),
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child:Center(
                            child:  Text(
                              "%",textAlign: TextAlign.center,
                            ),
                          )
                        ),

                        Container(
                          height: 70,
                          width: 100,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(
                            child: Text(
                              "CE",textAlign: TextAlign.center,
                            ),
                          )
                        ),


                        Container(
                          height: 70,
                          width: 100,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(
                            child: Text(
                              "C",textAlign: TextAlign.center,
                            ),
                          )
                        ),


                        Container(
                          height: 70,
                          width: 100,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(
                            child: IconButton(onPressed: () {},
                                icon: Icon(Icons.backspace,size: 16,)),
                          )
                        )


                      ],
                    ),

                    const SizedBox(height: 10,),


                    // Dòng 2
                    Row(
                      children: [
                        Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: const Color(0xFFFAFAFA),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child:Center(
                              child:  Text(
                                "¹/x",
                              ),
                            )
                        ),

                        Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: const Color(0xFFFAFAFA),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Text(
                                "x²",
                              ),
                            )
                        ),


                        Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: const Color(0xFFFAFAFA),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Text(
                                "²√x",
                              ),
                            )
                        ),


                        Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: const Color(0xFFFAFAFA),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                               child: Text("÷"),
                            )
                        )


                      ],
                    ),


                    const SizedBox(height: 10,),


                    // Dòng 3
                    Row(
                      children: [
                        Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child:Center(
                              child:  Text(
                                "7",
                              ),
                            )
                        ),

                        Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Text(
                                "8",
                              ),
                            )
                        ),


                        Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Text(
                                "9",
                              ),
                            )
                        ),


                        Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: const Color(0xFFFAFAFA),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Text("×"),
                            )
                        ),


                      ],
                    ),


                    const SizedBox(height: 10,),

                    // Dòng 4
                    Row(
                      children: [
                        Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child:Center(
                              child:  Text(
                                "4",
                              ),
                            )
                        ),

                        Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Text(
                                "5",
                              ),
                            )
                        ),


                        Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Text(
                                "6",
                              ),
                            )
                        ),


                        Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: const Color(0xFFFAFAFA),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Text("−"),
                            )
                        ),


                      ],
                    ),


                    const SizedBox(height: 10,),


                    // Dòng 5
                    Row(
                      children: [
                        Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child:Center(
                              child:  Text(
                                "1",
                              ),
                            )
                        ),

                        Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Text(
                                "2",
                              ),
                            )
                        ),


                        Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Text(
                                "3",
                              ),
                            )
                        ),


                        Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: const Color(0xFFFAFAFA),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Text("+"),
                            )
                        ),


                      ],
                    ),

                    const SizedBox(height: 10,),
                    // Dòng 5
                    Row(
                      children: [
                        Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child:Center(
                              child:  Text(
                                "+/−",
                              ),
                            )
                        ),

                        Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Text(
                                "0",
                              ),
                            )
                        ),


                        Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Text(
                                ".", style: TextStyle(fontSize: 16)
                              ),
                            )
                        ),


                        Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Text("=",style: TextStyle(fontSize: 16),),
                            )
                        ),


                      ],
                    )
                  ],

                )

              
          
            ],
          ),
        ),

        drawer: Drawer(
          backgroundColor: const Color(0xFFF9F9F9),
          child: SafeArea(
              child: ListView(
               padding: EdgeInsets.zero,
                children: [
                  
                  // Nút menu
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      top: 4,
                      bottom: 4,
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.menu,
                        size: 20,
                      ),
                    ),
                  ),

                  Padding(padding:
                    const EdgeInsets.only(left: 8,top: 4,bottom: 4),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Calculator",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.calculate, size: 18),
                    title: const Text("Standard", style: TextStyle(fontSize: 13)),
                    selected: true,
                    selectedTileColor: const Color(0xFFE5E5E5),
                    onTap: (){

                    },

                  ),
                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.science_outlined, size: 18),
                    title: const Text("Scientific", style: TextStyle(fontSize: 13)),
                    onTap: (){},
                  ),

                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.show_chart, size: 18),
                    title: const Text("Graphing", style: TextStyle(fontSize: 13)),
                    onTap: () {},
                  ),

                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.code, size: 18),
                    title: const Text("Programmer", style: TextStyle(fontSize: 13)),
                    onTap: () {},
                  ),

                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.calendar_month, size: 18),
                    title: const Text("Date calculation", style: TextStyle(fontSize: 13)),
                    onTap: () {},
                  ),

                  // Converter
                  const Padding(
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 5),
                    child: Text(
                      "Converter",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.currency_exchange, size: 18),
                    title: const Text("Currency", style: TextStyle(fontSize: 13)),
                    onTap: () {},
                  ),

                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.view_in_ar_outlined, size: 18),
                    title: const Text("Volume", style: TextStyle(fontSize: 13)),
                    onTap: () {},
                  ),

                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.straighten, size: 18),
                    title: const Text("Length", style: TextStyle(fontSize: 13)),
                    onTap: () {},
                  ),

                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.scale, size: 18),
                    title: const Text("Weight and mass", style: TextStyle(fontSize: 13)),
                    onTap: () {},
                  ),

                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.thermostat, size: 18),
                    title: const Text("Temperature", style: TextStyle(fontSize: 13)),
                    onTap: () {},
                  ),

                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.bolt, size: 18),
                    title: const Text("Energy", style: TextStyle(fontSize: 13)),
                    onTap: () {},
                  ),

                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.grid_4x4, size: 18),
                    title: const Text("Area", style: TextStyle(fontSize: 13)),
                    onTap: () {},
                  ),

                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.speed, size: 18),
                    title: const Text("Speed", style: TextStyle(fontSize: 13)),
                    onTap: () {},
                  ),

                  const Divider(),

                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.settings, size: 18),
                    title: const Text("Settings", style: TextStyle(fontSize: 13)),
                    onTap: () {},
                  ),


                ],


            )
          ),
        ),
      ),

      
    );
  }
}