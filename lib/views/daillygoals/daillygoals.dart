import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';

import 'addgoals.dart';

class DailyGoalsScreen extends StatefulWidget {
  const DailyGoalsScreen({super.key});

  @override
  DailyGoalsScreenState createState() => DailyGoalsScreenState();
}

class DailyGoalsScreenState extends State<DailyGoalsScreen> {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cs.onSurface,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text('daily_goals'.tr(), style: context.tt.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Stack(
          children: [
            Column(
              children: [
                Card(
                  color: Colors.white,
                  child: TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _selectedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                      });
                    },
                    calendarStyle: CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        color: context.cs.primary,
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      todayDecoration: BoxDecoration(
                        color: context.cs.primary.withValues(alpha: 0.4),
                        shape: BoxShape.circle,
                      ),
                      todayTextStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(height: 10),
                      GoalCard(
                        "Morning Run",
                        "4.50 km",
                        "6:00 AM",
                        Icons.directions_run,
                      ),
                      SizedBox(height: 10),
                      GoalCard(
                        "Horse Riding",
                        "6.00 km",
                        "8:00 AM",
                        Icons.hiking,
                      ),
                      SizedBox(height: 10),
                      GoalCard(
                        "Meditation",
                        "4 Sessions",
                        "4:00 PM",
                        Icons.self_improvement,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: MainActionButton(
                padding: AppConstants.padding6,
                text: 'add_goals'.tr(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddGoalsScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoalCard extends StatelessWidget {
  final String title, distance, time;
  final IconData icon;

  const GoalCard(this.title, this.distance, this.time, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: context.cs.primary.withValues(alpha: 0.3),
            child: FaIcon(icon, color: context.cs.primary),
          ),
          title: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            "$distance | $time",
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
          ),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
