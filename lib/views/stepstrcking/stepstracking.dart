import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/views/stepstrcking/step2.dart';

class StepTrackerScreen extends StatelessWidget {
  const StepTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cs.onSurface,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text('points'.tr(), style: context.tt.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: buildStepCounter(context),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildStatsRow(),
                  const SizedBox(height: 20),
                  buildFriendsList(context),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: MainActionButton(
                padding: AppConstants.padding6,
                text: 'next'.tr(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DuelScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStepCounter(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 160,
              height: 160,
              child: CircularProgressIndicator(
                value: 0.5,
                strokeWidth: 12,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation(context.cs.primary),
              ),
            ),
            Column(
              children: [
                Text(
                  "2450",
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "نقطة",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildStatsRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          buildStatCard("1.9 km", FontAwesomeIcons.shoePrints, Colors.blue),
          buildStatCard("130 kcal", FontAwesomeIcons.fire, Colors.purple),
          buildStatCard(
            "3.2 km/h",
            FontAwesomeIcons.guaraniSign,
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget buildStatCard(String value, IconData icon, Color bgColor) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: bgColor.withAlpha((0.1 * 255).toInt()),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: bgColor,
            radius: 15,
            child: FaIcon(icon, color: Colors.white, size: 14),
          ),
          const SizedBox(width: 8),
          Text(value, style: GoogleFonts.poppins(fontSize: 14)),
        ],
      ),
    );
  }

  Widget buildFriendsList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "الأصدقاء",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "عرض الكل",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: context.cs.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        buildFriendItem(
          "Robert",
          "4085",
          "2.7 km",
          "190 kcal",
          "2.3 km/h",
          Colors.red,
        ),
        buildFriendItem(
          "Valery",
          "304",
          "0.3 km",
          "64 kcal",
          "0.5 km/h",
          Colors.purple,
        ),
        buildFriendItem(
          "Max",
          "10238",
          "8 km",
          "315 kcal",
          "5 km/h",
          Colors.blue,
        ),
        buildFriendItem(
          "Robert",
          "4085",
          "2.7 km",
          "190 kcal",
          "2.3 km/h",
          Colors.red,
        ),
        buildFriendItem(
          "Valery",
          "304",
          "0.3 km",
          "64 kcal",
          "0.5 km/h",
          Colors.purple,
        ),
        buildFriendItem(
          "Max",
          "10238",
          "8 km",
          "315 kcal",
          "5 km/h",
          Colors.blue,
        ),
        buildFriendItem(
          "Robert",
          "4085",
          "2.7 km",
          "190 kcal",
          "2.3 km/h",
          Colors.red,
        ),
        buildFriendItem(
          "Valery",
          "304",
          "0.3 km",
          "64 kcal",
          "0.5 km/h",
          Colors.purple,
        ),
        buildFriendItem(
          "Max",
          "10238",
          "8 km",
          "315 kcal",
          "5 km/h",
          Colors.blue,
        ),
        SizedBox(height: 80),
      ],
    );
  }

  Widget buildFriendItem(
    String name,
    String steps,
    String distance,
    String kcal,
    String speed,
    Color color,
  ) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withAlpha((0.1 * 255).toInt()),
          backgroundImage: NetworkImage(
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D',
          ),
        ),
        title: Text(
          name,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        subtitle: Row(
          children: [
            Text("$distance | ", style: GoogleFonts.poppins(fontSize: 12)),
            Text("$kcal | ", style: GoogleFonts.poppins(fontSize: 12)),
            Text(speed, style: GoogleFonts.poppins(fontSize: 12)),
          ],
        ),
        trailing: Text(
          steps,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
