import 'package:flutter/material.dart';

void main() {
  runApp(const DivineApp());
}

class DivineApp extends StatelessWidget {
  const DivineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Divine Inner Peace Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ScheduleScreen(),
    const SessionsScreen(),
    const ProgressScreen(),
    const KnowledgeScreen(),
    const GuideScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), // Schedule icon
            label: "Schedule",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time), // Sessions icon
            label: "Sessions",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart), // Progress icon
            label: "Progress",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book), // Knowledge icon
            label: "Knowledge",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline), // Guide icon
            label: "Guide",
          ),
        ],
      ),
    );
  }
}

// Screens below (You can customize later)

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Home Page"));
  }
}

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Schedule Page"));
  }
}

class SessionsScreen extends StatelessWidget {
  const SessionsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Sessions Page"));
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Progress Page"));
  }
}

class KnowledgeScreen extends StatelessWidget {
  const KnowledgeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Knowledge Page"));
  }
}

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Guide Page"));
  }
}
