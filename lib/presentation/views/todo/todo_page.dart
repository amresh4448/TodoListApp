import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/domain/entities/task.dart';
import 'package:todo_list_app/domain/usecases/todo_usecase/fillter.dart';
import 'package:todo_list_app/presentation/views/todo/bloc/todo_bloc.dart';
import 'package:todo_list_app/presentation/views/todo/bloc/todo_event.dart';
import 'package:todo_list_app/presentation/views/todo/bloc/todo_state.dart';

class TaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        actions: [
          PopupMenuButton<TaskFilter>(
            onSelected: (filter) {
              context.read<TaskBloc>().add(FilterTasksEvent(filter));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: TaskFilter.all,
                child: Text('All Tasks'),
              ),
              const PopupMenuItem(
                value: TaskFilter.completed,
                child: Text('Completed Tasks'),
              ),
              const PopupMenuItem(
                value: TaskFilter.pending,
                child: Text('Pending Tasks'),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      context.read<TaskBloc>().add(DeleteTaskEvent(task.id));
                    },
                  ),
                  onTap: () {
                    context.read<TaskBloc>().add(ToggleTaskCompletionEvent(task.id));
                  },
                );
              },
            );
          } else if (state is TaskError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final title = await showDialog<String>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add Task'),
                content: TextField(
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Enter task title'),
                  onSubmitted: (value) {
                    Navigator.of(context).pop(value);
                  },
                ),
              );
            },
          );

          if (title != null && title.isNotEmpty) {
            final task = Task(id: UniqueKey().toString(), title: title);
            context.read<TaskBloc>().add(AddTaskEvent(task));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
