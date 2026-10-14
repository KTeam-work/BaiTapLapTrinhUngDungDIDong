import 'dart:io';
import 'package:bt_08/models/vocabulary.dart';
import 'package:path_provider/path_provider.dart';
import '../models/todo.dart';

class FileService {
  Future<String> get _path async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get _file async {
    final path = await _path;
    return File('$path/todo.txt');
  }

  // vocab
  Future<File> get _file1 async {
    final path = await _path;
    return File('$path/vocab.txt');
  }

  Future<void> saveTodos(List<Todo> todos) async {
    final file = await _file;
    String data = todos.map((e) => e.toFileString()).join("\n");
    await file.writeAsString(data);
  }

  // vocab
  Future<void> saveTodos1(List<Vocabulary> todos) async {
    final file = await _file1;
    String data = todos.map((e) => e.ToFile()).join("\n");
    await file.writeAsString(data);
  }


  // Đọc dữ liệu từ file và trả về danh sách Todo
  Future<List<Todo>> loadTodos() async {
    try {
      final file = await _file;
      final content = await file.readAsString();

      return content
          .split("\n")
          .where((e) => e.isNotEmpty)
          .map((e) => Todo.fromString(e))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // vocab
  Future<List<Vocabulary>> loadTodos1() async {
    try {
      final file = await _file1;
      final content = await file.readAsString();

      return content
          .split("\n")
          .where((e) => e.isNotEmpty)
          .map((e) => Vocabulary.fromString(e))
          .toList();
    } catch (e) {
      return [];
    }
  }
}