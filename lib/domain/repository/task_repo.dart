import 'package:todo_list_app/domain/entities/task.dart';

abstract class TaskRepository {

  Future<void> addTask(Task task);
  Future<void> deleteTask(String id);
  Future<void> toggleTaskCompletion(String id);
  Stream<List<Task>> getTasks();
}