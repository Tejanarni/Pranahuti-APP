import 'package:flutter/material.dart';
import 'package:innerpeaceguide/guide_page.dart';
import 'knowledge_page.dart';
import 'progress.dart';
import 'schedule_page.dart';
import 'guided_sessions_page.dart';

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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final Color backgroundTop = const Color(0xFFFFFBF5);
  final Color backgroundBottom = const Color(0xFFFFF4DC);
  final Color orangeAccent = const Color(0xFFFF8C00);
  final Color cardText = const Color(0xFF7A4E00);
  final Color timeChipColor = const Color(0xFFF6F3DC);

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 1.0,
      end: 1.4,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundTop,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFFBF5), Color(0xFFFFF4DC)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 36),
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
                ScaleTransition(
                  scale: _animation,
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 32),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final screenWidth = constraints.maxWidth;
                    final isSmallScreen = screenWidth < 600;
                    final cardWidth = isSmallScreen
                        ? screenWidth
                        : (screenWidth / 2) - 24;

                    return Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        SizedBox(width: cardWidth, child: _buildPracticeCard()),
                        SizedBox(
                          width: cardWidth,
                          child: _buildInspirationCard(),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
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
            style: const TextStyle(fontSize: 12, color: Colors.brown),
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
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SchedulePage()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => GuidedSessions()),
          );
        } else if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProgressPage()),
          );
        } else if (index == 4) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => KnowledgePage()),
          );
        } else if (index == 5) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => GuidePage()),
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
