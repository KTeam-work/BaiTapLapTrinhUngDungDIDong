import 'package:flutter/material.dart';

class Nhom extends StatelessWidget{
  const Nhom({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ứng dụng demo Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Thông Tin Nhóm",
            style: TextStyle(
              // Đã sửa 299 -> 255
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold

            ),
          ),
          backgroundColor: Colors.blue[900],
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
          ),
        ),

        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               Container(
                 padding: EdgeInsets.all(14),
                 decoration: BoxDecoration(
                   color: const Color(0xFFEDF5FF),
                   borderRadius: BorderRadius.circular(12)
                 ),

                 //sắp xếp icon và thông tin nhóm theo chiều ngang
                 child: Row(
                   children: [
                     CircleAvatar(
                       radius: 45,
                       backgroundColor: Colors.blue.shade100,
                       child: Icon(Icons.group,size: 40,),
                     ),

                     const SizedBox(width: 10,),
                     Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                       children: [

                         //hiển thị mã nhóm
                         Row(
                           children: [
                             Text("Mã nhóm: ", style: TextStyle(color: Colors.grey, fontSize: 14)),
                             Text("Nhom_01", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                           ],
                         ),

                         //hiển thị tên nhóm
                         SizedBox(height: 6),
                         Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text("Tên nhóm: ", style: TextStyle(color: Colors.grey, fontSize: 14)),
                             Expanded(
                               child: Text("Nhóm phát triển ứng dụng", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                             ),
                           ],
                         ),

                         //hiển thị số lượng thành viên
                         SizedBox(height: 6),
                         Row(
                           children: [
                             Text("Số lượng thành viên: ", style: TextStyle(color: Colors.grey, fontSize: 14)),
                             Text("3", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                           ],
                         ),
                       ],
                     ))
                   ],
                 ),
               ),
              
              const SizedBox(height: 20,),
              const Text(
                "Danh Sách Thành Viên",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20,),

              Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14)
                  ),

                 child: Row(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.lightBlue.shade200,
                        child: Icon(Icons.person_3,size: 30,),

                      ),

                      const SizedBox(width: 20,),

                      Expanded(child: Column(
                        //tên sinh viên 1
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text("Mã sinh viên",style: TextStyle(fontSize: 14),),
                                SizedBox(width: 15,),
                                Text("SV001",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                SizedBox(width: 15,),
                                Container(
                                  padding:EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadiusDirectional.circular(20),

                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Nhóm trưởng")
                                    ],
                                  ),
                                )

                            ],
                          ),

                          const SizedBox(height: 10,),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Tên sinh viên",style: TextStyle(fontSize: 14),),
                              SizedBox(width: 15,),
                              Text("Nguyễn văn an",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),

                            ],
                          ),


                        ],
                      ))


                    ],
                 ),
              ),

              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14)
                ),

                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.lightBlue.shade200,
                      child: Icon(Icons.person_2,size: 30,),

                    ),

                    const SizedBox(width: 20,),

                    Expanded(child: Column(
                      children: [
                        //tên sinh viên 2
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mã sinh viên",style: TextStyle(fontSize: 14),),
                            SizedBox(width: 15,),
                            Text("SV002",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                            SizedBox(width: 15,),
                            Container(
                              padding:EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadiusDirectional.circular(20),

                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Thành viên",style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            )

                          ],
                        ),

                        const SizedBox(height: 10,),


                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tên sinh viên",style: TextStyle(fontSize: 14),),
                            SizedBox(width: 15,),
                            Text("Lê minh cường",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),

                          ],
                        ),

                      ],
                    ))


                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14)
                ),

                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.lightBlue.shade200,
                      child: Icon(Icons.person_3,size: 30,),

                    ),

                    const SizedBox(width: 20,),

                    //sinh viên 3
                    Expanded(child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mã sinh viên",style: TextStyle(fontSize: 14),),
                            SizedBox(width: 15,),
                            Text("SV003",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                            SizedBox(width: 15,),
                            Container(
                              padding:EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadiusDirectional.circular(20),

                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Thành viên",style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            )

                          ],
                        ),

                        const SizedBox(height: 10,),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tên sinh viên",style: TextStyle(fontSize: 14),),
                            SizedBox(width: 15,),
                            Text("Trần thị bích",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),

                          ],
                        ),







                      ],
                    ))


                  ],
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}

