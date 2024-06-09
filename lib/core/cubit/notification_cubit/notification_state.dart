part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationScheduled extends NotificationState {
  final String taskId;

  NotificationScheduled(this.taskId);
}

class NotificationCancelled extends NotificationState {
  final String taskId;

  NotificationCancelled(this.taskId);
}

class NotificationError extends NotificationState {
  final String message;

  NotificationError(this.message);
}