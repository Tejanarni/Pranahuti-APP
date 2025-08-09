import 'package:flutter/material.dart';
import 'package:innerpeaceguide/guide_page.dart';
import 'package:innerpeaceguide/knowledge_page.dart';
import 'main.dart';
import 'guided_sessions_page.dart';
import 'schedule_page.dart';
import 'bottom_nav_bar.dart';
import 'dart:math';

// Class to hold a complete session log
class SessionLog {
  final String sessionTitle;
  final DateTime date;
  final int durationMinutes;
  int mood;
  String reflection;

  SessionLog({
    required this.sessionTitle,
    required this.date,
    required this.durationMinutes,
    this.mood = 0,
    this.reflection = '',
  });
}

class ProgressPage extends StatefulWidget {
  final bool showFeedbackForm;
  final SessionLog? newSessionLog;

  ProgressPage({
    super.key,
    this.showFeedbackForm = false,
    this.newSessionLog,
  });

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  final int _currentIndex = 3;
  String _reflectionText = '';
  int _moodRating = 0;
  String _currentTab = 'Daily Log';
  DateTime _selectedDate = DateTime.now();

  // Data to hold all session logs
  final List<SessionLog> _allSessionLogs = [
    // Dummy data for the past few days
    SessionLog(sessionTitle: 'Point B Meditation', date: DateTime.now().subtract(const Duration(days: 4)), durationMinutes: 60, mood: 4, reflection: 'Felt very peaceful and focused.'),
    SessionLog(sessionTitle: 'Heart Cleaning', date: DateTime.now().subtract(const Duration(days: 3)), durationMinutes: 60, mood: 3, reflection: 'A bit distracted, but felt a sense of relief afterward.'),
    SessionLog(sessionTitle: 'Trataka Meditation', date: DateTime.now().subtract(const Duration(days: 2)), durationMinutes: 3, mood: 5, reflection: 'Incredibly focused. Felt a deep connection and inner stillness.'),
    SessionLog(sessionTitle: 'Heart Cleaning', date: DateTime.now().subtract(const Duration(days: 1)), durationMinutes: 60, mood: 4, reflection: 'Found it easy to let go of thoughts. A very satisfying session.'),
    SessionLog(sessionTitle: 'Point B Meditation', date: DateTime.now(), durationMinutes: 60, mood: 3, reflection: 'Felt a little restless today, but still completed the session.'),
  ];

  String _filterSessionType = 'All Sessions';
  String _filterTimeRange = 'Last 30 Days';

  @override
  void initState() {
    super.initState();
    if (widget.showFeedbackForm && widget.newSessionLog != null) {
      _allSessionLogs.add(widget.newSessionLog!);
      _selectedDate = widget.newSessionLog!.date;
    }
  }

  void _submitFeedback() {
    final today = DateTime.now();
    final SessionLog? lastSession = _allSessionLogs.firstWhere(
          (log) => log.date.day == today.day && log.date.month == today.month && log.date.year == today.year,
      orElse: () => _allSessionLogs.last, // Fallback
    );

    if (lastSession != null) {
      lastSession.mood = _moodRating;
      lastSession.reflection = _reflectionText;
    }

    setState(() {
      _reflectionText = '';
      _moodRating = 0;
      // Navigate away from the feedback form after submission
      _currentTab = 'Daily Log';
    });
  }

  List<SessionLog> get _filteredSessions {
    final now = DateTime.now();
    DateTime startDate = now.subtract(const Duration(days: 30));

    if (_filterTimeRange == 'Last 7 Days') {
      startDate = now.subtract(const Duration(days: 7));
    } else if (_filterTimeRange == 'Last 30 Days') {
      startDate = now.subtract(const Duration(days: 30));
    } else if (_filterTimeRange == 'All Time') {
      startDate = DateTime(2000); // A far past date
    }

    return _allSessionLogs.where((log) {
      bool inTimeRange = log.date.isAfter(startDate.subtract(const Duration(days: 1))) && log.date.isBefore(now.add(const Duration(days: 1)));
      bool matchesType = _filterSessionType == 'All Sessions' || log.sessionTitle == _filterSessionType;
      return inTimeRange && matchesType;
    }).toList();
  }

