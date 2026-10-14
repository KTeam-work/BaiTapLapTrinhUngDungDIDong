import 'package:flutter/material.dart';
import 'package:bt_08/services/notification_service.dart';


class ScreenNotiEx extends StatelessWidget {
  const ScreenNotiEx({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationService notificationservice = NotificationService();
    notificationservice.init();

    return Scaffold(
      appBar: AppBar(title: Text("Screen Noti Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Nút lệnh lên lịch notification
            ElevatedButton(
              onPressed: () {
                notificationservice.showSimpleNotification();
              },
              child: Text("Gửi thông báo nhắc học Ngoại ngữ"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                notificationservice.scheduleNotificationAfter(
                  Duration(minutes: 2),
                  'drink_water_channel',
                  'Uống nước',
                  'Nhắc uống nước đúng giờ',
                );
              },
              child: Text("Gửi thông báo nhắc uống nước sau 2 phút"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                notificationservice.scheduleNotificationAfter(
                    Duration(minutes: 10),
                    'learn_english_channel',
                    'Nhắc học ngoại ngữ',
                    'Đã đến giờ học từ vựng tiếng Anh sau 10 phút!'
                );
              },
              child: Text("Hẹn giờ gửi thông báo học Ngoại ngữ sau 10 phút"),
            ),
          ],
        ),
      ),
    );
  }
}