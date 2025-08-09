import 'package:flutter/material.dart';
import 'guided_sessions_page.dart';
import 'guide_page.dart';
import 'knowledge_page.dart';
import 'progress.dart';
import 'schedule_page.dart';
import 'main.dart';

Widget buildBottomNavigationBar(BuildContext context, int currentIndex) {
  return BottomNavigationBar(
    currentIndex: currentIndex,
    backgroundColor: Colors.white,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.orange.shade300,
    type: BottomNavigationBarType.fixed,
    onTap: (index) {
      if (index == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else if (index == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SchedulePage()),
        );
      } else if (index == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const GuidedSessions()),
        );
      } else if (index == 3) {
        Navigator.pushReplacement(
          context,
          // Removed 'const' keyword to call the non-const constructor.
          MaterialPageRoute(builder: (context) => ProgressPage()),
        );
      } else if (index == 4) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const KnowledgePage()),
        );
      } else if (index == 5) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const GuidePage()),
        );
      }
    },
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(
        icon: Icon(Icons.calendar_month),
        label: "Schedule",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.access_time),
        label: "Sessions",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.show_chart),
        label: "Progress",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.menu_book),
        label: "Knowledge",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.chat_bubble_outline),
        label: "Guide",
      ),
    ],
  );
}
