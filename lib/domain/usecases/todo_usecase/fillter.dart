
import 'package:todo_list_app/domain/entities/task.dart';

enum TaskFilter { all, completed, pending }

class FilterTasks {
  List<Task> execute(List<Task> tasks, TaskFilter filter) {
    switch (filter) {
      case TaskFilter.completed:
        return tasks.where((task) => task.isCompleted).toList();
      case TaskFilter.pending:
        return tasks.where((task) => !task.isCompleted).toList();
      case TaskFilter.all:
      default:
        return tasks;
    }
  }
}
