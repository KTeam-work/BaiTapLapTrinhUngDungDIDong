import 'package:flutter/material.dart';
import '../models/file_task.dart';

class ScreenAddTask extends StatefulWidget {
  const ScreenAddTask({super.key});

  @override
  State<ScreenAddTask> createState() => _ScreenAddTaskState();
}

class _ScreenAddTaskState extends State<ScreenAddTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final FileTask _fileTask = FileTask();

  Future<void> _saveTask() async {
    final title = _titleController.text.trim();
    final time = _timeController.text.trim();

    if (title.isEmpty || time.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin!')),
      );
      return;
    }


    List<TaskItem> tasks = await _fileTask.loadTasks();
    tasks.add(TaskItem(title: title, time: time));
    await _fileTask.saveTasks(tasks);


    if (!mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm nhiệm vụ mới'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Tên nhiệm vụ',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(
                labelText: 'Giờ nhắc (Ví dụ: Nhắc lúc 20:00)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                foregroundColor: Colors.black87,
                minimumSize: const Size(150, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: _saveTask,
              child: const Text('Lưu nhiệm vụ'),
            ),
          ],
        ),
      ),
    );
  }
}