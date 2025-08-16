import 'package:get/get.dart';
import '../models/todo_model.dart';
import '../services/todo_service.dart';

class TodoController extends GetxController {
  final TodoService _todoService = TodoService();
  final todos = <Todo>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchTodos();
    super.onInit();
  }

  void fetchTodos() {
    isLoading(true);
    try {
      _todoService.getTodos().listen((todoList) {
        todos.assignAll(todoList);
        isLoading(false);
      });
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> addTodo(Todo todo) async {
    try {
      await _todoService.addTodo(todo);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      await _todoService.updateTodo(todo);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _todoService.deleteTodo(id);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void toggleTodoStatus(Todo todo) {
    final updatedTodo = Todo(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      isCompleted: !todo.isCompleted,
      createdAt: todo.createdAt,
    );
    updateTodo(updatedTodo);
  }
}