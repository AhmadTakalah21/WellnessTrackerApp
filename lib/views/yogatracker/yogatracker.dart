import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';


class YogaTrackerScreen extends StatelessWidget {
  const YogaTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Morning Workout"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.clock),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("06:30 AM", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildWorkoutItem("Jumping Jack"),
                  _buildWorkoutItem("Wall Sit"),
                  _buildWorkoutItem("Push Ups"),
                  _buildWorkoutItem("Abdominal Crunches"),
                  _buildWorkoutItem("Step Up Onto Chair"),
                  _buildWorkoutItem("Plank"),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CountdownScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Start", style: TextStyle(fontSize: 18)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutItem(String title) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500)),
        trailing: Switch(value: true, onChanged: (val) {}),
      ),
    );
  }
}

class CountdownScreen extends StatefulWidget {
  const CountdownScreen({super.key});

  @override
  State<CountdownScreen> createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  final CountDownController _controller = CountDownController();
  final int _duration = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Morning Workout"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularCountDownTimer(
            duration: _duration,
            initialDuration: 0,
            controller: _controller,
            width: 150,
            height: 150,
            ringColor: Colors.grey[300]!,
            fillColor: Colors.blue,
            backgroundColor: Colors.white,
            strokeWidth: 10.0,
            textStyle: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
            textFormat: CountdownTextFormat.S,
            isReverse: true,
            onComplete: () {},
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _controller.pause(),
                child: const Text("Pause"),
              ),
              ElevatedButton(
                onPressed: () => _controller.resume(),
                child: const Text("Resume"),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text("Next: Abdominal Crunches", style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
