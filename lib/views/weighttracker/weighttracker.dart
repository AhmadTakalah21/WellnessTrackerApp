// import 'package:flutter/material.dart';
// import 'package:percent_indicator/percent_indicator.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:intl/intl.dart';
// import 'package:wellnesstrackerapp/global/utils/app_colors.dart';

// class WeightTrackerr extends StatefulWidget {
//   const WeightTrackerr({super.key});

//   @override
//   WeightTrackerrState createState() => WeightTrackerrState();
// }

// class WeightTrackerrState extends State<WeightTrackerr> {
//   final double _weight = 154.0; // Default weight
//   bool _isKilograms = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Image.network(
//                 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA3u67tR73dkXKN4EapMHdCQZSuAXnCoKLwA&s',
//               ),
//               SizedBox(height: 40),

//               Text(
//                 "What is your current weight?",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 30),
//               Text(
//                 _weight.toStringAsFixed(0),
//                 style: TextStyle(fontSize: 60, fontWeight: FontWeight.w300),
//               ),
//               SizedBox(height: 10),
//               ToggleButtons(
//                 isSelected: [_isKilograms == false, _isKilograms == true],
//                 onPressed: (int index) {
//                   setState(() {
//                     _isKilograms = index == 1;
//                   });
//                 },
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.grey,
//                 selectedColor: Colors.white,
//                 fillColor: AppColors.buttonColor, // Brighter color
//                 borderColor: Colors.grey.shade400,
//                 selectedBorderColor: AppColors.buttonColor,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 40),
//                     child: Text("LB"),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 40),
//                     child: Text("KG"),
//                   ),
//                 ],
//               ),

//               SizedBox(height: 40),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.buttonColor,
//                   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                   textStyle: TextStyle(fontSize: 18),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder:
//                           (context) => WeightProgressScreen(weight: _weight),
//                     ),
//                   );
//                 },
//                 child: Text("Continue", style: TextStyle(color: Colors.white)),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class WeightProgressScreen extends StatefulWidget {
//   final double weight;

//   const WeightProgressScreen({super.key, required this.weight});

//   @override
//   WeightProgressScreenState createState() => WeightProgressScreenState();
// }

// class WeightProgressScreenState extends State<WeightProgressScreen> {
//   // Sample Data (Replace with your actual data source)
//   final double _startWeight = 154.0;
//   final double _goalWeight = 135.0;
//   final List<WeightEntry> _weightHistory = [
//     WeightEntry(
//       date: DateTime.now().subtract(Duration(days: 6)),
//       weight: 152.0,
//     ),
//     WeightEntry(
//       date: DateTime.now().subtract(Duration(days: 5)),
//       weight: 151.0,
//     ),
//     WeightEntry(
//       date: DateTime.now().subtract(Duration(days: 4)),
//       weight: 149.0,
//     ),
//     WeightEntry(
//       date: DateTime.now().subtract(Duration(days: 3)),
//       weight: 149.0,
//     ),
//     WeightEntry(
//       date: DateTime.now().subtract(Duration(days: 2)),
//       weight: 149.0,
//     ),
//     WeightEntry(
//       date: DateTime.now().subtract(Duration(days: 1)),
//       weight: 149.0,
//     ),
//     WeightEntry(date: DateTime.now(), weight: 148.0),
//   ];

//   String _selectedTimeFrame = '7 Days';

//   // Helper functions to calculate trends
//   double _calculateWeightChange(int days) {
//     if (_weightHistory.isEmpty) return 0.0;

//     DateTime cutoffDate = DateTime.now().subtract(Duration(days: days));
//     List<WeightEntry> relevantData =
//         _weightHistory
//             .where((entry) => entry.date.isAfter(cutoffDate))
//             .toList();

//     if (relevantData.isEmpty) {
//       return 0.0; // Handle the case with no data within the timeframe
//     }

