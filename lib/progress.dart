import 'package:flutter/material.dart';
import 'package:innerpeaceguide/guide_page.dart';
import 'package:innerpeaceguide/knowledge_page.dart';
import 'main.dart';
import 'guided_sessions_page.dart';
import 'schedule_page.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6EE),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Column(
                  children: [
                    Text(
                      'Your Journey',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5C3A1C),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Gentle progress tracking with love and humility',
                      style: TextStyle(fontSize: 14, color: Colors.brown),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildStatsRow(),
              const SizedBox(height: 24),
              _buildWeeklyPractice(),
              const SizedBox(height: 24),
              _buildReflectionBox(),
              const SizedBox(height: 20),
              _buildQuoteCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: 12,
      runSpacing: 12,
      children: const [
        _StatCard(
          label: 'Day Streak',
          value: '12',
          icon: Icons.flash_on,
          color: Color(0xFFFFE5A1),
        ),
        _StatCard(
          label: 'Total Sessions',
          value: '156',
          icon: Icons.favorite,
          color: Color(0xFFE9D7FF),
        ),
        _StatCard(
          label: 'This Week',
          value: '10/14',
          icon: Icons.calendar_month,
          color: Color(0xFFFED6F3),
        ),
        _StatCard(
          label: 'Avg. Session',
          value: '25m',
          icon: Icons.timer,
          color: Color(0xFFD6EFFF),
        ),
      ],
    );
  }

  Widget _buildWeeklyPractice() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final practiceLevels = [3, 2, 4, 3, 1, 2, 0];
    final moodLevels = [4, 3, 5, 2, 4, 3, 1];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(7, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Text(
                    days[index],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: List.generate(4, (i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.5),
                      child: Icon(
                        Icons.circle,
                        size: 10,
                        color: i < practiceLevels[index]
                            ? Colors.orange
                            : Colors.grey.shade300,
                      ),
                    );
                  }),
                ),
                const Spacer(),
                const Text("Mood: "),
                Row(
                  children: List.generate(5, (i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: Icon(
                        Icons.circle,
                        size: 8,
                        color: i < moodLevels[index]
                            ? Colors.purple
                            : Colors.grey.shade300,
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildReflectionBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Reflection",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText:
                  "How did your practice feel today? Any insights or experiences to note...",
              hintStyle: const TextStyle(color: Colors.orange),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.orange),
              ),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              // Save reflection action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Save Reflection"),
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3D9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        children: [
          Text(
            '"Progress is not measured by distance traveled, but by the depth of surrender in each moment."',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 13,
              color: Colors.brown,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6),
          Text(
            'Remember: Every session is a gift to yourself and the divine',
            style: TextStyle(fontSize: 13, color: Colors.brown),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 3,
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const GuidedSessions()),
          );
        } else if (index == 3) {
          // already here
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

// --- Helper widget ---
class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 78,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: Colors.brown),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF5C3A1C),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: Colors.brown),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
