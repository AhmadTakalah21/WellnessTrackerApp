import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

class StressManagement extends StatelessWidget {
  final List<Map<String, dynamic>> relaxationTechniques = [
    {"title": "Deep Breathing", "icon": Icons.spa, "color": Colors.blue},
    {"title": "Guided Meditation", "icon": Icons.self_improvement, "color": Colors.purple},
    {"title": "Nature Sounds", "icon": Icons.nature, "color": Colors.green},
    {"title": "Progressive Muscle Relaxation", "icon": Icons.fitness_center, "color": Colors.orange},
    {"title": "Mindful Walking", "icon": Icons.directions_walk, "color": Colors.teal},
  ];

  final List<Map<String, dynamic>> anxietyTracking = [
    {"title": "Daily Mood Tracker", "icon": Icons.insert_chart, "color": Colors.red},
    {"title": "Anxiety Level Graph", "icon": Icons.bar_chart, "color": Colors.indigo},
    {"title": "Mindfulness Reminders", "icon": Icons.notifications_active, "color": Colors.amber},
    {"title": "Journaling", "icon": Icons.book, "color": Colors.cyan},
    {"title": "Sleep Tracking", "icon": Icons.nightlight_round, "color": Colors.deepPurple},
  ];

   StressManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stress & Anxiety Management", style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("Relaxation Techniques & Sound Therapy"),
            listItems(relaxationTechniques, context),
            SizedBox(height: 20),
            sectionTitle("Anxiety Self-Assessment & Tracking"),
            listItems(anxietyTracking, context),
            SizedBox(height: 20),
            sectionTitle("Your Anxiety Level"),
            Center(
              child: CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 15.0,
                animation: true,
                percent: 0.4,
                center: Text(
                  "40%",
                  style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.redAccent),
                ),
                progressColor: Colors.redAccent,
                backgroundColor: Colors.grey[300]!,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AssessmentScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              child: Center(
                child: Text("Take a Self-Assessment", style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  Widget listItems(List<Map<String, dynamic>> items, BuildContext context) {
    return Column(
      children: items.map((item) {
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: item['color'].withOpacity(0.2),
              child: Icon(item['icon'], color: item['color']),
            ),
            title: Text(item['title'], style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600)),
            trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
          ),
        );
      }).toList(),
    );
  }
}

class AssessmentScreen extends StatelessWidget {
  const AssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Self-Assessment", style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("How often do you feel anxious?", style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ...["Rarely", "Sometimes", "Often", "Always"].map((option) => ListTile(
              title: Text(option, style: GoogleFonts.lato(fontSize: 16)),
              leading: Radio(value: option, groupValue: null, onChanged: (val) {}),
            )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              child: Center(
                child: Text("Submit", style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
