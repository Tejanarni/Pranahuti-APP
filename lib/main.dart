import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'guide_page.dart';
import 'knowledge_page.dart';
import 'progress.dart';
import 'schedule_page.dart';
import 'guided_sessions_page.dart';
import 'bottom_nav_bar.dart';

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

  final int _currentIndex = 0;

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

  // ✅ Updated fetch function for “Today’s Inspiration”
  Future<String> fetchDailyMessage() async {
    try {
      final response = await http.get(
        Uri.parse('https://sriramchandra.in/daily_messages.php'),
      );

      if (response.statusCode == 200) {
        final html = response.body;

        // ✅ Extract message inside <p style="font-size:22px; color:#C00; ">
        final match = RegExp(
          r'<p[^>]*style="font-size:22px; color:#C00; ?"[^>]*>(.*?)</p>',
          dotAll: true,
        ).firstMatch(html);

        if (match != null) {
          final rawText = match.group(1)!;
          final cleaned = rawText
              .replaceAll(RegExp(r'<[^>]*>'), '') // remove HTML tags
              .replaceAll('&nbsp;', ' ')
              .trim();
          return cleaned;
        } else {
          return "Stay centered in the heart. Peace will follow naturally.";
        }
      } else {
        return "Failed to fetch message. Try again later.";
      }
    } catch (e) {
      return "Error fetching today's inspiration.";
    }
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
                // ---------- HEADER ----------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://sriramchandra.in/assets/img/finallogo.gif',
                      height: 48,
                      width: 48,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "Pranahuti",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7A4E00),
                      ),
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
                    final cardWidth =
                    isSmallScreen ? screenWidth : (screenWidth / 2) - 24;
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
      bottomNavigationBar: buildBottomNavigationBar(context, _currentIndex),
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

  // ✅ Dynamic “Today’s Inspiration” card
  Widget _buildInspirationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Inspiration",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF7A4E00),
            ),
          ),
          const SizedBox(height: 16),
          FutureBuilder<String>(
            future: fetchDailyMessage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.orange),
                );
              } else if (snapshot.hasError) {
                return const Text(
                  "Error loading inspiration.",
                  style: TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFFAD5B00),
                  ),
                );
              } else {
                return Text(
                  '"${snapshot.data}"',
                  style: const TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFFAD5B00),
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 8),
          const Text(
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
}

