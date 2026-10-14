import 'dart:math';
import 'package:bt_08/models/vocabulary.dart';
import 'package:flutter/material.dart';
import '../services/file_services.dart';

class Kiemtratu extends StatefulWidget {
  const Kiemtratu({super.key});

  @override
  State<StatefulWidget> createState() => HienThiKiemTraTu();
}

class HienThiKiemTraTu extends State<Kiemtratu> {
  int correctCount = 0;
  int incorrectCount = 0;
  int currentList = 0;
  final FileService _fileService = FileService();
  List<Vocabulary> curr = [];

  // Các biến phục vụ logic câu hỏi Đúng/Sai
  String displayedWord = "";
  String displayedMeaning = "";
  bool isActuallyCorrect = false;

  @override
  void initState() {
    super.initState();
    _loadFile();
  }

  Future<void> _loadFile() async {
    List<Vocabulary> path = await _fileService.loadTodos1();
    setState(() {
      curr = path;
      if (curr.isNotEmpty) {
        _generateQuestion();
      }
    });
  }

  // Hàm tạo câu hỏi ngẫu nhiên (50% ghép nghĩa đúng, 50% lấy nghĩa từ ngẫu nhiên khác)
  void _generateQuestion() {
    if (curr.isEmpty) return;

    displayedWord = curr[currentList].word;
    String realMeaning = curr[currentList].mean;

    // Ngẫu nhiên 50% đúng / 50% sai
    bool showCorrect = Random().nextBool();

    if (showCorrect || curr.length < 2) {
      displayedMeaning = realMeaning;
      isActuallyCorrect = true;
    } else {
      // Lấy nghĩa của một từ ngẫu nhiên khác trong danh sách làm bẫy
      int randomWrongIndex;
      do {
        randomWrongIndex = Random().nextInt(curr.length);
      } while (randomWrongIndex == currentList);

      displayedMeaning = curr[randomWrongIndex].mean;
      isActuallyCorrect = false;
    }
  }

  // Hàm xử lý chung khi chọn Đúng hoặc Sai
  void _handleAnswer(bool userChoice) {
    if (curr.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chưa có từ vựng nào được lưu!')),
      );
      return;
    }

    setState(() {
      if (userChoice == isActuallyCorrect) {
        correctCount++;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Chính xác! 🎉'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        incorrectCount++;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sai rồi! Nghĩa đúng của "$displayedWord" là "${curr[currentList].mean}"'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }

      // Chuyển sang từ tiếp theo
      if (currentList < curr.length - 1) {
        currentList++;
      } else {
        currentList = 0; // Quay lại từ đầu danh sách
      }

      _generateQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Trắc nghiệm Đúng / Sai',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Thanh điểm (Correct and Incorrect score buttons)
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Nút điểm 'Đúng' (Xanh lá)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green.shade100,
                        ),
                        child: const Icon(Icons.check, color: Colors.green, size: 20),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Đúng:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            '$correctCount', // Điểm 'Đúng' động
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Nút điểm 'Sai' (Cam)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade700,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red.shade100,
                        ),
                        child: const Icon(Icons.close, color: Colors.red, size: 20),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sai:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            '$incorrectCount', // Điểm 'Sai' động
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Khu vực trung tâm (Question and Answer)
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Từ tiếng Anh (Câu hỏi)
                  Text(
                    curr.isNotEmpty ? displayedWord : 'Chưa có từ',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Từ tiếng Việt (Câu trả lời)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      curr.isNotEmpty ? displayedMeaning : 'Chưa có dữ liệu',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Thanh nút hành động (Correct and Incorrect buttons)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Nút "Đúng" màu xanh lá
                ElevatedButton.icon(
                  onPressed: () => _handleAnswer(true),
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: const Text(
                    'Đúng',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                // Nút "Sai" màu đỏ
                ElevatedButton.icon(
                  onPressed: () => _handleAnswer(false),
                  icon: const Icon(Icons.close, color: Colors.white),
                  label: const Text(
                    'Sai',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}