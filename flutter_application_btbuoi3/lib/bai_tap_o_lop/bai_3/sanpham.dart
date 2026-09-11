import 'package:flutter/material.dart';

class sanpham extends StatelessWidget{
  const sanpham({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
       title: 'Ứng dụng demo Flutter',
       debugShowCheckedModeBanner: false,
       theme: ThemeData(primarySwatch: Colors.blue),

       home: Scaffold(
         appBar: AppBar(
           title: Text("Thông tin sản phẩm",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
           backgroundColor: Colors.blue,
           leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back)),

         ),

         body: Center(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.start,
             children: [

               //hiển thị ảnh latop và các ảnh phụ của latop
               Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Container(
                     padding: EdgeInsetsDirectional.all(4),
                     decoration: BoxDecoration(
                       color: Colors.white,

                     ),
                     child: Image.asset("assets/anhlaptop.png",height: 300,width:250,fit:BoxFit.contain,),
                   ),

                   const SizedBox(width: 10,),

                   //sắp xếp các laptop phụ theo chiều dọc
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       //laptop 1
                       Container(
                         width: 100,
                         height: 100,
                         decoration: BoxDecoration(
                             color: Colors.grey

                         ),
                         child: Image.asset("assets/anhlaptop.png",width: 100,height: 100,),

                       ),
                       //laptop 2
                       Container(
                         width: 100,
                         height: 100,
                         decoration: BoxDecoration(
                             color: Colors.grey

                         ),
                         child: Image.asset("assets/anhlaptop2.png",width: 100,height: 100,),

                       ),

                       //laptop 3
                       Container(
                         width: 100,
                         height: 100,
                         decoration: BoxDecoration(
                             color: Colors.grey

                         ),
                         child: Image.asset("assets/anhlaptop3.png",width: 100,height: 100,),

                       )


                     ],
                   )

                 ],

               ),

               //tên sản phẩm
               const SizedBox(height: 30,),
               Padding(
                   padding: EdgeInsetsGeometry.only(left: 10),
                   child: Text("Laptop ASUS TUF Gaming A15",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
               ),

               //thông tin chi tiết sản phẩm
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Container(
                         padding: EdgeInsets.all(15),
                         decoration: BoxDecoration(
                             color: Colors.grey,
                             shape: BoxShape.circle

                         ),
                         child: Icon(Icons.qr_code,size:15),

                       ),
                       const SizedBox(width: 20,),
                       Padding(padding: EdgeInsets.only(top: 5),
                         child: Text("Mã Sản Phẩm",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),


                       ),

                       Padding(padding: EdgeInsets.only(top: 5,left: 50),
                         child: Text("SP001",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),


                       ),

                     ],
                   ),

                   const SizedBox(height: 20,),

                   //tên sản phẩm
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Container(
                         padding: EdgeInsets.all(15),
                         decoration: BoxDecoration(
                             color: Colors.grey,
                             shape: BoxShape.circle

                         ),
                         child: Icon(Icons.laptop_chromebook,size:15),

                       ),
                       const SizedBox(width: 20,),
                       Padding(padding: EdgeInsets.only(top: 5),
                         child: Text("Tên sản phẩm",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),


                       ),

                       Padding(padding: EdgeInsets.only(top: 5,left: 50),
                         child: Text("Laptop ASUS TUF",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),


                       ),

                     ],
                   ),

                   const SizedBox(height: 20,),

                   //nhà sản xuất
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Container(
                         padding: EdgeInsets.all(15),
                         decoration: BoxDecoration(
                             color: Colors.grey,
                             shape: BoxShape.circle

                         ),
                         child: Icon(Icons.precision_manufacturing,size: 15,),

                       ),
                       const SizedBox(width: 20,),
                       Padding(padding: EdgeInsets.only(top: 5),
                         child: Text("Nhà sản xuất",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),


                       ),

                       Padding(padding: EdgeInsets.only(top: 5,left: 60),
                         child: Text("ASUS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),


                       ),

                     ],
                   ),

                   const SizedBox(height: 20,),

                   //giá bán
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Container(
                         padding: EdgeInsets.all(15),
                         decoration: BoxDecoration(
                             color: Colors.grey,
                             shape: BoxShape.circle

                         ),
                         child: Icon(Icons.sell,size:15),

                       ),
                       const SizedBox(width: 20,),
                       Padding(padding: EdgeInsets.only(top: 5),
                         child: Text("Giá bán",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),


                       ),

                       Padding(padding: EdgeInsets.only(top: 5,left: 105),
                         child: Text("18.990.000đ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),


                       ),






                     ],
                   )
                 ],
               ),

               const SizedBox(height: 30,),

               //phần mô tả
               Container(
                 padding: const EdgeInsets.all(12),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [


                     Row(
                       children: [

                         Container(
                           padding: const EdgeInsets.all(8),
                           decoration: const BoxDecoration(
                             color: Color(0xFFE3F2FD),
                             shape: BoxShape.circle,
                           ),
                           child: const Icon(
                             Icons.article_outlined,
                             color: Colors.blue,
                             size: 20,
                           ),
                         ),

                         const SizedBox(width: 10),


                         const Text(
                           "Mô tả sản phẩm",
                           style: TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.bold,
                             color: Colors.black87,
                           ),
                         ),
                       ],
                     ),

                     const SizedBox(height: 10),


                     const Text(
                       "ASUS TUF Gaming A15 là chiếc laptop gaming mạnh mẽ, bền bỉ, được thiết kế dành cho game thủ và người dùng sáng tạo...",
                       style: TextStyle(
                         fontSize: 14,
                         color: Colors.black54,
                         height: 1.4,
                       ),
                     ),
                   ],
                 ),
               )


             ],
           )

         )




       ),

     );
  }
}

