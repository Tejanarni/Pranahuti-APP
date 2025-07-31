import 'package:flutter/material.dart';
import 'schedule_page.dart';

void main() {
  runApp(PranahutiApp());
}

class PranahutiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pranahuti',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final Color backgroundTop = const Color(0xFFFFFBF5);
  final Color backgroundBottom = const Color(0xFFFFF4DC);
  final Color orangeAccent = const Color(0xFFFF8C00);
  final Color cardText = Color(0xFF7A4E00);
  final Color timeChipColor = Color(0xFFF6F3DC);

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
        padding: const EdgeInsets.only(
          top: 60,
          left: 24,
          right: 24,
          bottom: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo and title
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
            const SizedBox(height: 40),
            const Text(
              "Welcome to Your Spiritual Journey",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              '"The heart is the hub of all sacred places. Go there and roam in it."',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.brown,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Icon(Icons.favorite, color: Colors.redAccent, size: 32),
            const SizedBox(height: 32),

            // Practice and Inspiration cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: _buildPracticeCard()),
                const SizedBox(width: 16),
                Expanded(child: _buildInspirationCard()),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildPracticeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Practice",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: cardText,
            ),
          ),
          const SizedBox(height: 16),
          _buildPracticeRow("Morning Meditation", "6:00 AM"),
          const SizedBox(height: 8),
          _buildPracticeRow("Evening Cleaning", "7:00 PM"),
          const SizedBox(height: 8),
          _buildPracticeRow("9 PM Prayer", "9:00 PM"),
        ],
      ),
    );
  }

  Widget _buildPracticeRow(String title, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(color: cardText)),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          decoration: BoxDecoration(
            color: timeChipColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            time,
            style: TextStyle(fontSize: 12, color: Colors.brown),
          ),
        ),
      ],
    );
  }

  Widget _buildInspirationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Today's Inspiration",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF7A4E00),
            ),
          ),
          SizedBox(height: 16),
          Text(
            '"Surrender is the only prayer. When you surrender, you become one with the Divine flow."',
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: Color(0xFFAD5B00),
            ),
          ),
          SizedBox(height: 8),
          Text(
            "- Master's Teaching",
            style: TextStyle(fontSize: 13, color: Color(0xFFAD5B00)),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.shade100,
          blurRadius: 8,
          offset: Offset(0, 4),
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
        if (index == 1) {
          // Schedule tab clicked
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SchedulePage()),
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
