import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/todo_controller.dart';
import '../controllers/theme_controller.dart';
import 'add_todo_view.dart';

class HomeView extends StatelessWidget {
  final TodoController _todoController = Get.put(TodoController());
  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,

        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00A9C7), Color(0xFF00BCA1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),

        title: Text(
          'Todo App',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
          ),
        ),

        actions: [
          Tooltip(
            message: 'Toggle Theme',
            child: Obx(
              () => IconButton(
                icon: Icon(
                  _themeController.isDarkMode.value
                      ? Icons.light_mode
                      : Icons.dark_mode,
                  color: Colors.white,
                ),
                onPressed: _themeController.toggleTheme,
              ),
            ),
          ),
          Tooltip(
            message: 'Sign Out',
            child: IconButton(
              icon: Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                Get.find<AuthController>().signOut();
                Get.offAllNamed('/sign-in');
              },
            ),
          ),
        ],

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(color: Colors.white24, height: 1),
        ),
      ),

      body: Obx(() {
        if (_todoController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: _todoController.todos.length,
          itemBuilder: (context, index) {
            final todo = _todoController.todos[index];
            return Slidable(
              key: ValueKey(todo.id),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (_) => _todoController.deleteTodo(todo.id!),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  onTap: () => _todoController.toggleTodoStatus(todo),
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (_) => _todoController.toggleTodoStatus(todo),
                  ),
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => Get.to(AddTodoView(), arguments: todo),
                  ),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF00A9C7), // Cyan shade
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () => Get.to(AddTodoView()),
      ),
    );
  }
}
