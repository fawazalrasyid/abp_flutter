import 'package:abp_flutter/task_page.dart';
import 'package:abp_flutter/week11/tutorial2/tutorial_11-2.dart';
import 'package:flutter/material.dart';

class TutorialWeek111 extends StatefulWidget {
  const TutorialWeek111({super.key});

  @override
  State<TutorialWeek111> createState() => _TutorialWeek111State();
}

class _TutorialWeek111State extends State<TutorialWeek111> {
  int selected = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              selected = index;
            });
          },
          children: [
            Center(
              child: InkWell(
                child: const Text(
                  'Go To Home Page',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TaskPage(),
                    ),
                  ); // MaterialPageRoute
                },
              ), //Inkwell
            ), // Center
            const TutorialWeek112(),
            const Center(
              child: Text(
                'Profile Page',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ), // Center
          ],
        ), // PageView
      ), // SafeArea
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.white,
        currentIndex: selected,
        onTap: (index) {
          setState(() {
            selected = index;
          });
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email),
            label: 'Email',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
