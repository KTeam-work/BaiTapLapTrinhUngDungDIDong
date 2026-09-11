import 'package:flutter/material.dart';


class SinhVien2 extends StatelessWidget{
  const SinhVien2({super.key});

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

              
              Center(
              
                child: const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage("assets/anhgv.png"),
                ),
              ),

              // Phần họ và tên
              const SizedBox(height: 10),
              Center(
                  child: const Padding(
                  padding: EdgeInsets.only(top: 10,left: 10),
                  child: Text(
                    "Giảng viên Trần Thị A",
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.purple),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 10,left: 10),
                child: Text(
                  "Khoa: Công nghệ Thông ti",
                  style: TextStyle(color: Colors.red,fontSize: 16,fontWeight:FontWeight.bold),
                ),
              ),


              const Padding(
                padding: EdgeInsets.only(top: 10,left: 10),
                child: Text(
                  "Học hàm: Thạc sỹ",
                  style: TextStyle(color: Colors.red,fontSize: 16,fontWeight:FontWeight.bold),
                ),
              ),


              const Padding(
                padding: EdgeInsets.only(top: 10,left: 10),
                child: Text(
                  "Chuyên ngành: CNPM",
                  style: TextStyle(color: Colors.greenAccent,fontSize: 16,fontWeight:FontWeight.bold),
                ),
              ),


              const Padding(
                padding: EdgeInsets.only(top: 10,left: 10),
                child: Text(
                  "Giảng dạy: Nhapajmoon lập trình,Lập trình windows,Lập trình w...",
                  style: TextStyle(color: Colors.lightBlue,fontSize: 16,fontWeight:FontWeight.bold),
                ),
              ),


              const Padding(
                padding: EdgeInsets.only(top: 10,left: 10),
                child: Text(
                  "Trường: Đại học Công Thương Thành phố Hồ Chí Minh",
                  style: TextStyle(color: Colors.red,fontSize: 16),
                ),
              ),


             

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