import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/todos_models.dart';

class TodoFirestore {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Them du lieu len firestore
  Future<void> addTodo(TodoModels todoModels) async {
    DocumentReference docRef =
        await _db.collection('todos').add(todoModels.toMap());
    todoModels.id = docRef.id; // Lưu lại id của tài liệu vừa được thêm
  }

  // Update du lieu
  Future<void> updateTodo(TodoModels todoModels) async {
    await _db.collection('todos').doc(todoModels.id).update(todoModels.toMap());
  }

  // Xoa du lieu
  Future<void> deleteTodo(String id) async {
    await _db.collection('todos').doc(id).delete();
  }

  // Lay du lieu tu firestore
  Stream<List<TodoModels>> getDataTodo() {
    return _db.collection('todos').snapshots().map((snapshot) =>
        snapshot.docs.map((e) => TodoModels.fromMap(e.data(), e.id)).toList());
  }
}
