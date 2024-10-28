import 'package:bloc_hive_tutorial/features/todo/data/models/todo_model.dart';
import 'package:bloc_hive_tutorial/features/todo/domain/entities/todo.dart';
import 'package:bloc_hive_tutorial/features/todo/domain/repos/todo_repo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveTodoRepo implements TodoRepo {
  final Box<TodoModel> todoBox;

  HiveTodoRepo(this.todoBox);

  // retrieve all todos
  @override
  Future<List<Todo>> getAllTodos() async {
    return todoBox.values
        .map((todoModel) => Todo(
              id: todoModel.id,
              title: todoModel.title,
              description: todoModel.description,
              isCompleted: todoModel.isCompleted,
            ))
        .toList();
  }

  // adding todo in database
  @override
  Future<void> addTodo(Todo todo) async {
    final todoModel = TodoModel(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      isCompleted: todo.isCompleted,
    );

    await todoBox.put(todo.id, todoModel);
  }

  // update todo
  @override
  Future<void> updateTodo(Todo newTodo) async {
    final todoModel = todoBox.get(newTodo.id);
    if (todoModel != null) {
      final updatedTodoModel = TodoModel(
        id: newTodo.id,
        title: newTodo.title,
        description: newTodo.description,
        isCompleted: newTodo.isCompleted,
      );
      await todoBox.put(newTodo.id, updatedTodoModel);
    }
  }

  // delete todo
  @override
  Future<void> deleteTodo(String id) async {
    await todoBox.delete(id);
  }
}
