

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../model/task_model.dart';
import '../notification_cubit/notification_cubit.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId;
  final NotificationCubit notificationCubit;

  TaskCubit({required this.userId, required this.notificationCubit})
      : super(TaskInitial());

  CollectionReference get tasksRef => _firestore.collection('users').doc(userId).collection('tasks');

  Future<void> fetchTasks() async {
    emit(TaskLoading());
    try {
      final snapshot = await tasksRef.get();
      final tasks = snapshot.docs.map((doc) => Task.fromSnapshot(doc)).toList();
      final completedTasks = tasks.where((task) => task.isComplete).toList();
      final incompleteTasks = tasks.where((task) => !task.isComplete).toList();
      emit(TasksLoaded(completedTasks: completedTasks, incompleteTasks: incompleteTasks));
    } catch (e) {
      emit(TaskFailure(message: e.toString()));
    }
  }

  Future<void> createTask(Task task) async {
    emit(TaskLoading());
    try {
      DocumentReference docRef = await tasksRef.add(task.toMap());
      Task newTask = task.copyWith(id: docRef.id);
      await notificationCubit.scheduleNotification(newTask); // Schedule notification
      fetchTasks();  // Refresh tasks
      emit(TaskSuccess());
    } catch (e) {
      emit(TaskFailure(message: e.toString()));
    }
  }

  Future<void> updateTask(Task task) async {
    emit(TaskLoading());
    try {
      await tasksRef.doc(task.id).update(task.toMap());
      await notificationCubit.scheduleNotification(task); // Schedule notification
      fetchTasks();  // Refresh tasks
      emit(TaskSuccess());
    } catch (e) {
      emit(TaskFailure(message: e.toString()));
    }
  }

  Future<void> deleteTask(String taskId) async {
    emit(TaskLoading());
    try {
      await tasksRef.doc(taskId).delete();
      await notificationCubit.cancelNotification(taskId); // Cancel notification
      fetchTasks();  // Refresh tasks
      emit(TaskSuccess());
    } catch (e) {
      emit(TaskFailure(message: e.toString()));
    }
  }

  Future<void> toggleTaskCompletion({required String taskId, required bool isComplete, required Task task}) async {
    emit(TaskLoading());
    try {
      await tasksRef.doc(taskId).update({'isComplete': isComplete});
      if (isComplete) {
        await notificationCubit.cancelNotification(task.id!); // Cancel notification if completed
      } else {
        await notificationCubit.scheduleNotification(task); // Reschedule notification if marked incomplete
      }
      fetchTasks();  // Refresh tasks
      emit(TaskSuccess());
    } catch (e) {
      emit(TaskFailure(message: e.toString()));
    }
  }
}