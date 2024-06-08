import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firestore/todo_firestore.dart';
import 'package:todo_app/models/category_models.dart';
import 'package:todo_app/models/todos_models.dart';

import '../../ultils/ultils.enums/color_extention.dart';
import '../category/category_list_page.dart';
import '../task_priority/task_priority_list_page.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _nameTaskTextController = TextEditingController();
  final _descTaskTextController = TextEditingController();
  CategoryModel? _categorySelected;
  Timestamp? _taskDateTimeSelected;
  int? _taskPrioritySelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF363636),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: _buildBodyPage(),
        ),
      ),
    );
  }

  Widget _buildBodyPage() {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTaskNameField(),
            _buildTaskDescField(),
            if (_taskDateTimeSelected != null) _buildTaskDateTime(),
            if (_categorySelected != null) _buildTaskCategory(),
            if (_taskPrioritySelected != null) _buildTaskPriority(),
            _buildTaskActionField(),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskNameField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thêm nhiệm vụ',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato',
              color: Colors.white.withOpacity(0.87)),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: TextFormField(
            controller: _nameTaskTextController,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
            ),
            decoration: InputDecoration(
                hintText: 'Tên việc cần làm',
                hintStyle: const TextStyle(
                    fontSize: 18, color: Color(0xFFAFAFAF), fontFamily: 'Lato'),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide:
                        const BorderSide(width: 1, color: Color(0xFF979797)))),
            autofocus: false,
          ),
        ),
      ],
    );
  }

  Widget _buildTaskDescField() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mô tả',
            style: TextStyle(
                fontSize: 18, fontFamily: 'Lato', color: Color(0xFFFFFFFF)),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: _descTaskTextController,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFFFFFFFF),
              ),
              decoration: InputDecoration(
                  hintText: 'Mô tả nhiệm vụ',
                  hintStyle: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                    color: Color(0xFFAFAFAF),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                          width: 1, color: Color(0xFF979797)))),
              autofocus: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskPriority() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Ưu tiên nhiệm vụ:',
            style: TextStyle(
                fontSize: 18, fontFamily: 'Lato', color: Color(0xFFAFAFAF)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4, left: 4),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Color(0xFF8687E7)),
                  borderRadius: BorderRadius.circular(4)),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/task_flag.png",
                    width: 24,
                    height: 24,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    _taskPrioritySelected!.toString(),
                    style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'Lato',
                        color: Color(0xFFAFAFAF)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCategory() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Hạng mục nhiệm vụ: ',
            style: TextStyle(
                fontSize: 18, fontFamily: 'Lato', color: Color(0xFFAFAFAF)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10),
            child: _buildGridCategoryItems(_categorySelected!),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskDateTime() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Thời gian làm: ',
            style: TextStyle(
                fontSize: 18, fontFamily: 'Lato', color: Color(0xFFAFAFAF)),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 2),
            child: Text(
              DateFormat('dd-MM-yyyy HH:mm', 'vi')
                  .format(_taskDateTimeSelected!.toDate()),
              style: const TextStyle(
                  fontSize: 16, fontFamily: 'Lato', color: Color(0xFFAFAFAF)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridCategoryItems(CategoryModel category) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: category.backgroundColorHex != null
                ? HexColor(category.backgroundColorHex!)
                : Colors.white,
          ),
          child: category.iconCodePoint != null
              ? Icon(
                  IconData(category.iconCodePoint!),
                  color: category.iconColorHex != null
                      ? HexColor(category.iconColorHex!)
                      : Colors.white,
                  size: 30,
                )
              : null,
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            category.name,
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskActionField() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: _selectTaskTime,
                icon: Image.asset(
                  'assets/images/task_timer.png',
                  width: 24,
                  height: 24,
                  fit: BoxFit.fill,
                ),
              ),
              IconButton(
                onPressed: _showDialogChoosePriority,
                icon: Image.asset(
                  'assets/images/task_flag.png',
                  width: 24,
                  height: 24,
                  fit: BoxFit.fill,
                ),
              ),
              IconButton(
                onPressed: _showDialogChooseCategory,
                icon: Image.asset(
                  'assets/images/task_tag.png',
                  width: 24,
                  height: 24,
                  fit: BoxFit.fill,
                ),
              )
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              _sendDataToFirestore();
            },
            icon: Image.asset(
              'assets/images/task_send.png',
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }

  void _showDialogChoosePriority() async {
    final result = await showGeneralDialog(
        context: context,
        barrierLabel: "",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (_, __, ___) {
          return TaskPriorityListPage();
        });
    print(result);
    if (result != null && result is Map<String, dynamic>) {
      // thuc hien
      final priority = result["priority"];
      setState(() {
        _taskPrioritySelected = priority;
      });
    } else {
      // khong lam gi ca
    }
  }

  void _showDialogChooseCategory() async {
    final result = await showGeneralDialog(
        context: context,
        barrierLabel: "",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (_, __, ___) {
          return CategoryListPage();
        });
    print(result);
    if (result != null && result is Map<String, dynamic>) {
      // thuc hien
      final categoryId = result["categoryId"];
      if (categoryId == null) {
        return;
      }
      final name = result["name"];
      final iconCodePoint = result["iconCodePoint"];
      final backgroundColorHex = result["backgroundColorHex"];
      final iconColorHex = result["iconColorHex"];

      final categoryModel = CategoryModel(
          id: categoryId,
          name: name,
          iconCodePoint: iconCodePoint,
          backgroundColorHex: backgroundColorHex,
          iconColorHex: iconColorHex);
      setState(() {
        _categorySelected = categoryModel;
      });
    } else {
      // khong lam gi ca
    }
  }

  void _selectTaskTime() async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.dark(
                    primary: Color(0xFF8687E7), onSurface: Colors.white),
              ),
              child: child!);
        });
    if (date == null) {
      return;
    }
    if (!context.mounted) {
      return;
    }
    final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.dark(
                    primary: Color(0xFF8687E7), onSurface: Colors.white),
              ),
              child: child!);
        });
    if (time == null) {
      return;
    }
    final dateTimeSelected =
        date.copyWith(hour: time.hour, minute: time.minute, second: 0);
    setState(() {
      _taskDateTimeSelected = Timestamp.fromDate(dateTimeSelected);
    });
  }

  Future<void> _sendDataToFirestore() async {
    TodoFirestore todoFirestore = TodoFirestore();
    try {
      if (_nameTaskTextController.text.isEmpty ||
          _descTaskTextController.text.isEmpty) {
        return;
      }
      final todoModels = TodoModels(
        title: _nameTaskTextController.text,
        description: _descTaskTextController.text,
        priority: _taskPrioritySelected,
        dateTime: _taskDateTimeSelected,
      );
      await todoFirestore.addTodo(todoModels);
      _nameTaskTextController.text = '';
      _descTaskTextController.text = '';
      _taskPrioritySelected = null;
      _taskDateTimeSelected = null;
      _categorySelected = null;
      setState(() {
        _showAlert('Thành công', 'Đã thêm nhiệm vụ!');
      });
    } catch (e) {
      print(e);
      _showAlert('Lỗi', 'Không thêm được');
    }
  }

  Future<void> _showAlert(String title, String message) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }
}
