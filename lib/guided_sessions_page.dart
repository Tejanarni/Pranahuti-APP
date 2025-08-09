import 'package:flutter/material.dart';
import 'dart:async';
import 'package:innerpeaceguide/schedule_page.dart';
import 'main.dart';
import 'progress.dart'; // Import ProgressPage
import 'knowledge_page.dart';
import 'guide_page.dart';
import 'bottom_nav_bar.dart'; // <-- IMPORT YOUR NEW FILE
import 'package:flutter_tts/flutter_tts.dart'; // Import the flutter_tts package

// Define an enum to represent the different phases of a session.
enum SessionPhase {
  none,
  trataka,
  tratakaOnly,
  instructions,
  meditation,
}

class GuidedSessions extends StatefulWidget {
  const GuidedSessions({super.key});

  @override
  State<GuidedSessions> createState() => _GuidedSessionsState();
}

class _GuidedSessionsState extends State<GuidedSessions> {
  // Set the default and only duration to 60 minutes for meditation.
  int selectedDuration = 60;
  // State variable to manage the current phase of the session.
  SessionPhase _currentPhase = SessionPhase.none;
  int remainingSeconds = 0;
  Timer? _timer;
  String _currentSessionTitle = '';
  final FlutterTts flutterTts = FlutterTts();

  // Define the current index for this page
  final int _currentIndex = 2; // Guided Sessions is at index 2

  // The list of durations now contains only a single 60-minute option.
  final List<int> durations = [60];

  final List<Map<String, dynamic>> sessions = [
    {
      'title': 'Trataka Meditation',
      'subtitle': 'Focusing on a central point for a calm mind',
      'color': Color(0xFFC0C0C0),
      'isTratakaOnly': true,
      'instructions': 'Sit in a comfortable position, with your spine erect. Gaze at the white dot on the screen without blinking. Gently quiet your mind, bringing your focus to the dot. If your mind wanders, gently bring it back. Continue this for the duration of the timer.'
    },
    {
      'title': 'Point B Meditation',
      'subtitle': 'Morning meditation focusing on Point B in the heart',
      'color': Color(0xFFFFD57E),
      'isTratakaOnly': false,
      'instructions': 'Imagine all your impurities and grossness to be going out from the point towards the front side and from behind it, the glow of the Atman is coming to view. Do this for not more than 10 minutes before commencing your daily practice of meditation.'
    },
    {
      'title': 'Heart Cleaning',
      'subtitle': 'Evening cleaning practice',
      'color': Color(0xFFCBC4F9),
      'isTratakaOnly': false,
      'instructions': 'Sit for half an hour with a suggestion to yourself that all complexities and impurities including grossness, darkness, etc., are going out of the whole system through the backside in the form of smoke or vapour and in its place the sacred current is flowing into your heart from the Master’s heart. Do not meditate on those things which we want to get rid off. Simply brush them off.'
    },
    {
      'title': '9 PM Universal Prayer',
      'subtitle': 'Prayer for the welfare of all beings',
      'color': Color(0xFFF4C2ED),
      'isTratakaOnly': false,
      'instructions': 'Everyone should meditate for about 15 minutes at 9 p.m. sharp every night regularly thinking that all the men and women in this world are one\'s brethren and true love, devotion and faith for the Master is developing in all.'
    },
    {
      'title': 'Point A Meditation',
      'subtitle': 'Night meditation on Point A',
      'color': Color(0xFFB7D6F7),
      'isTratakaOnly': false,
      'instructions': 'Fix your attention on the point and think that all men and women of the world are your brothers and sisters. Do this before going to bed for not more than 10 minutes.'
    },
  ];

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  void _initTts() {
    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing audio");
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Audio playback complete");
        startMeditation(); // Start meditation automatically after instructions
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("TTS Error: $msg");
      });
    });
  }

  Future<void> _speakInstructions(String instructions) async {
    await flutterTts.speak(instructions);
  }

  void startTrataka() {
    setState(() {
      _currentPhase = SessionPhase.trataka;
      remainingSeconds = 3 * 60; // 3 minutes for Trataka
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() => remainingSeconds--);
      } else {
        timer.cancel();
        startInstructions(); // Automatically transition to instructions.
      }
    });
  }

  void startTratakaOnly() {
    setState(() {
      _currentPhase = SessionPhase.tratakaOnly;
      remainingSeconds = 3 * 60; // 3 minutes for Trataka
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() => remainingSeconds--);
      } else {
        timer.cancel();
        endSession('Trataka Meditation'); // End the session after Trataka.
      }
    });
  }

  void startInstructions() {
    setState(() {
      _currentPhase = SessionPhase.instructions;
    });
    // Start playing audio instructions
    _speakInstructions(_getInstructionsForSession(_currentSessionTitle));
  }

  void skipInstructions() {
    flutterTts.stop();
    startMeditation();
  }

  void startMeditation() {
    setState(() {
      _currentPhase = SessionPhase.meditation;
      remainingSeconds = selectedDuration * 60; // 60 minutes for meditation
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() => remainingSeconds--);
      } else {
        timer.cancel();
        endSession(_currentSessionTitle); // Pass the correct session title.
      }
    });
  }

  void endSession(String sessionTitle) {
    _timer?.cancel();
    final sessionLog = SessionLog(
      sessionTitle: sessionTitle,
      date: DateTime.now(),
      durationMinutes: selectedDuration,
      mood: 0, // Placeholder
      reflection: '', // Placeholder
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

  String _getInstructionsForSession(String sessionTitle) {
    final session = sessions.firstWhere(
          (s) => s['title'] == sessionTitle,
      orElse: () => {'instructions': 'No specific instructions found.'},
    );
    return session['instructions'] as String;
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6EE),
      body: SafeArea(
        child: () {
          if (_currentPhase == SessionPhase.trataka || _currentPhase == SessionPhase.tratakaOnly) {
            return _buildTratakaView();
          } else if (_currentPhase == SessionPhase.instructions) {
            return _buildInstructionsView();
          } else if (_currentPhase == SessionPhase.meditation) {
            return _buildMeditationView();
          } else {
            return _buildSessionListView();
          }
        }(),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context, _currentIndex),
    );
  }

  Widget _buildSessionListView() {
    return SingleChildScrollView(
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
              isTratakaOnly: session['isTratakaOnly'] ?? false,
              onPressed: () {
                _currentSessionTitle = session['title'] as String;
                if (session['isTratakaOnly'] ?? false) {
                  startTratakaOnly();
                } else {
                  startTrataka();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTratakaView() {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          // White dot in the center of the screen
          Center(
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Heading at the top
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 24),
              child: Text(
                'Trataka (3 mins)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Timer and button at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    formatTime(remainingSeconds),
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Conditionally show 'Skip Trataka' or 'End Session'
                  _currentPhase == SessionPhase.tratakaOnly
                      ? ElevatedButton(
                    onPressed: () => endSession('Trataka Meditation'),
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
                  )
                      : ElevatedButton(
                    onPressed: startInstructions,
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
                    child: const Text('Skip Trataka'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionsView() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFFBF5), Color(0xFFFFF4DC)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            _currentSessionTitle,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5C3A1C),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                _getInstructionsForSession(_currentSessionTitle),
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.brown,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // A single button to skip the instructions and start meditation
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: skipInstructions,
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
                child: const Text('Skip Instructions'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMeditationView() {
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
              onPressed: () => endSession(_currentSessionTitle), // Fixed: Passing the correct session title
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
    required bool isTratakaOnly,
    required VoidCallback onPressed,
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
                  onPressed: onPressed,
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
}
