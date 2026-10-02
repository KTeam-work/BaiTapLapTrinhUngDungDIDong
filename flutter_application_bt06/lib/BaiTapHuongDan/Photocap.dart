import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class PhotoCaptureHome extends StatefulWidget{
  const PhotoCaptureHome({super.key});
  @override
  State<StatefulWidget> createState() => _PhotoCaptuerHomeState();
 
}

class _PhotoCaptuerHomeState extends State<PhotoCaptureHome>{
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();


  Future<void> _requestPermission(Permission permisstion) async{
    if(await permisstion.isDenied){
      await permisstion.request();
    }
  }


  Future<void> _pickImageFromGallery() async{
    await _requestPermission(Permission.photos);
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if(pickedFile != null){
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    
  }


  Future<void> _captureImageFromCamera() async{
    await _requestPermission(Permission.camera);
    final XFile? capturedFile = await _picker.pickImage(source: ImageSource.camera);
    if(capturedFile != null){
      setState(() {
        _imageFile = File(capturedFile.path);
      });
    }
  }

  void _showFullScreenreview(BuildContext context) {
  if (_imageFile != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImage(
          imageFile: _imageFile!,
        ),
      ),
    );
  }
}
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Photo Capture & Preview'),
      ) ,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
              ? GestureDetector(
              onTap: () => _showFullScreenreview(context),
              child: Image.file(
                _imageFile!,
                height: 300,
              ),
            )
          : const Text('Chưa chọn ảnh'),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: _pickImageFromGallery, child: Text('Chọn ảnh từ Gallery')),

            ElevatedButton(onPressed: _captureImageFromCamera, child: Text('Chụp ảnh từ Camera')),
          ]
        ),
      ),
    );
  }
}


class FullScreenImage extends StatelessWidget{
  final File imageFile;
  FullScreenImage({required this.imageFile});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Xem trước'),),
      body: Center(
        child: Image.file(imageFile),
      ),
    );
  }
}