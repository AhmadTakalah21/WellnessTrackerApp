import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';

import 'currenthyderation.dart';



class Hyderation1 extends StatelessWidget {
  final double dailyGoal = 3000; // ml
  final double currentIntake = 1750;

  const Hyderation1({super.key}); // ml

  @override
  Widget build(BuildContext context) {
    double progress = currentIntake / dailyGoal;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Water Balance",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Daily Goal Progress Indicator
            Center(
              child: CircularPercentIndicator(
                radius: 80,
                lineWidth: 12,
                percent: progress > 1 ? 1 : progress,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${(progress * 100).toInt()}%", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("of Daily Goal", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                progressColor: Colors.blue,
                backgroundColor: Colors.grey[300]!,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),

            SizedBox(height: 20),

            // Tabs for time selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTab("Last 30 days", false),
                _buildTab("Last 14 days", false),
                _buildTab("Last 7 days", true),
              ],
            ),

            SizedBox(height: 20),

            // Water Intake Bar Chart
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              height: 180,
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          List<String> days = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
                          return Text(days[value.toInt()], style: GoogleFonts.poppins(fontSize: 12));
                        },
                        reservedSize: 30,
                      ),
                    ),
                  ),
                  barGroups: [
                    _buildBar(0, 3),
                    _buildBar(1, 5),
                    _buildBar(2, 6),
                    _buildBar(3, 4),
                    _buildBar(4, 10, isHighlighted: true), // Highlighted for 100%
                    _buildBar(5, 5),
                    _buildBar(6, 4),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Drink History List
            _buildDrinkItem(FontAwesomeIcons.droplet, "Water", "500ml", "8:15 AM", Colors.blue),
            _buildDrinkItem(FontAwesomeIcons.mugSaucer, "Tea", "150ml", "9:45 AM", Colors.brown),
            _buildDrinkItem(FontAwesomeIcons.whiskeyGlass, "Juice", "250ml", "12:30 PM", Colors.orange),
            _buildDrinkItem(FontAwesomeIcons.mugHot, "Coffee", "200ml", "2:00 PM", Colors.black),
            _buildDrinkItem(FontAwesomeIcons.blender, "Smoothie", "300ml", "4:00 PM", Colors.purple),
            _buildDrinkItem(FontAwesomeIcons.wineBottle, "Soft Drink", "250ml", "6:30 PM", Colors.red),

            SizedBox(height: 20),

            // Add More Drinks Button


            SizedBox(height: 20),

            // Hydration Tip Box
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.lightBlue[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.lightbulb, color: Colors.blue),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Tip: Drink water 30 minutes before meals for better digestion!",
                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonColor,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {


            Navigator.push(context, MaterialPageRoute(builder: (_)=>CurrentHydrationScreen()));

          },
          child: Text("Add more drinks", style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
        ),
      ),
    );
  }

  // Bar Chart Builder
  BarChartGroupData _buildBar(int x, double value, {bool isHighlighted = false}) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: isHighlighted ? Colors.blue[700] : Colors.blue[300],
          width: 18,
          borderRadius: BorderRadius.circular(5),
          backDrawRodData: BackgroundBarChartRodData(show: true, toY: 10, color: Colors.grey[200]),
        ),
      ],
    );
  }

  // Tab Item
  Widget _buildTab(String text, bool isActive) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: isActive ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  // Drink Item Row
  Widget _buildDrinkItem(IconData icon, String title, String amount, String time, Color color) {
    return ListTile(
      leading: CircleAvatar(
          backgroundColor: color.withAlpha((0.2 * 255).toInt()),
          child: FaIcon(icon, color: color)),
      title: Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
      subtitle: Text(time, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
      trailing: Text(amount, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54)),
    );
  }
}
