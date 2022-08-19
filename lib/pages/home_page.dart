import 'package:flutter/material.dart';

import '../services/notification_channel_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<bool> futureInitializeNotificationsChannel;
  late NotificationChannelService _service;
  @override
  void initState() {
    super.initState();
    _service = new NotificationChannelService();
    futureInitializeNotificationsChannel =
        _service.initializeNotificationsChannel();
  }

  Future<void> showNotification() {
    return _service.flutterLocalNotificationsPlugin.show(
      0,
      'Celular em risco',
      'Não carregá-lo pode danificar a bateria',
      _service.platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Push notifications"),
        ),
      ),
      body: Center(
        child: FutureBuilder(
          initialData: false,
          future: futureInitializeNotificationsChannel,
          builder: (context, snapshot) {
            final isNotificationsChannelInitialized = snapshot.data;
            if (isNotificationsChannelInitialized == false) {
              if (_service.notificationsChannelInitializationError.isNotEmpty) {
                return Text(_service.notificationsChannelInitializationError);
              }
              return const CircularProgressIndicator();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    showNotification();
                  },
                  child: const Text('Lançar notificação'),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
