
import '../../repository/task_repo.dart';

class DeleteTask {
  final TaskRepository repository;

  DeleteTask(this.repository);

  Future<void> execute(String id) {
    return repository.deleteTask(id);
  }
}
