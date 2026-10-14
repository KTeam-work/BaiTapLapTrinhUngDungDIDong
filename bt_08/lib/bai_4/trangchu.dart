import 'package:bt_08/models/vocabulary.dart';
import 'package:flutter/material.dart';
import 'package:bt_08/services/notification_service.dart';
import 'package:bt_08/bai_4/hoctu.dart';
import 'package:bt_08/bai_4/kiemtratu.dart';
import '../services/file_services.dart';
import 'package:bt_08/bai_4/lichnhat.dart';
class TrangChu extends StatefulWidget{
  const TrangChu({super.key});

  @override
  State<StatefulWidget> createState() => HienThiTrangChu();


}


class HienThiTrangChu extends State<TrangChu>{
  final TextEditingController wordController = TextEditingController();
  final TextEditingController meaningController = TextEditingController();
  final FileService _fileService = FileService();
  final NotificationService noti = NotificationService();
  @override
  void initState() {
    super.initState();
    noti.init();
  }

  Future<void> luu() async{
    String word = wordController.text.trim();
    String mean = meaningController.text.trim();

    if(word.isEmpty || mean.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vui lòng nhập đầy đủ Từ và Nghĩa!')));
    }

    List<Vocabulary> curent = await _fileService.loadTodos1(); // load toàn bộ file Vocabulary
    
    curent.add(Vocabulary(word: word, mean: mean));

    await _fileService.saveTodos1(curent);


    await noti.scheduleNotificationAfter(
      const Duration(minutes: 10),
      'vocab_reminder_channel',
      'Đã lưu và lên lịch nhắc học từ sau 10 phút',
      'Hãy ôn lại từ: "$word" ($mean)',
    );

    if(mounted){ // kiểm tra widget có đang hiển thị không
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã lưu và lên lịch nhắc học từ sau 10 phút'),duration: Duration(seconds: 3),));

    }
    wordController.clear();
    meaningController.clear();

 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent
              ),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   CircleAvatar(
                     backgroundImage:AssetImage(""),
                     radius: 50,
                   ),

                   SizedBox(height: 10,),
                   Text("Trợ lý học từ vựng",style: TextStyle(color: Colors.white,fontSize: 16),)
                ],
              ) ,
            ),
            ListTile(
              leading: Icon(Icons.home),
               title: Text("Trang chủ"),
              onTap: (){

              },
            ),

            ListTile(
              leading: Icon(Icons.task),
              title: Text("Học từ"),
              onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HocTu()));
              },
            ),

            ListTile(
              leading: Icon(Icons.task),
              title: Text("Kiểm tra từ"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Kiemtratu()));
              },
            ),

            ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Lịch nhắc"),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LichNhac()),
                );
              },
            )
          ],
        ),
      ) ,
      appBar: AppBar(
        title: Text("Ứng dụng học từ vựng"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: wordController,
                    decoration: InputDecoration(
                      labelText: 'Từ'
                    ),
                  ),

                  SizedBox(height: 16),

                  TextField(
                    controller: meaningController,
                    decoration: InputDecoration(
                        labelText: 'Nghĩa'
                    ),
                  ),
                ],
              ),
            ),


            Align(
              child: ElevatedButton(onPressed: (){
                luu();
              }, child: Text("Lưu và nhắc học sau 10 phút",style: TextStyle(fontSize: 18),)),
            )
          ],
        ),
      ),
    );
  }
}