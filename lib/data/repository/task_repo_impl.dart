import 'package:todo_list_app/domain/repository/task_repo.dart';
import 'package:todo_list_app/domain/repository/task_repositry.dart';

import '../../domain/entities/task.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDataSource dataSource;

  TaskRepositoryImpl(this.dataSource);

  @override
  Future<void> addTask(Task task) => dataSource.addTask(task);

  @override
  Future<void> deleteTask(String id) => dataSource.deleteTask(id);

  @override
  Future<void> toggleTaskCompletion(String id) => dataSource.toggleTaskCompletion(id);

  @override
  Stream<List<Task>> getTasks() => dataSource.getTasks();
}
