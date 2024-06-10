part of 'task_cubit.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskSuccess extends TaskState {
  final Task? task;
 

  TaskSuccess({this.task});
}

class TasksLoaded extends TaskState {
  final List<Task> completedTasks;
  final List<Task> incompleteTasks;

  TasksLoaded({required this.completedTasks, required this.incompleteTasks});
}
class TaskFailure extends TaskState {
  final String message;

  TaskFailure({required this.message});
}