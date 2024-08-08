
import '../../domain/entities/task.dart';

class TaskDataSource {
  final List<Task> _tasks = [];

  Future<void> addTask(Task task) async {
    _tasks.add(task);
  }

  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((task) => task.id == id);
  }

  Future<void> toggleTaskCompletion(String id) async {
    var task = _tasks.firstWhere((task) => task.id == id);
   //final  task.isCompleted = !task.isCompleted;
  }

  Stream<List<Task>> getTasks() async* {
    yield _tasks;
  }
}






