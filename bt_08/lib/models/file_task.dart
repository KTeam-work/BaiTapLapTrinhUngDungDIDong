import 'dart:io';
import 'package:path_provider/path_provider.dart';

class TaskItem {
  String title;
  String time;
  bool isCompleted;

  TaskItem({required this.title, required this.time, this.isCompleted = false});

  // Chuyển thành chuỗi để lưu file
  String toFileString() => "$title|$time|$isCompleted";

  // Đọc từ chuỗi file lên
  static TaskItem fromString(String str) {
    final parts = str.split("|");
    return TaskItem(
      title: parts[0],
      time: parts[1],
      isCompleted: parts[2].toLowerCase() == 'true',
    );
  }
}

class FileTask {
  Future<String> get _path async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get _file async {
    final path = await _path;
    return File('$path/tasks.txt');
  }

  Future<void> saveTasks(List<TaskItem> tasks) async {
    final file = await _file;
    String data = tasks.map((e) => e.toFileString()).join("\n");
    await file.writeAsString(data);
  }

  Future<List<TaskItem>> loadTasks() async {
    try {
      final file = await _file;
      if (!await file.exists()) return [];
      final content = await file.readAsString();
      return content
          .split("\n")
          .where((e) => e.isNotEmpty)
          .map<TaskItem>((e) => TaskItem.fromString(e))
          .toList();
    } catch (e) {
      return [];
    }
  }
}