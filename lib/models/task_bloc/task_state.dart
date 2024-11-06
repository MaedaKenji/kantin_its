part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final  list<TaskModel> tasks;
  TaskLoaded(required.this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TaskError extends TaskState {
  final String message;
  TaskError(required.this.message);

  @override
  List<Object> get props => [message];
  
}