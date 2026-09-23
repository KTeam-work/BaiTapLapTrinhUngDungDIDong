import 'package:flutter/material.dart';
import 'package:flutter_application_btbuoi5/cua_hang.dart';

class trangchinh extends StatelessWidget{
  const trangchinh({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //ảnh
            Align(
              child: CircleAvatar(
                backgroundImage: AssetImage("Images/logo.png",),
                radius: 70,
              ),
            ),

            const SizedBox(height: 10,),
            Padding(padding: EdgeInsets.all(4),
            child: Text("Cửa hàng điện thoại",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),),

            Padding(padding: EdgeInsets.all(4),
              child: Text("140 Lê trọng tấn, Tân Phú, TP.Hồ Chí Minh",style: TextStyle(fontSize: 15,color: Colors.grey),),),

            //nút bấm
            const SizedBox(height: 10,),
            ElevatedButton(style: ElevatedButton.styleFrom(minimumSize: Size(100, 40)),onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (builder)=>cuahang()));
            } , child:Icon(Icons.arrow_forward,size: 16,) )
          ],
        ),
      ),

    );
  }
}