import 'package:flutter/material.dart';
import 'main.dart'; // Make sure this import works by correct path if needed

class SchedulePage extends StatelessWidget {
  final Color backgroundTop = const Color(0xFFFFFBF5);
  final Color backgroundBottom = const Color(0xFFFFF4DC);
  final Color cardColor = Colors.white;
  final Color labelColor = Color(0xFF7A4E00);
  final Color orangeAccent = Color(0xFFFF8C00);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundTop,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFFBF5), Color(0xFFFFF4DC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: ListView(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(radius: 12, backgroundColor: orangeAccent),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Pranahuti",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Divine Practice Companion",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),

            const Text(
              "Daily Practice Schedule",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            const Text(
              "Set gentle reminders for your spiritual practices",
              style: TextStyle(color: Colors.deepOrange, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            _buildReminderCard(
              icon: Icons.wb_sunny_outlined,
              iconColor: Colors.orange.shade300,
              title: 'Morning Meditation',
              subtitle: 'Point B Meditation before sunrise',
              time: '06:00',
            ),
            _buildReminderCard(
              icon: Icons.nights_stay,
              iconColor: Colors.purple.shade200,
              title: 'Evening Cleaning',
              subtitle: 'Heart cleaning after sunset',
              time: '19:00',
            ),
            _buildReminderCard(
              icon: Icons.brightness_3_outlined,
              iconColor: Colors.pink.shade200,
              title: '9 PM Prayer',
              subtitle: 'Universal prayer for all',
              time: '21:00',
            ),
            _buildReminderCard(
              icon: Icons.bedtime,
              iconColor: Colors.blue.shade200,
              title: 'Night Meditation',
              subtitle: 'Point A Meditation before sleep',
              time: '22:30',
            ),

            const SizedBox(height: 16),

            // Notification Settings
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _cardDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Notification Settings",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: labelColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildNotificationSetting("Gentle notification tones", true),
                  _buildNotificationSetting("Vibration reminders", true),
                  _buildNotificationSetting("Silent mode (weekends)", false),
                ],
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildReminderCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: _cardDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: iconColor.withOpacity(0.2),
                child: Icon(icon, color: iconColor),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 11, color: Colors.brown),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(
                        Icons.notifications_none,
                        size: 14,
                        color: Colors.orange,
                      ),
                      SizedBox(width: 4),
                      Text("Reminder time:", style: TextStyle(fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Switch(value: true, onChanged: (_) {}),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F3DC),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text(
                      time,
                      style: const TextStyle(fontSize: 12, color: Colors.brown),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: Colors.brown,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSetting(String text, bool value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: const TextStyle(fontSize: 13)),
        Switch(value: value, onChanged: (_) {}),
      ],
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.shade100,
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.orange.shade300,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == 0) {
          // Go back to Home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else if (index == 1) {
          // Already on SchedulePage, do nothing or refresh
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
