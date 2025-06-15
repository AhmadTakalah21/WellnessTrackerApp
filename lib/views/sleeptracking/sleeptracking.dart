import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wellnesstrackerapp/views/sleeptracking/sleepanalytics.dart';

import '../../Widgets/custombtn.dart';

void main() {
  runApp(MaterialApp(
    home: SleepCalendarScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class SleepCalendarScreen extends StatelessWidget {
  const SleepCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text("Good Morning, Maya ☀️",
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
              const SizedBox(height: 10),
              SleepNotificationCard(),
              const SizedBox(height: 10),
              Text("Your Sleep Calendar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SleepCalendar(),
              const SizedBox(height: 17),
              SleepStatsCard("Bed Time", "7h 28m", FontAwesomeIcons.bed, Colors.purpleAccent),
              const SizedBox(height: 10),
              SleepStatsCard("Alarm", "16h 18m", FontAwesomeIcons.bell, Colors.orangeAccent),
              const SizedBox(height: 10),
              SleepStatsCard("Deep Sleep", "3h 45m", FontAwesomeIcons.moon, Colors.blueAccent),
              const SizedBox(height: 10),
              SleepStatsCard("REM", "1h 30m", FontAwesomeIcons.eye, Colors.teal),
              const SizedBox(height: 10),
              ConsultationCard()
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomButton(text: 'Next', onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>SleepAnalyticsScreen()));


        }),
      ),
    );

  }
}

class SleepNotificationCard extends StatelessWidget {
  const SleepNotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.purple, Colors.deepPurpleAccent]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.nightlight_round, color: Colors.white, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "You have slept 09:30 that is above your recommendation",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          Icon(Icons.close, color: Colors.white)
        ],
      ),
    );
  }
}

class SleepCalendar extends StatelessWidget {
  const SleepCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        return Column(
          children: [
            Text("${22 + index}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: index == 2 ? Colors.purpleAccent : Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Text(index == 2 ? '24' : 'T', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      }),
    );
  }
}

class SleepStatsCard extends StatelessWidget {
  final String title, value;
  final IconData icon;
  final Color color;

  const SleepStatsCard(this.title, this.value, this.icon, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withAlpha((0.1 * 255).toInt()),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(value, style: TextStyle(fontSize: 14, color: Colors.black54)),
                ],
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54)
        ],
      ),
    );
  }
}
class ConsultationCard extends StatelessWidget {
  const ConsultationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.indigo, Colors.blueAccent]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Have a problem Sleeping?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text("Consult an expert", style: TextStyle(color: Colors.blueAccent)),
                ),
              ],
            ),
          ),
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network("https://img.freepik.com/free-photo/female-doctor-hospital-with-stethoscope_23-2148827774.jpg", width: 80))
        ],
      ),
    );  }
}



