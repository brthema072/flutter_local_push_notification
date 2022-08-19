import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationChannelService {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late NotificationDetails platformChannelSpecifics;

  Future<bool> initializeNotificationsChannel() async {
    try {
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      const androidInitializationSettings =
          AndroidInitializationSettings('app_icon');
      const initializationSettings =
          InitializationSettings(android: androidInitializationSettings);

      await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '3228c0e595837fb18f48472a6eed17fd',
        'BATTERY_NOTIFICATION',
        importance: Importance.max,
        priority: Priority.high,
      );
      platformChannelSpecifics =
          const NotificationDetails(android: androidPlatformChannelSpecifics);
      return true;
    } catch (error) {
      onErrorWhenInitializingNotificationsChannel();
      return false;
    }
  }

  var notificationsChannelInitializationError = '';

  void onErrorWhenInitializingNotificationsChannel() {
    notificationsChannelInitializationError =
        'Não foi possível inicializar o canal de notificações';
  }
}
