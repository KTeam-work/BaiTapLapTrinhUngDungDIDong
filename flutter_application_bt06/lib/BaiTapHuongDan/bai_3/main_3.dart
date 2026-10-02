import 'package:flutter/material.dart';
import 'package:another_telephony/telephony.dart';
import 'package:permission_handler/permission_handler.dart';
import 'sms_reader_app.dart';
import 'contacts_reader_app.dart';


class _DanhBaDienThoai extends StatefulWidget{
  const _DanhBaDienThoai({super.key});

  @override
  State<StatefulWidget> createState() => _hienThi();

}

class _hienThi extends State<_DanhBaDienThoai>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main App')),
      body: Column(
        mainAxisAlignment:  MainAxisAlignment.start,
        children: [
          const Text("Welcome to the Main App!",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactsReaderApp()));
          }, child: const Text('Go to SMS Reader App',style: TextStyle(fontSize: 18),)),

          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SmsReaderApp()));
          }, child: const Text('Go to contacts Reader App',style: TextStyle(fontSize: 18),)),
        ],
      ),
    );
  }
}