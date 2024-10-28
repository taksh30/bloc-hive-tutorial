import 'package:bloc_hive_tutorial/features/todo/domain/entities/todo.dart';
import 'package:bloc_hive_tutorial/features/todo/domain/repos/todo_repo.dart';
import 'package:bloc_hive_tutorial/features/todo/presentation/cubits/todo_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<TodoStates> {
  final TodoRepo todoRepo;

  TodoCubit(this.todoRepo) : super(TodoInitial()) {
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    emit(TodoLoading());
    try {
      final todos = await todoRepo.getAllTodos();
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(TodoError("Failed to load todos"));
    }
  }

  Future<void> addTodo(Todo todo) async {
    try {
      await todoRepo.addTodo(todo);
      await fetchTodos();
    } catch (e) {
      emit(TodoError("Failed to add todo"));
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      await todoRepo.updateTodo(todo);
      await fetchTodos();
    } catch (e) {
      emit(TodoError("Failed to update todo"));
    }
  }

  Future<void> toggleComplete(String id) async {
    try {
      if (state is TodoLoaded) {
        final todos = (state as TodoLoaded).todos.map((todo) {
          if (todo.id == id) return todo.toggleCompletion();
          return todo;
        }).toList();
        await todoRepo.updateTodo(todos.firstWhere((todo) => todo.id == id));
        emit(TodoLoaded(todos));
      }
    } catch (e) {
      emit(TodoError("Failed to update todo"));
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await todoRepo.deleteTodo(id);
      if (state is TodoLoaded) {
        final updatedTodos =
            (state as TodoLoaded).todos.where((todo) => todo.id != id).toList();
        emit(TodoLoaded(updatedTodos));
      }
    } catch (e) {
      emit(TodoError("Failed to delete todo"));
    }
  }
}
