class TodoModels {
  String? title;
  String? description;
  int? priority;
  DateTime? dateTime;

  TodoModels({this.title, this.description, this.priority, this.dateTime});

  // Chuyen doi doi tuong to do thanh map dang Key - Value
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'priority': priority,
      'dateTime': dateTime
    };
  }

  // Chuyển đổi dữ liệu từ Firestore thành đối tượng to do.
  factory TodoModels.fromMap(Map<String, dynamic> map) {
    return TodoModels(
      title: map['title'],
      description: map['description'],
      priority: map['priority'],
      dateTime: map['dateTime'],
    );
  }
}
