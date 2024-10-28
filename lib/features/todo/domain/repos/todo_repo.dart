import 'package:bloc_hive_tutorial/features/todo/domain/entities/todo.dart';

abstract class TodoRepo {
  Future<List<Todo>> getAllTodos();

  Future<void> addTodo(Todo todo);

  Future<void> updateTodo(Todo newTodo);

  Future<void> deleteTodo(String id);
}
