import 'package:bloc_hive_tutorial/features/todo/domain/entities/todo.dart';
import 'package:bloc_hive_tutorial/features/todo/presentation/cubits/todo_cubit.dart';
import 'package:bloc_hive_tutorial/features/todo/presentation/cubits/todo_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _titleCtr = TextEditingController();
  final TextEditingController _descCtr = TextEditingController();

  late final _todoCubit = context.read<TodoCubit>();

  void _showTodoDialog({Todo? todo}) {
    if (todo != null) {
      _titleCtr.text = todo.title;
      _descCtr.text = todo.description;
    } else {
      _titleCtr.clear();
      _descCtr.clear();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          todo == null ? 'Add Todo' : 'Update Todo',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleCtr,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            TextField(
              controller: _descCtr,
              decoration: const InputDecoration(hintText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              final title = _titleCtr.text.trim();
              final description = _descCtr.text.trim();

              // add todo
              if (title.isNotEmpty && description.isNotEmpty) {
                if (todo == null) {
                  final addTodo = Todo(
                    id: DateTime.now().toString(),
                    title: title,
                    description: description,
                  );
                  _todoCubit.addTodo(addTodo);
                } else {
                  // update todo
                  _todoCubit.updateTodo(
                      todo.copyWith(title: title, description: description));
                }
              }
              Navigator.pop(context);
            },
            child: Text(
              todo == null ? 'Add' : 'Update',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tasks',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<TodoCubit, TodoStates>(
        builder: (context, state) {
          // loading state
          if (state is TodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // loaded state
          else if (state is TodoLoaded) {
            if (state.todos.isEmpty) {
              return Center(
                child: Text(
                  'No todos added yet',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];

                return Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
                  child: Card(
                    color: Colors.grey.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: ListTile(
                        key: ValueKey(todo.id),
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        subtitle: Text(
                          todo.description,
                          style: TextStyle(
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        leading: Checkbox(
                          activeColor: Colors.black87,
                          value: todo.isCompleted,
                          onChanged: (_) => _todoCubit.toggleComplete(
                            todo.id,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.black),
                              onPressed: () => _showTodoDialog(todo: todo),
                            ),
                            IconButton(
                              icon:
                                  const Icon(Icons.delete, color: Colors.black),
                              onPressed: () => _todoCubit.deleteTodo(todo.id),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is TodoError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () => _showTodoDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
