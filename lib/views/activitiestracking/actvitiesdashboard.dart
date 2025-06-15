import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellnesstrackerapp/Widgets/custombtn.dart';
import 'actvity.dart';

class ActivitiesDashboard extends StatelessWidget {
  const ActivitiesDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(),
              const SizedBox(height: 20),
              buildCompetitionCard(),
              const SizedBox(height: 8),
              buildActivitySection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomButton(
          text: 'Next',
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => ActivityScreen()));
          },
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Morning!",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "3rd Aug, Wednesday",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Icon(Icons.notifications, color: Colors.black54),
      ],
    );
  }

  Widget buildCompetitionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            "Running Competition",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "02:58:59",
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Activity",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        buildActivityRow([
          buildActivityCard("1200", "kcal", FontAwesomeIcons.fire, Colors.red, Colors.red.shade100),
          buildActivityCard("867", "steps", FontAwesomeIcons.personWalking, Colors.blue, Colors.blue.shade100),
        ]),
        buildActivityRow([
          buildActivityCard("12", "km Cycling", FontAwesomeIcons.bicycle, Colors.green, Colors.green.shade100),
          buildActivityCard("3", "hours Workout", FontAwesomeIcons.dumbbell, Colors.orange, Colors.orange.shade100),
        ]),
        buildActivityRow([
          buildActivityCard("72 bpm", "Heart Rate", FontAwesomeIcons.heartPulse, Colors.red, Colors.red.shade100),
          buildActivityCard("98%", "Oxygen Level", FontAwesomeIcons.lungs, Colors.green, Colors.green.shade100),
        ]),
        buildActivityRow([
          buildActivityCard("8", "Hours Sleep", FontAwesomeIcons.bed, Colors.blueAccent, Colors.blueAccent.shade100),
          buildActivityCard("2L", "Water Intake", FontAwesomeIcons.droplet, Colors.lightBlue, Colors.lightBlue.shade100),
        ]),

      ],
    );
  }

  Widget buildActivityRow(List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children.map((widget) => Expanded(child: widget)).toList(),
    );
  }

  Widget buildActivityCard(String value, String label, IconData icon, Color iconColor, Color bgColor) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: FaIcon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
