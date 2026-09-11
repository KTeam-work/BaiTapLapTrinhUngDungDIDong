import 'package:flutter/material.dart';


class SinhVien1 extends StatelessWidget{
  const SinhVien1({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      title: 'Ứng dụng demo Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),

      home: Scaffold(
        appBar: AppBar(
          title: const Text("Thông tin sinh viên",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          backgroundColor: Colors.blue,
          leading: IconButton(onPressed: (){}, icon: Icon(Icons.home)),
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),

              // Ảnh
              Center(
                child: const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage("assets/Hieuthuhai.png"),
                ),
              ),

              // Phần họ và tên
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(top: 10,left: 10),
                child: Text(
                  "Họ và tên: Nguyễn Văn A",
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.purple),
                ),
              ),

              // Mã Sinh Viên
              const Padding(
                padding: EdgeInsets.only(top: 10,left: 10),
                child: Text(
                  "MSSV: 2001221234",
                  style: TextStyle(color: Colors.red,fontSize: 16,fontWeight:FontWeight.bold),
                ),
              ),

              // Lớp
              const Padding(
                padding: EdgeInsets.only(top: 10,left: 10),
                child: Text(
                  "Lớp 13DHTH02",
                  style: TextStyle(color: Colors.red,fontSize: 16,fontWeight:FontWeight.bold),
                ),
              ),

              // Phần Khóa
              const Padding(
                padding: EdgeInsets.only(top: 10,left: 10),
                child: Text(
                  "Khóa: 13 Đại học",
                  style: TextStyle(color: Colors.red,fontSize: 16,fontWeight:FontWeight.bold),
                ),
              ),

              // Ngành
              const Padding(
                padding: EdgeInsets.only(top: 10,left: 10),
                child: Text(
                  "Ngành: Công nghệ thông tin",
                  style: TextStyle(color: Colors.red,fontSize: 16,fontWeight:FontWeight.bold),
                ),
              ),

              // Trường đại học
              const Padding(
                padding: EdgeInsets.only(top: 10,left: 10),
                child: Text(
                  "Trường: Đại học Công Thương Thành phố Hồ Chí Minh",
                  style: TextStyle(color: Colors.red,fontSize: 16),
                ),
              ),


             
              // Nút trở về
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Center(
                  child: ElevatedButton(onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12)
                    ),
                    child: const Text("Trở về",style: TextStyle(fontSize: 16),),
                  
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