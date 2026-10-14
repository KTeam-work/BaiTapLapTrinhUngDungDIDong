import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:bt_08/services/notification_service.dart'; // Nhớ import service vào

class LichNhac extends StatefulWidget {
  const LichNhac({super.key});

  @override
  State<LichNhac> createState() => _LichNhacState();
}

class _LichNhacState extends State<LichNhac> {
  // Gọi service đã được khởi tạo sẵn
  final NotificationService noti = NotificationService();
  List<PendingNotificationRequest> pendingNotifications = [];

  @override
  void initState() {
    super.initState();
    _loadPendingNotifications();
  }

  // Tải danh sách thông báo đang chờ
  Future<void> _loadPendingNotifications() async {
    final List<PendingNotificationRequest> requests = await noti.getPendingNotifications();
    setState(() {
      pendingNotifications = requests;
    });
  }

  // Hàm hủy lịch nhắc gọi qua service
  Future<void> _cancelNotification(int id) async {
    await noti.cancelNotification(id);
    await _loadPendingNotifications(); // Thêm await để hết lỗi cảnh báo Future

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã xóa lịch nhắc!')),
      );
    }
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
          'Lịch nhắc',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: pendingNotifications.isEmpty
          ? const Center(
        child: Text(
          'Không có lịch nhắc nào đang chờ!',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: pendingNotifications.length,
        itemBuilder: (context, index) {
          final notification = pendingNotifications[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      color: Colors.black54,
                      size: 28,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.title ?? 'Ôn từ vựng mới!',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notification.body ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 24,
                  ),
                  onPressed: () {
                    _cancelNotification(notification.id);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}