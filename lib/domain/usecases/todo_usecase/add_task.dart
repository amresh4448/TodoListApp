import 'package:todo_list_app/domain/repository/task_repo.dart';
import '../../entities/task.dart';

class AddTask {
  final TaskRepository repository;

  AddTask(this.repository);

  Future<void> execute(Task task) {
    return repository.addTask(task);
  }
}