//     double initialWeight = relevantData.first.weight;
//     double finalWeight = relevantData.last.weight;
//     return initialWeight - finalWeight; // Weight change
//   }

//   double _calculateMedianWeight() {
//     if (_weightHistory.isEmpty) return 0.0;

//     List<double> weights = _weightHistory.map((entry) => entry.weight).toList();
//     weights.sort();
//     int middle = weights.length ~/ 2;
//     if (weights.length % 2 == 0) {
//       return (weights[middle - 1] + weights[middle]) / 2.0;
//     } else {
//       return weights[middle];
//     }
//   }

//   List<FlSpot> _getChartDataForTimeframe(String timeframe) {
//     DateTime cutoffDate;
//     switch (timeframe) {
//       case '30 Days':
//         cutoffDate = DateTime.now().subtract(Duration(days: 30));
//         break;
//       case '90 Days':
//         cutoffDate = DateTime.now().subtract(Duration(days: 90));
//         break;
//       case 'All Time':
//         cutoffDate = DateTime(0); // Start from the beginning
//         break;
//       default: // '7 Days'
//         cutoffDate = DateTime.now().subtract(Duration(days: 7));
//         break;
//     }

//     List<WeightEntry> filteredData =
//         _weightHistory
//             .where((entry) => entry.date.isAfter(cutoffDate))
//             .toList();

//     // Ensure the dates are in ascending order for the chart
//     filteredData.sort((a, b) => a.date.compareTo(b.date));

