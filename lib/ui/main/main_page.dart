import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/task/create_task_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> _page = [];
  int _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _page = [
      Container(
        color: Colors.red,
      ),
      Container(
        color: Colors.yellow,
      ),
      Container(
        color: Colors.green,
      ),
      Container(
        color: Colors.blue,
      ),
      Container(
        color: Colors.orange,
        child: SafeArea(
          child: TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: Text('Logout'),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xF121212),
      body: _page.elementAt(_currentPage),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF363636),
        unselectedItemColor: Colors.white,
        selectedItemColor: const Color(0xFF8687E7),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPage,
        onTap: (index) {
          if (index == 2) {
            // Khong hoat dong!
            return;
          }
          setState(() {
            _currentPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/tab_bar_home.png',
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
            activeIcon: Image.asset(
              'assets/images/tab_bar_home.png',
              width: 24,
              height: 24,
              fit: BoxFit.fill,
              color: const Color(0xFF8687E7),
            ),
            label: 'Index',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/tab_bar_calendar.png',
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
            activeIcon: Image.asset(
              'assets/images/tab_bar_calendar.png',
              width: 24,
              height: 24,
              fit: BoxFit.fill,
              color: const Color(0xFF8687E7),
            ),
            label: 'Calendar',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Container(),
            label: '',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/tab_bar_clock.png',
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
            activeIcon: Image.asset(
              'assets/images/tab_bar_clock.png',
              width: 24,
              height: 24,
              fit: BoxFit.fill,
              color: const Color(0xFF8687E7),
            ),
            label: 'Focuse',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/tab_bar_user.png',
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
            activeIcon: Image.asset(
              'assets/images/tab_bar_user.png',
              width: 24,
              height: 24,
              fit: BoxFit.fill,
              color: const Color(0xFF8687E7),
            ),
            label: 'Profile',
            backgroundColor: Colors.transparent,
          )
        ],
      ),
      floatingActionButton: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
            color: const Color(0xFF8687E7),
            borderRadius: BorderRadius.circular(32)),
        child: IconButton(
          onPressed: _onShowCreateTask,
          icon: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onShowCreateTask() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: const CreateTaskPage(),
          );
        });
  }
}
