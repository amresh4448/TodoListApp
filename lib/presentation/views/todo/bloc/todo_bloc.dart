import 'package:bloc/bloc.dart';
import 'package:todo_list_app/domain/entities/task.dart';
import 'package:todo_list_app/domain/repository/task_repo.dart';
import 'package:todo_list_app/domain/repository/task_repositry.dart';
import 'package:todo_list_app/domain/usecases/todo_usecase/add_task.dart';
import 'package:todo_list_app/domain/usecases/todo_usecase/delete_task.dart';
import 'package:todo_list_app/domain/usecases/todo_usecase/fillter.dart';
import 'package:todo_list_app/domain/usecases/todo_usecase/toggle_task_completion.dart';
import 'todo_event.dart';
import 'todo_state.dart';


class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;
  final AddTask addTask;
  final DeleteTask deleteTask;
  final ToggleTaskCompletion toggleTaskCompletion;
  final FilterTasks filterTasks;

  TaskBloc({
    required this.repository,
    required this.addTask,
    required this.deleteTask,
    required this.toggleTaskCompletion,
    required this.filterTasks,
  }) : super(TaskLoading()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<ToggleTaskCompletionEvent>(_onToggleTaskCompletion);
    on<FilterTasksEvent>(_onFilterTasks);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    await emit.forEach<List<Task>>(
      repository.getTasks(),
      onData: (tasks) => TaskLoaded(tasks),
      onError: (_, __) => TaskError('Failed to load tasks'),
    );
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    await addTask.execute(event.task);
  }

  Future<void> _onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    await deleteTask.execute(event.id);
  }

  Future<void> _onToggleTaskCompletion(ToggleTaskCompletionEvent event, Emitter<TaskState> emit) async {
    await toggleTaskCompletion.execute(event.id);
  }

  void _onFilterTasks(FilterTasksEvent event, Emitter<TaskState> emit) {
    final currentState = state;
    if (currentState is TaskLoaded) {
      final filteredTasks = filterTasks.execute(currentState.tasks, event.filter);
      emit(TaskLoaded(filteredTasks));
    }
  }
}
