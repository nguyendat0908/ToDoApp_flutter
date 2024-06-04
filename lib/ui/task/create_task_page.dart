import 'package:flutter/material.dart';
import 'package:todo_app/models/category_models.dart';

import '../../ultils/ultils.enums/color_extention.dart';
import '../category/category_list_page.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _nameTaskTextController = TextEditingController();
  final _descTaskTextController = TextEditingController();
  CategoryModel? _categorySelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF363636),
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(25),
          child: _buildBodyPage(),
        ),
      ),
    );
  }

  Widget _buildBodyPage() {
    return Form(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTaskNameField(),
        _buildTaskDescField(),
        if (_categorySelected != null) _buildTaskCategory(),
        _buildTaskActionField(),
      ],
    ));
  }

  Widget _buildTaskNameField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Task',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato',
              color: Colors.white.withOpacity(0.87)),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: TextFormField(
            controller: _nameTaskTextController,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
            ),
            decoration: InputDecoration(
                hintText: 'Do math homework',
                hintStyle: const TextStyle(
                    fontSize: 18, color: Color(0xFFAFAFAF), fontFamily: 'Lato'),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide:
                        BorderSide(width: 1, color: Color(0xFF979797)))),
            autofocus: false,
          ),
        ),
      ],
    );
  }

  Widget _buildTaskDescField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
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
                  hintText: 'Do math homework',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                    color: Color(0xFFAFAFAF),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide:
                          BorderSide(width: 1, color: Color(0xFF979797)))),
              autofocus: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCategory() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Task category',
            style: TextStyle(
                fontSize: 18, fontFamily: 'Lato', color: Color(0xFFFFFFFF)),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: _buildGridCategoryItems(_categorySelected!),
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
                onPressed: () {},
                icon: Image.asset(
                  'assets/images/task_timer.png',
                  width: 24,
                  height: 24,
                  fit: BoxFit.fill,
                ),
              ),
              IconButton(
                onPressed: () {},
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
            onPressed: () {},
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
}
