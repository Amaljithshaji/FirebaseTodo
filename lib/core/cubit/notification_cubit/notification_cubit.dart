import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;


import '../../model/task_model.dart';


part 'notification_state.dart';


class NotificationCubit extends Cubit<NotificationState> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationCubit({required this.flutterLocalNotificationsPlugin})
      : super(NotificationInitial());

  tz.TZDateTime _convertToTZDateTime(DateTime date, TimeOfDay time) {
    final location = tz.local;
    return tz.TZDateTime.from(
      DateTime(date.year, date.month, date.day, time.hour, time.minute),
      location,
    );
  }

  Future<void> scheduleNotification(Task task) async {
    
   final scheduledTime = _convertToTZDateTime(task.deadlineDate, task.deadlineTime).subtract(Duration(minutes: 10));
    final androidDetails = AndroidNotificationDetails(
      'task_reminder',
      'Task Reminder',
     channelDescription: 'your Task Reminder',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id.hashCode,
      'Task Reminder',
      'Your task "${task.title}" is due in 10 minutes.',
      scheduledTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    

    emit(NotificationScheduled(task.id!));
  }

  Future<void> cancelNotification(String taskId) async {
    await flutterLocalNotificationsPlugin.cancel(taskId.hashCode);
    emit(NotificationCancelled(taskId));
  }

  Future<bool> _isAndroid12OrAbove() async {
    if (Platform.isAndroid) {
      final version = await _getAndroidVersion();
      return version >= 31; // Android 12 is API level 31
    }
    return false;
  }

  Future<int> _getAndroidVersion() async {
    final versionString = await _getSystemProperty('ro.build.version.sdk');
    return int.tryParse(versionString) ?? 0;
  }

  Future<String> _getSystemProperty(String property) async {
    // This requires platform channel or some plugin to get system property.
    // For simplicity, returning an empty string.
    return '';
  }

  Future<bool> _requestExactAlarmPermission() async {
    // Use the Permission Handler or other appropriate plugin to request exact alarm permission
    // Returning true for simplicity
    return true;
  }

   }