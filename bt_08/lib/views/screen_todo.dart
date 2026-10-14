import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/todo.dart';
import '../services/file_services.dart';
import 'package:bt_08/services/notification_service.dart';

class ScreenTodo extends StatefulWidget {
  const ScreenTodo({super.key});

  @override
  State<ScreenTodo> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<ScreenTodo> {
  final TextEditingController _controller = TextEditingController();
  final FileService _fileServices = FileService();
  final NotificationService _notificationService = NotificationService();
  List<Todo> _todos = [];
  DateTime? _selectedTime;
  bool _isLoading = true;


  static final List<Color> _cardColors = [
    Colors.red.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.yellow.shade100,
    Colors.purple.shade100,
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {

    _controller.dispose();
    super.dispose();
  }


  Future<void> _loadData() async {
    final loadedTodos = await _fileServices.loadTodos();
    if (!mounted) return;

    setState(() {
      _todos = loadedTodos;
      _isLoading = false;
    });
  }


  Future<void> _addTodo() async {
    final title = _controller.text.trim();

    if (title.isEmpty || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Vui lòng nhập tên công việc và chọn thời gian!"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final newTodo = Todo(title: title, time: _selectedTime!);

    setState(() {
      _todos.add(newTodo);
      _controller.clear();
      _selectedTime = null;
    });

    _notificationService.scheduleNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 50,
      title: 'Đã đến giờ làm việc',
      body: 'Công việc "${newTodo.title}"',
      scheduledTime: newTodo.time,
    );

    await _fileServices.saveTodos(_todos);
  }


  Future<void> _pickDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null || !mounted) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null || !mounted) return;

    setState(() {
      _selectedTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
  }

  String _formatTime(DateTime time) {
    return DateFormat("dd/MM/yyyy HH:mm").format(time);
  }

  Color _getTextColor(Color background) {
    return background.computeLuminance() > 0.5 ? Colors.black87 : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Tên công việc",
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 12),


            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedTime == null
                        ? "Chưa chọn thời gian"
                        : _formatTime(_selectedTime!),
                    style: TextStyle(
                      color: _selectedTime == null ? Colors.grey : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _pickDateTime,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    side: const BorderSide(color: Colors.blue, width: 1.5),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Chọn thời gian"),
                ),
              ],
            ),
            const SizedBox(height: 12),


            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  _addTodo();
                  _notificationService.showSimpleNotification(
                    title: "Nhắc nhở công việc",
                    body: "Bạn đã thêm công việc mới: ${_controller.text.trim()}",
                  );



                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Lưu công việc",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),


            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _todos.isEmpty
                  ? const Center(
                child: Text(
                  "Chưa có công việc nào",
                  style: TextStyle(color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  final todo = _todos[index];
                  final Color bgColor = _cardColors[index % _cardColors.length];
                  final Color textColor = _getTextColor(bgColor);

                  return Card(
                    color: bgColor,
                    margin: const EdgeInsets.only(bottom: 8),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.task_alt, color: textColor),
                      title: Text(
                        todo.title ?? "Không có tiêu đề",
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        _formatTime(todo.time),
                        style: TextStyle(
                          color: textColor.withValues(alpha: 0.75),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
