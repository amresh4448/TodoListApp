import 'package:equatable/equatable.dart';
import 'package:todo_list_app/domain/entities/task.dart';
import 'package:todo_list_app/domain/usecases/todo_usecase/fillter.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasks extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final Task task;

  const AddTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final String id;

  const DeleteTaskEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ToggleTaskCompletionEvent extends TaskEvent {
  final String id;

  const ToggleTaskCompletionEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class FilterTasksEvent extends TaskEvent {
  final TaskFilter filter;

  const FilterTasksEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}