  Widget _buildFeedbackForm() {
    return Column(
      children: [
        Text(
          'How was your ${widget.newSessionLog!.sessionTitle}?',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5C3A1C),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        TextField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: "Share your thoughts and experiences...",
            hintStyle: const TextStyle(color: Colors.orange),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.orange),
            ),
          ),
          onChanged: (value) {
            _reflectionText = value;
          },
        ),
        const SizedBox(height: 16),
        const Text(
          'Rate your mood:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF5C3A1C),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < _moodRating ? Icons.favorite : Icons.favorite_border,
                color: Colors.redAccent,
              ),
              onPressed: () {
                setState(() {
                  _moodRating = index + 1;
                });
              },
            );
          }),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _submitFeedback,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text("Save Feedback"),
        ),
      ],
    );
  }

  Widget _buildCalendarView() {
    final today = DateTime.now();
    final currentMonth = DateTime(today.year, today.month, 1);
    final daysInMonth = DateTime(today.year, today.month + 1, 0).day;
    final firstDayOfWeek = currentMonth.weekday;

    final sessionsOnDate = _allSessionLogs.where((log) {
      final date = log.date;
      return date.year == _selectedDate.year && date.month == _selectedDate.month && date.day == _selectedDate.day;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Daily Log",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5C3A1C),
          ),
        ),
        const SizedBox(height: 16),
        // Calendar grid
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
          ),
          child: Column(
            children: [
              // Weekday headers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text('Mon', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Tue', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Wed', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Thu', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Fri', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Sat', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Sun', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  final day = index - firstDayOfWeek + 2;
                  final date = DateTime(today.year, today.month, day);
                  final sessionsOnDay = _allSessionLogs.where((log) =>
                  log.date.day == day && log.date.month == today.month && log.date.year == today.year
                  ).toList();
                  final hasSession = sessionsOnDay.isNotEmpty;

                  if (day <= 0 || day > daysInMonth) {
                    return Container(); // Empty container for days outside the current month
                  }

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: hasSession ? Colors.orange.shade100 : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                        border: date.day == _selectedDate.day && date.month == _selectedDate.month && date.year == _selectedDate.year
                            ? Border.all(color: Colors.deepOrange, width: 2)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          day.toString(),
                          style: TextStyle(
                            color: hasSession ? Colors.deepOrange : Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: daysInMonth + firstDayOfWeek -1,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "Reflections for ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        if (sessionsOnDate.isEmpty)
          const Text("No sessions recorded for this day.")
        else
          ...sessionsOnDate.map((log) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Session: ${log.sessionTitle}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Reflection: ${log.reflection}",
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 8),
                  Text("Mood: " + '😊' * log.mood),
                ],
              ),
            ),
          )),
      ],
    );
  }

  Widget _buildAnalyticsView() {
    final filteredSessions = _filteredSessions;

    // Aggregate data for charts
    final Map<String, double> sessionBreakdown = {};
    final List<double> moodData = [];
    final List<String> moodLabels = [];

    for (var session in filteredSessions) {
      sessionBreakdown.update(session.sessionTitle, (value) => value + 1, ifAbsent: () => 1);
      moodData.add(session.mood.toDouble());
    }

    // Calculate stats
    final totalSessions = filteredSessions.length;
    final avgMood = moodData.isNotEmpty ? (moodData.reduce((a, b) => a + b) / moodData.length).toStringAsFixed(1) : '0';
    final longestStreak = _calculateLongestStreak(filteredSessions);
    final sessionsThisWeek = filteredSessions.where((log) => log.date.isAfter(DateTime.now().subtract(const Duration(days: 7)))).length;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _filterSessionType,
                items: ['All Sessions', 'Point B Meditation', 'Heart Cleaning', '9 PM Universal Prayer', 'Point A Meditation', 'Trataka Meditation']
                    .map((String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(fontSize: 12)),
                ))
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _filterSessionType = newValue!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Session Type',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _filterTimeRange,
                items: ['Last 7 Days', 'Last 30 Days', 'All Time']
                    .map((String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(fontSize: 12)),
                ))
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _filterTimeRange = newValue!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Time Range',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildStatsRow(totalSessions, avgMood, longestStreak, sessionsThisWeek),
        const SizedBox(height: 24),
        _buildAnalyticsCard(
          title: "Session Breakdown",
          child: Column(
            children: [
              CustomPaint(
                size: const Size(double.infinity, 200),
                painter: PieChartPainter(
                  data: sessionBreakdown.cast<String, double>(),
                  colors: [Colors.orange.shade300, Colors.purple.shade300, Colors.blue.shade300, Colors.pink.shade300, Colors.green.shade300, Colors.grey.shade400],
                ),
              ),
              const SizedBox(height: 16),
              _buildPieChartLegend(sessionBreakdown),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildAnalyticsCard(
          title: "Mood Trend",
          child: CustomPaint(
            size: const Size(double.infinity, 200),
            painter: LineChartPainter(data: moodData),
          ),
        ),
        const SizedBox(height: 20),
        _buildQuoteCard(),
      ],
    );
  }

  Widget _buildPieChartLegend(Map<String, double> data) {
    List<Color> colors = [Colors.orange.shade300, Colors.purple.shade300, Colors.blue.shade300, Colors.pink.shade300, Colors.green.shade300, Colors.grey.shade400];
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: data.keys.map((key) {
        final index = data.keys.toList().indexOf(key);
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              color: colors[index % colors.length],
            ),
            const SizedBox(width: 4),
            Text(key, style: const TextStyle(fontSize: 12)),
          ],
        );
      }).toList(),
    );
  }

  int _calculateLongestStreak(List<SessionLog> sessions) {
    if (sessions.isEmpty) return 0;

    sessions.sort((a, b) => a.date.compareTo(b.date));
    int longestStreak = 0;
    int currentStreak = 0;

    for (int i = 0; i < sessions.length; i++) {
      if (i == 0) {
        currentStreak = 1;
      } else {
        final lastDate = DateTime(sessions[i-1].date.year, sessions[i-1].date.month, sessions[i-1].date.day);
        final currentDate = DateTime(sessions[i].date.year, sessions[i].date.month, sessions[i].date.day);
        final difference = currentDate.difference(lastDate).inDays;

        if (difference == 1) {
          currentStreak++;
        } else if (difference > 1) {
          currentStreak = 1;
        }
      }
      if (currentStreak > longestStreak) {
        longestStreak = currentStreak;
      }
    }
    return longestStreak;
  }

  Widget _buildStatsRow(int totalSessions, String avgMood, int longestStreak, int sessionsThisWeek) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: 12,
      runSpacing: 12,
      children: [
        _StatCard(
          label: 'Day Streak',
          value: longestStreak.toString(),
          icon: Icons.flash_on,
          color: const Color(0xFFFFE5A1),
        ),
        _StatCard(
          label: 'Total Sessions',
          value: totalSessions.toString(),
          icon: Icons.favorite,
          color: const Color(0xFFE9D7FF),
        ),
        _StatCard(
          label: 'This Week',
          value: sessionsThisWeek.toString(),
          icon: Icons.calendar_month,
          color: const Color(0xFFFED6F3),
        ),
        _StatCard(
          label: 'Avg. Mood',
          value: avgMood,
          icon: Icons.timer,
          color: const Color(0xFFD6EFFF),
        ),
      ],
    );
  }

  Widget _buildAnalyticsCard({required String title, required Widget child}) {
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
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          child,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6EE),
      bottomNavigationBar: buildBottomNavigationBar(context, _currentIndex),
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
              // Tab bar for switching between views
              _buildTabBar(),
              const SizedBox(height: 24),
              if (_currentTab == 'Daily Log')
                if (widget.showFeedbackForm) _buildFeedbackForm() else _buildCalendarView()
              else
                _buildAnalyticsView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTabButton('Daily Log'),
        _buildTabButton('Analytics'),
      ],
    );
  }

  Widget _buildTabButton(String title) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _currentTab = title;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _currentTab == title ? Colors.orange : Colors.white,
        foregroundColor: _currentTab == title ? Colors.white : Colors.orange,
        side: const BorderSide(color: Colors.orange),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(title),
    );
  }
}

