import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/todo_model.dart';

class TodoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user's todos
  Stream<List<Todo>> getTodos() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('User not logged in');

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('todos')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Todo.fromJson(doc.data(), doc.id))
        .toList());
  }

  // Add new todo
  Future<void> addTodo(Todo todo) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('User not logged in');

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('todos')
        .add(todo.toJson());
  }

  // Update todo
  Future<void> updateTodo(Todo todo) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null || todo.id == null) throw Exception('Invalid data');

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('todos')
        .doc(todo.id)
        .update(todo.toJson());
  }

  // Delete todo
  Future<void> deleteTodo(String id) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('User not logged in');

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('todos')
        .doc(id)
        .delete();
  }
}
