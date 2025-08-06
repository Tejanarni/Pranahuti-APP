import 'package:flutter/material.dart';
import 'dart:async';
import 'package:innerpeaceguide/schedule_page.dart';
import 'main.dart';
import 'progress.dart';
import 'knowledge_page.dart';
import 'guide_page.dart';

class GuidedSessions extends StatefulWidget {
  const GuidedSessions({super.key});

  @override
  State<GuidedSessions> createState() => _GuidedSessionsState();
}

class _GuidedSessionsState extends State<GuidedSessions> {
  int selectedDuration = 10;
  bool isSessionActive = false;
  int remainingSeconds = 0;
  Timer? _timer;

  final List<int> durations = [10, 20, 30, 45, 60];

  final List<Map<String, dynamic>> sessions = [
    {
      'title': 'Point B Meditation',
      'subtitle': 'Morning meditation focusing on Point B in the heart',
      'color': Color(0xFFFFD57E),
    },
    {
      'title': 'Heart Cleaning',
      'subtitle': 'Evening cleaning practice',
      'color': Color(0xFFCBC4F9),
    },
    {
      'title': '9 PM Universal Prayer',
      'subtitle': 'Prayer for the welfare of all beings',
      'color': Color(0xFFF4C2ED),
    },
    {
      'title': 'Point A Meditation',
      'subtitle': 'Night meditation on Point A',
      'color': Color(0xFFB7D6F7),
    },
  ];

  void startTimer() {
    setState(() {
      isSessionActive = true;
      remainingSeconds = selectedDuration * 60;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() => remainingSeconds--);
      } else {
        timer.cancel();
        setState(() => isSessionActive = false);
      }
    });
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6EE),
      body: SafeArea(
        child: isSessionActive
            ? _buildActiveSessionView()
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Column(
                        children: [
                          Text(
                            'Guided Sessions',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5C3A1C),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Divine guidance for your spiritual practice',
                            style: TextStyle(fontSize: 14, color: Colors.brown),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildDurationSelector(),
                    const SizedBox(height: 16),
                    ...sessions.map(
                      (session) => _buildSessionCard(
                        title: session['title'],
                        subtitle: session['subtitle'],
                        color: session['color'],
                      ),
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildDurationSelector() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black12)],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: durations.map((min) {
            final isSelected = selectedDuration == min;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: ChoiceChip(
                label: Text('$min min'),
                selected: isSelected,
                onSelected: (_) => setState(() => selectedDuration = min),
                selectedColor: Colors.orange,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
                backgroundColor: Colors.grey[200],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSessionCard({
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black12)],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 13, color: Colors.brown),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: startTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Start Session'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 22,
            backgroundColor: color,
            child: const Icon(Icons.play_arrow, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveSessionView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Session In Progress',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5C3A1C),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange.shade100,
              ),
              child: Text(
                formatTime(remainingSeconds),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                _timer?.cancel();
                setState(() => isSessionActive = false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('End Session'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 2,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.orange.shade300,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SchedulePage()),
          );
        } else if (index == 2) {
        } else if (index == 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProgressPage()),
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
}
