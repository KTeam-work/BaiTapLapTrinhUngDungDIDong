import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // 1. Init timezone
    tz.initializeTimeZones();
    // FIX cứng timezone VN
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));

    // 2. Android settings
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);

    // 3. Init plugin (Sửa lại dùng named parameter 'settings')
    await _plugin.initialize(settings: settings);

    // 4. Xin quyền notification
    await _requestPermission();
  }

  // ================= REQUEST PERMISSION =================
  Future<void> _requestPermission() async {
    // Xin quyền thông báo trên Android (Android 13+)
    final androidImplementation =
    _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await androidImplementation?.requestNotificationsPermission();
  }

  // - Xây dựng phương thức tạo notification có thể tái sử dụng nhiều lần
  static AndroidNotificationDetails _createAndroidDetails({
    required String channelId,
    required String channelName,
    String? channelDescription,
  }) {
    return AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      visibility: NotificationVisibility.public,
      playSound: true,
      enableVibration: true,
      showWhen: true,
    );
  }

  // - Xây dựng phương thức hẹn lịch hiển thị thông báo
  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    required AndroidNotificationDetails androidDetails,
  }) async {
    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(scheduledTime, tz.local),
      notificationDetails: NotificationDetails(android: androidDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }


  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    final details = _createAndroidDetails(channelId: 'todo_schedule_channel', channelName: 'Nhắc nhở công việc');
    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(scheduledTime, tz.local),
      notificationDetails: NotificationDetails(android: details),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,


    );
  }


  // - Hàm hiển thị thông báo ngay tức thì
  Future<void> showSimpleNotification({
    int id = 0,
    String title = 'Nhắc học từ vựng',
    String body = 'Bạn đã học 5 từ mới hôm nay chưa?',
  }) async {
    final details = _createAndroidDetails(
      channelId: 'learn_english_channel',
      channelName: 'Học Anh Văn',
    );

    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: NotificationDetails(android: details),
    );
  }

  // - Hàm lên lịch thông báo sau một khoảng thời gian (Delay)
  Future<void> scheduleNotificationAfter(
      Duration delay,
      String channelId,
      String channelName,
      String channelDescription,
      ) async {
    final details = _createAndroidDetails(
      channelId: channelId,
      channelName: channelName,
      channelDescription: channelDescription,
    );

    final scheduledTime = tz.TZDateTime.now(tz.local).add(delay);

    await _scheduleNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: channelName,
      body: channelDescription,
      scheduledTime: scheduledTime,
      androidDetails: details,
    );
  }



  Future<void> scheduleNotificationAfter1(
      String id,
      Duration delay,
      String channelId,
      String channelName,
      String channelDescription,
      ) async {
    final details = _createAndroidDetails(
      channelId: channelId,
      channelName: channelName,
      channelDescription: channelDescription,
    );

    final scheduledTime = tz.TZDateTime.now(tz.local).add(delay);

    await _scheduleNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: channelName,
      body: channelDescription,
      scheduledTime: scheduledTime,
      androidDetails: details,
    );
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _plugin.pendingNotificationRequests(); // Đổi tên biến cho khớp với file của bạn
  }

// Hủy thông báo theo ID
  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id: id);
  }

}