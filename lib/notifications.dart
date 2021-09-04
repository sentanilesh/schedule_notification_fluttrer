
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationsMgr {
  static NotificationsMgr? _instance;

  NotificationsMgr._();

  static NotificationsMgr get getInstance => _instance ??= NotificationsMgr._();

  Future<bool> initNotification() async {
    return await AwesomeNotifications().initialize('resource://drawable/app_icon', [
      NotificationChannel(
          channelKey: 'channelKey',
          channelName: 'channelName',
          channelDescription: 'Notification channel for Receive Notification',
          defaultColor: Colors.indigo,
          ledColor: Colors.white),
    ]);
  }

  void askNotificationPermission() async {
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  Future<bool> showNotification(int notificationID, String title, String body, DateTime scheduleTime) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: notificationID,
          channelKey: 'channelKey',
          title: title,
          body: body,
          notificationLayout: NotificationLayout.Default,
        ),
        schedule: NotificationCalendar.fromDate(date: scheduleTime),
        actionButtons: [
          NotificationActionButton(label: 'Snooze', key: 'SNOOZE', enabled: true),
          NotificationActionButton(label: 'Taken', key: 'TAKEN', enabled: true),
          NotificationActionButton(label: 'Miss', key: 'MISS', enabled: true)
        ]);
    return true;
  }

  void cancelScheduledNotification(int id) {
    AwesomeNotifications().cancelSchedule(id);
  }

  void listenNotificationStream(BuildContext context) {
    AwesomeNotifications().actionStream.listen((receivedNotification) {
      String tag = receivedNotification.buttonKeyPressed;
      switch (tag) {
        case 'SNOOZE': // TODO: IMPLEMENT HERE
          break;
        case 'TAKEN':// TODO: IMPLEMENT HERE
          break;
        case 'MISS':// TODO: IMPLEMENT HERE
          break;
      }
    });
  }
}