// --- Helper widget for stats cards ---
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

// --- Custom Painter for Pie Chart ---
class PieChartPainter extends CustomPainter {
  final Map<String, double> data;
  final List<Color> colors;

  PieChartPainter({required this.data, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.height / 2);
    double startAngle = -0.5 * 3.14159; // Start at the top
    final total = data.values.fold(0.0, (sum, item) => sum + item);

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (var i = 0; i < data.keys.length; i++) {
      final sweepAngle = (data.values.elementAt(i) / total) * 2 * 3.14159;
      final paint = Paint()..color = colors[i];
      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);

      // Draw labels
      final angle = startAngle + sweepAngle / 2;
      final x = size.width / 2 + (size.height / 2.5) * cos(angle);
      final y = size.height / 2 + (size.height / 2.5) * sin(angle);
      textPainter.text = TextSpan(
        text: '${data.keys.elementAt(i)}',
        style: const TextStyle(color: Colors.brown, fontSize: 12),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
// --- Custom Painter for Line Chart ---
class LineChartPainter extends CustomPainter {
  final List<double> data;

  LineChartPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepOrange
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final pointPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    final yMax = 5.0; // Mood is on a scale of 1-5
    final yMin = 1.0;
    final xStep = size.width / (data.length - 1);

    if (data.isNotEmpty) {
      // Scale points to the canvas size
      final yScale = size.height / (yMax - yMin);
      final yOffset = size.height;

      // Draw the line
      path.moveTo(0, yOffset - (data[0] - yMin) * yScale);
      for (var i = 1; i < data.length; i++) {
        final x = i * xStep;
        final y = yOffset - (data[i] - yMin) * yScale;
        path.lineTo(x, y);
      }
      canvas.drawPath(path, paint);

      // Draw the points
      for (var i = 0; i < data.length; i++) {
        final x = i * xStep;
        final y = yOffset - (data[i] - yMin) * yScale;
        canvas.drawCircle(Offset(x, y), 5, pointPaint);
        canvas.drawCircle(Offset(x, y), 3, paint..style = PaintingStyle.fill);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
