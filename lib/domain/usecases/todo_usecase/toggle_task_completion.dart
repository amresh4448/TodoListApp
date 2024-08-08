
import 'package:todo_list_app/domain/repository/task_repo.dart';

import '../../repository/task_repositry.dart';

class ToggleTaskCompletion {
  final TaskRepository repository;

  ToggleTaskCompletion(this.repository);

  Future<void> execute(String id) {
    return repository.toggleTaskCompletion(id);
  }
}
