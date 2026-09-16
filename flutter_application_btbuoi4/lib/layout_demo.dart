import 'package:flutter/material.dart';

class demo extends StatelessWidget{
  const demo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bai Tap Mau",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 175,
                            height: 175,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red
                            ),
                          ),

                          const SizedBox(width: 20,),

                          Container(
                            width: 175,
                            height: 175,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red
                            ),
                          ),

                          
                        ],
                      ),

                      const SizedBox(height: 10,),
                      Container(
                        width: 380,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue
                        ),
                      ),


                      const SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:<Widget> [
                          Container(
                            width: 175,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.cyan
                            ),
                          ),

                          Container(
                            width: 175,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.cyan
 
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}