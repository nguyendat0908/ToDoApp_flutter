import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/todos_models.dart';

class TodoFirestore {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Them du lieu len firestore
  Future<void> addTodo(TodoModels todoModels) async {
    await _db.collection('todos').add(todoModels.toMap());
  }

  // Update du lieu
  Future<void> updateTodo(TodoModels todoModels) async {
    await _db
        .collection('todos')
        .doc(todoModels.priority as String?)
        .update(todoModels.toMap());
  }

  // Xoa du lieu
  Future<void> deleteTodo(TodoModels todoModels) async {
    await _db.collection('todos').doc(todoModels.priority as String?).delete();
  }

  // Lay du lieu tu firestore
  Stream<List<TodoModels>> getDataTodo() {
    return _db.collection('todos').snapshots().map((snapshot) =>
        snapshot.docs.map((e) => TodoModels.fromMap(e.data())).toList());
  }
}
