import 'package:flutter/material.dart';

class DeTai extends StatelessWidget {
  const DeTai({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ứng dụng demo Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),

      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "CHI TIẾT ĐỀ TÀI ĐỒ ÁN",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.blue,

          // nút quay lại
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // row:hiển thị mã đề tài và số lượng tối đa
              const Row(
                children: [
                  const SizedBox(width: 30,),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Mã:DT2026_CNTT_01",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 60),
                     child: Text(
                      "Tối đa:2",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )


                ],
              ),

              //đường gạch ngang
              const Divider(height: 30,thickness: 1,), // đường gạch ngang

              //hiển thị tên đề tài
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.all(8),
                    decoration: const BoxDecoration(
                      color: Color((0xFFEDE7F6)),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.article,size: 20,),
                  ),

                  const SizedBox(width: 30,),
                  Expanded(child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ten đề tài",style: TextStyle(fontSize: 12,color: Colors.grey,fontWeight: FontWeight.bold)),
                      const SizedBox(width: 30,),
                      Text("Xây dựng ứng dụng quản lý đồ án tốt nghiệp",
                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
                    ],
                  )
                  )
                ],
              ),

              const Divider(height: 30,thickness: 1),

              //hiển thị chuyên ngành
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Container(
                     padding: EdgeInsetsDirectional.all(8),
                     decoration: BoxDecoration(
                       color: Color(0xFFE3F2FD),
                       shape: BoxShape.circle
                     ),
                     child: Icon(Icons.school,size: 20,),
                   ),
                  const SizedBox(width: 30,),
                  Expanded(child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Chuyên ngành", style: TextStyle(fontSize: 12, color: Colors.grey)),
                        const SizedBox(width: 30,),
                        Text("Công nghệ thông tin", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    )
                  ),
                ],
              ),

              const Divider(height: 30, thickness: 1),

              //hiển thị giảng viên hướng dẫn
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Container(
                     padding: EdgeInsetsDirectional.all(8),
                     decoration: BoxDecoration(
                       color: Color(0xFFFFEBEE),
                       shape: BoxShape.circle,
                     ),
                     child: Icon(Icons.person,size: 20,),
                   ),
                  const SizedBox(width: 30,),
                  Expanded(child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Giảng viên hướng dẫn", style: TextStyle(fontSize: 12, color: Colors.grey)),
                      SizedBox(height: 2),
                      Text("Ts. Nguyễn Văn A", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  )
                  ),

                ],
              ),


              const Divider(height: 30,thickness: 1,),

              //hiển thị yêu cầu đề tài
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFF8E1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.assignment,size: 20,),
                  ),
                  const SizedBox(width: 30),
                  Expanded(child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Yêu cầu đề tài", style: TextStyle(fontSize: 12, color: Colors.grey)),
                      SizedBox(height: 2),
                      Text("Xây dựng ứng dụng quản lý đồ án tốt nghiệp cho sinh viên, hỗ trợ đăng ký đề tài, theo dõi tiến độ, nộp báo cáo và quản lý thông tin khoa.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  )
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
