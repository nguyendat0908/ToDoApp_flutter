import 'package:flutter/material.dart';

class TaskPriorityListPage extends StatefulWidget {
  const TaskPriorityListPage({super.key});

  @override
  State<TaskPriorityListPage> createState() => _TaskPriorityListPageState();
}

class _TaskPriorityListPageState extends State<TaskPriorityListPage> {
  List<int> priorityListDataSource = [];
  int? _selectPriority;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        priorityListDataSource = List.generate(10, (index) => index + 1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _buildBodyPage(),
    );
  }

  Widget _buildBodyPage() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color(0xFF363636),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildChoosePriorityTitle(),
              _buildGridPriorityList(),
              _buildCreatePriorityButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChoosePriorityTitle() {
    return Column(
      children: [
        Text(
          'Ưu tiên nhiệm vụ',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.87)),
        ),
        // Thanh duong thang
        const Divider(
          color: Color(0xFF979797),
        )
      ],
    );
  }

  Widget _buildGridPriorityList() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 0.7),
      itemBuilder: (context, index) {
        final priority = priorityListDataSource.elementAt(index);
        return _buildGridPriorityItem(priority);
      },
      itemCount: priorityListDataSource.length,
    );
  }

  Widget _buildGridPriorityItem(int priority) {
    final isSelected = priority == _selectPriority;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectPriority = priority;
        });
      },
      child: Container(
        margin: EdgeInsets.all(5),
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? const Color(0xFF8687E7) : const Color(0xFF272727),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/task_flag.png",
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
            Text(
              priority.toString(),
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreatePriorityButton() {
    return Container(
      margin: const EdgeInsets.only(top: 108, bottom: 20),
      child: Row(
        children: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Hủy bỏ',
                style: TextStyle(
                    fontSize: 16, fontFamily: 'Lato', color: Color(0xFF8687E7)),
              )),
          const Spacer(),
          Container(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    "priority": _selectPriority,
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8875FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))),
                child: const Text(
                  "Lưu",
                  style: TextStyle(
                      fontSize: 16, fontFamily: 'Lato', color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
