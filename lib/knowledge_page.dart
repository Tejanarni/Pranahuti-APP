import 'package:flutter/material.dart';
import 'package:innerpeaceguide/guide_page.dart';
import 'main.dart';
import 'guided_sessions_page.dart';
import 'progress.dart';
import 'schedule_page.dart';

class KnowledgePage extends StatefulWidget {
  const KnowledgePage({super.key});

  @override
  State<KnowledgePage> createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {
  String selectedTab = "Teachings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6EE),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Column(
                  children: [
                    Text(
                      'Knowledge Hub',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5C3A1C),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Sacred wisdom from the Masters',
                      style: TextStyle(fontSize: 14, color: Colors.brown),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildTodaysThought(),
              const SizedBox(height: 20),
              _buildCategoryTabs(),
              const SizedBox(height: 20),
              ..._buildContentByTab(),
              const SizedBox(height: 20),
              _buildSearchBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTodaysThought() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3D9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          Icon(Icons.format_quote, color: Colors.orange, size: 32),
          SizedBox(height: 6),
          Text(
            "Today's Thought",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.brown,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "When the heart becomes the center of your being, the mind naturally follows. This is the beginning of true spiritual transformation.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.brown),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _categoryTab("Teachings"),
            const SizedBox(width: 10),
            _categoryTab("Practices"),
            const SizedBox(width: 10),
            _categoryTab("Commandments"),
            const SizedBox(width: 10),
            _categoryTab("Daily Inspiration", icon: Icons.format_quote),
          ],
        ),
      ),
    );
  }

  Widget _categoryTab(String title, {IconData? icon}) {
    final bool isSelected = title == selectedTab;
    return InkWell(
      onTap: () {
        setState(() {
          selectedTab = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange.shade200),
        ),
        child: Row(
          children: [
            if (icon != null)
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : Colors.orange,
              ),
            if (icon != null) const SizedBox(width: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                color: isSelected ? Colors.white : Colors.orange,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildContentByTab() {
    if (selectedTab == "Teachings") {
      return [
        _articleCard(
          "The Nature of Divine Love",
          "by Babuji Maharaj",
          "Divine love is not an emotion but a state of being. When we surrender completely, we merge with this eternal flow of love.",
        ),
      ];
    } else if (selectedTab == "Practices") {
      return [
        _articleCard(
          "Pranahuti Transmission",
          "by Lalaji Maharaj",
          "The divine current flows from the Master's heart to the seeker's heart, awakening the dormant spiritual faculties.",
        ),
        _articleCard(
          "Heart Cleaning Process",
          "by Practice Guide",
          "In the evening, sit in meditation and imagine that all complexities and impurities are leaving your system.",
        ),
      ];
    } else if (selectedTab == "Commandments") {
      return [
        _articleCard(
          "The Ten Commandments",
          "by Sahaj Marg",
          "Rise before dawn and offer your prayers and meditation. This sacred time connects us with the divine consciousness.",
        ),
      ];
    } else if (selectedTab == "Daily Inspiration") {
      return [
        _inspirationQuote(
          "“The heart that loves, serves without expectation.”",
          "Morning Reflection",
        ),
        _inspirationQuote(
          "“In surrender, we find the strength we never knew we had.”",
          "Evening Contemplation",
        ),
        _inspirationQuote(
          "“Every breath is a prayer when offered with devotion.”",
          "Meditation Insight",
        ),
      ];
    }
    return [];
  }

  Widget _articleCard(String title, String author, String excerpt) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDFB),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5C3A1C),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            author,
            style: const TextStyle(color: Colors.brown, fontSize: 13),
          ),
          const SizedBox(height: 12),
          Text(
            excerpt,
            style: const TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: Colors.brown,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Read full text',
                  style: TextStyle(color: Colors.deepOrange),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.menu_book,
                  color: Colors.deepOrange,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _inspirationQuote(String quote, String source) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFAE6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quote,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 14,
              color: Colors.brown,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '- $source',
            style: const TextStyle(color: Colors.brown, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
      ),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search teachings, practices, or insights...",
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.orange),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Search"),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 4,
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProgressPage()),
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
