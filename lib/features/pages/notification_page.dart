import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx/data_source/local/notification_service.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                NotificationService().showNotification();
              },
              child: const Text('Show notification'),
            ),
            ElevatedButton(
              onPressed: () {
                NotificationService().zonedSchedule();
              },
              child: const Text('Show schedule notification'),
            ),
          ],
        )),
      ),
    );
  }
}