//     return filteredData.asMap().entries.map((entry) {
//       int index = entry.key;
//       WeightEntry weightEntry = entry.value;
//       return FlSpot(index.toDouble(), weightEntry.weight);
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double progress = ((_startWeight - widget.weight) /
//             (_startWeight - _goalWeight))
//         .clamp(0.0, 1.0);
//     double weightChangeLast7Days = _calculateWeightChange(7);
//     double weightChangeLast30Days = _calculateWeightChange(30);
//     double weightChangeAllTime = _calculateWeightChange(
//       365 * 100,
//     ); // Effectively "All Time"
//     double medianWeight = _calculateMedianWeight();

//     List<FlSpot> chartData = _getChartDataForTimeframe(_selectedTimeFrame);
//     double minY =
//         chartData.isNotEmpty
//             ? chartData.map((e) => e.y).reduce((a, b) => a < b ? a : b) - 1
//             : 130; // set min and max values to chart axis
//     double maxY =
//         chartData.isNotEmpty
//             ? chartData.map((e) => e.y).reduce((a, b) => a > b ? a : b) + 1
//             : 155;
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'My Weight Loss Progress',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         elevation: 0, // Removes shadow under the app bar for a flatter look
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             // Progress Indicator
//             CircularPercentIndicator(

//               radius: 120.0,
//               lineWidth: 13.0,
//               percent: progress,
//               center: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     widget.weight.toStringAsFixed(0),
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 32.0,
//                     ),
//                   ),
//                   Text(
//                     '${(_goalWeight - widget.weight).abs().toStringAsFixed(0)} lb left to my goal',
//                     style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
//                   ),
//                 ],
//               ),
//               circularStrokeCap: CircularStrokeCap.round,
//               progressColor: AppColors.buttonColor,
//               backgroundColor: AppColors.buttonColor,
//               header: Padding(
//                 padding: EdgeInsets.only(bottom: 20.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '$_startWeight LB',
//                       style: TextStyle(color: Colors.grey[600]),
//                     ),
//                     Text(
//                       '$_goalWeight LB',
//                       style: TextStyle(color: Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),

//             // Trends
//             Text(
//               "Trends",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 _buildTrendCard(
//                   context,
//                   "Last 7 Days",
//                   weightChangeLast7Days,
//                   "lb",
//                 ),
//                 SizedBox(width: 10),
//                 _buildTrendCard(
//                   context,
//                   "Last 30 Days",
//                   weightChangeLast30Days,
//                   "lb",
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 _buildTrendCard(context, "All Time", weightChangeAllTime, "lb"),
//                 SizedBox(width: 10),
//                 _buildTrendCard(
//                   context,
//                   "Median Weight",
//                   medianWeight,
//                   "lb",
//                   isMedian: true,
//                 ),
//               ],
//             ),

//             SizedBox(height: 30),

//             // Line Chart
//             Text(
//               "Weight History",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: [
//                   _buildTimeFrameButton('7 Days'),
//                   _buildTimeFrameButton('30 Days'),
//                   _buildTimeFrameButton('90 Days'),
//                   _buildTimeFrameButton('All Time'),
//                 ],
//               ),
//             ),
//             SizedBox(height: 10),
//             Container(
//               height: 200,
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child:
//                   chartData.isNotEmpty
//                       ? LineChart(
//                         LineChartData(
//                           minY: minY,
//                           maxY: maxY,
//                           lineBarsData: [
//                             LineChartBarData(
//                               spots: chartData,
//                               isCurved: true,
//                               belowBarData: BarAreaData(show: false),
//                               dotData: FlDotData(show: true),
//                               color: Theme.of(context).primaryColor,
//                               barWidth: 4,
//                             ),
//                           ],
//                           titlesData: FlTitlesData(
//                             bottomTitles: AxisTitles(
//                               sideTitles: SideTitles(showTitles: false),
//                             ),
//                             leftTitles: AxisTitles(
//                               sideTitles: SideTitles(showTitles: false),
//                             ),
//                             topTitles: AxisTitles(
//                               sideTitles: SideTitles(showTitles: false),
//                             ),
//                             rightTitles: AxisTitles(
//                               sideTitles: SideTitles(showTitles: false),
//                             ),
//                           ),
//                           gridData: FlGridData(show: false),
//                           borderData: FlBorderData(show: false),
//                         ),
//                       )
//                       : Center(
//                         child: Text("No data available for this timeframe."),
//                       ),
//             ),
//             SizedBox(height: 20),

//             // History List
//             Text(
//               "Recent History",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: _weightHistory.length,
//               itemBuilder: (context, index) {
//                 final entry = _weightHistory[index];
//                 return _buildHistoryItem(entry);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTrendCard(
//     BuildContext context,
//     String title,
//     double value,
//     String unit, {
//     bool isMedian = false,
//   }) {
//     Color valueColor = value >= 0 ? Colors.green : Colors.red;
//     String prefix =
//         value >= 0 || isMedian ? "+" : ""; // Don't show + for median

//     return Expanded(
//       child: Container(
//         padding: EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withAlpha((0.2 * 255).toInt()),
//               spreadRadius: 1,
//               blurRadius: 7,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.grey[700],
//               ),
//             ),
//             SizedBox(height: 8),
//             Row(
//               children: [
//                 Text(
//                   '$prefix${value.toStringAsFixed(1)}',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: valueColor,
//                   ),
//                 ),
//                 SizedBox(width: 5),
//                 Text(
//                   unit,
//                   style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHistoryItem(WeightEntry entry) {
//     String formattedDate = DateFormat('d MMM, E').format(entry.date);
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//       decoration: BoxDecoration(),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(formattedDate, style: TextStyle(fontSize: 16)),
//           Text(
//             '${entry.weight} lb',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTimeFrameButton(String timeframe) {
//     bool isSelected = _selectedTimeFrame == timeframe;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 4.0),
//       child: ElevatedButton(
//         onPressed: () {
//           setState(() {
//             _selectedTimeFrame = timeframe;
//           });
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor:
//               isSelected ? Theme.of(context).primaryColor : Colors.grey[300],
//           foregroundColor: isSelected ? Colors.white : Colors.black,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: Text(timeframe),
//       ),
//     );
//   }
// }

// class WeightEntry {
//   final DateTime date;
//   final double weight;

//   WeightEntry({required this.date, required this.weight});
// }
