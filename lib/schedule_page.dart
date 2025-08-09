import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';
import 'progress.dart'; // Import ProgressPage and SessionLog

// Convert SchedulePage to a StatefulWidget to manage the state of the switches.
class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final Color backgroundTop = const Color(0xFFFFFBF5);
  final Color backgroundBottom = const Color(0xFFFFF4DC);
  final Color cardColor = Colors.white;
  final Color labelColor = const Color(0xFF7A4E00);
  final Color orangeAccent = const Color(0xFFFF8C00);

  // State variables for the switches
  bool _morningMeditationEnabled = true;
  bool _eveningCleaningEnabled = true;
  bool _ninePmPrayerEnabled = true;
  bool _nightMeditationEnabled = true;

  bool _gentleTonesEnabled = true;
  bool _vibrationRemindersEnabled = true;
  bool _silentModeEnabled = false;

  // State variables for practice times
  TimeOfDay _morningMeditationTime = const TimeOfDay(hour: 6, minute: 0);
  TimeOfDay _eveningCleaningTime = const TimeOfDay(hour: 19, minute: 0);
  TimeOfDay _ninePmPrayerTime = const TimeOfDay(hour: 21, minute: 0);
  TimeOfDay _nightMeditationTime = const TimeOfDay(hour: 22, minute: 30);

  // Define the current index for this page
  final int _currentIndex = 1; // Schedule is at index 1

  // Helper to format TimeOfDay to a string
  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return MaterialLocalizations.of(context).formatTimeOfDay(time, alwaysUse24HourFormat: true);
  }

  // Generic function to show the time picker and update state
  Future<void> _selectTime(BuildContext context, ValueChanged<TimeOfDay> onTimeSelected) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: orangeAccent, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: labelColor, // Clock dial text color
            ),
          ),
          child: child!,
        );
      },
    );
    if (newTime != null) {
      onTimeSelected(newTime);
    }
  }

  // Function to handle "Mark as Done" button press
  void _markAsDone(String sessionTitle) {
    final sessionLog = SessionLog(
      sessionTitle: sessionTitle,
      date: DateTime.now(),
      durationMinutes: 0, // Duration is unknown for manual completion
      mood: 0,
      reflection: '',
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProgressPage(
          showFeedbackForm: true,
          newSessionLog: sessionLog,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundTop,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFFBF5), Color(0xFFFFF4DC)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFFFFB52E), Color(0xFFFF9900)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Pranahuti",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF7A4E00),
                          ),
                        ),
                        Text(
                          "Divine Practice Companion",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFE67300),
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

                // Reminder cards with working switches and time picker
                _buildReminderCard(
                  icon: Icons.wb_sunny_outlined,
                  iconColor: Colors.orange.shade300,
                  title: 'Morning Meditation',
                  subtitle: 'Point B Meditation before sunrise',
                  time: _morningMeditationTime,
                  value: _morningMeditationEnabled,
                  onTimeSelected: (newTime) {
                    setState(() {
                      _morningMeditationTime = newTime;
                    });
                  },
                  onChanged: (bool value) {
                    setState(() {
                      _morningMeditationEnabled = value;
                    });
                  },
                ),
                _buildReminderCard(
                  icon: Icons.nights_stay,
                  iconColor: Colors.purple.shade200,
                  title: 'Evening Cleaning',
                  subtitle: 'Heart cleaning after sunset',
                  time: _eveningCleaningTime,
                  value: _eveningCleaningEnabled,
                  onTimeSelected: (newTime) {
                    setState(() {
                      _eveningCleaningTime = newTime;
                    });
                  },
                  onChanged: (bool value) {
                    setState(() {
                      _eveningCleaningEnabled = value;
                    });
                  },
                ),
                _buildReminderCard(
                  icon: Icons.brightness_3_outlined,
                  iconColor: Colors.pink.shade200,
                  title: '9 PM Prayer',
                  subtitle: 'Universal prayer for all',
                  time: _ninePmPrayerTime,
                  value: _ninePmPrayerEnabled,
                  onTimeSelected: (newTime) {
                    setState(() {
                      _ninePmPrayerTime = newTime;
                    });
                  },
                  onChanged: (bool value) {
                    setState(() {
                      _ninePmPrayerEnabled = value;
                    });
                  },
                ),
                _buildReminderCard(
                  icon: Icons.bedtime,
                  iconColor: Colors.blue.shade200,
                  title: 'Night Meditation',
                  subtitle: 'Point A Meditation before sleep',
                  time: _nightMeditationTime,
                  value: _nightMeditationEnabled,
                  onTimeSelected: (newTime) {
                    setState(() {
                      _nightMeditationTime = newTime;
                    });
                  },
                  onChanged: (bool value) {
                    setState(() {
                      _nightMeditationEnabled = value;
                    });
                  },
                ),

                const SizedBox(height: 16),

                // Notification Settings with working switches
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
                      _buildNotificationSetting(
                        "Gentle notification tones",
                        _gentleTonesEnabled,
                            (bool value) {
                          setState(() {
                            _gentleTonesEnabled = value;
                          });
                        },
                      ),
                      _buildNotificationSetting(
                        "Vibration reminders",
                        _vibrationRemindersEnabled,
                            (bool value) {
                          setState(() {
                            _vibrationRemindersEnabled = value;
                          });
                        },
                      ),
                      _buildNotificationSetting(
                        "Silent mode (weekends)",
                        _silentModeEnabled,
                            (bool value) {
                          setState(() {
                            _silentModeEnabled = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context, _currentIndex),
    );
  }

  Widget _buildReminderCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required TimeOfDay time,
    required bool value,
    required ValueChanged<TimeOfDay> onTimeSelected,
    required ValueChanged<bool> onChanged,
  }) {
    return GestureDetector(
      onTap: () => _selectTime(context, onTimeSelected),
      child: Container(
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
                Switch(value: value, onChanged: onChanged),
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
                        _formatTime(time),
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
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => _markAsDone(title),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    textStyle: const TextStyle(fontSize: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Mark as Done'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSetting(String text, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: const TextStyle(fontSize: 13)),
        Switch(value: value, onChanged: onChanged),
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
}
