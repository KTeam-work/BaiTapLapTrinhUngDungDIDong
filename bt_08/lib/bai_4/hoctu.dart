import 'package:bt_08/models/vocabulary.dart';
import 'package:flutter/material.dart';
import '../services/file_services.dart';
class HocTu extends StatefulWidget{
  const HocTu({super.key});

  @override
  State<HocTu> createState() =>HienThiHocTu();

}



class HienThiHocTu extends State<HocTu>{
  final TextEditingController meaning = TextEditingController();
  final FileService _fileService = FileService();
  List<Vocabulary> vocabList = [];
  int currentIndex = 0;
  int correctCount = 0;
  int incorrectCount = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadVocabularies();
  }

  Future<void> _loadVocabularies() async {
    List<Vocabulary> loadedList = await _fileService.loadTodos1();
    setState(() {
      vocabList = loadedList;
    });
  }

  void _checkAnswer() {
    if (vocabList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chưa có từ vựng nào được lưu!')),
      );
      return;
    }

    String userAns = meaning.text.trim().toLowerCase();
    String correctAns = vocabList[currentIndex].mean.trim().toLowerCase();

    setState(() {
      if (userAns == correctAns) {
        // Trả lời đúng
        correctCount++;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Chính xác!'),backgroundColor: Colors.green,),
        );
      } else {
        // Trả lời sai
        incorrectCount++;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sai rồi! Nghĩa đúng là: "${vocabList[currentIndex].mean}"'),backgroundColor: Colors.red,),
        );

        // Kiểm tra nếu số từ sai là bội số của 3 thì hiện thông báo (như yêu cầu đề bài)
        if (incorrectCount > 0 && incorrectCount % 3 == 0) {
          // Bạn có thể gọi Notification Service ở đây nếu muốn
        }
      }

      if (currentIndex < vocabList.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }

      // Xóa ô nhập liệu sau khi check
       meaning.clear();
    });
  }

  @override
  void dispose() {
    meaning.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    String displayWord = "Hết từ";
    if (vocabList.isNotEmpty && currentIndex < vocabList.length) {
      displayWord = vocabList[currentIndex].word;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Ôn tập từ mới"),


      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                 Container(
                   padding: EdgeInsets.only(left: 10),
                   width: 100,
                   height: 50,
                   decoration: BoxDecoration(
                     color: Colors.green,
                       borderRadius:  BorderRadius.circular(4)
                   ),
                   child:Row(
                     children: [
                       Icon(Icons.check,color: Colors.lightGreen,fontWeight: FontWeight.bold,),
                       Padding(padding: EdgeInsets.only(left: 10),child:
                       Text("$correctCount từ"), )

                     ],
                   ),
                 ),

                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius:  BorderRadius.circular(4)
                  ),
                  child:Row(
                    children: [
                      Icon(Icons.close,color: Colors.red,fontWeight: FontWeight.bold,),
                      Padding(padding: EdgeInsets.only(left: 10),child:
                      Text("$incorrectCount từ"),)
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: 15,),

            Container(
              width: 400,
              margin: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(displayWord,style: TextStyle(fontSize:16,fontWeight: FontWeight.bold),),

                  const SizedBox(height: 20,),
                  SizedBox(
                    width: 280,
                    height: 50,
                    child:  TextField(
                      controller: meaning,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Nhập nghĩa tiếng việt",
                          hintStyle: TextStyle(fontSize: 12),
                          border:OutlineInputBorder(
                            borderRadius:BorderRadius.circular(15),

                          )
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(onPressed: (){
                    _checkAnswer();
                  },style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                     shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                     ),
                    padding: const EdgeInsets.symmetric(horizontal: 36,vertical: 10)
                    ),
                      child: Text("Check")

                  ),





                ],
              ),
            )
          ],
        ),
      ),
    );
    
  }
}