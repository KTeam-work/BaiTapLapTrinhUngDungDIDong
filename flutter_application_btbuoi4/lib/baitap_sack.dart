
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class  baitapstack extends StatelessWidget{
  const baitapstack({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stack demo"),
        backgroundColor: const Color.fromARGB(255, 239, 168, 4),
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.home)),
      ),

      body: Stack(
        alignment: Alignment.center,
        children: <Widget> [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(40),
              image: DecorationImage(image: AssetImage('images'),
                fit: BoxFit.cover
                
              ),
              
              
            ),
          ),

          Positioned(
            right: 20,
            left: 20,
            bottom: 20,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
              height:150,
              child: const Column(
                children: <Widget> [
                  SizedBox(height: 10,),
                  Text("Dong Phong Nha",style: TextStyle(fontSize: 24,color: Colors.red,fontWeight: FontWeight.bold),),
                  Padding(padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Dong Phong Nha, nam trong vuon quoc gia Phong Nha - Ke Bang, tinh Quang Binh, Viet Nam, La mot trong nhug hang dong noi tieng v hap dan nhat tren the gioi",
                      maxLines: 4,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                  ),
              
                ],
                
              ),
            )
          
          )
        ],
      ),
    );
  }
}