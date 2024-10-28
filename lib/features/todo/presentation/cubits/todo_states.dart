import 'package:bloc_hive_tutorial/features/todo/domain/entities/todo.dart';

abstract class TodoStates {}

class TodoInitial extends TodoStates {}

class TodoLoading extends TodoStates {}

class TodoLoaded extends TodoStates {
  final List<Todo> todos;

  TodoLoaded(this.todos);
}

class TodoError extends TodoStates {
  final String message;

  TodoError(this.message);
}
