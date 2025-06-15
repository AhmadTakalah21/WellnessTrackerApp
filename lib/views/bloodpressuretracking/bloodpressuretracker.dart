import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';

import 'bloodpressurestates.dart';

class Bp1 extends StatelessWidget {
  const Bp1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Text(
              "Good Morning",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Spacer(),
            CircleAvatar(
              backgroundImage: NetworkImage(
                "https://img.freepik.com/free-psd/portrait-man-teenager-isolated_23-2151745771.jpg",
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),

              // Search Bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.magnifyingGlass, color: Colors.grey),
                    SizedBox(width: 10),
                    Text("Search", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Measurements Heading
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Measurements",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>BloodPressureStatsScreen()));

                    },
                    child: Text(
                      "All Signs >",
                      style: TextStyle(color: Colors.blue, fontSize: 14),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Blood Pressure Card
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>BloodPressureStatsScreen()));

            },
                child: _buildMeasurementCard(
                  title: "Blood Pressure (bpm)",
                  value: "141/90",
                  time: "7 min ago",
                  color: Colors.red,
                  chartData: [90, 110, 120, 100, 130, 140, 141],
                ),
              ),

              SizedBox(height: 15),

              // Blood Oxygen Card
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>BloodPressureStatsScreen()));

            },
                child: _buildMeasurementCard(
                  title: "Blood oxygen (spo2)",
                  value: "90/60",
                  time: "7 min ago",
                  color: Colors.yellow[700]!,
                  chartData: [85, 88, 90, 92, 91, 90, 89],
                ),
              ),
              SizedBox(height: 20),

              // Blood Pressure Card
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>BloodPressureStatsScreen()));

            },
                child: _buildMeasurementCard(
                  title: "Blood Pressure (bpm)",
                  value: "141/90",
                  time: "7 min ago",
                  color: Colors.red,
                  chartData: [90, 110, 120, 100, 130, 140, 141],
                ),
              ),

              SizedBox(height: 15),

              // Blood Oxygen Card
              _buildMeasurementCard(
                title: "Blood oxygen (spo2)",
                value: "90/60",
                time: "7 min ago",
                color: Colors.yellow[700]!,
                chartData: [85, 88, 90, 92, 91, 90, 89],
              ),

              SizedBox(height: 15),

              // Steps Count Card
              _buildStepsCard(),
            ],
          ),
        ),
      ),
    );
  }

  // Measurement Card with Chart
  Widget _buildMeasurementCard({
    required String title,
    required String value,
    required String time,
    required Color color,
    required List<double> chartData,
  }) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.1 * 255).toInt()),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            "Last 4 hours",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(
                width: 100,
                height: 40,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: List.generate(
                          chartData.length,
                          (index) => FlSpot(index.toDouble(), chartData[index]),
                        ),
                        isCurved: true,
                        color: color,
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(time, style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  // Steps Count Card
  Widget _buildStepsCard() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.1 * 255).toInt()),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Steps Count",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            "Last 7 days",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "3,133 Steps",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                width: 120,
                height: 40,
                child: BarChart(
                  BarChartData(
                    barGroups: List.generate(7, (index) {
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: (index + 3) * 10.toDouble(),
                            color: Colors.blue,
                            width: 8,
                          ),
                        ],
                      );
                    }),
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            List<String> labels = [
                              "S",
                              "M",
                              "T",
                              "W",
                              "T",
                              "F",
                              "S",
                            ];
                            return Text(
                              labels[value.toInt()],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text("Today", style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
