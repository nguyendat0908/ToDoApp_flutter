import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firestore/todo_firestore.dart';
import 'package:todo_app/models/todos_models.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final TodoFirestore todoFirestore = TodoFirestore();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _buildBodyPage(),
      ),
    );
  }

  Widget _buildBodyPage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 56),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeadIndex(),
            _buildTodoBox(),
            StreamBuilder<List<TodoModels>>(
              stream: todoFirestore.getDataTodo(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error}',
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Lato',
                          color: Colors.white.withOpacity(0.87)),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'No todo!',
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Lato',
                          color: Colors.white.withOpacity(0.87)),
                    ),
                  );
                } else {
                  List<TodoModels> allTodos = snapshot.data!;
                  List<TodoModels> completedTodos = allTodos
                      .where((todo) => todo.isDone)
                      .toList(); // Lọc danh sách công việc đã hoàn thành
                  List<TodoModels> remainingTodos = allTodos
                      .where((todo) => !todo.isDone)
                      .toList(); // Lọc danh sách công việc chưa hoàn thành

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildListTodo(
                          remainingTodos), // Hiển thị danh sách công việc chưa hoàn thành
                      _buildCompletedBox(), // Hiển thị box cho các công việc đã hoàn thành
                      _buildListTodo(
                          completedTodos), // Hiển thị danh sách công việc đã hoàn thành
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeadIndex() {
    return Row(
      children: [
        Image.asset(
          "assets/images/List_index.png",
          height: 42,
          width: 42,
          fit: BoxFit.fill,
        ),
        Expanded(child: Container()),
        Text(
          'Index',
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'Lato',
              color: Colors.white.withOpacity(0.87)),
        ),
        Expanded(child: Container()),
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(
            "assets/images/avatar.jpg",
            height: 42,
            width: 42,
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedBox() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Completed',
        style: TextStyle(
            fontSize: 16,
            fontFamily: 'Lato',
            color: Colors.white.withOpacity(0.87)),
      ),
      margin: EdgeInsets.only(top: 10),
      height: 40,
      width: 120,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.21),
          borderRadius: BorderRadius.circular(6)),
    );
  }

  Widget _buildListTodo(List<TodoModels> todoModels) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _buildListItems(todoModels[index]);
      },
      itemCount: todoModels.length,
    );
  }

  Widget _buildListItems(TodoModels todoModels) {
    return GestureDetector(
      onLongPress: () {
        // Hiển thị hộp thoại xác nhận xóa
        _showDeleteConfirmationDialog(todoModels);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: 327,
        height: 72,
        decoration: BoxDecoration(
          color: Color(0xFF363636),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Checkbox(
              value: todoModels.isDone,
              onChanged: (val) {
                setState(() {
                  todoModels.isDone = val!;
                  if (val) {
                    todoFirestore.updateTodo(todoModels);
                  }
                });
              },
              activeColor: Colors.white,
              checkColor: Colors.green,
            ),
            _buildDescAndTitle(todoModels),
            Expanded(child: Container()),
            _buildTimeAndPriority(todoModels),
          ],
        ),
      ),
    );
  }

  Widget _buildTodoBox() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'List Todo',
        style: TextStyle(
            fontSize: 16,
            fontFamily: 'Lato',
            color: Colors.white.withOpacity(0.87)),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 40,
      width: 120,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.21),
          borderRadius: BorderRadius.circular(6)),
    );
  }

  Widget _buildDescAndTitle(TodoModels todoModels) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          todoModels.title!,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'Lato',
              color: Colors.white.withOpacity(0.87)),
        ),
        Text(
          todoModels.description!,
          style: TextStyle(
              fontSize: 14, fontFamily: 'Lato', color: Color(0xFFAFAFAF)),
        ),
      ],
    );
  }

  Widget _buildTimeAndPriority(TodoModels todoModels) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPriority(todoModels.priority!),
        _buildTime(todoModels.dateTime!.toDate()),
      ],
    );
  }

  Widget _buildTime(DateTime time) {
    String formattedDate = DateFormat('HH:mm/dd-MM', 'vi').format(time);
    return Container(
      child: Text(
        formattedDate,
        style: TextStyle(
            fontSize: 14, fontFamily: 'Lato', color: Color(0xFFAFAFAF)),
      ),
    );
  }

  Widget _buildPriority(int priority) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Color(0xFF8687E7)),
          borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Image.asset(
            "assets/images/task_flag.png",
            width: 18,
            height: 18,
            fit: BoxFit.fill,
          ),
          Text(
            priority.toString(),
            style: const TextStyle(
                fontSize: 18, fontFamily: 'Lato', color: Color(0xFFAFAFAF)),
          ),
        ],
      ),
    );
  }

  // Phương thức để hiển thị hộp thoại xác nhận xóa
  void _showDeleteConfirmationDialog(TodoModels todoModels) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this task?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                todoFirestore.deleteTodo(todoModels
                    .id!); // Gọi phương thức xóa công việc từ Firestore
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
