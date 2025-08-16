import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import '../controllers/todo_controller.dart';
import '../models/todo_model.dart';

class AddTodoView extends StatefulWidget {
  @override
  _AddTodoViewState createState() => _AddTodoViewState();
}

class _AddTodoViewState extends State<AddTodoView> {
  final TodoController _todoController = Get.find();
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descController = TextEditingController();

    final todo = Get.arguments as Todo?;
    if (todo != null) {
      _titleController.text = todo.title;
      _descController.text = todo.description;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeCtrl = Get.find<ThemeController>();

    return Obx(() {
      final isDark = themeCtrl.isDarkMode.value;

      // Decide colors
      final cardColor = isDark ? Colors.grey[850] : Colors.white;
      final labelColor = isDark ? Colors.grey[400] : null;
      final textColor = isDark ? Colors.grey[400] : null;

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

          // Rounded bottom corners
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),

          // Title styling
          title: Text(
            Get.arguments == null ? 'Add Todo' : 'Edit Todo',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.1,
              color: Colors.white,
            ),
          ),

          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Container(color: Colors.white24, height: 1),
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Title Field
                Card(
                  elevation: 4,
                  color: cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      controller: _titleController,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(color: labelColor),
                        border: InputBorder.none,
                      ),
                      validator:
                          (v) =>
                              (v == null || v.isEmpty)
                                  ? 'Please enter a title'
                                  : null,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Description Field
                Expanded(
                  child: Card(
                    elevation: 4,
                    color: cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: _descController,
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          labelText: 'Content',
                          labelStyle: TextStyle(color: labelColor),
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: _saveTodo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00A9C7),
                    minimumSize: Size(double.infinity, 50),
                    padding: EdgeInsets.zero,
                  ),
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void _saveTodo() {
    if (_formKey.currentState!.validate()) {
      final todo = Todo(
        title: _titleController.text,
        description: _descController.text,
        createdAt: DateTime.now(),
      );

      if (Get.arguments == null) {
        _todoController.addTodo(todo);
      } else {
        final existingTodo = Get.arguments as Todo;
        final updatedTodo = Todo(
          id: existingTodo.id,
          title: _titleController.text,
          description: _descController.text,
          isCompleted: existingTodo.isCompleted,
          createdAt: existingTodo.createdAt,
        );
        _todoController.updateTodo(updatedTodo);
      }
      Get.back();
    }
  }
}
