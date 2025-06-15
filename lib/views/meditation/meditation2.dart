import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class Meditation2Screen extends StatelessWidget {
  const Meditation2Screen({super.key});

  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(12),
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, color: color, size: 28),
            SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
            SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 14, color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meditation Progress",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 17),),

        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Weekly Progress", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard("22", "Completed", FontAwesomeIcons.circleCheck, Colors.green),
                  _buildStatCard("8", "In Progress", FontAwesomeIcons.hourglassHalf, Colors.orange),
                  _buildStatCard("3", "Ongoing", FontAwesomeIcons.spinner, Colors.blue),
                  _buildStatCard("10", "Next Week", FontAwesomeIcons.calendar, Colors.purple),
                  _buildStatCard("5", "Paused", FontAwesomeIcons.pause, Colors.red),
                  _buildStatCard("12", "Planned", FontAwesomeIcons.listCheck, Colors.teal),
                  _buildStatCard("7", "Missed", FontAwesomeIcons.circleXmark, Colors.brown),
                  _buildStatCard("15", "Streak", FontAwesomeIcons.fire, Colors.amber),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text("Ongoing Sessions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView(
                children: [
                  _buildSessionCard("Mindfulness Meditation", "Instructor: Jee Soriano", "9:00 AM - 10:00 AM"),
                  _buildSessionCard("Breath Awareness", "Instructor: Jee Soriano", "10:00 AM - 11:00 AM"),
                  _buildSessionCard("Zen Meditation", "Instructor: Jee Soriano", "1:00 PM - 2:30 PM"), _buildSessionCard("Mindfulness Meditation", "Instructor: Jee Soriano", "9:00 AM - 10:00 AM"),
                  _buildSessionCard("Breath Awareness", "Instructor: Jee Soriano", "10:00 AM - 11:00 AM"),
                  _buildSessionCard("Zen Meditation", "Instructor: Jee Soriano", "1:00 PM - 2:30 PM"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionCard(String title, String instructor, String time) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.deepPurple,
          child: FaIcon(FontAwesomeIcons.seedling, color: Colors.white),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("$instructor \n$time"),
        isThreeLine: true,
      ),
    );
  }
}
