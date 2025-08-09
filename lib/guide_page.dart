import 'package:flutter/material.dart';
// Import your target pages for navigation
import 'main.dart';
import 'schedule_page.dart';
import 'progress.dart';
import 'knowledge_page.dart';
import 'guided_sessions_page.dart';
import 'bottom_nav_bar.dart'; // <-- IMPORT YOUR NEW FILE

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  // Define the current index for this page
  final int _currentIndex = 5; // Guide is at index 5

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6E9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF6E9),
        elevation: 0,
        title: Column(
          children: const [
            Text(
              'Divine Friend',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFFB85C00),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'AI guidance for your spiritual journey',
              style: TextStyle(fontSize: 13, color: Color(0xFFA66B1F)),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Chat Bubble
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3DC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFFE0B3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.person_rounded, color: Color(0xFFFF9800)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Namaste, dear soul. I am your Divine Friend, here to guide you on your spiritual journey.\nHow may I assist your practice today?',
                        style: TextStyle(
                          color: Color(0xFF6B3F00),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Input Box
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                            'Ask about your practice, seek guidance, or share your experience...',
                            hintStyle: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Color(0xFFFF9800),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Quick Guidance Header
              Row(
                children: const [
                  Icon(
                    Icons.flash_on_rounded,
                    color: Color(0xFFFF9800),
                    size: 20,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Quick Guidance',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Color(0xFF4B2E00),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Quick Guidance Tiles
              const GuidanceTile(
                text:
                "I'm feeling distracted during meditation. What should I do?",
              ),
              const GuidanceTile(text: "Explain today’s 9 PM prayer meaning"),
              const GuidanceTile(
                text: "How can I deepen my heart cleaning practice?",
              ),
              const GuidanceTile(
                text: "I missed my morning meditation. How to catch up?",
              ),
              const GuidanceTile(
                text: "Share a Master’s thought on handling anger",
              ),

              // Quote Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(top: 16, bottom: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0D4),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.lightbulb_outline_rounded,
                      color: Color(0xFFE68A00),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '“The AI assistant provides guidance based on Sahaj Marg principles, but remember - your heart and the Master’s grace are your truest guides.”',
                        style: TextStyle(
                          fontSize: 13.5,
                          color: Color(0xFF6B3F00),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context, _currentIndex),
    );
  }
}

class GuidanceTile extends StatelessWidget {
  final String text;

  const GuidanceTile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFAF2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFE0B3)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14.5, color: Color(0xFF4B2E00)),
      ),
    );
  }
}
