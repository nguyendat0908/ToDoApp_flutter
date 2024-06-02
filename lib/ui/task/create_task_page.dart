import 'package:flutter/material.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _nameTaskTextController = TextEditingController();
  final _descTaskTextController = TextEditingController();
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
                onPressed: () {},
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
}
