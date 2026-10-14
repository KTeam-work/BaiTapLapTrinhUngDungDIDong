import 'package:flutter/material.dart';
import '../models/file_task.dart';
import 'package:bt_08/views/screen_task.dart';
import 'package:bt_08/views/screenadd_task.dart';

class ScreenTask extends StatefulWidget {
  const ScreenTask({super.key});

  @override
  State<ScreenTask> createState() => _ScreenTaskState();
}

class _ScreenTaskState extends State<ScreenTask> {
  final FileTask _fileTask = FileTask();
  List<TaskItem> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await _fileTask.loadTasks();
    setState(() {
      _tasks = tasks;
      _isLoading = false;
    });
  }


  void _onTaskChecked(int index, bool? value) async {
    if (value == true) {

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Xác nhận'),
          content: const Text('Xác nhận nhiệm vụ này đã hoàn thành?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                setState(() {
                  _tasks[index].isCompleted = true;
                });
                await _fileTask.saveTasks(_tasks);


                int completedCount = _tasks.where((e) => e.isCompleted).length;


                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Đã hoàn thành! Tổng số nhiệm vụ hoàn thành: $completedCount'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Xác nhận'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhiệm vụ mỗi ngày'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _tasks.isEmpty
          ? const Center(
        child: Text(
          'Chưa có nhiệm vụ nào. Nhấn dấu + để thêm!',
          style: TextStyle(color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Checkbox(
                value: task.isCompleted,
                onChanged: (val) => _onTaskChecked(index, val),
              ),
              title: Text(
                task.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text(task.time),
              trailing: const Icon(Icons.notifications_outlined, color: Colors.black54),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade200,
        child: const Icon(Icons.add, color: Colors.black87),
        onPressed: () async {

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScreenAddTask()),
          );

          if (result == true) {
            _loadTasks();
          }
        },
      ),
    );
  }
}